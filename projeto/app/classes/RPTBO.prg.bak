*==============================================================================
* RPTBO.prg - Business Object - Cadastro Customizado de Relatorios 4Report
* Tabelas: SIGCDRLC (cabecalho), SIGCDRLD (detalhes FRX)
* Fase 1/8 - Propriedades e Init basico
*==============================================================================
DEFINE CLASS RPTBO AS BusinessBase

    *-- Cabecalho do Relatorio (SIGCDRLC)
    this_cRPT_ID         = ""   && RPT_ID - Chave primaria (DTOS+STRTRAN(TIME))
    this_cNmReport       = ""   && NmReport - Nome do arquivo do report
    this_cDescr          = ""   && Descr - Descricao do report
    this_dDtCriacao      = {}   && dtcad - Data de criacao
    this_dDtAlteracao    = {}   && dtmodif - Data de alteracao
    this_lAtivo          = .T.  && Ativo - Indicador ativo (default ligado)
    this_cSqlQuery       = ""   && SqlQuery - Query SQL do report

    *-- Parametros de Layout do Relatorio (Page2 do formulario)
    this_nOrientacao     = 1    && 1=Retrato, 2=Paisagem
    this_nTamPapel       = 1    && Indice do tamanho de papel no ComboBox

    *-- Controle interno
    this_cArqReport      = ""   && Caminho fisico do arquivo FRX gerado
    this_cDirTmp         = ""   && Diretorio temporario para arquivos FRX

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDRLC"
            THIS.this_cCampoChave = "RPT_ID"
            THIS.this_cDirTmp     = ".\Tmp\"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RPTBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRPT_ID)
    ENDFUNC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cRPT_ID      = ""
        THIS.this_cNmReport    = ""
        THIS.this_cDescr       = ""
        THIS.this_dDtCriacao   = {}
        THIS.this_dDtAlteracao = {}
        THIS.this_lAtivo       = .T.
        THIS.this_cSqlQuery    = ""
        THIS.this_nOrientacao  = 1
        THIS.this_nTamPapel    = 1
        THIS.this_cArqReport   = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRPT_ID      = TratarNulo(RPT_ID,      "C")
                THIS.this_cNmReport    = TratarNulo(NmReport,     "C")
                THIS.this_cDescr       = TratarNulo(Descr,        "C")
                THIS.this_lAtivo       = (TratarNulo(Ativo, "N") = 1)
                THIS.this_cSqlQuery    = TratarNulo(SqlQuery,     "C")
                IF PEMSTATUS(ALIAS(), "dtcad",   5)
                    THIS.this_dDtCriacao   = TratarNulo(dtcad,   "D")
                ENDIF
                IF PEMSTATUS(ALIAS(), "dtmodif", 5)
                    THIS.this_dDtAlteracao = TratarNulo(dtmodif, "D")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RPTBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Obrigat" + CHR(243) + "rio informar o Nome do Report.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Obrigat" + CHR(243) + "rio informar o SQL do Report.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * GerarRPT_ID - Gera chave RPT_ID no formato YYYYMMDD_HHMMSS
    * Padrao legado: DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    *==========================================================================
    PROTECTED FUNCTION GerarRPT_ID()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SIGCDRLC
    * RPT_ID gerado como YYYYMMDD_HHMMSS
    * dtcad e dtmodif preenchidos com data atual
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo, loc_cDataHoje
        loc_lSucesso = .F.

        TRY
            THIS.this_cRPT_ID = THIS.GerarRPT_ID()
            loc_cAtivo        = IIF(THIS.this_lAtivo, "1", "0")
            loc_cDataHoje     = FormatarDataSQL(DATE())

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                " (rpt_id, nmreport, ativo, descr, dtcad, dtmodif, sqlquery)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cRPT_ID)            + ", " + ;
                EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + ", " + ;
                loc_cAtivo                               + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescr))    + ", " + ;
                loc_cDataHoje                            + ", " + ;
                loc_cDataHoje                            + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cSqlQuery)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RPTBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SIGCDRLC
    * dtmodif atualizado com data atual
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo
        loc_lSucesso = .F.

        TRY
            loc_cAtivo = IIF(THIS.this_lAtivo, "1", "0")

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                " NmReport     = " + EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + "," + ;
                " Ativo        = " + loc_cAtivo + "," + ;
                " Descr        = " + EscaparSQL(ALLTRIM(THIS.this_cDescr)) + "," + ;
                " dtmodif      = " + FormatarDataSQL(DATE()) + "," + ;
                " SqlQuery     = " + EscaparSQL(ALLTRIM(THIS.this_cSqlQuery)) + ;
                " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RPTBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de SIGCDRLD (detalhes FRX) e SIGCDRLC
    * Ordem obrigatoria: detalhes primeiro, cabecalho depois (FK)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + ;
                EscaparSQL(THIS.this_cRPT_ID)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + ;
                EscaparSQL(THIS.this_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RPTBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca lista de reports (exibe no grid da Page1)
    * Cursor: cursor_4c_Dados com RPT_ID, NmReport, Descr, Ativo, dtcad, dtmodif
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        RPT_ID       C(20), ;
                        NmReport     C(100), ;
                        Descr        C(200), ;
                        Ativo        N(1,0), ;
                        dtcad        T,      ;
                        dtmodif      T       ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, dtcad, dtmodif" + ;
                    " FROM SIGCDRLC"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY NmReport"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar reports:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RPTBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo RPT_ID (inclui SqlQuery)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cRPT_ID)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, dtcad, dtmodif, sqlquery" + ;
                " FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(par_cRPT_ID)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar report:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "RPTBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
