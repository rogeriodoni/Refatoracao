*==============================================================================
* SIGREFCDBO.PRG
* Business Object para Relatorio de Informativo de Vendas Diarias (SIGREFCD)
*
* Herda de RelatorioBase
* Referencia legado: sigrefcd.SCX (frmrelatorio)
* Caption original: "Informativo de Vendas Diarias"
*==============================================================================

DEFINE CLASS sigrefcdBO AS RelatorioBase

    *-- Filtros do relatorio (mapeados dos campos get_* do legado)
    this_cCodEmpresa      = ""   && get_cd_empresa  - codigo da empresa (max 3 chars)
    this_cRazaEmpresa     = ""   && get_ds_empresa  - razao social da empresa (max 40 chars)
    this_dDtInicial       = {}   && get_dt_inicial  - data inicial do periodo
    this_dDtFinal         = {}   && get_dt_final    - data final do periodo

    *-- Variaveis de resultado mapeadas das PUBLIC vars do legado
    *-- (m.reslanca, m.resforma, m.rescheque, m.rescartao, m.resvende,
    *--  m.resconta, m.reslanfor, m.resqtdes, m.ResvDets)
    this_lResLanca        = .F.
    this_lResForma        = .F.
    this_lResCheque       = .F.
    this_lResCartao       = .F.
    this_lResVende        = .F.
    this_lResConta        = .F.
    this_lResLanFor       = .F.
    this_lResQtdes        = .F.
    this_lResvDets        = .F.

    *-- Configuracao do relatorio
    this_cTituloRelatorio = ""
    this_cArquivoFRX      = ""
    this_cMensagemErro    = ""

    *--------------------------------------------------------------------------
    * Init - Configura titulo, FRX e carrega cursores auxiliares do legado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            IF loc_lSucesso
                THIS.this_cTituloRelatorio = "Informativo de Vendas Di" + CHR(225) + "rias"
                THIS.this_cArquivoFRX      = "SigReFcD"

                *-- Cursor auxiliar de tomadores (usado pelo FRX)
                CREATE CURSOR csSigCdTom (Marca n(1), Descri c(40), Codigos n(2))
                INDEX ON Codigos TAG Codigos

                *-- Cursor de movimento (reutilizado a cada PrepararDados)
                CREATE CURSOR crMovimento (Datas t, Valor N(13,2))
                INDEX ON Datas TAG Datas

                *-- Carrega parametros de operacoes de fechamento (SigCdPam)
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "CrSigCdPam")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                    loc_lSucesso = .F.
                ELSE
                    *-- Carrega formas de pagamento (SigOpFp)
                    loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigOpFp", "CrSigOpFp")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao carregar SigOpFp"
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todas as queries e monta cursores para o relatorio
    * Replica logica do PROCEDURE processamento do legado sigrefcd.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_lcEmp, loc_lcOperacao, loc_lcConserto
        LOCAL loc_lcCbEmp, loc_lcTitulo, loc_lcPeriodo
        LOCAL loc_lcEnd1, loc_lcEnd2, loc_lcEnd3
        LOCAL loc_lcQuery
        LOCAL loc_lnValor, loc_lnValPr
        LOCAL pDtI, pDtF, pDtH

        loc_lSucesso = .F.

        TRY
            loc_lcEmp = ALLTRIM(THIS.this_cCodEmpresa)

            *-- Busca dados cadastrais da empresa selecionada
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, endes, numeros, bairs, ceps, cidas, estas, cgcs " + ;
                "FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_lcEmp), ;
                "crSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar dados da empresa"
                loc_lSucesso = .F.
            ENDIF

            *-- Monta strings do cabecalho do relatorio
            SELECT crSigCdEmp
            loc_lcCbEmp   = loc_lcEmp + "-" + ALLTRIM(crSigCdEmp.razas)
            loc_lcTitulo  = "Fechamento de Venda Di" + CHR(225) + "ria"
            loc_lcPeriodo = "Per" + CHR(237) + "odo : " + ;
                            DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal)
            loc_lcEnd1    = ALLTRIM(crSigCdEmp.endes) + " " + ;
                            ALLTRIM(crSigCdEmp.numeros) + " - " + ;
                            ALLTRIM(crSigCdEmp.bairs)
            loc_lcEnd2    = ALLTRIM(crSigCdEmp.ceps) + " " + ;
                            ALLTRIM(crSigCdEmp.cidas) + " " + ;
                            ALLTRIM(crSigCdEmp.estas)
            loc_lcEnd3    = ALLTRIM(crSigCdEmp.cgcs)

            *-- Cursor de cabecalho para o FRX
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho ;
                (empresa c(240), titulo c(240), End1 c(240), ;
                 End2 c(240), End3 c(240), PERIODO c(80))
            INSERT INTO csCabecalho ;
                (empresa, titulo, End1, End2, End3, Periodo) ;
                VALUES (loc_lcCbEmp, loc_lcTitulo, loc_lcEnd1, ;
                        loc_lcEnd2, loc_lcEnd3, loc_lcPeriodo)

            *-- Variaveis de data parametrizadas para SQLEXEC com ?pDtI/?pDtF
            pDtI = DATETIME(YEAR(THIS.this_dDtInicial), ;
                            MONTH(THIS.this_dDtInicial), ;
                            DAY(THIS.this_dDtInicial), 0, 0, 0)
            pDtF = DATETIME(YEAR(THIS.this_dDtFinal), ;
                            MONTH(THIS.this_dDtFinal), ;
                            DAY(THIS.this_dDtFinal), 23, 59, 59)
            pDtH = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

            *-- Obtem operacao de fechamento configurada em SigCdPam
            SELECT CrSigCdPam
            GO TOP
            IF !EOF()
                loc_lcOperacao = ALLTRIM(CrSigCdPam.dopes)
                loc_lcConserto = ALLTRIM(CrSigCdPam.opconsers)
            ELSE
                loc_lcOperacao = ""
                loc_lcConserto = ""
            ENDIF

            IF EMPTY(loc_lcOperacao)
                MsgAviso("N" + CHR(227) + "o existe movimenta" + CHR(231) + ;
                         CHR(227) + "o de fechamento configurada!!!", "Aviso")
            ENDIF

            WAIT WINDOW "Aguarde..." NOWAIT NOCLEAR

            *-- Query 1: dados de vendas gerais (csDadosV)
            *-- Inclui movimentos excluindo fpags especificos (garantia, cortesia, etc.)
            loc_lcQuery = ;
                "SELECT case when g.tipoops = 5 then 'M' else d.Infos end as Infos, " + ;
                "c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, " + ;
                "c.cidchaves as chaPar, c.fpags, d.fparcs, c.moefpgs, " + ;
                "case when g.tipoops = 5 then (c.valos*c.cotfpgs) * -1 " + ;
                "     else (c.valos*c.cotfpgs) end as valos, " + ;
                "case when g.tipoops = 5 then c.valos * -1 else c.valos end as valosM, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "g.tipoops = h.codigos AND " + ;
                "h.gergdmis = 1 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.dopes = g.dopes AND " + ;
                "c.fpags NOT IN ('garantia','cortesia','pag efetuado'," + ;
                "'aberto r','credito loja','dev loja') " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosV")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de vendas (csDadosV)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: vendas com pagamento efetuado/aberto r (csDadosP)
            loc_lcQuery = ;
                "SELECT d.Infos, c.datas, c.Emps, c.Dopes, c.Numes, " + ;
                "c.empdopnums, c.cidchaves as chaPar, c.fpags, " + ;
                "(c.valos*c.cotfpgs) as valos, d.fparcs, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "g.tipoops = h.codigos AND " + ;
                "h.gergdmis = 1 AND " + ;
                "g.tipoops <> 5 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos AND " + ;
                "g.opers <> 1 AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.dopes = g.dopes AND " + ;
                "c.fpags IN ('pag efetuado','aberto r') " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosP")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de pagamentos (csDadosP)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Query 3: recebimentos (csDadosR)
            loc_lcQuery = ;
                "SELECT DISTINCT d.infos, c.datas, c.Emps, c.Dopes, c.Numes, " + ;
                "c.empdopnums, c.cidchaves as chaPar, c.fpags, " + ;
                "(c.valos*c.cotfpgs) as valos, d.fparcs, " + ;
                "c.valos as valosM, c.moefpgs, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM SigMvccr a, sigmvPar c, sigcdope g, sigcdtom h, " + ;
                "sigopfp d, sigprinf e " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "c.dopes = g.dopes AND " + ;
                "c.dopes = 'RECEBIMENTO' AND " + ;
                "c.nopers = a.nopers AND " + ;
                "g.tipoops = h.codigos AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosR")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de recebimentos (csDadosR)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Agrupa csDadosV por datas/chapar -> Curv
            SELECT chapar, Datas, ;
                MAX(Emps) AS Emps, MAX(valos) AS valos, MAX(fparcs) AS fparcs, ;
                MAX(Info) AS Info, MAX(formas) AS formas, MAX(valpends) AS valpends, ;
                MAX(bandeira) AS bandeira, MAX(adquirente) AS adquirente, ;
                MAX(valosM) AS valosM, MAX(moefpgs) AS moefpgs, MAX(Infos) AS Infos ;
                FROM csDadosV GROUP BY Datas, chapar INTO CURSOR Curv

            *-- Cursor vazio Curr com mesma estrutura de csDadosR
            SELECT chapar, Datas, ;
                MAX(Emps) AS Emps, MAX(valos) AS valos, MAX(fparcs) AS fparcs, ;
                MAX(Info) AS Info, MAX(formas) AS formas, MAX(valpends) AS valpends, ;
                MAX(bandeira) AS bandeira, MAX(adquirente) AS adquirente, ;
                MAX(valosM) AS valosM, MAX(moefpgs) AS moefpgs, MAX(Infos) AS Infos ;
                FROM csDadosR WHERE 0=1 GROUP BY Datas, chapar INTO CURSOR Curr

            *-- UNION: categoriza valores em valAv (a vista), valFin (financiado), valRec (recebimento)
            SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                valos AS valAv, ;
                CAST(0.00 AS numeric(11,2)) AS valFin, ;
                CAST(0.00 AS numeric(11,2)) AS valRec ;
                FROM Curv WHERE fparcs = 1 ;
                UNION ;
                SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                CAST(0.00 AS numeric(11,2)) AS valAv, ;
                valos AS valFin, ;
                CAST(0.00 AS numeric(11,2)) AS valRec ;
                FROM Curv WHERE !(fparcs = 1) ;
                UNION ;
                SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                CAST(0.00 AS numeric(11,2)) AS valAv, ;
                CAST(0.00 AS numeric(11,2)) AS valFin, ;
                valos AS valRec ;
                FROM Curr ;
                INTO CURSOR Curt

            *-- Consolida por Infos/Datas/Emps
            SELECT Infos, Datas, Emps, ;
                SUM(valAv) AS valAv, SUM(valFin) AS valFin, SUM(valRec) AS valRec ;
                FROM Curt GROUP BY Datas, Infos, Emps INTO CURSOR curPag

            *-- Adiciona colunas de totalizacao
            SELECT *, valAv + valFin AS valVenda, valAv + valFin + valRec AS valTot ;
                FROM curPag INTO CURSOR curPag

            *-- Totais gerais
            SELECT SUM(valAv) AS valAv, SUM(valFin) AS valFin, ;
                SUM(valRec) AS valRec, SUM(valVenda) AS valVenda, ;
                SUM(valTot) AS valTot ;
                FROM curPag INTO CURSOR curPagT

            *-- Garante crMovimento disponivel e vazio
            IF !USED("crMovimento")
                CREATE CURSOR crMovimento (Datas t, Valor N(13,2))
                INDEX ON Datas TAG Datas
            ENDIF
            ZAP IN crMovimento

            *-- Processa cada linha de curPag aplicando percentuais de SigEmInf
            SELECT curPag
            GO TOP
            SCAN
                *-- Busca percentual por empresa/tipo de informacao
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT PercEmps FROM SigEmInf " + ;
                    "WHERE Emps = '" + ALLTRIM(curPag.Emps) + "'" + ;
                    " AND Infos = '" + ALLTRIM(curPag.Infos) + "'", ;
                    "crInfos")

                loc_lnValor = curPag.valTot

                *-- Aplica percentual se existir configuracao em SigEmInf
                IF loc_nResult > 0
                    SELECT crInfos
                    IF RECCOUNT("crInfos") > 0
                        loc_lnValPr = 0
                        SELECT crInfos
                        SCAN
                            loc_lnValPr = loc_lnValPr + ;
                                          ((loc_lnValor / 100) * crInfos.PercEmps)
                        ENDSCAN
                        loc_lnValor = loc_lnValPr
                    ENDIF
                ENDIF
                IF USED("crInfos")
                    USE IN crInfos
                ENDIF

                *-- Acumula no cursor de movimento
                SELECT crMovimento
                APPEND BLANK
                REPLACE Datas WITH curPag.Datas, ;
                        Valor WITH loc_lnValor IN crMovimento

                SELECT curPag
            ENDSCAN

            *-- Agrega movimento por data (consolida multiplas empresas/tipos)
            SELECT crMovimento
            SELECT datas, SUM(valor) AS Valor ;
                FROM crMovimento GROUP BY datas INTO CURSOR csMovimento READWRITE

            *-- Reconstroi crMovimento com dados consolidados
            ZAP IN crMovimento

            SELECT csMovimento
            GO TOP
            SCAN
                SELECT crMovimento
                APPEND BLANK
                REPLACE Datas WITH csMovimento.Datas, ;
                        Valor WITH csMovimento.Valor IN crMovimento
                SELECT csMovimento
            ENDSCAN

            IF USED("csMovimento")
                USE IN csMovimento
            ENDIF

            *-- Posiciona em crMovimento para o FRX
            SELECT crMovimento
            GO TOP

            WAIT CLEAR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio (com dialogo de impressora)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM SigReFcD TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM SigReFcD PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Operacoes CRUD - NAO APLICAVEIS a este BO
    * Este BO herda de RelatorioBase (formulario frmrelatorio).
    * Relatorios apenas leem dados para imprimir/visualizar via PrepararDados().
    * Os metodos abaixo existem apenas para satisfazer contratos genericos e
    * sinalizar explicitamente que a operacao nao se aplica a relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + ;
                                  CHR(227) + "o aplic" + CHR(225) + "vel: " + ;
                                  "relat" + CHR(243) + "rio n" + CHR(227) + ;
                                  "o carrega registro para edi" + CHR(231) + ;
                                  CHR(227) + "o."
        RETURN .F.
    ENDPROC

    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inserir " + ;
                                  "n" + CHR(227) + "o se aplica a relat" + ;
                                  CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Atualizar " + ;
                                  "n" + CHR(227) + "o se aplica a relat" + ;
                                  CHR(243) + "rios."
        RETURN .F.
    ENDPROC

ENDDEFINE
