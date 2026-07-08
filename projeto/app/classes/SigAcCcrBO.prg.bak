*==============================================================================
* SigAcCcrBO.prg - Business Object para Acesso a Conta Corrente
* Tabela: SigSyAcc
* PK: cIdChaves (Character, gerada por fUniqueIds)
*==============================================================================

DEFINE CLASS SigAcCcrBO AS BusinessBase

    *-- Campos da tabela SigSyAcc
    this_cIdChave  = ""    && cIdChaves - Chave primaria (gerada por fUniqueIds)
    this_cGrAcess  = ""    && gracess   - Grupo de acesso
    this_cUsuAcess = ""    && usuacess  - Usuario de acesso
    this_cGrContas = ""    && grcontas  - Grupo da conta corrente
    this_cCdContas = ""    && cdcontas  - Codigo da conta corrente

    *-- Campos virtuais (lookup display, nao persistidos no banco)
    this_cDGrConta = ""    && Descricao do grupo de conta (SigCdGcr.Descrs)
    this_cDConta   = ""    && Nome da conta corrente (SigCdCli.RClis)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyAcc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para propriedades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChave  = TratarNulo(cIdChaves, "C")
            THIS.this_cGrAcess  = TratarNulo(gracess,   "C")
            THIS.this_cUsuAcess = TratarNulo(usuacess,  "C")
            THIS.this_cGrContas = TratarNulo(grcontas,  "C")
            THIS.this_cCdContas = TratarNulo(cdcontas,  "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontas, cdcontas" + ;
                       " FROM SigSyAcc" + ;
                       IIF(!EMPTY(par_cFiltro), " WHERE " + par_cFiltro, "") + ;
                       " ORDER BY gracess, usuacess, grcontas, cdcontas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar acessos:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar acessos:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontas, cdcontas" + ;
                       " FROM SigSyAcc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado < 0
                MostrarErro("Erro ao carregar acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes de negocio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cGrAcess) AND EMPTY(THIS.this_cUsuAcess)
            MsgAviso("Usu" + CHR(225) + "rio/Grupo Inv" + CHR(225) + "lido !!!")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cGrContas) AND EMPTY(THIS.this_cCdContas)
            MsgAviso("Grupo/Conta Corrente Inv" + CHR(225) + "lidos !!")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicata - Verifica se ja existe registro identico (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 cIdChaves FROM SigSyAcc" + ;
                       " WHERE gracess  = " + EscaparSQL(THIS.this_cGrAcess)  + ;
                       " AND   usuacess = " + EscaparSQL(THIS.this_cUsuAcess) + ;
                       " AND   grcontas = " + EscaparSQL(THIS.this_cGrContas) + ;
                       " AND   cdcontas = " + EscaparSQL(THIS.this_cCdContas)

            IF !EMPTY(THIS.this_cIdChave)
                loc_cSQL = loc_cSQL + " AND cIdChaves <> " + EscaparSQL(THIS.this_cIdChave)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Duplic") > 0
                loc_lDuplicado = .T.
            ENDIF

            IF USED("cursor_4c_Duplic")
                USE IN cursor_4c_Duplic
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar duplicata:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigSyAcc
    * cIdChaves gerado com SYS(2015) - equivalente ao fUniqueIds() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChave = SYS(2015)

            loc_cSQL = "INSERT INTO SigSyAcc (cIdChaves, gracess, usuacess, grcontas, cdcontas)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cIdChave)  + ;
                       ", "        + EscaparSQL(THIS.this_cGrAcess)  + ;
                       ", "        + EscaparSQL(THIS.this_cUsuAcess) + ;
                       ", "        + EscaparSQL(THIS.this_cGrContas) + ;
                       ", "        + EscaparSQL(THIS.this_cCdContas) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigSyAcc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigSyAcc" + ;
                       " SET gracess  = " + EscaparSQL(THIS.this_cGrAcess)  + ;
                       ",    usuacess = " + EscaparSQL(THIS.this_cUsuAcess) + ;
                       ",    grcontas = " + EscaparSQL(THIS.this_cGrContas) + ;
                       ",    cdcontas = " + EscaparSQL(THIS.this_cCdContas) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigSyAcc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigSyAcc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricoesConta - Carrega descricoes de display (GrConta e Conta)
    * Preenche this_cDGrConta (SigCdGcr.Descrs) e this_cDConta (SigCdCli.RClis)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricoesConta()
        LOCAL loc_cSQL, loc_nResultado
        THIS.this_cDGrConta = ""
        THIS.this_cDConta   = ""

        TRY
            IF !EMPTY(THIS.this_cGrContas)
                loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cGrContas)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrDesc")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_GrDesc") > 0
                    SELECT cursor_4c_GrDesc
                    THIS.this_cDGrConta = TratarNulo(Descrs, "C")
                ENDIF
                IF USED("cursor_4c_GrDesc")
                    USE IN cursor_4c_GrDesc
                ENDIF
            ENDIF

            IF !EMPTY(THIS.this_cGrContas) AND !EMPTY(THIS.this_cCdContas)
                loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli" + ;
                           " WHERE Grupos = " + EscaparSQL(THIS.this_cGrContas) + ;
                           " AND   IClis  = " + EscaparSQL(THIS.this_cCdContas)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaDesc")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CtaDesc") > 0
                    SELECT cursor_4c_CtaDesc
                    THIS.this_cDConta = TratarNulo(RClis, "C")
                ENDIF
                IF USED("cursor_4c_CtaDesc")
                    USE IN cursor_4c_CtaDesc
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es de conta:" + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
