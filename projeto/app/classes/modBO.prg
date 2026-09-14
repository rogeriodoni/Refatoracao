*=============================================================================
* modBO.prg - Business Object de Modalidades
* Tabela: SigCdMod
* Schema: pkchave C(20) PK, Codigos C(2), Descs C(30)
*=============================================================================
DEFINE CLASS modBO AS BusinessBase

    *-- Chave primaria
    this_cPkChave = ""

    *-- Campos da tabela SigCdMod
    this_cCodigos = ""
    this_cDescs   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMod"
        THIS.this_cCampoChave = "pkchave"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de modalidades no cursor_4c_Dados
    * par_cFiltro: "" = todos, ou texto para filtrar por Descs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) # "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT pkchave, Codigos, Descs FROM SigCdMod"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                    " WHERE Descs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Descs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar modalidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega modalidade pela chave primaria (pkchave)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cPkChave) # "C" OR EMPTY(ALLTRIM(par_cPkChave))
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "SELECT pkchave, Codigos, Descs FROM SigCdMod" + ;
                           " WHERE pkchave = " + EscaparSQL(ALLTRIM(par_cPkChave))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                IF loc_nResult >= 0
                    IF RECCOUNT("cursor_4c_Carrega") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                        THIS.this_lNovoRegistro = .F.
                    ENDIF
                ELSE
                    MostrarErro("Erro ao carregar modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChave = TratarNulo(pkchave, "C")
            THIS.this_cCodigos = TratarNulo(Codigos, "C")
            THIS.this_cDescs   = TratarNulo(Descs,   "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoCodigo - Gera proximo codigo sequencial C(2)
    * Equivalente ao fGerUniqueKey('SIGCDMOD') do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo, loc_cCodigo
        loc_nProximo = 1
        loc_cCodigo  = ""

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS INT)), 0) AS MaxCod" + ;
                       " FROM SigCdMod"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
                SELECT cursor_4c_MaxCod
                loc_nProximo = NVL(cursor_4c_MaxCod.MaxCod, 0) + 1
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "modBO.GerarProximoCodigo")
        ENDTRY

        IF USED("cursor_4c_MaxCod")
            USE IN cursor_4c_MaxCod
        ENDIF

        RETURN ALLTRIM(STR(loc_nProximo, 2))
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDescs))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_lNovoRegistro
                    loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMod" + ;
                               " WHERE Descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaMod")
                    IF loc_nResult >= 0
                        SELECT cursor_4c_ValidaMod
                        IF cursor_4c_ValidaMod.Total > 0
                            MsgAviso("Descri" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada!", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_lSucesso = .T.
                        ENDIF
                    ELSE
                        MostrarErro("Erro ao validar modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                    IF USED("cursor_4c_ValidaMod")
                        USE IN cursor_4c_ValidaMod
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.ValidarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMod
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                    THIS.this_cPkChave = ALLTRIM(SYS(2015))
                ENDIF

                IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                    THIS.this_cCodigos = THIS.GerarProximoCodigo()
                ENDIF

                loc_cSQL = "INSERT INTO SigCdMod (pkchave, Codigos, Descs)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cPkChave) + ", " + ;
                           EscaparSQL(THIS.this_cCodigos) + ", " + ;
                           EscaparSQL(THIS.this_cDescs)   + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao inserir modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMod (apenas Descs pode ser alterada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMod" + ;
                           " SET Descs = " + EscaparSQL(THIS.this_cDescs) + ;
                           " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMod
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "DELETE FROM SigCdMod" + ;
                           " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir modalidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro:" + CHR(13) + loException.Message, "modBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
