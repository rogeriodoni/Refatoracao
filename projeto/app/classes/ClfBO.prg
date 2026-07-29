*==============================================================================
* ClfBO.prg - Business Object para Classificacao Fiscal
* Tabela: SIGCDCLF
* Tabelas filhas: sigcdiva (IVAs por estado), sigcdred (Reducoes por estado)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS ClfBO AS BusinessBase

    *-- Propriedades da entidade (SIGCDCLF)
    this_cCodigo    = ""   && codigos char(10) PK
    this_cDescricao = ""   && descricaos char(40)
    this_nAipi      = 0    && aipis numeric(9,2) - Aliq. IPI padrao
    this_cUnidade   = ""   && unidades char(3)
    this_cAliqReds  = ""   && aliqreds char(1) S/N - Aliquota Reduzida ICMS
    this_cBaseReds  = ""   && basereds char(1) S/N - Base Reduzida ICMS
    this_cIpis      = ""   && ipis char(1) S/N - flag IPI
    this_cSitRibs   = ""   && sitribs char(3) - Situacao Tributaria
    this_nBIcms     = 0    && bicms numeric(9,6) - percentual Base Reduzida ICMS
    this_nIndIVAST  = 0    && indivast numeric(7,3) - IVA-ST SP
    this_cIpiProds  = ""   && ipiprods char(1) S/N - IPI por produto
    this_nTipoMercs = 0    && tipoMercs numeric(2,0) - Codigo Tipo Mercadoria
    this_nTpSubSt   = 0    && TpSubSt numeric(1,0) - 1=IVA 2=Valor Determinado
    this_nBIcmss    = 0    && bicmss numeric(9,6) - Base Reduzida Substituicao
    this_nAliqFcp   = 0    && aliqfcp numeric(6,3) - Aliquota ICMS FCP
    this_cCest      = ""   && cest char(7) - CEST
    this_cUniTrib   = ""   && unitrib char(6) - Unidade Tributaria

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCLF"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos,    "C")
            THIS.this_cDescricao = TratarNulo(descricaos, "C")
            THIS.this_nAipi      = TratarNulo(aipis,      "N")
            THIS.this_cUnidade   = TratarNulo(unidades,   "C")
            THIS.this_cAliqReds  = TratarNulo(aliqreds,   "C")
            THIS.this_cBaseReds  = TratarNulo(basereds,   "C")
            THIS.this_cIpis      = TratarNulo(ipis,       "C")
            THIS.this_cSitRibs   = TratarNulo(sitribs,    "C")
            THIS.this_nBIcms     = TratarNulo(bicms,      "N")
            THIS.this_nIndIVAST  = TratarNulo(indivast,   "N")
            THIS.this_cIpiProds  = TratarNulo(ipiprods,   "C")
            THIS.this_nTipoMercs = TratarNulo(tipoMercs,  "N")
            THIS.this_nTpSubSt   = TratarNulo(TpSubSt,    "N")
            THIS.this_nBIcmss    = TratarNulo(bicmss,     "N")
            THIS.this_nAliqFcp   = TratarNulo(aliqfcp,    "N")
            THIS.this_cCest      = TratarNulo(cest,        "C")
            THIS.this_cUniTrib   = TratarNulo(unitrib,    "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SIGCDCLF
    * par_cFiltro: condicao WHERE adicional (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades, cest" + ;
                " FROM SIGCDCLF"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY codigos"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades," + ;
                " aliqreds, basereds, ipis, sitribs, bicms, indivast," + ;
                " ipiprods, tipoMercs, TpSubSt, bicmss, aliqfcp, cest, unitrib" + ;
                " FROM SIGCDCLF WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
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
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarIVAsPorCodigo - Carrega registros de sigcdiva para cursor local
    * Retorna cursor crIva readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarIVAsPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdiva WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpIva_4c")
            IF loc_nResultado >= 0
                IF USED("crIva")
                    SELECT crIva
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crIva ;
                        (cidchaves C(20), codigos C(10), estasO C(2), estasD C(2), ;
                         indivast N(7,3), indivastpi N(7,3), diasprz N(3,0))
                    SET NULL OFF
                ENDIF
                SELECT TmpIva_4c
                SCAN
                    SELECT crIva
                    APPEND BLANK
                    REPLACE codigos    WITH ALLTRIM(TmpIva_4c.codigos), ;
                            estasO     WITH ALLTRIM(TmpIva_4c.estaso), ;
                            estasD     WITH ALLTRIM(TmpIva_4c.estasd), ;
                            cidchaves  WITH ALLTRIM(TmpIva_4c.cidchaves), ;
                            indivast   WITH TmpIva_4c.indivast, ;
                            indivastpi WITH TmpIva_4c.indivastpi, ;
                            diasprz    WITH TmpIva_4c.diasprz
                ENDSCAN
                USE IN TmpIva_4c
                IF RECCOUNT("crIva") = 0
                    SELECT crIva
                    APPEND BLANK
                ENDIF
                SELECT crIva
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar IVAs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarIVAsPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpIva_4c")
                USE IN TmpIva_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarReducoesPorCodigo - Carrega registros de sigcdred para cursor local
    * Retorna cursor crRed readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarReducoesPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdred WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpRed_4c")
            IF loc_nResultado >= 0
                IF USED("crRed")
                    SELECT crRed
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crRed ;
                        (cidchaves C(20), codigos C(10), estas C(2), ;
                         areds N(6,3), breds N(6,3))
                    SET NULL OFF
                ENDIF
                SELECT TmpRed_4c
                SCAN
                    SELECT crRed
                    APPEND BLANK
                    REPLACE codigos   WITH ALLTRIM(TmpRed_4c.codigos), ;
                            estas     WITH ALLTRIM(TmpRed_4c.estas), ;
                            cidchaves WITH ALLTRIM(TmpRed_4c.cidchaves), ;
                            areds     WITH TmpRed_4c.areds, ;
                            breds     WITH TmpRed_4c.breds
                ENDSCAN
                USE IN TmpRed_4c
                SELECT crRed
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar Redu" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarReducoesPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpRed_4c")
                USE IN TmpRed_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Validar()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND (THIS.this_nAliqFcp < 0 OR THIS.this_nAliqFcp > 2)
            MsgAviso("Valor da Al" + CHR(237) + "quota FCP Inv" + CHR(225) + "lida. Deve ser entre 0 e 2.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcms < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida ICMS inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcmss < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida Substitui" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicata - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDCLF WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtde > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicata:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChave
        loc_lResultado = .F.
        TRY
            IF THIS.VerificarDuplicata()
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCLF" + ;
                    " (codigos, descricaos, aipis, unidades, aliqreds, basereds," + ;
                    " ipis, sitribs, bicms, indivast, ipiprods, tipoMercs," + ;
                    " TpSubSt, bicmss, aliqfcp, cest, unitrib)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                    EscaparSQL(THIS.this_cDescricao) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAipi)      + ", " + ;
                    EscaparSQL(THIS.this_cUnidade)   + ", " + ;
                    EscaparSQL(THIS.this_cAliqReds)  + ", " + ;
                    EscaparSQL(THIS.this_cBaseReds)  + ", " + ;
                    EscaparSQL(THIS.this_cIpis)      + ", " + ;
                    EscaparSQL(THIS.this_cSitRibs)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcms)     + ", " + ;
                    FormatarNumeroSQL(THIS.this_nIndIVAST)  + ", " + ;
                    EscaparSQL(THIS.this_cIpiProds)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTipoMercs) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpSubSt)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcmss)    + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAliqFcp)   + ", " + ;
                    EscaparSQL(THIS.this_cCest)      + ", " + ;
                    EscaparSQL(THIS.this_cUniTrib)   + ")"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.SalvarIVAs(THIS.this_cCodigo)
                    THIS.SalvarReducoes(THIS.this_cCodigo)
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SIGCDCLF SET" + ;
                " descricaos = "  + EscaparSQL(THIS.this_cDescricao) + "," + ;
                " aipis = "       + FormatarNumeroSQL(THIS.this_nAipi)     + "," + ;
                " unidades = "    + EscaparSQL(THIS.this_cUnidade)   + "," + ;
                " aliqreds = "    + EscaparSQL(THIS.this_cAliqReds)  + "," + ;
                " basereds = "    + EscaparSQL(THIS.this_cBaseReds)  + "," + ;
                " ipis = "        + EscaparSQL(THIS.this_cIpis)      + "," + ;
                " sitribs = "     + EscaparSQL(THIS.this_cSitRibs)   + "," + ;
                " bicms = "       + FormatarNumeroSQL(THIS.this_nBIcms)    + "," + ;
                " indivast = "    + FormatarNumeroSQL(THIS.this_nIndIVAST) + "," + ;
                " ipiprods = "    + EscaparSQL(THIS.this_cIpiProds)  + "," + ;
                " tipoMercs = "   + FormatarNumeroSQL(THIS.this_nTipoMercs)+ "," + ;
                " TpSubSt = "     + FormatarNumeroSQL(THIS.this_nTpSubSt)  + "," + ;
                " bicmss = "      + FormatarNumeroSQL(THIS.this_nBIcmss)   + "," + ;
                " aliqfcp = "     + FormatarNumeroSQL(THIS.this_nAliqFcp)  + "," + ;
                " cest = "        + EscaparSQL(THIS.this_cCest)      + "," + ;
                " unitrib = "     + EscaparSQL(THIS.this_cUniTrib)   + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.SalvarIVAs(THIS.this_cCodigo)
                THIS.SalvarReducoes(THIS.this_cCodigo)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM SIGCDCLF WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarIVAs - Salva registros do cursor crIva em sigcdiva
    * Estrategia: DELETE todos os IVAs do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarIVAs(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crIva")
                SELECT crIva
                SCAN
                    IF !EMPTY(ALLTRIM(crIva.estasO)) OR !EMPTY(ALLTRIM(crIva.estasD))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdiva" + ;
                            " (cidchaves, codigos, estaso, estasd, indivast, indivastpi, diasprz)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)            + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))     + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasO))    + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasD))    + ", " + ;
                            FormatarNumeroSQL(crIva.indivast)    + ", " + ;
                            FormatarNumeroSQL(crIva.indivastpi)  + ", " + ;
                            FormatarNumeroSQL(crIva.diasprz)     + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar IVA:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarIVAs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarReducoes - Salva registros do cursor crRed em sigcdred
    * Estrategia: DELETE todas as reducoes do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarReducoes(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crRed")
                SELECT crRed
                SCAN
                    IF !EMPTY(ALLTRIM(crRed.estas))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdred" + ;
                            " (cidchaves, codigos, estas, areds, breds)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)         + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))  + ", " + ;
                            EscaparSQL(ALLTRIM(crRed.estas))  + ", " + ;
                            FormatarNumeroSQL(crRed.areds)    + ", " + ;
                            FormatarNumeroSQL(crRed.breds)    + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar Redu" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarReducoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTemProduto - Verifica se existem produtos com aliquota IPI
    * Retorna .T. se ha produtos com IPI associados a este codigo
    *--------------------------------------------------------------------------
    FUNCTION VerificarTemProduto(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lTem
        loc_lTem = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SigCdPro" + ;
                " WHERE clfiscals = " + EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmPro")
                TABLEREVERT(.T., "cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmPro")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_TmPro") > 0
                SELECT cursor_4c_TmPro
                loc_lTem = (cursor_4c_TmPro.qtde > 0)
            ENDIF
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.VerificarTemProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        ENDTRY
        RETURN loc_lTem
    ENDFUNC

ENDDEFINE
