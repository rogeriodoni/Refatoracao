*==============================================================================
* SIGREIPSBO.PRG
* Business Object para Relatorio de Impressao de Etiquetas/Mala Direta (SigReIp3)
*
* Herda de RelatorioBase
* Tabela principal: SigMlCab
* Filtro: SigMlItn (codigo/descricao)
*==============================================================================

DEFINE CLASS SIGREIPSBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCodigos       = ""   && Codigo do item (SigMlItn.Codigos)
    this_cDescs         = ""   && Descricao do item (SigMlItn.Descs)

    *-- Cursor de dados do relatorio
    this_cCursorDados   = "cursor_4c_Relacao"

    *-- Identificacao
    this_cTabela        = "SigMlCab"
    this_cCampoChave    = "cIdChaves"
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMlCab"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula cursor do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cWhere = "1=1"
            IF !EMPTY(ALLTRIM(THIS.this_cCodigos))
                loc_cWhere = loc_cWhere + " AND Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))
            ENDIF

            loc_cSQL = "SELECT RClis, IClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, " + ;
                       "Tel1s, Tel2s, Faxs, cIdChaves " + ;
                       "FROM SigMlCab " + ;
                       "WHERE " + loc_cWhere + " " + ;
                       "ORDER BY RClis, IClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, " + ;
                       "Estas, Tel1s, Tel2s, Faxs, cIdChaves"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados para o relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                IF RECCOUNT() = 0
                    MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            REPORT FORM (gc_4c_CaminhoReports + "SigReIp3") TO PRINTER NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                IF RECCOUNT() = 0
                    MsgAviso("Nenhum registro encontrado para visualiza" + CHR(231) + CHR(227) + "o.", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            REPORT FORM (gc_4c_CaminhoReports + "SigReIp3") PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual no cursor
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            IF !EOF()
                RETURN ALLTRIM(cIdChaves)
            ENDIF
        ENDIF
        RETURN ""
    ENDPROC

ENDDEFINE
