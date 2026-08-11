*==============================================================================
* InfBO.prg - Business Object: Cadastro de Informações Complementares
* Tabela principal : SigPrInf (infos C(1), descrs C(15))
* Tabela secundária: SigEmInf (Infos FK, Emps, PercEmps, pkChave)
*==============================================================================
DEFINE CLASS InfBO AS BusinessBase

    *-- Propriedades da entidade (SigPrInf)
    this_cInfos  = ""    && C(1)  - Codigo da informacao (PK)
    this_cDescrs = ""    && C(15) - Descricao da informacao

*------------------------------------------------------------------------------
* Init - Configura propriedades base do BO
*------------------------------------------------------------------------------
PROCEDURE Init()
    DODEFAULT()
    THIS.this_cTabela     = "SigPrInf"
    THIS.this_cCampoChave = "Infos"
    RETURN .T.
ENDPROC

*------------------------------------------------------------------------------
* ObterChavePrimaria - Retorna valor da chave primária para auditoria
*------------------------------------------------------------------------------
PROCEDURE ObterChavePrimaria()
    RETURN THIS.this_cInfos
ENDPROC

*------------------------------------------------------------------------------
* Buscar - Carrega lista de informações em cursor_4c_Dados
*------------------------------------------------------------------------------
PROCEDURE Buscar(par_cFiltro)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
        RETURN .T.
    ENDIF

    TRY
        loc_cSQL = "SELECT Infos, Descrs FROM SigPrInf"
        IF !EMPTY(ALLTRIM(par_cFiltro))
            loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
        ENDIF
        loc_cSQL = loc_cSQL + " ORDER BY Infos"

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
        IF loc_nResultado >= 0
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao buscar informa" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* CarregarPorCodigo - Carrega registro pelo código de informação
*------------------------------------------------------------------------------
PROCEDURE CarregarPorCodigo(par_cInfos)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "SELECT Infos, Descrs FROM SigPrInf WHERE Infos = " + EscaparSQL(par_cInfos)

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
        IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
            loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            THIS.this_lNovoRegistro = .F.
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
    ENDIF

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
*------------------------------------------------------------------------------
PROCEDURE CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso
    loc_lSucesso = .F.

    IF USED(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cInfos  = TratarNulo(Infos,  "C")
        THIS.this_cDescrs = TratarNulo(Descrs, "C")
        loc_lSucesso = .T.
    ENDIF

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* VerificarCodigoDuplicado - Verifica se código já existe em SigPrInf
*------------------------------------------------------------------------------
PROCEDURE VerificarCodigoDuplicado(par_cInfos)
    LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
    loc_lDuplicado = .F.

    TRY
        loc_cSQL = "SELECT COUNT(*) AS Total FROM SigPrInf WHERE Infos = " + EscaparSQL(par_cInfos)
        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
        IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
            SELECT cursor_4c_ChkDup
            loc_lDuplicado = (Total > 0)
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    IF USED("cursor_4c_ChkDup")
        USE IN cursor_4c_ChkDup
    ENDIF

    RETURN loc_lDuplicado
ENDPROC

*------------------------------------------------------------------------------
* Inserir - INSERT INTO SigPrInf
*------------------------------------------------------------------------------
PROTECTED PROCEDURE Inserir()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "INSERT INTO SigPrInf (Infos, Descrs)" + ;
                   " VALUES (" + EscaparSQL(THIS.this_cInfos) + ;
                   ", " + EscaparSQL(THIS.this_cDescrs) + ")"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("INSERT")
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao inserir informa" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* Atualizar - UPDATE SigPrInf
*------------------------------------------------------------------------------
PROTECTED PROCEDURE Atualizar()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "UPDATE SigPrInf SET Descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                   " WHERE Infos = " + EscaparSQL(THIS.this_cInfos)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao atualizar informa" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* ExecutarExclusao - DELETE FROM SigEmInf + SigPrInf (transação atômica)
* Empresas vinculadas excluídas primeiro (integridade referencial)
*------------------------------------------------------------------------------
PROTECTED PROCEDURE ExecutarExclusao()
    LOCAL loc_cSQLEmInf, loc_cSQLPrInf, loc_nRes1, loc_nRes2, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQLEmInf = "DELETE FROM SigEmInf WHERE Infos = " + EscaparSQL(THIS.this_cInfos)
        loc_cSQLPrInf = "DELETE FROM SigPrInf WHERE Infos = " + EscaparSQL(THIS.this_cInfos)

        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
        loc_nRes1 = SQLEXEC(gnConnHandle, loc_cSQLEmInf)
        loc_nRes2 = SQLEXEC(gnConnHandle, loc_cSQLPrInf)

        IF loc_nRes1 >= 0 AND loc_nRes2 >= 0
            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.
        ELSE
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MostrarErro("Erro ao excluir informa" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* CarregarEmpresas - Carrega empresas vinculadas à informação em cursor local
* par_cInfos : código da informação
* par_cCursor: nome do cursor destino (ex: "cursor_4c_Emps")
*------------------------------------------------------------------------------
PROCEDURE CarregarEmpresas(par_cInfos, par_cCursor)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_cSQL = "SELECT Emps, PercEmps FROM SigEmInf" + ;
                   " WHERE Infos = " + EscaparSQL(par_cInfos) + ;
                   " ORDER BY Emps"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (par_cCursor))
        IF loc_nResultado >= 0
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

*------------------------------------------------------------------------------
* SalvarEmpresas - Sincroniza empresas do cursor local para SigEmInf
* Deleta todas as empresas do Infos e re-insere as não-vazias do cursor
* par_cInfos : código da informação
* par_cCursor: nome do cursor local com os dados (Emps, PercEmps)
*------------------------------------------------------------------------------
PROCEDURE SalvarEmpresas(par_cInfos, par_cCursor)
    LOCAL loc_cSQLDel, loc_cSQLIns, loc_nRes, loc_lSucesso, loc_lErroInsert
    LOCAL loc_cEmps, loc_nPercEmps
    loc_lSucesso = .F.

    IF !USED(par_cCursor)
        RETURN .F.
    ENDIF

    TRY
        loc_cSQLDel = "DELETE FROM SigEmInf WHERE Infos = " + EscaparSQL(par_cInfos)

        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQLDel)

        IF loc_nRes < 0
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MostrarErro("Erro ao limpar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ELSE
            loc_lErroInsert = .F.
            SELECT (par_cCursor)
            GO TOP
            DO WHILE !EOF() AND !loc_lErroInsert
                loc_cEmps     = ALLTRIM(Emps)
                loc_nPercEmps = PercEmps
                IF !EMPTY(loc_cEmps)
                    loc_cSQLIns = "INSERT INTO SigEmInf (Infos, Emps, PercEmps, pkChave)" + ;
                                  " VALUES (" + EscaparSQL(par_cInfos) + ;
                                  ", " + EscaparSQL(loc_cEmps) + ;
                                  ", " + FormatarNumeroSQL(loc_nPercEmps) + ;
                                  ", CONVERT(VARCHAR(36), NEWID()))"
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQLIns)
                    IF loc_nRes < 0
                        loc_lErroInsert = .T.
                    ENDIF
                ENDIF
                SKIP
            ENDDO

            IF loc_lErroInsert
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                MostrarErro("Erro ao inserir empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                loc_lSucesso = .T.
            ENDIF
        ENDIF
    CATCH TO loc_oErro
        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        MostrarErro("Erro: " + loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
ENDPROC

ENDDEFINE
