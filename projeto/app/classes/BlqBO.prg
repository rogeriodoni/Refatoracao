*------------------------------------------------------------------------------
* BlqBO.prg - Business Object para Bloqueios por Periodo (SigCdBlq)
* Herda de: BusinessBase
* Tabela: SigCdBlq
*------------------------------------------------------------------------------
DEFINE CLASS BlqBO AS BusinessBase

    *-- Propriedades da tabela SigCdBlq
    this_cCodigos   = ""    && Codigos    CHAR(10) - C" + CHR(243) + "digo gerado por fGerUniqueKey('BLOQUEIO')
    this_cCidChaves = ""    && CidChaves  CHAR     - Chave " + CHR(250) + "nica interna (gerada por fUniqueIds)
    this_dDtInicial = {}    && dtInicial  DATE     - Data inicial do per" + CHR(237) + "odo de bloqueio
    this_dDtFinal   = {}    && dtFinal    DATE     - Data final do per" + CHR(237) + "odo de bloqueio
    this_lInativo   = .F.   && inativo    LOGICAL  - Flag de registro inativo
    this_cUsuIncs   = ""    && UsuIncs    CHAR     - Usu" + CHR(225) + "rio de inclus" + CHR(227) + "o (somente leitura)
    this_dDtIncs    = {}    && DtIncs     DATETIME - Data/hora de inclus" + CHR(227) + "o (somente leitura)
    this_cUsuAlts   = ""    && UsuAlts    CHAR     - Usu" + CHR(225) + "rio de altera" + CHR(231) + CHR(227) + "o (somente leitura)
    this_dDtAlts    = {}    && DtAlts     DATETIME - Data/hora de altera" + CHR(231) + CHR(227) + "o (somente leitura)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdBlq"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_dDtInicial = TratarNulo(dtInicial, "D")
            THIS.this_dDtFinal   = TratarNulo(dtFinal,   "D")
            THIS.this_lInativo   = ConverterParaLogico(inativo)
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs,   "C")
            THIS.this_dDtIncs    = TratarNulo(DtIncs,    "D")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts,   "C")
            THIS.this_dDtAlts    = TratarNulo(DtAlts,    "D")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros da tabela (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, dtInicial, dtFinal, UsuIncs, DtIncs," + ;
                       " UsuAlts, DtAlts, inativo" + ;
                       " FROM SigCdBlq"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar bloqueios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, CidChaves, dtInicial, dtFinal, inativo," + ;
                       " UsuIncs, DtIncs, UsuAlts, DtAlts" + ;
                       " FROM SigCdBlq" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui novo registro no banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCodigos   = fGerMascara(fGerUniqueKey("BLOQUEIO"))
            THIS.this_cCidChaves = fUniqueIds()
            THIS.this_cUsuIncs   = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "INSERT INTO SigCdBlq" + ;
                       " (Codigos, CidChaves, dtInicial, dtFinal, inativo," + ;
                       "  UsuIncs, DtIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtInicial) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtFinal) + ", " + ;
                       IIF(THIS.this_lInativo, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cUsuIncs) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente no banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuAlts = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "UPDATE SigCdBlq SET" + ;
                       " dtInicial = " + FormatarDataSQL(THIS.this_dDtInicial) + "," + ;
                       " dtFinal   = " + FormatarDataSQL(THIS.this_dDtFinal) + "," + ;
                       " inativo   = " + IIF(THIS.this_lInativo, "1", "0") + "," + ;
                       " UsuAlts   = " + EscaparSQL(THIS.this_cUsuAlts) + "," + ;
                       " DtAlts    = GETDATE()" + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro do banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdBlq" + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
