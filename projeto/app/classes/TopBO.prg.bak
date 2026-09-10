*====================================================================
* TopBO.prg
*
* Business Object para Top (Tipos de Operacoes)
* Tabela: SigCdTom
*
* FASE 1/8: Propriedades e Init
*====================================================================

DEFINE CLASS TopBO AS BusinessBase

    *-- Propriedades da entidade (colunas de SigCdTom)
    this_nCodigos    = 0     && codigos      numeric(2,0)  NOT NULL - PK
    this_cDescrs     = ""    && descrs       char(30)      NOT NULL
    this_lLalts      = .F.   && lalts        bit           NOT NULL - registro automatico (nao editavel na tela)
    this_nFlagpgs    = 0     && flagpgs      numeric(1,0)  NOT NULL - Situacao (Pagos/Nao Pagos/Todos)
    this_nGergdmis   = 0     && gergdmis     numeric(1,0)  NOT NULL - Gravacao de Movimentacao
    this_nCancPeds   = 0     && cancpeds     numeric(1,0)  NOT NULL - Cancelamento de Pedido
    this_nTpGdmis    = 0     && tpgdmis      numeric(1,0)  NOT NULL - Tipo Gravacao Movimentacao (Soma/Subtrai)
    this_nOpVlUnis   = 0     && opvlunis     numeric(1,0)  NOT NULL - Atualiza Data/Valor Ult Compra
    this_nAtuCompras = 0     && atucompras   numeric(1,0)  NOT NULL - Atualiza Compras (Sim/Nao/Peso-Custo)
    this_nReposicaos = 0     && reposicaos   numeric(1,0)  NOT NULL - Geracao de Reposicao
    this_nMaxEnts    = 0     && maxents      numeric(4,0)  NOT NULL - Qtde Max Entregas (Dias Uteis)
    this_nExibLims   = 0     && exiblims     numeric(1,0)  NOT NULL - Exibe no limites de entregas
    this_nMaxEnt2s   = 0     && maxent2s     numeric(4,0)  NOT NULL - Qtde Max Entregas (Sabados)
    this_nMaxEnt3s   = 0     && maxent3s     numeric(4,0)  NOT NULL - Qtde Max Entregas (Domingos/Feriados)
    this_nBxVendas   = 0     && bxvendas     numeric(1,0)  NOT NULL - Baixa de Estoque
    this_nChkSDFs    = 0     && nchksdfs     numeric(1,0)  NOT NULL - Calcular Rel. de Comissao
    this_nTpMercs    = 0     && tpmercs      numeric(1,0)  NOT NULL - Mercadoria (Nenhuma/Separada/Nao Separada)
    this_nFlxCaixa   = 0     && nflxcaixa    numeric(1,0)  NOT NULL - Fluxo de Caixa
    this_nEntPends   = 0     && entpends     numeric(1,0)  NOT NULL - Exibir como entrada pendente
    this_nGerVds     = 0     && gervds       numeric(1,0)  NOT NULL - Vendedor (Propria Operacao/SubNivel)
    this_nGeraCmvs   = 0     && geracmvs     numeric(1,0)  NOT NULL - Gera CMV
    this_nOpIgnRelFc = 0     && opignrelfc   numeric(1,0)  NOT NULL - nao exibido no form, mas existe na tabela

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCdTom"
        THIS.this_cCampoChave = "Codigos"

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (codigos) para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Valores default ao iniciar novo registro
    * Legado (Click): Replace CrSigCdTom.lAlts with .t. quando pcEscolha='INSERIR'
    * lAlts = .T. marca o registro como alteravel/exclusivo do usuario (nao
    * automatico do sistema) - todo registro incluido manualmente nasce assim.
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_lLalts = .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos    = TratarNulo(codigos,    "N")
                THIS.this_cDescrs     = TratarNulo(descrs,     "C")
                THIS.this_lLalts      = ConverterParaLogico(lalts)
                THIS.this_nFlagpgs    = TratarNulo(flagpgs,    "N")
                THIS.this_nGergdmis   = TratarNulo(gergdmis,   "N")
                THIS.this_nCancPeds   = TratarNulo(cancpeds,   "N")
                THIS.this_nTpGdmis    = TratarNulo(tpgdmis,    "N")
                THIS.this_nOpVlUnis   = TratarNulo(opvlunis,   "N")
                THIS.this_nAtuCompras = TratarNulo(atucompras, "N")
                THIS.this_nReposicaos = TratarNulo(reposicaos, "N")
                THIS.this_nMaxEnts    = TratarNulo(maxents,    "N")
                THIS.this_nExibLims   = TratarNulo(exiblims,   "N")
                THIS.this_nMaxEnt2s   = TratarNulo(maxent2s,   "N")
                THIS.this_nMaxEnt3s   = TratarNulo(maxent3s,   "N")
                THIS.this_nBxVendas   = TratarNulo(bxvendas,   "N")
                THIS.this_nChkSDFs    = TratarNulo(nchksdfs,   "N")
                THIS.this_nTpMercs    = TratarNulo(tpmercs,    "N")
                THIS.this_nFlxCaixa   = TratarNulo(nflxcaixa,  "N")
                THIS.this_nEntPends   = TratarNulo(entpends,   "N")
                THIS.this_nGerVds     = TratarNulo(gervds,     "N")
                THIS.this_nGeraCmvs   = TratarNulo(geracmvs,   "N")
                THIS.this_nOpIgnRelFc = TratarNulo(opignrelfc, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdTom
    * Todas as colunas sao NOT NULL - nenhuma pode ficar de fora do INSERT
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdTom (codigos, descrs, lalts, flagpgs, gergdmis," + ;
                       " cancpeds, tpgdmis, opvlunis, atucompras, reposicaos," + ;
                       " maxents, exiblims, maxent2s, maxent3s, bxvendas," + ;
                       " nchksdfs, tpmercs, nflxcaixa, entpends, gervds," + ;
                       " geracmvs, opignrelfc)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos, 0) + "," + ;
                       EscaparSQL(THIS.this_cDescrs) + "," + ;
                       FormatarNumeroSQL(IIF(THIS.this_lLalts, 1, 0), 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFlagpgs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGergdmis, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCancPeds, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpGdmis, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpVlUnis, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAtuCompras, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nReposicaos, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaxEnts, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nExibLims, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaxEnt2s, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaxEnt3s, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBxVendas, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkSDFs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpMercs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFlxCaixa, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEntPends, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGerVds, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGeraCmvs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpIgnRelFc, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdTom
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdTom SET" + ;
                       " descrs = "     + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " lalts = "      + FormatarNumeroSQL(IIF(THIS.this_lLalts, 1, 0), 0) + "," + ;
                       " flagpgs = "    + FormatarNumeroSQL(THIS.this_nFlagpgs, 0) + "," + ;
                       " gergdmis = "   + FormatarNumeroSQL(THIS.this_nGergdmis, 0) + "," + ;
                       " cancpeds = "   + FormatarNumeroSQL(THIS.this_nCancPeds, 0) + "," + ;
                       " tpgdmis = "    + FormatarNumeroSQL(THIS.this_nTpGdmis, 0) + "," + ;
                       " opvlunis = "   + FormatarNumeroSQL(THIS.this_nOpVlUnis, 0) + "," + ;
                       " atucompras = " + FormatarNumeroSQL(THIS.this_nAtuCompras, 0) + "," + ;
                       " reposicaos = " + FormatarNumeroSQL(THIS.this_nReposicaos, 0) + "," + ;
                       " maxents = "    + FormatarNumeroSQL(THIS.this_nMaxEnts, 0) + "," + ;
                       " exiblims = "   + FormatarNumeroSQL(THIS.this_nExibLims, 0) + "," + ;
                       " maxent2s = "   + FormatarNumeroSQL(THIS.this_nMaxEnt2s, 0) + "," + ;
                       " maxent3s = "   + FormatarNumeroSQL(THIS.this_nMaxEnt3s, 0) + "," + ;
                       " bxvendas = "   + FormatarNumeroSQL(THIS.this_nBxVendas, 0) + "," + ;
                       " nchksdfs = "   + FormatarNumeroSQL(THIS.this_nChkSDFs, 0) + "," + ;
                       " tpmercs = "    + FormatarNumeroSQL(THIS.this_nTpMercs, 0) + "," + ;
                       " nflxcaixa = "  + FormatarNumeroSQL(THIS.this_nFlxCaixa, 0) + "," + ;
                       " entpends = "   + FormatarNumeroSQL(THIS.this_nEntPends, 0) + "," + ;
                       " gervds = "     + FormatarNumeroSQL(THIS.this_nGerVds, 0) + "," + ;
                       " geracmvs = "   + FormatarNumeroSQL(THIS.this_nGeraCmvs, 0) + "," + ;
                       " opignrelfc = " + FormatarNumeroSQL(THIS.this_nOpIgnRelFc, 0) + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE da tabela SigCdTom
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdTom WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de tipos de operacoes no cursor_4c_Dados
    * par_cFiltro: se numerico/preenchido, filtra por codigos exato
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, lalts, flagpgs, gergdmis," + ;
                       " cancpeds, tpgdmis, opvlunis, atucompras, reposicaos," + ;
                       " maxents, exiblims, maxent2s, maxent3s, bxvendas," + ;
                       " nchksdfs, tpmercs, nflxcaixa, entpends, gervds," + ;
                       " geracmvs, opignrelfc" + ;
                       " FROM SigCdTom"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro)), 0)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, lalts, flagpgs, gergdmis," + ;
                       " cancpeds, tpgdmis, opvlunis, atucompras, reposicaos," + ;
                       " maxents, exiblims, maxent2s, maxent3s, bxvendas," + ;
                       " nchksdfs, tpmercs, nflxcaixa, entpends, gervds," + ;
                       " geracmvs, opignrelfc" + ;
                       " FROM SigCdTom" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo, 0)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
