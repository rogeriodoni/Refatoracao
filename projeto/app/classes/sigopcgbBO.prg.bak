*------------------------------------------------------------------------------
* sigopcgbBO.prg - Business Object para Pesquisa Global de Codigo de Barras
* Form OPERACIONAL: SIGOPCGB (Formsigopcgb)
*
* Form de CONSULTA/PESQUISA (sem CRUD de entidade propria): a partir de um
* codigo de barras digitado, localiza a etiqueta (SigOpEtq), o produto
* (SigCdPro), monta o historico de movimentacao (SigMvHst/SigMvItn/SigMvIts/
* SigMvCab/SigMvMov) e as devolucoes em aberto (SigOpExi).
*
* Tabelas principais consultadas: SigOpEtq, SigOpEta, SigCdPro, SigCdCli,
* SigCdCtg, SigCdLpI, SigCdLpc, SigMvHst, SigMvItn, SigMvIts, SigMvCab,
* SigMvMov, SigOpExi, SigCdUni, SigCdOpe, SigCdPam, SigCdEmp
*
* Fase 1/8: Propriedades e Init()
*------------------------------------------------------------------------------
DEFINE CLASS sigopcgbBO AS BusinessBase

    *-- ===================================================================
    *-- IDENTIFICACAO DA ENTIDADE (etiqueta / codigo de barras pesquisado)
    *-- ===================================================================
    this_cTabela      = "SigOpEtq"
    this_cCampoChave  = "CBars"

    *-- ===================================================================
    *-- EMPRESA LOGADA (CsSigCdEmp no legado)
    *-- ===================================================================
    this_cCodEmpresa    = ""
    this_cRazaoEmpresa  = ""

    *-- ===================================================================
    *-- CODIGO DE BARRAS PESQUISADO / RESULTADO DA ETIQUETA (SigOpEtq)
    *-- ===================================================================
    this_nCodBarras         = 0
    this_nCodBarraAnterior  = 0
    this_cCodProduto        = ""
    this_cLocalizacao       = ""
    this_cOrigem            = ""
    this_cEmpresaOp         = ""
    this_cGrupoOp           = ""
    this_cContaOp           = ""
    this_nQtdeOp            = 0
    this_nPesoOp            = 0

    *-- ===================================================================
    *-- DADOS DO PRODUTO ENCONTRADO (TmpPro no legado)
    *-- ===================================================================
    this_cDescProduto       = ""
    this_cCodFornecedor     = ""
    this_cDescFornecedor    = ""
    this_cReferencia        = ""
    this_cColecao           = ""
    this_cCategoria         = ""
    this_nPrecoVenda        = 0
    this_nPrecoDe           = 0
    this_cUnidade           = ""
    this_cUnidadePeso       = ""
    this_cFigJpgBase64      = ""

    *-- ===================================================================
    *-- PRODUTO DA LINHA CORRENTE DO HISTORICO/MOVIMENTO (GetCProSHis/GetDProSHis)
    *-- ===================================================================
    this_cCodProdutoHist    = ""
    this_cDescProdutoHist   = ""
    this_cFigJpgProdutoHist = ""

    *-- ===================================================================
    *-- ESTADO DO FORMULARIO
    *-- ===================================================================
    this_nGradeSel          = 1      && 1=Historico 2=Movimento 3=Devolucao
    this_nTipoBusca         = 1
    this_lHabilitaValor     = .F.    && .T. quando nao ha unidade com cEstos = '3'
    this_lControlaLotes     = .F.    && .T. se existe SigCdOpe com ctrllotes 1 ou 2

    *-- ===================================================================
    *-- CONTROLE DE ACESSO (fChecaAcesso no legado)
    *-- ===================================================================
    this_lAcessoDocumento   = .F.
    this_lAcessoImprimir    = .F.
    this_lAcessoVisualizar  = .F.
    this_lAcessoRastro      = .F.
    this_lAcessoCorrecao    = .F.
    this_lAcessoFornecedor  = .F.
    this_lAcessoFollowUp    = .F.

    *-- ===================================================================
    *-- DOCUMENTO LOCALIZADO PARA O BtnDocumentoClick (CongBEest no legado)
    *-- ===================================================================
    this_cEmpsDocto         = ""
    this_cDopesDocto        = ""
    this_nNumesDocto        = 0

    *-- ===================================================================
    *-- INIT
    *-- ===================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpEtq"
            THIS.this_cCampoChave = "CBars"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar sigopcgbBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigOpEtq (etiqueta/codigo de
    * barras) para as propriedades this_* da entidade pesquisada.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_nCodBarras    = NVL(cbars, 0)
        THIS.this_cCodProduto   = TratarNulo(cpros, "")
        *-- Origem: o legado NAO usa empos aqui. O Processamento faz
        *-- getOrigem.Value = Left(TmpEti.codamss, 3) e Get_Empresa.Value = TmpEti.empos,
        *-- isto eh, sao campos DIFERENTES (codamss x empos) em controles diferentes.
        THIS.this_cOrigem       = LEFT(TratarNulo(codamss, ""), 3)
        THIS.this_cEmpresaOp    = TratarNulo(empos, "")
        THIS.this_cGrupoOp      = TratarNulo(grupos, "")
        THIS.this_cContaOp      = TratarNulo(contas, "")
        THIS.this_nQtdeOp       = NVL(qtds, 0)
        *-- Legado (Tiago, 25/04/2013): peso total = pesos + peso2s - quando o
        *-- peso do metal eh gravado separado na etiqueta, o peso final da
        *-- peca so aparece somando os dois.
        THIS.this_nPesoOp       = NVL(pesos, 0) + NVL(peso2s, 0)
        THIS.this_cLocalizacao  = TratarNulo(localizas, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do registro de etiqueta corrente (CBars)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodBarras)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEtiquetaPorCodBarras - Localiza a etiqueta pelo codigo de barras
    * digitado, resolvendo renumeracao (SigOpEta.cbars_old -> cbars_new), e
    * carrega os dados da etiqueta ATUAL em THIS (equivalente ao getBarras.Valid
    * do legado: Select a.CPros,a.CBars,b.cbars_old From SigOpEtq a left join
    * SigOpEta b on a.cpros = b.cpros and a.cbars = b.cbars_new Where
    * (a.CBars = ? or b.cbars_old = ?)).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEtiquetaPorCodBarras(par_nCodBarras)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCBarsAtual, loc_nCBarsAntigo

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        *-- Reinicia os dados da pesquisa anterior. Sem isso, uma busca que
        *-- cai no fallback por SigCdPro (sem etiqueta) herdaria em silencio
        *-- os dados de empresa/grupo/conta/local/peso da busca anterior.
        THIS.this_cCodProduto       = ""
        THIS.this_cOrigem           = ""
        THIS.this_cEmpresaOp        = ""
        THIS.this_cGrupoOp          = ""
        THIS.this_cContaOp          = ""
        THIS.this_nQtdeOp           = 0
        THIS.this_nPesoOp           = 0
        THIS.this_cLocalizacao      = ""
        THIS.this_nCodBarraAnterior = 0

        IF VARTYPE(par_nCodBarras) != "N" OR par_nCodBarras <= 0
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras inv" + CHR(225) + "lido."
            RETURN .F.
        ENDIF

        THIS.this_nCodBarras = par_nCodBarras

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- 1) Resolve renumeracao (cbars_old -> cbars_new) e localiza a etiqueta
            loc_cSQL = "SELECT a.CBars, a.CPros, b.cbars_old " + ;
                       "FROM SigOpEtq a " + ;
                       "LEFT JOIN SigOpEta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                       "WHERE a.CBars = " + FormatarNumeroSQL(par_nCodBarras, 0) + ;
                       " OR b.cbars_old = " + FormatarNumeroSQL(par_nCodBarras, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtqResolvida")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_EtqResolvida") > 0
                SELECT cursor_4c_EtqResolvida
                GO TOP
                loc_nCBarsAtual  = NVL(CBars, 0)
                loc_nCBarsAntigo = NVL(cbars_old, 0)

                IF USED("cursor_4c_EtqResolvida")
                    USE IN cursor_4c_EtqResolvida
                ENDIF

                loc_cSQL = "SELECT * FROM SigOpEtq WHERE CBars = " + FormatarNumeroSQL(loc_nCBarsAtual, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqueta")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Etiqueta") > 0
                    THIS.CarregarDoCursor("cursor_4c_Etiqueta")
                    THIS.this_nCodBarras        = loc_nCBarsAtual
                    THIS.this_nCodBarraAnterior = loc_nCBarsAntigo
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Etiqueta n" + CHR(227) + "o localizada."
                ENDIF

                IF USED("cursor_4c_Etiqueta")
                    USE IN cursor_4c_Etiqueta
                ENDIF
            ELSE
                IF USED("cursor_4c_EtqResolvida")
                    USE IN cursor_4c_EtqResolvida
                ENDIF

                *-- 2) Sem etiqueta: o legado (getBarras.Valid, ramo Else do 1o
                *-- SELECT) tambem aceita o codigo de barras gravado DIRETO no
                *-- cadastro de produto (SigCdPro.CBars) - util para produtos
                *-- sem etiqueta impressa.
                loc_cSQL = "SELECT CPros, CBars FROM SigCdPro " + ;
                           "WHERE CBars = " + FormatarNumeroSQL(par_nCodBarras, 0) + ;
                           " ORDER BY CPros"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProEtq")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ProEtq") > 0
                    SELECT cursor_4c_ProEtq
                    GO TOP
                    THIS.this_cCodProduto = TratarNulo(CPros, "")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras n" + CHR(227) + "o cadastrado."
                ENDIF

                IF USED("cursor_4c_ProEtq")
                    USE IN cursor_4c_ProEtq
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Buscar Etiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosProduto - Carrega os dados do produto encontrado (TmpPro no
    * legado: Select a.cpros,a.dpros,a.ifors,a.reffs,a.colecoes,a.pvens,
    * a.PrecoDe,a.figjpgs,a.cunis,a.cUniPs,b.rclis,a.categoria From SigCdPro a
    * Left Join SigCdCli b On b.Iclis = a.Ifors Where cpros = <cod>), a
    * descricao da categoria (SigCdCtg - "busca categoria para apresentar
    * como colecao") e a eventual override de preco pela lista de precos da
    * empresa logada (SigCdLpI/SigCdLpc).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosProduto(par_cCodProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodProduto, loc_cEmpresa
        LOCAL loc_nPVendaLista, loc_nPrecoDeLista

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        THIS.this_cDescProduto    = ""
        THIS.this_cCodFornecedor  = ""
        THIS.this_cDescFornecedor = ""
        THIS.this_cReferencia     = ""
        THIS.this_cColecao        = ""
        THIS.this_cCategoria      = ""
        THIS.this_nPrecoVenda     = 0
        THIS.this_nPrecoDe        = 0
        THIS.this_cUnidade        = ""
        THIS.this_cUnidadePeso    = ""
        THIS.this_cFigJpgBase64   = ""

        loc_cCodProduto = ALLTRIM(IIF(VARTYPE(par_cCodProduto) = "C", par_cCodProduto, ""))

        IF EMPTY(loc_cCodProduto)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ProdDados")
                USE IN cursor_4c_ProdDados
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.ifors, a.reffs, a.colecoes, a.pvens, " + ;
                       "a.precode, a.figjpgs, a.cunis, a.cunips, a.categoria, b.rclis " + ;
                       "FROM SigCdPro a LEFT JOIN SigCdCli b ON b.iclis = a.ifors " + ;
                       "WHERE a.cpros = " + EscaparSQL(loc_cCodProduto)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdDados")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha ao selecionar o produto (SigCdPro)." + ;
                    CHR(13) + CapturarErroSQL()
            ELSE
                IF RECCOUNT("cursor_4c_ProdDados") > 0
                    SELECT cursor_4c_ProdDados
                    GO TOP

                    THIS.this_cDescProduto    = TratarNulo(dpros, "")
                    THIS.this_cCodFornecedor  = TratarNulo(ifors, "")
                    THIS.this_cDescFornecedor = TratarNulo(rclis, "")
                    THIS.this_cReferencia     = TratarNulo(reffs, "")
                    THIS.this_cColecao        = TratarNulo(colecoes, "")
                    THIS.this_nPrecoVenda     = NVL(pvens, 0)
                    THIS.this_nPrecoDe        = NVL(precode, 0)
                    THIS.this_cUnidade        = TratarNulo(cunis, "")
                    THIS.this_cUnidadePeso    = TratarNulo(cunips, "")
                    THIS.this_cFigJpgBase64   = TratarNulo(figjpgs, "")

                    IF !EMPTY(ALLTRIM(TratarNulo(categoria, "")))
                        IF USED("cursor_4c_Categoria")
                            USE IN cursor_4c_Categoria
                        ENDIF

                        loc_cSQL = "SELECT descs FROM SigCdCtg WHERE cods = " + ;
                            EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_ProdDados.categoria, "")))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Categoria") > 0 ;
                                AND RECCOUNT("cursor_4c_Categoria") > 0
                            SELECT cursor_4c_Categoria
                            GO TOP
                            THIS.this_cCategoria = TratarNulo(descs, "")
                        ENDIF

                        IF USED("cursor_4c_Categoria")
                            USE IN cursor_4c_Categoria
                        ENDIF
                    ENDIF

                    loc_cEmpresa = ""
                    IF TYPE("go_4c_Sistema") = "O"
                        loc_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
                    ENDIF

                    IF !EMPTY(loc_cEmpresa)
                        IF USED("cursor_4c_ListaPreco")
                            USE IN cursor_4c_ListaPreco
                        ENDIF

                        loc_cSQL = "SELECT a.pvens, a.precode FROM SigCdLpI a, SigCdLpc b " + ;
                                   "WHERE a.lprecos = b.lprecos AND a.cpros = " + EscaparSQL(loc_cCodProduto) + ;
                                   " AND b.emps = " + EscaparSQL(loc_cEmpresa)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaPreco") > 0 ;
                                AND RECCOUNT("cursor_4c_ListaPreco") > 0
                            SELECT cursor_4c_ListaPreco
                            GO TOP
                            loc_nPVendaLista  = NVL(pvens, 0)
                            loc_nPrecoDeLista = NVL(precode, 0)

                            IF loc_nPVendaLista <> 0
                                THIS.this_nPrecoVenda = loc_nPVendaLista
                            ENDIF
                            IF loc_nPrecoDeLista <> 0
                                THIS.this_nPrecoDe = loc_nPrecoDeLista
                            ENDIF
                        ENDIF

                        IF USED("cursor_4c_ListaPreco")
                            USE IN cursor_4c_ListaPreco
                        ENDIF
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdDados")
                USE IN cursor_4c_ProdDados
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em sigopcgbBO.CarregarDadosProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarProdutoResumido - Dados RESUMIDOS de um produto (codigo,
    * descricao e imagem), usados pela grade de Movimento para mostrar o
    * produto da LINHA selecionada quando ele difere do produto pesquisado
    * (legado: grdMovimento.AfterRowColChange - Select CPros,DPros,FigJpgs
    * From SigCdPro Where CPros = <CsMovimento.CPros>).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarProdutoResumido(par_cCodProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodProduto

        loc_lSucesso = .F.
        THIS.this_cMensagemErro     = ""
        THIS.this_cCodProdutoHist   = ""
        THIS.this_cDescProdutoHist  = ""
        THIS.this_cFigJpgProdutoHist = ""

        loc_cCodProduto = ALLTRIM(IIF(VARTYPE(par_cCodProduto) = "C", par_cCodProduto, ""))

        IF EMPTY(loc_cCodProduto)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ProdResumo")
                USE IN cursor_4c_ProdResumo
            ENDIF

            loc_cSQL = "SELECT CPros, DPros, FigJpgs FROM SigCdPro WHERE CPros = " + ;
                       EscaparSQL(loc_cCodProduto)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdResumo")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ProdResumo") > 0
                SELECT cursor_4c_ProdResumo
                GO TOP
                THIS.this_cCodProdutoHist    = TratarNulo(CPros, "")
                THIS.this_cDescProdutoHist   = TratarNulo(DPros, "")
                THIS.this_cFigJpgProdutoHist = TratarNulo(FigJpgs, "")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ProdResumo")
                USE IN cursor_4c_ProdResumo
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em sigopcgbBO.CarregarProdutoResumido")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacoesPorData - Popula cursor_4c_Cotacoes com a cotacao de
    * cada moeda cadastrada em SigCdCot na data informada (legado:
    * atualizacot, chamado pelo checkbox Bot_Cotacoes e a cada troca de linha
    * da grade de Historico). fBuscarCotacao() (utils\functions.prg) reproduz
    * o SELECT TOP 1 ... ORDER BY datas DESC que o legado fazia inline.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCotacoesPorData(par_dData)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_dData

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        loc_dData = IIF(VARTYPE(par_dData) = "D", par_dData, {})

        IF !USED("cursor_4c_Cotacoes")
            THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es n" + ;
                CHR(227) + "o inicializado."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_CotMoedas")
                USE IN cursor_4c_CotMoedas
            ENDIF

            loc_cSQL = "SELECT cmoes FROM SigCdCot GROUP BY cmoes"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotMoedas")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha ao selecionar as moedas (SigCdCot)." + ;
                    CHR(13) + CapturarErroSQL()
            ELSE
                SELECT cursor_4c_Cotacoes
                ZAP

                IF USED("cursor_4c_CotMoedas")
                    SELECT cursor_4c_CotMoedas
                    GO TOP
                    DO WHILE !EOF("cursor_4c_CotMoedas")
                        INSERT INTO cursor_4c_Cotacoes (cmoes, valos) ;
                            VALUES (TratarNulo(cursor_4c_CotMoedas.cmoes, ""), ;
                                    fBuscarCotacao(cursor_4c_CotMoedas.cmoes, loc_dData))

                        SELECT cursor_4c_CotMoedas
                        SKIP
                    ENDDO
                ENDIF

                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_CotMoedas")
                USE IN cursor_4c_CotMoedas
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em sigopcgbBO.CarregarCotacoesPorData")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosIniciais - Reproduz os tres acessos que o Init legado
    * faz ANTES de montar as grades:
    *   1) Select cemps,razas From SigCdEmp Where cemps = <empresa logada>
    *      (CsSigCdEmp - usado no cabecalho da impressao da etiqueta)
    *   2) Select Count(1) as Qt From SigCdUni Where cEstos = '3'  -> Habvalor
    *      Habvalor = (Qt = 0): quando NAO existe unidade de estoque '3', a
    *      11a coluna da grade de Historico mostra VALOR; havendo, mostra PESO.
    *   3) Select * From SigCdOpe Where (ctrllotes = 1 Or ctrllotes = 2) -> TmpOpe
    *      !Eof('TmpOpe') eh uma das duas condicoes de Bot_Rastro.Visible.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosIniciais()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmpresa

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
        ELSE
            TRY
                loc_cEmpresa = ""
                IF TYPE("go_4c_Sistema") = "O"
                    loc_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
                ENDIF

                *-- 1) Empresa logada (CsSigCdEmp no legado)
                IF !EMPTY(loc_cEmpresa)
                    IF USED("cursor_4c_EmpLog")
                        USE IN cursor_4c_EmpLog
                    ENDIF

                    loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
                               "WHERE cemps = " + EscaparSQL(loc_cEmpresa)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpLog")

                    IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_EmpLog") > 0
                        SELECT cursor_4c_EmpLog
                        GO TOP
                        THIS.this_cCodEmpresa   = TratarNulo(cemps, "")
                        THIS.this_cRazaoEmpresa = TratarNulo(razas, "")
                    ENDIF

                    IF USED("cursor_4c_EmpLog")
                        USE IN cursor_4c_EmpLog
                    ENDIF
                ENDIF

                *-- 2) Habvalor: Select Count(1) as Qt From SigCdUni Where cEstos = '3'
                IF USED("cursor_4c_UniEst")
                    USE IN cursor_4c_UniEst
                ENDIF

                loc_cSQL = "SELECT COUNT(1) AS Qt FROM SigCdUni WHERE cEstos = " + EscaparSQL("3")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniEst")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_UniEst") > 0
                    SELECT cursor_4c_UniEst
                    GO TOP
                    IF VARTYPE(Qt) = "L"
                        THIS.this_lHabilitaValor = !Qt
                    ELSE
                        THIS.this_lHabilitaValor = (NVL(Qt, 0) = 0)
                    ENDIF
                ELSE
                    THIS.this_lHabilitaValor = .F.
                ENDIF

                IF USED("cursor_4c_UniEst")
                    USE IN cursor_4c_UniEst
                ENDIF

                *-- 3) Controle de lotes: SigCdOpe com ctrllotes 1 ou 2 (TmpOpe)
                IF USED("cursor_4c_OpeLote")
                    USE IN cursor_4c_OpeLote
                ENDIF

                loc_cSQL = "SELECT COUNT(1) AS Qt FROM SigCdOpe " + ;
                           "WHERE ctrllotes = " + FormatarNumeroSQL(1, 0) + ;
                           " OR ctrllotes = " + FormatarNumeroSQL(2, 0)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeLote")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_OpeLote") > 0
                    SELECT cursor_4c_OpeLote
                    GO TOP
                    THIS.this_lControlaLotes = (NVL(Qt, 0) > 0)
                ELSE
                    THIS.this_lControlaLotes = .F.
                ENDIF

                IF USED("cursor_4c_OpeLote")
                    USE IN cursor_4c_OpeLote
                ENDIF

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigopcgbBO.CarregarParametrosIniciais")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradesPorCodBarras - Popula os cursores das grades de Historico
    * e de Movimento a partir do codigo de barras (equivalente ao trecho do
    * PROCEDURE Processamento do legado que monta CsHistorico/CsMovimento).
    *
    * Os cursores cursor_4c_Historico e cursor_4c_Movimento sao criados pelo
    * FORM (CriarCursoresGrades) e aqui apenas ZERADOS e repopulados - NUNCA
    * derrubados por SQLEXEC, que zeraria o ColumnCount das grades ligadas a
    * eles. O SQL vai sempre para cursor temporario separado.
    *
    * Logica transcrita do legado, passo a passo:
    *   1) CrSigMvHst  = historico do codigo de barras (SigMvHst, Order by Seqs)
    *   2) CrSigMvItn  = itens de movimento do codigo de barras (SigMvItn x SigMvCab)
    *   3) se CrSigMvItn veio VAZIO, usa CrSigMvIts (SigMvIts) no lugar
    *   4) para cada linha do historico, calcula o valor RATEADO e insere em
    *      CsHistorico
    *   5) insere em CsMovimento os itens de movimento que NAO tem historico
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradesPorCodBarras(par_nCodBarras)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodBarras
        LOCAL loc_lUsaItn, loc_cEDN, loc_nRat, loc_cOpers, loc_dData, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_nCodBarras) != "N" OR par_nCodBarras <= 0
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras inv" + CHR(225) + "lido."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF !USED("cursor_4c_Historico") OR !USED("cursor_4c_Movimento")
                THIS.this_cMensagemErro = "Cursores das grades n" + CHR(227) + "o inicializados."
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            loc_cCodBarras = FormatarNumeroSQL(par_nCodBarras, 0)

            TRY
                *-- 1) Historico do codigo de barras (CrSigMvHst)
                IF USED("cursor_4c_HstOrig")
                    USE IN cursor_4c_HstOrig
                ENDIF

                loc_cSQL = "SELECT codbarras, cpros, emps, dopes, numes, datas, grupos, " + ;
                           "estos, opers, codcors, codtams, qtds, Pesos, OriDopNums " + ;
                           "FROM SigMvHst " + ;
                           "WHERE codbarras = " + loc_cCodBarras + " ORDER BY Seqs"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HstOrig")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha ao selecionar o hist" + CHR(243) + ;
                        "rico (SigMvHst)." + CHR(13) + CapturarErroSQL()
                ELSE
                    *-- 2) Itens de movimento (CrSigMvItn) - a data vem de SigMvCab
                    IF USED("cursor_4c_ItnOrig")
                        USE IN cursor_4c_ItnOrig
                    ENDIF

                    loc_cSQL = "SELECT a.codbarras, a.cpros, a.emps, a.dopes, a.numes, a.opers, " + ;
                               "a.units, a.totas, b.datas, a.Qtds, a.Pesos, a.EmpDopNums " + ;
                               "FROM SigMvItn a, SigMvCab b " + ;
                               "WHERE a.codbarras = " + loc_cCodBarras + ;
                               " AND a.empdopnums = b.empdopnums"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOrig")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Falha ao selecionar as movimenta" + CHR(231) + ;
                            CHR(245) + "es (SigMvItn)." + CHR(13) + CapturarErroSQL()
                    ELSE
                        *-- Chave POSICIONAL emps(3) + dopes(20) + STR(numes,6) = 29 chars
                        *-- (= EmpDopNums char(29)). NUNCA usar ALLTRIM nas partes.
                        SELECT cursor_4c_ItnOrig
                        INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                        GO TOP

                        loc_lUsaItn = !EOF("cursor_4c_ItnOrig")

                        *-- 3) Sem itens em SigMvItn: o legado cai para SigMvIts
                        IF !loc_lUsaItn
                            IF USED("cursor_4c_ItsOrig")
                                USE IN cursor_4c_ItsOrig
                            ENDIF

                            loc_cSQL = "SELECT codbarras, cpros, emps, dopes, numes, EmpDopNums " + ;
                                       "FROM SigMvIts WHERE codbarras = " + loc_cCodBarras

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItsOrig")

                            IF loc_nResultado < 0
                                THIS.this_cMensagemErro = "Falha ao selecionar as movimenta" + ;
                                    CHR(231) + CHR(245) + "es (SigMvIts)." + CHR(13) + CapturarErroSQL()
                            ENDIF
                        ENDIF

                        IF EMPTY(THIS.this_cMensagemErro)
                            *-- 4) Zera as grades e remonta o historico com o valor rateado
                            ZAP IN cursor_4c_Historico
                            ZAP IN cursor_4c_Movimento

                            SELECT cursor_4c_HstOrig
                            GO TOP
                            DO WHILE !EOF("cursor_4c_HstOrig")
                                loc_cEDN = TratarNulo(cursor_4c_HstOrig.OriDopNums, "")
                                loc_nRat = THIS.CalcularValorRateado(loc_cEDN)

                                INSERT INTO cursor_4c_Historico ;
                                    (codbarras, cpros, emps, dopes, numes, datas, grupos, estos, ;
                                     opers, codcors, codtams, valor, Qtds, Pesos, OriDopNums) ;
                                    VALUES ;
                                    (NVL(cursor_4c_HstOrig.codbarras, 0), ;
                                     TratarNulo(cursor_4c_HstOrig.cpros, ""), ;
                                     TratarNulo(cursor_4c_HstOrig.emps, ""), ;
                                     TratarNulo(cursor_4c_HstOrig.dopes, ""), ;
                                     NVL(cursor_4c_HstOrig.numes, 0), ;
                                     ConverterParaData(cursor_4c_HstOrig.datas), ;
                                     TratarNulo(cursor_4c_HstOrig.grupos, ""), ;
                                     TratarNulo(cursor_4c_HstOrig.estos, ""), ;
                                     TratarNulo(cursor_4c_HstOrig.opers, ""), ;
                                     TratarNulo(cursor_4c_HstOrig.codcors, ""), ;
                                     TratarNulo(cursor_4c_HstOrig.codtams, ""), ;
                                     loc_nRat, ;
                                     NVL(cursor_4c_HstOrig.qtds, 0), ;
                                     NVL(cursor_4c_HstOrig.Pesos, 0), ;
                                     loc_cEDN)

                                SELECT cursor_4c_HstOrig
                                SKIP
                            ENDDO

                            *-- 5) Movimentos SEM historico correspondente
                            IF loc_lUsaItn
                                SELECT cursor_4c_ItnOrig
                                GO TOP
                                DO WHILE !EOF("cursor_4c_ItnOrig")
                                    *-- Chave POSICIONAL: PADR explicito por parte
                                    *-- (3 + 20 + 6 = 29 = EmpDopNums char(29)).
                                    *-- NUNCA ALLTRIM nas partes: encurta a chave e
                                    *-- o SEEK falha em silencio.
                                    loc_cEDN = PADR(TratarNulo(cursor_4c_ItnOrig.emps, ""), 3) + ;
                                               PADR(TratarNulo(cursor_4c_ItnOrig.dopes, ""), 20) + ;
                                               STR(NVL(cursor_4c_ItnOrig.numes, 0), 6)

                                    IF !SEEK(loc_cEDN, "cursor_4c_Historico", "OriDopNums")
                                        INSERT INTO cursor_4c_Movimento ;
                                            (codbarras, cpros, emps, dopes, numes, datas, opers, ;
                                             valor, qtds, pesos, OriDopNums) ;
                                            VALUES ;
                                            (NVL(cursor_4c_ItnOrig.codbarras, 0), ;
                                             TratarNulo(cursor_4c_ItnOrig.cpros, ""), ;
                                             TratarNulo(cursor_4c_ItnOrig.emps, ""), ;
                                             TratarNulo(cursor_4c_ItnOrig.dopes, ""), ;
                                             NVL(cursor_4c_ItnOrig.numes, 0), ;
                                             ConverterParaData(cursor_4c_ItnOrig.datas), ;
                                             TratarNulo(cursor_4c_ItnOrig.opers, ""), ;
                                             NVL(cursor_4c_ItnOrig.units, 0), ;
                                             NVL(cursor_4c_ItnOrig.qtds, 0), ;
                                             NVL(cursor_4c_ItnOrig.pesos, 0), ;
                                             TratarNulo(cursor_4c_ItnOrig.EmpDopNums, ""))
                                    ENDIF

                                    SELECT cursor_4c_ItnOrig
                                    SKIP
                                ENDDO
                            ELSE
                                IF USED("cursor_4c_ItsOrig")
                                    SELECT cursor_4c_ItsOrig
                                    GO TOP
                                    DO WHILE !EOF("cursor_4c_ItsOrig")
                                        *-- Chave POSICIONAL de 29 chars, PADR por parte
                                        loc_cEDN = PADR(TratarNulo(cursor_4c_ItsOrig.emps, ""), 3) + ;
                                                   PADR(TratarNulo(cursor_4c_ItsOrig.dopes, ""), 20) + ;
                                                   STR(NVL(cursor_4c_ItsOrig.numes, 0), 6)

                                        IF !SEEK(loc_cEDN, "cursor_4c_Historico", "EmpDopNum")
                                            *-- O legado procura o Opers do item em CrSigMvItn, que
                                            *-- neste ramo esta VAZIO: o Seek devolve .F. e Opers
                                            *-- fica "". Transcrito como esta no legado.
                                            loc_cOpers = ""
                                            IF USED("cursor_4c_ItnOrig")
                                                IF SEEK(loc_cEDN, "cursor_4c_ItnOrig", "EmpDopNum")
                                                    loc_cOpers = TratarNulo(cursor_4c_ItnOrig.Opers, "")
                                                ENDIF
                                            ENDIF

                                            loc_dData = THIS.ObterDataDocumento(loc_cEDN)

                                            INSERT INTO cursor_4c_Movimento ;
                                                (codbarras, cpros, emps, dopes, numes, datas, ;
                                                 opers, valor, OriDopNums) ;
                                                VALUES ;
                                                (NVL(cursor_4c_ItsOrig.codbarras, 0), ;
                                                 TratarNulo(cursor_4c_ItsOrig.cpros, ""), ;
                                                 TratarNulo(cursor_4c_ItsOrig.emps, ""), ;
                                                 TratarNulo(cursor_4c_ItsOrig.dopes, ""), ;
                                                 NVL(cursor_4c_ItsOrig.numes, 0), ;
                                                 loc_dData, ;
                                                 loc_cOpers, ;
                                                 0, ;
                                                 TratarNulo(cursor_4c_ItsOrig.EmpDopNums, ""))
                                        ENDIF

                                        SELECT cursor_4c_ItsOrig
                                        SKIP
                                    ENDDO
                                ENDIF
                            ENDIF

                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF

                *-- Cursores de trabalho nao ficam abertos entre consultas.
                *-- cursor_4c_ItnOrig permanece: a grade de Movimento ja foi
                *-- montada, mas o ramo SigMvIts consulta o Opers nele.
                IF USED("cursor_4c_HstOrig")
                    USE IN cursor_4c_HstOrig
                ENDIF
                IF USED("cursor_4c_ItsOrig")
                    USE IN cursor_4c_ItsOrig
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigopcgbBO.CarregarGradesPorCodBarras")
            ENDTRY
        ENDIF

        IF !loc_lSucesso AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Pesquisa Global de C" + CHR(243) + "digo de Barras")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularValorRateado - Valor da linha do historico (coluna "valor" de
    * CsHistorico). REGRA DE NEGOCIO transcrita literalmente do Processamento
    * legado - nao simplificar nem reordenar:
    *
    *   Havendo SigMvMov para o documento (empdopnums):
    *       lnDif = SOMA(valtots - valitens); lnVal = SOMA(valtots); lnTot = SOMA(valitens)
    *       percorre CrSigMvItn; para a linha cujo emps+dopes+Str(numes,6) = EDN:
    *           opers = 'S' -> lnGer = Sum(totas) de SigMvHst do mesmo EDN com opers='S'
    *           senao       -> lnGer = CrSigMvItn.totas  E  lnDif = 0
    *           lnItn = CrSigMvItn.totas
    *       lnRat = Round(lnItn + ((lnItn / lnGer) * lnDif), 2)
    *   Sem SigMvMov:
    *       lnRat = SigMvCab.valos do mesmo empdopnums (0 se nao achar)
    *
    * lnVal e lnTot sao acumulados pelo legado e nao entram no resultado -
    * mantidos para nao alterar a transcricao da regra.
    *
    * UNICO desvio: o legado divide por lnGer sem guard, e lnGer fica 0 quando
    * nenhuma linha de CrSigMvItn casa com o documento (caso em que lnItn
    * tambem fica 0). Aqui a divisao so acontece com lnGer <> 0; no caso
    * excluido lnItn eh 0 e o rateio resulta 0, que eh o que a formula
    * representa. Todo caso em que o legado produz um numero devolve o MESMO
    * numero.
    *--------------------------------------------------------------------------
    FUNCTION CalcularValorRateado(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_nDif, loc_nVal, loc_nTot
        LOCAL loc_nRat, loc_nItn, loc_nGer, loc_cEDN, loc_cChaveItn, loc_lProsseguir

        loc_nDif        = 0
        loc_nVal        = 0
        loc_nTot        = 0
        loc_nRat        = 0
        loc_lProsseguir = .T.
        loc_cEDN = IIF(VARTYPE(par_cEmpDopNums) = "C", par_cEmpDopNums, "")

        IF EMPTY(loc_cEDN)
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF USED("cursor_4c_EstMo")
                USE IN cursor_4c_EstMo
            ENDIF

            loc_cSQL = "SELECT empdopnums, valtots, valitens FROM SigMvMov " + ;
                       "WHERE empdopnums = " + EscaparSQL(loc_cEDN)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstMo")

            IF loc_nResultado < 0
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            SELECT cursor_4c_EstMo
            GO TOP

            IF !EOF("cursor_4c_EstMo")
                DO WHILE !EOF("cursor_4c_EstMo")
                    loc_nDif = loc_nDif + (NVL(cursor_4c_EstMo.valtots, 0) - ;
                                           NVL(cursor_4c_EstMo.valitens, 0))
                    loc_nVal = loc_nVal + NVL(cursor_4c_EstMo.valtots, 0)
                    loc_nTot = loc_nTot + NVL(cursor_4c_EstMo.valitens, 0)
                    SELECT cursor_4c_EstMo
                    SKIP
                ENDDO

                loc_nItn = 0
                loc_nGer = 0

                IF USED("cursor_4c_ItnOrig")
                    SELECT cursor_4c_ItnOrig
                    GO TOP
                    DO WHILE !EOF("cursor_4c_ItnOrig")
                        *-- Chave POSICIONAL de 29 chars, PADR por parte
                        loc_cChaveItn = PADR(TratarNulo(cursor_4c_ItnOrig.emps, ""), 3) + ;
                                        PADR(TratarNulo(cursor_4c_ItnOrig.dopes, ""), 20) + ;
                                        STR(NVL(cursor_4c_ItnOrig.numes, 0), 6)

                        *-- Os dois lados sao a chave POSICIONAL de 29 chars
                        *-- (emps 3 + dopes 20 + STR(numes,6) = EmpDopNums char(29)).
                        *-- PADR nos DOIS lados para que diferenca de padding do
                        *-- driver nao faca a comparacao falhar em silencio.
                        IF PADR(loc_cChaveItn, 29) == PADR(loc_cEDN, 29)
                            IF ALLTRIM(TratarNulo(cursor_4c_ItnOrig.opers, "")) == "S"
                                loc_nGer = THIS.ObterTotalSaidaDocumento(loc_cEDN)
                            ELSE
                                loc_nGer = NVL(cursor_4c_ItnOrig.totas, 0)
                                loc_nDif = 0
                            ENDIF
                            loc_nItn = NVL(cursor_4c_ItnOrig.totas, 0)
                        ENDIF

                        SELECT cursor_4c_ItnOrig
                        SKIP
                    ENDDO

                    IF loc_nGer <> 0
                        loc_nRat = ROUND(loc_nItn + ((loc_nItn / loc_nGer) * loc_nDif), 2)
                    ELSE
                        loc_nRat = ROUND(loc_nItn, 2)
                    ENDIF
                ENDIF
            ELSE
                loc_nRat = THIS.ObterValorDocumento(loc_cEDN)
            ENDIF

            IF USED("cursor_4c_EstMo")
                USE IN cursor_4c_EstMo
            ENDIF
        ENDIF

        RETURN loc_nRat
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTotalSaidaDocumento - Sum(totas) do historico de SAIDA do documento
    * (legado: Select empdopnums, Sum(totas) As totas From SigMvHst
    *          Where empdopnums = <EDN> And opers = 'S' Group by Empdopnums)
    *--------------------------------------------------------------------------
    FUNCTION ObterTotalSaidaDocumento(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_nTotal

        loc_nTotal = 0

        IF USED("cursor_4c_TotSai")
            USE IN cursor_4c_TotSai
        ENDIF

        loc_cSQL = "SELECT empdopnums, SUM(totas) AS totas FROM SigMvHst " + ;
                   "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums) + ;
                   " AND opers = " + EscaparSQL("S") + " GROUP BY empdopnums"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TotSai")

        IF loc_nResultado >= 0 AND USED("cursor_4c_TotSai")
            SELECT cursor_4c_TotSai
            GO TOP
            IF !EOF("cursor_4c_TotSai")
                loc_nTotal = NVL(cursor_4c_TotSai.totas, 0)
            ENDIF
        ENDIF

        IF USED("cursor_4c_TotSai")
            USE IN cursor_4c_TotSai
        ENDIF

        RETURN loc_nTotal
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterValorDocumento - Valor do documento quando NAO existe SigMvMov
    * (legado: Select empdopnums,valos From SigMvCab Where empdopnums = <EDN>)
    *--------------------------------------------------------------------------
    FUNCTION ObterValorDocumento(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_nValor

        loc_nValor = 0

        IF USED("cursor_4c_CabValor")
            USE IN cursor_4c_CabValor
        ENDIF

        loc_cSQL = "SELECT empdopnums, valos FROM SigMvCab " + ;
                   "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabValor")

        IF loc_nResultado >= 0 AND USED("cursor_4c_CabValor")
            SELECT cursor_4c_CabValor
            GO TOP
            IF !EOF("cursor_4c_CabValor")
                loc_nValor = NVL(cursor_4c_CabValor.valos, 0)
            ENDIF
        ENDIF

        IF USED("cursor_4c_CabValor")
            USE IN cursor_4c_CabValor
        ENDIF

        RETURN loc_nValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterDataDocumento - Data do documento (legado: Select EmpDopNums,Datas
    * From SigMvCab Where EmpDopNums = <EDN>; sem registro fica Ctod(Space(8)),
    * isto eh, data VAZIA).
    *--------------------------------------------------------------------------
    FUNCTION ObterDataDocumento(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_dData

        loc_dData = {}

        IF USED("cursor_4c_CabData")
            USE IN cursor_4c_CabData
        ENDIF

        loc_cSQL = "SELECT EmpDopNums, Datas FROM SigMvCab " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabData")

        IF loc_nResultado >= 0 AND USED("cursor_4c_CabData")
            SELECT cursor_4c_CabData
            GO TOP
            IF !EOF("cursor_4c_CabData")
                loc_dData = ConverterParaData(cursor_4c_CabData.Datas)
            ENDIF
        ENDIF

        IF USED("cursor_4c_CabData")
            USE IN cursor_4c_CabData
        ENDIF

        RETURN loc_dData
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDevolucaoPorCodBarras - Popula o cursor da grade de Devolucao
    * (legado: crSigOpexi, bloco "Tiago - Busca barras devolvidas").
    *
    * O legado faz o SQLEXEC DIRETO no alias da grade (zerando RecordSource
    * antes e religando as 6 colunas depois). Aqui o SQL vai para cursor
    * temporario e o alias da grade eh recarregado com ZAP + APPEND FROM
    * DBF(), que preserva estrutura, RecordSource e ControlSource.
    *
    * O SUBSTRING(empdopnums, 25, 6) do numero de documento esta transcrito
    * LITERALMENTE do legado. Como EmpDopNums eh emps(3)+dopes(20)+STR(numes,6),
    * o campo numes comeca na posicao 24 - o legado le a partir da 25 e portanto
    * ignora o 1o caractere (que eh o espaco a esquerda do STR para numes ate
    * 99999). Manter identico ao legado: mudar o offset alteraria o numero
    * exibido na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDevolucaoPorCodBarras(par_nCodBarras)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_nCodBarras) != "N" OR par_nCodBarras <= 0
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras inv" + CHR(225) + "lido."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF !USED("cursor_4c_Devolucao")
                THIS.this_cMensagemErro = "Cursor da grade de devolu" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o inicializado."
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_DevTmp")
                    USE IN cursor_4c_DevTmp
                ENDIF

                loc_cSQL = "SELECT datas, " + EscaparSQL("E") + " AS opers, " + ;
                           "SUBSTRING(empdopnums, 1, 3) AS emps, " + ;
                           "SUBSTRING(empdopnums, 4, 20) AS dopes, " + ;
                           "CAST(SUBSTRING(empdopnums, 25, 6) AS NUMERIC) AS numes, " + ;
                           "empdopnums AS OriDopNums, valors " + ;
                           "FROM SigOpExi WHERE cbars = " + FormatarNumeroSQL(par_nCodBarras, 0)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DevTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha ao selecionar as barras devolvidas " + ;
                        "(SigOpExi)." + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_Devolucao
                    ZAP

                    IF USED("cursor_4c_DevTmp") AND RECCOUNT("cursor_4c_DevTmp") > 0
                        SELECT cursor_4c_Devolucao
                        APPEND FROM DBF("cursor_4c_DevTmp")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_DevTmp")
                    USE IN cursor_4c_DevTmp
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigopcgbBO.CarregarDevolucaoPorCodBarras")
            ENDTRY
        ENDIF

        IF !loc_lSucesso AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Pesquisa Global de C" + CHR(243) + "digo de Barras")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCorrecaoPorCodBarras - Popula o cursor do painel de correcao de
    * etiquetas (legado: Botao_de_Correcao.Click - Select * From SigEtHst
    * Where cbars = <codbarras>, para 'CrSigEtHst'). So as colunas usadas
    * pela grade (Column1..6 do Cnt_Correcao.GrdCorrecao).
    *
    * O cursor_4c_Correcao eh criado UMA UNICA VEZ pelo Form (CriarCursoresGrades)
    * e aqui apenas ZERADO e repopulado - NUNCA derrubado por SQLEXEC, que
    * zeraria o ColumnCount da grade ligada a ele. O SQL vai para cursor
    * temporario separado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCorrecaoPorCodBarras(par_nCodBarras)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_nCodBarras) != "N" OR par_nCodBarras <= 0
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras inv" + CHR(225) + "lido."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF !USED("cursor_4c_Correcao")
                THIS.this_cMensagemErro = "Cursor do painel de corre" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o inicializado."
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_CorTmp")
                    USE IN cursor_4c_CorTmp
                ENDIF

                loc_cSQL = "SELECT datas, cpros, pesos, codcors, codtams, usuars " + ;
                           "FROM SigEtHst WHERE cbars = " + FormatarNumeroSQL(par_nCodBarras, 0)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha ao selecionar o hist" + CHR(243) + ;
                        "rico de corre" + CHR(231) + CHR(245) + "es (SigEtHst)." + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_Correcao
                    ZAP

                    IF USED("cursor_4c_CorTmp") AND RECCOUNT("cursor_4c_CorTmp") > 0
                        SELECT cursor_4c_Correcao
                        APPEND FROM DBF("cursor_4c_CorTmp")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_CorTmp")
                    USE IN cursor_4c_CorTmp
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigopcgbBO.CarregarCorrecaoPorCodBarras")
            ENDTRY
        ENDIF

        IF !loc_lSucesso AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Favor reinicializar o processo")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarDocumentoPorChave - Verifica se existe registro em SigMvCab
    * para a chave EmpDopNums informada (legado: BtnDocumento.Click -
    * CursorQuery('SigMvCab','CongBEest','EmpDopNums',OriDopNums,
    * 'Emps,Dopes,Numes')). Achando, preenche this_cEmpsDocto/
    * this_cDopesDocto/this_nNumesDocto com os valores de SigMvCab (os
    * mesmos que o legado le de CongBEest.Emps/Dopes/Numes para abrir
    * FormSigMvExp).
    *--------------------------------------------------------------------------
    PROCEDURE LocalizarDocumentoPorChave(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou, loc_cChave

        loc_lAchou = .F.
        THIS.this_cEmpsDocto  = ""
        THIS.this_cDopesDocto = ""
        THIS.this_nNumesDocto = 0

        loc_cChave = IIF(VARTYPE(par_cEmpDopNums) = "C", par_cEmpDopNums, "")

        IF EMPTY(loc_cChave) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_CongBEest")
            USE IN cursor_4c_CongBEest
        ENDIF

        loc_cSQL = "SELECT Emps, Dopes, Numes FROM SigMvCab " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CongBEest")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_CongBEest") > 0
            SELECT cursor_4c_CongBEest
            GO TOP
            THIS.this_cEmpsDocto  = TratarNulo(Emps, "")
            THIS.this_cDopesDocto = TratarNulo(Dopes, "")
            THIS.this_nNumesDocto = NVL(Numes, 0)
            loc_lAchou = .T.
        ENDIF

        IF USED("cursor_4c_CongBEest")
            USE IN cursor_4c_CongBEest
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteNecessidadePorChave - Equivalente a ChkRegister('SigCdNec',
    * 'EmpDnPs', Emps+Dopes+Str(numes,10)) do legado - existencia de
    * registro em SigCdNec para a chave posicional EmpDnPs. ChkRegister NAO
    * existe em BusinessBase (regra CLAUDE.md "ChkRegister NAO EXISTE") -
    * substituido por COUNT.
    *
    * Chave POSICIONAL: PADR explicito por parte (3 + 20 + 10 = 33 =
    * empdnps char(33)). NUNCA ALLTRIM nas partes - encurtaria a chave e o
    * SELECT devolveria zero linhas em silencio (regra CLAUDE.md #42).
    *--------------------------------------------------------------------------
    FUNCTION ExisteNecessidadePorChave(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste, loc_cChave

        loc_lExiste = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cChave = PADR(IIF(VARTYPE(par_cEmps) = "C", par_cEmps, ""), 3) + ;
                     PADR(IIF(VARTYPE(par_cDopes) = "C", par_cDopes, ""), 20) + ;
                     STR(IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0), 10)

        IF USED("cursor_4c_ChkNec")
            USE IN cursor_4c_ChkNec
        ENDIF

        loc_cSQL = "SELECT COUNT(1) AS Qt FROM SigCdNec WHERE empdnps = " + EscaparSQL(loc_cChave)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNec")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkNec") > 0
            SELECT cursor_4c_ChkNec
            GO TOP
            loc_lExiste = (NVL(Qt, 0) > 0)
        ENDIF

        IF USED("cursor_4c_ChkNec")
            USE IN cursor_4c_ChkNec
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * LiberarCursoresConsulta - Fecha os cursores de TRABALHO desta consulta.
    * Os cursores das GRADES (cursor_4c_Historico/Movimento/Devolucao/Correcao)
    * NAO entram aqui: quem os cria e destroi eh o Form, e fecha-los derrubaria
    * o RecordSource das grades.
    *--------------------------------------------------------------------------
    PROCEDURE LiberarCursoresConsulta()
        LOCAL loc_nI, loc_cAlias
        LOCAL ARRAY loc_aAlias[17]

        loc_aAlias[1]  = "cursor_4c_HstOrig"
        loc_aAlias[2]  = "cursor_4c_ItnOrig"
        loc_aAlias[3]  = "cursor_4c_ItsOrig"
        loc_aAlias[4]  = "cursor_4c_EstMo"
        loc_aAlias[5]  = "cursor_4c_TotSai"
        loc_aAlias[6]  = "cursor_4c_CabValor"
        loc_aAlias[7]  = "cursor_4c_CabData"
        loc_aAlias[8]  = "cursor_4c_DevTmp"
        loc_aAlias[9]  = "cursor_4c_ProEtq"
        loc_aAlias[10] = "cursor_4c_ProdDados"
        loc_aAlias[11] = "cursor_4c_Categoria"
        loc_aAlias[12] = "cursor_4c_ListaPreco"
        loc_aAlias[13] = "cursor_4c_ProdResumo"
        loc_aAlias[14] = "cursor_4c_CotMoedas"
        loc_aAlias[15] = "cursor_4c_CorTmp"
        loc_aAlias[16] = "cursor_4c_CongBEest"
        loc_aAlias[17] = "cursor_4c_ChkNec"

        FOR loc_nI = 1 TO ALEN(loc_aAlias)
            loc_cAlias = loc_aAlias[loc_nI]
            IF USED(loc_cAlias)
                USE IN (loc_cAlias)
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - NAO sobrescritos.
    * SIGOPCGB eh form de CONSULTA/PESQUISA (Pesquisa Global de Codigo de
    * Barras): o legado so le SigOpEtq/SigOpEta/SigCdPro/SigMvHst/SigMvItn/
    * SigOpExi para exibicao - nenhum metodo do form grava registro proprio
    * (a correcao de etiqueta e a movimentacao abrem OUTROS forms: SigOpCgl/
    * SigReCgr). O comportamento padrao herdado de BusinessBase ja eh o
    * correto para esta entidade.
    *--------------------------------------------------------------------------

ENDDEFINE
