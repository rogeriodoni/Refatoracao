*==============================================================================
* PgbBO.prg - Business Object para Historico dos Barras
* Herda de: BusinessBase
* Form: FormPgb.prg (OPERACIONAL - somente leitura)
*==============================================================================

DEFINE CLASS PgbBO AS BusinessBase

    *-- Parametros de entrada recebidos pelo form
    this_cEmps  = ""   && Codigo da empresa
    this_cDopes = ""   && Codigo da operacao/documento
    this_nNumes = 0    && Numero do documento

    *-- Descricao exibida no rodape (campo dpros do cursor)
    this_cDescricao = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()

        this_cTabela     = "SigPrCtb"
        this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional nao tem PK unica
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarHistorico - Executa SP SigPrCtb para carregar historico de barras
    *   par_cEmps  = codigo empresa (3 chars)
    *   par_cDopes = codigo operacao/documento
    *   par_nNumes = numero do documento
    * Retorna .T. se ok, .F. se erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarHistorico(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_oErro, loc_cParam, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            *-- Cursor placeholder identico ao que o SQLEXEC vai popular
            SET NULL ON
            IF USED("cursor_4c_HistoricoPgb")
                USE IN cursor_4c_HistoricoPgb
            ENDIF
            CREATE CURSOR cursor_4c_HistoricoPgb ;
                (Datas    D    NULL, ;
                 Etiqs    C(30) NULL, ;
                 Ccustos  C(20) NULL, ;
                 Ccusto2s C(20) NULL, ;
                 Tpoperas C(40) NULL, ;
                 Tplancs  C(10) NULL, ;
                 Dtbases  D    NULL, ;
                 Dpros    C(60) NULL)
            SET NULL OFF

            *-- Parametro concatenado igual ao legado: Emp + Dope + STR(Nume, 6)
            loc_cParam = ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)
            loc_cSQL   = "EXEC SigPrCtb @EmpdopNums = " + EscaparSQL(loc_cParam)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistPgbTemp")

            IF loc_nResult > 0
                SELECT cursor_4c_HistoricoPgb
                ZAP
                APPEND FROM DBF("cursor_4c_HistPgbTemp")
                IF USED("cursor_4c_HistPgbTemp")
                    USE IN cursor_4c_HistPgbTemp
                ENDIF
                SELECT cursor_4c_HistoricoPgb
                IF RECCOUNT() > 0
                    GO BOTTOM
                ENDIF
                loc_lSucesso = .T.
            ELSE
                LOCAL loc_aErroSQL[1]
                AERROR(loc_aErroSQL)
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico de barras:" + CHR(13) + ;
                        loc_aErroSQL[2], "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarHistorico")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente do cursor de historico
    *   para as propriedades da instancia (Text1 do rodape mostra Dpros)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, "cursor_4c_HistoricoPgb")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de hist" + CHR(243) + "rico n" + CHR(227) + ;
                                      "o est" + CHR(225) + " aberto: " + loc_cAlias
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        IF RECCOUNT() = 0 OR EOF()
            RETURN .F.
        ENDIF

        *-- Rodape do form legado (Text1) exibe Dpros do registro corrente
        IF TYPE(loc_cAlias + ".Dpros") = "C"
            THIS.this_cDescricao = TratarNulo(EVALUATE(loc_cAlias + ".Dpros"), "C")
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Form de historico eh SOMENTE LEITURA
    *   Historico de barras eh populado por SP SigPrCtb, nunca por INSERT direto.
    *   Chamada indevida (via BusinessBase.Salvar) informa o motivo e retorna .F.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de hist" + CHR(243) + ;
                                  "rico dos barras " + CHR(233) + " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de INSER" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Form de historico eh SOMENTE LEITURA
    *   Registros vem da SP SigPrCtb; UPDATE direto nao eh suportado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de hist" + CHR(243) + ;
                                  "rico dos barras " + CHR(233) + " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de ATUALIZA" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Form de historico eh SOMENTE LEITURA
    *   Registros historicos nao devem ser removidos manualmente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de hist" + CHR(243) + ;
                                  "rico dos barras " + CHR(233) + " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de EXCLUS" + CHR(195) + ;
                                  "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

ENDDEFINE
