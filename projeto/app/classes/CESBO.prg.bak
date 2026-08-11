*==============================================================================
* CESBO.prg - Business Object para Classifica" + CHR(231) + CHR(227) + "o de Estoque
* Tabela: SigCdCle
* PK: cidchaves (char 20, gerada por fUniqueIds)
* Indice de busca: clacods (char 15)
*==============================================================================

DEFINE CLASS CESBO AS BusinessBase

    *-- Propriedades da tabela SigCdCle
    this_cChaveUnica = ""    && cidchaves char(20) - PK gerada por fUniqueIds
    this_cCodigo     = ""    && clacods   char(15) - C" + CHR(243) + "digo (indice de busca)
    this_cGrupo      = ""    && clagrupos char(10) - Grupo (FK SigCdGcr.Codigos)
    this_cConta      = ""    && clacontas char(10) - Conta (FK SigCdCli.iclis)
    this_cSetor      = ""    && setors    char(10) - Setor (FK SigCdGcr.Codigos)

    *==========================================================================
    * Init - Configura tabela e campo chave do BusinessBase
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCle"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna PK para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cChaveUnica
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia cursor -> propriedades (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaveUnica   = TratarNulo(cidchaves, "C")
            THIS.this_cCodigo       = TratarNulo(clacods,   "C")
            THIS.this_cGrupo        = TratarNulo(clagrupos, "C")
            THIS.this_cConta        = TratarNulo(clacontas, "C")
            THIS.this_cSetor        = TratarNulo(setors,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros (PUBLIC)
    * Inclui cidchaves no SELECT para que o Form possa carregar por PK
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, clacods, clagrupos, clacontas, setors" + ;
                       " FROM SigCdCle"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY clacods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PUBLIC)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, clacods, clagrupos, clacontas, setors" + ;
                       " FROM SigCdCle" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarDuplicata - Verifica duplicidade de clacods+clagrupos+clacontas
    * Reproduz ChkRegister('SigCdCle') do legado
    *==========================================================================
    FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata
        loc_lDuplicata = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdCle" + ;
                       " WHERE clacods   = " + EscaparSQL(THIS.this_cCodigo) + ;
                       "   AND clagrupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                       "   AND clacontas = " + EscaparSQL(THIS.this_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicata = (cursor_4c_Dup.total > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.VerificarDuplicata:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicata
    ENDFUNC

    *==========================================================================
    * Inserir - Inclui novo registro (PROTECTED)
    * cidchaves gerado por fUniqueIds(); valida grupo + duplicata antes
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cGrupo))
                MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.VerificarDuplicata()
                    MsgAviso("C" + CHR(243) + "digo, Grupo e Conta j" + CHR(225) + " Cadastrado!", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_cChaveUnica = fUniqueIds()

                    loc_cSQL = "INSERT INTO SigCdCle" + ;
                               " (cidchaves, clacods, clagrupos, clacontas, setors)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cChaveUnica) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)     + ", " + ;
                               EscaparSQL(THIS.this_cGrupo)      + ", " + ;
                               EscaparSQL(THIS.this_cConta)      + ", " + ;
                               EscaparSQL(THIS.this_cSetor)      + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao incluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF

                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * clacods e fixo ao alterar (desabilitado no legado em modo ALTERAR)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCle SET" + ;
                       " clagrupos = " + EscaparSQL(THIS.this_cGrupo) + "," + ;
                       " clacontas = " + EscaparSQL(THIS.this_cConta) + "," + ;
                       " setors    = " + EscaparSQL(THIS.this_cSetor) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Remove registro do banco (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCle" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaveUnica)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CESBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
