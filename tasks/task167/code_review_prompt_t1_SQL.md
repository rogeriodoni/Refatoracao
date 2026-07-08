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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1541 linhas total):

*-- Linhas 499 a 517:
499:             .HighlightBackColor = RGB(255, 255, 255)
500:             .HighlightForeColor = RGB(15, 41, 104)
501:             .HighlightStyle     = 2
502:             .DeleteMark         = .F.
503:             .RecordMark         = .F.
504:             .RowHeight          = 16
505:             .ScrollBars         = 2
506:             .ReadOnly           = .T.
507: 
508:             WITH .Column1
509:                 .Width               = 70
510:                 .Alignment           = 2
511:                 .Header1.Caption     = "Envelope"
512:                 .Text1.FontName      = "Verdana"
513:                 .Text1.FontSize      = 8
514:                 .Text1.Alignment     = 2
515:             ENDWITH
516: 
517:             WITH .Column2

*-- Linhas 744 a 769:
744:         WITH loc_oGrid
745:             .ColumnCount           = 8
746:             .RecordSource          = "cursor_4c_Dados"
747:             .Column1.ControlSource = "cursor_4c_Dados.Nenvs"
748:             .Column2.ControlSource = "cursor_4c_Dados.Nops"
749:             .Column3.ControlSource = "cursor_4c_Dados.Ordems"
750:             .Column4.ControlSource = "cursor_4c_Dados.TempoReal"
751:             .Column5.ControlSource = "cursor_4c_Dados.Cpros"
752:             .Column6.ControlSource = "cursor_4c_Dados.Pedido"
753:             .Column7.ControlSource = "cursor_4c_Dados.cliente"
754:             .Column8.ControlSource = "cursor_4c_Dados.UniPrdts"
755: 
756:             *-- Redefine cabecalhos (RecordSource reseta headers)
757:             .Column1.Header1.Caption = "Envelope"
758:             .Column2.Header1.Caption = "O.P."
759:             .Column3.Header1.Caption = "Seq"
760:             .Column4.Header1.Caption = "Minutos"
761:             .Column5.Header1.Caption = "Produto"
762:             .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
763:             .Column7.Header1.Caption = "Cliente"
764:             .Column8.Header1.Caption = "Unidade Prod."
765: 
766:             *-- Ordem visual: Column8=UniPrdts na 1a posicao (conforme SCX original)
767:             .Column1.ColumnOrder = 2
768:             .Column2.ColumnOrder = 3
769:             .Column3.ColumnOrder = 4

*-- Linhas 856 a 874:
856: 
857:         *-- Atualiza detalhe da linha no container de Page2
858:         IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha") = "O" AND USED("cursor_4c_Dados")
859:             SELECT cursor_4c_Dados
860:             IF !EOF()
861:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha
862:                     .txt_4c_Nenvs2.Value = NVL(cursor_4c_Dados.Nenvs,    0)
863:                     .txt_4c_Nops2.Value  = NVL(cursor_4c_Dados.Nops,     0)
864:                     .txt_4c_Seqs2.Value  = NVL(cursor_4c_Dados.Seqs,     0)
865:                     .txt_4c_TReal2.Value = NVL(cursor_4c_Dados.TempoReal, 0)
866:                     .txt_4c_Dopes2.Value = ALLTRIM(NVL(cursor_4c_Dados.Dopes,    ""))
867:                     .txt_4c_UniP2.Value  = ALLTRIM(NVL(cursor_4c_Dados.UniPrdts, ""))
868:                     .txt_4c_Rclis2.Value = ALLTRIM(NVL(cursor_4c_Dados.Rclis,    ""))
869:                     .Visible     = .T.
870:                 ENDWITH
871:             ENDIF
872:         ENDIF
873: 
874:         *-- Atualiza campos de Page2 (configurada em ConfigurarPaginaDados - Fase 5)

*-- Linhas 1274 a 1292:
1274:             IF THIS.CarregarDados()
1275:                 IF USED("cursor_4c_Dados")
1276:                     THIS.AtualizarGrid()
1277:                     SELECT cursor_4c_Dados
1278:                     GO TOP
1279:                     THIS.GrdDadosAfterRowColChange(0)
1280:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1281:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1282:                     ENDIF
1283:                 ENDIF
1284:                 THIS.pgf_4c_Paginas.Visible = .T.
1285:                 THIS.pgf_4c_Paginas.ActivePage = 1
1286:             ENDIF
1287:             THIS.LockScreen = .F.
1288:         CATCH TO loc_oErro
1289:             THIS.LockScreen = .F.
1290:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1291:         ENDTRY
1292:     ENDPROC

*-- Linhas 1303 a 1321:
1303:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1304:                 RETURN
1305:             ENDIF
1306:             SELECT cursor_4c_Dados
1307:             IF EOF() OR RECCOUNT() = 0
1308:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1309:                 RETURN
1310:             ENDIF
1311: 
1312:             *-- Garante que campos de detalhe estao populados com a linha corrente
1313:             THIS.GrdDadosAfterRowColChange(0)
1314:             THIS.pgf_4c_Paginas.ActivePage = 2
1315:         CATCH TO loc_oErro
1316:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
1317:         ENDTRY
1318:     ENDPROC
1319: 
1320:     *==========================================================================
1321:     * BtnVisualizarClick - Alterna para Page2 (detalhe do registro selecionado)

*-- Linhas 1328 a 1346:
1328:                 MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
1329:                 RETURN
1330:             ENDIF
1331:             SELECT cursor_4c_Dados
1332:             IF EOF() OR RECCOUNT() = 0
1333:                 MsgAviso("Selecione um registro do grid.", "Aviso")
1334:                 RETURN
1335:             ENDIF
1336: 
1337:             *-- Popula Page2 com o registro corrente e navega
1338:             THIS.GrdDadosAfterRowColChange(0)
1339:             THIS.pgf_4c_Paginas.ActivePage = 2
1340:         CATCH TO loc_oErro
1341:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1342:         ENDTRY
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     * BtnExcluirClick - Encerra a consulta e fecha o formulario

*-- Linhas 1362 a 1380:
1362:         loc_lSucesso = THIS.CarregarDados()
1363:         IF loc_lSucesso AND USED("cursor_4c_Dados")
1364:             THIS.AtualizarGrid()
1365:             SELECT cursor_4c_Dados
1366:             GO TOP
1367:             THIS.GrdDadosAfterRowColChange(0)
1368:             IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1369:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1370:             ENDIF
1371:         ENDIF
1372:         RETURN loc_lSucesso
1373:     ENDPROC
1374: 
1375:     *==========================================================================
1376:     * FormParaBO - Transfere parametros do form para o BO antes de consultar
1377:     *==========================================================================
1378:     PROCEDURE FormParaBO()
1379:         WITH THIS.this_oBusinessObject
1380:             .this_nCodigo  = THIS.this_nCodigo

*-- Linhas 1482 a 1500:
1482:             IF THIS.CarregarDados()
1483:                 IF USED("cursor_4c_Dados")
1484:                     THIS.AtualizarGrid()
1485:                     SELECT cursor_4c_Dados
1486:                     GO TOP
1487:                     THIS.GrdDadosAfterRowColChange(0)
1488:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
1489:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1490:                     ENDIF
1491:                 ENDIF
1492:                 THIS.pgf_4c_Paginas.Visible = .T.
1493:                 THIS.pgf_4c_Paginas.ActivePage = 1
1494:             ENDIF
1495:             THIS.LockScreen = .F.
1496:         CATCH TO loc_oErro
1497:             THIS.LockScreen = .F.
1498:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
1499:         ENDTRY
1500:     ENDPROC


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

