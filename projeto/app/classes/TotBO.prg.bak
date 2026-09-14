*====================================================================
* TotBO.prg
*
* Business Object para Cadastro de Tipos de Operacoes de Producao
* Tabela: SigCdToi
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TotBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdToi)
    this_nCodigo        = 0     && codigos numeric(2,0) - PK
    this_cDescricao     = ""    && descrs  char(30)
    this_nTipoOperacao  = 0     && tpgdmis numeric(1,0) - OptionGroup (1=Soma, 2=Subtrai)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
            THIS.this_cTabela     = "SigCdToi"
            THIS.this_cCampoChave = "codigos"

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TotBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de tipos de operacoes no cursor_4c_Dados
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, descrs, tpgdmis" + ;
                           " FROM SigCdToi" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs, tpgdmis" + ;
                           " FROM SigCdToi" + ;
                           " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
                           " ORDER BY codigos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
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
            loc_cSQL = "SELECT codigos, descrs, tpgdmis" + ;
                       " FROM SigCdToi" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigo       = TratarNulo(codigos, "N")
            THIS.this_cDescricao    = TratarNulo(descrs, "C")
            THIS.this_nTipoOperacao = TratarNulo(tpgdmis, "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdToi
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdToi (codigos, descrs, tpgdmis)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipoOperacao) + ;
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
    * Atualizar - UPDATE na tabela SigCdToi
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdToi SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " tpgdmis = " + FormatarNumeroSQL(THIS.this_nTipoOperacao) + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo)

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
    * ExecutarExclusao - DELETE da tabela SigCdToi
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdToi WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo)

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

ENDDEFINE
