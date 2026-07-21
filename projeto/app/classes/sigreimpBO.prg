*==============================================================================
* SIGREIMPBO.PRG
* Business Object - Relatorio Comparativo de Impostos
*
* Herda de RelatorioBase (NAO de BusinessBase)
* Form original: SIGREIMP.SCX (frmrelatorio)
* Relatorios: SigReIp1 (Detalhado), SigReIp2 (Resumido)
*==============================================================================

DEFINE CLASS sigreimpBO AS RelatorioBase

    *-- Identificacao (nao aplicavel em relatorio, requerido pela base)
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros de data (getDtInicial / getDtFinal)
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro de empresa (getEmpresa / getDEmpresa)
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtro de conta (getConta / getDConta)
    this_cConta         = ""
    this_cDConta        = ""

    *-- Opcoes de relatorio (chkSubTotDat / optTipos)
    this_lSubTotDat     = .F.
    this_nTipos         = 1

    *-- Nomes dos cursores de trabalho
    this_cCursorOperacoesE  = "cursor_4c_OperacoesE"
    this_cCursorOperacoesS  = "cursor_4c_OperacoesS"
    this_cCursorDados       = "crDados"
    this_cCursorCabecalho   = "crCabecalho"

    *-- Mensagem de erro
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oDataAccess = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacoes - Popula cursores de operacoes a partir de SigCdTom
    * Chamado no InicializarForm do Form antes de exibir os grids
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacoes()
        LOCAL loc_lSucesso, loc_cCursorE, loc_cCursorS
        LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs

        loc_lSucesso = .F.
        loc_cCursorE = THIS.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_cCursorOperacoesS

        TRY
            *-- Criar ou zerar cursor de entradas
            IF !USED(loc_cCursorE)
                CREATE CURSOR (loc_cCursorE) (SelImp l(1), Codigos n(2), Descrs c(30))
            ELSE
                ZAP IN (loc_cCursorE)
            ENDIF

            *-- Criar ou zerar cursor de saidas
            IF !USED(loc_cCursorS)
                CREATE CURSOR (loc_cCursorS) (SelImp l(1), Codigos n(2), Descrs c(30))
            ELSE
                ZAP IN (loc_cCursorS)
            ENDIF

            *-- Buscar tipos de operacoes de SigCdTom
            loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOp")

            IF loc_nResult > 0
                SELECT cursor_4c_TiposOp
                SCAN
                    loc_nCodigos = cursor_4c_TiposOp.Codigos
                    loc_cDescrs  = ALLTRIM(cursor_4c_TiposOp.Descrs)

                    SELECT (loc_cCursorE)
                    APPEND BLANK
                    REPLACE SelImp  WITH .F.
                    REPLACE Codigos WITH loc_nCodigos
                    REPLACE Descrs  WITH loc_cDescrs

                    SELECT (loc_cCursorS)
                    APPEND BLANK
                    REPLACE SelImp  WITH .F.
                    REPLACE Codigos WITH loc_nCodigos
                    REPLACE Descrs  WITH loc_cDescrs
                ENDSCAN

                IF USED("cursor_4c_TiposOp")
                    USE IN cursor_4c_TiposOp
                ENDIF

                SELECT (loc_cCursorE)
                GO TOP
                SELECT (loc_cCursorS)
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar tipos de opera" + ;
                    CHR(231) + CHR(245) + "es (SigCdTom)"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de gerar relatorio
    * Retorna .T. se valido, .F. caso contrario (this_cMensagemErro preenchido)
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        LOCAL loc_lValido, loc_cCursorE, loc_cCursorS
        LOCAL loc_nContE, loc_nContS, loc_lConflito
        LOCAL loc_nCodSaida, loc_cDescSaida

        loc_lValido    = .F.
        loc_lConflito  = .F.
        loc_cCursorE   = THIS.this_cCursorOperacoesE
        loc_cCursorS   = THIS.this_cCursorOperacoesS
        loc_nCodSaida  = 0
        loc_cDescSaida = ""

        TRY
            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"

            ELSE
                IF EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"

            ELSE
                IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Data Final Menor Que a Inicial!!!"

            ELSE
                *-- Contar entradas selecionadas
                loc_nContE = 0
                IF USED(loc_cCursorE)
                    SELECT (loc_cCursorE)
                    GO TOP
                    SCAN
                        IF SelImp
                            loc_nContE = loc_nContE + 1
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_nContE = 0
                    THIS.this_cMensagemErro = "Nenhum Tipo Operacional de Entrada Foi Selecionado!!!"

                ELSE
                    *-- Contar saidas selecionadas
                    loc_nContS = 0
                    IF USED(loc_cCursorS)
                        SELECT (loc_cCursorS)
                        GO TOP
                        SCAN
                            IF SelImp
                                loc_nContS = loc_nContS + 1
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF loc_nContS = 0
                        THIS.this_cMensagemErro = "Nenhum Tipo Operacional de Sa" + ;
                            CHR(237) + "da Foi Selecionado!!!"

                    ELSE
                        *-- Verificar conflito: mesmo codigo em entrada e saida
                        IF USED(loc_cCursorS)
                            SELECT (loc_cCursorS)
                            GO TOP
                            SCAN
                                IF SelImp AND !loc_lConflito
                                    loc_nCodSaida  = Codigos
                                    loc_cDescSaida = Descrs
                                    IF USED(loc_cCursorE)
                                        SELECT (loc_cCursorE)
                                        GO TOP
                                        LOCATE FOR Codigos = loc_nCodSaida AND SelImp
                                        IF !EOF()
                                            loc_lConflito = .T.
                                            THIS.this_cMensagemErro = "O Tipo Operacional " + ;
                                                ALLTRIM(loc_cDescSaida) + " Foi" + ;
                                                " Selecionado Como Entrada e Sa" + CHR(237) + ;
                                                "da. Verifique!!!"
                                        ENDIF
                                        SELECT (loc_cCursorS)
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF !loc_lConflito
                            loc_lValido = .T.
                        ENDIF
                    ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e prepara cursores para o relatorio
    * Replica logica do PROCEDURE processamento do SIGREIMP.SCX original
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

    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cCursorE, loc_cCursorS
        LOCAL loc_cDtInicialSQL, loc_cDtFinalSQL
        LOCAL loc_cEtiquetaEmp, loc_cEtiquetaCta
        LOCAL loc_cWrE, loc_cWrS, loc_nContE, loc_nContS, loc_nCodigo
        LOCAL loc_cQuery, loc_nResult
        LOCAL loc_cEmpresaFiltro, loc_cContaFiltro
        LOCAL loc_cEmpDopNums, loc_cQueryBaixas, loc_nResultBaixas

        loc_lSucesso = .F.
        loc_cCursorE = THIS.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_cCursorOperacoesS

        TRY
            *-- Formatar datas para SQL Server
            loc_cDtInicialSQL = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinalSQL   = "'" + ;
                PADL(TRANSFORM(YEAR(THIS.this_dDtFinal)),  4, "0") + "-" + ;
                PADL(TRANSFORM(MONTH(THIS.this_dDtFinal)), 2, "0") + "-" + ;
                PADL(TRANSFORM(DAY(THIS.this_dDtFinal)),   2, "0") + " 23:59:59'"

            *-- Montar etiquetas descritivas para o cabecalho
            IF EMPTY(THIS.this_cEmpresa)
                loc_cEtiquetaEmp = "Global"
            ELSE
                loc_cEtiquetaEmp = ALLTRIM(THIS.this_cEmpresa) + "-" + ALLTRIM(THIS.this_cDEmpresa)
            ENDIF

            IF EMPTY(THIS.this_cConta)
                loc_cEtiquetaCta = "Global"
            ELSE
                loc_cEtiquetaCta = ALLTRIM(THIS.this_cConta) + "-" + ALLTRIM(THIS.this_cDConta)
            ENDIF

            *-- Criar / zerar cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                ZAP IN (THIS.this_cCursorCabecalho)
            ELSE
                CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                    (Titulo c(200), Subtitulo c(200), Periodo c(200), SubTotDia l(1))
            ENDIF
            SELECT (THIS.this_cCursorCabecalho)
            APPEND BLANK
            REPLACE Titulo    WITH "Relat" + CHR(243) + "rio Comparativo de Impostos"
            REPLACE Subtitulo WITH "Empresa: " + loc_cEtiquetaEmp + ;
                " - Conta: " + loc_cEtiquetaCta
            REPLACE Periodo   WITH "Per" + CHR(237) + "odo: " + ;
                DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal)
            REPLACE SubTotDia WITH THIS.this_lSubTotDat
            GO TOP IN (THIS.this_cCursorCabecalho)

            *-- Construir lista de codigos de Entrada selecionados
            loc_cWrE   = ""
            loc_nContE = 0
            IF USED(loc_cCursorE)
                SELECT (loc_cCursorE)
                GO TOP
                SCAN
                    IF SelImp
                        loc_nCodigo = Codigos
                        IF EMPTY(loc_cWrE)
                            loc_cWrE = ALLTRIM(STR(loc_nCodigo, 2))
                        ELSE
                            loc_cWrE = loc_cWrE + ", " + ALLTRIM(STR(loc_nCodigo, 2))
                        ENDIF
                        loc_nContE = loc_nContE + 1
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_nContE > 1
                loc_cWrE = "IN (" + loc_cWrE + ")"
            ELSE
                loc_cWrE = "= " + loc_cWrE
            ENDIF

            *-- Construir lista de codigos de Saida selecionados
            loc_cWrS   = ""
            loc_nContS = 0
            IF USED(loc_cCursorS)
                SELECT (loc_cCursorS)
                GO TOP
                SCAN
                    IF SelImp
                        loc_nCodigo = Codigos
                        IF EMPTY(loc_cWrS)
                            loc_cWrS = ALLTRIM(STR(loc_nCodigo, 2))
                        ELSE
                            loc_cWrS = loc_cWrS + ", " + ALLTRIM(STR(loc_nCodigo, 2))
                        ENDIF
                        loc_nContS = loc_nContS + 1
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_nContS > 1
                loc_cWrS = "IN (" + loc_cWrS + ")"
            ELSE
                loc_cWrS = "= " + loc_cWrS
            ENDIF

            *-- Filtros opcionais de empresa e conta para SQL
            IF EMPTY(THIS.this_cEmpresa)
                loc_cEmpresaFiltro = ""
            ELSE
                loc_cEmpresaFiltro = "n.Emps = " + EscaparSQL(THIS.this_cEmpresa) + " AND "
            ENDIF

            IF EMPTY(THIS.this_cConta)
                loc_cContaFiltro = ""
            ELSE
                loc_cContaFiltro = "c.IClis = " + EscaparSQL(THIS.this_cConta) + " AND "
            ENDIF

            *-- Query principal: UNION ALL de Entradas e Saidas (replica lcQuery do original)
            loc_cQuery = ;
                "SELECT ' ' AS Baixas, 'E' AS Movimento, " + ;
                "n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, " + ;
                "n.TotNotas, n.ValICms, n.ICmsS, n.ValIpis, " + ;
                "n.CliFors, c.Razaos, c.Estas, n.EmpDopNums " + ;
                "FROM SigCdOpe o, SigMvNfi n, SigCdCli c " + ;
                "WHERE o.TipoOps " + loc_cWrE + " AND " + ;
                "o.NFiscals IN (1, 2) AND " + ;
                "o.Dopes = n.Dopes AND " + ;
                "n.Emis BETWEEN " + loc_cDtInicialSQL + " AND " + loc_cDtFinalSQL + ;
                " AND " + loc_cEmpresaFiltro + ;
                "LEFT(n.CliFors, 10) = c.IClis AND " + ;
                loc_cContaFiltro + "n.Cancelas = 0 " + ;
                "UNION ALL " + ;
                "SELECT ' ' AS Baixas, 'S' AS Movimento, " + ;
                "n.Emis, n.NFis, n.Series, n.CFis, n.CfoSubs, n.Emps, " + ;
                "n.TotNotas, n.ValICms, n.ICmsS, n.ValIpis, " + ;
                "n.CliFors, c.Razaos, c.Estas, n.EmpDopNums " + ;
                "FROM SigCdOpe o, SigMvNfi n, SigCdCli c " + ;
                "WHERE o.TipoOps " + loc_cWrS + " AND " + ;
                "o.NFiscals IN (1, 2) AND " + ;
                "o.Dopes = n.Dopes AND " + ;
                "n.Emis BETWEEN " + loc_cDtInicialSQL + " AND " + loc_cDtFinalSQL + ;
                " AND " + loc_cEmpresaFiltro + ;
                "LEFT(n.CliFors, 10) = c.IClis AND " + ;
                loc_cContaFiltro + "n.Cancelas = 0"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Dados1")

            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o ao buscar dados"

            ELSE
                *-- Processar baixas: para cada nota, verificar em SigMvCab/SigMvPec
                SELECT cursor_4c_Dados1
                GO TOP
                SCAN
                    loc_cEmpDopNums  = ALLTRIM(cursor_4c_Dados1.EmpDopNums)

                    loc_cQueryBaixas = ;
                        "SELECT e.EmpDopNums, p.EmpDopNums " + ;
                        "FROM SigMvCab e, SigCdOpe o, SigMvPec p, SigCdOpe o2 " + ;
                        "WHERE e.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
                        " AND o.Dopes = e.Dopes" + ;
                        " AND (1000000 * o.NDopes) + e.Numes = p.Codigos" + ;
                        " AND p.Dopes = o2.Dopes" + ;
                        " AND o2.CBxSubns = 1"

                    loc_nResultBaixas = SQLEXEC(gnConnHandle, loc_cQueryBaixas, "cursor_4c_Baixas")

                    IF loc_nResultBaixas > 0
                        SELECT cursor_4c_Baixas
                        GO TOP IN cursor_4c_Baixas
                        IF !EOF("cursor_4c_Baixas")
                            SELECT cursor_4c_Dados1
                            REPLACE Baixas WITH "X"
                        ENDIF
                        IF USED("cursor_4c_Baixas")
                            USE IN cursor_4c_Baixas
                        ENDIF
                        SELECT cursor_4c_Dados1
                    ENDIF
                ENDSCAN

                *-- Criar cursor final conforme tipo de relatorio
                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                IF THIS.this_nTipos = 1
                    *-- Detalhado: todos os registros ordenados
                    SELECT * FROM cursor_4c_Dados1 ;
                        INTO CURSOR (THIS.this_cCursorDados) READWRITE ;
                        ORDER BY Movimento, Emis, NFis, Series
                ELSE
                    *-- Resumido: agrupado por movimento, excluindo baixas
                    SELECT Movimento, ;
                           SUM(TotNotas) AS TotNotas, ;
                           SUM(ValICms)  AS ValICms, ;
                           SUM(ICmsS)    AS ICmsS, ;
                           SUM(ValIpis)  AS ValIpis ;
                        FROM cursor_4c_Dados1 ;
                        WHERE EMPTY(Baixas) ;
                        INTO CURSOR (THIS.this_cCursorDados) READWRITE ;
                        GROUP BY Movimento ;
                        ORDER BY Movimento
                ENDIF

                IF USED("cursor_4c_Dados1")
                    USE IN cursor_4c_Dados1
                ENDIF

                SELECT (THIS.this_cCursorDados)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Gera relatorio em preview na tela
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso, loc_cRelatorio
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipos = 1
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp1.frx"
                ELSE
                ENDIF
                THIS.ExecutarReportForm("SigReIp2", "PREVIEW", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso, loc_cRelatorio
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipos = 1
                    loc_cRelatorio = gc_4c_CaminhoReports + "SigReIp1.frx"
                ELSE
                ENDIF
                THIS.ExecutarReportForm("SigReIp2", "PRINTER_PROMPT", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
