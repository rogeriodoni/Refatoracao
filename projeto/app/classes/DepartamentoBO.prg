*==============================================================================
* DepartamentoBO.prg - Business Object para Departamentos
* Tabela: SigCdDpt | PK: codigos
* Migrado de: SIGCDDPT (frmcadastro)
*==============================================================================

DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Propriedades da entidade Departamento
    this_cCodigo    = ""  && codigos    C(10) - Chave primaria
    this_cDescricao = ""  && descricaos C(40)
    this_cDiretor   = ""  && diretors   C(10)
    this_nChkSubs   = 0   && nchksubs   N(1,0) - Obriga Subclas. Encerramento
    this_nChkTipos  = 0   && nchktipos  N(1,0) - Tipo
    this_nAutos     = 0   && autos      N(1,0) - Automatico

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave herdados do BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, diretors, nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em DepartamentoBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors, nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em DepartamentoBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                THIS.this_cDiretor   = TratarNulo(diretors,   "C")
                THIS.this_nChkSubs   = TratarNulo(nchksubs,   "N")
                THIS.this_nChkTipos  = TratarNulo(nchktipos,  "N")
                THIS.this_nAutos     = TratarNulo(autos,      "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em DepartamentoBO.CarregarDoCursor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDpt (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdDpt (codigos, descricaos, diretors, nchksubs, nchktipos, autos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigo))    + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDiretor))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkSubs)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkTipos)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutos)       + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Insert")
                TABLEREVERT(.T., "cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em DepartamentoBO.Inserir:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDpt (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdDpt SET" + ;
                       " descricaos = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                       " diretors   = " + EscaparSQL(ALLTRIM(THIS.this_cDiretor))   + "," + ;
                       " nchksubs   = " + FormatarNumeroSQL(THIS.this_nChkSubs)     + "," + ;
                       " nchktipos  = " + FormatarNumeroSQL(THIS.this_nChkTipos)    + "," + ;
                       " autos      = " + FormatarNumeroSQL(THIS.this_nAutos)       + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em DepartamentoBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da tabela SigCdDpt (PROTECTED)
    * Chamado internamente por BusinessBase.Excluir() (PUBLIC)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar dependencias antes de excluir
            LOCAL loc_cSQLCheck, loc_nCheck
            loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdUsu" + ;
                            " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Check")
                TABLEREVERT(.T., "cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF

            loc_nCheck = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_Check")

            IF loc_nCheck >= 0 AND RECCOUNT("cursor_4c_Check") > 0
                SELECT cursor_4c_Check
                IF cursor_4c_Check.nExiste > 0
                    MostrarErro("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir." + CHR(13) + ;
                               "Existem usu" + CHR(225) + "rios vinculados a este departamento.", "Exclus" + CHR(227) + "o Bloqueada")
                    IF USED("cursor_4c_Check")
                        USE IN cursor_4c_Check
                    ENDIF
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF

            loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em DepartamentoBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDiretor - Verifica se codigo de diretor existe em SigCdUsu
    * Retorna .T. se encontrou, preenchendo cursor_4c_BuscaDiretor
    *--------------------------------------------------------------------------
    FUNCTION BuscarDiretor(par_cCodigo, par_cFiltroExtra)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltroExtra) != "C"
                par_cFiltroExtra = ""
            ENDIF

            loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu WHERE cAtivos <> 'N'"

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = loc_cSQL + " AND Usuarios = " + EscaparSQL(ALLTRIM(par_cCodigo))
            ENDIF

            IF !EMPTY(ALLTRIM(par_cFiltroExtra))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltroExtra
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Usuarios"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaDiretor")
                TABLEREVERT(.T., "cursor_4c_BuscaDiretor")
                USE IN cursor_4c_BuscaDiretor
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDiretor")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar diretor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em DepartamentoBO.BuscarDiretor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
