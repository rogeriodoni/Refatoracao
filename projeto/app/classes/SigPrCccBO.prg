*==============================================================================
* SigPrCccBO.prg - Business Object para Recalculo de Saldos
* Herda de BusinessBase
* Tabela principal: SigOpClU (Ultima Compra por Cliente/Produto)
* Fases 1-2/8: Propriedades, Init e metodos de recalculo completos
*==============================================================================

DEFINE CLASS SigPrCccBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *--------------------------------------------------------------------------
    * Secao Conta Corrente (OpConta) - recalcula SigMvCcr
    *--------------------------------------------------------------------------
    this_cEmpConta    = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoConta  = ""    && txtGrupos   C(10) - grupo de conta
    this_cConta       = ""    && txtContas   C(10) - conta corrente
    this_cMoedaConta  = ""    && txtMoedas   C(3)  - moeda
    this_dDataConta   = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Estoque (OpEstoque) - recalcula SigMvHst
    *--------------------------------------------------------------------------
    this_cEmpEst      = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoEst    = ""    && txtGrupos   C(10) - grupo do deposito
    this_cEstoque     = ""    && Get_Estoque C(10) - codigo do deposito/estoque
    this_cProdEst     = ""    && Get_Produto C(14) - codigo do produto
    this_cDescProdEst = ""    && Get_Descs   C(40) - descricao do produto
    this_dDataEst     = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Custo de Produto (OpCusto) - recalcula custo em SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCusto      = ""  && Get_Empresa C(3)  - empresa filtro
    this_cProdCusto     = ""  && Get_Produto C(14) - codigo do produto
    this_cDescProdCusto = ""  && Get_Descs   C(40) - descricao do produto
    this_dDataCusto     = {}  && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Ultima Compra (OpCompra) - atualiza SigOpClU, SigCdCli, SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCompra      = "" && Get_Empresa C(3)  - empresa filtro
    this_cProdCompra     = "" && Get_Produto C(14) - codigo do produto
    this_cDescProdCompra = "" && Get_Descs   C(40) - descricao do produto
    this_dDataCompra     = {} && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Parametros do sistema (carregados de SigCdPam em InicializarDados)
    *--------------------------------------------------------------------------
    this_cMoeCentral  = ""    && MoeCentral  C(3)  - moeda central para cotacao
    this_cGrupoRecs   = ""    && GrupoRecs   C(10) - grupo recebimentos C.C.
    this_cGrupoPags   = ""    && GrupoPags   C(10) - grupo pagamentos C.C.
    this_cContaRecs   = ""    && ContaRecs   C(10) - conta recebimentos C.C.
    this_cContaPags   = ""    && ContaPags   C(10) - conta pagamentos C.C.

    *--------------------------------------------------------------------------
    * Estado do processamento
    *--------------------------------------------------------------------------
    this_nRegistros   = 0     && Get_Registro N    - contador de registros processados
    this_lProcessando = .F.   && .T. enquanto Processa.Click estiver rodando

    *--------------------------------------------------------------------------
    * Propriedades de linha - SigOpClU (CRUD)
    *--------------------------------------------------------------------------
    this_cChaves     = ""    && cidchaves  C(20) PK
    this_cCpros      = ""    && cpros      C(14)
    this_dDatas      = {}    && datas      datetime
    this_cDopes      = ""    && dopes      C(20)
    this_cEmpDopNums = ""    && empdopnums C(29)
    this_cEmps       = ""    && emps       C(3)
    this_cIclis      = ""    && iclis      C(10)
    this_cMoedas     = ""    && moedas     C(3)
    this_nNumes      = 0     && numes      N(6,0)
    this_nValors     = 0     && valors     N(13,2)
    this_nQtds       = 0     && qtds       N(12,0)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigOpClU"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarDados - carrega parametros de SigCdPam no BO
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags, MoeCentral " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cGrupoRecs  = NVL(GrupoRecs,  "")
                    THIS.this_cGrupoPags  = NVL(GrupoPags,  "")
                    THIS.this_cContaRecs  = NVL(ContaRecs,  "")
                    THIS.this_cContaPags  = NVL(ContaPags,  "")
                    THIS.this_cMoeCentral = NVL(MoeCentral, "")
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega colunas de SigOpClU do cursor informado
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaves     = NVL(cidchaves,  SPACE(20))
            THIS.this_cCpros      = NVL(cpros,      SPACE(14))
            THIS.this_dDatas      = NVL(datas,      {})
            THIS.this_cDopes      = NVL(dopes,      SPACE(20))
            THIS.this_cEmpDopNums = NVL(empdopnums, SPACE(29))
            THIS.this_cEmps       = NVL(emps,       SPACE(3))
            THIS.this_cIclis      = NVL(iclis,      SPACE(10))
            THIS.this_cMoedas     = NVL(moedas,     SPACE(3))
            THIS.this_nNumes      = NVL(numes,      0)
            THIS.this_nValors     = NVL(valors,     0)
            THIS.this_nQtds       = NVL(qtds,       0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir - insere um registro em SigOpClU
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            THIS.this_cChaves = SYS(2015) + SYS(2015)

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                " emps, iclis, moedas, numes, valors, qtds) " + ;
                "VALUES (" + ;
                EscaparSQL(LEFT(THIS.this_cChaves, 20))     + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 0)       + ")"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - atualiza registro em SigOpClU pela chave cidchaves
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpClU SET " + ;
                "cpros      = " + EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                "dopes      = " + EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "iclis      = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                "moedas     = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                "numes      = " + FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "qtds       = " + FormatarNumeroSQL(THIS.this_nQtds, 0)       + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna cidchaves do registro atual (para auditoria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *==========================================================================
    * RecalcularSaldosConta - recalcula saldos em SigMvCcr
    * Processa movimentos em ordem cronologica e atualiza saldos acumulados
    *==========================================================================
    PROCEDURE RecalcularSaldosConta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSaldo, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpConta)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoConta)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cMoedaConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "moedas = " + EscaparSQL(THIS.this_cMoedaConta)
            ENDIF
            IF !EMPTY(THIS.this_dDataConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataConta)
            ENDIF

            loc_cSQL = "SELECT emps, grupos, contas, moedas, " + ;
                       "       datas, numes, opers, valors " + ;
                       "FROM SigMvCcr" + m.loc_cWhere + ;
                       " ORDER BY emps, grupos, contas, moedas, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CcrRec") > 0
                IF USED("cursor_4c_CcrRec") AND RECCOUNT("cursor_4c_CcrRec") > 0
                    loc_nSaldo  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_CcrRec
                    SCAN
                        loc_cKey = ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(contas) + ALLTRIM(moedas)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSaldo  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSaldo = loc_nSaldo + valors
                        ELSE
                            loc_nSaldo = loc_nSaldo - valors
                        ENDIF
                        loc_cSQL = "UPDATE SigMvCcr SET saldos = " + ;
                                   FormatarNumeroSQL(m.loc_nSaldo, 2) + ;
                                   " WHERE emps = "   + EscaparSQL(emps)   + ;
                                   "   AND grupos = " + EscaparSQL(grupos)  + ;
                                   "   AND contas = " + EscaparSQL(contas)  + ;
                                   "   AND moedas = " + EscaparSQL(moedas)  + ;
                                   "   AND datas = "  + FormatarDataSQL(datas) + ;
                                   "   AND numes = "  + FormatarNumeroSQL(numes, 0)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CcrRec")
                    USE IN cursor_4c_CcrRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvCcr.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosConta")
            IF USED("cursor_4c_CcrRec")
                USE IN cursor_4c_CcrRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosEstoque - recalcula sqtds em SigMvHst
    * Processa movimentos em ordem e atualiza saldo acumulado de quantidade
    *==========================================================================
    PROCEDURE RecalcularSaldosEstoque()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSqtds, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpEst)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoEst)
            ENDIF
            IF !EMPTY(THIS.this_cProdEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdEst)
            ENDIF
            IF !EMPTY(THIS.this_dDataEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataEst)
            ENDIF

            loc_cSQL = "SELECT cpros, emps, grupos, estos, " + ;
                       "       datas, numes, opers, qtds, sqtds " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " ORDER BY cpros, emps, grupos, estos, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_HstRec") > 0
                IF USED("cursor_4c_HstRec") AND RECCOUNT("cursor_4c_HstRec") > 0
                    loc_nSqtds  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_HstRec
                    SCAN
                        loc_cKey = ALLTRIM(cpros) + ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(estos)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSqtds  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSqtds = loc_nSqtds + qtds
                        ELSE
                            loc_nSqtds = loc_nSqtds - qtds
                        ENDIF
                        loc_cSQL = "UPDATE SigMvHst SET sqtds = " + ;
                                   FormatarNumeroSQL(m.loc_nSqtds, 3) + ;
                                   " WHERE cpros = "   + EscaparSQL(cpros)   + ;
                                   "   AND emps = "    + EscaparSQL(emps)     + ;
                                   "   AND grupos = "  + EscaparSQL(grupos)   + ;
                                   "   AND estos = "   + EscaparSQL(estos)    + ;
                                   "   AND datas = "   + FormatarDataSQL(datas) + ;
                                   "   AND numes = "   + FormatarNumeroSQL(numes, 0)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_HstRec")
                    USE IN cursor_4c_HstRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvHst.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosEstoque")
            IF USED("cursor_4c_HstRec")
                USE IN cursor_4c_HstRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCusto - recalcula custofs em SigCdPro
    * Media ponderada de custo a partir dos movimentos de entrada em SigMvHst
    *==========================================================================
    PROCEDURE RecalcularSaldosCusto()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCusto)
            ENDIF
            IF !EMPTY(THIS.this_cProdCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCusto)
            ENDIF
            IF !EMPTY(THIS.this_dDataCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCusto)
            ENDIF

            loc_cSQL = "SELECT cpros, " + ;
                       "       SUM(qtds * units) / NULLIF(SUM(qtds), 0) AS custofsMedio " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CustoRec") > 0
                IF USED("cursor_4c_CustoRec") AND RECCOUNT("cursor_4c_CustoRec") > 0
                    SELECT cursor_4c_CustoRec
                    SCAN
                        IF !ISNULL(custofsMedio)
                            loc_cSQL = "UPDATE SigCdPro SET custofs = " + ;
                                       FormatarNumeroSQL(custofsMedio, 3) + ;
                                       " WHERE cpros = " + EscaparSQL(cpros)
                            SQLEXEC(gnConnHandle, m.loc_cSQL)
                            loc_nRecs = loc_nRecs + 1
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CustoRec")
                    USE IN cursor_4c_CustoRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao calcular custo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCusto")
            IF USED("cursor_4c_CustoRec")
                USE IN cursor_4c_CustoRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCompra - atualiza SigOpClU com ultima compra por produto
    * Localiza a entrada mais recente em SigMvHst e atualiza SigOpClU
    *==========================================================================
    PROCEDURE RecalcularSaldosCompra()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs
        LOCAL loc_cChkSQL, loc_cUpSQL, loc_cPros, loc_cEmps

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCompra)
            ENDIF
            IF !EMPTY(THIS.this_cProdCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCompra)
            ENDIF
            IF !EMPTY(THIS.this_dDataCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCompra)
            ENDIF

            loc_cSQL = "SELECT cpros, emps, " + ;
                       "       MAX(datas) AS ultimaData, " + ;
                       "       MAX(numes) AS ultimoNume " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros, emps"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraGrp") > 0
                IF USED("cursor_4c_CompraGrp") AND RECCOUNT("cursor_4c_CompraGrp") > 0
                    SELECT cursor_4c_CompraGrp
                    SCAN
                        loc_cPros = ALLTRIM(cpros)
                        loc_cEmps = ALLTRIM(emps)

                        *-- Busca detalhe do movimento mais recente
                        loc_cSQL = "SELECT TOP 1 cpros, emps, datas, numes, " + ;
                                   "            valors, qtds, moedas, dopes, empdopnums " + ;
                                   "FROM SigMvHst " + ;
                                   "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                   "  AND emps = "  + EscaparSQL(m.loc_cEmps) + ;
                                   " ORDER BY datas DESC, numes DESC"

                        IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraUlt") > 0
                            IF USED("cursor_4c_CompraUlt") AND RECCOUNT("cursor_4c_CompraUlt") > 0
                                SELECT cursor_4c_CompraUlt

                                *-- Verificar se ja existe registro em SigOpClU
                                loc_cChkSQL = "SELECT cidchaves FROM SigOpClU " + ;
                                              "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                              "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                IF SQLEXEC(gnConnHandle, m.loc_cChkSQL, "cursor_4c_CompraChk") > 0
                                    IF USED("cursor_4c_CompraChk") AND RECCOUNT("cursor_4c_CompraChk") > 0
                                        *-- UPDATE
                                        SELECT cursor_4c_CompraUlt
                                        loc_cUpSQL = "UPDATE SigOpClU SET " + ;
                                            "datas      = " + FormatarDataSQL(datas)          + ", " + ;
                                            "numes      = " + FormatarNumeroSQL(numes, 0)     + ", " + ;
                                            "valors     = " + FormatarNumeroSQL(valors, 2)    + ", " + ;
                                            "qtds       = " + FormatarNumeroSQL(qtds, 0)      + ", " + ;
                                            "moedas     = " + EscaparSQL(LEFT(moedas, 3))     + ", " + ;
                                            "dopes      = " + EscaparSQL(LEFT(dopes, 20))     + ", " + ;
                                            "empdopnums = " + EscaparSQL(LEFT(empdopnums, 29))+ " " + ;
                                            "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                            "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                        SQLEXEC(gnConnHandle, m.loc_cUpSQL)
                                    ELSE
                                        *-- INSERT novo
                                        SELECT cursor_4c_CompraUlt
                                        THIS.this_cCpros      = LEFT(cpros, 14)
                                        THIS.this_cEmps       = LEFT(emps, 3)
                                        THIS.this_dDatas      = datas
                                        THIS.this_nNumes      = numes
                                        THIS.this_nValors     = valors
                                        THIS.this_nQtds       = qtds
                                        THIS.this_cMoedas     = LEFT(moedas, 3)
                                        THIS.this_cDopes      = LEFT(dopes, 20)
                                        THIS.this_cEmpDopNums = LEFT(empdopnums, 29)
                                        THIS.this_cIclis      = SPACE(10)
                                        THIS.Inserir()
                                    ENDIF
                                    IF USED("cursor_4c_CompraChk")
                                        USE IN cursor_4c_CompraChk
                                    ENDIF
                                    loc_nRecs = loc_nRecs + 1
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_CompraUlt")
                                USE IN cursor_4c_CompraUlt
                            ENDIF
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CompraGrp")
                    USE IN cursor_4c_CompraGrp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar movimentos de compra.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCompra")
            IF USED("cursor_4c_CompraGrp")
                USE IN cursor_4c_CompraGrp
            ENDIF
            IF USED("cursor_4c_CompraUlt")
                USE IN cursor_4c_CompraUlt
            ENDIF
            IF USED("cursor_4c_CompraChk")
                USE IN cursor_4c_CompraChk
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
