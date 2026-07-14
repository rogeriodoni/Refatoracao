*==============================================================================
* SIGREAUPBO.PRG
* Business Object - Relatorio de Tipos de Autorizacoes de Producao
* Herda de RelatorioBase
*
* Filtros: Periodo, Grupo, Conta, Envelope, Codigo NCF, Ordem, Percentual
* Tabela principal: SigOpInc (joins: SigCdNcf, SigCdCli)
* Reports: SigReAu1 (listagem), SigReAu2 (percentual)
*==============================================================================

DEFINE CLASS SIGREAUPBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigOpInc"
    this_cCampoChave    = ""
    this_cMensagemErro  = ""

    *-- Filtros de periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro de grupo (codigo + descricao para lookup bidirecional)
    this_cGrupo         = ""
    this_cDGrupo        = ""

    *-- Filtro de conta (codigo + descricao para lookup bidirecional)
    this_cConta         = ""
    this_cDConta        = ""

    *-- Filtro de envelope (numerico)
    this_nEnvelope      = 0

    *-- Filtro de codigo NCF
    this_cCodigo        = ""

    *-- Opcao de ordem: 1=Grupo/Conta, 2=Tipo de Autorizacao
    this_nOrdem         = 1

    *-- Exibir em percentual: 0=nao, 1=sim
    this_nPercent       = 0

    *-- Nome do cursor principal de dados gerado por PrepararDados
    this_cCursorDados   = "cursor_4c_SigOpInc"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data Inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data Final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "A Data Final n" + CHR(227) + "o pode ser menor que a Inicial!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio
    * Replica logica do procedimento 'processamento' do legado:
    *   1. Carrega nome da empresa para cabecalho
    *   2. Cria cursor_4c_Cabecalho com titulo/subtitulo
    *   3. Executa query principal em SigOpInc (joins SigCdNcf, SigCdCli)
    *   4. Transforma cursor: percentual (TmpInc) ou listagem (Selecao+index)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cEmp, loc_cCab, loc_cSub
        LOCAL loc_nQbr, loc_nWQtd

        loc_lSucesso  = .F.
        loc_nWQtd     = 0
        loc_nQbr      = THIS.this_nOrdem
        THIS.this_cMensagemErro = ""

        TRY
            *-- 1. Nome da empresa para cabecalho (via go_4c_Sistema)
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- 2. Monta cabecalho e subtitulo do relatorio
            loc_cCab = "Relat" + CHR(243) + "rio de Tipo de Autoriza" + ;
                       CHR(231) + CHR(245) + "es"
            loc_cSub = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                       " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)
            IF !EMPTY(THIS.this_cGrupo)
                loc_cSub = loc_cSub + " - Grupo : " + ALLTRIM(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cSub = loc_cSub + " - Contas : " + ALLTRIM(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cSub = loc_cSub + " - Envelope : " + ALLTRIM(STR(THIS.this_nEnvelope))
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cSub = loc_cSub + " - C" + CHR(243) + "digo : " + ALLTRIM(THIS.this_cCodigo)
            ENDIF

            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho ;
                (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)
            SET NULL OFF

            *-- 3. Monta clausula WHERE da query principal
            loc_cWhere = "a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                         " AND a.Datas < DATEADD(day, 1, " + ;
                         FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                         " AND a.Cods = b.Cods" + ;
                         " AND (b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                         " OR b.Emps = '  ')" + ;
                         " AND a.Contas = d.IClis" + ;
                         " AND a.Cpros = ' '"

            IF !EMPTY(THIS.this_cGrupo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Grupos = " + EscaparSQL(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Cods = " + EscaparSQL(THIS.this_cCodigo)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Nenvs = " + TRANSFORM(THIS.this_nEnvelope)
            ENDIF

            *-- 4. Query principal: SigOpInc + SigCdNcf + SigCdCli
            loc_cSQL = "SELECT a.*, d.RClis, b.Descs AS DescTabs, b.fixos " + ;
                       "FROM SigOpInc a, SigCdNcf b, SigCdCli d " + ;
                       "WHERE " + loc_cWhere + " " + ;
                       "ORDER BY a.Grupos, a.Contas, a.Datas, a.Nenvs, a.Cods"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de autoriza" + ;
                    CHR(231) + CHR(245) + "es de produ" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- 5. Transforma cursor conforme modo: percentual ou listagem
            IF THIS.this_nPercent = 1

                SELECT (THIS.this_cCursorDados)
                SUM 1 TO loc_nWQtd

                IF loc_nWQtd > 0
                    SELECT Cods, ;
                           IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, ;
                           IIF(loc_nQbr = 1, Grupos, SPACE(10)) AS Grupos, ;
                           IIF(loc_nQbr = 1, Contas, SPACE(10)) AS Contas, ;
                           SUM(1) AS Qtds, ;
                           SUM(1 / loc_nWQtd * 100.00) AS Percs ;
                    FROM (THIS.this_cCursorDados) ;
                    INTO CURSOR cursor_4c_TmpInc ;
                    GROUP BY 1, 2, 3, 4 ;
                    ORDER BY 1, 2, 3, 4
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_TmpInc ;
                        (Cods C(10), DescTabs C(50), Grupos C(10), ;
                         Contas C(10), Qtds N(10,0), Percs N(10,2))
                    SET NULL OFF
                ENDIF

            ELSE

                SELECT IIF(loc_nQbr = 1, ;
                           Grupos + "/" + Contas + "-" + RClis, ;
                           Cods + "-" + IIF(fixos <> 2, DescTabs, Descs)) AS Quebra1, ;
                       IIF(loc_nQbr = 1, ;
                           Cods + "-" + DescTabs, ;
                           Grupos + "/" + Contas + "-" + RClis) AS Quebra2, ;
                       IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, * ;
                FROM (THIS.this_cCursorDados) ;
                INTO CURSOR cursor_4c_Selecao

                SELECT cursor_4c_Selecao
                INDEX ON Quebra1 + Quebra2 + DTOS(Datas) + STR(Nenvs, 10) TAG Ordem
                GO TOP

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
            THIS.RegistrarAuditoria("VISUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Prepara dados e envia direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINTER NOCONSOLE
            THIS.RegistrarAuditoria("DOCUMENTO")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros principais + periodo
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa, loc_cTipo

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cTipo = IIF(THIS.this_nPercent = 1, "PERCENT", "LISTAGEM") + ;
                    "/ORD" + ALLTRIM(STR(THIS.this_nOrdem))

        loc_cChave = loc_cEmpresa + "/" + loc_cTipo + "/" + ;
                     DTOC(THIS.this_dDtInicial) + "/" + ;
                     DTOC(THIS.this_dDtFinal)

        IF !EMPTY(THIS.this_cGrupo)
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(THIS.this_cConta)
            loc_cChave = loc_cChave + "/C:" + ALLTRIM(THIS.this_cConta)
        ENDIF

        IF !EMPTY(THIS.this_cCodigo)
            loc_cChave = loc_cChave + "/N:" + ALLTRIM(THIS.this_cCodigo)
        ENDIF

        IF THIS.this_nEnvelope > 0
            loc_cChave = loc_cChave + "/E:" + ALLTRIM(STR(THIS.this_nEnvelope))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * par_cOperacao: VISUALIZAR, IMPRIMIR, DOCUMENTO, EXPORTAR
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAUP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida via SQLEXEC sobre o
    *     periodo filtrado (cursor_4c_Cabecalho, cursor_4c_TmpInc, cursor_4c_Selecao)
    *   - Imprimir() / Visualizar() / Documento() consomem esses cursores
    *     atraves dos .FRX SigReAu1 (listagem) / SigReAu2 (percentual)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores auxiliares abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigOpInc")
            USE IN cursor_4c_SigOpInc
        ENDIF
        IF USED("cursor_4c_TmpInc")
            USE IN cursor_4c_TmpInc
        ENDIF
        IF USED("cursor_4c_Selecao")
            USE IN cursor_4c_Selecao
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
