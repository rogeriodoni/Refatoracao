*==============================================================================
* SigPrPpcBO.prg - Business Object - Produtos Por Conta
* Form OPERACIONAL: coleta filtros e consulta SigMvCab
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS SigPrPpcBO AS BusinessBase

    *-- Filtros de consulta - Grupo contabil (SigCdGcr)
    this_cGrupo       = ""
    this_cDGrupo      = ""

    *-- Filtros de consulta - Conta/Cliente (SigCdCli)
    this_cConta       = ""
    this_cContaDesc   = ""

    *-- Filtros de consulta - Operacao (SigCdOpe)
    this_cOperacao    = ""

    *-- Filtros de consulta - Periodo
    this_dInicial     = {}
    this_dFinal       = {}

    *-- Filtros de consulta - Empresa (SigCdEmp)
    this_cEmpresa     = ""
    this_cEmpresaDesc = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "Numes"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form OPERACIONAL nao tem chave primaria singular
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_cEmpresa) + TRANSFORM(THIS.this_cOperacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Verifica se grupo existe em SigCdGcr; popula this_cDGrupo
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupo(par_cGrupo)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(ALLTRIM(par_cGrupo))
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
            IF loc_nResult > 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
                SELECT cursor_4c_GcrVal
                THIS.this_cDGrupo = ALLTRIM(descrs)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarConta - Verifica se conta/cliente existe em SigCdCli; popula this_cContaDesc
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarConta(par_cConta)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                       EscaparSQL(ALLTRIM(par_cConta))
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
            IF loc_nResult > 0 AND USED("cursor_4c_CliVal") AND RECCOUNT("cursor_4c_CliVal") > 0
                SELECT cursor_4c_CliVal
                THIS.this_cContaDesc = ALLTRIM(RClis)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Verifica se operacao existe em SigCdOpe
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarOperacao(par_cOperacao)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao))
            IF USED("cursor_4c_OpeVal")
                USE IN cursor_4c_OpeVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
            IF loc_nResult > 0 AND USED("cursor_4c_OpeVal") AND RECCOUNT("cursor_4c_OpeVal") > 0
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_OpeVal")
                USE IN cursor_4c_OpeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Verifica se empresa existe em SigCdEmp; popula this_cEmpresaDesc
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarEmpresa(par_cEmpresa)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa))
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND RECCOUNT("cursor_4c_EmpVal") > 0
                SELECT cursor_4c_EmpVal
                THIS.this_cEmpresaDesc = ALLTRIM(Razas)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida todos os filtros obrigatorios
    * Retorna "" se tudo valido, ou mensagem de erro descritiva
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        LOCAL loc_cErro
        loc_cErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            RETURN "Grupo inv" + CHR(225) + "lido. Informe um grupo cont" + CHR(225) + "bil."
        ENDIF

        IF !THIS.ValidarGrupo(THIS.this_cGrupo)
            RETURN "Grupo " + CHR(34) + ALLTRIM(THIS.this_cGrupo) + CHR(34) + ;
                   " n" + CHR(227) + "o encontrado em SigCdGcr."
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cConta))
            RETURN "Conta inv" + CHR(225) + "lida. Informe uma conta."
        ENDIF

        IF !THIS.ValidarConta(THIS.this_cConta)
            RETURN "Conta " + CHR(34) + ALLTRIM(THIS.this_cConta) + CHR(34) + ;
                   " n" + CHR(227) + "o encontrada em SigCdCli."
        ENDIF

        IF EMPTY(THIS.this_dInicial)
            RETURN "Data inicial inv" + CHR(225) + "lida."
        ENDIF

        IF EMPTY(THIS.this_dFinal)
            RETURN "Data final inv" + CHR(225) + "lida."
        ENDIF

        IF THIS.this_dInicial > THIS.this_dFinal
            RETURN "Data inicial maior do que a data final."
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
            IF !THIS.ValidarOperacao(THIS.this_cOperacao)
                RETURN "Opera" + CHR(231) + CHR(227) + "o " + CHR(34) + ;
                       ALLTRIM(THIS.this_cOperacao) + CHR(34) + " n" + CHR(227) + "o encontrada."
            ENDIF
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
            IF !THIS.ValidarEmpresa(THIS.this_cEmpresa)
                RETURN "Empresa " + CHR(34) + ALLTRIM(THIS.this_cEmpresa) + CHR(34) + ;
                       " n" + CHR(227) + "o encontrada em SigCdEmp."
            ENDIF
        ENDIF

        RETURN loc_cErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarMovimentacoes - Executa consulta em SigMvCab com os filtros
    * Popula cursor TprMvCab (nome mantido para compatibilidade com SigPrPpp)
    * Retorna qtd de registros encontrados, ou -1 em erro de SQL
    *--------------------------------------------------------------------------
    FUNCTION ConsultarMovimentacoes()
        LOCAL loc_nResultado, loc_cWhere, loc_cSQL, loc_oErro
        LOCAL loc_cDtIniBase, loc_cDtFimBase, loc_cDtIniStr, loc_cDtFimStr
        loc_nResultado = -1
        TRY
            *-- Formata datas: inicio 00:00:00, fim 23:59:59
            loc_cDtIniBase = DTOS(THIS.this_dInicial)
            loc_cDtFimBase = DTOS(THIS.this_dFinal)
            loc_cDtIniStr  = "'" + SUBSTR(loc_cDtIniBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtIniBase,5,2) + "-" + SUBSTR(loc_cDtIniBase,7,2) + "'"
            loc_cDtFimStr  = "'" + SUBSTR(loc_cDtFimBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtFimBase,5,2) + "-" + SUBSTR(loc_cDtFimBase,7,2) + ;
                              " 23:59:59'"

            *-- Monta clausula WHERE adicional com filtros opcionais
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                loc_cWhere = loc_cWhere + ;
                    " AND GrupoDs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + ;
                    " AND ContaDs = " + EscaparSQL(ALLTRIM(THIS.this_cConta))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                loc_cWhere = loc_cWhere + " AND Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cOperacao))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                loc_cWhere = loc_cWhere + " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            ENDIF

            loc_cSQL = "SELECT * FROM SigMvCab" + ;
                       " WHERE Datas BETWEEN " + loc_cDtIniStr + " AND " + loc_cDtFimStr + ;
                       loc_cWhere + ;
                       " ORDER BY Emps, Dopes, Numes"

            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TprMvCab")

            IF loc_nResultado <= 0
                loc_nResultado = 0
            ELSE
                loc_nResultado = RECCOUNT("TprMvCab")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY
        RETURN loc_nResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de filtros para as props do BO
    * Cursor esperado: crSigTempC (SigTempC) ou similar com colunas de filtro
    * Campos opcionais - so mapeia os que existirem no cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE(par_cAliasCursor + ".cliente") != "U"
                    THIS.this_cConta = TratarNulo(cliente, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dcliente") != "U"
                    THIS.this_cContaDesc = TratarNulo(dcliente, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".operacao") != "U"
                    THIS.this_cOperacao = TratarNulo(operacao, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".datai") != "U"
                    THIS.this_dInicial = TratarNulo(datai, "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dataf") != "U"
                    THIS.this_dFinal = TratarNulo(dataf, "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".empresa") != "U"
                    THIS.this_cEmpresa = TratarNulo(empresa, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dempresa") != "U"
                    THIS.this_cEmpresaDesc = TratarNulo(dempresa, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".grupo") != "U"
                    THIS.this_cGrupo = TratarNulo(grupo, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dgrupo") != "U"
                    THIS.this_cDGrupo = TratarNulo(dgrupo, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL: executa consulta em SigMvCab com os filtros
    * Nao ha persistencia de registros - a "acao" do form eh consultar
    * movimentacoes que atendem os filtros. Popula cursor TprMvCab (padrao legado).
    * RegistrarAuditoria registra a operacao CONSULTA no LogAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nQtd, loc_cErroFiltros, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cErroFiltros = THIS.ValidarFiltros()
            IF !EMPTY(loc_cErroFiltros)
                THIS.this_cMensagemErro = loc_cErroFiltros
                loc_lSucesso = .F.
            ENDIF

            loc_nQtd = THIS.ConsultarMovimentacoes()

            DO CASE
            CASE loc_nQtd < 0
                THIS.this_cMensagemErro = "Falha ao consultar movimenta" + CHR(231) + CHR(245) + "es."
            CASE loc_nQtd = 0
                THIS.this_cMensagemErro = "Nenhuma movimenta" + CHR(231) + CHR(227) + "o foi encontrada."
            OTHERWISE
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("CONSULTA")
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL nao persiste registros
    * Delega para Inserir() (executa nova consulta) mantendo contrato BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE
