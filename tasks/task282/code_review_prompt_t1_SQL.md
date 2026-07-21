# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS

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
  Pagina.Lista.Grade.Column2.ControlSource = ""
  Pagina.Lista.Grade.Column3.ControlSource = ""
  Pagina.Lista.Grade.Column4.ControlSource = ""
  Pagina.Lista.Grade.Column5.ControlSource = ""
  Pagina.Lista.Grade.Column6.ControlSource = ""
  Pagina.Lista.Grade.Column7.ControlSource = ""
  ControlSource = "xEestI.DPros"
  DeleteMark = .F.
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column10.SelectOnEntry = .T.
  ControlSource = "xeesti.citens"
  ControlSource = "csTemporario.grupoos"
  ControlSource = "csTemporario.contaos"
  ControlSource = ""
  ControlSource = "csTemporario.grupods"
  ControlSource = "csTemporario.contads"
  ControlSource = ""
  ControlSource = "csTemporario.Vends"
  ControlSource = ""
  ControlSource = "csTemporario.grvends"
  ControlSource = "csTemporario.tabds"
  ControlSource = "csTemporario.pstatus"
  ControlSource = "xEestI.OBS"
  ControlSource = "csTemporario.nops"
  ControlSource = "csTemporario.prazoents"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "tmpoperacao.codigos"
  ControlSource = "csTemporario.mascnum"
  ControlSource = "csTemporario.notas"
  ControlSource = "CsTemporario.datas"
  ControlSource = "csTemporario.obses"
	.Column1.ControlSource = 'csTemporario.Numes'
	.Column2.ControlSource = 'csTemporario.Datas'
	.Column3.ControlSource = 'csTemporario.GrupoOs'
	.Column4.ControlSource = 'csTemporario.ContaOs'
	.Column5.ControlSource = 'csTemporario.GrupoDs'
	.Column6.ControlSource = 'csTemporario.ContaDs'
	.Column7.ControlSource = 'csTemporario.Nops'
	.Column8.ControlSource = 'csTemporario.Usuars'	
	.Column9.ControlSource = 'csTemporario.PStatus'
	.Column10.ControlSource = 'csTemporario.Emps'
	.Column11.ControlSource = 'csTemporario.Empds'
		.Column1.ControlSource = 'xEestI.Cpros'
		.Column3.ControlSource = 'xEestI.Qtds'
		.Column5.ControlSource = 'xEestI.QtBaixas'
		.Column4.ControlSource = 'xEestI.QtProds'
		.Column6.ControlSource = 'xEestI.QtBxProds'
		.Column2.ControlSource = 'xEestI.QtProds - xEestI.QtBxProds'
		.Column7.ControlSource = 'xEestI.CItens'
		.Column8.ControlSource = 'xEestI.TPesos'
		.Column9.ControlSource = 'xEestI.DescVals'
		.Column10.ControlSource = 'xEestI.CodTams'
		.Column1.ControlSource = 'xEestI.Cpros'
		.Column2.ControlSource = 'xEestI.QtBxProds'
		.Column3.ControlSource = 'xEestI.Qtds'
		.Column4.ControlSource = 'xEestI.Qtds - xEestI.QtBaixas'
		.Column5.ControlSource = 'xEestI.QtBaixas'
		.Column6.ControlSource = 'xEestI.QtProds'
		.Column7.ControlSource = 'xEestI.CItens'
		.Column8.ControlSource = 'xEestI.TPesos'
		.Column9.ControlSource = 'xEestI.DescVals'
		.Column10.ControlSource = 'xEestI.CodTams'
	.DeleteMark   = .f.
	.Column1.ControlSource = 'TmpOperacao.Codigos'
		Select TmpOperacao
		lcQuery = [select isnull(b.codtams,'') as codtams, isnull(b.codcors,'') as codcors, a.* ] + ;
			[from sigmvitn a ] + ;
			[left join sigmvits b on a.empdopnums = b.empdopnums ] + ; 
		.poDataMgr.SqlExecute(lcQuery,[crSigMvItn])
		.poDataMgr.SqlExecute(lcQuery,[xEestI])
		Select csTemporario
Select csTemporario
			Select csTemporario
Select crSigMvPec
	Insert Into TmpOperacao From MemVar
lcQuery = [select isnull(b.codtams,'') as codtams, isnull(b.codcors,'') as codcors, b.qtds as QtdsS, a.* ] + ;
			[from sigmvitn a ] + ;
			[left join sigmvits b on a.empdopnums = b.empdopnums ] + ; 
ThisForm.poDataMgr.SqlExecute(lcQuery,[crSigMvItn])
SELECT empdopnums, cpros, codcors, codtams, SUM(qtds) as qtds, SUM(qtdss) as qtdss, Max(qtbaixas) as qtbaixas, Max(qtprods) as qtprods, ;
from crSigMvItn group by empdopnums, cpros, codcors, codtams into cursor crSigMvItn
Select crSigMvItn
	Insert Into xEestI From Memvar
Select xEestI
Select xEestI
Select xEestI
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS SQL (2004 linhas total):

*-- Linhas 263 a 328:
263:             .HighlightBackColor = RGB(255, 255, 255)
264:             .HighlightForeColor = RGB(15, 41, 104)
265:             .HighlightStyle     = 2
266:             .DeleteMark         = .F.
267:             .RecordMark         = .F.
268:             .RowHeight          = 16
269:             .ScrollBars         = 2
270:             .GridLines          = 3
271:             .Visible            = .T.
272: 
273:             .Column1.ControlSource    = "csTemporario.Numes"
274:             .Column1.Width            = 60
275:             .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
276: 
277:             .Column2.ControlSource    = "csTemporario.Datas"
278:             .Column2.Width            = 80
279:             .Column2.Header1.Caption  = "Data"
280: 
281:             .Column3.ControlSource    = "csTemporario.GrupoOs"
282:             .Column3.Width            = 60
283:             .Column3.Header1.Caption  = "Grupo"
284: 
285:             .Column4.ControlSource    = "csTemporario.ContaOs"
286:             .Column4.Width            = 100
287:             .Column4.Header1.Caption  = "Origem"
288: 
289:             .Column5.ControlSource    = "csTemporario.GrupoDs"
290:             .Column5.Width            = 60
291:             .Column5.Header1.Caption  = "Grupo"
292: 
293:             .Column6.ControlSource    = "csTemporario.ContaDs"
294:             .Column6.Width            = 100
295:             .Column6.Header1.Caption  = "Destino"
296: 
297:             .Column7.ControlSource    = "csTemporario.Nops"
298:             .Column7.Width            = 80
299:             .Column7.Header1.Caption  = "Doc.Op"
300: 
301:             .Column8.ControlSource    = "csTemporario.Usuars"
302:             .Column8.Width            = 100
303:             .Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
304: 
305:             .Column9.ControlSource    = "csTemporario.PStatus"
306:             .Column9.Width            = 60
307:             .Column9.Header1.Caption  = "Status"
308: 
309:             .Column10.ControlSource   = "csTemporario.Emps"
310:             .Column10.Width           = 50
311:             .Column10.Header1.Caption = "EmpO"
312: 
313:             .Column11.ControlSource   = "csTemporario.Empds"
314:             .Column11.Width           = 50
315:             .Column11.Header1.Caption = "EmpD"
316:         ENDWITH
317: 
318:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", THIS, "BtnConsultarClick")
319:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
320: 
321:         THIS.FormatarGridLista(loc_oGrid)
322:         THIS.TornarControlesVisiveis(loc_oPagina)
323:     ENDPROC
324: 
325:     *--------------------------------------------------------------------------
326:     * ConfigurarPaginaDados - Page2: botoes, grade operacoes, campos header
327:     *--------------------------------------------------------------------------
328:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 408 a 426:
408:             .HighlightBackColor = RGB(255, 255, 255)
409:             .HighlightForeColor = RGB(15, 41, 104)
410:             .HighlightStyle     = 2
411:             .DeleteMark         = .F.
412:             .RecordMark         = .F.
413:             .RowHeight          = 16
414:             .ScrollBars         = 2
415:             .GridLines          = 1
416:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
417:             .Visible = .T.
418:         ENDWITH
419: 
420:         *-- cmd_4c_Entrega: botao de consulta/agendamento de entrega
421:         *-- Legado: cmdEntrega CommandGroup Top=7+29=36, Left=23, Width=90, Height=110
422:         loc_oPagina.AddObject("cmd_4c_Entrega", "CommandButton")
423:         WITH loc_oPagina.cmd_4c_Entrega
424:             .Caption       = "Entrega"
425:             .Top           = 36
426:             .Left          = 23

*-- Linhas 1069 a 1087:
1069:             .HighlightBackColor = RGB(255, 255, 255)
1070:             .HighlightForeColor = RGB(15, 41, 104)
1071:             .HighlightStyle     = 2
1072:             .DeleteMark         = .F.
1073:             .RecordMark         = .F.
1074:             .RowHeight          = 16
1075:             .ScrollBars         = 2
1076:             .GridLines          = 3
1077:             .Column1.Header1.Caption  = "Produto"
1078:             .Column1.Width            = 90
1079:             .Column2.Header1.Caption  = "Produzido"
1080:             .Column2.Width            = 65
1081:             .Column3.Header1.Caption  = "Qtd."
1082:             .Column3.Width            = 65
1083:             .Column4.Header1.Caption  = "Saldo"
1084:             .Column4.Width            = 65
1085:             .Column5.Header1.Caption  = "Qtd.Baixa"
1086:             .Column5.Width            = 65
1087:             .Column6.Header1.Caption  = "Produzir"

*-- Linhas 1274 a 1302:
1274:                 GO TOP IN csTemporario
1275:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1276:                 loc_oGrid.RecordSource = "csTemporario"
1277:                 loc_oGrid.Column1.ControlSource    = "csTemporario.Numes"
1278:                 loc_oGrid.Column2.ControlSource    = "csTemporario.Datas"
1279:                 loc_oGrid.Column3.ControlSource    = "csTemporario.GrupoOs"
1280:                 loc_oGrid.Column4.ControlSource    = "csTemporario.ContaOs"
1281:                 loc_oGrid.Column5.ControlSource    = "csTemporario.GrupoDs"
1282:                 loc_oGrid.Column6.ControlSource    = "csTemporario.ContaDs"
1283:                 loc_oGrid.Column7.ControlSource    = "csTemporario.Nops"
1284:                 loc_oGrid.Column8.ControlSource    = "csTemporario.Usuars"
1285:                 loc_oGrid.Column9.ControlSource    = "csTemporario.PStatus"
1286:                 loc_oGrid.Column10.ControlSource   = "csTemporario.Emps"
1287:                 loc_oGrid.Column11.ControlSource   = "csTemporario.Empds"
1288:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1289:                 loc_oGrid.Column2.Header1.Caption  = "Data"
1290:                 loc_oGrid.Column3.Header1.Caption  = "Grupo"
1291:                 loc_oGrid.Column4.Header1.Caption  = "Origem"
1292:                 loc_oGrid.Column5.Header1.Caption  = "Grupo"
1293:                 loc_oGrid.Column6.Header1.Caption  = "Destino"
1294:                 loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
1295:                 loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
1296:                 loc_oGrid.Column9.Header1.Caption  = "Status"
1297:                 loc_oGrid.Column10.Header1.Caption = "EmpO"
1298:                 loc_oGrid.Column11.Header1.Caption = "EmpD"
1299:                 loc_oGrid.Refresh()
1300:                 THIS.FormatarGridLista(loc_oGrid)
1301:                 loc_lResultado = .T.
1302:                 ENDIF

*-- Linhas 1321 a 1339:
1321:                 THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1322:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1323: 
1324:                 SELECT csTemporario
1325:                 *-- Preencher campos basicos a partir do cursor csTemporario
1326:                 loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(TRANSFORM(csTemporario.Numes))
1327:                 loc_oPg2.txt_4c_Data.Value    = IIF(EMPTY(csTemporario.Datas), {}, csTemporario.Datas)
1328:                 loc_oPg2.txt_4c_PrvEnts.Value = IIF(EMPTY(csTemporario.PrazoEnts), {}, csTemporario.PrazoEnts)
1329:                 loc_oPg2.txt_4c_Nop.Value     = ALLTRIM(NVL(csTemporario.Nops, ""))
1330:                 loc_oPg2.txt_4c_PStatus.Value = ALLTRIM(NVL(csTemporario.PStatus, ""))
1331: 
1332:                 *-- Guardar chave composta do pedido (Emps+Dopes+Numes)
1333:                 THIS.this_cEmpdopnums = ALLTRIM(csTemporario.Emps) + ;
1334:                     ALLTRIM(csTemporario.Dopes) + ;
1335:                     TRANSFORM(csTemporario.Numes, "@@@@@@")
1336: 
1337:                 *-- Carregar grade de tipos de operacao
1338:                 THIS.CarregarGradeOperacao()
1339: 

*-- Linhas 1390 a 1423:
1390:             *-- Descricao da conta de Destino via SQL (SigCdCli)
1391:             LOCAL loc_cSQL, loc_nRes
1392:             IF !EMPTY(ALLTRIM(NVL(loc_oBO.this_cContaDs, "")))
1393:                 loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
1394:                            " WHERE Iclis = " + EscaparSQL(ALLTRIM(loc_oBO.this_cContaDs))
1395:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DcontaD")
1396:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_DcontaD") > 0
1397:                     loc_oCnt.txt_4c_DcontaD.Value = ALLTRIM(cursor_4c_DcontaD.Rclis)
1398:                 ENDIF
1399:                 IF USED("cursor_4c_DcontaD")
1400:                     USE IN cursor_4c_DcontaD
1401:                 ENDIF
1402:             ELSE
1403:                 loc_oCnt.txt_4c_DcontaD.Value = ""
1404:             ENDIF
1405: 
1406:             *-- Campos GruResp e Resps/Dresps (When=.F. no legado -> ReadOnly + Enabled=.F.)
1407:             IF USED("csTemporario")
1408:                 SELECT csTemporario
1409:                 IF PEMSTATUS(loc_oCnt, "txt_4c_GruResp", 5)
1410:                     loc_oCnt.txt_4c_GruResp.Value = ALLTRIM(NVL(csTemporario.GrupoDs, ""))
1411:                 ENDIF
1412:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Resps", 5)
1413:                     loc_oCnt.txt_4c_Resps.Value   = ALLTRIM(NVL(csTemporario.ContaDs, ""))
1414:                 ENDIF
1415:             ENDIF
1416: 
1417:             loc_lResultado = .T.
1418:         CATCH TO loc_oErro
1419:             MsgErro(loc_oErro.Message, "Erro")
1420:         ENDTRY
1421:         RETURN loc_lResultado
1422:     ENDPROC
1423: 

*-- Linhas 1436 a 1474:
1436:                 IF USED("cursor_4c_Itens")
1437:                     USE IN cursor_4c_Itens
1438:                 ENDIF
1439:                 SELECT empdopnums, cpros, codcors, codtams, ;
1440:                        qtds, (qtds - qtbaixas) AS Saldos, qtbaixas, ;
1441:                        qtprods, qtbxprods, tpesos, descvals, DPros, OBS ;
1442:                     FROM xEestI ;
1443:                     INTO CURSOR cursor_4c_Itens READWRITE
1444: 
1445:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1446:                 loc_oGrid.ColumnCount = 10
1447:                 loc_oGrid.RecordSource = "cursor_4c_Itens"
1448:                 loc_oGrid.ColumnCount  = 10
1449: 
1450:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Itens.cpros"
1451:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Itens.qtprods"
1452:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Itens.qtds"
1453:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Itens.Saldos"
1454:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Itens.qtbaixas"
1455:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Itens.qtbxprods"
1456:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Itens.codcors"
1457:                 loc_oGrid.Column8.ControlSource   = "cursor_4c_Itens.tpesos"
1458:                 loc_oGrid.Column9.ControlSource   = "cursor_4c_Itens.descvals"
1459:                 loc_oGrid.Column10.ControlSource  = "cursor_4c_Itens.codtams"
1460: 
1461:                 loc_oGrid.Column1.Header1.Caption  = "Produto"
1462:                 loc_oGrid.Column2.Header1.Caption  = "Produzido"
1463:                 loc_oGrid.Column3.Header1.Caption  = "Qtd."
1464:                 loc_oGrid.Column4.Header1.Caption  = "Saldo"
1465:                 loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
1466:                 loc_oGrid.Column6.Header1.Caption  = "Produzir"
1467:                 loc_oGrid.Column7.Header1.Caption  = ""
1468:                 loc_oGrid.Column8.Header1.Caption  = "Peso"
1469:                 loc_oGrid.Column9.Header1.Caption  = CHR(37) + "Ent."
1470:                 loc_oGrid.Column10.Header1.Caption = "Tam."
1471: 
1472:                 loc_oGrid.Refresh()
1473: 
1474:                 *-- Exibir descricao/foto do primeiro item se houver registros

*-- Linhas 1520 a 1540:
1520:             loc_oImg.Picture = ""
1521: 
1522:             IF !EMPTY(ALLTRIM(par_cCpros)) AND gnConnHandle > 0
1523:                 loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro" + ;
1524:                            " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
1525:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigJpg")
1526:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_FigJpg") > 0
1527:                     IF !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1528:                        LEN(cursor_4c_FigJpg.FigJpgs) > 0
1529:                         loc_cArqTemp = ADDBS(SYS(2023)) + "Temp3.jpg"
1530:                         STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp, 0)
1531:                         IF FILE(loc_cArqTemp)
1532:                             loc_oImg.Picture = loc_cArqTemp
1533:                             loc_oImg.Visible = .T.
1534:                         ENDIF
1535:                     ENDIF
1536:                 ENDIF
1537:                 IF USED("cursor_4c_FigJpg")
1538:                     USE IN cursor_4c_FigJpg
1539:                 ENDIF
1540:             ENDIF

*-- Linhas 1787 a 1854:
1787:             IF !USED("csTemporario") OR EOF("csTemporario")
1788:                 MsgAviso("Nenhum pedido selecionado!", "")
1789:             ELSE
1790:                 SELECT csTemporario
1791:                 loc_dData = IIF(EMPTY(csTemporario.PrazoEnts), DATE(), csTemporario.PrazoEnts)
1792:                 loc_dEst  = IIF(EMPTY(csTemporario.Datas), DATE(), csTemporario.Datas)
1793:                 DO FORM SigOpEnt WITH csTemporario.Emps, csTemporario.Dopes, ;
1794:                     csTemporario.Numes, loc_dData, THIS, 0, loc_dEst, .T., 0
1795:                 loc_lResultado = .T.
1796:             ENDIF
1797:         CATCH TO loc_oErro
1798:             MsgErro(loc_oErro.Message, "Erro")
1799:         ENDTRY
1800:         RETURN loc_lResultado
1801:     ENDPROC
1802: 
1803:     *--------------------------------------------------------------------------
1804:     * BtnSubNiveisClick - Abre form SigMvSbn para sub-niveis do pedido
1805:     *--------------------------------------------------------------------------
1806:     PROCEDURE BtnSubNiveisClick()
1807:         LOCAL loc_oErro
1808:         TRY
1809:             IF !USED("csTemporario") OR EOF("csTemporario")
1810:                 MsgAviso("Nenhum pedido selecionado!", "")
1811:             ELSE
1812:                 SELECT csTemporario
1813:                 DO FORM SigMvSbn WITH THIS, csTemporario.Emps, csTemporario.Dopes, ;
1814:                     csTemporario.Numes, "csTemporario"
1815:             ENDIF
1816:         CATCH TO loc_oErro
1817:             MsgErro(loc_oErro.Message, "Erro")
1818:         ENDTRY
1819:     ENDPROC
1820: 
1821:     *--------------------------------------------------------------------------
1822:     * CarregarGradeOperacao - Carrega grade de tipos de operacao (SigCdOpe)
1823:     *--------------------------------------------------------------------------
1824:     PROTECTED PROCEDURE CarregarGradeOperacao()
1825:         LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResult
1826:         loc_lResultado = .F.
1827:         TRY
1828:             IF EMPTY(THIS.this_cDopes) OR gnConnHandle <= 0
1829:                 loc_lResultado = .T.
1830:             ELSE
1831:                 loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
1832:                 loc_cSQL    = "SELECT Dopes FROM SigCdOpe" + ;
1833:                     " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
1834:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
1835:                 IF loc_nResult > 0
1836:                     loc_oGrid.ColumnCount = 1
1837:                     loc_oGrid.RecordSource = "cursor_4c_Operacao"
1838:                     loc_oGrid.ColumnCount  = 1
1839:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Operacao.Dopes"
1840:                     loc_oGrid.Column1.Width           = 110
1841:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1842:                     loc_oGrid.Refresh()
1843:                 ENDIF
1844:                 loc_lResultado = .T.
1845:             ENDIF
1846:         CATCH TO loc_oErro
1847:             MsgErro(loc_oErro.Message, "Erro")
1848:         ENDTRY
1849:         RETURN loc_lResultado
1850:     ENDPROC
1851: 
1852: 
1853:     *--------------------------------------------------------------------------
1854:     * BtnIncluirClick - Nao disponivel neste form operacional


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* sigpres2BO.prg - Business Object para Pedido de Estoque (SIGPRES2)
* Herda de: BusinessBase
* Tabela principal: SigMvPec (PK: cidchaves, chave negocio: empdopnums)
* Itens: SigMvItn (join SigMvIts para cor/tamanho)
*==============================================================================
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela      = "SigMvPec"
    this_cCampoChave  = "cidchaves"

    *-- Chave de negocio composta (emps+dopes+numes)
    this_cEmpdopnums  = ""

    *-- Campos de SigMvPec (schema exato)
    this_cEmps        = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nCodigos     = 0
    this_dDatatrans   = {}
    this_nNtrans      = 0
    this_cLocals      = ""
    this_nValobxs     = 0
    this_cCidchaves   = ""
    this_cEmpsubs     = ""
    this_dDatas       = {}
    this_lChksubn     = .F.
    this_dDtagends    = {}
    this_lChkpagos    = .F.
    this_nNparcs      = 0
    this_nValps       = 0
    this_nValvars     = 0
    this_dVencps      = {}
    this_cPStatus     = ""

    *-- Campos adicionais do csTemporario (origem/destino contabil)
    this_cGrupoOs     = ""
    this_cContaOs     = ""
    this_cGrupoDs     = ""
    this_cContaDs     = ""
    this_cEmpds       = ""
    this_cUsuars      = ""
    this_nNops        = 0
    this_cVends       = ""
    this_cGrvends     = ""
    this_cTabds       = ""
    this_cObses       = ""
    this_dPrazoents   = {}
    this_cMascnum     = ""
    this_cNotas       = ""
    this_lChkBxParcs  = .F.

    *-- Descricoes (preenchidas por lookup em tempo de execucao)
    this_cDconta      = ""
    this_cDcontad     = ""
    this_cDresps      = ""

    *-- Referencia ao form pai (para navegacao/callbacks)
    this_oParentForm  = .NULL.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvPec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_nCodigos     = TratarNulo(codigos,    "N")
                THIS.this_dDatatrans   = TratarNulo(datatrans,  "D")
                THIS.this_nNtrans      = TratarNulo(ntrans,     "N")
                THIS.this_cLocals      = TratarNulo(locals,     "C")
                THIS.this_nValobxs     = TratarNulo(valobxs,    "N")
                THIS.this_cCidchaves   = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpdopnums  = TratarNulo(empdopnums, "C")
                THIS.this_cEmpsubs     = TratarNulo(empsubns,   "C")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_dDtagends    = TratarNulo(dtagends,   "D")
                THIS.this_lChkpagos    = ConverterParaLogico(chkpagos)
                THIS.this_nNparcs      = TratarNulo(nparcs,     "N")
                THIS.this_nValps       = TratarNulo(valps,      "N")
                THIS.this_nValvars     = TratarNulo(valvars,    "N")
                THIS.this_dVencps      = TratarNulo(vencps,     "D")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursorTemporario - Carrega campos do csTemporario (form)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursorTemporario(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cEmpds       = TratarNulo(empds,      "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
                THIS.this_cContaOs     = TratarNulo(contaos,    "C")
                THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
                THIS.this_cContaDs     = TratarNulo(contads,    "C")
                THIS.this_nNops        = TratarNulo(nops,       "N")
                THIS.this_cUsuars      = TratarNulo(usuars,     "C")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                THIS.this_cVends       = TratarNulo(vends,      "C")
                THIS.this_cGrvends     = TratarNulo(grvends,    "C")
                THIS.this_cTabds       = TratarNulo(tabds,      "C")
                THIS.this_cObses       = TratarNulo(obses,      "C")
                THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
                THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
                THIS.this_cNotas       = TratarNulo(notas,      "C")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_lChkBxParcs  = ConverterParaLogico(chkbxparcs)
                THIS.this_cEmpdopnums  = ALLTRIM(THIS.this_cEmps) + ;
                                         ALLTRIM(THIS.this_cDopes) + ;
                                         STR(THIS.this_nNumes, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro do SigMvPec pela chave de negocio
    * par_cEmpdopnums: emps+dopes+numes(6) concatenados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigMvPec WHERE empdopnums = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigMvPec conforme filtro
    * par_cFiltro: clausula WHERE adicional (sem o WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        loc_lResultado = .F.
        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = "SELECT emps, dopes, numes, datas, pstatus, cidchaves," + ;
                       " empdopnums, valobxs, nparcs, valps, valvars, vencps" + ;
                       " FROM SigMvPec" + loc_cWhere + ;
                       " ORDER BY empdopnums"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItens - Carrega cursor xEestI com itens do pedido
    * par_cEmpdopnums: chave composta do pedido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT ISNULL(b.codtams,'') AS codtams," + ;
                       " ISNULL(b.codcors,'') AS codcors, b.qtds AS QtdsS, a.*" + ;
                       " FROM SigMvItn a" + ;
                       " LEFT JOIN SigMvIts b ON a.empdopnums = b.empdopnums" + ;
                       " AND a.cpros = b.cpros AND a.citens = b.citens" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvItn") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorItens - Agrega itens por cpros+codcors+codtams para o grid
    * Precisa que crSigMvItn ja esteja carregado (via BuscarItens)
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF !USED("crSigMvItn")
                IF !THIS.BuscarItens(par_cEmpdopnums)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = "SELECT empdopnums, cpros, codcors, codtams," + ;
                       " SUM(qtds) AS qtds, SUM(qtdss) AS qtdss," + ;
                       " MAX(qtbaixas) AS qtbaixas, MAX(qtprods) AS qtprods," + ;
                       " MAX(qtbxprods) AS qtbxprods, 0 AS citens," + ;
                       " SUM(tpesos) AS tpesos, SUM(descvals) AS descvals" + ;
                       " FROM crSigMvItn" + ;
                       " GROUP BY empdopnums, cpros, codcors, codtams"
            SELECT &loc_cSQL INTO CURSOR crSigMvItn READWRITE

            IF !USED("xEestI")
                CREATE CURSOR xEestI (empdopnums C(29), cpros C(14), codcors C(4), ;
                    codtams C(4), qtds N(11,3), qtdss N(11,3), qtbaixas N(11,3), ;
                    qtprods N(11,3), qtbxprods N(11,3), citens N(4,0), ;
                    tpesos N(11,2), descvals N(11,2), DPros C(50), OBS M)
            ELSE
                ZAP IN xEestI
            ENDIF

            SELECT crSigMvItn
            INDEX ON EmpDopNums TAG EmpDopNums

            LOCAL loc_nI, loc_nQtds, loc_nQtdss
            FOR loc_nI = 1 TO RECCOUNT("crSigMvItn")
                GO loc_nI IN crSigMvItn
                SELECT crSigMvItn
                SCATTER MEMVAR MEMO

                IF !EMPTY(ALLTRIM(m.codtams)) OR !EMPTY(ALLTRIM(m.codcors))
                    m.qtds = m.qtdss
                ENDIF

                LOCAL loc_cSQLPro
                loc_cSQLPro = "SELECT cpros, DPros, PesoMs FROM SigCdPro" + ;
                              " WHERE cpros = " + EscaparSQL(ALLTRIM(m.cpros))
                IF SQLEXEC(gnConnHandle, loc_cSQLPro, "crSigCdPro") > 0 AND ;
                   RECCOUNT("crSigCdPro") > 0
                    m.tpesos   = crSigCdPro.PesoMs * m.qtds
                    m.descvals = (m.qtbaixas / IIF(m.qtds <> 0, m.qtds, 1)) * 100
                    m.DPros    = ALLTRIM(crSigCdPro.DPros)
                    IF USED("crSigCdPro")
                        USE IN crSigCdPro
                    ENDIF
                ENDIF

                INSERT INTO xEestI FROM MEMVAR
            ENDFOR

            *-- Linha de TOTAL
            LOCAL loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            SELECT xEestI
            SUM qtds, qtbaixas, tpesos, qtprods, qtbxprods ;
                TO loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            APPEND BLANK IN xEestI
            SELECT xEestI
            REPLACE cpros    WITH "TOTAL ->", ;
                    qtds     WITH loc_nTqtd, ;
                    qtbaixas WITH loc_nTqtdb, ;
                    tpesos   WITH loc_nTpeso, ;
                    qtprods  WITH loc_nTQtPrd, ;
                    qtbxprods WITH loc_nTQtBxprd, ;
                    descvals WITH ((loc_nTqtdb / IIF(loc_nTqtd <> 0, loc_nTqtd, 1)) * 100)
            GO TOP IN xEestI

            *-- Index para busca por produto+tamanho
            SELECT xEestI
            INDEX ON ALLTRIM(cpros) + ALLTRIM(codtams) TAG Tamanho

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMascaraNumeracao - Busca MascNums de SigCdPam para o tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMascaraNumeracao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") > 0 AND ;
               RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                THIS.this_cMascnum = ALLTRIM(crSigCdPam.MascNums)
                loc_lResultado = .T.
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTipoOperacao - Busca dados de SigCdOpe para o tipo op
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTipoOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe") > 0 AND ;
               RECCOUNT("crSigCdOpe") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSubDadosOperacao - Busca SigOpCdc para tipo de operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubDadosOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigOpCdc WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpCdc") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoCliente - Busca Rclis de SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoCliente(par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_cDescricao
        loc_lResultado = .F.
        loc_cDescricao = ""
        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli") > 0 AND ;
                   RECCOUNT("crSigCdCli") > 0
                    loc_cDescricao = ALLTRIM(crSigCdCli.Rclis)
                    loc_lResultado = .T.
                ENDIF
                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_cDconta = loc_cDescricao
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste alteracoes do csTemporario de volta ao SigMvPec
    * Atualiza apenas os campos editaveis pelo usuario neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigMvPec SET" + ;
                       " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
                       " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
                       " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
                       " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
                       " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                       " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
                       " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                       " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui pedido do SigMvPec (e itens relacionados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigMvItn WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvIts WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvPec WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidchaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigMvPec com todos os campos obrigatorios
    * cidchaves gerado como emps(3)+dopes(10)+numes(6)+segundos(1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_cCidchaves, loc_cEmpdopnums
        loc_lResultado = .F.
        TRY
            *-- Gerar cidchaves (char 20): emps 3 + dopes 10 + numes 6 + tick 1
            loc_cEmpdopnums = LEFT(ALLTRIM(THIS.this_cEmps) + SPACE(3), 3) + ;
                              LEFT(ALLTRIM(THIS.this_cDopes) + SPACE(20), 20) + ;
                              RIGHT("      " + ALLTRIM(STR(THIS.this_nNumes, 6)), 6)
            loc_cCidchaves  = LEFT(loc_cEmpdopnums, 19) + ;
                              RIGHT(ALLTRIM(STR(INT(SECONDS()), 1)), 1)

            THIS.this_cCidchaves  = LEFT(loc_cCidchaves, 20)
            THIS.this_cEmpdopnums = LEFT(loc_cEmpdopnums, 29)

            loc_cSQL = "INSERT INTO SigMvPec" + ;
                       " (emps, dopes, numes, codigos, datatrans, ntrans," + ;
                       "  locals, valobxs, cidchaves, empdopnums, empsubns," + ;
                       "  datas, chksubn, dtagends, chkpagos, nparcs," + ;
                       "  valps, valvars, vencps, pstatus)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cLocals), 10)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValobxs) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpsubs), 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       IIF(THIS.this_lChksubn, "1", "0") + "," + ;
                       FormatarDataSQL(THIS.this_dDtagends) + "," + ;
                       IIF(THIS.this_lChkpagos, "1", "0") + "," + ;
                       FormatarNumeroSQL(THIS.this_nNparcs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValvars) + "," + ;
                       FormatarDataSQL(THIS.this_dVencps) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPStatus), 1)) + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

