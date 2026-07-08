*==============================================================================
* SIGRECHPBO.PRG
* Business Object: SigReChp - Cheques em aberto
*
* Herda de: RelatorioBase
* Tipo: REPORT
* Tabela principal: SigCqChm + SigChe (join)
* FRX: SigReChp.frx
*==============================================================================

DEFINE CLASS sigrechpBO AS RelatorioBase

    *-- Filtro: tipo de data (1=Data Vencimento, 2=Data Operacao)
    this_nNrTipo            = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: opcao de nota (1=Sim/com nota, 2=Nao/sem nota, 3=Ambos)
    this_nNrOpcao           = 3

    *-- Filtro: emissor - grupo contabil
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""

    *-- Filtro: emissor - conta contabil
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro: destino - grupo contabil
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""

    *-- Filtro: destino - conta contabil
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *-- Filtro: ordem de classificacao e index selecionado
    this_cNmOrdem           = ""
    this_nOrdemIdx          = 1

    *-- Filtro: imprimir follow-up
    this_lImpFollow         = .F.

    *-- Captions dinamicos do opt_nr_opcao (carregados de SigCdPac)
    this_cCapOpcao1         = ""
    this_cCapOpcao2         = ""
    this_cCapOpcao3         = ""

    *-- Cursores de trabalho
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorTemp        = "cursor_4c_Temp"

    *-- Variaveis de cabecalho do relatorio
    this_cNomeEmpresa       = ""
    this_cTitulo            = ""
    this_cPeriodo           = ""
    this_cEmissor           = ""
    this_cDestino           = ""

    *-- Caminho do arquivo FRX
    this_cArquivoRelatorio  = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela          = ""
            THIS.this_cCampoChave      = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReChp.frx"
            THIS.this_dDtInicial       = DATE()
            THIS.this_dDtFinal         = DATE()
            THIS.this_nNrTipo          = 1
            THIS.this_nNrOpcao         = 3
            THIS.this_nOrdemIdx        = 1
            THIS.this_cTitulo          = "Relat" + CHR(243) + "rio de Cheques Pendentes"
            THIS.this_cCapOpcao1       = "Sim"
            THIS.this_cCapOpcao2       = "N" + CHR(227) + "o"
            THIS.this_cCapOpcao3       = "Ambos"
            loc_lSucesso               = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega captions do opt_nr_opcao de SigCdPac
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pac")
            IF loc_nResult > 0
                SELECT cursor_4c_Pac
                GO TOP
                IF !EOF()
                    THIS.this_cCapOpcao1 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcS)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcS), "Sim")
                    THIS.this_cCapOpcao2 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcN)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cCapOpcao3 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcA)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcA), "Ambos")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes DB/TR de SigCdOpt
    * Cria cursor_4c_Operacoes com Flag (L) e Operacaos (C15)
    * Chamado pelo Form em InicializarForm() para popular o grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_cOpc
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorOperacoes) (Flag L, Operacaos C(15))

            loc_cSql = "SELECT Operacaos FROM SigCdOpt " + ;
                       "WHERE Tipos = 'DB' OR Tipos = 'TR' " + ;
                       "ORDER BY Operacaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_OpcLoad")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + ;
                                          "es de SigCdOpt"
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_OpcLoad
            SCAN
                loc_cOpc = ALLTRIM(Operacaos)
                INSERT INTO (THIS.this_cCursorOperacoes) (Flag, Operacaos) ;
                    VALUES (.F., loc_cOpc)
            ENDSCAN

            IF USED("cursor_4c_OpcLoad")
                USE IN cursor_4c_OpcLoad
            ENDIF

            SELECT (THIS.this_cCursorOperacoes)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarOperacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula CsRelatorio para impressao
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_nFlagadas
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta, loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cCursorFinal

        loc_lSucesso = .F.
        TRY
            *-- Valida periodo
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtInicial > THIS.this_dDtFinal
                THIS.this_cMensagemErro = "Data inicial maior que data final"
                loc_lSucesso = .F.
            ENDIF

            *-- Valida operacoes selecionadas
            IF !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(245) + ;
                                          "es n" + CHR(227) + "o carregadas"
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorOperacoes)
            COUNT TO loc_nFlagadas FOR Flag
            IF loc_nFlagadas = 0
                THIS.this_cMensagemErro = "Selecione ao menos uma opera" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- Clausula WHERE: tipo de data (Vencimento=1 ou Operacao=2)
            IF THIS.this_nNrTipo = 2
                loc_cVerData = " AND CONVERT(DATE, a.dtents) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ELSE
                loc_cVerData = " AND CONVERT(DATE, b.vencs) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            *-- Clausula WHERE: empresa (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            *-- Clausula WHERE: opcao de nota (1=com nota, 2=sem nota, 3=ambos)
            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND NOT a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                loc_cVerOpcao = ""
                ENDIF
            ENDIF

            *-- Clausula WHERE: grupo emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND b.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF

            *-- Clausula WHERE: conta emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND b.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Clausula WHERE: grupo destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesGrupo))
                loc_cVerDesGrupo = ""
            ELSE
                loc_cVerDesGrupo = " AND b.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesGrupo))
            ENDIF

            *-- Clausula WHERE: conta destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesConta))
                loc_cVerDesConta = ""
            ELSE
                loc_cVerDesConta = " AND b.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesConta))
            ENDIF

            *-- 1. Query SQL Server: SigCqChm JOIN SigChe com todos os filtros
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            loc_cSql = "SELECT a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, " + ;
                       "b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques, " + ;
                       "b.valors, b.emps, b.umovs, ' ' AS Hists " + ;
                       "FROM SigCqChm a, SigChe b " + ;
                       "WHERE a.nums = b.nums"
            loc_cSql = loc_cSql + loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                       loc_cVerDesGrupo + loc_cVerDesConta + ;
                       " ORDER BY a.nums, a.numlotes, a.dtents, " + ;
                       "b.grclis, b.iclis, b.vencs, b.bancos, " + ;
                       "b.agencias, b.ncontas, b.ncheques, b.valors, b.emps, b.umovs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SqlTmp0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados dos cheques"
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Join VFP local com operacoes selecionadas -> cursor resultado
            *-- ImpFollow: resultado vai para cursor_4c_Temp; senao: vai para CsRelatorio
            loc_cCursorFinal = IIF(THIS.this_lImpFollow, THIS.this_cCursorTemp, "CsRelatorio")

            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF THIS.this_lImpFollow AND USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            *-- SELECT com ORDER BY dinamico baseado no indice do combobox de ordem
            DO CASE
                CASE THIS.this_nOrdemIdx = 2
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 4 ;
                      INTO CURSOR (m.loc_cCursorFinal) READWRITE
                CASE THIS.this_nOrdemIdx = 3
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 5 ;
                      INTO CURSOR (m.loc_cCursorFinal) READWRITE
                OTHERWISE
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 3 ;
                      INTO CURSOR (m.loc_cCursorFinal) READWRITE
            ENDCASE

            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            *-- 3. Preenche rClis e opcionalmente Hists
            IF THIS.this_lImpFollow
                THIS.ProcessarComFollowUp()
            ELSE
                THIS.BuscarClientes()
            ENDIF

            SELECT CsRelatorio
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarClientes - Preenche rClis em CsRelatorio via SigCdCli (sem FollowUp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarClientes()
        LOCAL loc_cSqlC, loc_nResult, loc_cIclis
        TRY
            SELECT CsRelatorio
            SCAN
                loc_cIclis = ALLTRIM(CsRelatorio.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliB")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliB
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliB.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliB
                    ENDIF
                    SELECT CsRelatorio
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.BuscarClientes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComFollowUp - Cria CsRelatorio com Hists e rClis do SigCheH/SigCdCli
    * Usado quando ImpFollow = .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarComFollowUp()
        LOCAL loc_cSqlH, loc_cSqlC, loc_nResult, loc_cNums, loc_cIclis
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            CREATE CURSOR CsRelatorio (Nums C(8), Numlotes N(8,0), dtents D, ;
                                       GrClis C(10), Iclis C(10), Vencs D, ;
                                       Bancos C(3), Agencias C(4), nContas C(10), ;
                                       nCheques C(6), Valors N(12,2), Emps C(3), ;
                                       Umovs C(15), Hists C(76), RClis C(50))

            SELECT (THIS.this_cCursorTemp)
            SCAN
                SCATTER MEMVAR MEMO

                SELECT CsRelatorio
                APPEND BLANK
                GATHER MEMVAR MEMO

                *-- Busca historico do cheque em SigCheH
                loc_cNums = ALLTRIM(m.Nums)
                loc_cSqlH = "SELECT TOP 1 Hists FROM SigCheH WHERE Nums = " + ;
                            EscaparSQL(loc_cNums)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlH, "cursor_4c_CheH")
                IF loc_nResult > 0
                    SELECT cursor_4c_CheH
                    IF !EOF()
                        REPLACE CsRelatorio.Hists WITH ALLTRIM(cursor_4c_CheH.Hists) ;
                                IN CsRelatorio
                    ENDIF
                    USE IN cursor_4c_CheH
                ENDIF

                *-- Busca razao social do cliente em SigCdCli
                loc_cIclis = ALLTRIM(m.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliF")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliF
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliF.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliF
                    ENDIF
                ENDIF

                SELECT (THIS.this_cCursorTemp)
            ENDSCAN

            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.ProcessarComFollowUp")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor CsCabecalho para o cabecalho do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp
        LOCAL loc_cNomeEmpresa, loc_cTipoData, loc_cPeriodo, loc_cEmissor, loc_cDestino

        loc_lSucesso = .F.
        TRY
            loc_cNomeEmpresa = ""
            loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            IF THIS.this_nNrTipo = 2
                loc_cTipoData = "Data da Movimenta" + CHR(231) + CHR(227) + "o: "
            ELSE
                loc_cTipoData = "Data de Vencimento: "
            ENDIF

            loc_cPeriodo = loc_cTipoData + ;
                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                           DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdEmiConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiConta))

            loc_cDestino = "Grupo / Conta Destino  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdDesGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdDesConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesConta))

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(80), Operacao C(80), ;
                                       Emissor C(80), Destino C(80))
            INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo, ;
                        loc_cPeriodo, loc_cEmissor, loc_cDestino)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.LimparCursores")
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
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Imprimir")
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
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdemIdx, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";DES="  + ALLTRIM(THIS.this_cCdDesGrupo) + "/" + ALLTRIM(THIS.this_cCdDesConta) + ;
                     ";FLW="  + IIF(THIS.this_lImpFollow, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de cursor de preset
    * par_cAliasCursor: nome do cursor com colunas dos filtros previamente usados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.dDtInicial") = "D"
                        THIS.this_dDtInicial = m.dDtInicial
                    ENDIF
                    IF TYPE("m.dDtFinal") = "D"
                        THIS.this_dDtFinal = m.dDtFinal
                    ENDIF
                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.cCdEmiGrupo") = "C"
                        THIS.this_cCdEmiGrupo = ALLTRIM(m.cCdEmiGrupo)
                    ENDIF
                    IF TYPE("m.cDsEmiGrupo") = "C"
                        THIS.this_cDsEmiGrupo = ALLTRIM(m.cDsEmiGrupo)
                    ENDIF
                    IF TYPE("m.cCdEmiConta") = "C"
                        THIS.this_cCdEmiConta = ALLTRIM(m.cCdEmiConta)
                    ENDIF
                    IF TYPE("m.cDsEmiConta") = "C"
                        THIS.this_cDsEmiConta = ALLTRIM(m.cDsEmiConta)
                    ENDIF
                    IF TYPE("m.cCdDesGrupo") = "C"
                        THIS.this_cCdDesGrupo = ALLTRIM(m.cCdDesGrupo)
                    ENDIF
                    IF TYPE("m.cDsDesGrupo") = "C"
                        THIS.this_cDsDesGrupo = ALLTRIM(m.cDsDesGrupo)
                    ENDIF
                    IF TYPE("m.cCdDesConta") = "C"
                        THIS.this_cCdDesConta = ALLTRIM(m.cCdDesConta)
                    ENDIF
                    IF TYPE("m.cDsDesConta") = "C"
                        THIS.this_cDsDesConta = ALLTRIM(m.cDsDesConta)
                    ENDIF
                    IF TYPE("m.nOrdemIdx") = "N"
                        THIS.this_nOrdemIdx = m.nOrdemIdx
                    ENDIF
                    IF TYPE("m.lImpFollow") = "L"
                        THIS.this_lImpFollow = m.lImpFollow
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
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
            MsgErro(loc_oErro.Message, "sigrechpBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
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
            MsgErro(loc_oErro.Message, "sigrechpBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
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
                       EscaparSQL("SigReChp") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
