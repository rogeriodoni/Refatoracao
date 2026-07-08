*-- sigprccpBO.prg
*-- BO para Recalculo de Precos (SIGPRCCP)
*-- Fase 1/8: BO - Propriedades e Init
*-- Tabela principal: SigPrCpo | Chave: cIdChaves

DEFINE CLASS sigprccpBO AS BusinessBase

    *-- ===================================================================
    *-- IDENTIFICACAO DA ENTIDADE
    *-- ===================================================================
    this_cTabela      = "SigPrCpo"
    this_cCampoChave  = "cIdChaves"

    *-- ===================================================================
    *-- FILTROS - FAIXA DE GRANDE GRUPO (SigCdGpr)
    *-- ===================================================================
    this_cMercI    = ""     && Grande Grupo inicial (getMercI, MaxLen=3)
    this_cMercF    = ""     && Grande Grupo final   (getMercF, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE GRUPO (SigCdGrp)
    *-- ===================================================================
    this_cGruI     = ""     && Grupo inicial (getCgrui, CGrus, MaxLen=3)
    this_cGruF     = ""     && Grupo final   (getCgruf, CGrus, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE SUBGRUPO (SigCdPsg)
    *-- ===================================================================
    this_cSGruI    = ""     && Subgrupo inicial (getSgruI, Codigos, MaxLen=6)
    this_cSGruF    = ""     && Subgrupo final   (getSgruF, Codigos, MaxLen=6)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE UNIDADE (SigCdUni)
    *-- ===================================================================
    this_cCuniI    = ""     && Unidade inicial (getCunii, CUnis, MaxLen=3)
    this_cCuniF    = ""     && Unidade final   (getCunif, CUnis, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE LINHA (SigCdLin)
    *-- ===================================================================
    this_cLinI     = ""     && Linha inicial (GetLini, Linhas, MaxLen=10)
    this_cLinF     = ""     && Linha final   (GetLinf, Linhas, MaxLen=10)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE COLECAO (SigCdCol)
    *-- ===================================================================
    this_cColI     = ""     && Colecao inicial (GetColi, Colecoes, MaxLen=10)
    this_cColF     = ""     && Colecao final   (GetColf, Colecoes, MaxLen=10)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE MOEDA (SigCdMoe)
    *-- ===================================================================
    this_cMoeI     = ""     && Moeda inicial (GetMoedai, CMoes, MaxLen=3)
    this_cMoeF     = ""     && Moeda final   (GetMoedaf, CMoes, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE MARKUP E ENCARGO (NUMERICOS)
    *-- ===================================================================
    this_nMrkI     = 0      && Markup inicial  (GetMrki)
    this_nMrkF     = 0      && Markup final    (GetMrkf)
    this_nEncI     = 0      && Encargo inicial (Get_EncI)
    this_nEncF     = 0      && Encargo final   (Get_Encf)

    *-- ===================================================================
    *-- FILTROS - FORNECEDOR (fAcessoContas)
    *-- ===================================================================
    this_cFornecs  = ""     && Fornecedor codigo      (getCFornecs, Ifors, MaxLen=10)
    this_cDFornecs = ""     && Fornecedor descricao   (getDFornecs, somente leitura, MaxLen=40)

    *-- ===================================================================
    *-- PARAMETROS DE PROCESSAMENTO - RECALCULO
    *-- ===================================================================
    this_nReajuste = 0      && Percentual de reajuste aplicado ao preco (Get_Reajuste)
    this_nNMrk     = 0      && Novo Markup                              (GetnMrk)
    this_nVariacao = 0      && Percentual de variacao para filtro pos-processamento (Get_Variacao)
    this_nEncargo  = 0      && Novo Encargo percentual                  (get_Encargo)
    this_cFeitio   = ""     && Codigo MKP atual (Get_Feitio, SigPrFti.Cods, MaxLen=2)
    this_cNewMkp   = ""     && Novo codigo MKP  (getNewMkp, SigPrFti.Cods, MaxLen=2)

    *-- ===================================================================
    *-- OPCOES DE PROCESSAMENTO (OPTIONGROUPS)
    *-- ===================================================================

    && Opc_situacao: 1=Ativos, 2=Inativos, 3=Todos (default VFP=1, nao definido no SCX)
    this_nSituacao = 1

    && Opc_pven: 1=Sim, 2=Nao  (default SCX Value=2 = Nao)
    this_nPven     = 2

    && Opc_Recalc: 1=Composicao, 2=CustoVenda, 3=Ambos, 4=PesoComp,
    &&             5=Cambio, 6=CambioInteiros, 7=MarkupCusto, 8=MarkupVenda
    this_nRecalc   = 1

    && Opc_Compra: 1=Comprar, 2=NaoComprar, 3=Todos  (default SCX Value=3)
    this_nCompra   = 3

    && fwoption1: 1=Ideal, 2=Venda  (default SCX Value=1)
    this_nFoption1 = 1

    *-- ===================================================================
    *-- PARAMETROS DO SISTEMA (carregados de SigCdPam e SigCdPaC)
    *-- ===================================================================
    this_nArreds      = 0   && Arredondamento de precos (SigCdPam.Arreds)
    this_nCalcCusts   = 0   && Metodo de calculo de custo (SigCdPaC.Calccusts)
    this_nNChkSubGrs  = 0   && Flag subgrupo por faixa de preco (SigCdPaC.NCHKSUBGRS)

    *-- ===================================================================
    *-- PROPRIEDADES DE REGISTRO SigPrCpo (composicao de produto)
    *-- Usadas para operacoes CRUD individuais em registros de composicao
    *-- ===================================================================
    this_cIdChaves   = ""    && Chave primaria (cidchaves C(20))
    this_cCats       = ""    && Categoria composicao (cats C(6))
    this_cCgrus      = ""    && Grupo do produto principal (cgrus C(3))
    this_cCpros      = ""    && Codigo do produto principal (cpros C(14))
    this_dDatatrans  = {}    && Data de transferencia (datatrans DATETIME NULL)
    this_cDcompos    = ""    && Descricao da composicao (dcompos C(40))
    this_cDscgrp     = ""    && Descricao do subgrupo (dscgrp C(20))
    this_cEtiqs      = ""    && Etiqueta (etiqs C(1))
    this_cGrupos     = ""    && Grupo (grupos C(10))
    this_cMats       = ""    && Codigo do material/componente (mats C(14))
    this_cMoeds      = ""    && Moeda (moeds C(3))
    this_cObscompos  = ""    && Observacao da composicao (obscompos C(10))
    this_nOrdems     = 0     && Ordem sequencial (ordems N(2,0))
    this_nPcompos    = 0     && Percentual composicao (pcompos N(11,3))
    this_nQtds       = 0     && Quantidade (qtds N(8,3))
    this_nQtscons    = 0     && Quantidade consumo (qtscons N(8,3))
    this_cUnicompos  = ""    && Unidade composicao (unicompos C(3))
    this_cCompos     = ""    && Composicao (compos C(10))
    this_nOrdcompos  = 0     && Ordem composicao (ordcompos N(2,0))
    this_nQtdcvs     = 0     && Quantidade custo venda (qtdcvs N(11,3))
    this_nVlrcvs     = 0     && Valor custo venda (vlrcvs N(11,2))
    this_dDtmovs     = {}    && Data movimento (dtmovs DATETIME NULL)
    this_cCunips     = ""    && Unidade preco (cunips C(3))
    this_nMarkcvs    = 0     && Markup custo venda (markcvs N(9,6))
    this_nPesos      = 0     && Peso (pesos N(8,3))
    this_nTotas      = 0     && Total (totas N(11,3))
    this_nTpalts     = 0     && Tipo alteracao (tpalts N(1,0))
    this_nVlrpvs     = 0     && Valor preco venda (vlrpvs N(11,2))
    this_nOrdts      = 0     && Ordem (ordts N(2,0))
    this_cTipos      = ""    && Tipo (tipos C(20))
    this_cMatriz     = ""    && Matriz (matriz C(14))
    this_cObsofs     = ""    && Observacao oficina (obsofs C(120))
    this_nPedraPrincipal = 0 && Pedra principal flag (PedraPrincipal N(1,0))

    *-- ===================================================================
    *-- ESTADO DE PROCESSAMENTO
    *-- ===================================================================
    this_lAutomatico  = .F. && Modo automatico (parametro pAuto do Init legado)
    this_cPro         = ""  && Produto atual sendo processado (PRIVATE pPro no legado)
    this_lProcessado  = .F. && Indica se Processar() foi executado com sucesso

    *-- ===================================================================
    *-- METODOS
    *-- ===================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigPrCpo"
            THIS.this_cCampoChave = "cIdChaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar sigprccpBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosAuxiliares - Carrega cursores auxiliares para processamento
    * Chamado pelo Form no InicializarForm() antes de qualquer Processar()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosAuxiliares()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Parametros SigCdPam (arredondamento de preco)
            loc_cSQL = "SELECT TOP 1 Arreds FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AuxPam")
            IF loc_nResult > 0 AND !EOF("cursor_4c_AuxPam")
                SELECT cursor_4c_AuxPam
                THIS.this_nArreds = NVL(cursor_4c_AuxPam.Arreds, 0)
                THIS.this_nArreds = IIF(THIS.this_nArreds = 0, 1, THIS.this_nArreds)
            ENDIF
            IF USED("cursor_4c_AuxPam")
                USE IN cursor_4c_AuxPam
            ENDIF

            *-- Parametros SigCdPaC (metodo calculo custo e flag subgrupo)
            loc_cSQL = "SELECT TOP 1 Calccusts, NCHKSUBGRS FROM SigCdPaC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AuxPaC")
            IF loc_nResult > 0 AND !EOF("cursor_4c_AuxPaC")
                SELECT cursor_4c_AuxPaC
                THIS.this_nCalcCusts  = NVL(cursor_4c_AuxPaC.CalcCusts, 0)
                THIS.this_nNChkSubGrs = NVL(cursor_4c_AuxPaC.NCHKSUBGRS, 0)
            ENDIF
            IF USED("cursor_4c_AuxPaC")
                USE IN cursor_4c_AuxPaC
            ENDIF

            *-- Moedas (SigCdMoe)
            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdMoe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMoe")
            IF loc_nResult > 0
                SELECT CrSigCdMoe
                INDEX ON Cmoes TAG Cmoes
                INDEX ON Dmoes TAG Dmoes
            ENDIF

            *-- Cotacoes de cambio (SigCdCot)
            IF USED("CrSigCdCot")
                USE IN CrSigCdCot
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCot"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdCot")
            IF loc_nResult > 0
                SELECT CrSigCdCot
                INDEX ON cmoes+DTOS(datas)+horas TAG Cotacaos
                INDEX ON cmoes+DTOS(datas) TAG cMoeData
            ENDIF

            *-- Grupos de produto (SigCdGrp)
            IF USED("CrSigCdGrp")
                USE IN CrSigCdGrp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdGrp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGrp")
            IF loc_nResult > 0
                SELECT CrSigCdGrp
                INDEX ON Cgrus TAG Cgrus
            ENDIF

            *-- Unidades de medida (SigCdUni)
            IF USED("CrSigCdUni")
                USE IN CrSigCdUni
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdUni"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdUni")
            IF loc_nResult > 0
                SELECT CrSigCdUni
                INDEX ON CUnis TAG cUnis
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados auxiliares: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorDados - Cria cursor_4c_Dados para exibicao no grid de produtos
    * Estrutura espelha o cursor CrProdutos do legado
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorDados()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ( ;
            lMarca   N(1)     NULL, ;
            CPros    C(14)    NULL, ;
            DPros    C(40)    NULL, ;
            ValAnt   N(14,2)  NULL, ;
            ValAtu   N(14,2)  NULL, ;
            CustoAfs N(12,4)  NULL, ;
            CustoFs  N(12,4)  NULL, ;
            PVarias  N(8,2)   NULL, ;
            CVarias  N(8,2)   NULL  ;
        )
        SET NULL OFF
        SELECT cursor_4c_Dados
        INDEX ON CPros TAG CPros
        SET ORDER TO
        GO TOP
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConstruirWhereClause - Constroi clausula WHERE a partir das propriedades de filtro
    * Retorna: string com condicoes (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    FUNCTION ConstruirWhereClause()
        LOCAL loc_nConta, loc_lcWhere, loc_lcInicio, loc_lcFinal
        LOCAL loc_laCampo(7), loc_laVarI(7), loc_laVarF(7)

        loc_laCampo(1) = "CGrus"
        loc_laCampo(2) = "Cunis"
        loc_laCampo(3) = "Linhas"
        loc_laCampo(4) = "Colecoes"
        IF THIS.this_nFoption1 = 2
            loc_laCampo(5) = "Moevs"
        ELSE
            loc_laCampo(5) = "Moedas"
        ENDIF
        loc_laCampo(6) = "SGrus"
        loc_laCampo(7) = "Mercs"

        loc_laVarI(1) = ALLTRIM(THIS.this_cGruI)
        loc_laVarI(2) = ALLTRIM(THIS.this_cCuniI)
        loc_laVarI(3) = ALLTRIM(THIS.this_cLinI)
        loc_laVarI(4) = ALLTRIM(THIS.this_cColI)
        loc_laVarI(5) = ALLTRIM(THIS.this_cMoeI)
        loc_laVarI(6) = ALLTRIM(THIS.this_cSGruI)
        loc_laVarI(7) = ALLTRIM(THIS.this_cMercI)

        loc_laVarF(1) = ALLTRIM(THIS.this_cGruF)
        loc_laVarF(2) = ALLTRIM(THIS.this_cCuniF)
        loc_laVarF(3) = ALLTRIM(THIS.this_cLinF)
        loc_laVarF(4) = ALLTRIM(THIS.this_cColF)
        loc_laVarF(5) = ALLTRIM(THIS.this_cMoeF)
        loc_laVarF(6) = ALLTRIM(THIS.this_cSGruF)
        loc_laVarF(7) = ALLTRIM(THIS.this_cMercF)

        loc_lcWhere = " "
        FOR loc_nConta = 1 TO 7
            loc_lcInicio = loc_laVarI(loc_nConta)
            loc_lcFinal  = loc_laVarF(loc_nConta)

            IF (loc_nConta > 1) AND ;
               (!EMPTY(loc_lcInicio) OR !EMPTY(loc_lcFinal)) AND ;
               !EMPTY(ALLTRIM(loc_lcWhere))
                loc_lcWhere = loc_lcWhere + " AND "
            ENDIF

            IF EMPTY(loc_lcInicio)
                IF !EMPTY(loc_lcFinal)
                    loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + " <= " + EscaparSQL(loc_lcFinal)
                ENDIF
            ELSE
                IF EMPTY(loc_lcFinal)
                    loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + " >= " + EscaparSQL(loc_lcInicio)
                ELSE
                    loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + ;
                                  " BETWEEN '" + loc_lcInicio + "' AND '" + loc_lcFinal + "'"
                ENDIF
            ENDIF
        ENDFOR

        loc_lcWhere = ALLTRIM(loc_lcWhere)
        IF EMPTY(loc_lcWhere)
            loc_lcWhere = "1=1"
        ENDIF

        *-- Filtro situacao (Ativos=1, Inativos=2, Todos=3)
        IF THIS.this_nSituacao = 1 OR THIS.this_nSituacao = 2
            loc_lcWhere = loc_lcWhere + " AND Situas = " + TRANSFORM(THIS.this_nSituacao)
        ENDIF

        *-- Filtro fornecedor
        IF !EMPTY(ALLTRIM(THIS.this_cFornecs))
            loc_lcWhere = loc_lcWhere + " AND Ifors = '" + ALLTRIM(THIS.this_cFornecs) + "'"
        ENDIF

        *-- Filtro compra/ForaLinha (1=Comprar, 2=NaoComprar, 3=Todos)
        IF THIS.this_nCompra = 1
            loc_lcWhere = loc_lcWhere + " AND ForaLinha = 0"
        ENDIF
        IF THIS.this_nCompra = 2
            loc_lcWhere = loc_lcWhere + " AND ForaLinha = 1"
        ENDIF

        RETURN loc_lcWhere
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - Recalcula precos dos produtos conforme parametros definidos
    * nas propriedades this_* do BO.
    * Retorna .T. se processamento bem-sucedido, .F. se erro.
    * Apos Processar(): cursor_4c_Dados e CrSigCdPro ficam prontos para AtualizarPrecos()
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lnMrki, loc_lnMrkf, loc_lnEncI, loc_lnEncF
        LOCAL loc_lcWhere, loc_lcQuery
        LOCAL loc_lnArred, loc_lnPvenda, loc_lnReajuste, loc_lnMarkup, loc_lnEncarg
        LOCAL loc_lnTpRecal, loc_lcFeitio, loc_lnOpcaoM
        LOCAL loc_lcFtiNew

        loc_lSucesso = .F.

        loc_lnMrki     = THIS.this_nMrkI
        loc_lnMrkf     = THIS.this_nMrkF
        loc_lnEncI     = THIS.this_nEncI
        loc_lnEncF     = THIS.this_nEncF
        loc_lnArred    = IIF(THIS.this_nArreds = 0, 1, THIS.this_nArreds)
        loc_lnPvenda   = THIS.this_nPven
        loc_lnReajuste = 1 + (THIS.this_nReajuste / 100)
        loc_lnMarkup   = THIS.this_nNMrk
        loc_lnEncarg   = THIS.this_nEncargo
        loc_lnTpRecal  = THIS.this_nRecalc
        loc_lcFeitio   = ALLTRIM(THIS.this_cFeitio)
        loc_lnOpcaoM   = THIS.this_nFoption1
        loc_lcFtiNew   = ALLTRIM(THIS.this_cNewMkp)

        IF INLIST(loc_lnTpRecal, 7, 8) AND EMPTY(loc_lcFtiNew)
            IF !THIS.this_lAutomatico
                MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            RETURN .F.
        ENDIF

        *-- Construir clausula WHERE e carregar produtos
        loc_lcWhere = THIS.ConstruirWhereClause()

        loc_lcQuery = "SELECT * FROM SigCdPro " + ;
                      "WHERE " + loc_lcWhere + ;
                      IIF(loc_lnMrki > 0, " AND Margems BETWEEN " + ;
                          FormatarNumeroSQL(loc_lnMrki) + " AND " + ;
                          FormatarNumeroSQL(loc_lnMrkf), "") + ;
                      IIF(loc_lnEncI > 0, " AND Encargos BETWEEN " + ;
                          FormatarNumeroSQL(loc_lnEncI) + " AND " + ;
                          FormatarNumeroSQL(loc_lnEncF), "") + ;
                      IIF(!EMPTY(loc_lcFeitio), " AND ( cFtios = '" + loc_lcFeitio + ;
                          "' OR cFtioCs = '" + loc_lcFeitio + "' )", "")

        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "CrSigCdPro")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + CHR(227) + "o (CrSigCdPro)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigCdPro
        INDEX ON CPros TAG CPros

        *-- Estrutura de composicao vazia para acumular calculos de todos produtos
        loc_lcQuery = "SELECT * FROM SigPrCpo WHERE 1=0"
        IF USED("TmpPrCpo")
            USE IN TmpPrCpo
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TmpPrCpo")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (TmpPrCpo)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT TmpPrCpo
        INDEX ON CPros TAG CPros

        *-- Feitios de markup (SigPrFti)
        IF USED("CrSigPrFti")
            USE IN CrSigPrFti
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFti", "CrSigPrFti")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFti)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigPrFti
        INDEX ON Cods TAG Cods

        *-- Feitios por grupo (SigPrFto + SigCdGrp)
        IF USED("CrSigPrFtiG")
            USE IN CrSigPrFtiG
        ENDIF
        loc_cSQL = "SELECT a.*, b.Dgrus FROM SigPrFto a, SigCdGrp b " + ;
                   "WHERE a.Cgrus = b.Cgrus AND a.Cgrus <> ' '"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigPrFtiG")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiG)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigPrFtiG
        INDEX ON Cods TAG Cods

        *-- Feitios por produto (SigPrFto + SigCdPro)
        IF USED("CrSigPrFtiP")
            USE IN CrSigPrFtiP
        ENDIF
        loc_cSQL = "SELECT a.*, b.Dpros FROM SigPrFto a, SigCdPro b " + ;
                   "WHERE a.Cpros = b.Cpros AND a.CGrus = ' '"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigPrFtiP")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiP)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigPrFtiP
        INDEX ON Cods TAG Cods

        *-- Cursor acumulador de totais por grupo/produto/moeda (para calculo de feitio de venda)
        IF USED("TotGrupo")
            USE IN TotGrupo
        ENDIF
        CREATE CURSOR TotGrupo (Grupo C(3), Cpros C(14), ValGrupo N(12,3), Moeda C(3))
        INDEX ON Grupo+Cpros+Moeda TAG GruMoe

        *-- Preparar cursor_4c_Dados (grid de resultados)
        THIS.CriarCursorDados()

        TRY
            IF loc_lnTpRecal = 4
                *------------------------------------------------------------------
                *-- CASO 4: Recalculo de Pesos dos Componentes
                *------------------------------------------------------------------
                SELECT CrSigCdPro
                GO TOP
                SCAN
                    THIS.this_cPro = ALLTRIM(CrSigCdPro.CPros)
                    loc_cSQL = "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(THIS.this_cPro)
                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpCompo")
                    IF loc_nResult < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (TmpCompo)")
                        ENDIF
                        loc_lSucesso = .F.
                    ENDIF

                    LOCAL loc_llAtu
                    loc_llAtu = .F.

                    SELECT TmpCompo
                    SCAN
                        LOCAL loc_lnMtlP, loc_lnValP
                        loc_lnMtlP = 1
                        IF !EMPTY(ALLTRIM(TmpCompo.Mats))
                            loc_cSQL = "SELECT a.PesoMs, b.CfgGerGprs " + ;
                                       "FROM SigCdPro a, SigCdGrp b " + ;
                                       "WHERE a.CPros = '" + ALLTRIM(TmpCompo.Mats) + "' " + ;
                                       "AND a.CGrus = b.CGrus"
                            IF USED("LocalProCp")
                                USE IN LocalProCp
                            ENDIF
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalProCp")
                            IF loc_nResult < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (LocalProCp)")
                                ENDIF
                                loc_lSucesso = .F.
                            ENDIF
                            GO TOP IN LocalProCp
                            IF !EOF("LocalProCp") AND (LocalProCp.PesoMs > 0) AND ;
                               (INT(VAL(SUBSTR(ALLTRIM(LocalProCp.CfgGerGprs), 9, 1))) > 1)
                                IF INT(VAL(SUBSTR(ALLTRIM(LocalProCp.CfgGerGprs), 9, 1))) = 2
                                    IF !EMPTY(ALLTRIM(TmpCompo.UniCompos))
                                        IF !EMPTY(ALLTRIM(TmpCompo.CUniPs)) AND (TmpCompo.Pesos > 0)
                                            loc_lnMtlP = TmpCompo.Pesos
                                        ENDIF
                                        loc_lnValP = LocalProCp.PesoMs * loc_lnMtlP
                                        loc_cSQL = "UPDATE SigPrCpo SET Qtds = " + ;
                                                   FormatarNumeroSQL(loc_lnValP) + ;
                                                   " WHERE cIdChaves = '" + ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgAviso("Os Pesos N" + CHR(227) + "o Foram Calculados!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                                            ENDIF
                                            loc_lSucesso = .F.
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ELSE
                                    IF !EMPTY(ALLTRIM(TmpCompo.CUniPs))
                                        IF !EMPTY(ALLTRIM(TmpCompo.UniCompos)) AND (TmpCompo.Qtds > 0)
                                            loc_lnMtlP = TmpCompo.Qtds
                                        ENDIF
                                        loc_lnValP = LocalProCp.PesoMs * loc_lnMtlP
                                        loc_cSQL = "UPDATE SigPrCpo SET Pesos = " + ;
                                                   FormatarNumeroSQL(loc_lnValP) + ;
                                                   " WHERE cIdChaves = '" + ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgAviso("Os Pesos N" + CHR(227) + "o Foram Calculados!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                                            ENDIF
                                            loc_lSucesso = .F.
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ENDIF
                                IF USED("LocalProCp")
                                    USE IN LocalProCp
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN

                    IF loc_llAtu
                        SELECT cursor_4c_Dados
                        INSERT INTO cursor_4c_Dados (lMarca, CPros, DPros) ;
                            VALUES (0, CrSigCdPro.CPros, CrSigCdPro.DPros)
                    ENDIF

                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    SELECT CrSigCdPro
                ENDSCAN

            ELSE
                *------------------------------------------------------------------
                *-- CASO GERAL: Recalculo de precos (todos os outros lnTpRecal)
                *------------------------------------------------------------------
                SELECT CrSigCdPro
                GO TOP
                SCAN
                    LOCAL loc_lnTQtde, loc_lnTotal, loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM
                    LOCAL loc_lnMoec, loc_lnMoecf, loc_lnMoedac, loc_lnMoeft
                    LOCAL loc_lnMoep, loc_lnMoev
                    LOCAL loc_lnCusto, loc_lnfPeso, loc_lnFator, loc_lnFeitio, loc_lnFeitioC
                    LOCAL loc_lnIdeal, loc_lnIdealCv, loc_lnMarkUpa, loc_lnCustof
                    LOCAL loc_lcMarkCus, loc_lcMarkVen, loc_lcFtioV
                    LOCAL loc_lcMoeAlias, loc_lnQtdeqs

                    THIS.this_cPro = ALLTRIM(CrSigCdPro.CPros)

                    IF EMPTY(ALLTRIM(CrSigCdPro.Moedas))
                        REPLACE Moedas WITH CrSigCdPro.Moecs IN CrSigCdPro
                    ENDIF

                    *-- Carregar composicao do produto via SQL
                    loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(THIS.this_cPro)
                    IF USED("CrSigPrCpo")
                        USE IN CrSigPrCpo
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigPrCpo")
                    IF loc_nResult < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrCpo)")
                        ENDIF
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT CrSigPrCpo
                    INDEX ON CPros TAG CPros

                    *-- Registrar no grid: codigo, descricao, valor anterior, custo anterior
                    SELECT cursor_4c_Dados
                    INSERT INTO cursor_4c_Dados (lMarca, CPros, DPros, ValAnt, CustoAfs) ;
                        VALUES (0, CrSigCdPro.CPros, CrSigCdPro.DPros, ;
                                CrSigCdPro.Pvens, CrSigCdPro.CustoFs)

                    STORE 0 TO loc_lnTQtde, loc_lnTotal, loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM

                    *-- Limpar TotGrupo para este produto
                    SELECT TotGrupo
                    ZAP

                    *-- Calcular taxa cambio moeda custo (Moecs)
                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moecs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoec = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    *-- Taxa cambio moeda principal (Moedas) para acumulo do SCAN
                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moedas)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoedac = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                    =SEEK(ALLTRIM(CrSigCdPro.Cgrus), "CrSigCdGrp", "Cgrus")

                    *--------------------------------------------------------------
                    *-- SCAN componentes da composicao
                    *--------------------------------------------------------------
                    SELECT CrSigPrCpo
                    =SEEK(THIS.this_cPro, "CrSigPrCpo", "CPros")
                    SCAN WHILE ALLTRIM(CPros) = THIS.this_cPro
                        LOCAL loc_llOk, loc_lnMoem, loc_lnMoevC
                        loc_lnMoem = 1
                        loc_lnMoevC = 1

                        IF EMPTY(ALLTRIM(CrSigPrCpo.Mats))
                            LOOP
                        ENDIF

                        loc_llOk = .T.

                        *-- Verificar material principal (excluir da composicao)
                        loc_cSQL = "SELECT DISTINCT MatPrincs FROM SigCdPro " + ;
                                   "WHERE MatPrincs <> Space(14) AND MatPrincs = '" + ;
                                   ALLTRIM(CrSigPrCpo.Mats) + "'"
                        IF USED("crMatPrinc")
                            USE IN crMatPrinc
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crMatPrinc")
                        IF loc_nResult >= 1 AND RECCOUNT("crMatPrinc") >= 1
                            loc_llOk = .F.
                        ENDIF

                        IF loc_llOk
                            loc_cSQL = "SELECT Custofs, MoeCusfs, Cunis, Cgrus, Moevs, cUniPs, pVens " + ;
                                       "FROM SigCdPro WHERE Cpros = '" + ALLTRIM(CrSigPrCpo.Mats) + "'"
                            IF USED("CrCompoPro")
                                USE IN CrCompoPro
                            ENDIF
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrCompoPro")
                            IF loc_nResult < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrCompoPro)")
                                ENDIF
                                loc_lSucesso = .F.
                            ENDIF

                            =SEEK(ALLTRIM(CrSigPrCpo.Cgrus), "CrSigCdGrp", "Cgrus")

                            IF !EOF("CrCompoPro") AND (loc_lnTpRecal <> 2)
                                IF CrSigCdGrp.pvCompos = 2
                                    REPLACE PCompos WITH CrCompoPro.Pvens, ;
                                            Moeds   WITH CrCompoPro.Moevs ;
                                            IN CrSigPrCpo
                                ELSE
                                    REPLACE PCompos WITH CrCompoPro.CustoFs, ;
                                            Moeds   WITH CrCompoPro.MoeCusfs ;
                                            IN CrSigPrCpo
                                ENDIF
                                REPLACE UniCompos WITH CrCompoPro.Cunis, ;
                                        CUniPs    WITH CrCompoPro.CUniPs, ;
                                        Cgrus     WITH CrCompoPro.Cgrus, ;
                                        DtMovs    WITH DATETIME() ;
                                        IN CrSigPrCpo
                            ENDIF

                            LOCAL loc_lnValgr
                            loc_lnValgr = CrSigPrCpo.PCompos * ;
                                          IIF(CrSigCdGrp.chkInstalas = 2, CrSigPrCpo.Pesos, CrSigPrCpo.Qtds)

                            SELECT TotGrupo
                            SET ORDER TO GruMoe
                            IF !SEEK(ALLTRIM(CrSigPrCpo.Cgrus)+ALLTRIM(CrSigPrCpo.CPros)+ALLTRIM(CrSigPrCpo.Moeds))
                                INSERT INTO TotGrupo (Grupo, Cpros, Moeda) ;
                                    VALUES (CrSigPrCpo.Cgrus, CrSigPrCpo.Mats, CrSigPrCpo.Moeds)
                            ENDIF
                            REPLACE ValGrupo WITH ValGrupo + loc_lnValgr IN TotGrupo

                            *-- Taxa cambio moeda do componente
                            loc_lcMoeAlias = ALLTRIM(CrSigPrCpo.Moeds)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            loc_lnMoem = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                            *-- Taxa cambio moeda venda do componente
                            loc_lcMoeAlias = ALLTRIM(CrCompoPro.Moevs)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            loc_lnMoevC = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                            IF EMPTY(ALLTRIM(CrSigPrCpo.Moeds))
                                IF USED("CrCompoPro")
                                    USE IN CrCompoPro
                                ENDIF
                                SELECT CrSigPrCpo
                                LOOP
                            ENDIF

                            IF loc_lnTpRecal <> 1
                                =SEEK(ALLTRIM(CrSigPrCpo.UniCompos), "CrSigCdUni", "cUnis")
                                =SEEK(ALLTRIM(CrSigPrCpo.Cgrus), "CrSigCdGrp", "Cgrus")

                                LOCAL loc_lnVlrCvs, loc_lnQtdCvs, loc_lnMarkCv2
                                LOCAL loc_lnCotMcf, loc_lnCotMpv
                                IF CrSigCdGrp.PCustVens <> 0
                                    loc_lnVlrCvs = ROUND(CrSigPrCpo.PCompos * (1 + CrSigCdGrp.PCustVens/100), 3)
                                ELSE
                                    loc_lnVlrCvs = CrSigPrCpo.PCompos
                                ENDIF
                                IF CrSigCdUni.PCustVens <> 0
                                    loc_lnQtdCvs = ROUND(CrSigPrCpo.Qtds * (1 + CrSigCdUni.PCustVens/100), 3)
                                ELSE
                                    loc_lnQtdCvs = CrSigPrCpo.Qtds
                                ENDIF

                                IF ALLTRIM(CrSigPrCpo.Moeds) <> ALLTRIM(CrCompoPro.Moevs)
                                    loc_lcMoeAlias = ALLTRIM(CrSigPrCpo.Moeds)
                                    IF SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                                    ELSE
                                        loc_lnQtdeqs = 1
                                    ENDIF
                                    loc_lnCotMcf = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                                    loc_lcMoeAlias = ALLTRIM(CrCompoPro.Moevs)
                                    IF SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                                    ELSE
                                        loc_lnQtdeqs = 1
                                    ENDIF
                                    loc_lnCotMpv = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                                    loc_lnMarkCv2 = ROUND(IIF(loc_lnVlrCvs = 0, 0, ;
                                                    (CrCompoPro.Pvens * loc_lnCotMpv / IIF(loc_lnCotMcf=0,1,loc_lnCotMcf)) / loc_lnVlrCvs), 6)
                                ELSE
                                    loc_lnMarkCv2 = ROUND(IIF(loc_lnVlrCvs = 0, 0, CrCompoPro.Pvens / loc_lnVlrCvs), 6)
                                ENDIF

                                REPLACE VlrCvs  WITH loc_lnVlrCvs, ;
                                        QtdCvs  WITH loc_lnQtdCvs, ;
                                        MarkCvs WITH loc_lnMarkCv2, ;
                                        DtMovs  WITH DATETIME(), ;
                                        VlrPvs  WITH CrCompoPro.Pvens ;
                                        IN CrSigPrCpo

                                loc_lnTotCv  = loc_lnTotCv  + ((CrSigPrCpo.VlrCvs * CrSigPrCpo.QtdCvs) * loc_lnMoem / IIF(loc_lnMoec=0,1,loc_lnMoec))
                                loc_lnTotpCv = loc_lnTotpCv + ((CrSigPrCpo.VlrPvs * CrSigPrCpo.QtdCvs) * loc_lnMoevC / IIF(loc_lnMoedac=0,1,loc_lnMoedac))
                            ENDIF

                            IF USED("CrCompoPro")
                                USE IN CrCompoPro
                            ENDIF
                        ELSE
                            *-- Material principal: calcular apenas cambio do componente
                            loc_lcMoeAlias = ALLTRIM(CrSigPrCpo.Moeds)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            loc_lnMoem = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs
                        ENDIF

                        IF loc_lnTpRecal <> 2
                            =SEEK(ALLTRIM(CrSigPrCpo.Cgrus), "CrSigCdGrp", "Cgrus")
                            IF INLIST(CrSigCdGrp.BPesos, 1, 3)
                                LOCAL loc_lcUniPeso, loc_lnFatorU
                                loc_lcUniPeso = IIF(CrSigCdGrp.BPesos = 1, ;
                                                    ALLTRIM(CrSigPrCpo.UniCompos), ALLTRIM(CrSigPrCpo.CUniPs))
                                IF SEEK(loc_lcUniPeso, "CrSigCdUni", "cUnis")
                                    loc_lnFatorU = IIF(CrSigCdUni.Fators = 0, 1, CrSigCdUni.Fators)
                                    SELECT CrSigPrCpo
                                    loc_lnTQtde = loc_lnTQtde + ;
                                                  (IIF(CrSigCdGrp.BPesos = 1, CrSigPrCpo.Qtds, CrSigPrCpo.Pesos) * loc_lnFatorU)
                                ENDIF
                            ENDIF
                            IF CrSigCdGrp.AtuComps <> 2
                                loc_lnTotal = loc_lnTotal + ;
                                              (CrSigPrCpo.PCompos * ;
                                               IIF(CrSigCdGrp.chkInstalas = 2, CrSigPrCpo.Pesos, CrSigPrCpo.Qtds)) * ;
                                              loc_lnMoem / IIF(loc_lnMoec=0,1,loc_lnMoec)
                            ENDIF
                        ENDIF

                        IF CrSigCdGrp.cvestims = 1
                            loc_lnTotEstM = loc_lnTotEstM + ;
                                            (CrSigPrCpo.PCompos * CrSigPrCpo.Qtds) * ;
                                            loc_lnMoem / IIF(loc_lnMoedac=0,1,loc_lnMoedac)
                        ENDIF
                        SELECT CrSigPrCpo
                    ENDSCAN

                    *-- Atualizar codigo de feitio se opcao 7 ou 8
                    SELECT CrSigCdPro
                    loc_lcMarkCus = ALLTRIM(CrSigCdPro.cftiocs)
                    loc_lcMarkVen = ALLTRIM(CrSigCdPro.cftios)
                    IF INLIST(loc_lnTpRecal, 7, 8)
                        IF loc_lnTpRecal = 7 AND !EMPTY(loc_lcFtiNew)
                            loc_lcMarkCus = loc_lcFtiNew
                        ENDIF
                        IF loc_lnTpRecal = 8 AND !EMPTY(loc_lcFtiNew)
                            loc_lcMarkVen = loc_lcFtiNew
                        ENDIF
                        REPLACE cftiocs WITH loc_lcMarkCus, ;
                                cftios  WITH loc_lcMarkVen ;
                                IN CrSigCdPro
                    ENDIF

                    *-- Acumular composicao calculada em TmpPrCpo
                    SELECT CrSigPrCpo
                    GO TOP
                    SCAN
                        SCATTER MEMO MEMVAR
                        SELECT TmpPrCpo
                        APPEND BLANK
                        GATHER MEMVAR
                        SELECT CrSigPrCpo
                    ENDSCAN

                    *-- Criar LocalTGrupo a partir de CrSigPrCpo (para calculo feitio custo)
                    IF USED("LocalTGrupo")
                        USE IN LocalTGrupo
                    ENDIF
                    SELECT Cgrus AS Grupo, Mats AS Cpros, dCompos AS Dgrus, ;
                           Moeds AS Moeda, Pesos, Qtds, PCompos, ;
                           0.000 AS ValGrupo, OrdTs ;
                    FROM CrSigPrCpo ;
                    ORDER BY 1, 2, 3 ;
                    INTO CURSOR LocalTGrupo READWRITE
                    =SEEK(ALLTRIM(CrSigCdPro.Cgrus), "CrSigCdGrp", "Cgrus")
                    UPDATE LocalTGrupo SET ValGrupo = ;
                        IIF(CrSigCdGrp.chkInstalas = 2, Pesos, Qtds) * PCompos

                    *-- Calcular pftiocs (feitio de custo) se aplicavel
                    IF !EMPTY(loc_lcMarkCus)
                        loc_cSQL = "SELECT * FROM SigPrFti WHERE Cods = " + EscaparSQL(loc_lcMarkCus)
                        IF USED("TmpFtio")
                            USE IN TmpFtio
                        ENDIF
                        SQLEXEC(gnConnHandle, loc_cSQL, "TmpFtio")
                        SELECT TmpFtio
                        IF RECCOUNT() > 0 AND TmpFtio.Acrescs = 0 AND ;
                           TmpFtio.Valors = 0 AND loc_lnTpRecal <> 2
                            loc_cSQL = "SELECT a.*, IsNull(b.Dgrus,'') AS Dgrus " + ;
                                       "FROM SigPrFto a LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                                       "WHERE a.Cods = " + EscaparSQL(loc_lcMarkCus) + " " + ;
                                       "AND (a.Cgrus <> ' ' OR a.Ordem <> 0) ORDER BY a.Cods"
                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            SQLEXEC(gnConnHandle, loc_cSQL, "TmpFtioC")

                            LOCAL loc_lnVacm, loc_lnVFt, loc_lnVcoef, loc_lnVadic

                            IF TmpFtio.AplsCus <> 1
                                loc_lnVacm = 0
                                loc_lnVFt  = 0
                                SELECT LocalTGrupo
                                GO TOP
                                SCAN
                                    SELECT TmpFtioC
                                    LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(LocalTGrupo.Grupo) AND ;
                                              ALLTRIM(Cpros) = ALLTRIM(LocalTGrupo.Cpros)
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(LocalTGrupo.Grupo) AND EMPTY(Cpros)
                                    ENDIF
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR Ordem = LocalTGrupo.OrdTs AND EMPTY(Cpros)
                                    ENDIF
                                    IF !EOF("TmpFtioC")
                                        LOCAL loc_lnCoefC, loc_lnMoeFtiC, loc_lnMoeGrpC
                                        loc_lnCoefC   = IIF(EOF("TmpFtioC"), 1, TmpFtioC.Coefs)
                                        loc_lnMoeFtiC = 1
                                        loc_lnMoeGrpC = 1
                                        IF !EMPTY(ALLTRIM(TmpFtio.Moedas)) AND ;
                                           ALLTRIM(TmpFtio.Moedas) <> ALLTRIM(LocalTGrupo.Moeda)
                                            loc_lnMoeFtiC = fBuscarCotacao(ALLTRIM(TmpFtio.Moedas), DATETIME())
                                            loc_lnMoeGrpC = fBuscarCotacao(ALLTRIM(LocalTGrupo.Moeda), DATETIME())
                                        ENDIF
                                        loc_lnVcoef = ROUND(LocalTGrupo.ValGrupo * ;
                                                      loc_lnMoeGrpC / IIF(loc_lnMoeFtiC=0,1,loc_lnMoeFtiC), 3)
                                        loc_lnVadic = ROUND(loc_lnVcoef * loc_lnCoefC - loc_lnVcoef, 3)
                                        loc_lnVacm  = loc_lnVacm + loc_lnVcoef + loc_lnVadic
                                        loc_lnVFt   = loc_lnVFt + loc_lnVadic
                                    ENDIF
                                    SELECT LocalTGrupo
                                ENDSCAN
                            ELSE
                                loc_lnVacm = CrSigCdPro.PCuss
                                loc_lnVFt  = 0
                            ENDIF

                            *-- Componentes individuais de produto (ordem=0, cgrus=' ')
                            loc_cSQL = "SELECT a.*, b.Dpros FROM SigPrFto a, SigCdPro b " + ;
                                       "WHERE a.Cods = " + EscaparSQL(loc_lcMarkCus) + " " + ;
                                       "AND a.Cpros = b.Cpros AND a.Cgrus = Space(3) AND a.Ordem = 0 " + ;
                                       "ORDER BY a.Seqs"
                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            SQLEXEC(gnConnHandle, loc_cSQL, "TmpFtioC")
                            SELECT TmpFtioC
                            SCAN
                                loc_lnVcoef = loc_lnVacm
                                IF TmpFtio.DivMults = 1
                                    loc_lnVadic = ROUND(loc_lnVcoef * TmpFtioC.Coefs - loc_lnVcoef, 3)
                                ELSE
                                    loc_lnVadic = ROUND(loc_lnVcoef / (1 - TmpFtioC.Coefs/100) - loc_lnVcoef, 3)
                                ENDIF
                                loc_lnVacm = loc_lnVacm + loc_lnVadic
                                loc_lnVFt  = loc_lnVFt + loc_lnVadic
                            ENDSCAN
                            REPLACE pftiocs WITH loc_lnVFt IN CrSigCdPro
                        ENDIF
                    ENDIF

                    *-- Calcular pftios (feitio de markup de venda) usando TotGrupo
                    loc_lcFtioV = ALLTRIM(loc_lcMarkVen)
                    =SEEK(loc_lcFtioV, "CrSigPrFti", "Cods")
                    IF !EOF("CrSigPrFti") AND loc_lnTpRecal <> 2
                        IF CrSigPrFti.Acrescs = 0 AND CrSigPrFti.Valors = 0
                            loc_lcMoeAlias = ALLTRIM(CrSigPrFti.Moedas)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            LOCAL loc_lnMoeCftiV
                            loc_lnMoeCftiV = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                            SELECT CrSigPrFtiG
                            SET ORDER TO Cods
                            SET KEY TO loc_lcFtioV

                            LOCAL loc_lnVacmV, loc_lnVFtV
                            loc_lnVacmV = 0
                            loc_lnVFtV  = 0

                            SELECT TotGrupo
                            SCAN
                                SELECT CrSigPrFtiG
                                LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(TotGrupo.Grupo) AND ;
                                          ALLTRIM(Cpros) = ALLTRIM(TotGrupo.Cpros)
                                IF EOF("CrSigPrFtiG")
                                    LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(TotGrupo.Grupo)
                                ENDIF

                                LOCAL loc_lnCoefV, loc_lnMoeGrpV
                                loc_lnCoefV  = IIF(EOF("CrSigPrFtiG"), 1, CrSigPrFtiG.Coefs)
                                loc_lnMoeGrpV = 1
                                IF !EMPTY(ALLTRIM(CrSigPrFti.Moedas)) AND ;
                                   ALLTRIM(CrSigPrFti.Moedas) <> ALLTRIM(TotGrupo.Moeda)
                                    loc_lnMoeGrpV = fBuscarCotacao(ALLTRIM(TotGrupo.Moeda), DATETIME())
                                    loc_lnVcoef = ROUND(TotGrupo.ValGrupo * ;
                                                  loc_lnMoeGrpV / IIF(loc_lnMoeCftiV=0,1,loc_lnMoeCftiV), 3)
                                ELSE
                                    loc_lnVcoef = TotGrupo.ValGrupo
                                ENDIF
                                loc_lnVadic  = ROUND(loc_lnVcoef * loc_lnCoefV - loc_lnVcoef, 3)
                                loc_lnVacmV  = loc_lnVacmV + loc_lnVcoef + loc_lnVadic
                                loc_lnVFtV   = loc_lnVFtV + loc_lnVadic
                                SELECT TotGrupo
                            ENDSCAN

                            SELECT CrSigPrFtiP
                            SET ORDER TO Cods
                            SET KEY TO loc_lcFtioV
                            SELECT CrSigPrFtiP
                            SCAN
                                loc_lnVcoef = loc_lnVacmV
                                IF CrSigPrFti.DivMults = 1
                                    loc_lnVadic = ROUND(loc_lnVcoef * CrSigPrFtiP.Coefs - loc_lnVcoef, 3)
                                ELSE
                                    loc_lnVadic = ROUND(loc_lnVcoef / (1 - CrSigPrFtiP.Coefs/100) - loc_lnVcoef, 3)
                                ENDIF
                                loc_lnVacmV = loc_lnVacmV + loc_lnVadic
                                loc_lnVFtV  = loc_lnVFtV + loc_lnVadic
                            ENDSCAN
                            REPLACE pftios WITH loc_lnVFtV, ;
                                    mFtios WITH CrSigPrFti.Moedas, ;
                                    Moedas WITH IIF(EMPTY(ALLTRIM(CrSigCdPro.Moedas)), ;
                                                    CrSigPrFti.Moedas, CrSigCdPro.Moedas) ;
                                    IN CrSigCdPro
                        ELSE
                            REPLACE mFtios WITH CrSigPrFti.Moedas, ;
                                    pftios WITH CrSigPrFti.Valors * CrSigCdPro.PesoMs ;
                                    IN CrSigCdPro
                        ENDIF
                    ENDIF

                    *-- Acumular peso e custo totais
                    IF loc_lnTQtde <> 0
                        REPLACE PesoMs WITH loc_lnTQtde IN CrSigCdPro
                    ENDIF
                    IF loc_lnTotal <> 0
                        REPLACE PCuss WITH loc_lnTotal IN CrSigCdPro
                    ENDIF

                    *-- Aplicar reajuste de markup e encargo
                    IF loc_lnTpRecal <> 2
                        IF loc_lnMarkup > 0
                            REPLACE Margems WITH loc_lnMarkup IN CrSigCdPro
                        ELSE
                            REPLACE Margems WITH CrSigCdPro.Margems * loc_lnReajuste IN CrSigCdPro
                        ENDIF
                        IF loc_lnEncarg <> 0
                            REPLACE Encargos WITH loc_lnEncarg IN CrSigCdPro
                        ENDIF
                    ENDIF

                    *-- Calcular preco ideal
                    loc_lnCusto   = CrSigCdPro.PCuss
                    loc_lnfPeso   = CrSigCdPro.PesoMs * CrSigCdPro.Fcustos
                    loc_lnFator   = CrSigCdPro.Margems
                    loc_lnFeitio  = CrSigCdPro.pftios
                    loc_lnFeitioC = CrSigCdPro.pftiocs

                    *-- Taxas de cambio finais para calculo de preco
                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moecs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoec = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moepcs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoep = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moevs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoev = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.MoeCusfs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoecf = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moedas)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoedac = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.mFtios)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoeft = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    *-- Ajuste de moedas do feitio
                    IF ALLTRIM(CrSigCdPro.mFtios) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                        loc_lnFeitio = loc_lnFeitio * loc_lnMoeft / IIF(loc_lnMoecf=0,1,loc_lnMoecf)
                    ENDIF
                    IF ALLTRIM(CrSigCdPro.Moepcs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                        loc_lnFeitioC = loc_lnFeitioC * loc_lnMoep / IIF(loc_lnMoecf=0,1,loc_lnMoecf)
                    ENDIF
                    IF ALLTRIM(CrSigCdPro.Moecs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                        loc_lnCustof = loc_lnCusto * loc_lnMoec / IIF(loc_lnMoecf=0,1,loc_lnMoecf)
                    ELSE
                        loc_lnCustof = loc_lnCusto
                    ENDIF
                    loc_lnCustof = loc_lnCustof + loc_lnFeitioC

                    *-- Aplicar peso ou fator de custo
                    IF THIS.this_nCalcCusts = 2
                        IF ALLTRIM(CrSigCdPro.Moepcs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                            loc_lnCustof = loc_lnCustof * IIF(CrSigCdPro.Fcustos = 0, 1, ;
                                           CrSigCdPro.Fcustos * loc_lnMoep / IIF(loc_lnMoecf=0,1,loc_lnMoecf))
                        ELSE
                            loc_lnCustof = loc_lnCustof * IIF(CrSigCdPro.Fcustos = 0, 1, CrSigCdPro.Fcustos)
                        ENDIF
                    ELSE
                        IF ALLTRIM(CrSigCdPro.Moepcs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                            loc_lnCustof = loc_lnCustof + (loc_lnfPeso * loc_lnMoep / IIF(loc_lnMoecf=0,1,loc_lnMoecf))
                        ELSE
                            loc_lnCustof = loc_lnCustof + loc_lnfPeso
                        ENDIF
                    ENDIF

                    *-- Se feitio de venda sem acrescimo, zerar fator (markup)
                    LOCAL loc_lnFtioAcrescs, loc_lnFtioValors
                    loc_lnFtioAcrescs = 0
                    loc_lnFtioValors  = 0
                    loc_lcFtioV = ALLTRIM(CrSigCdPro.cftios)
                    IF !EMPTY(loc_lcFtioV) AND SEEK(loc_lcFtioV, "CrSigPrFti", "Cods")
                        loc_lnFtioAcrescs = CrSigPrFti.Acrescs
                        loc_lnFtioValors  = CrSigPrFti.Valors
                    ENDIF
                    IF !EMPTY(loc_lcFtioV) AND loc_lnFtioAcrescs = 0 AND loc_lnFtioValors = 0
                        loc_lnFator = 0
                    ENDIF

                    *-- Preco ideal
                    IF ALLTRIM(CrSigCdPro.MoeCusfs) <> ALLTRIM(CrSigCdPro.Moedas)
                        loc_lnIdeal = (loc_lnCustof + loc_lnFeitio) * ;
                                      loc_lnMoecf / IIF(loc_lnMoedac=0,1,loc_lnMoedac) * ;
                                      IIF(loc_lnFator=0,1,loc_lnFator)
                    ELSE
                        loc_lnIdeal = (loc_lnCustof + loc_lnFeitio) * IIF(loc_lnFator=0,1,loc_lnFator)
                    ENDIF

                    IF !EMPTY(loc_lcFtioV) AND loc_lnFtioAcrescs = 0 AND loc_lnFtioValors = 0
                        REPLACE Margems WITH IIF(loc_lnCustof = 0, 0, ;
                                               ROUND(loc_lnIdeal / loc_lnCustof, 6)) ;
                                IN CrSigCdPro
                    ENDIF

                    *-- IdealCv (valor ideal pelo cambio/grupo)
                    =SEEK(ALLTRIM(CrSigCdPro.Cgrus), "CrSigCdGrp", "Cgrus")
                    IF CrSigCdGrp.TpCalcPs = 4
                        loc_lnIdealCv = loc_lnCusto * CrSigCdPro.MarkupA
                    ELSE
                        loc_lnIdealCv = loc_lnIdeal
                    ENDIF

                    *-- Arredondamento por faixa de grupo
                    IF !EOF("CrSigCdGrp") AND CrSigCdGrp.Arredcs <> 0 AND CrSigCdGrp.TpCalcPs <> 2
                        LOCAL loc_lnFatArred, loc_lnSoma
                        loc_lnFatArred = CrSigCdGrp.Arredcs
                        loc_lnSoma = loc_lnFatArred
                        DO WHILE loc_lnSoma < loc_lnIdealCv
                            loc_lnSoma = loc_lnSoma + loc_lnFatArred
                        ENDDO
                        loc_lnIdealCv = loc_lnSoma
                        loc_lnIdeal = loc_lnIdealCv
                    ENDIF

                    *-- Recalculo por cambio (opcoes 5 e 6)
                    IF INLIST(loc_lnTpRecal, 5, 6)
                        LOCAL loc_lnCotId, loc_lnCotVd, loc_lnPvenCamb, loc_lnVlVen
                        loc_lnCotId   = fBuscarCotacao(ALLTRIM(CrSigCdPro.Moedas), DATETIME())
                        loc_lnCotVd   = fBuscarCotacao(ALLTRIM(CrSigCdPro.Moevs), DATETIME())
                        loc_lnPvenCamb = CrSigCdPro.Pvideals * loc_lnCotId / IIF(loc_lnCotVd=0,1,loc_lnCotVd)
                        loc_lnVlVen   = loc_lnPvenCamb / IIF(CrSigCdPro.Encargos<>0, CrSigCdPro.Encargos, 1)
                        IF loc_lnTpRecal = 6
                            loc_lnPvenCamb = INT(CrSigCdPro.Pvideals * loc_lnCotId / IIF(loc_lnCotVd=0,1,loc_lnCotVd))
                            loc_lnVlVen = INT(loc_lnPvenCamb / IIF(CrSigCdPro.Encargos<>0, CrSigCdPro.Encargos, 1))
                        ENDIF
                        SELECT CrSigCdPro
                        REPLACE Pvens WITH loc_lnVlVen
                    ENDIF

                    *-- Atualizar campos de preco em CrSigCdPro
                    IF loc_lnTpRecal <> 2
                        REPLACE CustoFs  WITH loc_lnCustof IN CrSigCdPro
                        REPLACE Pvideals WITH loc_lnIdeal  IN CrSigCdPro
                        REPLACE Pvens    WITH IIF(loc_lnPvenda = 1, ;
                                               loc_lnIdeal / IIF(CrSigCdPro.Encargos<>0, CrSigCdPro.Encargos, 1), ;
                                               CrSigCdPro.Pvens) ;
                                           IN CrSigCdPro
                        IF loc_lnTotEstM > 0
                            REPLACE Valors WITH loc_lnTotEstM IN CrSigCdPro
                        ENDIF
                    ENDIF

                    loc_lnMarkUpa = IIF(CrSigCdPro.CustoFs = 0, 0, ;
                                        ROUND((CrSigCdPro.Pvens * loc_lnMoev) / ;
                                              (CrSigCdPro.CustoFs * IIF(loc_lnMoecf=0,1,loc_lnMoecf)), 3))
                    REPLACE MarkupA WITH loc_lnMarkUpa IN CrSigCdPro

                    *-- Atualizar grid com valores calculados
                    SELECT cursor_4c_Dados
                    IF SEEK(ALLTRIM(CrSigCdPro.CPros), "cursor_4c_Dados", "CPros")
                        REPLACE ValAtu  WITH CrSigCdPro.Pvens, ;
                                CustoFs WITH CrSigCdPro.CustoFs ;
                                IN cursor_4c_Dados
                        REPLACE PVarias WITH IIF(cursor_4c_Dados.ValAnt = 0, 0, ;
                                              ((cursor_4c_Dados.ValAtu/cursor_4c_Dados.ValAnt - 1)*100)) ;
                                IN cursor_4c_Dados
                        REPLACE CVarias WITH IIF(cursor_4c_Dados.CustoAfs = 0, 0, ;
                                              ((cursor_4c_Dados.CustoFs/cursor_4c_Dados.CustoAfs - 1)*100)) ;
                                IN cursor_4c_Dados
                    ENDIF
                    SELECT CrSigCdPro
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
            THIS.this_lProcessado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro no processamento: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPrecos - Persiste precos calculados por Processar() no banco
    * par_lAutomatico: .T. = modo automatico (sem confirmacoes)
    * Retorna .T. se atualizacao bem-sucedida
    * PRE-REQUISITO: Processar() deve ter sido chamado antes
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPrecos(par_lAutomatico)
        LOCAL loc_lSucesso, loc_llReturn, loc_cSQL
        LOCAL loc_lcCPros, loc_lcHora, loc_lcOrigem, loc_lcIdChaves
        LOCAL loc_lnResult, loc_llImpEtiq

        loc_lSucesso = .F.
        loc_llReturn = .T.

        IF VARTYPE(par_lAutomatico) <> "L"
            par_lAutomatico = THIS.this_lAutomatico
        ENDIF

        *-- Confirmar atualizacao
        IF !par_lAutomatico
            IF !MsgConfirma("Atualiza ???", "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
                RETURN .F.
            ENDIF
            loc_llImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")
        ELSE
            loc_llImpEtiq = .F.
        ENDIF

        *-- Selecionar apenas produtos marcados (lMarca=1)
        IF USED("CsProdutos")
            USE IN CsProdutos
        ENDIF
        SELECT * FROM cursor_4c_Dados WHERE lMarca = 1 ORDER BY CPros ;
            INTO CURSOR CsProdutos READWRITE
        SELECT CsProdutos
        GO TOP
        IF EOF()
            IF !par_lAutomatico
                MsgAviso("Nenhum Produto Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
            ENDIF
            RETURN .F.
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT CsProdutos
            GO TOP
            SCAN
                loc_lcCPros = ALLTRIM(CsProdutos.CPros)

                *-- Verificar se produto existe em CrSigCdPro (calculado por Processar)
                IF !SEEK(loc_lcCPros, "CrSigCdPro", "CPros")
                    SELECT CsProdutos
                    LOOP
                ENDIF

                *-- Registrar historico de precos em SigCdPrc (antes da atualizacao)
                loc_lcHora   = SUBSTR(TTOC(DATETIME()), 12, 8)
                loc_lcOrigem = TTOC(DATETIME()) + " SigPrCcp"
                loc_lcIdChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigCdPrc (" + ;
                           "cidchaves, dataalts, horaalts, usuaalts, origem, " + ;
                           "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                           "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                           "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                           "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                           "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                           "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                           "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                           "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                           "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                           "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                           "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                           "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                           "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                           "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                           "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts)" + ;
                           " SELECT " + ;
                           EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                           EscaparSQL(loc_lcHora) + ", " + ;
                           EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                           EscaparSQL(loc_lcOrigem) + ", " + ;
                           "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                           "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                           "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                           "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                           "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                           "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                           "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                           "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                           "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                           "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                           "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                           "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                           "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                           "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                           "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts " + ;
                           "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_lcCPros)
                loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_lnResult < 1
                    IF !par_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdPrc)")
                    ENDIF
                    loc_llReturn = .F.
                    EXIT
                ENDIF

                *-- Historico de composicao em SigPrCp2
                SELECT TmpPrCpo
                SET ORDER TO CPros
                =SEEK(loc_lcCPros, "TmpPrCpo", "CPros")
                SCAN WHILE ALLTRIM(CPros) = loc_lcCPros
                    loc_lcIdChaves = fUniqueIds()
                    loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                    loc_cSQL = "INSERT INTO SIGPRCP2 (" + ;
                               "cidchaves, dataalts, horaalts, usuaalts, " + ;
                               "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, " + ;
                               "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, " + ;
                               "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, " + ;
                               "dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, " + ;
                               "ordts, tipos, matriz, obsofs) VALUES (" + ;
                               EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                               EscaparSQL(loc_lcHora) + ", " + ;
                               EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cats))      + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cgrus))     + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cpros))     + ", " + ;
                               "NULL, " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.dcompos))   + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.dscgrp))    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.etiqs))     + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.grupos))    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.mats))      + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.moeds))     + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.obscompos)) + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.ordems)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.pcompos)  + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.qtds)     + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.qtscons)  + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.unicompos)) + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.compos))   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.ordcompos) + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.qtdcvs)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.vlrcvs)   + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cunips))    + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.markcvs)  + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.pesos)    + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.totas)    + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.tpalts)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.vlrpvs)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.ordts)    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.tipos))    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.matriz))   + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.obsofs))   + ")"
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_lnResult < 1
                        IF !par_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (SigPrCp2)")
                        ENDIF
                        loc_llReturn = .F.
                        EXIT
                    ENDIF
                    SELECT TmpPrCpo
                ENDSCAN

                IF !loc_llReturn
                    EXIT
                ENDIF

                *-- Deletar SigPrPrt para este produto
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_lcCPros))

                *-- Atualizar preco principal em SigCdPro
                SELECT CrSigCdPro
                IF SEEK(loc_lcCPros, "CrSigCdPro", "CPros")
                    loc_cSQL = "UPDATE SigCdPro SET " + ;
                               "CustoFs  = " + FormatarNumeroSQL(CrSigCdPro.CustoFs)  + ", " + ;
                               "Pvideals = " + FormatarNumeroSQL(CrSigCdPro.Pvideals) + ", " + ;
                               "Pvens    = " + FormatarNumeroSQL(CrSigCdPro.Pvens)    + ", " + ;
                               "Margems  = " + FormatarNumeroSQL(CrSigCdPro.Margems)  + ", " + ;
                               "Encargos = " + FormatarNumeroSQL(CrSigCdPro.Encargos) + ", " + ;
                               "PesoMs   = " + FormatarNumeroSQL(CrSigCdPro.PesoMs)   + ", " + ;
                               "PCuss    = " + FormatarNumeroSQL(CrSigCdPro.PCuss)    + ", " + ;
                               "MarkupA  = " + FormatarNumeroSQL(CrSigCdPro.MarkupA)  + ", " + ;
                               "pftios   = " + FormatarNumeroSQL(CrSigCdPro.pftios)   + ", " + ;
                               "mFtios   = " + EscaparSQL(ALLTRIM(CrSigCdPro.mFtios)) + ", " + ;
                               "Moedas   = " + EscaparSQL(ALLTRIM(CrSigCdPro.Moedas)) + ", " + ;
                               "pftiocs  = " + FormatarNumeroSQL(CrSigCdPro.pftiocs)  + ", " + ;
                               "cftios   = " + EscaparSQL(ALLTRIM(CrSigCdPro.cftios)) + ", " + ;
                               "cftiocs  = " + EscaparSQL(ALLTRIM(CrSigCdPro.cftiocs))+ ", " + ;
                               "Valors   = " + FormatarNumeroSQL(CrSigCdPro.Valors)   + ", " + ;
                               "ImpEtiqs = " + IIF(loc_llImpEtiq, "1", "0") + " " + ;
                               "WHERE cpros = " + EscaparSQL(loc_lcCPros)
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_lnResult < 1
                        IF !par_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha UPDATE SigCdPro")
                        ENDIF
                        loc_llReturn = .F.
                        EXIT
                    ENDIF
                ENDIF

                *-- Atualizar composicao em SigPrCpo com valores calculados
                SELECT TmpPrCpo
                SET ORDER TO CPros
                =SEEK(loc_lcCPros, "TmpPrCpo", "CPros")
                SCAN WHILE ALLTRIM(CPros) = loc_lcCPros
                    loc_cSQL = "UPDATE SigPrCpo SET " + ;
                               "PCompos   = " + FormatarNumeroSQL(TmpPrCpo.PCompos)   + ", " + ;
                               "Moeds     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Moeds))   + ", " + ;
                               "UniCompos = " + EscaparSQL(ALLTRIM(TmpPrCpo.UniCompos))+ ", " + ;
                               "CUniPs    = " + EscaparSQL(ALLTRIM(TmpPrCpo.CUniPs))  + ", " + ;
                               "Cgrus     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Cgrus))   + ", " + ;
                               "DtMovs    = GETDATE(), " + ;
                               "VlrCvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrCvs)   + ", " + ;
                               "QtdCvs    = " + FormatarNumeroSQL(TmpPrCpo.QtdCvs)   + ", " + ;
                               "MarkCvs   = " + FormatarNumeroSQL(TmpPrCpo.MarkCvs)  + ", " + ;
                               "VlrPvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrPvs)   + " " + ;
                               "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(TmpPrCpo.cIdChaves))
                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT TmpPrCpo
                ENDSCAN

                SELECT CsProdutos
            ENDSCAN

            *-- Atualizar subgrupo por faixa de preco (se configurado)
            IF loc_llReturn AND THIS.this_nNChkSubGrs = 1
                SELECT CrSigCdPro
                GO TOP
                SCAN
                    IF !SEEK(ALLTRIM(CrSigCdPro.CPros), "cursor_4c_Dados", "CPros")
                        SELECT CrSigCdPro
                        LOOP
                    ENDIF
                    IF cursor_4c_Dados.lMarca <> 1
                        SELECT CrSigCdPro
                        LOOP
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigCdPsg WHERE CGrus = '" + ALLTRIM(CrSigCdPro.cGrus) + ;
                               "' ORDER BY nFaixaFins"
                    IF USED("csSigCdPsg")
                        USE IN csSigCdPsg
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSigCdPsg")
                    IF loc_nResult < 1
                        IF !par_lAutomatico
                            MsgErro("Favor reinicializar o processo !!!", "Falha (csSigCdPsg)")
                        ENDIF
                        loc_llReturn = .F.
                        EXIT
                    ENDIF
                    LOCAL loc_lnPVens
                    loc_lnPVens = IIF(CrSigCdPro.pVens = 0, CrSigCdPro.pvideals, CrSigCdPro.pVens)
                    SELECT csSigCdPsg
                    LOCATE FOR nFaixaFins >= loc_lnPVens
                    IF !EOF("csSigCdPsg")
                        loc_cSQL = "UPDATE SigCdPro SET sGrus = " + ;
                                   EscaparSQL(ALLTRIM(csSigCdPsg.Codigos)) + ;
                                   " WHERE cpros = " + EscaparSQL(ALLTRIM(CrSigCdPro.CPros))
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    IF USED("csSigCdPsg")
                        USE IN csSigCdPsg
                    ENDIF
                    SELECT CrSigCdPro
                ENDSCAN
            ENDIF

            IF loc_llReturn
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                IF !par_lAutomatico
                    MsgInfo("Processamento Finalizado com Sucesso !!!", "")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                IF !par_lAutomatico
                    MsgErro("Falha na Atualiza" + CHR(231) + CHR(227) + "o. Reinicie o Processo !!!", "Arquivo")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MsgErro("Erro ao atualizar precos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessaAutomatico - Processa configuracoes de recalculo de SigCdCcp
    * automaticamente, sem interacao com usuario
    *--------------------------------------------------------------------------
    PROCEDURE ProcessaAutomatico()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lnOldSel, loc_lnVaria

        loc_lSucesso = .F.
        loc_lnOldSel = SELECT()

        TRY
            loc_cSQL = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"
            IF USED("crSigCdCcp")
                USE IN crSigCdCcp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCcp")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (SigCdCcp)")
            ELSE
                SELECT crSigCdCcp
                GO TOP
                SCAN
                    THIS.CriarCursorDados()

                    THIS.this_cFornecs  = ALLTRIM(crSigCdCcp.cfornecs)
                    THIS.this_cMercI    = ALLTRIM(crSigCdCcp.merci)
                    THIS.this_cMercF    = ALLTRIM(crSigCdCcp.mercf)
                    THIS.this_cGruI     = ALLTRIM(crSigCdCcp.cgrui)
                    THIS.this_cGruF     = ALLTRIM(crSigCdCcp.cgruf)
                    THIS.this_cSGruI    = ALLTRIM(crSigCdCcp.sgrui)
                    THIS.this_cSGruF    = ALLTRIM(crSigCdCcp.sgruf)
                    THIS.this_cCuniI    = ALLTRIM(crSigCdCcp.cunii)
                    THIS.this_cCuniF    = ALLTRIM(crSigCdCcp.cunif)
                    THIS.this_cLinI     = ALLTRIM(crSigCdCcp.lini)
                    THIS.this_cLinF     = ALLTRIM(crSigCdCcp.linf)
                    THIS.this_cColI     = ALLTRIM(crSigCdCcp.coli)
                    THIS.this_cColF     = ALLTRIM(crSigCdCcp.colf)
                    THIS.this_cMoeI     = ALLTRIM(crSigCdCcp.moedai)
                    THIS.this_cMoeF     = ALLTRIM(crSigCdCcp.moedaf)
                    THIS.this_nFoption1 = NVL(crSigCdCcp.opcmoedatp, 1)
                    THIS.this_nMrkI     = NVL(crSigCdCcp.mrki, 0)
                    THIS.this_nMrkF     = NVL(crSigCdCcp.mrkf, 0)
                    THIS.this_nEncI     = NVL(crSigCdCcp.enci, 0)
                    THIS.this_nEncF     = NVL(crSigCdCcp.encf, 0)
                    THIS.this_nVariacao = NVL(crSigCdCcp.variacao, 0)
                    THIS.this_cFeitio   = ALLTRIM(crSigCdCcp.feitio)
                    THIS.this_nSituacao = NVL(crSigCdCcp.opcsit, 3)
                    THIS.this_nRecalc   = NVL(crSigCdCcp.opcrecalc, 1)
                    THIS.this_nReajuste = NVL(crSigCdCcp.reajuste, 0)
                    THIS.this_nEncargo  = NVL(crSigCdCcp.encargo, 0)
                    THIS.this_nNMrk     = NVL(crSigCdCcp.nmrk, 0)
                    THIS.this_nPven     = NVL(crSigCdCcp.opcpven, 2)
                    THIS.this_cNewMkp   = ALLTRIM(crSigCdCcp.newmkp)

                    IF THIS.Processar()
                        *-- Filtrar por variacao
                        loc_lnVaria = THIS.this_nVariacao
                        IF loc_lnVaria > 0
                            DELETE FROM cursor_4c_Dados WHERE PVarias < loc_lnVaria
                        ENDIF
                        IF loc_lnVaria < 0
                            DELETE FROM cursor_4c_Dados WHERE PVarias > loc_lnVaria
                        ENDIF
                        *-- Marcar todos como selecionados para atualizacao
                        UPDATE cursor_4c_Dados SET lMarca = 1

                        IF !THIS.AtualizarPrecos(.T.)
                            EXIT
                        ENDIF
                    ENDIF

                    SELECT crSigCdCcp
                ENDSCAN

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro no processamento automatico: " + loc_oErro.Message, "Erro")
        ENDTRY

        SELECT (loc_lnOldSel)
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega TODAS as colunas do cursor SigPrCpo nas
    * propriedades this_* do BO. Usado para operacoes CRUD individuais em
    * registros de composicao de produto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cAliasCursor
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            *-- Chave primaria e identificacao
            THIS.this_cIdChaves  = ALLTRIM(NVL(cidchaves, ""))
            THIS.this_cCats      = ALLTRIM(NVL(cats,      ""))
            THIS.this_cCgrus     = ALLTRIM(NVL(cgrus,     ""))
            THIS.this_cCpros     = ALLTRIM(NVL(cpros,     ""))
            THIS.this_cPro       = THIS.this_cCpros

            *-- Datas
            IF TYPE(par_cAliasCursor + ".datatrans") != "U"
                THIS.this_dDatatrans = IIF(ISNULL(datatrans), {}, datatrans)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dtmovs") != "U"
                THIS.this_dDtmovs = IIF(ISNULL(dtmovs), {}, dtmovs)
            ENDIF

            *-- Descricoes e textos
            THIS.this_cDcompos   = ALLTRIM(NVL(dcompos,   ""))
            THIS.this_cDscgrp    = ALLTRIM(NVL(dscgrp,    ""))
            THIS.this_cEtiqs     = ALLTRIM(NVL(etiqs,     ""))
            THIS.this_cGrupos    = ALLTRIM(NVL(grupos,    ""))
            THIS.this_cMats      = ALLTRIM(NVL(mats,      ""))
            THIS.this_cMoeds     = ALLTRIM(NVL(moeds,     ""))
            THIS.this_cObscompos = ALLTRIM(NVL(obscompos, ""))
            THIS.this_cUnicompos = ALLTRIM(NVL(unicompos, ""))
            THIS.this_cCompos    = ALLTRIM(NVL(compos,    ""))
            THIS.this_cCunips    = ALLTRIM(NVL(cunips,    ""))
            THIS.this_cTipos     = ALLTRIM(NVL(tipos,     ""))
            THIS.this_cMatriz    = ALLTRIM(NVL(matriz,    ""))
            THIS.this_cObsofs    = ALLTRIM(NVL(obsofs,    ""))

            *-- Valores numericos
            THIS.this_nOrdems    = NVL(ordems,    0)
            THIS.this_nPcompos   = NVL(pcompos,   0)
            THIS.this_nQtds      = NVL(qtds,      0)
            THIS.this_nQtscons   = NVL(qtscons,   0)
            THIS.this_nOrdcompos = NVL(ordcompos, 0)
            THIS.this_nQtdcvs    = NVL(qtdcvs,    0)
            THIS.this_nVlrcvs    = NVL(vlrcvs,    0)
            THIS.this_nMarkcvs   = NVL(markcvs,   0)
            THIS.this_nPesos     = NVL(pesos,     0)
            THIS.this_nTotas     = NVL(totas,     0)
            THIS.this_nTpalts    = NVL(tpalts,    0)
            THIS.this_nVlrpvs    = NVL(vlrpvs,    0)
            THIS.this_nOrdts     = NVL(ordts,     0)

            *-- PedraPrincipal (coluna case-sensitive no SQL Server, mas VFP e case-insensitive)
            IF TYPE(par_cAliasCursor + ".PedraPrincipal") != "U"
                THIS.this_nPedraPrincipal = NVL(PedraPrincipal, 0)
            ENDIF

            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            MsgErro("Erro ao carregar dados de composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigPrCpo (composicao de produto)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro = .T.
    * Registra auditoria apos INSERT bem-sucedido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            *-- Gerar chave primaria se vazia (padrao: cpros + ordems)
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = LEFT(ALLTRIM(THIS.this_cCpros) + PADL(TRANSFORM(THIS.this_nOrdems), 6, "0"), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                       "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, " + ;
                       "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, " + ;
                       "qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, " + ;
                       "vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, " + ;
                       "vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCats)      + ", " + ;
                       EscaparSQL(THIS.this_cCgrus)     + ", " + ;
                       EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans)) + ", " + ;
                       EscaparSQL(THIS.this_cDcompos)   + ", " + ;
                       EscaparSQL(THIS.this_cDscgrp)    + ", " + ;
                       EscaparSQL(THIS.this_cEtiqs)     + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       EscaparSQL(THIS.this_cMats)      + ", " + ;
                       EscaparSQL(THIS.this_cMoeds)     + ", " + ;
                       EscaparSQL(THIS.this_cObscompos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       EscaparSQL(THIS.this_cUnicompos) + ", " + ;
                       EscaparSQL(THIS.this_cCompos)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdcompos) + ", " + ;
                       EscaparSQL(THIS.this_cIdChaves)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdcvs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrcvs)    + ", " + ;
                       IIF(EMPTY(THIS.this_dDtmovs), "NULL", FormatarDataSQL(THIS.this_dDtmovs)) + ", " + ;
                       EscaparSQL(THIS.this_cCunips)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMarkcvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpalts)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrpvs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdts)     + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cMatriz)    + ", " + ;
                       EscaparSQL(THIS.this_cObsofs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Registrar auditoria
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigPrCpo"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigPrCpo
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro = .F.
    * Registra auditoria apos UPDATE bem-sucedido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia - n" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel atualizar"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                       "cats = "      + EscaparSQL(THIS.this_cCats)      + ", " + ;
                       "cgrus = "     + EscaparSQL(THIS.this_cCgrus)     + ", " + ;
                       "cpros = "     + EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       "datatrans = " + IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans)) + ", " + ;
                       "dcompos = "   + EscaparSQL(THIS.this_cDcompos)   + ", " + ;
                       "dscgrp = "    + EscaparSQL(THIS.this_cDscgrp)    + ", " + ;
                       "etiqs = "     + EscaparSQL(THIS.this_cEtiqs)     + ", " + ;
                       "grupos = "    + EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       "mats = "      + EscaparSQL(THIS.this_cMats)      + ", " + ;
                       "moeds = "     + EscaparSQL(THIS.this_cMoeds)     + ", " + ;
                       "obscompos = " + EscaparSQL(THIS.this_cObscompos) + ", " + ;
                       "ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       "pcompos = "   + FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       "qtds = "      + FormatarNumeroSQL(THIS.this_nQtds)      + ", " + ;
                       "qtscons = "   + FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       "unicompos = " + EscaparSQL(THIS.this_cUnicompos) + ", " + ;
                       "compos = "    + EscaparSQL(THIS.this_cCompos)    + ", " + ;
                       "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdcompos) + ", " + ;
                       "qtdcvs = "    + FormatarNumeroSQL(THIS.this_nQtdcvs)    + ", " + ;
                       "vlrcvs = "    + FormatarNumeroSQL(THIS.this_nVlrcvs)    + ", " + ;
                       "dtmovs = "    + IIF(EMPTY(THIS.this_dDtmovs), "NULL", FormatarDataSQL(THIS.this_dDtmovs)) + ", " + ;
                       "cunips = "    + EscaparSQL(THIS.this_cCunips)    + ", " + ;
                       "markcvs = "   + FormatarNumeroSQL(THIS.this_nMarkcvs)   + ", " + ;
                       "pesos = "     + FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       "totas = "     + FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       "tpalts = "    + FormatarNumeroSQL(THIS.this_nTpalts)    + ", " + ;
                       "vlrpvs = "    + FormatarNumeroSQL(THIS.this_nVlrpvs)    + ", " + ;
                       "ordts = "     + FormatarNumeroSQL(THIS.this_nOrdts)     + ", " + ;
                       "tipos = "     + EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       "matriz = "    + EscaparSQL(THIS.this_cMatriz)    + ", " + ;
                       "obsofs = "    + EscaparSQL(THIS.this_cObsofs)    + ", " + ;
                       "PedraPrincipal = " + FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Registrar auditoria
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigPrCpo"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro atual de SigPrCpo pela chave primaria
    * Chamado por BusinessBase.Excluir() apos passar por AntesDeExcluir().
    * Registra auditoria apos DELETE bem-sucedido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia - n" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir"
            RETURN .F.
        ENDIF

        TRY
            *-- Registrar auditoria ANTES do DELETE (chave ainda existe)
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigPrCpo WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir registro de SigPrCpo"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
