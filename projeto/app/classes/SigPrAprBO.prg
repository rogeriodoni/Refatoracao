*==============================================================================
* SigPrAprBO.prg - Business Object para Reajuste de Precificacao
* Herda de BusinessBase
* Tabela principal: SigCdPro (Produtos)
* Fases 1+2: Propriedades, Init() e metodos de negocio
*==============================================================================

DEFINE CLASS SigPrAprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Filtros de selecao de produtos
    *--------------------------------------------------------------------------
    this_cGrupoInicio = ""    && Get_Cd_Grupo  (SigCdGrp.CGrus)   MaxLen=3
    this_cGrupoFim    = ""    && Get_ate_Grupo (SigCdGrp.CGrus)   MaxLen=3
    this_cColecao     = ""    && Get_Col       (SigCdCol.Colecoes) MaxLen=10
    this_cConta       = ""    && Get_Conta     (Fornecedor/IClis)
    this_cDConta      = ""    && Get_DConta    (Descricao conta)   MaxLen=50
    this_cPromo       = ""    && Get_Promo     (SigPrPmc.Promos)  MaxLen=25

    *--------------------------------------------------------------------------
    * Tipo de reajuste (Opt_Tipo)
    * 1=Variacao%, 2=MarkUp, 3=Cambio
    *--------------------------------------------------------------------------
    this_nTipo        = 0

    *--------------------------------------------------------------------------
    * Parametros por tipo de reajuste
    *--------------------------------------------------------------------------
    this_nVariacao    = 0     && Get_Variacao  N(8,2)  - Tipo 1
    this_cMoeda       = ""    && Get_Moeda     C(3)    - Tipo 2
    this_nMarkUp1     = 0     && Get_MarkUp1   N(6,2)  - Tipo 2 (markup origem)
    this_nMarkUp2     = 0     && Get_MarkUp2   N(6,2)  - Tipo 2 (markup destino)
    this_nFator       = 0     && GET_FATOR     N(8,3)  - Fator de Custo

    *--------------------------------------------------------------------------
    * Moedas auxiliares para calculo de preco
    *--------------------------------------------------------------------------
    this_cMoeCs       = ""    && Get_Moecs     C(3) - Moeda Custo Composicao
    this_cMoeCusFs    = ""    && Get_MoeCusFs  C(3) - Moeda Custo Total
    this_cMoedas      = ""    && Get_Moedas    C(3) - Moeda Preco Ideal
    this_cMoeVs       = ""    && Get_MoeVs     C(3) - Moeda Preco Atual
    this_cCFtios      = ""    && Get_CFtios    C(3) - Feitio (SigPrFti.Cods)
    this_cMoeCusto    = ""    && get_moeCusto  C(3) - Moeda do fator de custo

    *--------------------------------------------------------------------------
    * Flags de opcao do processamento
    *--------------------------------------------------------------------------
    this_nAuditado    = 0     && chkAuditado  - Modo manual (0=normal, 1=auditado)
    this_nLimpar      = 0     && chkLimpar    - Limpar promocoes anteriores
    this_nIncCusts    = 0     && chkIncCusts  - Incluir custos no reajuste
    this_nIgnorar     = 0     && chkIgnorar   - Ignorar componentes (SigPrCpo)

    *--------------------------------------------------------------------------
    * Controle de acesso
    *--------------------------------------------------------------------------
    this_lLibValAtu   = .F.   && LibValAtu - permite edicao manual do preco no grid
    this_cAntValue    = ""    && AntValue  - valor anterior do campo em edicao

    *--------------------------------------------------------------------------
    * Linha corrente do cursor cursor_4c_Produtos (espelha campos do grid)
    *--------------------------------------------------------------------------
    this_nLMarca      = 0     && cursor_4c_Produtos.lMarca   N(1)    - checkbox selecao
    this_cCPros       = ""    && cursor_4c_Produtos.CPros    C(14)   - codigo produto
    this_cDPros       = ""    && cursor_4c_Produtos.DPros    C(40)   - descricao produto
    this_nValAnt      = 0     && cursor_4c_Produtos.ValAnt   N(14,2) - preco anterior
    this_nValAtu      = 0     && cursor_4c_Produtos.ValAtu   N(14,2) - preco atual
    this_nFCustos     = 0     && cursor_4c_Produtos.fCustos  N(8,3)  - fator de custo
    this_cMoePcs      = ""    && cursor_4c_Produtos.MoePcs   C(3)    - moeda preco custo
    this_nCustoFs     = 0     && cursor_4c_Produtos.CustoFs  N(12,3) - custo final
    this_nManual      = 0     && cursor_4c_Produtos.Manual   N(1)    - editado manualmente

    *--------------------------------------------------------------------------
    * Parametros do sistema (carregados na inicializacao do form)
    *--------------------------------------------------------------------------
    this_nMarkUpCVs   = 0     && CrSigCdPam.MarkUpCVs - MarkUp padrao
    this_cGrPadFors   = ""    && CrSigCdPam.GrPadFors - grupo padrao fornecedores
    this_nCalcCusts   = 0     && CrSigCdPac.CalcCusts  - modo calculo custo
    this_nChkSubGrs   = 0     && CrSigCdPac.nChkSubGrs - verifica sub-grupos preco

    *--------------------------------------------------------------------------
    * Estado do processamento
    *--------------------------------------------------------------------------
    this_lProcessado  = .F.   && .T. apos BtnProcessar bem-sucedido
    this_lAtualizado  = .F.   && .T. apos BtnAtualizar bem-sucedido

    *--------------------------------------------------------------------------
    * Resultado de calculos internos
    *--------------------------------------------------------------------------
    this_nMarkupA    = 0      && MarkupA calculado (resultado de CalcMarkpa)
    this_nCustoFCalc = 0      && CustoF calculado  (resultado de CalcPreco)

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "CPros"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna codigo do produto atual para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCPros
    ENDPROC

    *==========================================================================
    * CarregarDadosIniciais - Carrega parametros do sistema e cursores de trabalho
    *==========================================================================
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                loc_lSucesso = .T.
            ELSE
            *-- Permissao de edicao manual de preco no grid
            THIS.this_lLibValAtu = fChecaAcesso("SIGPRAPR", "VMANUAL")

            *-- Parametros gerais do sistema (SigCdPam)
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            loc_cSQL = "SELECT TOP 1 MarkUpCVs, GrPadFors FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") < 1
                MsgErro("Falha ao carregar SigCdPam.", "Erro SigPrAprBO")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_SigCdPam
            GO TOP
            IF !EOF("cursor_4c_SigCdPam")
                THIS.this_nMarkUpCVs = NVL(cursor_4c_SigCdPam.MarkUpCVs, 0)
                THIS.this_cGrPadFors = NVL(ALLTRIM(cursor_4c_SigCdPam.GrPadFors), "")
            ENDIF
            USE IN cursor_4c_SigCdPam

            *-- Configuracoes de calculo (SigCdPac)
            IF USED("cursor_4c_SigCdPac")
                USE IN cursor_4c_SigCdPac
            ENDIF
            loc_cSQL = "SELECT TOP 1 CalcCusts, nChkSubGrs FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") < 1
                MsgErro("Falha ao carregar SigCdPac.", "Erro SigPrAprBO")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_SigCdPac
            GO TOP
            IF !EOF("cursor_4c_SigCdPac")
                THIS.this_nCalcCusts = NVL(cursor_4c_SigCdPac.CalcCusts,  0)
                THIS.this_nChkSubGrs = NVL(cursor_4c_SigCdPac.nChkSubGrs, 0)
            ENDIF
            USE IN cursor_4c_SigCdPac

            *-- Grupos de produto para arredondamento (SigCdGrp)
            IF USED("cursor_4c_SigCdGrp")
                USE IN cursor_4c_SigCdGrp
            ENDIF
            loc_cSQL = "SELECT CGrus, Arreds FROM SigCdGrp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdGrp") < 1
                MsgErro("Falha ao carregar SigCdGrp.", "Erro SigPrAprBO")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_SigCdGrp
            INDEX ON CGrus TAG CGrus
            GO TOP

            *-- Cursor do grid (produtos calculados)
            IF USED("cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos (lMarca N(1) NULL, CPros C(14) NULL, DPros C(40) NULL, ;
                ValAnt N(14,2) NULL, ValAtu N(14,2) NULL, fCustos N(8,3) NULL, MoePcs C(3) NULL, ;
                CustoFs N(12,3) NULL, Manual N(1) NULL)
            INDEX ON CPros TAG CPros
            SET NULL OFF
            SELECT cursor_4c_Produtos
            SET ORDER TO
            GO TOP

            *-- Snapshot de SigCdPro como buffer de trabalho ReadWrite
            IF USED("cursor_4c_TmpProSQL")
                USE IN cursor_4c_TmpProSQL
            ENDIF
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPro WHERE 0=1"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProSQL") < 1
                MsgErro("Falha ao preparar buffer SigCdPro.", "Erro SigPrAprBO")
                loc_lSucesso = .F.
            ENDIF
            SELECT * FROM cursor_4c_TmpProSQL INTO CURSOR cursor_4c_TmpPro READWRITE NOFILTER
            USE IN cursor_4c_TmpProSQL
            SELECT cursor_4c_TmpPro
            INDEX ON CPros TAG CPros
            GO TOP

            loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpProSQL")
                USE IN cursor_4c_TmpProSQL
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.CarregarDadosIniciais")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia linha do cursor para propriedades this_*
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_oErro

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_nLMarca  = lMarca
            THIS.this_cCPros   = ALLTRIM(CPros)
            THIS.this_cDPros   = ALLTRIM(DPros)
            THIS.this_nValAnt  = ValAnt
            THIS.this_nValAtu  = ValAtu
            THIS.this_nFCustos = fCustos
            THIS.this_cMoePcs  = ALLTRIM(MoePcs)
            THIS.this_nCustoFs = CustoFs
            THIS.this_nManual  = Manual
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.CarregarDoCursor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ProcessarReajuste - Calcula novos precos e popula cursor_4c_Produtos
    *==========================================================================
    PROCEDURE ProcessarReajuste()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere
        LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPven
        LOCAL loc_cMoePcs, loc_nFCustos, loc_nCustoFs, loc_nCustoFOriginal
        LOCAL loc_loBarra

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros por tipo
            DO CASE
            CASE THIS.this_nTipo = 1
                IF THIS.this_nVariacao = 0
                    MsgAviso("Varia" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!", ;
                        "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
            CASE THIS.this_nTipo = 2
                IF EMPTY(ALLTRIM(THIS.this_cMoeda))
                    MsgAviso("Moeda Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
                IF THIS.this_nMarkUp2 = 0
                    MsgAviso("MarkUp Inv" + CHR(225) + "lido !!!", "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
            ENDCASE

            *-- Limpar cursor do grid
            IF USED("cursor_4c_Produtos")
                ZAP IN cursor_4c_Produtos
            ENDIF

            *-- Montar clausula WHERE da consulta
            loc_cWhere = "0 = 0"

            IF !EMPTY(ALLTRIM(THIS.this_cGrupoInicio)) OR !EMPTY(ALLTRIM(THIS.this_cGrupoFim))
                IF !EMPTY(ALLTRIM(THIS.this_cGrupoFim))
                    loc_cWhere = loc_cWhere + " AND CGrus BETWEEN " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoInicio)) + ;
                        " AND " + EscaparSQL(ALLTRIM(THIS.this_cGrupoFim))
                ELSE
                    loc_cWhere = loc_cWhere + " AND CGrus = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoInicio))
                ENDIF
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cColecao))
                loc_cWhere = loc_cWhere + " AND Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecao))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + " AND IFors = " + EscaparSQL(ALLTRIM(THIS.this_cConta))
            ENDIF

            IF THIS.this_nTipo = 2
                loc_cWhere = loc_cWhere + ;
                    " AND MoeVs = "   + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + ;
                    " AND Margems = " + FormatarNumeroSQL(THIS.this_nMarkUp1)
            ENDIF

            IF THIS.this_nIgnorar = 0
                loc_cWhere = loc_cWhere + ;
                    " AND CPros NOT IN (SELECT DISTINCT CPros FROM SigPrCpo)"
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdPro WHERE " + loc_cWhere + " ORDER BY CPros"

            *-- Buscar produtos e criar buffer ReadWrite
            IF USED("cursor_4c_TmpProSQL")
                USE IN cursor_4c_TmpProSQL
            ENDIF
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProSQL") < 1
                MsgErro("Falha ao buscar produtos para processamento.", "Erro SigPrAprBO.ProcessarReajuste")
                loc_lSucesso = .F.
            ENDIF

            SELECT * FROM cursor_4c_TmpProSQL INTO CURSOR cursor_4c_TmpPro READWRITE NOFILTER
            USE IN cursor_4c_TmpProSQL
            SELECT cursor_4c_TmpPro
            INDEX ON CPros TAG CPros
            GO TOP

            IF RECCOUNT("cursor_4c_TmpPro") = 0
                MsgAviso("Nenhum produto encontrado com os filtros informados.", "Processamento")
                loc_lSucesso = .F.
            ENDIF

            *-- Progresso
            loc_loBarra = CREATEOBJECT("fwprogressbar", "Recalculando Valores...", ;
                RECCOUNT("cursor_4c_TmpPro"))
            loc_loBarra.Show

            *-- Calcular novo preco para cada produto
            SELECT cursor_4c_TmpPro
            GO TOP
            SCAN
                loc_loBarra.Update(.T.)

                loc_nCustoFOriginal  = cursor_4c_TmpPro.CustoFs
                THIS.this_nCustoFCalc = loc_nCustoFOriginal

                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nValAtu = cursor_4c_TmpPro.PVens + ;
                        ((cursor_4c_TmpPro.PVens * THIS.this_nVariacao) / 100)

                CASE THIS.this_nTipo = 2
                    loc_nValAtu = THIS.CalcPreco(THIS.this_nMarkUp2)

                CASE THIS.this_nTipo = 3
                    loc_nCotId = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moedas), DATETIME(), gnConnHandle)
                    loc_nCotVd = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moevs),  DATETIME(), gnConnHandle)
                    loc_nPven  = cursor_4c_TmpPro.Pvideals * loc_nCotId / ;
                        IIF(loc_nCotVd=0, 1, loc_nCotVd)
                    loc_nValAtu = loc_nPven / ;
                        IIF(cursor_4c_TmpPro.Encargos<>0, cursor_4c_TmpPro.Encargos, 1)

                OTHERWISE
                    loc_nValAtu = cursor_4c_TmpPro.PVens
                ENDCASE

                loc_cMoePcs  = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ;
                    ALLTRIM(cursor_4c_TmpPro.MoePcs), ALLTRIM(THIS.this_cMoeCusto))
                loc_nFCustos = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoePcs), ;
                    THIS.this_nFator, cursor_4c_TmpPro.fCustos)
                loc_nCustoFs = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoePcs), ;
                    THIS.this_nCustoFCalc, loc_nCustoFOriginal)

                INSERT INTO cursor_4c_Produtos ;
                    (lMarca, CPros, DPros, ValAnt, ValAtu, fCustos, MoePcs, CustoFs, Manual) ;
                    VALUES (1, cursor_4c_TmpPro.CPros, cursor_4c_TmpPro.DPros, ;
                        cursor_4c_TmpPro.PVens, loc_nValAtu, loc_nFCustos, ;
                        loc_cMoePcs, loc_nCustoFs, 0)

                SELECT cursor_4c_TmpPro
            ENDSCAN

            SELECT cursor_4c_Produtos
            SET ORDER TO CPros
            GO TOP

            THIS.this_lProcessado = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpProSQL")
                USE IN cursor_4c_TmpProSQL
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.ProcessarReajuste")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarPrecos - Grava alteracoes no SQL Server (com transacao)
    * par_lImpEtiq: .T. para marcar impressao de etiquetas
    *==========================================================================
    PROCEDURE AtualizarPrecos(par_lImpEtiq)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_llOk, loc_lTransacaoAtiva
        LOCAL loc_lcCPros, loc_lcHora, loc_lcOrigem, loc_lcIdChaves, loc_lnResult
        LOCAL loc_nPVens, loc_nPCuss, loc_nCustoFsDB, loc_nCotId, loc_nCotVd, loc_nPven
        LOCAL loc_cEffMoeCs, loc_cEffMoeCusFs, loc_cEffMoedas, loc_cEffCFtios, loc_cEffMoeVs
        LOCAL loc_cSetClauses, loc_loBarra

        loc_lSucesso       = .F.
        loc_llOk           = .T.
        loc_lTransacaoAtiva = .F.

        TRY
            *-- Filtrar apenas os produtos marcados no grid
            IF USED("cursor_4c_Selecionados")
                USE IN cursor_4c_Selecionados
            ENDIF
            SELECT * FROM cursor_4c_Produtos WHERE lMarca = 1 ORDER BY CPros ;
                INTO CURSOR cursor_4c_Selecionados READWRITE NOFILTER

            SELECT cursor_4c_Selecionados
            GO TOP
            IF EOF("cursor_4c_Selecionados")
                MsgAviso("Nenhum Produto Selecionado !!!", ;
                    "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                USE IN cursor_4c_Selecionados
                loc_lSucesso = .F.
            ENDIF

            *-- Iniciar transacao
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") < 1
                MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o.", ;
                    "Erro SigPrAprBO.AtualizarPrecos")
                USE IN cursor_4c_Selecionados
                loc_lSucesso = .F.
            ENDIF
            loc_lTransacaoAtiva = .T.

            loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                "Atualizando os Pre" + CHR(231) + "os...", RECCOUNT("cursor_4c_Selecionados"))
            loc_loBarra.Show

            SELECT cursor_4c_Selecionados
            GO TOP
            SCAN
                loc_loBarra.Update(.T., "Produto: " + ALLTRIM(cursor_4c_Selecionados.CPros))
                loc_lcCPros = ALLTRIM(cursor_4c_Selecionados.CPros)

                *-- Produto deve existir no buffer de trabalho
                IF !SEEK(loc_lcCPros, "cursor_4c_TmpPro", "CPros")
                    SELECT cursor_4c_Selecionados
                    LOOP
                ENDIF

                SELECT cursor_4c_TmpPro

                loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                loc_lcOrigem   = LEFT(TTOC(DATETIME()) + " SIGALTPC", 30)
                loc_lcIdChaves = LEFT(fUniqueIds(), 20)

                *-- Arquivar preco atual em SigCdPrc (historico)
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
                    EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
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
                    MsgErro("Falha ao arquivar hist" + CHR(243) + "rico em SigCdPrc: " + loc_lcCPros, ;
                        "Erro SigPrAprBO.AtualizarPrecos")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAtiva = .F.
                    loc_llOk = .F.
                ENDIF

                IF loc_llOk
                    *-- Calcular novo preco conforme tipo
                    loc_nPVens    = cursor_4c_TmpPro.PVens
                    loc_nPCuss    = cursor_4c_TmpPro.PCuss
                    loc_nCustoFsDB = cursor_4c_TmpPro.CustoFs

                    DO CASE
                    CASE THIS.this_nTipo = 1
                        loc_nPVens = cursor_4c_TmpPro.PVens + ;
                            ((cursor_4c_TmpPro.PVens * THIS.this_nVariacao) / 100)
                        IF THIS.this_nIncCusts = 1
                            loc_nPCuss    = cursor_4c_TmpPro.PCuss + ;
                                ((cursor_4c_TmpPro.PCuss * THIS.this_nVariacao) / 100)
                            loc_nCustoFsDB = cursor_4c_TmpPro.CustoFs + ;
                                ((cursor_4c_TmpPro.CustoFs * THIS.this_nVariacao) / 100)
                        ENDIF

                    CASE THIS.this_nTipo = 2
                        loc_nPVens    = THIS.CalcPreco(THIS.this_nMarkUp2)
                        loc_nCustoFsDB = cursor_4c_Selecionados.CustoFs

                    CASE THIS.this_nTipo = 3
                        loc_nCotId = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moedas), DATETIME(), gnConnHandle)
                        loc_nCotVd = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moevs),  DATETIME(), gnConnHandle)
                        loc_nPven  = cursor_4c_TmpPro.Pvideals * loc_nCotId / ;
                            IIF(loc_nCotVd=0, 1, loc_nCotVd)
                        loc_nPVens = loc_nPven / ;
                            IIF(cursor_4c_TmpPro.Encargos<>0, cursor_4c_TmpPro.Encargos, 1)
                    ENDCASE

                    *-- Preco manual sobrescreve calculo
                    IF cursor_4c_Selecionados.Manual = 1
                        loc_nPVens = cursor_4c_Selecionados.ValAtu
                    ENDIF

                    *-- Moedas efetivas (override do form ou valor do produto)
                    loc_cEffMoeCs    = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCs)), ;
                        ALLTRIM(cursor_4c_TmpPro.MoeCs),    ALLTRIM(THIS.this_cMoeCs))
                    loc_cEffMoeCusFs = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusFs)), ;
                        ALLTRIM(cursor_4c_TmpPro.MoeCusFs), ALLTRIM(THIS.this_cMoeCusFs))
                    loc_cEffMoedas   = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ;
                        ALLTRIM(cursor_4c_TmpPro.Moedas),   ALLTRIM(THIS.this_cMoedas))
                    loc_cEffCFtios   = IIF(EMPTY(ALLTRIM(THIS.this_cCFtios)), ;
                        ALLTRIM(cursor_4c_TmpPro.CFtios),   ALLTRIM(THIS.this_cCFtios))
                    loc_cEffMoeVs    = IIF(EMPTY(ALLTRIM(THIS.this_cMoeVs)), ;
                        ALLTRIM(cursor_4c_TmpPro.MoeVs),    ALLTRIM(THIS.this_cMoeVs))

                    *-- Calcular MarkupA com valores efetivos
                    THIS.CalcMarkpa(loc_cEffMoeCusFs, loc_cEffMoeVs, loc_nPVens, loc_nCustoFsDB)

                    *-- Montar UPDATE SigCdPro
                    loc_cSetClauses = ;
                        "DataAlts = GETDATE(), " + ;
                        "HoraAlts = " + EscaparSQL(loc_lcHora) + ", " + ;
                        "UsuaAlts = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                        "ImpEtiqs = " + IIF(par_lImpEtiq, "1", "0") + ", " + ;
                        "MarkupA  = " + FormatarNumeroSQL(THIS.this_nMarkupA) + ", " + ;
                        "MoeCs    = " + EscaparSQL(LEFT(loc_cEffMoeCs,    3)) + ", " + ;
                        "MoeCusFs = " + EscaparSQL(LEFT(loc_cEffMoeCusFs, 3)) + ", " + ;
                        "Moedas   = " + EscaparSQL(LEFT(loc_cEffMoedas,   3)) + ", " + ;
                        "CFtios   = " + EscaparSQL(LEFT(loc_cEffCFtios,   2)) + ", " + ;
                        "MoeVs    = " + EscaparSQL(LEFT(loc_cEffMoeVs,    3)) + ", " + ;
                        "PVens    = " + FormatarNumeroSQL(loc_nPVens)

                    IF THIS.this_nTipo = 1 AND THIS.this_nIncCusts = 1
                        loc_cSetClauses = loc_cSetClauses + ;
                            ", PCuss   = " + FormatarNumeroSQL(loc_nPCuss) + ;
                            ", CustoFs = " + FormatarNumeroSQL(loc_nCustoFsDB)
                    ENDIF

                    IF THIS.this_nTipo = 2
                        loc_cSetClauses = loc_cSetClauses + ;
                            ", Margems  = " + FormatarNumeroSQL(THIS.this_nMarkUp2) + ;
                            ", PVIdeals = " + FormatarNumeroSQL(loc_nPVens) + ;
                            ", fCustos  = " + FormatarNumeroSQL(cursor_4c_Selecionados.fCustos) + ;
                            ", MoePcs   = " + EscaparSQL(LEFT(ALLTRIM(cursor_4c_Selecionados.MoePcs), 3)) + ;
                            ", CustoFs  = " + FormatarNumeroSQL(cursor_4c_Selecionados.CustoFs)
                    ENDIF

                    loc_cSQL    = "UPDATE SigCdPro SET " + loc_cSetClauses + ;
                                  " WHERE CPros = " + EscaparSQL(loc_lcCPros)
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_lnResult < 1
                        MsgErro("Falha ao atualizar SigCdPro: " + loc_lcCPros, ;
                            "Erro SigPrAprBO.AtualizarPrecos")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAtiva = .F.
                        loc_llOk = .F.
                    ENDIF
                ENDIF

                *-- Subgrupo por faixa de preco
                IF loc_llOk AND THIS.this_nChkSubGrs = 1
                    IF USED("cursor_4c_SigCdPsg")
                        USE IN cursor_4c_SigCdPsg
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigCdPsg WHERE CGrus = " + ;
                        EscaparSQL(ALLTRIM(cursor_4c_TmpPro.cGrus)) + ;
                        " ORDER BY nFaixaFins"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPsg") > 0
                        LOCAL loc_lnPVens
                        loc_lnPVens = IIF(loc_nPVens = 0, cursor_4c_TmpPro.pvideals, loc_nPVens)
                        SELECT cursor_4c_SigCdPsg
                        LOCATE FOR nFaixaFins >= loc_lnPVens
                        IF !EOF("cursor_4c_SigCdPsg")
                            SQLEXEC(gnConnHandle, ;
                                "UPDATE SigCdPro SET sGrus = " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_SigCdPsg.Codigos)) + ;
                                " WHERE cpros = " + EscaparSQL(loc_lcCPros))
                        ENDIF
                        USE IN cursor_4c_SigCdPsg
                    ENDIF
                ENDIF

                *-- Arquivar composicao em SigPrCp2
                IF loc_llOk
                    IF USED("cursor_4c_TmpCompo")
                        USE IN cursor_4c_TmpCompo
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(loc_lcCPros)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCompo") > 0
                        SELECT cursor_4c_TmpCompo
                        GO TOP
                        SCAN
                            loc_lcIdChaves = LEFT(fUniqueIds(), 20)
                            loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                            loc_cSQL = "INSERT INTO SigPrCp2 (" + ;
                                "cidchaves, dataalts, horaalts, usuaalts, " + ;
                                "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, " + ;
                                "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, " + ;
                                "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, " + ;
                                "dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, " + ;
                                "ordts, tipos, matriz, obsofs) VALUES (" + ;
                                EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                                EscaparSQL(loc_lcHora) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cats))      + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cgrus))     + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cpros))     + ", " + ;
                                "NULL, " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.dcompos))   + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.dscgrp))    + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.etiqs))     + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.grupos))    + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.mats))      + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.moeds))     + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.obscompos)) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.ordems)    + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.pcompos)   + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.qtds)      + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.qtscons)   + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.unicompos)) + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.compos))   + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.ordcompos) + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.qtdcvs)    + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.vlrcvs)    + ", " + ;
                                "GETDATE(), " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cunips))    + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.markcvs)   + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.pesos)     + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.totas)     + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.tpalts)    + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.vlrpvs)    + ", " + ;
                                FormatarNumeroSQL(cursor_4c_TmpCompo.ordts)     + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.tipos))    + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.matriz))   + ", " + ;
                                EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.obsofs))   + ")"
                            loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_lnResult < 1
                                MsgErro("Falha ao arquivar componente em SigPrCp2: " + loc_lcCPros, ;
                                    "Erro SigPrAprBO.AtualizarPrecos")
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                loc_lTransacaoAtiva = .F.
                                loc_llOk = .F.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_TmpCompo
                        ENDSCAN
                        USE IN cursor_4c_TmpCompo
                    ENDIF
                ENDIF

                *-- Remover tabela de reticencia de precos
                IF loc_llOk
                    SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_lcCPros))
                ENDIF

                *-- Limpar promocoes anteriores se solicitado
                IF loc_llOk AND THIS.this_nLimpar = 1
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigPrPmi WHERE CPros = " + EscaparSQL(loc_lcCPros))
                    IF loc_lnResult < 1
                        MsgErro("Falha ao limpar promo" + CHR(231) + CHR(245) + "es: " + loc_lcCPros, ;
                            "Erro SigPrAprBO.AtualizarPrecos")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAtiva = .F.
                        loc_llOk = .F.
                    ENDIF
                ENDIF

                *-- Inserir promocao se informada e ainda nao existir
                IF loc_llOk AND !EMPTY(ALLTRIM(THIS.this_cPromo))
                    IF USED("cursor_4c_TmpPromI")
                        USE IN cursor_4c_TmpPromI
                    ENDIF
                    loc_cSQL = "SELECT TOP 1 cidchaves FROM SigPrPmi WHERE CPros = " + ;
                        EscaparSQL(loc_lcCPros) + ;
                        " AND Promos = " + EscaparSQL(ALLTRIM(THIS.this_cPromo))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPromI") > 0
                        SELECT cursor_4c_TmpPromI
                        GO TOP
                        IF EOF("cursor_4c_TmpPromI")
                            loc_lcIdChaves = LEFT(fUniqueIds(), 20)
                            loc_cSQL = "INSERT INTO SigPrPmi " + ;
                                "(cpros, pecas, promos, cbars, datas, cidchaves, " + ;
                                " promopro, dtalts, vendavels) VALUES (" + ;
                                EscaparSQL(loc_lcCPros) + ", '', " + ;
                                EscaparSQL(LEFT(ALLTRIM(THIS.this_cPromo), 25)) + ;
                                ", 0, GETDATE(), " + ;
                                EscaparSQL(loc_lcIdChaves) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(THIS.this_cPromo) + loc_lcCPros, 35)) + ;
                                ", GETDATE(), 0)"
                            loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_lnResult < 1
                                MsgErro("Falha ao inserir promo" + CHR(231) + CHR(227) + ;
                                    "o em SigPrPmi: " + loc_lcCPros, ;
                                    "Erro SigPrAprBO.AtualizarPrecos")
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                loc_lTransacaoAtiva = .F.
                                loc_llOk = .F.
                            ENDIF
                        ENDIF
                        USE IN cursor_4c_TmpPromI
                    ELSE
                        MsgErro("Falha ao verificar SigPrPmi: " + loc_lcCPros, ;
                            "Erro SigPrAprBO.AtualizarPrecos")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAtiva = .F.
                        loc_llOk = .F.
                    ENDIF
                ENDIF

                IF !loc_llOk
                    EXIT
                ENDIF

                SELECT cursor_4c_Selecionados
            ENDSCAN

            IF loc_llOk
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacaoAtiva = .F.
                    THIS.this_lAtualizado = .T.
                    MsgInfo("Processamento Finalizado com Sucesso !!!")
                    loc_lSucesso = .T.
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAtiva = .F.
                    MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o.", ;
                        "Erro SigPrAprBO.AtualizarPrecos")
                ENDIF
            ELSE
                IF loc_lTransacaoAtiva
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAtiva = .F.
                ENDIF
                MsgErro("Falha na atualiza" + CHR(231) + CHR(227) + ;
                    "o. Reinicie o Processo !!!", "Erro SigPrAprBO.AtualizarPrecos")
            ENDIF

            IF USED("cursor_4c_Selecionados")
                USE IN cursor_4c_Selecionados
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAtiva
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            IF USED("cursor_4c_Selecionados")
                USE IN cursor_4c_Selecionados
            ENDIF
            IF USED("cursor_4c_TmpCompo")
                USE IN cursor_4c_TmpCompo
            ENDIF
            IF USED("cursor_4c_TmpPromI")
                USE IN cursor_4c_TmpPromI
            ENDIF
            IF USED("cursor_4c_SigCdPsg")
                USE IN cursor_4c_SigCdPsg
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.AtualizarPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CalcPreco - Calcula preco ideal com base em markup e moedas
    * Requer cursor_4c_TmpPro posicionado no produto corrente
    * Retorna: preco ideal calculado; this_nCustoFCalc = custo final calculado
    *==========================================================================
    FUNCTION CalcPreco(par_nMargems)
        LOCAL loc_lnIdeal, loc_cMoeCusto, loc_nFaTCusto, loc_cMoeIdeal
        LOCAL loc_nCusto, loc_nFPeso, loc_nFeitio, loc_nCustoF
        LOCAL loc_nMoeC, loc_nMoeP, loc_nMoeV, loc_nMoeCF, loc_nMoedas, loc_nMoeFT
        LOCAL loc_oErro

        loc_lnIdeal = 0

        TRY
            SELECT cursor_4c_TmpPro

            loc_cMoeCusto = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ;
                ALLTRIM(cursor_4c_TmpPro.MoePcs), ALLTRIM(THIS.this_cMoeCusto))
            loc_nFaTCusto = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoeCusto), ;
                THIS.this_nFator, cursor_4c_TmpPro.fCustos)
            loc_cMoeIdeal = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ;
                ALLTRIM(cursor_4c_TmpPro.Moedas), ALLTRIM(THIS.this_cMoedas))
            loc_nCusto  = cursor_4c_TmpPro.PCuss
            loc_nFPeso  = cursor_4c_TmpPro.PesoMs * loc_nFaTCusto
            loc_nFeitio = cursor_4c_TmpPro.PFtios

            loc_nMoeC   = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoeCs))
            loc_nMoeP   = THIS.ObterCotacaoMoeda(loc_cMoeCusto)
            loc_nMoeV   = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoeVs))
            loc_nMoeCF  = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoeCusFs))
            loc_nMoedas = THIS.ObterCotacaoMoeda(loc_cMoeIdeal)
            loc_nMoeFT  = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MFtios))

            IF ALLTRIM(cursor_4c_TmpPro.MFtios) <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / IIF(loc_nMoeCF=0, 1, loc_nMoeCF)
            ENDIF

            IF ALLTRIM(cursor_4c_TmpPro.MoeCs) <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                loc_nCustoF = (loc_nCusto * loc_nMoeC) / IIF(loc_nMoeCF=0, 1, loc_nMoeCF)
            ELSE
                loc_nCustoF = loc_nCusto
            ENDIF

            IF THIS.this_nCalcCusts = 2
                IF loc_cMoeCusto <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFaTCusto=0, 1, ;
                        loc_nFaTCusto * loc_nMoeP / IIF(loc_nMoeCF=0, 1, loc_nMoeCF))
                ELSE
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFaTCusto=0, 1, loc_nFaTCusto)
                ENDIF
            ELSE
                IF loc_cMoeCusto <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                    loc_nCustoF = loc_nCustoF + ;
                        (loc_nFPeso * loc_nMoeP / IIF(loc_nMoeCF=0, 1, loc_nMoeCF))
                ELSE
                    loc_nCustoF = loc_nCustoF + loc_nFPeso
                ENDIF
            ENDIF

            IF ALLTRIM(cursor_4c_TmpPro.MoeCusFs) <> loc_cMoeIdeal
                loc_lnIdeal = (loc_nCustoF + loc_nFeitio) * loc_nMoeCF / ;
                    IIF(loc_nMoedas=0, 1, loc_nMoedas) * par_nMargems
            ELSE
                loc_lnIdeal = (loc_nCustoF + loc_nFeitio) * par_nMargems
            ENDIF

            THIS.this_nCustoFCalc = loc_nCustoF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.CalcPreco")
        ENDTRY

        RETURN loc_lnIdeal
    ENDFUNC

    *==========================================================================
    * CalcMarkpa - Calcula MarkupA e armazena em this_nMarkupA
    * par_cMoeCusFs: moeda efetiva do custo total
    * par_cMoeVs:    moeda efetiva do preco de venda
    * par_nPVens:    preco de venda final (apos calculos e manual override)
    * par_nCustoFs:  custo final usado como base
    *==========================================================================
    PROCEDURE CalcMarkpa(par_cMoeCusFs, par_cMoeVs, par_nPVens, par_nCustoFs)
        LOCAL loc_nMoeCF, loc_nMoeV, loc_oErro

        THIS.this_nMarkupA = 0

        TRY
            loc_nMoeCF = THIS.ObterCotacaoMoeda(par_cMoeCusFs)
            loc_nMoeV  = THIS.ObterCotacaoMoeda(par_cMoeVs)
            THIS.this_nMarkupA = IIF(par_nCustoFs = 0, 0, ;
                ROUND((par_nPVens * loc_nMoeV) / ;
                (par_nCustoFs * IIF(loc_nMoeCF=0, 1, loc_nMoeCF)), 3))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.CalcMarkpa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CalcIdeal - Calcula preco ideal com base nas moedas do produto corrente
    * Requer cursor_4c_TmpPro posicionado no produto corrente
    * Retorna: preco ideal
    *==========================================================================
    FUNCTION CalcIdeal()
        LOCAL loc_lnIdeal, loc_cMoeIdeal, loc_nFator, loc_nFeitio, loc_nCustoF
        LOCAL loc_nMoeCF, loc_nMoedas, loc_oErro

        loc_lnIdeal = 0

        TRY
            SELECT cursor_4c_TmpPro

            loc_cMoeIdeal = ALLTRIM(cursor_4c_TmpPro.Moedas)
            loc_nFator    = cursor_4c_TmpPro.Margems
            loc_nFeitio   = cursor_4c_TmpPro.PFtios
            loc_nCustoF   = cursor_4c_TmpPro.CustoFs

            loc_nMoeCF  = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoeCusFs))
            loc_nMoedas = THIS.ObterCotacaoMoeda(loc_cMoeIdeal)

            IF ALLTRIM(cursor_4c_TmpPro.MoeCusFs) <> loc_cMoeIdeal
                loc_lnIdeal = (loc_nCustoF + loc_nFeitio) * loc_nMoeCF / ;
                    IIF(loc_nMoedas=0, 1, loc_nMoedas) * loc_nFator
            ELSE
                loc_lnIdeal = (loc_nCustoF + loc_nFeitio) * loc_nFator
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.CalcIdeal")
        ENDTRY

        RETURN loc_lnIdeal
    ENDFUNC

    *==========================================================================
    * CalcLista - Calcula preco de lista por progressao aritmetica
    * par_nNumMax: referencia maxima para o calculo
    * Retorna: preco de lista calculado
    *==========================================================================
    FUNCTION CalcLista(par_nNumMax)
        LOCAL loc_nPasso, loc_nCodPre, loc_nFator

        loc_nPasso  = 3
        loc_nCodPre = 10
        loc_nFator  = 2

        DO WHILE loc_nCodPre < par_nNumMax
            loc_nCodPre = loc_nCodPre + IIF(loc_nPasso=0, 4, 5) * loc_nFator
            loc_nPasso  = MOD((loc_nPasso + 1), 5)
        ENDDO

        RETURN loc_nCodPre
    ENDFUNC

    *==========================================================================
    * CalcMargem - Calcula margem de lucro para um preco informado
    * Requer cursor_4c_TmpPro posicionado no produto corrente
    * par_nPreco: preco de venda para calculo da margem
    * Retorna: margem calculada (fator multiplicador)
    *==========================================================================
    FUNCTION CalcMargem(par_nPreco)
        LOCAL loc_nMargem, loc_cMoeIdeal, loc_nCusto, loc_nFPeso, loc_nFeitio
        LOCAL loc_nMoeC, loc_nMoeP, loc_nMoeV, loc_nMoeCF, loc_nMoeFT, loc_nMoedas
        LOCAL loc_nCustoF, loc_nFaTCusto, loc_oErro

        loc_nMargem = 0

        TRY
            SELECT cursor_4c_TmpPro

            loc_cMoeIdeal  = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ;
                ALLTRIM(cursor_4c_TmpPro.Moedas), ALLTRIM(THIS.this_cMoedas))
            loc_nFaTCusto  = cursor_4c_TmpPro.fCustos
            loc_nCusto     = cursor_4c_TmpPro.PCuss
            loc_nFPeso     = cursor_4c_TmpPro.PesoMs * loc_nFaTCusto
            loc_nFeitio    = cursor_4c_TmpPro.PFtios

            loc_nMoeC   = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoeCs))
            loc_nMoeP   = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoePcs))
            loc_nMoeV   = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoeVs))
            loc_nMoeCF  = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MoeCusFs))
            loc_nMoedas = THIS.ObterCotacaoMoeda(loc_cMoeIdeal)
            loc_nMoeFT  = THIS.ObterCotacaoMoeda(ALLTRIM(cursor_4c_TmpPro.MFtios))

            IF ALLTRIM(cursor_4c_TmpPro.MFtios) <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / IIF(loc_nMoeCF=0, 1, loc_nMoeCF)
            ENDIF

            IF ALLTRIM(cursor_4c_TmpPro.MoeCs) <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                loc_nCustoF = (loc_nCusto * loc_nMoeC) / IIF(loc_nMoeCF=0, 1, loc_nMoeCF)
            ELSE
                loc_nCustoF = loc_nCusto
            ENDIF

            IF THIS.this_nCalcCusts = 2
                IF ALLTRIM(cursor_4c_TmpPro.MoePcs) <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFaTCusto=0, 1, ;
                        loc_nFaTCusto * loc_nMoeP / IIF(loc_nMoeCF=0, 1, loc_nMoeCF))
                ELSE
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFaTCusto=0, 1, loc_nFaTCusto)
                ENDIF
            ELSE
                IF ALLTRIM(cursor_4c_TmpPro.MoePcs) <> ALLTRIM(cursor_4c_TmpPro.MoeCusFs)
                    loc_nCustoF = loc_nCustoF + ;
                        (loc_nFPeso * loc_nMoeP / IIF(loc_nMoeCF=0, 1, loc_nMoeCF))
                ELSE
                    loc_nCustoF = loc_nCustoF + loc_nFPeso
                ENDIF
            ENDIF

            IF loc_nCustoF = 0
                loc_nMargem = 0
            ELSE
                IF ALLTRIM(cursor_4c_TmpPro.MoeCusFs) <> loc_cMoeIdeal
                    loc_nMargem = par_nPreco / ;
                        ((loc_nCustoF + loc_nFeitio) * loc_nMoeCF / IIF(loc_nMoedas=0, 1, loc_nMoedas))
                ELSE
                    loc_nMargem = par_nPreco / (loc_nCustoF + loc_nFeitio)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.CalcMargem")
        ENDTRY

        RETURN loc_nMargem
    ENDFUNC

    *==========================================================================
    * ObterCotacaoMoeda - Retorna cotacao de uma moeda resolvendo redirects
    * par_cMoeda: codigo da moeda (CMoes em SigCdMoe)
    * Retorna: cotacao em reais (1 se moeda vazia ou nao encontrada)
    *==========================================================================
    PROTECTED FUNCTION ObterCotacaoMoeda(par_cMoeda)
        LOCAL loc_nCotacao, loc_cMoeReal, loc_nQtdeQs, loc_oErro

        IF EMPTY(ALLTRIM(par_cMoeda))
            RETURN 1
        ENDIF

        loc_nCotacao = 1

        TRY
            IF USED("cursor_4c_MoeTemp")
                USE IN cursor_4c_MoeTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 MoeQs, QtdeQs FROM SigCdMoe WHERE CMoes = " + ;
                EscaparSQL(ALLTRIM(par_cMoeda)), "cursor_4c_MoeTemp") > 0

                SELECT cursor_4c_MoeTemp
                GO TOP
                IF !EOF("cursor_4c_MoeTemp")
                    IF !EMPTY(ALLTRIM(cursor_4c_MoeTemp.MoeQs))
                        loc_cMoeReal = ALLTRIM(cursor_4c_MoeTemp.MoeQs)
                        loc_nQtdeQs  = IIF(cursor_4c_MoeTemp.QtdeQs=0, 1, cursor_4c_MoeTemp.QtdeQs)
                    ELSE
                        loc_cMoeReal = ALLTRIM(par_cMoeda)
                        loc_nQtdeQs  = 1
                    ENDIF
                    loc_nCotacao = fBuscarCotacao(loc_cMoeReal, DATETIME(), gnConnHandle) * loc_nQtdeQs
                ENDIF
                USE IN cursor_4c_MoeTemp
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_MoeTemp")
                USE IN cursor_4c_MoeTemp
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrAprBO.ObterCotacaoMoeda")
        ENDTRY

        RETURN loc_nCotacao
    ENDFUNC

ENDDEFINE
