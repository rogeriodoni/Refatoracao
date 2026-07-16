*==============================================================================
* SIGRECSMBO.PRG
* Business Object - Relatorio de Comissao por Condicao de Pagamento
* Herda de RelatorioBase
*
* Formulario original: SIGRECSM.SCX (frmrelatorio)
* Tabelas: SigMvCab, SigMvPar, SigCdOpe, SigOpFp, SigCdEmp, SigCdCli, SigCdCrg
* Relatorios FRX: SigReCs1 (Condicao Pgto), SigReCs2 (Sintetico/Analitico/Dividido)
*
* Cursores FRX (nomes fixos para compatibilidade):
*   cabecalho - cabecalho do relatorio (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo)
*   tempo     - dados principais para nOpt=1,2,4
*   tempo2    - dados agrupados por condicao de pagamento para nOpt=3
*==============================================================================

DEFINE CLASS sigrecsmBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: empresa (SigCdEmp - cemps / razas)
    this_cCemps         = ""
    this_cRazas         = ""

    *-- Filtros: grupo de vendedor (get_cd_grestoque / get_Ds_GrEstoque)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: vendedor / conta (get_cd_estoque / get_ds_estoque)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: moeda (SigCdMoe - cmoes / dmoes)
    this_cCmoes         = ""
    this_cDmoes         = ""

    *-- Opcao de relatorio: 1=Sintetico, 2=Analitico, 3=Cond.Pgto, 4=Comissao Dividida
    this_nOptRel        = 1

    *-- Nao incluir comissao zerada (FwChkComissao)
    this_lChkComissao   = .F.

    *-- Cursor de dados principal (nome FRX-compativel)
    this_cCursorDados       = "tempo"
    this_cCursorCabecalho   = "cabecalho"

    *-- Caminhos dos FRX
    *-- FRX1: nOpt=3 (Condicao de Pagamento)
    *-- FRX2: nOpt=1,2,4 (Sintetico, Analitico, Comissao Dividida)
    this_cCaminhoFrx1   = ""
    this_cCaminhoFrx2   = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCaminhoFrx1 = gc_4c_CaminhoReports + "SigReCs1.frx"
            THIS.this_cCaminhoFrx2 = gc_4c_CaminhoReports + "SigReCs2.frx"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecsmBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa filtros e monta cursores para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado (SIGRECSM)
    *
    * Fluxo:
    *   1. Carrega SigCdCot em cursor_4c_CsmCot (para CarregarCambioCSM)
    *   2. Busca nome da empresa para cabecalho
    *   3. Cria cursor cabecalho com dados do titulo do relatorio
    *   4. SQLEXEC query principal (SigMvCab/Par/Ope/Fp/Emp/Cli/Crg) em cursor_4c_CsmTemp
    *   5. SELECT local de cursor_4c_CsmTemp para cursor tempo (por nOpt)
    *   6. Se this_lChkComissao: remove registros com comissao zero
    *   7. Se nOpt=3: JOIN com SigPrInf para agrupar por condicao pagto em tempo2
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cDGrupo, loc_cConta, loc_cCmoes, loc_cDmoes
        LOCAL loc_nOpt
        LOCAL loc_cDataIni, loc_cDataFim
        LOCAL loc_cEmpWhere, loc_cGrupoWhere, loc_cContaWhere
        LOCAL loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo
        LOCAL loc_cVerVendedor

        loc_lSucesso = .F.

        TRY
            *-- Le filtros do BO
            loc_cEmpresa = PADR(ALLTRIM(THIS.this_cCemps), 3)
            loc_cGrupo   = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
            loc_cDGrupo  = PADR(ALLTRIM(THIS.this_cDsGrEstoque), 20)
            loc_cConta   = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
            loc_cCmoes   = PADR(ALLTRIM(THIS.this_cCmoes), 3)
            loc_cDmoes   = PADR(ALLTRIM(THIS.this_cDmoes), 15)
            loc_nOpt     = THIS.this_nOptRel

            *-- Formata datas para SQL Server
            loc_cDataIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDataFim = "'" + STR(YEAR(THIS.this_dDtFinal), 4) + "-" + ;
                           PADL(LTRIM(STR(MONTH(THIS.this_dDtFinal))), 2, "0") + "-" + ;
                           PADL(LTRIM(STR(DAY(THIS.this_dDtFinal))), 2, "0") + " 23:59:59'"

            *-- ================================================================
            *-- STEP 1: Carrega cotacoes para conversao de moeda (CarregarCambioCSM)
            *-- ================================================================
            IF USED("cursor_4c_CsmCot")
                USE IN cursor_4c_CsmCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", ;
                "cursor_4c_CsmCot")
            IF loc_nResult > 0
                SELECT cursor_4c_CsmCot
                INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            ENDIF

            *-- ================================================================
            *-- STEP 2: Busca nome da empresa para cabecalho do relatorio
            *-- ================================================================
            loc_cNomeEmpresa = ""
            IF USED("cursor_4c_CsmEmp")
                USE IN cursor_4c_CsmEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(ALLTRIM(loc_cEmpresa)), ;
                "cursor_4c_CsmEmp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_CsmEmp")
                SELECT cursor_4c_CsmEmp
                loc_cNomeEmpresa = ALLTRIM(cursor_4c_CsmEmp.razas)
            ENDIF

            *-- ================================================================
            *-- STEP 3: Monta strings do cabecalho e cria cursor cabecalho
            *-- ================================================================
            loc_cRelTitulo = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o de Vendedor por Condi" + CHR(231) + CHR(227) + ;
                             "o de Pagamento"
            loc_cRelTitul2 = "Relat" + CHR(243) + "rio " + ;
                             IIF(loc_nOpt = 1, "Sint" + CHR(233) + "tico", ;
                             IIF(loc_nOpt = 2, "Anal" + CHR(237) + "tico", ;
                             "Tipo Cond.Pagto")) + "  -  " + ;
                             IIF(EMPTY(ALLTRIM(loc_cGrupo)), ;
                             "Todos os Grupos", ;
                             "Grupo :" + ALLTRIM(loc_cGrupo) + ;
                             " - " + ALLTRIM(loc_cDGrupo)) + "  -  " + ;
                             ALLTRIM(loc_cCmoes) + "- " + ALLTRIM(loc_cDmoes)
            loc_cPeriodo   = "Per" + CHR(237) + "odo: " + ;
                             DTOC(THIS.this_dDtInicial) + ;
                             " " + CHR(160) + " " + DTOC(THIS.this_dDtFinal)

            IF USED("cabecalho")
                USE IN cabecalho
            ENDIF
            CREATE CURSOR cabecalho ;
                (pNmEmp C(80), pRelTitulo C(80), pRelTitul2 C(80), pPeriodo C(80))
            INSERT INTO cabecalho (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo) ;
                VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo)

            *-- ================================================================
            *-- STEP 4: Query principal contra SQL Server
            *-- ================================================================
            loc_cEmpWhere   = IIF(EMPTY(ALLTRIM(loc_cEmpresa)), "", ;
                              " AND a.emps = " + EscaparSQL(ALLTRIM(loc_cEmpresa)))
            loc_cGrupoWhere = IIF(EMPTY(ALLTRIM(loc_cGrupo)) OR loc_nOpt = 4, "", ;
                              " AND (a.GrVends = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ;
                              " OR a.GrResps = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ")")
            loc_cContaWhere = IIF(EMPTY(ALLTRIM(loc_cConta)) OR loc_nOpt = 4, "", ;
                              " AND (a.Vends = " + EscaparSQL(ALLTRIM(loc_cConta)) + ;
                              " OR a.Resps = " + EscaparSQL(ALLTRIM(loc_cConta)) + ")")

            IF USED("cursor_4c_CsmTemp")
                USE IN cursor_4c_CsmTemp
            ENDIF

            loc_cSQL = "SELECT a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes, a.empdopnums," + ;
                       " b.copers, c.Trocos, c.fpcomiss," + ;
                       " c.fpags, c.infos, d.valos," + ;
                       " d.Moefpgs, d.cotfpgs, e.razas," + ;
                       " f.iClis, f.rclis, f.CCargs," + ;
                       " g.FComis, g.acomis," + ;
                       " a.Resps, h.rclis AS DResps," + ;
                       " h.Ccargs AS CcargResps, a.grvends" + ;
                       " FROM SigMvCab a" + ;
                       " INNER JOIN SigMvPar d ON d.empdopnums = a.empdopnums" + ;
                       " INNER JOIN SigCdOpe b ON d.dopes = b.dopes" + ;
                       " AND b.ccomis = 1" + ;
                       " INNER JOIN SigOpFp c ON d.fpags = c.fpags" + ;
                       " AND c.bxcomis = 1" + ;
                       " INNER JOIN SigCdEmp e ON a.cemps = e.cemps" + ;
                       " LEFT JOIN SigCdCli h ON a.Resps = h.Iclis" + ;
                       " LEFT JOIN SigCdCli f ON a.Vends = f.iclis" + ;
                       " LEFT JOIN SigCdCrg g ON f.ccargs = g.ccargs" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFim + ;
                       loc_cEmpWhere + loc_cGrupoWhere + loc_cContaWhere + ;
                       " ORDER BY a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmTemp")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- ================================================================
            *-- STEP 5: Processa cursor temporario conforme opcao do relatorio
            *-- ================================================================
            IF USED("tempo")
                USE IN tempo
            ENDIF

            IF loc_nOpt = 1
                *-- Sintetico: vendedor como vends + UNION com responsavel (Resps)
                SELECT vends, datas, emps, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(m.loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                UNION ;
                SELECT Resps AS vends, datas, emps, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(m.loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                ORDER BY 3, 1, 2, 5 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF INLIST(loc_nOpt, 2, 3)
                *-- Analitico / Condicao Pagto: inclui dopes e numes no agrupamento
                SELECT dopes, vends, datas, emps, numes, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(m.loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                UNION ;
                SELECT dopes, Resps AS vends, datas, emps, numes, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(m.loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF loc_nOpt = 4
                *-- Comissao dividida: usa grade de comissoes (SigCdCmm) como base
                loc_cVerVendedor = IIF(EMPTY(ALLTRIM(loc_cGrupo)), "", ;
                                   " AND ALLTRIM(a.grvends) = '" + ;
                                   ALLTRIM(loc_cGrupo) + "'")
                loc_cVerVendedor = loc_cVerVendedor + ;
                                   IIF(EMPTY(ALLTRIM(loc_cConta)), "", ;
                                   " AND ALLTRIM(b.contas) = '" + ;
                                   ALLTRIM(loc_cConta) + "'")

                IF USED("cursor_4c_CsmCmm1")
                    USE IN cursor_4c_CsmCmm1
                ENDIF
                loc_cSQL = "SELECT a.*, b.rclis AS nvens" + ;
                           " FROM SigCdCmm a, SigCdCli b" + ;
                           " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                           " AND " + loc_cDataFim + ;
                           " AND a.contas = b.iclis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmCmm1")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigCdCmm"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=4)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_CsmCmm2")
                    USE IN cursor_4c_CsmCmm2
                ENDIF
                SELECT empdopnums, COUNT(contas) AS qtdv ;
                FROM cursor_4c_CsmCmm1 ;
                GROUP BY empdopnums ;
                INTO CURSOR cursor_4c_CsmCmm2

                IF USED("cursor_4c_CsmCdCmm")
                    USE IN cursor_4c_CsmCdCmm
                ENDIF
                SELECT a.*, b.qtdv ;
                FROM cursor_4c_CsmCmm1 a, cursor_4c_CsmCmm2 b ;
                WHERE a.empdopnums = b.empdopnums ;
                INTO CURSOR cursor_4c_CsmCdCmm

                SELECT a.dopes, b.contas AS vends, a.datas, a.emps, a.numes, ;
                       a.fpcomiss, a.fpags, a.rclis, a.razas, b.nvens, ;
                       a.CCargs, a.infos, a.FComis, ;
                       b.percs AS acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(a.CCargs) AND !ISNULL(a.FComis) AND a.FComis = "S", ;
                           b.percs / 100.0, 1.0) AS fatComis, ;
                       SUM(a.valos / b.qtdv * a.cotfpgs / ;
                           CarregarCambioCSM(m.loc_cCmoes, a.datas)) AS tots ;
                FROM cursor_4c_CsmTemp a, cursor_4c_CsmCdCmm b ;
                WHERE a.empdopnums = b.empdopnums &loc_cVerVendedor ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            *-- ================================================================
            *-- STEP 6: Filtro de comissao zerada (FwChkComissao)
            *-- SET DELETED ON (config.prg) ignora registros deletados no REPORT
            *-- ================================================================
            IF THIS.this_lChkComissao AND USED("tempo") AND RECCOUNT("tempo") > 0
                SELECT tempo
                DELETE FROM tempo WHERE ROUND(tots * fpcomiss * fatComis / 100.0, 2) = 0
            ENDIF

            *-- ================================================================
            *-- STEP 7: Para nOpt=3, agrupa por condicao de pagamento (SigPrInf)
            *-- ================================================================
            IF loc_nOpt = 3
                IF USED("cursor_4c_CsmInf")
                    USE IN cursor_4c_CsmInf
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigPrInf", "cursor_4c_CsmInf")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigPrInf"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=3)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("tempo2")
                    USE IN tempo2
                ENDIF
                SELECT a.emps, a.vends, MAX(a.nvens) AS nvens, ;
                       a.infos, MAX(b.descrs) AS descrs, ;
                       SUM(tots) AS tots, ;
                       MAX(a.razas) AS razas, MAX(a.CCargs) AS ccargs ;
                FROM tempo a, cursor_4c_CsmInf b ;
                WHERE a.infos = b.infos ;
                GROUP BY 1, 2, 4 ;
                ORDER BY 1, 2, 5 ;
                INTO CURSOR tempo2
            ENDIF

            SELECT tempo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.PrepararDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) TO PRINTER PROMPT NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) PREVIEW NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + ;
               "|" + ALLTRIM(THIS.this_cCemps) + "|" + ;
               STR(THIS.this_nOptRel, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores locais criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores[9], loc_i
        loc_aCursores[1] = "cursor_4c_CsmTemp"
        loc_aCursores[2] = "cursor_4c_CsmCot"
        loc_aCursores[3] = "cursor_4c_CsmEmp"
        loc_aCursores[4] = "cursor_4c_CsmCmm1"
        loc_aCursores[5] = "cursor_4c_CsmCmm2"
        loc_aCursores[6] = "cursor_4c_CsmCdCmm"
        loc_aCursores[7] = "cursor_4c_CsmInf"
        loc_aCursores[8] = "cabecalho"
        loc_aCursores[9] = "tempo"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        ENDFOR

        IF USED("tempo2")
            USE IN tempo2
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* CarregarCambioCSM - UDF standalone para calculo de cambio
* Equivalente a fCarregarCambio() do sistema legado, especifico para sigrecsmBO
* Acessivel de dentro de SELECT VFP (nao pode ser metodo de objeto)
*
* Acessa cursor_4c_CsmCot (carregado por sigrecsmBO.PrepararDados)
* Retorna cotacao da moeda na data informada (ou na data imediatamente anterior)
*==============================================================================
FUNCTION CarregarCambioCSM(par_cMoeda, par_dData)
    LOCAL loc_nCotacao, loc_cMoeda, loc_dData

    loc_nCotacao = 1

    IF VARTYPE(par_cMoeda) <> "C" OR EMPTY(par_cMoeda)
        RETURN 1
    ENDIF

    loc_cMoeda = PADR(ALLTRIM(par_cMoeda), 3)

    DO CASE
        CASE VARTYPE(par_dData) = "D"
            loc_dData = par_dData
        CASE VARTYPE(par_dData) = "T"
            loc_dData = TTOD(par_dData)
        OTHERWISE
            loc_dData = DATE()
    ENDCASE

    IF USED("cursor_4c_CsmCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(loc_dData)
        SELECT cursor_4c_CsmCot
        SET ORDER TO CMoeData

        *-- Busca exata na data
        IF SEEK(loc_cMoeda + DTOS(loc_dData))
            loc_nCotacao = cursor_4c_CsmCot.Valos
        ELSE
            *-- Nao encontrou: busca com NEAR para posicionar no mais proximo
            SET NEAR ON
            SEEK(loc_cMoeda + DTOS(loc_dData))
            SET NEAR OFF
            *-- Volta um registro para pegar a taxa mais recente anterior
            IF !BOF()
                SKIP -1
            ENDIF
            IF !BOF() AND ALLTRIM(cursor_4c_CsmCot.CMoes) = ALLTRIM(loc_cMoeda)
                loc_nCotacao = cursor_4c_CsmCot.Valos
            ENDIF
        ENDIF
    ENDIF

    RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
ENDFUNC
