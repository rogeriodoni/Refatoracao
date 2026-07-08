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
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
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
                .Caption         = "\<Arquivos Email"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .ToolTipText     = "Arquivos Email"
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

            *-- Option1: Top=5, Left=5, AutoSize=.T. (original)
            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .AutoSize  = .T.
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
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
                .FontName  = "Comic Sans MS"
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
                .WordWrap        = .T.
                             "o Espec" + CHR(237) + "fica 1"
                .FontName  = "Comic Sans MS"
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
                .WordWrap        = .T.
                             "o Espec" + CHR(237) + "fica 2"
                .FontName  = "Comic Sans MS"
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
                .FontName  = "Comic Sans MS"
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
        *   Original: Top=200, Left=359 -> Relativo a Page1: Top=115, Left=360
        loc_oPage1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPage1.lbl_4c_Label1
            .Top       = 115
            .Left      = 360
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

            WITH .Buttons(1)
                .Top      = 5
                .Left     = 5
                .AutoSize = .T.
                .Caption  = "Produto"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Visible  = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top      = 5
                .Left     = 80
                .AutoSize = .T.
                .Caption  = "Ref.Fornecedor"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
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
        RETURN
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
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Stub de compatibilidade com pipeline CRUD
    *   Form REPORT: busca nao aplicavel; usar BtnVisualizarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
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
        RETURN .T.
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
        RETURN
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
        RETURN
    ENDPROC

ENDDEFINE
