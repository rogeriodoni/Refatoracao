*==============================================================================
* SIGREEQRBO.PRG
* Business Object para Relatorio de Posicao de Estoque Retroativo
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS SIGREEQRBO AS RelatorioBase

    *-- Filtros: Empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: Grupo de Produto
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Filtros: Data de Saldo (usada quando this_nRfEstoque = 2)
    this_dDataSaldo     = {}

    *-- Filtros: Moeda para Conversao
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: Grupo de Calculo de Custo (visivel quando this_nCalcusto = 2)
    this_cCdGrupoCalc   = ""
    this_cDsGrupoCalc   = ""

    *-- Opcao de referencia de estoque: 1=Atual, 2=em data especifica
    this_nRfEstoque     = 1

    *-- Opcao de calculo de custo: 1=Total, 2=por Grupo
    this_nCalcusto      = 1

    *-- Nomes dos cursores de resultado produzidos pelo processamento
    this_cCursorGrupos      = "csTempoGr"
    this_cCursorProdutos    = "CsTempoCp"
    this_cCursorCabecalho   = "dbCabecalho"
    this_cCursorSelecao     = "Selecao"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarSelecao - Cria cursor Selecao com grupos/contas de estoque
    * Chamado pelo Form no Init para popular o grid de selecao interativa
    *--------------------------------------------------------------------------
    PROCEDURE InicializarSelecao()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                *-- Grupos de estoque ativos (estoques = 1)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos FROM SigCdGcr WHERE estoques = 1", ;
                    "TmpGccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar grupos de estoque"
                    EXIT
                ENDIF

                *-- Clientes vinculados aos grupos de estoque
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT b.grupos, b.iclis" + ;
                    " FROM SigCdCli b INNER JOIN SigCdGcr c ON b.grupos = c.codigos" + ;
                    " WHERE c.internos = '                    '" + ;
                    " AND c.estoques = 1", ;
                    "TmpCliGccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar clientes por grupo"
                    EXIT
                ENDIF

                *-- Combina grupos (linhas pai) e contas (linhas filhas) em Selecao
                IF USED("Selecao")
                    USE IN Selecao
                ENDIF

                SELECT 0 AS marcas, codigos AS grupos, SPACE(10) AS contas ;
                    FROM TmpGccr ;
                UNION ALL ;
                SELECT 0 AS marcas, grupos, iclis AS contas ;
                    FROM TmpCliGccr ;
                INTO CURSOR Selecao READWRITE

                IF !USED("Selecao")
                    CREATE CURSOR Selecao (marcas n(1), grupos c(10), contas c(10))
                ENDIF

                SELECT Selecao
                GO TOP
                INDEX ON grupos + contas TAG grucon

                IF USED("TmpGccr")
                    USE IN TmpGccr
                ENDIF
                IF USED("TmpCliGccr")
                    USE IN TmpCliGccr
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de posicao de estoque retroativo
    * Usa: cursor Selecao (populado e marcado pelo usuario no form)
    * Produz: cursors csTempoGr, CsTempoCp, dbCabecalho
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cCdEmpresa, loc_cCdGrupo, loc_nImpCusto, loc_nRfEstoque
        LOCAL loc_dDataSaldo, loc_cMoeda, loc_cGrpCalc
        LOCAL loc_cDatas, loc_dDataConv
        LOCAL loc_cCbTitulo, loc_cCbGrupo, loc_cCbEmpresa
        LOCAL loc_lcCpro, loc_mValGr
        LOCAL loc_cAno, loc_cMes, loc_cDia

        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cCdEmpresa = ALLTRIM(THIS.this_cCdEmpresa)
                loc_cCdGrupo   = ALLTRIM(THIS.this_cCdGrupo)
                loc_nImpCusto  = THIS.this_nCalcusto
                loc_nRfEstoque = THIS.this_nRfEstoque
                loc_dDataSaldo = THIS.this_dDataSaldo
                loc_cMoeda     = ALLTRIM(THIS.this_cCdMoeda)
                loc_cGrpCalc   = ALLTRIM(THIS.this_cCdGrupoCalc)

                *-- Formata data para SQL Server: YYYY-MM-DD HH:MM:SS
                IF EMPTY(loc_dDataSaldo)
                    loc_dDataSaldo = DATE()
                ENDIF
                loc_dDataSaldo = MAX(loc_dDataSaldo, CTOD("01/01/1900"))
                loc_cAno   = PADL(TRANSFORM(YEAR(loc_dDataSaldo)),  4, "0")
                loc_cMes   = PADL(TRANSFORM(MONTH(loc_dDataSaldo)), 2, "0")
                loc_cDia   = PADL(TRANSFORM(DAY(loc_dDataSaldo)),   2, "0")
                loc_cDatas = loc_cAno + "-" + loc_cMes + "-" + loc_cDia + " 23:59:59"

                *-- Cursor de cabecalho para o relatorio
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100))
                loc_cCbEmpresa = ALLTRIM(THIS.this_cDsEmpresa)
                loc_cCbTitulo  = "Posi" + CHR(231) + CHR(227) + "o de Estoque Retroativo " + ;
                    IIF(loc_nRfEstoque = 1, "Atual", "em " + DTOC(loc_dDataSaldo))
                loc_cCbGrupo   = "Grupo p/Calculo de Custo : " + ;
                    IIF(EMPTY(loc_cGrpCalc), "Geral", loc_cGrpCalc) + ;
                    "  Grupo de Produto: " + ;
                    IIF(EMPTY(loc_cCdGrupo), "Geral", ;
                        loc_cCdGrupo + " - " + ALLTRIM(THIS.this_cDsGrupo))
                INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                    VALUES (loc_cCbTitulo, loc_cCbGrupo, loc_cCbEmpresa)

                *-- Cursor de agrupamentos (totais por grupo/conta/linha)
                IF USED("csTempoGr")
                    USE IN csTempoGr
                ENDIF
                CREATE CURSOR csTempoGr ( ;
                    grupos c(10), contas c(10), linhas c(10), ;
                    tpesos n(12,2), tqtds n(12,3), vlvenda n(12,2), ;
                    moevenda c(3), vlcusto n(12,2), moecusto c(3), ;
                    tipos c(1), Quebra c(1))
                INDEX ON tipos + grupos + contas + Quebra + linhas + ;
                    moevenda + moecusto TAG Imprimir

                *-- Cursor de produtos (detalhe por produto)
                IF USED("CsTempoCp")
                    USE IN CsTempoCp
                ENDIF
                CREATE CURSOR CsTempoCp ( ;
                    cpros c(14), dpros c(40), tpesos n(12,2), tqtds n(12,3), ;
                    vlvenda n(12,2), moevenda c(3), vlcusto n(12,2), moecusto c(3), ;
                    tipos c(1), grupos c(10), contas c(10), linhas c(10), Quebra c(1))
                INDEX ON Tipos + grupos + contas + Quebra + linhas + cpros TAG Imprimir
                INDEX ON Grupos + Contas + Linhas + Cpros TAG visualizar

                *-- Busca movimentacoes conforme modo: estoque atual ou retroativo
                IF loc_nRfEstoque = 1
                    *-- Estoque atual: saldo corrente em SigMvEst
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros, a.emps, a.grupos, a.estos," + ;
                        " a.sqtds, a.sqtds AS qtds, c.Dpros, c.Linhas," + ;
                        " c.custofs, c.pvens, c.fvendas, c.moepvs," + ;
                        " c.pesoms, c.moecusfs, c.moevs, d.tpcustos, d.tpvendas" + ;
                        " FROM SigMvEst a" + ;
                        " INNER JOIN SigCdPro c ON a.cpros = c.cpros" + ;
                        " INNER JOIN SigCdLin d ON c.Linhas = d.Linhas" + ;
                        " WHERE a.emps = " + EscaparSQL(loc_cCdEmpresa) + ;
                        " AND a.sqtds <> 0" + ;
                        IIF(!EMPTY(loc_cCdGrupo), ;
                            " AND c.cgrus = " + EscaparSQL(loc_cCdGrupo), "") + ;
                        " ORDER BY a.cpros, a.emps, a.grupos, a.estos", ;
                        "CsTmpEst")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar estoque atual"
                        EXIT
                    ENDIF
                    loc_dDataConv = DATE()
                ELSE
                    *-- Estoque retroativo: historico SigMvHst ate a data informada
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.emps, a.grupos, a.estos, a.cpros," + ;
                        " a.qtds, a.opers, c.Dpros, c.Linhas," + ;
                        " c.custofs, c.pvens, c.fvendas, c.moepvs," + ;
                        " c.pesoms, c.moecusfs, c.moevs, f.tpcustos, f.tpvendas" + ;
                        " FROM SigMvHst a" + ;
                        " LEFT JOIN SigCdPro c ON a.cpros = c.Cpros" + ;
                        " LEFT JOIN SigCdLin f ON c.Linhas = f.Linhas" + ;
                        " WHERE a.emps = " + EscaparSQL(loc_cCdEmpresa) + ;
                        " AND a.datas <= '" + loc_cDatas + "'" + ;
                        IIF(!EMPTY(loc_cCdGrupo), ;
                            " AND c.cgrus = " + EscaparSQL(loc_cCdGrupo), ""), ;
                        "TmpEstPro")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar historico de estoque"
                        EXIT
                    ENDIF

                    *-- Calcula saldo: soma entradas (E=+1) e saidas (S=-1)
                    SELECT emps, grupos, estos, cpros, ;
                        SUM(qtds * IIF(opers = "E", 1, -1)) AS qtds, ;
                        Dpros, Linhas, custofs, pvens, fvendas, moepvs, ;
                        pesoms, moecusfs, moevs, tpcustos, tpvendas ;
                    FROM TmpEstPro ;
                    GROUP BY emps, grupos, estos, cpros, Dpros, Linhas, ;
                        custofs, pvens, fvendas, moepvs, pesoms, ;
                        moecusfs, moevs, tpcustos, tpvendas ;
                    HAVING SUM(qtds * IIF(opers = "E", 1, -1)) <> 0 ;
                    INTO CURSOR CsTmpEst

                    IF USED("TmpEstPro")
                        USE IN TmpEstPro
                    ENDIF
                    loc_dDataConv = loc_dDataSaldo
                ENDIF

                *-- Filtra pelos grupos/contas marcados no grid Selecao
                IF USED("TmpEst")
                    USE IN TmpEst
                ENDIF
                SELECT DISTINCT ;
                    a.cpros, a.emps, a.grupos, a.estos, a.qtds, ;
                    a.Dpros, a.Linhas, a.custofs, a.pvens, a.fvendas, ;
                    a.moepvs, a.pesoms, a.moecusfs, a.moevs, ;
                    a.tpcustos, a.tpvendas ;
                FROM CsTmpEst a, Selecao b ;
                WHERE a.grupos = b.grupos ;
                    AND IIF(!EMPTY(b.contas), a.estos = b.contas, .T.) ;
                    AND b.marcas = 1 ;
                INTO CURSOR TmpEst ;
                ORDER BY a.cpros

                IF USED("CsTmpEst")
                    USE IN CsTmpEst
                ENDIF

                *-- Processa produtos: calcula custos, converte moeda, acumula por grupo
                SELECT TmpEst
                GO TOP
                loc_lcCpro = SPACE(14)

                SCAN
                    SCATTER MEMVAR
                    m.vlCusto  = m.custofs
                    m.vlvenda  = ROUND(m.pvens * ;
                        IIF(m.fvendas <> 0 .AND. !EMPTY(m.moepvs), m.fvendas, 1), 2)
                    m.moecusto = m.moecusfs
                    m.moevenda = m.moevs
                    m.tqtds    = m.qtds
                    m.tpesos   = m.pesoms * m.qtds
                    m.contas   = m.estos
                    m.tipos    = " "
                    m.Quebra   = " "

                    IF m.tpcustos = "2"
                        m.vlCusto = m.pesoms * m.vlCusto
                    ENDIF
                    IF m.tpvendas = "2"
                        m.vlvenda = m.pesoms * m.vlvenda
                    ENDIF

                    *-- Custo por composicao (quando opt_calcusto = 2 = por grupo)
                    IF loc_nImpCusto = 2
                        IF m.cpros <> loc_lcCpro
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT cpros, cgrus, pcompos, qtds, moeds" + ;
                                " FROM SigPrCpo" + ;
                                " WHERE cpros = " + EscaparSQL(m.cpros) + ;
                                " AND cgrus = " + EscaparSQL(loc_cGrpCalc), ;
                                "CrSigPrCpo")
                        ENDIF
                        IF loc_nResult >= 0
                            loc_mValGr = 0
                            SELECT CrSigPrCpo
                            SCAN
                                loc_mValGr = loc_mValGr + ;
                                    ((CrSigPrCpo.pcompos * CrSigPrCpo.qtds) * ;
                                    fBuscarCotacao(CrSigPrCpo.moeds, loc_dDataConv, gnConnHandle) / ;
                                    fBuscarCotacao(m.moecusto, loc_dDataConv, gnConnHandle))
                            ENDSCAN
                            m.vlcusto = loc_mValGr
                            IF USED("CrSigPrCpo")
                                USE IN CrSigPrCpo
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Converte valores para moeda solicitada (quando informada)
                    IF !EMPTY(loc_cMoeda)
                        m.vlcusto  = m.vlcusto * ;
                            fBuscarCotacao(m.moecusto, loc_dDataConv, gnConnHandle) / ;
                            fBuscarCotacao(loc_cMoeda,  loc_dDataConv, gnConnHandle)
                        m.vlvenda  = m.vlvenda * ;
                            fBuscarCotacao(m.moevenda, loc_dDataConv, gnConnHandle) / ;
                            fBuscarCotacao(loc_cMoeda,  loc_dDataConv, gnConnHandle)
                        m.moecusto = loc_cMoeda
                        m.moevenda = loc_cMoeda
                    ENDIF

                    m.vlvenda = m.vlvenda * m.qtds
                    m.vlcusto = m.vlcusto * m.qtds

                    *-- Registra detalhe do produto em CsTempoCp
                    SELECT CsTempoCp
                    APPEND BLANK
                    GATHER MEMVAR

                    *-- Acumula totais por grupo em csTempoGr (usa index Imprimir)
                    SELECT csTempoGr
                    IF !SEEK(" " + m.grupos + m.contas + " " + m.linhas + ;
                            m.moevenda + m.moecusto)
                        APPEND BLANK
                        GATHER MEMVAR
                        REPLACE csTempoGr.tqtds   WITH 0
                        REPLACE csTempoGr.tpesos  WITH 0
                        REPLACE csTempoGr.vlvenda WITH 0
                        REPLACE csTempoGr.vlCusto WITH 0
                    ENDIF
                    REPLACE csTempoGr.tqtds   WITH csTempoGr.tqtds   + m.tqtds
                    REPLACE csTempoGr.tpesos  WITH csTempoGr.tpesos  + m.tpesos
                    REPLACE csTempoGr.vlVenda WITH csTempoGr.vlVenda + m.vlvenda
                    REPLACE csTempoGr.vlcusto WITH csTempoGr.vlcusto + m.vlcusto

                    IF m.cpros <> loc_lcCpro
                        loc_lcCpro = m.cpros
                    ENDIF
                    SELECT TmpEst
                ENDSCAN

                *-- Calcula totais: por linha (tipo 5), geral (tipo 6), subtotal por grupo
                IF USED("Tempo")
                    USE IN Tempo
                ENDIF
                SELECT "5" AS tipos, PADR("Tot Linha", 10) AS grupos, ;
                    SPACE(10) AS contas, linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, " " AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 4, 8, 10 ;
                UNION ALL ;
                SELECT "6" AS tipos, PADR("Tot Geral", 10) AS grupos, ;
                    SPACE(10) AS contas, SPACE(10) AS linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, " " AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 8, 10 ;
                UNION ALL ;
                SELECT " " AS tipos, grupos, contas, PADR("Total", 10) AS linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, "1" AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 2, 3, 8, 10 ;
                INTO CURSOR Tempo

                *-- Linha separadora no cursor de grupos
                SELECT csTempoGr
                APPEND BLANK
                REPLACE csTempoGr.Tipos    WITH "2"
                REPLACE csTempoGr.Grupos   WITH "----------"
                REPLACE csTempoGr.Contas   WITH "----------"
                REPLACE csTempoGr.Linhas   WITH "----------"
                REPLACE csTempoGr.moevenda WITH "---"
                REPLACE csTempoGr.moecusto WITH "---"

                *-- Mescla totais calculados nos cursores de saida
                SELECT Tempo
                SCAN
                    SCATTER MEMVAR
                    SELECT csTempoGr
                    APPEND BLANK
                    GATHER MEMVAR
                    SELECT CsTempoCp
                    APPEND BLANK
                    GATHER MEMVAR
                ENDSCAN

                IF USED("Tempo")
                    USE IN Tempo
                ENDIF
                IF USED("TmpEst")
                    USE IN TmpEst
                ENDIF

                SELECT csTempoGr
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
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
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReEqr") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
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
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReEqr") TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Retorna identificador composto dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cData
        loc_cData = IIF(EMPTY(THIS.this_dDataSaldo), "", DTOC(THIS.this_dDataSaldo))
        loc_cChave = "EMP=" + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";GRU=" + ALLTRIM(THIS.this_cCdGrupo) + ;
                     ";RFE=" + TRANSFORM(THIS.this_nRfEstoque) + ;
                     ";DTS=" + loc_cData + ;
                     ";MOE=" + ALLTRIM(THIS.this_cCdMoeda) + ;
                     ";CUS=" + TRANSFORM(THIS.this_nCalcusto) + ;
                     ";GCC=" + ALLTRIM(THIS.this_cCdGrupoCalc)
        RETURN loc_cChave
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
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                    loc_lSucesso = .F.
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.cCdGrupo") = "C"
                        THIS.this_cCdGrupo = ALLTRIM(m.cCdGrupo)
                    ENDIF
                    IF TYPE("m.cDsGrupo") = "C"
                        THIS.this_cDsGrupo = ALLTRIM(m.cDsGrupo)
                    ENDIF
                    IF TYPE("m.dDataSaldo") = "D"
                        THIS.this_dDataSaldo = m.dDataSaldo
                    ENDIF
                    IF TYPE("m.cCdMoeda") = "C"
                        THIS.this_cCdMoeda = ALLTRIM(m.cCdMoeda)
                    ENDIF
                    IF TYPE("m.cDsMoeda") = "C"
                        THIS.this_cDsMoeda = ALLTRIM(m.cDsMoeda)
                    ENDIF
                    IF TYPE("m.cCdGrupoCalc") = "C"
                        THIS.this_cCdGrupoCalc = ALLTRIM(m.cCdGrupoCalc)
                    ENDIF
                    IF TYPE("m.cDsGrupoCalc") = "C"
                        THIS.this_cDsGrupoCalc = ALLTRIM(m.cDsGrupoCalc)
                    ENDIF
                    IF TYPE("m.nRfEstoque") = "N"
                        THIS.this_nRfEstoque = m.nRfEstoque
                    ENDIF
                    IF TYPE("m.nCalcusto") = "N"
                        THIS.this_nCalcusto = m.nCalcusto
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
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
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        loc_lValido = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nCalcusto = 2 .AND. ;
               EMPTY(ALLTRIM(THIS.this_cCdGrupoCalc))
                THIS.this_cMensagemErro = "Grupo de C" + CHR(225) + "lculo Obrigat" + ;
                                          CHR(243) + "rio"
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nRfEstoque = 2 .AND. ;
               EMPTY(THIS.this_dDataSaldo)
                THIS.this_cMensagemErro = "Data do Saldo obrigat" + CHR(243) + ;
                                          "ria para estoque retroativo"
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
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
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        loc_lValido = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nCalcusto = 2 .AND. ;
               EMPTY(ALLTRIM(THIS.this_cCdGrupoCalc))
                THIS.this_cMensagemErro = "Grupo de C" + CHR(225) + "lculo Obrigat" + ;
                                          CHR(243) + "rio"
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nRfEstoque = 2 .AND. ;
               EMPTY(THIS.this_dDataSaldo)
                THIS.this_cMensagemErro = "Data do Saldo obrigat" + CHR(243) + ;
                                          "ria para estoque retroativo"
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
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
                       EscaparSQL("SigReEqr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("Selecao")
            USE IN Selecao
        ENDIF
        IF USED("csTempoGr")
            USE IN csTempoGr
        ENDIF
        IF USED("CsTempoCp")
            USE IN CsTempoCp
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("TmpGccr")
            USE IN TmpGccr
        ENDIF
        IF USED("TmpCliGccr")
            USE IN TmpCliGccr
        ENDIF
        IF USED("CsTmpEst")
            USE IN CsTmpEst
        ENDIF
        IF USED("TmpEstPro")
            USE IN TmpEstPro
        ENDIF
        IF USED("TmpEst")
            USE IN TmpEst
        ENDIF
        IF USED("Tempo")
            USE IN Tempo
        ENDIF
        IF USED("CrSigPrCpo")
            USE IN CrSigPrCpo
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
