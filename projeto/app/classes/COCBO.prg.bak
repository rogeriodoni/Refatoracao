*==============================================================================
* COCBO.prg - Business Object para Ocorrencias de Titulos (COC)
* Tabela: SigOpOco | PK: Codigos
* Schema: Codigos char(10), Descrs char(30), Grupos char, Contas char,
*         DContas char, Opers char(2), Contabs numeric, Notas numeric
*==============================================================================

DEFINE CLASS COCBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigOpOco)
    this_cCodigos  = ""    && Codigos  CHAR(10) - Codigo da Ocorrencia (PK)
    this_cDescrs   = ""    && Descrs   CHAR(30) - Descricao
    this_cGrupos   = ""    && Grupos   CHAR     - Codigo do Grupo (FK->SigCdGcr.Codigos)
    this_cContas   = ""    && Contas   CHAR     - Conta (FK->SigCdCli)
    this_cDContas  = ""    && DContas  CHAR     - Descricao da Conta (D-conta)
    this_cOpers    = ""    && Opers    CHAR(2)  - Tipo de Operacao ("DB"=Debito, "CR"=Credito)
    this_nContabs  = 0     && Contabs  NUMERIC  - Lanca Contabilidade (1=Sim, 2=Nao)
    this_nNotas    = 0     && Notas    NUMERIC  - Opcao SNA (1=Sim, 2=Nao, 3=Ambos)

    *-- Parametros de SigCdPac para captions do OpcaoSNA
    this_cTitOpcS  = "Sim"
    this_cTitOpcN  = "N" + CHR(227) + "o"
    this_cTitOpcA  = "Ambos"

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpOco"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de SigCdPac (captions OpcaoSNA)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"

            IF USED("cursor_4c_Params")
                TABLEREVERT(.T., "cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cTitOpcS = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcS, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcS, "C")), "Sim")
                THIS.this_cTitOpcN = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcN, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcN, "C")), "N" + CHR(227) + "o")
                THIS.this_cTitOpcA = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcA, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcA, "C")), "Ambos")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.CarregarParametros")
        ENDTRY

        IF USED("cursor_4c_Params")
            USE IN cursor_4c_Params
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros com filtro opcional
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

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
            MostrarErro(loException, "COCBO.Buscar")
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
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

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
            MostrarErro(loException, "COCBO.CarregarPorCodigo")
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
            THIS.this_cCodigos = TratarNulo(Codigos, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            THIS.this_cGrupos  = TratarNulo(Grupos,  "C")
            THIS.this_cContas  = TratarNulo(Contas,  "C")
            THIS.this_cDContas = TratarNulo(DContas, "C")
            THIS.this_cOpers   = TratarNulo(Opers,   "C")
            THIS.this_nContabs = TratarNulo(Contabs, "N")
            THIS.this_nNotas   = TratarNulo(Notas,   "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupo - Valida/busca grupo em SigCdGcr pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                loc_lSucesso = RECCOUNT("cursor_4c_BuscaGrupo") > 0
            ELSE
                MostrarErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.BuscarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_ChkExiste")
                TABLEREVERT(.T., "cursor_4c_ChkExiste")
                USE IN cursor_4c_ChkExiste
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkExiste") > 0
                SELECT cursor_4c_ChkExiste
                loc_lExiste = (cursor_4c_ChkExiste.nExiste > 0)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.VerificarCodigoExiste")
        ENDTRY

        IF USED("cursor_4c_ChkExiste")
            USE IN cursor_4c_ChkExiste
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpOco" + ;
                       " (Codigos, Descrs, Grupos, Contas, DContas, Opers, Contabs, Notas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOco SET" + ;
                       " Descrs  = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       " Grupos  = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       " Contas  = " + EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       " DContas = " + EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       " Opers   = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       " Contabs = " + FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       " Notas   = " + FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
