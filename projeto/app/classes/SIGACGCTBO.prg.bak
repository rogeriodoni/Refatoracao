*==============================================================================
* SIGACGCTBO.prg - Business Object: Acesso Lancamentos
* Tabela: SigSyAgc
* PK: cIdChaves (gerada por fUniqueIds)
*==============================================================================

DEFINE CLASS SIGACGCTBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (nao persistidas - configuradas no Init)
    *--------------------------------------------------------------------------
    this_cTabela     = "SigSyAgc"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Campos da tabela SigSyAgc
    *--------------------------------------------------------------------------
    this_cIdChaves = ""    && PK (gerada por fUniqueIds)
    this_cGrAcess  = ""    && Grupo Acesso (FK -> SigCdAcG.Grupos)
    this_cUsuAcess = ""    && Usuario Acesso (FK -> SigCdUsu.Usuarios)
    this_cGrContbs = ""    && Grupo Contabil (FK -> SigCdGcr.Codigos)
    this_cGrContas = ""    && Grupo Conta Corrente (FK -> SigCdGcr.Codigos)
    this_cCdContas = ""    && Codigo Conta Corrente (FK -> SigCdCli.Iclis)

    *--------------------------------------------------------------------------
    * Campos de exibicao (nao persistidos na tabela - preenchidos via lookup)
    *--------------------------------------------------------------------------
    this_cDGrContb   = ""  && Descricao Grupo Contabil (SigCdGcr.Descrs)
    this_cDGrConta   = ""  && Descricao Grupo Conta Corrente (SigCdGcr.Descrs)
    this_cDConta     = ""  && Descricao Conta Corrente (SigCdCli.RClis)

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyAgc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Para auditoria (override do BusinessBase)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros da tabela para o grid
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " ORDER BY gracess, usuacess"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                           " grcontas, cdcontas" + ;
                           " FROM SigSyAgc" + ;
                           " WHERE gracess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " OR usuacess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY gracess, usuacess"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (cIdChaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
            THIS.this_cGrAcess  = TratarNulo(gracess,   "C")
            THIS.this_cUsuAcess = TratarNulo(usuacess,  "C")
            THIS.this_cGrContbs = TratarNulo(grcontbs,  "C")
            THIS.this_cGrContas = TratarNulo(grcontas,  "C")
            THIS.this_cCdContas = TratarNulo(cdcontas,  "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDescricoes - Busca descricoes dos campos de lookup
    *==========================================================================
    PROCEDURE CarregarDescricoes()
        LOCAL loc_lResultado, loc_nRes
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_Desc")
                USE IN cursor_4c_Desc
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContbs))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContbs)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrContb = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrContb = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrContb = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContas)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrConta = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrConta = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas)) AND !EMPTY(ALLTRIM(THIS.this_cCdContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT RClis FROM SigCdCli" + ;
                    " WHERE Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                    " AND IClis = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)), ;
                    "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDConta = TratarNulo(RClis, "C")
                ELSE
                    THIS.this_cDConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDConta = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDescricoes: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cPK
        loc_lResultado = .F.

        TRY
            loc_cPK = fUniqueIds()
            THIS.this_cIdChaves = loc_cPK

            loc_cSQL = "INSERT INTO SigSyAgc" + ;
                       " (cIdChaves, gracess, usuacess, grcontbs, grcontas, cdcontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigSyAgc SET" + ;
                       " gracess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + "," + ;
                       " usuacess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + "," + ;
                       " grcontbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + "," + ;
                       " grcontas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + "," + ;
                       " cdcontas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE na tabela SigSyAgc (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com a mesma chave composta
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT cIdChaves FROM SigSyAgc" + ;
                       " WHERE GrAcess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ;
                       " AND   UsuAcess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ;
                       " AND   GrContbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ;
                       " AND   GrContas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                       " AND   CdContas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas))

            IF !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                    " AND cIdChaves <> " + EscaparSQL(THIS.this_cIdChaves)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0
                loc_lDuplicado = (RECCOUNT("cursor_4c_Dup") > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_lResultado = loc_lDuplicado
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
