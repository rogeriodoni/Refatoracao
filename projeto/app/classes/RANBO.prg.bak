*====================================================================
* RANBO.prg - Business Object para Registro de Analises
* Migrado de: SIGCDRAN.SCX (frmcadastro)
* Tabela: SigInAna
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RANBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigInAna)
    this_nCodigos    = 0    && codigos   numeric(6,0) NOT NULL - PK auto-gerado
    this_nCodtpans   = 0    && codtpans  numeric(2,0) NOT NULL - tipo analise
    this_dDatas      = {}   && datas     datetime NULL
    this_dDtamosts   = {}   && dtamosts  datetime NULL
    this_cEmps       = ""   && emps      char(3)     NOT NULL
    this_cFases      = ""   && fases     char(10)    NOT NULL
    this_nNfunds     = 0    && nfunds    numeric(6,0) NOT NULL
    this_nNlaudos    = 0    && nlaudos   numeric(6,0) NOT NULL
    this_nNlotes     = 0    && nlotes    numeric(10,0) NOT NULL
    this_nNops       = 0    && nops      numeric(10,0) NOT NULL
    this_nPesamosts  = 0    && pesamosts numeric(8,2) NOT NULL
    this_cResps      = ""   && resps     char(10)    NOT NULL

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigInAna"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * GerarProximoCodigo - Gera proximo codigo disponivel (global, sem filtro emps)
    *====================================================================
    PROCEDURE GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResultado, loc_nProximo
        loc_nProximo = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS proximo FROM SigInAna"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ProxCod")
                SELECT cursor_4c_ProxCod
                loc_nProximo = NVL(cursor_4c_ProxCod.proximo, 1)
                USE IN cursor_4c_ProxCod
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.GerarProximoCodigo")
        ENDTRY

        RETURN loc_nProximo
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos   = TratarNulo(codigos,   0)
                THIS.this_nCodtpans  = TratarNulo(codtpans,  0)
                THIS.this_dDatas     = TratarNulo(datas,     {})
                THIS.this_dDtamosts  = TratarNulo(dtamosts,  {})
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cFases     = TratarNulo(fases,     "")
                THIS.this_nNfunds    = TratarNulo(nfunds,    0)
                THIS.this_nNlaudos   = TratarNulo(nlaudos,   0)
                THIS.this_nNlotes    = TratarNulo(nlotes,    0)
                THIS.this_nNops      = TratarNulo(nops,      0)
                THIS.this_nPesamosts = TratarNulo(pesamosts, 0)
                THIS.this_cResps     = TratarNulo(resps,     "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_dDatas)
            MsgAviso("Data inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigInAna
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigInAna
                    (codigos, codtpans, datas, dtamosts, emps, fases, nfunds, nlaudos, nlotes, nops, pesamosts, resps)
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nCodigos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodtpans, 0)>>,
                    <<IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas))>>,
                    <<IIF(EMPTY(THIS.this_dDtamosts), "NULL", FormatarDataSQL(THIS.this_dDtamosts))>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cFases)>>,
                    <<FormatarNumeroSQL(THIS.this_nNfunds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNlaudos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNops, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesamosts, 2)>>,
                    <<EscaparSQL(THIS.this_cResps)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigInAna
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigInAna
                SET codtpans  = <<FormatarNumeroSQL(THIS.this_nCodtpans, 0)>>,
                    datas     = <<IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas))>>,
                    dtamosts  = <<IIF(EMPTY(THIS.this_dDtamosts), "NULL", FormatarDataSQL(THIS.this_dDtamosts))>>,
                    fases     = <<EscaparSQL(THIS.this_cFases)>>,
                    nfunds    = <<FormatarNumeroSQL(THIS.this_nNfunds, 0)>>,
                    nlaudos   = <<FormatarNumeroSQL(THIS.this_nNlaudos, 0)>>,
                    nlotes    = <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    nops      = <<FormatarNumeroSQL(THIS.this_nNops, 0)>>,
                    pesamosts = <<FormatarNumeroSQL(THIS.this_nPesamosts, 2)>>,
                    resps     = <<EscaparSQL(THIS.this_cResps)>>
                WHERE codigos = <<FormatarNumeroSQL(THIS.this_nCodigos, 0)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigInAna
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigInAna" + ;
                " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, datas, resps, codtpans, nlaudos
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos N(6,0), datas T, resps C(10), codtpans N(2,0), nlaudos N(6,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, datas, resps, codtpans, nlaudos FROM SigInAna" + ;
                    " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar an" + CHR(225) + "lises:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar an" + CHR(225) + "lises:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, codtpans, datas, dtamosts, emps, fases," + ;
                " nfunds, nlaudos, nlotes, nops, pesamosts, resps" + ;
                " FROM SigInAna" + ;
                " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("An" + CHR(225) + "lise n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar an" + CHR(225) + "lise:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "RANBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
