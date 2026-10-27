*==============================================================================
* FpoBO.prg - Business Object de Condicao de Pagamento Por Operacao
* Tabela: SigOpFpo
* PK: cidchaves
*==============================================================================

DEFINE CLASS FpoBO AS BusinessBase

    *-- Propriedades da tabela SigOpFpo
    this_cCidChaves  = ""    && PK char(20) - chave unica gerada
    this_cDopes      = ""    && char(20) - codigo da operacao (FK SigCdOpe)
    this_cFPags      = ""    && char(12) - condicao de pagamento (FK SigOpFp)
    this_nObrigs     = 0     && numeric(1,0) - obrigatorio (0/1)
    this_nAutos      = 0     && numeric(1,0) - so automatico (0/1)
    this_nContabs    = 0     && numeric(1,0) - nao contabilizar (0/1)
    this_cFPagss     = ""    && char(12) - condicao substituta
    this_nBlqAltExc  = 0     && numeric(1,0) - bloqueado para alterar/excluir (0/1)

    *-- Contexto de operacao corrente (preenchido pelo Form antes de Buscar)
    this_cDopesAtual = ""    && codigo da operacao em edicao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(CidChaves, "C")
            THIS.this_cDopes      = TratarNulo(Dopes,     "C")
            THIS.this_cFPags      = TratarNulo(FPags,     "C")
            THIS.this_nObrigs     = TratarNulo(Obrigs,    "N")
            THIS.this_nAutos      = TratarNulo(Autos,     "N")
            THIS.this_nContabs    = TratarNulo(Contabs,   "N")
            THIS.this_cFPagss     = TratarNulo(FPagss,    "C")
            THIS.this_nBlqAltExc  = TratarNulo(BlqAltExc, "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo CidChaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo" + ;
                       " WHERE CidChaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFpo")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_CarregaFpo") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFpo")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_CarregaFpo")
            USE IN cursor_4c_CarregaFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpo filtrados por Dopes
    * Retorna cursor_4c_Dados com as condicoes de pagamento da operacao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cDopesAtual))
                loc_cWhere = "WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopesAtual))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = "WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo " + loc_cWhere + ;
                       " ORDER BY FPags"

            *-- Fechar o cursor anterior ANTES do SQLEXEC. Sem isto, se a grade
            *-- deixou alteracao pendente no buffer, o SQLEXEC estoura com
            *-- "Table buffer for alias CURSOR_4C_DADOS contains uncommitted
            *-- changes". O guard testa o Buffering antes do TABLEREVERT: sem
            *-- buffering ele nao eh no-op, dispara o erro 1586 (regra #52).
            IF USED("cursor_4c_Dados")
                IF CURSORGETPROP("Buffering", "cursor_4c_Dados") > 1
                    TABLEREVERT(.T., "cursor_4c_Dados")
                ENDIF
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Buscar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCondicoesPagamento - Carrega SigOpFp disponivel em crSigOpFp
    * Usado pelo lookup do campo FPags no grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCondicoesPagamento()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT FPags, Fparcs, Situas FROM SigOpFp ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - BuscarCondicoesPagamento")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - BuscarCondicoesPagamento")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Valida se ha FPags duplicados no cursor
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicados(par_cCursorDados)
        LOCAL loc_lResultado, loc_cFPagsAnt, loc_cFPagsAtual
        loc_lResultado = .T.

        IF !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        TRY
            *-- Ordena copia do cursor por FPags para detectar adjacentes iguais
            SELECT FPags FROM (par_cCursorDados) ;
                WHERE !EMPTY(ALLTRIM(FPags)) ORDER BY FPags ;
                INTO CURSOR cursor_4c_SortFpo

            IF USED("cursor_4c_SortFpo")
                SELECT cursor_4c_SortFpo
                GO TOP
                loc_cFPagsAnt = ""
                SCAN
                    loc_cFPagsAtual = ALLTRIM(FPags)
                    IF loc_cFPagsAtual == loc_cFPagsAnt
                        MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                            loc_cFPagsAtual + " Digitada em Duplicidade!!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                    loc_cFPagsAnt = loc_cFPagsAtual
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ValidarDuplicados")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_SortFpo")
            USE IN cursor_4c_SortFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLote - Salva todos os registros do grid de volta ao SigOpFpo
    * par_cDopes: codigo da operacao
    * par_cCursorDados: alias do cursor com os dados do grid (ex: crSigOpFpo)
    * Logica: valida duplicatas, gera chaves, delete+insert atomico no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLote(par_cDopes, par_cCursorDados, par_cEscopoDopes)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_lTransacaoAberta, loc_lErroInsert
        LOCAL loc_cEscopo, loc_cIn, loc_nI, loc_cItem
        loc_lResultado    = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroInsert   = .F.

        *-- ESCOPO do DELETE. A tela aberta pelo MENU traz VARIAS operacoes na
        *-- grade e chega aqui com par_cDopes vazio: apagar por uma operacao so
        *-- destruiria as demais. Entao o escopo eh a UNIAO de:
        *--   par_cDopes        - o dialogo filho, aberto para UMA operacao
        *--   par_cEscopoDopes  - o que estava na grade quando ela carregou
        *--                       (cobre a linha EXCLUIDA, que sumiu do cursor)
        *--   Dopes do cursor   - cobre a linha INCLUIDA numa operacao nova
        loc_cEscopo = ""
        IF VARTYPE(par_cDopes) = "C" AND !EMPTY(ALLTRIM(par_cDopes))
            loc_cEscopo = ALLTRIM(par_cDopes)
        ENDIF
        IF VARTYPE(par_cEscopoDopes) = "C" AND !EMPTY(ALLTRIM(par_cEscopoDopes))
            loc_cEscopo = loc_cEscopo + IIF(EMPTY(loc_cEscopo), "", ",") + ALLTRIM(par_cEscopoDopes)
        ENDIF

        IF !USED(par_cCursorDados)
            MsgAviso("Cursor de dados n" + CHR(227) + "o encontrado", "")
            RETURN .F.
        ENDIF

        IF !THIS.ValidarDuplicados(par_cCursorDados)
            RETURN .F.
        ENDIF

        *-- acrescenta as operacoes presentes no cursor (linhas novas)
        SELECT (par_cCursorDados)
        GO TOP
        SCAN
            loc_cItem = ALLTRIM(NVL(Dopes, ""))
            IF !EMPTY(loc_cItem) AND !("," + UPPER(loc_cItem) + "," $ "," + UPPER(loc_cEscopo) + ",")
                loc_cEscopo = loc_cEscopo + IIF(EMPTY(loc_cEscopo), "", ",") + loc_cItem
            ENDIF
        ENDSCAN

        IF EMPTY(loc_cEscopo)
            MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o a gravar.", "")
            RETURN .F.
        ENDIF

        *-- monta o IN (...) escapando cada item
        loc_cIn = ""
        FOR loc_nI = 1 TO OCCURS(",", loc_cEscopo) + 1
            loc_cItem = ALLTRIM(GETWORDNUM(loc_cEscopo, loc_nI, ","))
            IF !EMPTY(loc_cItem)
                loc_cIn = loc_cIn + IIF(EMPTY(loc_cIn), "", ", ") + EscaparSQL(loc_cItem)
            ENDIF
        ENDFOR

        TRY
            *-- Gerar CidChaves para linhas novas (FPags nao vazio, CidChaves vazio)
            SELECT (par_cCursorDados)
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(FPags)) AND EMPTY(ALLTRIM(CidChaves))
                    loc_cCidChaves = fUniqueIds()
                    REPLACE CidChaves WITH loc_cCidChaves IN (par_cCursorDados)
                ENDIF
            ENDSCAN

            *-- Abrir transacao atomica
            loc_nResultado = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            IF loc_nResultado >= 0
                loc_lTransacaoAberta = .T.

                *-- Deletar os registros das operacoes NO ESCOPO (nunca das outras)
                loc_cSQL = "DELETE FROM SigOpFpo WHERE Dopes IN (" + loc_cIn + ")"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    *-- Reinserir as linhas validas (com FPags preenchido)
                    SELECT (par_cCursorDados)
                    GO TOP
                    SCAN WHILE !loc_lErroInsert
                        IF !EMPTY(ALLTRIM(FPags))
                            THIS.this_cCidChaves = ALLTRIM(CidChaves)
                            THIS.this_cDopes     = ALLTRIM(Dopes)
                            THIS.this_cFPags     = ALLTRIM(FPags)
                            THIS.this_nObrigs    = NVL(Obrigs, 0)
                            THIS.this_nAutos     = NVL(Autos, 0)
                            THIS.this_nContabs   = NVL(Contabs, 0)
                            THIS.this_cFPagss    = ALLTRIM(NVL(FPagss, ""))
                            THIS.this_nBlqAltExc = NVL(BlqAltExc, 0)
                            IF !THIS.Inserir()
                                loc_lErroInsert = .T.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao excluir registros anteriores")
                    loc_lErroInsert = .T.
                ENDIF

                IF !loc_lErroInsert
                    loc_nResultado = SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    IF loc_nResultado >= 0
                        loc_lTransacaoAberta = .F.
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote COMMIT")
                    ENDIF
                ENDIF

                IF loc_lTransacaoAberta
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote BEGIN TRANSACTION")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - SalvarLote")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigOpFpo
    * Chamado por SalvarLote e por BusinessBase.Salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpFpo" + ;
                " (CidChaves, Dopes, FPags, Obrigs, Autos, Contabs, FPagss, BlqAltExc)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)  + ", " + ;
                EscaparSQL(THIS.this_cDopes)       + ", " + ;
                EscaparSQL(THIS.this_cFPags)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nObrigs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nContabs)  + ", " + ;
                EscaparSQL(THIS.this_cFPagss)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqAltExc) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Inserir")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpFpo SET" + ;
                " Dopes    = " + EscaparSQL(THIS.this_cDopes)          + ", " + ;
                " FPags    = " + EscaparSQL(THIS.this_cFPags)          + ", " + ;
                " Obrigs   = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ", " + ;
                " Autos    = " + FormatarNumeroSQL(THIS.this_nAutos)   + ", " + ;
                " Contabs  = " + FormatarNumeroSQL(THIS.this_nContabs) + ", " + ;
                " FPagss   = " + EscaparSQL(THIS.this_cFPagss)         + ", " + ;
                " BlqAltExc= " + FormatarNumeroSQL(THIS.this_nBlqAltExc) + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Atualizar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro de SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpFpo" + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
