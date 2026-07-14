*-- sigopcgpBO.prg
*-- BO para Consulta Geral de Produtos (SIGOPCGP)
*-- Fase 2/8: BO - Metodos CRUD e operacionais
*-- Tabela principal: SigCdPro | Chave: CPros

DEFINE CLASS sigopcgpBO AS BusinessBase

    *-- ===================================================================
    *-- IDENTIFICACAO DA ENTIDADE
    *-- ===================================================================
    this_cTabela      = "SigCdPro"
    this_cCampoChave  = "CPros"

    *-- ===================================================================
    *-- ESTADO DO FORMULARIO
    *-- ===================================================================
    this_lConsultaExecutada = .F.
    this_lAlteraPreco       = .T.
    this_lPrimeira          = .T.
    this_lRetornoCj         = .F.
    this_lLlUser            = .F.
    this_lHabilitaPeso      = .F.
    this_nTpcalcp           = 0
    this_cComposiciona      = ""
    this_cPrEca             = ""
    this_cEmpOperas         = ""
    this_cChamadaExt        = ""
    this_cAntvalue          = ""
    this_dDtIant            = {}
    this_dDtFant            = {}

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - PRODUTO
    *-- ===================================================================
    this_cProdutoInicial    = ""
    this_cProdutoFinal      = ""
    this_cDescricao         = ""
    this_cEquivalente       = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - GRUPO / SUBGRUPO
    *-- ===================================================================
    this_cGrupoCod          = ""
    this_cGrupoDesc         = ""
    this_cGrupoNome         = ""
    this_cSubgrupoCod       = ""
    this_cSubgrupoDesc      = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - GRANDE GRUPO / LINHA / COLECAO
    *-- ===================================================================
    this_cGrandeGrupoCod    = ""
    this_cGrandeGrupoDesc   = ""
    this_cLinha             = ""
    this_cLinha2            = ""
    this_cColuna            = ""
    this_cColuna2           = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - CONTA / EMPRESA
    *-- ===================================================================
    this_cContaCod          = ""
    this_cContaNome         = ""
    this_cContaOCod         = ""
    this_cContaONome        = ""
    this_cEmpresaDesc       = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - COR / MODELO / ACABAMENTO
    *-- ===================================================================
    this_cCorCod            = ""
    this_cCorDesc           = ""
    this_cModeloInicial     = ""
    this_cModeloFinal       = ""
    this_cFxPreco           = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - FORNECEDOR / REFERENCIA
    *-- ===================================================================
    this_cFornecedorCod     = ""
    this_cFornecedorDesc    = ""
    this_cRefFornecedor     = ""
    this_cRefFornecedorFinal= ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - CLASSIFICACAO / CODIGO BARRA
    *-- ===================================================================
    this_cClassificacao     = ""
    this_cCodigoBarra       = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - LISTA / PROMOCAO
    *-- ===================================================================
    this_cListaPrecos       = ""
    this_cPromocao          = ""
    this_cDescritivo        = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - CUSTO / PESO (NUMERICOS)
    *-- ===================================================================
    this_nCustoInicial      = 0
    this_nCustoFinal        = 0
    this_nPesoInicial       = 0
    this_nPesoFinal         = 0
    this_cMoedaCusto        = ""

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - DATAS
    *-- ===================================================================
    this_dDataAltInicial    = {}
    this_dDataAltFinal      = {}
    this_dDataOperInicial   = {}
    this_dDataOperFinal     = {}

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - OPCOES (OPTION GROUP / COMBO)
    *-- ===================================================================
    this_nOptPagamento      = 3
    this_nOptTipoData       = 1
    this_nOptOperacao       = 0
    this_nOptTipoDataCad    = 1
    this_nOptTipoRef        = 3
    this_nSituacao          = 0
    this_nImagem            = 0

    *-- ===================================================================
    *-- FILTROS DE CONSULTA - CHECKBOXES
    *-- ===================================================================
    this_lEquivalentes      = .F.
    this_lMarcaTodosOpe     = .F.

    *-- ===================================================================
    *-- PRODUTO SELECIONADO (RESULTADO)
    *-- ===================================================================
    this_cCodPro            = ""
    this_cDescPro           = ""
    this_cGrupoPro          = ""
    this_cSubGrupoPro       = ""
    this_cUnidadePro        = ""
    this_cFornecedorPro     = ""
    this_cRefPro            = ""
    this_cCorPro            = ""
    this_cTamPro            = ""
    this_cPecaPro           = ""
    this_cBarraPro          = ""
    this_cLinhasPro         = ""

    *-- ===================================================================
    *-- DADOS DE CUSTO
    *-- ===================================================================
    this_nPrecoCusto        = 0
    this_cMoedaCustoPro     = ""
    this_nPesoMedio         = 0
    this_nFatorCusto        = 0
    this_nMargem            = 0
    this_nPrecoVenda        = 0
    this_nCustoEstimado     = 0

    *-- ===================================================================
    *-- DADOS DE ESTOQUE
    *-- ===================================================================
    this_cOrigem            = ""
    this_cDestino           = ""
    this_cVendedor          = ""
    this_nTotalEstoque      = 0
    this_nTotalEmpenhado    = 0

    *-- ===================================================================
    *-- DADOS DE ETIQUETA
    *-- ===================================================================
    this_cCodCorEtiq        = ""
    this_cCodTamEtiq        = ""
    this_cCodLocalEtiq      = ""
    this_nTotEstEtiq        = 0
    this_nTotEmpEtiq        = 0

    *-- ===================================================================
    *-- CONTROLE DE ESTADO DE NAVEGACAO
    *-- ===================================================================
    this_lResultadoCarregado = .F.
    this_nPaginaAtual        = 1

    *-- ===================================================================
    *-- METODOS
    *-- ===================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "CPros"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar sigopcgpBO: " + loc_oErro.Message)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodPro)
    ENDPROC

    *-- ===================================================================
    *-- CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *-- ===================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF EMPTY(par_cCursor) OR !USED(par_cCursor)
            THIS.this_cMensagemErro = "Cursor " + par_cCursor + " n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cCodPro       = ALLTRIM(NVL(EVALUATE(par_cCursor + ".cpros"),  ""))
            THIS.this_cDescPro      = ALLTRIM(NVL(EVALUATE(par_cCursor + ".dpros"),  ""))
            THIS.this_cGrupoPro     = ALLTRIM(NVL(EVALUATE(par_cCursor + ".cgrus"),  ""))
            THIS.this_cSubGrupoPro  = ALLTRIM(NVL(EVALUATE(par_cCursor + ".sgrus"),  ""))
            THIS.this_cUnidadePro   = ALLTRIM(NVL(EVALUATE(par_cCursor + ".cunis"),  ""))
            THIS.this_cFornecedorPro= ALLTRIM(NVL(EVALUATE(par_cCursor + ".ifors"),  ""))
            THIS.this_cRefPro       = ALLTRIM(NVL(EVALUATE(par_cCursor + ".reffs"),  ""))
            THIS.this_cBarraPro     = ALLTRIM(NVL(EVALUATE(par_cCursor + ".cbars"),  ""))
            THIS.this_nPrecoCusto   = NVL(EVALUATE(par_cCursor + ".pcuss"),    0)
            THIS.this_cMoedaCustoPro= ALLTRIM(NVL(EVALUATE(par_cCursor + ".moecs"),  ""))
            THIS.this_nPesoMedio    = NVL(EVALUATE(par_cCursor + ".pesoms"),   0)
            THIS.this_nFatorCusto   = NVL(EVALUATE(par_cCursor + ".fcustos"),  0)
            THIS.this_nMargem       = NVL(EVALUATE(par_cCursor + ".margems"),  0)
            THIS.this_nPrecoVenda   = NVL(EVALUATE(par_cCursor + ".pvens"),    0)
            THIS.this_nCustoEstimado= NVL(EVALUATE(par_cCursor + ".valors"),   0)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em CarregarDoCursor: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- Inserir - INSERT em SigCdPro (completude de interface)
    *-- ===================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigCdPro (cpros, dpros, cgrus, sgrus, cunis, ifors, reffs, pcuss, moecs, pesoms, fcustos, margems, pvens, valors) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCodPro)        + ", " + ;
                       EscaparSQL(THIS.this_cDescPro)       + ", " + ;
                       EscaparSQL(THIS.this_cGrupoPro)      + ", " + ;
                       EscaparSQL(THIS.this_cSubGrupoPro)   + ", " + ;
                       EscaparSQL(THIS.this_cUnidadePro)    + ", " + ;
                       EscaparSQL(THIS.this_cFornecedorPro) + ", " + ;
                       EscaparSQL(THIS.this_cRefPro)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecoCusto)    + ", " + ;
                       EscaparSQL(THIS.this_cMoedaCustoPro) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesoMedio)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFatorCusto)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMargem)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecoVenda)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCustoEstimado) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir produto"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Inserir: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- Atualizar - UPDATE em SigCdPro
    *-- ===================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                       "dpros = "    + EscaparSQL(THIS.this_cDescPro)       + ", " + ;
                       "cgrus = "    + EscaparSQL(THIS.this_cGrupoPro)      + ", " + ;
                       "sgrus = "    + EscaparSQL(THIS.this_cSubGrupoPro)   + ", " + ;
                       "cunis = "    + EscaparSQL(THIS.this_cUnidadePro)    + ", " + ;
                       "ifors = "    + EscaparSQL(THIS.this_cFornecedorPro) + ", " + ;
                       "reffs = "    + EscaparSQL(THIS.this_cRefPro)        + ", " + ;
                       "pcuss = "    + FormatarNumeroSQL(THIS.this_nPrecoCusto)    + ", " + ;
                       "moecs = "    + EscaparSQL(THIS.this_cMoedaCustoPro) + ", " + ;
                       "pesoms = "   + FormatarNumeroSQL(THIS.this_nPesoMedio)     + ", " + ;
                       "fcustos = "  + FormatarNumeroSQL(THIS.this_nFatorCusto)    + ", " + ;
                       "margems = "  + FormatarNumeroSQL(THIS.this_nMargem)        + ", " + ;
                       "pvens = "    + FormatarNumeroSQL(THIS.this_nPrecoVenda)    + ", " + ;
                       "valors = "   + FormatarNumeroSQL(THIS.this_nCustoEstimado) + " " + ;
                       "WHERE cpros = " + EscaparSQL(THIS.this_cCodPro)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar produto"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Atualizar: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- BuscarProdutos - Consulta principal de produtos (grp_operacao logic)
    *-- par_oFiltros: objeto com filtros (.NULL. usa propriedades this_)
    *-- Popula cursor_4c_Produtos com os resultados
    *-- ===================================================================
    PROCEDURE BuscarProdutos(par_oFiltros)
        LOCAL loc_lSucesso, loc_nResultado
        LOCAL loc_cProI, loc_cProF, loc_cDesc, loc_cDesc2, loc_cGrp, loc_cSGrp
        LOCAL loc_cFornec, loc_cRef, loc_cRefF, loc_cGdeGru, loc_cLinha, loc_cLinha2
        LOCAL loc_cColuna, loc_cColuna2, loc_cCor, loc_cAcabamento, loc_cEqv
        LOCAL loc_cListaPrecos, loc_cPromocao, loc_cClassificacao
        LOCAL loc_nPesoI, loc_nPesoF, loc_nCustoI, loc_nCustoF
        LOCAL loc_nVendaI, loc_nVendaF, loc_nEstI, loc_nEstF
        LOCAL loc_cMoeCusto, loc_cMoeVenda, loc_cMoeEst
        LOCAL loc_nSituas, loc_nImagem, loc_nTpRef
        LOCAL loc_dDtAltI, loc_dDtAltF
        LOCAL loc_cWhere, loc_cWhereFpro1, loc_cWhereFpro2
        LOCAL loc_cWhereFproTB1, loc_cWhereFproTB2
        LOCAL loc_cSelectPro, loc_cFromPro, loc_cWherePro, loc_cSQL
        LOCAL loc_cDtI, loc_cDtF

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            *-- Leitura dos filtros
            IF !ISNULL(par_oFiltros) AND TYPE("par_oFiltros") = "O"
                loc_cProI       = ALLTRIM(NVL(par_oFiltros.cProdutoInicial,    ""))
                loc_cProF       = ALLTRIM(NVL(par_oFiltros.cProdutoFinal,      ""))
                loc_cDesc       = ALLTRIM(NVL(par_oFiltros.cDescricao,         ""))
                loc_cDesc2      = ALLTRIM(NVL(par_oFiltros.cDescritivo,        ""))
                loc_cGrp        = ALLTRIM(NVL(par_oFiltros.cGrupoCod,          ""))
                loc_cSGrp       = ALLTRIM(NVL(par_oFiltros.cSubgrupoCod,       ""))
                loc_cGdeGru     = ALLTRIM(NVL(par_oFiltros.cGrandeGrupoCod,    ""))
                loc_cLinha      = ALLTRIM(NVL(par_oFiltros.cLinha,             ""))
                loc_cLinha2     = ALLTRIM(NVL(par_oFiltros.cLinha2,            ""))
                loc_cColuna     = ALLTRIM(NVL(par_oFiltros.cColuna,            ""))
                loc_cColuna2    = ALLTRIM(NVL(par_oFiltros.cColuna2,           ""))
                loc_cFornec     = ALLTRIM(NVL(par_oFiltros.cFornecedorCod,     ""))
                loc_cRef        = ALLTRIM(NVL(par_oFiltros.cRefFornecedor,     ""))
                loc_cRefF       = ALLTRIM(NVL(par_oFiltros.cRefFornecedorFinal,""))
                loc_cListaPrecos= ALLTRIM(NVL(par_oFiltros.cListaPrecos,       ""))
                loc_cPromocao   = ALLTRIM(NVL(par_oFiltros.cPromocao,          ""))
                loc_cClassificacao = ALLTRIM(NVL(par_oFiltros.cClassificacao,  ""))
                loc_cCor        = ALLTRIM(NVL(par_oFiltros.cCorCod,            ""))
                loc_cAcabamento = ALLTRIM(NVL(par_oFiltros.cFxPreco,           ""))
                loc_cEqv        = ALLTRIM(NVL(par_oFiltros.cEquivalente,       ""))
                loc_nPesoI      = NVL(par_oFiltros.nPesoInicial,  0)
                loc_nPesoF      = NVL(par_oFiltros.nPesoFinal,    0)
                loc_nCustoI     = NVL(par_oFiltros.nCustoInicial, 0)
                loc_nCustoF     = NVL(par_oFiltros.nCustoFinal,   0)
                loc_nVendaI     = 0
                loc_nVendaF     = 0
                loc_nEstI       = 0
                loc_nEstF       = 0
                loc_cMoeCusto   = ALLTRIM(NVL(par_oFiltros.cMoedaCusto,       ""))
                loc_cMoeVenda   = ""
                loc_cMoeEst     = ""
                loc_nSituas     = NVL(par_oFiltros.nSituacao,  0)
                loc_nImagem     = NVL(par_oFiltros.nImagem,    0)
                loc_nTpRef      = NVL(par_oFiltros.nOptTipoRef, 3)
                loc_dDtAltI     = NVL(par_oFiltros.dDataAltInicial, {})
                loc_dDtAltF     = NVL(par_oFiltros.dDataAltFinal,   {})
            ELSE
                loc_cProI       = ALLTRIM(THIS.this_cProdutoInicial)
                loc_cProF       = ALLTRIM(THIS.this_cProdutoFinal)
                loc_cDesc       = ALLTRIM(THIS.this_cDescricao)
                loc_cDesc2      = ALLTRIM(THIS.this_cDescritivo)
                loc_cGrp        = ALLTRIM(THIS.this_cGrupoCod)
                loc_cSGrp       = ALLTRIM(THIS.this_cSubgrupoCod)
                loc_cGdeGru     = ALLTRIM(THIS.this_cGrandeGrupoCod)
                loc_cLinha      = ALLTRIM(THIS.this_cLinha)
                loc_cLinha2     = ALLTRIM(THIS.this_cLinha2)
                loc_cColuna     = ALLTRIM(THIS.this_cColuna)
                loc_cColuna2    = ALLTRIM(THIS.this_cColuna2)
                loc_cFornec     = ALLTRIM(THIS.this_cFornecedorCod)
                loc_cRef        = ALLTRIM(THIS.this_cRefFornecedor)
                loc_cRefF       = ALLTRIM(THIS.this_cRefFornecedorFinal)
                loc_cListaPrecos= ALLTRIM(THIS.this_cListaPrecos)
                loc_cPromocao   = ALLTRIM(THIS.this_cPromocao)
                loc_cClassificacao = ALLTRIM(THIS.this_cClassificacao)
                loc_cCor        = ALLTRIM(THIS.this_cCorCod)
                loc_cAcabamento = ALLTRIM(THIS.this_cFxPreco)
                loc_cEqv        = ALLTRIM(THIS.this_cEquivalente)
                loc_nPesoI      = THIS.this_nPesoInicial
                loc_nPesoF      = THIS.this_nPesoFinal
                loc_nCustoI     = THIS.this_nCustoInicial
                loc_nCustoF     = THIS.this_nCustoFinal
                loc_nVendaI     = 0
                loc_nVendaF     = 0
                loc_nEstI       = 0
                loc_nEstF       = 0
                loc_cMoeCusto   = ALLTRIM(THIS.this_cMoedaCusto)
                loc_cMoeVenda   = ""
                loc_cMoeEst     = ""
                loc_nSituas     = THIS.this_nSituacao
                loc_nImagem     = THIS.this_nImagem
                loc_nTpRef      = THIS.this_nOptTipoRef
                loc_dDtAltI     = THIS.this_dDataAltInicial
                loc_dDtAltF     = THIS.this_dDataAltFinal
            ENDIF

            *-- Validacoes de faixa de produto
            IF !EMPTY(loc_cProI) AND EMPTY(loc_cProF)
                MsgAviso("Refer" + CHR(234) + "ncia Final do Produto Inv" + CHR(225) + "lida!!!")
            ELSE
                IF !EMPTY(loc_cProF) AND EMPTY(loc_cProI)
                    MsgAviso("Refer" + CHR(234) + "ncia Inicial do Produto Inv" + CHR(225) + "lida!!!")
                ELSE
                    *-- Normalizacao do range de produto
                    loc_cProI = IIF(EMPTY(loc_cProI), SPACE(10), loc_cProI)
                    loc_cProF = IIF(EMPTY(loc_cProF), REPLICATE(CHR(254), 14), loc_cProF)

                    *-- Montagem do WHERE principal
                    loc_cWhere      = "a.cpros Between " + EscaparSQL(loc_cProI) + " And " + EscaparSQL(loc_cProF) + " "
                    loc_cWhereFpro1 = ""
                    loc_cWhereFpro2 = ""
                    loc_cWhereFproTB1 = ""
                    loc_cWhereFproTB2 = ""

                    loc_cWhere = loc_cWhere + IIF(loc_nImagem = 1, " And Not a.FigJpgs Is Null ", ;
                                 IIF(loc_nImagem = 2, " And a.FigJpgs Is Null ", ""))

                    IF !EMPTY(loc_cDesc)
                        loc_cWhere = loc_cWhere + " And a.dpros Like '%" + ALLTRIM(loc_cDesc) + "%' "
                    ENDIF
                    IF !EMPTY(loc_cDesc2)
                        loc_cWhere = loc_cWhere + " And a.dpro2s Like '%" + ALLTRIM(loc_cDesc2) + "%' "
                    ENDIF

                    *-- Filtro fornecedor + referencia
                    IF !EMPTY(loc_cFornec)
                        loc_cWhereFpro1 = " And a.ifors = " + EscaparSQL(loc_cFornec) + ;
                            " And a.cpros Not in (Select xa.Cpros From SigPrFnc xa Where xa.Ifors = " + EscaparSQL(loc_cFornec) + ")"
                        loc_cWhereFproTB1 = " And a.cpros in (Select xa.Cpros From SigPrFnc xa Where xa.Ifors = " + EscaparSQL(loc_cFornec) + ")"
                    ENDIF

                    DO CASE
                        CASE loc_nTpRef = 1 AND !EMPTY(loc_cRef)
                            loc_cWhereFpro2 = " And Upper(a.reffs) Like '%" + ALLTRIM(loc_cRef) + "%'" + ;
                                " And a.Cpros Not in (Select Cpros From SigPrFnc Where Upper(reffs) Like '%" + ALLTRIM(loc_cRef) + "%')"
                            loc_cWhereFproTB2 = " And a.Cpros in (Select Cpros From SigPrFnc Where Upper(reffs) Like '%" + ALLTRIM(loc_cRef) + "%')"

                        CASE loc_nTpRef = 2 AND !EMPTY(loc_cRef) AND !EMPTY(loc_cRefF) AND (loc_cRef = loc_cRefF)
                            loc_cWhereFpro2 = " And a.Reffs = " + EscaparSQL(loc_cRef) + ;
                                " And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs = " + EscaparSQL(loc_cRef) + ")"
                            loc_cWhereFproTB2 = " And a.cpros in (Select Cpros From SigPrFnc Where Reffs = " + EscaparSQL(loc_cRef) + ")"

                        CASE loc_nTpRef = 2 AND !EMPTY(loc_cRef) AND !EMPTY(loc_cRefF)
                            loc_cWhereFpro2 = " And a.Reffs Between " + EscaparSQL(loc_cRef) + " And " + EscaparSQL(loc_cRefF) + ;
                                " And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs Between " + EscaparSQL(loc_cRef) + " And " + EscaparSQL(loc_cRefF) + ")"
                            loc_cWhereFproTB2 = " And a.cpros in (Select Cpros From SigPrFnc Where Reffs Between " + EscaparSQL(loc_cRef) + " And " + EscaparSQL(loc_cRefF) + ")"

                        CASE loc_nTpRef = 2 AND !EMPTY(loc_cRefF) AND EMPTY(loc_cRef)
                            loc_cWhereFpro2 = " And a.Reffs <= " + EscaparSQL(loc_cRefF) + ;
                                " And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs <= " + EscaparSQL(loc_cRefF) + ")"
                            loc_cWhereFproTB2 = " And a.cpros in (Select Cpros From SigPrFnc Where Reffs <= " + EscaparSQL(loc_cRefF) + ")"

                        CASE loc_nTpRef = 2 AND !EMPTY(loc_cRef) AND EMPTY(loc_cRefF)
                            loc_cWhereFpro2 = " And a.Reffs >= " + EscaparSQL(loc_cRef) + ;
                                " And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs >= " + EscaparSQL(loc_cRef) + ")"
                            loc_cWhereFproTB2 = " And a.cpros in (Select Cpros From SigPrFnc Where Reffs >= " + EscaparSQL(loc_cRef) + ")"
                    ENDCASE

                    IF EMPTY(loc_cFornec)
                        loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cGrp), " And a.cgrus = " + EscaparSQL(loc_cGrp) + " ", "")
                    ENDIF

                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cSGrp),     " And a.sgrus = "    + EscaparSQL(loc_cSGrp)     + " ", "")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cGdeGru),   " And a.mercs = "    + EscaparSQL(loc_cGdeGru)   + " ", "")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cMoeCusto), " And a.moecusfs = " + EscaparSQL(loc_cMoeCusto) + " ", "")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cMoeVenda), " And a.moevs = "    + EscaparSQL(loc_cMoeVenda) + " ", "")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cMoeEst),   " And a.moedas = "   + EscaparSQL(loc_cMoeEst)   + " ", "")

                    IF !EMPTY(loc_cLinha2)
                        loc_cWhere = loc_cWhere + " And a.linhas between " + EscaparSQL(loc_cLinha) + " And " + EscaparSQL(loc_cLinha2) + " "
                    ENDIF
                    IF !EMPTY(loc_cColuna2)
                        loc_cWhere = loc_cWhere + " And a.colecoes between " + EscaparSQL(loc_cColuna) + " And " + EscaparSQL(loc_cColuna2) + " "
                    ENDIF
                    IF loc_nCustoF > 0
                        loc_cWhere = loc_cWhere + " And a.custofs between " + FormatarNumeroSQL(loc_nCustoI) + " And " + FormatarNumeroSQL(loc_nCustoF) + " "
                    ENDIF
                    IF loc_nVendaF > 0
                        loc_cWhere = loc_cWhere + " And a.pvens between " + FormatarNumeroSQL(loc_nVendaI) + " And " + FormatarNumeroSQL(loc_nVendaF) + " "
                    ENDIF
                    IF loc_nEstF > 0
                        loc_cWhere = loc_cWhere + " And a.valors between " + FormatarNumeroSQL(loc_nEstI) + " And " + FormatarNumeroSQL(loc_nEstF) + " "
                    ENDIF
                    IF loc_nPesoF > 0
                        loc_cWhere = loc_cWhere + " And a.pesoms between " + FormatarNumeroSQL(loc_nPesoI) + " And " + FormatarNumeroSQL(loc_nPesoF) + " "
                    ENDIF

                    DO CASE
                        CASE loc_nSituas = 1
                            loc_cWhere = loc_cWhere + " And (a.situas = 1 Or a.situas = 0) "
                        CASE loc_nSituas = 2
                            loc_cWhere = loc_cWhere + " And a.situas = 2 "
                    ENDCASE

                    IF !EMPTY(loc_cCor)
                        loc_cWhere = loc_cWhere + " And a.CodCors = " + EscaparSQL(loc_cCor) + " "
                    ENDIF
                    IF !EMPTY(loc_cEqv)
                        loc_cWhere = loc_cWhere + " And (a.cproeqs = " + EscaparSQL(loc_cEqv) + " Or a.Cpros = " + EscaparSQL(loc_cEqv) + ") "
                    ENDIF
                    IF !EMPTY(loc_cClassificacao)
                        loc_cWhere = loc_cWhere + " And a.cClass = " + EscaparSQL(loc_cClassificacao) + " "
                    ENDIF

                    IF !EMPTY(loc_dDtAltI) AND !EMPTY(loc_dDtAltF)
                        loc_cDtI = FormatarDataSQL(loc_dDtAltI)
                        loc_cDtF = FormatarDataSQL(loc_dDtAltF)
                        loc_cWhere = loc_cWhere + " And a.Datas Between " + loc_cDtI + " And " + loc_cDtF + " "
                    ENDIF

                    *-- Montagem SELECT
                    loc_cSelectPro = "Select a.cpros,a.dpros,a.situas,a.linhas,a.cunis,a.pesoms,a.reffs,a.obspeds," + ;
                                     "a.cftios,a.moevs,a.moecs,a.moepcs,a.moecusfs,a.moedas,a.cproeqs,a.pvens," + ;
                                     "a.margems,a.pcuss,a.fcustos,a.colecoes,a.Sgrus "
                    loc_cFromPro   = "From SigCdPro a "
                    loc_cWherePro  = "Where " + loc_cWhere + loc_cWhereFpro1 + loc_cWhereFpro2

                    IF !EMPTY(loc_cPromocao)
                        loc_cSelectPro = loc_cSelectPro + ",p.pecas "
                        loc_cFromPro   = "From SigCdPro a Inner Join SigPrPmi p on p.cpros=a.cpros "
                        IF !EMPTY(loc_cGdeGru)
                            loc_cFromPro = loc_cFromPro + " Right Join SigCdGrp g On a.cgrus = g.cgrus "
                        ENDIF
                        loc_cWherePro = "Where p.promos = " + EscaparSQL(loc_cPromocao) + " And " + loc_cWhere
                    ENDIF

                    IF !EMPTY(loc_cListaPrecos) AND EMPTY(loc_cPromocao)
                        loc_cFromPro  = "From SigCdPro a Inner Join SigCdLpi pp on pp.cpros=a.cpros "
                        loc_cWherePro = "Where pp.lprecos = " + EscaparSQL(loc_cListaPrecos) + " And " + loc_cWhere
                    ENDIF

                    loc_cSQL = loc_cSelectPro + loc_cFromPro + loc_cWherePro

                    IF USED("cursor_4c_ProdutosTmp")
                        USE IN cursor_4c_ProdutosTmp
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTmp")

                    IF loc_nResultado >= 1
                        IF !USED("cursor_4c_Produtos")
                            SET NULL ON
                            CREATE CURSOR cursor_4c_Produtos (cpros c(14), dpros c(65), situas n(1,0), ;
                                linhas c(10), cunis c(6), pesoms n(9,3), reffs c(20), obspeds c(1), ;
                                cftios c(1), moevs c(6), moecs c(6), moepcs c(6), moecusfs c(6), ;
                                moedas c(6), cproeqs c(14), pvens n(14,4), margems n(9,4), ;
                                pcuss n(14,4), fcustos n(9,4), colecoes c(10), Sgrus c(10), pecas c(10))
                            SET NULL OFF
                            SELECT cursor_4c_Produtos
                            INDEX ON cpros TAG cpros
                        ELSE
                            SELECT cursor_4c_Produtos
                            SELECT cursor_4c_Produtos
                            ZAP
                        ENDIF

                        APPEND FROM DBF("cursor_4c_ProdutosTmp")
                        SELECT cursor_4c_Produtos
                        GO TOP

                        THIS.this_lConsultaExecutada = .T.
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao buscar produtos"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em BuscarProdutos: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- MontaEquivals - Monta cursor crProEtqEqs com produto e equivalentes
    *-- par_cPro: codigo do produto principal
    *-- ===================================================================
    PROCEDURE MontaEquivals(par_cPro)
        LOCAL loc_lSucesso, loc_nResultado, loc_cQuery
        LOCAL loc_cPai, loc_cFil

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            IF USED("crProEtqEqs")
                USE IN crProEtqEqs
            ENDIF

            CREATE CURSOR crProEtqEqs (CPros c(14))
            INDEX ON CPros TAG CPros

            IF THIS.this_lEquivalentes
                loc_cQuery = "Select CPros, CProEqs From SigCdPro Where CPros = " + EscaparSQL(par_cPro) + ;
                             " Union All " + ;
                             "Select CPros, CProEqs From SigCdPro Where CProEqs = " + EscaparSQL(par_cPro)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "LocalProEt")
                IF loc_nResultado >= 1
                    SELECT LocalProEt
                    SCAN
                        loc_cPai = LocalProEt.CPros
                        loc_cFil = IIF(EMPTY(LocalProEt.CProEqs), LocalProEt.CPros, LocalProEt.CProEqs)

                        loc_cQuery = "Select CPros, CProEqs From SigCdPro Where CPros In (" + EscaparSQL(loc_cPai) + ", " + EscaparSQL(loc_cFil) + ")" + ;
                                     " Union All " + ;
                                     "Select CPros, CProEqs From SigCdPro Where CProEqs In (" + EscaparSQL(loc_cPai) + ", " + EscaparSQL(loc_cFil) + ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "LocalProEt1")
                        IF loc_nResultado >= 1
                            SELECT LocalProEt1
                            SCAN
                                IF !SEEK(LocalProEt1.CPros, "crProEtqEqs", "CPros")
                                    INSERT INTO crProEtqEqs (CPros) VALUES (LocalProEt1.CPros)
                                ENDIF
                                IF !EMPTY(LocalProEt1.CProEqs) AND !SEEK(LocalProEt1.CProEqs, "crProEtqEqs", "CPros")
                                    INSERT INTO crProEtqEqs (CPros) VALUES (LocalProEt1.CProEqs)
                                ENDIF
                            ENDSCAN
                        ELSE
                            MsgErro("Falha na Conex" + CHR(227) + "o (LocalProEt1)")
                        ENDIF
                    ENDSCAN

                    IF USED("LocalProEt")
                        USE IN LocalProEt
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha na Conex" + CHR(227) + "o (LocalProEt)")
                ENDIF
            ELSE
                INSERT INTO crProEtqEqs (CPros) VALUES (par_cPro)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em MontaEquivals: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- BuscarEstoque - Carrega dados de estoque (mGrdEstoque logic)
    *-- par_cCodPro: codigo do produto
    *-- par_nOpcao: 1=todos, 2=somente com saldo
    *-- Popula cursors: crSigMvEst, crSigOpEtq1, crSigMvEstPd
    *-- ===================================================================
    PROCEDURE BuscarEstoque(par_cCodPro, par_nOpcao)
        LOCAL loc_lSucesso, loc_nResultado
        LOCAL loc_cFilQtd, loc_cFiltroEmp, loc_cQuery

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            loc_cFilQtd = IIF(par_nOpcao = 2, "a.sqtds > 0", "0 = 0")
            loc_cFiltroEmp = ""

            *-- Inicializa cursor crSigOpEtq1
            IF USED("crSigOpEtq1")
                ZAP IN crSigOpEtq1
            ELSE
                SET NULL ON
                CREATE CURSOR crSigOpEtq1 (CPros c(14), EmpOs c(3), Grupos c(10), Contas c(10), ;
                    CBars n(14,0), Qtds n(10,3), Pesos n(10,3), Localizas c(10), CodTams c(4), ;
                    CodCors c(4), Datas d(8), CPs1s c(1), Locals c(10), CodAmss c(10))
                SET NULL OFF
            ENDIF

            *-- Inicializa cursor crSigMvEst
            IF USED("crSigMvEst")
                ZAP IN crSigMvEst
            ELSE
                SET NULL ON
                CREATE CURSOR crSigMvEst (CPros c(14), Emps c(3), Grupos c(10), Estos c(10), ;
                    Sqtds n(14,3), CodCors c(4), CodTams c(4), QtdEmpHs n(14,3), SPesos n(14,3), ;
                    Pedidos n(14,3), EntPends n(14,3), Fk_Chave c(40), DContas c(60))
                SET NULL OFF
                SELECT crSigMvEst
                INDEX ON Emps+Grupos+Estos+CodCors+CodTams TAG EmpGruCon
            ENDIF

            *-- Inicializa cursor crSigMvEstPd
            IF USED("crSigMvEstPd")
                ZAP IN crSigMvEstPd
            ELSE
                SET NULL ON
                CREATE CURSOR crSigMvEstPd (Fk_Chave c(40), EmpDopNums c(22), Qtds n(14,3))
                SET NULL OFF
            ENDIF

            *-- Monta equivalentes
            IF THIS.MontaEquivals(par_cCodPro)
                *-- Para cada produto equivalente, busca etiquetas
                SELECT crProEtqEqs
                SCAN
                    loc_cQuery = "Select e.cpros,e.empos,e.grupos,e.contas,e.cbars,e.qtds,e.pesos," + ;
                                 "e.localizas,e.codtams,e.codcors,e.datas,e.CodAmss,'1' as cps1s " + ;
                                 " From SigOpEtq e " + ;
                                 " Where e.cpros = " + EscaparSQL(ALLTRIM(crProEtqEqs.CPros)) + ;
                                 " And e.Empos In (Select b.cemps From SigCdEmp b Where Not b.dircolins='" + SPACE(32) + "')" + ;
                                 " And e.cpros + e.empos + e.grupos + e.contas In" + ;
                                 " (Select a.cpros + a.emps + a.grupos + a.estos" + ;
                                 "  From SigMvEst a where a.cpros=" + EscaparSQL(ALLTRIM(crProEtqEqs.CPros)) + " and " + loc_cFilQtd + ")" + ;
                                 " Union All " + ;
                                 "Select e.cpros,e.empos,e.grupos,e.contas,e.cbars,e.qtds,e.pesos," + ;
                                 "e.localizas,e.codtams,e.codcors,e.datas,e.CodAmss,'0' as cps1s " + ;
                                 " From SigOpEtq e " + ;
                                 " Where e.cpros = " + EscaparSQL(ALLTRIM(crProEtqEqs.CPros)) + ;
                                 " And e.Empos In (Select b.cemps From SigCdEmp b Where b.dircolins='" + SPACE(32) + "')" + ;
                                 " And e.cpros + e.empos + e.grupos + e.contas In" + ;
                                 " (Select a.cpros + a.emps + a.grupos + a.estos" + ;
                                 "  From SigMvEst a where a.cpros=" + EscaparSQL(ALLTRIM(crProEtqEqs.CPros)) + " and " + loc_cFilQtd + ")" + ;
                                 " Order by 1,2,3,4,5"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "CrSigOpEtq2")
                    IF loc_nResultado >= 1
                        SELECT CrSigOpEtq2
                        SCAN
                            SCATTER MEMVAR MEMO
                            m.Datas = NVL(m.Datas, CTOT(""))
                            INSERT INTO crSigOpEtq1 FROM MEMVAR
                        ENDSCAN
                    ENDIF
                    IF USED("CrSigOpEtq2")
                        USE IN CrSigOpEtq2
                    ENDIF
                ENDSCAN

                *-- Busca saldos de estoque por equivalente
                SELECT crProEtqEqs
                SCAN
                    loc_cQuery = "Select a.CPros, a.Emps, a.Grupos, a.Estos, a.Sqtds, a.CodCors, a.CodTams, " + ;
                                 "9999999999.999 as QtdEmpHs, a.SPesos, " + ;
                                 "9999999999.999 as Pedidos, Space(20) as Fk_Chave, cli.Rclis as DContas " + ;
                                 "From SigMvEst a inner join SigCdCli cli on a.Estos = cli.Iclis " + ;
                                 "Where a.CPros = " + EscaparSQL(ALLTRIM(crProEtqEqs.CPros)) + " And " + loc_cFilQtd + loc_cFiltroEmp + ;
                                 " Order By a.Emps, a.Grupos, a.Estos, a.CodTams, a.CodCors"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "LocalEst")
                    IF loc_nResultado >= 1
                        SELECT LocalEst
                        SCAN
                            SCATTER MEMVAR MEMO
                            IF SEEK(LocalEst.Emps + LocalEst.Grupos + LocalEst.Estos + LocalEst.CodCors + LocalEst.CodTams, ;
                                    "crSigMvEst", "EmpGruCon")
                                REPLACE Sqtds  WITH Sqtds  + LocalEst.Sqtds,  ;
                                        SPesos WITH SPesos + LocalEst.SPesos IN crSigMvEst
                            ELSE
                                INSERT INTO crSigMvEst FROM MEMVAR
                            ENDIF
                            REPLACE Fk_Chave WITH SYS(2015), ;
                                    QtdEmpHs WITH 0, ;
                                    Pedidos  WITH 0 IN crSigMvEst
                        ENDSCAN
                        IF USED("LocalEst")
                            USE IN LocalEst
                        ENDIF
                    ELSE
                        MsgErro("Falha na Conex" + CHR(227) + "o (LocalEst)")
                    ENDIF
                ENDSCAN

                SELECT crSigMvEst
                THIS.this_nTotalEstoque   = 0
                THIS.this_nTotalEmpenhado = 0
                LOCAL loc_nPesoTot
                SUM Sqtds, SPesos TO THIS.this_nTotalEstoque, loc_nPesoTot

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em BuscarEstoque: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- AcertaGradeEti - Filtra CsEtiqueta por cor/tamanho/localizacao
    *-- par_cCor, par_cTam, par_cLoc: filtros opcionais
    *-- ===================================================================
    PROCEDURE AcertaGradeEti(par_cCor, par_cTam, par_cLoc)
        LOCAL loc_lSucesso, loc_cFil, loc_cEstEmp, loc_cEstGru, loc_cEstCta
        LOCAL loc_nTotEti, loc_nTotPes

        loc_lSucesso = .F.

        IF !USED("crSigCdPro") OR !USED("CrSigMvEst") OR !USED("crSigOpEtq1")
            MsgAviso("Favor reinicializar o processo.")
            RETURN .F.
        ENDIF

        TRY
            loc_cFil = IIF(!EMPTY(par_cCor), "a.codcors = '" + par_cCor + "' And ", "") + ;
                       IIF(!EMPTY(par_cTam), "a.codtams = '" + par_cTam + "' And ", "") + ;
                       IIF(!EMPTY(par_cLoc), "a.localizas = '" + par_cLoc + "' And ", "") + ".T."

            IF USED("crSigMvEtr")
                loc_cEstEmp = ALLTRIM(NVL(crSigMvEtr.emps,   ""))
                loc_cEstGru = ALLTRIM(NVL(crSigMvEtr.grupos, ""))
                loc_cEstCta = ALLTRIM(NVL(crSigMvEtr.estos,  ""))
            ELSE
                loc_cEstEmp = ""
                loc_cEstGru = ""
                loc_cEstCta = ""
            ENDIF

            IF USED("CsEtiqueta")
                USE IN CsEtiqueta
            ENDIF

            SELECT a.cpros, a.empos, a.grupos, a.contas, a.cbars, a.qtds, a.pesos, ;
                   a.localizas, a.codtams, a.codcors, a.datas, a.cps1s, a.locals, a.codamss ;
              FROM crSigOpEtq1 a ;
             WHERE a.empos = m.loc_cEstEmp AND ;
                   a.grupos = m.loc_cEstGru AND ;
                   a.contas = m.loc_cEstCta AND &loc_cFil. ;
              INTO CURSOR CsEtiqueta READWRITE

            SELECT CsEtiqueta
            INDEX ON cBars     TAG cBars
            INDEX ON qtds      TAG qtds
            INDEX ON pesos     TAG pesos
            INDEX ON localizas TAG localizas
            INDEX ON codtams   TAG codtams
            INDEX ON codcors   TAG codcors
            INDEX ON DTOS(datas) TAG datas

            loc_nTotEti = 0
            loc_nTotPes = 0
            SELECT CsEtiqueta
            SUM qtds, pesos TO loc_nTotEti, loc_nTotPes
            THIS.this_nTotEstEtiq = loc_nTotEti
            THIS.this_nTotEmpEtiq = loc_nTotPes

            SELECT CsEtiqueta
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em AcertaGradeEti: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- CarregaGrpOpe - Carrega dados do grupo de operacao (crGrpOpe)
    *-- par_cGrpOpe: codigo do grupo de operacao
    *-- par_cCodPro: codigo do produto
    *-- ===================================================================
    PROCEDURE CarregaGrpOpe(par_cGrpOpe, par_cCodPro)
        LOCAL loc_lSucesso, loc_nResultado, loc_cQuery
        LOCAL loc_cDgO, loc_cWhe, loc_nPen, loc_nQtd

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            loc_cDgO = PADR(par_cGrpOpe, 20)

            IF USED("crGrpOpe")
                ZAP IN crGrpOpe
            ELSE
                SET NULL ON
                CREATE CURSOR crGrpOpe (Emps c(3), Dopes c(3), Numes n(6,0), Qtds n(14,3))
                SET NULL OFF
            ENDIF

            *-- Busca parametro OpPends
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "Select DgOpes, OpPends From SigCdGpo Where DgOpes = " + EscaparSQL(loc_cDgO), ;
                "LocalGope")

            loc_nPen = 1
            IF loc_nResultado > 0 AND USED("LocalGope") AND !EMPTY("LocalGope") AND !EOF("LocalGope")
                loc_nPen = NVL(LocalGope.OpPends, 1)
            ENDIF
            IF USED("LocalGope")
                USE IN LocalGope
            ENDIF

            loc_cWhe = IIF(loc_nPen = 2, "b.ChkSubN = 0 And ", ;
                       IIF(loc_nPen = 3, "b.ChkSubN = 1 And ", ""))

            loc_cQuery = "Select b.Emps, b.Dopes, b.Numes, Sum(c.Qtds - c.QtBaixas) as Qtds " + ;
                         "From SigCdGpo a, SigMvCab b, SigMvItn c " + ;
                         "Where a.DgOpes = " + EscaparSQL(loc_cDgO) + " And " + ;
                               "a.Dopers = b.Dopes And " + loc_cWhe + ;
                               "b.EmpDopNums = c.EmpDopNums And " + ;
                               "c.CPros = " + EscaparSQL(par_cCodPro) + " " + ;
                         "Group By b.Emps, b.Dopes, b.Numes " + ;
                         "Order By b.Emps, b.Dopes, b.Numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "crDados")
            IF loc_nResultado >= 1
                loc_nQtd = 0
                SELECT crDados
                SCAN
                    INSERT INTO crGrpOpe (Emps, Dopes, Numes, Qtds) ;
                        VALUES (crDados.Emps, crDados.Dopes, crDados.Numes, crDados.Qtds)
                    loc_nQtd = loc_nQtd + crDados.Qtds
                ENDSCAN
                IF USED("crDados")
                    USE IN crDados
                ENDIF
                THIS.this_nTotalEstoque = loc_nQtd
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o (CarregaGrpOpe - crDados)")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em CarregaGrpOpe: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- AtualizaCpoEst - Busca ContaOs/ContaDs/Vends de uma movimentacao
    *-- par_cEmpDopNums: chave da movimentacao
    *-- Preenche propriedades: cOrigem, cDestino, cVendedor
    *-- ===================================================================
    PROCEDURE AtualizaCpoEst(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_nResultado, loc_cQuery
        LOCAL loc_cContaOs, loc_cContaDs, loc_cVends

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cOrigem   = ""
            THIS.this_cDestino  = ""
            THIS.this_cVendedor = ""

            loc_cQuery = "Select ContaOs, ContaDs, Vends From SigMvCab Where EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "LocalEest")
            IF loc_nResultado >= 1
                SELECT LocalEest
                GO TOP IN LocalEest

                IF !EOF("LocalEest")
                    loc_cContaOs = ALLTRIM(NVL(LocalEest.ContaOs, ""))
                    loc_cContaDs = ALLTRIM(NVL(LocalEest.ContaDs, ""))
                    loc_cVends   = ALLTRIM(NVL(LocalEest.Vends,   ""))

                    IF !EMPTY(loc_cContaOs)
                        THIS.this_cOrigem = loc_cContaOs
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "Select Rclis From SigCdCli Where Iclis = " + EscaparSQL(loc_cContaOs), ;
                            "LocalCli1")
                        IF loc_nResultado > 0 AND USED("LocalCli1") AND !EOF("LocalCli1")
                            THIS.this_cContaNome = ALLTRIM(NVL(LocalCli1.Rclis, ""))
                        ENDIF
                        IF USED("LocalCli1")
                            USE IN LocalCli1
                        ENDIF
                    ENDIF

                    IF !EMPTY(loc_cContaDs)
                        THIS.this_cDestino = loc_cContaDs
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "Select Rclis From SigCdCli Where Iclis = " + EscaparSQL(loc_cContaDs), ;
                            "LocalCli2")
                        IF loc_nResultado > 0 AND USED("LocalCli2") AND !EOF("LocalCli2")
                            THIS.this_cContaONome = ALLTRIM(NVL(LocalCli2.Rclis, ""))
                        ENDIF
                        IF USED("LocalCli2")
                            USE IN LocalCli2
                        ENDIF
                    ENDIF

                    IF !EMPTY(loc_cVends)
                        THIS.this_cVendedor = loc_cVends
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "Select Rclis From SigCdCli Where Iclis = " + EscaparSQL(loc_cVends), ;
                            "LocalCli3")
                        IF loc_nResultado > 0 AND USED("LocalCli3") AND !EOF("LocalCli3")
                            THIS.this_cEmpresaDesc = ALLTRIM(NVL(LocalCli3.Rclis, ""))
                        ENDIF
                        IF USED("LocalCli3")
                            USE IN LocalCli3
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("LocalEest")
                    USE IN LocalEest
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o (AtualizaCpoEst - LocalEest)")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em AtualizaCpoEst: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- AcertaOrdemGrade - Ordena cursor e destaca coluna ativa no grid
    *-- par_oGrd     : objeto Grid
    *-- par_cCmpOrd  : ControlSource da coluna (ex: "cursor.campo")
    *-- par_lDescend : .T. para descendente
    *-- ===================================================================
    PROCEDURE AcertaOrdemGrade(par_oGrd, par_cCmpOrd, par_lDescend)
        LOCAL loc_lSucesso, loc_i, loc_cCampo, loc_cCursor, loc_cOrdem, loc_nRecno

        loc_lSucesso = .F.

        IF EMPTY(par_cCmpOrd)
            RETURN .T.
        ENDIF

        TRY
            loc_cCursor = LEFT(par_cCmpOrd, AT(".", par_cCmpOrd) - 1)
            loc_cOrdem  = SUBSTR(par_cCmpOrd, AT(".", par_cCmpOrd) + 1)
            loc_nRecno  = RECNO(loc_cCursor)

            FOR loc_i = 1 TO par_oGrd.ColumnCount
                loc_cCampo = par_oGrd.Columns(loc_i).ControlSource
                IF loc_cCampo == par_cCmpOrd
                    par_oGrd.Columns(loc_i).Header1.BackColor = RGB(220, 255, 220)
                    IF par_lDescend
                        loc_cOrdem = loc_cOrdem + "d"
                    ENDIF
                    SET ORDER TO &loc_cOrdem. IN (loc_cCursor)
                ELSE
                    par_oGrd.Columns(loc_i).Header1.BackColor = RGB(212, 208, 200)
                ENDIF
            NEXT loc_i

            par_oGrd.Refresh()

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                GO loc_nRecno IN &loc_cCursor.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em AcertaOrdemGrade: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- MontaStrTpOpe - Monta string SQL IN com tipos de operacao selecionados
    *-- Usa cursor crSigCdTom (deve estar disponivel)
    *-- Retorna: "(1,2,3)" ou "" se nenhum selecionado
    *-- ===================================================================
    PROCEDURE MontaStrTpOpe()
        LOCAL loc_cStr

        loc_cStr = ""

        TRY
            IF USED("crSigCdTom")
                SELECT crSigCdTom
                GO TOP IN crSigCdTom
                SCAN
                    IF crSigCdTom.Selec = 1
                        loc_cStr = loc_cStr + IIF(EMPTY(loc_cStr), "(", ",") + ;
                                   CHR(39) + ALLTRIM(STR(crSigCdTom.Codigos, 2)) + CHR(39)
                    ENDIF
                ENDSCAN
                IF !EMPTY(loc_cStr)
                    loc_cStr = loc_cStr + ")"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em MontaStrTpOpe: " + loc_oErro.Message
        ENDTRY

        RETURN loc_cStr
    ENDPROC

    *-- ===================================================================
    *-- AtualizaCot - Atualiza cursor TmpCot com cotacoes de uma data
    *-- par_dData: data de referencia
    *-- ===================================================================
    PROCEDURE AtualizaCot(par_dData)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        LOCAL loc_cMoe, loc_nCotacao, loc_nCotResult

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "Select cmoes, 0.000 as valos From SigCdCot group by cmoes"

            IF USED("TmpCot")
                USE IN TmpCot
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpCot")
            IF loc_nResultado >= 1
                SELECT TmpCot
                GO TOP
                SCAN
                    loc_cMoe = ALLTRIM(TmpCot.cmoes)
                    loc_nCotacao = 0

                    IF !EMPTY(loc_cMoe) AND !EMPTY(par_dData)
                        loc_nCotResult = SQLEXEC(gnConnHandle, ;
                            "Select Top 1 valos From SigCdCot " + ;
                            "Where cmoes = " + EscaparSQL(loc_cMoe) + " " + ;
                            "And datas <= " + FormatarDataSQL(par_dData) + " " + ;
                            "Order By datas Desc", ;
                            "LocalCot")
                        IF loc_nCotResult > 0 AND USED("LocalCot") AND !EOF("LocalCot")
                            loc_nCotacao = NVL(LocalCot.valos, 0)
                        ENDIF
                        IF USED("LocalCot")
                            USE IN LocalCot
                        ENDIF
                    ENDIF

                    REPLACE valos WITH loc_nCotacao IN TmpCot
                ENDSCAN

                SELECT TmpCot
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o (TmpCot)")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em AtualizaCot: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- BuscarHistoricoMovimento - Busca ContaOs/ContaDs/Vends de SigMvCab
    *-- par_cEmpDopNums: chave da movimentacao
    *-- Popula cursor_4c_HistMov
    *-- ===================================================================
    PROCEDURE BuscarHistoricoMovimento(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_nResultado, loc_cQuery

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida"
            RETURN .F.
        ENDIF

        TRY
            loc_cQuery = "Select ContaOs, ContaDs, Vends From SigMvCab Where EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

            IF USED("cursor_4c_HistMov")
                USE IN cursor_4c_HistMov
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_HistMovTmp")
            IF loc_nResultado >= 1
                SET NULL ON
                CREATE CURSOR cursor_4c_HistMov (ContaOs c(10), ContaDs c(10), Vends c(10))
                SET NULL OFF
                APPEND FROM DBF("cursor_4c_HistMovTmp")
                USE IN cursor_4c_HistMovTmp
                SELECT cursor_4c_HistMov
                GO TOP
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar hist" + CHR(243) + "rico de movimento"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em BuscarHistoricoMovimento: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- ===================================================================
    *-- InicializarCursoresBase - Cria cursors necessarios para o formulario
    *-- Deve ser chamado no Load do formulario
    *-- ===================================================================
    PROCEDURE InicializarCursoresBase()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            *-- Cursor de materias primas para filtro de composicao
            IF USED("CsMatPrima")
                USE IN CsMatPrima
            ENDIF
            SET NULL ON
            CREATE CURSOR CsMatPrima (mats c(14), dcompos c(40), qtd_inicial n(10,2), ;
                qtd_final n(10,2), apenas l, Cgrus c(3), Tipos c(20))
            SET NULL OFF
            SELECT CsMatPrima
            INDEX ON mats TAG mats
            APPEND BLANK
            SET ORDER TO

            *-- Cursor de etiquetas
            IF USED("CsEtiqueta")
                USE IN CsEtiqueta
            ENDIF
            SET NULL ON
            CREATE CURSOR CsEtiqueta (CPros c(14), CBars n(14,0), Qtds n(10,3), Pesos n(9,2), ;
                Localizas c(10), CodTams c(4), CodCors c(4), Datas d(8), Cps1s c(1), Locals c(3))
            SET NULL OFF
            SELECT CsEtiqueta
            INDEX ON cBars TAG cBars

            *-- Cursor de fases de producao
            IF USED("CsFase")
                USE IN CsFase
            ENDIF
            SET NULL ON
            CREATE CURSOR CsFase (ordems n(2,0), grupos c(3), descricao c(40), figuras c(100), observacoes m)
            SET NULL OFF

            *-- Cursor de tipos de operacao
            IF USED("crSigCdTom")
                ZAP IN crSigCdTom
            ELSE
                SET NULL ON
                CREATE CURSOR crSigCdTom (Codigos n(2,0), Descrs c(30), GerGdmis n(2,0), Selec n(1,0))
                SET NULL OFF
            ENDIF

            *-- Cursor de filtro de operacoes
            IF USED("crFilOper")
                ZAP IN crFilOper
            ELSE
                SET NULL ON
                CREATE CURSOR crFilOper (EmpDopNums c(22))
                SET NULL OFF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em InicializarCursoresBase: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
