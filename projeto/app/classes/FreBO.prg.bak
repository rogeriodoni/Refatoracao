*==============================================================================
* FreBO.prg - Business Object: Fretes por Cidade
*==============================================================================
* Tabelas:
*   SigCdFrt  - modo global (this_cDopes vazio): PK = cidas
*   SigOpFrt  - modo operacional (this_cDopes preenchido): chave composta cidas+dopes
*==============================================================================

DEFINE CLASS FreBO AS BusinessBase

    *-- Campos compartilhados (SigCdFrt e SigOpFrt)
    this_cCidade     = ""   && cidas       CHAR(30)       - nome da cidade
    this_nFrete      = 0    && valors      NUMERIC(11,2)  - valor do frete

    *-- Campos exclusivos modo operacional (SigOpFrt)
    this_cDopes      = ""   && dopes       CHAR(20)       - tipo de operacao (vazio = modo global)

    *===========================================================================
    * Init - Inicializa BO no modo global (SigCdFrt / PK = cidas)
    *        Para modo operacional: setar this_cDopes apos Init()
    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrt"
            THIS.this_cCampoChave = "cidas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FreBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *   Ambos os modos: cidas (cidade)
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidade)
    ENDFUNC

    *===========================================================================
    * Buscar - Lista registros no cursor cursor_4c_Dados
    *   par_cFiltro: filtro opcional em cidas (LIKE)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: SigCdFrt
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                        " WHERE cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ELSE
                *-- Modo operacional: SigOpFrt filtrado por dopes
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " AND cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fretes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega registro por cidas no cursor cursor_4c_Carrega
    *   Modo global:      WHERE cidas = par_cCodigo
    *   Modo operacional: WHERE cidas = par_cCodigo AND dopes = this_cDopes
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo)
            ELSE
                loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidade = TratarNulo(cidas, "C")
                THIS.this_nFrete  = TratarNulo(valors, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Inserir - INSERT em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: INSERT em SigCdFrt
                loc_cSQL = "INSERT INTO SigCdFrt (cidas, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ELSE
                *-- Modo operacional: INSERT em SigOpFrt com chave composta cidas+dopes
                loc_cSQL = "INSERT INTO SigOpFrt (cidas, dopes, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Atualizar - UPDATE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: UPDATE SigCdFrt por cidas (PK nao alteravel, so valors)
                loc_cSQL = "UPDATE SigCdFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                *-- Modo operacional: UPDATE SigOpFrt pela chave composta cidas+dopes
                loc_cSQL = "UPDATE SigOpFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - DELETE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "DELETE FROM SigCdFrt WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                loc_cSQL = "DELETE FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
