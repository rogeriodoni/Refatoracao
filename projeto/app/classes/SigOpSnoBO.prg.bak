*==============================================================================
* SigOpSnoBO.prg - Business Object para Sub-Niveis da Operacao
* Tabela principal: SigOpCsn | PK: cidchaves
* Tabela secundaria: SigOpOss (Sub-Sub-Nivel por Sub-Nivel) | PK: cidchaves
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpSnoBO AS BusinessBase

    *-- Propriedades da entidade principal (mapeamento para tabela SigOpCsn)
    *-- PK
    this_cCidChaves     = ""    && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())

    *-- Chaves de relacionamento
    this_cCDopes        = ""    && cdopes char(20) NOT NULL - FK SigCdOpe.dopes (operacao pai)
    this_cCNivels       = ""    && cnivels char(20) NOT NULL - FK SigCdOpe.dopes (operacao usada como sub-nivel)

    *-- Flags / controles (numeric(1,0)) - ver CheckBox das colunas O/P/C/S/T da grade
    this_nObrigs        = 0     && obrigs numeric(1,0) NOT NULL - "O" = Obrigatorio
    this_nPgSubNNs      = 0     && pgsubnns numeric(1,0) NOT NULL - "P" = Bx SubNivel do SubNivel c/Pago
    this_nCBxPagos      = 0     && cbxpagos numeric(1,0) NOT NULL - "C" = Cancela Bx SubNivel do SubNivel c/Pago
    this_nTStatus       = 0     && tstatus numeric(1,0) NOT NULL - "S" = Controle de Status (Aprovado/Reprovado)
    this_nCkAtCta       = 0     && ckatcta numeric(1,0) NOT NULL - "T" = Atualiza o Grupo e Conta de Origem conforme o SubNivel
    this_nTrfCtaDSor    = 0     && trfctadsor numeric(1,0) NOT NULL - sem controle na tela (grava 0 - regra de INSERT NOT NULL)

    *-- Lookups
    this_nCodObs        = 0     && codobs numeric(3,0) NOT NULL - FK SigCdObs.Codigos (Observacao)
    this_cTpFats        = ""    && tpfats char(3) NOT NULL - FK SigCdTif.Codigos (Tipo de Faturamento)

    *-- Campo de exibicao (JOIN com SigCdOpe, somente leitura, nao persiste em SigOpCsn)
    this_nNDopes        = 0     && SigCdOpe.ndopes - numero sequencial da operacao (exibido no modo inverso)

    *-- Propriedades da entidade secundaria (tabela SigOpOss - sub-sub-nivel por sub-nivel)
    this_cCidChavesOss  = ""    && cidchaves char(20) NOT NULL - PK de SigOpOss (gerada com fUniqueIds())
    this_cCDopesOss     = ""    && cdopes char(20) NOT NULL - FK SigCdOpe.dopes (operacao pai, copiado de this_cCDopes)
    this_cCNivelsOss    = ""    && cnivels char(20) NOT NULL - FK copiado de this_cCNivels (sub-nivel ao qual pertence)
    this_cDopess        = ""    && dopess char(20) NOT NULL - FK SigCdOpe.dopes (sub-sub-nivel)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpCsn"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do sub-nivel a partir de um
    * cursor posicionado em uma linha de SigOpCsn (ou de um SELECT que inclua
    * as mesmas colunas + o campo de exibicao opcional "ndopes", vindo do
    * JOIN com SigCdOpe)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCDopes     = TratarNulo(cdopes,     "C")
                THIS.this_cCNivels    = TratarNulo(cnivels,    "C")
                THIS.this_nObrigs     = TratarNulo(obrigs,     "N")
                THIS.this_nPgSubNNs   = TratarNulo(pgsubnns,   "N")
                THIS.this_nCBxPagos   = TratarNulo(cbxpagos,   "N")
                THIS.this_nTStatus    = TratarNulo(tstatus,    "N")
                THIS.this_nCkAtCta    = TratarNulo(ckatcta,    "N")
                THIS.this_nTrfCtaDSor = TratarNulo(trfctadsor, "N")
                THIS.this_nCodObs     = TratarNulo(codobs,     "N")
                THIS.this_cTpFats     = TratarNulo(tpfats,     "C")

                *-- Campo de exibicao vindo do JOIN com SigCdOpe (presente so
                *-- quando o SELECT que populou o cursor o incluiu)
                IF TYPE(par_cAliasCursor + ".ndopes") != "U"
                    THIS.this_nNDopes = TratarNulo(ndopes, "N")
                ENDIF

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui um novo sub-nivel (linha de SigOpCsn) no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o 2o registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpCsn" + ;
                       " (cdopes, cnivels, cidchaves, obrigs, cbxpagos, codobs," + ;
                       "  pgsubnns, tstatus, tpfats, ckatcta, trfctadsor)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopes) + ", " + ;
                       EscaparSQL(THIS.this_cCNivels) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCBxPagos, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPgSubNNs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTStatus, 0) + ", " + ;
                       EscaparSQL(THIS.this_cTpFats) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCkAtCta, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTrfCtaDSor, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSno")
                USE IN cursor_4c_InsSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um sub-nivel (linha de SigOpCsn) existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpCsn SET" + ;
                       " cdopes     = " + EscaparSQL(THIS.this_cCDopes) + "," + ;
                       " cnivels    = " + EscaparSQL(THIS.this_cCNivels) + "," + ;
                       " obrigs     = " + FormatarNumeroSQL(THIS.this_nObrigs, 0) + "," + ;
                       " cbxpagos   = " + FormatarNumeroSQL(THIS.this_nCBxPagos, 0) + "," + ;
                       " codobs     = " + FormatarNumeroSQL(THIS.this_nCodObs, 0) + "," + ;
                       " pgsubnns   = " + FormatarNumeroSQL(THIS.this_nPgSubNNs, 0) + "," + ;
                       " tstatus    = " + FormatarNumeroSQL(THIS.this_nTStatus, 0) + "," + ;
                       " tpfats     = " + EscaparSQL(THIS.this_cTpFats) + "," + ;
                       " ckatcta    = " + FormatarNumeroSQL(THIS.this_nCkAtCta, 0) + "," + ;
                       " trfctadsor = " + FormatarNumeroSQL(THIS.this_nTrfCtaDSor, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSno")
                USE IN cursor_4c_UpdSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove um sub-nivel (linha de SigOpCsn) do banco.
    * Remove TAMBEM os sub-sub-niveis (SigOpOss) que dependem dele, pois o
    * legado permite excluir o sub-nivel so quando ele ainda eh o corrente na
    * grade (cmdExcluir.Click do SCX) e nao deixa registros orfaos em SigOpOss.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOss" + ;
                       " WHERE cidchaves IN (" + ;
                       " SELECT cidchaves FROM SigOpCsn WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelOssDep")
            IF USED("cursor_4c_DelOssDep")
                USE IN cursor_4c_DelOssDep
            ENDIF

            loc_cSQL = "DELETE FROM SigOpCsn" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelSno")
                USE IN cursor_4c_DelSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarSubNiveis - Popula cursor_4c_SubNiveis com os sub-niveis da
    * operacao (modo direto, equivalente ao legado "ReQuery('crSigOpCsn')"
    * filtrado por cdopes) ou com as operacoes que usam a operacao como
    * sub-nivel (modo inverso, equivalente ao "lcSql = Select a.*,b.nDopes
    * From SigOpCsn a Inner Join SigCdOpe b ... Where a.cNivels = ...").
    *
    * O JOIN com SigCdOpe traz ndopes (Column2 "#" da grade) da OPERACAO QUE
    * VARIA linha a linha - cnivels no modo direto (a coluna que o usuario
    * escolhe via lookup em cada sub-nivel), cdopes no modo inverso -, NUNCA
    * da coluna fixa pelo filtro WHERE. Juntar sempre por a.cdopes faria toda
    * linha, em modo direto, mostrar o ndopes da OPERACAO PAI repetido (pai
    * eh fixo pelo WHERE), em vez do ndopes de cada sub-nivel escolhido.
    * LEFT JOIN (nao INNER): linha com a coluna variavel ainda vazia (recem
    * inserida, antes do lookup) nao pode desaparecer do cursor.
    * Cursor READWRITE (regra sobre Grid com coluna editavel): as colunas O/
    * P/C/S/T sao CheckBox de grade e o codigo/observacao/tipo de fat. sao
    * TextBox editaveis na grade.
    *--------------------------------------------------------------------------
    FUNCTION ListarSubNiveis(par_cOperacaoPai, par_lModoInverso)
        LOCAL loc_cOperacaoPai, loc_lInverso, loc_cCampoFiltro, loc_cCampoJoin, ;
              loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
        loc_lInverso     = IIF(VARTYPE(par_lModoInverso) = "L", par_lModoInverso, .F.)
        loc_cCampoFiltro = IIF(loc_lInverso, "a.cnivels", "a.cdopes")
        loc_cCampoJoin   = IIF(loc_lInverso, "a.cdopes", "a.cnivels")

        TRY
            loc_cSQL = "SELECT a.*, b.ndopes AS ndopes" + ;
                       " FROM SigOpCsn a LEFT JOIN SigCdOpe b ON " + loc_cCampoJoin + " = b.dopes" + ;
                       " WHERE " + loc_cCampoFiltro + " = " + EscaparSQL(loc_cOperacaoPai) + ;
                       " ORDER BY a.cnivels"

            IF USED("cursor_4c_SubNivTmp")
                USE IN cursor_4c_SubNivTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubNivTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SubNiveis")
                    USE IN cursor_4c_SubNiveis
                ENDIF
                SELECT * FROM cursor_4c_SubNivTmp INTO CURSOR cursor_4c_SubNiveis READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar sub-n" + CHR(237) + "veis da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SubNivTmp")
                USE IN cursor_4c_SubNivTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ListarSubNiveis:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ListarSubSubNiveis - Popula cursor_4c_SubSubNiveis com os sub-sub-niveis
    * (SigOpOss) da operacao, equivalente ao legado "lcSql = Select * From
    * SigOpOss Where cDopes = ...", igual nos dois modos (direto/inverso).
    * Cursor READWRITE: a grade de sub-sub-niveis recebe linhas novas via
    * Append Blank no AfterRowColChange da grade de sub-niveis (Fase 8).
    *--------------------------------------------------------------------------
    FUNCTION ListarSubSubNiveis(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        TRY
            loc_cSQL = "SELECT * FROM SigOpOss" + ;
                       " WHERE cdopes = " + EscaparSQL(loc_cOperacaoPai)

            IF USED("cursor_4c_SubSubNivTmp")
                USE IN cursor_4c_SubSubNivTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubSubNivTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SubSubNiveis")
                    USE IN cursor_4c_SubSubNiveis
                ENDIF
                SELECT * FROM cursor_4c_SubSubNivTmp INTO CURSOR cursor_4c_SubSubNiveis READWRITE
                INDEX ON cnivels TAG cnivels
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar sub-sub-n" + CHR(237) + "veis da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SubSubNivTmp")
                USE IN cursor_4c_SubSubNivTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ListarSubSubNiveis:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSubSubNivelDoCursor - Carrega as propriedades do sub-sub-nivel
    * (SigOpOss) a partir de um cursor posicionado numa linha dessa tabela.
    * PUBLIC: chamado diretamente pelo Form (padrao operacional, regra do
    * cabecalho de BusinessBase sobre Inserir/Atualizar/Oss serem chamados
    * de fora em telas que nao seguem o fluxo unico de FormParaBO/BOParaForm).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubSubNivelDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChavesOss = TratarNulo(cidchaves, "C")
                THIS.this_cCDopesOss    = TratarNulo(cdopes,    "C")
                THIS.this_cCNivelsOss   = TratarNulo(cnivels,   "C")
                THIS.this_cDopess       = TratarNulo(dopess,    "C")
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirSubSubNivel - Inclui um novo sub-sub-nivel (linha de SigOpOss)
    *--------------------------------------------------------------------------
    PROCEDURE InserirSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChavesOss)
                THIS.this_cCidChavesOss = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpOss (cdopes, cidchaves, cnivels, dopess)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopesOss) + ", " + ;
                       EscaparSQL(THIS.this_cCidChavesOss) + ", " + ;
                       EscaparSQL(THIS.this_cCNivelsOss) + ", " + ;
                       EscaparSQL(THIS.this_cDopess) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsOss")
                USE IN cursor_4c_InsOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.InserirSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSubSubNivel - Atualiza o sub-sub-nivel (dopess) de uma linha
    * de SigOpOss ja existente. O legado (view remota com buffer) nao
    * precisa disso - o TableUpdate final grava o valor corrente da linha,
    * nova ou editada, da mesma forma. Sem view buferizada, a linha editada
    * (cidchaves ja gravado antes) exige UPDATE explicito - so INSERT
    * duplicaria a linha com o mesmo cidchaves.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOss SET" + ;
                       " cdopes  = " + EscaparSQL(THIS.this_cCDopesOss) + "," + ;
                       " cnivels = " + EscaparSQL(THIS.this_cCNivelsOss) + "," + ;
                       " dopess  = " + EscaparSQL(THIS.this_cDopess) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesOss)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdOss")
                USE IN cursor_4c_UpdOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.AtualizarSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirSubSubNivel - Remove um sub-sub-nivel (linha de SigOpOss)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOss" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesOss)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelOss")
                USE IN cursor_4c_DelOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ExcluirSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
