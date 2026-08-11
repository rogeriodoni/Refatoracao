*==============================================================================
* SIGREFFI BO - Relatorio de Fluxo Financeiro Analitico
*
* Herda de RelatorioBase
* Processa dados de fluxo financeiro analitico com filtros por:
*   - Periodo (data inicial/final, tipo Vencimento/Lancamento)
*   - Moeda de referencia e moeda de conversao
*   - Tipo (Pagamentos/Recebimentos/Ambos)
*   - Situacao (1=Baixados 2=Abertos 3=Todos)
*   - Ordem de impressao (Vencimento/Grupo-Conta)
*   - Opcoes NF, Previsto, Saldo, Atrasos
*   - Empresas e Disponibilidades selecionaveis via grid
*   - Operacoes de titulos selecionaveis via grid
*==============================================================================

*-- Garante que RelatorioBase esta carregado
IF !("RELATORIOBASE" $ UPPER(SET("PROCEDURE")))
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "relatoriobase.prg") ADDITIVE
ENDIF

DEFINE CLASS sigreffiBO AS RelatorioBase

    *--------------------------------------------------------------------------
    * Propriedades de identificacao do relatorio
    *--------------------------------------------------------------------------
    this_cTabela       = ""
    this_cCampoChave   = ""
    this_cMensagemErro = ""

    *-- Nome do FRX e titulo do relatorio
    this_cFRX          = "SigReFfi"
    this_cTituloRel    = ""

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Periodo
    *--------------------------------------------------------------------------
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nTpData       = 1     && 1=Vencimento 2=Lancamento

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Moeda
    *--------------------------------------------------------------------------
    this_cCdMoeda      = ""    && Codigo moeda referencia (max 3)
    this_cDsMoeda      = ""    && Descricao moeda referencia (max 15)
    this_cMoeConv      = ""    && Codigo moeda de conversao (max 3)
    this_cDMoeConv     = ""    && Descricao moeda de conversao (max 15)

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Opcoes de tipo e situacao
    *--------------------------------------------------------------------------
    this_nNrTipo       = 3     && 1=Pagamentos 2=Recebimentos 3=Ambos
    this_nNrSitua      = 1     && 1=Baixados 2=Pendentes 3=Todos
    this_nOrdImp       = 1     && 1=Vencimento 2=Grupo/Conta
    this_nOpcoes       = 3     && 1=Com NF 2=Sem NF 3=Ambos (caption carregado de SigCdPac)
    this_nNrPrev       = 3     && 1=Sim(previsto) 2=Nao 3=Ambos

    *--------------------------------------------------------------------------
    * Propriedades de filtro: Saldo e Atrasos
    *--------------------------------------------------------------------------
    this_nSaldos       = 1     && 1=Anterior (data-1) 2=Na Data
    this_nConsAtra     = 2     && 1=Sim (considerar atrasos) 2=Nao
    this_nListaAtra    = 1     && 1=Sim (listar atrasos) 2=Nao
    this_nListaCodOp   = 2     && 1=Sim (listar codigo operacao) 2=Nao

    *--------------------------------------------------------------------------
    * Nomes dos cursores de dados
    *--------------------------------------------------------------------------
    this_cCursorEmp       = "cursor_4c_Emp"       && Empresas selecionaveis (cEmp no legado)
    this_cCursorDisp      = "cursor_4c_Disp"      && Disponibilidades selecionaveis (cDisp no legado)
    this_cCursorOper      = "cursor_4c_Oper"      && Operacoes de titulos (crSigOpOpe no legado)
    this_cCursorMoeda     = "cursor_4c_Moeda"     && Tabela de moedas (crSigCdMoe no legado)
    this_cCursorCotacao   = "cursor_4c_Cotacao"   && Cotacoes (crSigCdCot no legado)
    this_cCursorRec       = "cursor_4c_Rec"       && Grupos de recebimento (crSigCdRec no legado)
    this_cCursorCabecalho = "csCabecalho"         && Cabecalho do relatorio (nome exigido pelo FRX)
    this_cCursorRelatorio = "csRelatorio"         && Dados principais (nome exigido pelo FRX)
    this_cCursorDados     = "csRelatorio"         && Alias padrao exigido por RelatorioBase

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de processamento
    *--------------------------------------------------------------------------
    this_lCursoresCarregados = .F.   && Flag: cursores de grids ja inicializados

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ELSE
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
                THIS.this_dDtInicial = DATE()
                THIS.this_dDtFinal   = DATE()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursoresBase - Carrega cursores de selecao (Empresas, Disps, Oper)
    * Chamado pelo Form no InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursoresBase()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSqlOpe, loc_cSqlEmp, loc_cSqlDisp
        LOCAL loc_cSqlMoe, loc_cSqlCot, loc_cSqlRec
        LOCAL loc_nResult
        LOCAL loc_cCursorEmp, loc_cCursorDisp, loc_cCursorOper
        LOCAL loc_cCursorMoeda, loc_cCursorCotacao, loc_cCursorRec

        loc_lSucesso = .F.

        *-- Copiar nomes de cursor para locais (evitar THIS dentro de SCAN)
        loc_cCursorEmp     = THIS.this_cCursorEmp
        loc_cCursorDisp    = THIS.this_cCursorDisp
        loc_cCursorOper    = THIS.this_cCursorOper
        loc_cCursorMoeda   = THIS.this_cCursorMoeda
        loc_cCursorCotacao = THIS.this_cCursorCotacao
        loc_cCursorRec     = THIS.this_cCursorRec

        TRY
            *-- Cursor de operacoes de titulos (SigOpOpe - exceto canceladas)
            loc_cSqlOpe = "SELECT CAST(0 AS BIT) AS SeleOp, o.Dopes, o.Opers, o.RealPrevs " + ;
                          "FROM SigOpOpe o " + ;
                          "WHERE o.OpeCancs <> 1 " + ;
                          "ORDER BY o.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlOpe, loc_cCursorOper)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos"
            ELSE
                *-- Cursor de empresas (SigCdEmp)
                loc_cSqlEmp = "SELECT CAST(0 AS BIT) AS ImpEmps, e.Cemps, e.Razas " + ;
                              "FROM SigCdEmp e " + ;
                              "ORDER BY e.Razas"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, loc_cCursorEmp)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar empresas"
                ELSE
                    *-- Marcar empresa corrente como selecionada
                    LOCAL loc_cEmpAtual
                    loc_cEmpAtual = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                    SELECT (loc_cCursorEmp)
                    SCAN
                        IF ALLTRIM(Cemps) == loc_cEmpAtual
                            REPLACE ImpEmps WITH 1
                        ENDIF
                    ENDSCAN

                    *-- Cursor de disponibilidades (SigCdDis tipos 0 e 1)
                    loc_cSqlDisp = "SELECT CAST(1 AS BIT) AS ImpDisps, d.Grupos, d.Contas, d.Tipos " + ;
                                   "FROM SigCdDis d " + ;
                                   "WHERE d.Tipos IN (0, 1) " + ;
                                   "ORDER BY d.Grupos, d.Contas"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlDisp, loc_cCursorDisp)
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao carregar disponibilidades"
                    ELSE
                        *-- Cursor de moedas (SigCdMoe)
                        loc_cSqlMoe = "SELECT m.CMoes, m.DMoes, m.Cotas " + ;
                                      "FROM SigCdMoe m " + ;
                                      "ORDER BY m.CMoes"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlMoe, loc_cCursorMoeda)
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao carregar moedas"
                        ELSE
                            *-- Cursor de cotacoes (SigCdCot)
                            loc_cSqlCot = "SELECT c.CMoes, c.Datas, c.Valos " + ;
                                          "FROM SigCdCot c " + ;
                                          "ORDER BY c.CMoes, c.Datas"

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlCot, loc_cCursorCotacao)
                            IF loc_nResult < 0
                                THIS.this_cMensagemErro = "Erro ao carregar cota" + CHR(231) + CHR(245) + "es"
                            ELSE
                                *-- Cursor de grupos de recebimento (SigCdRec)
                                loc_cSqlRec = "SELECT r.Grupos " + ;
                                              "FROM SigCdRec r " + ;
                                              "ORDER BY r.Grupos"

                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlRec, loc_cCursorRec)
                                IF loc_nResult < 0
                                    THIS.this_cMensagemErro = "Erro ao carregar grupos de recebimento"
                                ELSE
                                    THIS.this_lCursoresCarregados = .T.
                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.CarregarCursoresBase")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCaptionsOpcoes - Carrega captions de optOpcoes de SigCdPac
    * par_aResult deve ser dimensionado com 3 posicoes pelo chamador
    * Preenche par_aResult[1..3] com captions customizados ou padrao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCaptionsOpcoes(par_aResult)
        LOCAL loc_cSql, loc_nResult

        par_aResult[1] = "Sim"
        par_aResult[2] = "N" + CHR(227) + "o"
        par_aResult[3] = "Ambos"

        TRY
            loc_cSql = "SELECT TOP 1 TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pac")
            IF loc_nResult > 0
                SELECT cursor_4c_Pac
                GO TOP
                IF !EOF()
                    IF !EMPTY(cursor_4c_Pac.TitOpcS)
                        par_aResult[1] = ALLTRIM(cursor_4c_Pac.TitOpcS)
                    ENDIF
                    IF !EMPTY(cursor_4c_Pac.TitOpcN)
                        par_aResult[2] = ALLTRIM(cursor_4c_Pac.TitOpcN)
                    ENDIF
                    IF !EMPTY(cursor_4c_Pac.TitOpcA)
                        par_aResult[3] = ALLTRIM(cursor_4c_Pac.TitOpcA)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.CarregarCaptionsOpcoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacaoMoeda - Busca cotacao de moeda na data informada
    * Retorna valor numerico da cotacao (1 se nao encontrar)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacaoMoeda(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSql, loc_nResult

        loc_nCotacao = 1

        IF EMPTY(par_cMoeda)
            RETURN loc_nCotacao
        ENDIF

        TRY
            loc_cSql = "SELECT TOP 1 Valos FROM SigCdCot " + ;
                       "WHERE CMoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                       " AND Datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY Datas DESC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CotMoe")
            IF loc_nResult > 0
                SELECT cursor_4c_CotMoe
                GO TOP
                IF !EOF()
                    loc_nCotacao = IIF(cursor_4c_CotMoe.Valos = 0, 1, cursor_4c_CotMoe.Valos)
                ENDIF
                IF USED("cursor_4c_CotMoe")
                    USE IN cursor_4c_CotMoe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.BuscarCotacaoMoeda")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados para o relatorio de fluxo financeiro
    * Monta cursor_4c_Relatorio e cursor_4c_Cabecalho para o FRX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cCdMoeda, loc_cDsMoeda, loc_cMoeConv
        LOCAL loc_nNrTipo, loc_nNrPrev, loc_nNrSitua, loc_nOrdImp
        LOCAL loc_nOpcoes, loc_nTpData, loc_nSaldos
        LOCAL loc_nConsAtra, loc_nListaAtra, loc_nListaCodOp
        LOCAL loc_nVlCotacao
        LOCAL loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo, loc_cCbEmpresa
        LOCAL loc_cSql, loc_nResult

        loc_lSucesso = .F.

        TRY
            *-- Capturar valores dos filtros
            loc_dDtInicial   = THIS.this_dDtInicial
            loc_dDtFinal     = THIS.this_dDtFinal
            loc_cCdMoeda     = ALLTRIM(THIS.this_cCdMoeda)
            loc_cDsMoeda     = ALLTRIM(THIS.this_cDsMoeda)
            loc_nNrTipo      = THIS.this_nNrTipo
            loc_nNrPrev      = THIS.this_nNrPrev
            loc_nNrSitua     = THIS.this_nNrSitua
            loc_nOrdImp      = THIS.this_nOrdImp
            loc_nOpcoes      = THIS.this_nOpcoes
            loc_nTpData      = THIS.this_nTpData
            loc_nSaldos      = THIS.this_nSaldos
            loc_cMoeConv     = ALLTRIM(THIS.this_cMoeConv)
            loc_nConsAtra    = THIS.this_nConsAtra
            loc_nListaAtra   = THIS.this_nListaAtra
            loc_nListaCodOp  = THIS.this_nListaCodOp

            *-- Cotacao da moeda de conversao
            loc_nVlCotacao = THIS.BuscarCotacaoMoeda(loc_cMoeConv, DATE())
            IF loc_nVlCotacao = 0
                loc_nVlCotacao = 1
            ENDIF

            *-- Buscar nome da empresa corrente
            loc_cNmEmpresa = ""
            loc_cSql = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_NmEmp")
            IF loc_nResult > 0
                SELECT cursor_4c_NmEmp
                GO TOP
                IF !EOF()
                    loc_cNmEmpresa = ALLTRIM(cursor_4c_NmEmp.Razas)
                ENDIF
                IF USED("cursor_4c_NmEmp")
                    USE IN cursor_4c_NmEmp
                ENDIF
            ENDIF

            *-- Montar titulo e periodo
            loc_cNmTitulo = "Fluxo Financeiro Anal" + CHR(237) + "tico [" + ;
                IIF(loc_nNrTipo = 1, "Pagamentos", ;
                    IIF(loc_nNrTipo = 2, "Recebimentos", "Todos")) + "]"

            loc_cNmPeriodo = "Periodo: " + DTOC(loc_dDtInicial) + " " + CHR(224) + " " + ;
                DTOC(loc_dDtFinal) + " " + ;
                IIF(loc_nTpData = 1, "Vencimento", "Lan" + CHR(231) + "amento")

            loc_cCbEmpresa = ""
            IF loc_nNrSitua <> 3
                loc_cCbEmpresa = "   Situa" + CHR(231) + CHR(227) + "o: " + ;
                    IIF(loc_nNrSitua = 1, "Baixados", "Pendentes")
            ENDIF

            *-- Criar cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (nm_empresa C(80), nm_titulo C(80), nm_periodo C(80), ;
                 cb_empresa C(80), cb_Moe_Ref C(3), ConsidAtra N(1))

            INSERT INTO (THIS.this_cCursorCabecalho) ;
                (nm_empresa, nm_titulo, nm_periodo, cb_empresa, cb_Moe_Ref, ConsidAtra) ;
                VALUES (loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo, ;
                        loc_cCbEmpresa, loc_cMoeConv, loc_nConsAtra)

            *-- Criar cursor principal do relatorio
            IF USED(THIS.this_cCursorRelatorio)
                USE IN (THIS.this_cCursorRelatorio)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorRelatorio) ;
                (moedas C(3), dsmoedas C(15), vencs D, grupos C(10), contas C(10), ;
                 dopcs C(20), dscontas C(40), valors N(12,2), hists C(200), ;
                 flpagos C(1), quebras N(6), subquebras N(6), cstotals C(50), ;
                 Fase N(1), Saldos N(12,2), vl_Convertido N(12,2), ;
                 flPrevs C(2), Opers C(1))

            *-- Processar saldos de disponibilidades (Fase=1)
            IF !THIS.ProcessarSaldosDisponibilidades(loc_cCdMoeda, loc_dDtInicial, ;
                   loc_nSaldos, loc_nOpcoes, loc_nVlCotacao)
                MsgErro(THIS.this_cMensagemErro, "PrepararDados - Saldos")
            ENDIF

            *-- Processar atrasos se solicitado (Fase=3)
            IF loc_nListaAtra = 1
                IF !THIS.ProcessarAtrasos(loc_dDtInicial, loc_cCdMoeda, ;
                       loc_nNrTipo, loc_nNrPrev, loc_nOpcoes, ;
                       loc_nListaCodOp, loc_nVlCotacao)
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados - Atrasos")
                ENDIF
            ENDIF

            *-- Processar fluxo do periodo (Fase=2)
            IF !THIS.ProcessarFluxoPeriodo(loc_dDtInicial, loc_dDtFinal, loc_cCdMoeda, ;
                   loc_nNrTipo, loc_nNrPrev, loc_nNrSitua, loc_nOrdImp, loc_nOpcoes, ;
                   loc_nTpData, loc_nListaCodOp, loc_nVlCotacao)
                MsgErro(THIS.this_cMensagemErro, "PrepararDados - Periodo")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarSaldosDisponibilidades - Processa saldos iniciais (Fase=1)
    * Busca saldo anterior ao periodo para disponibilidades selecionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarSaldosDisponibilidades(par_cCdMoeda, par_dDtInicial, ;
        par_nSaldos, par_nOpcoes, par_nVlCotacao)

        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSql, loc_nResult
        LOCAL loc_cFiltroMoeda, loc_dDataCalc
        LOCAL loc_cCursorDisp, loc_cCursorMoeda, loc_cCursorRel

        loc_lSucesso = .F.
        loc_cCursorDisp  = THIS.this_cCursorDisp
        loc_cCursorMoeda = THIS.this_cCursorMoeda
        loc_cCursorRel   = THIS.this_cCursorRelatorio

        TRY
            loc_cFiltroMoeda = ""
            IF !EMPTY(par_cCdMoeda)
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(par_cCdMoeda)
            ENDIF

            *-- Data base para saldo: dia anterior se Anterior, propria data se Na Data
            loc_dDataCalc = IIF(par_nSaldos = 1, par_dDtInicial - 1, par_dDtInicial)

            *-- Buscar cruzamento SigMvSlc x SigCdCli para disponibilidades
            loc_cSql = "SELECT a.Grupos, a.Contas, a.Moedas, b.cContabs " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON b.IClis = a.Contas " + ;
                       "WHERE 1=1 " + loc_cFiltroMoeda + ;
                       " ORDER BY a.Grupos, a.Contas, a.Moedas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_MvSlc")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar movimenta" + CHR(231) + CHR(227) + "o de saldo"
            ELSE
                *-- Percorrer disponibilidades selecionadas
                LOCAL loc_cGrDisp, loc_cCtDisp, loc_nImpDisp
                SELECT (loc_cCursorDisp)
                GO TOP
                SCAN
                    loc_cGrDisp  = ALLTRIM(Grupos)
                    loc_cCtDisp  = ALLTRIM(Contas)
                    loc_nImpDisp = ImpDisps

                    IF loc_nImpDisp <> 1
                        LOOP
                    ENDIF

                    *-- Para cada linha do cursor MvSlc que bate com esta conta
                    LOCAL loc_cGrMvSlc, loc_cCtMvSlc, loc_cMoesMvSlc, loc_cContabs
                    SELECT cursor_4c_MvSlc
                    GO TOP
                    SCAN
                        loc_cGrMvSlc  = ALLTRIM(cursor_4c_MvSlc.Grupos)
                        loc_cCtMvSlc  = ALLTRIM(cursor_4c_MvSlc.Contas)
                        loc_cMoesMvSlc= ALLTRIM(cursor_4c_MvSlc.Moedas)
                        loc_cContabs  = ALLTRIM(cursor_4c_MvSlc.cContabs)

                        IF loc_cGrMvSlc <> loc_cGrDisp OR loc_cCtMvSlc <> loc_cCtDisp
                            LOOP
                        ENDIF

                        *-- Aplicar filtro de opcoes (NF ou nao NF) via cContabs
                        LOCAL loc_lPassaOpc
                        loc_lPassaOpc = .T.
                        IF par_nOpcoes = 1
                            loc_lPassaOpc = !EMPTY(loc_cContabs)
                        ELSE
                            IF par_nOpcoes = 2
                            loc_lPassaOpc = EMPTY(loc_cContabs)
                            ENDIF
                        ENDIF

                        IF !loc_lPassaOpc
                            LOOP
                        ENDIF

                        *-- Buscar ultimo saldo no SigMvCcr ate a data base
                        LOCAL loc_cGruConMoes, loc_cFiltroMoeInner, loc_cSqlSaldo
                        LOCAL loc_nSaldo, loc_nResSaldo
                        loc_cGruConMoes     = loc_cGrMvSlc + loc_cCtMvSlc + loc_cMoesMvSlc
                        loc_cFiltroMoeInner = ""
                        IF !EMPTY(par_cCdMoeda)
                            loc_cFiltroMoeInner = " AND Moedas = " + EscaparSQL(par_cCdMoeda)
                        ENDIF

                        loc_cSqlSaldo = "SELECT TOP 1 Saldos FROM SigMvCcr " + ;
                                        "WHERE GruConMoes = " + EscaparSQL(loc_cGruConMoes) + ;
                                        loc_cFiltroMoeInner + ;
                                        " AND Datas <= " + FormatarDataSQL(loc_dDataCalc) + ;
                                        " ORDER BY GruConMoes ASC, cIdChaves DESC"

                        loc_nSaldo     = 0
                        loc_nResSaldo  = SQLEXEC(gnConnHandle, loc_cSqlSaldo, "cursor_4c_Ccr")
                        IF loc_nResSaldo > 0
                            SELECT cursor_4c_Ccr
                            GO TOP
                            IF !EOF()
                                loc_nSaldo = cursor_4c_Ccr.Saldos
                            ENDIF
                            IF USED("cursor_4c_Ccr")
                                USE IN cursor_4c_Ccr
                            ENDIF
                        ENDIF

                        IF loc_nSaldo <> 0
                            *-- Buscar descricao da moeda
                            LOCAL loc_cDsMoedaLinha, loc_cMoeLinha
                            loc_cDsMoedaLinha = ""
                            loc_cMoeLinha     = loc_cMoesMvSlc
                            IF USED(loc_cCursorMoeda)
                                SELECT (loc_cCursorMoeda)
                                GO TOP
                                SCAN
                                    IF ALLTRIM(CMoes) == loc_cMoeLinha
                                        loc_cDsMoedaLinha = ALLTRIM(DMoes)
                                        EXIT
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            *-- Calcular conversao
                            LOCAL loc_nCtRef, loc_nVlConv
                            loc_nCtRef = THIS.BuscarCotacaoMoeda(loc_cMoeLinha, DATE())
                            IF loc_nCtRef = 0
                                loc_nCtRef = 1
                            ENDIF
                            loc_nVlConv = (loc_nSaldo * loc_nCtRef / par_nVlCotacao)

                            SELECT (loc_cCursorRel)
                            INSERT INTO (loc_cCursorRel) ;
                                (Grupos, Contas, Moedas, Saldos, Fase, DsMoedas, Vl_Convertido) ;
                                VALUES (loc_cGrDisp, loc_cCtDisp, ;
                                        loc_cMoeLinha, loc_nSaldo, 1, ;
                                        loc_cDsMoedaLinha, loc_nVlConv)
                        ENDIF

                        SELECT cursor_4c_MvSlc
                    ENDSCAN

                    SELECT (loc_cCursorDisp)
                ENDSCAN

                IF USED("cursor_4c_MvSlc")
                    USE IN cursor_4c_MvSlc
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.ProcessarSaldosDisponibilidades")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarAtrasos - Processa titulos vencidos antes do periodo (Fase=3)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarAtrasos(par_dDtInicial, par_cCdMoeda, ;
        par_nNrTipo, par_nNrPrev, par_nOpcoes, ;
        par_nListaCodOp, par_nVlCotacao)

        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSql, loc_nResult
        LOCAL loc_cFiltroMoeda, loc_cFiltroNF, loc_cFiltroPrev
        LOCAL loc_cCursorEmp, loc_cCursorMoeda, loc_cCursorRel

        loc_lSucesso = .F.
        loc_cCursorEmp   = THIS.this_cCursorEmp
        loc_cCursorMoeda = THIS.this_cCursorMoeda
        loc_cCursorRel   = THIS.this_cCursorRelatorio

        TRY
            loc_cFiltroMoeda = ""
            IF !EMPTY(par_cCdMoeda)
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(par_cCdMoeda)
            ENDIF

            loc_cFiltroNF = ""
            IF par_nOpcoes = 1
                loc_cFiltroNF = " AND a.Nfs IS NOT NULL AND LTRIM(RTRIM(a.Nfs)) <> ''"
            ELSE
                IF par_nOpcoes = 2
                loc_cFiltroNF = " AND (a.Nfs IS NULL OR LTRIM(RTRIM(a.Nfs)) = '')"
                ENDIF
            ENDIF

            loc_cFiltroPrev = ""
            IF par_nNrPrev = 1
                loc_cFiltroPrev = " AND b.ValPres = 2"
            ELSE
                IF par_nNrPrev = 2
                loc_cFiltroPrev = " AND b.ValPres <> 2"
                ENDIF
            ENDIF

            loc_cSql = "SELECT a.Moedas, a.Vencs, a.Opers, a.Grupos, a.Contas, a.DopCs, " + ;
                       "a.Valors, a.Hists, a.ValPags, a.Emps, a.NOpers, " + ;
                       "a.CIdChaves, a.EmpDopNums, a.EmpDopNcs " + ;
                       "FROM SigMvCcr a " + ;
                       "INNER JOIN SigTempR b ON a.DopCs = b.Dopes " + ;
                       "WHERE a.Vencs < " + FormatarDataSQL(par_dDtInicial) + ;
                       " AND a.TitCancs <> 1 " + ;
                       loc_cFiltroMoeda + loc_cFiltroNF + loc_cFiltroPrev + ;
                       " ORDER BY a.Moedas, a.Vencs, a.Grupos, a.Contas, a.CIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Atrasos")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar atrasos"
            ELSE
                LOCAL loc_cEmpAtr, loc_nImpEmpAtr, loc_lEmpSel
                LOCAL loc_nValors, loc_nValPags, loc_nSaldoAtr
                LOCAL loc_cFlPagos, loc_cHistAtr, loc_cEDN
                LOCAL loc_cMoesAtr, loc_cDsMoesAtr, loc_cOpersAtr
                LOCAL loc_nCtRefAtr, loc_nVlConvAtr

                SELECT cursor_4c_Atrasos
                GO TOP
                SCAN
                    loc_cEmpAtr = ALLTRIM(cursor_4c_Atrasos.Emps)

                    *-- Verificar se empresa esta selecionada no grid
                    loc_lEmpSel = .F.
                    IF USED(loc_cCursorEmp)
                        SELECT (loc_cCursorEmp)
                        GO TOP
                        SCAN
                            IF ALLTRIM(Cemps) == loc_cEmpAtr
                                loc_nImpEmpAtr = ImpEmps
                                IF loc_nImpEmpAtr = 1
                                    loc_lEmpSel = .T.
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Atrasos

                    IF !loc_lEmpSel
                        LOOP
                    ENDIF

                    loc_nValors   = cursor_4c_Atrasos.Valors
                    loc_nValPags  = cursor_4c_Atrasos.ValPags
                    loc_nSaldoAtr = loc_nValors - loc_nValPags

                    IF loc_nSaldoAtr <= 0
                        LOOP
                    ENDIF

                    loc_cFlPagos  = IIF(loc_nValPags >= loc_nValors, "*", "")
                    loc_cHistAtr  = ALLTRIM(cursor_4c_Atrasos.Hists)
                    loc_cMoesAtr  = ALLTRIM(cursor_4c_Atrasos.Moedas)
                    loc_cOpersAtr = ALLTRIM(cursor_4c_Atrasos.Opers)

                    IF par_nListaCodOp = 1
                        loc_cEDN = ALLTRIM(cursor_4c_Atrasos.EmpDopNums)
                        IF VAL(RIGHT(loc_cEDN, 6)) > 0
                            loc_cHistAtr = loc_cHistAtr + loc_cEDN
                        ELSE
                            loc_cHistAtr = loc_cHistAtr + ALLTRIM(cursor_4c_Atrasos.EmpDopNcs)
                        ENDIF
                    ENDIF

                    *-- Buscar descricao da moeda
                    loc_cDsMoesAtr = ""
                    IF USED(loc_cCursorMoeda)
                        SELECT (loc_cCursorMoeda)
                        GO TOP
                        SCAN
                            IF ALLTRIM(CMoes) == loc_cMoesAtr
                                loc_cDsMoesAtr = ALLTRIM(DMoes)
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Atrasos

                    *-- Calcular conversao
                    loc_nCtRefAtr = THIS.BuscarCotacaoMoeda(loc_cMoesAtr, DATE())
                    IF loc_nCtRefAtr = 0
                        loc_nCtRefAtr = 1
                    ENDIF
                    loc_nVlConvAtr = (loc_nSaldoAtr * loc_nCtRefAtr / par_nVlCotacao)

                    SELECT (loc_cCursorRel)
                    INSERT INTO (loc_cCursorRel) ;
                        (Moedas, DsMoedas, Vencs, Grupos, Contas, DopCs, Valors, ;
                         Hists, FlPagos, Fase, Saldos, Vl_Convertido, FlPrevs, Opers) ;
                        VALUES (loc_cMoesAtr, loc_cDsMoesAtr, ;
                                cursor_4c_Atrasos.Vencs, ;
                                ALLTRIM(cursor_4c_Atrasos.Grupos), ;
                                ALLTRIM(cursor_4c_Atrasos.Contas), ;
                                ALLTRIM(cursor_4c_Atrasos.DopCs), ;
                                loc_nSaldoAtr, loc_cHistAtr, loc_cFlPagos, ;
                                3, 0, loc_nVlConvAtr, "", loc_cOpersAtr)

                    SELECT cursor_4c_Atrasos
                ENDSCAN

                IF USED("cursor_4c_Atrasos")
                    USE IN cursor_4c_Atrasos
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.ProcessarAtrasos")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarFluxoPeriodo - Processa fluxo do periodo principal (Fase=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarFluxoPeriodo(par_dDtInicial, par_dDtFinal, par_cCdMoeda, ;
        par_nNrTipo, par_nNrPrev, par_nNrSitua, par_nOrdImp, par_nOpcoes, ;
        par_nTpData, par_nListaCodOp, par_nVlCotacao)

        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSql, loc_nResult
        LOCAL loc_cFiltroMoeda, loc_cFiltroNF, loc_cFiltroPrev
        LOCAL loc_cCampData, loc_cOrder
        LOCAL loc_cCursorEmp, loc_cCursorMoeda, loc_cCursorRel

        loc_lSucesso = .F.
        loc_cCursorEmp   = THIS.this_cCursorEmp
        loc_cCursorMoeda = THIS.this_cCursorMoeda
        loc_cCursorRel   = THIS.this_cCursorRelatorio

        TRY
            loc_cFiltroMoeda = ""
            IF !EMPTY(par_cCdMoeda)
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(par_cCdMoeda)
            ENDIF

            loc_cFiltroNF = ""
            IF par_nOpcoes = 1
                loc_cFiltroNF = " AND a.Nfs IS NOT NULL AND LTRIM(RTRIM(a.Nfs)) <> ''"
            ELSE
                IF par_nOpcoes = 2
                loc_cFiltroNF = " AND (a.Nfs IS NULL OR LTRIM(RTRIM(a.Nfs)) = '')"
                ENDIF
            ENDIF

            loc_cFiltroPrev = ""
            IF par_nNrPrev = 1
                loc_cFiltroPrev = " AND b.ValPres = 2"
            ELSE
                IF par_nNrPrev = 2
                loc_cFiltroPrev = " AND b.ValPres <> 2"
                ENDIF
            ENDIF

            *-- Campo de data conforme tipo selecionado
            loc_cCampData = IIF(par_nTpData = 1, "a.Vencs", "a.Datas")

            *-- Ordem de impressao
            IF par_nOrdImp = 1
                loc_cOrder = " ORDER BY a.Moedas, a.Vencs, a.Grupos, a.Contas, a.CIdChaves"
            ELSE
                loc_cOrder = " ORDER BY a.Moedas, a.Grupos, a.Contas, a.Vencs, a.CIdChaves"
            ENDIF

            loc_cSql = "SELECT a.Moedas, a.Vencs, a.Opers, a.Grupos, a.Contas, a.DopCs, " + ;
                       "a.Valors, a.Hists, a.ValPags, a.Emps, a.NOpers, a.CIdChaves, " + ;
                       "0 AS nPrevs, a.EmpDopNums, a.EmpDopNcs " + ;
                       "FROM SigMvCcr a " + ;
                       "INNER JOIN SigTempR b ON a.DopCs = b.Dopes " + ;
                       "WHERE " + loc_cCampData + " >= " + FormatarDataSQL(par_dDtInicial) + ;
                       " AND " + loc_cCampData + " <= " + FormatarDataSQL(par_dDtFinal) + ;
                       " AND a.TitCancs <> 1 " + ;
                       loc_cFiltroMoeda + loc_cFiltroNF + loc_cFiltroPrev + ;
                       loc_cOrder

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Periodo")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar fluxo do per" + CHR(237) + "odo"
            ELSE
                LOCAL loc_cEmpPer, loc_nImpEmpPer, loc_lEmpSelPer
                LOCAL loc_nValPer, loc_nPagPer, loc_nSaldoPer
                LOCAL loc_cFlPagosPer, loc_cHistPer, loc_cEDNPer
                LOCAL loc_cMoesPer, loc_cDsMoesPer, loc_cOpersPer
                LOCAL loc_nCtRefPer, loc_nVlConvPer

                SELECT cursor_4c_Periodo
                GO TOP
                SCAN
                    loc_cEmpPer = ALLTRIM(cursor_4c_Periodo.Emps)

                    *-- Verificar se empresa esta selecionada
                    loc_lEmpSelPer = .F.
                    IF USED(loc_cCursorEmp)
                        SELECT (loc_cCursorEmp)
                        GO TOP
                        SCAN
                            IF ALLTRIM(Cemps) == loc_cEmpPer
                                loc_nImpEmpPer = ImpEmps
                                IF loc_nImpEmpPer = 1
                                    loc_lEmpSelPer = .T.
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Periodo

                    IF !loc_lEmpSelPer
                        LOOP
                    ENDIF

                    loc_nValPer   = cursor_4c_Periodo.Valors
                    loc_nPagPer   = cursor_4c_Periodo.ValPags
                    loc_nSaldoPer = loc_nValPer - loc_nPagPer

                    IF par_nNrSitua = 1
                        IF loc_nPagPer < loc_nValPer
                            LOOP
                        ENDIF
                    ELSE
                        IF par_nNrSitua = 2
                            IF loc_nPagPer >= loc_nValPer
                                LOOP
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_cFlPagosPer = IIF(loc_nPagPer >= loc_nValPer, "*", "")
                    loc_cHistPer    = ALLTRIM(cursor_4c_Periodo.Hists)
                    loc_cMoesPer    = ALLTRIM(cursor_4c_Periodo.Moedas)
                    loc_cOpersPer   = ALLTRIM(cursor_4c_Periodo.Opers)

                    IF par_nListaCodOp = 1
                        loc_cEDNPer = ALLTRIM(cursor_4c_Periodo.EmpDopNums)
                        IF VAL(RIGHT(loc_cEDNPer, 6)) > 0
                            loc_cHistPer = loc_cHistPer + loc_cEDNPer
                        ELSE
                            loc_cHistPer = loc_cHistPer + ALLTRIM(cursor_4c_Periodo.EmpDopNcs)
                        ENDIF
                    ENDIF

                    *-- Buscar descricao da moeda
                    loc_cDsMoesPer = ""
                    IF USED(loc_cCursorMoeda)
                        SELECT (loc_cCursorMoeda)
                        GO TOP
                        SCAN
                            IF ALLTRIM(CMoes) == loc_cMoesPer
                                loc_cDsMoesPer = ALLTRIM(DMoes)
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_Periodo

                    *-- Calcular conversao
                    loc_nCtRefPer = THIS.BuscarCotacaoMoeda(loc_cMoesPer, DATE())
                    IF loc_nCtRefPer = 0
                        loc_nCtRefPer = 1
                    ENDIF
                    loc_nVlConvPer = (loc_nSaldoPer * loc_nCtRefPer / par_nVlCotacao)

                    SELECT (loc_cCursorRel)
                    INSERT INTO (loc_cCursorRel) ;
                        (Moedas, DsMoedas, Vencs, Grupos, Contas, DopCs, Valors, ;
                         Hists, FlPagos, Fase, Saldos, Vl_Convertido, FlPrevs, Opers) ;
                        VALUES (loc_cMoesPer, loc_cDsMoesPer, ;
                                cursor_4c_Periodo.Vencs, ;
                                ALLTRIM(cursor_4c_Periodo.Grupos), ;
                                ALLTRIM(cursor_4c_Periodo.Contas), ;
                                ALLTRIM(cursor_4c_Periodo.DopCs), ;
                                loc_nSaldoPer, loc_cHistPer, loc_cFlPagosPer, ;
                                2, 0, loc_nVlConvPer, "", loc_cOpersPer)

                    SELECT cursor_4c_Periodo
                ENDSCAN

                IF USED("cursor_4c_Periodo")
                    USE IN cursor_4c_Periodo
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.ProcessarFluxoPeriodo")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para a impressora (com prompt)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorRelatorio)
                    SELECT (THIS.this_cCursorRelatorio)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cFRX) ;
                        TO PRINTER PROMPT NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.Imprimir")
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
                IF USED(THIS.this_cCursorRelatorio)
                    SELECT (THIS.this_cCursorRelatorio)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cFRX) PREVIEW NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LiberarCursores - Libera todos os cursores em memoria
    *--------------------------------------------------------------------------
    PROCEDURE LiberarCursores()
        LOCAL loc_aCursores(8), loc_nI

        loc_aCursores(1) = THIS.this_cCursorEmp
        loc_aCursores(2) = THIS.this_cCursorDisp
        loc_aCursores(3) = THIS.this_cCursorOper
        loc_aCursores(4) = THIS.this_cCursorMoeda
        loc_aCursores(5) = THIS.this_cCursorCotacao
        loc_aCursores(6) = THIS.this_cCursorRec
        loc_aCursores(7) = THIS.this_cCursorCabecalho
        loc_aCursores(8) = THIS.this_cCursorRelatorio

        FOR loc_nI = 1 TO 8
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarOperacoes - Marca todas as operacoes de titulos para impressao
    * Equivalente ao botao MarcarOpe.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarOperacoes()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorOper

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE SeleOp WITH .T.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.MarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarOperacoes - Desmarca todas as operacoes de titulos
    * Equivalente ao botao DesmarcarOpe.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarOperacoes()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorOper

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE SeleOp WITH .F.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.DesmarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecaoOperacao - Inverte selecao da operacao no registro atual
    * Equivalente ao CheckBox KeyPress/MouseDown do Grd_Oper.Column1
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecaoOperacao()
        LOCAL loc_cCursor, loc_lAtual
        loc_cCursor = THIS.this_cCursorOper

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF()
                    loc_lAtual = SeleOp
                    REPLACE SeleOp WITH !loc_lAtual
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.AlternarSelecaoOperacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmpresas - Marca todas as empresas para impressao
    * Equivalente ao botao MarcarEmp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarEmpresas()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorEmp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpEmps WITH .T.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.MarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarEmpresas - Desmarca todas as empresas
    * Equivalente ao botao DesmarcarEmp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarEmpresas()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorEmp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpEmps WITH .F.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.DesmarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecaoEmpresa - Inverte selecao da empresa no registro atual
    * Equivalente ao CheckBox KeyPress/MouseDown do Grid1.Column1
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecaoEmpresa()
        LOCAL loc_cCursor, loc_lAtual
        loc_cCursor = THIS.this_cCursorEmp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF()
                    loc_lAtual = ImpEmps
                    REPLACE ImpEmps WITH !loc_lAtual
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.AlternarSelecaoEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarDisponibilidades - Marca todas as disponibilidades para impressao
    * Equivalente ao botao MarcarDisp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarDisponibilidades()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorDisp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpDisps WITH .T.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.MarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarDisponibilidades - Desmarca todas as disponibilidades
    * Equivalente ao botao DesmarcarDisp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarDisponibilidades()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorDisp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    REPLACE ImpDisps WITH .F.
                ENDSCAN
                GO TOP IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.DesmarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecaoDisponibilidade - Inverte selecao da disponibilidade atual
    * Equivalente ao CheckBox KeyPress/MouseDown do Grid2.Column1
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecaoDisponibilidade()
        LOCAL loc_cCursor, loc_lAtual
        loc_cCursor = THIS.this_cCursorDisp

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF()
                    loc_lAtual = ImpDisps
                    REPLACE ImpDisps WITH !loc_lAtual
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffiBO.AlternarSelecaoDisponibilidade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LiberarCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE
