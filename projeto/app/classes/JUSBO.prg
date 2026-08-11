*==============================================================================
* JUSBO.prg - Business Object para Justificativas do Retrabalho (SigPrJst)
*==============================================================================

DEFINE CLASS JUSBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves = ""   && cidchaves char(20) - PK gerada por fUniqueIds()

    *-- Campos da tabela SigPrJst
    this_cCods      = ""   && cods char(3) - codigo da justificativa
    this_cRetrabs   = ""   && cretrabs char(6) - tipo de retrabalho (FK)
    this_cDescrs    = ""   && descrs char(30) - descricao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrJst"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA: Sempre SELECT (alias) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCods      = TratarNulo(cods, "C")
            THIS.this_cRetrabs   = TratarNulo(cRetrabs, "C")
            THIS.this_cDescrs    = TratarNulo(descrs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista justificativas com filtro WHERE opcional
    * par_cFiltro: condicao sem a palavra WHERE (ex: "cRetrabs = 'X'")
    * Resultado em cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(3), cRetrabs C(6), descrs C(30))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, cods, cRetrabs, descrs" + ;
                       " FROM SigPrJst"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar justificativas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega justificativa pelo codigo (cods) - igual ao legado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCods)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, cods, cRetrabs, descrs" + ;
                       " FROM SigPrJst" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCods))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios e unicidade antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            *-- Codigo obrigatorio
            IF EMPTY(ALLTRIM(THIS.this_cCods))
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            *-- Validar duplicidade no INSERT: cods+cretrabs devem ser unicos
            IF loc_lResultado AND THIS.this_lNovoRegistro
                loc_cSQL = "SELECT cidchaves FROM SigPrJst" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCods) + ;
                           " AND cRetrabs = " + EscaparSQL(THIS.this_cRetrabs)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    SELECT cursor_4c_Dup
                    MsgAviso("Justificativa j" + CHR(225) + " cadastrada para o Retrabalho " + ;
                             ALLTRIM(THIS.this_cRetrabs), "")
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrJst
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigPrJst" + ;
                       " (cidchaves, cods, cRetrabs, descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCods) + ", " + ;
                       EscaparSQL(THIS.this_cRetrabs) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrJst (cods nao atualiza em modo ALTERAR pois
    * o original so habilita get_Descr no ALTERAR, mantendo cods readonly)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrJst SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCods) + ;
                       " AND cRetrabs = " + EscaparSQL(THIS.this_cRetrabs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigPrJst
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrJst" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCods) + ;
                       " AND cRetrabs = " + EscaparSQL(THIS.this_cRetrabs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Del")
            USE IN cursor_4c_Del
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
