*==============================================================================
* SIGREAEGBO.PRG
* BO do Relatorio: Analise de Estoque por Grande Grupo
*
* Herda de: RelatorioBase
* Origem: SIGREAEG.SCX (frmrelatorio)
* Relatorios FRX: SigReAe1.frx (principal), SigReAe2.frx (divergencias)
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Grupo de Estoque / conta (codigo + descricao)
*   - Grande Grupo (codigo + descricao via SigCdGpr)
*   - Periodo (data inicial e data final)
*
* Cursores de referencia carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas)
*   cursor_4c_SigCdGrp  - grupos de estoque (cgrus, mercs, cestoqs)
*
* Validacoes antes de processar (implementadas no Form - BtnClick):
*   - Grupo de Estoque: SigCdGcr.codigos
*   - Conta de Estoque: SigCdCli.iclis
*   - Grande Grupo: SigCdGpr.codigos
*   - Data inicial e final nao podem estar em branco
*   - Data final >= data inicial
*==============================================================================

DEFINE CLASS SIGREAEGBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""
    this_cCdGGrupo      = ""
    this_cDsGGrupo      = ""
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
            loc_lSucesso = .T.

            *-- Carregar empresas (usadas em Processamento e Processa)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp", ;
                "cursor_4c_SigCdEmp")
            IF loc_nResult >= 1
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps
                GO TOP
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar cadastro de empresas"
            ENDIF

            *-- Carregar grupos de estoque (usados em Processa via SEEK)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cgrus, mercs, cestoqs FROM SigCdGrp", ;
                "cursor_4c_SigCdGrp")
            IF loc_nResult >= 1
                SELECT cursor_4c_SigCdGrp
                INDEX ON cgrus TAG cgrus
                GO TOP
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar grupos de estoque"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREAEGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Coordena o processamento completo dos dados do relatorio
    * Equivalente ao procedimento "processamento" do formulario original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrupo
        LOCAL loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, loc_cPeriodo
        LOCAL loc_cCodEmpAtual, loc_lInicio, loc_lProcessa

        loc_lSucesso   = .F.
        loc_cEmpresa   = ALLTRIM(THIS.this_cEmpresa)
        loc_cGrupo     = ALLTRIM(THIS.this_cCdGrEstoque)
        loc_cEstoque   = ALLTRIM(THIS.this_cCdEstoque)
        loc_cGGrupo    = ALLTRIM(THIS.this_cCdGGrupo)
        loc_dDtInicial = THIS.this_dDtInicial
        loc_dDtFinal   = THIS.this_dDtFinal

        TRY
            *-- Montar cabecalho do relatorio
            loc_cTitulo1 = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
            loc_cTitulo2 = "Grupo: " + ;
                IIF(EMPTY(loc_cGrupo), "Todos", ;
                    ALLTRIM(loc_cGrupo) + " - " + ALLTRIM(THIS.this_cDsGrEstoque)) + ;
                " / Estoque: " + ;
                IIF(EMPTY(loc_cEstoque), "Todos", ;
                    ALLTRIM(loc_cEstoque) + " - " + ALLTRIM(THIS.this_cDsEstoque)) + ;
                " / Grande Grupo: " + ;
                IIF(EMPTY(loc_cGGrupo), "Todos", ALLTRIM(loc_cGGrupo))

            loc_cCodEmpAtual = go_4c_Sistema.cCodEmpresa
            IF SEEK(loc_cCodEmpAtual, "cursor_4c_SigCdEmp", "cemps")
                loc_cNomeEmpresa = ALLTRIM(loc_cCodEmpAtual) + " - " + ALLTRIM(cursor_4c_SigCdEmp.razas)
            ELSE
                loc_cNomeEmpresa = ALLTRIM(loc_cCodEmpAtual)
            ENDIF
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(loc_dDtFinal)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (nomeempresa c(80), titulo1 c(80), titulo2 c(150), periodo c(80))
            INSERT INTO CsCabecalho (nomeempresa, titulo1, titulo2, periodo) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, loc_cPeriodo)

            *-- Processar por empresa(s)
            IF EMPTY(loc_cEmpresa)
                loc_lInicio = .T.
                WAIT WINDOW "Verificando as empresas..." NOWAIT
                SELECT cursor_4c_SigCdEmp
                GO TOP
                SCAN
                    IF cursor_4c_SigCdEmp.ativas = 1
                        IF !THIS.ProcessarEmpresa(cursor_4c_SigCdEmp.cemps, ;
                                loc_cGrupo, loc_cEstoque, loc_cGGrupo)
                            THIS.this_cMensagemErro = "Erro ao processar empresa " + ;
                                ALLTRIM(cursor_4c_SigCdEmp.cemps)
                            loc_lSucesso = .F.
                        ENDIF
                        IF loc_lInicio
                            SELECT * FROM CsRel INTO CURSOR CsRelatorio READWRITE
                            SELECT * FROM CsDif INTO CURSOR CsDiferenca READWRITE
                            loc_lInicio = .F.
                        ELSE
                            SELECT CsRel
                            SCAN
                                SCATTER MEMVAR MEMO
                                INSERT INTO CsRelatorio FROM MEMVAR
                            ENDSCAN
                            SELECT CsDif
                            SCAN
                                SCATTER MEMVAR MEMO
                                INSERT INTO CsDiferenca FROM MEMVAR
                            ENDSCAN
                        ENDIF
                    ENDIF
                ENDSCAN
                WAIT CLEAR
            ELSE
                loc_lProcessa = THIS.ProcessarEmpresa(loc_cEmpresa, loc_cGrupo, ;
                                                      loc_cEstoque, loc_cGGrupo)
                IF !loc_lProcessa
                    loc_lSucesso = .F.
                ENDIF
                WAIT WINDOW "Aguarde a emiss" + CHR(227) + "o do relat" + CHR(243) + "rio..." NOWAIT
                SELECT * FROM CsRel INTO CURSOR CsRelatorio READWRITE
                SELECT * FROM CsDif INTO CURSOR CsDiferenca READWRITE
                WAIT CLEAR
            ENDIF

            SELECT CsDiferenca
            INDEX ON emps + dopes + STR(numes) TAG EmpDopNums
            GO TOP

            SELECT CsRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpresa - Executa o processamento completo de uma empresa
    * Equivalente ao procedimento "processa" do formulario original
    * par_cEmpEst  - Codigo da empresa (3 chars)
    * par_cGruEst  - Codigo do grupo de estoque (pode ser vazio)
    * par_cEstEst  - Codigo da conta de estoque (pode ser vazio)
    * par_cGGrupo  - Codigo do grande grupo (pode ser vazio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEmpresa(par_cEmpEst, par_cGruEst, par_cEstEst, par_cGGrupo)
        LOCAL loc_lSucesso
        LOCAL loc_cEmpEst, loc_cGruEst, loc_cEstEst, loc_cGGrupo
        LOCAL loc_dDtInicial, loc_dDtFinal, loc_dDtAnt
        LOCAL loc_tDtIni, loc_tDtFin, loc_tDtAnt
        LOCAL loc_cFiltro, loc_cQuery, loc_nResult
        LOCAL loc_cEGEs, loc_cEDNs, loc_cDopps
        LOCAL loc_cEmpIni, loc_cEmpFin, loc_cGruIni, loc_cGruFin, loc_cEstIni, loc_cEstFin
        LOCAL loc_nSQtds, loc_lnSldIni, loc_lnSldFin, loc_lFirst
        LOCAL loc_llOrigem, loc_llDestino, loc_cOpers, loc_cGGrpLocal

        loc_lSucesso = .F.
        TRY
            loc_cEmpEst    = PADR(ALLTRIM(par_cEmpEst), 3)
            loc_cGruEst    = PADR(ALLTRIM(par_cGruEst), 10)
            loc_cEstEst    = PADR(ALLTRIM(par_cEstEst), 10)
            loc_cGGrupo    = PADR(ALLTRIM(par_cGGrupo), 3)
            loc_dDtInicial = THIS.this_dDtInicial
            loc_dDtFinal   = THIS.this_dDtFinal
            loc_dDtAnt     = loc_dDtInicial - 1
            loc_tDtIni     = CTOT(DTOC(loc_dDtInicial) + " 00:00:00")
            loc_tDtFin     = CTOT(DTOC(loc_dDtFinal) + " 23:59:59")
            loc_tDtAnt     = CTOT(DTOC(loc_dDtAnt) + " 23:59:59")

            *-- Limpar cursores de trabalho anteriores
            IF USED("CrSigMvHst")
                USE IN CrSigMvHst
            ENDIF
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            IF USED("CsMov")
                USE IN CsMov
            ENDIF
            IF USED("CsPrd")
                USE IN CsPrd
            ENDIF
            IF USED("CsRel")
                USE IN CsRel
            ENDIF
            IF USED("TmpEstoque")
                USE IN TmpEstoque
            ENDIF

            *-- Criar cursores de trabalho
            CREATE CURSOR CrSigMvHst (Emps c(3), Grupos c(10), Estos c(10), Dopes c(20), ;
                Numes n(6,0), CPros c(14), Datas t NULL, Qtds n(12,3), ;
                Opers c(1), SQtds n(12,3), EmpGruEsts c(23), CIdChaves c(20))

            CREATE CURSOR TmpEst (CIdChaves c(20), Emps c(3), Grupos c(10), Estos c(10), ;
                CPros c(14), SalIni n(16,3), SalAtu n(16,3), GGrupo c(3))

            CREATE CURSOR CsMov (emps c(3), ggrupo c(3), dopes c(20), numes n(6,0), ;
                opers c(1), cpros c(14), qtds n(12,3), Pesos n(9,3))

            CREATE CURSOR CsPrd (emps c(3), ggrupo c(3), dopes c(20), numes n(6,0), ;
                opers c(1), qtds n(12,3))

            CREATE CURSOR CsRel (emps c(3), ggrupo c(3), dopes c(20), sldini n(12,3), ;
                entmov n(12,3), saimov n(12,3), salmov n(12,3), ;
                enthis n(12,3), saihis n(12,3), salhis n(12,3), ;
                sldfin n(12,3), difs n(12,3), PesoEs n(12,3), PesoSs n(12,3))

            *-- Montar lista de combinacoes Emps+Grupos+Estos a processar
            IF !EMPTY(ALLTRIM(loc_cGruEst)) AND !EMPTY(ALLTRIM(loc_cEstEst))
                CREATE CURSOR TmpEstoque (Emps c(3), Grupos c(10), Estos c(10))
                INSERT INTO TmpEstoque (Emps, Grupos, Estos) ;
                    VALUES (loc_cEmpEst, loc_cGruEst, loc_cEstEst)
            ELSE
                loc_cQuery = "SELECT Emps, Grupos, Estos FROM SigMvEst " + ;
                             "WHERE Emps = '" + ALLTRIM(loc_cEmpEst) + "'" + ;
                             IIF(!EMPTY(ALLTRIM(loc_cGruEst)), ;
                                 " AND Grupos = '" + ALLTRIM(loc_cGruEst) + "'", "") + ;
                             IIF(!EMPTY(ALLTRIM(loc_cEstEst)), ;
                                 " AND Estos = '" + ALLTRIM(loc_cEstEst) + "'", "") + ;
                             " GROUP BY Emps, Grupos, Estos ORDER BY Emps, Grupos, Estos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEstoque")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (TmpEstoque)"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
            SELECT TmpEstoque
            INDEX ON Emps + Grupos + Estos TAG EmpGruEsts
            GO TOP

            *-- Montar filtro SQL para selecao de produtos por estoque
            IF !EMPTY(ALLTRIM(loc_cEmpEst)) AND !EMPTY(ALLTRIM(loc_cGruEst)) AND !EMPTY(ALLTRIM(loc_cEstEst))
                loc_cFiltro = "a.empgruests = '" + loc_cEmpEst + loc_cGruEst + loc_cEstEst + "'"
            ELSE
                loc_cEmpIni = IIF(!EMPTY(ALLTRIM(loc_cEmpEst)), loc_cEmpEst, SPACE(3))
                loc_cEmpFin = IIF(!EMPTY(ALLTRIM(loc_cEmpEst)), loc_cEmpEst, REPLICATE(CHR(254), 3))
                loc_cGruIni = IIF(!EMPTY(ALLTRIM(loc_cGruEst)), loc_cGruEst, SPACE(10))
                loc_cGruFin = IIF(!EMPTY(ALLTRIM(loc_cGruEst)), loc_cGruEst, REPLICATE(CHR(254), 10))
                loc_cEstIni = IIF(!EMPTY(ALLTRIM(loc_cEstEst)), loc_cEstEst, SPACE(10))
                loc_cEstFin = IIF(!EMPTY(ALLTRIM(loc_cEstEst)), loc_cEstEst, REPLICATE(CHR(254), 10))
                loc_cFiltro = "a.empgruests BETWEEN '" + ;
                              loc_cEmpIni + loc_cGruIni + loc_cEstIni + ;
                              "' AND '" + ;
                              loc_cEmpFin + loc_cGruFin + loc_cEstFin + "'"
            ENDIF

            *-- Selecionar produtos dos estoques (join SigMvEst + SigCdPro + SigCdGrp)
            WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT
            loc_cQuery = "SELECT a.cIdChaves, a.Emps, a.Grupos, a.Estos, a.Cpros, " + ;
                         "c.Mercs AS GGrupo " + ;
                         "FROM SigMvEst a, SigCdPro b, SigCdGrp c " + ;
                         "WHERE " + loc_cFiltro + ;
                         " AND b.Cpros = a.Cpros AND c.Cgrus = b.Cgrus " + ;
                         IIF(EMPTY(ALLTRIM(loc_cGGrupo)), "", ;
                             "AND c.Mercs = '" + ALLTRIM(loc_cGGrupo) + "' ") + ;
                         "GROUP BY a.cIdChaves, a.Emps, a.Grupos, a.Estos, a.Cpros, c.Mercs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpSigMvEst")
            IF loc_nResult < 1
                MsgAviso("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (TmpSigMvEst)")
                loc_lSucesso = .F.
            ENDIF

            SELECT TmpEst
            ZAP IN TmpEst
            SELECT TmpSigMvEst
            GO TOP
            SCAN
                SCATTER MEMVAR
                m.SalIni = 0
                m.SalAtu = 0
                INSERT INTO TmpEst FROM MEMVAR
            ENDSCAN
            IF USED("TmpSigMvEst")
                USE IN TmpSigMvEst
            ENDIF
            WAIT CLEAR

            *-- Preparar TmpEst para busca de saldos
            SELECT TmpEst
            INDEX ON Emps + Grupos + Estos + CPros + GGrupo TAG EmpProGG
            GO TOP

            *-- Carregar historico ate a data final para cada estoque
            WAIT WINDOW "Selecionando Hist" + CHR(243) + "ricos..." NOWAIT
            SELECT TmpEstoque
            GO TOP
            SCAN
                loc_cEGEs = PADR(TmpEstoque.Emps, 3) + PADR(TmpEstoque.Grupos, 10) + ;
                            PADR(TmpEstoque.Estos, 10)
                loc_cQuery = "SELECT Emps, Grupos, Estos, CPros, Dopes, Numes, Datas, Qtds, " + ;
                             "Opers, SQtds, EmpGruEsts, CIdChaves " + ;
                             "FROM SigMvHst " + ;
                             "WHERE EmpGruEsts = " + EscaparSQL(loc_cEGEs) + " AND Datas <= ?loc_tDtFin " + ;
                             "ORDER BY Emps, Grupos, Estos, CPros, CIdChaves"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "CsHis")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsHis
                GO TOP
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO CrSigMvHst FROM MEMVAR
                ENDSCAN
                IF USED("CsHis")
                    USE IN CsHis
                ENDIF
                SELECT TmpEstoque
            ENDSCAN
            WAIT CLEAR

            SELECT CrSigMvHst
            INDEX ON EmpGruEsts TAG EmpGruEsts
            INDEX ON CPros TAG CPros
            INDEX ON EmpGruEsts + CPros + CIdChaves TAG EmpEstPro
            GO TOP

            *-- Calcular saldo anterior (antes da data inicial) por produto
            WAIT WINDOW "Verificando Saldo Anterior..." NOWAIT
            SELECT TmpEst
            GO TOP
            SCAN
                loc_nSQtds = 0
                loc_cEGEs  = TmpEst.Emps + TmpEst.Grupos + TmpEst.Estos
                IF USED("CrTmpHis")
                    USE IN CrTmpHis
                ENDIF
                SELECT TOP 1 Emps, Grupos, Estos, CPros, Datas, SQtds ;
                FROM CrSigMvHst ;
                WHERE EmpGruEsts = m.loc_cEGEs AND CPros = TmpEst.CPros AND Datas <= loc_tDtAnt ;
                ORDER BY CIdChaves DESC ;
                INTO CURSOR CrTmpHis READWRITE
                SELECT CrTmpHis
                GO TOP
                IF !EOF()
                    loc_nSQtds = CrTmpHis.SQtds
                ENDIF
                REPLACE SalIni WITH loc_nSQtds IN TmpEst
                SELECT TmpEst
            ENDSCAN
            WAIT CLEAR

            *-- Saldo inicial agregado por grande grupo
            SELECT Emps, GGrupo, MAX(Grupos) AS Grupos, MAX(Estos) AS Estos, SUM(SalIni) AS Saldo ;
            FROM TmpEst ;
            GROUP BY Emps, GGrupo ;
            INTO CURSOR csSaldoIni READWRITE
            SELECT csSaldoIni
            INDEX ON GGrupo TAG GGrupo
            GO TOP

            *-- Calcular saldo atual (no final do periodo) por produto
            WAIT WINDOW "Verificando Saldo Atual..." NOWAIT
            SELECT TmpEst
            GO TOP
            SCAN
                loc_nSQtds = 0
                loc_cEGEs  = TmpEst.Emps + TmpEst.Grupos + TmpEst.Estos
                IF USED("CrTmpHis")
                    USE IN CrTmpHis
                ENDIF
                SELECT TOP 1 Emps, Grupos, Estos, CPros, Datas, SQtds ;
                FROM CrSigMvHst ;
                WHERE EmpGruEsts = m.loc_cEGEs AND CPros = TmpEst.CPros AND Datas <= loc_tDtFin ;
                ORDER BY CIdChaves DESC ;
                INTO CURSOR CrTmpHis READWRITE
                SELECT CrTmpHis
                GO TOP
                IF !EOF()
                    loc_nSQtds = CrTmpHis.SQtds
                ENDIF
                SELECT TmpEst
                REPLACE TmpEst.salatu WITH loc_nSQtds
            ENDSCAN
            WAIT CLEAR

            *-- Saldo final agregado por grande grupo
            SELECT Emps, GGrupo, MAX(Grupos) AS Grupos, MAX(Estos) AS Estos, SUM(SalAtu) AS Saldo ;
            FROM TmpEst ;
            GROUP BY Emps, GGrupo ;
            INTO CURSOR csSaldoFin READWRITE
            SELECT csSaldoFin
            INDEX ON GGrupo TAG GGrupo
            GO TOP

            IF USED("CrTmpHis")
                USE IN CrTmpHis
            ENDIF

            *-- Selecionar movimentos do historico no periodo
            WAIT WINDOW "Aguarde! Analisando Estoque no Per" + CHR(237) + "odo..." NOWAIT
            SELECT Emps, Grupos, Estos, Dopes, Numes, CPros, Qtds, Opers, '   ' AS ggrupo ;
            FROM CrSigMvHst ;
            WHERE Datas BETWEEN loc_tDtIni AND loc_tDtFin ;
            ORDER BY Emps, Grupos, Estos, Dopes, Numes, CPros, Qtds, Opers ;
            INTO CURSOR TmpHis READWRITE
            WAIT CLEAR

            *-- Enriquecer TmpHis com GGrupo via SigCdPro + cursor_4c_SigCdGrp
            WAIT WINDOW "Verificando Grandes Grupos..." NOWAIT
            SELECT TmpHis
            GO TOP
            SCAN
                loc_cGGrpLocal = ''
                IF USED("TmpPro")
                    USE IN TmpPro
                ENDIF
                loc_cQuery = "SELECT cpros, cgrus FROM SigCdPro " + ;
                             "WHERE cpros = " + EscaparSQL(ALLTRIM(TmpHis.cpros))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpPro")
                IF loc_nResult >= 1
                    SELECT TmpPro
                    GO TOP
                    IF !EOF()
                        IF SEEK(TmpPro.cgrus, "cursor_4c_SigCdGrp", "cgrus")
                            loc_cGGrpLocal = cursor_4c_SigCdGrp.mercs
                        ENDIF
                    ENDIF
                ENDIF
                REPLACE GGrupo WITH loc_cGGrpLocal IN TmpHis
                SELECT TmpHis
            ENDSCAN
            IF USED("TmpPro")
                USE IN TmpPro
            ENDIF
            WAIT CLEAR

            *-- Agregar historico detalhado por Emps+GGrupo+Dopes+Numes
            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM TmpHis ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csHistorico READWRITE

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM TmpHis ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csHist READWRITE

            *-- Totais historicos por Emps+GGrupo+Dopes
            SELECT Emps, GGrupo, Dopes, SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas ;
            FROM csHist ;
            GROUP BY Emps, GGrupo, Dopes ;
            ORDER BY Emps, GGrupo, Dopes ;
            INTO CURSOR csTotHis READWRITE

            *-- Processar movimentos das contas de estoque no periodo
            WAIT WINDOW "Selecionando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT
            SELECT TmpEstoque
            GO TOP
            SCAN
                IF USED("TprMvCab")
                    USE IN TprMvCab
                ENDIF

                *-- Movimentos onde o estoque e origem
                loc_cQuery = "SELECT a.cidchaves, a.empdopnums, a.grupoos, a.grupods, " + ;
                             "a.contaos, a.contads, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests " + ;
                             "FROM SigMvCab a, SigCdOpe o " + ;
                             "WHERE a.emps = '" + ALLTRIM(TmpEstoque.Emps) + "' " + ;
                             "AND a.grupoos = '" + ALLTRIM(TmpEstoque.Grupos) + "' " + ;
                             "AND a.contaos = '" + ALLTRIM(TmpEstoque.Estos) + "' " + ;
                             "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                             "AND o.dopes = a.dopes AND o.estoqs = 1 " + ;
                             "ORDER BY a.cidchaves, a.empdopnums, o.opers, " + ;
                             "o.origems, o.destinos, o.estorigs, o.estdests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpMvO")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpMvO
                GO TOP

                *-- Movimentos onde o estoque e destino (nao transferencias)
                loc_cQuery = "SELECT a.cidchaves, a.empdopnums, a.grupoos, a.grupods, " + ;
                             "a.contaos, a.contads, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests " + ;
                             "FROM SigMvCab a, SigCdOpe o " + ;
                             "WHERE a.emps = '" + ALLTRIM(TmpEstoque.Emps) + "' " + ;
                             "AND a.grupods = '" + ALLTRIM(TmpEstoque.Grupos) + "' " + ;
                             "AND a.contads = '" + ALLTRIM(TmpEstoque.Estos) + "' " + ;
                             "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                             "AND o.dopes = a.dopes AND o.estoqs = 1 AND o.transs <> 1 " + ;
                             "ORDER BY a.cidchaves, a.empdopnums, o.opers, " + ;
                             "o.origems, o.destinos, o.estorigs, o.estdests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpMvD")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpMvD
                GO TOP

                *-- Transferencias onde o estoque e destino
                loc_cQuery = "SELECT a.cidchaves, a.empds, a.emps, a.dopes, a.numes, " + ;
                             "a.grupoos, a.grupods, a.contaos, a.contads, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests " + ;
                             "FROM SigMvCab a, SigCdOpe o " + ;
                             "WHERE a.empds = '" + ALLTRIM(TmpEstoque.Emps) + "' " + ;
                             "AND a.grupods = '" + ALLTRIM(TmpEstoque.Grupos) + "' " + ;
                             "AND a.contads = '" + ALLTRIM(TmpEstoque.Estos) + "' " + ;
                             "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                             "AND o.dopes = a.dopes AND o.estoqs = 1 AND o.transs = 1 " + ;
                             "ORDER BY a.cidchaves, a.empds, a.emps, a.dopes, a.numes, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTrf")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpTrf
                GO TOP

                *-- Unir origem + destino + transferencias em cursor de cabecalhos
                SELECT empdopnums, grupoos, grupods, contaos, contads, ;
                       opers, origems, destinos, estorigs, estdests ;
                FROM TmpMvO ;
                UNION ALL ;
                SELECT empdopnums, grupoos, grupods, contaos, contads, ;
                       opers, origems, destinos, estorigs, estdests ;
                FROM TmpMvD ;
                UNION ALL ;
                SELECT emps + dopes + STR(numes, 6) AS empdopnums, ;
                       grupoos, grupods, contaos, contads, ;
                       opers, origems, destinos, estorigs, estdests ;
                FROM TmpTrf ;
                INTO CURSOR CsEest READWRITE

                *-- Agrupar por documento (remover duplicatas por empdopnums)
                SELECT empdopnums, ;
                       MAX(grupoos) AS grupoos, MAX(grupods) AS grupods, ;
                       MAX(contaos) AS contaos, MAX(contads) AS contads, ;
                       MAX(opers) AS opers, MAX(origems) AS origems, ;
                       MAX(destinos) AS destinos, MAX(estorigs) AS estorigs, ;
                       MAX(estdests) AS estdests ;
                FROM CsEest ;
                GROUP BY empdopnums ;
                INTO CURSOR TprMvCab READWRITE

                *-- Processar cada documento para classificar movimentos E/S no estoque
                SELECT TprMvCab
                GO TOP
                SCAN
                    loc_cEDNs     = TprMvCab.empdopnums
                    loc_llOrigem  = .F.
                    loc_llDestino = .F.

                    *-- Determinar se documento envolve o estoque atual como origem ou destino
                    IF TprMvCab.estorigs = 4 OR TprMvCab.opers = 3
                        IF TprMvCab.origems = 1 AND ;
                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                           TprMvCab.contaos = TmpEstoque.Estos
                            loc_llOrigem = .T.
                        ELSE
                            IF TprMvCab.destinos = 1 AND ;
                               TprMvCab.grupods = TmpEstoque.Grupos AND ;
                               TprMvCab.contads = TmpEstoque.Estos
                                loc_llDestino = .T.
                            ENDIF
                        ENDIF
                    ELSE
                        IF TprMvCab.origems = 1 AND ;
                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                           TprMvCab.contaos = TmpEstoque.Estos
                            IF INLIST(TprMvCab.estorigs, 1, 2)
                                loc_llOrigem = .T.
                            ENDIF
                        ENDIF
                        IF TprMvCab.destinos = 1 AND ;
                           TprMvCab.grupods = TmpEstoque.Grupos AND ;
                           TprMvCab.contads = TmpEstoque.Estos
                            IF INLIST(TprMvCab.estdests, 1, 2)
                                loc_llDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF

                    IF !loc_llOrigem AND !loc_llDestino
                        LOOP
                    ENDIF

                    *-- Buscar itens do documento
                    IF USED("crLclMvItn")
                        USE IN crLclMvItn
                    ENDIF
                    loc_cQuery = "SELECT a.cidchaves, a.emps, a.dopes, a.numes, a.cpros, " + ;
                                 "a.opers, a.qtds, a.qtds * a.pesos AS Pesos, p.cgrus " + ;
                                 "FROM SigMvItn a, SigCdPro p " + ;
                                 "WHERE a.empdopnums = '" + ALLTRIM(loc_cEDNs) + "' " + ;
                                 "AND p.cpros = a.cpros " + ;
                                 "GROUP BY a.cidchaves, a.emps, a.dopes, a.numes, " + ;
                                 "a.cpros, a.opers, a.qtds, a.pesos, p.cgrus"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crLclMvItn")
                    IF loc_nResult < 1
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT crLclMvItn
                    GO TOP
                    SCAN
                        *-- Verificar se produto pertence a categoria de estoque (cestoqs=1)
                        IF !SEEK(crLclMvItn.cgrus, "cursor_4c_SigCdGrp", "cgrus")
                            LOOP
                        ENDIF
                        IF cursor_4c_SigCdGrp.cestoqs <> 1
                            LOOP
                        ENDIF
                        m.GGrupo   = cursor_4c_SigCdGrp.mercs
                        loc_cOpers = ' '

                        *-- Determinar E/S por tipo de operacao (estorigs=4 = especial)
                        IF TprMvCab.estorigs = 4
                            loc_llOrigem  = .F.
                            loc_llDestino = .F.
                            IF crLclMvItn.opers = 'S' AND ;
                               TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                               TprMvCab.contaos = TmpEstoque.Estos
                                loc_llOrigem = .T.
                                loc_cOpers   = 'S'
                            ELSE
                                IF crLclMvItn.opers = 'E' AND ;
                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                   TprMvCab.contads = TmpEstoque.Estos
                                    loc_llDestino = .T.
                                    loc_cOpers    = 'E'
                                ENDIF
                            ENDIF
                        ELSE
                            IF TprMvCab.opers = 3
                                *-- Transferencia: origens e destinos cruzados por empresa
                                IF TprMvCab.origems = 1
                                    IF SUBSTR(TprMvCab.empdopnums, 1, 3) = loc_cEmpEst
                                        IF crLclMvItn.opers = 'S' AND ;
                                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                           TprMvCab.contaos = TmpEstoque.Estos
                                            loc_llOrigem = .T.
                                            loc_cOpers   = 'S'
                                        ELSE
                                            IF crLclMvItn.opers = 'E' AND ;
                                               TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                               TprMvCab.contaos = TmpEstoque.Estos
                                                loc_llDestino = .T.
                                                loc_cOpers    = 'E'
                                            ELSE
                                                IF crLclMvItn.opers = 'S' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llOrigem = .T.
                                                    loc_cOpers   = 'S'
                                                ELSE
                                                    IF crLclMvItn.opers = 'E' AND ;
                                                       TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                       TprMvCab.contads = TmpEstoque.Estos
                                                        loc_llDestino = .T.
                                                        loc_cOpers    = 'E'
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ELSE
                                        IF crLclMvItn.opers = 'S' AND ;
                                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                           TprMvCab.contaos = TmpEstoque.Estos
                                            loc_llDestino = .T.
                                            loc_cOpers    = 'E'
                                        ELSE
                                            IF crLclMvItn.opers = 'E' AND ;
                                               TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                               TprMvCab.contaos = TmpEstoque.Estos
                                                loc_llOrigem = .T.
                                                loc_cOpers   = 'S'
                                            ELSE
                                                IF crLclMvItn.opers = 'S' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llDestino = .T.
                                                    loc_cOpers    = 'E'
                                                ELSE
                                                    IF crLclMvItn.opers = 'E' AND ;
                                                       TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                       TprMvCab.contads = TmpEstoque.Estos
                                                        loc_llOrigem = .T.
                                                        loc_cOpers   = 'S'
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ELSE
                                    IF TprMvCab.destinos = 1
                                        IF SUBSTR(TprMvCab.empdopnums, 1, 3) = loc_cEmpEst
                                            IF crLclMvItn.opers = 'S' AND ;
                                               TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                               TprMvCab.contads = TmpEstoque.Estos
                                                loc_llOrigem = .T.
                                                loc_cOpers   = 'S'
                                            ELSE
                                                IF crLclMvItn.opers = 'E' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llDestino = .T.
                                                    loc_cOpers    = 'E'
                                                ENDIF
                                            ENDIF
                                        ELSE
                                            IF crLclMvItn.opers = 'S' AND ;
                                               TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                               TprMvCab.contads = TmpEstoque.Estos
                                                loc_llDestino = .T.
                                                loc_cOpers    = 'E'
                                            ELSE
                                                IF crLclMvItn.opers = 'E' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llOrigem = .T.
                                                    loc_cOpers   = 'S'
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ELSE
                                *-- Operacao normal: estorigs/estdests definem E/S
                                IF loc_llOrigem AND TprMvCab.estorigs = 1
                                    loc_cOpers = 'E'
                                ELSE
                                    IF loc_llOrigem AND TprMvCab.estorigs = 2
                                        loc_cOpers = 'S'
                                    ELSE
                                        IF loc_llDestino AND TprMvCab.estdests = 1
                                            loc_cOpers = 'E'
                                        ELSE
                                            IF loc_llDestino AND TprMvCab.estdests = 2
                                                loc_cOpers = 'S'
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        IF loc_llOrigem OR loc_llDestino
                            SELECT crLclMvItn
                            SCATTER MEMVAR
                            m.emps  = loc_cEmpEst
                            m.opers = loc_cOpers
                            INSERT INTO CsMov FROM MEMVAR
                        ENDIF
                        SELECT crLclMvItn
                    ENDSCAN
                    SELECT TprMvCab
                ENDSCAN
                SELECT TmpEstoque
            ENDSCAN
            WAIT CLEAR

            SELECT CsMov
            GO TOP

            *-- Agregar movimentos de estoque por Emps+GGrupo+Dopes+Numes
            WAIT WINDOW "Aguarde! Analisando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds,  0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds,  0)) AS Saidas, ;
                   SUM(IIF(Opers = 'E', Pesos, 0)) AS PesoEs, ;
                   SUM(IIF(Opers = 'S', Pesos, 0)) AS PesoSs ;
            FROM CsMov ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csMovimento READWRITE

            SELECT csMovimento
            GO TOP

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds,  0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds,  0)) AS Saidas, ;
                   SUM(IIF(Opers = 'E', Pesos, 0)) AS PesoEs, ;
                   SUM(IIF(Opers = 'S', Pesos, 0)) AS PesoSs ;
            FROM CsMov ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csMovs READWRITE

            SELECT csMovs
            GO TOP

            SELECT Emps, GGrupo, Dopes, ;
                   SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas, ;
                   SUM(PesoEs) AS PesoEs, SUM(PesoSs) AS PesoSs ;
            FROM csMovs ;
            GROUP BY Emps, GGrupo, Dopes ;
            ORDER BY Emps, GGrupo, Dopes ;
            INTO CURSOR csTotMov READWRITE

            SELECT csTotMov
            GO TOP
            WAIT CLEAR

            *-- Selecionar producao - entradas (ENCERRAMENTO DIRETO)
            WAIT WINDOW "Aguarde! Selecionando Produ" + CHR(231) + CHR(227) + "o (Entradas)..." NOWAIT
            loc_cDopps = PADR('ENCERRAMENTO DIRETO', 20)
            IF USED("TmpPdE")
                USE IN TmpPdE
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.codpds AS cpros, b.qtds, 'E' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigPdMvf b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.codpds " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpPdE")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Selecionar producao - entradas (ENCERRAMENTO)
            loc_cDopps = PADR('ENCERRAMENTO', 20)
            IF USED("TmpPdE2")
                USE IN TmpPdE2
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.codpds AS cpros, b.qtds, 'E' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigPdMvf b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.codpds " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpPdE2")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Adicionar entradas de producao ao CsPrd
            SELECT TmpPdE
            GO TOP
            SCAN
                SCATTER MEMVAR
                m.ggrupo = IIF(SEEK(TmpPdE.cgrus, "cursor_4c_SigCdGrp", "cgrus"), ;
                               cursor_4c_SigCdGrp.mercs, '')
                INSERT INTO CsPrd FROM MEMVAR
            ENDSCAN

            SELECT TmpPdE2
            GO TOP
            SCAN
                SCATTER MEMVAR
                m.ggrupo = IIF(SEEK(TmpPdE2.cgrus, "cursor_4c_SigCdGrp", "cgrus"), ;
                               cursor_4c_SigCdGrp.mercs, '')
                INSERT INTO CsPrd FROM MEMVAR
            ENDSCAN
            WAIT CLEAR

            *-- Selecionar producao - saidas (ENCERRAMENTO DIRETO = materia prima consumida)
            WAIT WINDOW "Aguarde! Selecionando Produ" + CHR(231) + CHR(227) + "o (Sa" + ;
                        CHR(237) + "das)..." NOWAIT
            loc_cDopps = PADR('ENCERRAMENTO DIRETO', 20)
            IF USED("TmpEnc")
                USE IN TmpEnc
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.cmats AS cpros, b.qtds, 'S' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigCdNei b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.cmats " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEnc")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Selecionar producao - entradas por fundicao
            loc_cDopps = PADR('FUNDI' + CHR(199) + CHR(195) + 'O', 20)
            IF USED("TmpFun")
                USE IN TmpFun
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.cmats AS cpros, b.qtds, 'E' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigCdNei b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.cmats " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpFun")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Unir saidas de encerramento e fundicao
            SELECT emps, dopes, numes, cpros, qtds, opers, cgrus FROM TmpEnc ;
            UNION ALL ;
            SELECT emps, dopes, numes, cpros, qtds, opers, cgrus FROM TmpFun ;
            INTO CURSOR TmpPdS READWRITE

            *-- Adicionar saidas ao CsPrd (apenas produtos de categoria estoque)
            SELECT TmpPdS
            GO TOP
            SCAN
                IF SEEK(TmpPdS.cgrus, "cursor_4c_SigCdGrp", "cgrus")
                    IF cursor_4c_SigCdGrp.cestoqs <> 1
                        LOOP
                    ENDIF
                    SCATTER MEMVAR
                    m.ggrupo = cursor_4c_SigCdGrp.mercs
                    INSERT INTO CsPrd FROM MEMVAR
                ENDIF
            ENDSCAN
            WAIT CLEAR

            *-- Agregar producao por Emps+GGrupo+Dopes+Numes
            WAIT WINDOW "Aguarde! Analisando Produ" + CHR(231) + CHR(227) + "o..." NOWAIT

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM CsPrd ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csProducao READWRITE

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM CsPrd ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR CsPrds READWRITE

            SELECT Emps, GGrupo, Dopes, SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas ;
            FROM CsPrds ;
            GROUP BY Emps, GGrupo, Dopes ;
            ORDER BY Emps, GGrupo, Dopes ;
            INTO CURSOR csTotPrd READWRITE
            WAIT CLEAR

            *-- Combinar movimentos + producao + historico para calculo de saldos
            SELECT emps, ggrupo, dopes, entradas AS entmov, saidas AS saimov, ;
                   0 AS enthis, 0 AS saihis, PesoEs, PesoSs ;
            FROM csTotMov ;
            UNION ALL ;
            SELECT emps, ggrupo, dopes, entradas AS entmov, saidas AS saimov, ;
                   0 AS enthis, 0 AS saihis, 0 AS PesoEs, 0 AS PesoSs ;
            FROM csTotPrd ;
            UNION ALL ;
            SELECT emps, ggrupo, dopes, 0 AS entmov, 0 AS saimov, ;
                   entradas AS enthis, saidas AS saihis, 0 AS PesoEs, 0 AS PesoSs ;
            FROM csTotHis ;
            INTO CURSOR TmpMovHis READWRITE

            SELECT Emps, GGrupo, Dopes, ;
                   SUM(EntMov) AS EntMov, SUM(SaiMov) AS SaiMov, ;
                   SUM(EntHis) AS EntHis, SUM(SaiHis) AS SaiHis, ;
                   SUM(PesoEs) AS PesoEs, SUM(PesoSs) AS PesoSs ;
            FROM TmpMovHis ;
            GROUP BY Emps, GGrupo, Dopes ;
            INTO CURSOR CsMovHis READWRITE

            SELECT CsMovHis
            INDEX ON GGrupo TAG GGrupo
            GO TOP

            *-- Preencher CsRel: saldos acumulados por GGrupo + Dopes
            SELECT csSaldoIni
            GO TOP
            SCAN
                loc_lFirst   = .T.
                m.sldini     = 0
                m.entmov     = 0
                m.saimov     = 0
                m.enthis     = 0
                m.saihis     = 0
                m.salmov     = 0
                m.salhis     = 0
                m.sldfin     = 0
                m.difs       = 0
                m.PesoEs     = 0
                m.PesoSs     = 0

                =SEEK(csSaldoIni.GGrupo, "csSaldoFin", "ggrupo")
                m.emps       = csSaldoIni.emps
                m.ggrupo     = csSaldoIni.ggrupo
                loc_lnSldIni = csSaldoIni.saldo
                loc_lnSldFin = csSaldoFin.saldo
                m.salmov     = loc_lnSldIni
                m.salhis     = loc_lnSldIni

                SELECT CsMovHis
                GO TOP
                IF SEEK(csSaldoIni.ggrupo, "CsMovHis", "ggrupo")
                    DO WHILE !EOF() AND CsMovHis.ggrupo = csSaldoIni.ggrupo
                        m.dopes  = CsMovHis.dopes
                        m.entmov = CsMovHis.entmov
                        m.saimov = CsMovHis.saimov
                        m.enthis = CsMovHis.enthis
                        m.saihis = CsMovHis.saihis
                        m.PesoEs = CsMovHis.PesoEs
                        m.PesoSs = CsMovHis.PesoSs
                        m.sldini = 0
                        m.salmov = m.salmov + (m.entmov - m.saimov)
                        m.salhis = m.salhis + (m.enthis - m.saihis)
                        m.sldfin = 0
                        IF loc_lFirst
                            m.sldini   = loc_lnSldIni
                            loc_lFirst = .F.
                        ENDIF
                        INSERT INTO CsRel FROM MEMVAR
                        SELECT CsMovHis
                        SKIP
                    ENDDO
                    SELECT CsRel
                    REPLACE CsRel.sldfin WITH loc_lnSldFin, ;
                            CsRel.difs   WITH CsRel.salmov - loc_lnSldFin
                ENDIF
                SELECT csSaldoIni
            ENDSCAN

            *-- Construir cursor de movimentos+producao detalhado
            SELECT emps, ggrupo, dopes, numes, Entradas, Saidas, PesoEs, PesoSs ;
            FROM csMovimento ;
            UNION ALL ;
            SELECT emps, ggrupo, dopes, numes, Entradas, Saidas, ;
                   0 AS PesoEs, 0 AS PesoSs ;
            FROM csProducao ;
            INTO CURSOR CsMovPrd READWRITE

            SELECT Emps, Dopes, Numes, GGrupo, ;
                   SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas, ;
                   SUM(PesoEs) AS PesoEs, SUM(PesoSs) AS PesoSs ;
            FROM CsMovPrd ;
            GROUP BY Emps, Dopes, Numes, GGrupo ;
            INTO CURSOR CsMoviProd READWRITE

            *-- Construir cursor de divergencias (comparacao movimentos vs historico)
            SELECT a.emps, a.dopes, a.numes, a.GGrupo, ;
                   a.entradas AS entmov, a.saidas AS saimov, ;
                   b.entradas AS enthis, b.saidas AS saihis, ;
                   a.PesoEs, a.PesoSs ;
            FROM CsMoviProd a, csHistorico b ;
            WHERE a.emps + a.dopes + STR(a.numes, 6) + a.GGrupo = ;
                  b.emps + b.dopes + STR(b.numes, 6) + b.GGrupo ;
            AND (a.entradas <> b.entradas OR a.saidas <> b.saidas) ;
            UNION ALL ;
            SELECT a.emps, a.dopes, a.numes, a.GGrupo, ;
                   a.entradas AS entmov, a.saidas AS saimov, ;
                   0 AS enthis, 0 AS saihis, ;
                   0 AS PesoEs, 0 AS PesoSs ;
            FROM CsMoviProd a ;
            WHERE a.emps + a.dopes + STR(a.numes, 6) + a.GGrupo NOT IN ;
                  (SELECT b.emps + b.dopes + STR(b.numes, 6) + b.GGrupo ;
                   FROM csHistorico b) ;
            UNION ALL ;
            SELECT a.emps, a.dopes, a.numes, a.GGrupo, ;
                   0 AS entmov, 0 AS saimov, ;
                   a.entradas AS enthis, a.saidas AS saihis, ;
                   0 AS PesoEs, 0 AS PesoSs ;
            FROM csHistorico a ;
            WHERE a.emps + a.dopes + STR(a.numes, 6) + a.GGrupo NOT IN ;
                  (SELECT b.emps + b.dopes + STR(b.numes, 6) + b.GGrupo ;
                   FROM CsMoviProd b) ;
            INTO CURSOR CsDif READWRITE

            SELECT CsDif
            GO TOP

            SELECT CsRel
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "ProcessarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + "SigReAe1") PREVIEW NOCONSOLE
            IF USED("CsDiferenca")
                SELECT CsDiferenca
                GO TOP
                IF !EOF()
                    IF MsgConfirma("Deseja Visualizar o Relat" + CHR(243) + "rio de " + ;
                                   "Diverg" + CHR(234) + "ncias ?")
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAe2") PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + "SigReAe1") TO PRINTER PROMPT NOCONSOLE
            IF USED("CsDiferenca")
                SELECT CsDiferenca
                GO TOP
                IF !EOF()
                    IF MsgConfirma("Deseja Imprimir o Relat" + CHR(243) + "rio de " + ;
                                   "Diverg" + CHR(234) + "ncias ?")
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAe2") TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Retorna identificador composto dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "EMP=" + ALLTRIM(THIS.this_cEmpresa) + ;
               ";GRE=" + ALLTRIM(THIS.this_cCdGrEstoque) + ;
               ";EST=" + ALLTRIM(THIS.this_cCdEstoque) + ;
               ";GGP=" + ALLTRIM(THIS.this_cCdGGrupo) + ;
               ";DTI=" + DTOC(THIS.this_dDtInicial) + ;
               ";DTF=" + DTOC(THIS.this_dDtFinal)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao
    * par_cAliasCursor: cursor com colunas no formato preset
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + ;
                                          CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SCATTER MEMVAR

            IF TYPE("m.cEmpresa") = "C"
                THIS.this_cEmpresa = ALLTRIM(m.cEmpresa)
            ENDIF
            IF TYPE("m.cDesEmpresa") = "C"
                THIS.this_cDesEmpresa = ALLTRIM(m.cDesEmpresa)
            ENDIF
            IF TYPE("m.cCdGrEstoque") = "C"
                THIS.this_cCdGrEstoque = ALLTRIM(m.cCdGrEstoque)
            ENDIF
            IF TYPE("m.cDsGrEstoque") = "C"
                THIS.this_cDsGrEstoque = ALLTRIM(m.cDsGrEstoque)
            ENDIF
            IF TYPE("m.cCdEstoque") = "C"
                THIS.this_cCdEstoque = ALLTRIM(m.cCdEstoque)
            ENDIF
            IF TYPE("m.cDsEstoque") = "C"
                THIS.this_cDsEstoque = ALLTRIM(m.cDsEstoque)
            ENDIF
            IF TYPE("m.cCdGGrupo") = "C"
                THIS.this_cCdGGrupo = ALLTRIM(m.cCdGGrupo)
            ENDIF
            IF TYPE("m.cDsGGrupo") = "C"
                THIS.this_cDsGGrupo = ALLTRIM(m.cDsGGrupo)
            ENDIF
            IF TYPE("m.dDtInicial") = "D"
                THIS.this_dDtInicial = m.dDtInicial
            ENDIF
            IF TYPE("m.dDtFinal") = "D"
                THIS.this_dDtFinal = m.dDtFinal
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          "obrigat" + CHR(243) + "rio para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Data final deve ser maior ou igual " + ;
                                          CHR(224) + " data inicial"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          "obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Data final deve ser maior ou igual " + ;
                                          CHR(224) + " data inicial"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReAeg") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
