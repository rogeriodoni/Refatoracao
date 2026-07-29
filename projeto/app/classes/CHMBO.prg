*==============================================================================
* CHMBO.prg - Business Object: Configura??o do Cheque Matricial
* Tabela: SigCqMat
* PK: banco (C3)
* Gerado: 2026-07-28 - Fase 1/8
*==============================================================================
DEFINE CLASS CHMBO AS BusinessBase

    *-- Chave prim?ria
    this_cBanco     = ""   && banco C(3)

    *-- Posi??es de impress?o - Valor
    this_nLvlr      = 0    && lvlr  N - Linha  Valor
    this_nCvlr      = 0    && cvlr  N - Coluna Valor

    *-- Posi??es de impress?o - Valor Extenso 1
    this_nLvext1    = 0    && lvext1 N - Linha  Valor Extenso 1
    this_nCvext1    = 0    && cvext1 N - Coluna Valor Extenso 1

    *-- Posi??es de impress?o - Valor Extenso 2
    this_nLvext2    = 0    && lvext2 N - Linha  Valor Extenso 2
    this_nCvext2    = 0    && cvext2 N - Coluna Valor Extenso 2

    *-- Posi??es de impress?o - Favorecido
    this_nLfavo     = 0    && lfavo N - Linha  Favorecido
    this_nCfavo     = 0    && cfavo N - Coluna Favorecido

    *-- Posi??es de impress?o - Localidade
    this_nLlocal    = 0    && llocal N - Linha  Localidade
    this_nClocal    = 0    && clocal N - Coluna Localidade

    *-- Posi??es de impress?o - Dia
    this_nLdia      = 0    && ldia N - Linha  Dia
    this_nCdia      = 0    && cdia N - Coluna Dia

    *-- Posi??es de impress?o - M?s
    this_nLmes      = 0    && lmes N - Linha  M?s
    this_nCmes      = 0    && cmes N - Coluna M?s

    *-- Posi??es de impress?o - Ano
    this_nLano      = 0    && lano N - Linha  Ano
    this_nCano      = 0    && cano N - Coluna Ano

    *-- Campos de configura??o da impressora
    this_cLocal     = ""   && local      C(20) - Local de emiss?o
    this_cTamanho   = ""   && ctamanho   C(50) - Tamanho da folha
    this_cNomImpre  = ""   && cNomImpre  C(40) - Nome da impressora

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SigCqMat"
        THIS.this_cCampoChave  = "banco"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cBanco
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " WHERE banco LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY banco"
            ELSE
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " ORDER BY banco"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cBanco)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT banco, lvlr, cvlr, lvext1, cvext1," + ;
                       " lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                       " ldia, cdia, lmes, cmes, lano, cano," + ;
                       " [local], ctamanho, cnomimpre" + ;
                       " FROM SigCqMat" + ;
                       " WHERE banco = " + EscaparSQL(par_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBanco    = TratarNulo(banco,    "C")
            THIS.this_nLvlr     = TratarNulo(lvlr,     "N")
            THIS.this_nCvlr     = TratarNulo(cvlr,     "N")
            THIS.this_nLvext1   = TratarNulo(lvext1,   "N")
            THIS.this_nCvext1   = TratarNulo(cvext1,   "N")
            THIS.this_nLvext2   = TratarNulo(lvext2,   "N")
            THIS.this_nCvext2   = TratarNulo(cvext2,   "N")
            THIS.this_nLfavo    = TratarNulo(lfavo,    "N")
            THIS.this_nCfavo    = TratarNulo(cfavo,    "N")
            THIS.this_nLlocal   = TratarNulo(llocal,   "N")
            THIS.this_nClocal   = TratarNulo(clocal,   "N")
            THIS.this_nLdia     = TratarNulo(ldia,     "N")
            THIS.this_nCdia     = TratarNulo(cdia,     "N")
            THIS.this_nLmes     = TratarNulo(lmes,     "N")
            THIS.this_nCmes     = TratarNulo(cmes,     "N")
            THIS.this_nLano     = TratarNulo(lano,     "N")
            THIS.this_nCano     = TratarNulo(cano,     "N")
            THIS.this_cLocal    = TratarNulo(EVALUATE(par_cAliasCursor + ".local"), "C")
            THIS.this_cTamanho  = TratarNulo(ctamanho, "C")
            THIS.this_cNomImpre = TratarNulo(cnomimpre,"C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_cChkSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChkSQL = "SELECT COUNT(*) AS total FROM SigCqMat" + ;
                          " WHERE banco = " + EscaparSQL(THIS.this_cBanco)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkDup")

            IF cursor_4c_ChkDup.total > 0
                MsgAviso("Existe esse Banco J" + CHR(225) + " Cadastrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_ChkDup
            ELSE
                USE IN cursor_4c_ChkDup
                loc_cSQL = "INSERT INTO SigCqMat" + ;
                           " (banco, lvlr, cvlr, lvext1, cvext1," + ;
                           "  lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                           "  ldia, cdia, lmes, cmes, lano, cano," + ;
                           "  [local], ctamanho, cnomimpre)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cBanco) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLlocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nClocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLano) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCano) + ", " + ;
                           EscaparSQL(THIS.this_cLocal) + ", " + ;
                           EscaparSQL(THIS.this_cTamanho) + ", " + ;
                           EscaparSQL(THIS.this_cNomImpre) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Insert")
                    TABLEREVERT(.T., "cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

                IF loc_nResultado > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir: " + loException.Message, "Erro")
            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqMat SET" + ;
                       " lvlr = "    + FormatarNumeroSQL(THIS.this_nLvlr)   + "," + ;
                       " cvlr = "    + FormatarNumeroSQL(THIS.this_nCvlr)   + "," + ;
                       " lvext1 = "  + FormatarNumeroSQL(THIS.this_nLvext1) + "," + ;
                       " cvext1 = "  + FormatarNumeroSQL(THIS.this_nCvext1) + "," + ;
                       " lvext2 = "  + FormatarNumeroSQL(THIS.this_nLvext2) + "," + ;
                       " cvext2 = "  + FormatarNumeroSQL(THIS.this_nCvext2) + "," + ;
                       " lfavo = "   + FormatarNumeroSQL(THIS.this_nLfavo)  + "," + ;
                       " cfavo = "   + FormatarNumeroSQL(THIS.this_nCfavo)  + "," + ;
                       " llocal = "  + FormatarNumeroSQL(THIS.this_nLlocal) + "," + ;
                       " clocal = "  + FormatarNumeroSQL(THIS.this_nClocal) + "," + ;
                       " ldia = "    + FormatarNumeroSQL(THIS.this_nLdia)   + "," + ;
                       " cdia = "    + FormatarNumeroSQL(THIS.this_nCdia)   + "," + ;
                       " lmes = "    + FormatarNumeroSQL(THIS.this_nLmes)   + "," + ;
                       " cmes = "    + FormatarNumeroSQL(THIS.this_nCmes)   + "," + ;
                       " lano = "    + FormatarNumeroSQL(THIS.this_nLano)   + "," + ;
                       " cano = "    + FormatarNumeroSQL(THIS.this_nCano)   + "," + ;
                       " [local] = " + EscaparSQL(THIS.this_cLocal)         + "," + ;
                       " ctamanho = "+ EscaparSQL(THIS.this_cTamanho)       + "," + ;
                       " cnomimpre ="+ EscaparSQL(THIS.this_cNomImpre) + ;
                       " WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCqMat WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
