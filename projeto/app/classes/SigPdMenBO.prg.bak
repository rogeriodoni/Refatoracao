*==============================================================================
* SigPdMenBO.prg - Business Object para Mensagens de Produto
* Tabela: SigCdMsg
* Chave: cidchaves
*==============================================================================

DEFINE CLASS SigPdMenBO AS BusinessBase

    *-- Campos de SigCdMsg
    this_cCidChave  = ""
    this_nCors      = 0
    this_cCpros     = ""
    this_cEmpcpros  = ""
    this_cEmps      = ""
    this_cEstilos   = ""
    this_cFontes    = ""
    this_cLinha1s   = ""
    this_cLinha2s   = ""
    this_nTamanhos  = 0
    this_cCgrus     = ""
    this_cMercs     = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        this_cTabela     = "SigCdMsg"
        this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMensagem - Carrega dados de SigCdMsg pelo cidchave
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMensagem(par_cCidChave)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cors, cpros, empcpros, emps, " + ;
                       "estilos, fontes, linha1s, linha2s, tamanhos, cgrus, mercs " + ;
                       "FROM SigCdMsg " + ;
                       "WHERE estilos = " + EscaparSQL(par_cCidChave)

            IF USED("cursor_4c_SigPdMenMsg")
                TABLEREVERT(.T., "cursor_4c_SigPdMenMsg")
                USE IN cursor_4c_SigPdMenMsg
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPdMenMsg") > 0
                IF !EOF("cursor_4c_SigPdMenMsg")
                    SELECT cursor_4c_SigPdMenMsg
                    THIS.this_cCidChave  = ALLTRIM(NVL(cidchaves, ""))
                    THIS.this_nCors      = NVL(cors, 0)
                    THIS.this_cCpros     = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cEmpcpros  = ALLTRIM(NVL(empcpros, ""))
                    THIS.this_cEmps      = ALLTRIM(NVL(emps, ""))
                    THIS.this_cEstilos   = ALLTRIM(NVL(estilos, ""))
                    THIS.this_cFontes    = ALLTRIM(NVL(fontes, ""))
                    THIS.this_cLinha1s   = ALLTRIM(NVL(linha1s, ""))
                    THIS.this_cLinha2s   = ALLTRIM(NVL(linha2s, ""))
                    THIS.this_nTamanhos  = NVL(tamanhos, 9)
                    THIS.this_cCgrus     = ALLTRIM(NVL(cgrus, ""))
                    THIS.this_cMercs     = ALLTRIM(NVL(mercs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao buscar mensagem do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChave  = ALLTRIM(TratarNulo(cidchaves, "C"))
            THIS.this_nCors      = TratarNulo(cors, "N")
            THIS.this_cCpros     = ALLTRIM(TratarNulo(cpros, "C"))
            THIS.this_cEmpcpros  = ALLTRIM(TratarNulo(empcpros, "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps, "C"))
            THIS.this_cEstilos   = ALLTRIM(TratarNulo(estilos, "C"))
            THIS.this_cFontes    = ALLTRIM(TratarNulo(fontes, "C"))
            THIS.this_cLinha1s   = ALLTRIM(TratarNulo(linha1s, "C"))
            THIS.this_cLinha2s   = ALLTRIM(TratarNulo(linha2s, "C"))
            THIS.this_nTamanhos  = TratarNulo(tamanhos, "N")
            THIS.this_cCgrus     = ALLTRIM(TratarNulo(cgrus, "C"))
            THIS.this_cMercs     = ALLTRIM(TratarNulo(mercs, "C"))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF EMPTY(ALLTRIM(THIS.this_cCidChave))
            MsgAviso("Chave da mensagem " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cCpros))
            MsgAviso("C" + CHR(243) + "digo do produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("C" + CHR(243) + "digo da empresa " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMsg " + ;
                       "(cidchaves, cors, cpros, empcpros, emps, " + ;
                       "estilos, fontes, linha1s, linha2s, tamanhos, cgrus, mercs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChave) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCors) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cEmpcpros) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEstilos) + ", " + ;
                       EscaparSQL(THIS.this_cFontes) + ", " + ;
                       EscaparSQL(THIS.this_cLinha1s) + ", " + ;
                       EscaparSQL(THIS.this_cLinha2s) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTamanhos) + ", " + ;
                       EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       EscaparSQL(THIS.this_cMercs) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMsg SET " + ;
                       "cors = " + FormatarNumeroSQL(THIS.this_nCors) + ", " + ;
                       "cpros = " + EscaparSQL(THIS.this_cCpros) + ", " + ;
                       "empcpros = " + EscaparSQL(THIS.this_cEmpcpros) + ", " + ;
                       "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "estilos = " + EscaparSQL(THIS.this_cEstilos) + ", " + ;
                       "fontes = " + EscaparSQL(THIS.this_cFontes) + ", " + ;
                       "linha1s = " + EscaparSQL(THIS.this_cLinha1s) + ", " + ;
                       "linha2s = " + EscaparSQL(THIS.this_cLinha2s) + ", " + ;
                       "tamanhos = " + FormatarNumeroSQL(THIS.this_nTamanhos) + ", " + ;
                       "cgrus = " + EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       "mercs = " + EscaparSQL(THIS.this_cMercs) + " " + ;
                       "WHERE estilos = " + EscaparSQL(THIS.this_cEstilos)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMsg " + ;
                       "WHERE estilos = " + EscaparSQL(THIS.this_cEstilos)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
