*==============================================================================
* OrgBO.prg - Business Object para Origens de Mercadoria
* Tabela: SigCdOrg
* Migrado de: SigCdOrg.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS OrgBO AS BusinessBase

    *-- Propriedades de dados
    this_cCodigo    = ""    && codigos  char(1)  - chave primaria
    this_cDescricao = ""    && descricaos char(40)

    *--------------------------------------------------------------------------
    * Init - Inicializa BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOrg"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos,    "C")
            THIS.this_cDescricao = TratarNulo(descricaos, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros ou filtrados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos" + ;
                       " FROM SigCdOrg a"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Origens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos" + ;
                       " FROM SigCdOrg a" + ;
                       " WHERE a.codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdOrg (codigos, descricaos)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cCodigo) + ;
                       ", " + EscaparSQL(THIS.this_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOrg SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro (chamado pelo BusinessBase.Excluir)
    * Valida: nao pode excluir se usado em SigCdPro ou SigCdPrc (origmercs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cSQL2, loc_nResult2, loc_lPodeExcluir
        loc_lResultado   = .F.
        loc_lPodeExcluir = .T.

        TRY
            *-- Verificar uso em SigCdPro
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPro" + ;
                       " WHERE origmercs = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkPro") > 0
                SELECT cursor_4c_ChkPro
                IF cursor_4c_ChkPro.qtd > 0
                    MsgErro("Origem n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da pois est" + CHR(225) + " sendo usada em Produtos!", "")
                    loc_lPodeExcluir = .F.
                ENDIF
            ENDIF
            IF USED("cursor_4c_ChkPro")
                USE IN cursor_4c_ChkPro
            ENDIF

            *-- Verificar uso em SigCdPrc (somente se ainda pode excluir)
            IF loc_lPodeExcluir
                loc_cSQL2 = "SELECT COUNT(*) AS qtd FROM SigCdPrc" + ;
                            " WHERE origmercs = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_ChkPrc")
                IF loc_nResult2 >= 0 AND RECCOUNT("cursor_4c_ChkPrc") > 0
                    SELECT cursor_4c_ChkPrc
                    IF cursor_4c_ChkPrc.qtd > 0
                        MsgErro("Origem n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da pois est" + CHR(225) + " sendo usada em Produtos!", "")
                        loc_lPodeExcluir = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChkPrc")
                    USE IN cursor_4c_ChkPrc
                ENDIF
            ENDIF

            *-- Executar exclusao somente se passou nas validacoes
            IF loc_lPodeExcluir
                loc_cSQL = "DELETE FROM SigCdOrg WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir Origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe (para INSERIR)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOrg" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrg")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkOrg") > 0
                SELECT cursor_4c_ChkOrg
                loc_lExiste = (cursor_4c_ChkOrg.qtd > 0)
            ENDIF
            IF USED("cursor_4c_ChkOrg")
                USE IN cursor_4c_ChkOrg
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE
