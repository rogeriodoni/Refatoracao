*==============================================================================
* FTFBO.prg - Business Object para Finalizadoras (Tef)
* Tabela: SigFiNz
* PK: nordems (numeric 2,0)
*==============================================================================

DEFINE CLASS FTFBO AS BusinessBase

    *-- Propriedades da tabela SigFiNz
    this_nOrdem    = 0    && nordems numeric(2,0) - PK
    this_cDescricao = ""  && cdescrs char(20)

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela    = "SigFiNz"
        THIS.this_cCampoChave = "nordems"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nOrdem)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nOrdem     = TratarNulo(nordems, "N")
            THIS.this_cDescricao = ALLTRIM(TratarNulo(cdescrs, "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros (PUBLIC)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT nordems, cdescrs" + ;
                       " FROM SigFiNz" + ;
                       " ORDER BY nordems"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT nordems, cdescrs" + ;
                           " FROM SigFiNz" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY nordems"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNz")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Finalizadoras (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela PK (PUBLIC)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nOrdem)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT nordems, cdescrs" + ;
                       " FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(par_nOrdem)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNz (nordems, cdescrs)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nOrdem) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNz" + ;
                       " SET cdescrs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE nordems = " + FormatarNumeroSQL(THIS.this_nOrdem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(THIS.this_nOrdem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarOrdemExistente - Valida unicidade do campo Ordem (PUBLIC)
    *==========================================================================
    FUNCTION VerificarOrdemExistente(par_nOrdem)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(par_nOrdem)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkOrdem")
                TABLEREVERT(.T., "cursor_4c_ChkOrdem")
                USE IN cursor_4c_ChkOrdem
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrdem")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkOrdem") > 0
                SELECT cursor_4c_ChkOrdem
                loc_lExiste = (cursor_4c_ChkOrdem.Total > 0)
            ENDIF

            IF USED("cursor_4c_ChkOrdem")
                USE IN cursor_4c_ChkOrdem
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.VerificarOrdemExistente:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE
