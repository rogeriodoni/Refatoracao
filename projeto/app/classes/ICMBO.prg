*==============================================================================
* ICMBO.prg - Business Object: Cadastro de Indices de Comissao
* Tabela: SigCdCmi
* PK: cidchaves (char 20, gerado via fUniqueIds)
*==============================================================================

DEFINE CLASS ICMBO AS BusinessBase

    *-- Campos da tabela SigCdCmi
    this_cEmps      = ""    && char(3)  - Empresa
    this_cCargos    = ""    && char(10) - Cargo
    this_cFPags     = ""    && char(12) - Condicao de Pagamento
    this_cTabDes    = ""    && char(10) - Tabela de Desconto
    this_dDtInis    = {}    && datetime - Data Inicial do Periodo
    this_dDtFins    = {}    && datetime - Data Final do Periodo
    this_nComiss    = 0     && numeric(4,2) - Percentual de Comissao
    this_cIdChaves  = ""    && char(20) - Chave unica (PK, gerado por fUniqueIds)
    this_tDtAlts    = {}    && datetime - Data/hora ultima alteracao

    *-- Campos descricao (lookup, nao armazenados no banco)
    this_cDEmpresa  = ""    && Razao social da empresa (SigCdEmp.Razas)
    this_cDCargo    = ""    && Descricao do cargo (SigCdCrg.DCargs)
    this_cDTabDes   = ""    && Descricao da tabela de desconto (SigOpTdz.Descrs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCmi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ICMBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       loc_cWhere + ;
                       " ORDER BY a.emps, a.tabdes, a.cargos, a.fpags"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar " + CHR(237) + "ndices de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "ICMBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = ALLTRIM(TratarNulo(cidchaves,  "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps,       "C"))
            THIS.this_cTabDes    = ALLTRIM(TratarNulo(tabdes,     "C"))
            THIS.this_cCargos    = ALLTRIM(TratarNulo(cargos,     "C"))
            THIS.this_cFPags     = ALLTRIM(TratarNulo(fpags,      "C"))
            THIS.this_dDtInis    = TratarNulo(dtinis, "D")
            THIS.this_dDtFins    = TratarNulo(dtfins, "D")
            THIS.this_nComiss    = TratarNulo(comiss, "N")
            THIS.this_tDtAlts    = TratarNulo(dtalts, "D")
            IF TYPE(par_cAliasCursor + ".razas") != "U"
                THIS.this_cDEmpresa = ALLTRIM(TratarNulo(razas,         "C"))
                THIS.this_cDCargo   = ALLTRIM(TratarNulo(dcargs,        "C"))
                THIS.this_cDTabDes  = ALLTRIM(TratarNulo(descrs_tabdes, "C"))
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cId
        LOCAL loc_nResultDup, loc_cSQLDup, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            *-- Verificar duplicidade (Emps+Cargos+FPags+TabDes+DtInis+DtFins)
            loc_cSQLDup = "SELECT cidchaves FROM SigCdCmi" + ;
                          " WHERE emps = "   + EscaparSQL(THIS.this_cEmps)   + ;
                          " AND cargos = "   + EscaparSQL(THIS.this_cCargos) + ;
                          " AND fpags = "    + EscaparSQL(THIS.this_cFPags)  + ;
                          " AND tabdes = "   + EscaparSQL(THIS.this_cTabDes) + ;
                          " AND dtinis = "   + FormatarDataSQL(THIS.this_dDtInis) + ;
                          " AND dtfins = "   + FormatarDataSQL(THIS.this_dDtFins)

            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            loc_nResultDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupVerif")
            IF loc_nResultDup > 0 AND RECCOUNT("cursor_4c_DupVerif") > 0
                loc_lDuplicado = .T.
                MsgAviso("Dados j" + CHR(225) + " cadastrados para esta combina" + CHR(231) + CHR(227) + "o!", "")
            ENDIF
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF

            IF !loc_lDuplicado
                *-- Gerar chave unica
                loc_cId = fUniqueIds()
                THIS.this_cIdChaves = loc_cId

                loc_cSQL = "INSERT INTO SigCdCmi (cidchaves, emps, tabdes, cargos, fpags," + ;
                           " dtinis, dtfins, comiss, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cId) + ", " + ;
                           EscaparSQL(THIS.this_cEmps)   + ", " + ;
                           EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                           EscaparSQL(THIS.this_cCargos)  + ", " + ;
                           EscaparSQL(THIS.this_cFPags)   + ", " + ;
                           FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                           "GETDATE())"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Ins")
                    TABLEREVERT(.T., "cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                IF loc_nResult > 0
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    MsgErro("Erro ao inserir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCmi SET" + ;
                       " emps = "   + EscaparSQL(THIS.this_cEmps)   + ", " + ;
                       " tabdes = " + EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                       " cargos = " + EscaparSQL(THIS.this_cCargos)  + ", " + ;
                       " fpags = "  + EscaparSQL(THIS.this_cFPags)   + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                       " dtfins = " + FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                       " comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       " dtalts = GETDATE()" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult > 0
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                MsgErro("Erro ao atualizar " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult > 0
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                MsgErro("Erro ao excluir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
