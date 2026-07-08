*==============================================================================
* SIGREDDPBO.PRG
* Business Object para o Relatorio Demonstrativo de Balanco (SigReDdp)
*
* Herda de: RelatorioBase
* Tipo: REPORT
*
* Filtros do formulario:
*   this_cNome     - Nome do demonstrativo (Get_Demonstrativo / SigPrDmo.Nome)
*   this_dDtFinal  - Data de referencia para apuracao do saldo (get_dt_final)
*
* Processamento (PrepararDados):
*   1. Carrega parametro Ouros de SigCdPam
*   2. Carrega clientes de SigCdCli (para lookup IClis -> RClis)
*   3. Busca configuracao do demonstrativo em SigPrDmo (Grupos, Contas)
*   4. Apura saldo inicial via SigCdFcx + SigOpCfe (CPros = Ouros)
*   5. Processa linhas SigCdDpr:
*      - Operas='E'/'S': entradas/saidas de SigCdFes por TpOps
*      - Operas='P'    : pesagens de SigOpCfe por SigCdCli
*      - Operas='H'    : historico de estoque via SigMvEst + SigMvHst
*      - Operas='T'    : insere linha de sub-total/total geral
*   6. Monta cursor_4c_Cabecalho com empresa, titulo e periodo
*   7. Monta cursor_4c_Result com todas as linhas do demonstrativo
*
* Relatorio FRX: SigReDdp.frx (na pasta gc_4c_CaminhoReports)
*==============================================================================

DEFINE CLASS SigReDdpBO AS RelatorioBase

    *-- Filtros recebidos via FormParaRelatorio()
    this_cNome              = ""    && Nome do demonstrativo (SigPrDmo.Nome)
    this_dDtFinal           = {}    && Data final de referencia para apuracao

    *-- Cursor principal de saida (populado por PrepararDados)
    this_cCursorDados       = "cursor_4c_Result"

    *-- Titulo do relatorio (exibido no cabecalho)
    this_cTituloRelatorio   = ""

    *--------------------------------------------------------------------------
    * Init - Construtor: configura identificacao e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela           = "SigReDdp"
        THIS.this_cCampoChave       = "Nome"
        THIS.this_cTituloRelatorio  = "Demonstrativo de Balan" + CHR(231) + "o"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
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
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                THIS.ExecutarReportForm("SigReDdp", "PREVIEW", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(loc_oErro.Message, "Erro em Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                loc_cArquivo = gc_4c_CaminhoReports + "SigReDdp.frx"
                REPORT FORM (loc_cArquivo) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(loc_oErro.Message, "Erro em Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor_4c_Cabecalho e cursor_4c_Result
    * Replica a logica do procedure 'processamento' do form original SIGREDDP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcConfig, loc_ldFinal
        LOCAL loc_lcCbEmpresa, loc_lcCbTitulo, loc_lcCbPeriodo
        LOCAL loc_lnSaldo, loc_lnSubTotal
        LOCAL loc_lcOuros
        LOCAL loc_lcPrDmoGrupos, loc_lcPrDmoContas
        LOCAL loc_lcNome, loc_lnQtde, loc_lnPeso, loc_lnOrdem
        LOCAL loc_lcDprGrupos, loc_lcDprContas, loc_lcDprTpOps
        LOCAL loc_lcDprOperas, loc_lnDprOrdems
        LOCAL loc_lcDprGruposH, loc_lcDprContasH
        LOCAL loc_lcPGrI, loc_lcPGrF, loc_lcEstos
        LOCAL loc_lcCodigos
        LOCAL loc_oErro

        loc_lSucesso   = .F.
        loc_lnSaldo    = 0
        loc_lnSubTotal = 0
        loc_lcNome     = ""
        loc_lnQtde     = 0
        loc_lnPeso     = 0
        loc_lnOrdem    = 0

        TRY
            loc_lcConfig = ALLTRIM(THIS.this_cNome)
            loc_ldFinal  = THIS.this_dDtFinal

            IF EMPTY(loc_lcConfig) OR EMPTY(loc_ldFinal)
                THIS.this_cMensagemErro = "Preencha o Demonstrativo e a Data"
                ERROR "Filtros invalidos"
            ENDIF

            *-- Limpa cursores de saida de execucao anterior
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Result")
                USE IN cursor_4c_Result
            ENDIF

            *-- 1. Carrega parametro Ouros de SigCdPam
            loc_cSQL = "SELECT Ouros FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdPam"
                ERROR "Falha SQL"
            ENDIF
            SELECT cursor_4c_SigCdPam
            GO TOP
            loc_lcOuros = ALLTRIM(cursor_4c_SigCdPam.Ouros)
            USE IN cursor_4c_SigCdPam

            *-- 2. Carrega clientes para lookup IClis -> RClis
            loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdCli")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdCli"
                ERROR "Falha SQL"
            ENDIF
            SELECT cursor_4c_SigCdCli
            INDEX ON IClis TAG IClis

            loc_lcCbEmpresa = go_4c_Sistema.cCodEmpresa

            loc_lcCbTitulo  = "Demonstrativo de Balan" + CHR(231) + "o " + loc_lcConfig
            loc_lcCbPeriodo = "Data : " + DTOC(loc_ldFinal)

            *-- 4. Cria cursores de saida
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho ;
                (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80), SdInicial N(12,3))
            SET NULL OFF
            INSERT INTO cursor_4c_Cabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                   VALUES (loc_lcCbEmpresa, loc_lcCbTitulo, loc_lcCbPeriodo)

            SET NULL ON
            CREATE CURSOR cursor_4c_Result ;
                (Ordem N(3), Grupos C(10), Contas C(10), Nome C(50), ;
                 TpOps C(15), Operas C(1), Qtds N(12,3))
            SET NULL OFF
            INDEX ON Ordem TAG Ordem

            *-- 5. Busca configuracao do demonstrativo em SigPrDmo
            loc_cSQL = "SELECT Grupos, Contas FROM SigPrDmo " + ;
                       "WHERE Nome = " + EscaparSQL(loc_lcConfig)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrDmo")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigPrDmo"
                ERROR "Falha SQL"
            ENDIF
            SELECT cursor_4c_SigPrDmo
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + ;
                                          "o encontrado: " + loc_lcConfig
                USE IN cursor_4c_SigPrDmo
                ERROR "Demonstrativo nao encontrado"
            ENDIF
            loc_lcPrDmoGrupos = ALLTRIM(cursor_4c_SigPrDmo.Grupos)
            loc_lcPrDmoContas = ALLTRIM(cursor_4c_SigPrDmo.Contas)
            USE IN cursor_4c_SigPrDmo

            *-- 6. Apuracao do Saldo Inicial: fecha mais recente via SigCdFcx
            loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Codigos FROM SigCdFcx " + ;
                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND Grupos = " + EscaparSQL(loc_lcPrDmoGrupos) + ;
                       " AND Contas = " + EscaparSQL(loc_lcPrDmoContas) + ;
                       " AND Datas <= " + FormatarDataSQL(loc_ldFinal) + ;
                       " ORDER BY Emps, Grupos, Contas, Datas, Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdFcx")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdFcx (Saldo Inicial)"
                ERROR "Falha SQL"
            ENDIF

            SELECT cursor_4c_SigCdFcx
            INDEX ON DTOS(Datas) TAG GrConDat
            SET ORDER TO GrConDat DESCENDING
            SET NEAR ON
            SEEK DTOS(loc_ldFinal)
            SET NEAR OFF
            SET ORDER TO GrConDat ASCENDING

            SCAN WHILE Datas <= loc_ldFinal
                loc_lcCodigos = ALLTRIM(STR(cursor_4c_SigCdFcx.Codigos))

                loc_cSQL = "SELECT Emps, Codigos, CPros, Saldos FROM SigOpCfe " + ;
                           "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND Codigos = " + loc_lcCodigos + ;
                           " ORDER BY Emps, Codigos, CPros, Saldos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpCfe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar SigOpCfe (Saldo)"
                    ERROR "Falha SQL"
                ENDIF

                SELECT cursor_4c_SigOpCfe
                SCAN
                    IF ALLTRIM(cursor_4c_SigOpCfe.CPros) = loc_lcOuros
                        loc_lnQtde  = cursor_4c_SigOpCfe.Saldos
                        loc_lnSaldo = loc_lnSaldo + loc_lnQtde
                        INSERT INTO cursor_4c_Result (Grupos, Contas, TpOps, Qtds) ;
                               VALUES (loc_lcPrDmoGrupos, loc_lcPrDmoContas, ;
                                       "Saldo Inicial", loc_lnQtde)
                    ENDIF
                ENDSCAN
                IF USED("cursor_4c_SigOpCfe")
                    USE IN cursor_4c_SigOpCfe
                ENDIF
                SELECT cursor_4c_SigCdFcx
            ENDSCAN
            IF USED("cursor_4c_SigCdFcx")
                USE IN cursor_4c_SigCdFcx
            ENDIF

            *-- Grava saldo inicial no cabecalho
            SELECT cursor_4c_Cabecalho
            GO TOP
            REPLACE cursor_4c_Cabecalho.SdInicial WITH loc_lnSaldo
            loc_lnSubTotal = loc_lnSaldo

            *-- 7. Busca e processa linhas do demonstrativo (SigCdDpr)
            loc_cSQL = "SELECT Nome, Ordems, Grupos, Contas, Operas, TpOps FROM SigCdDpr " + ;
                       "WHERE Nome = " + EscaparSQL(loc_lcConfig) + ;
                       " ORDER BY Nome, Ordems, Grupos, Contas, Operas, TpOps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdDpr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdDpr"
                ERROR "Falha SQL"
            ENDIF

            SELECT cursor_4c_SigCdDpr
            SCAN

                IF ALLTRIM(cursor_4c_SigCdDpr.Operas) = "T"
                    *-- Sub-Total ou Total Geral
                    INSERT INTO cursor_4c_Result (Operas, Qtds, Ordem, Nome) ;
                           VALUES ("T", loc_lnSubTotal, cursor_4c_SigCdDpr.Ordems, ;
                                   IIF(cursor_4c_SigCdDpr.Ordems = 999, ;
                                       "Total Geral", "Sub-Total"))
                    LOOP
                ENDIF

                IF INLIST(ALLTRIM(cursor_4c_SigCdDpr.Operas), "E", "S", "P")
                    *-- Entradas, Saidas ou Pesagens
                    loc_lcDprGrupos = ALLTRIM(cursor_4c_SigCdDpr.Grupos)
                    loc_lcDprContas = ALLTRIM(cursor_4c_SigCdDpr.Contas)
                    loc_lcDprTpOps  = ALLTRIM(cursor_4c_SigCdDpr.TpOps)
                    loc_lcDprOperas = ALLTRIM(cursor_4c_SigCdDpr.Operas)
                    loc_lnDprOrdems = cursor_4c_SigCdDpr.Ordems

                    loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Codigos FROM SigCdFcx " + ;
                               "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                               " AND Grupos = " + EscaparSQL(loc_lcDprGrupos) + ;
                               " AND Contas = " + EscaparSQL(loc_lcDprContas) + ;
                               " AND Datas <= " + FormatarDataSQL(loc_ldFinal) + ;
                               " ORDER BY Emps, Grupos, Contas, Datas, Codigos"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdFcx")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar SigCdFcx (linhas)"
                        ERROR "Falha SQL"
                    ENDIF

                    SELECT cursor_4c_SigCdFcx
                    INDEX ON DTOS(Datas) TAG GrConDat
                    SET ORDER TO GrConDat DESCENDING
                    SET NEAR ON
                    SEEK DTOS(loc_ldFinal)
                    SET NEAR OFF
                    SET ORDER TO GrConDat ASCENDING

                    SCAN WHILE Datas <= loc_ldFinal
                        loc_lcCodigos = ALLTRIM(STR(cursor_4c_SigCdFcx.Codigos))

                        IF loc_lcDprOperas = "P"
                            *-- Pesagens: busca nome do cliente por Contas = IClis
                            IF SEEK(loc_lcDprContas, "cursor_4c_SigCdCli", "IClis")
                                loc_lcNome = ALLTRIM(cursor_4c_SigCdCli.Rclis)
                            ELSE
                                loc_lcNome = ""
                            ENDIF

                            loc_cSQL = "SELECT Emps, Codigos, CPros, Pesagems FROM SigOpCfe " + ;
                                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                       " AND Codigos = " + loc_lcCodigos + ;
                                       " ORDER BY Emps, Codigos, CPros, Pesagems"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpCfe")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar SigOpCfe (Pesagens)"
                                ERROR "Falha SQL"
                            ENDIF

                            SELECT cursor_4c_SigOpCfe
                            SCAN
                                IF ALLTRIM(cursor_4c_SigOpCfe.CPros) = loc_lcOuros
                                    INSERT INTO cursor_4c_Result ;
                                           (Grupos, Contas, Nome, TpOps, Operas, Qtds, Ordem) ;
                                           VALUES (loc_lcDprGrupos, loc_lcDprContas, ;
                                                   loc_lcNome, "PESAGEM", loc_lcDprOperas, ;
                                                   cursor_4c_SigOpCfe.Pesagems, loc_lnDprOrdems)
                                    loc_lnSubTotal = loc_lnSubTotal - cursor_4c_SigOpCfe.Pesagems
                                ENDIF
                            ENDSCAN
                            IF USED("cursor_4c_SigOpCfe")
                                USE IN cursor_4c_SigOpCfe
                            ENDIF
                            SELECT cursor_4c_SigCdFcx

                        ELSE
                            *-- Entradas (E) ou Saidas (S): busca em SigCdFes por TpOps
                            loc_cSQL = "SELECT Emps, Codigos, CPros, TpOps, " + ;
                                       "PesoEnts, PesoSais FROM SigCdFes " + ;
                                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                       " AND Codigos = " + loc_lcCodigos + ;
                                       " ORDER BY Emps, Codigos, CPros, TpOps, PesoEnts, PesoSais"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdFes")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar SigCdFes"
                                ERROR "Falha SQL"
                            ENDIF

                            SELECT cursor_4c_SigCdFes
                            SCAN
                                IF ALLTRIM(cursor_4c_SigCdFes.CPros) = loc_lcOuros ;
                                   AND ALLTRIM(cursor_4c_SigCdFes.TpOps) = loc_lcDprTpOps
                                    IF SEEK(loc_lcDprContas, "cursor_4c_SigCdCli", "IClis")
                                        loc_lcNome = ALLTRIM(cursor_4c_SigCdCli.Rclis)
                                    ELSE
                                        loc_lcNome = ""
                                    ENDIF
                                    loc_lnQtde = IIF(loc_lcDprOperas = "E", ;
                                                     cursor_4c_SigCdFes.PesoEnts, ;
                                                     cursor_4c_SigCdFes.PesoSais)
                                    INSERT INTO cursor_4c_Result ;
                                           (Grupos, Contas, Nome, TpOps, Operas, Qtds, Ordem) ;
                                           VALUES (loc_lcDprGrupos, loc_lcDprContas, ;
                                                   loc_lcNome, ;
                                                   ALLTRIM(cursor_4c_SigCdFes.TpOps), ;
                                                   loc_lcDprOperas, loc_lnQtde, loc_lnDprOrdems)
                                    IF loc_lcDprOperas = "E"
                                        loc_lnSubTotal = loc_lnSubTotal + loc_lnQtde
                                    ELSE
                                        loc_lnSubTotal = loc_lnSubTotal - loc_lnQtde
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            IF USED("cursor_4c_SigCdFes")
                                USE IN cursor_4c_SigCdFes
                            ENDIF
                            SELECT cursor_4c_SigCdFcx
                        ENDIF
                    ENDSCAN
                    IF USED("cursor_4c_SigCdFcx")
                        USE IN cursor_4c_SigCdFcx
                    ENDIF
                    SELECT cursor_4c_SigCdDpr

                ELSE
                    *-- Operas = 'H': Historico de estoque via SigMvEst + SigMvHst
                    *-- lnOrdem e lcNome capturados do primeiro registro H do grupo
                    loc_lnPeso  = 0
                    loc_lnOrdem = cursor_4c_SigCdDpr.Ordems

                    IF EMPTY(ALLTRIM(cursor_4c_SigCdDpr.Contas))
                        loc_lcNome = "Saldo das Fases"
                    ELSE
                        IF SEEK(cursor_4c_SigCdDpr.Contas, "cursor_4c_SigCdCli", "IClis")
                            loc_lcNome = ALLTRIM(cursor_4c_SigCdCli.Rclis)
                        ELSE
                            loc_lcNome = ""
                        ENDIF
                    ENDIF

                    *-- SCAN aninhado: acumula peso de todos os registros H consecutivos
                    SCAN WHILE ALLTRIM(cursor_4c_SigCdDpr.Nome) = loc_lcConfig ;
                           AND ALLTRIM(cursor_4c_SigCdDpr.Operas) = "H"

                        loc_lcDprGruposH = ALLTRIM(cursor_4c_SigCdDpr.Grupos)
                        loc_lcDprContasH = ALLTRIM(cursor_4c_SigCdDpr.Contas)
                        loc_lcPGrI = loc_lcDprContasH
                        loc_lcPGrF = IIF(EMPTY(loc_lcDprContasH), ;
                                         REPLICATE(CHR(254), 20), loc_lcDprContasH)

                        *-- Busca estoques em SigMvEst via EmpGruEsts (coluna computada)
                        loc_cSQL = "SELECT Emps, Grupos, Estos, CPros FROM SigMvEst " + ;
                                   "WHERE EmpGruEsts BETWEEN " + ;
                                         EscaparSQL(go_4c_Sistema.cCodEmpresa + ;
                                                    loc_lcDprGruposH + loc_lcPGrI) + ;
                                   " AND " + EscaparSQL(go_4c_Sistema.cCodEmpresa + ;
                                                        loc_lcDprGruposH + loc_lcPGrF) + ;
                                   " AND CPros = " + EscaparSQL(loc_lcOuros) + ;
                                   " AND NOT Sqtds = 0" + ;
                                   " ORDER BY Emps, Grupos, Estos, CPros"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvEst")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar SigMvEst"
                            ERROR "Falha SQL"
                        ENDIF

                        SELECT cursor_4c_SigMvEst
                        INDEX ON Emps + Grupos + Estos + CPros TAG EmpEstPro
                        SET ORDER TO EmpEstPro
                        SET NEAR ON
                        SEEK go_4c_Sistema.cCodEmpresa + loc_lcDprGruposH + ;
                             loc_lcDprContasH + loc_lcOuros
                        SET NEAR OFF

                        SCAN WHILE go_4c_Sistema.cCodEmpresa + loc_lcDprGruposH = ;
                                        ALLTRIM(Emps) + ALLTRIM(Grupos) ;
                                   AND ALLTRIM(Estos) = loc_lcDprContasH
                            loc_lcEstos = ALLTRIM(cursor_4c_SigMvEst.Estos)

                            *-- Busca saldo mais recente ate loc_ldFinal em SigMvHst
                            loc_cSQL = "SELECT TOP 1 EmpGruEsts, CPros, cIdChaves, Sqtds " + ;
                                       "FROM SigMvHst " + ;
                                       "WHERE EmpGruEsts = " + ;
                                             EscaparSQL(go_4c_Sistema.cCodEmpresa + ;
                                                        loc_lcDprGruposH + loc_lcEstos) + ;
                                       " AND CPros = " + EscaparSQL(loc_lcOuros) + ;
                                       " AND Datas <= " + FormatarDataSQL(loc_ldFinal) + ;
                                       " ORDER BY EmpGruEsts ASC, CPros ASC, cIdChaves DESC"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvHst")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar SigMvHst"
                                ERROR "Falha SQL"
                            ENDIF

                            SELECT cursor_4c_SigMvHst
                            GO TOP
                            IF !EOF()
                                loc_lnPeso = loc_lnPeso + cursor_4c_SigMvHst.Sqtds
                            ENDIF
                            IF USED("cursor_4c_SigMvHst")
                                USE IN cursor_4c_SigMvHst
                            ENDIF
                            SELECT cursor_4c_SigMvEst
                        ENDSCAN
                        IF USED("cursor_4c_SigMvEst")
                            USE IN cursor_4c_SigMvEst
                        ENDIF
                        SELECT cursor_4c_SigCdDpr
                    ENDSCAN
                    *-- Apos ENDSCAN cursor esta no primeiro registro nao-H (ou EOF)

                    IF loc_lnPeso <> 0
                        INSERT INTO cursor_4c_Result ;
                               (Grupos, Contas, Nome, Operas, Qtds, Ordem) ;
                               VALUES (cursor_4c_SigCdDpr.Grupos, ;
                                       cursor_4c_SigCdDpr.Contas, ;
                                       loc_lcNome, "H", loc_lnPeso, loc_lnOrdem)
                        loc_lnSubTotal = loc_lnSubTotal + loc_lnPeso
                    ENDIF

                    SELECT cursor_4c_SigCdDpr
                    SKIP -1
                ENDIF

            ENDSCAN

            IF USED("cursor_4c_SigCdDpr")
                USE IN cursor_4c_SigCdDpr
            ENDIF
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF

            SELECT cursor_4c_Result
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")

            *-- Fecha cursores de saida (dados incompletos)
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Result")
                USE IN cursor_4c_Result
            ENDIF
            *-- Fecha cursores intermediarios
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
            IF USED("cursor_4c_SigPrDmo")
                USE IN cursor_4c_SigPrDmo
            ENDIF
            IF USED("cursor_4c_SigCdFcx")
                USE IN cursor_4c_SigCdFcx
            ENDIF
            IF USED("cursor_4c_SigOpCfe")
                USE IN cursor_4c_SigOpCfe
            ENDIF
            IF USED("cursor_4c_SigCdFes")
                USE IN cursor_4c_SigCdFes
            ENDIF
            IF USED("cursor_4c_SigCdDpr")
                USE IN cursor_4c_SigCdDpr
            ENDIF
            IF USED("cursor_4c_SigMvEst")
                USE IN cursor_4c_SigMvEst
            ENDIF
            IF USED("cursor_4c_SigMvHst")
                USE IN cursor_4c_SigMvHst
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor
    *
    * Permite recuperar configuracao de filtros previamente salva (ex: historico
    * de relatorios). Mapeia colunas do cursor para propriedades this_cNome e
    * this_dDtFinal deste BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("Nome") = "C"
                    THIS.this_cNome = ALLTRIM(NVL(EVALUATE("Nome"), ""))
                ENDIF
                IF TYPE("DtFinal") = "D"
                    THIS.this_dDtFinal = NVL(EVALUATE("DtFinal"), {})
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de filtros est" + CHR(225) + " vazio"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao da configuracao atual
    *
    * Como nao ha registro persistido, retorna concatenacao dos filtros
    * atualmente carregados (usado para auditoria/log de execucoes).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_cNome)
            loc_cChave = "DEMONSTRATIVO=" + ALLTRIM(THIS.this_cNome)
        ENDIF
        IF !EMPTY(THIS.this_dDtFinal)
            IF !EMPTY(loc_cChave)
                loc_cChave = loc_cChave + "|"
            ENDIF
            loc_cChave = loc_cChave + "DTFINAL=" + DTOC(THIS.this_dDtFinal)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Grava evento de impressao/visualizacao do relatorio em LogAuditoria
    * para rastreabilidade de quem executou o Demonstrativo de Balanco
    * e com quais filtros (nome do demonstrativo + data final).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(NVL(par_cOperacao, "RELATORIO")) + ", " + ;
                       EscaparSQL("SigReDdp") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Demonstrativo de Balan" + CHR(231) + "o") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "RegistrarAuditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
