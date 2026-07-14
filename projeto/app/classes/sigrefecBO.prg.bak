*==============================================================================
* SIGREFECBO.PRG
* Business Object para Relatorio de Fechamento de Caixa
* Herda de RelatorioBase
*
* Formulario original: SIGREFEC (sigrefec.SCX)
* Caption: "Fechamento de Caixa"
*==============================================================================

DEFINE CLASS sigrefecBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmps       = ""    && Codigo da empresa (3)
    this_cDEmps      = ""    && Razao social da empresa (40)

    *-- Filtro: Periodo
    this_dDtIni      = {}    && Data inicial
    this_dDtFim      = {}    && Data final

    *-- Filtro: Usuario / Vendedor / Forma de Pagamento
    this_cUsuars     = ""    && Codigo do usuario (10)
    this_cVends      = ""    && Codigo do vendedor (10)
    this_cFPags      = ""    && Condicao de pagamento / forma (10)

    *-- Opcoes de impressao (checkboxes)
    this_lDetOpe     = .F.   && Detalhado Por Operacao
    this_lVends      = .F.   && Imprime Vendedor
    this_lOpePag     = .T.   && Operacoes X Pagamentos
    this_lResFpg     = .T.   && Resumo Por Formas de Pagamento
    this_lAnaPag     = .F.   && Analitico Por Pagamentos
    this_lVendRes    = .F.   && Resumo Por Vendedor

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtIni = DATE()
            THIS.this_dDtFim = DATE()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrefecBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Wrapper com TRY/CATCH para PrepararDadosInterno
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDadosInterno()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosInterno - Logica completa de preparacao (retorno direto OK)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosInterno()
        LOCAL loc_cSQL, loc_nResult, loc_cEdn, loc_cFPags
        LOCAL loc_cVista1EmpDopNums, loc_lnPri
        PRIVATE pDtI, pDtF

        pDtI    = THIS.this_dDtIni
        pDtF    = THIS.this_dDtFim + 1  && limite superior exclusivo (inicio do proximo dia)
        loc_cFPags = ALLTRIM(THIS.this_cFPags)

        *-- Query principal: todas as operacoes de fechamento de caixa do periodo
        loc_cSQL = "SELECT o.RelFechas, o.CalcFecs, e.EmpDopNums, e.Datas, " + ;
                   "e.ContaDs, c.RClis, e.Notas, e.Usuars, e.Valos, e.Vends, " + ;
                   "o.COpers, (o.NDopes * 1000000) + e.Numes AS Codigos, e.ChkSubn " + ;
                   "FROM SigCdOpe o, SigMvCab e, SigCdCli c " + ;
                   "WHERE (o.RelFechas = 1 OR o.RelFechas = 4 " + ;
                   "OR (o.RelFechas = 3 AND e.chkPagos = 1)) " + ;
                   "AND o.CalcFecs = 2 AND o.Dopes = e.Dopes " + ;
                   "AND e.Datas >= ?pDtI AND e.Datas < ?pDtF " + ;
                   "AND e.ContaDs = c.IClis AND e.lcancelas = 0"

        loc_cSQL = loc_cSQL + ;
                   " AND NOT e.EmpDopNums IN (" + ;
                   "SELECT a1.EmpDopNums FROM SigMvPec a1 " + ;
                   "WHERE a1.Codigos IN (" + ;
                   "SELECT (o1.NDopes * 1000000) + e1.Numes AS Codigos " + ;
                   "FROM SigCdOpe o1, SigMvCab e1 " + ;
                   "WHERE o1.RelFechas = 3 AND o1.CalcFecs = 2 " + ;
                   "AND o1.Dopes = e1.Dopes " + ;
                   "AND e1.Datas >= ?pDtI AND e1.Datas < ?pDtF))" + ;
                   " ORDER BY e.EmpDopNums"

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crDados)"
            MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
            RETURN .F.
        ENDIF

        *-- Remove vendas NF parceladas canceladas
        DELETE FROM crDados WHERE RelFechas = 1 AND ChkSubn = .T.

        *-- Substitui vendedor vazio pelo codigo do cliente
        UPDATE crDados SET Vends = ContaDs WHERE EMPTY(Vends)

        *-- Cria cursor de pagamentos consolidados
        CREATE CURSOR crPagamentos ;
            (EmpDopNums C(29), Parcs N(3), FPags C(12), Bancos C(3), ;
             Agencias C(4), Contas C(10), Numeros C(6), Valos N(12,2), ;
             MoeFpgs C(3), Vencs D(8), Outros C(20), DetFecCxs N(1))

        *-- Para cada operacao, busca formas de pagamento
        SELECT crDados
        SCAN
            loc_cEdn = crDados.EmpDopNums

            *-- Tenta buscar pagamentos diretos em SigMvPar
            loc_cSQL = "SELECT a.EmpDopNums, a.Parcs, a.FPags, b.Formas, b.Infos, " + ;
                       "a.Bancos, a.Agencias, a.Contas, a.Numeros, " + ;
                       "CASE WHEN b.trocos=1 THEN -a.valos ELSE a.valos END AS valos, " + ;
                       "a.MoeFpgs, a.Vencs, a.Outros, b.DetFecCxs " + ;
                       "FROM SigMvPar a, SigOpFp b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND a.FPags = b.FPags ORDER BY a.Parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags1)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crPags1
            GO TOP IN crPags1
            IF !EOF("crPags1")
                *-- Filtra por forma de pagamento especificada (se houver)
                SELECT * FROM crPags1 ;
                    WHERE IIF(EMPTY(m.loc_cFPags), .T., FPags = PADR(m.loc_cFPags, 12)) ;
                    INTO CURSOR crPags READWRITE
            ELSE
                *-- Operacao vinculada: busca via SigMvPec
                loc_cSQL = "SELECT b.EmpDopNums, b.Parcs, b.FPags, c.Formas, c.Infos, " + ;
                           "b.Bancos, b.Agencias, b.Contas, b.Numeros, " + ;
                           "CASE WHEN c.trocos=1 THEN -b.valos ELSE b.valos END AS valos, " + ;
                           "b.MoeFpgs, b.Vencs, b.Outros, c.DetFecCxs " + ;
                           "FROM SigMvPec a, SigMvPar b, SigOpFp c " + ;
                           "WHERE a.Codigos = " + LTRIM(STR(crDados.Codigos, 10)) + ;
                           " AND a.EmpDopNums = b.EmpDopNums AND b.FPags = c.FPags"

                IF !EMPTY(loc_cFPags)
                    loc_cSQL = loc_cSQL + " AND b.FPags = " + EscaparSQL(PADR(loc_cFPags, 12))
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY b.Parcs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF
            ENDIF

            SELECT crPags
            GO TOP IN crPags
            IF EOF("crPags") AND !EMPTY(loc_cFPags)
                DELETE IN crDados
            ELSE
                SCAN
                    SCATTER MEMVAR MEMO
                    m.EmpDopNums = loc_cEdn
                    m.FPags = IIF(m.Infos = "B" AND !EMPTY(m.Formas), m.Formas, m.FPags)
                    INSERT INTO crPagamentos FROM MEMVAR
                ENDSCAN
            ENDIF
        ENDSCAN

        *-- Monta crDetalhe: JOIN entre crDados e crPagamentos
        SELECT LEFT(a.EmpDopNums, 3) AS Emps, ;
               SUBSTR(a.EmpDopNums, 4, 20) AS Dopes, ;
               RIGHT(a.EmpDopNums, 6) AS Numes, ;
               a.Datas, a.ContaDs AS IClis, a.RClis, a.Notas, ;
               a.Valos * IIF(a.COpers = 2, -1, 1) AS Valos, ;
               a.Vends, SPACE(30) AS NVends, a.Codigos, a.Usuars, ;
               b.Parcs, b.FPags, b.Bancos, b.Agencias, b.Contas, ;
               b.Numeros, b.Valos * IIF(a.COpers = 2, -1, 1) AS ValPagos, ;
               b.MoeFpgs, b.Vencs, b.DetFecCxs, b.Outros, ;
               a.RelFechas, a.CalcFecs, ;
               SPACE(32) AS RPags, SPACE(32) AS RChqs ;
            FROM crDados a RIGHT JOIN crPagamentos b ;
            ON a.EmpDopNums = b.EmpDopNums ;
            ORDER BY a.Datas, a.EmpDopNums, b.Parcs ;
            INTO CURSOR crDetalhe READWRITE

        *-- Preenche NVends e campos de vista (RPags/RChqs) em crDetalhe
        SELECT crDetalhe
        SCAN
            IF crDetalhe.RelFechas = 3 AND crDetalhe.CalcFecs = 2
                *-- Reconstroi EmpDopNums a partir dos campos fixos (sem ALLTRIM - fixed-width)
                loc_cEdn = crDetalhe.Emps + crDetalhe.Dopes + crDetalhe.Numes

                loc_cSQL = "SELECT p.EmpDopNums " + ;
                           "FROM SigMvPec p " + ;
                           "WHERE p.Codigos = " + LTRIM(STR(crDetalhe.Codigos, 10)) + ;
                           " ORDER BY p.EmpDopNums"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista1)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF

                SELECT crVista1
                GO TOP IN crVista1
                IF !EOF("crVista1")
                    loc_cVista1EmpDopNums = crVista1.EmpDopNums

                    loc_cSQL = "SELECT r.Parcs, r.FPags, r.Valos, r.Vencs, " + ;
                               "r.Contas, r.Numeros " + ;
                               "FROM SigMvPar r " + ;
                               "WHERE r.EmpDopNums = " + EscaparSQL(loc_cVista1EmpDopNums) + ;
                               " AND r.Parcs = " + LTRIM(STR(crDetalhe.Parcs, 2)) + ;
                               " ORDER BY r.Parcs"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista)"
                        MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                        RETURN .F.
                    ENDIF

                    loc_lnPri = 1
                    SELECT crVista
                    SCAN
                        IF !ISNULL(crVista.FPags)
                            IF loc_lnPri > 1
                                loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                                           "WHERE Usuarios = " + EscaparSQL(crDetalhe.Vends)

                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
                                IF loc_nResult < 1
                                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                                    RETURN .F.
                                ENDIF

                                SELECT crNVends
                                GO TOP IN crNVends
                                IF !EOF("crNVends")
                                    REPLACE NVends WITH crNVends.NComps IN crDetalhe
                                ENDIF

                                SKIP IN crDetalhe
                            ENDIF

                            REPLACE RPags WITH LTRIM(STR(loc_lnPri, 2)) + " " + crVista.FPags + ;
                                    " " + SPACE(6) + ;
                                    TRANSFORM(crVista.Valos, "999,999.99") IN crDetalhe

                            IF !EMPTY(crVista.Numeros)
                                REPLACE RChqs WITH crVista.Contas + " / " + crVista.Numeros + ;
                                        "  " + DTOC(crVista.Vencs) IN crDetalhe
                            ENDIF

                            loc_lnPri = loc_lnPri + 1
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Preenche nome do vendedor para todas as linhas
            loc_cSQL = "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
                       EscaparSQL(crDetalhe.Vends)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crNVends
            GO TOP IN crNVends
            IF !EOF("crNVends")
                REPLACE NVends WITH crNVends.NComps IN crDetalhe
            ENDIF
        ENDSCAN

        *-- Monta impressao linha a linha em crImpressao
        CREATE CURSOR crImpressao (Detalhe C(40))

        SET POINT TO ","
        SET SEPARATOR TO "."

        THIS.Cabecalho()

        IF THIS.this_lDetOpe
            THIS.Detalhado()
        ENDIF

        IF THIS.this_lVendRes
            THIS.ResVends()
        ENDIF

        IF THIS.this_lResFpg
            THIS.ResumoPagto()
        ENDIF

        IF THIS.this_lOpePag
            THIS.PagtoXFpags()
        ENDIF

        IF THIS.this_lAnaPag
            THIS.AnaFPags()
        ENDIF

        SET POINT TO "."
        SET SEPARATOR TO ","

        SELECT crImpressao
        GO TOP IN crImpressao

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Cabecalho - Insere cabecalho do relatorio em crImpressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Cabecalho()
        LOCAL loc_cDEmps, loc_dDtIni, loc_dDtFim, loc_cUsuars

        loc_cDEmps  = ALLTRIM(THIS.this_cDEmps)
        loc_dDtIni  = THIS.this_dDtIni
        loc_dDtFim  = THIS.this_dDtFim
        loc_cUsuars = ALLTRIM(THIS.this_cUsuars)

        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES (PADC(loc_cDEmps, 40))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Caixas de: " + DTOC(loc_dDtIni) + ;
            " " + CHR(224) + " " + DTOC(loc_dDtFim))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Usuario  : " + ;
            IIF(EMPTY(loc_cUsuars), "GERAL", loc_cUsuars))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Fechamento em " + DTOC(DATE()) + ;
            " " + CHR(224) + "s " + SUBSTR(TTOC(DATETIME()), 12, 5) + "h")
        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Detalhado - Secao detalhada por operacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Detalhado()
        LOCAL loc_cVen, loc_cVal, loc_lnTot, loc_cCli, loc_cVdd

        loc_cVen   = ALLTRIM(THIS.this_cVends)
        loc_lnTot  = 0

        IF EMPTY(loc_cVen)
            IF THIS.this_lVends
                SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Vends, Dopes ;
                    ORDER BY Dopes, Vends ;
                    INTO CURSOR TmpOperacoes
            ELSE
                SELECT SPACE(10) AS Vends, Dopes, ;
                       SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Dopes ;
                    ORDER BY Dopes ;
                    INTO CURSOR TmpOperacoes
            ENDIF
        ELSE
            SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = m.loc_cVen ;
                GROUP BY Vends, Dopes ;
                ORDER BY Dopes, Vends ;
                INTO CURSOR TmpOperacoes
        ENDIF

        INSERT INTO crImpressao (Detalhe) VALUES ("======== DETALHADO POR OPERACAO ========")

        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes + ":   " + loc_cVal)

            IF EMPTY(loc_cVen)
                IF THIS.this_lVends
                    SELECT DISTINCT Vends, Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND Vends = TmpOperacoes.Vends ;
                        ORDER BY Dopes, Vends, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ELSE
                    SELECT DISTINCT Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes ;
                        ORDER BY Dopes, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ENDIF
            ELSE
                SELECT DISTINCT Dopes, Numes ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOperacoes.Dopes AND Vends = m.loc_cVen ;
                    ORDER BY Dopes, Numes ;
                    INTO CURSOR TmpOpeIndivs
            ENDIF

            SELECT TmpOpeIndivs
            SCAN
                SELECT IClis, RClis, Notas, Vends, NVends, Parcs, FPags, ValPagos, ;
                       Vencs, Bancos, Agencias, Contas, Numeros, RelFechas ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOpeIndivs.Dopes ;
                    ORDER BY Parcs ;
                    INTO CURSOR TmpOpePags

                SELECT TmpOpePags
                SCAN
                    loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999,999.99")

                    IF TmpOpePags.Parcs = 1
                        INSERT INTO crImpressao (Detalhe) VALUES ("> " + ;
                            PADL(ALLTRIM(TmpOpeIndivs.Numes), 6, "0") + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ELSE
                        INSERT INTO crImpressao (Detalhe) VALUES ("        " + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ENDIF

                    IF !EMPTY(TmpOpePags.Numeros)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                            TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                            "  " + DTOC(TmpOpePags.Vencs))
                    ENDIF
                ENDSCAN

                SELECT TmpOpePags
                GO TOP IN TmpOpePags
                IF !EOF("TmpOpePags")
                    loc_cCli = PADR(ALLTRIM(TmpOpePags.IClis) + " - " + ;
                                    ALLTRIM(TmpOpePags.RClis), 31)
                    INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cCli + " " + TmpOpePags.Notas)
                ENDIF

                IF THIS.this_lVends
                    SELECT TmpOpePags
                    GO TOP IN TmpOpePags
                    IF !EOF("TmpOpePags")
                        IF EMPTY(TmpOpePags.Vends)
                            loc_cVdd = ALLTRIM(TmpOpePags.IClis) + " - " + ALLTRIM(TmpOpePags.RClis)
                        ELSE
                            loc_cVdd = ALLTRIM(TmpOpePags.Vends) + " - " + ALLTRIM(TmpOpePags.NVends)
                        ENDIF
                        INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cVdd)
                    ENDIF
                ENDIF
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * PagtoXFpags - Secao Operacoes X Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PagtoXFpags()
        LOCAL loc_cVal, loc_lnTot, loc_lnGer

        SELECT Dopes, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Dopes ;
            ORDER BY Dopes ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO: OPERACOES X PAGAMENTOS ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnGer = 0
        SELECT TmpOperacoes
        SCAN
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes)

            SELECT DetFecCxs, RelFechas, FPags, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Dopes = TmpOperacoes.Dopes ;
                GROUP BY DetFecCxs, RelFechas, FPags ;
                ORDER BY FPags ;
                INTO CURSOR TmpFPags

            loc_lnTot = 0
            SELECT TmpFPags
            SCAN
                loc_lnGer = loc_lnGer + IIF(RelFechas=4, 0, TmpFPags.Valos)
                loc_lnTot = loc_lnTot + IIF(RelFechas=4, 0, TmpFPags.Valos)

                loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpFPags.FPags + " : " + loc_cVal)

                IF TmpFPags.DetFecCxs = 1 AND TmpFPags.RelFechas = 3
                    SELECT Notas, FPags, SUM(ValPagos) AS ValPagos, ;
                           Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND FPags = TmpFPags.FPags ;
                        GROUP BY Notas, FPags, Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        ORDER BY Notas ;
                        INTO CURSOR TmpOpeChqs

                    SELECT TmpOpeChqs
                    SCAN
                        IF !EMPTY(TmpOpeChqs.Outros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + TmpOpeChqs.Outros + " " + loc_cVal)
                        ENDIF

                        IF !EMPTY(TmpOpeChqs.Numeros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "99,999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + DTOC(TmpOpeChqs.Vencs) + " " + ;
                                TmpOpeChqs.Numeros + " " + loc_cVal)
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("      SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnGer, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("  TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResumoPagto - Secao Resumo Por Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResumoPagto()
        LOCAL loc_cVal, loc_lnTot

        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO POR FORMAS DE PAGAMENTO ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")

        *-- Subtotal especifico VALE + DINHEIRO + TROCO
        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            WHERE RelFechas = 4 OR INLIST(FPags, "DINHEIRO    ", "TROCO       ") ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL ESPECIE: " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResVends - Secao Resumo Por Vendedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResVends()
        LOCAL loc_cVal, loc_lnTot

        SELECT Vends, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Vends ;
            ORDER BY Vends ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("========= RESUMO POR VENDEDOR ==========")

        loc_lnTot = 0
        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Vends + ;
                "            : " + loc_cVal)

            SELECT Dopes, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = TmpOperacoes.Vends ;
                GROUP BY Dopes ;
                ORDER BY Dopes ;
                INTO CURSOR TmpDopes

            SELECT TmpDopes
            SCAN
                loc_cVal = TRANSFORM(TmpDopes.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("   " + TmpDopes.Dopes + " : " + loc_cVal)
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL:            " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * AnaFPags - Secao Analitico Por Pagamentos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AnaFPags()
        LOCAL loc_cVal, loc_lnTot, loc_lnSub

        INSERT INTO crImpressao (Detalhe) VALUES ("======= ANALITICO POR PAGAMENTOS =======")

        SELECT DISTINCT FPags ;
            FROM crDetalhe ;
            ORDER BY FPags ;
            INTO CURSOR TmpFPags

        loc_lnTot = 0

        SELECT TmpFPags
        SCAN
            SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
                   RPags, RChqs, RelFechas, Vends, Notas, Parcs, ;
                   ValPagos, Contas, Numeros, Vencs ;
                FROM crDetalhe ;
                WHERE FPags = TmpFPags.FPags ;
                ORDER BY FPags, Vends, Notas, Parcs ;
                INTO CURSOR TmpOpePags

            loc_lnSub = 0

            SELECT TmpOpePags
            SCAN
                loc_lnTot = loc_lnTot + TmpOpePags.ValPagos
                loc_lnSub = loc_lnSub + TmpOpePags.ValPagos

                loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999.99")

                IF TmpOpePags.Parcs = 1
                    INSERT INTO crImpressao (Detalhe) VALUES (PADR(TmpOpePags.FPags, 10) + " " + ;
                        PADR(TmpOpePags.Vends, 9) + TmpOpePags.Notas + ;
                        "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ELSE
                    INSERT INTO crImpressao (Detalhe) VALUES ("                    " + ;
                        TmpOpePags.Notas + "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ENDIF

                IF !EMPTY(TmpOpePags.Numeros)
                    INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                        TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                        "  " + DTOC(TmpOpePags.Vencs))
                ENDIF

                IF !EMPTY(TmpOpePags.RPags)
                    INSERT INTO crImpressao (Detalhe) VALUES ("        " + TmpOpePags.RPags)

                    IF !EMPTY(TmpOpePags.RChqs)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + TmpOpePags.RChqs)
                    ENDIF
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnSub, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("=              SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
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

        *-- Isolamento de locale + modo de renderizacao (Erro28)
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

    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                THIS.ExecutarReportForm("RelSigReFec", "PRINTER_PROMPT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                THIS.ExecutarReportForm("RelSigReFec", "PREVIEW")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE
