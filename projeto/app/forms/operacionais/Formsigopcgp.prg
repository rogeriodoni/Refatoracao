*============================================================
* Formsigopcgp.prg
* Pesquisa Global de Produtos (SIGOPCGP)
* Tipo: OPERACIONAL - layout customizado com grids e containers
* Fase 3/8: Estrutura Base
*============================================================
DEFINE CLASS Formsigopcgp AS FormBase

  Height      = 614
  Width       = 1000
  Caption     = "Pesquisa Global de Produtos"
  AutoCenter  = .T.
  BorderStyle = 2
  TitleBar    = 0
  DataSession = 2
  ShowWindow = 1
  WindowType = 1
  KeyPreview  = .T.

  *-- Propriedades de estado
  this_oBusinessObject    = .NULL.
  this_cModoAtual         = "CONSULTA"
  this_cMensagemErro      = ""
  this_lPrimeira          = .T.
  this_lConsultaExecutada = .F.
  this_lAlteraPreco       = .F.
  this_cPrompt            = ""
  this_nTpcalcp           = 0
  this_nEmpresa           = 0
  this_cGrupo             = ""
  this_cSubGrupo          = ""
  this_cFornecedor        = ""
  this_cOrigem            = "T"
  this_nTipoCalculo       = 0
  this_lExibeInativos     = .F.
  this_lExibeCompostos    = .F.
  this_cCodPesq           = ""
  this_cDesPesq           = ""
  this_nPageAtual         = 1

  *------------------------------------------------------------
  PROCEDURE Init
    RETURN DODEFAULT()
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE InicializarForm
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    TRY
      THIS.this_oBusinessObject = CREATEOBJECT("sigopcgpBO")
      IF VARTYPE(THIS.this_oBusinessObject) = "O"
        THIS.this_cPrompt = THIS.Caption
        THIS.InicializarCursores()
        THIS.ConfigurarPageFrame()
        THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
        BINDEVENT(THIS.pgf_4c_1.Page1.grp_4c_Operacao,       "Click", THIS, "GrpOperacaoClick")
        BINDEVENT(THIS.pgf_4c_1.Page1.grp_4c_LimparFiltros,  "Click", THIS, "GrpLimparFiltrosClick")

        *-- Grid AfterRowColChange para carregar detalhes do produto selecionado
        BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos, ;
          "AfterRowColChange", THIS, "GrdProdutosAfterRowColChange")

        *-- Inicializar combos de filtro
        THIS.PopularCombos()
        *-- Criar botao Voltar na pagina de resultado
        THIS.ConfigurarBtnVoltar()
        BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        *-- Carregar dados iniciais dos grids de filtro
        THIS.CarregarCaracteristicas()
        THIS.CarregarTiposOperacao()

        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio.", "Erro")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao inicializar: " + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPageFrame
    *-- PageFrame principal (fld_principal) - 2 paginas: Consulta e Resultado
    THIS.AddObject("pgf_4c_1", "PageFrame")
    WITH THIS.pgf_4c_1
      .Top         = 0
      .Left        = 0
      .Width       = 1005
      .Height      = 616
      .PageCount   = 2
      .Tabs        = .F.
    ENDWITH

    THIS.ConfigurarPaginaConsulta()
    THIS.ConfigurarPaginaLista()
    THIS.ConfigurarPaginaResultado()
    THIS.ConfigurarPaginaDados()

    THIS.pgf_4c_1.Visible = .T.
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPaginaConsulta
    *-- Page1 = pagina de filtros/consulta
    WITH THIS.pgf_4c_1.Page1
      .Caption   = ""
      .BackColor = RGB(236, 233, 216)

      *-- Container titulo (cntSombra) - barra de titulo azul
      .AddObject("cnt_4c_Sombra", "Container")
      WITH .cnt_4c_Sombra
        .Top         = 0
        .Left        = 0
        .Width       = THIS.Width
        .Height      = 28
        .BackColor   = RGB(0, 0, 128)
        .BorderWidth = 0
        .Visible     = .T.

        .AddObject("lbl_4c_Titulo", "Label")
        WITH .lbl_4c_Titulo
          .Top       = 4
          .Left      = 4
          .Width     = THIS.Width
          .Height    = 20
          .Caption   = "Pesquisa Global de Produtos"
          .FontName  = "Tahoma"
          .FontSize  = 10
          .FontBold  = .T.
          .ForeColor = RGB(255, 255, 255)
          .BackStyle = 0
          .AutoSize  = .F.
        ENDWITH
      ENDWITH

      *-- CommandGroup de operacoes (grp_operacao): Consultar + Cancelar
      .AddObject("grp_4c_Operacao", "CommandGroup")
      WITH .grp_4c_Operacao
        .Top         = -3
        .Left        = 844
        .Height      = 85
        .Width       = 160
        .ButtonCount = 2
        .BorderStyle = 0
        .Visible     = .T.
      ENDWITH

      WITH .grp_4c_Operacao.Buttons(1)
        .Caption     = "\<Consultar"
        .Top         = 5
        .Left        = 5
        .Width       = 75
        .Height      = 75
        .FontName    = "Comic Sans MS"
        .FontSize    = 8
        .FontBold    = .T.
        .FontItalic  = .T.
        .ToolTipText = "Consultar Usando os Filtros Informados"
      ENDWITH

      WITH .grp_4c_Operacao.Buttons(2)
        .Caption     = "Encerrar"
        .Top         = 5
        .Left        = 80
        .Width       = 75
        .Height      = 75
        .FontName    = "Comic Sans MS"
        .FontSize    = 8
        .FontBold    = .T.
        .FontItalic  = .T.
        .Cancel      = .T.
        .ToolTipText = "[ESC] Sair"
      ENDWITH

      *-- Botao Limpar Filtros (Commandgroup1 do legado)
      .AddObject("grp_4c_LimparFiltros", "CommandGroup")
      WITH .grp_4c_LimparFiltros
        .Top         = 36
        .Left        = 839
        .Width       = 75
        .Height      = 40
        .ButtonCount = 1
        .BorderStyle = 0
        .Visible     = .T.
      ENDWITH
      WITH .grp_4c_LimparFiltros.Buttons(1)
        .Top         = 3
        .Left        = 3
        .Width       = 40
        .Height      = 34
        .Caption     = ""
        .ToolTipText = "Limpar os Campos dos Filtros"
      ENDWITH

      *-- PageFrame de filtros (Filtro) - PageCount=1, Top=-25
      .AddObject("pgf_4c_Filtro", "PageFrame")
      WITH .pgf_4c_Filtro
        .Top         = -25
        .Left        = 0
        .Width       = 1005
        .Height      = 641
        .PageCount   = 1
        .Tabs        = .F.
      ENDWITH

      WITH .pgf_4c_Filtro.Page1
        .Caption   = ""
        .BackColor = RGB(236, 233, 216)
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPaginaResultado
    *-- Page2 = pagina de resultados com 6 sub-paginas
    WITH THIS.pgf_4c_1.Page2
      .Caption   = ""
      .BackColor = RGB(236, 233, 216)

      *-- Label TxtCaption (legenda da consulta)
      .AddObject("lbl_4c_TxtCaption", "Label")
      WITH .lbl_4c_TxtCaption
        .Top       = 0
        .Left      = 0
        .Width     = 1000
        .Height    = 17
        .Caption   = ""
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
        .ForeColor = RGB(0, 0, 0)
        .AutoSize  = .F.
      ENDWITH

      *-- PageFrame de resultados (Result) - 6 sub-paginas com abas
      .AddObject("pgf_4c_Result", "PageFrame")
      WITH .pgf_4c_Result
        .Top         = 17
        .Left        = 0
        .Width       = 1000
        .Height      = 590
        .PageCount   = 6
        .Tabs        = .T.
      ENDWITH

      *-- PageOrder 1: Selecao/Filtro Produtos
      WITH .pgf_4c_Result.Page1
        .Caption   = "Sele" + CHR(231) + CHR(227) + "o"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 2: Custo
      WITH .pgf_4c_Result.Page2
        .Caption   = "Custo"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 3: Composicao
      WITH .pgf_4c_Result.Page3
        .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 4: Estoque/Historico
      WITH .pgf_4c_Result.Page4
        .Caption   = "Estoque/Hist" + CHR(243) + "rico"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 5: Industria/Fase
      WITH .pgf_4c_Result.Page5
        .Caption   = "Ind" + CHR(250) + "stria/Fase"
        .BackColor = RGB(236, 233, 216)
      ENDWITH

      *-- PageOrder 6: Estoque/Etiquetas
      WITH .pgf_4c_Result.Page6
        .Caption   = "Estoque/Etiquetas"
        .BackColor = RGB(236, 233, 216)
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE InicializarCursores
    *-- Validacao de UI nao executa SQL - apenas cria placeholders
    IF NOT USED("cursor_4c_Dados")
      SET NULL ON
      CREATE CURSOR cursor_4c_Dados ;
        (cpros  C(15), dpros  C(60), cgrus  C(5),  ;
         dgrus  C(40), cmoes  C(3),  price  N(18,4),;
         qatua  N(18,4), ativo L)
      SET NULL OFF
    ENDIF

    IF NOT USED("CsMatPrima")
      SET NULL ON
      CREATE CURSOR CsMatPrima ;
        (mats C(15), dcompos C(60), qtd_inicial N(18,4), ;
         qtd_final N(18,4), apenas L, Cgrus C(5), Tipos C(10))
      SET NULL OFF
    ENDIF

    IF NOT USED("cursor_4c_Caract")
      SET NULL ON
      CREATE CURSOR cursor_4c_Caract ;
        (marcado L, cods C(5), descs C(40))
      SET NULL OFF
    ENDIF

    IF NOT USED("cursor_4c_TOpe")
      SET NULL ON
      CREATE CURSOR cursor_4c_TOpe ;
        (marcado L, ctipo C(5), dtipo C(40))
      SET NULL OFF
    ENDIF

    IF NOT USED("CrSigMvHst")
      SET NULL ON
      CREATE CURSOR CrSigMvHst ;
        (cpros C(15), dtmov D, qtmov N(18,4), vlmov N(18,4))
      SET NULL OFF
    ENDIF

    IF NOT USED("CsEtiqueta")
      SET NULL ON
      CREATE CURSOR CsEtiqueta ;
        (cpros C(15), dpros C(60), qetiq N(18,4))
      SET NULL OFF
    ENDIF

    IF NOT USED("CsFase")
      SET NULL ON
      CREATE CURSOR CsFase ;
        (cpros C(15), cfases C(5), dfases C(40))
      SET NULL OFF
    ENDIF

    IF NOT USED("CrProdutos")
      SET NULL ON
      CREATE CURSOR CrProdutos (cpros C(15), dpros C(60))
      SET NULL OFF
    ENDIF
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE CarregarDados
    THIS.BtnConsultarClick()
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE BtnConsultarClick
    LOCAL loc_oPag, loc_oFiltros, loc_lSucesso, loc_cCaption
    LOCAL loc_cPesoI, loc_cPesoF, loc_cCustoI, loc_cCustoF

    loc_oPag     = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_lSucesso = .F.

    TRY
      *-- Cria objeto de filtros
      loc_oFiltros = CREATEOBJECT("Empty")

      *-- Produto / Descricao
      ADDPROPERTY(loc_oFiltros, "cProdutoInicial",     ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value))
      ADDPROPERTY(loc_oFiltros, "cProdutoFinal",       ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value))
      ADDPROPERTY(loc_oFiltros, "cDescricao",          ALLTRIM(loc_oPag.txt_4c_Descricao.Value))
      ADDPROPERTY(loc_oFiltros, "cDescritivo",         ALLTRIM(loc_oPag.txt_4c_Descritivo.Value))

      *-- Equivalente (so usa se checkbox marcado)
      ADDPROPERTY(loc_oFiltros, "cEquivalente", ;
        IIF(loc_oPag.chk_4c_Equiv.Value = 1, ALLTRIM(loc_oPag.txt_4c_Equiv.Value), ""))

      *-- Grupo / SubGrupo / Grande Grupo
      ADDPROPERTY(loc_oFiltros, "cGrandeGrupoCod",     ALLTRIM(loc_oPag.txt_4c_Gde.Value))
      ADDPROPERTY(loc_oFiltros, "cGrupoCod",           ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value))
      ADDPROPERTY(loc_oFiltros, "cSubgrupoCod",        ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value))

      *-- Linha / Colecao
      ADDPROPERTY(loc_oFiltros, "cLinha",              ALLTRIM(loc_oPag.txt_4c_LinhaI.Value))
      ADDPROPERTY(loc_oFiltros, "cLinha2",             ALLTRIM(loc_oPag.txt_4c_LinhaF.Value))
      ADDPROPERTY(loc_oFiltros, "cColuna",             ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value))
      ADDPROPERTY(loc_oFiltros, "cColuna2",            ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value))

      *-- Fornecedor / Referencia
      ADDPROPERTY(loc_oFiltros, "cFornecedorCod",      ALLTRIM(loc_oPag.txt_4c_CdFornec.Value))
      ADDPROPERTY(loc_oFiltros, "cRefFornecedor",      ALLTRIM(loc_oPag.txt_4c_RefFornec.Value))
      ADDPROPERTY(loc_oFiltros, "cRefFornecedorFinal", ALLTRIM(loc_oPag.txt_4c_RefFornecF.Value))
      ADDPROPERTY(loc_oFiltros, "nOptTipoRef",         loc_oPag.opt_4c_TpReffs.Value)

      *-- Cor / Faixa Valor / Classificacao
      ADDPROPERTY(loc_oFiltros, "cCorCod",             ALLTRIM(loc_oPag.txt_4c_Cor.Value))
      ADDPROPERTY(loc_oFiltros, "cFxPreco",            ALLTRIM(loc_oPag.txt_4c_FxPreco.Value))
      ADDPROPERTY(loc_oFiltros, "cClassificacao",      ALLTRIM(loc_oPag.txt_4c_Classe.Value))

      *-- Lista de Precos / Promocao
      ADDPROPERTY(loc_oFiltros, "cListaPrecos",        ALLTRIM(loc_oPag.txt_4c_Lista.Value))
      ADDPROPERTY(loc_oFiltros, "cPromocao",           ALLTRIM(loc_oPag.txt_4c_Promo.Value))

      *-- Situacao / Imagem (0=Todos)
      ADDPROPERTY(loc_oFiltros, "nSituacao",           loc_oPag.cmb_4c_Situas.ListIndex)
      ADDPROPERTY(loc_oFiltros, "nImagem",             loc_oPag.cmb_4c_Imagem.ListIndex)

      *-- Pesos (converte string com mascara para numero)
      loc_cPesoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoI.Value), ",", "")
      loc_cPesoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoF.Value), ",", "")
      ADDPROPERTY(loc_oFiltros, "nPesoInicial", VAL(loc_cPesoI))
      ADDPROPERTY(loc_oFiltros, "nPesoFinal",   VAL(loc_cPesoF))

      *-- Custo
      loc_cCustoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoI.Value), ",", "")
      loc_cCustoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoF.Value), ",", "")
      ADDPROPERTY(loc_oFiltros, "nCustoInicial", VAL(loc_cCustoI))
      ADDPROPERTY(loc_oFiltros, "nCustoFinal",   VAL(loc_cCustoF))
      ADDPROPERTY(loc_oFiltros, "cMoedaCusto",   ALLTRIM(loc_oPag.txt_4c_MoeCusto.Value))

      *-- Datas (CTOD("") retorna {} - data vazia segura)
      ADDPROPERTY(loc_oFiltros, "dDataAltInicial", CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltI.Value)))
      ADDPROPERTY(loc_oFiltros, "dDataAltFinal",   CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltF.Value)))

      *-- Executa busca no BO
      THIS.MousePointer = 11

      loc_lSucesso = THIS.this_oBusinessObject.BuscarProdutos(loc_oFiltros)

      THIS.MousePointer = 0

      IF loc_lSucesso AND USED("cursor_4c_Produtos")
        *-- Transfere resultados para CrProdutos (RecordSource do grid)
        THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.RecordSource = ""

        IF USED("CrProdutos")
          SELECT CrProdutos
          ZAP IN CrProdutos
        ENDIF

        IF RECCOUNT("cursor_4c_Produtos") > 0
          SELECT CrProdutos
          APPEND FROM DBF("cursor_4c_Produtos") FIELDS cpros, dpros
        ENDIF

        THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.RecordSource = "CrProdutos"
        SELECT CrProdutos
        IF !EOF()
          GO TOP
        ENDIF
        THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.Refresh()

        *-- Atualiza legenda e navega para pagina de resultado
        loc_cCaption = THIS.this_cPrompt
        THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = loc_cCaption
        THIS.this_lConsultaExecutada                   = .T.

        THIS.AlternarPagina(2)
      ELSE
        THIS.MousePointer = 0
        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
          MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
        ELSE
          MsgAviso("Nenhum produto encontrado com os filtros informados.")
        ENDIF
      ENDIF

    CATCH TO loc_oErro
      THIS.MousePointer = 0
      MsgErro("Erro na consulta: " + loc_oErro.Message, "Erro")
    ENDTRY

    loc_oFiltros = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- BtnCancelarClick: cancela edicao de preco (restaura ReadOnly nos campos de preco)
  PROCEDURE BtnCancelarClick
    LOCAL loc_oCab
    TRY
      loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
      loc_oCab.txt_4c_PrVendaR.ReadOnly   = .T.
      loc_oCab.txt_4c_MoePrVR.ReadOnly    = .T.
      loc_oCab.txt_4c_PesoMedioR.ReadOnly = .T.
      loc_oCab.txt_4c_FatorVR.ReadOnly    = .T.
      loc_oCab.txt_4c_MoeFatorR.ReadOnly  = .T.
      loc_oCab = .NULL.
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_Cabecalho pode nao estar instanciado ainda; ReadOnly e melhor-esforco
    ENDTRY
    THIS.AjustarBotoesPorModo()
  ENDPROC

  *------------------------------------------------------------
  *-- TornarControlesVisiveis: exclui containers flutuantes (Visible=.F.)
  PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_j, loc_oCtrl, loc_cNome
    IF VARTYPE(par_oContainer) # "O"
      RETURN
    ENDIF
    FOR loc_i = 1 TO par_oContainer.ControlCount
      loc_oCtrl = par_oContainer.Controls(loc_i)
      loc_cNome = UPPER(loc_oCtrl.Name)

      *-- Containers flutuantes permanecem Visible=.F. (mostrados via botoes)
      IF INLIST(loc_cNome, ;
          "CNT_4C_PRECO",    ;
          "CNT_4C_ZOOM",     ;
          "CNT_4C_FILTROS",  ;
          "CNT_4C_ETIQUETA", ;
          "CNT_4C_DETALHE")
        LOOP
      ENDIF

      loc_oCtrl.Visible = .T.

      *-- Recursao em Containers
      IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
        IF loc_oCtrl.ControlCount > 0
          THIS.TornarControlesVisiveis(loc_oCtrl)
        ENDIF
      ENDIF

      *-- Recursao em Pages de PageFrame
      IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
        FOR loc_j = 1 TO loc_oCtrl.PageCount
          THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
        ENDFOR
      ENDIF
    ENDFOR
    loc_oCtrl = .NULL.
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE Destroy
    *-- Liberar todos os cursores utilizados pelo form
    LOCAL loc_aCursores(15), loc_i
    loc_aCursores(1)  = "cursor_4c_Dados"
    loc_aCursores(2)  = "CsMatPrima"
    loc_aCursores(3)  = "CrSigCdPro"
    loc_aCursores(4)  = "CrSigMvEst"
    loc_aCursores(5)  = "CrSigOpEtq1"
    loc_aCursores(6)  = "CrSigPrCpo"
    loc_aCursores(7)  = "CrSigMvHst"
    loc_aCursores(8)  = "CrSigMvEtr"
    loc_aCursores(9)  = "CrProdutos"
    loc_aCursores(10) = "TotGrupo2"
    loc_aCursores(11) = "CsFase"
    loc_aCursores(12) = "CsEtiqueta"
    loc_aCursores(13) = "crProEtqEqs"
    loc_aCursores(14) = "cursor_4c_Caract"
    loc_aCursores(15) = "cursor_4c_TOpe"

    FOR loc_i = 1 TO 15
      IF USED(loc_aCursores(loc_i))
        USE IN (loc_aCursores(loc_i))
      ENDIF
    ENDFOR

    *-- Liberar objeto de negocio
    THIS.this_oBusinessObject = .NULL.

    DODEFAULT()
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE AlternarPagina(par_nPagina)
    THIS.pgf_4c_1.ActivePage = par_nPagina
  ENDPROC

  *------------------------------------------------------------
  PROCEDURE GrpOperacaoClick
    DO CASE
    CASE THIS.pgf_4c_1.Page1.grp_4c_Operacao.Value = 1
      THIS.BtnConsultarClick()
    CASE THIS.pgf_4c_1.Page1.grp_4c_Operacao.Value = 2
      THIS.BtnEncerrarClick()
    ENDCASE
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarPaginaLista
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    *-- Separador horizontal (sh_Refs)
    loc_oPag.AddObject("shp_4c_Refs", "Shape")
    WITH loc_oPag.shp_4c_Refs
      .Top         = 481
      .Left        = 8
      .Height      = 1
      .Width       = 981
      .BorderStyle = 1
      .BorderWidth = 2
      .BackStyle   = 0
    ENDWITH

    *== LINHA 1: Produto inicial/final + Equivalente + Situacao + Imagem ==
    loc_oPag.AddObject("lbl_4c_Produto", "Label")
    WITH loc_oPag.lbl_4c_Produto
      .Top       = 84
      .Left      = 66
      .Width     = 47
      .Height    = 15
      .Caption   = "\<Produto :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_ProdutoI", "TextBox")
    WITH loc_oPag.txt_4c_ProdutoI
      .Top           = 80
      .Left          = 117
      .Width         = 126
      .Height        = 22
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_ProdutoA", "Label")
    WITH loc_oPag.lbl_4c_ProdutoA
      .Top       = 84
      .Left      = 253
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_ProdutoF", "TextBox")
    WITH loc_oPag.txt_4c_ProdutoF
      .Top           = 80
      .Left          = 282
      .Width         = 126
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Equiv", "Label")
    WITH loc_oPag.lbl_4c_Equiv
      .Top       = 84
      .Left      = 446
      .Width     = 65
      .Height    = 15
      .Caption   = "Equivalente :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Equiv", "TextBox")
    WITH loc_oPag.txt_4c_Equiv
      .Top           = 80
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("chk_4c_Equiv", "CheckBox")
    WITH loc_oPag.chk_4c_Equiv
      .Top           = 83
      .Left          = 628
      .Width         = 18
      .Height        = 17
      .Caption       = ""
      .Value         = 0
      .BackStyle     = 0
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Situacao", "Label")
    WITH loc_oPag.lbl_4c_Situacao
      .Top       = 84
      .Left      = 660
      .Width     = 53
      .Height    = 15
      .Caption   = " Situa" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("cmb_4c_Situas", "ComboBox")
    WITH loc_oPag.cmb_4c_Situas
      .Top         = 80
      .Left        = 716
      .Width       = 98
      .Height      = 23
      .FontName    = "Tahoma"
      .FontSize    = 8
      .Style       = 2
      .BorderStyle = 1
    ENDWITH

    *== LINHA 2: Descricao + Barras + Imagem ==
    loc_oPag.AddObject("lbl_4c_Descricao", "Label")
    WITH loc_oPag.lbl_4c_Descricao
      .Top       = 108
      .Left      = 58
      .Width     = 55
      .Height    = 15
      .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Descricao", "TextBox")
    WITH loc_oPag.txt_4c_Descricao
      .Top           = 104
      .Left          = 117
      .Width         = 291
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Barras", "Label")
    WITH loc_oPag.lbl_4c_Barras
      .Top       = 108
      .Left      = 445
      .Width     = 66
      .Height    = 15
      .Caption   = "C" + CHR(243) + "d. Barras :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Barra", "TextBox")
    WITH loc_oPag.txt_4c_Barra
      .Top           = 104
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 14
      .Format        = "K"
      .InputMask     = "99999999999999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Imagem", "Label")
    WITH loc_oPag.lbl_4c_Imagem
      .Top       = 108
      .Left      = 666
      .Width     = 47
      .Height    = 15
      .Caption   = "Imagem :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("cmb_4c_Imagem", "ComboBox")
    WITH loc_oPag.cmb_4c_Imagem
      .Top         = 104
      .Left        = 716
      .Width       = 98
      .Height      = 23
      .FontName    = "Tahoma"
      .FontSize    = 8
      .Style       = 2
      .BorderStyle = 1
    ENDWITH

    *== LINHA 3: Descritivo + Linha Inicial/Final ==
    loc_oPag.AddObject("lbl_4c_Descritivo", "Label")
    WITH loc_oPag.lbl_4c_Descritivo
      .Top       = 132
      .Left      = 57
      .Width     = 56
      .Height    = 15
      .Caption   = "Descritivo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Descritivo", "TextBox")
    WITH loc_oPag.txt_4c_Descritivo
      .Top           = 128
      .Left          = 117
      .Width         = 291
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Linha", "Label")
    WITH loc_oPag.lbl_4c_Linha
      .Top       = 132
      .Left      = 477
      .Width     = 34
      .Height    = 15
      .Caption   = "\<Linha :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_LinhaI", "TextBox")
    WITH loc_oPag.txt_4c_LinhaI
      .Top           = 128
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_LinhaA", "Label")
    WITH loc_oPag.lbl_4c_LinhaA
      .Top       = 132
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_LinhaF", "TextBox")
    WITH loc_oPag.txt_4c_LinhaF
      .Top           = 128
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 4: Completa + Grupo Venda Inicial/Final ==
    loc_oPag.AddObject("lbl_4c_Completa", "Label")
    WITH loc_oPag.lbl_4c_Completa
      .Top       = 155
      .Left      = 59
      .Width     = 54
      .Height    = 15
      .Caption   = "Completa :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DCompl", "TextBox")
    WITH loc_oPag.txt_4c_DCompl
      .Top           = 152
      .Left          = 117
      .Width         = 291
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 25
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoVenda", "Label")
    WITH loc_oPag.lbl_4c_GrupoVenda
      .Top       = 156
      .Left      = 440
      .Width     = 71
      .Height    = 15
      .Caption   = "Grupo \<Venda :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_GrupoVI", "TextBox")
    WITH loc_oPag.txt_4c_GrupoVI
      .Top           = 152
      .Left          = 515
      .Width         = 108
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoVA", "Label")
    WITH loc_oPag.lbl_4c_GrupoVA
      .Top       = 156
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_GrupoVF", "TextBox")
    WITH loc_oPag.txt_4c_GrupoVF
      .Top           = 152
      .Left          = 649
      .Width         = 108
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 5: Grupo (produto) + Peso Medio ==
    loc_oPag.AddObject("lbl_4c_Grupo", "Label")
    WITH loc_oPag.lbl_4c_Grupo
      .Top       = 178
      .Left      = 75
      .Width     = 38
      .Height    = 15
      .Caption   = "Grupo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Gde", "TextBox")
    WITH loc_oPag.txt_4c_Gde
      .Top           = 174
      .Left          = 117
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "!K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoSep", "Label")
    WITH loc_oPag.lbl_4c_GrupoSep
      .Top       = 175
      .Left      = 154
      .Width     = 10
      .Height    = 15
      .Caption   = "/"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdGrupo", "TextBox")
    WITH loc_oPag.txt_4c_CdGrupo
      .Top           = 174
      .Left          = 163
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsGrupo", "TextBox")
    WITH loc_oPag.txt_4c_DsGrupo
      .Top           = 174
      .Left          = 200
      .Width         = 208
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Peso", "Label")
    WITH loc_oPag.lbl_4c_Peso
      .Top       = 180
      .Left      = 448
      .Width     = 63
      .Height    = 15
      .Caption   = "Peso M" + CHR(233) + "dio :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_PesoI", "TextBox")
    WITH loc_oPag.txt_4c_PesoI
      .Top           = 174
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 8
      .InputMask     = "999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PesoA", "Label")
    WITH loc_oPag.lbl_4c_PesoA
      .Top       = 180
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_PesoF", "TextBox")
    WITH loc_oPag.txt_4c_PesoF
      .Top           = 174
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 8
      .InputMask     = "999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 6: Subgrupo + Preco Custo + Modelo ==
    loc_oPag.AddObject("lbl_4c_Sgrupo", "Label")
    WITH loc_oPag.lbl_4c_Sgrupo
      .Top       = 202
      .Left      = 58
      .Width     = 55
      .Height    = 15
      .Caption   = "Subgrupo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdSGrupo", "TextBox")
    WITH loc_oPag.txt_4c_CdSGrupo
      .Top           = 198
      .Left          = 117
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsSGrupo", "TextBox")
    WITH loc_oPag.txt_4c_DsSGrupo
      .Top           = 198
      .Left          = 172
      .Width         = 236
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PCusto", "Label")
    WITH loc_oPag.lbl_4c_PCusto
      .Top       = 203
      .Left      = 429
      .Width     = 82
      .Height    = 15
      .Caption   = "Pre" + CHR(231) + "o de Custo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CustoI", "TextBox")
    WITH loc_oPag.txt_4c_CustoI
      .Top           = 198
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PCustoA", "Label")
    WITH loc_oPag.lbl_4c_PCustoA
      .Top       = 203
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CustoF", "TextBox")
    WITH loc_oPag.txt_4c_CustoF
      .Top           = 198
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_MoeCusto", "TextBox")
    WITH loc_oPag.txt_4c_MoeCusto
      .Top           = 198
      .Left          = 760
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Modelo", "Label")
    WITH loc_oPag.lbl_4c_Modelo
      .Top       = 202
      .Left      = 839
      .Width     = 43
      .Height    = 15
      .Caption   = "Modelo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CodFinP", "TextBox")
    WITH loc_oPag.txt_4c_CodFinP
      .Top           = 198
      .Left          = 886
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_ModeloA", "Label")
    WITH loc_oPag.lbl_4c_ModeloA
      .Top       = 202
      .Left      = 931
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CodFinPF", "TextBox")
    WITH loc_oPag.txt_4c_CodFinPF
      .Top           = 198
      .Left          = 959
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 7: Cor + Valor Estimado + Faixa Valor ==
    loc_oPag.AddObject("lbl_4c_Cor", "Label")
    WITH loc_oPag.lbl_4c_Cor
      .Top       = 225
      .Left      = 87
      .Width     = 26
      .Height    = 15
      .Caption   = "Cor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Cor", "TextBox")
    WITH loc_oPag.txt_4c_Cor
      .Top           = 222
      .Left          = 117
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DCor", "TextBox")
    WITH loc_oPag.txt_4c_DCor
      .Top           = 222
      .Left          = 172
      .Width         = 236
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Estimado", "Label")
    WITH loc_oPag.lbl_4c_Estimado
      .Top       = 226
      .Left      = 432
      .Width     = 79
      .Height    = 15
      .Caption   = "Valor Estimado :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_EstimI", "TextBox")
    WITH loc_oPag.txt_4c_EstimI
      .Top           = 222
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_EstimadoA", "Label")
    WITH loc_oPag.lbl_4c_EstimadoA
      .Top       = 226
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_EstimF", "TextBox")
    WITH loc_oPag.txt_4c_EstimF
      .Top           = 222
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_MoeEstim", "TextBox")
    WITH loc_oPag.txt_4c_MoeEstim
      .Top           = 222
      .Left          = 760
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_FxPreco", "Label")
    WITH loc_oPag.lbl_4c_FxPreco
      .Top       = 226
      .Left      = 820
      .Width     = 62
      .Height    = 15
      .Caption   = "Faixa Valor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_FxPreco", "TextBox")
    WITH loc_oPag.txt_4c_FxPreco
      .Top           = 222
      .Left          = 886
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 15
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 8: Preco Venda + Classificacao + Acabamento ==
    loc_oPag.AddObject("lbl_4c_PVenda", "Label")
    WITH loc_oPag.lbl_4c_PVenda
      .Top       = 251
      .Left      = 427
      .Width     = 84
      .Height    = 15
      .Caption   = "Pre" + CHR(231) + "o de Venda :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_VendaI", "TextBox")
    WITH loc_oPag.txt_4c_VendaI
      .Top           = 247
      .Left          = 515
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PVendaA", "Label")
    WITH loc_oPag.lbl_4c_PVendaA
      .Top       = 251
      .Left      = 626
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_VendaF", "TextBox")
    WITH loc_oPag.txt_4c_VendaF
      .Top           = 247
      .Left          = 649
      .Width         = 108
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 9
      .InputMask     = "9,999,999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_MoeVenda", "TextBox")
    WITH loc_oPag.txt_4c_MoeVenda
      .Top           = 247
      .Left          = 760
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Classe", "Label")
    WITH loc_oPag.lbl_4c_Classe
      .Top       = 251
      .Left      = 812
      .Width     = 70
      .Height    = 15
      .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Classe", "TextBox")
    WITH loc_oPag.txt_4c_Classe
      .Top           = 247
      .Left          = 886
      .Width         = 35
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Acabamento", "Label")
    WITH loc_oPag.lbl_4c_Acabamento
      .Top       = 249
      .Left      = 44
      .Width     = 69
      .Height    = 15
      .Caption   = "Acabamento :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CodAcb", "TextBox")
    WITH loc_oPag.txt_4c_CodAcb
      .Top           = 246
      .Left          = 117
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DAcb", "TextBox")
    WITH loc_oPag.txt_4c_DAcb
      .Top           = 246
      .Left          = 172
      .Width         = 236
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *== LINHA 9: Lista Precos + Periodo Alteracao + Dimensoes ==
    loc_oPag.AddObject("lbl_4c_Lista", "Label")
    WITH loc_oPag.lbl_4c_Lista
      .Top       = 272
      .Left      = 32
      .Width     = 81
      .Height    = 15
      .Caption   = "Lista de Pre" + CHR(231) + "os :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Lista", "TextBox")
    WITH loc_oPag.txt_4c_Lista
      .Top           = 270
      .Left          = 117
      .Width         = 239
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 30
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_PeriodoAlt", "Label")
    WITH loc_oPag.lbl_4c_PeriodoAlt
      .Top       = 275
      .Left      = 466
      .Width     = 45
      .Height    = 15
      .Caption   = "Per" + CHR(237) + "odo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtAltI", "TextBox")
    WITH loc_oPag.txt_4c_DtAltI
      .Top           = 271
      .Left          = 515
      .Width         = 80
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_DtAltA", "Label")
    WITH loc_oPag.lbl_4c_DtAltA
      .Top       = 275
      .Left      = 598
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtAltF", "TextBox")
    WITH loc_oPag.txt_4c_DtAltF
      .Top           = 271
      .Left          = 621
      .Width         = 80
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *-- OptTpDtCad (Alt/Inc)
    loc_oPag.AddObject("opt_4c_TpDtCad", "OptionGroup")
    loc_oPag.opt_4c_TpDtCad.Top         = 271
    loc_oPag.opt_4c_TpDtCad.Left        = 708
    loc_oPag.opt_4c_TpDtCad.Width       = 81
    loc_oPag.opt_4c_TpDtCad.Height      = 24
    loc_oPag.opt_4c_TpDtCad.ButtonCount = 2
    loc_oPag.opt_4c_TpDtCad.BorderStyle = 0
    loc_oPag.opt_4c_TpDtCad.BackStyle   = 0
    loc_oPag.opt_4c_TpDtCad.Value       = 1
    WITH loc_oPag.opt_4c_TpDtCad.Buttons(1)
      .Caption  = "Alt"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 35
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpDtCad.Buttons(2)
      .Caption  = "Inc"
      .BackStyle = 0
      .Top      = 2
      .Left     = 39
      .Width    = 35
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *-- Dimensao Profundidade
    loc_oPag.AddObject("lbl_4c_Profund", "Label")
    WITH loc_oPag.lbl_4c_Profund
      .Top       = 275
      .Left      = 828
      .Width     = 55
      .Height    = 15
      .Caption   = "Profund. :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Tamps", "TextBox")
    WITH loc_oPag.txt_4c_Tamps
      .Top           = 271
      .Left          = 886
      .Width         = 58
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .InputMask     = "999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 10: Promocao + Dimensao Altura ==
    loc_oPag.AddObject("lbl_4c_Promo", "Label")
    WITH loc_oPag.lbl_4c_Promo
      .Top       = 295
      .Left      = 57
      .Width     = 56
      .Height    = 15
      .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Promo", "TextBox")
    WITH loc_oPag.txt_4c_Promo
      .Top           = 292
      .Left          = 117
      .Width         = 239
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 25
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Altura", "Label")
    WITH loc_oPag.lbl_4c_Altura
      .Top       = 297
      .Left      = 840
      .Width     = 42
      .Height    = 15
      .Caption   = "Altura :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Tamas", "TextBox")
    WITH loc_oPag.txt_4c_Tamas
      .Top           = 293
      .Left          = 886
      .Width         = 58
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .InputMask     = "999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 11: Fornecedor + Dimensao Comprimento + grdCaracts ==
    loc_oPag.AddObject("lbl_4c_Fornec", "Label")
    WITH loc_oPag.lbl_4c_Fornec
      .Top       = 317
      .Left      = 49
      .Width     = 64
      .Height    = 15
      .Caption   = "Fornecedor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdFornec", "TextBox")
    WITH loc_oPag.txt_4c_CdFornec
      .Top           = 314
      .Left          = 117
      .Width         = 80
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsFornec", "TextBox")
    WITH loc_oPag.txt_4c_DsFornec
      .Top           = 314
      .Left          = 200
      .Width         = 311
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Comprim", "Label")
    WITH loc_oPag.lbl_4c_Comprim
      .Top       = 319
      .Left      = 826
      .Width     = 57
      .Height    = 15
      .Caption   = "Comprim. :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Tamcs", "TextBox")
    WITH loc_oPag.txt_4c_Tamcs
      .Top           = 315
      .Left          = 886
      .Width         = 58
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .InputMask     = "999.99"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    THIS.ConfigurarGrdCaracts(loc_oPag)

    *== LINHA 12: Ref.Fornecedor + Opt_TpReffs + Conjunto ==
    loc_oPag.AddObject("lbl_4c_RefFornec", "Label")
    WITH loc_oPag.lbl_4c_RefFornec
      .Top       = 339
      .Left      = 25
      .Width     = 88
      .Height    = 15
      .Caption   = "Ref. Fornecedor :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_RefFornec", "TextBox")
    WITH loc_oPag.txt_4c_RefFornec
      .Top           = 336
      .Left          = 117
      .Width         = 115
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 40
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("lbl_4c_RefFornecA", "Label")
    WITH loc_oPag.lbl_4c_RefFornecA
      .Top       = 339
      .Left      = 237
      .Width     = 20
      .Height    = 15
      .Caption   = "at" + CHR(233)
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_RefFornecF", "TextBox")
    WITH loc_oPag.txt_4c_RefFornecF
      .Top           = 336
      .Left          = 260
      .Width         = 115
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *-- Opt_TpReffs (Similar/Equivalente/Todos)
    loc_oPag.AddObject("opt_4c_TpReffs", "OptionGroup")
    loc_oPag.opt_4c_TpReffs.Top         = 336
    loc_oPag.opt_4c_TpReffs.Left        = 377
    loc_oPag.opt_4c_TpReffs.Width       = 187
    loc_oPag.opt_4c_TpReffs.Height      = 23
    loc_oPag.opt_4c_TpReffs.ButtonCount = 3
    loc_oPag.opt_4c_TpReffs.BorderStyle = 0
    loc_oPag.opt_4c_TpReffs.BackStyle   = 0
    loc_oPag.opt_4c_TpReffs.Value       = 3
    WITH loc_oPag.opt_4c_TpReffs.Buttons(1)
      .Caption  = "Similar"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 58
      .Height   = 19
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpReffs.Buttons(2)
      .Caption  = "Equivalente"
      .BackStyle = 0
      .Top      = 2
      .Left     = 62
      .Width    = 65
      .Height   = 19
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpReffs.Buttons(3)
      .Caption  = "Todos"
      .BackStyle = 0
      .Top      = 2
      .Left     = 129
      .Width    = 55
      .Height   = 19
      .AutoSize = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_Conjunto", "Label")
    WITH loc_oPag.lbl_4c_Conjunto
      .Top       = 341
      .Left      = 830
      .Width     = 53
      .Height    = 15
      .Caption   = "Conjunto :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Conjunto", "TextBox")
    WITH loc_oPag.txt_4c_Conjunto
      .Top           = 337
      .Left          = 886
      .Width         = 52
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .InputMask     = "999999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *== LINHA 13: Empresa + Grupo CC ==
    loc_oPag.AddObject("lbl_4c_Empresa", "Label")
    WITH loc_oPag.lbl_4c_Empresa
      .Top       = 360
      .Left      = 63
      .Width     = 50
      .Height    = 15
      .Caption   = "Empresa :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_Emps", "TextBox")
    WITH loc_oPag.txt_4c_Emps
      .Top           = 358
      .Left          = 117
      .Width         = 31
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DsEmps", "TextBox")
    WITH loc_oPag.txt_4c_DsEmps
      .Top           = 358
      .Left          = 150
      .Width         = 360
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    loc_oPag.AddObject("lbl_4c_GrupoCC", "Label")
    WITH loc_oPag.lbl_4c_GrupoCC
      .Top       = 383
      .Left      = 75
      .Width     = 38
      .Height    = 15
      .Caption   = "Grupo :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_GrupoCC", "TextBox")
    WITH loc_oPag.txt_4c_GrupoCC
      .Top           = 380
      .Left          = 117
      .Width         = 80
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_NGrupoCC", "TextBox")
    WITH loc_oPag.txt_4c_NGrupoCC
      .Top           = 380
      .Left          = 199
      .Width         = 311
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *-- Produto Web (optWebs)
    loc_oPag.AddObject("lbl_4c_ProdWeb", "Label")
    WITH loc_oPag.lbl_4c_ProdWeb
      .Top       = 392
      .Left      = 851
      .Width     = 72
      .Height    = 15
      .Caption   = "Produto Web :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("opt_4c_Webs", "OptionGroup")
    loc_oPag.opt_4c_Webs.Top         = 407
    loc_oPag.opt_4c_Webs.Left        = 851
    loc_oPag.opt_4c_Webs.Width       = 132
    loc_oPag.opt_4c_Webs.Height      = 63
    loc_oPag.opt_4c_Webs.ButtonCount = 5
    loc_oPag.opt_4c_Webs.BorderStyle = 0
    loc_oPag.opt_4c_Webs.BackStyle   = 0
    loc_oPag.opt_4c_Webs.Value       = 5
    WITH loc_oPag.opt_4c_Webs.Buttons(1)
      .Caption  = "Sim"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(2)
      .Caption  = "N" + CHR(227) + "o"
      .BackStyle = 0
      .Top      = 14
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(3)
      .Caption  = "Tudo"
      .BackStyle = 0
      .Top      = 26
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(4)
      .Caption  = "Sim/N" + CHR(227) + "o"
      .BackStyle = 0
      .Top      = 38
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Webs.Buttons(5)
      .Caption  = "Apenas Web"
      .BackStyle = 0
      .Top      = 50
      .Left     = 2
      .Width    = 126
      .Height   = 12
      .AutoSize = .F.
    ENDWITH

    *== LINHA 14: Conta CC ==
    loc_oPag.AddObject("lbl_4c_ContaCC", "Label")
    WITH loc_oPag.lbl_4c_ContaCC
      .Top       = 405
      .Left      = 75
      .Width     = 38
      .Height    = 15
      .Caption   = "Conta :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_CdConta", "TextBox")
    WITH loc_oPag.txt_4c_CdConta
      .Top           = 402
      .Left          = 117
      .Width         = 80
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_NConta", "TextBox")
    WITH loc_oPag.txt_4c_NConta
      .Top           = 402
      .Left          = 199
      .Width         = 311
      .Height        = 21
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *== LINHA 15: Composicao (label + grd_composicao) ==
    loc_oPag.AddObject("lbl_4c_Composicao", "Label")
    WITH loc_oPag.lbl_4c_Composicao
      .Top       = 425
      .Left      = 44
      .Width     = 69
      .Height    = 15
      .Caption   = " Composi" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    THIS.ConfigurarGrdComposicao(loc_oPag)

    *== LINHA 16: Tipo de Operacao + grdTOpe + Operacao campos ==
    loc_oPag.AddObject("lbl_4c_TipoOpe", "Label")
    WITH loc_oPag.lbl_4c_TipoOpe
      .Top       = 488
      .Left      = 19
      .Width     = 94
      .Height    = 15
      .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("chk_4c_MarcaTOpe", "CheckBox")
    WITH loc_oPag.chk_4c_MarcaTOpe
      .Top       = 487
      .Left      = 120
      .Width     = 13
      .Height    = 16
      .Caption   = ""
      .Value     = 0
      .BackStyle = 0
    ENDWITH

    THIS.ConfigurarGrdTOpe(loc_oPag)

    loc_oPag.AddObject("lbl_4c_Operacao", "Label")
    WITH loc_oPag.lbl_4c_Operacao
      .Top       = 488
      .Left      = 561
      .Width     = 56
      .Height    = 15
      .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_EmpsO", "TextBox")
    WITH loc_oPag.txt_4c_EmpsO
      .Top           = 486
      .Left          = 618
      .Width         = 31
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 3
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_Operacao", "TextBox")
    WITH loc_oPag.txt_4c_Operacao
      .Top           = 486
      .Left          = 652
      .Width         = 151
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 20
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_OperacaoI", "TextBox")
    WITH loc_oPag.txt_4c_OperacaoI
      .Top           = 486
      .Left          = 805
      .Width         = 55
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 6
      .Format        = "K"
      .InputMask     = "999999"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *-- Botao arquivo (equivalente ao Commandgroup1 em Filtro.Principal)
    loc_oPag.AddObject("grp_4c_Arquivo", "CommandGroup")
    WITH loc_oPag.grp_4c_Arquivo
      .Top         = 482
      .Left        = 476
      .Width       = 55
      .Height      = 55
      .ButtonCount = 1
      .BorderStyle = 0
    ENDWITH
    WITH loc_oPag.grp_4c_Arquivo.Buttons(1)
      .Top         = 3
      .Left        = 3
      .Width       = 40
      .Height      = 40
      .Caption     = ""
      .ToolTipText = "Arquivo"
    ENDWITH

    *== LINHA 17: Periodo Operacao + OptTpData + OptOperacao + OptPagamento ==
    loc_oPag.AddObject("lbl_4c_DtOpe", "Label")
    WITH loc_oPag.lbl_4c_DtOpe
      .Top       = 516
      .Left      = 496
      .Width     = 121
      .Height    = 17
      .Caption   = "Dt Opera" + CHR(231) + CHR(227) + "o : "
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtOpeI", "TextBox")
    WITH loc_oPag.txt_4c_DtOpeI
      .Top           = 511
      .Left          = 618
      .Width         = 80
      .Height        = 25
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_DtOpeF", "TextBox")
    WITH loc_oPag.txt_4c_DtOpeF
      .Top           = 511
      .Left          = 716
      .Width         = 80
      .Height        = 25
      .FontName      = "Tahoma"
      .FontSize      = 8
      .Format        = "K"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    *-- OptTpData (Dt Operacao / Dt Cadastro)
    loc_oPag.AddObject("opt_4c_TpData", "OptionGroup")
    loc_oPag.opt_4c_TpData.Top         = 512
    loc_oPag.opt_4c_TpData.Left        = 800
    loc_oPag.opt_4c_TpData.Width       = 187
    loc_oPag.opt_4c_TpData.Height      = 24
    loc_oPag.opt_4c_TpData.ButtonCount = 2
    loc_oPag.opt_4c_TpData.BorderStyle = 0
    loc_oPag.opt_4c_TpData.BackStyle   = 0
    loc_oPag.opt_4c_TpData.Value       = 1
    WITH loc_oPag.opt_4c_TpData.Buttons(1)
      .Caption  = "Dt Opera" + CHR(231) + CHR(227) + "o"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 90
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_TpData.Buttons(2)
      .Caption  = "Dt Cadastro"
      .BackStyle = 0
      .Top      = 2
      .Left     = 94
      .Width    = 90
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *-- Filtro de Situacao da Operacao (3 opcoes)
    loc_oPag.AddObject("opt_4c_Operacao", "OptionGroup")
    loc_oPag.opt_4c_Operacao.Top         = 534
    loc_oPag.opt_4c_Operacao.Left        = 615
    loc_oPag.opt_4c_Operacao.Width       = 227
    loc_oPag.opt_4c_Operacao.Height      = 24
    loc_oPag.opt_4c_Operacao.ButtonCount = 3
    loc_oPag.opt_4c_Operacao.BorderStyle = 0
    loc_oPag.opt_4c_Operacao.BackStyle   = 0
    WITH loc_oPag.opt_4c_Operacao.Buttons(1)
      .Caption  = "Pendentes"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Operacao.Buttons(2)
      .Caption  = "Faturados"
      .BackStyle = 0
      .Top      = 2
      .Left     = 76
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Operacao.Buttons(3)
      .Caption  = "Todos"
      .BackStyle = 0
      .Top      = 2
      .Left     = 150
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *-- Filtro de Situacao do Pagamento (3 opcoes)
    loc_oPag.AddObject("opt_4c_Pagamento", "OptionGroup")
    loc_oPag.opt_4c_Pagamento.Top         = 550
    loc_oPag.opt_4c_Pagamento.Left        = 615
    loc_oPag.opt_4c_Pagamento.Width       = 227
    loc_oPag.opt_4c_Pagamento.Height      = 24
    loc_oPag.opt_4c_Pagamento.ButtonCount = 3
    loc_oPag.opt_4c_Pagamento.BorderStyle = 0
    loc_oPag.opt_4c_Pagamento.BackStyle   = 0
    loc_oPag.opt_4c_Pagamento.Value       = 3
    WITH loc_oPag.opt_4c_Pagamento.Buttons(1)
      .Caption  = "Pagos"
      .BackStyle = 0
      .Top      = 2
      .Left     = 2
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Pagamento.Buttons(2)
      .Caption  = "Pendentes"
      .BackStyle = 0
      .Top      = 2
      .Left     = 76
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH
    WITH loc_oPag.opt_4c_Pagamento.Buttons(3)
      .Caption  = "Cancelados"
      .BackStyle = 0
      .Top      = 2
      .Left     = 150
      .Width    = 72
      .Height   = 20
      .AutoSize = .F.
    ENDWITH

    *== LINHA 18: Conta Financeira + CPF + Botao Conjuge ==
    loc_oPag.AddObject("lbl_4c_ContaFin", "Label")
    WITH loc_oPag.lbl_4c_ContaFin
      .Top       = 578
      .Left      = 72
      .Width     = 38
      .Height    = 15
      .Caption   = "Conta :"
      .FontName  = "Tahoma"
      .FontSize  = 8
      .BackStyle = 0
    ENDWITH

    loc_oPag.AddObject("txt_4c_ContaO", "TextBox")
    WITH loc_oPag.txt_4c_ContaO
      .Top           = 576
      .Left          = 118
      .Width         = 80
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 10
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_CPF", "TextBox")
    WITH loc_oPag.txt_4c_CPF
      .Top           = 576
      .Left          = 200
      .Width         = 146
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
      .BorderStyle   = 1
      .SpecialEffect = 1
    ENDWITH

    loc_oPag.AddObject("txt_4c_NContaO", "TextBox")
    WITH loc_oPag.txt_4c_NContaO
      .Top           = 576
      .Left          = 348
      .Width         = 346
      .Height        = 23
      .FontName      = "Tahoma"
      .FontSize      = 8
      .MaxLength     = 50
      .Format        = "K!"
      .BorderStyle   = 1
      .SpecialEffect = 1
      .Enabled       = .F.
    ENDWITH

    *-- Botao Conjuge (cmdConjuge)
    loc_oPag.AddObject("grp_4c_Conjuge", "CommandGroup")
    WITH loc_oPag.grp_4c_Conjuge
      .Top         = 565
      .Left        = 698
      .Width       = 46
      .Height      = 37
      .ButtonCount = 1
      .BorderStyle = 0
    ENDWITH
    WITH loc_oPag.grp_4c_Conjuge.Buttons(1)
      .Top         = 3
      .Left        = 3
      .Width       = 40
      .Height      = 31
      .Caption     = ""
      .ToolTipText = "Procurar Conta Por C" + CHR(244) + "njuge"
    ENDWITH

    *-- BINDEVENTs: Lookups F4 nos campos de filtro
    BINDEVENT(loc_oPag.txt_4c_ProdutoI,  "KeyPress", THIS, "TxtProdutoIKeyPress")
    BINDEVENT(loc_oPag.txt_4c_ProdutoF,  "KeyPress", THIS, "TxtProdutoFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Equiv,     "KeyPress", THIS, "TxtEquivKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdGrupo,   "KeyPress", THIS, "TxtCdGrupoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Gde,       "KeyPress", THIS, "TxtGdeKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdSGrupo,  "KeyPress", THIS, "TxtCdSGrupoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Cor,       "KeyPress", THIS, "TxtCorKeyPress")
    BINDEVENT(loc_oPag.txt_4c_LinhaI,    "KeyPress", THIS, "TxtLinhaIKeyPress")
    BINDEVENT(loc_oPag.txt_4c_LinhaF,    "KeyPress", THIS, "TxtLinhaFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_GrupoVI,   "KeyPress", THIS, "TxtGrupoVIKeyPress")
    BINDEVENT(loc_oPag.txt_4c_GrupoVF,   "KeyPress", THIS, "TxtGrupoVFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_MoeCusto,  "KeyPress", THIS, "TxtMoeCustoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_MoeEstim,  "KeyPress", THIS, "TxtMoeEstimKeyPress")
    BINDEVENT(loc_oPag.txt_4c_MoeVenda,  "KeyPress", THIS, "TxtMoeVendaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CodFinP,   "KeyPress", THIS, "TxtCodFinPKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CodFinPF,  "KeyPress", THIS, "TxtCodFinPFKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Classe,    "KeyPress", THIS, "TxtClasseKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CodAcb,    "KeyPress", THIS, "TxtCodAcbKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Promo,     "KeyPress", THIS, "TxtPromoKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Lista,     "KeyPress", THIS, "TxtListaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdFornec,  "KeyPress", THIS, "TxtCdFornecKeyPress")
    BINDEVENT(loc_oPag.txt_4c_Emps,      "KeyPress", THIS, "TxtEmpsKeyPress")
    BINDEVENT(loc_oPag.txt_4c_GrupoCC,   "KeyPress", THIS, "TxtGrupoCCKeyPress")
    BINDEVENT(loc_oPag.txt_4c_CdConta,   "KeyPress", THIS, "TxtCdContaKeyPress")
    BINDEVENT(loc_oPag.txt_4c_ContaO,    "KeyPress", THIS, "TxtContaOKeyPress")
    BINDEVENT(loc_oPag.txt_4c_EmpsO,     "KeyPress", THIS, "TxtEmpsOKeyPress")

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarGrdComposicao(par_oPag)
    par_oPag.AddObject("grd_4c_Composicao", "Grid")
    par_oPag.grd_4c_Composicao.Top          = 425
    par_oPag.grd_4c_Composicao.Left         = 117
    par_oPag.grd_4c_Composicao.Width        = 722
    par_oPag.grd_4c_Composicao.Height       = 54
    par_oPag.grd_4c_Composicao.ColumnCount  = 7
    par_oPag.grd_4c_Composicao.RecordSource = "CsMatPrima"

    WITH par_oPag.grd_4c_Composicao
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 18
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.

      WITH .Column1
        .Width           = 108
        .ControlSource   = "CsMatPrima.mats"
        .Movable         = .F.
        .Resizable       = .F.
        .Header1.Caption = "Caracter" + CHR(237) + "stica"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column2
        .Width           = 290
        .ControlSource   = "CsMatPrima.dcompos"
        .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column3
        .Width           = 80
        .ControlSource   = "CsMatPrima.qtd_inicial"
        .Header1.Caption = "Qtd"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column4
        .Width           = 80
        .ControlSource   = "CsMatPrima.qtd_final"
        .Header1.Caption = "Quantidade"
        .Header1.Alignment = 2
      ENDWITH

      *-- Column5: CheckBox (apenas)
      .Column5.AddObject("Check1", "CheckBox")
      WITH .Column5
        .Width          = 15
        .CurrentControl = "Check1"
        .Sparse         = .F.
        .ControlSource  = "CsMatPrima.apenas"
        .Header1.Caption = ""
      ENDWITH

      WITH .Column6
        .Width           = 31
        .ControlSource   = "CsMatPrima.Cgrus"
        .Header1.Caption = "Grupo"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column7
        .Width           = 80
        .ControlSource   = "CsMatPrima.Tipos"
        .Header1.Caption = "Tipos"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarGrdCaracts(par_oPag)
    par_oPag.AddObject("grd_4c_Caract", "Grid")
    par_oPag.grd_4c_Caract.Top          = 319
    par_oPag.grd_4c_Caract.Left         = 568
    par_oPag.grd_4c_Caract.Width        = 187
    par_oPag.grd_4c_Caract.Height       = 105
    par_oPag.grd_4c_Caract.ColumnCount  = 2
    par_oPag.grd_4c_Caract.RecordSource = "cursor_4c_Caract"

    WITH par_oPag.grd_4c_Caract
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 17
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.

      *-- Column1: CheckBox (marcado)
      .Column1.AddObject("Check1", "CheckBox")
      WITH .Column1
        .Width          = 15
        .CurrentControl = "Check1"
        .Sparse         = .F.
        .ControlSource  = "cursor_4c_Caract.marcado"
        .Header1.Caption = ""
      ENDWITH

      WITH .Column2
        .Width           = 150
        .ControlSource   = "cursor_4c_Caract.descs"
        .Header1.Caption = "Caracter" + CHR(237) + "stica"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  PROTECTED PROCEDURE ConfigurarGrdTOpe(par_oPag)
    par_oPag.AddObject("grd_4c_TOpe", "Grid")
    par_oPag.grd_4c_TOpe.Top          = 485
    par_oPag.grd_4c_TOpe.Left         = 118
    par_oPag.grd_4c_TOpe.Width        = 360
    par_oPag.grd_4c_TOpe.Height       = 89
    par_oPag.grd_4c_TOpe.ColumnCount  = 3
    par_oPag.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"

    WITH par_oPag.grd_4c_TOpe
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 17
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.

      *-- Column1: CheckBox (marcado)
      .Column1.AddObject("Check1", "CheckBox")
      WITH .Column1
        .Width          = 15
        .CurrentControl = "Check1"
        .Sparse         = .F.
        .ControlSource  = "cursor_4c_TOpe.marcado"
        .Header1.Caption = ""
      ENDWITH

      WITH .Column2
        .Width           = 31
        .ControlSource   = "cursor_4c_TOpe.ctipo"
        .Header1.Caption = "C" + CHR(243) + "d"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column3
        .Width           = 290
        .ControlSource   = "cursor_4c_TOpe.dtipo"
        .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH
  ENDPROC

  *------------------------------------------------------------
  *-- Fase 5/8: Page2 (Selecao) - Grid + Cabecalho Parte 1
  PROTECTED PROCEDURE ConfigurarPaginaDados
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1

    *-- Grid principal de produtos (grd_produtos)
    loc_oPag.AddObject("grd_4c_Produtos", "Grid")
    loc_oPag.grd_4c_Produtos.RecordSource = "CrProdutos"
    loc_oPag.grd_4c_Produtos.Top          = 5
    loc_oPag.grd_4c_Produtos.Left         = 0
    loc_oPag.grd_4c_Produtos.Width        = 655
    loc_oPag.grd_4c_Produtos.Height       = 275

    loc_oPag.grd_4c_Produtos.ColumnCount = 2
    WITH loc_oPag.grd_4c_Produtos
      .FontName          = "Tahoma"
      .FontSize          = 8
      .DeleteMark        = .F.
      .RecordMark        = .F.
      .ScrollBars        = 2
      .RowHeight         = 18
      .AllowHeaderSizing = .F.
      .AllowRowSizing    = .F.
      .ReadOnly          = .T.

      WITH .Column1
        .Width             = 108
        .ControlSource     = "CrProdutos.cpros"
        .Movable           = .F.
        .Resizable         = .F.
        .Header1.Caption   = "C" + CHR(243) + "d"
        .Header1.Alignment = 2
      ENDWITH

      WITH .Column2
        .Width             = 525
        .ControlSource     = "CrProdutos.dpros"
        .Movable           = .F.
        .Resizable         = .F.
        .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        .Header1.Alignment = 2
      ENDWITH
    ENDWITH

    *-- Imagem do produto (FigJpg) - lado direito do grid
    loc_oPag.AddObject("img_4c_FigJpg", "Image")
    WITH loc_oPag.img_4c_FigJpg
      .Top         = 5
      .Left        = 658
      .Width       = 222
      .Height      = 220
      .BorderStyle = 0
      .Stretch     = 2
    ENDWITH

    *-- Container cabecalho: primeiros 50% dos campos de detalhe do produto
    loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
    WITH loc_oPag.cnt_4c_Cabecalho
      .Top         = 283
      .Left        = 0
      .Width       = 1000
      .Height      = 370
      .BackColor   = RGB(236, 233, 216)
      .BorderWidth = 0
      .Visible     = .T.

      *-- ROW 1: Fornecedor
      .AddObject("lbl_4c_Lbl_fornecedor", "Label")
      WITH .lbl_4c_Lbl_fornecedor
        .Top       = 5
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Fornecedor :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c__cd_fornecedor", "TextBox")
      WITH .txt_4c__cd_fornecedor
        .Top           = 2
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_fornecedor", "TextBox")
      WITH .txt_4c__ds_fornecedor
        .Top           = 2
        .Left          = 159
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 2: Ref. Fornecedor
      .AddObject("lbl_4c_Lbl_ref_fornecedor", "Label")
      WITH .lbl_4c_Lbl_ref_fornecedor
        .Top       = 28
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Ref.Fornec. :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c__ref_fornecedor", "TextBox")
      WITH .txt_4c__ref_fornecedor
        .Top           = 25
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 3: Grupo
      .AddObject("lbl_4c_Lbl_grupo", "Label")
      WITH .lbl_4c_Lbl_grupo
        .Top       = 51
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Grupo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c__cd_grupo", "TextBox")
      WITH .txt_4c__cd_grupo
        .Top           = 48
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 5
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_grupo", "TextBox")
      WITH .txt_4c__ds_grupo
        .Top           = 48
        .Left          = 124
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 4: Subgrupo
      .AddObject("lbl_4c_SGrupo", "Label")
      WITH .lbl_4c_SGrupo
        .Top       = 74
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Subgrupo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c__cd_sgrupo", "TextBox")
      WITH .txt_4c__cd_sgrupo
        .Top           = 71
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 6
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_sgrupo", "TextBox")
      WITH .txt_4c__ds_sgrupo
        .Top           = 71
        .Left          = 134
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 5: Linha
      .AddObject("lbl_4c_Label5", "Label")
      WITH .lbl_4c_Label5
        .Top       = 97
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Linha :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_CdLinha", "TextBox")
      WITH .txt_4c_CdLinha
        .Top           = 94
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 10
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_DsLinha", "TextBox")
      WITH .txt_4c_DsLinha
        .Top           = 94
        .Left          = 159
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 6: Grupo de Venda
      .AddObject("lbl_4c_Label4", "Label")
      WITH .lbl_4c_Label4
        .Top       = 120
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Gr. Venda :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_GrVenda", "TextBox")
      WITH .txt_4c_GrVenda
        .Top           = 117
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 5
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_GrDvenda", "TextBox")
      WITH .txt_4c_GrDvenda
        .Top           = 117
        .Left          = 134
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 7: Unidade + Grande Grupo
      .AddObject("lbl_4c_Lbl_unidade", "Label")
      WITH .lbl_4c_Lbl_unidade
        .Top       = 143
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Unidade :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c__cd_unidade", "TextBox")
      WITH .txt_4c__cd_unidade
        .Top           = 140
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 5
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("lbl_4c_Label15", "Label")
      WITH .lbl_4c_Label15
        .Top       = 143
        .Left      = 550
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Gde. Grupo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c__cd_ggrupo", "TextBox")
      WITH .txt_4c__cd_ggrupo
        .Top           = 140
        .Left          = 628
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 5
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c__ds_ggrupo", "TextBox")
      WITH .txt_4c__ds_ggrupo
        .Top           = 140
        .Left          = 676
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 40
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 8: Modelo (CodFinP / DesFinP)
      .AddObject("lbl_4c_Label14", "Label")
      WITH .lbl_4c_Label14
        .Top       = 166
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Modelo :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_CodFinP", "TextBox")
      WITH .txt_4c_CodFinP
        .Top           = 163
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 3
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_DesFinP", "TextBox")
      WITH .txt_4c_DesFinP
        .Top           = 163
        .Left          = 114
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 30
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 9: Conjunto + Equivalente
      .AddObject("lbl_4c_Label37", "Label")
      WITH .lbl_4c_Label37
        .Top       = 189
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Conjunto :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_Conjunto", "TextBox")
      WITH .txt_4c_Conjunto
        .Top           = 186
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 6
        .InputMask     = "999999"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("lbl_4c_Label3", "Label")
      WITH .lbl_4c_Label3
        .Top       = 189
        .Left      = 550
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Equivalente :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_Equivalente", "TextBox")
      WITH .txt_4c_Equivalente
        .Top           = 186
        .Left          = 623
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 14
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 10: Qtd Minima + Cod Barras
      .AddObject("lbl_4c_Lbl_qtd_minima", "Label")
      WITH .lbl_4c_Lbl_qtd_minima
        .Top       = 212
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Qtd M" + CHR(237) + "nima :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c__qtd_minima", "TextBox")
      WITH .txt_4c__qtd_minima
        .Top           = 209
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "99,999.99"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("lbl_4c_Label23", "Label")
      WITH .lbl_4c_Label23
        .Top       = 212
        .Left      = 550
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "C" + CHR(243) + "d. Barras :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_VBars", "TextBox")
      WITH .txt_4c_VBars
        .Top           = 209
        .Left          = 625
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 14
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 11: Cor + Classificacao
      .AddObject("lbl_4c_LblCor", "Label")
      WITH .lbl_4c_LblCor
        .Top       = 235
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Cor :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_CodCorR", "TextBox")
      WITH .txt_4c_CodCorR
        .Top           = 232
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 5
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_DescCorR", "TextBox")
      WITH .txt_4c_DescCorR
        .Top           = 232
        .Left          = 119
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 30
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("lbl_4c_LblClassif", "Label")
      WITH .lbl_4c_LblClassif
        .Top       = 235
        .Left      = 550
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Classif. :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_ClassifR", "TextBox")
      WITH .txt_4c_ClassifR
        .Top           = 232
        .Left          = 628
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 30
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 12: Preco Venda + Peso Medio
      .AddObject("lbl_4c_LblPrVenda", "Label")
      WITH .lbl_4c_LblPrVenda
        .Top       = 258
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Pr. Venda :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_PrVendaR", "TextBox")
      WITH .txt_4c_PrVendaR
        .Top           = 255
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "9999999.99"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_MoePrVR", "TextBox")
      WITH .txt_4c_MoePrVR
        .Top           = 255
        .Left          = 159
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 20
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("lbl_4c_LblPesoMedio", "Label")
      WITH .lbl_4c_LblPesoMedio
        .Top       = 258
        .Left      = 550
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Peso M" + CHR(233) + "dio :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_PesoMedioR", "TextBox")
      WITH .txt_4c_PesoMedioR
        .Top           = 255
        .Left          = 632
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "9999999.9999"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 13: Fator Venda + Locais
      .AddObject("lbl_4c_LblFatorV", "Label")
      WITH .lbl_4c_LblFatorV
        .Top       = 281
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Fat. Venda :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_FatorVR", "TextBox")
      WITH .txt_4c_FatorVR
        .Top           = 278
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .InputMask     = "9999999.99"
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("txt_4c_MoeFatorR", "TextBox")
      WITH .txt_4c_MoeFatorR
        .Top           = 278
        .Left          = 159
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 20
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("lbl_4c_LblLocais", "Label")
      WITH .lbl_4c_LblLocais
        .Top       = 281
        .Left      = 550
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Locais :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_LocaisR", "TextBox")
      WITH .txt_4c_LocaisR
        .Top           = 278
        .Left          = 632
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 50
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      *-- ROW 14: Obs. 1 + Obs. 2
      .AddObject("lbl_4c_LblObs1", "Label")
      WITH .lbl_4c_LblObs1
        .Top       = 304
        .Left      = 5
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Obs. 1 :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_Obs1R", "TextBox")
      WITH .txt_4c_Obs1R
        .Top           = 301
        .Left          = 76
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 50
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH

      .AddObject("lbl_4c_LblObs2", "Label")
      WITH .lbl_4c_LblObs2
        .Top       = 304
        .Left      = 550
        .Width     = THIS.Width
        .Height    = 15
        .Caption   = "Obs. 2 :"
        .FontName  = "Tahoma"
        .FontSize  = 8
        .BackStyle = 0
      ENDWITH

      .AddObject("txt_4c_Obs2R", "TextBox")
      WITH .txt_4c_Obs2R
        .Top           = 301
        .Left          = 632
        .Width         = THIS.Width
        .Height        = 21
        .FontName      = "Tahoma"
        .FontSize      = 8
        .MaxLength     = 50
        .SpecialEffect = 1
        .ReadOnly      = .T.
      ENDWITH
    ENDWITH

    *-- Container botoes de acao (Salvar/Cancelar) - abaixo da imagem
    loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
    WITH loc_oPag.cnt_4c_BotoesAcao
      .Top         = 228
      .Left        = 658
      .Width       = 222
      .Height      = 52
      .BackColor   = RGB(236, 233, 216)
      .BorderWidth = 0
      .Visible     = .T.

      .AddObject("cmd_4c_Salvar", "CommandButton")
      WITH .cmd_4c_Salvar
        .Top      = 3
        .Left     = 3
        .Width    = 100
        .Height   = 23
        .Caption  = "Salvar"
        .FontName = "Tahoma"
        .FontSize = 8
        .Enabled  = .F.
      ENDWITH

      .AddObject("cmd_4c_Cancelar", "CommandButton")
      WITH .cmd_4c_Cancelar
        .Top      = 3
        .Left     = 116
        .Width    = 75
        .Height   = 75
        .Caption  = "Encerrar"
        .FontName = "Tahoma"
        .FontSize = 8
        .Enabled  = .F.
      ENDWITH
    ENDWITH

    loc_oPag = .NULL.
  ENDPROC

  *============================================================
  *-- KEYPRESS HANDLERS - Lookup F4 (par_nKeyCode=28 ou 115)
  *============================================================

  PROCEDURE TxtProdutoIKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupProduto("I")
    ENDIF
  ENDPROC

  PROCEDURE TxtProdutoFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupProduto("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtEquivKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupEquiv()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdGrupoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupGrupo()
    ENDIF
  ENDPROC

  PROCEDURE TxtGdeKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupGrandeGrupo()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdSGrupoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupSubGrupo()
    ENDIF
  ENDPROC

  PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupCor()
    ENDIF
  ENDPROC

  PROCEDURE TxtLinhaIKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupLinha("I")
    ENDIF
  ENDPROC

  PROCEDURE TxtLinhaFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupLinha("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtGrupoVIKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupGrupoV("I")
    ENDIF
  ENDPROC

  PROCEDURE TxtGrupoVFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupGrupoV("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupMoeda("MoeCusto")
    ENDIF
  ENDPROC

  PROCEDURE TxtMoeEstimKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupMoeda("MoeEstim")
    ENDIF
  ENDPROC

  PROCEDURE TxtMoeVendaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupMoeda("MoeVenda")
    ENDIF
  ENDPROC

  PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupModeloFin("P")
    ENDIF
  ENDPROC

  PROCEDURE TxtCodFinPFKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupModeloFin("F")
    ENDIF
  ENDPROC

  PROCEDURE TxtClasseKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupClasse()
    ENDIF
  ENDPROC

  PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupAcabamento()
    ENDIF
  ENDPROC

  PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupPromocao()
    ENDIF
  ENDPROC

  PROCEDURE TxtListaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupLista()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdFornecKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupFornecedor()
    ENDIF
  ENDPROC

  PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupEmpresa("Emps", "DsEmps")
    ENDIF
  ENDPROC

  PROCEDURE TxtGrupoCCKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupGrupoCC()
    ENDIF
  ENDPROC

  PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupContaCC()
    ENDIF
  ENDPROC

  PROCEDURE TxtContaOKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupContaFin()
    ENDIF
  ENDPROC

  PROCEDURE TxtEmpsOKeyPress(par_nKeyCode, par_nShiftAlt)
    IF INLIST(par_nKeyCode, 28, 115)
      THIS.AbrirLookupEmpresa("EmpsO", "")
    ENDIF
  ENDPROC

  *============================================================
  *-- ABRIR LOOKUP METHODS
  *============================================================

  PROCEDURE AbrirLookupProduto(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    DO CASE
      CASE par_cTipo = "I"
        loc_cTarget = "txt_4c_ProdutoI"
        loc_cVal    = ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value)
      CASE par_cTipo = "F"
        loc_cTarget = "txt_4c_ProdutoF"
        loc_cVal    = ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value)
      OTHERWISE
        RETURN
    ENDCASE
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdPro", "cursor_4c_LkpProd", "cpros", loc_cVal, "Produto")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d. Produto")
      loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpProd.cpros)
    ELSE
      loc_oPag.&loc_cTarget..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpProd")
      USE IN cursor_4c_LkpProd
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupEquiv
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Equiv.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdPro", "cursor_4c_LkpEquiv", "cpros", loc_cVal, "Produto/Equivalente")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Equiv.Value = ALLTRIM(cursor_4c_LkpEquiv.cpros)
    ELSE
      loc_oPag.txt_4c_Equiv.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpEquiv")
      USE IN cursor_4c_LkpEquiv
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrupo
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdGrp", "cursor_4c_LkpGrp", "CGrus", loc_cVal, "Grupo de Produto")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("DGrus", "", "Grupo")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_LkpGrp.CGrus)
      loc_oPag.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_LkpGrp.DGrus)
    ELSE
      loc_oPag.txt_4c_CdGrupo.Value = ""
      loc_oPag.txt_4c_DsGrupo.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpGrp")
      USE IN cursor_4c_LkpGrp
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrandeGrupo
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Gde.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdGpr", "cursor_4c_LkpGpr", "codigos", loc_cVal, "Grande Grupo")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Gde.Value = ALLTRIM(cursor_4c_LkpGpr.codigos)
    ELSE
      loc_oPag.txt_4c_Gde.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpGpr")
      USE IN cursor_4c_LkpGpr
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupSubGrupo
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdPsg", "cursor_4c_LkpPsg", "codigos", loc_cVal, "Sub-Grupo")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("codigos",    "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descricaos", "", "Sub-Grupo")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdSGrupo.Value = ALLTRIM(cursor_4c_LkpPsg.codigos)
      loc_oPag.txt_4c_DsSGrupo.Value = ALLTRIM(cursor_4c_LkpPsg.descricaos)
    ELSE
      loc_oPag.txt_4c_CdSGrupo.Value = ""
      loc_oPag.txt_4c_DsSGrupo.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpPsg")
      USE IN cursor_4c_LkpPsg
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupCor
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Cor.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCor", "cursor_4c_LkpCor", "cods", loc_cVal, "Cor")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cods", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descs", "", "Cor")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Cor.Value  = ALLTRIM(cursor_4c_LkpCor.cods)
      loc_oPag.txt_4c_DCor.Value = ALLTRIM(cursor_4c_LkpCor.descs)
    ELSE
      loc_oPag.txt_4c_Cor.Value  = ""
      loc_oPag.txt_4c_DCor.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpCor")
      USE IN cursor_4c_LkpCor
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupLinha(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    IF par_cTipo = "I"
      loc_cTarget = "txt_4c_LinhaI"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_LinhaI.Value)
    ELSE
      loc_cTarget = "txt_4c_LinhaF"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_LinhaF.Value)
    ENDIF
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdLin", "cursor_4c_LkpLin", "Linhas", loc_cVal, "Linha")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Linhas", "", "Linha")
      loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpLin.Linhas)
    ELSE
      loc_oPag.&loc_cTarget..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpLin")
      USE IN cursor_4c_LkpLin
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrupoV(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    IF par_cTipo = "I"
      loc_cTarget = "txt_4c_GrupoVI"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value)
    ELSE
      loc_cTarget = "txt_4c_GrupoVF"
      loc_cVal    = ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value)
    ENDIF
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCol", "cursor_4c_LkpCol", "Colecoes", loc_cVal, "Grupo de Venda")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Descs",    "", "Grupo Venda")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpCol.Colecoes)
    ELSE
      loc_oPag.&loc_cTarget..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpCol")
      USE IN cursor_4c_LkpCol
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupMoeda(par_cCampo)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cCtrl
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cCtrl = "txt_4c_" + par_cCampo
    loc_cVal  = ALLTRIM(loc_oPag.&loc_cCtrl..Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdMoe", "cursor_4c_LkpMoe", "CMoes", loc_cVal, "Moeda")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("DMoes", "", "Moeda")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cCtrl..Value = ALLTRIM(cursor_4c_LkpMoe.CMoes)
    ELSE
      loc_oPag.&loc_cCtrl..Value = ""
    ENDIF
    IF USED("cursor_4c_LkpMoe")
      USE IN cursor_4c_LkpMoe
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupModeloFin(par_cTipo)
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    IF par_cTipo = "P"
      loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodFinP.Value)
    ELSE
      loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodFinPF.Value)
    ENDIF
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdFip", "cursor_4c_LkpFip", "Cods", loc_cVal, "Modelo/Finalizador")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      IF par_cTipo = "P"
        loc_oPag.txt_4c_CodFinP.Value  = ALLTRIM(cursor_4c_LkpFip.Cods)
      ELSE
        loc_oPag.txt_4c_CodFinPF.Value = ALLTRIM(cursor_4c_LkpFip.Cods)
      ENDIF
    ELSE
      IF par_cTipo = "P"
        loc_oPag.txt_4c_CodFinP.Value  = ""
      ELSE
        loc_oPag.txt_4c_CodFinPF.Value = ""
      ENDIF
    ENDIF
    IF USED("cursor_4c_LkpFip")
      USE IN cursor_4c_LkpFip
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupClasse
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Classe.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCls", "cursor_4c_LkpCls", "cods", loc_cVal, ;
      "Classifica" + CHR(231) + CHR(227) + "o")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descs", "", "Classifica" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Classe.Value = ALLTRIM(cursor_4c_LkpCls.cods)
    ELSE
      loc_oPag.txt_4c_Classe.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpCls")
      USE IN cursor_4c_LkpCls
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupAcabamento
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CodAcb.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdAca", "cursor_4c_LkpAca", "cods", loc_cVal, "Acabamento")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("cods",   "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descrs", "", "Acabamento")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_LkpAca.cods)
      loc_oPag.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_LkpAca.descrs)
    ELSE
      loc_oPag.txt_4c_CodAcb.Value = ""
      loc_oPag.txt_4c_DAcb.Value   = ""
    ENDIF
    IF USED("cursor_4c_LkpAca")
      USE IN cursor_4c_LkpAca
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupPromocao
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Promo.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigPrPmc", "cursor_4c_LkpPmc", "promos", loc_cVal, "Promo" + CHR(231) + CHR(227) + "o")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("promos", "", "Promo" + CHR(231) + CHR(227) + "o")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Promo.Value = ALLTRIM(cursor_4c_LkpPmc.promos)
    ELSE
      loc_oPag.txt_4c_Promo.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpPmc")
      USE IN cursor_4c_LkpPmc
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupLista
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Lista.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdLpc", "cursor_4c_LkpLpc", "lprecos", loc_cVal, ;
      "Lista de Pre" + CHR(231) + "os")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("lprecos", "", "Lista")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_Lista.Value = ALLTRIM(cursor_4c_LkpLpc.lprecos)
    ELSE
      loc_oPag.txt_4c_Lista.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpLpc")
      USE IN cursor_4c_LkpLpc
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupFornecedor
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdFornec.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCli", "cursor_4c_LkpForn", "Iclis", loc_cVal, "Fornecedor")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Rclis", "", "Fornecedor")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdFornec.Value = ALLTRIM(cursor_4c_LkpForn.Iclis)
      loc_oPag.txt_4c_DsFornec.Value = ALLTRIM(cursor_4c_LkpForn.Rclis)
    ELSE
      loc_oPag.txt_4c_CdFornec.Value = ""
      loc_oPag.txt_4c_DsFornec.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpForn")
      USE IN cursor_4c_LkpForn
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupEmpresa(par_cCampo, par_cCampoDes)
    LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cCtrl, loc_cCtrlD
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cCtrl = "txt_4c_" + par_cCampo
    loc_cVal  = ALLTRIM(loc_oPag.&loc_cCtrl..Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdEmp", "cursor_4c_LkpEmp", "Cemps", loc_cVal, "Empresa")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Razas", "", "Empresa")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.&loc_cCtrl..Value = ALLTRIM(cursor_4c_LkpEmp.Cemps)
      IF NOT EMPTY(par_cCampoDes)
        loc_cCtrlD = "txt_4c_" + par_cCampoDes
        loc_oPag.&loc_cCtrlD..Value = ALLTRIM(cursor_4c_LkpEmp.Razas)
      ENDIF
    ELSE
      loc_oPag.&loc_cCtrl..Value = ""
      IF NOT EMPTY(par_cCampoDes)
        loc_cCtrlD = "txt_4c_" + par_cCampoDes
        loc_oPag.&loc_cCtrlD..Value = ""
      ENDIF
    ENDIF
    IF USED("cursor_4c_LkpEmp")
      USE IN cursor_4c_LkpEmp
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupGrupoCC
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_GrupoCC.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdGcr", "cursor_4c_LkpGcr", "codigos", loc_cVal, "Grupo C/C")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("descrs",  "", "Grupo C/C")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_GrupoCC.Value  = ALLTRIM(cursor_4c_LkpGcr.codigos)
      loc_oPag.txt_4c_NGrupoCC.Value = ALLTRIM(cursor_4c_LkpGcr.descrs)
    ELSE
      loc_oPag.txt_4c_GrupoCC.Value  = ""
      loc_oPag.txt_4c_NGrupoCC.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpGcr")
      USE IN cursor_4c_LkpGcr
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupContaCC
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdConta.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCli", "cursor_4c_LkpConta", "Iclis", loc_cVal, "Conta Corrente")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Rclis", "", "Conta")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_LkpConta.Iclis)
      loc_oPag.txt_4c_NConta.Value  = ALLTRIM(cursor_4c_LkpConta.Rclis)
    ELSE
      loc_oPag.txt_4c_CdConta.Value = ""
      loc_oPag.txt_4c_NConta.Value  = ""
    ENDIF
    IF USED("cursor_4c_LkpConta")
      USE IN cursor_4c_LkpConta
    ENDIF
    loc_oForm.Release()
  ENDPROC

  PROCEDURE AbrirLookupContaFin
    LOCAL loc_oPag, loc_cVal, loc_oForm
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
    loc_cVal  = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
      "SigCdCli", "cursor_4c_LkpContaO", "Iclis", loc_cVal, "Conta Financeira")
    IF ISNULL(loc_oForm)
      RETURN
    ENDIF
    IF NOT loc_oForm.this_lAchouRegistro
      loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
      loc_oForm.mAddColuna("Rclis", "", "Conta")
      loc_oForm.Show()
    ENDIF
    IF loc_oForm.this_lSelecionou
      loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(cursor_4c_LkpContaO.Iclis)
      loc_oPag.txt_4c_NContaO.Value = ALLTRIM(cursor_4c_LkpContaO.Rclis)
    ELSE
      loc_oPag.txt_4c_ContaO.Value  = ""
      loc_oPag.txt_4c_NContaO.Value = ""
    ENDIF
    IF USED("cursor_4c_LkpContaO")
      USE IN cursor_4c_LkpContaO
    ENDIF
    loc_oForm.Release()
  ENDPROC

  *------------------------------------------------------------
  *-- GrpLimparFiltrosClick: limpa todos os campos de filtro
  PROCEDURE GrpLimparFiltrosClick
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    TRY
      *-- Produto
      loc_oPag.txt_4c_ProdutoI.Value  = ""
      loc_oPag.txt_4c_ProdutoF.Value  = ""
      loc_oPag.txt_4c_Descricao.Value = ""
      loc_oPag.txt_4c_Descritivo.Value= ""
      loc_oPag.txt_4c_Barra.Value     = ""
      loc_oPag.txt_4c_Equiv.Value     = ""
      loc_oPag.chk_4c_Equiv.Value     = 0

      *-- Situacao / Imagem
      loc_oPag.cmb_4c_Situas.ListIndex = 0
      loc_oPag.cmb_4c_Imagem.ListIndex = 0

      *-- Grupo / SubGrupo
      loc_oPag.txt_4c_Gde.Value      = ""
      loc_oPag.txt_4c_CdGrupo.Value  = ""
      loc_oPag.txt_4c_DsGrupo.Value  = ""
      loc_oPag.txt_4c_CdSGrupo.Value = ""
      loc_oPag.txt_4c_DsSGrupo.Value = ""

      *-- Linha / Colecao
      loc_oPag.txt_4c_LinhaI.Value  = ""
      loc_oPag.txt_4c_LinhaF.Value  = ""
      loc_oPag.txt_4c_GrupoVI.Value = ""
      loc_oPag.txt_4c_GrupoVF.Value = ""

      *-- Descricao completa
      loc_oPag.txt_4c_DCompl.Value = ""

      *-- Pesos
      loc_oPag.txt_4c_PesoI.Value = ""
      loc_oPag.txt_4c_PesoF.Value = ""

      *-- Custo / Venda / Estimado
      loc_oPag.txt_4c_CustoI.Value  = ""
      loc_oPag.txt_4c_CustoF.Value  = ""
      loc_oPag.txt_4c_MoeCusto.Value= ""
      loc_oPag.txt_4c_VendaI.Value  = ""
      loc_oPag.txt_4c_VendaF.Value  = ""
      loc_oPag.txt_4c_MoeVenda.Value= ""
      loc_oPag.txt_4c_EstimI.Value  = ""
      loc_oPag.txt_4c_EstimF.Value  = ""
      loc_oPag.txt_4c_MoeEstim.Value= ""
      loc_oPag.txt_4c_FxPreco.Value = ""

      *-- Cor / Acabamento / Classificacao / Modelo
      loc_oPag.txt_4c_Cor.Value     = ""
      loc_oPag.txt_4c_DCor.Value    = ""
      loc_oPag.txt_4c_CodAcb.Value  = ""
      loc_oPag.txt_4c_DAcb.Value    = ""
      loc_oPag.txt_4c_Classe.Value  = ""
      loc_oPag.txt_4c_CodFinP.Value = ""
      loc_oPag.txt_4c_CodFinPF.Value= ""

      *-- Lista / Promocao
      loc_oPag.txt_4c_Lista.Value = ""
      loc_oPag.txt_4c_Promo.Value = ""

      *-- Fornecedor / Referencia
      loc_oPag.txt_4c_CdFornec.Value  = ""
      loc_oPag.txt_4c_DsFornec.Value  = ""
      loc_oPag.txt_4c_RefFornec.Value = ""
      loc_oPag.txt_4c_RefFornecF.Value= ""
      loc_oPag.opt_4c_TpReffs.Value   = 3

      *-- Datas
      loc_oPag.txt_4c_DtAltI.Value = ""
      loc_oPag.txt_4c_DtAltF.Value = ""
      loc_oPag.opt_4c_TpDtCad.Value = 1

      *-- Empresa / GrupoCC / Conta
      loc_oPag.txt_4c_Emps.Value    = ""
      loc_oPag.txt_4c_DsEmps.Value  = ""
      loc_oPag.txt_4c_GrupoCC.Value = ""
      loc_oPag.txt_4c_NGrupoCC.Value= ""
      loc_oPag.txt_4c_CdConta.Value = ""
      loc_oPag.txt_4c_NConta.Value  = ""
      loc_oPag.txt_4c_ContaO.Value  = ""
      loc_oPag.txt_4c_NContaO.Value = ""

      *-- Produto Web
      loc_oPag.opt_4c_Webs.Value = 5

      *-- Dimensoes
      loc_oPag.txt_4c_Tamps.Value   = ""
      loc_oPag.txt_4c_Tamcs.Value   = ""
      loc_oPag.txt_4c_Conjunto.Value= ""

      THIS.this_lConsultaExecutada = .F.

    CATCH TO loc_oErro
      MsgErro("Erro ao limpar filtros: " + loc_oErro.Message, "Erro")
    ENDTRY
  ENDPROC

  *============================================================
  *-- FASE 7: EVENTOS OPERACIONAIS PRINCIPAIS
  *============================================================

  *------------------------------------------------------------
  *-- PopularCombos: inicializa combos Situacao e Imagem
  PROTECTED PROCEDURE PopularCombos
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    WITH loc_oPag.cmb_4c_Situas
      .Clear
      .AddItem("Ativos  ")
      .AddItem("Inativos")
      .AddItem("Ambos   ")
      .Value = "Ambos   "
    ENDWITH

    WITH loc_oPag.cmb_4c_Imagem
      .Clear
      .AddItem("c/Imagem")
      .AddItem("s/Imagem")
      .AddItem("Ambos   ")
      .Value = "Ambos   "
    ENDWITH

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- ConfigurarBtnVoltar: cria botao Voltar na pagina de resultados
  PROTECTED PROCEDURE ConfigurarBtnVoltar
    LOCAL loc_oPag
    loc_oPag = THIS.pgf_4c_1.Page2

    loc_oPag.AddObject("cmd_4c_Voltar", "CommandButton")
    WITH loc_oPag.cmd_4c_Voltar
      .Top         = 0
      .Left        = 920
      .Width       = 75
      .Height      = 17
      .Caption     = "\<Voltar"
      .FontName    = "Tahoma"
      .FontSize    = 8
      .FontBold    = .T.
      .Visible     = .T.
    ENDWITH

    BINDEVENT(loc_oPag.cmd_4c_Voltar, "Click", THIS, "BtnVoltarClick")
    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- BtnVoltarClick: retorna para pagina de filtros
  PROCEDURE BtnVoltarClick
    THIS.Caption = THIS.this_cPrompt
    THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = THIS.Caption
    THIS.AlternarPagina(1)
  ENDPROC

  *------------------------------------------------------------
  *-- KeyPress do Form: F8 ativa busca por LIKE
  PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = -7
      IF VARTYPE(go_4c_Sistema) = "O"
        go_4c_Sistema.BuscaP = .T.
      ENDIF
    ENDIF
    DODEFAULT(par_nKeyCode, par_nShiftAltCtrl)
  ENDPROC

  *------------------------------------------------------------
  *-- GrdProdutosAfterRowColChange: carrega detalhes do produto selecionado
  PROCEDURE GrdProdutosAfterRowColChange(par_nColIndex)
    LOCAL loc_cCodPro, loc_cSQL, loc_nRet, loc_oCab
    LOCAL loc_cCodGru, loc_cCodSgru, loc_cCodCor
    LOCAL loc_cDsSgrupo, loc_cDsCor

    IF !USED("CrProdutos") OR RECCOUNT("CrProdutos") = 0
      RETURN
    ENDIF

    SELECT CrProdutos
    IF EOF()
      RETURN
    ENDIF

    loc_cCodPro = ALLTRIM(CrProdutos.cpros)
    IF EMPTY(loc_cCodPro)
      RETURN
    ENDIF

    TRY
      THIS.MousePointer = 11

      *-- Query principal: dados do produto com JOINs
      loc_cSQL = ;
        "Select a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis, " + ;
        "a.ifors, a.reffs, a.qmins, a.pvens, a.moevs, " + ;
        "a.pesoms, a.fcustos, a.moepcs, a.fvendas, a.moepvs, " + ;
        "a.obspeds, a.obspes, a.linhas, a.colecoes, " + ;
        "a.CodCors, a.cproeqs, a.cClass, a.Locals, a.cbars, " + ;
        "a.CodFinP, a.Conjunts, a.Mercs, a.pcuss, a.moecs, " + ;
        "a.situas, a.DPro2s, a.DPro3s, a.Volumes, " + ;
        "a.pesobs, a.tamps, a.tamhs, a.tamls, a.ProdWebs, " + ;
        "c.rclis, g.dgrus, " + ;
        "b.descs As desccol, l.descs As desclin, " + ;
        "f.descs As descftio, h.descs As descgru " + ;
        "From SigCdPro a " + ;
        "Left Join SigCdGrp g On a.cgrus = g.cgrus " + ;
        "Left Join SigCdCol b On a.colecoes = b.colecoes " + ;
        "Left Join SigCdLin l On a.linhas = l.linhas " + ;
        "Left Join SigPrFti f On a.cftios = f.cods " + ;
        "Left Join SigCdCli c On a.ifors = c.iclis " + ;
        "Left Join SigCdGpr h On a.Mercs = h.codigos " + ;
        "Where a.cpros = " + EscaparSQL(loc_cCodPro)

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProd")
      IF loc_nRet < 1
        THIS.MousePointer = 0
        RETURN
      ENDIF

      SELECT cursor_4c_TmpProd
      IF EOF()
        THIS.MousePointer = 0
        IF USED("cursor_4c_TmpProd")
          USE IN cursor_4c_TmpProd
        ENDIF
        RETURN
      ENDIF

      GO TOP IN cursor_4c_TmpProd

      *-- Buscar subgrupo separadamente
      loc_cCodGru  = ALLTRIM(NVL(cursor_4c_TmpProd.cgrus, ""))
      loc_cCodSgru = ALLTRIM(NVL(cursor_4c_TmpProd.sgrus, ""))

      loc_cDsSgrupo = ""
      IF !EMPTY(loc_cCodSgru)
        loc_cSQL = "Select descricaos From SigCdPsg " + ;
          "Where cgrus = " + EscaparSQL(loc_cCodGru) + ;
          " And codigos = " + EscaparSQL(loc_cCodSgru)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSgr") >= 1
          IF USED("cursor_4c_TmpSgr") AND !EOF("cursor_4c_TmpSgr")
            loc_cDsSgrupo = ALLTRIM(NVL(cursor_4c_TmpSgr.descricaos, ""))
          ENDIF
          IF USED("cursor_4c_TmpSgr")
            USE IN cursor_4c_TmpSgr
          ENDIF
        ENDIF
      ENDIF

      *-- Buscar cor separadamente
      loc_cCodCor = ALLTRIM(NVL(cursor_4c_TmpProd.CodCors, ""))

      loc_cDsCor = ""
      IF !EMPTY(loc_cCodCor)
        loc_cSQL = "Select descs From SigCdCor Where Cods = " + ;
          EscaparSQL(loc_cCodCor)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCor") >= 1
          IF USED("cursor_4c_TmpCor") AND !EOF("cursor_4c_TmpCor")
            loc_cDsCor = ALLTRIM(NVL(cursor_4c_TmpCor.descs, ""))
          ENDIF
          IF USED("cursor_4c_TmpCor")
            USE IN cursor_4c_TmpCor
          ENDIF
        ENDIF
      ENDIF

      *-- Preencher campos do cabecalho
      loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho

      *-- Fornecedor
      loc_oCab.txt_4c__cd_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.ifors, ""))
      loc_oCab.txt_4c__ds_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.rclis, ""))

      *-- Ref. Fornecedor
      loc_oCab.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.reffs, ""))

      *-- Grupo
      loc_oCab.txt_4c__cd_grupo.Value = loc_cCodGru
      loc_oCab.txt_4c__ds_grupo.Value = ALLTRIM(NVL(cursor_4c_TmpProd.dgrus, ""))

      *-- Subgrupo
      loc_oCab.txt_4c__cd_sgrupo.Value = loc_cCodSgru
      loc_oCab.txt_4c__ds_sgrupo.Value = loc_cDsSgrupo

      *-- Linha
      loc_oCab.txt_4c_CdLinha.Value = ALLTRIM(NVL(cursor_4c_TmpProd.linhas, ""))
      loc_oCab.txt_4c_DsLinha.Value = ALLTRIM(NVL(cursor_4c_TmpProd.desclin, ""))

      *-- Grupo de Venda
      loc_oCab.txt_4c_GrVenda.Value  = ALLTRIM(NVL(cursor_4c_TmpProd.colecoes, ""))
      loc_oCab.txt_4c_GrDvenda.Value = ALLTRIM(NVL(cursor_4c_TmpProd.desccol, ""))

      *-- Unidade
      loc_oCab.txt_4c__cd_unidade.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cunis, ""))

      *-- Grande Grupo
      loc_oCab.txt_4c__cd_ggrupo.Value = ALLTRIM(NVL(cursor_4c_TmpProd.Mercs, ""))
      loc_oCab.txt_4c__ds_ggrupo.Value = ALLTRIM(NVL(cursor_4c_TmpProd.descgru, ""))

      *-- Modelo / Finalizador
      loc_oCab.txt_4c_CodFinP.Value = ALLTRIM(NVL(cursor_4c_TmpProd.CodFinP, ""))
      loc_oCab.txt_4c_DesFinP.Value = ALLTRIM(NVL(cursor_4c_TmpProd.descftio, ""))

      *-- Conjunto
      loc_oCab.txt_4c_Conjunto.Value = ALLTRIM(STR(NVL(cursor_4c_TmpProd.Conjunts, 0)))

      *-- Equivalente
      loc_oCab.txt_4c_Equivalente.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cproeqs, ""))

      *-- Qtd Minima
      loc_oCab.txt_4c__qtd_minima.Value = NVL(cursor_4c_TmpProd.qmins, 0)

      *-- Cod Barras
      loc_oCab.txt_4c_VBars.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cbars, ""))

      *-- Cor
      loc_oCab.txt_4c_CodCorR.Value  = loc_cCodCor
      loc_oCab.txt_4c_DescCorR.Value = loc_cDsCor

      *-- Classificacao
      loc_oCab.txt_4c_ClassifR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.cClass, ""))

      *-- Preco Venda
      loc_oCab.txt_4c_PrVendaR.Value  = NVL(cursor_4c_TmpProd.pvens, 0)
      loc_oCab.txt_4c_MoePrVR.Value   = ALLTRIM(NVL(cursor_4c_TmpProd.moevs, ""))

      *-- Peso Medio
      loc_oCab.txt_4c_PesoMedioR.Value = NVL(cursor_4c_TmpProd.pesoms, 0)

      *-- Fator Venda
      loc_oCab.txt_4c_FatorVR.Value   = NVL(cursor_4c_TmpProd.fvendas, 0)
      loc_oCab.txt_4c_MoeFatorR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.moepvs, ""))

      *-- Locais
      loc_oCab.txt_4c_LocaisR.Value = ALLTRIM(NVL(cursor_4c_TmpProd.Locals, ""))

      *-- Obs. 1 e 2
      loc_oCab.txt_4c_Obs1R.Value = ALLTRIM(NVL(cursor_4c_TmpProd.obspeds, ""))
      loc_oCab.txt_4c_Obs2R.Value = ALLTRIM(NVL(cursor_4c_TmpProd.obspes, ""))

      *-- Atualizar legenda com codigo do produto
      THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = ;
        THIS.this_cPrompt + " - Produto: " + loc_cCodPro + ;
        " - " + ALLTRIM(NVL(cursor_4c_TmpProd.dpros, ""))

      *-- Carregar imagem do produto
      THIS.CarregarImagemProduto(loc_cCodPro)

      *-- Liberar cursor temporario
      IF USED("cursor_4c_TmpProd")
        USE IN cursor_4c_TmpProd
      ENDIF

      loc_oCab = .NULL.
      THIS.MousePointer = 0

    CATCH TO loc_oErro
      THIS.MousePointer = 0
      loc_oCab = .NULL.
      IF USED("cursor_4c_TmpProd")
        USE IN cursor_4c_TmpProd
      ENDIF
    ENDTRY
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarImagemProduto: carrega imagem JPG do produto
  PROTECTED PROCEDURE CarregarImagemProduto(par_cCodPro)
    LOCAL loc_cSQL, loc_nRet, loc_cArquivo, loc_oImg

    loc_oImg = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.img_4c_FigJpg
    loc_oImg.Picture = ""

    TRY
      loc_cSQL = "Select FigJpgs From SigCdPro " + ;
        "Where cpros = " + EscaparSQL(par_cCodPro)
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpImg")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpImg") AND !EOF("cursor_4c_TmpImg")
        IF !ISNULL(cursor_4c_TmpImg.FigJpgs) AND !EMPTY(cursor_4c_TmpImg.FigJpgs)
          loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
          STRTOFILE(cursor_4c_TmpImg.FigJpgs, loc_cArquivo)
          loc_oImg.Picture = loc_cArquivo
        ENDIF
      ENDIF
      IF USED("cursor_4c_TmpImg")
        USE IN cursor_4c_TmpImg
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: imagem nao disponivel (cursor/SQLEXEC pode falhar, FigJpgs vazio); produto exibe sem foto
    ENDTRY

    loc_oImg = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarCaracteristicas: carrega grid de caracteristicas do filtro
  PROTECTED PROCEDURE CarregarCaracteristicas
    LOCAL loc_cSQL, loc_nRet
    TRY
      loc_cSQL = "Select 0 as marcado, Codigos as cods, " + ;
        "Codigos as descs From SigCrRap"
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCaract")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpCaract")
        IF USED("cursor_4c_Caract")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = ""
          SELECT cursor_4c_Caract
          SELECT cursor_4c_Caract
          ZAP
          APPEND FROM DBF("cursor_4c_TmpCaract")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.ColumnCount = 2
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = "cursor_4c_Caract"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.ControlSource  = "cursor_4c_Caract.marcado"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.Header1.Caption = ""
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.ControlSource  = "cursor_4c_Caract.descs"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.Header1.Caption = "Caracter" + CHR(237) + "stica"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Refresh()
        ENDIF
        USE IN cursor_4c_TmpCaract
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: caracteristicas nao disponiveis para o produto; grid permanece vazio sem dialog
    ENDTRY
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarTiposOperacao: carrega grid de tipos de operacao
  PROTECTED PROCEDURE CarregarTiposOperacao
    LOCAL loc_cSQL, loc_nRet
    TRY
      loc_cSQL = "Select 0 as marcado, Codigos as ctipo, " + ;
        "Descrs as dtipo From SigCdTom"
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTOpe")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpTOpe")
        IF USED("cursor_4c_TOpe")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = ""
          SELECT cursor_4c_TOpe
          SELECT cursor_4c_TOpe
          ZAP
          APPEND FROM DBF("cursor_4c_TmpTOpe")
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.ColumnCount = 3
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.ControlSource  = "cursor_4c_TOpe.marcado"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.Header1.Caption = ""
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.ControlSource  = "cursor_4c_TOpe.ctipo"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.Header1.Caption = "C" + CHR(243) + "d"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.ControlSource  = "cursor_4c_TOpe.dtipo"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
          THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Refresh()
        ENDIF
        USE IN cursor_4c_TmpTOpe
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: tipos de operacao nao disponiveis para o produto; grid permanece vazio sem dialog
    ENDTRY
  ENDPROC

  *------------------------------------------------------------
  *-- MontaStrTpOpe: monta string IN para filtro de tipos de operacao
  PROTECTED PROCEDURE MontaStrTpOpe
    LOCAL loc_cResult
    loc_cResult = ""

    IF !USED("cursor_4c_TOpe")
      RETURN loc_cResult
    ENDIF

    SELECT cursor_4c_TOpe
    SCAN FOR cursor_4c_TOpe.marcado
      IF !EMPTY(loc_cResult)
        loc_cResult = loc_cResult + ","
      ENDIF
      loc_cResult = loc_cResult + "'" + ;
        ALLTRIM(cursor_4c_TOpe.ctipo) + "'"
    ENDSCAN

    RETURN loc_cResult
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarComposicaoFiltro: carrega grid composicao do filtro
  PROTECTED PROCEDURE CarregarComposicaoFiltro
    LOCAL loc_cSQL, loc_nRet

    IF USED("CsMatPrima")
      THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = ""
      SELECT CsMatPrima
      ZAP IN CsMatPrima
    ENDIF

    TRY
      loc_cSQL = "Select cpros as mats, dpros as dcompos, " + ;
        "0.00 as qtd_inicial, 0.00 as qtd_final, " + ;
        ".F. as apenas, cgrus as Cgrus, '' as Tipos " + ;
        "From SigCdPro Where 1=0"
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMat")
      IF loc_nRet >= 1 AND USED("cursor_4c_TmpMat")
        USE IN cursor_4c_TmpMat
      ENDIF
    CATCH TO loc_oErro
      *-- INTENCIONAL: SQLEXEC inicial pode falhar (estrutura cursor); CsMatPrima sera populado por consulta real
    ENDTRY

    IF USED("CsMatPrima")
      THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = "CsMatPrima"
      THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.Refresh()
    ENDIF
  ENDPROC

  *------------------------------------------------------------
  *-- LimparCamposCabecalho: limpa todos os campos de detalhe do produto
  PROTECTED PROCEDURE LimparCamposCabecalho
    LOCAL loc_oCab

    loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho

    TRY
      loc_oCab.txt_4c__cd_fornecedor.Value  = ""
      loc_oCab.txt_4c__ds_fornecedor.Value  = ""
      loc_oCab.txt_4c__ref_fornecedor.Value = ""
      loc_oCab.txt_4c__cd_grupo.Value       = ""
      loc_oCab.txt_4c__ds_grupo.Value       = ""
      loc_oCab.txt_4c__cd_sgrupo.Value      = ""
      loc_oCab.txt_4c__ds_sgrupo.Value      = ""
      loc_oCab.txt_4c_CdLinha.Value         = ""
      loc_oCab.txt_4c_DsLinha.Value         = ""
      loc_oCab.txt_4c_GrVenda.Value         = ""
      loc_oCab.txt_4c_GrDvenda.Value        = ""
      loc_oCab.txt_4c__cd_unidade.Value     = ""
      loc_oCab.txt_4c__cd_ggrupo.Value      = ""
      loc_oCab.txt_4c__ds_ggrupo.Value      = ""
      loc_oCab.txt_4c_CodFinP.Value         = ""
      loc_oCab.txt_4c_DesFinP.Value         = ""
      loc_oCab.txt_4c_Conjunto.Value        = ""
      loc_oCab.txt_4c_Equivalente.Value     = ""
      loc_oCab.txt_4c__qtd_minima.Value     = 0
      loc_oCab.txt_4c_VBars.Value           = ""
      loc_oCab.txt_4c_CodCorR.Value         = ""
      loc_oCab.txt_4c_DescCorR.Value        = ""
      loc_oCab.txt_4c_ClassifR.Value        = ""
      loc_oCab.txt_4c_PrVendaR.Value        = 0
      loc_oCab.txt_4c_MoePrVR.Value         = ""
      loc_oCab.txt_4c_PesoMedioR.Value      = 0
      loc_oCab.txt_4c_FatorVR.Value         = 0
      loc_oCab.txt_4c_MoeFatorR.Value       = ""
      loc_oCab.txt_4c_LocaisR.Value         = ""
      loc_oCab.txt_4c_Obs1R.Value           = ""
      loc_oCab.txt_4c_Obs2R.Value           = ""

      THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.img_4c_FigJpg.Picture = ""
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_Cabecalho/img_4c_FigJpg podem nao estar instanciados; LimparCampos eh melhor-esforco
    ENDTRY

    loc_oCab = .NULL.
  ENDPROC

  *============================================================
  *-- FASE 8: METODOS DE CONSOLIDACAO
  *============================================================

  *------------------------------------------------------------
  *-- BtnBuscarClick: executa busca usando filtros informados (alias de BtnConsultarClick)
  PROCEDURE BtnBuscarClick
    THIS.BtnConsultarClick()
  ENDPROC

  *------------------------------------------------------------
  *-- BtnEncerrarClick: encerra o formulario
  PROCEDURE BtnEncerrarClick
    THIS.Release()
  ENDPROC

  *------------------------------------------------------------
  *-- BtnSalvarClick: salva alteracao de preco do produto selecionado
  PROCEDURE BtnSalvarClick
    LOCAL loc_lSucesso, loc_cCodPro, loc_oCab
    LOCAL loc_cSQL, loc_nRet

    loc_lSucesso = .F.

    IF !THIS.this_lAlteraPreco
      MsgAviso("Altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o n" + CHR(227) + "o habilitada.")
      RETURN
    ENDIF

    IF !USED("CrProdutos") OR RECCOUNT("CrProdutos") = 0
      MsgAviso("Nenhum produto selecionado.")
      RETURN
    ENDIF

    SELECT CrProdutos
    IF EOF()
      MsgAviso("Nenhum produto selecionado.")
      RETURN
    ENDIF

    loc_cCodPro = ALLTRIM(CrProdutos.cpros)
    IF EMPTY(loc_cCodPro)
      MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o identificado.")
      RETURN
    ENDIF

    loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho

    TRY
      *-- Recarregar dados atuais do produto do banco para nao perder campos nao editaveis
      loc_cSQL = "SELECT dpros, cgrus, sgrus, cunis, ifors, reffs, " + ;
        "pcuss, moecs, pesoms, fcustos, margems, pvens, valors " + ;
        "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSalvar")

      IF loc_nRet >= 1 AND USED("cursor_4c_TmpSalvar") AND !EOF("cursor_4c_TmpSalvar")
        GO TOP IN cursor_4c_TmpSalvar

        THIS.this_oBusinessObject.this_cCodPro        = loc_cCodPro
        THIS.this_oBusinessObject.this_cDescPro       = ALLTRIM(NVL(cursor_4c_TmpSalvar.dpros,   ""))
        THIS.this_oBusinessObject.this_cGrupoPro      = ALLTRIM(NVL(cursor_4c_TmpSalvar.cgrus,   ""))
        THIS.this_oBusinessObject.this_cSubGrupoPro   = ALLTRIM(NVL(cursor_4c_TmpSalvar.sgrus,   ""))
        THIS.this_oBusinessObject.this_cUnidadePro    = ALLTRIM(NVL(cursor_4c_TmpSalvar.cunis,   ""))
        THIS.this_oBusinessObject.this_cFornecedorPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.ifors,   ""))
        THIS.this_oBusinessObject.this_cRefPro        = ALLTRIM(NVL(cursor_4c_TmpSalvar.reffs,   ""))
        THIS.this_oBusinessObject.this_nPrecoCusto    = NVL(cursor_4c_TmpSalvar.pcuss,   0)
        THIS.this_oBusinessObject.this_cMoedaCustoPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.moecs,   ""))
        THIS.this_oBusinessObject.this_nMargem        = NVL(cursor_4c_TmpSalvar.margems, 0)
        THIS.this_oBusinessObject.this_nCustoEstimado = NVL(cursor_4c_TmpSalvar.valors,  0)

        *-- Campos editaveis pelo usuario (preco, peso, fator)
        THIS.this_oBusinessObject.this_nPrecoVenda  = NVL(loc_oCab.txt_4c_PrVendaR.Value,   0)
        THIS.this_oBusinessObject.this_nPesoMedio   = NVL(loc_oCab.txt_4c_PesoMedioR.Value, 0)
        THIS.this_oBusinessObject.this_nFatorCusto  = NVL(loc_oCab.txt_4c_FatorVR.Value,    0)

        IF USED("cursor_4c_TmpSalvar")
          USE IN cursor_4c_TmpSalvar
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.Atualizar()

        IF loc_lSucesso
          MsgInfo("Pre" + CHR(231) + "o atualizado com sucesso.")
          *-- Restaurar ReadOnly nos campos de preco apos salvar
          loc_oCab.txt_4c_PrVendaR.ReadOnly   = .T.
          loc_oCab.txt_4c_MoePrVR.ReadOnly    = .T.
          loc_oCab.txt_4c_PesoMedioR.ReadOnly = .T.
          loc_oCab.txt_4c_FatorVR.ReadOnly    = .T.
          loc_oCab.txt_4c_MoeFatorR.ReadOnly  = .T.
          THIS.AjustarBotoesPorModo()
        ELSE
          MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
        ENDIF
      ELSE
        IF USED("cursor_4c_TmpSalvar")
          USE IN cursor_4c_TmpSalvar
        ENDIF
        MsgErro("Produto n" + CHR(227) + "o encontrado no banco de dados.", "Erro")
      ENDIF

    CATCH TO loc_oErro
      MsgErro("Erro ao salvar: " + loc_oErro.Message, "Erro")
      IF USED("cursor_4c_TmpSalvar")
        USE IN cursor_4c_TmpSalvar
      ENDIF
    ENDTRY

    loc_oCab = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- FormParaBO: copia todos os campos do formulario para propriedades do BO
  PROTECTED PROCEDURE FormParaBO
    LOCAL loc_oPag, loc_cPesoI, loc_cPesoF, loc_cCustoI, loc_cCustoF

    IF VARTYPE(THIS.this_oBusinessObject) != "O"
      RETURN
    ENDIF

    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    TRY
      *-- Produto / Descricao
      THIS.this_oBusinessObject.this_cProdutoInicial = ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value)
      THIS.this_oBusinessObject.this_cProdutoFinal   = ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value)
      THIS.this_oBusinessObject.this_cDescricao      = ALLTRIM(loc_oPag.txt_4c_Descricao.Value)
      THIS.this_oBusinessObject.this_cDescritivo     = ALLTRIM(loc_oPag.txt_4c_Descritivo.Value)
      THIS.this_oBusinessObject.this_cCodigoBarra    = ALLTRIM(loc_oPag.txt_4c_Barra.Value)

      *-- Equivalente
      THIS.this_oBusinessObject.this_lEquivalentes   = (loc_oPag.chk_4c_Equiv.Value = 1)
      THIS.this_oBusinessObject.this_cEquivalente    = ;
        IIF(loc_oPag.chk_4c_Equiv.Value = 1, ALLTRIM(loc_oPag.txt_4c_Equiv.Value), "")

      *-- Grupo / SubGrupo / Grande Grupo
      THIS.this_oBusinessObject.this_cGrandeGrupoCod = ALLTRIM(loc_oPag.txt_4c_Gde.Value)
      THIS.this_oBusinessObject.this_cGrupoCod       = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
      THIS.this_oBusinessObject.this_cGrupoDesc      = ALLTRIM(loc_oPag.txt_4c_DsGrupo.Value)
      THIS.this_oBusinessObject.this_cSubgrupoCod    = ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value)
      THIS.this_oBusinessObject.this_cSubgrupoDesc   = ALLTRIM(loc_oPag.txt_4c_DsSGrupo.Value)

      *-- Linha / Colecao (GrupoVenda I/F)
      THIS.this_oBusinessObject.this_cLinha   = ALLTRIM(loc_oPag.txt_4c_LinhaI.Value)
      THIS.this_oBusinessObject.this_cLinha2  = ALLTRIM(loc_oPag.txt_4c_LinhaF.Value)
      THIS.this_oBusinessObject.this_cColuna  = ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value)
      THIS.this_oBusinessObject.this_cColuna2 = ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value)

      *-- Modelo I/F (CodFinP)
      THIS.this_oBusinessObject.this_cModeloInicial = ALLTRIM(loc_oPag.txt_4c_CodFinP.Value)
      THIS.this_oBusinessObject.this_cModeloFinal   = ALLTRIM(loc_oPag.txt_4c_CodFinPF.Value)

      *-- Pesos
      loc_cPesoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoI.Value), ",", "")
      loc_cPesoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoF.Value), ",", "")
      THIS.this_oBusinessObject.this_nPesoInicial = VAL(loc_cPesoI)
      THIS.this_oBusinessObject.this_nPesoFinal   = VAL(loc_cPesoF)

      *-- Custo / Moeda
      loc_cCustoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoI.Value), ",", "")
      loc_cCustoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_CustoF.Value), ",", "")
      THIS.this_oBusinessObject.this_nCustoInicial = VAL(loc_cCustoI)
      THIS.this_oBusinessObject.this_nCustoFinal   = VAL(loc_cCustoF)
      THIS.this_oBusinessObject.this_cMoedaCusto   = ALLTRIM(loc_oPag.txt_4c_MoeCusto.Value)

      *-- Faixa de preco / Classificacao
      THIS.this_oBusinessObject.this_cFxPreco        = ALLTRIM(loc_oPag.txt_4c_FxPreco.Value)
      THIS.this_oBusinessObject.this_cClassificacao  = ALLTRIM(loc_oPag.txt_4c_Classe.Value)

      *-- Cor
      THIS.this_oBusinessObject.this_cCorCod  = ALLTRIM(loc_oPag.txt_4c_Cor.Value)
      THIS.this_oBusinessObject.this_cCorDesc = ALLTRIM(loc_oPag.txt_4c_DCor.Value)

      *-- Lista / Promocao
      THIS.this_oBusinessObject.this_cListaPrecos = ALLTRIM(loc_oPag.txt_4c_Lista.Value)
      THIS.this_oBusinessObject.this_cPromocao    = ALLTRIM(loc_oPag.txt_4c_Promo.Value)

      *-- Fornecedor / Referencia
      THIS.this_oBusinessObject.this_cFornecedorCod      = ALLTRIM(loc_oPag.txt_4c_CdFornec.Value)
      THIS.this_oBusinessObject.this_cFornecedorDesc     = ALLTRIM(loc_oPag.txt_4c_DsFornec.Value)
      THIS.this_oBusinessObject.this_cRefFornecedor      = ALLTRIM(loc_oPag.txt_4c_RefFornec.Value)
      THIS.this_oBusinessObject.this_cRefFornecedorFinal = ALLTRIM(loc_oPag.txt_4c_RefFornecF.Value)
      THIS.this_oBusinessObject.this_nOptTipoRef         = loc_oPag.opt_4c_TpReffs.Value

      *-- Situacao / Imagem
      THIS.this_oBusinessObject.this_nSituacao = loc_oPag.cmb_4c_Situas.ListIndex
      THIS.this_oBusinessObject.this_nImagem   = loc_oPag.cmb_4c_Imagem.ListIndex

      *-- Datas alteracao
      THIS.this_oBusinessObject.this_dDataAltInicial = CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltI.Value))
      THIS.this_oBusinessObject.this_dDataAltFinal   = CTOD(ALLTRIM(loc_oPag.txt_4c_DtAltF.Value))
      THIS.this_oBusinessObject.this_nOptTipoDataCad = loc_oPag.opt_4c_TpDtCad.Value

      *-- Datas operacao
      THIS.this_oBusinessObject.this_dDataOperInicial = CTOD(ALLTRIM(loc_oPag.txt_4c_DtOpeI.Value))
      THIS.this_oBusinessObject.this_dDataOperFinal   = CTOD(ALLTRIM(loc_oPag.txt_4c_DtOpeF.Value))
      THIS.this_oBusinessObject.this_nOptTipoData     = loc_oPag.opt_4c_TpData.Value
      THIS.this_oBusinessObject.this_nOptOperacao     = loc_oPag.opt_4c_Operacao.Value

      *-- Pagamento
      THIS.this_oBusinessObject.this_nOptPagamento = loc_oPag.opt_4c_Pagamento.Value

      *-- Empresa / GrupoCC / Conta CC
      THIS.this_oBusinessObject.this_cEmpresaDesc = ALLTRIM(loc_oPag.txt_4c_DsEmps.Value)
      THIS.this_oBusinessObject.this_cContaCod    = ALLTRIM(loc_oPag.txt_4c_GrupoCC.Value)
      THIS.this_oBusinessObject.this_cContaNome   = ALLTRIM(loc_oPag.txt_4c_NGrupoCC.Value)
      THIS.this_oBusinessObject.this_cContaOCod   = ALLTRIM(loc_oPag.txt_4c_CdConta.Value)
      THIS.this_oBusinessObject.this_cContaONome  = ALLTRIM(loc_oPag.txt_4c_NConta.Value)

      *-- Marcacao Todos Tipos Operacao
      THIS.this_oBusinessObject.this_lMarcaTodosOpe = (loc_oPag.chk_4c_MarcaTOpe.Value = 1)

    CATCH TO loc_oErro
      MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
    ENDTRY

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- BOParaForm: copia propriedades do BO para os campos do formulario
  PROTECTED PROCEDURE BOParaForm
    LOCAL loc_oPag

    IF VARTYPE(THIS.this_oBusinessObject) != "O"
      RETURN
    ENDIF

    loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    TRY
      *-- Produto / Descricao
      loc_oPag.txt_4c_ProdutoI.Value   = THIS.this_oBusinessObject.this_cProdutoInicial
      loc_oPag.txt_4c_ProdutoF.Value   = THIS.this_oBusinessObject.this_cProdutoFinal
      loc_oPag.txt_4c_Descricao.Value  = THIS.this_oBusinessObject.this_cDescricao
      loc_oPag.txt_4c_Descritivo.Value = THIS.this_oBusinessObject.this_cDescritivo
      loc_oPag.txt_4c_Barra.Value      = THIS.this_oBusinessObject.this_cCodigoBarra

      *-- Equivalente
      loc_oPag.txt_4c_Equiv.Value   = THIS.this_oBusinessObject.this_cEquivalente
      loc_oPag.chk_4c_Equiv.Value   = IIF(!EMPTY(THIS.this_oBusinessObject.this_cEquivalente), 1, 0)

      *-- Grupo / SubGrupo / Grande Grupo
      loc_oPag.txt_4c_Gde.Value       = THIS.this_oBusinessObject.this_cGrandeGrupoCod
      loc_oPag.txt_4c_CdGrupo.Value   = THIS.this_oBusinessObject.this_cGrupoCod
      loc_oPag.txt_4c_DsGrupo.Value   = THIS.this_oBusinessObject.this_cGrupoDesc
      loc_oPag.txt_4c_CdSGrupo.Value  = THIS.this_oBusinessObject.this_cSubgrupoCod
      loc_oPag.txt_4c_DsSGrupo.Value  = THIS.this_oBusinessObject.this_cSubgrupoDesc

      *-- Linha / Colecao
      loc_oPag.txt_4c_LinhaI.Value  = THIS.this_oBusinessObject.this_cLinha
      loc_oPag.txt_4c_LinhaF.Value  = THIS.this_oBusinessObject.this_cLinha2
      loc_oPag.txt_4c_GrupoVI.Value = THIS.this_oBusinessObject.this_cColuna
      loc_oPag.txt_4c_GrupoVF.Value = THIS.this_oBusinessObject.this_cColuna2

      *-- Modelo I/F
      loc_oPag.txt_4c_CodFinP.Value  = THIS.this_oBusinessObject.this_cModeloInicial
      loc_oPag.txt_4c_CodFinPF.Value = THIS.this_oBusinessObject.this_cModeloFinal

      *-- Cor / Classificacao / Faixa
      loc_oPag.txt_4c_Cor.Value    = THIS.this_oBusinessObject.this_cCorCod
      loc_oPag.txt_4c_DCor.Value   = THIS.this_oBusinessObject.this_cCorDesc
      loc_oPag.txt_4c_Classe.Value = THIS.this_oBusinessObject.this_cClassificacao
      loc_oPag.txt_4c_FxPreco.Value = THIS.this_oBusinessObject.this_cFxPreco

      *-- Lista / Promocao
      loc_oPag.txt_4c_Lista.Value = THIS.this_oBusinessObject.this_cListaPrecos
      loc_oPag.txt_4c_Promo.Value = THIS.this_oBusinessObject.this_cPromocao

      *-- Moeda custo
      loc_oPag.txt_4c_MoeCusto.Value = THIS.this_oBusinessObject.this_cMoedaCusto

      *-- Fornecedor / Referencia
      loc_oPag.txt_4c_CdFornec.Value   = THIS.this_oBusinessObject.this_cFornecedorCod
      loc_oPag.txt_4c_DsFornec.Value   = THIS.this_oBusinessObject.this_cFornecedorDesc
      loc_oPag.txt_4c_RefFornec.Value  = THIS.this_oBusinessObject.this_cRefFornecedor
      loc_oPag.txt_4c_RefFornecF.Value = THIS.this_oBusinessObject.this_cRefFornecedorFinal
      loc_oPag.opt_4c_TpReffs.Value    = THIS.this_oBusinessObject.this_nOptTipoRef

      *-- Situacao / Imagem
      loc_oPag.cmb_4c_Situas.ListIndex = THIS.this_oBusinessObject.this_nSituacao
      loc_oPag.cmb_4c_Imagem.ListIndex = THIS.this_oBusinessObject.this_nImagem

      *-- Datas alteracao
      loc_oPag.txt_4c_DtAltI.Value  = IIF(EMPTY(THIS.this_oBusinessObject.this_dDataAltInicial), "", ;
        DTOC(THIS.this_oBusinessObject.this_dDataAltInicial))
      loc_oPag.txt_4c_DtAltF.Value  = IIF(EMPTY(THIS.this_oBusinessObject.this_dDataAltFinal), "", ;
        DTOC(THIS.this_oBusinessObject.this_dDataAltFinal))
      loc_oPag.opt_4c_TpDtCad.Value = THIS.this_oBusinessObject.this_nOptTipoDataCad

      *-- Datas operacao
      loc_oPag.txt_4c_DtOpeI.Value   = IIF(EMPTY(THIS.this_oBusinessObject.this_dDataOperInicial), "", ;
        DTOC(THIS.this_oBusinessObject.this_dDataOperInicial))
      loc_oPag.txt_4c_DtOpeF.Value   = IIF(EMPTY(THIS.this_oBusinessObject.this_dDataOperFinal), "", ;
        DTOC(THIS.this_oBusinessObject.this_dDataOperFinal))
      loc_oPag.opt_4c_TpData.Value    = THIS.this_oBusinessObject.this_nOptTipoData
      loc_oPag.opt_4c_Operacao.Value  = THIS.this_oBusinessObject.this_nOptOperacao

      *-- Pagamento
      loc_oPag.opt_4c_Pagamento.Value = THIS.this_oBusinessObject.this_nOptPagamento

      *-- Empresa / GrupoCC / Conta CC
      loc_oPag.txt_4c_DsEmps.Value   = THIS.this_oBusinessObject.this_cEmpresaDesc
      loc_oPag.txt_4c_GrupoCC.Value  = THIS.this_oBusinessObject.this_cContaCod
      loc_oPag.txt_4c_NGrupoCC.Value = THIS.this_oBusinessObject.this_cContaNome
      loc_oPag.txt_4c_CdConta.Value  = THIS.this_oBusinessObject.this_cContaOCod
      loc_oPag.txt_4c_NConta.Value   = THIS.this_oBusinessObject.this_cContaONome

    CATCH TO loc_oErro
      MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
    ENDTRY

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- HabilitarCampos: habilita/desabilita controles conforme permissao de alteracao de preco
  PROTECTED PROCEDURE HabilitarCampos
    LOCAL loc_oPag, loc_lPode, loc_oCab

    loc_lPode = THIS.this_lAlteraPreco
    loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

    TRY
      *-- Filtros de consulta sempre habilitados
      loc_oPag.txt_4c_ProdutoI.Enabled  = .T.
      loc_oPag.txt_4c_ProdutoF.Enabled  = .T.
      loc_oPag.txt_4c_Descricao.Enabled = .T.
      loc_oPag.txt_4c_Descritivo.Enabled = .T.
      loc_oPag.txt_4c_Barra.Enabled     = .T.
      loc_oPag.txt_4c_Equiv.Enabled     = .T.
      loc_oPag.chk_4c_Equiv.Enabled     = .T.
      loc_oPag.txt_4c_CdGrupo.Enabled   = .T.
      loc_oPag.txt_4c_CdSGrupo.Enabled  = .T.
      loc_oPag.txt_4c_CdFornec.Enabled  = .T.
      loc_oPag.txt_4c_RefFornec.Enabled = .T.
      loc_oPag.txt_4c_Cor.Enabled       = .T.
    CATCH TO loc_oErro
      *-- INTENCIONAL: filtros podem nao estar instanciados; Enabled eh melhor-esforco
    ENDTRY

    TRY
      *-- Campos de preco no resultado: editaveis somente se lAlteraPreco = .T.
      loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
      loc_oCab.txt_4c_PrVendaR.ReadOnly   = !loc_lPode
      loc_oCab.txt_4c_MoePrVR.ReadOnly    = !loc_lPode
      loc_oCab.txt_4c_PesoMedioR.ReadOnly = !loc_lPode
      loc_oCab.txt_4c_FatorVR.ReadOnly    = !loc_lPode
      loc_oCab.txt_4c_MoeFatorR.ReadOnly  = !loc_lPode
      loc_oCab = .NULL.
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_Cabecalho de resultado pode nao estar instanciado; ReadOnly eh melhor-esforco
    ENDTRY

    THIS.AjustarBotoesPorModo()

    loc_oPag = .NULL.
  ENDPROC

  *------------------------------------------------------------
  *-- LimparCampos: limpa todos os campos de filtro (delega para GrpLimparFiltrosClick)
  PROCEDURE LimparCampos
    THIS.GrpLimparFiltrosClick()
  ENDPROC

  *------------------------------------------------------------
  *-- CarregarLista: executa a consulta e carrega os grids de resultado
  PROCEDURE CarregarLista
    THIS.BtnConsultarClick()
  ENDPROC

  *------------------------------------------------------------
  *-- AjustarBotoesPorModo: habilita/desabilita botoes de acao conforme permissoes e estado
  PROTECTED PROCEDURE AjustarBotoesPorModo
    LOCAL loc_oCnt, loc_lHabilitar

    loc_lHabilitar = THIS.this_lAlteraPreco AND THIS.this_lConsultaExecutada

    TRY
      loc_oCnt = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao
      loc_oCnt.cmd_4c_Salvar.Enabled   = loc_lHabilitar
      loc_oCnt.cmd_4c_Cancelar.Enabled = loc_lHabilitar
      loc_oCnt = .NULL.
    CATCH TO loc_oErro
      *-- INTENCIONAL: cnt_4c_BotoesAcao pode nao estar instanciado; Enabled eh melhor-esforco
    ENDTRY
  ENDPROC

ENDDEFINE
