*==============================================================================
* FormSigOpPck.prg - Atendimento Picking (OPERACIONAL)
* Migrado de SIGOPPCK.SCX
*
* Form OPERACIONAL de consulta/processamento (NAO segue o padrao CRUD
* Page1=Lista/Page2=Dados): o usuario escolhe um periodo, uma empresa e um
* criterio de Tipo de Operacao (grade de Tipos de Operacao OU campo de
* Movimentacao avulso, conforme o acesso do usuario) e filtra por Grande
* Grupo/Grupo de Produto na pagina de Filtros; o botao Consultar processa os
* movimentos do periodo e monta a grade de resultado (legado: crPgRes01) na
* pagina de Dados, usada para visualizacao, impressao e exportacao Excel.
*
* PageFrame com 2 paginas, abas OCULTAS (legado: pgfPrincipal.Tabs = .F.,
* Top = -2 - layout customizado, NAO o padrao CRUD Top=-29/compensacao +29):
*   Page1 pgFiltros - filtros de periodo/empresa/operacao + grades de
*                      selecao (Tipos de Operacao, Grande Grupo, Grupo de
*                      Produto) - tem a faixa do cabecalho (cntSombra)
*   Page2 pgDados   - PageFrame interno (pgResults, 1 pagina: pgRes01) com
*                      a grade de resultado (Detalhamento dos Produtos)
*
* Herda de: FormBase
* BO: SigOpPckBO (sem tabela/entidade CRUD propria - ver cabecalho do BO)
*
* Historico de fases:
*   Fase 1/2: SigOpPckBO.prg (propriedades, Init, CarregarDoCursor)
*   Fase 3:   FormSigOpPck.prg - estrutura base (heranca, Init, PageFrame
*             com as 2 paginas do legado)
*   Fase 4:   FormSigOpPck.prg - Page1 (pgFiltros) completa: faixa do
*             cabecalho, filtros de periodo/empresa/movimentacao, as
*             grades de Tipos de Operacao/Grande Grupo/Grupo de Produto
*             com os botoes Marcar/Desmarcar Tudo, o CommandGroup de acao
*             (Consultar/Sair) e AlternarPagina(). Nao segue o padrao
*             CRUD Page1=Lista (este form eh OPERACIONAL de consulta -
*             ver cabecalho do arquivo); a populacao via SQL das grades
*             de filtro (SigCdTom/SigCdGpr/SigCdGrp) e o processamento
*             dos movimentos ficam para fase posterior.
*   Fase 5/6: FormSigOpPck.prg - campos da Page1 (periodo/empresa/
*             movimentacao) e os lookups de Empresa (SigCdEmp) e
*             Operacao (SigCdOpe).
*   Fase 7:   FormSigOpPck.prg - eventos principais: Consultar (valida o
*             periodo e chama SigOpPckBO.Processar), Marcar/Desmarcar
*             Tudo das 3 grades de filtro, grade de resultado
*             (AfterRowColChange -> observacao/imagem do item), busca
*             posicional por numero de movimento, Cadastro do Produto,
*             Movimento de origem, Subniveis, Visualizar/Imprimir
*             (REPORT FORM SigOpPck) e Exportar XLS.
*   Fase 8:   FormSigOpPck.prg - consolidacao final: funis CarregarDados/
*             CarregarGradeResultado, hooks FormParaBO/BOParaForm (filtros
*             de periodo/empresa/movimentacao - o legado preenche
*             getDcI/getDcF com Date() no Init e este form nunca o fazia),
*             persistencia do layout da grade de resultado por usuario
*             (AcertaColunas LER/GRAVAR + SigSyPar, substituindo o
*             poSigSyPar/fGravaUserXML do Framework legado), GradePadrao(),
*             ocultar coluna arrastada a largura 0 (Column<N>.Resize),
*             ordem das colunas (ColumnOrder do SCX), DynamicFontBold e a
*             Pesquisa Global de Produtos (Column7.Text1.DblClick).
*
* Metodos do SCX legado DELIBERADAMENTE nao migrados (codigo morto no
* proprio legado - regra #17 do CLAUDE.md, transcrever o que o legado FAZ):
*   BuscaAntigos() / LimpaEmps()  - os unicos call sites estao COMENTADOS
*                                   (*!*) no metodo Processamento
*   GerarTXT() / fLimpa()         - GerarTXT nao tem NENHUM call site (nao
*                                   existe botao de TXT no SCX) e fLimpa so
*                                   eh usada por ele
*   AcessoEmpresas(pCur)          - alimentava fAcessoEmpresa/fAcessoMovmto
*                                   (funcoes globais Fortyus nao portadas);
*                                   este form usa lookup proprio via
*                                   FormBuscaAuxiliar
*==============================================================================

DEFINE CLASS FormSigOpPck AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - valores exatos do SCX original)
    *--------------------------------------------------------------------------
    Width        = 1300
    Height       = 700
    DataSession  = 2
    BorderStyle  = 2
    AutoCenter   = .T.
    Caption      = "Atendimento Picking"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    SizeBox      = .F.
    ZoomBox      = .F.
    Themes       = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Business Object (ja declarada em FormBase - this_oBusinessObject)
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Controle de pagina ativa: FILTROS / DADOS (FormBase declara
    * this_cModoAtual = "LISTA" por default; este form nao eh CRUD)
    *--------------------------------------------------------------------------
    this_cModoAtual = "FILTROS"

    *--------------------------------------------------------------------------
    * Guardas de reentrancia dos lookups de Empresa/Operacao (regra #37/#47
    * do CLAUDE.md - o picker eh MODAL e redispara o proprio LostFocus ao
    * tirar/devolver o foco; sem a guarda abriria um segundo dialogo).
    *--------------------------------------------------------------------------
    this_lEmLookupEmpresa  = .F.
    this_lEmLookupOperacao = .F.

    *--------------------------------------------------------------------------
    * Guardas de "valor nao mudou" dos lookups de Empresa/Operacao: no legado
    * o Valid so dispara quando o controle MUDA de valor, mas LostFocus
    * dispara SEMPRE que o foco sai do campo (ex.: Tab sem digitar nada
    * novo) - sem esta guarda o lookup reabriria/reconsultaria a cada saida
    * do campo, mesmo com o valor ja validado.
    *--------------------------------------------------------------------------
    this_cUltimoValidarEmpOsLostFocusValidado      = ""
    this_cUltimoValidarOperacaoLostFocusValidado   = ""

    *--------------------------------------------------------------------------
    * Init - Chama FormBase.Init() que dispara InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura base
    * (PageFrame com as 2 paginas do legado). Grades, filtros e botoes sao
    * adicionados nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpPckBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpPckBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarEventosPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarEventosPaginaDados()

                *-- Popula Empresa/this_lAcessoPorTipo e as 3 grades de
                *-- filtro a partir do banco (legado: bloco do Init do SCX -
                *-- ver cabecalho de SigOpPckBO.CarregarFiltros). Pulado em
                *-- modo de validacao de UI (sem conexao SQL real).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.this_oBusinessObject.CarregarFiltros()
                        MsgErro("Erro ao carregar os filtros da tela.", "Erro")
                    ENDIF

                    *-- Layout salvo da grade de resultado por usuario
                    *-- (legado: .poSigSyPar.mLerCfg(), objeto fGravaUserXML
                    *-- do Framework NAO portado - substituido por SigSyPar
                    *-- via SQL, mesmo padrao de FormSIGOPCGF).
                    THIS.this_oBusinessObject.CarregarCfgGrade()
                ENDIF

                *-- Espelha os filtros do BO na tela. FORA do IF acima de
                *-- proposito: inclui getDcI/getDcF = Date(), que o Init do
                *-- legado preenche sempre (codigo_fonte.txt:2792-2793) e que
                *-- nao depende de SQL - os defaults ja vem do
                *-- SigOpPckBO.Init.
                THIS.BOParaForm()
                THIS.AtualizarFiltrosNaTela()

                *-- Aplica o layout lido acima as colunas da grade de
                *-- resultado (legado: MontaGrades termina em
                *-- ThisForm.AcertaColunas([LER])).
                THIS.AcertaColunas("LER")

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "FILTROS"

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame com as 2 paginas do legado.
    * Top/Width/Height EXATOS do dump (SigOpPck_form_codigo_fonte.txt:510-535):
    * abas ocultas (Tabs = .F.) com layout customizado - NAO eh o padrao CRUD
    * Top=-29/compensacao +29 de frmcadastro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -2
            .Left      = 0
            .Width     = 1301
            .Height    = 705
            .PageCount = 2
            .Tabs      = .F.
            *-- TabStyle do SCX NAO eh transcrita: eh READ-ONLY em runtime no
            *-- VFP9 ("Property TABSTYLE is read-only") - mesma situacao da
            *-- BorderWidth anotada abaixo. Com as abas ocultas (Tabs = .F.)
            *-- o estilo de aba nao tem efeito visual nenhum.
            .Visible   = .F.
            *-- ErasePage do SCX NAO foi transcrita: PageFrame nao tem essa
            *-- propriedade no runtime do VFP9 - medido em 2026-11-13 com
            *-- automation\_probeErasePage783.prg (PEMSTATUS devolve .F. e a
            *-- atribuicao estoura "Property ERASEPAGE is not found."). Eh
            *-- propriedade de tempo de PROJETO, gravada no SCX pelo Form
            *-- Designer, da mesma familia de ZOrderSet/ShapeType da regra
            *-- #33 do CLAUDE.md: transcreve-la derrubava o Init DENTRO do
            *-- TRY de InicializarForm e a tela nao abria (CREATEOBJECT
            *-- devolvia .F. e o menu nao fazia nada).
            *-- PageFrame.BorderWidth eh READ-ONLY em runtime ("Property
            *-- BORDERWIDTH is read-only") e o SCX legado nao a declara
            *-- com valor diferente do default - nao atribuir.

            .Page1.Caption   = ""
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.FontName  = "Verdana"
            .Page1.FontSize  = 8
            .Page1.ForeColor = RGB(36, 84, 155)

            *-- Page2.Caption = "s" no dump legado eh resto de placeholder
            *-- de template (as abas estao ocultas - Tabs = .F. - a
            *-- caption nunca eh exibida); nao transcrever o lixo.
            .Page2.Caption   = ""
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.FontName  = "Verdana"
            .Page2.FontSize  = 8
            .Page2.ForeColor = RGB(36, 84, 155)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta TODO o conteudo da Page1 (pgFiltros):
    * faixa do cabecalho, filtros de periodo/empresa/movimentacao, a grade
    * de Tipos de Operacao (ou o campo de Movimentacao avulso, conforme o
    * acesso do usuario - this_lAcessoPorTipo), as grades de Grande Grupo e
    * Grupo de Produto com os botoes Marcar/Desmarcar Tudo, e o
    * CommandGroup de acao (Consultar/Sair). NAO segue o padrao CRUD
    * Page1=Lista: este form eh OPERACIONAL de consulta/processamento (ver
    * cabecalho do arquivo) - Page1 eh a pagina de FILTROS, nao uma lista
    * de registros.
    *
    * As 3 grades sao ligadas a cursores PLACEHOLDER (estrutura final, sem
    * linhas) - regra #41 do CLAUDE.md: Column.ControlSource de cursor
    * inexistente derruba o Init. A populacao real via SQL (SigCdTom/
    * SigCdGpr/SigCdGrp) fica para fase posterior (CarregarFiltros() no BO
    * - ver cabecalho de SigOpPckBO.prg).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_lAcessoPorTipo

        loc_oPag           = THIS.pgf_4c_Paginas.Page1
        loc_lAcessoPorTipo = THIS.this_oBusinessObject.this_lAcessoPorTipo

        THIS.CriarCursoresFiltroPlaceholder()

        *-- Faixa do cabecalho (legado: cntSombra) - regra #11, PRIMEIRO
        *-- AddObject da pagina. AddObject do filho e o WITH que configura
        *-- suas propriedades ficam FORA do WITH do container (regra #44 -
        *-- WITH aninhado com .AddObject + WITH .filho dentro ignora
        *-- propriedades em silencio).
        loc_oPag.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPag.cnt_4c_Sombra
            .Top         = 2
            .Left        = 0
            .Width       = 1308
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oPag.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .Top           = 25
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.this_oBusinessObject.this_cCaption
            .Visible       = .T.
        ENDWITH

        loc_oPag.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oPag.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .AutoSize    = .F.
            .Alignment   = 0
            .BackStyle   = 0
            .Top         = 24
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.this_oBusinessObject.this_cCaption
            .Visible     = .T.
        ENDWITH

        *-- Periodo (legado: Say1/getDcI/Label2/getDcF)
        loc_oPag.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPag.lbl_4c_Periodo
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Left      = 260
            .Top       = 166
            .Width     = 60
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "odo :"
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DcI", "TextBox")
        WITH loc_oPag.txt_4c_DcI
            .FontName      = "Tahoma"
            .Left          = 309
            .Top           = 162
            .Width         = 100
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "Data Inicial de Filtro"
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPag.lbl_4c_Ate
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Left      = 395
            .Top       = 166
            .Width     = 18
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "at" + CHR(233)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DcF", "TextBox")
        WITH loc_oPag.txt_4c_DcF
            .FontName      = "Tahoma"
            .Left          = 420
            .Top           = 162
            .Width         = 100
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "Data Final de Filtro"
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Empresa (legado: Say4/getEmpOs/getDEmpOs)
        loc_oPag.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPag.lbl_4c_Empresa
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .Alignment  = 0
            .Left       = 255
            .Top        = 193
            .Width      = 60
            .Height     = 15
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Empresa :"
            .Visible    = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_EmpOs", "TextBox")
        WITH loc_oPag.txt_4c_EmpOs
            .FontName      = "Tahoma"
            .Left          = 309
            .Top           = 189
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DEmpOs", "TextBox")
        WITH loc_oPag.txt_4c_DEmpOs
            .FontName      = "Tahoma"
            .Left          = 343
            .Top           = 189
            .Width         = 290
            .Height        = 23
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Movimentacao - campo avulso, visivel so quando o usuario NAO
        *-- tem acesso por Tipo de Operacao (legado: Say2/getOperacao)
        loc_oPag.AddObject("lbl_4c_Movimentacao", "Label")
        WITH loc_oPag.lbl_4c_Movimentacao
            .FontName  = "Tahoma"
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Left      = 227
            .Top       = 219
            .Width     = 94
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oPag.txt_4c_Operacao
            .FontName      = "Tahoma"
            .Left          = 309
            .Top           = 215
            .Width         = 183
            .Height        = 23
            .MaxLength     = 20
            .Format        = "!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Tipo de Operacao - grade, visivel so quando o usuario TEM
        *-- acesso por Tipo de Operacao (legado: Label1/grdTipo/btnMarca/
        *-- btnDesmarca)
        loc_oPag.AddObject("lbl_4c_TipoOperacao", "Label")
        WITH loc_oPag.lbl_4c_TipoOperacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .WordWrap  = .F.
            .BackStyle = 0
            .Alignment = 0
            .Left      = 211
            .Top       = 244
            .Width     = 94
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("grd_4c_Tipo", "Grid")
        THIS.ConfigurarGradeFiltro(loc_oPag.grd_4c_Tipo, THIS.this_oBusinessObject.this_cCursorTipos, ;
            309, 241, 387, 323, 282, "Tipos")

        loc_oPag.AddObject("cmd_4c_BtnMarca", "CommandButton")
        THIS.ConfigurarBotaoMarcar(loc_oPag.cmd_4c_BtnMarca, 636, 352, "Selecionar Tudo")

        loc_oPag.AddObject("cmd_4c_BtnDesmarca", "CommandButton")
        THIS.ConfigurarBotaoDesmarcar(loc_oPag.cmd_4c_BtnDesmarca, 636, 397, "Desmarcar Tudo")

        *-- Grande Grupo (legado: grdMercs/btnMarGde/btnDesGde)
        loc_oPag.AddObject("grd_4c_GrdGpr", "Grid")
        THIS.ConfigurarGradeFiltro(loc_oPag.grd_4c_GrdGpr, THIS.this_oBusinessObject.this_cCursorGrdGpr, ;
            720, 218, 195, 323, 283, "Grande Grupo")

        loc_oPag.AddObject("cmd_4c_BtnMarGde", "CommandButton")
        THIS.ConfigurarBotaoMarcar(loc_oPag.cmd_4c_BtnMarGde, 1046, 268, "Selecionar")

        loc_oPag.AddObject("cmd_4c_BtnDesGde", "CommandButton")
        THIS.ConfigurarBotaoDesmarcar(loc_oPag.cmd_4c_BtnDesGde, 1046, 313, "Desmarcar")

        *-- Grupo de Produto - 3 colunas (legado: grdCGrus/btnMarGrp/btnDesGrp).
        *-- WITH das Columns fica FORA do WITH do grid (regra #44 - nested
        *-- WITH com .AddObject dentro ignora propriedades em silencio;
        *-- Column1/2/3 seguem o mesmo padrao seguro de ConfigurarGrdP1/P2
        *-- em Formsigrepes.prg).
        loc_oPag.AddObject("grd_4c_GrdGru", "Grid")
        WITH loc_oPag.grd_4c_GrdGru
            .RecordSource   = THIS.this_oBusinessObject.this_cCursorGrdGru
            .ColumnCount    = 3
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .RecordMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .Left           = 720
            .Top            = 426
            .Height         = 195
            .Width          = 323
            .ForeColor      = RGB(0, 0, 0)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
        ENDWITH

        WITH loc_oPag.grd_4c_GrdGru.Column1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Width     = 18
            .Enabled   = .T.
            .Sparse    = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption   = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 2
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 17
            .CurrentControl  = "Check1"
            .ControlSource   = THIS.this_oBusinessObject.this_cCursorGrdGru + ".nMarcas"
            .Header1.Caption = ""
        ENDWITH

        WITH loc_oPag.grd_4c_GrdGru.Column2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 30
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .ControlSource     = THIS.this_oBusinessObject.this_cCursorGrdGru + ".Mercs"
            .Header1.Alignment = 2
            .Header1.Caption   = "Gde"
        ENDWITH

        WITH loc_oPag.grd_4c_GrdGru.Column3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 252
            .ForeColor         = RGB(0, 0, 0)
            .ControlSource     = THIS.this_oBusinessObject.this_cCursorGrdGru + ".CDescricaos"
            .Header1.Alignment = 2
            .Header1.Caption   = "Grupo de Produto"
        ENDWITH

        loc_oPag.AddObject("cmd_4c_BtnMarGrp", "CommandButton")
        THIS.ConfigurarBotaoMarcar(loc_oPag.cmd_4c_BtnMarGrp, 1046, 477, "Selecionar")

        loc_oPag.AddObject("cmd_4c_BtnDesGrp", "CommandButton")
        THIS.ConfigurarBotaoDesmarcar(loc_oPag.cmd_4c_BtnDesGrp, 1046, 522, "Desmarcar")

        *-- CommandGroup de acao: Consultar / Sair (legado: cmgFiltros)
        loc_oPag.AddObject("obj_4c_CmgFiltros", "CommandGroup")
        WITH loc_oPag.obj_4c_CmgFiltros
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Top           = 0
            .Left          = 1135
            .Width         = 173
            .Height        = 110
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 11
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .Caption     = "Consultar"
                .ToolTipText = "Consultar Usando os Filtros Informados"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top         = 5
                .Left        = 87
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "Sair"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH
        ENDWITH

        *-- Layout salvo da grade de resultado - so visivel para o usuario
        *-- 4CONTROL (legado: getCfgGrade.Visible = (Usuar = '4CONTROL'))
        loc_oPag.AddObject("txt_4c_CfgGrade", "TextBox")
        WITH loc_oPag.txt_4c_CfgGrade
            .Height        = 23
            .Left          = 1
            .Top           = 660
            .Width         = 1297
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) == "4CONTROL")
        ENDWITH

        *-- Visibilidade condicional ao acesso do usuario (regra do legado:
        *-- Not fChecaAcesso('SIGOPPCK','CONPORTIPO') And Usuar <> '4CONTROL'
        *-- esconde a grade de Tipos e mostra o campo avulso de Movimentacao)
        loc_oPag.lbl_4c_Movimentacao.Visible = !loc_lAcessoPorTipo
        loc_oPag.txt_4c_Operacao.Visible     = !loc_lAcessoPorTipo
        loc_oPag.lbl_4c_TipoOperacao.Visible = loc_lAcessoPorTipo
        loc_oPag.grd_4c_Tipo.Visible         = loc_lAcessoPorTipo
        loc_oPag.cmd_4c_BtnMarca.Visible     = loc_lAcessoPorTipo
        loc_oPag.cmd_4c_BtnDesmarca.Visible  = loc_lAcessoPorTipo
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresFiltroPlaceholder - Cria, com a estrutura final (sem
    * linhas), os cursores que alimentam as 3 grades de filtro da Page1. A
    * populacao real via SQL (SigCdTom/SigCdGpr/SigCdGrp) fica para fase
    * posterior (CarregarFiltros() no BO) - sem o placeholder aqui, ligar
    * Column.ControlSource a um cursor inexistente derruba o Init (regra
    * #41 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresFiltroPlaceholder()
        LOCAL loc_cCursorTipos, loc_cCursorGrdGpr, loc_cCursorGrdGru

        loc_cCursorTipos  = THIS.this_oBusinessObject.this_cCursorTipos
        loc_cCursorGrdGpr = THIS.this_oBusinessObject.this_cCursorGrdGpr
        loc_cCursorGrdGru = THIS.this_oBusinessObject.this_cCursorGrdGru

        IF USED(loc_cCursorTipos)
            USE IN (loc_cCursorTipos)
        ENDIF
        CREATE CURSOR (loc_cCursorTipos) (nMarcas N(1,0), CCodigos C(2), CDescricaos C(50))

        IF USED(loc_cCursorGrdGpr)
            USE IN (loc_cCursorGrdGpr)
        ENDIF
        CREATE CURSOR (loc_cCursorGrdGpr) (nMarcas N(1,0), Codigos C(3), CDescricaos C(50))

        IF USED(loc_cCursorGrdGru)
            USE IN (loc_cCursorGrdGru)
        ENDIF
        CREATE CURSOR (loc_cCursorGrdGru) (nMarcas N(1,0), Mercs C(3), Codigos C(3), CDescricaos C(50))
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeFiltro - Helper para as grades de filtro de 2 colunas
    * (Check + Descricao): Tipos de Operacao (grdTipo) e Grande Grupo
    * (grdMercs). Padrao canonico: Column1 = CheckBox ligado a "nMarcas"
    * (regra #18 - AddObject + CurrentControl + Sparse = .F.), Column2 =
    * descricao combinada codigo-descricao (ReadOnly). Referencia:
    * Formsigrepes.prg ConfigurarGrdP2.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeFiltro(par_oGrd, par_cCursor, par_nLeft, par_nTop, ;
            par_nHeight, par_nWidth, par_nCol2Width, par_cCaptionCol2)

        WITH par_oGrd
            .RecordSource   = par_cCursor
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .RecordMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 16
            .RowHeight      = 16
            .ScrollBars     = 2
            .TabStop        = .F.
            .Left           = par_nLeft
            .Top            = par_nTop
            .Height         = par_nHeight
            .Width          = par_nWidth
            .ForeColor      = RGB(0, 0, 0)
            .GridLineColor  = RGB(238, 238, 238)
            .Themes         = .F.
            .Visible        = .T.
        ENDWITH

        *-- WITH das Columns FORA do WITH do grid (regra #44 - nested WITH
        *-- com .AddObject dentro ignora propriedades em silencio)
        WITH par_oGrd.Column1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Width     = 18
            .Enabled   = .T.
            .Sparse    = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Caption   = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 2
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 17
            .CurrentControl  = "Check1"
            .ControlSource   = par_cCursor + ".nMarcas"
            .Header1.Caption = ""
        ENDWITH

        WITH par_oGrd.Column2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = par_nCol2Width
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .ControlSource     = par_cCursor + ".CDescricaos"
            .Header1.Alignment = 2
            .Header1.Caption   = par_cCaptionCol2
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoMarcar / ConfigurarBotaoDesmarcar - Helpers para os
    * botoes "Selecionar"/"Desmarcar Tudo" ao lado de cada grade de filtro
    * (legado: btnMarca/btnMarGde/btnMarGrp e btnDesmarca/btnDesGde/
    * btnDesGrp - mesmo icone/propriedades nos 3 pares).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoMarcar(par_oBtn, par_nLeft, par_nTop, par_cToolTip)
        WITH par_oBtn
            .Top         = par_nTop
            .Left        = par_nLeft
            .Height      = 45
            .Width       = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = par_cToolTip
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarBotaoDesmarcar(par_oBtn, par_nLeft, par_nTop, par_cToolTip)
        WITH par_oBtn
            .Top         = par_nTop
            .Left        = par_nLeft
            .Height      = 45
            .Width       = 45
            .FontName    = "Arial"
            .FontSize    = 7
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = par_cToolTip
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosPaginaLista - BINDEVENT dos botoes de Marcar/
    * Desmarcar Tudo das 3 grades de filtro e do CommandGroup de acao
    * (Consultar/Sair).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosPaginaLista()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        BINDEVENT(loc_oPag.cmd_4c_BtnMarca,    "Click", THIS, "BtnMarcaClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesmarca, "Click", THIS, "BtnDesmarcaClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnMarGde,   "Click", THIS, "BtnMarGdeClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesGde,   "Click", THIS, "BtnDesGdeClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnMarGrp,   "Click", THIS, "BtnMarGrpClick")
        BINDEVENT(loc_oPag.cmd_4c_BtnDesGrp,   "Click", THIS, "BtnDesGrpClick")

        BINDEVENT(loc_oPag.obj_4c_CmgFiltros.Buttons(1), "Click", THIS, "BtnConsultarClick")
        BINDEVENT(loc_oPag.obj_4c_CmgFiltros.Buttons(2), "Click", THIS, "BtnSairClick")

        *-- Lookup de Empresa (legado: getEmpOs.Valid/getDEmpOs.Valid =
        *-- fAcessoEmpresa - funcao NAO portada; substituicao canonica via
        *-- FormBuscaAuxiliar em SigCdEmp - regra #47: LostFocus valida,
        *-- F4 abre o picker direto)
        BINDEVENT(loc_oPag.txt_4c_EmpOs, "LostFocus", THIS, "ValidarEmpOsLostFocus")
        BINDEVENT(loc_oPag.txt_4c_EmpOs, "KeyPress",  THIS, "EmpOsKeyPress")

        *-- Lookup de Operacao/Movimentacao (legado: getOperacao.Valid =
        *-- fAcessoMovmto - funcao NAO portada; SigCdOpe eh single-column,
        *-- Dopes eh PK e descricao ao mesmo tempo)
        BINDEVENT(loc_oPag.txt_4c_Operacao, "LostFocus", THIS, "ValidarOperacaoLostFocus")
        BINDEVENT(loc_oPag.txt_4c_Operacao, "KeyPress",  THIS, "OperacaoKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFiltrosNaTela - Reaplica a visibilidade do criterio de Tipo
    * de Operacao (grade de Tipos x campo avulso de Movimentacao) com o
    * valor REAL de this_lAcessoPorTipo, ja resolvido por CarregarFiltros
    * (que roda DEPOIS de ConfigurarPaginaLista - a visibilidade inicial
    * configurada ali usa o default .F. da property, ver cabecalho do BO),
    * preenche o campo de Empresa com o default carregado e repinta as 3
    * grades de filtro ja populadas (regra #21 do CLAUDE.md - popular
    * cursor nao repinta a grade sozinho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarFiltrosNaTela()
        LOCAL loc_oPag, loc_oBO, loc_lAcessoPorTipo

        loc_oPag           = THIS.pgf_4c_Paginas.Page1
        loc_oBO            = THIS.this_oBusinessObject
        loc_lAcessoPorTipo = loc_oBO.this_lAcessoPorTipo

        loc_oPag.lbl_4c_Movimentacao.Visible = !loc_lAcessoPorTipo
        loc_oPag.txt_4c_Operacao.Visible     = !loc_lAcessoPorTipo
        loc_oPag.lbl_4c_TipoOperacao.Visible = loc_lAcessoPorTipo
        loc_oPag.grd_4c_Tipo.Visible         = loc_lAcessoPorTipo
        loc_oPag.cmd_4c_BtnMarca.Visible     = loc_lAcessoPorTipo
        loc_oPag.cmd_4c_BtnDesmarca.Visible  = loc_lAcessoPorTipo

        *-- Os valores dos campos de filtro ficam em BOParaForm() (fonte
        *-- unica) - aqui so a visibilidade condicional e o repintar das
        *-- grades.
        IF USED(loc_oBO.this_cCursorTipos)
            GO TOP IN (loc_oBO.this_cCursorTipos)
        ENDIF
        loc_oPag.grd_4c_Tipo.Refresh()

        IF USED(loc_oBO.this_cCursorGrdGpr)
            GO TOP IN (loc_oBO.this_cCursorGrdGpr)
        ENDIF
        loc_oPag.grd_4c_GrdGpr.Refresh()

        IF USED(loc_oBO.this_cCursorGrdGru)
            GO TOP IN (loc_oBO.this_cCursorGrdGru)
        ENDIF
        loc_oPag.grd_4c_GrdGru.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Monta a METADE INICIAL do conteudo da Page2
    * (pgDados): o PageFrame interno pgResults (legado, 1 pagina - pgRes01,
    * Caption "Detalhamento dos Produtos"), a grade de resultado
    * (grdDados1, 16 colunas - ControlSource transcrito EXATO do metodo
    * Processamento do legado, SigOpPck_form_codigo_fonte.txt:2509-2526;
    * Header/Width/cor de cada coluna do dump de propriedades, :1288-1390
    * e :1405-1780) e o painel de observacao do item (Say3/getObsItn) com
    * a imagem do produto (ImgFigJpg). A segunda metade (campo de busca,
    * botoes da pagina de resultado - btnRestaurar/btnProduto/cmdOperacao/
    * SubNiveis - e os botoes de Retornar/Visualizar/Excel/Imprimir do
    * nivel pgDados) fica para a fase seguinte.
    *
    * O cursor placeholder (cursor_4c_Dados) tem de existir ANTES do
    * ControlSource da grade ser atribuido - regra #41 do CLAUDE.md
    * (Column.ControlSource de cursor inexistente derruba o Init). A
    * populacao real via SQL (processamento dos movimentos filtrados)
    * fica para fase posterior (Processar() no BO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_cCursor

        loc_oPag    = THIS.pgf_4c_Paginas.Page2
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        THIS.CriarCursorDadosPlaceholder()

        *-- PageFrame interno (legado: pgResults, 1 pagina - pgRes01)
        loc_oPag.AddObject("pgf_4c_Resultados", "PageFrame")
        WITH loc_oPag.pgf_4c_Resultados
            .Top       = 2
            .Left      = -1
            .Width     = 1304
            .Height    = 600
            .PageCount = 1
            .Tabs      = .F.

            .Page1.FontName  = "Tahoma"
            .Page1.FontSize  = 8
            .Page1.Caption   = "Detalhamento dos Produtos"
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- AddObject do filho e o WITH que o configura ficam FORA do WITH
        *-- do pai (regra #44 - WITH aninhado com .AddObject dentro ignora
        *-- propriedades em silencio).
        loc_oPag.pgf_4c_Resultados.Page1.AddObject("grd_4c_Dados", "Grid")
        THIS.ConfigurarGrdDados(loc_oPag.pgf_4c_Resultados.Page1.grd_4c_Dados, loc_cCursor)

        loc_oPag.pgf_4c_Resultados.Page1.AddObject("lbl_4c_ObsItem", "Label")
        WITH loc_oPag.pgf_4c_Resultados.Page1.lbl_4c_ObsItem
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Left      = 6
            .Top       = 4
            .Width     = 100
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do " + CHR(205) + "tem"
            .Visible   = .T.
        ENDWITH

        loc_oPag.pgf_4c_Resultados.Page1.AddObject("edt_4c_ObsItem", "EditBox")
        WITH loc_oPag.pgf_4c_Resultados.Page1.edt_4c_ObsItem
            .FontName          = "Tahoma"
            .Left              = 5
            .Top               = 20
            .Width             = 312
            .Height            = 250
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .NullDisplay       = "  "
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Imagem do produto - oculta por default (legado: ImgFigJpg.
        *-- Visible = .F.; so aparece ao carregar a linha corrente da
        *-- grade - comportamento fica para fase posterior)
        loc_oPag.pgf_4c_Resultados.Page1.AddObject("img_4c_FigProduto", "Image")
        WITH loc_oPag.pgf_4c_Resultados.Page1.img_4c_FigProduto
            .Stretch     = 1
            .Left        = 327
            .Top         = 1
            .Width       = 695
            .Height      = 318
            .Picture     = ""
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
            .Visible     = .F.
        ENDWITH

        *-- Campo de busca por numero do movimento na grade (legado:
        *-- Say2/getBusca - digita o numero e pressiona ENTER para localizar
        *-- a linha na grade, sem abrir picker: eh busca POSICIONAL dentro
        *-- do cursor ja carregado, nao lookup de tabela)
        loc_oPag.pgf_4c_Resultados.Page1.AddObject("lbl_4c_BuscaCodigo", "Label")
        WITH loc_oPag.pgf_4c_Resultados.Page1.lbl_4c_BuscaCodigo
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .AutoSize   = .F.
            .BackStyle  = 0
            .Alignment  = 0
            .Left       = 5
            .Top        = 276
            .Width      = 70
            .Height     = 15
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Buscar C" + CHR(243) + "digo"
            .Visible    = .T.
        ENDWITH

        loc_oPag.pgf_4c_Resultados.Page1.AddObject("txt_4c_Busca", "TextBox")
        WITH loc_oPag.pgf_4c_Resultados.Page1.txt_4c_Busca
            .FontName      = "Tahoma"
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 5
            .MaxLength     = 3
            .SpecialEffect = 1
            .ToolTipText   = "Para Procurar um C" + CHR(243) + "digo Digite Aqui e Pressione [ENTER]"
            .Top           = 292
            .Width         = 82
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 240)
            .Visible       = .T.
        ENDWITH

        *-- Botao Restaurar Grade (legado: btnRestaurar - restaura colunas
        *-- ocultas/largura da grade de resultado para o padrao original)
        loc_oPag.pgf_4c_Resultados.Page1.AddObject("cmd_4c_BtnRestaurar", "CommandButton")
        WITH loc_oPag.pgf_4c_Resultados.Page1.cmd_4c_BtnRestaurar
            .Top         = 94
            .Left        = 1045
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
            .Caption     = "Restaurar Grade"
            .ToolTipText = "Restaura as Colunas da Grade Para o Padr" + CHR(227) + "o Original"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- Botao Cadastro (legado: btnProduto - abre o Cadastro de Produtos
        *-- para o item da linha corrente da grade)
        loc_oPag.pgf_4c_Resultados.Page1.AddObject("cmd_4c_BtnProduto", "CommandButton")
        WITH loc_oPag.pgf_4c_Resultados.Page1.cmd_4c_BtnProduto
            .Top         = 94
            .Left        = 1121
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
            .Caption     = "Cadastro"
            .ToolTipText = "Cadastro do Produto"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- CommandGroup "Movimento" (legado: cmdOperacao/btnOperacao - abre
        *-- o movimento de origem do item - SigMvExp/SigMvPdt conforme a
        *-- operacao seja de Pedido ou Devolucao)
        loc_oPag.pgf_4c_Resultados.Page1.AddObject("obj_4c_CmdOperacao", "CommandGroup")
        WITH loc_oPag.pgf_4c_Resultados.Page1.obj_4c_CmdOperacao
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 169
            .Left        = 1121
            .Width       = 80
            .Height      = 100
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top         = 0
                .Left        = 0
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
                .Caption     = "Movimento"
                .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH
        ENDWITH

        *-- Botao Subniveis (legado: SubNiveis - abre a tela de Subniveis do
        *-- movimento/item corrente)
        loc_oPag.pgf_4c_Resultados.Page1.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH loc_oPag.pgf_4c_Resultados.Page1.cmd_4c_SubNiveis
            .Top         = 169
            .Left        = 1197
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
            .Caption     = "\<Subn" + CHR(237) + "veis"
            .ToolTipText = "Subn" + CHR(237) + "veis"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- CommandGroup "Retornar" (legado: cmgRetornar/btnRetornar - volta
        *-- para a pagina de Filtros, nivel da Page2 pgDados - NAO dentro do
        *-- PageFrame interno pgResults)
        loc_oPag.AddObject("obj_4c_CmgRetornar", "CommandGroup")
        WITH loc_oPag.obj_4c_CmgRetornar
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Top           = 44
            .Left          = 1197
            .Width         = 79
            .Height        = 99
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top         = 0
                .Left        = 0
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Cancel      = .T.
                .Caption     = "Retornar"
                .ToolTipText = "Retornar aos Filtros"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH
        ENDWITH

        *-- Botao Visualizar (legado: btnVisualizar - preview do REPORT FORM
        *-- SigOpPck, ordenado por SubGrupo + Codigo_Item)
        loc_oPag.AddObject("cmd_4c_BtnVisualizar", "CommandButton")
        WITH loc_oPag.cmd_4c_BtnVisualizar
            .Top             = 44
            .Left            = 1121
            .Height          = 75
            .Width           = 75
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_video_60.jpg"
            .Caption         = "Visualizar"
            .ToolTipText     = "Gerar TXT Tabulado PAra Importa" + CHR(231) + CHR(227) + "o em Excel"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Exporta XLS (legado: btnExcel)
        loc_oPag.AddObject("cmd_4c_BtnExcel", "CommandButton")
        WITH loc_oPag.cmd_4c_BtnExcel
            .Top             = 120
            .Left            = 1197
            .Height          = 75
            .Width           = 75
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
            .Caption         = "Exporta XLS"
            .ToolTipText     = "Gerar Arquivo XLS "
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Imprimir (legado: BtnImprimir - imprime o REPORT FORM
        *-- SigOpPck direto na impressora, com prompt)
        loc_oPag.AddObject("cmd_4c_BtnImprimir", "CommandButton")
        WITH loc_oPag.cmd_4c_BtnImprimir
            .Top             = 44
            .Left            = 1045
            .Height          = 75
            .Width           = 75
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Caption         = "Imprimir"
            .ToolTipText     = "Gerar TXT Tabulado PAra Importa" + CHR(231) + CHR(227) + "o em Excel"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorDadosPlaceholder - Cria, com a estrutura final (sem
    * linhas), o cursor que alimenta a grade de resultado (grdDados1,
    * legado: crPgRes01 - "Detalhamento dos Produtos"). Colunas EXATAS do
    * Create Cursor do legado (SigOpPck_form_codigo_fonte.txt:2761-2770),
    * na MESMA ordem - regra do CLAUDE.md sobre CREATE CURSOR repetido em
    * mais de um local (aqui so ha este, mas a ordem tem de casar com as
    * propriedades this_Res* do BO, que leem/escrevem por NOME de coluna
    * via EVALUATE em CarregarDoCursor). A populacao real fica para fase
    * posterior (Processar() no BO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorDadosPlaceholder()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        CREATE CURSOR (loc_cCursor) ( ;
            Ordem C(1), Filtro N(1,0), Empresa C(3), Movimentacao C(20), Numero N(6,0), ;
            Data_Venda D, Codigo_Vendedora C(10), Item N(10,0), Codigo_Item C(14), ;
            Desc_Item C(40), Obs_Item M, Quantidade N(16,2), Val_Unitario N(16,2), ;
            Total N(16,2), Total_Geral N(16,2), Moeda C(3), Operacao C(1), Barras N(14,0), ;
            Gde_Grupo C(3), Grupo C(3), SubGrupo C(60), Custo_Cadastro N(16,2), ;
            Moe_Cus_Cadastro C(3), Markup N(16,2), Venda_Cadastro N(16,2), Moe_Vda_Cadastro C(3), ;
            Imagem M, Tamanho C(4), Cor C(4), Cod_Cliente C(10), Nome_Cliente C(50), ;
            Cod_Fornecedor C(10), Nome_Fornecedor C(50), Tkt_Medio N(16,2), Ref_Fornecedor C(20), ;
            Valor_Diferenca N(16,2), Perc_Diferenca N(16,2), Pct_Dif_Chr C(20), Parcelas N(3,0), ;
            Cond_Pagto C(100), Venda_CadastroR N(16,2), Desc_Acres N(16,2), CpfCli C(20), ;
            Pedidoweb C(20), pStatus C(1), Dias N(5,0), Descritivo C(45), Local C(10), ;
            Qtde N(12,0), Colecao C(60), Destino C(3), ContaOrigem C(10))

        *-- Tags EXATOS do legado (Load(), codigo_fonte.txt:2772-2775). Com
        *-- Filtro/Perc_Diferenca sempre 0 nesta tela (regra de "diferenca"
        *-- nao exercitada aqui), Ordem1/Ordem2 ficam sempre vazios e
        *-- Ordem3 sempre com tudo - SigOpPckBO.MontarCursorDados() usa
        *-- Ordem3 ao final do processamento (legado: Thisform.Filtros(1,3)).
        SELECT (loc_cCursor)
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro = 1 OR (Perc_Diferenca > 0 AND Filtro <> 3) TAG Ordem1
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro = 2 OR (Perc_Diferenca < 0 AND Filtro <> 3) TAG Ordem2
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro <> 1 AND Filtro <> 2 TAG Ordem3
        INDEX ON Data_Venda TAG Ordem4
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrdDados - Grade de resultado "Detalhamento dos Produtos"
    * (legado: grdDados1), 16 colunas SOMENTE LEITURA (legado:
    * Movable/Resizable/ReadOnly = .F./.F./.T. para TODAS as colunas,
    * codigo_fonte.txt:2495-2504 - via loop, aqui via SetAll). ControlSource
    * de cada coluna transcrito EXATO do metodo Processamento do legado
    * (:2509-2526); Width/Header de cada coluna do dump de propriedades
    * (:1288-1390, :1405-1780).
    *
    * Column1 (header "Emp") liga em Destino, Column11 (header "Categoria")
    * liga em Colecao e Column16 (header "Cole" + CHR(231) + CHR(227) +
    * "o") liga em Subgrupo - parece trocado, mas eh exatamente o que o
    * legado faz (ControlSource explicito no metodo Processamento) -
    * TRANSCREVER, nao "corrigir" (regra #17 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd, par_cCursor)
        WITH par_oGrd
            .RecordSource      = par_cCursor
            .ColumnCount       = 16
            .FontName          = "Tahoma"
            .FontSize          = 7
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 21
            .RowHeight         = 15
            .ScrollBars        = 3
            .Left              = 4
            .Top               = 320
            .Width             = 1292
            .Height            = 251
            .GridLineColor     = RGB(238, 238, 238)
            .Themes            = .F.
            .Visible           = .T.

            *-- Negrito dinamico nas linhas cuja Ordem nao eh "A" (legado:
            *-- MontaGrades, .SetAll([DynamicFontBold], [crPgRes01.Ordem
            *-- <> 'A'], [Column])).
            .SetAll("DynamicFontBold", par_cCursor + ".Ordem <> 'A'", "Column")

            *-- NAO aplicar Movable/Resizable/ReadOnly = .F. aqui: o loop do
            *-- legado que faz isso (MontaGrades, codigo_fonte.txt:2467-2505)
            *-- roda SO nas 3 grades de FILTRO (grdTipo/grdMercs/grdCGrus -
            *-- ver ConfigurarGradeFiltro); grdDados1 fica com as colunas
            *-- redimensionaveis DE PROPOSITO, porque eh arrastar a largura
            *-- para 0 que dispara Column<N>.Resize e oferece ocultar a
            *-- coluna (ver ColunaDados<NN>Resize/OcultarColunaDados).
        ENDWITH

        WITH par_oGrd.Column1
            .Width               = 31
            .ControlSource       = par_cCursor + ".Destino"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Emp"
        ENDWITH

        WITH par_oGrd.Column2
            .Width               = 150
            .ControlSource       = par_cCursor + ".Movimentacao"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"
        ENDWITH

        WITH par_oGrd.Column3
            .Width               = 55
            .ControlSource       = par_cCursor + ".Numero"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "C" + CHR(243) + "digo"
        ENDWITH

        WITH par_oGrd.Column4
            .Width               = 71
            .ControlSource       = "IIF(EMPTY(" + par_cCursor + ".Data_Venda), SPACE(10), DTOC(" + par_cCursor + ".Data_Venda))"
            .Text1.Alignment     = 2
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Data"
        ENDWITH

        WITH par_oGrd.Column5
            .Width               = 150
            .ControlSource       = par_cCursor + ".Pedidoweb"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Pedido Web"
        ENDWITH

        WITH par_oGrd.Column6
            .Width               = 80
            .ControlSource       = par_cCursor + ".Barras"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Barra"
        ENDWITH

        WITH par_oGrd.Column7
            .Width                 = 110
            .ControlSource         = par_cCursor + ".Codigo_Item"
            .Text1.FontBold        = .T.
            .Text1.FontUnderline   = .T.
            .Text1.ForeColor       = RGB(0, 0, 255)
            .Header1.Alignment     = 2
            .Header1.FontBold      = .T.
            .Header1.ForeColor     = RGB(90, 90, 90)
            .Header1.Caption       = "Produto"
        ENDWITH

        WITH par_oGrd.Column8
            .Width               = 296
            .ControlSource       = par_cCursor + ".Desc_Item"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o do Produto"
        ENDWITH

        WITH par_oGrd.Column9
            .Width               = 35
            .ControlSource       = par_cCursor + ".Cor"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Cor"
        ENDWITH

        *-- Coluna "Tam" eh clicavel no legado (FontBold/FontUnderline/
        *-- ForeColor azul no proprio Column, nao no Text1 - dump confirma
        *-- as propriedades no nivel da Column)
        WITH par_oGrd.Column10
            .Width               = 35
            .FontBold            = .T.
            .FontUnderline       = .T.
            .Alignment           = 2
            .ForeColor           = RGB(0, 0, 255)
            .ControlSource       = par_cCursor + ".Tamanho"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Tam"
        ENDWITH

        WITH par_oGrd.Column11
            .Width               = 213
            .ControlSource       = par_cCursor + ".Colecao"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Categoria"
        ENDWITH

        WITH par_oGrd.Column12
            .Width               = 60
            .ControlSource       = par_cCursor + ".Local"
            .Text1.Alignment     = 3
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Local"
        ENDWITH

        WITH par_oGrd.Column13
            .Width               = 60
            .ControlSource       = par_cCursor + ".Qtde"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Qtd. Local"
        ENDWITH

        WITH par_oGrd.Column14
            .Width               = 164
            .ControlSource       = par_cCursor + ".Descritivo"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Descritivo"
        ENDWITH

        WITH par_oGrd.Column15
            .Width               = 100
            .ControlSource       = par_cCursor + ".Quantidade"
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Quantidade"
        ENDWITH

        WITH par_oGrd.Column16
            .Width               = 141
            .ControlSource       = par_cCursor + ".Subgrupo"
            .Text1.Alignment     = 2
            .Header1.Alignment   = 2
            .Header1.FontBold    = .T.
            .Header1.ForeColor   = RGB(90, 90, 90)
            .Header1.Caption     = "Cole" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- ORDEM de exibicao das colunas - vai por ULTIMO, depois de
        *-- RecordSource/ControlSource/Width (mesma razao da Width: mexer na
        *-- fonte do grid faz o VFP recalcular a ordem).
        THIS.AplicarOrdemColunasDados(par_oGrd)
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarOrdemColunasDados - Ordem de exibicao das 16 colunas da grade
    * de resultado, transcrita do SCX legado (Column<N>.ColumnOrder).
    *
    * ATENCAO: no SCX os SLOTS de coluna estao RENOMEADOS - o slot
    * "Column16" tem Name = "Column10", o slot "Column10" tem Name =
    * "Column11", etc. Os valores abaixo sao resolvidos pelo NOME de
    * runtime (que eh o que .ColumnN alcanca em VFP9), nao pelo numero do
    * slot: Column1=1, Column2=9, Column3=2, Column4=3, Column5=11,
    * Column6=4, Column7=6, Column8=7, Column9=8, Column10=12,
    * Column11=13, Column12=14, Column13=15, Column14=10, Column15=5,
    * Column16=16.
    *
    * A atribuicao eh feita na ORDEM CRESCENTE da posicao de destino
    * (insercao): o VFP renumera as demais colunas a cada atribuicao, e so
    * assim a permutacao final bate com a do SCX - medido no VFP9 em
    * 2026-11-13 com automation\_probeColOrder783.prg, que devolveu
    * exatamente os 16 ColumnOrder do SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarOrdemColunasDados(par_oGrd)
        LOCAL loc_nPos
        LOCAL ARRAY loc_aColuna[16]

        *-- loc_aColuna[posicao] = numero da Column que ocupa essa posicao
        loc_aColuna[1]  = 1
        loc_aColuna[2]  = 3
        loc_aColuna[3]  = 4
        loc_aColuna[4]  = 6
        loc_aColuna[5]  = 15
        loc_aColuna[6]  = 7
        loc_aColuna[7]  = 8
        loc_aColuna[8]  = 9
        loc_aColuna[9]  = 2
        loc_aColuna[10] = 14
        loc_aColuna[11] = 5
        loc_aColuna[12] = 10
        loc_aColuna[13] = 11
        loc_aColuna[14] = 12
        loc_aColuna[15] = 13
        loc_aColuna[16] = 16

        FOR loc_nPos = 1 TO 16
            STORE loc_nPos TO ("par_oGrd.Column" + ALLTRIM(STR(loc_aColuna[loc_nPos])) + ".ColumnOrder")
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePadrao - Restaura larguras e visibilidade das colunas da grade de
    * resultado para a tabela PADRAO do legado (PROCEDURE gradepadrao,
    * SigOpPck_form_codigo_fonte.txt:2400-2432 - array laGrd(1..16) + loop
    * que tambem forca Visible = .t. e termina com Refresh).
    *
    * Esta tabela NAO eh a mesma das larguras iniciais (essas vem do SCX,
    * ver ConfigurarGrdDados): o legado tem as duas, e esta eh a que o
    * botao "Restaurar Grade" aplica.
    *--------------------------------------------------------------------------
    PROCEDURE GradePadrao()
        LOCAL loc_oGrd, loc_nI, loc_cCol
        LOCAL ARRAY loc_aLargura[16]

        loc_aLargura[1]  = 31
        loc_aLargura[2]  = 150
        loc_aLargura[3]  = 55
        loc_aLargura[4]  = 71
        loc_aLargura[5]  = 150
        loc_aLargura[6]  = 80
        loc_aLargura[7]  = 110
        loc_aLargura[8]  = 296
        loc_aLargura[9]  = 35
        loc_aLargura[10] = 35
        loc_aLargura[11] = 100
        loc_aLargura[12] = 100
        loc_aLargura[13] = 290
        loc_aLargura[14] = 150
        loc_aLargura[15] = 100
        loc_aLargura[16] = 25

        loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados

        FOR loc_nI = 1 TO loc_oGrd.ColumnCount
            loc_cCol = "loc_oGrd.Column" + ALLTRIM(STR(loc_nI))
            STORE loc_aLargura[loc_nI] TO (loc_cCol + ".Width")
            STORE .T. TO (loc_cCol + ".Visible")
        ENDFOR

        loc_oGrd.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AcertaColunas - Le ("LER") ou monta ("GRAVAR") o layout das colunas da
    * grade de resultado na string de configuracao (legado: PROCEDURE
    * acertacolunas, SigOpPck_form_codigo_fonte.txt:2086-2118).
    *
    * Formato da string (transcrito do legado): um bloco de 5 posicoes por
    * coluna - 1..3 = Width com zeros a esquerda, 4 = Visible ("1"/"0"),
    * 5 = BRANCO reservado para uso futuro. Largura nao gravada (bloco
    * vazio/zero) MANTEM a largura corrente, igual ao legado.
    *
    * O deposito eh o TextBox txt_4c_CfgGrade (legado: getCfgGrade, visivel
    * so para o usuario 4CONTROL); a persistencia por usuario fica em
    * SigOpPckBO.CarregarCfgGrade/GravarCfgGrade (SigSyPar), substituindo o
    * poSigSyPar/fGravaUserXML do Framework legado, que nao foi portado.
    *--------------------------------------------------------------------------
    PROCEDURE AcertaColunas(par_cTipo)
        LOCAL loc_oGrd, loc_oTxt, loc_cStr, loc_nPos, loc_nI, loc_cCol, ;
            loc_cBloco, loc_nLargura, loc_lVisivel

        loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados
        loc_oTxt = THIS.pgf_4c_Paginas.Page1.txt_4c_CfgGrade

        IF UPPER(ALLTRIM(par_cTipo)) == "LER"
            loc_cStr = loc_oTxt.Value
            loc_nPos = 1

            FOR loc_nI = 1 TO loc_oGrd.ColumnCount
                loc_cBloco   = SUBSTR(loc_cStr, loc_nPos, 5)
                loc_nLargura = INT(VAL(SUBSTR(loc_cBloco, 1, 3)))
                loc_lVisivel = !(SUBSTR(loc_cBloco, 4, 1) == "0")
                loc_cCol     = "loc_oGrd.Column" + ALLTRIM(STR(loc_nI))

                IF loc_nLargura > 0
                    STORE loc_nLargura TO (loc_cCol + ".Width")
                ENDIF

                STORE loc_lVisivel TO (loc_cCol + ".Visible")

                loc_nPos = loc_nPos + 5
            ENDFOR
        ELSE
            loc_cStr = ""

            FOR loc_nI = 1 TO loc_oGrd.ColumnCount
                loc_cCol     = "loc_oGrd.Column" + ALLTRIM(STR(loc_nI))
                loc_nLargura = EVALUATE(loc_cCol + ".Width")
                loc_lVisivel = EVALUATE(loc_cCol + ".Visible")

                *-- Teto de 999: o bloco tem 3 posicoes para a largura e uma
                *-- coluna arrastada alem disso produziria um bloco de 4
                *-- caracteres, deslocando TODOS os blocos seguintes na
                *-- leitura. O legado nao tem essa protecao (corrompe a
                *-- propria string); aqui o excedente eh apenas limitado.
                loc_nLargura = MIN(INT(loc_nLargura), 999)

                loc_cStr = loc_cStr + PADL(ALLTRIM(STR(loc_nLargura)), 3, "0") + ;
                    IIF(loc_lVisivel, "1", "0") + " "
            ENDFOR

            loc_oTxt.Value = loc_cStr
            THIS.this_oBusinessObject.this_cCfgGrade = loc_cStr
            THIS.this_oBusinessObject.GravarCfgGrade()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarColunaDados - Corpo unico dos 16 Column<N>.Resize do legado:
    * se o usuario arrastou a largura da coluna para 0, pergunta se quer
    * oculta-la (legado: lcHea = Alltrim(This.Header1.Caption) / If
    * (This.Width = 0) And (MessageBox([Deseja Ocultar a Coluna "] + lcHea +
    * [" da Grade?], 4+32+256, [Ocultar Colunas]) = 6) / This.Visible = .f.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE OcultarColunaDados(par_nColuna)
        LOCAL loc_oGrd, loc_cCol, loc_cHeader

        loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados
        loc_cCol = "loc_oGrd.Column" + ALLTRIM(STR(par_nColuna))

        IF EVALUATE(loc_cCol + ".Width") = 0
            loc_cHeader = ALLTRIM(EVALUATE(loc_cCol + ".Header1.Caption"))

            IF MsgConfirma("Deseja Ocultar a Coluna " + CHR(34) + loc_cHeader + CHR(34) + ;
                    " da Grade?", "Ocultar Colunas")
                STORE .F. TO (loc_cCol + ".Visible")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ColunaDados<NN>Resize - Handlers do Resize de cada coluna da grade de
    * resultado. PUBLIC obrigatorio (regra #3 do CLAUDE.md - BINDEVENT com
    * metodo PROTECTED falha em silencio). O evento nao informa o objeto
    * emissor, por isso um handler fino por coluna delegando o corpo unico.
    *--------------------------------------------------------------------------
    PROCEDURE ColunaDados01Resize()
        THIS.OcultarColunaDados(1)
    ENDPROC

    PROCEDURE ColunaDados02Resize()
        THIS.OcultarColunaDados(2)
    ENDPROC

    PROCEDURE ColunaDados03Resize()
        THIS.OcultarColunaDados(3)
    ENDPROC

    PROCEDURE ColunaDados04Resize()
        THIS.OcultarColunaDados(4)
    ENDPROC

    PROCEDURE ColunaDados05Resize()
        THIS.OcultarColunaDados(5)
    ENDPROC

    PROCEDURE ColunaDados06Resize()
        THIS.OcultarColunaDados(6)
    ENDPROC

    PROCEDURE ColunaDados07Resize()
        THIS.OcultarColunaDados(7)
    ENDPROC

    PROCEDURE ColunaDados08Resize()
        THIS.OcultarColunaDados(8)
    ENDPROC

    PROCEDURE ColunaDados09Resize()
        THIS.OcultarColunaDados(9)
    ENDPROC

    PROCEDURE ColunaDados10Resize()
        THIS.OcultarColunaDados(10)
    ENDPROC

    PROCEDURE ColunaDados11Resize()
        THIS.OcultarColunaDados(11)
    ENDPROC

    PROCEDURE ColunaDados12Resize()
        THIS.OcultarColunaDados(12)
    ENDPROC

    PROCEDURE ColunaDados13Resize()
        THIS.OcultarColunaDados(13)
    ENDPROC

    PROCEDURE ColunaDados14Resize()
        THIS.OcultarColunaDados(14)
    ENDPROC

    PROCEDURE ColunaDados15Resize()
        THIS.OcultarColunaDados(15)
    ENDPROC

    PROCEDURE ColunaDados16Resize()
        THIS.OcultarColunaDados(16)
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosProdutoDblClick - Duplo clique na coluna "Produto" abre a
    * Pesquisa Global de Produtos filtrada pelo codigo da linha corrente
    * (legado: grdDados1.Column7.Text1.DblClick - Do Form SigOpCgp NoShow,
    * depois Commandgroup1.Command1.Click() + get_produto_inicial/
    * get_produto_final = Padr(This.Value, 14) + cmd_consulta.Click()).
    *
    * Equivalentes no sistema novo (Formsigopcgp): GrpLimparFiltrosClick()
    * para o Command1 que limpa os filtros, txt_4c_ProdutoI/txt_4c_ProdutoF
    * da pagina de filtro para os dois get_produto_*, e BtnConsultarClick()
    * para o cmd_consulta.
    *
    * DUAS divergencias DELIBERADAS do legado, pelas razoes abaixo:
    * 1) O legado abre com NoShow e guarda a instancia em ThisForm.poObjExt1
    *    para reusar; Formsigopcgp eh MODAL (WindowType = 1), entao nao ha
    *    instancia viva para reusar e a tela eh exibida com Show() - sem
    *    isso o usuario daria o duplo clique e nada apareceria.
    * 2) A guarda goSistema.ConsultaAberta do legado nao tem contrapartida:
    *    essa property nao existe em go_4c_Sistema e nada no sistema novo a
    *    mantem, de modo que testa-la seria sempre .F. (equivalente a
    *    omiti-la).
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosProdutoDblClick()
        LOCAL loc_cCursor, loc_cCodigo, loc_oForm, loc_oPagFiltro, loc_oErro

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        loc_cCodigo = ""

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            loc_cCodigo = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Codigo_Item"), ""))
        ENDIF

        IF EMPTY(loc_cCodigo)
            RETURN
        ENDIF

        TRY
            GarantirClasse("Formsigopcgp")
            loc_oForm = CREATEOBJECT("Formsigopcgp")

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.GrpLimparFiltrosClick()

                loc_oPagFiltro = loc_oForm.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
                loc_oPagFiltro.txt_4c_ProdutoI.Value = PADR(loc_cCodigo, 14)
                loc_oPagFiltro.txt_4c_ProdutoF.Value = PADR(loc_cCodigo, 14)

                loc_oForm.BtnConsultarClick()
                loc_oForm.Show()
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a Pesquisa " + ;
                    "Global de Produtos.", "Pesquisa Global de Produtos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Pesquisa Global de Produtos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Funil unico de navegacao entre FILTROS (Page1) e
    * DADOS (Page2 - grade de resultado; legado: cmgRetornar.Click volta
    * para a Page1). Este form NAO eh CRUD - nao ha botoes de lista para
    * reabilitar (regra #40 nao se aplica), so o modo atual do form.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "FILTROS"
        ELSE
            THIS.this_cModoAtual = "DADOS"

            *-- Repintar SO DEPOIS de trocar o ActivePage: Refresh em pagina
            *-- OCULTA nao pinta (regra #21 do CLAUDE.md) - por isso o funil
            *-- de repintura mora aqui e nao no caller.
            THIS.CarregarGradeResultado()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcaClick / BtnDesmarcaClick - Marcar/Desmarcar Tudo na grade de
    * Tipos de Operacao (legado: btnMarca.Click / btnDesmarca.Click).
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcaClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos

        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET nMarcas = 1
            GO TOP IN (loc_cCursor)
            THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcaClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos

        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET nMarcas = 0
            GO TOP IN (loc_cCursor)
            THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarGdeClick / BtnDesGdeClick - Marcar/Desmarcar Tudo na grade de
    * Grande Grupo (legado: btnMarGde.Click / btnDesGde.Click).
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarGdeClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr

        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET nMarcas = 1
            GO TOP IN (loc_cCursor)
            THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesGdeClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr

        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET nMarcas = 0
            GO TOP IN (loc_cCursor)
            THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarGrpClick / BtnDesGrpClick - Marcar/Desmarcar Tudo na grade de
    * Grupo de Produto (legado: btnMarGrp.Click / btnDesGrp.Click).
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarGrpClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru

        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET nMarcas = 1
            GO TOP IN (loc_cCursor)
            THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesGrpClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru

        IF USED(loc_cCursor)
            UPDATE (loc_cCursor) SET nMarcas = 0
            GO TOP IN (loc_cCursor)
            THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultarClick - Valida o periodo informado (legado: cmgFiltros.
    * Command1.Click) e processa os movimentos filtrados (legado:
    * ThisForm.Processamento(), chamado apos as mesmas 3 validacoes de
    * data). Com sucesso, segue para a pagina de Dados e repinta a grade
    * de resultado (legado: ActivePage=2 + AfterRowColChange, codigo_
    * fonte.txt:2729-2733).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultarClick()
        LOCAL loc_oPag, loc_dIni, loc_dFim

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPag.txt_4c_DcI.Value
        loc_dFim = loc_oPag.txt_4c_DcF.Value

        IF EMPTY(loc_dIni)
            MsgAviso("A Data Inicial n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lida!!!", ;
                "Dados Inv" + CHR(225) + "lidos!!!")
            loc_oPag.txt_4c_DcI.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_dFim)
            MsgAviso("A Data Final n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lida!!!", ;
                "Dados Inv" + CHR(225) + "lidos!!!")
            loc_oPag.txt_4c_DcF.SetFocus()
            RETURN
        ENDIF

        IF loc_dIni > loc_dFim
            MsgAviso("A Data Inicial n" + CHR(227) + "o Pode Ser Maior Que a Final!!!", ;
                "Dados Inv" + CHR(225) + "lidos!!!")
            loc_oPag.txt_4c_DcI.SetFocus()
            RETURN
        ENDIF

        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - FUNIL unico de carga da grade de resultado (legado:
    * cmgFiltros.Command1.Click -> ThisForm.Processamento() -> ActivePage=2).
    * Captura a tela nas propriedades do BO (FormParaBO), processa e, com
    * sucesso, vai para a pagina de Dados - que eh quem repinta a grade
    * (AlternarPagina(2) -> CarregarGradeResultado, regra #21 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF THIS.FormParaBO()
            *-- BO ja exibe o proprio MsgErro (ver Processar() no BO) - o form
            *-- so segue adiante se o processamento deu certo (regra #20 do
            *-- CLAUDE.md - falha de processamento nunca eh muda).
            IF THIS.this_oBusinessObject.Processar()
                THIS.AlternarPagina(2)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere os filtros digitados na Page1 para as
    * propriedades do BO (legado: o Click de cmgFiltros le getDcI/getDcF/
    * getEmpOs/getOperacao direto dos controles). PROTECTED obrigatorio:
    * FormBase declara este hook como PROTECTED e VFP9 nao permite ALARGAR
    * o escopo de metodo herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag, loc_oBO

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oBO  = THIS.this_oBusinessObject

        loc_oBO.this_dDataIni     = loc_oPag.txt_4c_DcI.Value
        loc_oBO.this_dDataFim     = loc_oPag.txt_4c_DcF.Value
        loc_oBO.this_cEmpresa     = ALLTRIM(loc_oPag.txt_4c_EmpOs.Value)
        loc_oBO.this_cDescEmpresa = ALLTRIM(loc_oPag.txt_4c_DEmpOs.Value)
        loc_oBO.this_cOperacao    = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)

        *-- Layout da grade: SEM ALLTRIM - a string eh POSICIONAL (blocos de
        *-- 5 posicoes por coluna, a 5a eh um BRANCO reservado pelo legado).
        loc_oBO.this_cCfgGrade = loc_oPag.txt_4c_CfgGrade.Value

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Espelha os filtros do BO nos controles da Page1 (legado:
    * bloco do Init que faz getDcI.Value = Date(), getDcF.Value = Date(),
    * getOperacao.Value = [], getEmpOs.Value = _Empr e getDEmpOs.Value =
    * crSigCdEmp.Razas). PROTECTED pelo mesmo motivo de FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oBO

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oBO  = THIS.this_oBusinessObject

        loc_oPag.txt_4c_DcI.Value      = ConverterParaData(loc_oBO.this_dDataIni)
        loc_oPag.txt_4c_DcF.Value      = ConverterParaData(loc_oBO.this_dDataFim)
        loc_oPag.txt_4c_EmpOs.Value    = loc_oBO.this_cEmpresa
        loc_oPag.txt_4c_DEmpOs.Value   = loc_oBO.this_cDescEmpresa
        loc_oPag.txt_4c_Operacao.Value = loc_oBO.this_cOperacao
        loc_oPag.txt_4c_CfgGrade.Value = loc_oBO.this_cCfgGrade

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeResultado - Repinta a grade de resultado e espelha a
    * linha corrente nas propriedades this_Res* do BO (legado: ActivePage
    * do PageFrame interno + AfterRowColChange explicito apos trocar de
    * pagina, codigo_fonte.txt:2731-2733 - regra #21 do CLAUDE.md, popular
    * cursor nao repinta a grade sozinho).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeResultado()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF USED(loc_cCursor)
            GO TOP IN (loc_cCursor)
        ENDIF

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.Refresh()
        THIS.GrdDadosAfterRowColChange(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Encerra o form, gravando antes o layout da grade de
    * resultado (legado: cmgFiltros.Command2.Click = ThisForm.AcertaColunas
    * ([GRAVAR]) + ThisForm.Release; o Release do legado chama tambem
    * poSigSyPar.fGravaUserCfg(), e aqui a persistencia esta dentro do
    * proprio AcertaColunas("GRAVAR")).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.AcertaColunas("GRAVAR")
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpOsLostFocus - Resolve o codigo de Empresa digitado contra
    * SigCdEmp (legado: getEmpOs.Valid/getDEmpOs.Valid = fAcessoEmpresa(Usuar,
    * "C"|"D", ...) - funcao global Fortyus NAO portada). Match exato
    * preenche codigo+descricao direto; sem match, abre o picker (regra #50
    * do CLAUDE.md - sem MsgAviso, sem apagar o que o usuario digitou).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpOsLostFocus()
        LOCAL loc_oPag, loc_cCodigo, loc_cSQL, loc_nResultado

        IF THIS.this_lEmLookupEmpresa
            RETURN
        ENDIF

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPag.txt_4c_EmpOs.Value)

        *-- Guarda de "valor nao mudou" (LostFocus dispara sempre, Valid do
        *-- legado so dispara quando o valor MUDA) - sem isto, sair do campo
        *-- sem alterar o codigo ja validado reabriria/reconsultaria toda vez.
        IF loc_cCodigo == THIS.this_cUltimoValidarEmpOsLostFocusValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cCodigo)
            loc_oPag.txt_4c_DEmpOs.Value = ""
            RETURN
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        loc_cSQL       = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodigo)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

        IF loc_nResultado > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
            loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
        ELSE
            THIS.AbrirLookupEmpresa()
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        THIS.this_cUltimoValidarEmpOsLostFocusValidado = ALLTRIM(loc_oPag.txt_4c_EmpOs.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpOsKeyPress - F4 abre o picker de Empresa direto (regra #47 - so com
    * o teste da tecla; os demais caracteres seguem para o LostFocus).
    *--------------------------------------------------------------------------
    PROCEDURE EmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Picker de Empresa (SigCdEmp), substituicao
    * canonica de fAcessoEmpresa em modo LOOKUP (memoria: "fAcessoEmpresa
    * nao portada"). Guarda de reentrancia porque o Show() eh modal e tira/
    * devolve o foco, redisparando o proprio LostFocus (regra #37).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oPag, loc_oBusca, loc_oErro

        IF THIS.this_lEmLookupEmpresa
            RETURN
        ENDIF
        THIS.this_lEmLookupEmpresa = .T.

        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
                ALLTRIM(loc_oPag.txt_4c_EmpOs.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.this_lEmLookupEmpresa = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacaoLostFocus - Resolve o codigo de Operacao/Movimentacao
    * digitado contra SigCdOpe (legado: getOperacao.Valid = fAcessoMovmto -
    * funcao global Fortyus NAO portada). SigCdOpe eh single-column - Dopes
    * eh PK e descricao ao mesmo tempo (memoria: "SigCdOpe single column" -
    * NUNCA adicionar uma 2a coluna de descricao).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacaoLostFocus()
        LOCAL loc_oPag, loc_cCodigo, loc_cSQL, loc_nResultado

        IF THIS.this_lEmLookupOperacao
            RETURN
        ENDIF

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)

        *-- Guarda de "valor nao mudou" (LostFocus dispara sempre, Valid do
        *-- legado so dispara quando o valor MUDA) - sem isto, sair do campo
        *-- sem alterar o codigo ja validado reabriria/reconsultaria toda vez.
        IF loc_cCodigo == THIS.this_cUltimoValidarOperacaoLostFocusValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cCodigo)
            RETURN
        ENDIF

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCodigo)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")

        IF loc_nResultado > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
            loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
        ELSE
            THIS.AbrirLookupOperacao()
        ENDIF

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        THIS.this_cUltimoValidarOperacaoLostFocusValidado = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * OperacaoKeyPress - F4 abre o picker de Operacao direto.
    *--------------------------------------------------------------------------
    PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupOperacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupOperacao - Picker de Operacao (SigCdOpe), substituicao
    * canonica de fAcessoMovmto. Guarda de reentrancia pelo mesmo motivo do
    * AbrirLookupEmpresa.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupOperacao()
        LOCAL loc_oPag, loc_oBusca, loc_oErro

        IF THIS.this_lEmLookupOperacao
            RETURN
        ENDIF
        THIS.this_lEmLookupOperacao = .T.

        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
                ALLTRIM(loc_oPag.txt_4c_Operacao.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                    SELECT cursor_4c_BuscaOpe
                    loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.this_lEmLookupOperacao = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosPaginaDados - BINDEVENT dos controles da pagina de
    * Dados (grade de resultado e os botoes ao redor dela - Restaurar Grade/
    * Cadastro/Movimento/Subniveis/Busca por codigo - e os botoes de nivel
    * da Page2 - Retornar/Visualizar/Excel/Imprimir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosPaginaDados()
        LOCAL loc_oPagRes, loc_oPagDados

        loc_oPagRes   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2

        BINDEVENT(loc_oPagRes.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(loc_oPagRes.txt_4c_Busca, "KeyPress", THIS, "BuscaCodigoKeyPress")
        BINDEVENT(loc_oPagRes.cmd_4c_BtnRestaurar, "Click", THIS, "BtnRestaurarClick")
        BINDEVENT(loc_oPagRes.cmd_4c_BtnProduto, "Click", THIS, "BtnProdutoClick")
        BINDEVENT(loc_oPagRes.obj_4c_CmdOperacao.Buttons(1), "Click", THIS, "BtnOperacaoClick")
        BINDEVENT(loc_oPagRes.cmd_4c_SubNiveis, "Click", THIS, "BtnSubNiveisClick")

        BINDEVENT(loc_oPagDados.obj_4c_CmgRetornar.Buttons(1), "Click", THIS, "BtnRetornarClick")
        BINDEVENT(loc_oPagDados.cmd_4c_BtnVisualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagDados.cmd_4c_BtnExcel, "Click", THIS, "GerarXLS")
        BINDEVENT(loc_oPagDados.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")

        *-- Coluna "Produto": duplo clique abre a Pesquisa Global de Produtos
        *-- (legado: grdDados1.Column7.Text1.DblClick).
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column7.Text1, "DblClick", THIS, "GrdDadosProdutoDblClick")

        *-- Resize de CADA coluna da grade de resultado: arrastar a largura
        *-- para 0 pergunta se o usuario quer ocultar a coluna (legado:
        *-- grdDados1.Column<N>.Resize, as 16 com o MESMO corpo). Um handler
        *-- fino por coluna porque o evento nao informa qual objeto disparou
        *-- (AEVENTS consulta POR objeto de origem, nao devolve o emissor).
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column1,  "Resize", THIS, "ColunaDados01Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column2,  "Resize", THIS, "ColunaDados02Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column3,  "Resize", THIS, "ColunaDados03Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column4,  "Resize", THIS, "ColunaDados04Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column5,  "Resize", THIS, "ColunaDados05Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column6,  "Resize", THIS, "ColunaDados06Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column7,  "Resize", THIS, "ColunaDados07Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column8,  "Resize", THIS, "ColunaDados08Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column9,  "Resize", THIS, "ColunaDados09Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column10, "Resize", THIS, "ColunaDados10Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column11, "Resize", THIS, "ColunaDados11Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column12, "Resize", THIS, "ColunaDados12Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column13, "Resize", THIS, "ColunaDados13Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column14, "Resize", THIS, "ColunaDados14Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column15, "Resize", THIS, "ColunaDados15Resize")
        BINDEVENT(loc_oPagRes.grd_4c_Dados.Column16, "Resize", THIS, "ColunaDados16Resize")
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Espelha a linha corrente da grade de
    * resultado nas propriedades this_Res* do BO (CarregarDoCursor) e
    * atualiza o painel de observacao/imagem do item (legado: ControlSource
    * direto de getObsItn/ImgFigJpg em crPgRes01, que se atualizava sozinho
    * ao mudar de linha). Sem filtro de coluna, igual aos outros 11 dos 12
    * handlers do projeto que usam AfterRowColChange para carregar detalhe
    * da linha corrente (regra #46 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
        THIS.AtualizarDetalheItem()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarDetalheItem - Copia this_cResObsItem para o EditBox e decodifica
    * this_cResImagem (base64, com os 3 prefixos data:image/... do legado) para
    * um arquivo temporario, exibindo-o no Image (legado: ImgFigJpg.Click).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarDetalheItem()
        LOCAL loc_oPagRes, loc_cArquivo, loc_cFoto

        loc_oPagRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1

        loc_oPagRes.edt_4c_ObsItem.Value = THIS.this_oBusinessObject.this_cResObsItem

        loc_oPagRes.img_4c_FigProduto.Picture = ""
        loc_oPagRes.img_4c_FigProduto.Visible = .F.

        IF !EMPTY(THIS.this_oBusinessObject.this_cResImagem)
            loc_cArquivo = ADDBS(SYS(2023)) + "sigoppck_" + SYS(2015) + ".jpg"
            loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(THIS.this_oBusinessObject.this_cResImagem, ;
                "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), "data:image/jpg;base64,", ""), 14)
            STRTOFILE(loc_cFoto, loc_cArquivo)

            IF FILE(loc_cArquivo)
                loc_oPagRes.img_4c_FigProduto.Picture = loc_cArquivo
                loc_oPagRes.img_4c_FigProduto.Visible = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscaCodigoKeyPress - Busca POSICIONAL (nao-lookup) do numero do
    * movimento dentro do cursor ja carregado (legado: getBusca.Valid/
    * LostFocus - Locate For Numero = This.Value, depois foca a coluna 3).
    *--------------------------------------------------------------------------
    PROCEDURE BuscaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagRes, loc_cCursor, loc_nValor

        IF INLIST(par_nKeyCode, 13, 9)
            loc_oPagRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
            loc_nValor  = loc_oPagRes.txt_4c_Busca.Value

            IF loc_nValor > 0 AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                GO TOP
                LOCATE FOR Numero = loc_nValor
                loc_oPagRes.grd_4c_Dados.Refresh()

                IF par_nKeyCode = 13
                    loc_oPagRes.grd_4c_Dados.Column3.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRestaurarClick - Restaura larguras/visibilidade das colunas da
    * grade de resultado para o padrao do legado e REGRAVA o layout
    * (legado: btnRestaurar.Click = If MessageBox(...) = 6 / GradePadrao() /
    * AcertaColunas([GRAVAR])).
    *--------------------------------------------------------------------------
    PROCEDURE BtnRestaurarClick()
        IF MsgConfirma("Deseja Restaurar as Colunas da Grade (Ocultas e Larguras)?", "Restaurar Grade")
            THIS.GradePadrao()
            THIS.AcertaColunas("GRAVAR")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProdutoClick - Abre o Cadastro de Produtos para o item da linha
    * corrente (legado: btnProduto.Click = Do Form SigCdPro linked, que no
    * sistema novo eh FormProduto - CRUD independente, sem parametro de
    * codigo posicional; o usuario busca pelo codigo indicado no aviso,
    * mesmo padrao usado em Formsigoporc.BtnCadastroProdutoClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProdutoClick()
        LOCAL loc_cCursor, loc_cCodigoItem, loc_oForm

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            loc_cCodigoItem = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Codigo_Item"), ""))

            IF !EMPTY(loc_cCodigoItem)
                MsgInfo("Produto: " + loc_cCodigoItem + CHR(13) + ;
                    "Digite esse c" + CHR(243) + "digo na busca do Cadastro de Produtos.", ;
                    "Cadastro do Produto")

                GarantirClasse("FormProduto")
                loc_oForm = CREATEOBJECT("FormProduto")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                ENDIF
            ENDIF
        ENDIF

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOperacaoClick - Abre o movimento de origem do item corrente
    * (legado: cmdOperacao.btnOperacao.Valid): valida a linha selecionada,
    * confere se a operacao existe em SigCdOpe (Pedido - abre FormSigMvExp)
    * ou SigCdOpd (Devolucao - abre FormSigMvPdt).
    *--------------------------------------------------------------------------
    PROCEDURE BtnOperacaoClick()
        LOCAL loc_cCursor, loc_cEmpresa, loc_cMovimentacao, loc_nNumero, ;
            loc_cSQL, loc_nResultado, loc_oForm

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        loc_cEmpresa      = ""
        loc_cMovimentacao = ""
        loc_nNumero       = 0

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            loc_cEmpresa      = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Empresa"), ""))
            loc_cMovimentacao = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Movimentacao"), ""))
            loc_nNumero       = TratarNulo(EVALUATE(loc_cCursor + ".Numero"), 0)
        ENDIF

        IF EMPTY(loc_cEmpresa) OR EMPTY(loc_cMovimentacao) OR loc_nNumero = 0
            MsgAviso("Selecione Um Registro V" + CHR(225) + "lido Na Grade de Itens!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        IF USED("cursor_4c_TmpOpe")
            USE IN cursor_4c_TmpOpe
        ENDIF

        loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cMovimentacao)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")

        IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
            IF USED("cursor_4c_TmpOpe")
                USE IN cursor_4c_TmpOpe
            ENDIF

            GarantirClasse("FormSigMvExp")
            loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        ELSE
            IF USED("cursor_4c_TmpOpe")
                USE IN cursor_4c_TmpOpe
            ENDIF

            loc_cSQL       = "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cMovimentacao)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")

            IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
                GarantirClasse("FormSigMvPdt")
                loc_oForm = CREATEOBJECT("FormSigMvPdt", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                ENDIF
            ENDIF

            IF USED("cursor_4c_TmpOpe")
                USE IN cursor_4c_TmpOpe
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSubNiveisClick - Abre a tela de Subniveis do item corrente (legado:
    * SubNiveis.Click = Do Form SigMvSbn with Thisform, Empresa,
    * Movimentacao, Numero - sem guarda no legado, transcrito igual; o
    * proprio FormSigMvSbn tolera Empresa/Movimentacao vazios).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSubNiveisClick()
        LOCAL loc_cCursor, loc_cEmpresa, loc_cMovimentacao, loc_nNumero, loc_oForm

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        loc_cEmpresa      = ""
        loc_cMovimentacao = ""
        loc_nNumero       = 0

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            loc_cEmpresa      = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Empresa"), ""))
            loc_cMovimentacao = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Movimentacao"), ""))
            loc_nNumero       = TratarNulo(EVALUATE(loc_cCursor + ".Numero"), 0)
        ENDIF

        GarantirClasse("FormSigMvSbn")
        loc_oForm = CREATEOBJECT("FormSigMvSbn", THIS, loc_cEmpresa, loc_cMovimentacao, loc_nNumero)
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRetornarClick - Volta para a pagina de Filtros (legado:
    * cmgRetornar.btnRetornar.Click = ThisForm.pgfPrincipal.ActivePage = 1).
    *--------------------------------------------------------------------------
    PROCEDURE BtnRetornarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do REPORT FORM SigOpPck (legado:
    * btnVisualizar.Click = Index on SubGrupo+Codigo_Item + Report Form
    * SigOpPck Preview). Guard de arquivo ausente (regra #25/#49 do
    * CLAUDE.md) - o FRX ainda nao foi portado nesta fase.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.ExecutarRelatorioSigOpPck("PREVIEW")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime o REPORT FORM SigOpPck com prompt de
    * impressora (legado: BtnImprimir.Click = Index on SubGrupo+Codigo_Item
    * + Report Form SigOpPck To PRINTER Prompt).
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.ExecutarRelatorioSigOpPck("PRINTER_PROMPT")
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRelatorioSigOpPck - Funil comum de Visualizar/Imprimir: ordena
    * o cursor de resultado (legado: Index on SubGrupo + Codigo_Item Tag
    * Ordem1), isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRX legado Fortyus
    * - regra do CLAUDE.md sobre isolamento de locale em REPORT FORM) e
    * dispara o REPORT FORM, com guard de arquivo ausente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarRelatorioSigOpPck(par_cModo)
        LOCAL loc_cCursor, loc_cFrx, loc_cPointAnt, loc_cSeparatorAnt, ;
            loc_nBehaviorAnt, loc_oErro

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para " + ;
                IIF(par_cModo = "PREVIEW", "visualizar", "imprimir") + ".", ;
                "Relat" + CHR(243) + "rio")
            RETURN
        ENDIF

        loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SigOpPck.frx")

        IF !FILE(loc_cFrx)
            MostrarErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + loc_cFrx, "Erro")
            RETURN
        ENDIF

        SELECT (loc_cCursor)

        *-- O legado reindexa SO no Visualizar (btnVisualizar.Click = Index
        *-- on SubGrupo + Codigo_Item Tag Ordem1 + Go Top + Report Form ...
        *-- Preview); o Imprimir (BtnImprimir.Click) faz apenas Go Top +
        *-- Report Form ... To PRINTER Prompt, mantendo a ordem corrente
        *-- (Ordem3, posta por SigOpPckBO.MontarCursorDados). Reindexar nos
        *-- dois mudaria a ordem do relatorio IMPRESSO.
        IF par_cModo = "PREVIEW"
            INDEX ON SubGrupo + Codigo_Item TAG Ordem1
        ENDIF

        GO TOP

        loc_cPointAnt     = SET("POINT")
        loc_cSeparatorAnt = SET("SEPARATOR")
        loc_nBehaviorAnt  = SET("REPORTBEHAVIOR")

        TRY
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            IF par_cModo = "PREVIEW"
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Gerar Relat" + CHR(243) + "rio")
        ENDTRY

        SET POINT TO (loc_cPointAnt)
        SET SEPARATOR TO (loc_cSeparatorAnt)
        SET REPORTBEHAVIOR (loc_nBehaviorAnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarXLS - Exporta o cursor de resultado para planilha XLS (legado:
    * ThisForm.GerarXLS() = PutFile + Select ... Order By ... Into Cursor
    * crExcel + Copy To ... Type Xl5).
    *--------------------------------------------------------------------------
    PROCEDURE GerarXLS()
        LOCAL loc_cCursor, loc_cArquivo

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para exportar.", ;
                "Exporta" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS")

        IF !EMPTY(loc_cArquivo)
            IF USED("cursor_4c_Excel")
                USE IN cursor_4c_Excel
            ENDIF

            SELECT * FROM (loc_cCursor) ;
                ORDER BY Destino, Ordem, Data_Venda, Movimentacao, Numero ;
                INTO CURSOR cursor_4c_Excel

            SELECT cursor_4c_Excel
            COPY TO (loc_cArquivo) TYPE XL5
            USE IN cursor_4c_Excel

            MsgInfo('O Arquivo "' + ALLTRIM(loc_cArquivo) + '" Foi Gerado!!!', ;
                "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - this_oBusinessObject e o restauro do menu ja sao tratados em
    * FormBase.Destroy(); DODEFAULT() tem de ser a ULTIMA linha (regra do
    * fix menu-shrinks, Erro58).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
