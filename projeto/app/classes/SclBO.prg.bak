*==============================================================================
* SclBO.prg - Business Object para Situacao de Contas
* Tabela: SigCdCst | PK: codigos
*==============================================================================

DEFINE CLASS SclBO AS BusinessBase

    *-- Propriedades - SigCdCst
    this_cCodigos  = ""    && codigos  char(3)
    this_cDescrs   = ""    && descrs   char(30)
    this_cDescr2s  = ""    && descr2s  char(30) - Descricao Para Movimentacoes
    this_cMalads   = ""    && cmalads  char(1)  - Mala Direta (S/N)
    this_nDispMovs = 0     && dispmovs numeric(1,0) - Movimentacao (0=Sim 1=Nao)
    this_nPriors   = 0     && priors   numeric(3,0) - Prioridade
    this_nAutos    = 0     && autos    numeric(1,0) - Tipo (0=Normal 1=Automatica)
    this_nBlqMovs  = 0     && blqmovs  numeric(1,0) - Bloquear Movimentacao (0=Sim 1=Nao 2=VerificaCondPagto)
    this_nBlqDescs = 0     && blqdescs numeric(1,0) - Bloquear Desconto (0=Sim 1=Nao)
    this_nUltCompra = 0    && ultcompra numeric(6,3) - Exibe dados Ultima Compra (0=Sim 1=Nao)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCst"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(codigos,   "C")
            THIS.this_cDescrs    = TratarNulo(descrs,    "C")
            THIS.this_cDescr2s   = TratarNulo(descr2s,   "C")
            THIS.this_cMalads    = TratarNulo(cmalads,   "C")
            THIS.this_nDispMovs  = TratarNulo(dispmovs,  "N")
            THIS.this_nPriors    = TratarNulo(priors,    "N")
            THIS.this_nAutos     = TratarNulo(autos,     "N")
            THIS.this_nBlqMovs   = TratarNulo(blqmovs,   "N")
            THIS.this_nBlqDescs  = TratarNulo(blqdescs,  "N")
            THIS.this_nUltCompra = TratarNulo(ultcompra, "N")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra" + ;
                       " FROM SigCdCst"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra" + ;
                       " FROM SigCdCst WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(UPPER(ALLTRIM(THIS.this_cMalads)), "S", "N")
            MsgAviso("Especifica" + CHR(231) + CHR(227) + "o da Mala Direta Inv" + CHR(225) + "lida, Apenas [S]im ou [N]" + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdCst" + ;
                       " (codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)             + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)              + ", " + ;
                       EscaparSQL(THIS.this_cDescr2s)             + ", " + ;
                       EscaparSQL(UPPER(THIS.this_cMalads))       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDispMovs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPriors)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutos)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqMovs)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqDescs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUltCompra)     + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCst SET" + ;
                       " descrs   = " + EscaparSQL(THIS.this_cDescrs)              + ", " + ;
                       " descr2s  = " + EscaparSQL(THIS.this_cDescr2s)             + ", " + ;
                       " cmalads  = " + EscaparSQL(UPPER(THIS.this_cMalads))       + ", " + ;
                       " dispmovs = " + FormatarNumeroSQL(THIS.this_nDispMovs)      + ", " + ;
                       " priors   = " + FormatarNumeroSQL(THIS.this_nPriors)        + ", " + ;
                       " autos    = " + FormatarNumeroSQL(THIS.this_nAutos)         + ", " + ;
                       " blqmovs  = " + FormatarNumeroSQL(THIS.this_nBlqMovs)       + ", " + ;
                       " blqdescs = " + FormatarNumeroSQL(THIS.this_nBlqDescs)      + ", " + ;
                       " ultcompra= " + FormatarNumeroSQL(THIS.this_nUltCompra)     + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCst WHERE codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
