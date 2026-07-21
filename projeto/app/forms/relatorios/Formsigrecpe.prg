*==============================================================================
* FORMSIGRECPE.PRG
* Relatorio: Diverg" + CHR(234) + "ncias em Estoques
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: sigrecpe.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - Estoque A : Grupo de Estoque + Conta (fAcessoContab / fAcessoContas)
*   - Estoque B : Grupo de Estoque + Conta (fAcessoContab / fAcessoContas)
*   - Analisar Cor/Tamanho : opt_4c_CorTam (Sim / N" + CHR(227) + "o)
*   - Tipo de Compara" + CHR(231) + CHR(227) + "o : opt_4c_Tipo (EstoqA x EstoqB / ProdutosxEstoqB)
*   - Analisar por Ref.Fornecedor : opt_4c_Reff (Sim / N" + CHR(227) + "o)
*   - Filtro de Produto : Grupo, Unidade, Linha, Grupo Venda (intervalos i/f)
*   - Situa" + CHR(231) + CHR(227) + "o : opt_4c_Situacao (Ativos / Inativos / Todos)
*
* FASES 5-7/8 - Form completo: estrutura + todos os campos + lookups + eventos
*   * Propriedades visuais e declara" + CHR(231) + CHR(227) + "o de classe
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()       (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes()          (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame()       (PageFrame com 1 p" + CHR(225) + "gina - Filtros)
*   * ConfigurarPaginaFiltros()   (todos campos: EstoqueA/B, filtros produto, op" + CHR(231) + CHR(245) + "es)
*   * FormParaRelatorio()         (transfer" + CHR(234) + "ncia controles -> BO)
*   * ValidarCamposObrigatorios() (EstoqueB obrigat" + CHR(243) + "rio; EstoqueA se Tipo=1)
*   * LimparCampos()              (reset filtros para defaults do legado)
*   * BtnVisualizarClick()        (REPORT FORM ... PREVIEW NOCONSOLE)
*   * BtnImprimirClick()          (REPORT FORM ... TO PRINTER PROMPT NOCONSOLE)
*   * BtnExcelClick()             (COPY TO ... TYPE XLS)
*   * BtnSairClick()              (THIS.Release)
*   * BtnIncluirClick()           (LimparCampos - reset filtros)
*   * BtnAlterarClick()           (delega BtnVisualizarClick)
*   * BtnExcluirClick()           (aviso: opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel)
*   * BtnVisualizarCrudClick()    (delega BtnImprimirClick)
*   * Lookups completos: GrEstoque A/B (SigCdGcr), Conta A/B (SigCdCli),
*                        Grupo/Unidade/Linha/GrupoVenda (SigCdGrp/Uni/Lin/Col)
*   * Mapeamento CRUD->REPORT (AtualizarEstadoControles, AlternarPagina, etc.)
*==============================================================================

DEFINE CLASS Formsigrecpe AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia
    Height      = 600
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
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Instancia sigrecpeBO e valida cria" + CHR(231) + CHR(227) + "o
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es + PageFrame
    *   4. Vincula eventos Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Diverg" + CHR(234) + "ncias em estoques"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecpeBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecpeBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
            ELSE
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente ao cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro na Page1
                THIS.ConfigurarPaginaFiltros()

                *-- Restaurar valores padr" + CHR(227) + "o dos filtros
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

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
                .Caption   = "Diverg" + CHR(234) + "ncias em estoques"
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
                .Caption   = "Diverg" + CHR(234) + "ncias em estoques"
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
    * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
    *   Original: btnReport.Left=528, Top=3, Width=305, Height=85 (800px form)
    *   Novo sist: cmg_4c_Botoes.Left=529, Top=0, Width=273, Height=80 (1000px)
    *   Canonical: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
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
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (impressora com di" + CHR(225) + "logo de sele" + CHR(231) + CHR(227) + "o)
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

            *-- Excel (exportar dados do cursor para planilha)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
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
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar (fechar form - Cancel=.T. para ESC)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
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
    *   O form legado SIGRECPE " + CHR(233) + " FLAT (sem PageFrame), mas no novo padr" + CHR(227) + "o
    *   os campos de filtro s" + CHR(227) + "o agrupados em um PageFrame de 1 p" + CHR(225) + "gina.
    *   Os controles de filtro (TextBoxes, OptionGroups, Labels) s" + CHR(227) + "o
    *   adicionados " + CHR(224) + " Page1 na Fase 5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) ate o fim do form
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
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
    *   Equivalente ao bloco 'processamento' do form legado SIGRECPE.
    *   Todos os controles referenciados s" + CHR(227) + "o criados na Fase 5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                *-- Estoque A
                .this_cCdGrEstoqueA = ALLTRIM(loc_oPg.txt_4c_CdGrEstoqueA.Value)
                .this_cDsGrEstoqueA = ALLTRIM(loc_oPg.txt_4c_DsGrEstoqueA.Value)
                .this_cCdEstoqueA   = ALLTRIM(loc_oPg.txt_4c_CdEstoqueA.Value)
                .this_cDsEstoqueA   = ALLTRIM(loc_oPg.txt_4c_DsEstoqueA.Value)
                *-- Estoque B
                .this_cCdGrupoB     = ALLTRIM(loc_oPg.txt_4c_CdGrupoB.Value)
                .this_cDsGrupoB     = ALLTRIM(loc_oPg.txt_4c_DsGrupoB.Value)
                .this_cCdContaB     = ALLTRIM(loc_oPg.txt_4c_CdContaB.Value)
                .this_cDsContaB     = ALLTRIM(loc_oPg.txt_4c_DsContaB.Value)
                *-- Op" + CHR(231) + CHR(245) + "es de compara" + CHR(231) + CHR(227) + "o
                .this_nTipo         = loc_oPg.opt_4c_Tipo.Value
                .this_nCorTam       = loc_oPg.opt_4c_CorTam.Value
                .this_nReff         = loc_oPg.opt_4c_Reff.Value
                .this_nSituacao     = loc_oPg.opt_4c_Situacao.Value
                *-- Filtros de produto (intervalos inicial/final)
                .this_cCgrui        = ALLTRIM(loc_oPg.txt_4c_Cgrui.Value)
                .this_cCgruf        = ALLTRIM(loc_oPg.txt_4c_Cgruf.Value)
                .this_cCunii        = ALLTRIM(loc_oPg.txt_4c_Cunii.Value)
                .this_cCunif        = ALLTRIM(loc_oPg.txt_4c_Cunif.Value)
                .this_cLini         = ALLTRIM(loc_oPg.txt_4c_Lini.Value)
                .this_cLinf         = ALLTRIM(loc_oPg.txt_4c_Linf.Value)
                .this_cColi         = ALLTRIM(loc_oPg.txt_4c_Coli.Value)
                .this_cColf         = ALLTRIM(loc_oPg.txt_4c_Colf.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCamposObrigatorios - Valida campos obrigat" + CHR(243) + "rios antes de gerar
    *   Estoque B (Grupo + Conta) " + CHR(233) + " obrigat" + CHR(243) + "rio em todos os tipos de relat" + CHR(243) + "rio.
    *   Estoque A (Grupo + Conta) " + CHR(233) + " obrigat" + CHR(243) + "rio apenas no Tipo 1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCamposObrigatorios()
        LOCAL loc_oPg, loc_nTipo, loc_lValido
        loc_lValido = .T.
        TRY
            DO WHILE .T.
                loc_oPg   = THIS.pgf_4c_Paginas.Page1
                loc_nTipo = 2

                IF PEMSTATUS(loc_oPg, "opt_4c_Tipo", 5)
                    loc_nTipo = loc_oPg.opt_4c_Tipo.Value
                ENDIF

                IF PEMSTATUS(loc_oPg, "txt_4c_CdGrupoB", 5)
                    IF EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGrupoB.Value))
                        MsgAviso("Estoque B - Grupo de Estoque " + CHR(233) + ;
                            " obrigat" + CHR(243) + "rio.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oPg.txt_4c_CdGrupoB.SetFocus()
                        loc_lValido = .F.
                        EXIT
                    ENDIF
                ENDIF

                IF PEMSTATUS(loc_oPg, "txt_4c_CdContaB", 5)
                    IF EMPTY(ALLTRIM(loc_oPg.txt_4c_CdContaB.Value))
                        MsgAviso("Estoque B - Conta de Estoque " + CHR(233) + ;
                            " obrigat" + CHR(243) + "rio.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oPg.txt_4c_CdContaB.SetFocus()
                        loc_lValido = .F.
                        EXIT
                    ENDIF
                ENDIF

                IF loc_nTipo = 1
                    IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoqueA", 5)
                        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGrEstoqueA.Value))
                            MsgAviso("Estoque A - Grupo de Estoque " + CHR(233) + ;
                                " obrigat" + CHR(243) + "rio no tipo Estoque x Estoque.", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                            loc_oPg.txt_4c_CdGrEstoqueA.SetFocus()
                            loc_lValido = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    IF PEMSTATUS(loc_oPg, "txt_4c_CdEstoqueA", 5)
                        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_CdEstoqueA.Value))
                            MsgAviso("Estoque A - Conta de Estoque " + CHR(233) + ;
                                " obrigat" + CHR(243) + "rio no tipo Estoque x Estoque.", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                            loc_oPg.txt_4c_CdEstoqueA.SetFocus()
                            loc_lValido = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDIF

                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padr" + CHR(227) + "o do legado
    *   Estoque A/B: em branco; Op" + CHR(231) + CHR(245) + "es: valores default do Init legado
    *   opt_CorTam=2(N" + CHR(227) + "o), opt_Tipo=1(EstA x EstB), opt_reff=2(N" + CHR(227) + "o), Situacao=3(Todos)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoqueA", 5)
                loc_oPg.txt_4c_CdGrEstoqueA.Value = ""
                loc_oPg.txt_4c_DsGrEstoqueA.Value = ""
                loc_oPg.txt_4c_CdEstoqueA.Value   = ""
                loc_oPg.txt_4c_DsEstoqueA.Value   = ""
                loc_oPg.txt_4c_CdGrupoB.Value      = ""
                loc_oPg.txt_4c_DsGrupoB.Value      = ""
                loc_oPg.txt_4c_CdContaB.Value      = ""
                loc_oPg.txt_4c_DsContaB.Value      = ""
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_Cgrui", 5)
                loc_oPg.txt_4c_Cgrui.Value = ""
                loc_oPg.txt_4c_Cgruf.Value = ""
                loc_oPg.txt_4c_Cunii.Value = ""
                loc_oPg.txt_4c_Cunif.Value = ""
                loc_oPg.txt_4c_Lini.Value  = ""
                loc_oPg.txt_4c_Linf.Value  = ""
                loc_oPg.txt_4c_Coli.Value  = ""
                loc_oPg.txt_4c_Colf.Value  = ""
            ENDIF

            *-- OptionGroups: valores padr" + CHR(227) + "o iguais ao Init() do legado
            IF PEMSTATUS(loc_oPg, "opt_4c_CorTam", 5)
                loc_oPg.opt_4c_CorTam.Value  = 2
            ENDIF
            IF PEMSTATUS(loc_oPg, "opt_4c_Tipo", 5)
                loc_oPg.opt_4c_Tipo.Value    = 1
            ENDIF
            IF PEMSTATUS(loc_oPg, "opt_4c_Reff", 5)
                loc_oPg.opt_4c_Reff.Value    = 2
            ENDIF
            IF PEMSTATUS(loc_oPg, "opt_4c_Situacao", 5)
                loc_oPg.opt_4c_Situacao.Value = 3
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relat" + CHR(243) + "rio em preview na tela
    *   Equivalente ao procedure 'visualizacao' do form legado SIGRECPE.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            DO WHILE .T.
                IF !THIS.ValidarCamposObrigatorios()
                    EXIT
                ENDIF
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relat" + CHR(243) + "rio na impressora com di" + CHR(225) + "logo de sele" + CHR(231) + CHR(227) + "o
    *   Equivalente ao procedure 'processamento' do form legado SIGRECPE.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            DO WHILE .T.
                IF !THIS.ValidarCamposObrigatorios()
                    EXIT
                ENDIF
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do cursor para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_cCursor
        TRY
            DO WHILE .T.
                IF !THIS.ValidarCamposObrigatorios()
                    EXIT
                ENDIF
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.PrepararDados()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                    EXIT
                ENDIF
                loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
                IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                    MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                    EXIT
                ENDIF
                loc_cArquivo = PUTFILE("Salvar como...", "SigReCpE", "XLS")
                IF !EMPTY(loc_cArquivo)
                    SELECT (loc_cCursor)
                    COPY TO (loc_cArquivo) TYPE XLS
                    MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
                        loc_cArquivo, "Excel")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Em forms CRUD os bot" + CHR(245) + "es Incluir/Alterar/Excluir manipulam registros.
    * Em forms de RELATORIO essas opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o existem - os m" + CHR(233) + "todos abaixo
    * traduzem o conceito CRUD para a sem" + CHR(226) + "ntica de relat" + CHR(243) + "rio.
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override: formul" + CHR(225) + "rio de relat" + CHR(243) + "rio n" + CHR(227) + "o usa CRUD
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Visualizar" para form de relat" + CHR(243) + "rio
    *   Em CRUD: prepara form para altera" + CHR(231) + CHR(227) + "o do registro selecionado.
    *   Em REPORT: delega para BtnVisualizarClick (gera preview com filtros atuais).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida em form de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel neste relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Limpar filtros" para form de relat" + CHR(243) + "rio
    *   Em CRUD: prepara form para inclus" + CHR(227) + "o de novo registro.
    *   Em REPORT: restaura campos de filtro para os valores padr" + CHR(227) + "o.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarCrudClick - "Imprimir" para form de relat" + CHR(243) + "rio
    *   Em CRUD: exibe registro em modo visualiza" + CHR(231) + CHR(227) + "o (somente leitura).
    *   Em REPORT: delega para BtnImprimirClick (envia para impressora).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarCrudClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Adiciona controles de filtro na Page1
    *   Equivale ao layout flat do SIGRECPE original (frmrelatorio sem PageFrame)
    *   Controles posicionados com compensacao: Page1_top = original_top - 85
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            *-- ====== SECAO: Filtro de Produto (original top 139..280) ======

            loc_oPg.AddObject("lbl_4c_FiltProd", "Label")
            WITH loc_oPg.lbl_4c_FiltProd
                .Top       = 54
                .Left      = 195
                .Width     = 107
                .Height    = 16
                .Caption   = "Filtro de Produto"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Grupo (cgrus) inicial
            loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
            WITH loc_oPg.lbl_4c_LblGrupo
                .Top      = 76
                .Left     = 231
                .Width    = 41
                .Height   = 15
                .Caption  = "Grupo : "
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Cgrui", "TextBox")
            WITH loc_oPg.txt_4c_Cgrui
                .Top      = 71
                .Left     = 276
                .Width    = 31
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_Ate1", "Label")
            WITH loc_oPg.lbl_4c_Ate1
                .Top      = 76
                .Left     = 314
                .Width    = 30
                .Height   = 15
                .Caption  = "at" + CHR(233) + " :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Cgruf", "TextBox")
            WITH loc_oPg.txt_4c_Cgruf
                .Top      = 71
                .Left     = 341
                .Width    = 31
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Unidade (cunis) inicial
            loc_oPg.AddObject("lbl_4c_LblUnidade", "Label")
            WITH loc_oPg.lbl_4c_LblUnidade
                .Top      = 98
                .Left     = 221
                .Width    = 51
                .Height   = 15
                .Caption  = "Unidade : "
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Cunii", "TextBox")
            WITH loc_oPg.txt_4c_Cunii
                .Top      = 95
                .Left     = 276
                .Width    = 31
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_Ate2", "Label")
            WITH loc_oPg.lbl_4c_Ate2
                .Top      = 98
                .Left     = 314
                .Width    = 30
                .Height   = 15
                .Caption  = "at" + CHR(233) + " :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Cunif", "TextBox")
            WITH loc_oPg.txt_4c_Cunif
                .Top      = 95
                .Left     = 341
                .Width    = 31
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Linha (linhas) inicial
            loc_oPg.AddObject("lbl_4c_LblLinha", "Label")
            WITH loc_oPg.lbl_4c_LblLinha
                .Top      = 122
                .Left     = 235
                .Width    = 37
                .Height   = 15
                .Caption  = "Linha : "
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Lini", "TextBox")
            WITH loc_oPg.txt_4c_Lini
                .Top      = 119
                .Left     = 276
                .Width    = 80
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_Ate3", "Label")
            WITH loc_oPg.lbl_4c_Ate3
                .Top      = 122
                .Left     = 361
                .Width    = 30
                .Height   = 15
                .Caption  = "at" + CHR(233) + " :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Linf", "TextBox")
            WITH loc_oPg.txt_4c_Linf
                .Top      = 119
                .Left     = 385
                .Width    = 80
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Grupo de Venda / Colecao (colecoes)
            loc_oPg.AddObject("lbl_4c_LblGrupoVenda", "Label")
            WITH loc_oPg.lbl_4c_LblGrupoVenda
                .Top      = 146
                .Left     = 195
                .Width    = 77
                .Height   = 15
                .Caption  = "Grupo  Venda : "
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Coli", "TextBox")
            WITH loc_oPg.txt_4c_Coli
                .Top      = 143
                .Left     = 276
                .Width    = 80
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_Ate4", "Label")
            WITH loc_oPg.lbl_4c_Ate4
                .Top      = 146
                .Left     = 361
                .Width    = 30
                .Height   = 15
                .Caption  = "at" + CHR(233) + " :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_Colf", "TextBox")
            WITH loc_oPg.txt_4c_Colf
                .Top      = 143
                .Left     = 385
                .Width    = 80
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Situacao
            loc_oPg.AddObject("lbl_4c_LblSituacao", "Label")
            WITH loc_oPg.lbl_4c_LblSituacao
                .Top      = 170
                .Left     = 219
                .Width    = 60
                .Height   = 15
                .Caption  = "Situa" + CHR(231) + CHR(227) + "o : "
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("opt_4c_Situacao", "OptionGroup")
            loc_oPg.opt_4c_Situacao.ButtonCount = 3
            WITH loc_oPg.opt_4c_Situacao
                .Top         = 169
                .Left        = 276
                .Width       = 188
                .Height      = 22
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 3
                .Visible     = .T.
                .Buttons(1).Caption  = "Ativos"
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).Width    = 62
                .Buttons(2).Caption  = "Inativos"
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).Left     = 63
                .Buttons(2).Width    = 62
                .Buttons(3).Caption  = "Todos"
                .Buttons(3).FontName = "Tahoma"
                .Buttons(3).FontSize = 8
                .Buttons(3).Left     = 126
                .Buttons(3).Width    = 62
            ENDWITH

            *-- ====== SECAO: Estoque A (original top 282..355) ======

            loc_oPg.AddObject("lbl_4c_EstoqueA", "Label")
            WITH loc_oPg.lbl_4c_EstoqueA
                .Top       = 197
                .Left      = 195
                .Width     = 65
                .Height    = 16
                .Caption   = "Estoque A"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LblGrEstA", "Label")
            WITH loc_oPg.lbl_4c_LblGrEstA
                .Top      = 221
                .Left     = 192
                .Width    = 95
                .Height   = 16
                .Caption  = "Grupo de Estoque :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_CdGrEstoqueA", "TextBox")
            WITH loc_oPg.txt_4c_CdGrEstoqueA
                .Top      = 216
                .Left     = 300
                .Width    = 80
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_DsGrEstoqueA", "TextBox")
            WITH loc_oPg.txt_4c_DsGrEstoqueA
                .Top      = 216
                .Left     = 380
                .Width    = 290
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .ReadOnly = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LblEstA", "Label")
            WITH loc_oPg.lbl_4c_LblEstA
                .Top      = 246
                .Left     = 246
                .Width    = 48
                .Height   = 16
                .Caption  = "Estoque :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_CdEstoqueA", "TextBox")
            WITH loc_oPg.txt_4c_CdEstoqueA
                .Top      = 241
                .Left     = 300
                .Width    = 80
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_DsEstoqueA", "TextBox")
            WITH loc_oPg.txt_4c_DsEstoqueA
                .Top      = 241
                .Left     = 380
                .Width    = 290
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .ReadOnly = .T.
                .Visible  = .T.
            ENDWITH

            *-- ====== SECAO: Estoque B (original top 354..430) ======

            loc_oPg.AddObject("lbl_4c_EstoqueB", "Label")
            WITH loc_oPg.lbl_4c_EstoqueB
                .Top       = 269
                .Left      = 195
                .Width     = 64
                .Height    = 16
                .Caption   = "Estoque B"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LblGrEstB", "Label")
            WITH loc_oPg.lbl_4c_LblGrEstB
                .Top      = 293
                .Left     = 192
                .Width    = 95
                .Height   = 16
                .Caption  = "Grupo de Estoque :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_CdGrupoB", "TextBox")
            WITH loc_oPg.txt_4c_CdGrupoB
                .Top      = 288
                .Left     = 300
                .Width    = 80
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_DsGrupoB", "TextBox")
            WITH loc_oPg.txt_4c_DsGrupoB
                .Top      = 288
                .Left     = 380
                .Width    = 290
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .ReadOnly = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LblEstB", "Label")
            WITH loc_oPg.lbl_4c_LblEstB
                .Top      = 318
                .Left     = 246
                .Width    = 48
                .Height   = 16
                .Caption  = "Estoque :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_CdContaB", "TextBox")
            WITH loc_oPg.txt_4c_CdContaB
                .Top      = 313
                .Left     = 300
                .Width    = 80
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_DsContaB", "TextBox")
            WITH loc_oPg.txt_4c_DsContaB
                .Top      = 313
                .Left     = 380
                .Width    = 290
                .Height   = 25
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .ReadOnly = .T.
                .Visible  = .T.
            ENDWITH

            *-- ====== SECAO: Opcoes de Comparacao (original top 430..490) ======

            loc_oPg.AddObject("lbl_4c_LblCorTam", "Label")
            WITH loc_oPg.lbl_4c_LblCorTam
                .Top      = 351
                .Left     = 219
                .Width    = 115
                .Height   = 16
                .Caption  = "Analisar Cor/Tamanho :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("opt_4c_CorTam", "OptionGroup")
            loc_oPg.opt_4c_CorTam.ButtonCount = 2
            WITH loc_oPg.opt_4c_CorTam
                .Top         = 345
                .Left        = 347
                .Width       = 97
                .Height      = 23
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
                .Buttons(1).Caption  = "Sim"
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).Width    = 48
                .Buttons(2).Caption  = "N" + CHR(227) + "o"
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).Left     = 49
                .Buttons(2).Width    = 48
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LblTipo", "Label")
            WITH loc_oPg.lbl_4c_LblTipo
                .Top      = 371
                .Left     = 301
                .Width    = 43
                .Height   = 15
                .Caption  = "Analisar "
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("opt_4c_Tipo", "OptionGroup")
            loc_oPg.opt_4c_Tipo.ButtonCount = 2
            WITH loc_oPg.opt_4c_Tipo
                .Top         = 365
                .Left        = 347
                .Width       = 303
                .Height      = 25
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.
                .Buttons(1).Caption  = "Estoque x Estoque"
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).Width    = 150
                .Buttons(2).Caption  = "Produto x Estoque"
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).Left     = 151
                .Buttons(2).Width    = 150
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LblReff", "Label")
            WITH loc_oPg.lbl_4c_LblReff
                .Top      = 392
                .Left     = 189
                .Width    = 145
                .Height   = 16
                .Caption  = "Analisar por Ref.Fornecedor :"
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("opt_4c_Reff", "OptionGroup")
            loc_oPg.opt_4c_Reff.ButtonCount = 2
            WITH loc_oPg.opt_4c_Reff
                .Top         = 386
                .Left        = 347
                .Width       = 97
                .Height      = 23
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
                .Buttons(1).Caption  = "Sim"
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).Width    = 48
                .Buttons(2).Caption  = "N" + CHR(227) + "o"
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).Left     = 49
                .Buttons(2).Width    = 48
            ENDWITH

            *-- ====== BINDEVENTS - KeyPress handlers (PUBLIC - contrato BINDEVENT) ======

            *-- Estoque A: Grupo (codigo)
            BINDEVENT(loc_oPg.txt_4c_CdGrEstoqueA, "KeyPress", THIS, "TeclaCdGrEstoqueA")
            *-- Estoque A: Conta (codigo)
            BINDEVENT(loc_oPg.txt_4c_CdEstoqueA,   "KeyPress", THIS, "TeclaCdEstoqueA")
            *-- Estoque B: Grupo (codigo)
            BINDEVENT(loc_oPg.txt_4c_CdGrupoB,     "KeyPress", THIS, "TeclaCdGrupoB")
            *-- Estoque B: Conta (codigo)
            BINDEVENT(loc_oPg.txt_4c_CdContaB,     "KeyPress", THIS, "TeclaCdContaB")
            *-- Filtros de produto
            BINDEVENT(loc_oPg.txt_4c_Cgrui, "KeyPress", THIS, "TeclaCgrui")
            BINDEVENT(loc_oPg.txt_4c_Cgruf, "KeyPress", THIS, "TeclaCgruf")
            BINDEVENT(loc_oPg.txt_4c_Cunii, "KeyPress", THIS, "TeclaCunii")
            BINDEVENT(loc_oPg.txt_4c_Cunif, "KeyPress", THIS, "TeclaCunif")
            BINDEVENT(loc_oPg.txt_4c_Lini,  "KeyPress", THIS, "TeclaLini")
            BINDEVENT(loc_oPg.txt_4c_Linf,  "KeyPress", THIS, "TeclaLinf")
            BINDEVENT(loc_oPg.txt_4c_Coli,  "KeyPress", THIS, "TeclaColi")
            BINDEVENT(loc_oPg.txt_4c_Colf,  "KeyPress", THIS, "TeclaColf")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  LOOKUPS - ESTOQUE A: Grupo de Estoque (SigCdGcr: codigos/descrs)
    *==========================================================================

    *-- KeyPress no codigo do GrEstoqueA: F4=busca, ENTER/TAB=valida
    PROCEDURE TeclaCdGrEstoqueA(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque("A")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoqueA()
            ENDIF
        ENDIF
    ENDPROC

    *-- Valida codigo digitado contra SigCdGcr; se nao encontrar, abre lookup
    PROCEDURE ValidarCdGrEstoqueA()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            DO WHILE .T.
                loc_oPg     = THIS.pgf_4c_Paginas.Page1
                loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CdGrEstoqueA.Value)
                IF EMPTY(loc_cCodigo)
                    loc_oPg.txt_4c_DsGrEstoqueA.Value = ""
                    loc_oPg.txt_4c_CdEstoqueA.Value   = ""
                    loc_oPg.txt_4c_DsEstoqueA.Value   = ""
                    EXIT
                ENDIF
                loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr" + ;
                           " WHERE codigos = " + EscaparSQL(PADR(loc_cCodigo, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstAVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstAVal")
                    SELECT cursor_4c_GrEstAVal
                    loc_oPg.txt_4c_CdGrEstoqueA.Value = ALLTRIM(cursor_4c_GrEstAVal.codigos)
                    loc_oPg.txt_4c_DsGrEstoqueA.Value = ALLTRIM(cursor_4c_GrEstAVal.descrs)
                    loc_oPg.txt_4c_CdEstoqueA.Value   = ""
                    loc_oPg.txt_4c_DsEstoqueA.Value   = ""
                ELSE
                    *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                    THIS.AbrirBuscaGrEstoque("A")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_GrEstAVal")
            USE IN cursor_4c_GrEstAVal
        ENDIF
    ENDPROC

    *-- Abre FormBuscaAuxiliar para SigCdGcr (compartilhado: lado = "A" ou "B")
    PROCEDURE AbrirBuscaGrEstoque(par_cLado)
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_GrEstBusca"
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF UPPER(ALLTRIM(par_cLado)) = "A"
                loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrEstoqueA.Value)
            ELSE
                loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrupoB.Value)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Grupo de Estoque", .F., .F., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    IF UPPER(ALLTRIM(par_cLado)) = "A"
                        loc_oPg.txt_4c_CdGrEstoqueA.Value = ALLTRIM(codigos)
                        loc_oPg.txt_4c_DsGrEstoqueA.Value = ALLTRIM(descrs)
                        loc_oPg.txt_4c_CdEstoqueA.Value   = ""
                        loc_oPg.txt_4c_DsEstoqueA.Value   = ""
                    ELSE
                        loc_oPg.txt_4c_CdGrupoB.Value = ALLTRIM(codigos)
                        loc_oPg.txt_4c_DsGrupoB.Value = ALLTRIM(descrs)
                        loc_oPg.txt_4c_CdContaB.Value  = ""
                        loc_oPg.txt_4c_DsContaB.Value  = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  LOOKUPS - ESTOQUE A: Conta de Estoque (SigCdCli: iclis/razaos)
    *==========================================================================

    PROCEDURE TeclaCdEstoqueA(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta("A")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoqueA()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdEstoqueA()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            DO WHILE .T.
                loc_oPg     = THIS.pgf_4c_Paginas.Page1
                loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CdEstoqueA.Value)
                IF EMPTY(loc_cCodigo)
                    loc_oPg.txt_4c_DsEstoqueA.Value = ""
                    EXIT
                ENDIF
                loc_cSQL = "SELECT TOP 1 iclis, razaos FROM SigCdCli" + ;
                           " WHERE iclis = " + EscaparSQL(PADR(loc_cCodigo, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaAVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_ContaAVal")
                    SELECT cursor_4c_ContaAVal
                    loc_oPg.txt_4c_CdEstoqueA.Value = ALLTRIM(cursor_4c_ContaAVal.iclis)
                    loc_oPg.txt_4c_DsEstoqueA.Value = ALLTRIM(cursor_4c_ContaAVal.razaos)
                ELSE
                    *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                    THIS.AbrirBuscaConta("A")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_ContaAVal")
            USE IN cursor_4c_ContaAVal
        ENDIF
    ENDPROC

    *-- Abre FormBuscaAuxiliar para SigCdCli filtrado por grupo (lado = "A" ou "B")
    PROCEDURE AbrirBuscaConta(par_cLado)
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor, loc_cGrupo, loc_cFiltro
        loc_cCursor = "cursor_4c_ContaBusca"
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF UPPER(ALLTRIM(par_cLado)) = "A"
                loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEstoqueA.Value)
                loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrEstoqueA.Value)
            ELSE
                loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdContaB.Value)
                loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrupoB.Value)
            ENDIF

            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
            ELSE
                loc_cFiltro = ""
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Conta de Estoque", .F., .F., loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razaos", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    IF UPPER(ALLTRIM(par_cLado)) = "A"
                        loc_oPg.txt_4c_CdEstoqueA.Value = ALLTRIM(iclis)
                        loc_oPg.txt_4c_DsEstoqueA.Value = ALLTRIM(razaos)
                    ELSE
                        loc_oPg.txt_4c_CdContaB.Value = ALLTRIM(iclis)
                        loc_oPg.txt_4c_DsContaB.Value = ALLTRIM(razaos)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  LOOKUPS - ESTOQUE B: Grupo de Estoque B
    *==========================================================================

    PROCEDURE TeclaCdGrupoB(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque("B")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupoB()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdGrupoB()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            DO WHILE .T.
                loc_oPg     = THIS.pgf_4c_Paginas.Page1
                loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CdGrupoB.Value)
                IF EMPTY(loc_cCodigo)
                    loc_oPg.txt_4c_DsGrupoB.Value = ""
                    loc_oPg.txt_4c_CdContaB.Value  = ""
                    loc_oPg.txt_4c_DsContaB.Value  = ""
                    EXIT
                ENDIF
                loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr" + ;
                           " WHERE codigos = " + EscaparSQL(PADR(loc_cCodigo, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstBVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstBVal")
                    SELECT cursor_4c_GrEstBVal
                    loc_oPg.txt_4c_CdGrupoB.Value = ALLTRIM(cursor_4c_GrEstBVal.codigos)
                    loc_oPg.txt_4c_DsGrupoB.Value = ALLTRIM(cursor_4c_GrEstBVal.descrs)
                    loc_oPg.txt_4c_CdContaB.Value  = ""
                    loc_oPg.txt_4c_DsContaB.Value  = ""
                ELSE
                    *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                    THIS.AbrirBuscaGrEstoque("B")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_GrEstBVal")
            USE IN cursor_4c_GrEstBVal
        ENDIF
    ENDPROC

    *==========================================================================
    *  LOOKUPS - ESTOQUE B: Conta de Estoque B
    *==========================================================================

    PROCEDURE TeclaCdContaB(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta("B")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdContaB()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdContaB()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            DO WHILE .T.
                loc_oPg     = THIS.pgf_4c_Paginas.Page1
                loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CdContaB.Value)
                IF EMPTY(loc_cCodigo)
                    loc_oPg.txt_4c_DsContaB.Value = ""
                    EXIT
                ENDIF
                loc_cSQL = "SELECT TOP 1 iclis, razaos FROM SigCdCli" + ;
                           " WHERE iclis = " + EscaparSQL(PADR(loc_cCodigo, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaBVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_ContaBVal")
                    SELECT cursor_4c_ContaBVal
                    loc_oPg.txt_4c_CdContaB.Value = ALLTRIM(cursor_4c_ContaBVal.iclis)
                    loc_oPg.txt_4c_DsContaB.Value = ALLTRIM(cursor_4c_ContaBVal.razaos)
                ELSE
                    *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                    THIS.AbrirBuscaConta("B")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_ContaBVal")
            USE IN cursor_4c_ContaBVal
        ENDIF
    ENDPROC

    *==========================================================================
    *  LOOKUPS - FILTROS DE PRODUTO (F4 abre busca e preenche o campo)
    *==========================================================================

    PROCEDURE TeclaCgrui(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Cgrui)
        ENDIF
    ENDPROC

    PROCEDURE TeclaCgruf(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Cgruf)
        ENDIF
    ENDPROC

    PROCEDURE TeclaCunii(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaUnidadeFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Cunii)
        ENDIF
    ENDPROC

    PROCEDURE TeclaCunif(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaUnidadeFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Cunif)
        ENDIF
    ENDPROC

    PROCEDURE TeclaLini(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaLinhaFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Lini)
        ENDIF
    ENDPROC

    PROCEDURE TeclaLinf(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaLinhaFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Linf)
        ENDIF
    ENDPROC

    PROCEDURE TeclaColi(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaColecaoFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Coli)
        ENDIF
    ENDPROC

    PROCEDURE TeclaColf(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaColecaoFiltro(THIS.pgf_4c_Paginas.Page1.txt_4c_Colf)
        ENDIF
    ENDPROC

    *-- Busca Grupo de Produto (SigCdGrp: cgrus/dgrus)
    PROCEDURE AbrirBuscaGrupoFiltro(par_oTxt)
        LOCAL loc_oBusca, loc_cCursor
        loc_cCursor = "cursor_4c_GrpFiltBusca"
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", loc_cCursor, "cgrus", ALLTRIM(par_oTxt.Value), ;
                "Grupo de Produto", .F., .F., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    par_oTxt.Value = ALLTRIM(cgrus)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *-- Busca Unidade (SigCdUni: cUnis/dUnis)
    PROCEDURE AbrirBuscaUnidadeFiltro(par_oTxt)
        LOCAL loc_oBusca, loc_cCursor
        loc_cCursor = "cursor_4c_UniFiltBusca"
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", loc_cCursor, "cUnis", ALLTRIM(par_oTxt.Value), ;
                "Unidade", .F., .F., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cUnis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    par_oTxt.Value = ALLTRIM(cUnis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *-- Busca Linha (SigCdLin: Linhas/Descs)
    PROCEDURE AbrirBuscaLinhaFiltro(par_oTxt)
        LOCAL loc_oBusca, loc_cCursor
        loc_cCursor = "cursor_4c_LinFiltBusca"
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", loc_cCursor, "Linhas", ALLTRIM(par_oTxt.Value), ;
                "Linha", .F., .F., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    par_oTxt.Value = ALLTRIM(Linhas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *-- Busca Grupo de Venda / Colecao (SigCdCol: Colecoes/Descs)
    PROCEDURE AbrirBuscaColecaoFiltro(par_oTxt)
        LOCAL loc_oBusca, loc_cCursor
        loc_cCursor = "cursor_4c_ColFiltBusca"
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", loc_cCursor, "Colecoes", ALLTRIM(par_oTxt.Value), ;
                "Grupo de Venda", .F., .F., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    par_oTxt.Value = ALLTRIM(Colecoes)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (continuacao Fase 4)
    * Forms CRUD tem Page1=Lista (grid+botoes CRUD) e Page2=Dados.
    * Forms REPORT tem apenas Page1=Filtros + cmg_4c_Botoes (top do form).
    * Os metodos abaixo traduzem a API CRUD para a estrutura REPORT, garantindo
    * que codigo generico (menu, tooling) que chama ConfigurarPaginaLista /
    * AlternarPagina funcione neste form de relatorio.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Alias REPORT para ConfigurarPaginaFiltros
    *   Em forms CRUD: configura Grid + botoes Incluir/Alterar/Excluir na Page1.
    *   Em forms REPORT: NAO existe grid de lista nem botoes CRUD - os controles
    *   da Page1 sao os filtros do relatorio. Os botoes do relatorio
    *   (Visualizar/Imprimir/Excel/Encerrar) ficam no cmg_4c_Botoes, montado em
    *   ConfigurarBotoes() (topo do form, FORA do PageFrame).
    *   IDEMPOTENTE: detecta se Page1 ja tem os controles de filtro montados
    *   (verifica txt_4c_CdGrEstoqueA criado em ConfigurarPaginaFiltros) e so
    *   delega quando ainda nao foi configurada - evita duplicar AddObject.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg, loc_lPrecisaConfigurar
        loc_lPrecisaConfigurar = .F.
        TRY
            DO WHILE .T.
                IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                    loc_lPrecisaConfigurar = .T.
                    EXIT
                ENDIF
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                IF !PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoqueA", 5)
                    loc_lPrecisaConfigurar = .T.
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF loc_lPrecisaConfigurar
            THIS.ConfigurarPaginaFiltros()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre paginas do PageFrame
    *   Em forms CRUD: alterna entre Page1 (Lista) e Page2 (Dados), ajustando
    *   estado dos botoes (AjustarBotoesPorModo) e recarregando lista quando
    *   volta para Page1.
    *   Em forms REPORT: PageFrame tem apenas 1 pagina (Filtros). O parametro
    *   eh validado contra PageCount e a unica pagina valida (Page1) eh ativada.
    *   Se receber valor invalido, mantem Page1 como ActivePage (comportamento
    *   defensivo - REPORT nao tem fluxo de troca de pagina).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_nPageCount
        TRY
            DO WHILE .T.
                IF VARTYPE(par_nPagina) != "N"
                    loc_nPagina = 1
                ELSE
                    loc_nPagina = par_nPagina
                ENDIF

                IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                    EXIT
                ENDIF

                loc_nPageCount = THIS.pgf_4c_Paginas.PageCount
                IF loc_nPagina < 1 OR loc_nPagina > loc_nPageCount
                    loc_nPagina = 1
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Override: forms REPORT nao tem grid de lista para carregar
    *   Em forms CRUD: executa SELECT na tabela e carrega cursor_4c_Dados no grid.
    *   Em forms REPORT: dados sao gerados sob demanda pelo BO (PrepararDados)
    *   ao clicar Visualizar/Imprimir/Excel. Retorna .T. para compatibilidade
    *   com codigo generico que verifica resultado de CarregarLista.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Override CRUD->REPORT (FASE 5/8)
    *   Em forms CRUD: cria Page2 com Labels, TextBoxes e botoes Salvar/Cancelar.
    *   Em forms REPORT: Page2 NAO existe - o form e FLAT (uma pagina de filtros).
    *   Todos os controles de entrada estao na Page1 (ConfigurarPaginaFiltros).
    *   Este override garante que, se FormBase ou codigo generico chamar
    *   ConfigurarPaginaDados(), a pagina de filtros seja configurada corretamente
    *   (idempotente - nao duplica controles ja existentes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Equivalente REPORT do botao Buscar do CRUD
    *   Em forms CRUD: abre FormBuscaAuxiliar para localizar registro no grid.
    *   Em forms REPORT: nao existe registro para buscar - delega para
    *   BtnVisualizarClick (gera preview com os filtros atuais).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * FASE 8 - METODOS CRUD -> REPORT (consolida" + CHR(231) + CHR(227) + "o final)
    *   Overrides dos metodos CRUD esperados pelo FormBase e codigo generico.
    *   Cada metodo traduz a semantica CRUD para a semantica REPORT.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Override CRUD->REPORT
    *   Em forms CRUD: copia campos do form para o BusinessObject.
    *   Em forms REPORT: delega para FormParaRelatorio (copia filtros para BO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Override CRUD->REPORT
    *   Em forms CRUD: copia propriedades do BO para os campos do form.
    *   Em forms REPORT: nao ha dados de registro para carregar - no-op.
    *   Os valores dos filtros sao gerenciados pelo proprio form (LimparCampos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Override CRUD->REPORT
    *   Em forms CRUD: habilita/desabilita campos conforme o modo (INCLUIR/ALTERAR).
    *   Em forms REPORT: os campos de filtro sao sempre editaveis - no-op.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Override CRUD->REPORT
    *   Em forms CRUD: habilita/desabilita botoes conforme this_cModoAtual.
    *   Em forms REPORT: botoes do CommandGroup sao sempre habilitados - no-op.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formul" + CHR(225) + "rio (alias de BtnSairClick)
    *   Pode ser chamado via BINDEVENT do cmg_4c_Botoes.Buttons(4) com Cancel=.T.
    *   ou diretamente por codigo generico. Delega para BtnSairClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Override CRUD->REPORT
    *   Em forms CRUD: executa Salvar (Inserir ou Atualizar) no BO.
    *   Em forms REPORT: nao ha registro para salvar - delega para Imprimir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Override CRUD->REPORT
    *   Em forms CRUD: descarta altera" + CHR(231) + CHR(245) + "es e volta para a lista.
    *   Em forms REPORT: restaura filtros para valores padr" + CHR(227) + "o (LimparCampos).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos ao fechar o formul" + CHR(225) + "rio
    *   CRITICO: usar this_oRelatorio = .NULL. (NAO .Release() - objeto Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
