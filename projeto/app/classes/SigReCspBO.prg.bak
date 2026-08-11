*==============================================================================
* SIGRECSPBO.PRG
* Business Object para Pesquisa de Operacoes (SIGRECSP)
* Herda de RelatorioBase
*
* Tabela principal: SigMvCab
* Chave: EmpDopNums
* Cursor resultado: cursor_4c_SigReCsp
*==============================================================================

DEFINE CLASS SigReCspBO AS RelatorioBase

    *-- Configuracao base
    this_cTabela        = "SigMvCab"
    this_cCampoChave    = "EmpDopNums"
    this_cCursorDados   = "cursor_4c_SigReCsp"

    *-- Filtros: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtros: Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: Movimentacao
    this_cNmOperacao    = ""
    this_cCodigo        = ""
    this_cDocumento     = ""

    *-- Filtros: Conta/Grupo contabil
    this_nOptConta      = 1
    this_cContas        = ""
    this_cDContas       = ""
    this_cGrupos        = ""
    this_cDGrupos       = ""

    *-- Filtros: Observacao
    this_cObses         = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO de pesquisa de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega empresa padrao e sua descricao.
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco Init() do legado SIGRECSP que carrega SigCdEmp.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(THIS.this_cEmpresa)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(THIS.this_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRec")
                IF loc_nResult > 0
                    SELECT cursor_4c_EmpRec
                    IF !EOF()
                        THIS.this_cDEmpresa = ALLTRIM(cursor_4c_EmpRec.Razas)
                    ENDIF
                    USE IN cursor_4c_EmpRec
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal em SigMvCab com os filtros
    * definidos nas propriedades this_*. Popula cursor_4c_SigReCsp.
    * Equivalente ao metodo 'processamento' do form legado SIGRECSP.
    * NOTA: filtro de acesso por operacao (fAcessoMovmto) nao replicado -
    * funcao legada de controle de acesso nao existe no novo sistema.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cOpCta, loc_cOpGru, loc_dDtI, loc_dDtF, loc_cDtFSQL
        loc_lSucesso = .F.
        TRY
            *-- Normalizar datas: sem data = faixa maxima historica
            loc_dDtI = IIF(EMPTY(THIS.this_dDtInicial), {^1900-01-01}, THIS.this_dDtInicial)
            loc_dDtF = IIF(EMPTY(THIS.this_dDtFinal),   {^2099-12-31}, THIS.this_dDtFinal)

            *-- Data final com 23:59:59 para cobrir o dia inteiro (campo DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_dDtF),  4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF),   2, "0") + " 23:59:59'"

            *-- Colunas de Conta/Grupo dependem de OptConta:
            *-- 1=Origem -> ContaOs/GrupoOs | 2=Destino -> ContaDs/GrupoDs
            IF THIS.this_nOptConta = 1
                loc_cOpCta = "ContaOs"
                loc_cOpGru = "GrupoOs"
            ELSE
                loc_cOpCta = "ContaDs"
                loc_cOpGru = "GrupoDs"
            ENDIF

            *-- Construir clausula WHERE adicional
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cNmOperacao))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cNmOperacao))
            ENDIF

            *-- numes e NUMERIC(6,0) - nao usar aspas, apenas o valor numerico
            IF !EMPTY(ALLTRIM(THIS.this_cCodigo))
                loc_cWhere = loc_cWhere + ;
                    " AND a.numes = " + ALLTRIM(THIS.this_cCodigo)
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cDocumento))
                loc_cWhere = loc_cWhere + ;
                    " AND a.notas = " + EscaparSQL(ALLTRIM(THIS.this_cDocumento))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrupos))
                loc_cWhere = loc_cWhere + ;
                    " AND a." + loc_cOpGru + " = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrupos))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cContas))
                loc_cWhere = loc_cWhere + ;
                    " AND a." + loc_cOpCta + " = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cContas))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cObses))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Obses LIKE " + ;
                    EscaparSQL("%" + ALLTRIM(THIS.this_cObses) + "%")
            ENDIF

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Query principal: SigMvCab com campos do grid original
            loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.notas," + ;
                " a.datars, a.empdopnums, a.operadors, a.usulibs," + ;
                " ISNULL(CONVERT(VARCHAR(250), a.Obses), '') AS Obses" + ;
                " FROM SigMvCab a" + ;
                " WHERE a.datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                " AND " + loc_cDtFSQL + ;
                loc_cWhere + ;
                " ORDER BY a.EmpDopNums"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de opera" + ;
                    CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ELSE
                SELECT (THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de cursor de configuracao.
    * Util para "ultimo filtro usado" sem quebrar quando o schema evoluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        TRY
            loc_lValido = !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            IF !loc_lValido
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel"
            ENDIF
            IF loc_lValido
                SELECT (par_cAliasCursor)
                loc_lValido = !EOF()
                IF !loc_lValido
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                ENDIF
            ENDIF
            IF loc_lValido
                IF TYPE(par_cAliasCursor + ".c_empresa") = "C"
                    THIS.this_cEmpresa    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_empresa"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dempresa") = "C"
                    THIS.this_cDEmpresa   = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dempresa"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".d_inicial") = "D"
                    THIS.this_dDtInicial  = EVALUATE(par_cAliasCursor + ".d_inicial")
                ENDIF
                IF TYPE(par_cAliasCursor + ".d_final") = "D"
                    THIS.this_dDtFinal    = EVALUATE(par_cAliasCursor + ".d_final")
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_operacao") = "C"
                    THIS.this_cNmOperacao = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_operacao"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_codigo") = "C"
                    THIS.this_cCodigo     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_codigo"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_documento") = "C"
                    THIS.this_cDocumento  = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_documento"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".n_optconta") = "N"
                    THIS.this_nOptConta   = EVALUATE(par_cAliasCursor + ".n_optconta")
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_contas") = "C"
                    THIS.this_cContas     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_contas"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dcontas") = "C"
                    THIS.this_cDContas    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dcontas"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_grupos") = "C"
                    THIS.this_cGrupos     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_grupos"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dgrupos") = "C"
                    THIS.this_cDGrupos    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dgrupos"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_obses") = "C"
                    THIS.this_cObses      = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_obses"))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: pesquisa nao persiste dados.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: use PrepararDados()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: pesquisa nao persiste dados.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: use PrepararDados()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Pesquisa nao tem chave primaria para persistencia.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro.
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_EmpRec")
            USE IN cursor_4c_EmpRec
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
