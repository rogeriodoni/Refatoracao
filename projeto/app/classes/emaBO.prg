*==============================================================================
* EMABO.PRG
* Business Object para Cadastro de Email (SigCdEma)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS emaBO AS BusinessBase

    *-- Propriedades de dados
    this_cIdChaves     = ""    && cIdChaves (C 20) - PK tecnica (UUID gerado por fUniqueIds)
    this_cCods         = ""    && Email (C 50) - chave natural unica
    this_cCodsOriginal = ""    && Cods original apos CarregarPorCodigo (para UPDATE WHERE)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEma"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar emaBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves     = TratarNulo(cIdChaves, "C")
            THIS.this_cCods         = TratarNulo(Cods, "C")
            THIS.this_cCodsOriginal = THIS.this_cCods
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os emails (ou filtrados por texto)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                           " WHERE Cods LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar emails:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo email (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma" + ;
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(par_cCodigo), 50))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEma
    * Logica do legado: valida email nao vazio, verifica duplicidade, gera PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cSQLDup, loc_nDup
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verificar duplicidade de email (logica identica ao legado)
            loc_cSQLDup = "SELECT Cods FROM SigCdEma" + ;
                          " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCods), 50))
            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_Dup")

            IF loc_nDup >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                MsgAviso("Email J" + CHR(225) + " Cadastrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF

                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
                loc_cSQL = "INSERT INTO SigCdEma (cIdChaves, Cods)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdEma" + ;
                       " SET Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodsOriginal), 50))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEma" + ;
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCods), 50))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
