*==============================================================================
* EmbBO.prg - Business Object para Embalagens
* Tabela: SigCdEmb
* Herda de: BusinessBase
*
* Campos (schema.sql):
*   cods   char(3)        NOT NULL  - PK
*   descs  char(20)       NOT NULL
*   multis numeric(5,1)  NOT NULL
*   precos numeric(11,2) NOT NULL
*   pesos  numeric(11,2) NOT NULL
*==============================================================================

DEFINE CLASS EmbBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento 1:1 com colunas SigCdEmb)
    this_cCodigo    = ""  && cods char(3) - PK
    this_cDescricao = ""  && descs char(20)
    this_nMultis    = 0   && multis numeric(5,1)
    this_nPrecos    = 0   && precos numeric(11,2)
    this_nPesos     = 0   && pesos numeric(11,2)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmb"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de embalagens (PUBLIC)
    * par_cFiltro: filtro opcional aplicado ao WHERE
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, multis, precos, pesos" + ;
                       " FROM SigCdEmb"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar embalagens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega embalagem pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, multis, precos, pesos" + ;
                       " FROM SigCdEmb" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo)

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
            MsgErro("Erro em EmbBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,   "C")
            THIS.this_cDescricao = TratarNulo(descs,  "C")
            THIS.this_nMultis    = TratarNulo(multis, "N")
            THIS.this_nPrecos    = TratarNulo(precos, "N")
            THIS.this_nPesos     = TratarNulo(pesos,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEmb (cods, descs, multis, precos, pesos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMultis) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEmb SET" + ;
                       " descs = "  + EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       " multis = " + FormatarNumeroSQL(THIS.this_nMultis) + ", " + ;
                       " precos = " + FormatarNumeroSQL(THIS.this_nPrecos) + ", " + ;
                       " pesos = "  + FormatarNumeroSQL(THIS.this_nPesos) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEmb WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
