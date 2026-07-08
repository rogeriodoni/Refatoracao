*------------------------------------------------------------------------------
* ColBO.prg - Business Object para Cadastro de Grupo de Venda
* Tabela: SigCdCol
* Fase 1/8: Propriedades e Init()
*------------------------------------------------------------------------------

DEFINE CLASS ColBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SigCdCol
    this_cCodcols  = ""    && codcols  char(1)
    this_cColecoes = ""    && colecoes char(10) - PK
    this_cDescs    = ""    && descs    char(40)
    this_nRepoauts = 0     && repoauts numeric(1,0)
    this_nConprods = 0     && conprods numeric(1,0)
    this_nAltprods = 0     && altprods numeric(1,0)
    this_dDtincs   = {}    && dtincs   datetime
    this_cUsuars   = ""    && usuars   char(10)
    this_cAgrupas  = ""    && agrupas  char(10)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCol"
        THIS.this_cCampoChave = "colecoes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cColecoes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros com filtro opcional
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT colecoes, descs, codcols, repoauts, conprods," + ;
                       " altprods, dtincs, usuars, agrupas" + ;
                       " FROM SigCdCol"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY colecoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ColBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT colecoes, descs, codcols, repoauts, conprods," + ;
                       " altprods, dtincs, usuars, agrupas" + ;
                       " FROM SigCdCol" + ;
                       " WHERE colecoes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ColBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cColecoes = TratarNulo(colecoes, "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_cCodcols  = TratarNulo(codcols,  "C")
            THIS.this_nRepoauts = TratarNulo(repoauts, "N")
            THIS.this_nConprods = TratarNulo(conprods, "N")
            THIS.this_nAltprods = TratarNulo(altprods, "N")
            THIS.this_dDtincs   = TratarNulo(dtincs,   "T")
            THIS.this_cUsuars   = TratarNulo(usuars,   "C")
            THIS.this_cAgrupas  = TratarNulo(agrupas,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdCol (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdCol" + ;
                       " (colecoes, descs, codcols, repoauts, conprods," + ;
                       "  altprods, dtincs, usuars, agrupas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs))    + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodcols))  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nRepoauts)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nConprods)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAltprods)   + ", " + ;
                       IIF(EMPTY(THIS.this_dDtincs), "NULL", FormatarDataSQL(THIS.this_dDtincs)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars))   + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cAgrupas))  + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ColBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdCol (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCol SET" + ;
                       " descs    = " + EscaparSQL(ALLTRIM(THIS.this_cDescs))    + ", " + ;
                       " codcols  = " + EscaparSQL(ALLTRIM(THIS.this_cCodcols))  + ", " + ;
                       " repoauts = " + FormatarNumeroSQL(THIS.this_nRepoauts)   + ", " + ;
                       " conprods = " + FormatarNumeroSQL(THIS.this_nConprods)   + ", " + ;
                       " altprods = " + FormatarNumeroSQL(THIS.this_nAltprods)   + ", " + ;
                       " dtincs   = " + IIF(EMPTY(THIS.this_dDtincs), "NULL", FormatarDataSQL(THIS.this_dDtincs)) + ", " + ;
                       " usuars   = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars))   + ", " + ;
                       " agrupas  = " + EscaparSQL(ALLTRIM(THIS.this_cAgrupas))  + ;
                       " WHERE colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ColBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdCol (PROTECTED)
    * Verifica integridade referencial com SigCdPro antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nDependentes
        loc_lSucesso = .F.

        TRY
            *-- Verificar se existem produtos usando este grupo de venda
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdPro" + ;
                       " WHERE Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkPro") > 0
                SELECT cursor_4c_ChkPro
                loc_nDependentes = cursor_4c_ChkPro.nExiste
            ELSE
                loc_nDependentes = 0
            ENDIF

            IF USED("cursor_4c_ChkPro")
                USE IN cursor_4c_ChkPro
            ENDIF

            IF loc_nDependentes > 0
                MostrarErro("Existem Produtos Utilizando Esse Grupo de Venda.", "Imposs" + CHR(237) + "vel Exclus" + CHR(227) + "o...")
            ELSE
                loc_cSQL = "DELETE FROM SigCdCol" + ;
                           " WHERE colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ColBO.ExecutarExclusao")
            IF USED("cursor_4c_ChkPro")
                USE IN cursor_4c_ChkPro
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
