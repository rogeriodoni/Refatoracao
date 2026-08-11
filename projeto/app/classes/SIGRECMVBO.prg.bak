*==============================================================================
* SIGRECMVBO.PRG
* Business Object para Relatorio CMV - Custo Medio de Venda
*
* Herda de: RelatorioBase
* Tabela: SigCdCmv
* Chave: pkchaves = PADR(cpros,14) + PADL(mes,2,'0') + PADL(ano,4,'0')
* Relatorio: SigReCmv.frx
*==============================================================================

DEFINE CLASS SIGRECMVBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigCdCmv"
    this_cCampoChave    = "pkchaves"
    this_cMensagemErro  = ""

    *-- Filtros do formulario
    this_cMes           = ""    && Mes do calculo (formato "MM")
    this_cAno           = ""    && Ano do calculo (formato "YYYY")
    this_cNmOperacao    = ""    && Codigo da operacao de finalizacao da producao
    this_cGrupoMov      = ""    && Codigo do grupo de custo - credito (SigCdGcr.codigos)
    this_cDGrupoMov     = ""    && Descricao do grupo de custo - debito (SigCdGcr.descrs)
    this_cCdEstoque     = ""    && Codigo da conta de estoque (SigCdCli.iclis)
    this_cDsEstoque     = ""    && Descricao da conta de estoque (SigCdCli.rclis)
    this_cCdMoeda       = ""    && Codigo da moeda de conversao (SigCdMoe.CMoes)
    this_cDsMoeda       = ""    && Descricao da moeda (SigCdMoe.DMoes)

    *-- Valores calculados durante o processamento
    this_nCustoGrama    = 0     && Custo por grama produzida (lnCusGr no legado)
    this_nTotalCusto    = 0     && Total do custo de producao no periodo
    this_nTotalPeso     = 0     && Total do peso dos itens produzidos
    this_nTotalQtd      = 0     && Total de quantidade dos itens produzidos

    *-- Propriedades de registro SigCdCmv (CRUD individual)
    this_cPkChaves      = ""    && Chave primaria (cpros+mes+ano)
    this_cCpros         = ""    && Codigo do produto
    this_cDatas         = ""    && Periodo "MM/AAAA"
    this_cMoedas        = ""    && Codigo da moeda
    this_nValCuss       = 0     && Valor do custo unitario

    *-- Cursores de trabalho
    this_cCursorDados   = "crVenda"      && Cursor principal para o relatorio
    this_cCursorOpe     = "crSigCdOpe"   && Operacoes CMV filtradas
    this_cCursorPac     = "crSigCdPac"   && Configuracao padrao PAC
    this_cCursorCmv     = "crSigCdCmv"   && Cursor para gravacao em SigCdCmv

    *-- Configuracao do relatorio
    this_cCaminhoFRX    = ""
    this_cTitulo        = ""

    *--------------------------------------------------------------------------
    * Init - Configura titulo e caminho FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTitulo     = "CMV - Custo da Mercadoria Vendida"
            THIS.this_cCaminhoFRX = gc_4c_CaminhoReports + "SigReCmv.frx"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega cursores SigCdOpe/SigCdPac e define
    * valores default para os campos do formulario nas propriedades this_*
    * Retorna .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                *-- Carrega operacoes CMV (SigCdOpe filtrada por SigCdTom)
                loc_cSQL = "SELECT a.dopes FROM SigCdOpe a " + ;
                           "INNER JOIN SigCdTom b ON a.TipoOps = b.Codigos " + ;
                           "WHERE b.GeraCmvs = 1 AND a.vendas = 1 " + ;
                           "AND a.caixas = 1 AND a.copers = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpe)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es CMV"
                    EXIT
                ENDIF

                *-- Carrega configuracao padrao PAC
                loc_cSQL = "SELECT GruCmvs, ConCmvs, OpeCmvs FROM SigCdPac"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPac)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar configura" + CHR(231) + CHR(227) + CHR(227) + "o PAC"
                    EXIT
                ENDIF

                *-- Mes/ano atual como default
                THIS.this_cMes = PADL(MONTH(DATE()), 2, "0")
                THIS.this_cAno = PADL(YEAR(DATE()), 4, "0")

                *-- Preenche defaults da configuracao PAC
                SELECT (THIS.this_cCursorPac)
                IF !EOF()
                    THIS.this_cNmOperacao = ALLTRIM(NVL(OpeCmvs, ""))
                    THIS.this_cGrupoMov   = ALLTRIM(NVL(GruCmvs, ""))
                    THIS.this_cCdEstoque  = ALLTRIM(NVL(ConCmvs, ""))
                ENDIF

                *-- Busca descricao do grupo de custo (SigCdGcr)
                IF !EMPTY(THIS.this_cGrupoMov)
                    loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + ;
                               EscaparSQL(THIS.this_cGrupoMov)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruDescr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_GruDescr
                        IF !EOF()
                            THIS.this_cDGrupoMov = ALLTRIM(NVL(descrs, ""))
                        ENDIF
                        USE IN cursor_4c_GruDescr
                    ENDIF
                ENDIF

                *-- Busca descricao da conta de estoque (SigCdCli)
                IF !EMPTY(THIS.this_cCdEstoque)
                    loc_cSQL = "SELECT TOP 1 rclis FROM SigCdCli WHERE iclis = " + ;
                               EscaparSQL(THIS.this_cCdEstoque)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContDescr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_ContDescr
                        IF !EOF()
                            THIS.this_cDsEstoque = ALLTRIM(NVL(rclis, ""))
                        ENDIF
                        USE IN cursor_4c_ContDescr
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lOK
        loc_lOK = .T.

        IF EMPTY(THIS.this_cMes) OR EMPTY(THIS.this_cAno)
            THIS.this_cMensagemErro = "M" + CHR(234) + "s e Ano s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND EMPTY(THIS.this_cNmOperacao)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de finaliza" + CHR(231) + CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND (EMPTY(THIS.this_cGrupoMov) OR EMPTY(THIS.this_cCdEstoque))
            THIS.this_cMensagemErro = "Grupo e conta do custo da produ" + CHR(231) + CHR(227) + "o s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND EMPTY(THIS.this_cCdMoeda)
            THIS.this_cMensagemErro = "Moeda de convers" + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lOK = .F.
        ENDIF

        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao da moeda para a data especificada
    * par_cMoeda: codigo da moeda (SigCdCot.cmoes)
    * par_dData:  data de referencia
    * Retorna: valor numerico da cotacao (1.0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda) OR VARTYPE(par_dData) != "D" OR EMPTY(par_dData)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                       "WHERE cmoes = " + EscaparSQL(par_cMoeda) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")
            IF loc_nResult > 0
                SELECT cursor_4c_Cotacao
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cotacao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Calcula CMV (Custo da Mercadoria Vendida)
    * Reproduz a logica do PROCEDURE processamento do legado
    * Gera cursores crVenda e crCabec para o REPORT FORM
    * Grava em SigCdCmv se usuario confirmar
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cOpeFinal, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_nMes, loc_dDtIni, loc_dDtFin, loc_cDtIniSQL, loc_cDtFinSQL
        LOCAL loc_nCotaOpera, loc_lGrava
        LOCAL loc_nSal, loc_cGCM, loc_cMoeOpe, loc_nValor, loc_nCota
        LOCAL loc_nTotCusto, loc_nCusGr
        LOCAL loc_cDopes, loc_nCusto, loc_cMesAtual, loc_cMesItem, loc_cChave
        LOCAL loc_cMesCmvStr, loc_nMesCmv, loc_nAnoCmv, loc_dUltDiaMes
        LOCAL loc_cNmTitulo, loc_cDtPeriodo
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                *-- Captura filtros das propriedades this_*
                loc_cOpeFinal = ALLTRIM(THIS.this_cNmOperacao)
                loc_cGrupo    = ALLTRIM(THIS.this_cGrupoMov)
                loc_cConta    = ALLTRIM(THIS.this_cCdEstoque)
                loc_cMoeda    = ALLTRIM(THIS.this_cCdMoeda)

                *-- Calcula periodo: primeiro e ultimo dia do mes
                loc_nMes   = VAL(THIS.this_cMes)
                loc_dDtIni = DATE(VAL(THIS.this_cAno), loc_nMes, 1)
                IF loc_nMes >= 12
                    loc_dDtFin = DATE(VAL(THIS.this_cAno) + 1, 1, 1) - 1
                ELSE
                    loc_dDtFin = DATE(VAL(THIS.this_cAno), loc_nMes + 1, 1) - 1
                ENDIF
                loc_cDtIniSQL = FormatarDataSQL(loc_dDtIni)
                *-- Data final com 23:59:59 (equivalente a fDtoSQL com hora '23:59:00')
                loc_cDtFinSQL = "'" + PADL(YEAR(loc_dDtFin), 4, "0") + "-" + ;
                                PADL(MONTH(loc_dDtFin), 2, "0") + "-" + ;
                                PADL(DAY(loc_dDtFin), 2, "0") + " 23:59:59'"

                *-- Cotacao da moeda no ultimo dia do mes
                loc_nCotaOpera = THIS.BuscarCotacao(loc_cMoeda, loc_dDtFin)

                *-- Verifica se periodo ja foi calculado
                loc_cSQL = "SELECT DISTINCT valcuss FROM SigCdCmv WHERE datas = " + ;
                           EscaparSQL(PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0"))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoIte")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao verificar per" + CHR(237) + "odo (CustoIte)"
                    EXIT
                ENDIF

                loc_lGrava = .T.
                SELECT cursor_4c_CustoIte
                IF RECCOUNT("cursor_4c_CustoIte") > 0
                    loc_lGrava = MsgConfirma("Esse per" + CHR(237) + "odo j" + CHR(225) + ;
                                 " foi calculado o CMV. Gravar valor do recalculado?")
                ENDIF
                USE IN cursor_4c_CustoIte

                *-- Busca itens finalizados da producao (somente se operacao informada)
                IF !EMPTY(loc_cOpeFinal)
                    loc_cSQL = "SELECT cpros, qtds, pesos FROM SigMvItn " + ;
                               "WHERE Dopes = " + EscaparSQL(loc_cOpeFinal) + ;
                               " AND DtAlts BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar itens produzidos (crItens)"
                        EXIT
                    ENDIF
                ENDIF

                *-- Cria cursor temporario de acumulacao de custo
                SET NULL ON
                CREATE CURSOR cursor_4c_Custo (Saldos N(11,2))
                SET NULL OFF

                *-- Busca saldo do custo de producao (SigMvSlc + SigCdCli)
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                           "b.RClis, b.Situas, b.Cpfs, b.ContaMats, ' ' AS Matriz " + ;
                           "FROM SigMvSlc a, SigCdCli b " + ;
                           "WHERE a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                           " AND a.Contas = " + EscaparSQL(loc_cConta) + ;
                           " AND a.Contas = b.IClis " + ;
                           "ORDER BY a.Contas, a.Moedas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Saldo")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao buscar saldo de custo (crSaldo)"
                    EXIT
                ENDIF

                *-- Calcula saldo total convertendo moedas quando necessario
                loc_nSal = 0
                SELECT cursor_4c_Saldo
                SCAN
                    loc_cGCM    = ALLTRIM(cursor_4c_Saldo.Grupos) + ;
                                  ALLTRIM(cursor_4c_Saldo.Contas) + ;
                                  ALLTRIM(cursor_4c_Saldo.Moedas)
                    loc_cMoeOpe = ALLTRIM(cursor_4c_Saldo.Moedas)

                    loc_cSQL = "SELECT a.Saldos, a.Datas, a.Opers FROM SigMvCcr a " + ;
                               "WHERE a.GruConMoes = " + EscaparSQL(loc_cGCM) + ;
                               " AND a.Datas BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMcc1")
                    IF loc_nResult > 0
                        SELECT cursor_4c_TmpMcc1
                        SCAN
                            loc_nValor = cursor_4c_TmpMcc1.Saldos
                            IF loc_cMoeOpe <> loc_cMoeda
                                loc_nCota = THIS.BuscarCotacao(loc_cMoeOpe, cursor_4c_TmpMcc1.Datas)
                                IF loc_nCotaOpera <> 0
                                    loc_nValor = loc_nValor * loc_nCota / loc_nCotaOpera
                                ENDIF
                            ENDIF
                            IF ALLTRIM(cursor_4c_TmpMcc1.Opers) = "D"
                                loc_nSal = loc_nSal + ABS(loc_nValor)
                            ELSE
                                loc_nSal = loc_nSal - ABS(loc_nValor)
                            ENDIF
                            SELECT cursor_4c_TmpMcc1
                        ENDSCAN
                        USE IN cursor_4c_TmpMcc1
                    ENDIF

                    SELECT cursor_4c_Saldo
                ENDSCAN
                USE IN cursor_4c_Saldo

                *-- Registra saldo acumulado no cursor de custo
                SELECT cursor_4c_Custo
                INSERT INTO cursor_4c_Custo (Saldos) VALUES (loc_nSal)

                *-- Soma peso e quantidade dos itens produzidos
                IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                    SET NULL ON
                    SELECT SUM(Pesos) AS TotPeso, SUM(Qtds) AS TotQtd ;
                        FROM cursor_4c_Itens ;
                        INTO CURSOR cursor_4c_TotItens READWRITE
                    SET NULL OFF
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_TotItens (TotPeso N(11,2), TotQtd N(11,2))
                    SET NULL OFF
                    INSERT INTO cursor_4c_TotItens (TotPeso, TotQtd) VALUES (0, 0)
                ENDIF

                *-- Soma saldo total do custo de producao
                SELECT cursor_4c_Custo
                GO TOP
                SUM Saldos TO loc_nTotCusto

                *-- Calcula preco por grama produzida
                SELECT cursor_4c_TotItens
                IF NVL(cursor_4c_TotItens.TotPeso, 0) = 0 OR loc_nTotCusto = 0
                    MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel calcular " + ;
                        "o Custo do Grama Produzido desse per" + CHR(237) + "odo pois n" + CHR(227) + ;
                        "o teve nenhum produto vendido ou custo de produ" + CHR(231) + CHR(227) + ;
                        "o lan" + CHR(231) + "ada.", "CMV")
                    loc_nCusGr = 0
                ELSE
                    loc_nCusGr = ABS(loc_nTotCusto) / ABS(cursor_4c_TotItens.TotPeso)
                ENDIF

                *-- Salva valores calculados nas propriedades do BO
                THIS.this_nCustoGrama = loc_nCusGr
                THIS.this_nTotalCusto = loc_nTotCusto
                THIS.this_nTotalPeso  = NVL(cursor_4c_TotItens.TotPeso, 0)
                THIS.this_nTotalQtd   = NVL(cursor_4c_TotItens.TotQtd, 0)

                *-- Cria cursor principal do relatorio (crVenda) com estrutura do SigMvItn
                loc_cSQL = "SELECT 0 AS ordem, dopes, cpros, qtds, pesos, " + ;
                           "dtalts AS Datas, 00000000.0000 AS ValCuss, " + ;
                           "00000000.0000 AS TotCuss, '  ' AS MoeCuss " + ;
                           "FROM SigMvItn WHERE 0=1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao criar cursor de dados (crVenda)"
                    EXIT
                ENDIF

                *-- Linha 1: totais gerais da producao
                SELECT cursor_4c_TotItens
                INSERT INTO (THIS.this_cCursorDados) ;
                    (ordem, qtds, pesos, TotCuss, ValCuss, MoeCuss) ;
                    VALUES (1, NVL(cursor_4c_TotItens.TotQtd, 0), ;
                            NVL(cursor_4c_TotItens.TotPeso, 0), ;
                            ABS(loc_nTotCusto), loc_nCusGr, loc_cMoeda)

                *-- Calcula custo de cada item vendido por operacao CMV
                SELECT (THIS.this_cCursorOpe)
                SCAN
                    loc_cDopes = ALLTRIM(Dopes)

                    loc_cSQL = "SELECT 2 AS ordem, a.dopes, a.cpros, a.qtds, a.pesos, " + ;
                               "b.Datas, 00000000.0000 AS ValCuss, " + ;
                               "00000000.0000 AS TotCuss, '  ' AS MoeCuss " + ;
                               "FROM SigMvItn a " + ;
                               "INNER JOIN sigopetq b ON a.codbarras = b.cbars " + ;
                               "WHERE a.Dopes = " + EscaparSQL(loc_cDopes) + ;
                               " AND a.DtAlts BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvItn")
                    IF loc_nResult > 0
                        *-- Calcula custo unitario de cada item
                        SELECT cursor_4c_SigMvItn
                        SCAN
                            loc_nCusto    = loc_nCusGr
                            loc_cMesAtual = PADL(THIS.this_cMes, 2, "0") + PADL(THIS.this_cAno, 4, "0")
                            loc_cMesItem  = PADL(MONTH(cursor_4c_SigMvItn.Datas), 2, "0") + ;
                                            PADL(YEAR(cursor_4c_SigMvItn.Datas), 4, "0")

                            *-- Item de periodo diferente: busca custo historico em SigCdCmv
                            IF loc_cMesAtual <> loc_cMesItem
                                loc_cChave = PADR(ALLTRIM(cursor_4c_SigMvItn.Cpros), 14) + loc_cMesItem
                                loc_cSQL = "SELECT valcuss, moedas, datas FROM SigCdCmv " + ;
                                           "WHERE pkchaves = " + EscaparSQL(loc_cChave)
                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoIteH")
                                IF loc_nResult > 0
                                    SELECT cursor_4c_CustoIteH
                                    IF !EOF()
                                        loc_nCusto = cursor_4c_CustoIteH.valcuss
                                        IF ALLTRIM(cursor_4c_CustoIteH.moedas) <> loc_cMoeda
                                            loc_cMesCmvStr = ALLTRIM(cursor_4c_CustoIteH.datas)
                                            loc_nMesCmv    = VAL(SUBSTR(loc_cMesCmvStr, 1, 2))
                                            loc_nAnoCmv    = VAL(SUBSTR(loc_cMesCmvStr, 4, 4))
                                            IF loc_nMesCmv >= 12
                                                loc_dUltDiaMes = DATE(loc_nAnoCmv + 1, 1, 1) - 1
                                            ELSE
                                                loc_dUltDiaMes = DATE(loc_nAnoCmv, loc_nMesCmv + 1, 1) - 1
                                            ENDIF
                                            loc_nCota = THIS.BuscarCotacao(ALLTRIM(cursor_4c_CustoIteH.moedas), loc_dUltDiaMes)
                                            IF loc_nCotaOpera <> 0
                                                loc_nCusto = loc_nCusto * loc_nCota / loc_nCotaOpera
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                    USE IN cursor_4c_CustoIteH
                                ENDIF
                            ENDIF

                            SELECT cursor_4c_SigMvItn
                            REPLACE ValCuss WITH loc_nCusto, ;
                                    TotCuss WITH NVL(Pesos * loc_nCusto, 0), ;
                                    MoeCuss WITH loc_cMoeda
                            SELECT cursor_4c_SigMvItn
                        ENDSCAN

                        *-- Adiciona itens calculados ao cursor principal do relatorio
                        SELECT cursor_4c_SigMvItn
                        GO TOP
                        SELECT (THIS.this_cCursorDados)
                        APPEND FROM DBF("cursor_4c_SigMvItn")
                        USE IN cursor_4c_SigMvItn
                    ENDIF

                    SELECT (THIS.this_cCursorOpe)
                ENDSCAN

                *-- Grava em SigCdCmv se confirmado e houver itens
                IF loc_lGrava AND USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                    THIS.RegistrarCMV(loc_nCusGr)
                ENDIF

                *-- Cursor de cabecalho para o relatorio
                loc_cNmTitulo  = "CMV - Custo da Mercadoria Vendida"
                loc_cDtPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtIni) + ;
                                 " a " + DTOC(loc_dDtFin)
                CREATE CURSOR crCabec (titulos C(80), titulo2s C(80))
                INSERT INTO crCabec (titulos, titulo2s) VALUES (loc_cNmTitulo, loc_cDtPeriodo)

                *-- Posiciona no cursor de dados para o REPORT FORM
                SELECT (THIS.this_cCursorDados)

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega registro do cursor SigCdCmv nas propriedades
    * par_cAliasCursor: nome do alias/cursor com registro posicionado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF() AND !BOF()
                    THIS.this_cPkChaves = ALLTRIM(NVL(pkchaves, ""))
                    THIS.this_cCpros    = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cDatas    = ALLTRIM(NVL(datas, ""))
                    THIS.this_cMoedas   = ALLTRIM(NVL(moedas, ""))
                    THIS.this_nValCuss  = NVL(valcuss, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdCmv com as propriedades this_*
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cPkChaves) OR EMPTY(THIS.this_cCpros) OR ;
                   EMPTY(THIS.this_cDatas) OR EMPTY(THIS.this_cMoedas)
                    THIS.this_cMensagemErro = "Campos obrigat" + CHR(243) + "rios n" + CHR(227) + "o preenchidos"
                    EXIT
                ENDIF

                loc_cSQL = "INSERT INTO SigCdCmv " + ;
                           "(pkchaves, cpros, datas, moedas, valcuss) VALUES (" + ;
                           EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                           EscaparSQL(THIS.this_cCpros) + ", " + ;
                           EscaparSQL(THIS.this_cDatas) + ", " + ;
                           EscaparSQL(THIS.this_cMoedas) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nValCuss, 2) + ;
                           ")"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao inserir CMV em SigCdCmv"
                    EXIT
                ENDIF

                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdCmv com as propriedades this_*
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cPkChaves)
                    THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada"
                    EXIT
                ENDIF

                loc_cSQL = "UPDATE SigCdCmv SET " + ;
                           "cpros = "   + EscaparSQL(THIS.this_cCpros) + ", " + ;
                           "datas = "   + EscaparSQL(THIS.this_cDatas) + ", " + ;
                           "moedas = "  + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                           "valcuss = " + FormatarNumeroSQL(THIS.this_nValCuss, 2) + ;
                           " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao atualizar CMV em SigCdCmv"
                    EXIT
                ENDIF

                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarCMV - Grava custo calculado em SigCdCmv (INSERT ou UPDATE)
    * par_nCusGr: custo por grama calculado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarCMV(par_nCusGr)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cPkChaves, loc_cDatas, loc_lExiste
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                loc_cDatas = PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0")

                *-- Para cada produto distinto nos itens produzidos
                SELECT DISTINCT cpros FROM cursor_4c_Itens INTO CURSOR cursor_4c_Gravar READWRITE

                SELECT cursor_4c_Gravar
                SCAN
                    loc_cPkChaves = PADR(ALLTRIM(cursor_4c_Gravar.cpros), 14) + ;
                                   PADL(THIS.this_cMes, 2, "0") + ;
                                   PADL(THIS.this_cAno, 4, "0")

                    *-- Verifica se registro ja existe
                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCmv " + ;
                               "WHERE pkchaves = " + EscaparSQL(loc_cPkChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExisteCmv")
                    loc_lExiste = .F.
                    IF loc_nResult > 0
                        SELECT cursor_4c_ExisteCmv
                        IF !EOF()
                            loc_lExiste = NVL(nExiste, 0) > 0
                        ENDIF
                        USE IN cursor_4c_ExisteCmv
                    ENDIF

                    IF loc_lExiste
                        loc_cSQL = "UPDATE SigCdCmv SET " + ;
                                   "valcuss = " + FormatarNumeroSQL(par_nCusGr, 2) + ", " + ;
                                   "moedas = " + EscaparSQL(ALLTRIM(THIS.this_cCdMoeda)) + ", " + ;
                                   "datas = " + EscaparSQL(loc_cDatas) + ;
                                   " WHERE pkchaves = " + EscaparSQL(loc_cPkChaves)
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdCmv " + ;
                                   "(pkchaves, cpros, valcuss, moedas, datas) VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Gravar.cpros)) + ", " + ;
                                   FormatarNumeroSQL(par_nCusGr, 2) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cCdMoeda)) + ", " + ;
                                   EscaparSQL(loc_cDatas) + ;
                                   ")"
                    ENDIF

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT cursor_4c_Gravar
                ENDSCAN
                USE IN cursor_4c_Gravar

                THIS.RegistrarAuditoria("GERACMV")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
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
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE TO PRINTER
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComDialogo - Prepara dados e abre dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComDialogo()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna pkchaves do registro corrente
    * Prioridade: this_cPkChaves (setada por CarregarDoCursor/Inserir/Atualizar)
    * Fallback: monta a partir do cursor crVenda + mes/ano correntes
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cCursor, loc_cCpros
        loc_cChave  = ""
        loc_cCursor = THIS.this_cCursorDados
        IF !EMPTY(THIS.this_cPkChaves)
            loc_cChave = ALLTRIM(THIS.this_cPkChaves)
        ELSE
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                loc_cCpros = Cpros
                loc_cChave = PADR(ALLTRIM(loc_cCpros), 14) + ;
                             PADL(THIS.this_cMes, 2, "0") + ;
                             PADL(THIS.this_cAno, 4, "0")
            ENDIF
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF EMPTY(loc_cChave)
                loc_cChave = PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0")
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ;
                       ", GETDATE())"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorOpe)
            USE IN (THIS.this_cCursorOpe)
        ENDIF
        IF USED(THIS.this_cCursorPac)
            USE IN (THIS.this_cCursorPac)
        ENDIF
        IF USED("crCabec")
            USE IN crCabec
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        IF USED("cursor_4c_TotItens")
            USE IN cursor_4c_TotItens
        ENDIF
        IF USED("cursor_4c_Custo")
            USE IN cursor_4c_Custo
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
