*============================================================================
* CCJBO.prg - Business Object para Calculo de Juros
*
* Tabela principal : SigCdCcj  (PK: codigo char(6))
* Tabela detalhe   : SigDtCcj  (PK: cidchaves char(20), FK: codigo char(6))
* Lookup conta     : SigCdCli  (PK: Iclis, desc: Rclis)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS CCJBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCdCcj (campos do banco)
    *==========================================================================
    this_cCodigo   = ""    && char(6)       - Chave primaria (gerada externamente)
    this_cContas   = ""    && char(10)      - Conta (FK SigCdCli.Iclis)
    this_dDataBase = {}    && datetime NULL - Data Base para calculo de juros
    this_nFator    = 0     && numeric(5,2)  - Fator de juros (porcentagem)
    this_nTotal    = 0     && numeric(11,2) - Total bruto dos documentos
    this_nTotLiq   = 0     && numeric(11,2) - Total liquido apos calculo de juros

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas no banco
    *==========================================================================
    this_cDContas   = ""   && Descricao da conta (SigCdCli.Rclis, exibicao)
    this_nQtde      = 0    && Quantidade de documentos no detalhe (calculada)
    this_nMedia     = 0    && Media de dias calculados
    this_nTiposDias = 1    && Tipo calculo: 1=Corridos, 2=Uteis (optDias.Value)

    *==========================================================================
    * Cache de feriados (SigCdFer) usado por VerificarFeriado/AjustarDiasUteis
    * Formato: "|AAAAMMDD|AAAAMMDD|..." - evita um SELECT por dia no laco
    *==========================================================================
    this_cFeriados           = ""
    this_lFeriadosCarregados = .F.

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCcj"
            THIS.this_cCampoChave = "codigo"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- Alias do cursor de detalhe (SigDtCcj)
    this_cCursorDetalhe = "cursor_4c_Detalhe"

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = ALLTRIM(TratarNulo(codigo, "C"))
            THIS.this_cContas   = ALLTRIM(TratarNulo(contas, "C"))
            THIS.this_dDataBase = TratarNulo(data_base, "D")
            THIS.this_nFator    = TratarNulo(fator, "N")
            THIS.this_nTotal    = TratarNulo(total, "N")
            THIS.this_nTotLiq   = TratarNulo(totliq, "N")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT com JOIN SigCdCli para o grid da lista
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.
        loc_cWhere   = ""

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.codigo, a.contas, a.data_base, a.fator, a.total, a.totliq," + ;
                       " ISNULL(b.rclis, '') AS desconta" + ;
                       " FROM sigcdccj a" + ;
                       " LEFT JOIN sigcdcli b ON b.iclis = a.contas"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE a.contas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                             " OR ISNULL(b.rclis, '') LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.contas, a.data_base DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT pelo codigo (PK) para edicao/visualizacao
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT codigo, contas, data_base, fator, total, totliq" + ;
                       " FROM sigcdccj" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera codigo unico de 6 chars via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarCodigo()
        LOCAL loc_cSQL, loc_nResultado, loc_cNovoCodigo
        loc_cNovoCodigo = ""

        TRY
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_cSQL = "SELECT UPPER(LEFT(REPLACE(NEWID(), '-', ''), 6)) AS novoCodigo"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = ALLTRIM(novoCodigo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF

        RETURN loc_cNovoCodigo
    ENDPROC

    *==========================================================================
    * BuscarDetalhe - Carrega linhas de SigDtCcj para cursor de detalhe
    *                 Se par_cCodigo vazio, cria cursor vazio com a estrutura
    *==========================================================================
    PROCEDURE BuscarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDetalhe)
                USE IN (THIS.this_cCursorDetalhe)
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorDetalhe) ;
                    (cidchaves C(20), codigo C(6), datas T, ;
                     dias N(3,0), liquido N(11,2), valor N(11,2))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, codigo, datas, dias, liquido, valor" + ;
                           " FROM sigdtccj" + ;
                           " WHERE codigo = " + EscaparSQL(par_cCodigo) + ;
                           " ORDER BY datas"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DetLoad")

                IF loc_nResultado > 0
                    *-- Converte para READWRITE (SQLEXEC gera somente-leitura por padrao)
                    *-- Necessario para APPEND BLANK (InserirV) e REPLACE (Recalcular)
                    SELECT cidchaves, codigo, datas, dias, liquido, valor ;
                        FROM cursor_4c_DetLoad ;
                        INTO CURSOR (THIS.this_cCursorDetalhe) READWRITE
                    IF USED("cursor_4c_DetLoad")
                        USE IN cursor_4c_DetLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Valida e retorna descricao de SigCdCli
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            THIS.this_cDContas = ""
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT iclis, rclis" + ;
                       " FROM sigcdcli" + ;
                       " WHERE iclis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                THIS.this_cDContas = ALLTRIM(NVL(rclis, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cDContas = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirDetalhe - PROTECTED: persiste cursor de detalhe em sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE InserirDetalhe()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAlias
        LOCAL loc_cCodigo, loc_dDatas, loc_nDias, loc_nLiquido, loc_nValor
        loc_lSucesso = .T.
        loc_cAlias   = THIS.this_cCursorDetalhe

        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        TRY
            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF EMPTY(datas)
                    LOOP
                ENDIF

                loc_cCodigo  = THIS.this_cCodigo
                loc_dDatas   = datas
                loc_nDias    = NVL(dias, 0)
                loc_nLiquido = NVL(liquido, 0)
                loc_nValor   = NVL(valor, 0)

                loc_cSQL = "INSERT INTO sigdtccj" + ;
                           " (cidchaves, codigo, datas, dias, liquido, valor)" + ;
                           " VALUES (" + ;
                           " LEFT(REPLACE(NEWID(), '-', ''), 20)," + ;
                           EscaparSQL(loc_cCodigo) + "," + ;
                           FormatarDataSQL(loc_dDatas) + "," + ;
                           FormatarNumeroSQL(loc_nDias) + "," + ;
                           FormatarNumeroSQL(loc_nLiquido) + "," + ;
                           FormatarNumeroSQL(loc_nValor) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - PROTECTED: INSERT em sigcdccj + linhas sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao inserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - PROTECTED: DELETE+INSERT (padrao legado msv_alterar)
    *             Delete cabecalho + detalhe antigos, reinsere com novos valores
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (FK)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover detalhe para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover cabecalho para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- RE-INSERT cabecalho com valores atualizados
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao reinserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - PROTECTED: DELETE de sigdtccj e sigcdccj
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Recalcular - Recalcula juros de cada linha do detalhe
    * Prerequisito: this_dDataBase, this_nFator e this_nTiposDias setados
    * Atualiza Dias/Liquido no cursor_4c_Detalhe e acumula this_n* totais
    *
    * Fiel ao legado SIGCDCCJ.Pagina.recalcular:
    *   lnDias = Ttod(Datas) - Ttod(DataBase)          (pode ser NEGATIVO)
    *   lnLiq  = Round(Valor - (Valor*((lnDias/30)*(Fator/100))),2)
    *   Abs(lnDias) > 999 -> avisa, limpa Datas e aborta
    *   Totais via Count/Sum/Avg Where Not Empty(Dias)
    *==========================================================================
    PROCEDURE Recalcular()
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        LOCAL loc_dBase, loc_nFator, loc_nTipo
        LOCAL loc_nDias, loc_nLiquido, loc_dDatas_d, loc_dBase_d, loc_nValor
        LOCAL loc_lExcedeu

        loc_lSucesso = .F.
        loc_lExcedeu = .F.
        loc_cAlias   = THIS.this_cCursorDetalhe
        loc_dBase    = THIS.this_dDataBase
        loc_nFator   = NVL(THIS.this_nFator, 0)
        loc_nTipo    = NVL(THIS.this_nTiposDias, 1)

        IF !USED(loc_cAlias)
            MsgErro("Cursor de detalhe n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Recalcular")
            RETURN .F.
        ENDIF

        IF ISNULL(loc_dBase) OR EMPTY(loc_dBase)
            MsgErro("Data Base n" + CHR(227) + "o informada.", "Recalcular")
            RETURN .F.
        ENDIF

        TRY
            *-- Data Base chega como DATE (TextBox .Value = {}) ou como DATETIME
            *-- (coluna sigcdccj.data_base). TTOD() SO aceita DATETIME - passar
            *-- um DATE dispara erro 11 "Function argument value, type, or count
            *-- is invalid". Normalizar sempre via ConverterParaData().
            loc_dBase_d = ConverterParaData(loc_dBase)

            *-- Dias uteis (optDias = 2): carrega feriados uma unica vez
            IF loc_nTipo = 2
                THIS.CarregarFeriados()
            ENDIF

            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF ISNULL(datas) OR EMPTY(datas)
                    LOOP
                ENDIF

                loc_dDatas_d = ConverterParaData(datas)
                loc_nValor   = NVL(valor, 0)
                loc_nDias    = loc_dDatas_d - loc_dBase_d

                IF loc_nDias > 0 AND loc_nTipo = 2
                    loc_nDias = THIS.AjustarDiasUteis(loc_dBase_d, loc_dDatas_d)
                ENDIF

                loc_nLiquido = ROUND(loc_nValor - (loc_nValor * ((loc_nDias / 30) * (loc_nFator / 100))), 2)

                *-- sigdtccj.dias eh numeric(3,0): acima de 999 nao cabe
                IF ABS(loc_nDias) > 999
                    MsgAviso("Quantidade de dias superior a 999 dias.", "Aten" + CHR(231) + CHR(227) + "o")
                    REPLACE datas WITH {}
                    loc_lExcedeu = .T.
                    EXIT
                ENDIF

                REPLACE dias WITH loc_nDias, liquido WITH loc_nLiquido
            ENDSCAN

            IF !loc_lExcedeu
                THIS.AtualizarTotaisDetalhe()
                loc_lSucesso = .T.
            ENDIF

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Recalcular")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarTotaisDetalhe - Recalcula this_nQtde/Media/Total/TotLiq a partir
    * do cursor de detalhe. Fiel ao legado:
    *   Select Count(*), Sum(Valor), Sum(Liquido), Avg(Dias)
    *     From crDetalhe Where Not Empty(Dias)
    * (linhas com Dias = 0 NAO entram nos totais - comportamento do legado)
    *==========================================================================
    PROCEDURE AtualizarTotaisDetalhe()
        LOCAL loc_cAlias, loc_cCursorTot, loc_lSucesso, loc_oErro

        loc_lSucesso   = .F.
        loc_cAlias     = THIS.this_cCursorDetalhe
        loc_cCursorTot = "cursor_4c_TotCcj"

        THIS.this_nQtde   = 0
        THIS.this_nMedia  = 0
        THIS.this_nTotal  = 0
        THIS.this_nTotLiq = 0

        IF USED(loc_cAlias)
            TRY
                IF USED(loc_cCursorTot)
                    USE IN (loc_cCursorTot)
                ENDIF

                SELECT COUNT(*)            AS qtd, ;
                       SUM(NVL(valor, 0))   AS totvalor, ;
                       SUM(NVL(liquido, 0)) AS totliqui, ;
                       AVG(NVL(dias, 0))    AS meddias ;
                    FROM (loc_cAlias) ;
                    WHERE NOT EMPTY(NVL(dias, 0)) ;
                    INTO CURSOR (loc_cCursorTot) READWRITE

                SELECT (loc_cCursorTot)
                THIS.this_nQtde   = NVL(qtd, 0)
                THIS.this_nMedia  = NVL(meddias, 0)
                THIS.this_nTotal  = NVL(totvalor, 0)
                THIS.this_nTotLiq = NVL(totliqui, 0)

                USE IN (loc_cCursorTot)
                SELECT (loc_cAlias)
                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "AtualizarTotaisDetalhe")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriados
    * (string "|AAAAMMDD|..."), evitando um SELECT por dia dentro do laco.
    *==========================================================================
    PROTECTED PROCEDURE CarregarFeriados()
        LOCAL loc_cSQL, loc_nRet, loc_cLista, loc_cAliasAnt, loc_oErro

        IF THIS.this_lFeriadosCarregados
            RETURN .T.
        ENDIF

        loc_cLista    = "|"
        loc_cAliasAnt = ALIAS()

        TRY
            IF USED("cursor_4c_FerLoad")
                USE IN cursor_4c_FerLoad
            ENDIF

            loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")

            IF loc_nRet > 0 AND USED("cursor_4c_FerLoad")
                SELECT cursor_4c_FerLoad
                SCAN
                    IF !ISNULL(datas) AND !EMPTY(datas)
                        loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
                    ENDIF
                ENDSCAN
                USE IN cursor_4c_FerLoad
            ENDIF

            THIS.this_cFeriados           = loc_cLista
            THIS.this_lFeriadosCarregados = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarFeriados")
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VerificarFeriado - .T. se a data eh sabado, domingo ou feriado (SigCdFer)
    * Equivalente a fChkFeriado(poDataMgr, ldDia, .T., .T.) do legado.
    *==========================================================================
    PROTECTED PROCEDURE VerificarFeriado(par_dData)
        LOCAL loc_nDow, loc_lNaoUtil

        loc_lNaoUtil = .F.
        loc_nDow     = DOW(par_dData)

        IF loc_nDow = 1 OR loc_nDow = 7
            loc_lNaoUtil = .T.
        ELSE
            loc_lNaoUtil = ("|" + DTOS(par_dData) + "|") $ THIS.this_cFeriados
        ENDIF

        RETURN loc_lNaoUtil
    ENDPROC

    *==========================================================================
    * AjustarDiasUteis - Fiel ao legado: parte dos dias corridos e SUBTRAI
    * cada sabado/domingo/feriado do intervalo [inicio, fim].
    *==========================================================================
    PROTECTED PROCEDURE AjustarDiasUteis(par_dInicio, par_dFim)
        LOCAL loc_nDias, loc_dAtual

        loc_nDias  = par_dFim - par_dInicio
        loc_dAtual = par_dInicio

        DO WHILE loc_dAtual <= par_dFim
            IF THIS.VerificarFeriado(loc_dAtual)
                loc_nDias = loc_nDias - 1
            ENDIF
            loc_dAtual = loc_dAtual + 1
        ENDDO

        RETURN loc_nDias
    ENDPROC

ENDDEFINE
