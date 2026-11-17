*==============================================================================
* SIGOPRPSBO.prg - Business Object para Follow Up de RPS (SIGOPRPS)
* Tabela principal: SigCdFrp (log de acompanhamento/rastreamento do RPS)
*==============================================================================

DEFINE CLASS SIGOPRPSBO AS BusinessBase

    *-- Identificacao do RPS (parametros recebidos na abertura do form) ----
    this_cEmps   = ""    && char(3)  - Empresa
    this_cTipos  = ""    && char(5)  - Tipo do RPS
    this_cSeries = ""    && char(5)  - Serie do RPS
    this_nNumRps = 0     && N(12,0)  - Numero do RPS
    this_cDopes  = ""    && char(20) - Operacao (codigo)
    this_nNumes  = 0     && N(6,0)   - Numero da operacao

    *-- Cursor com o historico de acompanhamento (SigCdFrp) ----------------
    this_cCursorDados = "cursor_4c_Historico"

    *-- Dados do registro de historico corrente (populados por CarregarDoCursor) --
    this_cCidChaves  = ""    && char(20) - PK de SigCdFrp
    this_dDatas      = {}    && datetime - Data/Hora do lancamento
    this_cNfis       = ""    && char(8)  - Numero da NF
    this_cTransacaos = ""    && char(30) - Tipo de lancamento/transacao
    this_cUsuars     = ""    && char(10) - Usuario que gerou o lancamento

    *--------------------------------------------------------------------------
    * Init - Recebe a identificacao do RPS a ser acompanhado
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cTipos, par_cSeries, par_nNumRps, par_cDopes, par_nNumes)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdFrp"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cEmps   = TratarNulo(par_cEmps, "")
            THIS.this_cTipos  = TratarNulo(par_cTipos, "")
            THIS.this_cSeries = TratarNulo(par_cSeries, "")
            THIS.this_nNumRps = TratarNulo(par_nNumRps, 0)
            THIS.this_cDopes  = TratarNulo(par_cDopes, "")
            THIS.this_nNumes  = TratarNulo(par_nNumes, 0)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SIGOPRPSBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarHistorico - Consulta o historico de acompanhamento do RPS
    * (SigCdFrp), do mais recente para o mais antigo, e popula
    * THIS.this_cCursorDados (cursor_4c_Historico - RecordSource do grid).
    *
    * Transcricao LITERAL do Init do SCX legado: o filtro usa APENAS Emps,
    * Tipos, Series e NumRps - Dopes e Numes sao recebidos na identificacao
    * mas NAO entram no WHERE da consulta original, e isso nao foi alterado.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarHistorico()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        THIS.this_cMensagemErro = ""

        TRY
            loc_cSQL = "SELECT Datas, Transacaos, Usuars, Nfis " + ;
                       "FROM SigCdFrp " + ;
                       "WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos) + ;
                       " AND Series = " + EscaparSQL(THIS.this_cSeries) + ;
                       " AND NumRps = " + FormatarNumeroSQL(THIS.this_nNumRps, 0) + ;
                       " ORDER BY Datas DESC"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar hist" + CHR(243) + ;
                    "rico do RPS: " + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao consultar hist" + CHR(243) + ;
                "rico do RPS: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCdFrp para as
    * properties this_* do registro de historico corrente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
            THIS.this_dDatas      = TratarNulo(datas, {})
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cNfis       = TratarNulo(nfis, "")
            THIS.this_nNumes      = TratarNulo(numes, 0)
            THIS.this_nNumRps     = TratarNulo(numrps, 0)
            THIS.this_cSeries     = TratarNulo(series, "")
            THIS.this_cTipos      = TratarNulo(tipos, "")
            THIS.this_cTransacaos = TratarNulo(transacaos, "")
            THIS.this_cUsuars     = TratarNulo(usuars, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria do registro de historico corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir/Atualizar/ExecutarExclusao - SIGOPRPS (Follow Up de RPS) eh
    * uma tela de CONSULTA somente leitura: o legado nao tem Incluir/Alterar/
    * Excluir (Commandgroup2 tem um unico botao, "Encerrar", e todos os
    * get_* do form tem When retornando .F., ou seja nunca entram em modo de
    * edicao). O comportamento padrao herdado de BusinessBase ja eh o
    * correto para estes tres metodos - nao ha necessidade de sobrescrever.
    *--------------------------------------------------------------------------

ENDDEFINE
