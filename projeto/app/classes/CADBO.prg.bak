*====================================================================
* CADBO.prg
*
* Business Object para Cadastros Gerais (SigCdCad)
* Herda de: BusinessBase
*
* PARAMETRIZADO: this_cTipoCads define a categoria de cadastro.
* Todas as queries filtram por TipoCads.
* Aberto pelo menu com par_cTipoCads e par_nMaxCodCads.
*====================================================================

DEFINE CLASS CADBO AS BusinessBase

    *-- Filtro de categoria (obrigatorio - definido pelo formulario chamador)
    this_cTipoCads   = ""   && tipocads char(20) - tipo/categoria do cadastro

    *-- Propriedades da entidade (SigCdCad)
    this_cPkChaves   = ""   && pkchaves char(20) - chave primaria (LEFT(NEWID(),20))
    this_cCodCads    = ""   && codcads char(20) - codigo do item
    this_cDesCads    = ""   && descads char(40) - descricao do item
    this_cTxtCads    = ""   && txtcads char(50) - texto adicional
    this_cUsuars     = ""   && usuars char(10) - usuario que incluiu
    this_dDtIncs     = {}   && dtincs datetime - data/hora de inclusao
    this_cUsuAlts    = ""   && usualts char(10) - usuario que alterou
    this_dDtAlts     = {}   && dtalts datetime - data/hora de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCad"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            THIS.this_cCodCads  = TratarNulo(codcads,  "C")
            THIS.this_cDesCads  = TratarNulo(descads,  "C")
            THIS.this_cTxtCads  = TratarNulo(txtcads,  "C")
            THIS.this_cTipoCads = TratarNulo(tipocads, "C")
            THIS.this_cUsuars   = TratarNulo(usuars,   "C")
            THIS.this_cUsuAlts  = TratarNulo(usualts,  "C")
            IF !ISNULL(dtincs)
                THIS.this_dDtIncs = dtincs
            ENDIF
            IF !ISNULL(dtalts)
                THIS.this_dDtAlts = dtalts
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de cadastros filtrada por TipoCads
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cTipoCads)
            MsgErro("Tipo de cadastro n" + CHR(227) + "o definido.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           " ORDER BY codcads"
            ELSE
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           "   AND codcads LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY codcads"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cadastros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar cadastros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro por CodCads (chave de negocio)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, txtcads," + ;
                       " usuars, dtincs, usualts, dtalts" + ;
                       " FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Verifica se CodCads ja existe neste TipoCads
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.qtd > 0)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Dup")
            USE IN cursor_4c_Dup
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cPkNovo
        loc_lSucesso = .F.
        loc_cPkNovo  = ""

        TRY
            *-- Gerar PK via SQL Server (NEWID nao existe em VFP)
            SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(),20) AS pk_novo", "cursor_4c_PkNovo")
            IF USED("cursor_4c_PkNovo") AND RECCOUNT("cursor_4c_PkNovo") > 0
                SELECT cursor_4c_PkNovo
                loc_cPkNovo = ALLTRIM(cursor_4c_PkNovo.pk_novo)
            ENDIF
            IF USED("cursor_4c_PkNovo")
                USE IN cursor_4c_PkNovo
            ENDIF

            IF !EMPTY(loc_cPkNovo)
                THIS.this_cPkChaves = loc_cPkNovo

                loc_cSQL = "INSERT INTO SigCdCad" + ;
                           " (pkchaves, tipocads, codcads, descads, txtcads, usuars, dtincs, usualts, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(PADR(THIS.this_cPkChaves, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cCodCads,  20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cDesCads,  40)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTxtCads,  50)) + ", " + ;
                           EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(SPACE(10)) + ", " + ;
                           "NULL" + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Falha ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inserir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCad SET" + ;
                       " descads  = " + EscaparSQL(PADR(THIS.this_cDesCads, 40)) + "," + ;
                       " txtcads  = " + EscaparSQL(PADR(THIS.this_cTxtCads, 50)) + "," + ;
                       " usualts  = " + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + "," + ;
                       " dtalts   = GETDATE()" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads  = " + EscaparSQL(PADR(THIS.this_cCodCads,  20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro (PROTECTED - chamado por Excluir)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads  = " + EscaparSQL(PADR(THIS.this_cCodCads,  20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Hook chamado por NovoRegistro
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

ENDDEFINE
