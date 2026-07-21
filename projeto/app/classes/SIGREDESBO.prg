*==============================================================================
* SIGREDESBO.PRG
* Business Object para Relatorio de Cotas de Desconto (SIGREDES)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvCab, SigMvItn, SigMvItd, sigcddes
* Relatorios FRX: SigReDes.frx (Detalhado), SigReDe1.frx (Resumido)
*
* Filtros:
*   - Empresa    (codigo + descricao)
*   - Periodo    (data inicial / data final)
*   - Grupo      (codigo + descricao - campo Grupos de SigCdCli)
*   - Vendedor   (codigo + descricao - campo Vends/IClis de SigMvCab/SigCdCli)
*   - Categoria  (codigo + descricao - campo colecoes de SigcdPro / SigCdCol)
*   - Colecao    (codigo + descricao - campo sgrus de SigcdPro / SigCdPsg)
*   - Produto    (codigo + descricao - campo CPros de SigCdPro)
*   - Com desconto (0=todos, 1=somente com desconto)
*   - Lancamento   (0=todos, 1=somente lancamentos novos)
*   - Tipo visao   (1=Detalhado, 2=Resumido)
*==============================================================================

DEFINE CLASS SIGREDESBO AS RelatorioBase

    *-- Filtro: empresa
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: grupo (campo Grupos de SigCdCli)
    this_cCGru          = ""
    this_cDGru          = ""

    *-- Filtro: vendedor (campo Vends de SigMvCab / IClis de SigCdCli)
    this_cVend          = ""
    this_cDVend         = ""

    *-- Filtro: categoria (campo colecoes de SigcdPro; lookup SigCdCol: colecoes/descs)
    this_cCate          = ""
    this_cCateD         = ""

    *-- Filtro: colecao (campo sgrus de SigcdPro; lookup SigCdPsg: codigos/descricaos)
    this_cCole          = ""
    this_cColeD         = ""

    *-- Filtro: produto (campo CPros de SigCdPro; lookup SigCdPro: CPros/DPros)
    this_cProd          = ""
    this_cProdD         = ""

    *-- Tipo de visao: 1=Detalhado (SigReDes.frx), 2=Resumido (SigReDe1.frx)
    this_nOpcao         = 1

    *-- Filtro com desconto: 0=todos, 1=somente itens com desconto (chaitd preenchido)
    this_nDesc          = 0

    *-- Filtro lancamento: 0=todos, 1=somente lancamentos (dtincs do produto < 61 dias)
    this_nLanc          = 0

    *-- Cursores gerenciados pelo BO
    this_cCursorDados      = "csRelatorio"
    this_cCursorRelatorio  = "csCabecalho"
    this_cCursorOpFp       = "cursor_4c_OpFp"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de Cotas de Desconto
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Inicializa filtros com valores padrao e carrega
    * formas de pagamento disponiveis em cursor_4c_OpFp (ReadWrite para que o
    * grid do form permita marcar/desmarcar via CheckBox).
    * Equivalente ao bloco de Init() do form legado SIGREDES.
    * Chamado pelo form em InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_dPrimeiro, loc_dUltimo
        loc_lSucesso = .F.
        TRY
            *-- Primeiro e ultimo dia do mes corrente
            loc_dPrimeiro = DATE() - DAY(DATE()) + 1
            loc_dUltimo   = GOMONTH(loc_dPrimeiro, 1) - 1

            THIS.this_dDtInicial  = loc_dPrimeiro
            THIS.this_dDtFinal    = loc_dUltimo
            THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            THIS.this_cDesEmpresa = ""

            *-- Buscar descricao da empresa para popular UI sem abrir lookup modal
            IF !EMPTY(THIS.this_cEmpresa)
                LOCAL loc_cSqlEmp, loc_nResEmp
                loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = " + ;
                              EscaparSQL(THIS.this_cEmpresa)
                loc_nResEmp = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_EmpDesIni")
                IF loc_nResEmp >= 1
                    SELECT cursor_4c_EmpDesIni
                    IF !EOF()
                        THIS.this_cDesEmpresa = ALLTRIM(Razas)
                    ENDIF
                    USE IN cursor_4c_EmpDesIni
                ENDIF
            ENDIF

            THIS.this_cVend       = ""
            THIS.this_cDVend      = ""
            THIS.this_cCGru       = ""
            THIS.this_cDGru       = ""
            THIS.this_cCate       = ""
            THIS.this_cCateD      = ""
            THIS.this_cCole       = ""
            THIS.this_cColeD      = ""
            THIS.this_cProd       = ""
            THIS.this_cProdD      = ""
            THIS.this_nOpcao      = 1
            THIS.this_nDesc       = 0
            THIS.this_nLanc       = 0

            *-- Carregar formas de pagamento disponiveis (SigOpFp)
            *-- Cursor precisa ser ReadWrite: usuario marca/desmarca via grid
            IF USED(THIS.this_cCursorOpFp)
                USE IN (THIS.this_cCursorOpFp)
            ENDIF
            IF USED("cursor_4c_OpFp_tmp")
                USE IN cursor_4c_OpFp_tmp
            ENDIF

            loc_cSQL = "SELECT CAST(0 AS INT) AS nMarca, fpags FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar formas de pagamento (SigOpFp)"
            ELSE
                SELECT * FROM cursor_4c_OpFp_tmp INTO CURSOR (THIS.this_cCursorOpFp) READWRITE
                USE IN cursor_4c_OpFp_tmp
                SELECT (THIS.this_cCursorOpFp)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Cotas de Desconto
    * Equivalente ao procedimento "processamento" do legado SIGREDES.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lContinuar
        LOCAL loc_lcGru, loc_lcVend, loc_lcEmp, loc_lcCole, loc_lcCate, loc_lcProd
        LOCAL loc_cheVen, loc_cheCole, loc_cheCate, loc_cheProd, loc_cheFP
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo
        LOCAL loc_lcChaAnt, loc_ldDatM, loc_ldDatP, loc_lnValRel, loc_lnAlt
        LOCAL loc_lcPdes, loc_lcVdes, loc_lnOpt, loc_lnDesc, loc_lnLanc
        LOCAL loc_cOpFpAlias, loc_nVdestot
        LOCAL loc_aCursFech(11), loc_nFech
        PRIVATE pDtI, pDtF, pDtH

        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            *-- Extrair valores dos filtros do BO
            loc_lcGru  = ALLTRIM(THIS.this_cCGru)
            loc_lcVend = ALLTRIM(THIS.this_cVend)
            loc_lcEmp  = ALLTRIM(THIS.this_cEmpresa)
            loc_lcCole = ALLTRIM(THIS.this_cCole)
            loc_lcCate = ALLTRIM(THIS.this_cCate)
            loc_lcProd = ALLTRIM(THIS.this_cProd)
            loc_lnOpt  = THIS.this_nOpcao
            loc_lnDesc = THIS.this_nDesc
            loc_lnLanc = THIS.this_nLanc

            *-- Parametros de data para SQLEXEC binding (?pDtI / ?pDtF / ?pDtH)
            pDtI = DTOT(THIS.this_dDtInicial)
            pDtF = DTOT(THIS.this_dDtFinal) + 86399
            pDtH = DTOT(DATE()) + 86399

            *-- Filtro vendedor
            IF EMPTY(loc_lcVend)
                loc_cheVen = ""
            ELSE
                loc_cheVen = " and a.vends = '" + loc_lcVend + "' "
            ENDIF

            *-- Filtro colecao
            IF EMPTY(loc_lcCole)
                loc_cheCole = ""
            ELSE
                loc_cheCole = " and p.sgrus = '" + loc_lcCole + "' "
            ENDIF

            *-- Filtro categoria
            IF EMPTY(loc_lcCate)
                loc_cheCate = ""
            ELSE
                loc_cheCate = " and p.colecoes = '" + loc_lcCate + "' "
            ENDIF

            *-- Filtro produto
            IF EMPTY(loc_lcProd)
                loc_cheProd = ""
            ELSE
                loc_cheProd = " and b.cpros = '" + loc_lcProd + "' "
            ENDIF

            *-- Filtro formas de pagamento (marcadas no grid)
            loc_cheFP      = ""
            loc_cOpFpAlias = THIS.this_cCursorOpFp
            IF USED(loc_cOpFpAlias)
                SELECT nMarca, fpags FROM (m.loc_cOpFpAlias) WHERE nMarca = 1 ;
                    INTO CURSOR cursor_4c_FpSel
                GO TOP
                IF !EOF()
                    loc_cheFP = " and e.fpags in ('"
                    SCAN
                        loc_cheFP = loc_cheFP + ALLTRIM(fpags) + "','"
                    ENDSCAN
                    loc_cheFP = LEFT(loc_cheFP, LEN(loc_cheFP) - 2) + ") "
                ENDIF
                IF USED("cursor_4c_FpSel")
                    USE IN cursor_4c_FpSel
                ENDIF
            ENDIF

            *-- Titulo para cabecalho do relatorio
            loc_lcCbEmp = "VENDAS"
            IF !EMPTY(loc_lcGru)
                loc_lcCbEmp = loc_lcCbEmp + " (" + ALLTRIM(loc_lcGru) + ")"
            ENDIF

            *-- Fechar cursores de execucao anterior
            loc_aCursFech(1)  = "csDados"
            loc_aCursFech(2)  = "csDados1"
            loc_aCursFech(3)  = "csDados_tmp"
            loc_aCursFech(4)  = "csRelatorio"
            loc_aCursFech(5)  = "csTmpRel"
            loc_aCursFech(6)  = "csCabecalho"
            loc_aCursFech(7)  = "crProd"
            loc_aCursFech(8)  = "crMvPar"
            loc_aCursFech(9)  = "crAux"
            loc_aCursFech(10) = "crAux1"
            loc_aCursFech(11) = "crAux2"
            FOR loc_nFech = 1 TO 11
                IF USED(loc_aCursFech(loc_nFech))
                    USE IN (loc_aCursFech(loc_nFech))
                ENDIF
            ENDFOR
            IF USED("cursor_4c_FpSel")
                USE IN cursor_4c_FpSel
            ENDIF

            *-- Query principal: cabecalho x itens x descontos (SQL Server)
            loc_lcQuery = ;
                "Select a.datars, a.Emps, a.Dopes, a.Numes, " + ;
                "b.CPros, b.dpros, b.qtds, b.units, b.unitorigs, b.totas, b.opers, " + ;
                "c.rclis as repre, " + ;
                "case when co.descricaos is null then 'sem subgrupo' " + ;
                "  else co.descricaos end as colecao, " + ;
                "case when ca.descs is null then 'sem categoria' " + ;
                "  else ca.descs end as categoria, " + ;
                "a.empdopnums, a.cidchaves as chaCab, b.cidchaves as chaItn, " + ;
                "d.cidchaves as chaItd, SPACE(50) as formasP, '1' as imprime, " + ;
                "' ' as lancamento, d.ddesc, d.pdes, d.vdes, d.tpdesc, " + ;
                "d.codigo, e.valcota, round(unitorigs*qtds,2) as ValR, " + ;
                "CAST(0.00 as numeric(11,4)) as DescT, " + ;
                "CAST(0.00 as numeric(11,2)) as Realizado, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes01, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes01, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes02, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes02, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes03, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes03, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes04, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes04, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes05, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes05, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes06, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes06, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes07, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes07, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes08, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes08, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes09, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes09, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes10, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes10, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes11, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes11, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes12, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes12, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes13, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes13, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes14, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes14, " + ;
                "CAST(0.00 as numeric(11,4)) as vdestot " + ;
                "From SigMvCab a with(nolock) " + ;
                "left join SigCdCli c with(nolock) on c.IClis = a.Vends " + ;
                ", SigMvItn b with(nolock) " + ;
                "left join SigMvItd d with(nolock) " + ;
                "  on b.empdopnums = d.empdopnums " + ;
                "  and b.cpros = d.Cpros and b.citens = d.citens " + ;
                "left join sigcddes e with(nolock) on d.codigo = e.codigo, " + ;
                "SigCdOpe g with(nolock), " + ;
                "SigCdTom h with(nolock), SigcdPro p with(nolock) " + ;
                "left join SigCdPsg co with(nolock) " + ;
                "  on co.cgrus = p.cgrus and co.codigos = p.sgrus " + ;
                "left join SigCdCtg ca with(nolock) on ca.cods = p.categoria " + ;
                "Where a.datars BetWeen ?pDtI And ?pDtF And " + ;
                IIF(EMPTY(loc_lcGru), "", "c.Grupos = '" + loc_lcGru + "' And ") + ;
                IIF(EMPTY(loc_lcEmp), "", "a.Emps = '"   + loc_lcEmp + "' And ") + ;
                "b.cpros = p.cpros And " + ;
                "a.EmpDopNums = b.EmpDopNums and " + ;
                "a.dopes = g.dopes and " + ;
                "g.tipoops = h.codigos and " + ;
                "h.gergdmis = 1 and " + ;
                "g.tipoops <> 5 " + ;
                loc_cheCole + loc_cheCate + loc_cheVen + loc_cheProd + ;
                "order by a.cidchaves, b.cidchaves, d.cidchaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados)"
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT * FROM csDados_tmp INTO CURSOR csDados READWRITE
                USE IN csDados_tmp
                SELECT csDados
                GO TOP

                *-- Query secundaria: cotas sigcddes nao cobertas pela query principal
                loc_lcQuery = "SELECT * FROM sigcddes WITH(NOLOCK)" + ;
                    " WHERE dtini >= ?pDtI And dtfin <= ?pDtF" + ;
                    IIF(EMPTY(loc_lcEmp), "", " and Emps = '" + loc_lcEmp + "'")
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados1)"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Append de cotas sem venda no periodo
                SELECT * FROM csDados1 ;
                    WHERE emps NOT IN (SELECT emps FROM csDados) ;
                    INTO CURSOR csDados1
                SELECT csDados1
                GO TOP
                SCAN
                    SELECT csDados
                    APPEND BLANK
                    REPLACE emps    WITH csDados1.emps
                    REPLACE valcota WITH csDados1.valcota
                    REPLACE imprime WITH "1"
                ENDSCAN
                IF USED("csDados1")
                    USE IN csDados1
                ENDIF

                *-- Marcar linhas duplicadas e sinalizar lancamentos
                loc_lcChaAnt = "xxxxxxx"
                SELECT csDados
                GO TOP
                SCAN
                    IF ISNULL(csDados.chaitd) OR EMPTY(csDados.chaitd)
                        REPLACE chaitd WITH SPACE(20) IN csDados
                        REPLACE ddesc  WITH ""         IN csDados
                        REPLACE pdes   WITH 0.00       IN csDados
                        REPLACE vdes   WITH 0.00       IN csDados
                    ENDIF
                    IF csDados.chacab + csDados.chaitn + csDados.chaitd = loc_lcChaAnt
                        REPLACE imprime WITH "" IN csDados
                    ENDIF
                    loc_lcChaAnt = csDados.chacab + csDados.chaitn + csDados.chaitd

                    *-- Lancamento: produto lancado ha menos de 61 dias da data da venda
                    loc_lcQuery = "SELECT dtincs FROM sigcdpro WITH(NOLOCK) WHERE cpros = " + ;
                                  EscaparSQL(ALLTRIM(csDados.cpros))
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crProd") >= 1
                        SELECT crProd
                        IF !EOF() AND !ISNULL(crProd.dtincs)
                            loc_ldDatM = TTOD(csDados.datars)
                            loc_ldDatP = TTOD(crProd.dtincs)
                            IF loc_ldDatM - loc_ldDatP < 61
                                REPLACE lancamento WITH "1" IN csDados
                            ENDIF
                        ENDIF
                        USE IN crProd
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Filtrar somente itens com desconto (chaitd preenchido)
                IF loc_lnDesc = 1
                    SELECT csDados
                    DELETE ALL FOR chaitd = SPACE(20)
                ENDIF

                *-- Filtrar somente produtos lancamento
                IF loc_lnLanc = 1
                    SELECT csDados
                    DELETE ALL FOR lancamento <> "1"
                ENDIF

                *-- Formas de pagamento de cada operacao
                SELECT csDados
                GO TOP
                SCAN
                    loc_lcQuery = "SELECT fpags FROM sigmvpar WITH(NOLOCK)" + ;
                        " WHERE empdopnums = " + ;
                        EscaparSQL(ALLTRIM(csDados.empdopnums)) + ;
                        " GROUP BY fpags"
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crMvPar") >= 1
                        SELECT crMvPar
                        GO TOP
                        SCAN
                            REPLACE formasP WITH ALLTRIM(csDados.formasP) + ;
                                " " + ALLTRIM(crMvPar.fpags) IN csDados
                        ENDSCAN
                        USE IN crMvPar
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Cursor de trabalho: apenas registros a imprimir
                SELECT * FROM csDados WHERE imprime = "1" INTO CURSOR csRelatorio READWRITE

                *-- Preencher colunas de desconto (pdes01-pdes14) por tipo
                SELECT csRelatorio
                GO TOP
                SCAN
                    SELECT csDados
                    GO TOP
                    SCAN FOR csDados.chacab + csDados.chaitn + csDados.chaitd = ;
                             csRelatorio.chacab + csRelatorio.chaitn + csRelatorio.chaitd ;
                             AND NVL(csDados.tpdesc, 0) > 0
                        loc_lcPdes = "pDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        loc_lcVdes = "vDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        REPLACE &loc_lcPdes WITH csDados.pdes IN csRelatorio
                        REPLACE &loc_lcVdes WITH csDados.vdes IN csRelatorio
                    ENDSCAN
                    SELECT csRelatorio
                    loc_lnAlt = csRelatorio.pdes01 + csRelatorio.pdes02 + ;
                                csRelatorio.pdes03 + csRelatorio.pdes04 + ;
                                csRelatorio.pdes05 + csRelatorio.pdes06 + ;
                                csRelatorio.pdes07 + csRelatorio.pdes08 + ;
                                csRelatorio.pdes09 + csRelatorio.pdes10 + ;
                                csRelatorio.pdes11 + csRelatorio.pdes12 + ;
                                csRelatorio.pdes13 + csRelatorio.pdes14
                    REPLACE desct WITH IIF(csRelatorio.ValR = 0, 0, ;
                        ROUND((csRelatorio.ValR - csRelatorio.totas) / ;
                              NVL(csRelatorio.ValR, 1) * 100, 2)) ;
                        IN csRelatorio
                    loc_lnValRel = csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes12 + csRelatorio.vdes13
                    REPLACE realizado WITH loc_lnValRel IN csRelatorio
                    loc_nVdestot = csRelatorio.vdes01 + csRelatorio.vdes02 + ;
                                   csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes11 + csRelatorio.vdes12 + ;
                                   csRelatorio.vdes13 + csRelatorio.vdes14
                    REPLACE vdestot WITH loc_nVdestot IN csRelatorio
                ENDSCAN

                *-- Agrupa em csTmpRel
                IF loc_lnOpt = 1
                    *-- Detalhado: agrupa colapsando chaitd duplicados
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, ;
                           MAX(chaitd) AS chaitd, formasp, imprime, lancamento, ;
                           MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, SUM(vdes) AS vdes, ;
                           MAX(tpdesc) AS tpdesc, codigo, valcota, valr, desct, ;
                           realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, formasp, ;
                                    imprime, lancamento, codigo, valcota, valr, ;
                                    desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ELSE
                    *-- Resumido: inclui chaitd no agrupamento
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, chaitd, formasp, imprime, ;
                           lancamento, MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, ;
                           SUM(vdes) AS vdes, MAX(tpdesc) AS tpdesc, codigo, ;
                           valcota, valr, desct, realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, chaitd, ;
                                    formasp, imprime, lancamento, codigo, valcota, ;
                                    valr, desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ENDIF

                *-- Reconstruir csRelatorio a partir de csTmpRel
                ZAP IN csRelatorio
                SELECT * FROM csTmpRel INTO CURSOR csRelatorio READWRITE
                IF USED("csTmpRel")
                    USE IN csTmpRel
                ENDIF
                SELECT csRelatorio
                GO TOP

                *-- Visao Resumida: calculos de totais por empresa e vendedor
                IF loc_lnOpt <> 1
                    SELECT emps, SPACE(20) AS repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM csRelatorio GROUP BY emps, codigo INTO CURSOR crAux2
                    SELECT emps, SPACE(20) AS repre, SUM(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM crAux2 GROUP BY emps INTO CURSOR crAux2

                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM csRelatorio GROUP BY emps, repre, codigo ;
                           INTO CURSOR crAux1
                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM crAux1 GROUP BY emps, repre ;
                           INTO CURSOR crAux1 READWRITE
                    SELECT crAux1
                    DELETE ALL FOR EMPTY(repre)

                    SELECT * FROM crAux2 UNION (SELECT * FROM crAux1) INTO CURSOR crAux
                    SELECT emps, repre, valcota, ;
                           realizado AS realizadoV, ;
                           ROUND(realizado / NVL(valcota, 1) * 100, 2) AS realizadoP, ;
                           valcota - realizado AS saldoV, ;
                           ROUND((valcota - realizado) / NVL(valcota, 1) * 100, 2) AS saldoP, ;
                           tipo ;
                           FROM crAux INTO CURSOR csRelatorio ORDER BY 1
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Resumido"
                ELSE
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Detalhado"
                ENDIF

                *-- Cursor de cabecalho para o relatorio
                loc_lcCbPeriodo = "Per" + CHR(237) + "odo : " + ;
                    DTOC(THIS.this_dDtInicial) + " 00:00:00 - " + ;
                    DTOC(THIS.this_dDtFinal)   + " 23:59:59 "
                CREATE CURSOR csCabecalho (empresa c(240), titulo c(240), periodo c(80))
                INSERT INTO csCabecalho (empresa, titulo, periodo) ;
                    VALUES (loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo)

                SELECT csRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Processa e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF


        *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                ENDIF
                SELECT csRelatorio
                GO TOP
                THIS.ExecutarReportForm("SigReDe1", "PREVIEW", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Processa e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                ENDIF
                SELECT csRelatorio
                GO TOP
                THIS.ExecutarReportForm("SigReDe1", "PRINTER_PROMPT", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * (snapshot de filtros - usado para reaproveitar filtros entre execucoes)
    * Equivalente a CarregarDoCursor de BOs CRUD, adaptado para relatorio.
    * par_cAliasCursor : nome do cursor com campos identicos as propriedades
    *                    de filtro do BO (cEmpresa, dDtInicial, etc.)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_aFields(1), loc_nFlds, loc_nI, loc_cFld
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Mapear apenas os campos efetivamente presentes no cursor
            loc_nFlds = AFIELDS(loc_aFields, loc_cAlias)
            FOR loc_nI = 1 TO loc_nFlds
                loc_cFld = UPPER(ALLTRIM(loc_aFields(loc_nI, 1)))
                DO CASE
                    CASE loc_cFld == "CEMPRESA"
                        THIS.this_cEmpresa    = TratarNulo(EVALUATE(loc_cAlias + ".cEmpresa"),    "C")
                    CASE loc_cFld == "CDESEMPRESA"
                        THIS.this_cDesEmpresa = TratarNulo(EVALUATE(loc_cAlias + ".cDesEmpresa"), "C")
                    CASE loc_cFld == "DDTINICIAL"
                        THIS.this_dDtInicial  = TratarNulo(EVALUATE(loc_cAlias + ".dDtInicial"),  "D")
                    CASE loc_cFld == "DDTFINAL"
                        THIS.this_dDtFinal    = TratarNulo(EVALUATE(loc_cAlias + ".dDtFinal"),    "D")
                    CASE loc_cFld == "CCGRU"
                        THIS.this_cCGru       = TratarNulo(EVALUATE(loc_cAlias + ".cCGru"),       "C")
                    CASE loc_cFld == "CDGRU"
                        THIS.this_cDGru       = TratarNulo(EVALUATE(loc_cAlias + ".cDGru"),       "C")
                    CASE loc_cFld == "CVEND"
                        THIS.this_cVend       = TratarNulo(EVALUATE(loc_cAlias + ".cVend"),       "C")
                    CASE loc_cFld == "CDVEND"
                        THIS.this_cDVend      = TratarNulo(EVALUATE(loc_cAlias + ".cDVend"),      "C")
                    CASE loc_cFld == "CCATE"
                        THIS.this_cCate       = TratarNulo(EVALUATE(loc_cAlias + ".cCate"),       "C")
                    CASE loc_cFld == "CCATED"
                        THIS.this_cCateD      = TratarNulo(EVALUATE(loc_cAlias + ".cCateD"),      "C")
                    CASE loc_cFld == "CCOLE"
                        THIS.this_cCole       = TratarNulo(EVALUATE(loc_cAlias + ".cCole"),       "C")
                    CASE loc_cFld == "CCOLED"
                        THIS.this_cColeD      = TratarNulo(EVALUATE(loc_cAlias + ".cColeD"),      "C")
                    CASE loc_cFld == "CPROD"
                        THIS.this_cProd       = TratarNulo(EVALUATE(loc_cAlias + ".cProd"),       "C")
                    CASE loc_cFld == "CPRODD"
                        THIS.this_cProdD      = TratarNulo(EVALUATE(loc_cAlias + ".cProdD"),      "C")
                    CASE loc_cFld == "NOPCAO"
                        THIS.this_nOpcao      = TratarNulo(EVALUATE(loc_cAlias + ".nOpcao"),      "N")
                    CASE loc_cFld == "NDESC"
                        THIS.this_nDesc       = TratarNulo(EVALUATE(loc_cAlias + ".nDesc"),       "N")
                    CASE loc_cFld == "NLANC"
                        THIS.this_nLanc       = TratarNulo(EVALUATE(loc_cAlias + ".nLanc"),       "N")
                ENDCASE
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Relatorio nao suporta operacoes de insercao de dados
    * Mantido por contrato com BusinessBase mas registra auditoria da execucao
    * do relatorio (que e a unica operacao "de escrita" relevante para reports)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Reports nao inserem registros de negocio. A unica acao registrada
            *-- e a auditoria da execucao do relatorio em si.
            THIS.RegistrarAuditoria("EXECUCAO_RELATORIO")
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de inser" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Relatorio nao suporta operacoes de atualizacao de dados
    * Mantido por contrato com BusinessBase. Reports sao read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de atualiza" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    * Operacao tipica: "EXECUCAO_RELATORIO"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cDetalhe, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") <> "N" OR gnConnHandle < 1
                loc_lSucesso = .F.
            ENDIF

            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            loc_cDetalhe = "SIGREDES " + ALLTRIM(par_cOperacao) + ;
                " | Per" + CHR(237) + "odo " + DTOC(THIS.this_dDtInicial) + ;
                " - " + DTOC(THIS.this_dDtFinal) + ;
                " | Empresa " + ALLTRIM(THIS.this_cEmpresa) + ;
                " | Vend " + ALLTRIM(THIS.this_cVend) + ;
                " | Visao " + IIF(THIS.this_nOpcao = 1, "Detalhada", "Resumida")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                "VALUES (" + EscaparSQL("SIGREDES") + ", " + ;
                EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                EscaparSQL("SIGREDES") + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(loc_cDetalhe) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(15), loc_nI
        loc_aCursores(1)  = THIS.this_cCursorDados
        loc_aCursores(2)  = THIS.this_cCursorRelatorio
        loc_aCursores(3)  = THIS.this_cCursorOpFp
        loc_aCursores(4)  = "cursor_4c_OpFp_tmp"
        loc_aCursores(5)  = "csDados1"
        loc_aCursores(6)  = "csTmpRel"
        loc_aCursores(7)  = "csRelatorio"
        loc_aCursores(8)  = "crAux"
        loc_aCursores(9)  = "crAux1"
        loc_aCursores(10) = "crAux2"
        loc_aCursores(11) = "crProd"
        loc_aCursores(12) = "crMvPar"
        loc_aCursores(13) = "csCabecalho"
        loc_aCursores(14) = "cursor_4c_EmpCab"
        loc_aCursores(15) = "csDados"

        FOR loc_nI = 1 TO 15
            IF !EMPTY(loc_aCursores(loc_nI)) AND USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE
