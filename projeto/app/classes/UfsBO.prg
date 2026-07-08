*==============================================================================
* UfsBO.prg - Business Object para Cadastro de Estados (UFs)
* Tabela: SigCdUfs
* Chave: estados (char 2)
* Migrado de: SigCdUfs.SCX (SIGCDUFD)
*==============================================================================

DEFINE CLASS UfsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos da tabela SigCdUfs
    *--------------------------------------------------------------------------

    *-- Identificacao (PK)
    this_cEstados                  = ""   && estados CHAR(2) - PK
    this_cDescrs                   = ""   && descrs CHAR(40)

    *-- Aliquotas ICMS
    this_nAicms                    = 0    && aicms NUMERIC(9,2) - Aliquota ICMS
    this_nBicms                    = 0    && bicms NUMERIC(9,2) - Base ICMS Reduzida
    this_nAreduzidas               = 0    && areduzidas NUMERIC(9,2) - Aliquota Reduzida
    this_nAliqsbs                  = 0    && aliqsbs NUMERIC(9,2) - Aliquota Local Substituicao Tributaria

    *-- IPI / Codigo IBGE / Layout NFCe
    this_cIpis                     = ""   && ipis CHAR(1) - T=Tributado I=Isento O=Outros
    this_nUFIBGEs                  = 0    && UFIBGEs NUMERIC(2,0) - Codigo IBGE
    this_cLayoutnf                 = ""   && layoutnf CHAR(20) - Layout NFCe
    this_nChkgnre                  = 0    && chkgnre NUMERIC(1,0)
    this_nNcotepe52s               = 0    && ncotepe52s INT - CAT 52

    *-- Chaves NF-e
    this_cChaveConsultaHomologacao = ""   && ChaveConsultaHomologacao CHAR(80)
    this_cChaveConsultaProducao    = ""   && ChaveConsultaProducao CHAR(80)
    this_cHomologacao              = ""   && Homologacao CHAR(80)
    this_cProducao                 = ""   && Producao CHAR(80)

    *-- Sintegra - flags NUMERIC(1,0)
    this_nGer50                    = 0    && ger50  - Tipo 50 Nota Fiscal (Modelos 1,1A,4,6,21,22)
    this_nGer51                    = 0    && ger51  - Tipo 51 Nota Fiscal de IPI (Modelo 1 e 1A)
    this_nGer53                    = 0    && ger53  - Tipo 53 Registro de Substituicao Tributaria
    this_nGer54                    = 0    && ger54  - Tipo 54 Registro de Produtos das Notas Fiscais
    this_nGer60                    = 0    && ger60  - Tipo 60 Notas Emitidas Por EFC/PDV
    this_nGer60D                   = 0    && ger60d - Tipo 60 (D) Resumo Diario dos Cupons
    this_nGer60I                   = 0    && ger60i - Tipo 60 (I) Itens dos Cupons
    this_nGer60R                   = 0    && ger60r - Tipo 60 (R) Resumo Mensal dos Cupons
    this_nGer60P                   = 0    && ger60p - Tipo 60 (P) Condicoes de Pagamento
    this_nGer61                    = 0    && ger61  - Tipo 61 Nota Fiscal (Modelos 14,15,16,13,2,4)
    this_nGer70                    = 0    && ger70  - Tipo 70 Notas e Conhecimentos de Transportes
    this_nGer74                    = 0    && ger74  - Tipo 74 Inventario
    this_nGer75                    = 0    && ger75  - Tipo 75 Produtos
    this_nGer77                    = 0    && ger77  - Tipo 77 Objetos Para Transportadora
    this_nGer88                    = 0    && ger88  - Tipo 88 Apuracao de ICMS - GIM para PB
    this_nGer88ms                  = 0    && ger88ms - Tipo 88 MS
    this_nGerSefaz                 = 0    && gersefaz - Tipos (16,17,18,19) Selos Para Sefaz
    this_nGerncm                   = 0    && gerncm - Usar barrar no NCM
    this_nCodidents                = 0    && codidents - Usar Codigo de Identidade dos Produtos
    this_nNgersufr1s               = 0    && ngersufr1s INT - sem uso

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUfs"
            THIS.this_cCampoChave = "estados"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEstados
    ENDFUNC

    *==========================================================================
    * Buscar - Seleciona registros com filtro opcional (PUBLIC)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE UPPER(estados) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    ") OR UPPER(descrs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas," + ;
                " aliqsbs, ipis, UFIBGEs, layoutnf," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s" + ;
                " FROM SigCdUfs" + loc_cWhere + ;
                " ORDER BY estados"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar estados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (estado) (PUBLIC)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cEstados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas," + ;
                " aliqsbs, ipis, UFIBGEs, layoutnf," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s," + ;
                " chkgnre, ChaveConsultaHomologacao, ChaveConsultaProducao," + ;
                " Homologacao, Producao" + ;
                " FROM SigCdUfs" + ;
                " WHERE estados = " + EscaparSQL(par_cEstados)

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
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades do BO a partir de cursor (PUBLIC)
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEstados                  = TratarNulo(estados,                   "C")
                THIS.this_cDescrs                   = TratarNulo(descrs,                    "C")
                THIS.this_nAicms                    = TratarNulo(aicms,                     "N")
                THIS.this_nBicms                    = TratarNulo(bicms,                     "N")
                THIS.this_nAreduzidas               = TratarNulo(areduzidas,                "N")
                THIS.this_nAliqsbs                  = TratarNulo(aliqsbs,                   "N")
                THIS.this_cIpis                     = TratarNulo(ipis,                      "C")
                THIS.this_nUFIBGEs                  = TratarNulo(UFIBGEs,                   "N")
                THIS.this_cLayoutnf                 = TratarNulo(layoutnf,                  "C")
                THIS.this_nGer50                    = TratarNulo(ger50,                     "N")
                THIS.this_nGer51                    = TratarNulo(ger51,                     "N")
                THIS.this_nGer53                    = TratarNulo(ger53,                     "N")
                THIS.this_nGer54                    = TratarNulo(ger54,                     "N")
                THIS.this_nGer60                    = TratarNulo(ger60,                     "N")
                THIS.this_nGer60D                   = TratarNulo(ger60d,                    "N")
                THIS.this_nGer60I                   = TratarNulo(ger60i,                    "N")
                THIS.this_nGer60R                   = TratarNulo(ger60r,                    "N")
                THIS.this_nGer60P                   = TratarNulo(ger60p,                    "N")
                THIS.this_nGer61                    = TratarNulo(ger61,                     "N")
                THIS.this_nGer70                    = TratarNulo(ger70,                     "N")
                THIS.this_nGer74                    = TratarNulo(ger74,                     "N")
                THIS.this_nGer75                    = TratarNulo(ger75,                     "N")
                THIS.this_nGer77                    = TratarNulo(ger77,                     "N")
                THIS.this_nGer88                    = TratarNulo(ger88,                     "N")
                THIS.this_nGer88ms                  = TratarNulo(ger88ms,                   "N")
                THIS.this_nGerSefaz                 = TratarNulo(gersefaz,                  "N")
                THIS.this_nGerncm                   = TratarNulo(gerncm,                    "N")
                THIS.this_nCodidents                = TratarNulo(codidents,                 "N")
                THIS.this_nNgersufr1s               = TratarNulo(ngersufr1s,                "N")
                THIS.this_nNcotepe52s               = TratarNulo(ncotepe52s,                "N")

                *-- Campos opcionais (apenas no CarregarPorCodigo completo)
                IF TYPE(par_cAliasCursor + ".chkgnre") != "U"
                    THIS.this_nChkgnre              = TratarNulo(chkgnre,                   "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".ChaveConsultaHomologacao") != "U"
                    THIS.this_cChaveConsultaHomologacao = TratarNulo(ChaveConsultaHomologacao, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".ChaveConsultaProducao") != "U"
                    THIS.this_cChaveConsultaProducao    = TratarNulo(ChaveConsultaProducao,    "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Homologacao") != "U"
                    THIS.this_cHomologacao              = TratarNulo(Homologacao,              "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Producao") != "U"
                    THIS.this_cProducao                 = TratarNulo(Producao,                 "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdUfs (" + ;
                "estados, descrs, aicms, bicms, areduzidas, aliqsbs, ipis," + ;
                " UFIBGEs, layoutnf, chkgnre," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s," + ;
                " ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cEstados) + ", " + ;
                EscaparSQL(THIS.this_cDescrs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAicms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBicms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAreduzidas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqsbs) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUFIBGEs) + ", " + ;
                EscaparSQL(THIS.this_cLayoutnf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkgnre) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer50) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer51) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer53) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer54) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60D) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60I) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60R) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60P) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer61) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer70) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer74) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer75) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer77) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer88) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer88ms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerSefaz) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerncm) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodidents) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNgersufr1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcotepe52s) + ", " + ;
                EscaparSQL(THIS.this_cChaveConsultaHomologacao) + ", " + ;
                EscaparSQL(THIS.this_cChaveConsultaProducao) + ", " + ;
                EscaparSQL(THIS.this_cHomologacao) + ", " + ;
                EscaparSQL(THIS.this_cProducao) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdUfs SET" + ;
                " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                " aicms = " + FormatarNumeroSQL(THIS.this_nAicms) + "," + ;
                " bicms = " + FormatarNumeroSQL(THIS.this_nBicms) + "," + ;
                " areduzidas = " + FormatarNumeroSQL(THIS.this_nAreduzidas) + "," + ;
                " aliqsbs = " + FormatarNumeroSQL(THIS.this_nAliqsbs) + "," + ;
                " ipis = " + EscaparSQL(THIS.this_cIpis) + "," + ;
                " UFIBGEs = " + FormatarNumeroSQL(THIS.this_nUFIBGEs) + "," + ;
                " layoutnf = " + EscaparSQL(THIS.this_cLayoutnf) + "," + ;
                " chkgnre = " + FormatarNumeroSQL(THIS.this_nChkgnre) + "," + ;
                " ger50 = " + FormatarNumeroSQL(THIS.this_nGer50) + "," + ;
                " ger51 = " + FormatarNumeroSQL(THIS.this_nGer51) + "," + ;
                " ger53 = " + FormatarNumeroSQL(THIS.this_nGer53) + "," + ;
                " ger54 = " + FormatarNumeroSQL(THIS.this_nGer54) + "," + ;
                " ger60 = " + FormatarNumeroSQL(THIS.this_nGer60) + "," + ;
                " ger60d = " + FormatarNumeroSQL(THIS.this_nGer60D) + "," + ;
                " ger60i = " + FormatarNumeroSQL(THIS.this_nGer60I) + "," + ;
                " ger60r = " + FormatarNumeroSQL(THIS.this_nGer60R) + "," + ;
                " ger60p = " + FormatarNumeroSQL(THIS.this_nGer60P) + "," + ;
                " ger61 = " + FormatarNumeroSQL(THIS.this_nGer61) + "," + ;
                " ger70 = " + FormatarNumeroSQL(THIS.this_nGer70) + "," + ;
                " ger74 = " + FormatarNumeroSQL(THIS.this_nGer74) + "," + ;
                " ger75 = " + FormatarNumeroSQL(THIS.this_nGer75) + "," + ;
                " ger77 = " + FormatarNumeroSQL(THIS.this_nGer77) + "," + ;
                " ger88 = " + FormatarNumeroSQL(THIS.this_nGer88) + "," + ;
                " ger88ms = " + FormatarNumeroSQL(THIS.this_nGer88ms) + "," + ;
                " gersefaz = " + FormatarNumeroSQL(THIS.this_nGerSefaz) + "," + ;
                " gerncm = " + FormatarNumeroSQL(THIS.this_nGerncm) + "," + ;
                " codidents = " + FormatarNumeroSQL(THIS.this_nCodidents) + "," + ;
                " ngersufr1s = " + FormatarNumeroSQL(THIS.this_nNgersufr1s) + "," + ;
                " ncotepe52s = " + FormatarNumeroSQL(THIS.this_nNcotepe52s) + "," + ;
                " ChaveConsultaHomologacao = " + EscaparSQL(THIS.this_cChaveConsultaHomologacao) + "," + ;
                " ChaveConsultaProducao = " + EscaparSQL(THIS.this_cChaveConsultaProducao) + "," + ;
                " Homologacao = " + EscaparSQL(THIS.this_cHomologacao) + "," + ;
                " Producao = " + EscaparSQL(THIS.this_cProducao) + ;
                " WHERE estados = " + EscaparSQL(THIS.this_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdUfs WHERE estados = " + ;
                EscaparSQL(THIS.this_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
