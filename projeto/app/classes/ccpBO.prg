*============================================================================
* ccpBO.prg - Business Object para Parametrizacao do Recalculo de Precos
* Tabela: SigCdCcp
* Task: 358 - Migracao do formulario SIGCDCCP
*============================================================================

DEFINE CLASS ccpBO AS BusinessBase

    *-- Chave primaria
    this_cCodigo     = ""

    *-- Flag de inatividade
    this_lInativa    = .F.

    *-- Fornecedor
    this_cCFornecs   = ""
    this_cDFornecs   = ""

    *-- Filtros: Unidade (inicio / fim)
    this_cCunii      = ""
    this_cCunif      = ""

    *-- Filtros: Linha (inicio / fim)
    this_cLini       = ""
    this_cLinf       = ""

    *-- Filtros: Colecao (inicio / fim)
    this_cColi       = ""
    this_cColf       = ""

    *-- Filtros: Grupo (inicio / fim)
    this_cCgrui      = ""
    this_cCgruf      = ""

    *-- Filtros: Moeda (inicio / fim)
    this_cMoedai     = ""
    this_cMoedaf     = ""

    *-- Filtros: Grande Grupo (inicio / fim)
    this_cMercI      = ""
    this_cMercF      = ""

    *-- Filtros: Subgrupo (inicio / fim)
    this_cSgruI      = ""
    this_cSgruF      = ""

    *-- Filtros: Markup (inicio / fim)
    this_nMrki       = 0
    this_nMrkf       = 0

    *-- Filtros: Encargo (inicio / fim)
    this_nEncI       = 0
    this_nEncf       = 0

    *-- Parametros de calculo
    this_nReajuste   = 0
    this_nNMrk       = 0
    this_nVariacao   = 0
    this_cFeitio     = ""
    this_nEncargo    = 0
    this_cNewMkp     = ""

    *-- Opcoes (OptionGroups): Situacao (1-3)
    this_nOpcSit     = 1

    *-- Opcoes (OptionGroups): Recalcula (1-8)
    this_nOpcRecalc  = 1

    *-- Opcoes (OptionGroups): Atualiza Val.Venda (1-2)
    this_nOpcpven    = 1

    *-- Opcoes (OptionGroups): Tipo Moeda (1-2)
    this_nOpcMoedaTp = 1

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCcp"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de parametros no cursor_4c_Dados
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigo, cfornecs FROM SigCdCcp ORDER BY codigo"
            ELSE
                loc_cSQL = "SELECT codigo, cfornecs FROM SigCdCcp" + ;
                           " WHERE RTRIM(codigo) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                           " ORDER BY codigo"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar par" + CHR(226) + "metros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar par" + CHR(226) + "metros:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, Inativas, cfornecs, merci, mercf," + ;
                       " cgrui, cgruf, sgrui, sgruf, cunii, cunif," + ;
                       " lini, linf, coli, colf, moedai, moedaf, opcmoedatp," + ;
                       " mrki, mrkf, enci, encf, variacao, feitio," + ;
                       " opcSit, opcrecalc, reajuste, encargo, nmrk, opcpven, newmkp" + ;
                       " FROM SigCdCcp" + ;
                       " WHERE RTRIM(codigo) = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar par" + CHR(226) + "metro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo     = TratarNulo(codigo, "C")
            THIS.this_lInativa    = (TratarNulo(Inativas, "N") = 1)
            THIS.this_cCFornecs   = TratarNulo(cfornecs, "C")
            THIS.this_cMercI      = TratarNulo(merci, "C")
            THIS.this_cMercF      = TratarNulo(mercf, "C")
            THIS.this_cCgrui      = TratarNulo(cgrui, "C")
            THIS.this_cCgruf      = TratarNulo(cgruf, "C")
            THIS.this_cSgruI      = TratarNulo(sgrui, "C")
            THIS.this_cSgruF      = TratarNulo(sgruf, "C")
            THIS.this_cCunii      = TratarNulo(cunii, "C")
            THIS.this_cCunif      = TratarNulo(cunif, "C")
            THIS.this_cLini       = TratarNulo(lini, "C")
            THIS.this_cLinf       = TratarNulo(linf, "C")
            THIS.this_cColi       = TratarNulo(coli, "C")
            THIS.this_cColf       = TratarNulo(colf, "C")
            THIS.this_cMoedai     = TratarNulo(moedai, "C")
            THIS.this_cMoedaf     = TratarNulo(moedaf, "C")
            THIS.this_nOpcMoedaTp = TratarNulo(opcmoedatp, "N")
            THIS.this_nMrki       = TratarNulo(mrki, "N")
            THIS.this_nMrkf       = TratarNulo(mrkf, "N")
            THIS.this_nEncI       = TratarNulo(enci, "N")
            THIS.this_nEncf       = TratarNulo(encf, "N")
            THIS.this_nVariacao   = TratarNulo(variacao, "N")
            THIS.this_cFeitio     = TratarNulo(feitio, "C")
            THIS.this_nOpcSit     = TratarNulo(opcSit, "N")
            THIS.this_nOpcRecalc  = TratarNulo(opcrecalc, "N")
            THIS.this_nReajuste   = TratarNulo(reajuste, "N")
            THIS.this_nEncargo    = TratarNulo(encargo, "N")
            THIS.this_nNMrk       = TratarNulo(nmrk, "N")
            THIS.this_nOpcpven    = TratarNulo(opcpven, "N")
            THIS.this_cNewMkp     = TratarNulo(newmkp, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarProximoCodigo - Gera proximo codigo sequencial para SigCdCcp
    *==========================================================================
    PROTECTED FUNCTION GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResultado, loc_nProximo
        loc_nProximo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(RTRIM(codigo) AS INT)), 0) + 1 AS proximo" + ;
                       " FROM SigCdCcp"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Proximo")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Proximo") > 0
                SELECT cursor_4c_Proximo
                loc_nProximo = cursor_4c_Proximo.proximo
            ENDIF
            IF USED("cursor_4c_Proximo")
                USE IN cursor_4c_Proximo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Proximo")
                USE IN cursor_4c_Proximo
            ENDIF
        ENDTRY

        RETURN loc_nProximo
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT na tabela SigCdCcp
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves, loc_nProxCodigo
        loc_lSucesso = .F.

        TRY
            *-- Gerar codigo sequencial se nao informado
            IF EMPTY(ALLTRIM(THIS.this_cCodigo))
                loc_nProxCodigo = THIS.GerarProximoCodigo()
                IF loc_nProxCodigo <= 0
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo sequencial.", "Erro")
                ELSE
                    THIS.this_cCodigo = PADL(TRANSFORM(loc_nProxCodigo), 3, "0")
                ENDIF
            ENDIF

            *-- Gerar cIdChaves (PK interna do framework)
            loc_cCidChaves = LEFT(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCdCcp" + ;
                       " (cIdChaves, codigo, Inativas, cfornecs," + ;
                       " merci, mercf, cgrui, cgruf, sgrui, sgruf," + ;
                       " cunii, cunif, lini, linf, coli, colf," + ;
                       " moedai, moedaf, opcmoedatp, mrki, mrkf," + ;
                       " enci, encf, variacao, feitio," + ;
                       " opcSit, opcrecalc, reajuste, encargo, nmrk, opcpven, newmkp)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       FormatarNumeroSQL(IIF(THIS.this_lInativa, 1, 0)) + "," + ;
                       EscaparSQL(THIS.this_cCFornecs) + "," + ;
                       EscaparSQL(THIS.this_cMercI) + "," + ;
                       EscaparSQL(THIS.this_cMercF) + "," + ;
                       EscaparSQL(THIS.this_cCgrui) + "," + ;
                       EscaparSQL(THIS.this_cCgruf) + "," + ;
                       EscaparSQL(THIS.this_cSgruI) + "," + ;
                       EscaparSQL(THIS.this_cSgruF) + "," + ;
                       EscaparSQL(THIS.this_cCunii) + "," + ;
                       EscaparSQL(THIS.this_cCunif) + "," + ;
                       EscaparSQL(THIS.this_cLini) + "," + ;
                       EscaparSQL(THIS.this_cLinf) + "," + ;
                       EscaparSQL(THIS.this_cColi) + "," + ;
                       EscaparSQL(THIS.this_cColf) + "," + ;
                       EscaparSQL(THIS.this_cMoedai) + "," + ;
                       EscaparSQL(THIS.this_cMoedaf) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpcMoedaTp) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMrki) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMrkf) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEncI) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEncf) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVariacao) + "," + ;
                       EscaparSQL(THIS.this_cFeitio) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpcSit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpcRecalc) + "," + ;
                       FormatarNumeroSQL(THIS.this_nReajuste) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEncargo) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNMrk) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpcpven) + "," + ;
                       EscaparSQL(THIS.this_cNewMkp) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir par" + CHR(226) + "metro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir par" + CHR(226) + "metro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigCdCcp
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCcp SET" + ;
                       " Inativas = " + FormatarNumeroSQL(IIF(THIS.this_lInativa, 1, 0)) + "," + ;
                       " cfornecs = " + EscaparSQL(THIS.this_cCFornecs) + "," + ;
                       " merci = " + EscaparSQL(THIS.this_cMercI) + "," + ;
                       " mercf = " + EscaparSQL(THIS.this_cMercF) + "," + ;
                       " cgrui = " + EscaparSQL(THIS.this_cCgrui) + "," + ;
                       " cgruf = " + EscaparSQL(THIS.this_cCgruf) + "," + ;
                       " sgrui = " + EscaparSQL(THIS.this_cSgruI) + "," + ;
                       " sgruf = " + EscaparSQL(THIS.this_cSgruF) + "," + ;
                       " cunii = " + EscaparSQL(THIS.this_cCunii) + "," + ;
                       " cunif = " + EscaparSQL(THIS.this_cCunif) + "," + ;
                       " lini = " + EscaparSQL(THIS.this_cLini) + "," + ;
                       " linf = " + EscaparSQL(THIS.this_cLinf) + "," + ;
                       " coli = " + EscaparSQL(THIS.this_cColi) + "," + ;
                       " colf = " + EscaparSQL(THIS.this_cColf) + "," + ;
                       " moedai = " + EscaparSQL(THIS.this_cMoedai) + "," + ;
                       " moedaf = " + EscaparSQL(THIS.this_cMoedaf) + "," + ;
                       " opcmoedatp = " + FormatarNumeroSQL(THIS.this_nOpcMoedaTp) + "," + ;
                       " mrki = " + FormatarNumeroSQL(THIS.this_nMrki) + "," + ;
                       " mrkf = " + FormatarNumeroSQL(THIS.this_nMrkf) + "," + ;
                       " enci = " + FormatarNumeroSQL(THIS.this_nEncI) + "," + ;
                       " encf = " + FormatarNumeroSQL(THIS.this_nEncf) + "," + ;
                       " variacao = " + FormatarNumeroSQL(THIS.this_nVariacao) + "," + ;
                       " feitio = " + EscaparSQL(THIS.this_cFeitio) + "," + ;
                       " opcSit = " + FormatarNumeroSQL(THIS.this_nOpcSit) + "," + ;
                       " opcrecalc = " + FormatarNumeroSQL(THIS.this_nOpcRecalc) + "," + ;
                       " reajuste = " + FormatarNumeroSQL(THIS.this_nReajuste) + "," + ;
                       " encargo = " + FormatarNumeroSQL(THIS.this_nEncargo) + "," + ;
                       " nmrk = " + FormatarNumeroSQL(THIS.this_nNMrk) + "," + ;
                       " opcpven = " + FormatarNumeroSQL(THIS.this_nOpcpven) + "," + ;
                       " newmkp = " + EscaparSQL(THIS.this_cNewMkp) + ;
                       " WHERE RTRIM(codigo) = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar par" + CHR(226) + "metro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar par" + CHR(226) + "metro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigCdCcp
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCcp" + ;
                       " WHERE RTRIM(codigo) = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir par" + CHR(226) + "metro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir par" + CHR(226) + "metro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
