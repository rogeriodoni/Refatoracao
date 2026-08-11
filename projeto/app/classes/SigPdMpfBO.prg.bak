*==============================================================================
* SigPdMpfBO.prg - Business Object: Movimentacoes de producao por funcionario
*==============================================================================
* Tabela principal : SigCdNec (movimentacoes)
* Tabela join      : SigCdOpd (operacoes de producao)
* Lookups          : SigCdGcr (grupos), SigCdCli (contas)
* Tipo             : OPERACIONAL (consulta + CRUD em SigCdNec)
*==============================================================================

DEFINE CLASS SigPdMpfBO AS BusinessBase

    *-- Filtros de consulta - Periodo
    this_dDtInicial  = {}
    this_dDtFinal    = {}

    *-- Filtro - Operacao (dopps em SigCdOpd, char(20))
    this_cNmOperacao = ""

    *-- Filtro - Grupo contabil (SigCdGcr.codigos, char(10))
    this_cGrupo      = ""

    *-- Descricao do grupo (SigCdGcr.descrs, char(40))
    this_cDGrupo     = ""

    *-- Filtro - Conta (SigCdCli.IClis, char(10))
    this_cConta      = ""

    *-- Descricao da conta (SigCdCli.RClis)
    this_cDConta     = ""

    *-- Tipo de filtro por conta: 1=Origem, 2=Destino, 3=Todos
    this_nOptConta   = 3

    *-- Propriedades adicionais para CRUD em SigCdNec
    this_cCidChaves  = ""    && PK char(20)
    this_dDatas      = {}    && Data movimentacao
    this_cDopps      = ""    && Operacao char(20)
    this_cEmps       = ""    && Empresa char(3)
    this_cContaOs    = ""    && Conta origem char(10)
    this_cContaDs    = ""    && Conta destino char(10)
    this_cGrupoOs    = ""    && Grupo origem char(10)
    this_cGrupoDs    = ""    && Grupo destino char(10)
    this_nNumps      = 0     && Numero processo numeric(10,0)
    this_nNops       = 0     && Numero operacao numeric(10,0)
    this_cUsuars     = ""    && Usuario char(10)
    this_nTotPesos   = 0     && Total pesos numeric(11,3)
    this_cDocus      = ""    && Documento char(10)
    this_cLocals     = ""    && Local char(10)
    this_cEmpDnps    = ""    && char(33) - empresa+doc+nump
    this_cJobs       = ""    && Job char(10)

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdNec"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor SigCdNec para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Chave primaria
                IF TYPE(par_cAliasCursor + ".cidchaves") != "U"
                    THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                ENDIF

                *-- Data movimentacao
                IF TYPE(par_cAliasCursor + ".datas") != "U"
                    THIS.this_dDatas = TratarNulo(datas, "D")
                ENDIF

                *-- Operacao
                IF TYPE(par_cAliasCursor + ".dopps") != "U"
                    THIS.this_cDopps = TratarNulo(dopps, "C")
                ENDIF

                *-- Empresa
                IF TYPE(par_cAliasCursor + ".emps") != "U"
                    THIS.this_cEmps = TratarNulo(emps, "C")
                ENDIF

                *-- Contas
                IF TYPE(par_cAliasCursor + ".contaos") != "U"
                    THIS.this_cContaOs = TratarNulo(contaos, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".contads") != "U"
                    THIS.this_cContaDs = TratarNulo(contads, "C")
                ENDIF

                *-- Grupos
                IF TYPE(par_cAliasCursor + ".grupoos") != "U"
                    THIS.this_cGrupoOs = TratarNulo(grupoos, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".grupods") != "U"
                    THIS.this_cGrupoDs = TratarNulo(grupods, "C")
                ENDIF

                *-- Numericos
                IF TYPE(par_cAliasCursor + ".numps") != "U"
                    THIS.this_nNumps = TratarNulo(numps, "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".nops") != "U"
                    THIS.this_nNops = TratarNulo(nops, "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".totpesos") != "U"
                    THIS.this_nTotPesos = TratarNulo(totpesos, "N")
                ENDIF

                *-- Outros
                IF TYPE(par_cAliasCursor + ".usuars") != "U"
                    THIS.this_cUsuars = TratarNulo(usuars, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".docus") != "U"
                    THIS.this_cDocus = TratarNulo(docus, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".locals") != "U"
                    THIS.this_cLocals = TratarNulo(locals, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".empdnps") != "U"
                    THIS.this_cEmpDnps = TratarNulo(empdnps, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".jobs") != "U"
                    THIS.this_cJobs = TratarNulo(jobs, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar (SigCdNec)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_dDatas)
            MsgAviso("Informe a data da movimenta" + CHR(231) + CHR(227) + "o.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDopps))
            MsgAviso("Informe a opera" + CHR(231) + CHR(227) + "o.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
            MsgAviso("Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova movimentacao em SigCdNec
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF

            *-- Monta empdnps (emps + docus + numps) caso nao informado
            IF EMPTY(ALLTRIM(THIS.this_cEmpDnps))
                THIS.this_cEmpDnps = PADR(ALLTRIM(THIS.this_cEmps),  3) + ;
                                     PADR(ALLTRIM(THIS.this_cDocus), 10) + ;
                                     PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "cidchaves, datas, dopps, emps, " + ;
                       "contaos, contads, grupoos, grupods, " + ;
                       "numps, nops, usuars, totpesos, " + ;
                       "docus, locals, empdnps, jobs, " + ;
                       "chksubn, imprs, lccs, procbals, procdbal, " + ;
                       "retrabs, autos, nconforms, " + ;
                       "grvends, vends, ntrans, naceites, " + ;
                       "libprods, codnconfs, numbalds, numbals, " + ;
                       "codobs, empds, nlotes, pesolancs, " + ;
                       "usulibs, chkbaixa, usuconfs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cDopps) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cContaOs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoOs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       EscaparSQL(THIS.this_cDocus) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnps) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       "0, 0, 0, 0, 0, " + ;
                       "0, 0, 0, " + ;
                       "'', '', 0, 0, " + ;
                       "'', '', 0, 0, " + ;
                       "0, '', 0, 0, " + ;
                       "'', 0, '')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 1
                MsgErro("Falha ao inserir movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza movimentacao em SigCdNec
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdNec SET " + ;
                       "datas = "    + FormatarDataSQL(THIS.this_dDatas)   + ", " + ;
                       "dopps = "    + EscaparSQL(THIS.this_cDopps)        + ", " + ;
                       "emps = "     + EscaparSQL(THIS.this_cEmps)         + ", " + ;
                       "contaos = "  + EscaparSQL(THIS.this_cContaOs)      + ", " + ;
                       "contads = "  + EscaparSQL(THIS.this_cContaDs)      + ", " + ;
                       "grupoos = "  + EscaparSQL(THIS.this_cGrupoOs)      + ", " + ;
                       "grupods = "  + EscaparSQL(THIS.this_cGrupoDs)      + ", " + ;
                       "numps = "    + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       "nops = "     + FormatarNumeroSQL(THIS.this_nNops)  + ", " + ;
                       "usuars = "   + EscaparSQL(THIS.this_cUsuars)       + ", " + ;
                       "totpesos = " + FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       "docus = "    + EscaparSQL(THIS.this_cDocus)        + ", " + ;
                       "locals = "   + EscaparSQL(THIS.this_cLocals)       + ", " + ;
                       "empdnps = "  + EscaparSQL(THIS.this_cEmpDnps)      + ", " + ;
                       "jobs = "     + EscaparSQL(THIS.this_cJobs)         + " "  + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 1
                MsgErro("Falha ao atualizar movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("ATUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui movimentacao de SigCdNec pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdNec WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 1
                MsgErro("Falha ao excluir movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("EXCLUIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de executar a consulta
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
            MsgAviso("Informe o per" + CHR(237) + "odo de consulta.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor Que a Data Inicial!!!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConstruirSQL - Monta a query de consulta de movimentacoes por funcionario
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConstruirSQL()
        LOCAL loc_cSQL, loc_cWhere, loc_cGrupo, loc_cConta, loc_cOper
        LOCAL loc_cDtIni, loc_cDtFim

        loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
        loc_cConta = ALLTRIM(THIS.this_cConta)
        loc_cOper  = ALLTRIM(THIS.this_cNmOperacao)

        *-- Formata datas: inicio com hora 00:00:00, fim com 23:59:59
        loc_cDtIni = "'" + ;
            PADL(YEAR(THIS.this_dDtInicial),  4, "0") + "-" + ;
            PADL(MONTH(THIS.this_dDtInicial), 2, "0") + "-" + ;
            PADL(DAY(THIS.this_dDtInicial),   2, "0") + " 00:00:00'"

        loc_cDtFim = "'" + ;
            PADL(YEAR(THIS.this_dDtFinal),  4, "0") + "-" + ;
            PADL(MONTH(THIS.this_dDtFinal), 2, "0") + "-" + ;
            PADL(DAY(THIS.this_dDtFinal),   2, "0") + " 23:59:59'"

        *-- Monta clausula WHERE para filtro de conta/grupo conforme optConta
        DO CASE
            CASE THIS.this_nOptConta = 1   && Origem
                loc_cWhere = "(a.grupoos = " + EscaparSQL(loc_cGrupo) + ;
                             " AND a.contaos = " + EscaparSQL(loc_cConta) + ")"
            CASE THIS.this_nOptConta = 2   && Destino
                loc_cWhere = "(a.grupods = " + EscaparSQL(loc_cGrupo) + ;
                             " AND a.contads = " + EscaparSQL(loc_cConta) + ")"
            OTHERWISE                       && Todos
                loc_cWhere = "((a.grupoos = " + EscaparSQL(loc_cGrupo) + ;
                             " OR a.grupods = " + EscaparSQL(loc_cGrupo) + ") AND " + ;
                             "(a.contaos = " + EscaparSQL(loc_cConta) + ;
                             " OR a.contads = " + EscaparSQL(loc_cConta) + "))"
        ENDCASE

        *-- Filtro de operacao: sem operacao busca apenas grcomps=1, com operacao filtra por dopps
        LOCAL loc_cFiltroOper
        IF EMPTY(loc_cOper)
            loc_cFiltroOper = "o.grcomps = 1"
        ELSE
            loc_cFiltroOper = "a.dopps = " + EscaparSQL(loc_cOper)
        ENDIF

        *-- Monta SQL completo (equivalente ao legado: SELECT a.*)
        loc_cSQL = "SELECT a.* " + ;
                   "FROM SigCdNec a, SigCdOpd o " + ;
                   "WHERE a.datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " " + ;
                   "AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " " + ;
                   "AND a.dopps = o.dopps " + ;
                   "AND " + loc_cFiltroOper + " " + ;
                   "AND " + loc_cWhere

        RETURN loc_cSQL
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - Executa a consulta e retorna a SQL string se houver
    *                    registros (vazia em caso de erro ou sem resultados)
    *--------------------------------------------------------------------------
    FUNCTION ExecutarConsulta()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.
        loc_cSQL     = ""

        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = ""
            ENDIF

            loc_cSQL = THIS.ConstruirSQL()

            *-- Fecha cursor temporario anterior se existir
            IF USED("cursor_4c_TmpConsulta")
                USE IN cursor_4c_TmpConsulta
            ENDIF

            *-- Executa para verificar se ha registros
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpConsulta")

            IF loc_nResult < 1
                MsgErro("Falha ao executar consulta de movimenta" + CHR(231) + CHR(245) + "es.", "Erro")
                loc_lSucesso = ""
            ENDIF

            SELECT cursor_4c_TmpConsulta
            IF RECCOUNT() = 0
                IF USED("cursor_4c_TmpConsulta")
                    USE IN cursor_4c_TmpConsulta
                ENDIF
                MsgAviso("Nenhum Registro Selecionado!!!", "Consulta")
                loc_lSucesso = ""
            ENDIF

            IF USED("cursor_4c_TmpConsulta")
                USE IN cursor_4c_TmpConsulta
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lSucesso
            RETURN loc_cSQL
        ENDIF
        RETURN ""
    ENDFUNC

ENDDEFINE
