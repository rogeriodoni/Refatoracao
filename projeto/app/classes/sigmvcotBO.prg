*============================================================================
* sigmvcotBO.prg - Business Object para Cotacao de Compras
*
* Tabela principal : SigCtTDc  (PK: cidchaves char(20), business key: codigos)
* Tabela fornecs    : SigCtTFn  (FK: cidchaves)
* Tabela itens/prods: SigCtTCt  (FK: cidchaves)
*
* Form legado (SIGMVCOT) e um form OPERACIONAL com 4 paginas:
*   Filtros -> Dados (movimentacoes) -> Cotacoes (fornecedores/produtos) -> Pedidos
* As grades (Movimentacoes, Cotacoes em Aberto, Fornecedores, Produtos,
* Pedidos/Itens de Pedido) sao manipuladas via cursores populados por
* SQLEXEC (ver aliases HIDDEN abaixo) - nao viram propriedades this_ do BO,
* que representa apenas o cabecalho da Cotacao (SigCtTDc) sendo editado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigmvcotBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCtTDc (campos do banco)
    *==========================================================================
    this_cCidChaves  = ""   && char(20) NOT NULL - Chave primaria Fortyus (fUniqueIds())
    this_nCodigos    = 0    && numeric(6,0) NOT NULL - Codigo da cotacao (chave de negocio)
    this_cComprador  = ""   && char(12) NOT NULL - Usuario comprador (SigCdUsu.Usuarios)
    this_cDeptos     = ""   && char(10) NOT NULL - Departamento solicitante (SigCdDpt.Codigos)
    this_dDtCotas    = {}   && datetime NULL - Data da cotacao
    this_dDtPagtos   = {}   && datetime NULL - Data de pagamento
    this_dDtSolics   = {}   && datetime NULL - Data da solicitacao
    this_dDtValids   = {}   && datetime NULL - Data de validade da cotacao
    this_cJustificas = ""   && text NULL - Justificativa geral da cotacao
    this_nPrioris    = 0    && numeric(1,0) NOT NULL - Prioridade (1=Normal,2=Media,3=Alta)
    this_nSituas     = 0    && numeric(1,0) NOT NULL - Situacao (0=Em cotacao, >0=Pedido gerado)
    this_cSolicitas  = ""   && char(10) NOT NULL - Usuario solicitante (SigCdUsu.Usuarios)
    this_cAprovador  = ""   && char(10) NOT NULL - Usuario aprovador (SigCdUsu.Usuarios)
    this_cAprSols    = ""   && char(10) NOT NULL - Usuario que aprova a solicitacao
    this_nChkAprovs  = 0    && numeric(1,0) NOT NULL - Flag aprovacao final (0/1)
    this_cContaEs    = ""   && char(10) NOT NULL - Conta de entrega (SigCdCli.IClis)
    this_dDtAprovs   = {}   && datetime NULL - Data da aprovacao final
    this_dDtAprSols  = {}   && datetime NULL - Data da aprovacao da solicitacao
    this_nLocalEnts  = 0    && numeric(10,0) NOT NULL - Local de entrega (SigCdEnd)
    this_cObsAprovs  = ""   && text NULL - Observacao da aprovacao final
    this_cObsAprSols = ""   && text NULL - Observacao da aprovacao da solicitacao
    this_nCopias     = 0    && numeric(6,0) NOT NULL - Codigo da cotacao original (copia)

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas no banco (descricoes de lookup)
    *==========================================================================
    this_cDComprador = ""   && Nome do comprador (SigCdUsu.NComps, exibicao)
    this_cDDeptos    = ""   && Descricao do departamento (SigCdDpt.Descricaos, exibicao)
    this_cDSolicitas = ""   && Nome do solicitante (SigCdUsu.NComps, exibicao)
    this_cDAprovador = ""   && Nome do aprovador (SigCdUsu.NComps, exibicao)
    this_cDAprSols   = ""   && Nome do aprovador da solicitacao (SigCdUsu.NComps, exibicao)
    this_cDContaEs   = ""   && Nome da conta de entrega (SigCdCli.RClis, exibicao)

    *==========================================================================
    * Aliases de cursores das grades da tela (populados via SQLEXEC nas fases
    * seguintes) - HIDDEN para nao aparecer em FormParaBO/BOParaForm
    *==========================================================================
    HIDDEN this_cCursorFornecedores
    HIDDEN this_cCursorProdutos
    HIDDEN this_cCursorMovimentacao
    HIDDEN this_cCursorCotasPendentes
    HIDDEN this_cCursorPedidos
    HIDDEN this_cCursorItensPedido

    this_cCursorFornecedores  = "cursor_4c_Fornecedores"
    this_cCursorProdutos      = "cursor_4c_Produtos"
    this_cCursorMovimentacao  = "cursor_4c_Movimentacao"
    this_cCursorCotasPendentes = "cursor_4c_CotasPendentes"
    this_cCursorPedidos       = "cursor_4c_Pedidos"
    this_cCursorItensPedido   = "cursor_4c_ItensPedido"

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCtTDc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do cabecalho da cotacao
    * (SigCtTDc) a partir de um cursor ja aberto.
    *
    * As colunas cD<Campo> (this_cDComprador, this_cDDeptos, this_cDSolicitas,
    * this_cDAprovador, this_cDAprSols, this_cDContaEs) sao descricoes de
    * lookup que so existem quando o SELECT de origem faz JOIN com
    * SigCdUsu/SigCdDpt/SigCdCli - por isso sao carregadas so quando presentes
    * no cursor (regra #34: nunca checar por nome via Controls, aqui via TYPE).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "")
            THIS.this_nCodigos    = TratarNulo(codigos,    0)
            THIS.this_cComprador  = TratarNulo(comprador,  "")
            THIS.this_cDeptos     = TratarNulo(deptos,     "")
            THIS.this_dDtCotas    = TratarNulo(dtcotas,    {})
            THIS.this_dDtPagtos   = TratarNulo(dtpagtos,   {})
            THIS.this_dDtSolics   = TratarNulo(dtsolics,   {})
            THIS.this_dDtValids   = TratarNulo(dtvalids,   {})
            THIS.this_cJustificas = TratarNulo(justificas, "")
            THIS.this_nPrioris    = TratarNulo(prioris,    0)
            THIS.this_nSituas     = TratarNulo(situas,     0)
            THIS.this_cSolicitas  = TratarNulo(solicitas,  "")
            THIS.this_cAprovador  = TratarNulo(aprovador,  "")
            THIS.this_cAprSols    = TratarNulo(aprsols,    "")
            THIS.this_nChkAprovs  = TratarNulo(chkaprovs,  0)
            THIS.this_cContaEs    = TratarNulo(contaes,    "")
            THIS.this_dDtAprovs   = TratarNulo(dtaprovs,   {})
            THIS.this_dDtAprSols  = TratarNulo(dtaprsols,  {})
            THIS.this_nLocalEnts  = TratarNulo(localents,  0)
            THIS.this_cObsAprovs  = TratarNulo(obsaprovs,  "")
            THIS.this_cObsAprSols = TratarNulo(obsaprsols, "")
            THIS.this_nCopias     = TratarNulo(copias,     0)

            * Descricoes de lookup - presentes so quando o SELECT de origem
            * faz JOIN trazendo essas colunas extras.
            IF TYPE(par_cAliasCursor + ".dcomprador") != "U"
                THIS.this_cDComprador = TratarNulo(dcomprador, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".ddeptos") != "U"
                THIS.this_cDDeptos = TratarNulo(ddeptos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dsolicitas") != "U"
                THIS.this_cDSolicitas = TratarNulo(dsolicitas, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".daprovador") != "U"
                THIS.this_cDAprovador = TratarNulo(daprovador, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".daprsols") != "U"
                THIS.this_cDAprSols = TratarNulo(daprsols, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dcontaes") != "U"
                THIS.this_cDContaEs = TratarNulo(dcontaes, "")
            ENDIF

            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Inclui o cabecalho da cotacao (SigCtTDc) - PROTECTED
    *
    * cidchaves (PK Fortyus) sempre gerado por fUniqueIds() - NUNCA string
    * vazia, senao o 2o registro colide no indice unico (regra #22).
    * codigos (chave de negocio) gerado por fGerUniqueKey("SIGMVCOT"), igual
    * ao legado (Insert Into crSigCtTDc ... fGerUniqueKey([SIGMVCOT])).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

            IF THIS.this_nCodigos <= 0
                THIS.this_nCodigos = fGerUniqueKey("SIGMVCOT")
            ENDIF

            IF THIS.this_nCodigos <= 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel gerar o c" + CHR(243) + "digo da cota" + CHR(231) + CHR(227) + "o."
            ELSE
                loc_cSQL = "INSERT INTO SigCtTDc" + ;
                           " (cidchaves, codigos, comprador, deptos, dtcotas, dtpagtos," + ;
                           "  dtsolics, dtvalids, justificas, prioris, situas, solicitas," + ;
                           "  aprovador, aprsols, chkaprovs, contaes, dtaprovs, dtaprsols," + ;
                           "  localents, obsaprovs, obsaprsols, copias)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCodigos, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cComprador, 12)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cDeptos, 10)) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtCotas) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtPagtos) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtSolics) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtValids) + ", " + ;
                           EscaparSQL(THIS.this_cJustificas) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nPrioris, 0) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cSolicitas, 10)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cAprovador, 10)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cAprSols, 10)) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nChkAprovs, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cContaEs, 10)) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtAprovs) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtAprSols) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLocalEnts, 0) + ", " + ;
                           EscaparSQL(THIS.this_cObsAprovs) + ", " + ;
                           EscaparSQL(THIS.this_cObsAprSols) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCopias, 0) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao incluir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvcotBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza o cabecalho da cotacao (SigCtTDc) - PROTECTED
    * cidchaves e codigos NUNCA sao alterados apos a inclusao.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCtTDc SET" + ;
                       " comprador   = " + EscaparSQL(LEFT(THIS.this_cComprador, 12)) + "," + ;
                       " deptos      = " + EscaparSQL(LEFT(THIS.this_cDeptos, 10)) + "," + ;
                       " dtcotas     = " + FormatarDataSQL(THIS.this_dDtCotas) + "," + ;
                       " dtpagtos    = " + FormatarDataSQL(THIS.this_dDtPagtos) + "," + ;
                       " dtsolics    = " + FormatarDataSQL(THIS.this_dDtSolics) + "," + ;
                       " dtvalids    = " + FormatarDataSQL(THIS.this_dDtValids) + "," + ;
                       " justificas  = " + EscaparSQL(THIS.this_cJustificas) + "," + ;
                       " prioris     = " + FormatarNumeroSQL(THIS.this_nPrioris, 0) + "," + ;
                       " situas      = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
                       " solicitas   = " + EscaparSQL(LEFT(THIS.this_cSolicitas, 10)) + "," + ;
                       " aprovador   = " + EscaparSQL(LEFT(THIS.this_cAprovador, 10)) + "," + ;
                       " aprsols     = " + EscaparSQL(LEFT(THIS.this_cAprSols, 10)) + "," + ;
                       " chkaprovs   = " + FormatarNumeroSQL(THIS.this_nChkAprovs, 0) + "," + ;
                       " contaes     = " + EscaparSQL(LEFT(THIS.this_cContaEs, 10)) + "," + ;
                       " dtaprovs    = " + FormatarDataSQL(THIS.this_dDtAprovs) + "," + ;
                       " dtaprsols   = " + FormatarDataSQL(THIS.this_dDtAprSols) + "," + ;
                       " localents   = " + FormatarNumeroSQL(THIS.this_nLocalEnts, 0) + "," + ;
                       " obsaprovs   = " + EscaparSQL(THIS.this_cObsAprovs) + "," + ;
                       " obsaprsols  = " + EscaparSQL(THIS.this_cObsAprSols) + "," + ;
                       " copias      = " + FormatarNumeroSQL(THIS.this_nCopias, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvcotBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
