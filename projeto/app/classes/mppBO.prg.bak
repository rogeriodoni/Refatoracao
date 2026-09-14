*==============================================================================
* mppBO.prg - Business Object para Complementos de Caracteristicas
* Tabela  : SigPrCpP
* PK      : CidChaves (UUID gerado por fUniqueIds)
* nTipos  : 0=Produtos  1=Contas  2=Movimentacoes
*==============================================================================

DEFINE CLASS mppBO AS BusinessBase

    *-- Chave primaria (UUID)
    this_cCidChaves     = ""    && char(20)    CidChaves - PK gerada por fUniqueIds()

    *-- Dados cadastrais
    this_cCodigos       = ""    && char(20)    Codigos   - Codigo do complemento
    this_cDescrs        = ""    && char(40)    Descrs    - Descricao

    *-- Tipo de complemento
    this_nTipos         = 0     && numeric(1)  nTipos    - 0=Produto 1=Conta 2=Movimentacao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCpP"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de complementos filtrados por nTipos
    *   par_cFiltro : filtro SQL adicional (sem WHERE) ou "" para todos
    *   par_nTipos  : 0/1/2 conforme tipo; -1 = sem filtro de tipo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP"

            loc_cWhere = ""

            IF VARTYPE(par_nTipos) = "N" AND par_nTipos >= 0
                loc_cWhere = "nTipos = " + ALLTRIM(STR(par_nTipos, 1))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                IF EMPTY(loc_cWhere)
                    loc_cWhere = par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            IF !EMPTY(loc_cWhere)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega complemento pela PK (CidChaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP" + ;
                       " WHERE CidChaves = " + EscaparSQL(par_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigosETipo - Busca por Codigos + nTipos (chave natural)
    *   Usada para verificar duplicata antes de inserir
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigosETipo(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.CarregarPorCodigosETipo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoDuplicado - Retorna .T. se Codigos+nTipos ja existe
    *   (chamado antes do INSERT para barrar duplicatas - logica do legado)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoDuplicado(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            IF USED("cursor_4c_Duplica")
                USE IN cursor_4c_Duplica
            ENDIF

            loc_cSQL = "SELECT TOP 1 CidChaves FROM SigPrCpP" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplica")
            IF loc_nResult > 0
                loc_lDuplicado = (RECCOUNT("cursor_4c_Duplica") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarCodigoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Duplica")
            USE IN cursor_4c_Duplica
        ENDIF
        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoEmCaracteristicasContas - Verifica uso em SigClCrc.Compls
    *   Legado: antes de excluir registro com nTipos=1, verificar uso
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoEmCaracteristicasContas(par_cDescrs)
        LOCAL loc_cSQL, loc_nResult, loc_lEmUso
        loc_lEmUso = .F.
        TRY
            IF USED("cursor_4c_VerUso")
                USE IN cursor_4c_VerUso
            ENDIF

            loc_cSQL = "SELECT TOP 1 Compls FROM SigClCrc" + ;
                       " WHERE Compls = " + EscaparSQL(par_cDescrs)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerUso")
            IF loc_nResult > 0
                loc_lEmUso = (RECCOUNT("cursor_4c_VerUso") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarUsoEmCaracteristicasContas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerUso")
            USE IN cursor_4c_VerUso
        ENDIF
        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoEmFichasTecnicas - Verifica uso em SigCdFtc.CTits + nTipos
    *   Legado: antes de excluir, verificar se codigo e titulo de ficha tecnica
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoEmFichasTecnicas(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lEmUso
        loc_lEmUso = .F.
        TRY
            IF USED("cursor_4c_VerFtc")
                USE IN cursor_4c_VerFtc
            ENDIF

            loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdFtc" + ;
                       " WHERE CTits = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFtc")
            IF loc_nResult > 0
                loc_lEmUso = (RECCOUNT("cursor_4c_VerFtc") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarUsoEmFichasTecnicas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerFtc")
            USE IN cursor_4c_VerFtc
        ENDIF
        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cDescrs    = TratarNulo(Descrs,    "C")
            THIS.this_nTipos     = TratarNulo(nTipos,    "N")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cChave
        loc_lSucesso = .F.
        TRY
            loc_cChave           = fUniqueIds()
            THIS.this_cCidChaves = loc_cChave

            loc_cSQL = "INSERT INTO SigPrCpP (CidChaves, Codigos, Descrs, nTipos) VALUES (" + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ", " + ;
                       ALLTRIM(STR(THIS.this_nTipos, 1)) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Legado so permite alterar Descrs (Codigos e readonly em modo ALTERAR)
            loc_cSQL = "UPDATE SigPrCpP SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrCpP WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Del")
            USE IN cursor_4c_Del
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
