# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PNCOD, CODIGOS, DATAS, FASES, UNIPRDTS, CONTAS, CPROS, UNIDADE

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
		lcSql = [Select * From SigCdPcz Where codigos = ]+Str(pnCod)
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcp') < 1)
		lcSql = [Select Codigos, Sum(minutos) as Minutos, sum(minutos-Saldos) as UtilizadoS, Sum(saldos) as Saldos ]+;
				[From SigCdPcP Where Codigos = ]+Str(pncod)+[ And Datas = ?pDataI And Fases = ']+pFase+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcpcp') < 1)
		lcSql = [Select * from SigCdPcg Where datas = ?pDatai And Fases = ']+pFase+[' And Codigos = ]+Str(pnCod)+[ ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcppp') < 1)
		lcSql = [Select a.*, a.dopes+'-'+Str(a.numes,6) as Pedido, a.contas+'-'+b.rclis as cliente, b.Rclis ]+;
				[From SigCdPco a, SigCdCli b ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcpOP2') < 1)
		Select a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, sum(a.Minutos) as Minutos From zTmpPcpOp2 a, zTmpPcpPP b ;
		Select a.*, b.Minutos as TempU, c.Minutos as TempoO, fStoM((a.minutos*60)/(c.minutos*60)*(b.minutos*60)) as TempoReal;
		From zTmpPcpOp2 a, zTmpPcpPp b, zTmpPcpOp3 c ;
Select zTmpPcpOp
	.Column1.ControlSource = 'zTmpPcpOp.nenvs'
	.Column2.Controlsource = 'zTmpPcpOp.Nops'
	.Column3.Controlsource = 'zTmpPcpOp.ordems'
	.Column4.Controlsource = 'zTmpPcpOp.TempoReal' &&'zTmpPcpOp.Minutos'
	.Column5.Controlsource = 'zTmpPcpOp.Cpros'
	.Column6.Controlsource = 'zTmpPcpOp.Pedido'
	.Column7.Controlsource = 'zTmpPcpOp.Cliente'
	.Column8.Controlsource = 'zTmpPcpOp.UniPrdts'
lcQuery = [Select FigJpgs, Dpros From SigCdPro Where Cpros= ']+zTmpPcpOp.Cpros+[']
=ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTmpPro')
Select zTmpPcpOp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1545 linhas total):

*-- Linhas 502 a 520:
502:             .HighlightBackColor = RGB(255, 255, 255)
503:             .HighlightForeColor = RGB(15, 41, 104)
504:             .HighlightStyle     = 2
505:             .DeleteMark         = .F.
506:             .RecordMark         = .F.
507:             .RowHeight          = 16
508:             .ScrollBars         = 2
509:             .ReadOnly           = .T.
510: 
511:             WITH .Column1
512:                 .Width               = 70
513:                 .Alignment           = 2
514:                 .Header1.Caption     = "Envelope"
515:                 .Text1.FontName      = "Verdana"
516:                 .Text1.FontSize      = 8
517:                 .Text1.Alignment     = 2
518:             ENDWITH
519: 
520:             WITH .Column2

*-- Linhas 747 a 772:
747:         loc_oGrid.ColumnCount  = 8
748:         loc_oGrid.RecordSource = "cursor_4c_Dados"
749:         WITH loc_oGrid
750:             .Column1.ControlSource = "cursor_4c_Dados.Nenvs"
751:             .Column2.ControlSource = "cursor_4c_Dados.Nops"
752:             .Column3.ControlSource = "cursor_4c_Dados.Ordems"
753:             .Column4.ControlSource = "cursor_4c_Dados.TempoReal"
754:             .Column5.ControlSource = "cursor_4c_Dados.Cpros"
755:             .Column6.ControlSource = "cursor_4c_Dados.Pedido"
756:             .Column7.ControlSource = "cursor_4c_Dados.cliente"
757:             .Column8.ControlSource = "cursor_4c_Dados.UniPrdts"
758: 
759:             *-- Redefine cabecalhos (RecordSource reseta headers)
760:             .Column1.Header1.Caption = "Envelope"
761:             .Column2.Header1.Caption = "O.P."
762:             .Column3.Header1.Caption = "Seq"
763:             .Column4.Header1.Caption = "Minutos"
764:             .Column5.Header1.Caption = "Produto"
765:             .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
766:             .Column7.Header1.Caption = "Cliente"
767:             .Column8.Header1.Caption = "Unidade Prod."
768: 
769:             *-- Ordem visual: Column8=UniPrdts na 1a posicao (conforme SCX original)
770:             .Column1.ColumnOrder = 2
771:             .Column2.ColumnOrder = 3
772:             .Column3.ColumnOrder = 4

*-- Linhas 859 a 877:
859: 
860:         *-- Atualiza detalhe da linha no container de Page2
861:         IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha") = "O" AND USED("cursor_4c_Dados")
862:             SELECT cursor_4c_Dados
863:             IF !EOF()
864:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha
865:                     .txt_4c_Nenvs2.Value = NVL(cursor_4c_Dados.Nenvs,    0)
866:                     .txt_4c_Nops2.Value  = NVL(cursor_4c_Dados.Nops,     0)
867:                     .txt_4c_Seqs2.Value  = NVL(cursor_4c_Dados.Seqs,     0)
868:                     .txt_4c_TReal2.Value = NVL(cursor_4c_Dados.TempoReal, 0)
869:                     .txt_4c_Dopes2.Value = ALLTRIM(NVL(cursor_4c_Dados.Dopes,    ""))
870:                     .txt_4c_UniP2.Value  = ALLTRIM(NVL(cursor_4c_Dados.UniPrdts, ""))
871:                     .txt_4c_Rclis2.Value = ALLTRIM(NVL(cursor_4c_Dados.Rclis,    ""))
872:                     .Visible     = .T.
873:                 ENDWITH
874:             ENDIF
875:         ENDIF
876: 
877:         *-- Atualiza campos de Page2 (configurada em ConfigurarPaginaDados - Fase 5)

*-- Linhas 1278 a 1296:
1278:             IF THIS.CarregarDados()
1279:                 IF USED("cursor_4c_Dados")
1280:                     THIS.AtualizarGrid()
1281:                     SELECT cursor_4c_Dados
1282:                     GO TOP
1283:                     THIS.GrdDadosAfterRowColChange(0)
1284:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1285:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1286:                     ENDIF
1287:                 ENDIF
1288:                 THIS.pgf_4c_Paginas.Visible = .T.
1289:                 THIS.pgf_4c_Paginas.ActivePage = 1
1290:             ENDIF
1291:             THIS.LockScreen = .F.
1292:         CATCH TO loc_oErro
1293:             THIS.LockScreen = .F.
1294:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1295:         ENDTRY
1296:     ENDPROC

*-- Linhas 1307 a 1325:
1307:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1308:                 RETURN
1309:             ENDIF
1310:             SELECT cursor_4c_Dados
1311:             IF EOF() OR RECCOUNT() = 0
1312:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1313:                 RETURN
1314:             ENDIF
1315: 
1316:             *-- Garante que campos de detalhe estao populados com a linha corrente
1317:             THIS.GrdDadosAfterRowColChange(0)
1318:             THIS.pgf_4c_Paginas.ActivePage = 2
1319:         CATCH TO loc_oErro
1320:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
1321:         ENDTRY
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * BtnVisualizarClick - Alterna para Page2 (detalhe do registro selecionado)

*-- Linhas 1332 a 1350:
1332:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1333:                 RETURN
1334:             ENDIF
1335:             SELECT cursor_4c_Dados
1336:             IF EOF() OR RECCOUNT() = 0
1337:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1338:                 RETURN
1339:             ENDIF
1340: 
1341:             *-- Popula Page2 com o registro corrente e navega
1342:             THIS.GrdDadosAfterRowColChange(0)
1343:             THIS.pgf_4c_Paginas.ActivePage = 2
1344:         CATCH TO loc_oErro
1345:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1346:         ENDTRY
1347:     ENDPROC
1348: 
1349:     *==========================================================================
1350:     * BtnExcluirClick - Encerra a consulta e fecha o formulario

*-- Linhas 1366 a 1384:
1366:         loc_lSucesso = THIS.CarregarDados()
1367:         IF loc_lSucesso AND USED("cursor_4c_Dados")
1368:             THIS.AtualizarGrid()
1369:             SELECT cursor_4c_Dados
1370:             GO TOP
1371:             THIS.GrdDadosAfterRowColChange(0)
1372:             IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1373:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1374:             ENDIF
1375:         ENDIF
1376:         RETURN loc_lSucesso
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     * FormParaBO - Transfere parametros do form para o BO antes de consultar
1381:     *==========================================================================
1382:     PROCEDURE FormParaBO()
1383:         WITH THIS.this_oBusinessObject
1384:             .this_nCodigo  = THIS.this_nCodigo

*-- Linhas 1486 a 1504:
1486:             IF THIS.CarregarDados()
1487:                 IF USED("cursor_4c_Dados")
1488:                     THIS.AtualizarGrid()
1489:                     SELECT cursor_4c_Dados
1490:                     GO TOP
1491:                     THIS.GrdDadosAfterRowColChange(0)
1492:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1493:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1494:                     ENDIF
1495:                 ENDIF
1496:                 THIS.pgf_4c_Paginas.Visible = .T.
1497:                 THIS.pgf_4c_Paginas.ActivePage = 1
1498:             ENDIF
1499:             THIS.LockScreen = .F.
1500:         CATCH TO loc_oErro
1501:             THIS.LockScreen = .F.
1502:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
1503:         ENDTRY
1504:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*==============================================================================
* sigprcpdBO.prg - Business Object para Capacidade Produtiva
* Form OPERACIONAL (consulta somente leitura - sem CRUD)
* Tabelas: SigCdPcz, SigCdPcP, SigCdPcg, SigCdPco, SigCdCli, SigCdPro
*==============================================================================
DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Parametros de consulta (recebidos do chamador via Form.Init)
    this_nCodigo    = 0
    this_cFase      = ""
    this_cUnidade   = ""
    this_dData      = {}

    *-- Resumo de capacidade (vindos de SigCdPcP agrupado)
    this_nCapacidade  = 0
    this_nUtilizado   = 0
    this_nSaldo       = 0

    *-- Detalhe do produto selecionado no grid (SigCdPro)
    this_cDescricaoProduto = ""
    this_cFotoBase64       = ""
    this_cCaminhoFoto      = ""

    *-- Detalhe do envelope/linha selecionada no grid (cursor_4c_Dados)
    this_nQuantidade    = 0
    this_cCliente       = ""
    this_nTempoEnvelope = 0
    this_cProduto       = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigCdPcz"
        this_cCampoChave = "codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega todos os cursores de capacidade produtiva
    *   par_nCodigo  - Codigo do processo (SigCdPcz.codigos)
    *   par_cFase    - Fase/setor de producao
    *   par_cUnidade - Unidade produtiva (vazio = todas as unidades)
    *   par_dData    - Data de consulta
    * Retorna .T. se sucesso, .F. se falha
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_nCodigo, par_cFase, par_cUnidade, par_dData)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cFiltroUnid

        loc_lSucesso    = .F.
        loc_cFiltroUnid = IIF(EMPTY(par_cUnidade), "", " And UniPrdts = " + EscaparSQL(par_cUnidade))

        THIS.this_nCodigo  = par_nCodigo
        THIS.this_cFase    = par_cFase
        THIS.this_cUnidade = par_cUnidade
        THIS.this_dData    = par_dData

        TRY
            *-- 1. Dados basicos do processo (SigCdPcz)
            IF USED("cursor_4c_Pcp")
                USE IN cursor_4c_Pcp
            ENDIF

            loc_cSQL = "Select * From SigCdPcz Where codigos = " + TRANSFORM(par_nCodigo)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcp")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar dados do processo (SigCdPcz).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Resumo de capacidade (SigCdPcP agrupado)
            IF USED("cursor_4c_Capacidade")
                USE IN cursor_4c_Capacidade
            ENDIF

            loc_cSQL = "Select Codigos, Sum(minutos) as Minutos, " + ;
                       "sum(minutos-Saldos) as UtilizadoS, Sum(saldos) as Saldos " + ;
                       "From SigCdPcP " + ;
                       "Where Codigos = " + TRANSFORM(par_nCodigo) + ;
                       " And Datas = " + FormatarDataSQL(par_dData) + ;
                       " And Fases = " + EscaparSQL(par_cFase) + ;
                       loc_cFiltroUnid + ;
                       " Group by Codigos"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Capacidade")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar capacidade (SigCdPcP).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("cursor_4c_Capacidade") > 0
                SELECT cursor_4c_Capacidade
                GO TOP
                THIS.this_nCapacidade = NVL(cursor_4c_Capacidade.Minutos,    0)
                THIS.this_nUtilizado  = NVL(cursor_4c_Capacidade.UtilizadoS, 0)
                THIS.this_nSaldo      = NVL(cursor_4c_Capacidade.Saldos,     0)
            ELSE
                THIS.this_nCapacidade = 0
                THIS.this_nUtilizado  = 0
                THIS.this_nSaldo      = 0
            ENDIF

            *-- 3. Itens individuais de programacao por item (SigCdPcg)
            IF USED("cursor_4c_PcpPp")
                USE IN cursor_4c_PcpPp
            ENDIF

            loc_cSQL = "Select * from SigCdPcg " + ;
                       "Where datas = " + FormatarDataSQL(par_dData) + ;
                       " And Fases = " + EscaparSQL(par_cFase) + ;
                       " And Codigos = " + TRANSFORM(par_nCodigo) + ;
                       loc_cFiltroUnid + ;
                       " Order by Cidchaves"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpPp")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar programa" + CHR(231) + CHR(227) + "o (SigCdPcg).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 4. Ordens de producao com clientes (SigCdPco + SigCdCli)
            IF USED("cursor_4c_PcpOp2")
                USE IN cursor_4c_PcpOp2
            ENDIF

            loc_cSQL = "Select a.*, " + ;
                       "a.dopes+'-'+RTRIM(STR(a.numes,6)) as Pedido, " + ;
                       "a.contas+'-'+b.rclis as cliente, b.Rclis " + ;
                       "From SigCdPco a, SigCdCli b " + ;
                       "Where a.Codigos = " + TRANSFORM(par_nCodigo) + ;
                       " And a.Fases = " + EscaparSQL(par_cFase) + ;
                       STRTRAN(loc_cFiltroUnid, " UniPrdts", " a.UniPrdts") + ;
                       " And a.Contas = b.Iclis " + ;
                       "Order by a.UniPrdts, a.Seqs, a.Nenvs"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpOp2")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar ordens de produ" + CHR(231) + CHR(227) + "o (SigCdPco).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 5. Agrega minutos por (Fases, UniPrdts, Nenvs, Seqs) via VFP SELECT local
            IF USED("cursor_4c_PcpOp3")
                USE IN cursor_4c_PcpOp3
            ENDIF

            SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, ;
                   SUM(a.Minutos) AS Minutos ;
            FROM cursor_4c_PcpOp2 a, cursor_4c_PcpPp b ;
            WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
            INTO CURSOR cursor_4c_PcpOp3 READWRITE ;
            GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs

            *-- 6. Cursor final para o grid: combina dados com proporcionalidade de tempo
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            SET NULL ON
            SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                   fStoM((a.Minutos*60)/(c.Minutos*60)*(b.Minutos*60)) AS TempoReal ;
            FROM cursor_4c_PcpOp2 a, cursor_4c_PcpPp b, cursor_4c_PcpOp3 c ;
            WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
            AND   a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  c.Fases + c.UniPrdts + STR(c.Nenvs,10) + STR(c.Seqs,2) ;
            INTO CURSOR cursor_4c_Dados READWRITE ;
            ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs
            SET NULL OFF

            IF RECCOUNT("cursor_4c_Dados") > 0
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da linha atual do cursor_4c_Dados para
    * as propriedades da BO. Chamado pelo form em AfterRowColChange do grid,
    * antes de atualizar os labels de descricao, quantidade, cliente e tempo.
    *   par_cAliasCursor - Alias do cursor (normalmente "cursor_4c_Dados")
    * Retorna .T. se carregou, .F. se cursor nao existe ou esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Dados", par_cAliasCursor)

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        IF EOF() OR BOF() OR RECCOUNT() = 0
            RETURN .F.
        ENDIF

        *-- Chave do envelope/linha selecionada
        IF TYPE(loc_cAlias + ".Nenvs")    != "U"
            THIS.this_nCodigo = NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0)
        ENDIF

        *-- Produto (para lookup em ObterDetalheProduto)
        IF TYPE(loc_cAlias + ".Cpros") != "U"
            THIS.this_cProduto = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Cpros"), ""))
        ENDIF

        *-- Quantidade (Qtds da OP)
        IF TYPE(loc_cAlias + ".Qtds") != "U"
            THIS.this_nQuantidade = NVL(EVALUATE(loc_cAlias + ".Qtds"), 0)
        ENDIF

        *-- Cliente (Rclis - razao social)
        IF TYPE(loc_cAlias + ".Rclis") != "U"
            THIS.this_cCliente = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Rclis"), ""))
        ENDIF

        *-- Tempo do envelope (TempU calculado em CarregarDados)
        IF TYPE(loc_cAlias + ".TempU") != "U"
            THIS.this_nTempoEnvelope = NVL(EVALUATE(loc_cAlias + ".TempU"), 0)
        ENDIF

        *-- Unidade produtiva (UniPrdts)
        IF TYPE(loc_cAlias + ".UniPrdts") != "U"
            THIS.this_cUnidade = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".UniPrdts"), ""))
        ENDIF

        *-- Fase (Fases)
        IF TYPE(loc_cAlias + ".Fases") != "U"
            THIS.this_cFase = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Fases"), ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Override BusinessBase.
    * Form SIGPRCPD e OPERACIONAL de consulta somente leitura: a tela apenas
    * exibe capacidade produtiva vinda de SigCdPcz/SigCdPcP/SigCdPcg/SigCdPco.
    * Nao ha INSERT em nenhuma tabela no codigo legado. Sobrescrever para
    * bloquear qualquer chamada acidental via BusinessBase.Salvar() e informar
    * o motivo de forma explicita.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Capacidade Produtiva " + CHR(233) + ;
            " uma tela de consulta somente leitura. " + ;
            "Opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + "o n" + ;
            CHR(227) + "o " + CHR(233) + " suportada por este processo."
        MsgAviso(THIS.this_cMensagemErro, "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Override BusinessBase.
    * Mesmo motivo de Inserir(): SIGPRCPD nao altera dados persistidos. Todas
    * as tabelas envolvidas sao apenas lidas (Select * From SigCdPcz, etc.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Capacidade Produtiva " + CHR(233) + ;
            " uma tela de consulta somente leitura. " + ;
            "Opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o n" + ;
            CHR(227) + "o " + CHR(233) + " suportada por este processo."
        MsgAviso(THIS.this_cMensagemErro, "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override para log de consulta.
    * Como o form eh read-only, registramos apenas a operacao "CONSULTA"
    * para rastrear quem acessou a capacidade produtiva de qual processo.
    *   par_cOperacao - Descartado (sempre gravamos "CONSULTA")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + ;
                   EscaparSQL(THIS.this_cTabela)                     + ", " + ;
                   EscaparSQL("CONSULTA")                            + ", " + ;
                   EscaparSQL(loc_cChave)                            + ", " + ;
                   EscaparSQL(loc_cUsuario)                          + ", " + ;
                   "GETDATE())"

        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDetalheProduto - Carrega foto e descricao do produto da linha atual
    *   par_cCpros    - Codigo do produto (SigCdPro.Cpros)
    * Retorna .T. se produto encontrado com foto valida
    *--------------------------------------------------------------------------
    PROCEDURE ObterDetalheProduto(par_cCpros)
        LOCAL loc_lTemFoto, loc_cSQL, loc_nRet
        LOCAL loc_cFotoBase64, loc_cArquivo

        loc_lTemFoto = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "Select FigJpgs, Dpros From SigCdPro " + ;
                       "Where Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_Produto") > 0
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cDescricaoProduto = NVL(cursor_4c_Produto.Dpros,   "")
                THIS.this_cFotoBase64       = NVL(cursor_4c_Produto.FigJpgs, "")

                IF !EMPTY(THIS.this_cFotoBase64)
                    loc_cFotoBase64 = THIS.this_cFotoBase64
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/png;base64,",  "")
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/jpeg;base64,", "")
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/jpg;base64,",  "")

                    loc_cArquivo    = SYS(2023) + "\sigprcpd.jpg"
                    loc_cFotoBase64 = STRCONV(loc_cFotoBase64, 14)

                    IF STRTOFILE(loc_cFotoBase64, loc_cArquivo) > 0
                        THIS.this_cCaminhoFoto = loc_cArquivo
                        loc_lTemFoto           = .T.
                    ELSE
                        THIS.this_cCaminhoFoto = ""
                    ENDIF
                ELSE
                    THIS.this_cCaminhoFoto = ""
                ENDIF
            ELSE
                THIS.this_cDescricaoProduto = ""
                THIS.this_cFotoBase64       = ""
                THIS.this_cCaminhoFoto      = ""
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lTemFoto
    ENDPROC

ENDDEFINE

*==============================================================================
* fStoM - Converte segundos em minutos (replica funcao fStoM do framework legado)
* Usada nos VFP SELECTs locais dentro de CarregarDados
*==============================================================================
FUNCTION fStoM(par_nSegundos)
    IF VARTYPE(par_nSegundos) != "N" OR par_nSegundos = 0
        RETURN 0
    ENDIF
    RETURN INT(par_nSegundos / 60)
ENDFUNC

