*==============================================================================
* SIGREDIRBO.PRG
* Business Object - Demonstrativo de Retencao de Impostos
* CSLL, COFINS e PIS/PASEP
*
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREDIRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cAnoBase            = ""
    this_cFornec             = ""
    this_cDforn              = ""

    *-- Cursores internos
    this_cCursorEmpresas     = "cursor_4c_Empresas"
    this_cCursorDados        = "cursor_4c_Dados"

    *-- Arquivo de relatorio (sem extensao)
    this_cArquivoFRX         = "sigReDir"
    this_cUltimoArquivoExcel  = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO e carrega cursor de empresas para selecao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        IF !DODEFAULT()
            THIS.this_cMensagemErro = "Falha na inicializa" + CHR(231) + CHR(227) + "o da classe base"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT 1 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")

            IF loc_nResult > 0
                *-- Cria cursor local READWRITE para permitir marcacao pelo usuario
                IF USED(THIS.this_cCursorEmpresas)
                    USE IN (THIS.this_cCursorEmpresas)
                ENDIF
                SELECT Imps, cemps, razas FROM cursor_4c_EmpTmp ;
                    INTO CURSOR (THIS.this_cCursorEmpresas) READWRITE
                USE IN cursor_4c_EmpTmp
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar lista de empresas"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e recursos alocados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorEmpresas)
            USE IN (THIS.this_cCursorEmpresas)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarEmpresas - Monta clausula WHERE para filtro de empresas selecionadas
    * Retorna string SQL (ex: " AND a.Emps = 'xxx'") ou "" se nenhuma selecionada
    *--------------------------------------------------------------------------
    PROCEDURE MontarEmpresas()
        LOCAL loc_cEmp, loc_cVir, loc_nCount

        loc_cEmp   = ""
        loc_cVir   = ""
        loc_nCount = 0

        IF !USED(THIS.this_cCursorEmpresas)
            THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN ""
        ENDIF

        SELECT (THIS.this_cCursorEmpresas)
        SCAN
            IF Imps = 1
                loc_nCount = loc_nCount + 1
            ENDIF
        ENDSCAN

        IF loc_nCount = 0
            THIS.this_cMensagemErro = "Nenhuma empresa foi selecionada."
            RETURN ""
        ENDIF

        IF loc_nCount = 1
            SELECT (THIS.this_cCursorEmpresas)
            SCAN
                IF Imps = 1
                    loc_cEmp = " AND a.Emps = '" + ALLTRIM(cemps) + "'"
                ENDIF
            ENDSCAN
        ELSE
            loc_cEmp = " AND a.Emps IN ("
            SELECT (THIS.this_cCursorEmpresas)
            SCAN
                IF Imps = 1
                    loc_cEmp = loc_cEmp + loc_cVir + "'" + ALLTRIM(cemps) + "'"
                    loc_cVir = ", "
                ENDIF
            ENDSCAN
            loc_cEmp = loc_cEmp + ")"
        ENDIF

        RETURN loc_cEmp
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL UNION ALL (PIS/COFINS/CSLL) e executa query
    * Retorna .T. se dados carregados com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpFilter, loc_cFornecFilter
        LOCAL loc_cDtIni, loc_cDtFin, loc_cAno
        LOCAL loc_cJoins, loc_cWhere
        LOCAL loc_cSelect1, loc_cSelect2, loc_cSelect3

        loc_lSucesso = .F.

        TRY
            *-- Validacao: ano base obrigatorio
            loc_cAno = ALLTRIM(THIS.this_cAnoBase)
            IF EMPTY(loc_cAno)
                THIS.this_cMensagemErro = "Ano base n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Filtro de empresas (valida selecao e monta clausula)
            loc_cEmpFilter = THIS.MontarEmpresas()
            IF EMPTY(loc_cEmpFilter)
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo do exercicio anual
            loc_cDtIni = "'" + loc_cAno + "-01-01'"
            loc_cDtFin = "'" + loc_cAno + "-12-31 23:59:59'"

            *-- Filtro de fornecedor (opcional)
            IF !EMPTY(ALLTRIM(THIS.this_cFornec))
                loc_cFornecFilter = " AND a.clifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornec))
            ELSE
                loc_cFornecFilter = ""
            ENDIF

            *-- Clausulas reutilizaveis
            loc_cJoins = " LEFT JOIN SigCdSrv b WITH (NOLOCK) ON a.codservs = b.codservs" + ;
                         " LEFT JOIN SigCdCli c ON c.iclis = a.clifors" + ;
                         " LEFT JOIN SigCdEmp d ON a.emps = d.cemps"

            loc_cWhere = " WHERE a.emis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin + ;
                         " AND (a.vpis <> 0 OR a.vcofins <> 0 OR a.vcsll <> 0)" + ;
                         loc_cEmpFilter + loc_cFornecFilter

            *-- SELECT PIS
            loc_cSelect1 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vpis AS vimposto, b.codpiss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT COFINS
            loc_cSelect2 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcofins AS vimposto, b.codcofinss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT CSLL
            loc_cSelect3 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcsll AS vimposto, b.codcslls AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- UNION ALL (PIS + COFINS + CSLL) com ordenacao
            loc_cSQL = loc_cSelect1 + ;
                       " UNION ALL " + loc_cSelect2 + ;
                       " UNION ALL " + loc_cSelect3 + ;
                       " ORDER BY cnpj, clifors, emis, codservs"

            *-- Fechar cursor anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e abre dialogo de impressao
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
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
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresas - Marca ou desmarca todas as empresas no cursor
    * par_lMarcar: .T. marca todas, .F. desmarca todas
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresas(par_lMarcar)
        LOCAL loc_nValor
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)
        IF USED(THIS.this_cCursorEmpresas)
            SELECT (THIS.this_cCursorEmpresas)
            REPLACE ALL Imps WITH loc_nValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresaUnica - Marca/desmarca empresa especifica no cursor
    * par_cCodigoEmp: codigo da empresa (cemps) a alterar
    * par_lMarcar: .T. para marcar (Imps=1), .F. para desmarcar (Imps=0)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, par_lMarcar)
        LOCAL loc_lSucesso, loc_nValor, loc_cCodigo
        loc_lSucesso = .F.
        loc_cCodigo = ALLTRIM(par_cCodigoEmp)
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)

        IF EMPTY(loc_cCodigo) OR !USED(THIS.this_cCursorEmpresas)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorEmpresas)
        LOCATE FOR ALLTRIM(cemps) == loc_cCodigo
        IF FOUND()
            REPLACE Imps WITH loc_nValor
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirEmpresaNaSelecao - Adiciona empresa especifica na selecao (Imps=1)
    * Util para pre-selecionar empresas via codigo externo (ex: empresa logada)
    * par_cCodigoEmp: codigo da empresa (cemps) a marcar
    *--------------------------------------------------------------------------
    PROCEDURE InserirEmpresaNaSelecao(par_cCodigoEmp)
        RETURN THIS.AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtros da linha atual do cursor
    * Permite restaurar estado de filtros a partir de cursor externo
    * (ex: configuracao salva, parametros de outro form, agendamento)
    * par_cAliasCursor: nome do cursor com campos AnoBase/Fornec/Dforn
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ELSE
                SELECT (par_cAliasCursor)

                IF TYPE("AnoBase") <> "U"
                    THIS.this_cAnoBase = TratarNulo(AnoBase, "C")
                ENDIF

                IF TYPE("Fornec") <> "U"
                    THIS.this_cFornec = TratarNulo(Fornec, "C")
                ENDIF

                IF TYPE("Dforn") <> "U"
                    THIS.this_cDforn = TratarNulo(Dforn, "C")
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
    * ExportarExcel - Prepara dados e exporta cursor para arquivo XLS
    *   Retorna .T. se exportacao bem-sucedida
    *   this_cUltimoArquivoExcel recebe caminho do arquivo gerado
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cData
        loc_lSucesso = .F.
        THIS.this_cUltimoArquivoExcel = ""

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cData    = TRANSFORM(YEAR(DATE())) + ;
                           RIGHT("0" + TRANSFORM(MONTH(DATE())), 2) + ;
                           RIGHT("0" + TRANSFORM(DAY(DATE())), 2)
            loc_cArquivo = SYS(5) + CURDIR() + "sigReDir_" + loc_cData + ".xls"

            SELECT (THIS.this_cCursorDados)
            COPY TO (loc_cArquivo) TYPE XLS

            THIS.this_cUltimoArquivoExcel = loc_cArquivo
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do relatorio (ano base + cnpj fornec)
    * Usado por RegistrarAuditoria para identificar a execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cAnoBase)
        IF !EMPTY(ALLTRIM(THIS.this_cFornec))
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cFornec)
        ENDIF
        RETURN loc_cChave
    ENDPROC

ENDDEFINE
