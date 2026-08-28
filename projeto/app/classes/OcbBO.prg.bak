*==============================================================================
* OcbBO.prg - Business Object para Ocorrencias do Balanco
* Tabela: SigBaOco
*==============================================================================

DEFINE CLASS OcbBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas de SigBaOco)
    this_cCodigos   = ""    && codigos   char(10) - PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cTipos     = ""    && tipos     char(1) - "O" ou "J"
    this_cApuras    = ""    && apuras    char(1) - "S" ou "N"
    this_cLancas    = ""    && lancas    char(1) - "S" ou "N"
    this_cOpers     = ""    && opers     char(2) - "DB","CR","DF","NL"
    this_cAutos     = ""    && autos     char(1) - "S" ou "N"
    this_cOperacaos = ""    && operacaos char(1) - "E" ou "S"
    this_cGrupos    = ""    && grupos    char(10) - FK SigCdGcr

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigBaOco"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT com filtro opcional (cursor_4c_Dados)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

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

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_cTipos      = TratarNulo(tipos,      "C")
            THIS.this_cApuras     = TratarNulo(apuras,     "C")
            THIS.this_cLancas     = TratarNulo(lancas,     "C")
            THIS.this_cOpers      = TratarNulo(opers,      "C")
            THIS.this_cAutos      = TratarNulo(autos,      "C")
            THIS.this_cOperacaos  = TratarNulo(operacaos,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigBaOco" + ;
                       " (codigos, descrs, tipos, apuras, lancas," + ;
                       "  opers, autos, operacaos, grupos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigBaOco SET" + ;
                       " descrs    = " + EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       " apuras    = " + EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       " lancas    = " + EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       " opers     = " + EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       " autos     = " + EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       " operacaos = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigBaOco (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
