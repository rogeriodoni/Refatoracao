*==============================================================================
* SIGPRINTBO.prg - Business Object para Cadastro de Instru????es de Impress??o
* Tabela: SigOpIns
* Gerado em: 2026-07-17
*==============================================================================

DEFINE CLASS SIGPRINTBO AS BusinessBase

    *-- Propriedades da entidade (mapeiam colunas de SigOpIns)
    this_cCodigo    = ""   && cods    char(10) NOT NULL - PK
    this_cDescricao = ""   && descrs  char(76) NOT NULL
    this_cMensagem  = ""   && mensas  text NULL
    this_nTipo      = 0    && tipos   numeric(1,0) NOT NULL - 1=Cheque, 2=Titulos, 3=FollowUp
    this_cCidChaves = ""   && cidchaves char(20) NOT NULL

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpIns"
            THIS.this_cCampoChave = "cods"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros de SigOpIns
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns ORDER BY cods"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                           " FROM SigOpIns" + ;
                           " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY cods"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (cods)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,      "C")
            THIS.this_cDescricao = TratarNulo(descrs,    "C")
            THIS.this_cMensagem  = TratarNulo(mensas,    "C")
            THIS.this_nTipo      = TratarNulo(tipos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpIns
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigOpIns (cods, descrs, mensas, tipos, cidchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpIns (PK = cods)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpIns SET" + ;
                       " descrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       " mensas = " + EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       " tipos = "  + FormatarNumeroSQL(THIS.this_nTipo) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpIns (PK = cods)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe (para validar unicidade)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigo(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCod")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCod") > 0
                SELECT cursor_4c_ValCod
                loc_lExiste = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE
