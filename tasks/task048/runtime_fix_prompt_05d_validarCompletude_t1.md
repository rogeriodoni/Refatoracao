# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigrecgp.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[Formsigrecgp.prg] Procedure vazia (sem codigo): BtnSalvarClick
[Formsigrecgp.prg] Procedure vazia (sem codigo): BtnBuscarClick
[Formsigrecgp.prg] Procedure vazia (sem codigo): BOParaForm
[Formsigrecgp.prg] Procedure vazia (sem codigo): HabilitarCampos
[Formsigrecgp.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecgp.prg):
*==============================================================================
* FORMSIGRECGP.PRG
* Relatorio de Composicao de Produtos
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECGP.SCX (frmrelatorio)
*
* FASE 3/8 - Estrutura base do form
*   * Propriedades visuais (PILAR 1: exatas do original Width=800, Height=300)
*   * Init(par_oParentForm) - armazena referencia ao form pai antes do DODEFAULT
*   * InicializarForm() - cria BO, cabecalho, botoes, container de progresso
*   * ConfigurarCabecalho() - container escuro com titulo (cntSombra equivalente)
*   * ConfigurarBotoes() - CommandGroup 4 botoes (btnReport equivalente)
*   * ConfigurarPageFrame() - PageFrame de 1 pagina "Filtros"
*   * ConfigurarContainerProgresso() - Container1 + lbl Aguarde + Selecionando
*   * MostrarProgresso() - exibe/oculta indicador durante processamento
*   * Destroy() - libera BO e reabilita form pai
* FASE 4/8 - Filtros na Page1 (equivalente a ConfigurarPaginaLista para forms REPORT)
*   * ConfigurarPaginaFiltros() - Opc_Rel (5 tipos relatorio), Opc_Ordem, lbl_4c_Label1
*   * AlternarPagina() - navega entre paginas (compatibilidade pipeline)
*   * Habilita Buttons(5) condicionalmente pelo estado do form pai (get_opera??oi)
* FASE 5/8 - Acoes e transferencia de filtros (Parte 1)
*   * ConfigurarPaginaDados() - stub pipeline compat (form FLAT, sem Page2/Dados)
*   * FormParaRelatorio() - transfere Opc_Rel/Opc_Ordem do form para o BO
*   * BtnVisualizarClick() - prepara dados + chama Visualizar no BO
*   * BtnImprimirClick() - prepara dados + chama Imprimir no BO
*   * BINDEVENTs Buttons(1) Visualizar e Buttons(2) Imprimir adicionados em InicializarForm
* FASE 6/8 - Correcao de captions PILAR 1 e BINDEVENTs completos
*   * ConfigurarPaginaFiltros() corrigido: captions exatos do original
*     Opc_Rel: Composicao / Custo-Venda / CompEsp1 / CompEsp2 / Custo-Venda2
*     Opc_Ordem: Produto / Ref.Fornecedor com posicoes exatas (Left=5/80, Top=5)
*   * BtnExcelClick() - aviso de nao disponibilidade
*   * BtnEncerrarClick() - fecha dialogo via Release()
*   * BINDEVENTs para Buttons(3) Excel e Buttons(4) Encerrar
* FASE 7/8 - Eventos principais (concluido - form REPORT nao tem eventos CRUD)
*   * Forms REPORT tem: BtnVisualizarClick, BtnImprimirClick, BtnExcelClick,
*     BtnEncerrarClick - todos ja implementados nas fases 5/6
*   * BtnIncluirClick/BtnAlterarClick/BtnExcluirClick NAO se aplicam a REPORT
* FASE 8/8 - Consolidacao e metodos de compatibilidade com pipeline (COMPLETO)
*   * BtnCancelarClick() - alias para BtnEncerrarClick
*   * BtnSalvarClick(), BtnBuscarClick() - stubs pipeline CRUD
*   * FormParaBO() - delega para FormParaRelatorio()
*   * BOParaForm() - stub pipeline
*   * LimparCampos() - reseta Opc_Rel=1, Opc_Ordem=1
*   * HabilitarCampos() - stub pipeline
*   * CarregarLista() - stub pipeline (retorna .T.)
*   * AjustarBotoesPorModo() - stub pipeline
*   * menu.prg: BAR 45 "Composicao de Produtos" + AbrirFormsigrecgp()
*==============================================================================

DEFINE CLASS Formsigrecgp AS FormBase

    *-- Dimensoes e aparencia (PILAR 1 - exatas do original SIGRECGP.SCX)
    Height      = 300
    Width       = 800
    DataSession = 1
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio   = .NULL.
    *-- Referencia ao form pai (que abriu este dialogo como sub-form)
    this_oParentForm  = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Armazena referencia ao form pai ANTES de DODEFAULT() chamar
    *        InicializarForm(), para que InicializarForm() ja tenha acesso.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm)
        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e monta layout base do dialogo de relatorio
    *   Fase 3: cabecalho + botoes + container de progresso
    *   Fases posteriores adicionam: Opc_Rel, Opc_Ordem, Say1, BINDEVENTs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Composi" + ;
                           CHR(231) + CHR(227) + "o de Produtos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Criar BO do relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecgpBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecgpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Repassa referencia ao pai para o BO (usado em PrepararDados tipo 5)
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oRelatorio.this_oParentForm = THIS.this_oParentForm
                ENDIF

                *-- Container escuro de cabecalho (cntSombra equivalente)
                THIS.ConfigurarCabecalho()

                *-- Grupo de botoes de relatorio (btnReport equivalente)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros (controles em Page1 nas fases 4-6)
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro na Page1: Opc_Rel (5 tipos), Opc_Ordem, Say1
                THIS.ConfigurarPaginaFiltros()

                *-- Habilitar Buttons(5) condicionalmente pelo estado do form pai
                *   Original: thisform.opc_Rel.option5.Enabled = .get_opera[c+ao]i.value<>0
                LOCAL loc_lOp5, loc_oPrincipal, loc_nOpVal
                loc_lOp5 = .F.
                TRY
                    IF VARTYPE(THIS.this_oParentForm) = "O"
                        loc_oPrincipal = THIS.this_oParentForm.fld_principal.pag_Consulta.filtro.principal
                        loc_nOpVal = EVALUATE("loc_oPrincipal.get_opera" + CHR(231) + CHR(227) + "oi.Value")
                        loc_lOp5 = (loc_nOpVal <> 0)
                    ENDIF
                CATCH
                    loc_lOp5 = .F.
                ENDTRY
                THIS.pgf_4c_Paginas.Page1.obj_4c_Opc_Rel.Buttons(5).Enabled = loc_lOp5

                *-- Container de progresso (Container1 + Label1 + Label2)
                *   Adicionado por ultimo para ficar acima do PageFrame (z-order)
                THIS.ConfigurarContainerProgresso()

                *-- Atualiza caption nos labels do cabecalho apos criacao
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- BINDEVENTs para todos os botoes de relatorio (Fases 5 e 6)
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior de 80px).
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

            *-- Sombra (deslocada 2px para efeito 3D sobre o fundo escuro)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (visivel sobre a sombra preta)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o de Produtos"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes (btnReport equivalente)
    *   PILAR 1: posicoes exatas do original SIGRECGP.SCX
    *   btnReport: Top=-2(ajustado para 0), Left=495, Width=310, Height=85
    *   Botoes: Visualiza(L=5), Imprime(L=80), DocExcel(L=155), sair(L=230)
    *   Cada botao: Width=75, Height=75, Top=5
    *   Eventos Click vinculados na Fase 7/8
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .ButtonCount   = 4
            .Top           = 0
            .Left          = 495
            .Width         = 310
            .Height        = 85
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
                .Width           = 75
                .Height          = 75
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 2: Imprimir (enviar para impressora)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
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
                .WordWrap        = .T.
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 3: Excel (exportar dados)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
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
                .WordWrap        = .T.
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 4: Encerrar (fechar dialogo, tecla ESC)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
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
                .WordWrap        = .T.
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina visivel "Filtros"
    *   O form legado SIGRECGP e FLAT (sem PageFrame), mas no novo padrao os
    *   controles de filtro (Opc_Rel, Opc_Ordem, Say1) sao agrupados em um
    *   PageFrame de 1 pagina para consistencia com o restante do sistema.
    *   Os controles sao adicionados a Page1 nas fases 4-6.
    *   PageCount=2 para compatibilidade com pipeline (Page2 fica vazia).
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

        *-- Page1: Filtros (onde Opc_Rel, Opc_Ordem e Say1 serao adicionados)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Page2: vazia (compatibilidade com pipeline BtnIncluirNavegacao)
        loc_oPgf.Page2.Caption   = ""
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerProgresso - Indicador visual durante processamento
    *   Equivalente a Container1 + Label1 ("Aguarde !!!") + Label2 ("Selecionando...")
    *   PILAR 1: posicoes exatas do original
    *   Container1: Top=113, Left=289, Width=222, Height=66
    *   Label1 (Aguarde): Top=126, Left=359
    *   Label2 (Selecionando): Top=144, Left=304
    *   Todos inicialmente invisiveis - exibidos via MostrarProgresso(.T.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerProgresso()
        THIS.AddObject("cnt_4c_Progresso", "Container")
        WITH THIS.cnt_4c_Progresso
            .Top           = 113
            .Left          = 289
            .Width         = 222
            .Height        = 66
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 0
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Aguarde", "Label")
        WITH THIS.lbl_4c_Aguarde
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 11
            .BackStyle = 0
            .Caption   = "Aguarde !!!"
            .Height    = 20
            .Left      = 359
            .Top       = 126
            .Width     = 83
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Selecionando", "Label")
        WITH THIS.lbl_4c_Selecionando
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 11
            .BackStyle = 0
            .Caption   = "Selecionando Registros..."
            .Height    = 20
            .Left      = 304
            .Top       = 144
            .Width     = 193
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarProgresso - Exibe ou oculta o indicador de progresso
    *   Chamado antes e depois de PrepararDados() + Imprimir()/Visualizar()
    *   par_lMostrar: .T. para exibir, .F. para ocultar
    *--------------------------------------------------------------------------
    PROCEDURE MostrarProgresso(par_lMostrar)
        LOCAL loc_lVisivel
        IF VARTYPE(par_lMostrar) = "L"
            loc_lVisivel = par_lMostrar
        ELSE
            loc_lVisivel = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Progresso", 5)
            THIS.cnt_4c_Progresso.Visible   = loc_lVisivel
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Aguarde", 5)
            THIS.lbl_4c_Aguarde.Visible     = loc_lVisivel
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Selecionando", 5)
            THIS.lbl_4c_Selecionando.Visible = loc_lVisivel
        ENDIF
        DOEVENTS
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Adiciona controles de filtro a Page1
    *   Equivalentes ao Opc_Rel, Opc_Ordem e Say1 do form original SIGRECGP.
    *   Posicoes relativas a Page1 (PageFrame.Top=85 subtraido do original).
    *   PILAR 1: captions e posicoes EXATAS do original (corrigido na Fase 6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPage1, loc_oGrupo
        loc_oPage1 = THIS.pgf_4c_Paginas.Page1

        *-- obj_4c_Opc_Rel: tipo de relatorio (5 opcoes verticais)
        *   Original: Top=93, Left=81, Width=186, Height=102, ButtonCount=5
        *   Relativo a Page1: Top = 93 - 85 = 8
        loc_oPage1.AddObject("obj_4c_Opc_Rel", "OptionGroup")
        loc_oGrupo = loc_oPage1.obj_4c_Opc_Rel
        loc_oGrupo.ButtonCount = 5
        WITH loc_oGrupo
            .Top       = 8
            .Left      = 81
            .Width     = 186
            .Height    = 102
            .Value     = 1
            .BackStyle = 0
            .Themes    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8

            *-- Option1: Top=5, Left=5, AutoSize=.T. (original)
            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .AutoSize  = .T.
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            *-- Option2: Top=24, Left=5, AutoSize=.T. (original)
            WITH .Buttons(2)
                .Top       = 24
                .Left      = 5
                .AutoSize  = .T.
                .Caption   = "Custo / Venda"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            *-- Option3: Top=43, Left=5, Width=161, Height=17 (original)
            WITH .Buttons(3)
                .Top       = 43
                .Left      = 5
                .Width     = 161
                .Height    = 17
                .Caption   = "Composi" + CHR(231) + CHR(227) + ;
                             "o Espec" + CHR(237) + "fica 1"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            *-- Option4: Top=62, Left=5, Width=165, Height=17 (original)
            WITH .Buttons(4)
                .Top       = 62
                .Left      = 5
                .Width     = 165
                .Height    = 17
                .Caption   = "Composi" + CHR(231) + CHR(227) + ;
                             "o Espec" + CHR(237) + "fica 2"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            *-- Option5: Top=81, Left=5, Width=136, Height=17, Enabled=.F. (original)
            WITH .Buttons(5)
                .Top       = 81
                .Left      = 5
                .Width     = 136
                .Height    = 17
                .Caption   = "Custo / Venda 2"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- lbl_4c_Label1: "Ordem : " ao lado da selecao de ordenacao
        *   Original: Top=200, Left=87 -> Relativo a Page1: Top = 115
        loc_oPage1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPage1.lbl_4c_Label1
            .Top       = 115
            .Left      = 87
            .Width     = 48
            .Height    = 17
            .Caption   = "Ordem : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_Opc_Ordem: ordenacao dos dados (2 opcoes lado a lado)
        *   Original: Top=195, Left=135, Width=190, Height=27 -> Page1: Top = 110
        *   Option1: Left=5, Top=5, AutoSize=.T., Caption="Produto"
        *   Option2: Left=80, Top=5, AutoSize=.T., Caption="Ref.Fornecedor"
        loc_oPage1.AddObject("obj_4c_Opc_Ordem", "OptionGroup")
        loc_oGrupo = loc_oPage1.obj_4c_Opc_Ordem
        WITH loc_oGrupo
            .ButtonCount = 2
            .Top       = 110
            .Left      = 135
            .Width     = 190
            .Height    = 27
            .Value     = 1
            .BackStyle = 0
            .Themes    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8

            WITH .Buttons(1)
                .Top      = 5
                .Left     = 5
                .AutoSize = .T.
                .Caption  = "Produto"
                .Visible  = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top      = 5
                .Left     = 80
                .AutoSize = .T.
                .Caption  = "Ref.Fornecedor"
                .Visible  = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre paginas do PageFrame
    *   Forms REPORT tem layout de 1 pagina de filtros; metodo mantido para
    *   compatibilidade com o pipeline de validacao automatica.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
                AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e reabilita form pai (equivalente ao Release legado)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF VARTYPE(THIS.this_oParentForm) = "O"
            IF PEMSTATUS(THIS.this_oParentForm, "Enabled", 5)
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Stub de compatibilidade com pipeline (Fase 5)
    *   Form REPORT FLAT: sem Page2 de edicao de dados.
    *   Filtros do usuario ficam na Page1 (ConfigurarPaginaFiltros).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form FLAT sem Page2/Dados - compatibilidade com pipeline de validacao
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere estado dos filtros do form para o BO
    *   Chamado antes de cada geracao (Visualizar, Imprimir)
    *   Popula:
    *     this_nOpcRel   <- obj_4c_Opc_Rel.Value (1=Comp, 2=Custo/Venda, 3=Esp1, 4=Esp2, 5=CV2)
    *     this_nOpcOrdem <- obj_4c_Opc_Ordem.Value (1=Produto, 2=Ref.Fornecedor)
    *     this_nVal      <- derivado: INLIST(tipo,2)=1, else 0
    *     this_cEmpEDN   <- chave empresa+operacao+id (somente tipo 5, via form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_nTpRel, loc_oPrincipal, loc_cEmpSo
        LOCAL loc_cOpera, loc_nOperaI, loc_cEDN, loc_oErro
        TRY
            loc_nTpRel = THIS.pgf_4c_Paginas.Page1.obj_4c_Opc_Rel.Value
            THIS.this_oRelatorio.this_nOpcRel   = loc_nTpRel
            THIS.this_oRelatorio.this_nOpcOrdem = ;
                THIS.pgf_4c_Paginas.Page1.obj_4c_Opc_Ordem.Value
            THIS.this_oRelatorio.this_nVal = ;
                IIF(INLIST(loc_nTpRel, 2) = .T., 1, 0)

            *-- Tipo 5: repassa chave EDN (empresa+operacao+id) do form pai
            IF loc_nTpRel = 5 AND VARTYPE(THIS.this_oParentForm) = "O"
                loc_cEmpSo  = ""
                loc_cOpera  = ""
                loc_nOperaI = 0
                TRY
                    loc_oPrincipal = THIS.this_oParentForm.fld_principal.pag_Consulta.filtro.principal
                    loc_cEmpSo = ALLTRIM(EVALUATE("loc_oPrincipal.getempso.Value"))
                    loc_cOpera = ALLTRIM(EVALUATE( ;
                        "loc_oPrincipal.get_opera" + CHR(231) + CHR(227) + "o.Value"))
                    loc_nOperaI = EVALUATE( ;
                        "loc_oPrincipal.get_opera" + CHR(231) + CHR(227) + "oi.Value")
                CATCH
                    *-- se nao conseguir acessar o form pai, EDN fica vazio
                ENDTRY
                loc_cEDN = loc_cEmpSo + ;
                           PADR(loc_cOpera, 20) + ;
                           PADL(ALLTRIM(STR(loc_nOperaI)), 6)
                THIS.this_oRelatorio.this_cEmpEDN = loc_cEDN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Aciona geracao de relatorio em preview (Buttons 1)
    *   Equivalente ao metodo visualizacao do legado SIGRECGP
    *   Fluxo: FormParaRelatorio -> MostrarProgresso -> PrepararDados -> Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lOK, loc_oErro
        loc_lOK = .F.
        TRY
            THIS.FormParaRelatorio()
            THIS.MostrarProgresso(.T.)
            loc_lOK = THIS.this_oRelatorio.PrepararDados()
            THIS.MostrarProgresso(.F.)
            IF loc_lOK
                THIS.this_oRelatorio.Visualizar()
            ELSE
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                    "Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            THIS.MostrarProgresso(.F.)
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Aciona geracao de relatorio para impressora (Buttons 2)
    *   Equivalente ao metodo impressao do legado SIGRECGP
    *   Fluxo: FormParaRelatorio -> MostrarProgresso -> PrepararDados -> Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lOK, loc_oErro
        loc_lOK = .F.
        TRY
            THIS.FormParaRelatorio()
            THIS.MostrarProgresso(.T.)
            loc_lOK = THIS.this_oRelatorio.PrepararDados()
            THIS.MostrarProgresso(.F.)
            IF loc_lOK
                THIS.this_oRelatorio.Imprimir()
            ELSE
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                    "Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            THIS.MostrarProgresso(.F.)
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Botao Excel (Buttons 3) - exportacao para Excel
    *   O relatorio de composicao nao suporta exportacao direta para Excel
    *   no sistema migrado. O usuario deve usar o visualizador e exportar de la.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel para este relat" + CHR(243) + "rio." + CHR(13) + ;
            "Utilize Visualizar e exporte pelo visualizador de relat" + CHR(243) + "rios.", ;
            "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialogo (Buttons 4 / ESC)
    *   Destroy() cuida de reabilitar this_oParentForm.Enabled = .T.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Alias de compatibilidade com pipeline CRUD
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Stub de compatibilidade com pipeline CRUD
    *   Form REPORT: salvar nao aplicavel; usar BtnImprimirClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Stub de compatibilidade com pipeline CRUD
    *   Form REPORT: busca nao aplicavel; usar BtnVisualizarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Compatibilidade com pipeline CRUD
    *   Delega para FormParaRelatorio() que e o metodo real deste form REPORT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Stub de compatibilidade com pipeline CRUD
    *   Form REPORT nao carrega valores do BO de volta para o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao
    *   Equivalente a "limpar formulario" antes de nova geracao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPage1
        loc_oPage1 = THIS.pgf_4c_Paginas.Page1
        IF PEMSTATUS(loc_oPage1, "obj_4c_Opc_Rel", 5)
            loc_oPage1.obj_4c_Opc_Rel.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPage1, "obj_4c_Opc_Ordem", 5)
            loc_oPage1.obj_4c_Opc_Ordem.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Stub de compatibilidade com pipeline CRUD
    *   Form REPORT: sem campos de entrada CRUD para habilitar/desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Stub de compatibilidade com pipeline CRUD
    *   Form REPORT: sem lista de registros para carregar
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Stub de compatibilidade com pipeline CRUD
    *   Form REPORT: sem modos LISTA/DADOS/INCLUIR/ALTERAR/VISUALIZAR
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecgpBO.prg):
*==============================================================================
* SIGRECGPBO.PRG
* BO do Relatorio de Composicao de Produtos (SIGRECGP)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrecgpBO AS RelatorioBase

    *-- Opcoes selecionadas pelo usuario no form
    this_nOpcRel      = 1    && 1=Comp, 2=Custo/Venda, 3=CompEsp1, 4=CompEsp2, 5=Custo/Venda2
    this_nOpcOrdem    = 1    && 1=Produto, 2=Ref.Fornecedor
    this_nVal         = 0    && Derivado: INLIST(tipo,2) -> 1, else 0

    *-- Referencia ao form pai e filtros
    this_oParentForm  = .NULL.
    this_cEmpEDN      = ""   && Chave empresa+operacao+operacaoid (tipo 5)

    *--------------------------------------------------------------------------
    * Init - Configura identificadores base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Sem chave para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursor Relatorio com dados de composicao
    * Equivalente ao metodo processamento do legado
    * REQUER que CrProdutos esteja populado pelo form chamador
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nOrdem, loc_nTpRel, loc_lOK
        LOCAL loc_cEmpresa, loc_cTitulo, loc_nResult, loc_cSQL
        LOCAL loc_cGrupo, loc_cProdt, loc_nCnt
        LOCAL loc_cCodPro, loc_lFoundMov, loc_cFotoRel
        LOCAL loc_cFotoBranco, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nOrdem = THIS.this_nOpcOrdem
            loc_nTpRel = THIS.this_nOpcRel

            THIS.this_nVal = IIF(INLIST(loc_nTpRel, 2) = .T., 1, 0)

            *-- Tipos 3 e 4: processamento especial de composicao especifica
            IF INLIST(loc_nTpRel, 3, 4)
                loc_lSucesso = THIS.PrepararDadosCompEsp1()
            ELSE
                *-- Tipos 1, 2, 5: processamento padrao

                *-- Obter nome da empresa para cabecalho
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                           " WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpHdr")

                IF loc_nResult > 0
                    SELECT cursor_4c_EmpHdr
                    GO TOP
                    loc_cEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ;
                                   IIF(!EMPTY(cursor_4c_EmpHdr.Razas), ;
                                       ALLTRIM(cursor_4c_EmpHdr.Razas), "")
                    USE IN cursor_4c_EmpHdr
                ELSE
                    loc_cEmpresa = go_4c_Sistema.cCodEmpresa
                ENDIF

                loc_cTitulo = "RELAT" + CHR(211) + "RIO DE COMPOSI" + ;
                              CHR(199) + CHR(195) + "O DE PRODUTOS"

                *-- Cursor de cabecalho para o relatorio
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF
                CREATE CURSOR csCabecalho (NomeEmpresa c(80), Titulo c(200), ImpImagem l(1))
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, ImpImagem) ;
                    VALUES (loc_cEmpresa, loc_cTitulo, .T.)

                *-- Imagem em branco para produtos sem foto
                IF USED("CrBranco")
                    USE IN CrBranco
                ENDIF
                CREATE CURSOR CrBranco (Branco M)
                SELECT CrBranco
                APPEND BLANK

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 carqicones, marqicones FROM SigSyIco" + ;
                    " WHERE carqicones = 'brjpg.jpg'", ;
                    "cursor_4c_BrJpg")

                IF loc_nResult > 0
                    SELECT cursor_4c_BrJpg
                    GO TOP
                    IF !EOF() AND !EMPTY(cursor_4c_BrJpg.marqicones)
                        SELECT CrBranco
                        REPLACE Branco WITH cursor_4c_BrJpg.marqicones IN CrBranco
                    ENDIF
                    USE IN cursor_4c_BrJpg
                ENDIF

                IF !EMPTY(CrBranco.Branco)
                    loc_cFotoBranco = STRCONV(STRTRAN(STRTRAN(STRTRAN(CrBranco.Branco, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFotoBranco, SYS(2023) + "\FBRANCOS.JPG")
                ENDIF

                *-- Cursores temporarios de dados
                IF USED("Tmp_Memos")
                    USE IN Tmp_Memos
                ENDIF
                CREATE CURSOR Tmp_Memos (Cids c(1), Imagem m, ValTot m, MoeTot m)

                IF USED("Tmp_Compos")
                    USE IN Tmp_Compos
                ENDIF

                *-- Popula Tmp_Compos conforme tipo de relatorio
                loc_lOK = .T.

                IF INLIST(loc_nTpRel, 5)
                    *-- Tipo 5: dados de composicao filtrados pela operacao
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros,a.mats,a.dcompos,a.cats," + ;
                        "a.qtscons*b.qtds as qtscons,a.unicompos," + ;
                        "a.moeds,a.cgrus,a.obscompos,a.etiqs," + ;
                        "a.vlrcvs,a.qtdcvs*b.qtds as qtdcvs," + ;
                        "a.qtds,a.pcompos,b.totas,b.moedas " + ;
                        "FROM SigPrCpo a, SigMvItN b " + ;
                        "WHERE b.cpros = a.cpros" + ;
                        " AND empdopnums = " + EscaparSQL(THIS.this_cEmpEDN), ;
                        "TmpAux")

                    IF loc_nResult > 0
                        *-- Acumula por material
                        SELECT cpros, mats, MAX(dcompos) as dcompos, ;
                               MAX(cats) as cats, ;
                               SUM(ROUND(qtscons,3)) as qtscons, ;
                               MAX(unicompos) as unicompos, ;
                               MAX(moeds) as moeds, ;
                               MAX(cgrus) as cgrus, ;
                               MAX(obscompos) as obscompos, ;
                               MAX(etiqs) as etiqs, ;
                               SUM(vlrcvs) as vlrcvs, ;
                               SUM(ROUND(qtdcvs,3)) as qtdcvs, ;
                               SUM(qtds) as qtds, ;
                               SUM(pcompos) as pcompos, ;
                               00000000.00 as valtotmoe, ;
                               0 as ps ;
                            FROM TmpAux GROUP BY cpros, mats ;
                            INTO CURSOR AuxCompos READWRITE

                        *-- Totais de consumo por produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               SUM(qtscons) as qtscons ;
                            FROM AuxCompos GROUP BY cpros ;
                            INTO CURSOR AuxCons

                        *-- Totais de qtdcvs por unidade/produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               unicompos, SUM(qtdcvs) as qtdcvs ;
                            FROM AuxCompos GROUP BY cpros, unicompos ;
                            INTO CURSOR AuxMat

                        *-- Totais de valor por moeda/produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               moeds, SUM(vlrcvs*qtdcvs) as valtotmoe ;
                            FROM AuxCompos GROUP BY cpros, moeds ;
                            INTO CURSOR AuxMoe

                        *-- Totais gerais por material
                        SELECT mats, dcompos, unicompos, ;
                               MAX(moeds) as moeds, ;
                               SUM(qtscons) as qtscons, ;
                               SUM(qtdcvs) as qtdcvs, ;
                               SUM(vlrcvs*qtdcvs) as valtotmoe ;
                            FROM AuxCompos GROUP BY mats, dcompos, unicompos ;
                            INTO CURSOR AuxG

                        *-- Consolida qtscons no AuxCompos
                        SELECT AuxCons
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxCons.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND qtscons = 0
                            IF !FOUND()
                                APPEND BLANK
                                REPLACE ps WITH 1
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxCons.cpros, ;
                                    qtscons WITH AuxCons.qtscons
                            SELECT AuxCons
                        ENDSCAN

                        *-- Consolida qtdcvs no AuxCompos
                        SELECT AuxMat
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxMat.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND ;
                                        unicompos = '   '
                            IF !FOUND()
                                APPEND BLANK
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxMat.cpros, ;
                                    unicompos WITH AuxMat.unicompos, ;
                                    qtdcvs WITH AuxMat.qtdcvs
                            SELECT AuxMat
                        ENDSCAN

                        *-- Consolida valtotmoe no AuxCompos
                        SELECT AuxMoe
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxMoe.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND ;
                                        moeds = '   '
                            IF !FOUND()
                                APPEND BLANK
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxMoe.cpros, ;
                                    moeds WITH AuxMoe.moeds, ;
                                    valtotmoe WITH AuxMoe.valtotmoe
                            SELECT AuxMoe
                        ENDSCAN

                        SELECT * FROM AuxCompos ORDER BY cpros, mats ;
                            INTO CURSOR Tmp_Compos READWRITE

                        SELECT cpros, MAX(totas) as totas, MAX(moedas) as moedas ;
                            FROM TmpAux GROUP BY cpros ;
                            INTO CURSOR TmpMov READWRITE

                        *-- Totais por material (variavel publica lida pelo relatorio)
                        PUBLIC pcTotais
                        pcTotais = "TOTAIS POR MATERIAL" + CHR(10)
                        pcTotais = pcTotais + ;
                            "Material      Descricao                       " + ;
                            "           Consumo      Qtde Un      Total" + CHR(10)
                        pcTotais = pcTotais + ;
                            "________________________________________________" + ;
                            "_________________________________________" + CHR(10)
                        SELECT AuxG
                        GO TOP
                        SCAN
                            pcTotais = pcTotais + AuxG.mats + dcompos + ;
                                       TRANSFORM(qtscons, "@R 999999.999") + ;
                                       TRANSFORM(qtdcvs, "@R 999999.999") + ;
                                       " " + unicompos + ;
                                       TRANSFORM(valtotmoe, "@R 9999999.99") + ;
                                       " " + moeds + CHR(10)
                        ENDSCAN
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao buscar dados da opera" + ;
                            CHR(231) + CHR(227) + "o"
                        loc_lOK = .F.
                    ENDIF
                ELSE
                    *-- Tipos 1 e 2: todos os dados de composicao
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros,a.mats,a.dcompos,a.cats," + ;
                        "a.qtscons,a.unicompos,a.moeds,a.cgrus," + ;
                        "a.obscompos,a.etiqs,a.vlrcvs,a.qtdcvs," + ;
                        "a.qtds,a.pcompos," + ;
                        "CAST(0 AS NUMERIC(8,2)) as valtotmoe," + ;
                        "0 as ps " + ;
                        "FROM SigPrCpo a", ;
                        "Tmp_Compos")

                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar composicao dos produtos"
                        loc_lOK = .F.
                    ENDIF
                ENDIF

                IF loc_lOK
                    *-- CsRels: join CrProdutos x Tmp_Compos
                    SELECT a.cpros      AS Codigo, ;
                           a.dpros      AS Descricao, ;
                           SPACE(10)    AS Linha, ;
                           SPACE(3)     AS Unidade, ;
                           000000.00    AS Peso, ;
                           00000000.00  AS PreCusto, ;
                           SPACE(3)     AS MoeCusto, ;
                           00000000.00  AS PreVenda, ;
                           SPACE(3)     AS MoeVenda, ;
                           000000000.00 AS PreIdeal, ;
                           SPACE(3)     AS MoeIdeal, ;
                           c.mats       AS CodMateria, ;
                           c.dcompos    AS DesMateria, ;
                           c.cats       AS Categoria, ;
                           c.qtscons    AS Consumo, ;
                           IIF(loc_nTpRel = 1, c.qtds, c.qtdcvs) AS Quantidade, ;
                           c.unicompos  AS UniMateria, ;
                           IIF(loc_nTpRel = 1, c.pcompos, c.vlrcvs) AS ValMateria, ;
                           c.moeds      AS MoeMateria, ;
                           c.cpros + c.cgrus AS Grupos, ;
                           999999       AS Quadro, ;
                           SPACE(8)     AS OrdImg, ;
                           SPACE(15)    AS RefFor, ;
                           c.obscompos  AS Observa, ;
                           SPACE(6)     AS SubGrupo, ;
                           c.etiqs      AS Imprime, ;
                           c.cgrus      AS GruProd, ;
                           SPACE(20)    AS DesGrupo, ;
                           c.valtotmoe  AS valtotmoe, ;
                           c.ps         AS Ps ;
                        FROM CrProdutos a, Tmp_Compos c ;
                        WHERE a.cpros = c.cpros ;
                            AND IIF(INLIST(loc_nTpRel, 2), c.vlrcvs # 0, .T.) ;
                        ORDER BY a.cpros + c.cgrus ;
                        INTO CURSOR CsRels

                    *-- CsRelatorio: adiciona colunas de memo (imagem, totais)
                    SELECT a.*, b.Imagem, b.ValTot, b.MoeTot ;
                        FROM CsRels a ;
                        FULL JOIN Tmp_Memos b ON b.cids = ' ' ;
                        INTO CURSOR CsRelatorio

                    IF USED("CsRels")
                        USE IN CsRels
                    ENDIF

                    IF USED("Relatorio")
                        USE IN Relatorio
                    ENDIF

                    *-- Abre segunda referencia para permitir sub-SELECTs durante SCAN
                    USE DBF("CsRelatorio") ALIAS Relatorio IN 0 AGAIN

                    *-- Enriquece cada produto com dados detalhados do SQL
                    SELECT Relatorio
                    GO TOP
                    SCAN
                        loc_cCodPro   = Relatorio.Codigo
                        loc_lFoundMov = .F.

                        IF USED("TmpProds")
                            USE IN TmpProds
                        ENDIF

                        IF INLIST(loc_nTpRel, 5) AND USED("TmpMov")
                            SELECT TmpMov
                            LOCATE FOR cpros = loc_cCodPro
                            loc_lFoundMov = FOUND()
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT a.cpros,a.linhas,a.cunis,a.pesoms," + ;
                            "a.custofs,a.moecusfs,a.moecs," + ;
                            "a.pvens,a.moevs,a.pvideals," + ;
                            "a.moedas,a.reffs,a.figjpgs," + ;
                            "a.sgrus,s.descricaos " + ;
                            "FROM SigCdPro a " + ;
                            "LEFT JOIN SigCdPsg s ON a.sgrus = s.codigos " + ;
                            "WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
                            "TmpProds")

                        SELECT TmpProds
                        GO TOP
                        IF !EOF()
                            SELECT Relatorio
                            REPLACE Relatorio.Linha    WITH TmpProds.linhas, ;
                                    Relatorio.Unidade  WITH TmpProds.cunis, ;
                                    Relatorio.Peso     WITH TmpProds.pesoms, ;
                                    Relatorio.PreCusto WITH TmpProds.custofs, ;
                                    Relatorio.MoeCusto WITH ;
                                        IIF(loc_nTpRel = 1, ;
                                            TmpProds.moecusfs, TmpProds.moecs), ;
                                    Relatorio.PreIdeal WITH TmpProds.pvideals, ;
                                    Relatorio.MoeIdeal WITH TmpProds.moedas, ;
                                    Relatorio.Imagem   WITH ;
                                        STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                            TmpProds.figjpgs, ;
                                            "data:image/png;base64,",""), ;
                                            "data:image/jpeg;base64,",""), ;
                                            "data:image/jpg;base64,",""),14), ;
                                    Relatorio.RefFor   WITH TmpProds.reffs, ;
                                    Relatorio.SubGrupo WITH TmpProds.sgrus, ;
                                    Relatorio.DesGrupo WITH TmpProds.descricaos

                            *-- Preco de venda: tipo 5 usa preco da movimentacao
                            IF loc_lFoundMov = .T.
                                REPLACE Relatorio.PreVenda WITH TmpMov.totas, ;
                                        Relatorio.MoeVenda WITH TmpMov.moedas
                            ELSE
                                REPLACE Relatorio.PreVenda WITH TmpProds.pvens, ;
                                        Relatorio.MoeVenda WITH TmpProds.moevs
                            ENDIF
                        ENDIF
                        SELECT Relatorio
                    ENDSCAN

                    *-- Indexa por referencia + grupo + quadro
                    INDEX ON RefFor + Grupos + STR(Quadro, 6) TAG Ordem
                    SET ORDER TO Ordem

                    loc_nCnt   = 0
                    loc_cGrupo = Relatorio.RefFor + Relatorio.Grupos
                    loc_cProdt = SUBSTR(Relatorio.Grupos, 1, 10)

                    *-- Processa imagens, totais por grupo e ordenacao de quadros
                    SELECT Relatorio
                    GO TOP
                    SCAN
                        REPLACE Relatorio.ValTot WITH "", ;
                                Relatorio.MoeTot WITH ""

                        IF EMPTY(Imagem) OR ISNULL(Imagem)
                            REPLACE Relatorio.OrdImg WITH "FBRANCOS"
                        ELSE
                            REPLACE Relatorio.OrdImg WITH "F" + PADL(RECNO(), 7, "0")
                            loc_cFotoRel = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                Relatorio.Imagem, ;
                                "data:image/png;base64,",""), ;
                                "data:image/jpeg;base64,",""), ;
                                "data:image/jpg;base64,",""), 14)
                            STRTOFILE(loc_cFotoRel, SYS(2023) + "\F" + ;
                                      PADL(RECNO(), 7, "0") + ".Jpg")
                        ENDIF

                        IF Relatorio.Imprime = "S" AND loc_nTpRel = 2
                            IF !EMPTY(Relatorio.Observa) AND !ISNULL(Relatorio.Observa)
                                REPLACE Relatorio.DesMateria WITH Relatorio.Observa
                            ELSE
                                IF !EMPTY(Relatorio.DesGrupo) AND !ISNULL(Relatorio.DesGrupo)
                                    REPLACE Relatorio.DesMateria WITH Relatorio.DesGrupo
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Ao mudar de grupo: calcula totais do grupo anterior
                        IF loc_cGrupo # Relatorio.RefFor + Relatorio.Grupos
                            SKIP -1

                            SELECT a.Grupos, a.MoeCusto, ;
                                   SUM(a.Quantidade * a.ValMateria) AS Valor ;
                                FROM CsRelatorio a ;
                                WHERE a.RefFor + a.Grupos = loc_cGrupo ;
                                GROUP BY a.Grupos, a.MoeCusto ;
                                INTO CURSOR csMoedas

                            SELECT csMoedas
                            SCAN
                                SELECT Relatorio
                                REPLACE Relatorio.ValTot WITH ;
                                    IIF(EMPTY(ValTot), ;
                                        TRANSFORM(csMoedas.Valor, "999,999.99"), ;
                                        ValTot + CHR(13) + ;
                                        TRANSFORM(csMoedas.Valor, "999,999.99")), ;
                                    Relatorio.MoeTot WITH ;
                                    IIF(EMPTY(MoeTot), ;
                                        csMoedas.MoeCusto, ;
                                        MoeTot + CHR(13) + csMoedas.MoeCusto)
                                SELECT csMoedas
                            ENDSCAN

                            SELECT Relatorio
                            SKIP
                            loc_cGrupo = Relatorio.RefFor + Relatorio.Grupos
                        ENDIF

                        IF loc_cProdt # SUBSTR(Relatorio.Grupos, 1, 10)
                            loc_cProdt = SUBSTR(Relatorio.Grupos, 1, 10)
                            loc_nCnt = 0
                        ENDIF

                        REPLACE Relatorio.Quadro WITH loc_nCnt
                        SELECT Relatorio
                        loc_nCnt = loc_nCnt + 1
                    ENDSCAN

                    *-- Calcula totais do ultimo grupo
                    SELECT Relatorio
                    GO BOTTOM

                    SELECT a.Grupos, a.MoeCusto, ;
                           SUM(a.Quantidade * a.ValMateria) AS Valor ;
                        FROM CsRelatorio a ;
                        WHERE a.RefFor + a.Grupos = loc_cGrupo ;
                        GROUP BY a.Grupos, a.MoeCusto ;
                        INTO CURSOR CsMoedas

                    SELECT CsMoedas
                    SCAN
                        SELECT Relatorio
                        REPLACE Relatorio.ValTot WITH ;
                            IIF(EMPTY(ValTot), ;
                                TRANSFORM(CsMoedas.Valor, "999,999.99"), ;
                                ValTot + CHR(13) + TRANSFORM(CsMoedas.Valor, "999,999.99")), ;
                            Relatorio.MoeTot WITH ;
                            IIF(EMPTY(MoeTot), ;
                                CsMoedas.MoeCusto, ;
                                MoeTot + CHR(13) + CsMoedas.MoeCusto)
                        SELECT CsMoedas
                    ENDSCAN

                    *-- Ordenacao final
                    SELECT Relatorio
                    IF loc_nOrdem = 1
                        INDEX ON Grupos + STR(Quadro, 6) TAG Ordem
                    ENDIF
                    SET ORDER TO Ordem
                    GO TOP

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosCompEsp1 - Prepara cursor crProCompos para tipos 3 e 4
    * Equivalente ao metodo proccompesp1 do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosCompEsp1()
        LOCAL loc_lSucesso, loc_lOK, loc_cEmp, loc_nResult
        LOCAL loc_lcImgJpg, loc_oErro
        LOCAL loc_cCodPro, loc_lcCompos, loc_cMaoObraPro, loc_cMaoObraGarra
        LOCAL loc_lcArquivo, loc_xImg, loc_lcFoto

        loc_lSucesso = .F.

        TRY
            *-- Nome da empresa para o cabecalho
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Razas FROM SigCdEmp" + ;
                " WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_TmpEmp")

            IF loc_nResult > 0
                SELECT cursor_4c_TmpEmp
                GO TOP
                loc_cEmp = IIF(!EOF(), ALLTRIM(cursor_4c_TmpEmp.Razas), "")
                USE IN cursor_4c_TmpEmp
            ELSE
                loc_cEmp = go_4c_Sistema.cCodEmpresa
            ENDIF

            *-- Cursor de cabecalho
            IF USED("Cabecalho")
                USE IN Cabecalho
            ENDIF
            CREATE CURSOR Cabecalho (Empresa c(50), Titulos c(50), lImpTit l)
            INSERT INTO Cabecalho (Empresa, Titulos, lImpTit) ;
                VALUES (loc_cEmp, ;
                    "Composi" + CHR(231) + CHR(227) + "o Espec" + CHR(237) + "fica 1", ;
                    .F.)

            *-- Cursor de resultado da composicao especifica
            IF USED("crProCompos")
                USE IN crProCompos
            ENDIF
            CREATE CURSOR crProCompos ( ;
                cPros c(14), dPros c(40), PesoMs n(12,2), PVens n(12,2), ;
                Compos m, DtIncs d, DataAlts d, CodGarras c(10), ;
                cProdPai c(14), MoeVs c(3), PrecoGarra n(12,2), ;
                PesoGarra n(12,2), MoeGarra c(3), ;
                cMObraPro c(50), cMObraGarra c(50), Colecoes c(10))

            *-- Imagem em branco via SigSyIco
            loc_lcImgJpg = ""
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 carqicones, marqicones FROM SigSyIco" + ;
                " WHERE carqicones = 'brjpg.jpg'", ;
                "cursor_4c_Icone1")

            IF loc_nResult > 0
                SELECT cursor_4c_Icone1
                GO TOP
                IF !EOF()
                    loc_lcImgJpg = NVL(cursor_4c_Icone1.marqicones, "")
                ENDIF
                USE IN cursor_4c_Icone1
            ENDIF

            IF USED("CrBranco")
                USE IN CrBranco
            ENDIF
            CREATE CURSOR CrBranco (branco m)
            SELECT CrBranco
            APPEND BLANK
            IF !EMPTY(loc_lcImgJpg)
                REPLACE Branco WITH loc_lcImgJpg IN CrBranco
            ENDIF

            *-- Verifica cursor de produtos do form chamador
            IF !USED("CrProdutos")
                THIS.this_cMensagemErro = "Cursor CrProdutos n" + CHR(227) + ;
                    "o encontrado. O form chamador deve popular este cursor antes de chamar PrepararDados."
                loc_lSucesso = .F.
                loc_lOK = .F.
            ELSE
                loc_lOK = .T.
            ENDIF

            IF loc_lOK
                *-- Percorre cada produto e monta o cursor de composicao especifica
                SELECT CrProdutos
                GO TOP IN CrProdutos
                SCAN WHILE loc_lOK
                    loc_cCodPro       = CrProdutos.cPros
                    loc_lcCompos      = ""
                    loc_cMaoObraPro   = ""
                    loc_cMaoObraGarra = ""

                    *-- Dados principais do produto e garra
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT b.CPros, MAX(b.dpros) as dpros," + ;
                        " b.PVens, b.PesoMs, b.DtIncs," + ;
                        " MAX(c.DataAlts) as DataAlts, b.Colecoes," + ;
                        " b.CodGarras, b.cProEqs, b.MoeVs," + ;
                        " d.PVens as PrecoGarra," + ;
                        " d.PesoMs as PesoGarra," + ;
                        " d.MoeVs as MoeGarra" + ;
                        " FROM SigCdPro b" + ;
                        " LEFT JOIN SigCdPro d ON d.cPros = b.CodGarras" + ;
                        " LEFT JOIN SigCdPrc c ON c.cPros = b.cPros" + ;
                        " WHERE b.cPros = " + EscaparSQL(loc_cCodPro) + ;
                        " GROUP BY b.cPros, b.PVens, b.PesoMs, b.DtIncs," + ;
                        " b.Colecoes, b.CodGarras, b.cProEqs," + ;
                        " b.MoeVs, d.PVens, d.PesoMs, d.MoeVs" + ;
                        " ORDER BY b.CPros", ;
                        "crTmpPro")

                    IF loc_nResult < 1
                        MsgErro("Falha na conex" + CHR(227) + ;
                            "o ao buscar produto " + loc_cCodPro, ;
                            "PrepararDadosCompEsp1")
                        loc_lOK = .F.
                    ENDIF

                    IF loc_lOK
                        *-- Composicao do produto
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT a.cGrus, a.Mats, a.dCompos, a.Qtds," + ;
                            " a.UniCompos, a.Pesos, a.cUniPs," + ;
                            " b.CustoFs, c.nTipoJoals" + ;
                            " FROM SigPrCpo a" + ;
                            " INNER JOIN SigCdPro b ON b.cPros = a.Mats" + ;
                            " INNER JOIN SigCdGrp c ON c.cGrus = a.cGrus" + ;
                            " WHERE a.cPros = " + EscaparSQL(loc_cCodPro), ;
                            "crTmpCompo")

                        IF loc_nResult < 1
                            MsgErro("Falha na conex" + CHR(227) + ;
                                "o ao buscar composi" + CHR(231) + CHR(227) + ;
                                "o de " + loc_cCodPro, ;
                                "PrepararDadosCompEsp1")
                            loc_lOK = .F.
                        ENDIF
                    ENDIF

                    IF loc_lOK
                        *-- Monta string de composicao e identifica mao de obra
                        SELECT crTmpCompo
                        SCAN
                            IF crTmpCompo.nTipoJoals = 4
                                loc_cMaoObraPro = loc_cMaoObraPro + ;
                                    IIF(!EMPTY(loc_cMaoObraPro), "/", "") + ;
                                    ALLTRIM(crTmpCompo.Mats)
                            ENDIF
                            loc_lcCompos = loc_lcCompos + ;
                                IIF(!EMPTY(loc_lcCompos), CHR(13) + CHR(10), "")
                            loc_lcCompos = loc_lcCompos + crTmpCompo.Mats + "  " + ;
                                LEFT(crTmpCompo.dCompos, 34) + " " + ;
                                TRANSFORM(crTmpCompo.Qtds, "9999.999") + " " + ;
                                crTmpCompo.UniCompos + " " + ;
                                TRANSFORM(crTmpCompo.Pesos, "9999.999") + " " + ;
                                crTmpCompo.cUniPs
                        ENDSCAN

                        *-- Mao de obra da garra (acessorio do produto)
                        SELECT crTmpPro
                        GO TOP
                        IF !EMPTY(crTmpPro.CodGarras)
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT a.Mats" + ;
                                " FROM SigPrCpo a" + ;
                                " INNER JOIN SigCdPro b ON b.cPros = a.Mats" + ;
                                " INNER JOIN SigCdGrp c ON c.cGrus = a.cGrus" + ;
                                " WHERE a.cPros = " + EscaparSQL(crTmpPro.CodGarras) + ;
                                " AND c.nTipoJoals = 4", ;
                                "crMaoObra")

                            IF loc_nResult < 1
                                MsgErro("Falha na conex" + CHR(227) + ;
                                    "o ao buscar m" + CHR(227) + ;
                                    "o de obra da garra", ;
                                    "PrepararDadosCompEsp1")
                                loc_lOK = .F.
                            ELSE
                                SELECT crMaoObra
                                SCAN
                                    loc_cMaoObraGarra = loc_cMaoObraGarra + ;
                                        IIF(!EMPTY(loc_cMaoObraGarra), "/", "") + ;
                                        ALLTRIM(crMaoObra.Mats)
                                ENDSCAN
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lOK
                        *-- Imagem do produto
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT FigJpgs FROM SigCdPro" + ;
                            " WHERE cPros = " + EscaparSQL(loc_cCodPro), ;
                            "cursor_4c_LocPro")

                        *-- Limpa codigo do produto para uso como nome de arquivo
                        SELECT crTmpPro
                        GO TOP
                        loc_xImg = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN( ;
                            crTmpPro.cPros, "/", ""), " ", ""), ".", ""), "\", ""))
                        loc_lcArquivo = SYS(2023) + "\T" + loc_xImg + ".jpg"

                        CLEAR RESOURCES
                        IF loc_nResult > 0
                            SELECT cursor_4c_LocPro
                            GO TOP
                            IF !EOF() AND !EMPTY(cursor_4c_LocPro.FigJpgs)
                                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_LocPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                            ELSE
                                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    CrBranco.Branco, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                            ENDIF
                            USE IN cursor_4c_LocPro
                        ELSE
                            loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                CrBranco.Branco, ;
                                "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                                "data:image/jpg;base64,", ""), 14)
                        ENDIF

                        STRTOFILE(loc_lcFoto, loc_lcArquivo)

                        *-- Insere registro no cursor de resultado
                        SELECT crTmpPro
                        GO TOP
                        INSERT INTO crProCompos ( ;
                            cPros, dPros, PesoMs, PVens, Compos, ;
                            DtIncs, DataAlts, CodGarras, cProdPai, ;
                            MoeVs, PrecoGarra, PesoGarra, MoeGarra, ;
                            cMObraPro, cMObraGarra, Colecoes) ;
                            VALUES ( ;
                            crTmpPro.cPros, crTmpPro.dpros, ;
                            crTmpPro.PesoMs, crTmpPro.PVens, ;
                            loc_lcCompos, ;
                            NVL(crTmpPro.DtIncs, {}), ;
                            NVL(crTmpPro.DataAlts, {}), ;
                            crTmpPro.CodGarras, crTmpPro.cProEqs, ;
                            crTmpPro.MoeVs, ;
                            NVL(crTmpPro.PrecoGarra, 0), ;
                            NVL(crTmpPro.PesoGarra, 0), ;
                            NVL(crTmpPro.MoeGarra, ""), ;
                            loc_cMaoObraPro, loc_cMaoObraGarra, ;
                            crTmpPro.Colecoes)

                        SELECT CrProdutos
                    ENDIF
                ENDSCAN

                IF loc_lOK
                    SELECT crProCompos
                    GO TOP IN crProCompos
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDadosCompEsp1")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o relatorio em impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_nTpRel, loc_lcApagar, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nTpRel = THIS.this_nOpcRel

            IF loc_nTpRel = 1
                REPORT FORM SigReCgp TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 2)
                REPORT FORM SigReCg1 TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 5)
                REPORT FORM SigReCg2 TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF loc_nTpRel = 3
                REPORT FORM SigPrCpr TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF loc_nTpRel = 4
                REPORT FORM SigPrCp2 TO PRINT PROMPT NOCONSOLE
            ENDIF

            loc_lcApagar = SYS(2023) + "\F*.Jpg"
            DELETE FILE &loc_lcApagar.

            THIS.LimparCursores()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_nTpRel, loc_lcApagar, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nTpRel = THIS.this_nOpcRel

            IF loc_nTpRel = 1
                REPORT FORM SigReCgp PREVIEW NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 2)
                REPORT FORM SigReCg1 PREVIEW NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 5)
                REPORT FORM SigReCg2 PREVIEW NOCONSOLE
            ENDIF
            IF loc_nTpRel = 3
                REPORT FORM SigPrCpr PREVIEW NOCONSOLE
            ENDIF
            IF loc_nTpRel = 4
                REPORT FORM SigPrCp2 PREVIEW NOCONSOLE
            ENDIF

            loc_lcApagar = SYS(2023) + "\F*.Jpg"
            DELETE FILE &loc_lcApagar.

            THIS.LimparCursores()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Libera cursores temporarios e arquivos de imagem
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        LOCAL loc_lcArquivo, loc_xImg

        *-- Remove arquivos de imagem temporarios da CompEsp1 (prefixo T)
        IF USED("crProCompos")
            SELECT crProCompos
            GO TOP
            SCAN
                loc_xImg = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN( ;
                    crProCompos.cPros, "/", ""), " ", ""), ".", ""), "\", ""))
                loc_lcArquivo = SYS(2023) + "\T" + loc_xImg + ".jpg"
                IF FILE(loc_lcArquivo)
                    DELETE FILE (loc_lcArquivo)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Fecha cursores de relatorio
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("Relatorio")
            USE IN Relatorio
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("csMoedas")
            USE IN csMoedas
        ENDIF
        IF USED("CsMoedas")
            USE IN CsMoedas
        ENDIF
        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        IF USED("crProCompos")
            USE IN crProCompos
        ENDIF
        IF USED("Tmp_Memos")
            USE IN Tmp_Memos
        ENDIF
        IF USED("Tmp_Compos")
            USE IN Tmp_Compos
        ENDIF
        IF USED("CrBranco")
            USE IN CrBranco
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas de parametros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    *-- SCATTER MEMVAR para acessar colunas dinamicamente
                    SCATTER MEMVAR

                    IF TYPE("m.nOpcRel") = "N"
                        THIS.this_nOpcRel = m.nOpcRel
                    ENDIF
                    IF TYPE("m.nOpcOrdem") = "N"
                        THIS.this_nOpcOrdem = m.nOpcOrdem
                    ENDIF
                    IF TYPE("m.cEmpEDN") = "C"
                        THIS.this_cEmpEDN = ALLTRIM(m.cEmpEDN)
                    ENDIF
                    IF TYPE("m.nVal") = "N"
                        THIS.this_nVal = m.nVal
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Prepara dados, dispara impressao e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !INLIST(THIS.this_nOpcRel, 1, 2, 3, 4, 5)
                THIS.this_cMensagemErro = "Tipo de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(THIS.this_nOpcRel)
            ELSE
                IF !THIS.PrepararDados()
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.Imprimir()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("IMPRESSAO")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Prepara dados, dispara preview e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !INLIST(THIS.this_nOpcRel, 1, 2, 3, 4, 5)
                THIS.this_cMensagemErro = "Tipo de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(THIS.this_nOpcRel)
            ELSE
                IF !THIS.PrepararDados()
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.Visualizar()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("VISUALIZACAO")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario, loc_cEmpresa, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF

            loc_cChave = "EMP=" + loc_cEmpresa + ;
                         ";TIPO=" + ALLTRIM(STR(THIS.this_nOpcRel, 1)) + ;
                         ";ORDEM=" + ALLTRIM(STR(THIS.this_nOpcOrdem, 1)) + ;
                         ";EDN=" + ALLTRIM(THIS.this_cEmpEDN)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCgp") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE

