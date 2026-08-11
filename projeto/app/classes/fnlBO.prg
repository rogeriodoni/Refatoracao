*==============================================================================
* fnlBO.prg - Business Object para Tabela de Finalizacoes (SigFiNal)
* Herda de: BusinessBase
* Tabela: SigFiNal (PK composta: imps + ordems)
*==============================================================================

DEFINE CLASS fnlBO AS BusinessBase

    *-- Propriedades da tabela SigFiNal
    this_cImps       = ""   && char(20) - Impressora (PK parte 1)
    this_nOrdems     = 0    && numeric(2,0) - Ordem finalizadora
    this_cDescrs     = ""   && char(40) - Descricao
    this_nCodFinzs   = 0    && numeric(2,0) - Codigo finalizador
    this_nFixos      = 2    && numeric(1,0) - Fixo (1=Sim, 2=Nao)
    this_cVincs      = "N"  && char(1) - Vinculado (S/N)
    this_nRelGers    = 0    && numeric(1,0) - FK SigFiRlg.ordems
    this_cDescs      = ""   && alias SigFiRlg.descrs (nao coluna real - lookup display)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiNal"
        THIS.this_cCampoChave = "imps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cImps) + STR(THIS.this_nOrdems, 2, 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cImps       = TratarNulo(imps,       "C")
            THIS.this_nOrdems     = TratarNulo(ordems,     "N")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_nCodFinzs   = TratarNulo(ncodfinzs,  "N")
            THIS.this_nFixos      = TratarNulo(nfixos,     "N")
            THIS.this_cVincs      = TratarNulo(vincs,      "C")
            THIS.this_nRelGers    = TratarNulo(nrelgers,   "N")
            *-- descs vem do JOIN; se coluna existir no cursor, carregar
            IF TYPE("descs") != "U"
                THIS.this_cDescs  = TratarNulo(descs,      "C")
            ELSE
                THIS.this_cDescs  = ""
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNal")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar finalizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps" + ;
                       " WHERE a.imps = " + EscaparSQL(par_cImps) + ;
                       " AND a.ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFnl")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CarregaFnl") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFnl")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_CarregaFnl")
            USE IN cursor_4c_CarregaFnl
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarRelGerencial - Busca registros de SigFiRlg para lookup de Rel. Gerencial
    *--------------------------------------------------------------------------
    PROCEDURE BuscarRelGerencial(par_cImps, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(par_cCursorDestino)
            par_cCursorDestino = "cursor_4c_RelGer"
        ENDIF

        TRY
            loc_cSQL = "SELECT ordems, descrs FROM SigFiRlg" + ;
                       " WHERE imps = " + EscaparSQL(par_cImps) + ;
                       " ORDER BY ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Rel. Gerencial:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNal" + ;
                       " (imps, ordems, descrs, nfixos, ncodfinzs, vincs, nrelgers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cImps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       EscaparSQL(THIS.this_cVincs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNal SET" + ;
                       " imps = "      + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " descrs = "    + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = "    + FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       " ncodfinzs = " + FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       " vincs = "     + EscaparSQL(THIS.this_cVincs) + ", " + ;
                       " nrelgers = "  + FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOrdemDuplicada - Verifica se Imps+Ordems ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrdemDuplicada(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldOrd")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldOrd") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldOrd")
            USE IN cursor_4c_VldOrd
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoDuplicado - Verifica se Imps+ncodfinzs ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigoDuplicado(par_cImps, par_nCodFinzs)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ncodfinzs = " + FormatarNumeroSQL(par_nCodFinzs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldCod")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldCod") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldCod")
            USE IN cursor_4c_VldCod
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoNcodFinzs - Proximo codigo finalizador disponivel por impressora
    * Substitui fGerUniqueKey('SigFiNal') do legado
    *--------------------------------------------------------------------------
    PROCEDURE GerarProximoNcodFinzs(par_cImps)
        LOCAL loc_nResultado, loc_nProximo
        loc_nProximo = 1

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ncodfinzs), 0) + 1 AS Proximo FROM SigFiNal" + ;
                " WHERE imps = " + EscaparSQL(par_cImps), ;
                "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = cursor_4c_ProxCod.Proximo
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo c" + CHR(243) + "digo:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDPROC

ENDDEFINE
