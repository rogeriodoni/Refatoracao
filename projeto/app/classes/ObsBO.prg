*====================================================================
* ObsBO.prg
*
* Business Object para Cadastro de Observacoes
* Tabela: SigCdObs
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ObsBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdObs)
    this_nCodigos    = 0     && Codigos numeric(3,0) - PK
    this_cDescrs     = ""    && descrs  char
    this_cObservas   = ""    && Observas memo
    this_cGrupos     = ""    && grupos  char
    this_cAgrupas    = ""    && agrupas char
    this_nComiss     = 0     && Comiss  numeric (1=Sim, 2=Nao)
    this_nClassifs   = 0     && Classifs numeric (1=Grave, 2=Leve, 3=Interno)
    this_cMovAutDop  = ""    && MovAutDop char (lookup SigCdOpe.Dopes)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdObs"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria (PUBLIC)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * Buscar - Carrega lista de registros no cursor_4c_Dados (PUBLIC)
    * par_cFiltro: condicao WHERE sem "WHERE" (pode ser "")
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs," + ;
                       " CASE WHEN Comiss = 2 THEN 'NAO' ELSE 'SIM' END AS PgComissao," + ;
                       " Grupos, Agrupas" + ;
                       " FROM SigCdObs" + ;
                       loc_cWhere + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       " Grupos, Agrupas, MovAutDop" + ;
                       " FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos   = TratarNulo(codigos,   "N")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cObservas  = TratarNulo(observas,  "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,   "C")
                THIS.this_nComiss    = TratarNulo(comiss,    "N")
                THIS.this_nClassifs  = TratarNulo(classifs,  "N")
                THIS.this_cMovAutDop = TratarNulo(movautdop, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.T.
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdObs" + ;
                       " (Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       "  Grupos, Agrupas, MovAutDop)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cObservas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClassifs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cAgrupas) + ", " + ;
                       EscaparSQL(THIS.this_cMovAutDop) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.F.
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdObs SET" + ;
                       " Descrs    = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " Observas  = " + EscaparSQL(THIS.this_cObservas) + "," + ;
                       " Comiss    = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Classifs  = " + FormatarNumeroSQL(THIS.this_nClassifs) + "," + ;
                       " Grupos    = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Agrupas   = " + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " MovAutDop = " + EscaparSQL(THIS.this_cMovAutDop) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Remove registro da tabela (PROTECTED)
    * Chamado internamente por BusinessBase.Excluir()
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarOperacoesNivel - Carrega cursor para lookup de MovAutDop (PUBLIC)
    * Equivalente ao: Select Dopes,Cmoes,nFiscals,Abrevs From SigCdOpe
    * Usado pelo Form para popular o lookup de Movimentacao Automatica
    *====================================================================
    FUNCTION BuscarOperacoesNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Nivel")
                USE IN cursor_4c_Nivel
            ENDIF

            loc_cSQL = "SELECT Dopes, Cmoes, NFiscals, Abrevs" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE LTRIM(RTRIM(Abrevs)) <> ''" + ;
                       " ORDER BY Dopes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.BuscarOperacoesNivel")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
