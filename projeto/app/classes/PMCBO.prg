*==============================================================================
* PMCBO.prg - Business Object: Tabela de Promo??es por Per?odo
* Tabela: SigCdPmc (PK: codigo)
* Schema:
*   codigo   char(10)     PK  auto-gerado PMC+AAMM+SEQ
*   cpros    char(14)     FK SigCdPro.CPros
*   tppro    numeric(2,0) tipo (1=Brinde)
*   dtini    datetime     data inicial
*   dtfin    datetime     data final
*   valmin   numeric(9,2) valor minimo
*   usualts  char(10)     usuario ultima alteracao
*   dtalts   datetime     data/hora ultima alteracao
*==============================================================================
DEFINE CLASS PMCBO AS BusinessBase

    *-- Chave prim?ria
    this_cCodigo   = ""

    *-- Produto (FK SigCdPro.CPros)
    this_cCpros    = ""

    *-- Tipo de promo??o: 1=Brinde
    this_nTppro    = 0

    *-- Per?odo de vig?ncia
    this_tDtini    = {}
    this_tDtfin    = {}

    *-- Valor m?nimo da venda para conceder o brinde
    this_nValmin   = 0

    *-- Auditoria
    this_cUsualts  = ""
    this_tDtalts   = {}

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPmc"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "")
            THIS.this_cCpros    = TratarNulo(cpros,    "")
            THIS.this_nTppro    = TratarNulo(tppro,    0)
            THIS.this_tDtini    = TratarNulo(dtini,    {})
            THIS.this_tDtfin    = TratarNulo(dtfin,    {})
            THIS.this_nValmin   = TratarNulo(valmin,   0)
            THIS.this_cUsualts  = TratarNulo(usualts,  "")
            THIS.this_tDtalts   = TratarNulo(dtalts,   {})
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condi??o SQL adicional (sem WHERE), ou "" para todos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + loc_cWhere + ;
                       " ORDER BY codigo"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo??es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Buscar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo c?digo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.CarregarPorCodigo:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera c?digo auto no formato PMC+AAMM+SEQ (ex: PMC2608001)
    * Replica l?gica original: 'PMC'+SUBSTR(STR(YEAR),3)+PADL(MONTH,2,'0')+SEQ
    *==========================================================================
    PROCEDURE GerarCodigo()
    *==========================================================================
        LOCAL loc_cPrefixo, loc_cSQL, loc_nResult, loc_cCodigo, loc_nSeq, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCodigo  = ""

        TRY
            loc_cPrefixo = "PMC" + SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                           PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                       " WHERE codigo LIKE " + EscaparSQL(loc_cPrefixo + "%")

            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")

            IF loc_nResult >= 0
                SELECT cursor_4c_Seq
                loc_nSeq    = cursor_4c_Seq.qtd + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
                USE IN cursor_4c_Seq
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao gerar c?digo PMC:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_Seq")
                    USE IN cursor_4c_Seq
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.GerarCodigo:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.this_cCodigo = loc_cCodigo
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDtIniFim - Valida que dtini <= dtfin e que o per?odo n?o existe
    * Retorna "" se OK, ou mensagem de erro
    *==========================================================================
    PROCEDURE ValidarPeriodo()
    *==========================================================================
        LOCAL loc_cMsg, loc_cSQL, loc_nResult, loc_cDtIni, loc_cDtFin, loc_lSucesso
        loc_cMsg     = ""
        loc_lSucesso = .T.

        TRY
            *-- Validar campos obrigat?rios
            IF EMPTY(THIS.this_cCpros)
                loc_lSucesso = "Produto n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtini)
                loc_lSucesso = "Data Inicial n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtfin)
                loc_lSucesso = "Data final n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF THIS.this_tDtini > THIS.this_tDtfin
                loc_lSucesso = "As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!"
            ENDIF

            *-- Verificar sobreposi??o de per?odo para o mesmo produto (s? no INSERT)
            IF THIS.this_lNovoRegistro
                loc_cDtIni = FormatarDataSQL(THIS.this_tDtini)
                loc_cDtFin = FormatarDataSQL(THIS.this_tDtfin)

                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                           " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                           " AND (" + ;
                           "  " + loc_cDtIni + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           " OR " + ;
                           "  " + loc_cDtFin + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           ")"

                IF USED("cursor_4c_Val")
                    USE IN cursor_4c_Val
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Val")

                IF loc_nResult >= 0
                    SELECT cursor_4c_Val
                    IF cursor_4c_Val.qtd > 0
                        loc_cMsg = "Esse intervalo j" + CHR(225) + " est" + CHR(225) + ;
                                   " cadastrado para esse produto!"
                    ENDIF
                    USE IN cursor_4c_Val
                ELSE
                    MsgErro("Erro ao validar per?odo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    IF USED("cursor_4c_Val")
                        USE IN cursor_4c_Val
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ValidarPeriodo:" + CHR(13) + loException.Message, "Erro")
            loc_cMsg = "Erro interno ao validar per?odo."
        ENDTRY

        RETURN loc_cMsg
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPmc" + ;
                       " (codigo, cpros, tppro, dtini, dtfin, valmin, usualts, dtalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)            + ", " + ;
                       EscaparSQL(THIS.this_cCpros)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTppro)       + ", " + ;
                       FormatarDataSQL(THIS.this_tDtini)         + ", " + ;
                       FormatarDataSQL(THIS.this_tDtfin)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmin)      + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)           + ", " + ;
                       FormatarDataSQL(THIS.this_tDtalts)        + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Inserir:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPmc SET" + ;
                       " cpros   = " + EscaparSQL(THIS.this_cCpros)          + ", " + ;
                       " tppro   = " + FormatarNumeroSQL(THIS.this_nTppro)   + ", " + ;
                       " dtini   = " + FormatarDataSQL(THIS.this_tDtini)     + ", " + ;
                       " dtfin   = " + FormatarDataSQL(THIS.this_tDtfin)     + ", " + ;
                       " valmin  = " + FormatarNumeroSQL(THIS.this_nValmin)  + ", " + ;
                       " usualts = " + EscaparSQL(THIS.this_cUsualts)        + ", " + ;
                       " dtalts  = " + FormatarDataSQL(THIS.this_tDtalts)    + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Atualizar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPmc WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ExecutarExclusao:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
