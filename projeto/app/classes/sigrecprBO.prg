*==============================================================================
* SIGRECPRBO.PRG
* Business Object para Relatorio de Cheques Prorrogados
* Herda de RelatorioBase
*
* Filtros do formulario original (SIGRECPR):
*   DataIni / DataFin     -> this_dDataIni / this_dDataFin
*   OptFiltro (1/2)       -> this_nTipoFiltro (1=Prorrogados, 2=Vencimento)
*   GetTipoRel (ListIndex)-> this_nTipoRel (1=Ativos..5=Devolvidos)
*   Opt_Bons (1/2)        -> this_nBons (1=Ativos, 2=Todos)
*   Opcao (hidden, 1/2)   -> this_nOpcao (1=Em aberto, 2=Geral)
*==============================================================================

DEFINE CLASS sigrecprBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDataIni       = {}
    this_dDataFin       = {}
    this_nTipoFiltro    = 1
    this_nTipoRel       = 1
    this_nBons          = 1
    this_nOpcao         = 1

    *-- Titulo calculado com os filtros selecionados
    this_cTitulo        = ""

    *-- Caminho do FRX
    this_cArquivoRelatorio = ""

    *-- Cursor principal do relatorio
    this_cCursorDados   = "CsRelatorio"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de Cheques Prorrogados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela          = ""
            THIS.this_cCampoChave      = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReCpr.frx"
            THIS.this_dDataIni         = DATE()
            THIS.this_dDataFin         = DATE()
            THIS.this_nTipoFiltro      = 1
            THIS.this_nTipoRel         = 1
            THIS.this_nBons            = 1
            THIS.this_nOpcao           = 1
            THIS.this_cTitulo          = "Cheques Prorrogados"
            loc_lSucesso               = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula CsRelatorio para impressao
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cVerTipo, loc_cCampoDt
        LOCAL loc_cDataIni, loc_cDataFin, loc_nResult

        loc_lSucesso = .F.
        TRY
            *-- Validar periodo
            IF EMPTY(THIS.this_dDataIni) OR EMPTY(THIS.this_dDataFin)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + ;
                    CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDataIni > THIS.this_dDataFin
                THIS.this_cMensagemErro = "Data inicial maior que data final"
                loc_lSucesso = .F.
            ENDIF

            *-- Formatar datas para SQL
            loc_cDataIni = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDataFin = "'" + ;
                PADL(YEAR(THIS.this_dDataFin),  4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDataFin), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDataFin),   2, "0") + " 23:59:59'"

            *-- Campo de data do filtro (Prorrogados=e.vencs, Vencimento=a.vencs)
            loc_cCampoDt = IIF(THIS.this_nTipoFiltro = 1, "e.vencs", "a.vencs")

            *-- Montar clausula adicional de filtro por tipo de relatorio
            DO CASE
                CASE THIS.this_nTipoRel = 2  && Baixados
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='CR' AND devolvidos='N' " + ;
                        "AND opants NOT IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='S'))"

                CASE THIS.this_nTipoRel = 3  && NEG.PG (Devolvidos)
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='S')"

                CASE THIS.this_nTipoRel = 4  && Bons
                    IF THIS.this_nBons = 1  && Ativos
                        loc_cVerTipo = " AND a.umovs IN (" + ;
                            "SELECT operacaos FROM SigCdOpt " + ;
                            "WHERE devolvidos<>'S' AND tipos='DB' AND Ordens=1)"
                    ELSE  && Todos
                        loc_cVerTipo = " AND a.umovs IN (" + ;
                            "SELECT operacaos FROM SigCdOpt " + ;
                            "WHERE devolvidos<>'S')"
                    ENDIF
                    loc_cVerTipo = loc_cVerTipo + ;
                        " AND a.contat NOT IN (" + ;
                        "SELECT DISTINCT contat FROM sigche " + ;
                        "WHERE umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE devolvidos='S'))"

                CASE THIS.this_nTipoRel = 5  && Devolvidos
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE devolvidos='S')"

                OTHERWISE  && Ativos (lnTipoRel=1 ou vazio)
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='N')"
            ENDCASE

            *-- Calcular titulo com filtros aplicados
            THIS.this_cTitulo = "Filtros: " + ;
                IIF(THIS.this_nTipoFiltro = 1, "Prorrogados", "Vencimento") + ;
                " - " + ;
                IIF(THIS.this_nTipoRel = 1 OR THIS.this_nTipoRel = 0, "Ativos", ;
                IIF(THIS.this_nTipoRel = 2, "Baixados", ;
                IIF(THIS.this_nTipoRel = 3, "NEG.PG", ;
                IIF(THIS.this_nTipoRel = 4, ;
                    "Bons - " + IIF(THIS.this_nBons = 1, "Ativos", "Todos"), ;
                    "Devolvidos"))))

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Montar SQL principal (todas as tabelas em SQL Server)
            loc_cSQL = "SELECT e.iclis, e.vencs AS ultvenc, e.umovs, " + ;
                       "e.agencias, e.bancos, e.ncontas, e.ncheques, " + ;
                       "c.rclis, c.grupos, e.valors, a.*, " + ;
                       TRANSFORM(THIS.this_nOpcao) + " AS opcao, " + ;
                       "m.razas AS empresa, " + ;
                       "CAST(" + loc_cDataIni + " AS datetime) AS dataini, " + ;
                       "CAST(" + loc_cDataFin + " AS datetime) AS datafin, " + ;
                       "e.contat, e.grupot, t.rclis AS dContat "
            loc_cSQL = loc_cSQL + ;
                       "FROM SigChe e, SigCdOpt r, SigCdCli c, " + ;
                       "SigChea a, SigCdEmp m, SigCdCli t "
            loc_cSQL = loc_cSQL + ;
                       "WHERE " + loc_cCampoDt + ;
                       " BETWEEN " + loc_cDataIni + " AND " + loc_cDataFin + ;
                       " AND e.umovs = r.operacaos" + ;
                       " AND e.iclis = c.iclis" + ;
                       " AND e.nums = a.nums" + ;
                       " AND e.contat = t.iclis" + ;
                       " AND m.cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_cSQL = loc_cSQL + loc_cVerTipo + ;
                       " ORDER BY c.rclis, e.agencias, e.bancos, e.ncontas, e.ncheques"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cheques prorrogados"
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorDados)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria CsCabecalho para uso no relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp, loc_cNomeEmpresa, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            loc_cNomeEmpresa = ""
            loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cemps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDataFin) + ;
                           " - Filtro: " + ;
                           IIF(THIS.this_nTipoFiltro = 1, "Prorrogados", "Vencimento")

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ;
                (NomeEmpresa C(80), Titulo C(100), Periodo C(100))
            INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo, loc_cPeriodo)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + ;
                        CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + ;
                        CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os filtros do BO a partir de um cursor
    * Util para restaurar filtros salvos / pre-configurados antes da impressao.
    * Aceita cursores com qualquer subconjunto das colunas abaixo:
    *   dDataIni, dDataFin (data)
    *   nTipoFiltro, nTipoRel, nBons, nOpcao (numerico)
    *   cTitulo (texto)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = ALLTRIM(par_cAliasCursor)
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)

            IF TYPE(loc_cAlias + ".dDataIni") = "D"
                THIS.this_dDataIni = NVL(EVALUATE(loc_cAlias + ".dDataIni"), DATE())
            ENDIF
            IF TYPE(loc_cAlias + ".dDataFin") = "D"
                THIS.this_dDataFin = NVL(EVALUATE(loc_cAlias + ".dDataFin"), DATE())
            ENDIF
            IF TYPE(loc_cAlias + ".nTipoFiltro") = "N"
                THIS.this_nTipoFiltro = NVL(EVALUATE(loc_cAlias + ".nTipoFiltro"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nTipoRel") = "N"
                THIS.this_nTipoRel = NVL(EVALUATE(loc_cAlias + ".nTipoRel"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nBons") = "N"
                THIS.this_nBons = NVL(EVALUATE(loc_cAlias + ".nBons"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nOpcao") = "N"
                THIS.this_nOpcao = NVL(EVALUATE(loc_cAlias + ".nOpcao"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".cTitulo") = "C"
                THIS.this_cTitulo = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo"), ""))
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO="   + ALLTRIM(STR(THIS.this_nTipoFiltro, 1)) + ;
                     ";REL="   + ALLTRIM(STR(THIS.this_nTipoRel, 1)) + ;
                     ";BONS="  + ALLTRIM(STR(THIS.this_nBons, 1)) + ;
                     ";OPC="   + ALLTRIM(STR(THIS.this_nOpcao, 1)) + ;
                     ";DT="    + DTOC(THIS.this_dDataIni) + ;
                     "-"       + DTOC(THIS.this_dDataFin)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCpr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: delega para Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: delega para Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE
