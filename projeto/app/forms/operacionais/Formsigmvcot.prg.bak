*==============================================================================
* Formsigmvcot.prg - Cotacao de Compras (OPERACIONAL)
* Migrado de SIGMVCOT.SCX
*
* Form OPERACIONAL customizado (NAO segue padrao CRUD Page1=Lista/Page2=Dados):
* wizard de 4 paginas com abas VISIVEIS (o legado nao esconde o PageFrame -
* Page1.FontBold/FontName/FontSize/ForeColor sao a formatacao das proprias
* abas), navegado por botoes que habilitam/desabilitam paginas em sequencia:
*
*   Page1 pgFiltros  "Filtros"   - filtros de periodo/empresa/operacao/job
*   Page2 pgDados    "Dados"     - grade de Movimentacoes + Cotacoes em Aberto
*   Page3 pgCotacoes "Cotacoes"  - fornecedores/produtos da cotacao corrente
*   Page4 pgPedidos  "Pedidos"   - geracao de pedidos de compra a partir da cotacao
*
* Sem cabecalho cnt_4c_Cabecalho (o legado nao tem cntSombra/lblSombra/lblTitulo
* neste form - regra #11 do CLAUDE.md nao se aplica) e sem containers CRUD
* cnt_4c_Botoes/cnt_4c_Saida (cada pagina tem seu proprio CommandGroup de
* navegacao, criado na Fase 4).
*
* Herda de: FormBase
* BO: sigmvcotBO (cabecalho SigCtTDc - cidchaves/codigos)
*
* Historico de fases:
*   Fase 1/2: sigmvcotBO.prg (propriedades + CRUD do cabecalho SigCtTDc)
*   Fase 3:   Formsigmvcot.prg - estrutura base (heranca, Init, PageFrame 4 paginas)
*   Fase 4:   Page1 (Filtros) completa - campos Periodo/Operacao/Empresa/Job,
*             CommandGroup Processar/Encerrar, validacoes/lookups e AlternarPagina;
*             Page2 (Dados) completa - ConfigurarPaginaLista com as duas grades
*             (Movimentacoes em aberto e Cotacoes Realizadas), os 7 CommandGroups
*             de acao, o OptionGroup "Gerar Produtos", CarregarLista (carga real
*             das duas grades) e os handlers de marcacao/selecao
*   Fase 5:   Page4 (Pedidos) - ConfigurarPaginaDados com o container
*             cnt_4c_Operacao (cabecalho da operacao de pedido: Empresa, Data,
*             Operacao, Moeda, Job, Destino, Entrega, Obs.), os tres
*             CommandGroups de navegacao/acao da pagina, AjustarCamposPedidos
*             (equivalente aos PROCEDURE When do legado) e o retorno para a
*             pagina de Cotacoes
*==============================================================================

DEFINE CLASS Formsigmvcot AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - valores exatos do SCX original)
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 590
    DataSession  = 2
    BorderStyle  = 2
    AutoCenter   = .T.
    Caption      = "Cota" + CHR(231) + CHR(227) + "o de Compras"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ClipControls = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Business Object
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Controle de modo/pagina ativa: FILTROS / DADOS / COTACOES / PEDIDOS
    *--------------------------------------------------------------------------
    this_cModoAtual = "FILTROS"

    *--------------------------------------------------------------------------
    * Propriedades equivalentes ao ThisForm.loObj do legado (CreateObject
    * [Relation] + AddProperty). Flatten para propriedades this_ do form,
    * em vez de objeto aninhado (PILAR 3 - arquitetura nova).
    *--------------------------------------------------------------------------
    this_dDtPerI     = {}   && loObj.DtPerI  - data inicial do filtro de periodo
    this_dDtPerF     = {}   && loObj.DtPerF  - data final do filtro de periodo
    this_cDopes      = ""   && loObj.Dopes   - operacao filtrada (SigCdOpe.dopes)
    this_cEmps       = ""   && loObj.Emps    - empresa filtrada (SigCdEmp.cemps)
    this_cPcEscolha  = ""   && loObj.pcEscolha - INSERIR/ALTERAR/EXCLUIR/CONSULTAR
    this_lCopiando   = .F.  && loObj.Copiando  - .T. quando a cotacao esta sendo copiada
    this_lLibSolics  = .F.  && loObj.LibSolics - acesso a liberar solicitacoes (fChecaAcesso)
    this_cJobs       = ""   && loObj.Jobs    - job filtrado (para movimentacao por job)
    this_oConsulta   = .NULL. && loObj.Consulta - referencia ao form SigOpCgp (consulta externa)

    *--------------------------------------------------------------------------
    * Parametros do sistema e linha corrente da grade de Cotacoes Realizadas.
    * this_nGesind espelha crSigCdPam.Gesind do legado (cursor global Fortyus
    * que o sistema novo nao pre-carrega - lido de SigCdPam em
    * CarregarParametrosSistema). Decide o esquema de cores da grade de
    * Movimentacoes (ver AplicarCoresGridOperacoes).
    *--------------------------------------------------------------------------
    this_nGesind            = 0    && SigCdPam.gesind - gestao industrial ligada (0/1)
    this_cMoedaPs           = ""   && SigCdPam.moedaps - moeda padrao do sistema (LiberaPagto/GravaPedidos)
    this_nCodigoSelecionado = 0    && crCotaPends.Codigos da linha corrente da grade
    this_cTagProduto        = ""   && GotFocus/LostFocus da Column1 (Produto) do grd_4c_Produtos

    *--------------------------------------------------------------------------
    * Guarda de reentrancia para os lookups de coluna de grid abertos a partir
    * de LostFocus (Column.Text1 nao aceita BINDEVENT("Valid") de forma
    * confiavel, entao o Show() modal do FormBuscaAuxiliar fica pendurado no
    * LostFocus da celula). Sem a guarda, o Show() bloqueante + o foco saindo
    * e voltando pode reentrar no mesmo LostFocus e empilhar um segundo picker
    * (mesma causa do Erro173 documentado no projeto).
    *--------------------------------------------------------------------------
    this_lAbrindoLookupGrid = .F.

    *--------------------------------------------------------------------------
    * Init - Chama FormBase.Init() que dispara InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura base
    * (PageFrame com as 4 paginas). Grids, botoes e campos de dados sao
    * adicionados nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvcotBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigmvcotBO", "Erro")
            ELSE
                THIS.CarregarParametrosSistema()
                THIS.CriarCursoresLista()
                THIS.CriarCursoresCotacao()
                THIS.CriarCursoresPedidos()

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaFiltros()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaCotacoes()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "FILTROS"

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame com as 4 paginas do wizard.
    * Abas VISIVEIS (Tabs = .T.) - o legado nao usa Top=-29/Tabs=.F. como o
    * padrao CRUD, e sim a navegacao normal por abas + botoes Enabled por
    * pagina (loFil.Enabled=.T./loDad.Enabled=.F./loCot.Enabled=.F./
    * loPed.Enabled=.F. no Init legado - so a pagina de Filtros comeca ativa).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top         = -1
            .Left        = 0
            .Width       = 1003
            .Height      = 589
            .PageCount   = 4
            .Tabs        = .T.
            .Visible     = .F.
            *-- PageFrame.BorderWidth eh READ-ONLY em runtime ("Property
            *-- BORDERWIDTH is read-only") e o SCX legado nao a declara.

            .Page1.Caption   = "Filtros"
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.FontName  = "Verdana"
            .Page1.FontSize  = 8
            .Page1.FontBold  = .T.
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(36, 84, 155)
            .Page1.Enabled   = .T.

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.FontName  = "Verdana"
            .Page2.FontSize  = 8
            .Page2.FontBold  = .T.
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(36, 84, 155)
            .Page2.Enabled   = .F.

            .Page3.Caption   = "Cota" + CHR(231) + CHR(245) + "es"
            .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page3.FontName  = "Verdana"
            .Page3.FontSize  = 8
            .Page3.FontBold  = .T.
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(36, 84, 155)
            .Page3.Enabled   = .F.

            .Page4.Caption   = "Pedidos"
            .Page4.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page4.FontName  = "Verdana"
            .Page4.FontSize  = 8
            .Page4.FontBold  = .T.
            .Page4.BackColor = RGB(255, 255, 255)
            .Page4.ForeColor = RGB(36, 84, 155)
            .Page4.Enabled   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Monta os controles da Page1 (pgFiltros):
    * shape de agrupamento visual, filtros de Periodo/Operacao/Empresa/Job
    * e o CommandGroup de navegacao (Processar/Encerrar). Espelha
    * SIGMVCOT.pgfPagina.pgFiltros do legado - Top/Left EXATOS do SCX
    * (pgf_4c_Paginas.Top = -1, sem a compensacao +29 do padrao CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Shape de agrupamento visual dos filtros
        loc_oPag.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPag.shp_4c_Shape1
            .Top           = 180
            .Left          = 16
            .Width         = 967
            .Height        = 119
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        *-- Periodo (Data Inicial a Data Final)
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 319
            .Top       = 194
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtPerI", "TextBox")
        WITH loc_oPag.txt_4c_DtPerI
            .Height        = 22
            .Left          = 385
            .Top           = 191
            .Width         = 80
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag.lbl_4c_Label9
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = CHR(224)
            .Left      = 471
            .Top       = 194
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtPerF", "TextBox")
        WITH loc_oPag.txt_4c_DtPerF
            .Height        = 22
            .Left          = 485
            .Top           = 191
            .Width         = 80
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Operacao (SigCdOpe.Dopes)
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Left      = 307
            .Top       = 219
            .Width     = 62
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPag.txt_4c_Dopes
            .FontName      = "Courier New"
            .FontSize      = 9
            .Format        = "K"
            .Height        = 22
            .Left          = 385
            .MaxLength     = 20
            .SpecialEffect = 1
            .Top           = 216
            .Width         = 150
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Empresa (SigCdEmp.Cemps/Razas)
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Left      = 312
            .Top       = 244
            .Width     = 57
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_CEmps", "TextBox")
        WITH loc_oPag.txt_4c_CEmps
            .FontName      = "Courier New"
            .FontSize      = 9
            .Alignment     = 0
            .Format        = "K"
            .Height        = 22
            .InputMask     = "!!!"
            .Left          = 385
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 241
            .Width         = 31
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPag.txt_4c_DEmps
            .FontName      = "Courier New"
            .Format        = "K"
            .Height        = 22
            .Left          = 419
            .MaxLength     = 40
            .SpecialEffect = 1
            .Top           = 241
            .Width         = 238
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Job/Conta (SigCdCli.IClis/RClis)
        loc_oPag.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPag.lbl_4c_Label25
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = "Job :"
            .Left      = 347
            .Top       = 268
            .Width     = 32
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Job", "TextBox")
        WITH loc_oPag.txt_4c_Job
            .FontName      = "Courier New"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 21
            .Left          = 385
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 266
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(0, 0, 128)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Djob", "TextBox")
        WITH loc_oPag.txt_4c_Djob
            .FontName      = "Courier New"
            .Format        = "K"
            .Height        = 21
            .Left          = 467
            .MaxLength     = 40
            .SpecialEffect = 1
            .Top           = 266
            .Width         = 304
            .BorderColor   = RGB(0, 0, 128)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- CommandGroup de navegacao (Processar / Encerrar)
        loc_oPag.AddObject("obj_4c_CmdBotoes", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdBotoes
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 110
            .Left        = 823
            .Top         = 7
            .Width       = 170
            .Visible     = .T.

            WITH .Buttons(1)
                .Top           = 5
                .Left          = 5
                .Height        = 100
                .Width         = 80
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption       = "Processar"
                .MousePointer  = 15
                .ToolTipText   = "Processar os Dados"
                .SpecialEffect = 0
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top           = 5
                .Left          = 85
                .Height        = 100
                .Width         = 80
                .FontSize      = 8
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Encerrar"
                .MousePointer  = 15
                .ToolTipText   = "Sair do Cadastro"
                .SpecialEffect = 0
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Teclado: Enter/Tab valida contra a tabela, F4 abre o lookup direto
        BINDEVENT(loc_oPag.txt_4c_CEmps, "KeyPress", THIS, "TeclaCEmps")
        BINDEVENT(loc_oPag.txt_4c_DEmps, "KeyPress", THIS, "TeclaDEmps")
        BINDEVENT(loc_oPag.txt_4c_Dopes, "KeyPress", THIS, "TeclaDopes")
        BINDEVENT(loc_oPag.txt_4c_Job,   "KeyPress", THIS, "TeclaJob")
        BINDEVENT(loc_oPag.txt_4c_Djob,  "KeyPress", THIS, "TeclaDjob")

        BINDEVENT(loc_oPag.obj_4c_CmdBotoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
        BINDEVENT(loc_oPag.obj_4c_CmdBotoes.Buttons(2), "Click", THIS, "BtnSairClick")

        *-- Valores padrao (empresa atual + periodo = hoje), como no Init legado
        THIS.CarregarPadroesFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPadroesFiltros - Preenche os valores iniciais dos filtros
    * (Periodo = hoje, Empresa = empresa atual) - equivalente ao trecho do
    * Init legado que faz loFil.getCEmps.Value = _Empr / getDtPerI.Value =
    * Date() apos o CursorQuery em SigCdEmp. Consulta SQL e SetFocus ficam
    * fora do modo de teste (gb_4c_ModoTeste), que roda sem conexao ao banco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarPadroesFiltros()
        LOCAL loc_oPag, loc_cSQL, loc_nResultado

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DtPerI.Value = DATE()
        loc_oPag.txt_4c_DtPerF.Value = DATE()

        IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            loc_oPag.txt_4c_CEmps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpPadrao")

            IF loc_nResultado > 0 AND USED("cursor_4c_EmpPadrao") AND !EOF("cursor_4c_EmpPadrao")
                loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpPadrao.Razas)
            ENDIF

            IF USED("cursor_4c_EmpPadrao")
                USE IN cursor_4c_EmpPadrao
            ENDIF

            loc_oPag.txt_4c_DtPerI.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCEmps/TeclaDEmps/TeclaDopes/TeclaJob/TeclaDjob - Handlers de
    * KeyPress dos filtros: F4 (115) abre o lookup direto, Enter (13) ou
    * Tab (9) valida o valor digitado contra a tabela (equivalente ao Valid
    * do legado, que nao se liga de forma confiavel via BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDesEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDesEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDopes(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperacao()
        ENDIF
    ENDPROC

    PROCEDURE TeclaJob(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaJobCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarJobCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDjob(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaJobDescricao()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarJobDescricao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Empresa (SigCdEmp.Cemps/Razas) - equivalente a fAcessoEmpresa('C'/'D',
    * this.Value, getCEmps, getDEmps) do legado (fAcessoEmpresa nao portada -
    * ver docs/GUIA_RAPIDO_MIGRACAO.md / memoria "facessoempresa_nao_portada").
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResultado

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_CEmps.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DEmps.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
            loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
        ELSE
            loc_oPag.txt_4c_DEmps.Value = ""
            THIS.AbrirBuscaEmpresa()
        ENDIF

        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_CEmps.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPag.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPag.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    PROCEDURE ValidarDesEmpresa()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResultado

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_DEmps.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_CEmps.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_EmpDVal") AND !EOF("cursor_4c_EmpDVal")
            loc_oPag.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_EmpDVal.Cemps)
        ELSE
            THIS.AbrirBuscaDesEmpresa()
        ENDIF

        IF USED("cursor_4c_EmpDVal")
            USE IN cursor_4c_EmpDVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDesEmpresa()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_DEmps.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                loc_oPag.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        loc_oPag.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Operacao (SigCdOpe.Dopes) - equivalente ao getDopes.Valid do legado
    * (a checagem original contra crCotReq/fAcessoMovmto pertence a carga da
    * Page2 - crCotReq e populado na fase que constroi as Cotacoes em Aberto;
    * aqui a operacao e validada diretamente contra o cadastro SigCdOpe).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResultado

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Dopes.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_OpeVal") AND !EOF("cursor_4c_OpeVal")
            loc_oPag.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_OpeVal.Dopes)
        ELSE
            THIS.AbrirBuscaOperacao()
        ENDIF

        IF USED("cursor_4c_OpeVal")
            USE IN cursor_4c_OpeVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Dopes.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
            "Selecionar Opera" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPag.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        loc_oPag.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Job/Conta (SigCdCli.IClis/RClis) - equivalente a fAcessoContas(Usuar,
    * Grupo, 'C'/'D', this.Value, getjob, getdjob, ...) do legado, sem grupo
    * (fAcessoContas nao usada como lookup UX - ver memoria
    * "facessocontas_lookup_ux": substituicao canonica por SELECT direto +
    * FormBuscaAuxiliar).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarJobCodigo()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResultado

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Job.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_Djob.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_JobVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_JobVal") AND !EOF("cursor_4c_JobVal")
            loc_oPag.txt_4c_Djob.Value = ALLTRIM(cursor_4c_JobVal.RClis)
        ELSE
            loc_oPag.txt_4c_Djob.Value = ""
            THIS.AbrirBuscaJobCodigo()
        ENDIF

        IF USED("cursor_4c_JobVal")
            USE IN cursor_4c_JobVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaJobCodigo()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Job.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaJob", "IClis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPag.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.IClis)
                loc_oPag.txt_4c_Djob.Value = ALLTRIM(cursor_4c_BuscaJob.RClis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJob")
                        loc_oPag.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.IClis)
                        loc_oPag.txt_4c_Djob.Value = ALLTRIM(cursor_4c_BuscaJob.RClis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaJob")
            USE IN cursor_4c_BuscaJob
        ENDIF
    ENDPROC

    PROCEDURE ValidarJobDescricao()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResultado

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Djob.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_Job.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RClis = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_JobDVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_JobDVal") AND !EOF("cursor_4c_JobDVal")
            loc_oPag.txt_4c_Job.Value = ALLTRIM(cursor_4c_JobDVal.IClis)
        ELSE
            THIS.AbrirBuscaJobDescricao()
        ENDIF

        IF USED("cursor_4c_JobDVal")
            USE IN cursor_4c_JobDVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaJobDescricao()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Djob.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaJobD", "RClis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPag.txt_4c_Djob.Value = ALLTRIM(cursor_4c_BuscaJobD.RClis)
                loc_oPag.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJobD.IClis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJobD")
                        loc_oPag.txt_4c_Djob.Value = ALLTRIM(cursor_4c_BuscaJobD.RClis)
                        loc_oPag.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJobD.IClis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaJobD")
            USE IN cursor_4c_BuscaJobD
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Valida os filtros e, confirmado, guarda os valores
    * em propriedades this_ do form (equivalente a ThisForm.loObj) e navega
    * para a Page2 (Dados). Espelha cmdBotoes.btnProcessar.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oPag, loc_lConfirma

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF EMPTY(loc_oPag.txt_4c_DtPerI.Value)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos...")
            loc_oPag.txt_4c_DtPerI.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_oPag.txt_4c_DtPerF.Value)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos...")
            loc_oPag.txt_4c_DtPerF.SetFocus()
            RETURN
        ENDIF

        IF loc_oPag.txt_4c_DtPerI.Value > loc_oPag.txt_4c_DtPerF.Value
            MsgAviso("Data Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", ;
                "Dados Inv" + CHR(225) + "lidos...")
            loc_oPag.txt_4c_DtPerI.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_oPag.txt_4c_Dopes.Value)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                "Dados Inv" + CHR(225) + "lidos...")
            loc_oPag.txt_4c_Dopes.SetFocus()
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma o Processamento?", "Confirma" + CHR(231) + CHR(227) + "o!!!")

        IF loc_lConfirma
            THIS.this_dDtPerI = loc_oPag.txt_4c_DtPerI.Value
            THIS.this_dDtPerF = loc_oPag.txt_4c_DtPerF.Value
            THIS.this_cDopes  = ALLTRIM(loc_oPag.txt_4c_Dopes.Value)
            THIS.this_cEmps   = ALLTRIM(loc_oPag.txt_4c_CEmps.Value)
            THIS.this_cJobs   = ALLTRIM(loc_oPag.txt_4c_Job.Value)

            THIS.Processamento()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Encerra o form (equivalente a cmdBotoes.btnSair.Click).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Habilita a pagina de destino e desabilita as demais,
    * espelhando o padrao usado pelo legado em cada CommandGroup de navegacao
    * (loFil.Enabled/.pgDados.Enabled/... + ActivePage + Refresh).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPgf

        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.Page1.Enabled = (par_nPagina = 1)
        loc_oPgf.Page2.Enabled = (par_nPagina = 2)
        loc_oPgf.Page3.Enabled = (par_nPagina = 3)
        loc_oPgf.Page4.Enabled = (par_nPagina = 4)

        loc_oPgf.ActivePage = par_nPagina
        loc_oPgf.Refresh()

        *-- A pagina de Pedidos reavalia os When dos campos de cntOperacao ao
        *-- ser aberta (o modo corrente pode ter mudado desde a ultima vez).
        IF par_nPagina = 4
            THIS.AjustarCamposPedidos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Equivalente a ThisForm.Processamento do legado: com os
    * filtros validados e confirmados em BtnProcessarClick, carrega as duas
    * grades da pagina Dados e so entao avanca da pagina Filtros (1) para a
    * pagina Dados (2). Se CarregarLista nao encontrou nada, o legado avisa e
    * PERMANECE na pagina de Filtros (o SetFocus volta para getDtPerI).
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        IF THIS.CarregarLista()
            THIS.this_cModoAtual = "DADOS"
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Le SigCdPam.gesind (tabela de parametros do
    * sistema, de linha unica) para this_nGesind. No legado esse valor vem do
    * cursor global crSigCdPam, que o Framework Fortyus pre-carregava no login
    * e que a arquitetura nova nao possui - por isso a leitura acontece aqui.
    * SigCdPam NAO tem coluna Emps: nao filtrar por empresa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_nResultado, loc_oErro

        THIS.this_nGesind    = 0
        THIS.this_lLibSolics = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.this_lLibSolics = .T.
            RETURN
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        *-- LibSolics (loObj.LibSolics do legado) = fChecaAcesso("SIGMVCOT",
        *-- "LIBSOLICS") - acesso para liberar/aprovar a solicitacao mesmo sem
        *-- ser o AprSols designado. Guardado em TRY separado: uma falha aqui
        *-- nao pode impedir a leitura de this_nGesind logo abaixo.
        TRY
            THIS.this_lLibSolics = fChecaAcesso("SIGMVCOT", "LIBSOLICS", .F.)
        CATCH TO loc_oErro
            THIS.this_lLibSolics = .F.
        ENDTRY

        IF !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_Parametros")
                USE IN cursor_4c_Parametros
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT gesind, moedaps FROM SigCdPam", "cursor_4c_Parametros")

            IF loc_nResultado > 0 AND USED("cursor_4c_Parametros")
                SELECT cursor_4c_Parametros
                GO TOP IN cursor_4c_Parametros
                IF !EOF("cursor_4c_Parametros")
                    THIS.this_nGesind  = NVL(cursor_4c_Parametros.gesind, 0)
                    THIS.this_cMoedaPs = ALLTRIM(NVL(cursor_4c_Parametros.moedaps, ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_Parametros")
                USE IN cursor_4c_Parametros
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ler os par" + CHR(226) + "metros do sistema (SigCdPam):" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresLista - Cria os cursores das duas grades da pagina Dados,
    * com a estrutura EXATA do PROCEDURE Load legado:
    *
    *   crOperacoes  -> cursor_4c_Movimentacao    (grade de Movimentacoes)
    *   crCotaPends  -> grade de Cotacoes Realizadas (grd_4c_CotaPends, cursor local)
    *
    * CREATE CURSOR nasce READWRITE, o que eh pre-requisito para a coluna de
    * marcacao (CheckBox) do grid de Movimentacoes aceitar o REPLACE feito
    * pelos handlers de clique/tecla. Tipos e tamanhos transcritos do legado
    * sem "correcoes" (Nops n(6) e Itens n(6) sao os do Load original).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresLista()
        IF USED("cursor_4c_Movimentacao")
            USE IN cursor_4c_Movimentacao
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Movimentacao ( ;
            Marcas     L(1),  Emps       C(3),  Dopes      C(20), Numes      N(6), ;
            Datas      D(8),  Itens      N(6),  EmpDopNums C(29), Nops       N(6), ;
            ChkSubn    L(1),  LCancelas  L(1),  ChkBxParcs L(1),  ChkPagos   L(1), ;
            ProcBals   L(1),  ProcDBal   L(1),  Destinos   N(1),  EstDests   N(1), ;
            EstOrigs   N(1),  Origems    N(1),  Produc     N(1),  Jobs       C(10))
        SET NULL OFF

        INDEX ON DTOS(Datas) + EmpDopNums TAG Ordem

        IF USED("cursor_4c_CotasPendentes")
            USE IN cursor_4c_CotasPendentes
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_CotasPendentes ( ;
            Situas     N(1),  Codigos    N(6),  DtSolics   D(8),  Solicitas  C(10), ;
            Deptos     C(10), Prioris    C(10), DtCotas    D(8),  DtAprovs   D(8), ;
            Aprovador  C(10), ContaEs    C(10), LocalEnts  N(10), Justificas M(4), ;
            Copias     N(6))
        SET NULL OFF

        INDEX ON Codigos TAG Ordem
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta a Page2 (pgDados do legado), que eh a
    * pagina de LISTA deste form OPERACIONAL: as duas grades (Movimentacoes
    * em aberto e Cotacoes Realizadas) e os CommandGroups de acao sobre elas.
    *
    * Top/Left EXATOS do SCX. O PageFrame deste form tem Top = -1 e abas
    * VISIVEIS - NAO existe aqui a compensacao +29 do padrao CRUD.
    *
    * Ordem de criacao = ordem do SCX, de cima para baixo, para que o z-order
    * final fique igual ao legado (o CommandGroup "Retornar aos Filtros",
    * marcado com o maior ZOrderSet, eh criado por ultimo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        *-- Titulo da grade de Movimentacoes (Say5 do legado)
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Caption   = "\<Movimenta" + CHR(231) + CHR(245) + "es"
            .Top       = 7
            .Left      = 250
            .Width     = 110
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Grade de Movimentacoes em aberto (grdOperacoes -> crOperacoes)
        THIS.ConfigurarGridOperacoes(loc_oPag)

        *-- Marcar / Desmarcar todas as movimentacoes (cmdMarcaDesmarca)
        loc_oPag.AddObject("obj_4c_CmdMarcaDesmarca", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdMarcaDesmarca
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Top         = 169
            .Left        = 668
            .Width       = 160
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
                .Caption         = "Marcar Todas"
                .MousePointer    = 15
                .ToolTipText     = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 0
                .Left            = 80
                .Height          = 100
                .Width           = 80
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                .Caption         = "Desmarcar Todas "
                .MousePointer    = 15
                .ToolTipText     = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Gerar Cotacoes a partir das movimentacoes marcadas (cmdCotar)
        loc_oPag.AddObject("obj_4c_CmdCotar", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdCotar
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 169
            .Left        = 828
            .Width       = 80
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "Gerar Cota" + CHR(231) + CHR(245) + "es"
                .MousePointer    = 15
                .ToolTipText     = "Gerar Cota" + CHR(231) + CHR(245) + "es"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Cotacao sem origem / "Cotacao Livre" (cmdProblemas). A visibilidade
        *-- depende do acesso SIGMVCOT/COTSEMOPE, avaliado em CarregarLista.
        loc_oPag.AddObject("obj_4c_CmdProblemas", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdProblemas
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 169
            .Left        = 908
            .Width       = 80
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .Caption         = "Cota" + CHR(231) + CHR(227) + "o Livre"
                .MousePointer    = 15
                .ToolTipText     = "Gerar Cota" + CHR(231) + CHR(227) + "o Sem Origem"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Filtro "Gerar Produtos" (optFiltro): Todos / Com Estoque / Sem Estoque
        loc_oPag.AddObject("obj_4c_OptFiltro", "OptionGroup")
        WITH loc_oPag.obj_4c_OptFiltro
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 277
            .Left        = 875
            .Width       = 105
            .Height      = 64
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Todos"
                .Left      = 5
                .Top       = 5
                .Width     = 94
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Com Estoque"
                .Left      = 5
                .Top       = 24
                .Width     = 94
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Sem Estoque"
                .Left      = 5
                .Top       = 44
                .Width     = 94
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDWITH

        *-- Rotulo do filtro "Gerar Produtos :" (Say2 do legado)
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Caption   = "\<Gerar Produtos :"
            .Top       = 283
            .Left      = 765
            .Width     = 105
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Titulo da grade de Cotacoes Realizadas (Say1 do legado)
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Caption   = "Cota" + CHR(231) + CHR(245) + "es \<Realizadas"
            .Top       = 294
            .Left      = 250
            .Width     = 140
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Grade de Cotacoes Realizadas (grdCotaPends -> crCotaPends)
        THIS.ConfigurarGridCotaPends(loc_oPag)

        *-- Visualizar cotacao selecionada (cmdCotacoes1)
        loc_oPag.AddObject("obj_4c_CmdCotacoes1", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdCotacoes1
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 453
            .Left        = 668
            .Width       = 90
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .Caption         = "Visualizar Cota" + CHR(231) + CHR(227) + "o"
                .MousePointer    = 15
                .ToolTipText     = "Consultar Cota" + CHR(231) + CHR(245) + "es"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Alterar / Excluir cotacao selecionada (cmdCotacoes)
        loc_oPag.AddObject("obj_4c_CmdCotacoes", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdCotacoes
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Top         = 453
            .Left        = 748
            .Width       = 159
            .Height      = 102
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .Caption         = "Alterar Cota" + CHR(231) + CHR(227) + "o"
                .MousePointer    = 15
                .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(245) + "es"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 0
                .Left            = 80
                .Height          = 100
                .Width           = 80
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .Caption         = "Excluir Cota" + CHR(231) + CHR(227) + "o"
                .MousePointer    = 15
                .ToolTipText     = "Excluir Cota" + CHR(231) + CHR(245) + "es"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Copiar cotacao aprovada (cmdCopiar)
        loc_oPag.AddObject("obj_4c_CmdCopiar", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdCopiar
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 454
            .Left        = 908
            .Width       = 79
            .Height      = 101
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
                .Caption         = "Copiar Cota" + CHR(231) + CHR(227) + "o"
                .MousePointer    = 15
                .ToolTipText     = "Copiar Cota" + CHR(231) + CHR(245) + "es"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Retornar a pagina de Filtros (cmdBotoes) - por ULTIMO, para ficar
        *-- por cima, equivalente ao maior ZOrderSet do SCX
        loc_oPag.AddObject("obj_4c_CmdBotoes", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdBotoes
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Top         = 7
            .Left        = 902
            .Width       = 90
            .Height      = 110
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Cancel          = .T.
                .Caption         = " Retornar  aos Filtros"
                .MousePointer    = 15
                .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Filtros"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Eventos dos botoes da pagina Dados
        BINDEVENT(loc_oPag.obj_4c_CmdMarcaDesmarca.Buttons(1), "Click", THIS, "BtnMarcarTodasClick")
        BINDEVENT(loc_oPag.obj_4c_CmdMarcaDesmarca.Buttons(2), "Click", THIS, "BtnDesmarcarTodasClick")
        BINDEVENT(loc_oPag.obj_4c_CmdCotar.Buttons(1),         "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPag.obj_4c_CmdProblemas.Buttons(1),     "Click", THIS, "BtnCotacaoLivreClick")
        BINDEVENT(loc_oPag.obj_4c_CmdCotacoes1.Buttons(1),     "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPag.obj_4c_CmdCotacoes.Buttons(1),      "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPag.obj_4c_CmdCotacoes.Buttons(2),      "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPag.obj_4c_CmdCopiar.Buttons(1),        "Click", THIS, "BtnCopiarCotacaoClick")
        BINDEVENT(loc_oPag.obj_4c_CmdBotoes.Buttons(1),        "Click", THIS, "BtnRetornarFiltrosClick")

        *-- Estado inicial dos botoes de acao sobre a cotacao selecionada
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaCotacoes - Monta a Page3 (pgCotacoes do legado), onde o
    * usuario detalha fornecedores/produtos de uma cotacao e a acompanha ate a
    * aprovacao. Espelha SIGMVCOT.pgfPagina.pgCotacoes - Top/Left EXATOS do
    * SCX (mesma pagina "achatada", sem compensacao +29 do padrao CRUD, igual
    * as demais paginas deste wizard).
    *
    * NESTA FASE (5/8) entram so os campos ESCALARES do cabecalho da cotacao -
    * a linha Codigo/Solicitante/Depto/Comprador/Aprovador/datas/Prioridade,
    * todos espelhando crSigCtTDc.<campo> do legado. Ficam para a Fase 6:
    * as grades grdFornecs/grdCotacoes, o PageFrame aninhado pgfComplCots
    * (abas Adicionais/Aprovacao/Solicitas - eh la que mora o campo Aprovador
    * EDITAVEL com o lookup fwBuscaExt; o txt_4c_AprovadorCab daqui eh so o
    * espelho de leitura que fica na linha de cima, como no legado), os
    * campos de descricao/observacao/justificativa do produto selecionado
    * (getDPros/getObs/getJustificas), getCopias e os CommandGroups de acao
    * (cmdGravar/cmdEscolha/cmdBotoes/cmdProdutos), que dependem de metodos
    * (GravaDados/GeraPedidos/Impressao/ExcluiProduto) ainda nao escritos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaCotacoes()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page3

        *-- Codigo (crSigCtTDc.Codigos) - somente leitura, gerado pelo BO
        loc_oPag.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPag.lbl_4c_Label12
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "C" + CHR(243) + "digo"
            .Left      = 9
            .Top       = 120
            .Width     = 40
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPag.txt_4c_Codigos
            .FontName      = "Arial"
            .FontSize      = 8
            .FontBold      = .T.
            .Format        = "K"
            .Height        = 20
            .Left          = 9
            .Top           = 136
            .Width         = 48
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 128)
            .BorderColor   = RGB(0, 0, 128)
            .ReadOnly      = .T.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Solicitante (SigCdUsu.Usuarios/NComps)
        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Solicitante"
            .Left      = 86
            .Top       = 120
            .Width     = 62
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Solicitas", "TextBox")
        WITH loc_oPag.txt_4c_Solicitas
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 20
            .Left          = 86
            .Top           = 136
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Depto. (SigCdDpt.Codigos/Descricaos)
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Depto."
            .Left      = 195
            .Top       = 120
            .Width     = 39
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Deptos", "TextBox")
        WITH loc_oPag.txt_4c_Deptos
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 20
            .Left          = 195
            .Top           = 136
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Comprador (SigCdUsu.Usuarios/NComps)
        loc_oPag.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPag.lbl_4c_Label10
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Comprador"
            .Left      = 304
            .Top       = 120
            .Width     = 65
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Comprador", "TextBox")
        WITH loc_oPag.txt_4c_Comprador
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 20
            .Left          = 304
            .Top           = 136
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Aprovador (espelho de LEITURA do cabecalho - crSigCtTDc.Aprovador.
        *-- O campo EDITAVEL com o lookup fwBuscaExt fica em pgfComplCots.
        *-- pgAprovacao (Fase 6) - por isso o nome NAO repete txt_4c_Aprovador,
        *-- que sera usado la, evitando a colisao de objeto da regra #11.
        loc_oPag.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPag.lbl_4c_Label15
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Aprovador"
            .Left      = 413
            .Top       = 120
            .Width     = 62
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_AprovadorCab", "TextBox")
        WITH loc_oPag.txt_4c_AprovadorCab
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 20
            .Left          = 413
            .Top           = 136
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Solicitacao (data - crSigCtTDc.DtSolics)
        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Solicita" + CHR(231) + CHR(227) + "o"
            .Left      = 522
            .Top       = 120
            .Width     = 63
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtSolics", "TextBox")
        WITH loc_oPag.txt_4c_DtSolics
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 522
            .Top           = 136
            .Width         = 64
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Cotacao (data - crSigCtTDc.DtCotas)
        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Left      = 615
            .Top       = 120
            .Width     = 48
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtCotas", "TextBox")
        WITH loc_oPag.txt_4c_DtCotas
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 615
            .Top           = 136
            .Width         = 64
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Validade (data - crSigCtTDc.DtValids)
        loc_oPag.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag.lbl_4c_Label8
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Validade"
            .Left      = 708
            .Top       = 120
            .Width     = 50
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtValids", "TextBox")
        WITH loc_oPag.txt_4c_DtValids
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 708
            .Top           = 136
            .Width         = 64
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Pagamento (data - crSigCtTDc.DtPagtos)
        loc_oPag.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag.lbl_4c_Label9
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Pagamento"
            .Left      = 801
            .Top       = 120
            .Width     = 67
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DtPagtos", "TextBox")
        WITH loc_oPag.txt_4c_DtPagtos
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 801
            .Top           = 136
            .Width         = 64
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Prioridade (crSigCtTDc.Prioris - 1=Normal, 2=Media, 3=Alta;
        *-- RowSource TRANSCRITO do legado, indice 1-based - regra CLAUDE.md
        *-- #188, NUNCA inventar lista placeholder)
        loc_oPag.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPag.lbl_4c_Label11
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Prioridade"
            .Left      = 900
            .Top       = 120
            .Width     = 60
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("cbo_4c_Prioris", "ComboBox")
        WITH loc_oPag.cbo_4c_Prioris
            .FontName      = "Arial"
            .FontSize      = 8
            .FontBold      = .T.
            .Height        = 20
            .Left          = 900
            .Top           = 136
            .Width         = 90
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "  Normal,  " + CHR(205) + CHR(233) + "dia,  Alta"
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .ListIndex     = 1
            .Visible       = .T.
        ENDWITH

        *-- InteractiveChange do legado: cor do texto conforme a prioridade
        BINDEVENT(loc_oPag.cbo_4c_Prioris, "InteractiveChange", THIS, "AtualizarCorPrioridade")

        *-- Lookups dos campos de cabecalho (F4 abre, Enter/Tab valida - regra
        *-- do lookup do CLAUDE.md; nao ligados na Fase 5)
        BINDEVENT(loc_oPag.txt_4c_Solicitas, "KeyPress", THIS, "TeclaSolicitante")
        BINDEVENT(loc_oPag.txt_4c_Deptos,    "KeyPress", THIS, "TeclaDepartamento")
        BINDEVENT(loc_oPag.txt_4c_Comprador, "KeyPress", THIS, "TeclaCompradorCab")

        *====================================================================
        * FASE 6 - restante da Page3: campos de produto/rodape, sub-abas
        * (pgfComplCots), as duas grades (Fornecedores/Cotacoes) e os
        * CommandGroups de acao. Cada bloco tem metodo proprio para nao
        * transformar ConfigurarPaginaCotacoes num unico metodo gigante.
        *====================================================================
        THIS.ConfigurarCamposRodapeCotacao(loc_oPag)
        THIS.ConfigurarComplCots(loc_oPag)
        THIS.ConfigurarGridFornecs(loc_oPag)
        THIS.ConfigurarGridCotacoes(loc_oPag)
        THIS.ConfigurarBotoesCotacoes(loc_oPag)

        *-- Estado inicial dos When/ReadOnly desta pagina (sera reaplicado
        *-- sempre que uma cotacao for carregada - ver CarregarCotacaoSelecionada
        *-- e GeraCotacao)
        THIS.AjustarCamposCotacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposRodapeCotacao - Item A da Fase 6: campos de nivel raiz de
    * Page3 que faltavam - Shape2 (moldura decorativa), Descricao/Observacao/
    * Justificativa do PRODUTO corrente da grade (getDPros/getObs/getJustificas,
    * espelhos de crSigCtTCt da linha corrente - por isso ReadOnly nao se aplica
    * a Obs/Justificas, que sao editaveis quando a linha permite) e Copias
    * (Codigo da cotacao original, sempre .F. no When - so exibicao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposRodapeCotacao(par_oPagina)
        LOCAL loc_oPag
        loc_oPag = par_oPagina

        *-- Moldura decorativa do rodape (Shape2 do legado)
        loc_oPag.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPag.shp_4c_Shape2
            .Top           = 482
            .Left          = 8
            .Width         = 987
            .Height        = 76
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        *-- "Descricao do Produto" (Say2) + getDPros (espelho de leitura de
        *-- crSigCtTCt.DPros da linha corrente do grdCotacoes)
        loc_oPag.AddObject("lbl_4c_Label2b", "Label")
        WITH loc_oPag.lbl_4c_Label2b
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Left      = 15
            .Top       = 484
            .Width     = 122
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DPros", "TextBox")
        WITH loc_oPag.txt_4c_DPros
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 20
            .Left          = 15
            .Top           = 498
            .Width         = 258
            .MaxLength     = 65
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- "Observacao do Produto" (Say1) + getObs (crSigCtTCt.Obs, editavel)
        loc_oPag.AddObject("lbl_4c_Label1b", "Label")
        WITH loc_oPag.lbl_4c_Label1b
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
            .Left      = 277
            .Top       = 484
            .Width     = 134
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oPag.obj_4c_GetObs
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 277
            .Top           = 498
            .Width         = 384
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- "Justificativa do Produto" (Say3) + getJustificas (crSigCtTCt.Justificas)
        loc_oPag.AddObject("lbl_4c_Label3b", "Label")
        WITH loc_oPag.lbl_4c_Label3b
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Justificativa do Produto"
            .Left      = 16
            .Top       = 519
            .Width     = 136
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_GetJustificas", "EditBox")
        WITH loc_oPag.obj_4c_GetJustificas
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 16
            .Top           = 533
            .Width         = 644
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- "Cotacao Original :" (Say13 de Page3) + getCopias (crSigCtTDc.Copias -
        *-- codigo da cotacao que deu origem a esta, quando copiada - When
        *-- sempre .F. no legado, so exibicao)
        loc_oPag.AddObject("lbl_4c_Label13b", "Label")
        WITH loc_oPag.lbl_4c_Label13b
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o Original :"
            .Left      = 782
            .Top       = 511
            .Width     = 100
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Copias", "TextBox")
        WITH loc_oPag.txt_4c_Copias
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "999999"
            .InputMask     = "999999"
            .Height        = 20
            .Left          = 905
            .Top           = 508
            .Width         = 57
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .ReadOnly      = .T.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Obs/Justificas do produto seguem a linha corrente do grdCotacoes -
        *-- o AfterRowColChange do legado so faz .Refresh (o binding jah
        *-- reflete a linha); aqui, como nao ha ControlSource direto (os
        *-- valores sao ESPELHADOS manualmente da linha corrente, regra dos
        *-- campos de rodape de grid), o handler deste form copia os 3 campos.
        BINDEVENT(loc_oPag.txt_4c_DPros,           "LostFocus", THIS, "SalvarRodapeProdutoAtual")
        BINDEVENT(loc_oPag.obj_4c_GetObs,          "LostFocus", THIS, "SalvarRodapeProdutoAtual")
        BINDEVENT(loc_oPag.obj_4c_GetJustificas,   "LostFocus", THIS, "SalvarRodapeProdutoAtual")
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresCotacao - Cursores locais das grades de Page3 (Cotacoes):
    *
    *   cursor_4c_Produtos      -> crSigCtTCt  (grdCotacoes, itens da cotacao)
    *   cursor_4c_Fornecedores  -> crSigCtTFn  (grdFornecs, fornecedores A..F)
    *
    * Estrutura espelha docs/schema.sql (SigCtTCt/SigCtTFn), NUNCA o dump do
    * legado (regra #22). CREATE CURSOR nasce READWRITE - pre-requisito para os
    * REPLACE feitos pelos handlers de Valid/toggle das grades.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresCotacao()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos ( ;
            cIdChaves  C(20), Codigos N(6),    CItens     N(6),    CPros   C(14), ;
            DPros      C(65), CUnis   C(3),    CodCors    C(4),    CodTams C(4), ;
            EmpDopNums C(29), Obs     M(4),    Justificas M(4), ;
            Qtds       N(15,2), QtdAdqs  N(15,2), ValAdqs N(15,6), ;
            Marca01 L(1), Marca02 L(1), Marca03 L(1), Marca04 L(1), Marca05 L(1), Marca06 L(1), ;
            Unit01 N(15,6), Unit02 N(15,6), Unit03 N(15,6), Unit04 N(15,6), Unit05 N(15,6), Unit06 N(15,6), ;
            Tota01 N(15,6), Tota02 N(15,6), Tota03 N(15,6), Tota04 N(15,6), Tota05 N(15,6), Tota06 N(15,6))
        SET NULL OFF

        INDEX ON CItens TAG Ordem

        IF USED("cursor_4c_Fornecedores")
            USE IN cursor_4c_Fornecedores
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Fornecedores ( ;
            cIdChaves C(20), Codigos N(6), Grades C(1), IClis C(10), Fornecs C(40), ;
            Contatos  C(20), Tel1s   C(20), FPags  C(12), DtEnts D(8), ;
            Fretes    C(12), VlFretes N(11,2))
        SET NULL OFF

        INDEX ON Grades TAG Ordem
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarComplCots - Item B da Fase 6: PageFrame interno pgf_4c_ComplCots
    * (3 sub-abas: Adicionais/Aprovacao Final/Aprovacao Solicitante), criado em
    * Page3 - Top/Left/Width/Height EXATOS do SCX (pgfComplCots). Tabs = .T.:
    * sao 3 sub-telas alternadas manualmente pelo usuario (Complementos /
    * Aprovacao Final / Aprovacao Solicitante), nao um wizard escondido.
    *
    * Page1=pgAdicionais, Page2=pgAprovacao, Page3=pgSolicitas - mesma ordem de
    * criacao do SCX (regra #31: jamais setar ActivePage pelo PageOrder do
    * dump, so pela ordem Page1/Page2/Page3 usada aqui).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarComplCots(par_oPagina)
        LOCAL loc_oPgf, loc_oPg1, loc_oPg2, loc_oPg3

        par_oPagina.AddObject("pgf_4c_ComplCots", "PageFrame")
        loc_oPgf = par_oPagina.pgf_4c_ComplCots

        WITH loc_oPgf
            .Top       = 6
            .Left      = 407
            .Width     = 500
            .Height    = 100
            .PageCount = 3
            .Tabs      = .T.
            .Visible   = .T.

            .Page1.Caption   = "Complementos"
            .Page1.FontName  = "Verdana"
            .Page1.FontSize  = 8
            .Page1.FontBold  = .T.
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(36, 84, 155)

            .Page2.Caption   = "Aprova" + CHR(231) + CHR(227) + "o Final"
            .Page2.FontName  = "Verdana"
            .Page2.FontSize  = 8
            .Page2.FontBold  = .T.
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(36, 84, 155)

            .Page3.Caption   = "Aprova" + CHR(231) + CHR(227) + "o Solicitante"
            .Page3.FontName  = "Verdana"
            .Page3.FontSize  = 8
            .Page3.FontBold  = .T.
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oPg1 = loc_oPgf.Page1
        loc_oPg2 = loc_oPgf.Page2
        loc_oPg3 = loc_oPgf.Page3

        *====================================================================
        * Page1 - pgAdicionais (Entrega geral / Justificativa geral)
        *====================================================================
        loc_oPg1.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg1.lbl_4c_Label14
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Justificativa :"
            .Left      = 5
            .Top       = 20
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_GetJustGeral", "EditBox")
        WITH loc_oPg1.obj_4c_GetJustGeral
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 96
            .Top           = 18
            .Width         = 353
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg1.lbl_4c_Label13
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Entrega :"
            .Left      = 33
            .Top       = 42
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_ContaEs", "TextBox")
        WITH loc_oPg1.txt_4c_ContaEs
            .FontName      = "Arial"
            .FontSize      = 8
            .Alignment     = 3
            .Height        = 20
            .Left          = 96
            .Top           = 40
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DContaEs", "TextBox")
        WITH loc_oPg1.txt_4c_DContaEs
            .FontName      = "Arial"
            .FontSize      = 8
            .Alignment     = 3
            .Height        = 20
            .Left          = 178
            .Top           = 40
            .Width         = 271
            .MaxLength     = 50
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .ReadOnly      = .T.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- cmdEntrega (fwbtnp) - Do Form SigCdEnd no legado; SigCdEnd nao foi
        *-- portado (nao existe form equivalente no sistema novo). A resolucao
        *-- do cliente/grupo pela ContaEs eh transcrita; o passo de abrir a
        *-- tela de endereco vira um aviso encaminhando para o cadastro de
        *-- Clientes, que eh onde os enderecos de entrega devem ser mantidos.
        loc_oPg1.AddObject("cmd_4c_CmdEntrega", "CommandButton")
        WITH loc_oPg1.cmd_4c_CmdEntrega
            .Top           = 20
            .Left          = 451
            .Height        = 20
            .Width         = 20
            .Picture       = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
            .Caption       = ""
            .ToolTipText   = "Local de Entrega"
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.obj_4c_GetJustGeral, "KeyPress", THIS, "ValidarJustGeral")
        BINDEVENT(loc_oPg1.txt_4c_ContaEs,      "KeyPress",  THIS, "TeclaContaEsGeral")
        BINDEVENT(loc_oPg1.txt_4c_DContaEs,     "KeyPress",  THIS, "TeclaDContaEsGeral")
        BINDEVENT(loc_oPg1.cmd_4c_CmdEntrega,   "Click",     THIS, "BtnEntregaGeralClick")

        *====================================================================
        * Page2 - pgAprovacao (Aprovacao Final)
        *====================================================================
        loc_oPg2.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg2.lbl_4c_Label15
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Aprovador"
            .Left      = 7
            .Top       = 20
            .Width     = 71
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Aprovador", "TextBox")
        WITH loc_oPg2.txt_4c_Aprovador
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 20
            .Left          = 7
            .Top           = 36
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Data"
            .Left      = 89
            .Top       = 20
            .Width     = 32
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DtAprovs", "TextBox")
        WITH loc_oPg2.txt_4c_DtAprovs
            .FontName      = "Arial"
            .FontSize      = 8
            .InputMask     = "99/99/9999"
            .Height        = 20
            .Left          = 89
            .Top           = 36
            .Width         = 64
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Aprova" + CHR(231) + CHR(227) + "o"
            .Left      = 155
            .Top       = 21
            .Width     = 173
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_GetObsAprovs", "EditBox")
        WITH loc_oPg2.obj_4c_GetObsAprovs
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 155
            .Top           = 36
            .Width         = 295
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- chkAprovador - Picture normal (nao aprovado) / DownPicture (aprovado)
        loc_oPg2.AddObject("chk_4c_ChkAprovador", "CheckBox")
        WITH loc_oPg2.chk_4c_ChkAprovador
            .Top            = 17
            .Left           = 451
            .Height         = 40
            .Width          = 40
            .Style          = 1
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
            .DownPicture    = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
            .Alignment      = 0
            .Caption        = ""
            .SpecialEffect  = 1
            .BackColor      = RGB(255, 255, 255)
            .Value          = 0
            .Visible        = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Aprovador,    "KeyPress",  THIS, "TeclaAprovadorFinal")
        BINDEVENT(loc_oPg2.txt_4c_DtAprovs,     "KeyPress", THIS, "ValidarDtAprovs")
        BINDEVENT(loc_oPg2.obj_4c_GetObsAprovs, "KeyPress", THIS, "ValidarObsAprovs")
        BINDEVENT(loc_oPg2.chk_4c_ChkAprovador, "Click",     THIS, "ChkAprovadorClick")

        *====================================================================
        * Page3 - pgSolicitas (Aprovacao do Solicitante)
        *====================================================================
        loc_oPg3.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg3.lbl_4c_Label15
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Aprovador"
            .Left      = 5
            .Top       = 19
            .Width     = 71
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_AprSols", "TextBox")
        WITH loc_oPg3.txt_4c_AprSols
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 5
            .Top           = 35
            .Width         = 80
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .ReadOnly      = .T.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg3.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg3.lbl_4c_Label6
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Data"
            .Left      = 87
            .Top       = 19
            .Width     = 32
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_DtAprSols", "TextBox")
        WITH loc_oPg3.txt_4c_DtAprSols
            .FontName      = "Arial"
            .FontSize      = 8
            .InputMask     = "99/99/9999"
            .Height        = 20
            .Left          = 87
            .Top           = 35
            .Width         = 64
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        loc_oPg3.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg3.lbl_4c_Label1
            .FontBold  = .T.
            .FontSize  = 8
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Aprova" + CHR(231) + CHR(227) + "o"
            .Left      = 153
            .Top       = 20
            .Width     = 173
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("obj_4c_GetObsAprSols", "EditBox")
        WITH loc_oPg3.obj_4c_GetObsAprSols
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 20
            .Left          = 153
            .Top           = 35
            .Width         = 339
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.txt_4c_DtAprSols,     "KeyPress", THIS, "ValidarDtAprSols")
        BINDEVENT(loc_oPg3.obj_4c_GetObsAprSols, "KeyPress", THIS, "ValidarObsAprSols")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridFornecs - Item D da Fase 6: grade de Fornecedores A..F
    * (grdFornecs do legado, ligada a crSigCtTFn -> cursor_4c_Fornecedores).
    *
    * RENUMERACAO (PILAR 3): o SCX legado tem ColumnCount=9 mas usa nomes de
    * Column INVERTIDOS/reaproveitados (Column2 do codigo eh a 7a coluna
    * fisica, Column3/5/6/7/8/9/10 pulam o "Column4") - artefato de edicao do
    * Form Designer, documentado no CLAUDE.md como "numeracao rara". Aqui a
    * grade eh RENUMERADA em ordem natural e crescente, sem lacunas:
    *
    *   Column1=indicador(cor+Grades) Column2=Codigo   Column3=Fornecedor
    *   Column4=Contato               Column5=Telefone Column6=Condicao
    *   Column7=Entrega               Column8=Frete     Column9=Valor Frete
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridFornecs(par_oPagina)
        LOCAL loc_oGrid, loc_cCor

        par_oPagina.AddObject("grd_4c_Fornecedores", "Grid")
        loc_oGrid = par_oPagina.grd_4c_Fornecedores

        loc_cCor = ;
            "IIF(cursor_4c_Fornecedores.Grades = [A], RGB(0,0,128), " + ;
            "IIF(cursor_4c_Fornecedores.Grades = [B], RGB(0,128,0), " + ;
            "IIF(cursor_4c_Fornecedores.Grades = [C], RGB(185,0,0), " + ;
            "IIF(cursor_4c_Fornecedores.Grades = [D], RGB(128,64,0), " + ;
            "IIF(cursor_4c_Fornecedores.Grades = [E], RGB(255,128,0), RGB(128,128,192))))))"

        loc_oGrid.ColumnCount = 9

        WITH loc_oGrid
            .Top           = 164
            .Left          = 7
            .Width         = 984
            .Height        = 81
            .FontName      = "Tahoma"
            .FontSize      = 8
            .HeaderHeight  = 16
            .RowHeight     = 15
            .ScrollBars    = 3
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .F.
            .GridLineColor = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        loc_oGrid.ColumnCount = 9
        loc_oGrid.RecordSource          = "cursor_4c_Fornecedores"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Fornecedores.Grades"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Fornecedores.IClis"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Fornecedores.Fornecs"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Fornecedores.Contatos"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Fornecedores.Tel1s"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Fornecedores.FPags"
        loc_oGrid.Column7.ControlSource = "cursor_4c_Fornecedores.DtEnts"
        loc_oGrid.Column8.ControlSource = "cursor_4c_Fornecedores.Fretes"
        loc_oGrid.Column9.ControlSource = "cursor_4c_Fornecedores.VlFretes"

        WITH loc_oGrid.Column1
            .FontBold          = .T.
            .Alignment         = 2
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Sparse            = .F.
            .DynamicForeColor  = loc_cCor
            .Header1.Caption   = ""
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .FontBold          = .T.
            .Movable           = .F.
            .Resizable         = .F.
            .DynamicForeColor  = loc_cCor
            .Format            = "K"
            .Text1.MaxLength         = 10
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column3
            .Movable           = .F.
            .Resizable         = .F.
            .DynamicForeColor  = loc_cCor
            .Format            = "K"
            .Text1.MaxLength         = 40
            .Header1.Caption   = "Fornecedor"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column4
            .Movable           = .F.
            .Resizable         = .F.
            .Format            = "K"
            .Text1.MaxLength         = 20
            .Header1.Caption   = "Contato"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column5
            .Movable           = .F.
            .Resizable         = .F.
            .Format            = "K"
            .Text1.MaxLength         = 20
            .Header1.Caption   = "Telefone"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column6
            .Movable           = .F.
            .Resizable         = .F.
            .Format            = "K"
            .Text1.MaxLength         = 12
            .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column7
            .Alignment         = 3
            .Movable           = .F.
            .Resizable         = .F.
            .Format            = "E"
            .InputMask         = "99/99/9999"
            .Header1.Caption   = "Entrega"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        *-- Frete: lista fechada de 2 valores (Emitente/Destinatario), sem
        *-- item vazio - equivalente ao fwBuscaInt em crFretes do legado, que
        *-- so tinha essas duas opcoes fixas (regra CLAUDE.md #24: Format com M
        *-- eh multiple choice, InputMask vira a LISTA de valores validos).
        WITH loc_oGrid.Column8
            .Movable           = .F.
            .Resizable         = .F.
            .Format            = "KM"
            .InputMask         = "Emitente,Destinatario"
            .Header1.Caption   = "Frete"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column9
            .Alignment         = 3
            .Movable           = .F.
            .Resizable         = .F.
            .Format            = "999,999.99"
            .InputMask        = "999,999.99"
            .Header1.Caption   = "Valor Frete"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        *-- Larguras por ULTIMO (valores EXATOS do SCX, na ordem renumerada)
        loc_oGrid.Column1.Width = 16
        loc_oGrid.Column2.Width = 84
        loc_oGrid.Column3.Width = 307
        loc_oGrid.Column4.Width = 126
        loc_oGrid.Column5.Width = 120
        loc_oGrid.Column6.Width = 84
        loc_oGrid.Column7.Width = 58
        loc_oGrid.Column8.Width = 80
        loc_oGrid.Column9.Width = 80

        *-- Navegacao Tab/Shift+Tab identica em todas as colunas (Tab entra na
        *-- grade de Produtos, Shift+Tab volta para a Prioridade)
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column5.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column6.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column7.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column8.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")
        BINDEVENT(loc_oGrid.Column9.Text1, "KeyPress", THIS, "GridFornecsKeyPressComum")

        *-- Lookups (fwBuscaExt do legado -> FormBuscaAuxiliar canonico). Usa
        *-- LostFocus, nao Valid: BINDEVENT em "Valid" nao dispara de forma
        *-- confiavel em TextBox (licao ja registrada no projeto).
        BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "ValidarFornecedorCodigoGrid")
        BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "ValidarFornecedorNomeGrid")
        BINDEVENT(loc_oGrid.Column6.Text1, "KeyPress", THIS, "ValidarCondicaoPagtoGrid")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridCotacoes - Item C da Fase 6: grade de Produtos da cotacao
    * (grdCotacoes do legado, ligada a crSigCtTCt -> cursor_4c_Produtos).
    * ColumnCount=25 - numeracao IGUAL a legada (Column1..Column25), pois o
    * SCX aqui usa a ordem natural (o ColumnOrder do legado so muda a ordem
    * VISUAL de exibicao, nao a identidade das colunas - transcrito o dump de
    * comportamento por NUMERO de Column, nao por posicao na tela):
    *
    *   1=Produto 2=Solicitada(RO) 3=Adquirida 4=Uni 5=ValorAdq.
    *   6/9/12/15/18/21 = Check A/B/C/D/E/F     7/10/13/16/19/22 = Unitario A..F
    *   8/11/14/17/20/23 = Total A..F           24=Tam 25=Cor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridCotacoes(par_oPagina)
        LOCAL loc_oGrid

        par_oPagina.AddObject("grd_4c_Produtos", "Grid")
        loc_oGrid = par_oPagina.grd_4c_Produtos

        loc_oGrid.ColumnCount = 25

        WITH loc_oGrid
            .Top           = 260
            .Left          = 7
            .Width         = 984
            .Height        = 216
            .FontName      = "Tahoma"
            .FontSize      = 8
            .HeaderHeight  = 16
            .RowHeight     = 15
            .ScrollBars    = 3
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .F.
            .GridLineColor = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        loc_oGrid.ColumnCount = 25
        loc_oGrid.RecordSource           = "cursor_4c_Produtos"
        loc_oGrid.Column1.ControlSource  = "cursor_4c_Produtos.CPros"
        loc_oGrid.Column2.ControlSource  = "cursor_4c_Produtos.Qtds"
        loc_oGrid.Column3.ControlSource  = "cursor_4c_Produtos.QtdAdqs"
        loc_oGrid.Column4.ControlSource  = "cursor_4c_Produtos.CUnis"
        loc_oGrid.Column5.ControlSource  = "cursor_4c_Produtos.ValAdqs"
        loc_oGrid.Column6.ControlSource  = "cursor_4c_Produtos.Marca01"
        loc_oGrid.Column7.ControlSource  = "cursor_4c_Produtos.Unit01"
        loc_oGrid.Column8.ControlSource  = "cursor_4c_Produtos.Tota01"
        loc_oGrid.Column9.ControlSource  = "cursor_4c_Produtos.Marca02"
        loc_oGrid.Column10.ControlSource = "cursor_4c_Produtos.Unit02"
        loc_oGrid.Column11.ControlSource = "cursor_4c_Produtos.Tota02"
        loc_oGrid.Column12.ControlSource = "cursor_4c_Produtos.Marca03"
        loc_oGrid.Column13.ControlSource = "cursor_4c_Produtos.Unit03"
        loc_oGrid.Column14.ControlSource = "cursor_4c_Produtos.Tota03"
        loc_oGrid.Column15.ControlSource = "cursor_4c_Produtos.Marca04"
        loc_oGrid.Column16.ControlSource = "cursor_4c_Produtos.Unit04"
        loc_oGrid.Column17.ControlSource = "cursor_4c_Produtos.Tota04"
        loc_oGrid.Column18.ControlSource = "cursor_4c_Produtos.Marca05"
        loc_oGrid.Column19.ControlSource = "cursor_4c_Produtos.Unit05"
        loc_oGrid.Column20.ControlSource = "cursor_4c_Produtos.Tota05"
        loc_oGrid.Column21.ControlSource = "cursor_4c_Produtos.Marca06"
        loc_oGrid.Column22.ControlSource = "cursor_4c_Produtos.Unit06"
        loc_oGrid.Column23.ControlSource = "cursor_4c_Produtos.Tota06"
        loc_oGrid.Column24.ControlSource = "cursor_4c_Produtos.CodTams"
        loc_oGrid.Column25.ControlSource = "cursor_4c_Produtos.CodCors"

        *-- Column1 (Produto) - link azul sublinhado, igual ao legado
        WITH loc_oGrid.Column1
            .FontBold          = .T.
            .FontUnderline     = .T.
            .ReadOnly          = .F.
            .Sparse            = .F.
            .Format            = "K"
            .Text1.MaxLength         = 14
            .Header1.Caption   = "Produto"
            .Header1.Alignment = 2
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
            .Text1.FontBold    = .T.
            .Text1.FontUnderline = .T.
            .Text1.ForeColor   = RGB(0, 0, 255)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 (Solicitada) - SEMPRE somente leitura (When = .F. no legado)
        WITH loc_oGrid.Column2
            .ReadOnly          = .T.
            .Format            = "999,999.99"
            .InputMask         = "999,999.99"
            .Header1.Caption   = "Solicitada"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column3
            .Format            = "999,999.99"
            .InputMask         = "999,999.99"
            .Header1.Caption   = "Adquirida"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column4
            .Format            = "K"
            .Text1.MaxLength         = 3
            .Header1.Caption   = "Uni"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column5
            .Format            = "999,999.999999"
            .InputMask         = "999,999.999999"
            .ToolTipText       = "Duplo Click - Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica de Valores"
            .Header1.Caption   = "Valor Adq."
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        *-- Pares Check/Unitario/Total dos 6 fornecedores (A..F)
        THIS.ConfigurarParFornecedorGrid(loc_oGrid,  6,  7,  8, "A", "01", RGB(0,   0,   128))
        THIS.ConfigurarParFornecedorGrid(loc_oGrid,  9, 10, 11, "B", "02", RGB(0,   128, 0))
        THIS.ConfigurarParFornecedorGrid(loc_oGrid, 12, 13, 14, "C", "03", RGB(185, 0,   0))
        THIS.ConfigurarParFornecedorGrid(loc_oGrid, 15, 16, 17, "D", "04", RGB(128, 64,  0))
        THIS.ConfigurarParFornecedorGrid(loc_oGrid, 18, 19, 20, "E", "05", RGB(255, 128, 0))
        THIS.ConfigurarParFornecedorGrid(loc_oGrid, 21, 22, 23, "F", "06", RGB(128, 128, 192))

        WITH loc_oGrid.Column24
            .Format            = "K"
            .Text1.MaxLength         = 4
            .Header1.Caption   = "Tam"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column25
            .Format            = "K"
            .Text1.MaxLength         = 4
            .Header1.Caption   = "Cor"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        *-- Larguras por ULTIMO (valores EXATOS do SCX)
        loc_oGrid.Column1.Width  = 110
        loc_oGrid.Column2.Width  = 70
        loc_oGrid.Column3.Width  = 70
        loc_oGrid.Column4.Width  = 30
        loc_oGrid.Column5.Width  = 93
        loc_oGrid.Column6.Width  = 16
        loc_oGrid.Column7.Width  = 83
        loc_oGrid.Column8.Width  = 93
        loc_oGrid.Column9.Width  = 16
        loc_oGrid.Column10.Width = 83
        loc_oGrid.Column11.Width = 93
        loc_oGrid.Column12.Width = 16
        loc_oGrid.Column13.Width = 83
        loc_oGrid.Column14.Width = 93
        loc_oGrid.Column15.Width = 16
        loc_oGrid.Column16.Width = 83
        loc_oGrid.Column17.Width = 93
        loc_oGrid.Column18.Width = 16
        loc_oGrid.Column19.Width = 83
        loc_oGrid.Column20.Width = 93
        loc_oGrid.Column21.Width = 16
        loc_oGrid.Column22.Width = 83
        loc_oGrid.Column23.Width = 93
        loc_oGrid.Column24.Width = 30
        loc_oGrid.Column25.Width = 30

        *-- Navegacao Tab/Shift+Tab comum + eventos de Column1 (Produto)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridCotacoesAfterRowColChange")
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",   THIS, "GridCotacoesKeyPressComum")
        BINDEVENT(loc_oGrid.Column1.Text1, "GotFocus",   THIS, "GridCotacoesProdutoGotFocus")
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "GridCotacoesProdutoLostFocus")
        BINDEVENT(loc_oGrid.Column1.Text1, "DblClick",   THIS, "GridCotacoesProdutoDblClick")
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "ValidarProdutoGrid")

        BINDEVENT(loc_oGrid.Column2.Text1,  "KeyPress", THIS, "GridCotacoesKeyPressComum")
        BINDEVENT(loc_oGrid.Column3.Text1,  "KeyPress", THIS, "GridCotacoesKeyPressComum")
        BINDEVENT(loc_oGrid.Column3.Text1,  "LostFocus", THIS, "RecalcularTotaisPorQuantidade")
        BINDEVENT(loc_oGrid.Column4.Text1,  "KeyPress", THIS, "GridCotacoesKeyPressComum")
        BINDEVENT(loc_oGrid.Column4.Text1,  "KeyPress", THIS, "ValidarUnidadeGrid")
        BINDEVENT(loc_oGrid.Column5.Text1,  "KeyPress", THIS, "GridCotacoesKeyPressComum")
        BINDEVENT(loc_oGrid.Column5.Header1, "DblClick", THIS, "SelecaoAutomaticaMelhorPreco")
        BINDEVENT(loc_oGrid.Column24.Text1, "KeyPress", THIS, "GridCotacoesKeyPressComum")
        BINDEVENT(loc_oGrid.Column25.Text1, "KeyPress", THIS, "GridCotacoesKeyPressComum")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarParFornecedorGrid - Monta o trio Check(marcacao)/Unitario/Total
    * de UM fornecedor (A..F) da grdCotacoes. Extraido em metodo unico porque
    * os 6 fornecedores repetem a MESMA estrutura no legado, so trocando o
    * numero (01..06), a letra e a cor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarParFornecedorGrid(par_oGrid, par_nColChk, par_nColUnit, par_nColTot, par_cLetra, par_cNum, par_nCor)
        LOCAL loc_oColChk, loc_oColUnit, loc_oColTot, loc_cDinBack, loc_cNum

        loc_cNum     = par_cNum
        loc_oColChk  = EVALUATE("par_oGrid.Column" + TRANSFORM(par_nColChk))
        loc_oColUnit = EVALUATE("par_oGrid.Column" + TRANSFORM(par_nColUnit))
        loc_oColTot  = EVALUATE("par_oGrid.Column" + TRANSFORM(par_nColTot))

        loc_cDinBack = "IIF(cursor_4c_Produtos.Marca" + loc_cNum + ", RGB(255,255,223), RGB(255,255,255))"

        IF !PEMSTATUS(loc_oColChk, "chk_4c_Marca" + loc_cNum, 5)
            loc_oColChk.AddObject("chk_4c_Marca" + loc_cNum, "CheckBox")
        ENDIF

        WITH EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum)
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 60
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
            .BackStyle = 0
            .ReadOnly  = .F.
            .ToolTipText = "Duplo Click - Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica do Fornecedor"
            .Visible   = .T.
        ENDWITH

        WITH loc_oColChk
            .CurrentControl   = "chk_4c_Marca" + loc_cNum
            .Sparse           = .F.
            .ReadOnly         = .F.
            .Movable          = .F.
            .Resizable        = .F.
            .BackColor        = par_nCor
            .Header1.Caption  = par_cLetra
            .Header1.ForeColor = par_nCor
            .Header1.FontBold = .T.
            .Header1.FontSize = 8
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oColUnit
            .Format           = "99999.999999"
            .InputMask        = "99999.999999"
            .DynamicBackColor = loc_cDinBack
            .Header1.Caption  = "Unit" + CHR(225) + "rio"
            .Header1.ForeColor = par_nCor
            .Header1.FontBold = .T.
            .Header1.Alignment = 2
            .Header1.FontSize = 8
        ENDWITH

        WITH loc_oColTot
            .Format           = "999999.999999"
            .InputMask        = "999999.999999"
            .DynamicBackColor = loc_cDinBack
            .Header1.Caption  = "Total"
            .Header1.ForeColor = par_nCor
            .Header1.FontBold = .T.
            .Header1.Alignment = 2
            .Header1.FontSize = 8
        ENDWITH

        *-- Toggle de marcacao: NoDefault + 4 handlers manuais (regra CLAUDE.md
        *-- "CheckBox em Grid Column nao alterna pelo binding nativo")
        DO CASE
            CASE par_cLetra = "A"
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaAMouseDown")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "KeyPress",  THIS, "ChkMarcaAKeyPress")
                BINDEVENT(loc_oColChk.Header1, "DblClick", THIS, "SelecionarTodosMarcaA")
            CASE par_cLetra = "B"
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaBMouseDown")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "KeyPress",  THIS, "ChkMarcaBKeyPress")
                BINDEVENT(loc_oColChk.Header1, "DblClick", THIS, "SelecionarTodosMarcaB")
            CASE par_cLetra = "C"
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaCMouseDown")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "KeyPress",  THIS, "ChkMarcaCKeyPress")
                BINDEVENT(loc_oColChk.Header1, "DblClick", THIS, "SelecionarTodosMarcaC")
            CASE par_cLetra = "D"
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaDMouseDown")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "KeyPress",  THIS, "ChkMarcaDKeyPress")
                BINDEVENT(loc_oColChk.Header1, "DblClick", THIS, "SelecionarTodosMarcaD")
            CASE par_cLetra = "E"
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaEMouseDown")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "KeyPress",  THIS, "ChkMarcaEKeyPress")
                BINDEVENT(loc_oColChk.Header1, "DblClick", THIS, "SelecionarTodosMarcaE")
            CASE par_cLetra = "F"
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "Click",     THIS, "GridMarcaClickNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseUp",   THIS, "GridMarcaMouseUpNoDefault")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "MouseDown", THIS, "ChkMarcaFMouseDown")
                BINDEVENT(EVALUATE("loc_oColChk.chk_4c_Marca" + loc_cNum), "KeyPress",  THIS, "ChkMarcaFKeyPress")
                BINDEVENT(loc_oColChk.Header1, "DblClick", THIS, "SelecionarTodosMarcaF")
        ENDCASE

        BINDEVENT(loc_oColUnit.Text1, "KeyPress",  THIS, "GridCotacoesKeyPressComum")
        BINDEVENT(loc_oColTot.Text1,  "KeyPress",  THIS, "GridCotacoesKeyPressComum")

        DO CASE
            CASE par_cLetra = "A"
                BINDEVENT(loc_oColUnit.Text1, "LostFocus", THIS, "RecalcularTotalPorUnitarioA")
                BINDEVENT(loc_oColTot.Text1,  "LostFocus", THIS, "RecalcularUnitarioPorTotalA")
            CASE par_cLetra = "B"
                BINDEVENT(loc_oColUnit.Text1, "LostFocus", THIS, "RecalcularTotalPorUnitarioB")
                BINDEVENT(loc_oColTot.Text1,  "LostFocus", THIS, "RecalcularUnitarioPorTotalB")
            CASE par_cLetra = "C"
                BINDEVENT(loc_oColUnit.Text1, "LostFocus", THIS, "RecalcularTotalPorUnitarioC")
                BINDEVENT(loc_oColTot.Text1,  "LostFocus", THIS, "RecalcularUnitarioPorTotalC")
            CASE par_cLetra = "D"
                BINDEVENT(loc_oColUnit.Text1, "LostFocus", THIS, "RecalcularTotalPorUnitarioD")
                BINDEVENT(loc_oColTot.Text1,  "LostFocus", THIS, "RecalcularUnitarioPorTotalD")
            CASE par_cLetra = "E"
                BINDEVENT(loc_oColUnit.Text1, "LostFocus", THIS, "RecalcularTotalPorUnitarioE")
                BINDEVENT(loc_oColTot.Text1,  "LostFocus", THIS, "RecalcularUnitarioPorTotalE")
            CASE par_cLetra = "F"
                BINDEVENT(loc_oColUnit.Text1, "LostFocus", THIS, "RecalcularTotalPorUnitarioF")
                BINDEVENT(loc_oColTot.Text1,  "LostFocus", THIS, "RecalcularUnitarioPorTotalF")
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesCotacoes - Item E da Fase 6: os 4 CommandGroups de acao
    * de Page3 (cmdEscolha/cmdBotoes/cmdGravar/cmdProdutos). Icones/Captions
    * EXATOS do dump do SCX (PROPRIEDADES DE: ...cmdEscolha/cmdBotoes/
    * cmdGravar/cmdProdutos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesCotacoes(par_oPagina)
        LOCAL loc_oPag
        loc_oPag = par_oPagina

        *-- cmdEscolha: Excluir Produto / Historico do Produto
        loc_oPag.AddObject("obj_4c_CmdEscolha", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdEscolha
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 7
            .Left        = 246
            .Width       = 162
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .Caption         = "Excluir Produto"
                .MousePointer    = 15
                .ToolTipText     = "Excluir o Produto da Cota" + CHR(231) + CHR(227) + "o"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 0
                .Left            = 80
                .Height          = 100
                .Width           = 80
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                .Caption         = "Hist" + CHR(243) + "rico do Produto"
                .MousePointer    = 15
                .ToolTipText     = "Hist" + CHR(243) + "rico do Produto"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- cmdBotoes: Voltar para a Pagina de Dados (Page2)
        loc_oPag.AddObject("obj_4c_CmdBotoes", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdBotoes
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 7
            .Left        = 910
            .Width       = 90
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Cancel          = .T.
                .Caption         = "P" + CHR(225) + "gina de Dados"
                .MousePointer    = 15
                .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Dados"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- cmdGravar: Gravar Cotacao / Gerar Pedidos / Imprimir Cotacao
        loc_oPag.AddObject("obj_4c_CmdGravar", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdGravar
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 7
            .Left        = 6
            .Width       = 240
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_disco_60.jpg"
                .Caption         = "Gravar Cota" + CHR(231) + CHR(227) + "o"
                .MousePointer    = 15
                .ToolTipText     = "Gravar Dados da Cota" + CHR(231) + CHR(227) + "o"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 0
                .Left            = 80
                .Height          = 100
                .Width           = 80
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
                .Caption         = "Gerar Pedidos"
                .MousePointer    = 15
                .ToolTipText     = "Gerar Pedidos"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 0
                .Left            = 160
                .Height          = 100
                .Width           = 80
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Caption         = "Imprimir Cota" + CHR(231) + CHR(227) + "o"
                .MousePointer    = 15
                .ToolTipText     = "Imprimir Cota" + CHR(231) + CHR(227) + "o"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- cmdProdutos: inserir/excluir linha em branco na grade (AutoSize=.T.
        *-- no legado - os dois icones ficam lado a lado, sem WordWrap)
        loc_oPag.AddObject("obj_4c_CmdProdutos", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdProdutos
            .ButtonCount = 2
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 492
            .Left        = 663
            .Width       = 91
            .Height      = 50
            .Visible     = .T.

            WITH .Buttons(1)
                .Top           = 5
                .Left          = 5
                .Height        = 40
                .Width         = 40
                .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Inserir Produto na Grade"
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top           = 5
                .Left          = 46
                .Height        = 40
                .Width         = 40
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Excluir Produto da Grade"
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Eventos
        BINDEVENT(loc_oPag.obj_4c_CmdEscolha.Buttons(1), "Click", THIS, "BtnExcluirProdutoClick")
        BINDEVENT(loc_oPag.obj_4c_CmdEscolha.Buttons(2), "Click", THIS, "BtnHistoricoProdutoClick")
        BINDEVENT(loc_oPag.obj_4c_CmdBotoes.Buttons(1),  "Click", THIS, "BtnSairCotacoesClick")
        BINDEVENT(loc_oPag.obj_4c_CmdGravar.Buttons(1),  "Click", THIS, "BtnGravarCotacaoClick")
        BINDEVENT(loc_oPag.obj_4c_CmdGravar.Buttons(2),  "Click", THIS, "BtnGeraPedidosCliqueClick")
        BINDEVENT(loc_oPag.obj_4c_CmdGravar.Buttons(3),  "Click", THIS, "BtnImprimirCotacaoClick")
        BINDEVENT(loc_oPag.obj_4c_CmdProdutos.Buttons(1), "Click", THIS, "AdicionarLinhaProduto")
        BINDEVENT(loc_oPag.obj_4c_CmdProdutos.Buttons(2), "Click", THIS, "AdicionarLinhaProduto")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCorPrioridade - PROCEDURE InteractiveChange do cmbPrioris
    * legado: This.ForeColor = Iif(Value=3, vermelho, Iif(Value=2, laranja,
    * preto)). Transcrito literalmente (regra de negocio de destaque visual).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCorPrioridade()
        LOCAL loc_oCbo

        loc_oCbo = THIS.pgf_4c_Paginas.Page3.cbo_4c_Prioris

        DO CASE
            CASE loc_oCbo.ListIndex = 3
                loc_oCbo.ForeColor = RGB(185, 0, 0)
            CASE loc_oCbo.ListIndex = 2
                loc_oCbo.ForeColor = RGB(255, 128, 64)
            OTHERWISE
                loc_oCbo.ForeColor = RGB(0, 0, 0)
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposCotacao - Reproduz TODOS os PROCEDURE When de Page3 (campos
    * de cabecalho, sub-abas de pgfComplCots e colunas das duas grades),
    * usando ReadOnly (ou Enabled, no caso do CheckBox chk_4c_ChkAprovador) em
    * vez de esconder o controle - exatamente como o legado faz.
    *
    * Gates usados (traduzidos das propriedades do BO/form, ja que este form
    * nao mantem os cursores crSigCtTDc/crCotaPends do legado):
    *   pcEscolha  -> THIS.this_cPcEscolha
    *   ChkAprovs  -> THIS.this_oBusinessObject.this_nChkAprovs
    *   Copiando   -> THIS.this_lCopiando
    *   AprSols/DtAprSols (cabecalho) -> this_cAprSols / this_dDtAprSols do BO
    *   LibSolics  -> THIS.this_lLibSolics
    *   Situas (cotacao corrente) -> this_oBusinessObject.this_nSituas
    *   Usuar      -> gc_4c_UsuarioLogado
    *   Copias (cabecalho) -> this_oBusinessObject.this_nCopias
    *
    * Chamado ao fim de ConfigurarPaginaCotacoes e sempre que uma cotacao for
    * carregada/gerada (GeraCotacao/CarregarCotacaoSelecionada) ou o estado de
    * aprovacao mudar (AprovarCotacao).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarCamposCotacao()
        LOCAL loc_oPag, loc_oBO, loc_lEdita, loc_lChkOk, loc_lCopiando
        LOCAL loc_lPodeAprovarFinal, loc_lPodeAprovarSol, loc_oPgComp
        LOCAL loc_oAdic, loc_oApr, loc_oSol

        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page3", 5)
            RETURN
        ENDIF
        loc_oPag = THIS.pgf_4c_Paginas.Page3
        IF !PEMSTATUS(loc_oPag, "txt_4c_Solicitas", 5)
            RETURN
        ENDIF

        loc_oBO       = THIS.this_oBusinessObject
        loc_lEdita    = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        loc_lChkOk    = (VARTYPE(loc_oBO) = "O" AND loc_oBO.this_nChkAprovs = 0)
        loc_lCopiando = THIS.this_lCopiando

        *-- Campos de cabecalho (raiz de Page3)
        loc_oPag.txt_4c_Solicitas.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
        loc_oPag.txt_4c_Deptos.ReadOnly     = !(loc_lEdita AND loc_lChkOk)
        loc_oPag.txt_4c_Comprador.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
        loc_oPag.txt_4c_DtSolics.ReadOnly   = !(loc_lEdita AND loc_lChkOk)
        loc_oPag.txt_4c_DtPagtos.ReadOnly   = !(loc_lEdita AND loc_lChkOk)
        loc_oPag.cbo_4c_Prioris.Enabled     = (loc_lEdita AND (loc_lChkOk OR loc_lCopiando))

        IF VARTYPE(loc_oBO) = "O"
            loc_oPag.txt_4c_DtCotas.ReadOnly  = !(loc_lEdita AND loc_lChkOk AND EMPTY(loc_oBO.this_nCopias))
            loc_oPag.txt_4c_DtValids.ReadOnly = !(loc_lEdita AND (loc_lChkOk OR loc_lCopiando) AND EMPTY(loc_oBO.this_nCopias))
        ELSE
            loc_oPag.txt_4c_DtCotas.ReadOnly  = .T.
            loc_oPag.txt_4c_DtValids.ReadOnly = .T.
        ENDIF

        *-- Rodape do produto corrente (getDPros/getObs/getJustificas)
        loc_oPag.txt_4c_DPros.ReadOnly         = !(loc_lEdita AND loc_lChkOk)
        loc_oPag.obj_4c_GetObs.ReadOnly        = !(loc_lEdita AND loc_lChkOk)
        loc_oPag.obj_4c_GetJustificas.ReadOnly = !(loc_lEdita AND loc_lChkOk)

        *-- Sub-abas de pgfComplCots
        IF PEMSTATUS(loc_oPag, "pgf_4c_ComplCots", 5)
            loc_oPgComp = loc_oPag.pgf_4c_ComplCots
            loc_oAdic   = loc_oPgComp.Page1
            loc_oApr    = loc_oPgComp.Page2
            loc_oSol    = loc_oPgComp.Page3

            *-- pgAdicionais
            loc_oAdic.txt_4c_ContaEs.ReadOnly    = !(loc_lEdita AND loc_lChkOk)
            loc_oAdic.txt_4c_DContaEs.ReadOnly   = !(loc_lEdita AND loc_lChkOk AND EMPTY(loc_oAdic.txt_4c_ContaEs.Value))
            loc_oAdic.obj_4c_GetJustGeral.ReadOnly = !(loc_lEdita AND loc_lChkOk)

            *-- pgAprovacao (Final) - depende da aprovacao do SOLICITANTE ja ter
            *-- ocorrido (AprSols preenchido + DtAprSols valida), ou LibSolics
            IF VARTYPE(loc_oBO) = "O"
                loc_lPodeAprovarFinal = (!EMPTY(loc_oBO.this_cAprSols) AND !EMPTY(loc_oBO.this_dDtAprSols)) ;
                                        OR THIS.this_lLibSolics
            ELSE
                loc_lPodeAprovarFinal = THIS.this_lLibSolics
            ENDIF

            loc_oApr.txt_4c_Aprovador.ReadOnly     = !(loc_lEdita AND loc_lChkOk AND loc_lPodeAprovarFinal)
            loc_oApr.txt_4c_DtAprovs.ReadOnly       = !(loc_lEdita AND loc_lChkOk AND loc_lPodeAprovarFinal)
            loc_oApr.obj_4c_GetObsAprovs.ReadOnly   = !(loc_lEdita AND loc_lChkOk AND loc_lPodeAprovarFinal)
            loc_oApr.chk_4c_ChkAprovador.Enabled    = (loc_lEdita AND (!loc_lChkOk OR loc_lPodeAprovarFinal))

            *-- pgSolicitas - so o proprio AprSols designado (ou LibSolics) pode
            *-- preencher, com a cotacao ainda em aberto (Situas = 0)
            IF VARTYPE(loc_oBO) = "O"
                loc_lPodeAprovarSol = (loc_oBO.this_nSituas = 0) AND ;
                                      (ALLTRIM(UPPER(gc_4c_UsuarioLogado)) = ALLTRIM(UPPER(loc_oBO.this_cAprSols)))
            ELSE
                loc_lPodeAprovarSol = .F.
            ENDIF

            loc_oSol.txt_4c_DtAprSols.ReadOnly     = !(loc_lEdita AND loc_lPodeAprovarSol AND loc_lChkOk)
            loc_oSol.obj_4c_GetObsAprSols.ReadOnly = !(loc_lEdita AND loc_lPodeAprovarSol AND loc_lChkOk)
        ENDIF

        *-- Colunas da grade de Produtos (grd_4c_Produtos)
        IF PEMSTATUS(loc_oPag, "grd_4c_Produtos", 5)
            WITH loc_oPag.grd_4c_Produtos
                .Column3.ReadOnly  = !(loc_lEdita AND (loc_lChkOk OR loc_lCopiando))
                .Column4.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
                .Column5.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
                .Column6.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
                .Column7.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
                .Column8.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
                .Column9.ReadOnly  = !(loc_lEdita AND loc_lChkOk)
                .Column10.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column11.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column12.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column13.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column14.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column15.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column16.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column17.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column18.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column19.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column20.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column21.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column22.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column23.ReadOnly = !(loc_lEdita AND loc_lChkOk)
            ENDWITH
        ENDIF

        *-- Colunas da grade de Fornecedores (grd_4c_Fornecedores)
        IF PEMSTATUS(loc_oPag, "grd_4c_Fornecedores", 5)
            WITH loc_oPag.grd_4c_Fornecedores
                .Column2.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column3.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column4.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column5.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column6.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column7.ReadOnly = !(loc_lEdita AND (loc_lChkOk OR loc_lCopiando))
                .Column8.ReadOnly = !(loc_lEdita AND loc_lChkOk)
                .Column9.ReadOnly = !(loc_lEdita AND loc_lChkOk)
            ENDWITH
        ENDIF

        *-- Botoes de acao que dependem do modo/estado da cotacao corrente
        IF PEMSTATUS(loc_oPag, "obj_4c_CmdEscolha", 5)
            loc_oPag.obj_4c_CmdEscolha.Buttons(1).Enabled = (loc_lEdita AND loc_lChkOk)
        ENDIF
        IF PEMSTATUS(loc_oPag, "obj_4c_CmdProdutos", 5)
            loc_oPag.obj_4c_CmdProdutos.Visible = (loc_lEdita AND loc_lChkOk)
        ENDIF
        IF PEMSTATUS(loc_oPag, "obj_4c_CmdGravar", 5) AND VARTYPE(loc_oBO) = "O"
            loc_oPag.obj_4c_CmdGravar.Buttons(1).Enabled = ;
                INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR", "EXCLUIR") AND (loc_oBO.this_nSituas < 1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarRodapeProdutoAtual - Copia getDPros/getObs/getJustificas (rodape
    * de Page3) para a linha CORRENTE de cursor_4c_Produtos. Sao campos que o
    * legado liga por ControlSource direto a crSigCtTCt; aqui, como o valor
    * fica em controles de nivel de Page (fora da grade), a copia manual eh
    * feita ao perder o foco - equivalente ao LostFocus nativo do binding.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarRodapeProdutoAtual()
        LOCAL loc_oPag

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page3

        SELECT cursor_4c_Produtos
        REPLACE DPros      WITH ALLTRIM(loc_oPag.txt_4c_DPros.Value), ;
                Obs        WITH loc_oPag.obj_4c_GetObs.Value, ;
                Justificas WITH loc_oPag.obj_4c_GetJustificas.Value ;
            IN cursor_4c_Produtos
    ENDPROC

    *--------------------------------------------------------------------------
    * GridCotacoesAfterRowColChange - Espelha a linha corrente do grd_4c_Produtos
    * nos campos de rodape (equivalente ao Refresh dos 3 controles no legado,
    * que estao ligados por ControlSource direto).
    *--------------------------------------------------------------------------
    PROCEDURE GridCotacoesAfterRowColChange(par_nColIndex)
        LOCAL loc_oPag

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page3

        SELECT cursor_4c_Produtos
        loc_oPag.txt_4c_DPros.Value         = ALLTRIM(NVL(DPros, ""))
        loc_oPag.obj_4c_GetObs.Value        = NVL(Obs, "")
        loc_oPag.obj_4c_GetJustificas.Value = NVL(Justificas, "")
    ENDPROC

    *--------------------------------------------------------------------------
    * GridCotacoesKeyPressComum / GridFornecsKeyPressComum - Navegacao comum
    * Tab/Shift+Tab das colunas de texto das duas grades de Page3, transcrita
    * do KeyPress identico presente em TODAS as colunas do dump legado.
    *--------------------------------------------------------------------------
    PROCEDURE GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = 9   && TAB
                THIS.pgf_4c_Paginas.Page3.txt_4c_DPros.SetFocus()
            CASE par_nKeyCode = 15  && SHIFT+TAB
                THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Column2.SetFocus()
        ENDCASE
    ENDPROC

    PROCEDURE GridFornecsKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = 9   && TAB
                THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Column1.SetFocus()
            CASE par_nKeyCode = 15  && SHIFT+TAB
                THIS.pgf_4c_Paginas.Page3.cbo_4c_Prioris.SetFocus()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * Marcacao de fornecedor (A..F) na grd_4c_Produtos - o CheckBox de Column
    * NAO alterna pelo binding nativo (regra CLAUDE.md): Click/MouseUp so dao
    * NODEFAULT; o toggle de verdade acontece no MouseDown/KeyPress(Enter/
    * Espaco), chamando o helper generico AlternarMarcaCotacao. O DblClick do
    * Header1 chama SelecionarTodosFornecedor (selecao em massa do legado).
    *--------------------------------------------------------------------------
    PROCEDURE GridMarcaClickNoDefault()
        NODEFAULT
    ENDPROC

    PROCEDURE GridMarcaMouseUpNoDefault(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *-- Fornecedor A (Marca01)
    PROCEDURE ChkMarcaAMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaCotacao("01")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaCotacao("01")
            NODEFAULT
        ELSE
            THIS.GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        ENDIF
    ENDPROC

    PROCEDURE SelecionarTodosMarcaA()
        THIS.SelecionarTodosFornecedor("01")
    ENDPROC

    PROCEDURE RecalcularTotalPorUnitarioA()
        THIS.RecalcularTotalPorUnitario("01")
    ENDPROC

    PROCEDURE RecalcularUnitarioPorTotalA()
        THIS.RecalcularUnitarioPorTotal("01")
    ENDPROC

    *-- Fornecedor B (Marca02)
    PROCEDURE ChkMarcaBMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaCotacao("02")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaBKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaCotacao("02")
            NODEFAULT
        ELSE
            THIS.GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        ENDIF
    ENDPROC

    PROCEDURE SelecionarTodosMarcaB()
        THIS.SelecionarTodosFornecedor("02")
    ENDPROC

    PROCEDURE RecalcularTotalPorUnitarioB()
        THIS.RecalcularTotalPorUnitario("02")
    ENDPROC

    PROCEDURE RecalcularUnitarioPorTotalB()
        THIS.RecalcularUnitarioPorTotal("02")
    ENDPROC

    *-- Fornecedor C (Marca03)
    PROCEDURE ChkMarcaCMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaCotacao("03")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaCKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaCotacao("03")
            NODEFAULT
        ELSE
            THIS.GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        ENDIF
    ENDPROC

    PROCEDURE SelecionarTodosMarcaC()
        THIS.SelecionarTodosFornecedor("03")
    ENDPROC

    PROCEDURE RecalcularTotalPorUnitarioC()
        THIS.RecalcularTotalPorUnitario("03")
    ENDPROC

    PROCEDURE RecalcularUnitarioPorTotalC()
        THIS.RecalcularUnitarioPorTotal("03")
    ENDPROC

    *-- Fornecedor D (Marca04)
    PROCEDURE ChkMarcaDMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaCotacao("04")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaDKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaCotacao("04")
            NODEFAULT
        ELSE
            THIS.GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        ENDIF
    ENDPROC

    PROCEDURE SelecionarTodosMarcaD()
        THIS.SelecionarTodosFornecedor("04")
    ENDPROC

    PROCEDURE RecalcularTotalPorUnitarioD()
        THIS.RecalcularTotalPorUnitario("04")
    ENDPROC

    PROCEDURE RecalcularUnitarioPorTotalD()
        THIS.RecalcularUnitarioPorTotal("04")
    ENDPROC

    *-- Fornecedor E (Marca05)
    PROCEDURE ChkMarcaEMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaCotacao("05")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaEKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaCotacao("05")
            NODEFAULT
        ELSE
            THIS.GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        ENDIF
    ENDPROC

    PROCEDURE SelecionarTodosMarcaE()
        THIS.SelecionarTodosFornecedor("05")
    ENDPROC

    PROCEDURE RecalcularTotalPorUnitarioE()
        THIS.RecalcularTotalPorUnitario("05")
    ENDPROC

    PROCEDURE RecalcularUnitarioPorTotalE()
        THIS.RecalcularUnitarioPorTotal("05")
    ENDPROC

    *-- Fornecedor F (Marca06)
    PROCEDURE ChkMarcaFMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaCotacao("06")
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaCotacao("06")
            NODEFAULT
        ELSE
            THIS.GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
        ENDIF
    ENDPROC

    PROCEDURE SelecionarTodosMarcaF()
        THIS.SelecionarTodosFornecedor("06")
    ENDPROC

    PROCEDURE RecalcularTotalPorUnitarioF()
        THIS.RecalcularTotalPorUnitario("06")
    ENDPROC

    PROCEDURE RecalcularUnitarioPorTotalF()
        THIS.RecalcularUnitarioPorTotal("06")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarMarcaCotacao - Transcreve o KeyPress/MouseDown do Check1 legado:
    * marca o fornecedor <par_cNum> (desmarcando os outros 5) e copia o Total
    * correspondente para ValAdqs; se ja estava marcado, desmarca e zera
    * ValAdqs. Formula/sinal EXATOS do legado (regra CLAUDE.md #17).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarMarcaCotacao(par_cNum)
        LOCAL loc_lMarcado, loc_cCampo

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_cCampo  = "Marca" + par_cNum
        loc_lMarcado = EVALUATE("cursor_4c_Produtos." + loc_cCampo)

        SELECT cursor_4c_Produtos
        IF loc_lMarcado
            REPLACE (loc_cCampo) WITH .F., ValAdqs WITH 0 IN cursor_4c_Produtos
        ELSE
            REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
                    Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
            REPLACE (loc_cCampo) WITH .T., ;
                    ValAdqs WITH EVALUATE("cursor_4c_Produtos.Tota" + par_cNum) IN cursor_4c_Produtos
        ENDIF

        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodosFornecedor - Header1.DblClick do legado: marca <par_cNum>
    * em TODAS as linhas com Total preenchido e ValAdqs = Total, desmarcando os
    * outros 5 fornecedores em todas as linhas (Update sem Where -> todas).
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodosFornecedor(par_cNum)
        LOCAL loc_cCampo, loc_cCampoTota, loc_nRegAtual, loc_nI, loc_cOutro

        IF !USED("cursor_4c_Produtos") ;
           OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cCampo     = "Marca" + par_cNum
        loc_cCampoTota = "Tota"  + par_cNum
        loc_nRegAtual  = RECNO("cursor_4c_Produtos")

        *-- Transcrito literal do Header1.DblClick legado (3 passos
        *-- distintos - inclusive a assimetria: so as OUTRAS 5 letras sao
        *-- limpas incondicionalmente, a marcada so muda onde o Total dela
        *-- esta preenchido). REPLACE...FOR (nao UPDATE-SQL) porque so REPLACE
        *-- aceita nome de campo DINAMICO via parenteses em VFP9:
        *-- Update Set Marca<N>=.t. Where Not Empty(Tota<N>)
        *-- Update Set ValAdqs=Tota<N> Where Marca<N>
        *-- Update Set Marca<outras 5>=.f. (todas as linhas)
        SELECT cursor_4c_Produtos
        REPLACE (loc_cCampo) WITH .T. FOR !EMPTY(EVALUATE(loc_cCampoTota)) IN cursor_4c_Produtos
        REPLACE ValAdqs WITH EVALUATE(loc_cCampoTota) FOR EVALUATE(loc_cCampo) IN cursor_4c_Produtos

        FOR loc_nI = 1 TO 6
            loc_cOutro = "Marca" + PADL(loc_nI, 2, "0")
            IF loc_cOutro != loc_cCampo
                REPLACE (loc_cOutro) WITH .F. ALL IN cursor_4c_Produtos
            ENDIF
        ENDFOR

        GO TOP IN cursor_4c_Produtos
        IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
            GO loc_nRegAtual IN cursor_4c_Produtos
        ENDIF

        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularTotalPorUnitario / RecalcularUnitarioPorTotal - Formulas
    * TRANSCRITAS literalmente do Valid das colunas Unitario/Total (regra
    * CLAUDE.md #17): Total = Unitario * QtdAdqs (com guard de negativo) e
    * Unitario = Total / QtdAdqs (guard de divisao por zero).
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularTotalPorUnitario(par_cNum)
        LOCAL loc_nUnit, loc_nQtd, loc_nTotalNovo

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        SELECT cursor_4c_Produtos
        loc_nUnit = EVALUATE("Unit" + par_cNum)

        IF loc_nUnit < 0
            REPLACE ("Unit" + par_cNum) WITH 0 IN cursor_4c_Produtos
            loc_nUnit = 0
        ENDIF

        loc_nQtd      = QtdAdqs
        loc_nTotalNovo = loc_nUnit * loc_nQtd

        IF EVALUATE("Tota" + par_cNum) != loc_nTotalNovo
            REPLACE ("Tota" + par_cNum) WITH loc_nTotalNovo IN cursor_4c_Produtos
        ENDIF

        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
    ENDPROC

    PROCEDURE RecalcularUnitarioPorTotal(par_cNum)
        LOCAL loc_nTotal, loc_nQtd, loc_nUnitNovo

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        SELECT cursor_4c_Produtos
        loc_nTotal = EVALUATE("Tota" + par_cNum)

        IF loc_nTotal < 0
            REPLACE ("Tota" + par_cNum) WITH 0 IN cursor_4c_Produtos
            loc_nTotal = 0
        ENDIF

        loc_nQtd     = IIF(QtdAdqs = 0, 1, QtdAdqs)
        loc_nUnitNovo = loc_nTotal / loc_nQtd

        IF EVALUATE("Unit" + par_cNum) != loc_nUnitNovo
            REPLACE ("Unit" + par_cNum) WITH loc_nUnitNovo IN cursor_4c_Produtos
        ENDIF

        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularTotaisPorQuantidade - Valid da Column3 (QtdAdqs): recalcula os
    * 6 Totais quando a quantidade adquirida muda (Tota0N = Unit0N * Value),
    * so para os fornecedores com Unitario preenchido - transcrito literal.
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularTotaisPorQuantidade()
        LOCAL loc_nQtd, loc_nI, loc_cNum

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        SELECT cursor_4c_Produtos
        loc_nQtd = QtdAdqs

        IF loc_nQtd < 0
            REPLACE QtdAdqs WITH 0 IN cursor_4c_Produtos
            loc_nQtd = 0
        ENDIF

        FOR loc_nI = 1 TO 6
            loc_cNum = PADL(loc_nI, 2, "0")
            IF EVALUATE("Unit" + loc_cNum) > 0
                REPLACE ("Tota" + loc_cNum) WITH EVALUATE("Unit" + loc_cNum) * loc_nQtd IN cursor_4c_Produtos
            ENDIF
        ENDFOR

        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecaoAutomaticaMelhorPreco - Header1.DblClick da Column5 (ValAdqs):
    * para cada linha, escolhe automaticamente o MENOR Total entre os 6
    * fornecedores (so troca se o total for menor que o ValAdqs atual ou se
    * ValAdqs estiver vazio) - transcrito do DblClick legado.
    *--------------------------------------------------------------------------
    PROCEDURE SelecaoAutomaticaMelhorPreco()
        LOCAL loc_lConfirma, loc_nI, loc_cNum, loc_nRegAtual

        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_lConfirma = .T.
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            loc_lConfirma = MsgConfirma("Deseja Realizar a Sele" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + ;
                "tica de Valores?", "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF

        IF !loc_lConfirma
            RETURN
        ENDIF

        loc_nRegAtual = RECNO("cursor_4c_Produtos")

        SELECT cursor_4c_Produtos
        SCAN
            FOR loc_nI = 1 TO 6
                loc_cNum = PADL(loc_nI, 2, "0")
                IF !EMPTY(EVALUATE("Tota" + loc_cNum)) AND ;
                   (EMPTY(ValAdqs) OR ValAdqs > EVALUATE("Tota" + loc_cNum))
                    REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
                            Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
                    REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum), ;
                            ("Marca" + loc_cNum) WITH .T. IN cursor_4c_Produtos
                ENDIF
            ENDFOR
        ENDSCAN

        IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
            GO loc_nRegAtual IN cursor_4c_Produtos
        ENDIF

        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * Column1 (Produto) da grd_4c_Produtos - GotFocus guarda o valor original
    * (Tag), LostFocus reverte se a linha ja estiver vinculada a uma operacao
    * (EmpDopNums preenchido - so entao o produto fica travado), e o lookup
    * (ValidarProdutoGrid) so roda quando a linha AINDA esta livre.
    *--------------------------------------------------------------------------
    PROCEDURE GridCotacoesProdutoGotFocus()
        IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
            THIS.this_cTagProduto = ALLTRIM(cursor_4c_Produtos.CPros)
        ENDIF
    ENDPROC

    PROCEDURE GridCotacoesProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
            IF !EMPTY(cursor_4c_Produtos.EmpDopNums)
                SELECT cursor_4c_Produtos
                REPLACE CPros WITH THIS.this_cTagProduto IN cursor_4c_Produtos
                THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE GridCotacoesProdutoDblClick()
        *-- Legado: Do Form SigOpCgp.Scx (tela de consulta de movimentacoes por
        *-- produto) - form de CONSULTA externo, nao portado nesta fase.
        MsgAviso("Consulta de movimenta" + CHR(231) + CHR(245) + "es por produto (SigOpCgp) " + ;
            "n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
            "Aviso")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProdutoGrid - Valid da Column1: so faz sentido buscar/gravar
    * quando a linha AINDA nao esta vinculada a uma operacao (EmpDopNums
    * vazio) - transcrito literal do guard do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarProdutoGrid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cValor, loc_oBusca

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        IF !EMPTY(cursor_4c_Produtos.EmpDopNums)
            RETURN
        ENDIF

        loc_oGrid  = THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos
        loc_cValor = ALLTRIM(loc_oGrid.Column1.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        *-- Guarda de reentrancia: o Show() modal abaixo, disparado por
        *-- LostFocus, pode reentrar neste mesmo metodo quando o foco sai e
        *-- volta - sem a guarda, um segundo picker fica empilhado por cima.
        IF THIS.this_lAbrindoLookupGrid
            RETURN
        ENDIF
        THIS.this_lAbrindoLookupGrid = .T.

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProduto", "CPros", loc_cValor, "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("CUnis", "", "Uni")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                SELECT cursor_4c_Produtos
                REPLACE CPros     WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
                        DPros     WITH ALLTRIM(cursor_4c_BuscaProduto.DPros), ;
                        CUnis     WITH ALLTRIM(cursor_4c_BuscaProduto.CUnis), ;
                        cIdChaves WITH LEFT(fUniqueIds(), 20) IN cursor_4c_Produtos
                loc_oGrid.Refresh()
                THIS.GridCotacoesAfterRowColChange(1)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF

        THIS.this_lAbrindoLookupGrid = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnidadeGrid - Valid da Column4 (CUnis): lookup em SigCdUni e, se
    * o produto ja tem unidade cadastrada em SigCdPro, avisa quando o valor
    * digitado diverge (mesma checagem do legado, sem alterar o Value).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUnidadeGrid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cValor, loc_oBusca, loc_cSQL, loc_nResultado

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_oGrid  = THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos
        loc_cValor = ALLTRIM(loc_oGrid.Column4.Text1.Value)

        IF !EMPTY(loc_cValor)
            *-- Guarda de reentrancia (ver ValidarProdutoGrid) - o Show() modal
            *-- disparado por LostFocus pode reentrar neste mesmo metodo.
            IF THIS.this_lAbrindoLookupGrid
                RETURN
            ENDIF
            THIS.this_lAbrindoLookupGrid = .T.

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUnidade", "CUnis", loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", .T.)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CUnis", "", "Uni")
                    loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnidade")
                    SELECT cursor_4c_Produtos
                    REPLACE CUnis WITH ALLTRIM(cursor_4c_BuscaUnidade.CUnis) IN cursor_4c_Produtos
                ELSE
                    SELECT cursor_4c_Produtos
                    REPLACE CUnis WITH "" IN cursor_4c_Produtos
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUnidade")
                USE IN cursor_4c_BuscaUnidade
            ENDIF

            loc_oGrid.Refresh()

            *-- Confere contra a unidade cadastrada no produto (aviso, nao bloqueio)
            IF !EMPTY(cursor_4c_Produtos.CPros)
                loc_cSQL = "SELECT CUnis FROM SigCdPro WHERE CPros = " + ;
                    EscaparSQL(cursor_4c_Produtos.CPros)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniPro")

                IF loc_nResultado > 0 AND USED("cursor_4c_UniPro") AND !EOF("cursor_4c_UniPro")
                    IF !EMPTY(cursor_4c_UniPro.CUnis) AND ;
                       ALLTRIM(cursor_4c_UniPro.CUnis) != ALLTRIM(cursor_4c_Produtos.CUnis)
                        MsgAviso("A Unidade de Medida Deste Produto no Cadastro " + CHR(233) + ' "' + ;
                            ALLTRIM(cursor_4c_UniPro.CUnis) + '"!!!', "Aten" + CHR(231) + CHR(227) + "o!!!")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_UniPro")
                    USE IN cursor_4c_UniPro
                ENDIF
            ENDIF

            THIS.this_lAbrindoLookupGrid = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFornecedorCodigoGrid / ValidarFornecedorNomeGrid - Column2 (IClis)
    * e Column3 (Fornecs) do grd_4c_Fornecedores: lookup em SigCdCli e, ao
    * achar, replica Fornecs/Contatos/Tel1s/Fretes na linha (Fretes sempre
    * "Emitente" por padrao - regra de negocio do legado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFornecedorCodigoGrid(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ValidarFornecedorGrid("IClis")
    ENDPROC

    PROCEDURE ValidarFornecedorNomeGrid(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ValidarFornecedorGrid("RClis")
    ENDPROC

    PROTECTED PROCEDURE ValidarFornecedorGrid(par_cCampo)
        LOCAL loc_oGrid, loc_cValor, loc_oBusca, loc_cTitulo

        IF !USED("cursor_4c_Fornecedores") OR EOF("cursor_4c_Fornecedores")
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores

        IF par_cCampo = "IClis"
            loc_cValor = ALLTRIM(loc_oGrid.Column2.Text1.Value)
        ELSE
            loc_cValor = ALLTRIM(loc_oGrid.Column3.Text1.Value)
        ENDIF

        IF EMPTY(loc_cValor)
            SELECT cursor_4c_Fornecedores
            REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
                IN cursor_4c_Fornecedores
            loc_oGrid.Refresh()
            RETURN
        ENDIF

        *-- Guarda de reentrancia (ver ValidarProdutoGrid).
        IF THIS.this_lAbrindoLookupGrid
            RETURN
        ENDIF
        THIS.this_lAbrindoLookupGrid = .T.

        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaFornec", par_cCampo, loc_cValor, loc_cTitulo, .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("IClis",   "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis",   "", "Nome")
                loc_oBusca.mAddColuna("Contato", "", "Contato")
                loc_oBusca.mAddColuna("Tel1s",   "", "Telefone")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFornec")
                SELECT cursor_4c_Fornecedores
                REPLACE IClis    WITH ALLTRIM(cursor_4c_BuscaFornec.IClis), ;
                        Fornecs  WITH ALLTRIM(cursor_4c_BuscaFornec.RClis), ;
                        Contatos WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Contato, "")), ;
                        Tel1s    WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Tel1s, "")), ;
                        Fretes   WITH "Emitente" IN cursor_4c_Fornecedores
            ELSE
                SELECT cursor_4c_Fornecedores
                REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
                    IN cursor_4c_Fornecedores
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaFornec")
            USE IN cursor_4c_BuscaFornec
        ENDIF

        loc_oGrid.Refresh()
        THIS.this_lAbrindoLookupGrid = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCondicaoPagtoGrid - Column6 (FPags) do grd_4c_Fornecedores.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCondicaoPagtoGrid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cValor, loc_oBusca

        IF !USED("cursor_4c_Fornecedores") OR EOF("cursor_4c_Fornecedores")
            RETURN
        ENDIF

        loc_oGrid  = THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores
        loc_cValor = ALLTRIM(loc_oGrid.Column6.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        *-- Guarda de reentrancia (ver ValidarProdutoGrid).
        IF THIS.this_lAbrindoLookupGrid
            RETURN
        ENDIF
        THIS.this_lAbrindoLookupGrid = .T.

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", "cursor_4c_BuscaFPag", "FPags", loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", .T.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("FPags",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
                SELECT cursor_4c_Fornecedores
                REPLACE FPags WITH ALLTRIM(cursor_4c_BuscaFPag.FPags) IN cursor_4c_Fornecedores
            ELSE
                SELECT cursor_4c_Fornecedores
                REPLACE FPags WITH "" IN cursor_4c_Fornecedores
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaFPag")
            USE IN cursor_4c_BuscaFPag
        ENDIF

        THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
        THIS.this_lAbrindoLookupGrid = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Solicitante / Departamento / Comprador (cabecalho de Page3) -
    * KeyPress(F4/Enter/Tab) + Validar/AbrirBusca, mesmo padrao de Page1.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaSolicitante(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaSolicitante()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSolicitante()
        ENDIF
    ENDPROC

    PROCEDURE ValidarSolicitante()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page3
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Solicitas.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaSolic", "Usuarios", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oPag.txt_4c_Solicitas.Value = ALLTRIM(cursor_4c_BuscaSolic.Usuarios)
            ELSE
                loc_oBusca.mAddColuna("Usuarios", "", "Solicitante")
                loc_oBusca.mAddColuna("NComps",   "", "Nome")
                loc_oBusca.mAddColuna("Deptos",   "", "Departamento")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSolic")
                    loc_oPag.txt_4c_Solicitas.Value = ALLTRIM(cursor_4c_BuscaSolic.Usuarios)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaSolic")
            USE IN cursor_4c_BuscaSolic
        ENDIF

        *-- Legado: se AprSols ainda vazio, herda o proprio solicitante
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND EMPTY(THIS.this_oBusinessObject.this_cAprSols)
            THIS.this_oBusinessObject.this_cAprSols = ALLTRIM(loc_oPag.txt_4c_Solicitas.Value)
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaSolicitante()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page3
        loc_oPag.txt_4c_Solicitas.Value = ""
        THIS.ValidarSolicitante()
    ENDPROC

    PROCEDURE TeclaDepartamento(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepartamento()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDepartamento()
        ENDIF
    ENDPROC

    PROCEDURE ValidarDepartamento()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page3
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Deptos.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdDpt", "cursor_4c_BuscaDepto", "Codigos", loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", .T.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Codigos",    "", "Departamento")
                loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDepto")
                loc_oPag.txt_4c_Deptos.Value = ALLTRIM(cursor_4c_BuscaDepto.Codigos)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaDepto")
            USE IN cursor_4c_BuscaDepto
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDepartamento()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page3
        loc_oPag.txt_4c_Deptos.Value = ""
        THIS.ValidarDepartamento()
    ENDPROC

    PROCEDURE TeclaCompradorCab(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCompradorCab()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCompradorCab()
        ENDIF
    ENDPROC

    PROCEDURE ValidarCompradorCab()
        LOCAL loc_oPag, loc_cValor, loc_oBusca

        loc_oPag   = THIS.pgf_4c_Paginas.Page3
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Comprador.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaCompr", "Usuarios", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oPag.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaCompr.Usuarios)
            ELSE
                loc_oBusca.mAddColuna("Usuarios", "", "Solicitante")
                loc_oBusca.mAddColuna("NComps",   "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCompr")
                    loc_oPag.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaCompr.Usuarios)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCompr")
            USE IN cursor_4c_BuscaCompr
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCompradorCab()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page3
        loc_oPag.txt_4c_Comprador.Value = ""
        THIS.ValidarCompradorCab()
    ENDPROC

    *--------------------------------------------------------------------------
    * pgAdicionais - Justificativa geral (crSigCtTDc.Justificas) e Entrega
    * geral (ContaEs/DContaEs, sem filtro de grupo - fAcessoContas(Usuar, [],
    * [C]/[D], ...) do legado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarJustGeral(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cJustificas = ;
                THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page1.obj_4c_GetJustGeral.Value
        ENDIF
    ENDPROC

    PROCEDURE TeclaContaEsGeral(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaEsGeral("IClis")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaEsGeral("IClis")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDContaEsGeral(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaEsGeral("RClis")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaEsGeral("RClis")
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaEsGeral(par_cCampo)
        LOCAL loc_oAdic, loc_cValor, loc_cSQL, loc_nResultado

        loc_oAdic = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page1

        IF par_cCampo = "IClis"
            loc_cValor = ALLTRIM(loc_oAdic.txt_4c_ContaEs.Value)
        ELSE
            loc_cValor = ALLTRIM(loc_oAdic.txt_4c_DContaEs.Value)
        ENDIF

        IF EMPTY(loc_cValor)
            loc_oAdic.txt_4c_ContaEs.Value  = ""
            loc_oAdic.txt_4c_DContaEs.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaEsVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_ContaEsVal") AND !EOF("cursor_4c_ContaEsVal")
            loc_oAdic.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_ContaEsVal.IClis)
            loc_oAdic.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_ContaEsVal.RClis)
        ELSE
            loc_oAdic.txt_4c_ContaEs.Value  = ""
            loc_oAdic.txt_4c_DContaEs.Value = ""
            THIS.AbrirBuscaContaEsGeral(par_cCampo)
        ENDIF

        IF USED("cursor_4c_ContaEsVal")
            USE IN cursor_4c_ContaEsVal
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cContaEs = ALLTRIM(loc_oAdic.txt_4c_ContaEs.Value)
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaEsGeral(par_cCampo)
        LOCAL loc_oAdic, loc_cValor, loc_oBusca

        loc_oAdic = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page1

        IF par_cCampo = "IClis"
            loc_cValor = ALLTRIM(loc_oAdic.txt_4c_ContaEs.Value)
        ELSE
            loc_cValor = ALLTRIM(loc_oAdic.txt_4c_DContaEs.Value)
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaContaEs", par_cCampo, loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oAdic.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_BuscaContaEs.IClis)
                loc_oAdic.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_BuscaContaEs.RClis)
            ELSE
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaEs")
                    loc_oAdic.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_BuscaContaEs.IClis)
                    loc_oAdic.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_BuscaContaEs.RClis)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaContaEs")
            USE IN cursor_4c_BuscaContaEs
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cContaEs = ALLTRIM(loc_oAdic.txt_4c_ContaEs.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEntregaGeralClick - cmdEntrega.Valid do legado (pgAdicionais): Do Form
    * SigCdEnd, tela de cadastro de enderecos de entrega do cliente. SigCdEnd
    * NAO foi portado para o sistema novo (nao ha form equivalente) - a
    * resolucao do cliente pela ContaEs eh transcrita; o passo final vira um
    * aviso encaminhando para o cadastro de Clientes, onde os enderecos de
    * entrega devem ser mantidos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEntregaGeralClick()
        LOCAL loc_cContaEs, loc_cSQL, loc_nResultado

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cContaEs = ALLTRIM(THIS.this_oBusinessObject.this_cContaEs)

        IF EMPTY(loc_cContaEs)
            MsgAviso("Informe a Conta de Entrega antes de escolher o local de entrega.", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cContaEs)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EntregaCli")

        IF loc_nResultado < 0 OR !USED("cursor_4c_EntregaCli") OR EOF("cursor_4c_EntregaCli")
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                "Falha na Conex" + CHR(227) + "o (cmdEntrega)")
        ELSE
            MsgAviso("A tela de Local de Entrega (SigCdEnd) n" + CHR(227) + "o foi portada para o " + ;
                "sistema novo." + CHR(13) + "Cadastre/ajuste os endere" + CHR(231) + "os de entrega do " + ;
                "cliente " + ALLTRIM(cursor_4c_EntregaCli.RClis) + " pelo cadastro de Clientes.", "Aviso")
        ENDIF

        IF USED("cursor_4c_EntregaCli")
            USE IN cursor_4c_EntregaCli
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * pgAprovacao - Aprovador Final (Usuario ativo, fwBuscaExt), Data e
    * Observacao (sem lookup, so gravam no BO) e o CheckBox de aprovacao.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaAprovadorFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaAprovadorFinal()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarAprovadorFinal()
        ENDIF
    ENDPROC

    PROCEDURE ValidarAprovadorFinal()
        LOCAL loc_oApr, loc_cValor, loc_oBusca

        loc_oApr   = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2
        loc_cValor = ALLTRIM(loc_oApr.txt_4c_Aprovador.Value)

        IF EMPTY(loc_cValor)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cAprovador = ""
            ENDIF
            THIS.pgf_4c_Paginas.Page3.txt_4c_AprovadorCab.Value = ""
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaAprov", "Usuarios", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oApr.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprov.Usuarios)
            ELSE
                loc_oBusca.mAddColuna("Usuarios", "", "Aprovador")
                loc_oBusca.mAddColuna("NComps",   "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAprov")
                    loc_oApr.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprov.Usuarios)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaAprov")
            USE IN cursor_4c_BuscaAprov
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cAprovador = ALLTRIM(loc_oApr.txt_4c_Aprovador.Value)
        ENDIF

        *-- Espelho de leitura na raiz de Page3 (txt_4c_AprovadorCab)
        THIS.pgf_4c_Paginas.Page3.txt_4c_AprovadorCab.Value = loc_oApr.txt_4c_Aprovador.Value
    ENDPROC

    PROCEDURE AbrirBuscaAprovadorFinal()
        LOCAL loc_oApr

        loc_oApr = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2
        loc_oApr.txt_4c_Aprovador.Value = ""
        THIS.ValidarAprovadorFinal()
    ENDPROC

    PROCEDURE ValidarDtAprovs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oApr

        loc_oApr = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDtAprovs = loc_oApr.txt_4c_DtAprovs.Value
        ENDIF
    ENDPROC

    PROCEDURE ValidarObsAprovs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oApr

        loc_oApr = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cObsAprovs = loc_oApr.obj_4c_GetObsAprovs.Value
        ENDIF
    ENDPROC

    PROCEDURE ValidarDtAprSols(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oSol

        loc_oSol = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page3

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDtAprSols = loc_oSol.txt_4c_DtAprSols.Value
        ENDIF
    ENDPROC

    PROCEDURE ValidarObsAprSols(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oSol

        loc_oSol = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page3

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cObsAprSols = loc_oSol.obj_4c_GetObsAprSols.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkAprovadorClick - PROCEDURE Valid do chkAprovador legado: grava os
    * dados (GravaDados) e dispara AprovarCotacao. Transcrito literal.
    *--------------------------------------------------------------------------
    PROCEDURE ChkAprovadorClick()
        LOCAL loc_oPg2

        loc_oPg2 = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nChkAprovs = loc_oPg2.chk_4c_ChkAprovador.Value
        ENDIF

        IF !THIS.GravaDados()
            RETURN
        ENDIF

        THIS.AprovarCotacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirProdutoClick / BtnHistoricoProdutoClick - cmdEscolha do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirProdutoClick()
        THIS.ExcluiProduto()
    ENDPROC

    PROCEDURE BtnHistoricoProdutoClick()
        *-- Legado: Do Form SigMvCth (historico de compras do produto). Form
        *-- nao portado para o sistema novo (ver docs/GUIA_RAPIDO_MIGRACAO.md /
        *-- ProximasMigracoes\SigMvCth.SCX, ainda nao migrado).
        IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos") AND !EMPTY(cursor_4c_Produtos.CPros)
            MsgAviso("Hist" + CHR(243) + "rico de compras do produto (SigMvCth) n" + CHR(227) + "o " + ;
                "dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluiProduto - cmdEscolha.btnExcluirItem / Valid de cmdProdutos.
    * btnExcluir: remove a linha corrente de cursor_4c_Produtos, renumera
    * CItens e, se a operacao de origem (EmpDopNums) nao ficar mais referenciada
    * por NENHUM outro item, desmarca SigMvCab.Utilizados para liberar a
    * movimentacao. Nunca deixa a grade com menos de 1 linha (regra do legado:
    * "So Ha Um Produto - Nao E Possivel Excluir").
    *--------------------------------------------------------------------------
    PROCEDURE ExcluiProduto()
        LOCAL loc_cEdn, loc_cIdAtual, loc_nRec, loc_nCod, loc_nItn, loc_cSQL, loc_nResultado

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Nenhum Produto Selecionado na Grade!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN .F.
        ENDIF

        IF RECCOUNT("cursor_4c_Produtos") = 1
            MsgAviso("S" + CHR(243) + " H" + CHR(225) + " Um Produto na Grade!!! N" + CHR(227) + ;
                "o " + CHR(233) + " Poss" + CHR(237) + "vel Efetuar a Exclus" + CHR(227) + "o!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN .F.
        ENDIF

        loc_cEdn = cursor_4c_Produtos.EmpDopNums
        loc_cIdAtual = cursor_4c_Produtos.cIdChaves
        loc_nRec = RECNO("cursor_4c_Produtos")

        IF !EMPTY(loc_cEdn) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_nCod = THIS.this_oBusinessObject.this_nCodigos

            *-- So desmarca o SigMvCab se NENHUMA outra linha (desta ou de
            *-- OUTRAS cotacoes ja gravadas) ainda usar a mesma operacao
            SELECT COUNT(*) AS Total FROM cursor_4c_Produtos ;
                WHERE EmpDopNums = loc_cEdn AND cIdChaves != loc_cIdAtual ;
                INTO CURSOR cursor_4c_ChecagemLocal

            IF cursor_4c_ChecagemLocal.Total = 0
                loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
                    EscaparSQL(loc_cEdn) + " AND Codigos != " + FormatarNumeroSQL(loc_nCod, 0)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChecagemSQL")

                IF loc_nResultado >= 0 AND USED("cursor_4c_ChecagemSQL") AND EOF("cursor_4c_ChecagemSQL")
                    SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
                        EscaparSQL(loc_cEdn))
                ENDIF

                IF USED("cursor_4c_ChecagemSQL")
                    USE IN cursor_4c_ChecagemSQL
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChecagemLocal")
                USE IN cursor_4c_ChecagemLocal
            ENDIF
        ENDIF

        SELECT cursor_4c_Produtos
        DELETE IN cursor_4c_Produtos

        loc_nItn = 1
        SCAN
            REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
            loc_nItn = loc_nItn + 1
        ENDSCAN

        GO TOP IN cursor_4c_Produtos
        IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Produtos")
            GO loc_nRec IN cursor_4c_Produtos
        ENDIF

        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
        THIS.GridCotacoesAfterRowColChange(1)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarLinhaProduto - cmdProdutos.btnInserir/btnExcluir.Valid: os dois
    * botoes do legado fazem EXATAMENTE a mesma coisa (renumerar CItens,
    * remover linhas com CPros vazio e inserir uma linha em branco no final).
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarLinhaProduto()
        LOCAL loc_nItn, loc_nCod

        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_nCod = 0
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_nCod = THIS.this_oBusinessObject.this_nCodigos
        ENDIF

        loc_nItn = 1
        SELECT cursor_4c_Produtos
        SCAN
            REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
            IF EMPTY(cursor_4c_Produtos.CPros)
                DELETE IN cursor_4c_Produtos
            ELSE
                loc_nItn = loc_nItn + 1
            ENDIF
        ENDSCAN

        INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
            VALUES (LEFT(fUniqueIds(), 20), loc_nCod, loc_nItn, "", "", "", 0, "", 0)

        GO BOTTOM IN cursor_4c_Produtos
        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
        THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Column1.SetFocus()
        THIS.GridCotacoesAfterRowColChange(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairCotacoesClick - cmdBotoes.btnSair.Click de Page3: confirma
    * abandono em modo de edicao, desfaz a edicao em curso do BO e volta para
    * a pagina de Dados (Page2).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairCotacoesClick()
        LOCAL loc_lConfirma

        loc_lConfirma = .T.

        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            loc_lConfirma = MsgConfirma("Deseja Realmente Abandonar as Altera" + CHR(231) + CHR(245) + "es?", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF

        IF !loc_lConfirma
            THIS.pgf_4c_Paginas.Page3.obj_4c_CmdGravar.Buttons(1).SetFocus()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CancelarEdicao()
        ENDIF

        THIS.this_cModoAtual = "DADOS"
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGravarCotacaoClick - cmdGravar.btnGravaDados.Click: grava e volta para
    * a pagina de Dados, exatamente como o legado (que reusa o mesmo bloco do
    * btnSair apos gravar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnGravarCotacaoClick()
        IF !THIS.GravaDados()
            RETURN
        ENDIF

        IF THIS.CarregarLista()
            THIS.this_cModoAtual = "DADOS"
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravaDados - Equivalente ao PROCEDURE gravadados legado: apaga o que
    * existia para este Codigos e regrava o cabecalho (SigCtTDc, via BO) e os
    * itens/fornecedores (SigCtTCt/SigCtTFn, INSERT direto - esta arquitetura
    * nao usa cursores bufferizados/TABLEUPDATE como o legado, entao o padrao
    * "apagar tudo e regravar" e feito com DELETE + INSERT explicitos).
    *
    * Modo EXCLUIR: so apaga (cabecalho + filhos) e libera o SigMvCab.
    *--------------------------------------------------------------------------
    PROCEDURE GravaDados()
        LOCAL loc_lOk, loc_nCod, loc_cSQL, loc_nI, loc_cNum, loc_nRec

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_lOk = .T.

        *-- ValAdqs = Total do fornecedor marcado (ou 0 se nenhum) - transcrito
        IF USED("cursor_4c_Produtos")
            loc_nRec = RECNO("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            SCAN
                loc_cNum = ""
                FOR loc_nI = 1 TO 6
                    IF EVALUATE("Marca" + PADL(loc_nI, 2, "0"))
                        loc_cNum = PADL(loc_nI, 2, "0")
                    ENDIF
                ENDFOR
                IF EMPTY(loc_cNum)
                    REPLACE ValAdqs WITH 0 IN cursor_4c_Produtos
                ELSE
                    REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum) IN cursor_4c_Produtos
                ENDIF
            ENDSCAN
            IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Produtos"))
                GO loc_nRec IN cursor_4c_Produtos
            ENDIF
        ENDIF

        IF THIS.this_cPcEscolha = "EXCLUIR"
            loc_nCod = THIS.this_oBusinessObject.this_nCodigos

            *-- Libera as operacoes (SigMvCab) que so eram usadas por esta cotacao
            IF USED("cursor_4c_Produtos")
                SELECT DISTINCT EmpDopNums FROM cursor_4c_Produtos ;
                    WHERE !EMPTY(EmpDopNums) INTO CURSOR cursor_4c_ApagarEdn

                SELECT cursor_4c_ApagarEdn
                SCAN
                    loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
                        EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums) + " AND Codigos != " + ;
                        FormatarNumeroSQL(loc_nCod, 0)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ApagarChk") >= 0
                        IF USED("cursor_4c_ApagarChk") AND EOF("cursor_4c_ApagarChk")
                            SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
                                EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums))
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_ApagarChk")
                        USE IN cursor_4c_ApagarChk
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_ApagarEdn")
                    USE IN cursor_4c_ApagarEdn
                ENDIF
            ENDIF

            IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
                MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - Apagando SigCtTFn)" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lOk = .F.
            ENDIF
            IF loc_lOk AND SQLEXEC(gnConnHandle, "DELETE FROM SigCtTCt WHERE Codigos = " + ;
                FormatarNumeroSQL(loc_nCod, 0)) < 0
                MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - Apagando SigCtTCt)" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lOk = .F.
            ENDIF
            IF loc_lOk AND !THIS.this_oBusinessObject.Excluir()
                loc_lOk = .F.
            ENDIF

            RETURN loc_lOk
        ENDIF

        *-- INSERIR/ALTERAR: recolhe primeiro o que esta nos controles do
        *-- cabecalho (no legado o ControlSource ja mantinha crSigCtTDc em dia;
        *-- aqui, campo digitado e gravado sem sair do foco nunca chegou ao BO)
        THIS.FormParaBO()

        *-- e so entao grava o cabecalho via BO (Inserir gera cidchaves +
        *-- codigos automaticamente no primeiro Salvar)
        IF !THIS.this_oBusinessObject.Salvar()
            RETURN .F.
        ENDIF

        loc_nCod = THIS.this_oBusinessObject.this_nCodigos

        *-- Regrava filhos: apaga o que ja existia e reinsere o cursor inteiro
        IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
            MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - SigCtTFn)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF
        IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
            MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - SigCtTCt)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_Fornecedores")
            SELECT cursor_4c_Fornecedores
            SCAN
                loc_cSQL = "INSERT INTO SigCtTFn (cidchaves, codigos, grades, iclis, fornecs, contatos, " + ;
                    "tel1s, fpags, dtents, fretes, vlfretes) VALUES (" + ;
                    EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
                    FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
                    EscaparSQL(Grades) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(IClis), 10)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(Fornecs), 40)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(Contatos), 20)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(Tel1s), 20)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(FPags), 12)) + ", " + ;
                    FormatarDataSQL(DtEnts) + ", " + ;
                    EscaparSQL(LEFT(IIF(EMPTY(Fretes), "Emitente", ALLTRIM(Fretes)), 12)) + ", " + ;
                    FormatarNumeroSQL(VlFretes, 2) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTFn)" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                    RETURN .F.
                ENDIF
            ENDSCAN
        ENDIF

        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            SCAN FOR !EMPTY(CPros)
                loc_cSQL = "INSERT INTO SigCtTCt (cidchaves, codigos, citens, cpros, dpros, cunis, " + ;
                    "codcors, codtams, empdopnums, obs, justificas, qtds, qtdadqs, valadqs, " + ;
                    "marca01, marca02, marca03, marca04, marca05, marca06, " + ;
                    "unit01, unit02, unit03, unit04, unit05, unit06, " + ;
                    "tota01, tota02, tota03, tota04, tota05, tota06) VALUES (" + ;
                    EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
                    FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
                    FormatarNumeroSQL(CItens, 0) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(CPros), 14)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(DPros), 65)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(CUnis), 3)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(NVL(CodCors, "")), 4)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(NVL(CodTams, "")), 4)) + ", " + ;
                    EscaparSQL(LEFT(NVL(EmpDopNums, ""), 29)) + ", " + ;
                    EscaparSQL(Obs) + ", " + EscaparSQL(Justificas) + ", " + ;
                    FormatarNumeroSQL(Qtds, 2) + ", " + FormatarNumeroSQL(QtdAdqs, 2) + ", " + ;
                    FormatarNumeroSQL(ValAdqs, 6) + ", " + ;
                    IIF(Marca01, "1", "0") + ", " + IIF(Marca02, "1", "0") + ", " + IIF(Marca03, "1", "0") + ", " + ;
                    IIF(Marca04, "1", "0") + ", " + IIF(Marca05, "1", "0") + ", " + IIF(Marca06, "1", "0") + ", " + ;
                    FormatarNumeroSQL(Unit01, 6) + ", " + FormatarNumeroSQL(Unit02, 6) + ", " + ;
                    FormatarNumeroSQL(Unit03, 6) + ", " + FormatarNumeroSQL(Unit04, 6) + ", " + ;
                    FormatarNumeroSQL(Unit05, 6) + ", " + FormatarNumeroSQL(Unit06, 6) + ", " + ;
                    FormatarNumeroSQL(Tota01, 6) + ", " + FormatarNumeroSQL(Tota02, 6) + ", " + ;
                    FormatarNumeroSQL(Tota03, 6) + ", " + FormatarNumeroSQL(Tota04, 6) + ", " + ;
                    FormatarNumeroSQL(Tota05, 6) + ", " + FormatarNumeroSQL(Tota06, 6) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTCt)" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_Produtos
            ENDSCAN
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AprovarCotacao - Equivalente ao PROCEDURE aprovarcotacao legado.
    * Transcrito literal: cada guarda de validacao, ao falhar, zera ChkAprovs,
    * regrava (GravaDados) e devolve o foco ao campo correspondente.
    *--------------------------------------------------------------------------
    PROCEDURE AprovarCotacao()
        LOCAL loc_oApr, loc_oBO, loc_cSQL, loc_nResultado, loc_nVlLib, loc_nTotalCotacao

        loc_oApr = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2
        loc_oBO  = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        IF EMPTY(loc_oBO.this_cAprovador)
            MsgAviso("O Aprovador Final N" + CHR(227) + "o Foi Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oBO.this_nChkAprovs = 0
            IF !THIS.GravaDados()
                RETURN .F.
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_Aprovador.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_oBO.this_dDtAprovs)
            MsgAviso("A Data da Aprova" + CHR(231) + CHR(227) + "o Final N" + CHR(227) + "o Foi Informada!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oBO.this_nChkAprovs = 0
            IF !THIS.GravaDados()
                RETURN .F.
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_DtAprovs.SetFocus()
            RETURN .F.
        ENDIF

        IF !THIS.this_lLibSolics
            IF EMPTY(loc_oBO.this_cAprSols)
                MsgAviso("O Aprovador Solicitante N" + CHR(227) + "o Foi Informado!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oBO.this_nChkAprovs = 0
                IF !THIS.GravaDados()
                    RETURN .F.
                ENDIF
                loc_oApr.chk_4c_ChkAprovador.Value = 0
                loc_oApr.txt_4c_Aprovador.SetFocus()
                RETURN .F.
            ENDIF

            IF EMPTY(loc_oBO.this_dDtAprSols)
                MsgAviso("A Data da Aprova" + CHR(231) + CHR(227) + "o do Solicitante N" + CHR(227) + ;
                    "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oBO.this_nChkAprovs = 0
                IF !THIS.GravaDados()
                    RETURN .F.
                ENDIF
                loc_oApr.chk_4c_ChkAprovador.Value = 0
                loc_oApr.txt_4c_DtAprovs.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        IF ALLTRIM(UPPER(gc_4c_UsuarioLogado)) != ALLTRIM(UPPER(loc_oBO.this_cAprovador))
            MsgAviso("O Aprovador Informado N" + CHR(227) + "o Confere Com o Usu" + CHR(225) + "rio Logado!!!" + ;
                CHR(13) + "Esse Procedimento Ser" + CHR(225) + " Registrado Para Auditoria!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oBO.this_nChkAprovs = 0
            IF !THIS.GravaDados()
                RETURN .F.
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_Aprovador.SetFocus()
            RETURN .F.
        ENDIF

        IF loc_oBO.this_nChkAprovs = 0
            *-- Usuario DESMARCOU a aprovacao - elimina os dados, exceto se o
            *-- pedido ja tiver sido gerado (Situas <> 0)
            IF loc_oBO.this_nSituas != 0
                MsgAviso("O Pedido J" + CHR(225) + " Foi Gerado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ELSE
                loc_oBO.this_cAprovador = ""
                loc_oBO.this_dDtAprovs  = {}
                loc_oBO.this_cObsAprovs = ""
                loc_oApr.txt_4c_Aprovador.Value    = ""
                loc_oApr.txt_4c_DtAprovs.Value     = {}
                loc_oApr.obj_4c_GetObsAprovs.Value = ""
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_Aprovador.SetFocus()
            RETURN .F.
        ENDIF

        *-- Procurando o cargo do aprovador e o valor maximo de liberacao
        loc_cSQL = "SELECT CCargs FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(loc_oBO.this_cAprovador)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargoAprov")

        IF loc_nResultado < 0 OR !USED("cursor_4c_CargoAprov") OR EOF("cursor_4c_CargoAprov") OR ;
           EMPTY(cursor_4c_CargoAprov.CCargs)
            MsgAviso("O Aprovador N" + CHR(227) + "o Possui o Cargo Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oBO.this_nChkAprovs = 0
            IF !THIS.GravaDados()
                RETURN .F.
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_Aprovador.SetFocus()
            IF USED("cursor_4c_CargoAprov")
                USE IN cursor_4c_CargoAprov
            ENDIF
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT VlLibCots FROM SigCdCrg WHERE CCargs = " + EscaparSQL(cursor_4c_CargoAprov.CCargs)
        USE IN cursor_4c_CargoAprov
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LimiteAprov")

        IF loc_nResultado < 0 OR !USED("cursor_4c_LimiteAprov") OR EOF("cursor_4c_LimiteAprov") OR ;
           EMPTY(cursor_4c_LimiteAprov.VlLibCots)
            MsgAviso("O Cargo do Aprovador N" + CHR(227) + "o Possui Um Valor de Libera" + CHR(231) + CHR(227) + ;
                "o de Cota" + CHR(231) + CHR(227) + "o Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oBO.this_nChkAprovs = 0
            IF !THIS.GravaDados()
                RETURN .F.
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_Aprovador.SetFocus()
            IF USED("cursor_4c_LimiteAprov")
                USE IN cursor_4c_LimiteAprov
            ENDIF
            RETURN .F.
        ENDIF

        loc_nVlLib = cursor_4c_LimiteAprov.VlLibCots
        USE IN cursor_4c_LimiteAprov

        IF !THIS.GeraPedidos(.T.)
            loc_oBO.this_nChkAprovs = 0
            IF !THIS.GravaDados()
                RETURN .F.
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_Aprovador.SetFocus()
            RETURN .F.
        ENDIF

        loc_nTotalCotacao = 0
        IF USED("cursor_4c_CabOperas")
            SELECT SUM(Valors) AS Total FROM cursor_4c_CabOperas INTO CURSOR cursor_4c_SomaCab
            IF USED("cursor_4c_SomaCab") AND !EOF("cursor_4c_SomaCab")
                loc_nTotalCotacao = NVL(cursor_4c_SomaCab.Total, 0)
            ENDIF
            IF USED("cursor_4c_SomaCab")
                USE IN cursor_4c_SomaCab
            ENDIF
        ENDIF

        IF loc_nTotalCotacao <= 0 OR loc_nTotalCotacao > loc_nVlLib
            MsgAviso("O Cargo do Aprovador N" + CHR(227) + "o Permite a Aprova" + CHR(231) + CHR(227) + ;
                "o Do Valor Desta Cota" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + CHR(13) + ;
                "Valor da Cota" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nTotalCotacao, 12, 2)) + ;
                "  -  Limite Para Aprova" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nVlLib, 12, 2)), ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oBO.this_nChkAprovs = 0
            IF !THIS.GravaDados()
                RETURN .F.
            ENDIF
            loc_oApr.chk_4c_ChkAprovador.Value = 0
            loc_oApr.txt_4c_Aprovador.SetFocus()
            RETURN .F.
        ENDIF

        MsgInfo("Cota" + CHR(231) + CHR(227) + "o Aprovada!!!", "Aprova" + CHR(231) + CHR(227) + "o!!!")
        THIS.pgf_4c_Paginas.Page3.obj_4c_CmdGravar.Buttons(2).SetFocus()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresPedidos - Cursores locais da pagina de Pedidos (Page4):
    *
    *   cursor_4c_Pedidos    -> crPedidos    (staging por produto/fornecedor)
    *   cursor_4c_CabOperas  -> crCabOperas  (grdCabOperas, 1 linha por Numes)
    *   cursor_4c_ItnOperas  -> crItnOperas  (grdItnOperas, itens de cada Numes)
    *   cursor_4c_Subniveis  -> crSubniveis  (operacoes de subnivel do Dopes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresPedidos()
        IF USED("cursor_4c_Pedidos")
            USE IN cursor_4c_Pedidos
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Pedidos ( ;
            IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), CPros C(14), DPros C(65), ;
            CUnis C(3), Obs M(4), Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), ;
            CodCors C(4), CodTams C(4))
        SET NULL OFF

        IF USED("cursor_4c_CabOperas")
            USE IN cursor_4c_CabOperas
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_CabOperas ( ;
            Numes N(6), IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), ;
            Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), Jobs C(10))
        SET NULL OFF
        INDEX ON IFors TAG IFors
        INDEX ON Numes TAG Ordem

        IF USED("cursor_4c_ItnOperas")
            USE IN cursor_4c_ItnOperas
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_ItnOperas ( ;
            Numes N(6), CItens N(6), CPros C(14), DPros C(65), CodCors C(4), CodTams C(4), ;
            CUnis C(3), Obs M(4), Qtds N(15,2), Units N(15,6), Valors N(15,2))
        SET NULL OFF
        INDEX ON STR(Numes, 6) + STR(CItens, 6) TAG Ordem

        IF USED("cursor_4c_Subniveis")
            USE IN cursor_4c_Subniveis
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Subniveis ( ;
            Dopes C(20), GruOrigs C(10), GruDests C(10), ConDests C(10), Opers N(1), ;
            CMoes C(3), NFiscals N(1), Series C(3), Especies C(2), TipoNfs N(1), ;
            MarcaSubns C(1), Cfos C(10), Casas N(1), GrVends C(10), ChkLimOps N(1))
        SET NULL OFF
        INDEX ON Dopes TAG Dopes
    ENDPROC

    *--------------------------------------------------------------------------
    * GeraPedidos - Equivalente ao PROCEDURE gerapedidos legado: valida os
    * dados de cada fornecedor marcado na grade de Produtos, monta os cursores
    * de cabecalho/itens da pagina de Pedidos e navega para Page4 (a menos que
    * par_lChk seja .T., usado por AprovarCotacao so para CALCULAR o total).
    *
    * NAO inclui a gravacao fisica (SigMvCab/SigMvItn/financeiro) - essa parte
    * (GravaPedidos do legado) esta em THIS.GravaPedidos(), acionada pelo
    * botao "Processar Pedidos" (BtnProcessarPedidosClick).
    *--------------------------------------------------------------------------
    PROCEDURE GeraPedidos(par_lChk)
        LOCAL loc_oBO, loc_cLetra, loc_nI, loc_lAchouFn, loc_cGrade
        LOCAL loc_cIFors, loc_cFornecs, loc_cFPags, loc_dDtEnts, loc_cFretes, loc_nVlFretes
        LOCAL loc_cSQL, loc_nResultado, loc_nNum, loc_nItn, loc_nNumAtual

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        IF EMPTY(loc_oBO.this_dDtPagtos)
            MsgAviso("A Data de Pagamento N" + CHR(227) + "o Foi Informada!!!", ;
                "Data de Pagamento N" + CHR(227) + "o Informada")
            THIS.pgf_4c_Paginas.Page3.txt_4c_DtPagtos.SetFocus()
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Pedidos")
            THIS.CriarCursoresPedidos()
        ENDIF

        ZAP IN cursor_4c_Pedidos
        ZAP IN cursor_4c_CabOperas
        ZAP IN cursor_4c_ItnOperas

        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            SCAN
                loc_cLetra = ""
                DO CASE
                    CASE cursor_4c_Produtos.Marca01
                        loc_cLetra = "A"
                    CASE cursor_4c_Produtos.Marca02
                        loc_cLetra = "B"
                    CASE cursor_4c_Produtos.Marca03
                        loc_cLetra = "C"
                    CASE cursor_4c_Produtos.Marca04
                        loc_cLetra = "D"
                    CASE cursor_4c_Produtos.Marca05
                        loc_cLetra = "E"
                    CASE cursor_4c_Produtos.Marca06
                        loc_cLetra = "F"
                    OTHERWISE
                        REPLACE ValAdqs WITH 0 IN cursor_4c_Produtos
                ENDCASE

                IF !EMPTY(loc_cLetra)
                    loc_lAchouFn = SEEK(loc_cLetra, "cursor_4c_Fornecedores", "Ordem")

                    IF !loc_lAchouFn
                        MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
                            ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + ;
                            "N" + CHR(227) + "o Tem o Fornecedor Informado!!! Corrija os Dados e Tente " + ;
                            "Novamente!!!", "Fornecedor N" + CHR(227) + "o Informado")
                        RETURN .F.
                    ENDIF

                    IF EMPTY(cursor_4c_Fornecedores.FPags)
                        MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
                            "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
                            "N" + CHR(227) + "o Tem a Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                            "Informada!!! Corrija os Dados e Tente Novamente!!!", ;
                            "Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Informada")
                        RETURN .F.
                    ENDIF

                    IF EMPTY(cursor_4c_Fornecedores.DtEnts)
                        MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
                            "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
                            "N" + CHR(227) + "o Tem a Data de Entrega Informada!!! Corrija os Dados e " + ;
                            "Tente Novamente!!!", "Data de Entrega N" + CHR(227) + "o Informada")
                        RETURN .F.
                    ENDIF

                    IF EMPTY(cursor_4c_Fornecedores.Fretes)
                        MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
                            "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
                            "N" + CHR(227) + "o Tem o Frete (Emitente/Destinat" + CHR(225) + "rio) Informado!!! " + ;
                            "Corrija os Dados e Tente Novamente!!!", "Frete N" + CHR(227) + "o Informado")
                        RETURN .F.
                    ENDIF

                    IF ALLTRIM(cursor_4c_Fornecedores.Fretes) == "Destinatario" AND EMPTY(cursor_4c_Fornecedores.VlFretes)
                        MsgAviso("O Fornecedor " + loc_cLetra + " - " + ALLTRIM(cursor_4c_Fornecedores.IClis) + ;
                            "-" + ALLTRIM(cursor_4c_Fornecedores.Fornecs) + CHR(13) + ;
                            "N" + CHR(227) + "o Tem o Valor do Frete Informado!!! Corrija os Dados e Tente " + ;
                            "Novamente!!!", "Valor do Frete N" + CHR(227) + "o Informado")
                        RETURN .F.
                    ENDIF

                    IF EMPTY(cursor_4c_Produtos.QtdAdqs)
                        MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + " N" + CHR(227) + "o Tem a " + ;
                            "Quantidade Adquirida Informada!!!" + CHR(13) + "Corrija os Dados e Tente " + ;
                            "Novamente!!!", "Quantidade Adquirida N" + CHR(227) + "o Informada")
                        RETURN .F.
                    ENDIF

                    IF EMPTY(cursor_4c_Produtos.ValAdqs)
                        MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + " N" + CHR(227) + "o Tem o " + ;
                            "Valor Adquirido Informado!!!" + CHR(13) + "Corrija os Dados e Tente Novamente!!!", ;
                            "Valor Adquirido N" + CHR(227) + "o Informado")
                        RETURN .F.
                    ENDIF

                    IF EMPTY(cursor_4c_Fornecedores.IClis)
                        MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
                            ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + "Foi Solicitado ao Fornecedor " + ;
                            loc_cLetra + " Que Est" + CHR(225) + " Sem o C" + CHR(243) + "digo Informado!!!" + ;
                            CHR(13) + "Para Gerar Pedidos " + CHR(233) + " Necess" + CHR(225) + "rio Realizar " + ;
                            "o Cadastro Deste Fornecedor!!!", "Fornecedor N" + CHR(227) + "o Informado")
                        RETURN .F.
                    ENDIF

                    loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(cursor_4c_Fornecedores.IClis)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ForneCliChk")

                    IF loc_nResultado < 0 OR !USED("cursor_4c_ForneCliChk") OR EOF("cursor_4c_ForneCliChk")
                        MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
                            ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + "Foi Solicitado ao Fornecedor " + ;
                            loc_cLetra + " Que Est" + CHR(225) + " Sem o C" + CHR(243) + "digo Informado!!!" + ;
                            CHR(13) + "Para Gerar Pedidos " + CHR(233) + " Necess" + CHR(225) + "rio Realizar " + ;
                            "o Cadastro Deste Fornecedor!!!", "Fornecedor N" + CHR(227) + "o Informado")
                        IF USED("cursor_4c_ForneCliChk")
                            USE IN cursor_4c_ForneCliChk
                        ENDIF
                        RETURN .F.
                    ENDIF
                    IF USED("cursor_4c_ForneCliChk")
                        USE IN cursor_4c_ForneCliChk
                    ENDIF

                    INSERT INTO cursor_4c_Pedidos (IFors, Fornecs, FPags, DtEnts, CPros, DPros, CUnis, Obs, ;
                            Qtds, Valors, Fretes, VlFretes, CodCors, CodTams) ;
                        VALUES (ALLTRIM(cursor_4c_Fornecedores.IClis), ALLTRIM(cursor_4c_Fornecedores.Fornecs), ;
                            ALLTRIM(cursor_4c_Fornecedores.FPags), NVL(cursor_4c_Fornecedores.DtEnts, {}), ;
                            ALLTRIM(cursor_4c_Produtos.CPros), ALLTRIM(cursor_4c_Produtos.DPros), ;
                            ALLTRIM(cursor_4c_Produtos.CUnis), NVL(cursor_4c_Produtos.Obs, ""), ;
                            cursor_4c_Produtos.QtdAdqs, cursor_4c_Produtos.ValAdqs, ;
                            ALLTRIM(cursor_4c_Fornecedores.Fretes), cursor_4c_Fornecedores.VlFretes, ;
                            NVL(cursor_4c_Produtos.CodCors, ""), NVL(cursor_4c_Produtos.CodTams, ""))
                ENDIF
            ENDSCAN
        ENDIF

        IF !USED("cursor_4c_Pedidos") OR EOF("cursor_4c_Pedidos")
            MsgAviso("Nenhum Produto Foi Selecionado Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN .F.
        ENDIF

        *-- Agrupa por fornecedor (crCabOperas: 1 linha por IFors)
        loc_nNum = 0
        SELECT cursor_4c_Pedidos
        SCAN
            IF !SEEK(cursor_4c_Pedidos.IFors, "cursor_4c_CabOperas", "IFors")
                loc_nNum = loc_nNum + 1
                INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Fretes, VlFretes, Jobs) ;
                    VALUES (loc_nNum, cursor_4c_Pedidos.IFors, cursor_4c_Pedidos.Fornecs, cursor_4c_Pedidos.FPags, ;
                        cursor_4c_Pedidos.DtEnts, cursor_4c_Pedidos.Fretes, cursor_4c_Pedidos.VlFretes, ;
                        THIS.this_cJobs)
            ENDIF

            loc_nNumAtual = cursor_4c_CabOperas.Numes
            SELECT cursor_4c_CabOperas
            REPLACE Qtds WITH Qtds + cursor_4c_Pedidos.Qtds, ;
                    Valors WITH Valors + cursor_4c_Pedidos.Valors IN cursor_4c_CabOperas

            INSERT INTO cursor_4c_ItnOperas (Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
                VALUES (loc_nNumAtual, cursor_4c_Pedidos.CPros, cursor_4c_Pedidos.DPros, cursor_4c_Pedidos.CodCors, ;
                    cursor_4c_Pedidos.CodTams, cursor_4c_Pedidos.CUnis, cursor_4c_Pedidos.Obs, ;
                    cursor_4c_Pedidos.Qtds, IIF(cursor_4c_Pedidos.Qtds = 0, 0, cursor_4c_Pedidos.Valors / cursor_4c_Pedidos.Qtds), ;
                    cursor_4c_Pedidos.Valors)

            SELECT cursor_4c_Pedidos
        ENDSCAN

        *-- Renumera CItens dentro de cada Numes
        loc_nNumAtual = -1
        loc_nItn = 0
        SELECT cursor_4c_ItnOperas
        SCAN
            IF loc_nNumAtual != cursor_4c_ItnOperas.Numes
                loc_nItn     = 0
                loc_nNumAtual = cursor_4c_ItnOperas.Numes
            ENDIF
            loc_nItn = loc_nItn + 1
            REPLACE CItens WITH loc_nItn IN cursor_4c_ItnOperas
        ENDSCAN

        *-- Operacoes de subnivel do Dopes filtrado em Page1
        loc_cSQL = ;
            "SELECT a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, " + ;
            "a.Series, a.Especies, a.TipoNfs, a.MarcaSubns, a.Cfos, a.Casas, a.GrVends, b.ChkLimOps " + ;
            "FROM SigCdOpe a INNER JOIN SigOpCdd b ON a.Dopes = b.Dopes " + ;
            "WHERE a.Nivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + " " + ;
            "UNION ALL " + ;
            "SELECT b.CDopes AS Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, " + ;
            "c.Series, c.Especies, c.TipoNfs, c.MarcaSubns, c.Cfos, c.Casas, c.GrVends, d.ChkLimOps " + ;
            "FROM SigOpCsn b INNER JOIN SigCdOpe c ON b.CDopes = c.Dopes " + ;
            "INNER JOIN SigOpCdd d ON b.CDopes = d.Dopes " + ;
            "WHERE b.CNivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubTemp")

        IF loc_nResultado < 0
            MsgErro("Falha na Conex" + CHR(227) + "o (GeraPedidos - Subn" + CHR(237) + "veis)" + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Subniveis")
            THIS.CriarCursoresPedidos()
        ENDIF
        ZAP IN cursor_4c_Subniveis

        IF USED("cursor_4c_SubTemp")
            SELECT DISTINCT * FROM cursor_4c_SubTemp INTO CURSOR cursor_4c_SubDistinct
            SELECT cursor_4c_SubDistinct
            SCAN
                INSERT INTO cursor_4c_Subniveis (Dopes, GruOrigs, GruDests, ConDests, Opers, CMoes, ;
                        NFiscals, Series, Especies, TipoNfs, MarcaSubns, Cfos, Casas, GrVends, ChkLimOps) ;
                    VALUES (cursor_4c_SubDistinct.Dopes, cursor_4c_SubDistinct.GruOrigs, cursor_4c_SubDistinct.GruDests, ;
                        cursor_4c_SubDistinct.ConDests, cursor_4c_SubDistinct.Opers, cursor_4c_SubDistinct.CMoes, ;
                        cursor_4c_SubDistinct.NFiscals, cursor_4c_SubDistinct.Series, cursor_4c_SubDistinct.Especies, ;
                        cursor_4c_SubDistinct.TipoNfs, cursor_4c_SubDistinct.MarcaSubns, cursor_4c_SubDistinct.Cfos, ;
                        cursor_4c_SubDistinct.Casas, cursor_4c_SubDistinct.GrVends, cursor_4c_SubDistinct.ChkLimOps)
            ENDSCAN
            IF USED("cursor_4c_SubDistinct")
                USE IN cursor_4c_SubDistinct
            ENDIF
            USE IN cursor_4c_SubTemp
        ENDIF

        GO TOP IN cursor_4c_Subniveis

        *-- Preenche o cabecalho da operacao de pedido (cnt_4c_Operacao)
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
            WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
                .txt_4c_Emps.Value  = THIS.this_cEmps
                .txt_4c_Job.Value   = THIS.this_cJobs
                .txt_4c_Datas.Value = DATE()

                IF !EOF("cursor_4c_Subniveis")
                    .txt_4c_Dopes.Value  = ALLTRIM(cursor_4c_Subniveis.Dopes)
                    .txt_4c_CMoes.Value  = ALLTRIM(cursor_4c_Subniveis.CMoes)
                    .txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_Subniveis.GruDests)
                    .txt_4c_ContaDs.Value = ALLTRIM(cursor_4c_Subniveis.ConDests)
                ENDIF

                .txt_4c_ContaEs.Value = ALLTRIM(loc_oBO.this_cContaEs)
                .obj_4c_GetObs.Value = "Cota" + CHR(231) + CHR(227) + "o " + ;
                    ALLTRIM(STR(loc_oBO.this_nCodigos, 6)) + ;
                    IIF(EMPTY(ALLTRIM(loc_oBO.this_cJustificas)), "", " - ") + ALLTRIM(loc_oBO.this_cJustificas)

                IF !EMPTY(.txt_4c_ContaDs.Value)
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(.txt_4c_ContaDs.Value)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DContaDsTmp") > 0 AND ;
                       USED("cursor_4c_DContaDsTmp") AND !EOF("cursor_4c_DContaDsTmp")
                        .txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_DContaDsTmp.RClis)
                    ENDIF
                    IF USED("cursor_4c_DContaDsTmp")
                        USE IN cursor_4c_DContaDsTmp
                    ENDIF
                ENDIF

                IF !EMPTY(.txt_4c_ContaEs.Value)
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(.txt_4c_ContaEs.Value)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DContaEsTmp") > 0 AND ;
                       USED("cursor_4c_DContaEsTmp") AND !EOF("cursor_4c_DContaEsTmp")
                        .txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_DContaEsTmp.RClis)
                    ENDIF
                    IF USED("cursor_4c_DContaEsTmp")
                        USE IN cursor_4c_DContaEsTmp
                    ENDIF
                ENDIF
            ENDWITH
        ENDIF

        IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
            MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
            RETURN .F.
        ENDIF

        GO TOP IN cursor_4c_CabOperas

        IF par_lChk
            RETURN .T.
        ENDIF

        THIS.this_cModoAtual = "PEDIDOS"
        THIS.AlternarPagina(4)

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "obj_4c_CmdProcessar", 5)
            THIS.pgf_4c_Paginas.Page4.obj_4c_CmdProcessar.Visible = .T.
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "pgf_4c_PgOperacoes", 5)
            THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.ActivePage = 1
            THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.Page1.grd_4c_CabOperas.Refresh()
        ENDIF

        THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao.txt_4c_Dopes.SetFocus()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConsultaPedidos - Equivalente ao PROCEDURE consultapedidos legado: le os
    * pedidos JA GERADOS (SigCtTPc/SigCtTPe/SigCtTPi) para exibir em modo
    * CONSULTAR, sem permitir nova gravacao (cmdProcessar fica invisivel).
    *--------------------------------------------------------------------------
    PROCEDURE ConsultaPedidos()
        LOCAL loc_oBO, loc_cSQL, loc_nResultado, loc_nCod

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        loc_nCod = loc_oBO.this_nCodigos

        IF !USED("cursor_4c_Pedidos")
            THIS.CriarCursoresPedidos()
        ENDIF

        ZAP IN cursor_4c_Pedidos
        ZAP IN cursor_4c_CabOperas
        ZAP IN cursor_4c_ItnOperas

        loc_cSQL = "SELECT * FROM SigCtTPc WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPc")

        IF loc_nResultado < 0
            MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPc)" + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_ConsultaPc") AND !EOF("cursor_4c_ConsultaPc")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
                WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
                    .txt_4c_Datas.Value   = ConverterParaData(NVL(cursor_4c_ConsultaPc.Datas, {}))
                    .txt_4c_Emps.Value    = ALLTRIM(NVL(cursor_4c_ConsultaPc.Emps, ""))
                    .txt_4c_Dopes.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.Dopes, ""))
                    .txt_4c_CMoes.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.CMoes, ""))
                    .txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.GrupoDs, ""))
                    .txt_4c_ContaDs.Value = ALLTRIM(NVL(cursor_4c_ConsultaPc.ContaDs, ""))
                    .txt_4c_CodObs.Value  = NVL(cursor_4c_ConsultaPc.CodObs, 0)
                    .obj_4c_GetObs.Value  = NVL(cursor_4c_ConsultaPc.Obs, "")
                    .txt_4c_ContaEs.Value = ALLTRIM(NVL(cursor_4c_ConsultaPc.ContaEs, ""))

                    IF !EMPTY(.txt_4c_ContaDs.Value)
                        IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(.txt_4c_ContaDs.Value), "cursor_4c_DsTmp") > 0 AND ;
                           USED("cursor_4c_DsTmp") AND !EOF("cursor_4c_DsTmp")
                            .txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_DsTmp.RClis)
                        ENDIF
                        IF USED("cursor_4c_DsTmp")
                            USE IN cursor_4c_DsTmp
                        ENDIF
                    ENDIF

                    IF !EMPTY(.txt_4c_ContaEs.Value)
                        IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(.txt_4c_ContaEs.Value), "cursor_4c_EsTmp") > 0 AND ;
                           USED("cursor_4c_EsTmp") AND !EOF("cursor_4c_EsTmp")
                            .txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_EsTmp.RClis)
                        ENDIF
                        IF USED("cursor_4c_EsTmp")
                            USE IN cursor_4c_EsTmp
                        ENDIF
                    ENDIF
                ENDWITH
            ENDIF

            loc_cSQL = "SELECT * FROM SigCtTPe WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPe")

            IF loc_nResultado < 0
                MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPe)" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                RETURN .F.
            ENDIF

            IF USED("cursor_4c_ConsultaPe")
                SELECT cursor_4c_ConsultaPe
                SCAN
                    INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Qtds, Valors, Fretes, VlFretes) ;
                        VALUES (cursor_4c_ConsultaPe.Numes, ALLTRIM(cursor_4c_ConsultaPe.IFors), ;
                            ALLTRIM(cursor_4c_ConsultaPe.Fornecs), ALLTRIM(cursor_4c_ConsultaPe.FPags), ;
                            ConverterParaData(NVL(cursor_4c_ConsultaPe.DtEnts, {})), cursor_4c_ConsultaPe.Qtds, ;
                            cursor_4c_ConsultaPe.Valors, ALLTRIM(NVL(cursor_4c_ConsultaPe.Fretes, "")), ;
                            NVL(cursor_4c_ConsultaPe.VlFretes, 0))
                ENDSCAN
                USE IN cursor_4c_ConsultaPe
            ENDIF

            loc_cSQL = "SELECT * FROM SigCtTPi WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0) + ;
                " ORDER BY Numes, CItens"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPi")

            IF loc_nResultado < 0
                MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPi)" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                RETURN .F.
            ENDIF

            IF USED("cursor_4c_ConsultaPi")
                SELECT cursor_4c_ConsultaPi
                SCAN
                    INSERT INTO cursor_4c_ItnOperas (CItens, Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
                        VALUES (cursor_4c_ConsultaPi.CItens, cursor_4c_ConsultaPi.Numes, ALLTRIM(cursor_4c_ConsultaPi.CPros), ;
                            ALLTRIM(cursor_4c_ConsultaPi.DPros), ALLTRIM(NVL(cursor_4c_ConsultaPi.CodCors, "")), ;
                            ALLTRIM(NVL(cursor_4c_ConsultaPi.CodTams, "")), ALLTRIM(cursor_4c_ConsultaPi.CUnis), ;
                            NVL(cursor_4c_ConsultaPi.Obs, ""), cursor_4c_ConsultaPi.Qtds, cursor_4c_ConsultaPi.Units, ;
                            cursor_4c_ConsultaPi.Valors)
                ENDSCAN
                USE IN cursor_4c_ConsultaPi
            ENDIF
        ENDIF

        IF USED("cursor_4c_ConsultaPc")
            USE IN cursor_4c_ConsultaPc
        ENDIF

        IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
            MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
            RETURN .F.
        ENDIF

        GO TOP IN cursor_4c_CabOperas

        THIS.this_cModoAtual = "PEDIDOS"
        THIS.AlternarPagina(4)

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "obj_4c_CmdProcessar", 5)
            THIS.pgf_4c_Paginas.Page4.obj_4c_CmdProcessar.Visible = .F.
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "pgf_4c_PgOperacoes", 5)
            THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.ActivePage = 1
            THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes.Page1.grd_4c_CabOperas.Refresh()
        ENDIF

        THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao.txt_4c_Dopes.SetFocus()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LiberaPagto - Equivalente ao PROCEDURE liberapagto legado. So se aplica
    * quando a operacao de lancamento tem ChkLimOps = 1 (limite de valor por
    * cargo do usuario - "Tiago 22/09/2014 CC2016"): busca o cargo do usuario
    * logado, o limite de liberacao do cargo (SigCdCrg.VlLibOpes) e compara
    * contra o valor do titulo convertido para a moeda padrao do sistema
    * (this_cMoedaPs). ThisForm.Cotacao(...) do legado (metodo que nao existe
    * em PROCEDURE nenhuma do dump - provavelmente herdado de classe fora do
    * acervo) equivale a fBuscarCotacao(...): mesma operacao (cotacao da moeda
    * na data) feita duas linhas acima para a moeda padrao.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LiberaPagto(par_nValTit, par_cMoeTit, par_dDatTit)
        LOCAL loc_cSQL, loc_cCargo, loc_nVlLib, loc_nCotP, loc_nVlL, loc_lLib

        IF !USED("cursor_4c_Subniveis") OR cursor_4c_Subniveis.ChkLimOps != 1
            RETURN .T.
        ENDIF

        loc_cSQL = "SELECT CCargs FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LibUsu") < 1 OR !USED("cursor_4c_LibUsu") OR EOF("cursor_4c_LibUsu")
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + ;
                "o (CrSigCdUsu)", "Erro SQL")
            IF USED("cursor_4c_LibUsu")
                USE IN cursor_4c_LibUsu
            ENDIF
            RETURN .F.
        ENDIF
        loc_cCargo = ALLTRIM(NVL(cursor_4c_LibUsu.CCargs, ""))
        USE IN cursor_4c_LibUsu

        loc_cSQL = "SELECT VlLibOpes FROM SigCdCrg WHERE CCargs = " + EscaparSQL(loc_cCargo)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LibCrg") < 1 OR !USED("cursor_4c_LibCrg") OR EOF("cursor_4c_LibCrg")
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + ;
                "o (CrTmpCarg)", "Erro SQL")
            IF USED("cursor_4c_LibCrg")
                USE IN cursor_4c_LibCrg
            ENDIF
            RETURN .F.
        ENDIF
        loc_nVlLib = NVL(cursor_4c_LibCrg.VlLibOpes, 0)
        USE IN cursor_4c_LibCrg

        loc_nCotP = fBuscarCotacao(THIS.this_cMoedaPs, par_dDatTit)
        loc_nVlL  = par_nValTit * IIF(par_cMoeTit == THIS.this_cMoedaPs, 1, ;
            fBuscarCotacao(par_cMoeTit, par_dDatTit) / loc_nCotP)
        loc_lLib  = (loc_nVlLib >= loc_nVlL)

        IF !loc_lLib
            MsgAviso("Usu" + CHR(225) + "rio n" + CHR(227) + "o autorizado a liberar pagamento na " + ;
                "movimenta" + CHR(231) + CHR(227) + "o: " + TRANSFORM(cursor_4c_CabOperas.Numes), loc_cCargo)
        ENDIF

        RETURN loc_lLib
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravaPedidos - Equivalente ao PROCEDURE gravapedidos legado: grava
    * fisicamente as operacoes de compra (SigMvCab/SigMvItn/SigMvIts/SigMvPar)
    * e o espelho da cotacao convertida em pedido (SigCtTPc/Pe/Pi/Ps), 1
    * conjunto de SigMvCab/Itn/Par por fornecedor marcado (cursor_4c_CabOperas).
    *
    * Adaptacoes de arquitetura (regra ja usada em GravaDados/AprovarCotacao
    * deste form): SQLEXEC direto por registro em vez de cursor bufferizado +
    * TableUpdate/Rollback. Como a conexao deste ambiente nasce com
    * Transactions=2 (manual - medido, ver functions.prg:fGerUniqueKey), o
    * "tudo ou nada" do Commit/Rollback legado equivale a SQLCOMMIT/SQLROLLBACK
    * explicitos ao final (mesmo padrao de SIGMVCMVBO.GravarLancamentos).
    *
    * Duas funcoes GLOBAIS do legado ficam FORA do dump (regra #27 - nunca
    * chutar valor de calculo/lancamento financeiro):
    *   fCalcularImpostos  - calcula impostos da Nota Fiscal (NFiscals 1/2).
    *                        Operacoes que emitem NF automaticamente por essa
    *                        tela ficam BLOQUEADAS ate a funcao ser portada -
    *                        aviso claro em vez de estourar em runtime.
    *   fSigOpFin_Lancs    - lancamentos financeiros automaticos configurados
    *                        em SigOpCdi. So dispara quando ha configuracao
    *                        para a operacao (sem config, e no-op no legado
    *                        tambem) - chamada literal, sem wrapper, para
    *                        falhar alto so nesse caso especifico.
    *--------------------------------------------------------------------------
    PROCEDURE GravaPedidos()
        LOCAL loc_oCnt, loc_oBO, loc_cEmp, loc_dDat, loc_cDop, loc_cMoe
        LOCAL loc_cGrO, loc_cGrD, loc_cCtD, loc_cCtE, loc_nObs, loc_cObs, loc_nEnt
        LOCAL loc_cOpe, loc_nENF, loc_cGrv, loc_nCotP, loc_nCotPen, loc_nTtPen, loc_nTtGer
        LOCAL loc_lManual, loc_lOk, loc_cErro, loc_cSQL, loc_nResultado
        LOCAL loc_nNum, loc_nNop, loc_cEmpDopNums, loc_cEmpGopNums, loc_nNumesGrupo
        LOCAL loc_nPar, loc_dDtV, loc_cMdf, loc_nI, loc_oErro

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
            RETURN .F.
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao

        *-- Validacoes de cabecalho (PROCEDURE gravapedidos legado)
        loc_cEmp = ALLTRIM(loc_oCnt.txt_4c_Emps.Value)
        IF EMPTY(loc_cEmp)
            MsgAviso("A Empresa de Lan" + CHR(231) + "amento N" + CHR(227) + "o Foi Informada!!!", ;
                "Dados Inv" + CHR(225) + "lidos!!!")
            loc_oCnt.txt_4c_Emps.SetFocus()
            RETURN .F.
        ENDIF

        loc_dDat = loc_oCnt.txt_4c_Datas.Value
        IF EMPTY(loc_dDat)
            MsgAviso("A Data de Lan" + CHR(231) + "amento N" + CHR(227) + "o Foi Informada!!!", ;
                "Dados Inv" + CHR(225) + "lidos!!!")
            loc_oCnt.txt_4c_Datas.SetFocus()
            RETURN .F.
        ENDIF

        loc_cDop = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)
        IF !USED("cursor_4c_Subniveis") OR EMPTY(loc_cDop) OR ;
            !SEEK(PADR(loc_cDop, 20), "cursor_4c_Subniveis", "Dopes")
            MsgAviso("A Opera" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + "amento N" + CHR(227) + ;
                "o Foi Informada!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            loc_oCnt.txt_4c_Dopes.SetFocus()
            RETURN .F.
        ENDIF

        loc_cMoe = ALLTRIM(loc_oCnt.txt_4c_CMoes.Value)
        IF EMPTY(loc_cMoe)
            MsgAviso("A Moeda de Lan" + CHR(231) + "amento N" + CHR(227) + "o Foi Informada!!!", ;
                "Dados Inv" + CHR(225) + "lidos!!!")
            loc_oCnt.txt_4c_CMoes.SetFocus()
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
            MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Para Gravar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN .F.
        ENDIF

        *-- cursor_4c_Subniveis ja esta posicionado pelo SEEK acima
        loc_cGrO = ALLTRIM(cursor_4c_Subniveis.GruOrigs)
        loc_cGrD = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
        loc_cCtD = ALLTRIM(loc_oCnt.txt_4c_ContaDs.Value)
        loc_cCtE = ALLTRIM(loc_oCnt.txt_4c_ContaEs.Value)
        loc_nObs = loc_oCnt.txt_4c_CodObs.Value
        loc_cObs = loc_oCnt.obj_4c_GetObs.Value
        loc_nEnt = loc_oBO.this_nLocalEnts
        loc_cOpe = IIF(cursor_4c_Subniveis.Opers = 1, "E", "S")
        loc_nENF = cursor_4c_Subniveis.NFiscals
        loc_cGrv = ALLTRIM(cursor_4c_Subniveis.GrVends)

        IF INLIST(loc_nENF, 1, 2)
            MsgErro("Esta opera" + CHR(231) + CHR(227) + "o emite Nota Fiscal automaticamente ao " + ;
                "gerar o pedido (c" + CHR(225) + "lculo de impostos), funcionalidade ainda n" + ;
                CHR(227) + "o portada para o sistema novo." + CHR(13) + ;
                "Selecione uma opera" + CHR(231) + CHR(227) + "o de lan" + CHR(231) + "amento que N" + ;
                CHR(227) + "o emita NF, ou gere este pedido pelo sistema legado.", ;
                "Funcionalidade N" + CHR(227) + "o Dispon" + CHR(237) + "vel")
            RETURN .F.
        ENDIF

        *-- Limite de valor por cargo (Tiago - 22/09/2014 - CC2016)
        IF cursor_4c_Subniveis.ChkLimOps = 1
            loc_nCotP = fBuscarCotacao(THIS.this_cMoedaPs, loc_dDat)
            loc_lOk   = .T.
            SELECT cursor_4c_CabOperas
            GO TOP
            DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
                loc_nCotPen = IIF(EMPTY(loc_cMoe), 1, fBuscarCotacao(loc_cMoe, loc_dDat))
                loc_nTtPen  = cursor_4c_CabOperas.Valors * loc_nCotPen
                loc_nTtGer  = IIF(loc_nCotP = 0, 0, loc_nTtPen / loc_nCotP)
                IF !THIS.LiberaPagto(loc_nTtGer, THIS.this_cMoedaPs, loc_dDat)
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk
                    SKIP IN cursor_4c_CabOperas
                ENDIF
            ENDDO
            IF !loc_lOk
                RETURN .F.
            ENDIF
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        loc_lOk     = .T.
        loc_cErro   = ""

        TRY
            *-- SigCtTPc - cabecalho da cotacao-pedido (1 registro, fora do loop
            *-- por fornecedor - Insert Into crSigCtTPc do legado)
            loc_cSQL = "INSERT INTO SigCtTPc (cidchaves, codigos, datars, datas, emps, dopes, cmoes, " + ;
                "grupods, contads, contaes, codobs, obs) VALUES (" + ;
                EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
                FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", GETDATE(), " + ;
                FormatarDataSQL(loc_dDat) + ", " + ;
                EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
                EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
                FormatarNumeroSQL(loc_nObs, 0) + ", " + EscaparSQL(loc_cObs) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPc)" + CHR(13) + CapturarErroSQL()
                loc_lOk = .F.
            ENDIF

            SELECT cursor_4c_CabOperas
            GO TOP
            DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
                loc_nNumesGrupo = cursor_4c_CabOperas.Numes

                loc_nNum = fGerUniqueKey(ALLTRIM(loc_cDop) + loc_cEmp)
                loc_nNop = fGerUniqueKey("SIGMVCCR")
                loc_cEmpDopNums = loc_cEmp + loc_cDop + STR(loc_nNum, 6)
                loc_cEmpGopNums = loc_cEmp + SPACE(20) + STR(loc_nNum, 6)

                *-- SigMvCab - cabecalho da movimentacao (1 por fornecedor)
                loc_cSQL = "INSERT INTO SigMvCab (cidchaves, emps, dopes, numes, empdopnums, mascnum, " + ;
                    "opers, datas, datars, dtalts, grupoos, contaos, grupods, contads, contaes, " + ;
                    "localents, codobs, obses, valos, valinis, usuars, prazoents, empgopnums, " + ;
                    "usupagos, grvends, resps, jobs, " + ;
                    "npedclis, acres, antecs, chksubn, codpeds, desc2s, descs, devols, empds, " + ;
                    "grresps, grupos, iclis, ifors, locals, lotechqs, lprecos, ncarnecs, " + ;
                    "nemps, nops, notas, nrcons, ntrans, numolds, tabds, tpfats, transps, " + ;
                    "usuals, usulibs, valacres, valdes2s, valdescs, valdevs, valencs, " + ;
                    "valservs, valvars, vars, vends, cotusus, espes, qtdes, lcancelas, cofs, " + ;
                    "livros, chkbxparcs, ecfs, dgopes, trfisicos, utilizados, valndevs, " + ;
                    "valobxs, noforms, auditors, localizas, chkpagos, chkpgs, codtrans, " + ;
                    "empdnbxs, empdncrds, obsagends, operadors, vcompensas, motdscs, " + ;
                    "ndeclaras, numbalds, numbals, priors, procbals, procdbal, protats, " + ;
                    "ultgrvs, moeits, rnops, impress, pstatus, valvarps, cifccfs, cupfis, " + ;
                    "idconta, ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, ptax1s, " + ;
                    "ptax2s, ptax3s, obscabmovs, codobs2) VALUES (" + ;
                    EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
                    EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                    EscaparSQL(loc_cEmpDopNums) + ", " + EscaparSQL(ALLTRIM(fGerMascara(loc_nNum))) + ", " + ;
                    EscaparSQL(loc_cOpe) + ", " + FormatarDataSQL(loc_dDat) + ", GETDATE(), GETDATE(), " + ;
                    EscaparSQL(loc_cGrO) + ", " + EscaparSQL(cursor_4c_CabOperas.IFors) + ", " + ;
                    EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
                    FormatarNumeroSQL(loc_nEnt, 0) + ", " + FormatarNumeroSQL(loc_nObs, 0) + ", " + ;
                    EscaparSQL(loc_cObs) + ", " + FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + ;
                    FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                    FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + EscaparSQL(loc_cEmpGopNums) + ", " + ;
                    EscaparSQL(LEFT(loc_oBO.this_cAprovador, 10)) + ", " + EscaparSQL(loc_cGrv) + ", " + ;
                    EscaparSQL(LEFT(loc_oBO.this_cComprador, 12)) + ", " + ;
                    EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Jobs, ""), 10)) + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 4) + ", " + ;
                    EscaparSQL("") + ", " + 0 + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 4) + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + 0 + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    FormatarNumeroSQL(0, 4) + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + 0 + ", " + 0 + ", " + 0 + ", " + ;
                    0 + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    0 + ", " + 0 + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    0 + ", " + 0 + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvCab)" + CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                ENDIF

                *-- SigCtTPs - liga o Codigos da cotacao ao EmpDopNums gerado
                IF loc_lOk
                    loc_cSQL = "INSERT INTO SigCtTPs (cidchaves, codigos, empdopnums) VALUES (" + ;
                        EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
                        EscaparSQL(loc_cEmpDopNums) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPs)" + CHR(13) + CapturarErroSQL()
                        loc_lOk = .F.
                    ENDIF
                ENDIF

                *-- SigCtTPe - fornecedor/condicao/entrega do pedido (1 por fornecedor)
                IF loc_lOk
                    loc_cSQL = "INSERT INTO SigCtTPe (cidchaves, codigos, numes, ifors, fornecs, fpags, " + ;
                        "dtents, qtds, valors, fretes, vlfretes) VALUES (" + ;
                        EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
                        FormatarNumeroSQL(loc_nNumesGrupo, 0) + ", " + ;
                        EscaparSQL(LEFT(cursor_4c_CabOperas.IFors, 10)) + ", " + ;
                        EscaparSQL(LEFT(cursor_4c_CabOperas.Fornecs, 50)) + ", " + ;
                        EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
                        FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + ;
                        FormatarNumeroSQL(cursor_4c_CabOperas.Qtds, 2) + ", " + ;
                        FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 6) + ", " + ;
                        EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Fretes, ""), 12)) + ", " + ;
                        FormatarNumeroSQL(cursor_4c_CabOperas.VlFretes, 2) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPe)" + CHR(13) + CapturarErroSQL()
                        loc_lOk = .F.
                    ENDIF
                ENDIF

                *-- Itens do fornecedor corrente (cursor_4c_ItnOperas.Numes = loc_nNumesGrupo)
                IF loc_lOk
                    SELECT cursor_4c_ItnOperas
                    GO TOP
                    LOCATE FOR cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
                    DO WHILE loc_lOk AND !EOF("cursor_4c_ItnOperas") AND cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
                        loc_cSQL = "INSERT INTO SigMvItn (cidchaves, emps, dopes, numes, empdopnums, dtalts, " + ;
                            "citens, cpros, dpros, obs, opers, moedas, moefats, moevals, qtds, aqtds, units, " + ;
                            "totas, cunis, " + ;
                            "codbarras, descvals, etiesps, fators, fatvals, fvals, iconfs, " + ;
                            "locals, notas, nrcons, ntrans, numolds, pesos, qtbaixas, " + ;
                            "qtbxprods, qtprods, tpesos, unitembs, univals, vcoms, aliqs, " + ;
                            "sitribs, tpipis, valipis, aliqicms, valdescs, empos, moevs, " + ;
                            "utilizas, ncodigos, qtreservas, nlotes, baseicms, chksubn, " + ;
                            "unit2s, usulibs, valrats, codlprecs, cunips, motdscs, tipos, " + ;
                            "unitinfs, cpro2s, abrevis, bcicmss, bcipis, icms, icmss, pdescs, " + ;
                            "nchvtbds, idpro, unitorigs, origmercs, baseicm2s, baseicm3s, " + ;
                            "baseipi2s, baseipi3s, cfops, ratdacs, ratfrts, raticmds, raticms, " + ;
                            "ratsegs, sittricms, aliqiis, citem2, taxaiis, vcofins, vpis, " + ;
                            "aliqorigs, lcancelas, compris, codfabs, nadis, niadis, aliqcofs, " + ;
                            "aliqpis, cssl, inss, irrf, iss, valbases, localos) VALUES (" + ;
                            EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
                            EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                            EscaparSQL(loc_cEmpDopNums) + ", GETDATE(), " + ;
                            FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 65)) + ", " + ;
                            EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
                            EscaparSQL(loc_cOpe) + ", " + EscaparSQL(loc_cMoe) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
                            FormatarNumeroSQL(1, 0) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 2) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            0 + ", " + FormatarNumeroSQL(0, 3) + ", " + ;
                            FormatarNumeroSQL(0, 6) + ", " + 0 + ", " + 0 + ", " + ;
                            EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 3) + ", " + ;
                            FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", " + ;
                            FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 4) + ", " + FormatarNumeroSQL(0, 6) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 3) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            0 + ", " + FormatarNumeroSQL(0, 6) + ", " + ;
                            EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                            FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                            FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + 0 + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvItn)" + CHR(13) + CapturarErroSQL()
                            loc_lOk = .F.
                        ENDIF

                        IF loc_lOk
                            loc_cSQL = "INSERT INTO SigCtTPi (cidchaves, codigos, citens, numes, cpros, " + ;
                                "dpros, codcors, codtams, cunis, obs, qtds, units, valors) VALUES (" + ;
                                EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.Numes, 0) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 50)) + ", " + ;
                                EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
                                EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ", " + ;
                                EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 2) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 6) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPi)" + CHR(13) + CapturarErroSQL()
                                loc_lOk = .F.
                            ENDIF
                        ENDIF

                        *-- SigMvIts - detalhe de cor/tamanho, so quando informado
                        IF loc_lOk AND (!EMPTY(cursor_4c_ItnOperas.CodCors) OR !EMPTY(cursor_4c_ItnOperas.CodTams))
                            loc_cSQL = "INSERT INTO SigMvIts (cidchaves, emps, dopes, numes, citens, cpros, " + ;
                                "codcors, codtams, qtds, aqtds, empdopnums, chksubn, " + ;
                                "codembs, qtdembs, aqtdembs, qtbaixas, prembs, codembents, " + ;
                                "qtdents, codbarras, pesos, qtbxprods, qtprods, locals, " + ;
                                "ntrans, qtreservas, compris) VALUES (" + ;
                                EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
                                EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
                                EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
                                EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
                                EscaparSQL(loc_cEmpDopNums) + ", 0, " + ;
                                EscaparSQL("") + ", " + FormatarNumeroSQL(0, 1) + ", " + ;
                                FormatarNumeroSQL(0, 1) + ", " + ;
                                FormatarNumeroSQL(0, 3) + ", " + ;
                                FormatarNumeroSQL(0, 3) + ", " + EscaparSQL("") + ", " + ;
                                FormatarNumeroSQL(0, 3) + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + ;
                                FormatarNumeroSQL(0, 3) + ", " + ;
                                FormatarNumeroSQL(0, 3) + ", " + ;
                                FormatarNumeroSQL(0, 3) + ", " + EscaparSQL("") + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + ;
                                FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvIts)" + CHR(13) + CapturarErroSQL()
                                loc_lOk = .F.
                            ENDIF
                        ENDIF

                        IF loc_lOk
                            SKIP IN cursor_4c_ItnOperas
                        ENDIF
                    ENDDO
                ENDIF

                *-- SigMvPar - parcelas financeiras conforme a condicao de pagamento
                IF loc_lOk
                    loc_cSQL = "SELECT FParcs, MoeFpgs, TVens, Dias FROM SigOpFp WHERE FPags = " + ;
                        EscaparSQL(ALLTRIM(cursor_4c_CabOperas.FPags))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFPag")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_LocalFPag") AND !EOF("cursor_4c_LocalFPag")
                        loc_nPar = IIF(NVL(cursor_4c_LocalFPag.FParcs, 0) < 1, 1, cursor_4c_LocalFPag.FParcs)
                        loc_dDtV = loc_dDat
                        loc_cMdf = IIF(EMPTY(NVL(cursor_4c_LocalFPag.MoeFpgs, "")), loc_cMoe, ;
                            ALLTRIM(cursor_4c_LocalFPag.MoeFpgs))

                        FOR loc_nI = 1 TO loc_nPar
                            loc_cSQL = "INSERT INTO SigMvPar (cidchaves, emps, dopes, numes, empdopnums, " + ;
                                "datas, cotfpgs, fpags, moefpgs, nopers, valos, vencs, parcs, pagos, dtalts, " + ;
                                "agencias, bancos, cartaos, contas, dcarts, ec_numes, grclis, " + ;
                                "iclis, impcars, inschs, locals, ncarnes, ncarts, ncopias, " + ;
                                "nocreditos, nrecs, ntrans, numchqs, numeros, numolds, outros, " + ;
                                "vpags, cotusus, cnidtefs, cnnsuparcs, numlotechs, nidcheps, " + ;
                                "empos, valocurs, trocos, cpfs, digagencs, digchqs, digcontas, " + ;
                                "pracas, tparcs, valdescs, codbcrts, lcancelas, vcofins, " + ;
                                "vcsll, virf, vlrtrbfs, vpis, adquirente, autoriza, nsu) VALUES (" + ;
                                EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
                                EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                EscaparSQL(loc_cEmpDopNums) + ", " + FormatarDataSQL(loc_dDat) + ", " + ;
                                FormatarNumeroSQL(1, 4) + ", " + EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
                                EscaparSQL(LEFT(loc_cMdf, 3)) + ", " + FormatarNumeroSQL(loc_nNop, 0) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_CabOperas.Valors / loc_nPar, 2) + ", " + ;
                                FormatarDataSQL(loc_dDtV) + ", " + FormatarNumeroSQL(loc_nI, 0) + ", " + ;
                                EscaparSQL("1") + ", GETDATE(), " + ;
                                EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                                EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + 0 + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                                EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                                EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                                FormatarNumeroSQL(0, 2) + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                                FormatarNumeroSQL(0, 0) + ", " + ;
                                FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", " + ;
                                0 + ", " + FormatarNumeroSQL(0, 2) + ", " + ;
                                FormatarNumeroSQL(0, 2) + ", " + ;
                                FormatarNumeroSQL(0, 2) + ", " + ;
                                FormatarNumeroSQL(0, 2) + ", " + ;
                                FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", " + ;
                                EscaparSQL("") + ", " + EscaparSQL("") + ")"

                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvPar)" + CHR(13) + CapturarErroSQL()
                                loc_lOk = .F.
                            ENDIF

                            IF UPPER(ALLTRIM(NVL(cursor_4c_LocalFPag.TVens, ""))) == "F"
                                loc_dDtV = GOMONTH(loc_dDat, loc_nI)
                            ELSE
                                loc_dDtV = loc_dDtV + NVL(cursor_4c_LocalFPag.Dias, 0)
                            ENDIF
                        ENDFOR
                    ENDIF

                    IF USED("cursor_4c_LocalFPag")
                        USE IN cursor_4c_LocalFPag
                    ENDIF
                ENDIF

                IF loc_lOk
                    SELECT cursor_4c_CabOperas
                    SKIP IN cursor_4c_CabOperas
                ENDIF
            ENDDO

            *-- Marca a cotacao como Pedido Gerado
            IF loc_lOk
                loc_cSQL = "UPDATE SigCtTDc SET Situas = 1 WHERE Codigos = " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - Update SigCtTDc)" + CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- "Lanca movimentacoes financeiras conforme configurado" (Tiago,
            *-- 23/09/2014). fSigOpFin_Lancs eh funcao GLOBAL fora do dump -
            *-- so dispara quando ha config em SigOpCdi para esta operacao;
            *-- sem config, e no-op no legado tambem.
            IF loc_lOk
                loc_cSQL = "SELECT TOP 1 Dopes FROM SigOpCdi WHERE Dopes = " + EscaparSQL(PADR(loc_cDop, 20))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdi") > 0 AND USED("cursor_4c_OpCdi") AND !EOF("cursor_4c_OpCdi")
                    fSigOpFin_Lancs(gnConnHandle, loc_cDop)
                ENDIF
                IF USED("cursor_4c_OpCdi")
                    USE IN cursor_4c_OpCdi
                ENDIF
            ENDIF

            IF loc_lOk
                loc_lOk = fRecalculaS(.T., gnConnHandle)
                IF !loc_lOk
                    loc_cErro = "Favor Reinicializar o Processo!!!"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cErro = loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lOk = .F.
        ENDTRY

        IF loc_lOk
            IF loc_lManual
                = SQLCOMMIT(gnConnHandle)
            ENDIF
            loc_oBO.this_nSituas = 1
            MsgInfo("Pedidos Gerados Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o Conclu" + CHR(237) + "da")
        ELSE
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            MsgErro("Os Pedidos N" + CHR(227) + "o Puderam Ser Gerados!!!" + ;
                IIF(EMPTY(loc_cErro), "", CHR(13) + loc_cErro), "Gera" + CHR(231) + CHR(227) + "o Conclu" + CHR(237) + "da")
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarPedidosClick - obj_4c_CmdProcessar.Buttons(1).Click da pagina
    * Pedidos (cmdProcessar.btnProcessar do legado): grava fisicamente os
    * pedidos gerados a partir da cotacao aprovada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarPedidosClick()
        THIS.GravaPedidos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGeraPedidosCliqueClick - cmdGravar.btnGeraPedidos.Click: em modo de
    * edicao grava e gera os pedidos; em modo CONSULTAR so exibe os ja gerados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnGeraPedidosCliqueClick()
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            IF !THIS.GravaDados()
                RETURN
            ENDIF
            THIS.GeraPedidos(.F.)
        ELSE
            THIS.ConsultaPedidos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Equivalente ao PROCEDURE impressao legado: monta os dados de
    * cabecalho da cotacao (nomes de Comprador/Aprovador/AprSols resolvidos via
    * SigCdUsu). O REPORT FORM (crCabecalho/crDetalhe -> FRX) NAO foi portado
    * nesta fase - nao ha FRX equivalente no acervo migrado ainda - por isso o
    * fechamento eh um aviso, e nao uma tela de impressao muda ou quebrada.
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_oBO, loc_cPrioridade, loc_cTipo, loc_cNomeComprador, loc_cNomeAprSols, loc_cNomeAprovador

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_cPrioridade = IIF(loc_oBO.this_nPrioris = 3, "Alta", IIF(loc_oBO.this_nPrioris = 2, "M" + CHR(233) + "dia", "Normal"))
        loc_cTipo       = IIF(loc_oBO.this_nSituas > 0, "Pedido Gerado", "em Cota" + CHR(231) + CHR(227) + "o")

        loc_cNomeComprador = ""
        IF !EMPTY(loc_oBO.this_cComprador)
            IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
                EscaparSQL(loc_oBO.this_cComprador), "cursor_4c_NomeCompr") > 0 AND ;
               USED("cursor_4c_NomeCompr") AND !EOF("cursor_4c_NomeCompr")
                loc_cNomeComprador = ALLTRIM(cursor_4c_NomeCompr.NComps)
            ENDIF
            IF USED("cursor_4c_NomeCompr")
                USE IN cursor_4c_NomeCompr
            ENDIF
        ENDIF

        loc_cNomeAprSols = ""
        IF !EMPTY(loc_oBO.this_cAprSols)
            IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
                EscaparSQL(loc_oBO.this_cAprSols), "cursor_4c_NomeAprSol") > 0 AND ;
               USED("cursor_4c_NomeAprSol") AND !EOF("cursor_4c_NomeAprSol")
                loc_cNomeAprSols = ALLTRIM(cursor_4c_NomeAprSol.NComps)
            ENDIF
            IF USED("cursor_4c_NomeAprSol")
                USE IN cursor_4c_NomeAprSol
            ENDIF
        ENDIF

        loc_cNomeAprovador = ""
        IF !EMPTY(loc_oBO.this_cAprovador)
            IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
                EscaparSQL(loc_oBO.this_cAprovador), "cursor_4c_NomeAprov") > 0 AND ;
               USED("cursor_4c_NomeAprov") AND !EOF("cursor_4c_NomeAprov")
                loc_cNomeAprovador = ALLTRIM(cursor_4c_NomeAprov.NComps)
            ENDIF
            IF USED("cursor_4c_NomeAprov")
                USE IN cursor_4c_NomeAprov
            ENDIF
        ENDIF

        MsgAviso("Impress" + CHR(227) + "o da Cota" + CHR(231) + CHR(227) + "o " + ;
            ALLTRIM(STR(loc_oBO.this_nCodigos, 6)) + " (" + loc_cTipo + ", Prioridade " + loc_cPrioridade + ")" + ;
            CHR(13) + "Comprador: " + loc_cNomeComprador + CHR(13) + ;
            "Aprovador Solicitante: " + loc_cNomeAprSols + CHR(13) + ;
            "Aprovador Final: " + loc_cNomeAprovador + CHR(13) + CHR(13) + ;
            "O relat" + CHR(243) + "rio impresso (FRX) desta cota" + CHR(231) + CHR(227) + "o ainda " + ;
            CHR(227) + "o foi portado para o sistema novo.", "Impress" + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnImprimirCotacaoClick()
        THIS.Impressao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Monta a Page4 (pgPedidos do legado), que eh a
    * pagina de CAMPOS DE DADOS deste form OPERACIONAL: a unica que tem campos
    * editaveis de cabecalho (o container cntOperacao), preenchidos a partir da
    * cotacao aprovada para gerar as operacoes de pedido de compra.
    *
    * NOME: segue a convencao do pipeline (ConfigurarPaginaDados = metodo dos
    * campos de dados). NAO confundir com a Page2, cujo Caption legado tambem
    * eh "Dados" mas que eh a pagina de LISTA (duas grades) e esta em
    * ConfigurarPaginaLista.
    *
    * Top/Left EXATOS do SCX. O PageFrame deste form tem Top = -1 e abas
    * VISIVEIS - NAO existe aqui a compensacao +29 do padrao CRUD.
    *
    * Os filhos de cnt_4c_Operacao tem Left/Top RELATIVOS ao container
    * (564 x 172) e TODOS cabem dentro dele - conferido campo a campo, porque
    * filho fora da area do pai eh recortado sem erro e sem log (regra #30).
    * Os labels tambem foram conferidos contra o Left do campo vizinho da mesma
    * linha, para nao invadirem a caixa de texto (regras #23/#28).
    *
    * Ordem de criacao = ordem do SCX. O PageFrame interno pgOperacoes (grades
    * grdCabOperas/grdItnOperas) e os lookups dos campos (PROCEDURE Valid do
    * legado) pertencem a Fase 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oCnt

        loc_oPag = THIS.pgf_4c_Paginas.Page4

        *-- Voltar para a pagina de Cotacoes (cmdBotoes.btnSair). O Caption e o
        *-- ToolTipText dizem "Pagina de Dados", mas o Click legado vai para a
        *-- pagina de COTACOES (ActivePage = 3) - texto e comportamento
        *-- transcritos como estao no legado, sem "corrigir" nenhum dos dois.
        loc_oPag.AddObject("obj_4c_CmdBotoes", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdBotoes
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Top         = 7
            .Left        = 910
            .Width       = 80
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Cancel          = .T.
                .Caption         = "P" + CHR(225) + "gina de Dados"
                .MousePointer    = 15
                .ToolTipText     = "Voltar Para a P" + CHR(225) + "gina de Dados"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPag.obj_4c_CmdBotoes.Buttons(1), "Click", THIS, "BtnRetornarCotacoesClick")

        *-- Processar Pedidos (cmdProcessar.btnProcessar) - grava fisicamente
        *-- os pedidos (GravaPedidos do legado, ver BtnProcessarPedidosClick).
        loc_oPag.AddObject("obj_4c_CmdProcessar", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdProcessar
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Top         = 7
            .Left        = 748
            .Width       = 80
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                .Caption         = "Processar Pedidos"
                .MousePointer    = 15
                .ToolTipText     = "Gerar Opera" + CHR(231) + CHR(245) + "es dos Pedidos"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPag.obj_4c_CmdProcessar.Buttons(1), "Click", THIS, "BtnProcessarPedidosClick")

        *-- Alterar Pedidos (cmdOperacao.btnOperacao). O SCX legado NAO tem
        *-- codigo nenhum para este botao (nem Click, nem Valid) - ele eh
        *-- migrado apenas visualmente, sem BINDEVENT, para manter a tela
        *-- identica a do legado (PILAR 1).
        loc_oPag.AddObject("obj_4c_CmdOperacao", "CommandGroup")
        WITH loc_oPag.obj_4c_CmdOperacao
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Top         = 7
            .Left        = 829
            .Width       = 80
            .Height      = 100
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 0
                .Left            = 0
                .Height          = 100
                .Width           = 80
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .Caption         = "Alterar Pedidos"
                .MousePointer    = 15
                .ToolTipText     = "Alterar a Opera" + CHR(231) + CHR(227) + "o Gerada"
                .SpecialEffect   = 0
                .PicturePosition = 7
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * cntOperacao - cabecalho da operacao de pedido que sera gerada.
        * Container TRANSPARENTE (BackStyle = 0) sobre a Picture da Page.
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cnt_4c_Operacao", "Container")
        WITH loc_oPag.cnt_4c_Operacao
            .Top           = 4
            .Left          = 3
            .Width         = 564
            .Height        = 172
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt = loc_oPag.cnt_4c_Operacao

        *-- Labels da classe "say" do Framework: o SCX declara so Caption /
        *-- Left / Top / ForeColor. AutoSize eh no-op em Label criado por
        *-- AddObject (regra #23), entao a Width vai explicita, com
        *-- Alignment = 0 e largura que cabe o texto SEM alcancar o Left do
        *-- campo vizinho. BackStyle = 0 em todos, como nos seis irmaos que o
        *-- SCX declara - label opaco sobre a Picture da Page apareceria como
        *-- uma caixa cinza no meio do container transparente.

        *-- "Destino :" (Say8) - grupo/conta contabil de destino
        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Destino :"
            .Left      = 12
            .Top       = 53
            .Width     = 55
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- "Entrega :" (Say2) - conta de entrega do pedido
        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Entrega :"
            .Left      = 10
            .Top       = 75
            .Width     = 55
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- "Empresa :" (Say3)
        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Empresa :"
            .Left      = 4
            .Top       = 9
            .Width     = 60
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- "Data :" (Say4)
        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Data :"
            .Left      = 106
            .Top       = 9
            .Width     = 38
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- "Operacao :" (Say5)
        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Left      = 216
            .Top       = 9
            .Width     = 65
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- "Moeda :" (Say6)
        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Moeda :"
            .Left      = 431
            .Top       = 9
            .Width     = 50
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Grupo contabil de destino (getGrupoDs -> SigCdGcr.Codigos)
        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .FontName          = "Arial"
            .FontSize          = 8
            .FontBold          = .T.
            .Format            = "K"
            .Height            = 20
            .Left              = 73
            .Top               = 51
            .Width             = 73
            .Margin            = 2
            .MaxLength         = 10
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Conta contabil de destino (getContaDs -> SigCdCli.IClis)
        loc_oCnt.AddObject("txt_4c_ContaDs", "TextBox")
        WITH loc_oCnt.txt_4c_ContaDs
            .FontName          = "Arial"
            .FontSize          = 8
            .Format            = "K"
            .Height            = 20
            .Left              = 149
            .Top               = 51
            .Width             = 73
            .Margin            = 2
            .MaxLength         = 10
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Nome da conta de destino (getDContaDs -> SigCdCli.RClis)
        loc_oCnt.AddObject("txt_4c_DContaDs", "TextBox")
        WITH loc_oCnt.txt_4c_DContaDs
            .FontName          = "Arial"
            .FontSize          = 8
            .Format            = "K"
            .Height            = 20
            .Left              = 225
            .Top               = 51
            .Width             = 287
            .Margin            = 2
            .MaxLength         = 50
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Conta de entrega (getContaEs -> SigCdCli.IClis). O SCX NAO declara
        *-- Format neste campo nem no getDContaEs - nao inventar "K" aqui.
        loc_oCnt.AddObject("txt_4c_ContaEs", "TextBox")
        WITH loc_oCnt.txt_4c_ContaEs
            .FontName          = "Arial"
            .FontSize          = 8
            .Height            = 20
            .Left              = 73
            .Top               = 73
            .Width             = 73
            .Margin            = 2
            .MaxLength         = 10
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Nome da conta de entrega (getDContaEs -> SigCdCli.RClis)
        loc_oCnt.AddObject("txt_4c_DContaEs", "TextBox")
        WITH loc_oCnt.txt_4c_DContaEs
            .FontName          = "Arial"
            .FontSize          = 8
            .Height            = 20
            .Left              = 149
            .Top               = 73
            .Width             = 362
            .Margin            = 2
            .MaxLength         = 50
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Local de entrega (cmdEntrega). O legado dispara o form SigCdEnd no
        *-- PROCEDURE Valid deste CommandGroup (nao no Click) - a chamada
        *-- pertence a Fase 6, junto com os demais lookups da pagina.
        loc_oCnt.AddObject("obj_4c_CmdEntrega", "CommandGroup")
        WITH loc_oCnt.obj_4c_CmdEntrega
            .ButtonCount = 1
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 57
            .Left        = 520
            .Width       = 40
            .Height      = 40
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top           = 0
                .Left          = 0
                .Height        = 40
                .Width         = 40
                .Picture       = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Local de Entrega"
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Empresa de lancamento (getEmps -> SigCdEmp.Cemps, char(3))
        loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oCnt.txt_4c_Emps
            .FontName          = "Arial"
            .FontSize          = 8
            .Format            = "K"
            .Height            = 20
            .Left              = 73
            .Top               = 7
            .Width             = 27
            .Margin            = 2
            .MaxLength         = 3
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- "Obs. :" (Say_Obs)
        loc_oCnt.AddObject("lbl_4c__Obs", "Label")
        WITH loc_oCnt.lbl_4c__Obs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Obs. :"
            .Left      = 33
            .Top       = 95
            .Width     = 36
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Observacao da operacao (getObs - EditBox)
        loc_oCnt.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oCnt.obj_4c_GetObs
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 72
            .Left          = 104
            .Top           = 95
            .Width         = 407
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Data de lancamento (getDatas)
        loc_oCnt.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oCnt.txt_4c_Datas
            .FontName          = "Arial"
            .FontSize          = 8
            .Format            = "KE"
            .InputMask         = "99/99/9999"
            .Height            = 20
            .Left              = 149
            .Top               = 7
            .Width             = 62
            .Margin            = 2
            .MaxLength         = 10
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = {}
            .Visible           = .T.
        ENDWITH

        *-- Operacao de lancamento (getDopes -> SigCdOpe.Dopes, char(20))
        loc_oCnt.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oCnt.txt_4c_Dopes
            .FontName          = "Arial"
            .FontSize          = 8
            .Format            = "K"
            .Height            = 20
            .Left              = 289
            .Top               = 7
            .Width             = 135
            .Margin            = 2
            .MaxLength         = 20
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Moeda de lancamento (getCMoes -> SigCdMoe.CMoes, char(3))
        loc_oCnt.AddObject("txt_4c_CMoes", "TextBox")
        WITH loc_oCnt.txt_4c_CMoes
            .FontName          = "Arial"
            .FontSize          = 8
            .Format            = "K"
            .Height            = 20
            .Left              = 485
            .Top               = 7
            .Width             = 27
            .Margin            = 2
            .MaxLength         = 3
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Codigo da observacao padrao (getCodObs). Campo NUMERICO no legado
        *-- (Value = 0 no SCX) - o Value nasce numerico aqui tambem, senao a
        *-- leitura feita por GravaPedidos compara tipos diferentes.
        loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
        WITH loc_oCnt.txt_4c_CodObs
            .FontName          = "Arial"
            .FontSize          = 8
            .Alignment         = 3
            .Format            = "K"
            .Height            = 20
            .Left              = 73
            .Top               = 95
            .Width             = 27
            .Margin            = 2
            .MaxLength         = 3
            .SpecialEffect     = 1
            .BorderColor       = RGB(0, 0, 128)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Value             = 0
            .Visible           = .T.
        ENDWITH

        *-- "Job :" (Say25 - unico label do container com FontName proprio)
        loc_oCnt.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oCnt.lbl_4c_Label25
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Job :"
            .Left      = 39
            .Top       = 31
            .Width     = 32
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Job (getJob/getDjob -> SigCdCli.IClis/RClis). O PROCEDURE When do
        *-- legado retorna .F. nos dois: sao campos de EXIBICAO, preenchidos
        *-- por codigo a partir da cotacao. ReadOnly (e nao Enabled = .F.)
        *-- porque o When bloqueia a edicao SEM acinzentar o controle.
        loc_oCnt.AddObject("txt_4c_Job", "TextBox")
        WITH loc_oCnt.txt_4c_Job
            .FontName      = "Arial"
            .FontSize      = 8
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 20
            .Left          = 73
            .Top           = 29
            .Width         = 73
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(0, 0, 128)
            .Themes        = .F.
            .ReadOnly      = .T.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Djob", "TextBox")
        WITH loc_oCnt.txt_4c_Djob
            .FontName      = "Arial"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 20
            .Left          = 149
            .Top           = 29
            .Width         = 304
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(0, 0, 128)
            .Themes        = .F.
            .ReadOnly      = .T.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- O When do legado eh reavaliado a cada troca de foco; o equivalente
        *-- aqui eh reaplicar AjustarCamposPedidos ao sair dos campos de que os
        *-- outros dependem (Grupo -> Conta de destino; Conta -> Nome da conta).
        BINDEVENT(loc_oCnt.txt_4c_Grupo,   "LostFocus", THIS, "AjustarCamposPedidos")
        BINDEVENT(loc_oCnt.txt_4c_ContaDs, "LostFocus", THIS, "AjustarCamposPedidos")
        BINDEVENT(loc_oCnt.txt_4c_ContaEs, "LostFocus", THIS, "AjustarCamposPedidos")

        *====================================================================
        * FASE 6 - Item G: lookups de cnt_4c_Operacao + PageFrame interno
        * pgf_4c_PgOperacoes (grdCabOperas/grdItnOperas)
        *====================================================================
        THIS.ConfigurarLookupsOperacaoPedido(loc_oCnt)
        THIS.ConfigurarPgOperacoes(loc_oPag)

        THIS.AjustarCamposPedidos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLookupsOperacaoPedido - Item G da Fase 6: liga os lookups dos
    * campos de cnt_4c_Operacao ja criados na Fase 5 (KeyPress F4/Enter/Tab,
    * regra do lookup do CLAUDE.md). getDjob/getJob ja nascem ReadOnly (When
    * sempre .F. no legado) e nao precisam de lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLookupsOperacaoPedido(par_oContainer)
        BINDEVENT(par_oContainer.txt_4c_Grupo,   "KeyPress", THIS, "TeclaGrupoDestino")
        BINDEVENT(par_oContainer.txt_4c_ContaDs, "KeyPress", THIS, "TeclaContaDestino")
        BINDEVENT(par_oContainer.txt_4c_DContaDs, "KeyPress", THIS, "TeclaDContaDestino")
        BINDEVENT(par_oContainer.txt_4c_ContaEs, "KeyPress", THIS, "TeclaContaEntregaPedido")
        BINDEVENT(par_oContainer.txt_4c_DContaEs, "KeyPress", THIS, "TeclaDContaEntregaPedido")
        BINDEVENT(par_oContainer.txt_4c_Emps,    "KeyPress", THIS, "TeclaEmpresaPedido")
        BINDEVENT(par_oContainer.txt_4c_Dopes,   "KeyPress", THIS, "TeclaOperacaoLancamento")
        BINDEVENT(par_oContainer.txt_4c_CMoes,   "KeyPress", THIS, "TeclaMoedaPedido")
        BINDEVENT(par_oContainer.obj_4c_CmdEntrega.Buttons(1), "Click", THIS, "BtnEntregaPedidoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * Grupo contabil de destino (getGrupoDs -> SigCdGcr.Codigos/Descrs).
    * fAcessoContab do legado substituido pelo padrao canonico.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupoDestino(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoDestino()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoDestino()
        ENDIF
    ENDPROC

    PROCEDURE ValidarGrupoDestino()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)

        IF EMPTY(loc_cValor)
            THIS.AjustarCamposPedidos()
            RETURN
        ENDIF

        loc_cSQL = "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_GrupoVal") AND !EOF("cursor_4c_GrupoVal")
            loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrupoVal.Codigos)
        ELSE
            THIS.AbrirBuscaGrupoDestino()
        ENDIF

        IF USED("cursor_4c_GrupoVal")
            USE IN cursor_4c_GrupoVal
        ENDIF

        THIS.AjustarCamposPedidos()
    ENDPROC

    PROCEDURE AbrirBuscaGrupoDestino()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValor, "Grupo de Contas", .T.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                    loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                ENDIF
            ELSE
                loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Conta contabil de destino (getContaDs -> SigCdCli.IClis, filtrada pelo
    * Grupo) / Nome da conta (getDContaDs -> SigCdCli.RClis).
    *--------------------------------------------------------------------------
    PROCEDURE TeclaContaDestino(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaDestino("IClis")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaDestino("IClis")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDContaDestino(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaDestino("RClis")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaDestino("RClis")
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaDestino(par_cCampo)
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado

        loc_oCnt = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao

        IF par_cCampo = "IClis"
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_ContaDs.Value)
        ELSE
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DContaDs.Value)
        ENDIF

        IF EMPTY(loc_cValor)
            loc_oCnt.txt_4c_ContaDs.Value  = ""
            loc_oCnt.txt_4c_DContaDs.Value = ""
            THIS.AjustarCamposPedidos()
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
            loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDsVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_ContaDsVal") AND !EOF("cursor_4c_ContaDsVal")
            loc_oCnt.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_ContaDsVal.IClis)
            loc_oCnt.txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_ContaDsVal.RClis)
        ELSE
            THIS.AbrirBuscaContaDestino(par_cCampo)
        ENDIF

        IF USED("cursor_4c_ContaDsVal")
            USE IN cursor_4c_ContaDsVal
        ENDIF

        THIS.AjustarCamposPedidos()
    ENDPROC

    PROCEDURE AbrirBuscaContaDestino(par_cCampo)
        LOCAL loc_oCnt, loc_cValor, loc_oBusca, loc_cFiltro

        loc_oCnt = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao

        IF par_cCampo = "IClis"
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_ContaDs.Value)
        ELSE
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DContaDs.Value)
        ENDIF

        loc_cFiltro = ""
        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
            loc_cFiltro = "Grupos = " + EscaparSQL(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaContaDs", par_cCampo, loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", .F., .T., loc_cFiltro)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oCnt.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
                loc_oCnt.txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
            ELSE
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaDs")
                    loc_oCnt.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
                    loc_oCnt.txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaContaDs")
            USE IN cursor_4c_BuscaContaDs
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Conta de entrega (getContaEs/getDContaEs -> SigCdCli.IClis/RClis, SEM
    * filtro de grupo - fAcessoContas(Usuar, [], ...) do legado).
    *--------------------------------------------------------------------------
    PROCEDURE TeclaContaEntregaPedido(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaEntregaPedido("IClis")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaEntregaPedido("IClis")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDContaEntregaPedido(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaEntregaPedido("RClis")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaEntregaPedido("RClis")
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaEntregaPedido(par_cCampo)
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado

        loc_oCnt = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao

        IF par_cCampo = "IClis"
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_ContaEs.Value)
        ELSE
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DContaEs.Value)
        ENDIF

        IF EMPTY(loc_cValor)
            loc_oCnt.txt_4c_ContaEs.Value  = ""
            loc_oCnt.txt_4c_DContaEs.Value = ""
            THIS.AjustarCamposPedidos()
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaEsPedVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_ContaEsPedVal") AND !EOF("cursor_4c_ContaEsPedVal")
            loc_oCnt.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_ContaEsPedVal.IClis)
            loc_oCnt.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_ContaEsPedVal.RClis)
        ELSE
            THIS.AbrirBuscaContaEntregaPedido(par_cCampo)
        ENDIF

        IF USED("cursor_4c_ContaEsPedVal")
            USE IN cursor_4c_ContaEsPedVal
        ENDIF

        THIS.AjustarCamposPedidos()
    ENDPROC

    PROCEDURE AbrirBuscaContaEntregaPedido(par_cCampo)
        LOCAL loc_oCnt, loc_cValor, loc_oBusca

        loc_oCnt = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao

        IF par_cCampo = "IClis"
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_ContaEs.Value)
        ELSE
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DContaEs.Value)
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaContaEsPed", par_cCampo, loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oCnt.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_BuscaContaEsPed.IClis)
                loc_oCnt.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_BuscaContaEsPed.RClis)
            ELSE
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaEsPed")
                    loc_oCnt.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_BuscaContaEsPed.IClis)
                    loc_oCnt.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_BuscaContaEsPed.RClis)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaContaEsPed")
            USE IN cursor_4c_BuscaContaEsPed
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEntregaPedidoClick - cmdEntrega.Valid de cnt_4c_Operacao: mesma
    * observacao do BtnEntregaGeralClick (SigCdEnd nao portado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEntregaPedidoClick()
        LOCAL loc_cContaEs, loc_cSQL, loc_nResultado

        loc_cContaEs = ALLTRIM(THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao.txt_4c_ContaEs.Value)

        IF EMPTY(loc_cContaEs)
            MsgAviso("Informe a Conta de Entrega antes de escolher o local de entrega.", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cContaEs)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EntregaPedCli")

        IF loc_nResultado < 0 OR !USED("cursor_4c_EntregaPedCli") OR EOF("cursor_4c_EntregaPedCli")
            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                "Falha na Conex" + CHR(227) + "o (cmdEntrega)")
        ELSE
            MsgAviso("A tela de Local de Entrega (SigCdEnd) n" + CHR(227) + "o foi portada para o " + ;
                "sistema novo." + CHR(13) + "Cadastre/ajuste os endere" + CHR(231) + "os de entrega do " + ;
                "cliente " + ALLTRIM(cursor_4c_EntregaPedCli.RClis) + " pelo cadastro de Clientes.", "Aviso")
        ENDIF

        IF USED("cursor_4c_EntregaPedCli")
            USE IN cursor_4c_EntregaPedCli
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Empresa de lancamento (getEmps -> SigCdEmp.Cemps/Razas).
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaPedido(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresaPedido()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaPedido()
        ENDIF
    ENDPROC

    PROCEDURE ValidarEmpresaPedido()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Emps.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpPedVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_EmpPedVal") AND !EOF("cursor_4c_EmpPedVal")
            loc_oCnt.txt_4c_Emps.Value = ALLTRIM(cursor_4c_EmpPedVal.Cemps)
        ELSE
            THIS.AbrirBuscaEmpresaPedido()
        ENDIF

        IF USED("cursor_4c_EmpPedVal")
            USE IN cursor_4c_EmpPedVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresaPedido()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Emps.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpPed", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oCnt.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmpPed.Cemps)
            ELSE
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpPed")
                    loc_oCnt.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmpPed.Cemps)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmpPed")
            USE IN cursor_4c_BuscaEmpPed
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Operacao de lancamento (getDopes -> operacoes de subnivel do Dopes
    * filtrado em Page1, cursor_4c_Subniveis - equivalente ao fwBuscaInt do
    * legado sobre crSubniveis, aqui implementado como FormBuscaAuxiliar sobre
    * uma SUBCONSULTA SQL Server derivada (nao um cursor VFP local - o
    * contrato de FormBuscaAuxiliar exige "SELECT * FROM <tabela>", e uma
    * expressao "(SELECT ... ) AS X" e uma tabela derivada valida no SQL
    * Server, preservando o padrao canonico do projeto).
    *--------------------------------------------------------------------------
    PROCEDURE TeclaOperacaoLancamento(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacaoLancamento()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperacaoLancamento()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE MontarConsultaSubniveis()
        RETURN ;
            "(SELECT a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, " + ;
            "a.Series, a.Especies, a.TipoNfs, a.MarcaSubns, a.Cfos, a.Casas, a.GrVends, b.ChkLimOps " + ;
            "FROM SigCdOpe a INNER JOIN SigOpCdd b ON a.Dopes = b.Dopes " + ;
            "WHERE a.Nivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + " " + ;
            "UNION ALL " + ;
            "SELECT b.CDopes AS Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, " + ;
            "c.Series, c.Especies, c.TipoNfs, c.MarcaSubns, c.Cfos, c.Casas, c.GrVends, d.ChkLimOps " + ;
            "FROM SigOpCsn b INNER JOIN SigCdOpe c ON b.CDopes = c.Dopes " + ;
            "INNER JOIN SigOpCdd d ON b.CDopes = d.Dopes " + ;
            "WHERE b.CNivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ") AS cursor_4c_SubDerivada"
    ENDPROC

    PROCEDURE ValidarOperacaoLancamento()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT * FROM " + THIS.MontarConsultaSubniveis() + " WHERE Dopes = " + ;
            EscaparSQL(PADR(loc_cValor, 20))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeLancVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_OpeLancVal") AND !EOF("cursor_4c_OpeLancVal")
            loc_oCnt.txt_4c_Dopes.Value  = ALLTRIM(cursor_4c_OpeLancVal.Dopes)
            loc_oCnt.txt_4c_CMoes.Value  = ALLTRIM(NVL(cursor_4c_OpeLancVal.CMoes, ""))
            loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(NVL(cursor_4c_OpeLancVal.GruDests, ""))
            loc_oCnt.txt_4c_ContaDs.Value = ""
            THIS.ValidarContaDestino("IClis")
        ELSE
            THIS.AbrirBuscaOperacaoLancamento()
        ENDIF

        IF USED("cursor_4c_OpeLancVal")
            USE IN cursor_4c_OpeLancVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaOperacaoLancamento()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            THIS.MontarConsultaSubniveis(), "cursor_4c_BuscaOpeLanc", "Dopes", loc_cValor, ;
            "Opera" + CHR(231) + CHR(245) + "es", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lAchouRegistro
                loc_oCnt.txt_4c_Dopes.Value   = ALLTRIM(cursor_4c_BuscaOpeLanc.Dopes)
                loc_oCnt.txt_4c_CMoes.Value   = ALLTRIM(NVL(cursor_4c_BuscaOpeLanc.CMoes, ""))
                loc_oCnt.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_BuscaOpeLanc.GruDests, ""))
                loc_oCnt.txt_4c_ContaDs.Value = ""
                THIS.ValidarContaDestino("IClis")
            ELSE
                loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpeLanc")
                    loc_oCnt.txt_4c_Dopes.Value   = ALLTRIM(cursor_4c_BuscaOpeLanc.Dopes)
                    loc_oCnt.txt_4c_CMoes.Value   = ALLTRIM(NVL(cursor_4c_BuscaOpeLanc.CMoes, ""))
                    loc_oCnt.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_BuscaOpeLanc.GruDests, ""))
                    loc_oCnt.txt_4c_ContaDs.Value = ""
                    THIS.ValidarContaDestino("IClis")
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaOpeLanc")
            USE IN cursor_4c_BuscaOpeLanc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Moeda de lancamento (getCMoes -> SigCdMoe.CMoes/DMoes).
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoedaPedido(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaPedido()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaPedido()
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoedaPedido()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_CMoes.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_MoeVal") AND !EOF("cursor_4c_MoeVal")
            loc_oCnt.txt_4c_CMoes.Value = ALLTRIM(cursor_4c_MoeVal.CMoes)
        ELSE
            THIS.AbrirBuscaMoedaPedido()
        ENDIF

        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaPedido()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_CMoes.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", .T.)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CMoes", "", "Cod")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    loc_oCnt.txt_4c_CMoes.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                ENDIF
            ELSE
                loc_oCnt.txt_4c_CMoes.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgOperacoes - PageFrame interno pgf_4c_PgOperacoes (mapeia
    * pgOperacoes do legado): Page1=Operacoes (grdCabOperas), Page2=Itens
    * (grdItnOperas). O Activate de Page2 filtra grdItnOperas pelos itens da
    * operacao corrente de grdCabOperas (SET KEY TO do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgOperacoes(par_oPagina)
        LOCAL loc_oPgf

        par_oPagina.AddObject("pgf_4c_PgOperacoes", "PageFrame")
        loc_oPgf = par_oPagina.pgf_4c_PgOperacoes

        WITH loc_oPgf
            .Top       = 182
            .Left      = 1
            .Width     = 997
            .Height    = 377
            .PageCount = 2
            .Tabs      = .T.
            .Visible   = .T.

            .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
            .Page1.FontName  = "Verdana"
            .Page1.FontSize  = 8
            .Page1.FontBold  = .T.
            .Page1.ForeColor = RGB(36, 84, 155)

            .Page2.Caption   = "Itens"
            .Page2.FontName  = "Verdana"
            .Page2.FontSize  = 8
            .Page2.FontBold  = .T.
            .Page2.ForeColor = RGB(36, 84, 155)
        ENDWITH

        THIS.ConfigurarGridCabOperas(loc_oPgf.Page1)
        THIS.ConfigurarGridItnOperas(loc_oPgf.Page2)

        *-- Equivalente ao PROCEDURE pgItens.Activate do legado - PageFrame nao
        *-- tem InteractiveChange nativo; quem dispara ao trocar de aba eh o
        *-- Activate da Page de DESTINO.
        BINDEVENT(loc_oPgf.Page2, "Activate", THIS, "PgItensActivate")
    ENDPROC

    *--------------------------------------------------------------------------
    * PgItensActivate - Equivalente ao pgItens.Activate do legado: ao ativar a
    * aba "Itens", filtra grdItnOperas pelos itens da operacao corrente
    * (Numes) de grdCabOperas.
    *--------------------------------------------------------------------------
    PROCEDURE PgItensActivate()
        LOCAL loc_oPgf, loc_nNumes

        loc_oPgf = THIS.pgf_4c_Paginas.Page4.pgf_4c_PgOperacoes

        IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
            loc_nNumes = cursor_4c_CabOperas.Numes

            SELECT cursor_4c_ItnOperas
            SET ORDER TO Ordem
            SET FILTER TO Numes = loc_nNumes
            GO TOP IN cursor_4c_ItnOperas

            loc_oPgf.Page2.grd_4c_ItnOperas.Refresh()
            loc_oPgf.Page2.grd_4c_ItnOperas.Column1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridCabOperas - grdCabOperas (cabecalho das operacoes de
    * pedido, 1 linha por fornecedor -> cursor_4c_CabOperas).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridCabOperas(par_oPagina)
        LOCAL loc_oGrid

        par_oPagina.AddObject("grd_4c_CabOperas", "Grid")
        loc_oGrid = par_oPagina.grd_4c_CabOperas

        loc_oGrid.ColumnCount = 9

        WITH loc_oGrid
            .Top           = 6
            .Left          = 9
            .Width         = 975
            .Height        = 339
            .FontName      = "Tahoma"
            .FontSize      = 8
            .HeaderHeight  = 16
            .RowHeight     = 15
            .ScrollBars    = 3
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .GridLineColor = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        loc_oGrid.ColumnCount = 9
        loc_oGrid.RecordSource          = "cursor_4c_CabOperas"
        loc_oGrid.Column1.ControlSource = "cursor_4c_CabOperas.Numes"
        loc_oGrid.Column2.ControlSource = "cursor_4c_CabOperas.IFors"
        loc_oGrid.Column3.ControlSource = "cursor_4c_CabOperas.Fornecs"
        loc_oGrid.Column4.ControlSource = "cursor_4c_CabOperas.FPags"
        loc_oGrid.Column5.ControlSource = "cursor_4c_CabOperas.DtEnts"
        loc_oGrid.Column6.ControlSource = "cursor_4c_CabOperas.Qtds"
        loc_oGrid.Column7.ControlSource = "cursor_4c_CabOperas.Valors"
        loc_oGrid.Column8.ControlSource = "cursor_4c_CabOperas.Fretes"
        loc_oGrid.Column9.ControlSource = "cursor_4c_CabOperas.VlFretes"

        WITH loc_oGrid.Column1
            .Alignment         = 3
            .Header1.Caption   = "Ord."
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column3
            .Header1.Caption   = "Fornecedor"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column4
            .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column5
            .Alignment         = 3
            .Format            = "E"
            .Header1.Caption   = "Entrega"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column6
            .Alignment         = 3
            .Format            = "999,999.99"
            .Header1.Caption   = "Quantidade"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column7
            .Alignment         = 3
            .Format            = "999,999.99"
            .Header1.Caption   = "Valor"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column8
            .Header1.Caption   = "F"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column9
            .Alignment         = 3
            .Format            = "999,999.99"
            .Header1.Caption   = "Frete"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        loc_oGrid.Column1.Width = 35
        loc_oGrid.Column2.Width = 80
        loc_oGrid.Column3.Width = 250
        loc_oGrid.Column4.Width = 110
        loc_oGrid.Column5.Width = 80
        loc_oGrid.Column6.Width = 110
        loc_oGrid.Column7.Width = 110
        loc_oGrid.Column8.Width = 60
        loc_oGrid.Column9.Width = 90

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridCabOperasAfterRowColChange")
    ENDPROC

    PROCEDURE GridCabOperasAfterRowColChange(par_nColIndex)
        LOCAL loc_nNumes

        IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
            loc_nNumes = cursor_4c_CabOperas.Numes
            SELECT cursor_4c_ItnOperas
            SET ORDER TO Ordem
            SET FILTER TO Numes = loc_nNumes
            GO TOP IN cursor_4c_ItnOperas
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridItnOperas - grdItnOperas (itens de UMA operacao de pedido,
    * filtrados pelo Numes corrente de grdCabOperas -> cursor_4c_ItnOperas).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridItnOperas(par_oPagina)
        LOCAL loc_oGrid

        par_oPagina.AddObject("grd_4c_ItnOperas", "Grid")
        loc_oGrid = par_oPagina.grd_4c_ItnOperas

        loc_oGrid.ColumnCount = 9

        WITH loc_oGrid
            .Top           = 5
            .Left          = 9
            .Width         = 975
            .Height        = 340
            .FontName      = "Tahoma"
            .FontSize      = 8
            .HeaderHeight  = 16
            .RowHeight     = 15
            .ScrollBars    = 3
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .GridLineColor = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        loc_oGrid.ColumnCount = 9
        loc_oGrid.RecordSource          = "cursor_4c_ItnOperas"
        loc_oGrid.Column1.ControlSource = "cursor_4c_ItnOperas.CItens"
        loc_oGrid.Column2.ControlSource = "cursor_4c_ItnOperas.CPros"
        loc_oGrid.Column3.ControlSource = "cursor_4c_ItnOperas.DPros"
        loc_oGrid.Column4.ControlSource = "cursor_4c_ItnOperas.CUnis"
        loc_oGrid.Column5.ControlSource = "cursor_4c_ItnOperas.Qtds"
        loc_oGrid.Column6.ControlSource = "cursor_4c_ItnOperas.Units"
        loc_oGrid.Column7.ControlSource = "cursor_4c_ItnOperas.Valors"
        loc_oGrid.Column8.ControlSource = "cursor_4c_ItnOperas.CodCors"
        loc_oGrid.Column9.ControlSource = "cursor_4c_ItnOperas.CodTams"

        WITH loc_oGrid.Column1
            .Alignment         = 3
            .Header1.Caption   = "Ord."
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column3
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column4
            .Header1.Caption   = "Uni"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column5
            .Alignment         = 3
            .Format            = "999,999.99"
            .Header1.Caption   = "Quantidade"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column6
            .Alignment         = 3
            .Format            = "999999.999999"
            .Header1.Caption   = "Unit" + CHR(225) + "rio"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column7
            .Alignment         = 3
            .Format            = "999,999.99"
            .Header1.Caption   = "Total"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column8
            .Header1.Caption   = "Cor"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrid.Column9
            .Header1.Caption   = "Tam"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
        ENDWITH

        loc_oGrid.Column1.Width = 40
        loc_oGrid.Column2.Width = 90
        loc_oGrid.Column3.Width = 300
        loc_oGrid.Column4.Width = 50
        loc_oGrid.Column5.Width = 120
        loc_oGrid.Column6.Width = 110
        loc_oGrid.Column7.Width = 110
        loc_oGrid.Column8.Width = 75
        loc_oGrid.Column9.Width = 75
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposPedidos - Reproduz os PROCEDURE When dos campos de
    * cntOperacao, que no legado gateiam a edicao pelo modo corrente
    * (loObj.pcEscolha) e pelo preenchimento dos campos de que dependem:
    *
    *   getEmps/getDatas/getDopes/getCMoes/getGrupoDs/getObs
    *                  -> InList(pcEscolha, INSERIR, ALTERAR)
    *   getContaDs     -> ... E Grupo preenchido
    *   getDContaDs    -> ... E Grupo preenchido E Conta de destino VAZIA
    *   getContaEs     -> InList(pcEscolha, INSERIR, ALTERAR)
    *   getDContaEs    -> ... E Conta de entrega VAZIA
    *   getJob/getDjob -> Return .f. (nunca editaveis - ja nascem ReadOnly)
    *
    * getCodObs NAO tem When no legado, mas eh campo da mesma operacao e segue
    * o modo, como os demais editaveis do cabecalho.
    *
    * Usa ReadOnly, e nao Enabled: o When do legado impede a edicao sem
    * acinzentar o controle.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarCamposPedidos()
        LOCAL loc_oCnt, loc_lEdita, loc_lTemGrupo, loc_lTemContaDs, loc_lTemContaEs

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
            RETURN
        ENDIF

        loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
        loc_lEdita = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

        loc_lTemGrupo   = !EMPTY(loc_oCnt.txt_4c_Grupo.Value)
        loc_lTemContaDs = !EMPTY(loc_oCnt.txt_4c_ContaDs.Value)
        loc_lTemContaEs = !EMPTY(loc_oCnt.txt_4c_ContaEs.Value)

        WITH loc_oCnt
            .txt_4c_Emps.ReadOnly   = !loc_lEdita
            .txt_4c_Datas.ReadOnly  = !loc_lEdita
            .txt_4c_Dopes.ReadOnly  = !loc_lEdita
            .txt_4c_CMoes.ReadOnly  = !loc_lEdita
            .txt_4c_Grupo.ReadOnly  = !loc_lEdita
            .txt_4c_CodObs.ReadOnly = !loc_lEdita
            .obj_4c_GetObs.ReadOnly = !loc_lEdita

            .txt_4c_ContaDs.ReadOnly  = !(loc_lEdita AND loc_lTemGrupo)
            .txt_4c_DContaDs.ReadOnly = !(loc_lEdita AND loc_lTemGrupo AND !loc_lTemContaDs)
            .txt_4c_ContaEs.ReadOnly  = !loc_lEdita
            .txt_4c_DContaEs.ReadOnly = !(loc_lEdita AND !loc_lTemContaEs)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRetornarCotacoesClick - cmdBotoes.btnSair.Click da pagina de Pedidos:
    * em modo de edicao pede confirmacao, descarta as alteracoes em curso
    * (o RollBack do poDataMgr legado = CancelarEdicao do BusinessBase) e volta
    * para a pagina de Cotacoes - que eh a pagina 3, apesar de o Caption do
    * botao dizer "Pagina de Dados" (ver ConfigurarPaginaDados).
    *
    * O legado ainda faz SetFocus em pgCotacoes.cmdGravar.btnGeraPedidos; esse
    * CommandGroup eh criado na Fase 6, e o SetFocus entra junto com ele.
    *--------------------------------------------------------------------------
    PROCEDURE BtnRetornarCotacoesClick()
        LOCAL loc_lConfirma

        loc_lConfirma = .T.

        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            loc_lConfirma = MsgConfirma("Deseja Realmente Abandonar as Altera" + ;
                CHR(231) + CHR(245) + "es?", "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF

        IF loc_lConfirma
            THIS.this_oBusinessObject.CancelarEdicao()

            THIS.this_cModoAtual = "COTACOES"
            THIS.AlternarPagina(3)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridOperacoes - Grade de Movimentacoes em aberto (grdOperacoes
    * do legado, ligada a crOperacoes). A Column1 eh a coluna de MARCACAO:
    * exige AddObject + CurrentControl + Sparse = .F., senao o CheckBox nunca
    * aparece (a coluna continua desenhando o Text1 dela) - e Column.ReadOnly
    * tem de vir DEPOIS de Grid.ReadOnly, que propaga para as colunas.
    *
    * Column.Width por ULTIMO: mexer em RecordSource/ControlSource faz o VFP
    * recalcular todas as larguras para o default.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPagina)
        LOCAL loc_oGrid

        par_oPagina.AddObject("grd_4c_Operacoes", "Grid")
        loc_oGrid = par_oPagina.grd_4c_Operacoes

        loc_oGrid.ColumnCount = 6

        WITH loc_oGrid
            .Top               = 25
            .Left              = 250
            .Width             = 407
            .Height            = 244
            .FontName          = "Tahoma"
            .FontSize          = 8
            .RowHeight         = 16
            .ScrollBars        = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .ReadOnly          = .F.
            .GridLineColor     = RGB(128, 128, 128)
            .Visible           = .T.
        ENDWITH

        loc_oGrid.ColumnCount = 6
        loc_oGrid.RecordSource          = "cursor_4c_Movimentacao"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Movimentacao.Marcas"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Movimentacao.Datas"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Movimentacao.Emps"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Movimentacao.Dopes"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Movimentacao.Numes"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Movimentacao.Itens"

        IF !PEMSTATUS(loc_oGrid.Column1, "chk_4c_Marcas", 5)
            loc_oGrid.Column1.AddObject("chk_4c_Marcas", "CheckBox")
        ENDIF

        WITH loc_oGrid.Column1.chk_4c_Marcas
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
            .BackStyle = 0
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .CurrentControl   = "chk_4c_Marcas"
            .Sparse           = .F.
            .ReadOnly         = .F.
            .Movable          = .F.
            .Resizable        = .F.
            .FontSize         = 8
            .Header1.Caption  = ""
            .Header1.FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .FontSize          = 8
            .ReadOnly          = .T.
            .Header1.Caption   = "Data"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontName    = "Arial"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 1
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH

        WITH loc_oGrid.Column3
            .FontSize          = 8
            .ReadOnly          = .T.
            .Header1.Caption   = "Emp"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontSize    = 8
            .Text1.Margin      = 0
        ENDWITH

        WITH loc_oGrid.Column4
            .FontSize          = 8
            .ReadOnly          = .T.
            .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column5
            .FontSize          = 8
            .ReadOnly          = .T.
            .Format            = "999999"
            .InputMask         = "999999"
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontSize    = 8
            .Text1.Margin      = 0
        ENDWITH

        WITH loc_oGrid.Column6
            .FontSize          = 8
            .ReadOnly          = .T.
            .Format            = "999999"
            .InputMask         = "999999"
            .Header1.Caption   = "Itens"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontSize    = 8
            .Text1.Margin      = 0
        ENDWITH

        *-- Larguras por ULTIMO (valores EXATOS do SCX)
        loc_oGrid.Column1.Width = 17
        loc_oGrid.Column2.Width = 70
        loc_oGrid.Column3.Width = 31
        loc_oGrid.Column4.Width = 150
        loc_oGrid.Column5.Width = 56
        loc_oGrid.Column6.Width = 56

        *-- O CheckBox de grid NAO alterna pelo binding nativo: o legado
        *-- suprime o toggle padrao (NoDefault) e inverte Marcas por codigo,
        *-- para poder validar a regra de Job.
        BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "Click",     THIS, "ChkMarcasClick")
        BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "MouseDown", THIS, "ChkMarcasMouseDown")
        BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "MouseUp",   THIS, "ChkMarcasMouseUp")
        BINDEVENT(loc_oGrid.Column1.chk_4c_Marcas, "KeyPress",  THIS, "ChkMarcasKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridCotaPends - Grade de Cotacoes Realizadas (grdCotaPends do
    * legado, ligada a crCotaPends). A cor da coluna Prioridade eh dinamica,
    * exatamente como o DynamicForeColor declarado no SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridCotaPends(par_oPagina)
        LOCAL loc_oGrid, loc_cCorPrioridade

        par_oPagina.AddObject("grd_4c_CotaPends", "Grid")
        loc_oGrid = par_oPagina.grd_4c_CotaPends

        loc_oGrid.ColumnCount = 6

        WITH loc_oGrid
            .Top           = 311
            .Left          = 250
            .Width         = 407
            .Height        = 244
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowHeight     = 16
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .GridLineColor = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        loc_oGrid.ColumnCount = 6
        loc_oGrid.RecordSource          = "cursor_4c_CotasPendentes"
        loc_oGrid.Column1.ControlSource = "cursor_4c_CotasPendentes.Codigos"
        loc_oGrid.Column2.ControlSource = "cursor_4c_CotasPendentes.DtSolics"
        loc_oGrid.Column3.ControlSource = "cursor_4c_CotasPendentes.Solicitas"
        loc_oGrid.Column4.ControlSource = "cursor_4c_CotasPendentes.Deptos"
        loc_oGrid.Column5.ControlSource = "cursor_4c_CotasPendentes.Prioris"
        loc_oGrid.Column6.ControlSource = "cursor_4c_CotasPendentes.DtCotas"

        WITH loc_oGrid.Column1
            .FontSize          = 8
            .FontBold          = .T.
            .Alignment         = 3
            .Movable           = .F.
            .Resizable         = .F.
            .Sparse            = .F.
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontBold    = .T.
            .Text1.FontSize    = 8
            .Text1.Alignment   = 3
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column2
            .FontSize          = 8
            .FontBold          = .T.
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = "Solicita" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontBold    = .T.
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column3
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = "Solicitante"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontSize    = 8
            .Text1.Margin      = 0
        ENDWITH

        WITH loc_oGrid.Column4
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = "Departamento"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontSize    = 8
            .Text1.Margin      = 0
        ENDWITH

        *-- Cor da prioridade: Alta = vermelho, Media = laranja,
        *-- Ped.Gerado = azul, Normal = preto (DynamicForeColor do SCX)
        loc_cCorPrioridade = ;
            "IIF(cursor_4c_CotasPendentes.Prioris = [Alta], RGB(185,0,0), " + ;
            "IIF(cursor_4c_CotasPendentes.Prioris = [M" + CHR(233) + "dia], RGB(255,128,64), " + ;
            "IIF(cursor_4c_CotasPendentes.Prioris = [Ped.Gerado], RGB(0,0,255), RGB(0,0,0))))"

        WITH loc_oGrid.Column5
            .FontSize          = 8
            .FontBold          = .T.
            .Movable           = .F.
            .Resizable         = .F.
            .DynamicForeColor  = loc_cCorPrioridade
            .Header1.Caption   = "Prioridade"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontBold    = .T.
            .Text1.FontSize    = 8
            .Text1.Margin      = 0
        ENDWITH

        WITH loc_oGrid.Column6
            .FontSize          = 8
            .Alignment         = 3
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontSize  = 8
            .Text1.FontSize    = 8
            .Text1.Alignment   = 3
            .Text1.Margin      = 0
        ENDWITH

        *-- Larguras por ULTIMO (valores EXATOS do SCX)
        loc_oGrid.Column1.Width = 42
        loc_oGrid.Column2.Width = 58
        loc_oGrid.Column3.Width = 77
        loc_oGrid.Column4.Width = 77
        loc_oGrid.Column5.Width = 68
        loc_oGrid.Column6.Width = 58

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridCotaPendsAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Equivalente ao PROCEDURE processamento do legado:
    * popula as duas grades da pagina Dados com os filtros ja validados.
    *
    *   1) Movimentacoes em aberto  (SigMvCab + SigMvItn + SigCdPro + SigCdOpe)
    *   2) Desconta o que ja foi cotado (SigCtTCt) e descarta saldo <= 0
    *   3) Agrupa por Empresa+Operacao+Numero somando os itens
    *   4) Cotacoes ja realizadas   (SigCtTDc)
    *
    * Retorna .F. (com o aviso do legado) quando as duas grades ficam vazias -
    * nesse caso Processamento NAO avanca de pagina, como no original.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro, loc_oProgresso
        LOCAL loc_cDtI, loc_cDtF, loc_cFiltro, loc_cEd1, loc_cEd2
        LOCAL loc_cSQL, loc_nResultado, loc_cEdn, loc_nSaldo
        LOCAL loc_dData, loc_cPrioridade, loc_oPag

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_oProgresso  = .NULL.
        loc_oPag        = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oProgresso = CREATEOBJECT("fwprogressbar", ;
                    "Processando Cota" + CHR(231) + CHR(245) + "es de Produtos", 4)

                IF VARTYPE(loc_oProgresso) = "O"
                    loc_oProgresso.Show()
                    loc_oProgresso.Update("Montando Telas", .T.)
                ENDIF

                ZAP IN cursor_4c_Movimentacao
                ZAP IN cursor_4c_CotasPendentes

                loc_cDtI = FormatarDataSQL(THIS.this_dDtPerI)
                loc_cDtF = FormatarDataSQL(DTOT(THIS.this_dDtPerF) + 86399)

                *-- Filtro de operacao/empresa transcrito do legado: com a
                *-- empresa informada ele troca Dopes por uma faixa de
                *-- EmpDopNums (Emps + Dopes + Numes de 0 a 999999).
                IF EMPTY(THIS.this_cEmps)
                    loc_cFiltro = "a.Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
                ELSE
                    loc_cEd1 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(0, 6)
                    loc_cEd2 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(999999, 6)
                    loc_cFiltro = "a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + ;
                                  " AND " + EscaparSQL(loc_cEd2)
                ENDIF

                IF !EMPTY(THIS.this_cJobs)
                    loc_cFiltro = loc_cFiltro + " AND a.Jobs = " + EscaparSQL(THIS.this_cJobs)
                ENDIF

                IF VARTYPE(loc_oProgresso) = "O"
                    loc_oProgresso.Update("Selecionando Opera" + CHR(231) + CHR(245) + ;
                        "es Pendentes", .T.)
                ENDIF

                loc_cSQL = "SELECT a.Datas, a.Emps, a.Dopes, a.Numes, b.CItens, " + ;
                           "(b.Qtds - b.QtBaixas) AS Qtds, " + ;
                           "a.ChkBxParcs, a.ChkPagos, a.ChkSubn, a.LCancelas, a.Nops, " + ;
                           "a.ProcBals, a.ProcDBal, " + ;
                           "d.Destinos, d.EstDests, d.EstOrigs, d.Origems, d.Produc, a.Jobs " + ;
                           "FROM SigMvCab a, SigMvItn b, SigCdPro c, SigCdOpe d " + ;
                           "WHERE a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND " + ;
                           "a.ChkSubn = 0 AND " + loc_cFiltro + " AND " + ;
                           "a.EmpDopNums = b.EmpDopNums AND " + ;
                           "(b.Qtds - b.QtBaixas) > 0 AND " + ;
                           "b.CPros = c.CPros AND " + ;
                           "a.Dopes = d.Dopes " + ;
                           "ORDER BY a.Datas, a.Emps, a.Dopes, a.Numes, b.CItens"

                IF USED("cursor_4c_MovTemp")
                    USE IN cursor_4c_MovTemp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTemp")

                IF loc_nResultado < 1
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (Movimenta" + CHR(231) + ;
                        CHR(245) + "es)")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF VARTYPE(loc_oProgresso) = "O"
                    loc_oProgresso.Update("Processando Dados Das Opera" + CHR(231) + ;
                        CHR(245) + "es Pendentes", .T.)
                ENDIF

                *-- Elimina as movimentacoes ja utilizadas em cotacoes
                *-- anteriores: o saldo cotado (SigCtTCt) desconta a quantidade
                *-- em aberto e o que zerar sai da lista.
                SELECT cursor_4c_MovTemp
                SCAN
                    loc_nSaldo = NVL(cursor_4c_MovTemp.Qtds, 0)
                    loc_cEdn   = cursor_4c_MovTemp.Emps + cursor_4c_MovTemp.Dopes + ;
                                 STR(cursor_4c_MovTemp.Numes, 6)

                    loc_cSQL = "SELECT a.EmpDopNums, a.CItens, a.Qtds " + ;
                               "FROM SigCtTCt a " + ;
                               "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND " + ;
                               "a.CItens = " + ;
                               FormatarNumeroSQL(cursor_4c_MovTemp.CItens, 0) + " " + ;
                               "ORDER BY a.EmpDopNums, a.CItens, a.Qtds"

                    IF USED("cursor_4c_CotCtTemp")
                        USE IN cursor_4c_CotCtTemp
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotCtTemp") > 0
                        SELECT cursor_4c_CotCtTemp
                        GO TOP IN cursor_4c_CotCtTemp
                        IF !EOF("cursor_4c_CotCtTemp")
                            loc_nSaldo = NVL(cursor_4c_MovTemp.Qtds, 0) - ;
                                         NVL(cursor_4c_CotCtTemp.Qtds, 0)
                        ENDIF
                        USE IN cursor_4c_CotCtTemp
                    ENDIF

                    SELECT cursor_4c_MovTemp
                    IF !(loc_nSaldo > 0)
                        DELETE IN cursor_4c_MovTemp
                    ENDIF
                ENDSCAN

                *-- Agrupa por Empresa + Operacao + Numero, somando os itens
                SELECT cursor_4c_MovTemp
                SCAN
                    loc_dData = ConverterParaData(NVL(cursor_4c_MovTemp.Datas, {}))
                    loc_cEdn  = cursor_4c_MovTemp.Emps + cursor_4c_MovTemp.Dopes + ;
                                STR(cursor_4c_MovTemp.Numes, 6)

                    IF !SEEK(DTOS(loc_dData) + loc_cEdn, "cursor_4c_Movimentacao", "Ordem")
                        INSERT INTO cursor_4c_Movimentacao ;
                            (Emps, Dopes, Numes, Datas, EmpDopNums, Nops, ChkSubn, ;
                             LCancelas, ChkBxParcs, ChkPagos, ProcBals, ProcDBal, ;
                             Destinos, EstDests, EstOrigs, Origems, Produc, Jobs) ;
                            VALUES ;
                            (cursor_4c_MovTemp.Emps, cursor_4c_MovTemp.Dopes, ;
                             cursor_4c_MovTemp.Numes, loc_dData, loc_cEdn, ;
                             NVL(cursor_4c_MovTemp.Nops, 0), ;
                             ConverterParaLogico(cursor_4c_MovTemp.ChkSubn), ;
                             ConverterParaLogico(cursor_4c_MovTemp.LCancelas), ;
                             ConverterParaLogico(cursor_4c_MovTemp.ChkBxParcs), ;
                             ConverterParaLogico(cursor_4c_MovTemp.ChkPagos), ;
                             ConverterParaLogico(cursor_4c_MovTemp.ProcBals), ;
                             ConverterParaLogico(cursor_4c_MovTemp.ProcDBal), ;
                             NVL(cursor_4c_MovTemp.Destinos, 0), ;
                             NVL(cursor_4c_MovTemp.EstDests, 0), ;
                             NVL(cursor_4c_MovTemp.EstOrigs, 0), ;
                             NVL(cursor_4c_MovTemp.Origems, 0), ;
                             NVL(cursor_4c_MovTemp.Produc, 0), ;
                             NVL(cursor_4c_MovTemp.Jobs, ""))
                    ENDIF

                    REPLACE Itens WITH Itens + NVL(cursor_4c_MovTemp.Qtds, 0) ;
                        IN cursor_4c_Movimentacao

                    SELECT cursor_4c_MovTemp
                ENDSCAN

                IF USED("cursor_4c_MovTemp")
                    USE IN cursor_4c_MovTemp
                ENDIF

                SELECT cursor_4c_Movimentacao
                GO TOP IN cursor_4c_Movimentacao

                THIS.AplicarCoresGridOperacoes()

                IF VARTYPE(loc_oProgresso) = "O"
                    loc_oProgresso.Update("Carregando as Cota" + CHR(231) + CHR(245) + ;
                        "es Pendentes", .T.)
                ENDIF

                *-- Cotacoes ja realizadas: as que estao em aberto (Situas = 0)
                *-- mais as que geraram pedido dentro do periodo filtrado
                loc_cSQL = "SELECT a.Situas, a.Codigos, a.DtSolics, a.Solicitas, " + ;
                           "a.Deptos, a.Prioris, a.DtCotas, a.DtAprovs, a.Aprovador, " + ;
                           "a.ContaEs, a.LocalEnts, a.Justificas, a.Copias " + ;
                           "FROM SigCtTDc a " + ;
                           "WHERE a.Situas = 0 OR " + ;
                           "(NOT a.Situas = 0 AND a.DtCotas BETWEEN " + ;
                           loc_cDtI + " AND " + loc_cDtF + ") " + ;
                           "ORDER BY a.Codigos"

                IF USED("cursor_4c_CotDcTemp")
                    USE IN cursor_4c_CotDcTemp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotDcTemp")

                IF loc_nResultado < 1
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                        "Falha na Conex" + CHR(227) + "o (Cota" + CHR(231) + CHR(245) + "es)")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_CotDcTemp
                SCAN
                    IF NVL(cursor_4c_CotDcTemp.Situas, 0) <> 0
                        loc_cPrioridade = "Ped.Gerado"
                    ELSE
                        DO CASE
                            CASE NVL(cursor_4c_CotDcTemp.Prioris, 0) = 3
                                loc_cPrioridade = "Alta"
                            CASE NVL(cursor_4c_CotDcTemp.Prioris, 0) = 2
                                loc_cPrioridade = "M" + CHR(233) + "dia"
                            OTHERWISE
                                loc_cPrioridade = "Normal"
                        ENDCASE
                    ENDIF

                    INSERT INTO cursor_4c_CotasPendentes ;
                        (Situas, Codigos, DtSolics, Solicitas, Deptos, Prioris, ;
                         DtCotas, DtAprovs, Aprovador, ContaEs, LocalEnts, ;
                         Justificas, Copias) ;
                        VALUES ;
                        (NVL(cursor_4c_CotDcTemp.Situas, 0), ;
                         NVL(cursor_4c_CotDcTemp.Codigos, 0), ;
                         ConverterParaData(NVL(cursor_4c_CotDcTemp.DtSolics, {})), ;
                         NVL(cursor_4c_CotDcTemp.Solicitas, ""), ;
                         NVL(cursor_4c_CotDcTemp.Deptos, ""), ;
                         loc_cPrioridade, ;
                         ConverterParaData(NVL(cursor_4c_CotDcTemp.DtCotas, {})), ;
                         ConverterParaData(NVL(cursor_4c_CotDcTemp.DtAprovs, {})), ;
                         NVL(cursor_4c_CotDcTemp.Aprovador, ""), ;
                         NVL(cursor_4c_CotDcTemp.ContaEs, ""), ;
                         NVL(cursor_4c_CotDcTemp.LocalEnts, 0), ;
                         NVL(cursor_4c_CotDcTemp.Justificas, ""), ;
                         NVL(cursor_4c_CotDcTemp.Copias, 0))

                    SELECT cursor_4c_CotDcTemp
                ENDSCAN

                IF USED("cursor_4c_CotDcTemp")
                    USE IN cursor_4c_CotDcTemp
                ENDIF

                IF VARTYPE(loc_oProgresso) = "O"
                    loc_oProgresso.Complete(.T.)
                    loc_oProgresso = .NULL.
                ENDIF

                IF RECCOUNT("cursor_4c_Movimentacao") < 1 AND ;
                   RECCOUNT("cursor_4c_CotasPendentes") < 1
                    MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o!!!")
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
                ELSE
                    *-- Popular o cursor NAO repinta a grade: GO TOP + Refresh
                    SELECT cursor_4c_CotasPendentes
                    GO TOP IN cursor_4c_CotasPendentes

                    SELECT cursor_4c_Movimentacao
                    GO TOP IN cursor_4c_Movimentacao

                    loc_oPag.obj_4c_CmdProblemas.Visible = THIS.PossuiAcessoCotacaoLivre()

                    loc_oPag.grd_4c_Operacoes.Refresh()
                    loc_oPag.grd_4c_CotaPends.Refresh()

                    THIS.AjustarBotoesPorModo()

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        FINALLY
            IF VARTYPE(loc_oProgresso) = "O"
                loc_oProgresso.Complete(.T.)
            ENDIF
            loc_oProgresso = .NULL.

            IF USED("cursor_4c_MovTemp")
                USE IN cursor_4c_MovTemp
            ENDIF
            IF USED("cursor_4c_CotCtTemp")
                USE IN cursor_4c_CotCtTemp
            ENDIF
            IF USED("cursor_4c_CotDcTemp")
                USE IN cursor_4c_CotDcTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PossuiAcessoCotacaoLivre - Decide se o botao "Cotacao Livre" aparece.
    * Transcreve fChecaAcesso("SIGMVCOT", "COTSEMOPE") do legado, com pMsg=.F.
    * (o legado usa o retorno so para ligar/desligar o botao, sem avisar).
    *
    * fChecaAcesso EH a funcao original do Framework Fortyus (sigacess.PRG),
    * carregada por config.prg - NAO reimplementar a consulta aqui: o modelo
    * de acesso de SigCdAcu tem a coluna Parametros (nao "Acessos") e concede
    * permissao tanto por usuario quanto por grupo (SigCdAcg), alem do caso
    * do usuario interno com acesso total.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PossuiAcessoCotacaoLivre()
        LOCAL loc_lAcesso, loc_oErro

        loc_lAcesso = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            loc_lAcesso = fChecaAcesso("SIGMVCOT", "COTSEMOPE", .F.)
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar o acesso " + CHR(224) + " Cota" + CHR(231) + ;
                CHR(227) + "o Livre:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lAcesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarCoresGridOperacoes - Transcreve o bloco de SetAll do fim do
    * PROCEDURE processamento legado, que define as cores dinamicas da grade
    * de Movimentacoes. O esquema depende de SigCdPam.gesind (this_nGesind) e,
    * com a gestao industrial ligada, tambem do tipo da operacao corrente
    * (Produc) - exatamente como no original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarCoresGridOperacoes()
        LOCAL loc_oGrid

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes

        IF THIS.this_nGesind = 1
            IF cursor_4c_Movimentacao.Produc <> 1
                loc_oGrid.SetAll("DynamicForeColor", ;
                    "IIF(cursor_4c_Movimentacao.LCancelas, RGB(255,0,0), " + ;
                    "IIF(cursor_4c_Movimentacao.ChkSubn, RGB(0,0,255), RGB(0,0,0)))", ;
                    "Column")

                IF (cursor_4c_Movimentacao.Origems = 1 AND ;
                    INLIST(cursor_4c_Movimentacao.EstOrigs, 1, 2, 4)) OR ;
                   (cursor_4c_Movimentacao.Destinos = 1 AND ;
                    INLIST(cursor_4c_Movimentacao.EstDests, 1, 2, 4))

                    loc_oGrid.SetAll("DynamicBackColor", ;
                        "IIF(cursor_4c_Movimentacao.ProcBals AND " + ;
                        "cursor_4c_Movimentacao.ProcDBal, RGB(220,255,220), " + ;
                        "IIF(cursor_4c_Movimentacao.ProcBals, RGB(255,209,164), " + ;
                        "IIF(cursor_4c_Movimentacao.ProcDBal, RGB(255,255,196), " + ;
                        "IIF(cursor_4c_Movimentacao.ChkPagos, RGB(160,243,231), " + ;
                        "RGB(255,255,255)))))", "Column")
                ENDIF
            ELSE
                loc_oGrid.SetAll("DynamicForeColor", ;
                    "IIF(cursor_4c_Movimentacao.ChkSubn, RGB(0,0,225), " + ;
                    "IIF(cursor_4c_Movimentacao.ChkBxParcs, RGB(255,0,255), " + ;
                    "IIF(cursor_4c_Movimentacao.Nops > 0, RGB(255,0,0), RGB(0,0,0))))", ;
                    "Column")

                loc_oGrid.SetAll("DynamicBackColor", ;
                    "IIF(cursor_4c_Movimentacao.Nops > 0 AND " + ;
                    "(cursor_4c_Movimentacao.ChkSubn OR " + ;
                    "cursor_4c_Movimentacao.ChkBxParcs), RGB(249,249,0), " + ;
                    "RGB(255,255,255))", "Column")
            ENDIF
        ELSE
            loc_oGrid.SetAll("DynamicBackColor", ;
                "IIF(cursor_4c_Movimentacao.ChkPagos, RGB(160,243,231), " + ;
                "RGB(255,255,255))", "Column")

            loc_oGrid.SetAll("DynamicForeColor", ;
                "IIF(cursor_4c_Movimentacao.LCancelas, RGB(255,0,0), " + ;
                "IIF(cursor_4c_Movimentacao.ChkSubn, RGB(0,0,255), " + ;
                "IIF(cursor_4c_Movimentacao.ChkBxParcs, RGB(255,0,255), " + ;
                "RGB(0,0,0))))", "Column")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita os botoes de acao sobre a
    * cotacao corrente. Transcreve as regras do legado, presentes tanto no fim
    * do processamento quanto no AfterRowColChange da grade:
    *
    *   Alterar/Excluir -> so com a cotacao ainda em aberto (Situas = 0)
    *   Copiar          -> so com aprovacao final E do solicitante, e desde
    *                      que a cotacao ainda nao tenha sido copiada
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag, loc_lTemLinha, loc_lEmAberto, loc_lPodeCopiar

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        loc_lTemLinha = USED("cursor_4c_CotasPendentes") AND ;
                        RECCOUNT("cursor_4c_CotasPendentes") > 0 AND ;
                        !EOF("cursor_4c_CotasPendentes")

        IF loc_lTemLinha
            THIS.this_nCodigoSelecionado = cursor_4c_CotasPendentes.Codigos
            loc_lEmAberto = (cursor_4c_CotasPendentes.Situas = 0)

            loc_lPodeCopiar = !EMPTY(cursor_4c_CotasPendentes.DtAprovs) AND ;
                              !EMPTY(cursor_4c_CotasPendentes.Aprovador) AND ;
                              !EMPTY(cursor_4c_CotasPendentes.DtSolics) AND ;
                              !EMPTY(cursor_4c_CotasPendentes.Solicitas) AND ;
                              EMPTY(cursor_4c_CotasPendentes.Copias)
        ELSE
            THIS.this_nCodigoSelecionado = 0
            loc_lEmAberto   = .F.
            loc_lPodeCopiar = .F.
        ENDIF

        loc_oPag.obj_4c_CmdCotacoes.Buttons(1).Enabled = loc_lEmAberto
        loc_oPag.obj_4c_CmdCotacoes.Buttons(2).Enabled = loc_lEmAberto

        IF loc_oPag.obj_4c_CmdCopiar.Visible
            loc_oPag.obj_4c_CmdCopiar.Buttons(1).Enabled = loc_lPodeCopiar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridCotaPendsAfterRowColChange - AfterRowColChange da grade de Cotacoes
    * Realizadas. Handler de BINDEVENT DEVE declarar o parametro do evento.
    *--------------------------------------------------------------------------
    PROCEDURE GridCotaPendsAfterRowColChange(par_nColIndex)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcas* - Coluna de marcacao da grade de Movimentacoes. O legado
    * SUPRIME o toggle nativo do CheckBox (NoDefault em Click/MouseDown/
    * MouseUp) e inverte crOperacoes.Marcas por codigo, para poder validar a
    * regra de Job. Sem os quatro handlers o CheckBox nao alterna.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcasClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcacaoOperacao()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcacaoOperacao()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarMarcacaoOperacao - Inverte a marcacao da movimentacao corrente e
    * aplica a regra do legado: nao se pode marcar, ao mesmo tempo,
    * movimentacoes de JOBS DIFERENTES - nesse caso a marcacao eh desfeita.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarMarcacaoOperacao()
        LOCAL loc_oGrid, loc_cJob

        IF !USED("cursor_4c_Movimentacao") OR EOF("cursor_4c_Movimentacao")
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes

        REPLACE Marcas WITH !Marcas IN cursor_4c_Movimentacao
        loc_oGrid.Refresh()

        IF cursor_4c_Movimentacao.Marcas AND !EMPTY(cursor_4c_Movimentacao.Jobs)
            loc_cJob = cursor_4c_Movimentacao.Jobs

            SELECT EmpDopNums ;
              FROM cursor_4c_Movimentacao ;
             WHERE Marcas AND Jobs <> m.loc_cJob ;
              INTO CURSOR cursor_4c_MarcaJob

            IF !EOF("cursor_4c_MarcaJob")
                MsgAviso("N" + CHR(227) + "o " + CHR(233) + " permitido marcar " + ;
                    "movimenta" + CHR(231) + CHR(227) + "o de jobs diferentes.", "Aviso")
                REPLACE Marcas WITH !Marcas IN cursor_4c_Movimentacao
                loc_oGrid.Refresh()
            ENDIF

            IF USED("cursor_4c_MarcaJob")
                USE IN cursor_4c_MarcaJob
            ENDIF

            SELECT cursor_4c_Movimentacao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarTodasClick / BtnDesmarcarTodasClick - Marcam ou desmarcam todas
    * as movimentacoes (cmdMarcaDesmarca.Click do legado:
    * Update crOperacoes Set Marcas = (This.Value = 1)).
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarTodasClick()
        IF USED("cursor_4c_Movimentacao")
            UPDATE cursor_4c_Movimentacao SET Marcas = .T.
            GO TOP IN cursor_4c_Movimentacao
            THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarTodasClick()
        IF USED("cursor_4c_Movimentacao")
            UPDATE cursor_4c_Movimentacao SET Marcas = .F.
            GO TOP IN cursor_4c_Movimentacao
            THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRetornarFiltrosClick - cmdBotoes.btnSair.Click da pagina Dados:
    * volta para a pagina de Filtros com o foco na data inicial.
    *--------------------------------------------------------------------------
    PROCEDURE BtnRetornarFiltrosClick()
        THIS.this_cModoAtual = "FILTROS"
        THIS.AlternarPagina(1)
        THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * Botoes de acao sobre cotacoes - transcrevem literalmente os Click do
    * legado, que definem o modo de edicao (pcEscolha) e o flag de copia
    * (Copiando) e delegam para GeraCotacao / AlteraCotacao / CopiaCotacao:
    *
    *   BtnIncluirClick       -> cmdCotar.btnProcessar.Click     (INSERIR, da grade)
    *   BtnCotacaoLivreClick  -> cmdProblemas.btnProblemas.Click (INSERIR, sem origem)
    *   BtnAlterarClick       -> cmdCotacoes.btnAlterar.Click    (ALTERAR)
    *   BtnExcluirClick       -> cmdCotacoes.btnExcluir.Click    (EXCLUIR)
    *   BtnVisualizarClick    -> cmdCotacoes1.btnConsultar.Click (CONSULTAR)
    *   BtnCopiarCotacaoClick -> cmdCopiar.btnCopiar.Click       (ALTERAR + Copiando)
    *
    * Os quatro primeiros usam os nomes canonicos do projeto (PILAR 3); as
    * legendas na tela continuam as do legado - "Gerar Cotacoes", "Alterar
    * Cotacao", "Visualizar Cotacao", "Excluir Cotacao" -, que eh o que o
    * PILAR 1 exige. Sao PUBLIC de proposito: o BINDEVENT e o
    * TesteAutomatico.prg chamam de fora da classe (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_cPcEscolha = "INSERIR"
        THIS.this_lCopiando  = .F.
        THIS.GeraCotacao(.T.)
    ENDPROC

    PROCEDURE BtnCotacaoLivreClick()
        THIS.this_cPcEscolha = "INSERIR"
        THIS.this_lCopiando  = .F.
        THIS.GeraCotacao(.F.)
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.this_cPcEscolha = "ALTERAR"
        THIS.this_lCopiando  = .F.
        THIS.AlteraCotacao()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.this_cPcEscolha = "EXCLUIR"
        THIS.this_lCopiando  = .F.
        THIS.AlteraCotacao()
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        THIS.this_cPcEscolha = "CONSULTAR"
        THIS.this_lCopiando  = .F.
        THIS.AlteraCotacao()
    ENDPROC

    PROCEDURE BtnCopiarCotacaoClick()
        THIS.this_cPcEscolha = "ALTERAR"
        THIS.this_lCopiando  = .T.
        THIS.CopiaCotacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * GeraCotacao - Leva para a pagina de Cotacoes uma cotacao NOVA.
    *
    *   par_lDaGrade = .T. -> nasce das movimentacoes MARCADAS na grade (botao
    *                         "Gerar Cotacoes"). O legado exige ao menos uma
    *                         marcada e guarda o Job delas em loObj.Jobs.
    *   par_lDaGrade = .F. -> cotacao sem origem (botao "Cotacao Livre").
    *
    * A montagem das grades de fornecedores/produtos da pagina Cotacoes
    * pertence a ConfigurarPaginaCotacoes/CarregarCotacao, que constroem
    * aquela pagina.
    *--------------------------------------------------------------------------
    PROCEDURE GeraCotacao(par_lDaGrade)
        LOCAL loc_lSucesso, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF par_lDaGrade
            IF !USED("cursor_4c_Movimentacao")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT EmpDopNums, Jobs ;
                  FROM cursor_4c_Movimentacao ;
                 WHERE Marcas ;
                  INTO CURSOR cursor_4c_CotarProds

                GO TOP IN cursor_4c_CotarProds

                IF EOF("cursor_4c_CotarProds")
                    MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada " + ;
                        "Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_cJobs = ALLTRIM(cursor_4c_CotarProds.Jobs)
                ENDIF

                SELECT cursor_4c_Movimentacao
            ENDIF
        ENDIF

        IF loc_lProsseguir
            THIS.this_nCodigoSelecionado = 0
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.PreencherPadroesNovaCotacao(par_lDaGrade)
            THIS.PopularCamposCotacaoNoFormulario()
            THIS.ZerarCursoresCotacao()

            THIS.this_cModoAtual = "COTACOES"
            THIS.AlternarPagina(3)
            THIS.AjustarCamposCotacao()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherPadroesNovaCotacao - Equivalente ao INSERT INTO crSigCtTDc do
    * PROCEDURE geracotacao legado: Solicitas/Comprador = usuario logado,
    * DtSolics = data da movimentacao (ou hoje, se sem origem), DtCotas =
    * hoje, DtValids = hoje + NDdVals (SigOpCdc.Dopes), Prioris = 1 (Normal).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherPadroesNovaCotacao(par_lDaGrade)
        LOCAL loc_oBO, loc_nDias, loc_dDtSolic

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_dDtSolic = DATE()
        IF par_lDaGrade AND USED("cursor_4c_Movimentacao") AND !EOF("cursor_4c_Movimentacao")
            loc_dDtSolic = ConverterParaData(cursor_4c_Movimentacao.Datas)
        ENDIF

        loc_nDias = 0
        IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND !EMPTY(THIS.this_cDopes)
            IF SQLEXEC(gnConnHandle, "SELECT NDdVals FROM SigOpCdc WHERE Dopes = " + ;
                EscaparSQL(PADR(THIS.this_cDopes, 20)), "cursor_4c_NDdValsTmp") > 0 AND ;
               USED("cursor_4c_NDdValsTmp") AND !EOF("cursor_4c_NDdValsTmp")
                loc_nDias = NVL(cursor_4c_NDdValsTmp.NDdVals, 0)
            ENDIF
            IF USED("cursor_4c_NDdValsTmp")
                USE IN cursor_4c_NDdValsTmp
            ENDIF
        ENDIF

        loc_oBO.this_cSolicitas  = gc_4c_UsuarioLogado
        loc_oBO.this_cAprSols    = gc_4c_UsuarioLogado
        loc_oBO.this_cComprador  = gc_4c_UsuarioLogado
        loc_oBO.this_dDtSolics   = loc_dDtSolic
        loc_oBO.this_dDtCotas    = DATE()
        loc_oBO.this_dDtValids   = DATE() + loc_nDias
        loc_oBO.this_nPrioris    = 1
        loc_oBO.this_nChkAprovs  = 0
        loc_oBO.this_nSituas     = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCamposCotacaoNoFormulario - Espelha as propriedades do BO
    * (cabecalho da cotacao) nos controles de Page3/pgfComplCots. Chamado
    * sempre que uma cotacao NOVA/EXISTENTE eh carregada no BO.
    *
    * O espelhamento em si vive em BOParaForm(), que e o par canonico de
    * FormParaBO(); este metodo continua existindo com o nome de origem porque
    * e assim que GeraCotacao e CarregarCotacaoSelecionada o chamam.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PopularCamposCotacaoNoFormulario()
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * ZerarCursoresCotacao - Cotacao NOVA: ZAP dos cursores das grades e uma
    * linha de fornecedor por letra (A..F, Fretes = "Emitente" por padrao) +
    * uma linha de produto em branco - transcrito do INSERT INTO crSigCtTFn/
    * crSigCtTCt do PROCEDURE geracotacao legado (Reccount = 0 -> ramo Else).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ZerarCursoresCotacao()
        LOCAL loc_nI

        IF !USED("cursor_4c_Produtos")
            THIS.CriarCursoresCotacao()
        ENDIF

        ZAP IN cursor_4c_Produtos
        ZAP IN cursor_4c_Fornecedores

        INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
            VALUES (LEFT(fUniqueIds(), 20), 0, 1, "", "", "", 0, "", 0)

        FOR loc_nI = 1 TO 6
            INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, Fretes) ;
                VALUES (LEFT(fUniqueIds(), 20), 0, CHR(64 + loc_nI), "Emitente")
        ENDFOR

        GO TOP IN cursor_4c_Produtos
        GO TOP IN cursor_4c_Fornecedores

        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
            THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
            THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
            THIS.GridCotacoesAfterRowColChange(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlteraCotacao - Leva para a pagina de Cotacoes a cotacao SELECIONADA na
    * grade de Cotacoes Realizadas, nos modos ALTERAR / EXCLUIR / CONSULTAR.
    * Transcreve a guarda do legado (grade vazia ou Codigos < 1 avisa e devolve
    * o foco para a grade) e carrega o cabecalho (SigCtTDc) no BO.
    *--------------------------------------------------------------------------
    PROCEDURE AlteraCotacao()
        LOCAL loc_lSucesso, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF !USED("cursor_4c_CotasPendentes") OR EOF("cursor_4c_CotasPendentes") OR ;
           cursor_4c_CotasPendentes.Codigos < 1
            MsgAviso("Nenhuma Cota" + CHR(231) + CHR(227) + "o Foi Selecionada na Grade!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.pgf_4c_Paginas.Page2.grd_4c_CotaPends.SetFocus()
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            THIS.this_nCodigoSelecionado = cursor_4c_CotasPendentes.Codigos

            IF THIS.CarregarCotacaoSelecionada(THIS.this_nCodigoSelecionado)
                THIS.this_cModoAtual = "COTACOES"
                THIS.AlternarPagina(3)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiaCotacao - Leva para a pagina de Cotacoes uma copia da cotacao
    * selecionada. O legado so libera o botao quando a cotacao ja tem aprovacao
    * final e do solicitante e ainda nao foi copiada (ver AjustarBotoesPorModo);
    * a mesma condicao eh revalidada aqui, porque o botao pode ser acionado por
    * teclado antes de o AfterRowColChange atualizar o estado.
    *--------------------------------------------------------------------------
    PROCEDURE CopiaCotacao()
        LOCAL loc_lSucesso, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF !USED("cursor_4c_CotasPendentes") OR EOF("cursor_4c_CotasPendentes") OR ;
           cursor_4c_CotasPendentes.Codigos < 1
            MsgAviso("Nenhuma Cota" + CHR(231) + CHR(227) + "o Foi Selecionada na Grade!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.pgf_4c_Paginas.Page2.grd_4c_CotaPends.SetFocus()
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF !EMPTY(cursor_4c_CotasPendentes.Copias)
                MsgAviso("Esta Cota" + CHR(231) + CHR(227) + "o J" + CHR(225) + ;
                    " Foi Copiada!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            IF EMPTY(cursor_4c_CotasPendentes.DtAprovs) OR ;
               EMPTY(cursor_4c_CotasPendentes.Aprovador) OR ;
               EMPTY(cursor_4c_CotasPendentes.DtSolics) OR ;
               EMPTY(cursor_4c_CotasPendentes.Solicitas)
                MsgAviso("A Cota" + CHR(231) + CHR(227) + "o Ainda N" + CHR(227) + ;
                    "o Foi Aprovada!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            THIS.this_nCodigoSelecionado = cursor_4c_CotasPendentes.Codigos

            IF THIS.CarregarCotacaoSelecionada(THIS.this_nCodigoSelecionado)
                THIS.this_cModoAtual = "COTACOES"
                THIS.AlternarPagina(3)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacaoSelecionada - Le o cabecalho da cotacao (SigCtTDc) e o
    * entrega ao Business Object. Equivale ao primeiro bloco do PROCEDURE
    * alteracotacao legado (SqlExecute + Scatter/Insert em crSigCtTDc), aqui
    * com o cabecalho vivendo nas propriedades do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCotacaoSelecionada(par_nCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT * FROM SigCtTDc WHERE Codigos = " + ;
                       FormatarNumeroSQL(par_nCodigo, 0) + " ORDER BY Codigos"

            IF USED("cursor_4c_CotacaoAtual")
                USE IN cursor_4c_CotacaoAtual
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacaoAtual")

            IF loc_nResultado < 1
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o (Cota" + CHR(231) + CHR(227) + "o)")
            ELSE
                SELECT cursor_4c_CotacaoAtual
                GO TOP IN cursor_4c_CotacaoAtual

                IF EOF("cursor_4c_CotacaoAtual")
                    MsgAviso("Cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                        "o encontrada: " + ALLTRIM(TRANSFORM(par_nCodigo)), ;
                        "Aten" + CHR(231) + CHR(227) + "o!!!")
                ELSE
                    THIS.this_oBusinessObject.EditarRegistro()
                    loc_lSucesso = ;
                        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_CotacaoAtual")

                    IF loc_lSucesso
                        THIS.CarregarItensEFornecedoresCotacao(par_nCodigo)
                        THIS.PopularCamposCotacaoNoFormulario()
                        THIS.AjustarCamposCotacao()
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_CotacaoAtual")
                USE IN cursor_4c_CotacaoAtual
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCotacaoSelecionada")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItensEFornecedoresCotacao - Le SigCtTCt/SigCtTFn da cotacao
    * <par_nCodigo> para cursor_4c_Produtos/cursor_4c_Fornecedores (equivalente
    * ao SELECT * ... Order By Codigos, CItens/Grades do PROCEDURE
    * alteracotacao legado - aqui usado tanto por Alterar quanto Consultar/
    * Excluir, ja que a estrutura de carga eh identica).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarItensEFornecedoresCotacao(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado

        IF !USED("cursor_4c_Produtos")
            THIS.CriarCursoresCotacao()
        ENDIF

        ZAP IN cursor_4c_Produtos
        ZAP IN cursor_4c_Fornecedores

        loc_cSQL = "SELECT * FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
            " ORDER BY Codigos, CItens"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp")

        IF loc_nResultado > 0 AND USED("cursor_4c_ProdutosTemp")
            SELECT cursor_4c_ProdutosTemp
            SCAN
                INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, CUnis, CodCors, CodTams, ;
                        EmpDopNums, Obs, Justificas, Qtds, QtdAdqs, ValAdqs, ;
                        Marca01, Marca02, Marca03, Marca04, Marca05, Marca06, ;
                        Unit01, Unit02, Unit03, Unit04, Unit05, Unit06, ;
                        Tota01, Tota02, Tota03, Tota04, Tota05, Tota06) ;
                    VALUES (cursor_4c_ProdutosTemp.cIdChaves, cursor_4c_ProdutosTemp.Codigos, ;
                        cursor_4c_ProdutosTemp.CItens, ALLTRIM(cursor_4c_ProdutosTemp.CPros), ;
                        ALLTRIM(cursor_4c_ProdutosTemp.DPros), ALLTRIM(cursor_4c_ProdutosTemp.CUnis), ;
                        ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodCors, "")), ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodTams, "")), ;
                        ALLTRIM(NVL(cursor_4c_ProdutosTemp.EmpDopNums, "")), NVL(cursor_4c_ProdutosTemp.Obs, ""), ;
                        NVL(cursor_4c_ProdutosTemp.Justificas, ""), cursor_4c_ProdutosTemp.Qtds, ;
                        cursor_4c_ProdutosTemp.QtdAdqs, cursor_4c_ProdutosTemp.ValAdqs, ;
                        ConverterParaLogico(cursor_4c_ProdutosTemp.Marca01), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca02), ;
                        ConverterParaLogico(cursor_4c_ProdutosTemp.Marca03), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca04), ;
                        ConverterParaLogico(cursor_4c_ProdutosTemp.Marca05), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca06), ;
                        cursor_4c_ProdutosTemp.Unit01, cursor_4c_ProdutosTemp.Unit02, cursor_4c_ProdutosTemp.Unit03, ;
                        cursor_4c_ProdutosTemp.Unit04, cursor_4c_ProdutosTemp.Unit05, cursor_4c_ProdutosTemp.Unit06, ;
                        cursor_4c_ProdutosTemp.Tota01, cursor_4c_ProdutosTemp.Tota02, cursor_4c_ProdutosTemp.Tota03, ;
                        cursor_4c_ProdutosTemp.Tota04, cursor_4c_ProdutosTemp.Tota05, cursor_4c_ProdutosTemp.Tota06)
            ENDSCAN
            USE IN cursor_4c_ProdutosTemp
        ENDIF

        *-- Sem linhas (nao deveria acontecer, mas o legado sempre garante ao
        *-- menos 1 linha para a grade nao ficar sem cursor posicionavel)
        IF RECCOUNT("cursor_4c_Produtos") < 1
            INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
                VALUES (LEFT(fUniqueIds(), 20), par_nCodigo, 1, "", "", "", 0, "", 0)
        ENDIF

        loc_cSQL = "SELECT * FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
            " ORDER BY Codigos, Grades"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornecTemp")

        IF loc_nResultado > 0 AND USED("cursor_4c_FornecTemp")
            SELECT cursor_4c_FornecTemp
            SCAN
                INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, IClis, Fornecs, Contatos, ;
                        Tel1s, FPags, DtEnts, Fretes, VlFretes) ;
                    VALUES (cursor_4c_FornecTemp.cIdChaves, cursor_4c_FornecTemp.Codigos, cursor_4c_FornecTemp.Grades, ;
                        ALLTRIM(cursor_4c_FornecTemp.IClis), ALLTRIM(cursor_4c_FornecTemp.Fornecs), ;
                        ALLTRIM(cursor_4c_FornecTemp.Contatos), ALLTRIM(cursor_4c_FornecTemp.Tel1s), ;
                        ALLTRIM(cursor_4c_FornecTemp.FPags), ConverterParaData(NVL(cursor_4c_FornecTemp.DtEnts, {})), ;
                        ALLTRIM(NVL(cursor_4c_FornecTemp.Fretes, "Emitente")), NVL(cursor_4c_FornecTemp.VlFretes, 0))
            ENDSCAN
            USE IN cursor_4c_FornecTemp
        ENDIF

        GO TOP IN cursor_4c_Produtos
        GO TOP IN cursor_4c_Fornecedores

        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
            THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
            THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
            THIS.GridCotacoesAfterRowColChange(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Recolhe para o BusinessObject (cabecalho SigCtTDc) o que
    * esta NOS CONTROLES da pagina de Cotacoes (Page3 + pgf_4c_ComplCots).
    *
    * Override do hook PROTECTED de FormBase (formbase.prg:285), que o
    * FormBase.Salvar() ja chama antes do BO.Salvar(). PROTECTED e obrigatorio
    * aqui: o escopo vem da classe pai, entao declarar sem o modificador nao
    * torna o metodo publico - so esconde do leitor que ele nao e chamavel de
    * fora da classe (chamada externa estoura "Property FORMPARABO is not
    * found", mesmo com PEMSTATUS devolvendo .T. - CLAUDE.md regra #3).
    *
    * No legado cada um desses campos tem ControlSource apontando direto para
    * crSigCtTDc, entao o que o usuario digitou ja esta no cursor quando o
    * btnGravaDados dispara. Aqui nao ha ControlSource: os Validar<X> so
    * escrevem no BO quando o campo perde o foco ou recebe Enter/Tab. Sem esta
    * varredura, o que foi digitado e gravado direto no botao (sem sair do
    * campo) - data de cotacao/validade/pagamento, prioridade, departamento -
    * se perderia em silencio. Chamado por GravaDados antes do Salvar().
    *
    * NAO recolhe os campos abaixo, de proposito - o dono deles e outro:
    *   this_cCidChaves / this_nCodigos - gerados pelo BO no primeiro Inserir
    *                                     (os TextBox sao ReadOnly, exibicao)
    *   this_nCopias                    - definido por CopiaCotacao (ReadOnly)
    *   this_nSituas                    - definido por GravaPedidos
    *   this_nLocalEnts                 - definido pelo dialogo SigCdEnd
    *   this_nChkAprovs                 - flag da maquina de aprovacao. Quem
    *                                     manda nele sao ChkAprovadorClick e
    *                                     AprovarCotacao, que o ZERAM no BO e
    *                                     so DEPOIS de GravaDados zeram o
    *                                     CheckBox (ordem transcrita do
    *                                     legado). Le-lo aqui desfaria esse
    *                                     zero e gravaria como aprovada uma
    *                                     cotacao que a validacao recusou.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPag, loc_oAdic, loc_oApr, loc_oSol

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "txt_4c_Codigos", 5)
            RETURN .F.
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page3

        loc_oBO.this_cSolicitas = ALLTRIM(loc_oPag.txt_4c_Solicitas.Value)
        loc_oBO.this_cDeptos    = ALLTRIM(loc_oPag.txt_4c_Deptos.Value)
        loc_oBO.this_cComprador = ALLTRIM(loc_oPag.txt_4c_Comprador.Value)
        loc_oBO.this_dDtSolics  = ConverterParaData(loc_oPag.txt_4c_DtSolics.Value)
        loc_oBO.this_dDtCotas   = ConverterParaData(loc_oPag.txt_4c_DtCotas.Value)
        loc_oBO.this_dDtValids  = ConverterParaData(loc_oPag.txt_4c_DtValids.Value)
        loc_oBO.this_dDtPagtos  = ConverterParaData(loc_oPag.txt_4c_DtPagtos.Value)
        loc_oBO.this_nPrioris   = MAX(loc_oPag.cbo_4c_Prioris.ListIndex, 1)

        *-- O Aprovador do cabecalho (txt_4c_AprovadorCab) e ReadOnly, so
        *-- espelho: o campo editavel e o da aba Aprovacao, lido logo abaixo.
        IF PEMSTATUS(loc_oPag, "pgf_4c_ComplCots", 5)
            loc_oAdic = loc_oPag.pgf_4c_ComplCots.Page1
            loc_oApr  = loc_oPag.pgf_4c_ComplCots.Page2
            loc_oSol  = loc_oPag.pgf_4c_ComplCots.Page3

            loc_oBO.this_cContaEs    = ALLTRIM(loc_oAdic.txt_4c_ContaEs.Value)
            loc_oBO.this_cDContaEs   = ALLTRIM(loc_oAdic.txt_4c_DContaEs.Value)
            loc_oBO.this_cJustificas = loc_oAdic.obj_4c_GetJustGeral.Value

            loc_oBO.this_cAprovador  = ALLTRIM(loc_oApr.txt_4c_Aprovador.Value)
            loc_oBO.this_dDtAprovs   = ConverterParaData(loc_oApr.txt_4c_DtAprovs.Value)
            loc_oBO.this_cObsAprovs  = loc_oApr.obj_4c_GetObsAprovs.Value

            loc_oBO.this_cAprSols    = ALLTRIM(loc_oSol.txt_4c_AprSols.Value)
            loc_oBO.this_dDtAprSols  = ConverterParaData(loc_oSol.txt_4c_DtAprSols.Value)
            loc_oBO.this_cObsAprSols = loc_oSol.obj_4c_GetObsAprSols.Value
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Caminho inverso de FormParaBO: espelha as propriedades do
    * cabecalho da cotacao (SigCtTDc, no BusinessObject) nos controles da
    * pagina de Cotacoes. E o que o legado obtem de graca pelo ControlSource
    * ligado a crSigCtTDc. Chamado sempre que uma cotacao NOVA ou EXISTENTE e
    * carregada no BO (GeraCotacao / AlteraCotacao / CopiaCotacao, atraves de
    * PopularCamposCotacaoNoFormulario) e depois do Salvar(), para o Codigo
    * recem-gerado aparecer na tela.
    *
    * this_cDContaEs e a unica descricao de lookup com controle proprio; as
    * demais (this_cDComprador/DDeptos/DSolicitas/DAprovador/DAprSols) nao tem
    * TextBox na tela - o legado tambem so exibe o codigo nesses campos.
    *
    * Override do hook PROTECTED de FormBase (formbase.prg:280) - ver a nota
    * de escopo em FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPag, loc_oAdic, loc_oApr, loc_oSol

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "txt_4c_Codigos", 5)
            RETURN .F.
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page3

        loc_oPag.txt_4c_Codigos.Value       = TRANSFORM(loc_oBO.this_nCodigos)
        loc_oPag.txt_4c_Solicitas.Value     = loc_oBO.this_cSolicitas
        loc_oPag.txt_4c_Deptos.Value        = loc_oBO.this_cDeptos
        loc_oPag.txt_4c_Comprador.Value     = loc_oBO.this_cComprador
        loc_oPag.txt_4c_AprovadorCab.Value  = loc_oBO.this_cAprovador
        loc_oPag.txt_4c_DtSolics.Value      = loc_oBO.this_dDtSolics
        loc_oPag.txt_4c_DtCotas.Value       = loc_oBO.this_dDtCotas
        loc_oPag.txt_4c_DtValids.Value      = loc_oBO.this_dDtValids
        loc_oPag.txt_4c_DtPagtos.Value      = loc_oBO.this_dDtPagtos
        loc_oPag.txt_4c_Copias.Value        = loc_oBO.this_nCopias
        loc_oPag.cbo_4c_Prioris.ListIndex   = MAX(loc_oBO.this_nPrioris, 1)
        THIS.AtualizarCorPrioridade()

        IF PEMSTATUS(loc_oPag, "pgf_4c_ComplCots", 5)
            loc_oAdic = loc_oPag.pgf_4c_ComplCots.Page1
            loc_oApr  = loc_oPag.pgf_4c_ComplCots.Page2
            loc_oSol  = loc_oPag.pgf_4c_ComplCots.Page3

            loc_oAdic.txt_4c_ContaEs.Value        = loc_oBO.this_cContaEs
            loc_oAdic.txt_4c_DContaEs.Value       = loc_oBO.this_cDContaEs
            loc_oAdic.obj_4c_GetJustGeral.Value   = loc_oBO.this_cJustificas

            loc_oApr.txt_4c_Aprovador.Value       = loc_oBO.this_cAprovador
            loc_oApr.txt_4c_DtAprovs.Value        = loc_oBO.this_dDtAprovs
            loc_oApr.obj_4c_GetObsAprovs.Value    = loc_oBO.this_cObsAprovs
            loc_oApr.chk_4c_ChkAprovador.Value    = loc_oBO.this_nChkAprovs

            loc_oSol.txt_4c_AprSols.Value         = loc_oBO.this_cAprSols
            loc_oSol.txt_4c_DtAprSols.Value       = loc_oBO.this_dDtAprSols
            loc_oSol.obj_4c_GetObsAprSols.Value   = loc_oBO.this_cObsAprSols
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar/Abandonar da pagina CORRENTE. No legado cada
    * pagina tem o seu proprio cmdBotoes.btnSair, e todos fazem a mesma coisa:
    * abandonar o que esta em edicao e VOLTAR UMA PAGINA (a de Filtros, que e a
    * primeira, encerra o form). Este metodo e o ponto unico de entrada desse
    * comportamento - cada botao da tela continua ligado ao seu handler
    * especifico, com a legenda e o foco que o legado define para ele:
    *
    *   Page4 Pedidos  -> BtnRetornarCotacoesClick (confirma, cancela, vai p/ 3)
    *   Page3 Cotacoes -> BtnSairCotacoesClick     (confirma, cancela, vai p/ 2)
    *   Page2 Dados    -> BtnRetornarFiltrosClick  (volta para os filtros)
    *   Page1 Filtros  -> BtnSairClick             (encerra o form)
    *
    * A confirmacao ("Deseja Realmente Abandonar as Alteracoes?") e o
    * CancelarEdicao() do BO ficam nos handlers de Page3/Page4, que sao as
    * paginas onde ha edicao em curso - exatamente como no legado, onde so
    * esses dois btnSair perguntam antes do RollBack.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_nPagina

        loc_nPagina = THIS.pgf_4c_Paginas.ActivePage

        DO CASE
            CASE loc_nPagina = 4
                THIS.BtnRetornarCotacoesClick()
            CASE loc_nPagina = 3
                THIS.BtnSairCotacoesClick()
            CASE loc_nPagina = 2
                THIS.BtnRetornarFiltrosClick()
            OTHERWISE
                THIS.BtnSairClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis, recursivamente, todos os
    * controles filhos (Pages de PageFrame + Controls de Container). AddObject
    * cria os controles com Visible=.F. por padrao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - FormBase.Destroy() cuida da liberacao do BusinessObject e da
    * restauracao dos popups do menu (Erro58). DODEFAULT() SEMPRE por ultimo.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
