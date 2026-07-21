*==============================================================================
* SIGRECTPBO.PRG
* Business Object para Relatorio de Cotacao de Compras
* Herda de RelatorioBase
* Formulario original: SIGRECTP (sigrectp.SCX)
*
* Tabelas: SigCtTdc (cabecalho), SigCtTct (itens), SigCtTfn (fornecedores),
*           SigCtTps (pedidos gerados), sigcdusu (usuarios)
*==============================================================================

DEFINE CLASS SIGRECTPBO AS RelatorioBase

    *-- Arquivo e titulo do relatorio
    this_cArquivoRelatorio  = ""
    this_cTituloRelatorio   = ""

    *-- Cursor de saida do relatorio
    this_cCursorDados       = "crImpressao"

    *-- Filtros de periodo de cotacao (obrigatorios)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de periodo de validade (opcionais)
    this_dDtValidIs         = {}
    this_dDtValidFs         = {}

    *-- Filtro de comprador (sigcdusu.Usuarios, MaxLen 10)
    this_cComprador         = ""

    *-- Filtro de aprovador (sigcdusu.Usuarios, MaxLen 10)
    this_cAprovador         = ""

    *-- Filtro de produto: codigo (SigCtTct.cpros, MaxLen 14) e descricao (SigCtTct.dpros)
    this_cCPros             = ""
    this_cDPros             = ""

    *-- Filtro de fornecedor: codigo (SigCtTfn.iclis, MaxLen 10) e nome (SigCdCli.rclis)
    this_cIClis             = ""
    this_cRClis             = ""

    *-- Filtro pedidos: 1=Sim (tem pedido gerado), 2=Nao, 3=Ambos (default 3)
    this_nPedidos           = 3

    *-- Filtro aprovados: 1=Sim (chkaprovs=1), 2=Nao (chkaprovs=0), 3=Ambos (default 3)
    this_nAprovados         = 3

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de cotacao de compras
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "relsigrectp.frx"
            THIS.this_cTituloRelatorio  = "Relat" + CHR(243) + "rio de Cota" + ;
                                          CHR(231) + CHR(227) + "o de Compras"
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de preparar dados.
    * Equivalente a loNegocios.ValidaBotoes(loObj) do legado.
    * Retorna "": filtros validos
    * Retorna "DataInicial": data inicial vazia ou invalida
    * Retorna "DataFinal":   data final vazia ou invalida
    * Retorna "Periodo":     data final < data inicial (cotacao)
    * Retorna "PeriodoV":    data validade final < data validade inicial
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial)
            RETURN "DataInicial"
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            RETURN "DataFinal"
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            RETURN "Periodo"
        ENDIF
        IF !EMPTY(THIS.this_dDtValidIs) AND !EMPTY(THIS.this_dDtValidFs)
            IF THIS.this_dDtValidFs < THIS.this_dDtValidIs
                RETURN "PeriodoV"
            ENDIF
        ENDIF
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor crImpressao com dados de cotacoes de
    * compras conforme filtros definidos nas propriedades this_*.
    * Equivalente ao PROCEDURE processamento do legado SIGRECTP.
    * Tambem cria cursor crCabecalho para cabecalho do relatorio FRX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_cWhere, loc_cJoin, loc_nResult
        LOCAL loc_cDtIniSQL, loc_cDtFimSQL
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            *-- Fechar cursor anterior se aberto
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Formatar datas para SQL Server (datetime)
            loc_cDtIniSQL = "'" + ;
                PADL(YEAR(THIS.this_dDtInicial),  4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDtInicial), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDtInicial),   2, "0") + " 00:00:00'"
            loc_cDtFimSQL = "'" + ;
                PADL(YEAR(THIS.this_dDtFinal),  4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDtFinal), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDtFinal),   2, "0") + " 23:59:59'"

            *-- Clausula WHERE base: periodo de cotacao (obrigatorio)
            loc_cWhere = "dc.dtcotas >= " + loc_cDtIniSQL + ;
                         " AND dc.dtcotas <= " + loc_cDtFimSQL

            *-- Filtro periodo de validade (opcional - apenas se ambas preenchidas)
            IF !EMPTY(THIS.this_dDtValidIs)
                loc_cWhere = loc_cWhere + ;
                    " AND dc.dtvalids >= '" + ;
                    PADL(YEAR(THIS.this_dDtValidIs),  4, "0") + "-" + ;
                    PADL(MONTH(THIS.this_dDtValidIs), 2, "0") + "-" + ;
                    PADL(DAY(THIS.this_dDtValidIs),   2, "0") + " 00:00:00'"
            ENDIF
            IF !EMPTY(THIS.this_dDtValidFs)
                loc_cWhere = loc_cWhere + ;
                    " AND dc.dtvalids <= '" + ;
                    PADL(YEAR(THIS.this_dDtValidFs),  4, "0") + "-" + ;
                    PADL(MONTH(THIS.this_dDtValidFs), 2, "0") + "-" + ;
                    PADL(DAY(THIS.this_dDtValidFs),   2, "0") + " 23:59:59'"
            ENDIF

            *-- Filtro comprador
            IF !EMPTY(ALLTRIM(THIS.this_cComprador))
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(dc.comprador) = " + EscaparSQL(ALLTRIM(THIS.this_cComprador))
            ENDIF

            *-- Filtro aprovador
            IF !EMPTY(ALLTRIM(THIS.this_cAprovador))
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(dc.aprovador) = " + EscaparSQL(ALLTRIM(THIS.this_cAprovador))
            ENDIF

            *-- Filtro aprovados (chkaprovs: 0=nao aprovado, 1=aprovado)
            IF THIS.this_nAprovados = 1
                loc_cWhere = loc_cWhere + " AND dc.chkaprovs = 1"
            ENDIF
            IF THIS.this_nAprovados = 2
                loc_cWhere = loc_cWhere + " AND dc.chkaprovs = 0"
            ENDIF

            *-- Filtro pedidos via EXISTS em SigCtTps
            IF THIS.this_nPedidos = 1
                loc_cWhere = loc_cWhere + ;
                    " AND EXISTS (SELECT 1 FROM SigCtTps ps" + ;
                    " WHERE ps.codigos = dc.codigos)"
            ENDIF
            IF THIS.this_nPedidos = 2
                loc_cWhere = loc_cWhere + ;
                    " AND NOT EXISTS (SELECT 1 FROM SigCtTps ps" + ;
                    " WHERE ps.codigos = dc.codigos)"
            ENDIF

            *-- JOINs adicionais para filtros de produto e fornecedor
            loc_cJoin = ""

            IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                loc_cJoin  = loc_cJoin + ;
                    " INNER JOIN SigCtTct ct ON ct.codigos = dc.codigos"
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(ct.cpros) = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cIClis))
                loc_cJoin  = loc_cJoin + ;
                    " INNER JOIN SigCtTfn fn ON fn.codigos = dc.codigos"
                loc_cWhere = loc_cWhere + ;
                    " AND RTRIM(fn.iclis) = " + EscaparSQL(ALLTRIM(THIS.this_cIClis))
            ENDIF

            *-- SELECT principal: cabecalho da cotacao com nomes dos usuarios
            loc_cSQL = "SELECT DISTINCT" + ;
                " dc.codigos, dc.dtcotas, dc.dtvalids, dc.dtsolics," + ;
                " dc.dtpagtos, dc.dtaprovs," + ;
                " RTRIM(dc.comprador) AS comprador," + ;
                " RTRIM(dc.aprovador) AS aprovador," + ;
                " RTRIM(dc.solicitas) AS solicitas," + ;
                " RTRIM(dc.aprsols)   AS aprsols," + ;
                " dc.situas, dc.prioris," + ;
                " dc.chkaprovs, dc.localents, dc.copias," + ;
                " RTRIM(dc.deptos)   AS deptos," + ;
                " RTRIM(dc.contaes)  AS contaes," + ;
                " ISNULL(RTRIM(u1.ncomps), '') AS ncomp_comprador," + ;
                " ISNULL(RTRIM(u2.ncomps), '') AS ncomp_aprovador" + ;
                " FROM SigCtTdc dc" + ;
                " LEFT JOIN sigcdusu u1 ON RTRIM(u1.usuarios) = RTRIM(dc.comprador)" + ;
                " LEFT JOIN sigcdusu u2 ON RTRIM(u2.usuarios) = RTRIM(dc.aprovador)" + ;
                loc_cJoin + ;
                " WHERE " + loc_cWhere + ;
                " ORDER BY dc.codigos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de cota" + ;
                    CHR(231) + CHR(227) + "o de compras"
                loc_lSucesso = .F.
            ELSE
                *-- Cursor de cabecalho para o FRX
                loc_cEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)
                loc_cTitulo  = THIS.this_cTituloRelatorio
                loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                    DTOC(THIS.this_dDtInicial) + " " + CHR(150) + " " + DTOC(THIS.this_dDtFinal)

                IF USED("crCabecalho")
                    USE IN crCabecalho
                ENDIF
                CREATE CURSOR crCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
                INSERT INTO crCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                    VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

                SELECT (THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave descritiva para auditoria (periodo+filtros)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTituloRelatorio)
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_dDtFinal)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cComprador))
            loc_cChave = loc_cChave + "|comp:" + ALLTRIM(THIS.this_cComprador)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cIClis))
            loc_cChave = loc_cChave + "|forn:" + ALLTRIM(THIS.this_cIClis)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cOperacao
        loc_lSucesso = .F.
        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
                            par_cOperacao, "VISUALIZAR")
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Operacao, Tabela, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cOperacao) + "," + ;
                EscaparSQL("RELATORIO_COTACAO_COMPRAS") + "," + ;
                EscaparSQL(THIS.ObterChavePrimaria()) + "," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(ALLTRIM(THIS.this_cTituloRelatorio)) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar auditoria"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de parametros salvos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) ;
               OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(par_cAliasCursor)
                loc_lSucesso = .F.
            ELSE
                loc_cAlias = ALLTRIM(par_cAliasCursor)
                SELECT (loc_cAlias)
                IF !EOF()
                    IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                        THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_final") = "D"
                        THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".dt_final")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_valid_i") = "D"
                        THIS.this_dDtValidIs = EVALUATE(loc_cAlias + ".dt_valid_i")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_valid_f") = "D"
                        THIS.this_dDtValidFs = EVALUATE(loc_cAlias + ".dt_valid_f")
                    ENDIF
                    IF TYPE(loc_cAlias + ".comprador") = "C"
                        THIS.this_cComprador = ALLTRIM(EVALUATE(loc_cAlias + ".comprador"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".aprovador") = "C"
                        THIS.this_cAprovador = ALLTRIM(EVALUATE(loc_cAlias + ".aprovador"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cpros") = "C"
                        THIS.this_cCPros = ALLTRIM(EVALUATE(loc_cAlias + ".cpros"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".dpros") = "C"
                        THIS.this_cDPros = ALLTRIM(EVALUATE(loc_cAlias + ".dpros"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".iclis") = "C"
                        THIS.this_cIClis = ALLTRIM(EVALUATE(loc_cAlias + ".iclis"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".rclis") = "C"
                        THIS.this_cRClis = ALLTRIM(EVALUATE(loc_cAlias + ".rclis"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".n_pedidos") = "N"
                        THIS.this_nPedidos = IIF(BETWEEN(EVALUATE(loc_cAlias + ".n_pedidos"), 1, 3), ;
                            EVALUATE(loc_cAlias + ".n_pedidos"), 3)
                    ENDIF
                    IF TYPE(loc_cAlias + ".n_aprovados") = "N"
                        THIS.this_nAprovados = IIF(BETWEEN(EVALUATE(loc_cAlias + ".n_aprovados"), 1, 3), ;
                            EVALUATE(loc_cAlias + ".n_aprovados"), 3)
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o grava registros. Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o altera registros. Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores abertos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
