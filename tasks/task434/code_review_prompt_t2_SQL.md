# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODS, CPROS, VALORS, COEFS, ANTVALUE, ORDEM
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODS, CPROS, VALORS, COEFS, ANTVALUE, ORDEM

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
  ControlSource = "crSigPrFti.cods"
  ControlSource = "crSigPrFti.Descs"
  ControlSource = "crSigPrFti.Faixafs"
  ControlSource = "crSigPrFti.FaixaIs"
  ControlSource = "crSigPrFti.Acrescs"
  ControlSource = "crSigPrFti.Lucros"
  ControlSource = "crSigPrFti.Valors"
  ControlSource = "crSigPrFti.tpftios"
  ControlSource = "crSigPrFti.Perdas"
  ControlSource = "crSigPrFti.Divmults"
  ControlSource = "crSigPrFti.moedas"
  ControlSource = "crSigPrFti.Tipos"
  ControlSource = "crSigPrFti.Aplscus"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "CsCusto.Cpros"
  Column2.ControlSource = "CsCusto.Dpros"
  Column3.ControlSource = "CsCusto.coefs"
  Column4.ControlSource = "Cscusto.Seqs"
  ControlSource = "crSigPrFti.Etiquetas"
Select CrSigPrFti
If ThisForm.poDataMgr.SqlExecute([Select cmoes,dmoes From SigCdMoe ],'CrSigCdMoe') < 1
Select CrSigCdMoe
lcSql = [Select CgruCfxs From SigCdPac ]
If ThisForm.poDataMgr.SqlExecute(lcSql,'TmpParac') < 1
lcSql = [Select Cgrus, Dgrus, Coefs From SigCdGrp ]
If ThisForm.poDataMgr.SqlExecute(lcSql,'CrSigCdGrp') < 1
Select CrSigCdGrp
lcSql = [Select Cpros,dpros,pVens From SigCdPro Where Cgrus = ']+TmpParac.CgruCfxs+[']
If ThisForm.poDataMgr.SqlExecute(lcSql,'CrSigCdPro') < 1
Select CrSigCdPro
Select CrSigPrFti
Select CsGrade
Select CsCusto
Select CrSigPrFto
	lcSql = [Select * From SigPrFto Where Cods = ']+CrSigPrFti.Cods+[' Order by Seqs]
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtioc')  <1
	Select TmpFtioC
			=Seek(m.Cgrus,'CrSigCdGrp','Cgrus')
			Insert Into CsGrade (Cgrus, CPros, Dgrus, Coefs, Ordem ) Values ;
				Insert Into CsGrade (Cgrus, CPros, Dgrus, Coefs, Ordem ) Values ;
				=Seek(m.cpros,'CrSigCdPro','Cpros')
				Insert Into CsCusto (cpros, Dpros, Seqs, Coefs ) Values ;
Select CsCusto
Select CsGrade
Select CsGrade
	.column1.ControlSource = [CsGrade.Cgrus]
	.column2.ControlSource = [CsGrade.Dgrus]
	.column3.ControlSource = [CsGrade.Coefs]
	.column4.ControlSource = [CsGrade.CPros]
	.column5.ControlSource = [CsGrade.Ordem]
		.Get_Ds_Moeda.Value = Iif(Seek(CrSigPrFti.moedas ,'CrSigCdMoe','CMoes'),CrSigCdMoe.dmoes,'')
	Select Cgrus, CPros, sum(1) From CsGrade Where Cgrus <> ' ' Group by Cgrus, CPros Into Cursor CsDuplica having sum(1) > 1
	Select CsDuplica
	Select Cpros,sum(1) From CsCusto Where Cpros <> ' ' Group by Cpros Into Cursor CsDuplica having sum(1) > 1
	Select CsDuplica
		Select [ ] as Agrupar,Sum(1) as Tot From Csgrade Where Cgrus <> ' ' And Coefs <> 0 ;
		Select ChkDados
			Select [ ] as Agrupar,sum(1) as Tot From CsCusto Where Cpros <> ' ' Into Cursor ChkDados group by 1
			Select ChkDados
			lcQuery = [Delete From SigPrFti Where Cods = '] + lcCod + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPrFti)')
			lcQuery = [Delete From SigPrFto Where Cods = '] + lcCod + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPrFto)')
		Select CrSigPrFti
		Select CsGrade
				Insert Into CrSigPrFto (Cods, Cgrus, CPros, Coefs, cidChaves, Ordem ) Values ;
		Select CsCusto
				Insert Into CrSigPrFto (Cods, Cpros, Seqs, Coefs, cidChaves ) Values ;
			If Not ThisForm.poDataMgr.Update('crSigPrFti')
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrFti)')
			If Not ThisForm.poDataMgr.Update('CrSigPrFto')
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - CrSigPrFto)')
	Select crSigprFti
	Select crSigprFti
	If Not Seek(This.Value,'CrSigCdGrp','Cgrus')
Select * From CsGrade Where (Empty(Cgrus) And Ordem <> 0) Into Cursor TmpBranco
		Select CsGrade
		Insert Into CsGrade (Cgrus) Values ('')
	If Not Seek(This.Value,'CrSigCdPro','Cpros')
Select * From CsCusto Where Empty(Cpros) ;
	Select CsCusto
	Insert Into CsCusto (Cpros) Values ('')
	Select CsCusto
	SELECT (lcCursor)
		Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFti.prg) - TRECHOS RELEVANTES PARA PASS SQL (2436 linhas total):

*-- Linhas 87 a 114:
87:             USE IN csGrade
88:         ENDIF
89:         SET NULL ON
90:         CREATE CURSOR csGrade (Cgrus C(3), CPros C(14), Dgrus C(20), Coefs N(8,4), Ordem N(1,0))
91:         SET NULL OFF
92:         SELECT csGrade
93:         INDEX ON CPros TAG CPros
94: 
95:         IF USED("csCusto")
96:             USE IN csCusto
97:         ENDIF
98:         SET NULL ON
99:         CREATE CURSOR csCusto (Cpros C(14), Dpros C(40), Seqs N(5), Coefs N(8,4))
100:         SET NULL OFF
101:     ENDPROC
102: 
103:     *==========================================================================
104:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
105:     *==========================================================================
106:     PROTECTED PROCEDURE ConfigurarPageFrame()
107:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
108:         WITH THIS.pgf_4c_Paginas
109:             .Top       = -29
110:             .Left      = 0
111:             .Width     = THIS.Width
112:             .Height    = THIS.Height + 29
113:             .PageCount = 2
114:             .Tabs      = .F.

*-- Linhas 296 a 328:
296:             .HeaderHeight      = 16
297:             .AllowHeaderSizing = .F.
298:             .AllowRowSizing    = .F.
299:             .DeleteMark        = .F.
300:             .RecordMark        = .F.
301:             .ScrollBars        = 2
302:             .ReadOnly          = .T.
303:             .Visible           = .T.
304:         ENDWITH
305:         WITH loc_oPagina.grd_4c_Lista.Column1
306:             .ControlSource = "cursor_4c_Dados.cods"
307:             .Width         = 50
308:             .Movable       = .F.
309:             .Resizable     = .F.
310:         ENDWITH
311:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
312:         WITH loc_oPagina.grd_4c_Lista.Column2
313:             .ControlSource = "cursor_4c_Dados.descs"
314:             .Width         = 270
315:             .Movable       = .F.
316:             .Resizable     = .F.
317:         ENDWITH
318:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
319:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
320: 
321:         *-- Botoes CRUD dentro de cnt_4c_Botoes (Left=5/80/155/230/305, Top=5, W=75, H=75)
322:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
323:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
324:             .Caption         = "Incluir"
325:             .Top             = 5
326:             .Left            = 5
327:             .Width           = 75
328:             .Height          = 75

*-- Linhas 1187 a 1251:
1187:             .FontSize          = 8
1188:             .AllowHeaderSizing = .F.
1189:             .AllowRowSizing    = .F.
1190:             .DeleteMark        = .F.
1191:             .RecordMark        = .F.
1192:             .HeaderHeight      = 16
1193:             .RowHeight         = 16
1194:             .ScrollBars        = 2
1195:             .GridLineColor     = RGB(238, 238, 238)
1196:             .RecordSource      = "csGrade"
1197:             .Visible           = .T.
1198:         ENDWITH
1199:         WITH loc_oPgGrupos.grd_4c_Grade.Column1
1200:             .ColumnOrder   = 2
1201:             .ControlSource = "csGrade.Cgrus"
1202:             .Width         = 42
1203:             .Movable       = .F.
1204:             .Resizable     = .F.
1205:         ENDWITH
1206:         loc_oPgGrupos.grd_4c_Grade.Column1.Header1.Caption = "Grupo"
1207:         WITH loc_oPgGrupos.grd_4c_Grade.Column2
1208:             .ColumnOrder   = 4
1209:             .ControlSource = "csGrade.Dgrus"
1210:             .Width         = 224
1211:             .Movable       = .F.
1212:             .Resizable     = .F.
1213:         ENDWITH
1214:         loc_oPgGrupos.grd_4c_Grade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1215:         WITH loc_oPgGrupos.grd_4c_Grade.Column3
1216:             .ColumnOrder   = 5
1217:             .ControlSource = "csGrade.Coefs"
1218:             .Width         = 70
1219:             .Movable       = .F.
1220:             .Resizable     = .F.
1221:             .Sparse        = .F.
1222:         ENDWITH
1223:         loc_oPgGrupos.grd_4c_Grade.Column3.Header1.Caption = "Coeficiente"
1224:         loc_oPgGrupos.grd_4c_Grade.Column3.Text1.InputMask = "999.9999"
1225:         WITH loc_oPgGrupos.grd_4c_Grade.Column4
1226:             .ColumnOrder   = 3
1227:             .ControlSource = "csGrade.CPros"
1228:             .Width         = 108
1229:             .Movable       = .F.
1230:             .Resizable     = .F.
1231:             .Sparse        = .F.
1232:         ENDWITH
1233:         loc_oPgGrupos.grd_4c_Grade.Column4.Header1.Caption = "Produto"
1234:         WITH loc_oPgGrupos.grd_4c_Grade.Column5
1235:             .ColumnOrder   = 1
1236:             .ControlSource = "csGrade.Ordem"
1237:             .Width         = 42
1238:             .Movable       = .F.
1239:             .Resizable     = .F.
1240:         ENDWITH
1241:         loc_oPgGrupos.grd_4c_Grade.Column5.Header1.Caption = "Ordem"
1242:         loc_oPgGrupos.grd_4c_Grade.Column2.ReadOnly = .T.
1243:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "When",      THIS, "GradeGrupoCol1When")
1244:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "Valid",     THIS, "GradeGrupoCol1Valid")
1245:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "When",      THIS, "GradeGrupoCol3When")
1246:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "KeyPress", THIS, "GradeGrupoCol3LostFocus")
1247:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeGrupoCol4When")
1248:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "Valid",     THIS, "GradeGrupoCol4Valid")
1249:     ENDPROC
1250: 
1251:     *==========================================================================

*-- Linhas 1268 a 1359:
1268:             .FontSize          = 8
1269:             .AllowHeaderSizing = .F.
1270:             .AllowRowSizing    = .F.
1271:             .DeleteMark        = .F.
1272:             .RecordMark        = .F.
1273:             .HeaderHeight      = 16
1274:             .RowHeight         = 16
1275:             .ScrollBars        = 2
1276:             .GridLineColor     = RGB(238, 238, 238)
1277:             .RecordSource      = "csCusto"
1278:             .Visible           = .T.
1279:         ENDWITH
1280:         WITH loc_oPgCusto.grd_4c_Custo.Column1
1281:             .ControlSource = "csCusto.Cpros"
1282:             .Width         = 108
1283:             .Movable       = .F.
1284:             .Resizable     = .F.
1285:         ENDWITH
1286:         loc_oPgCusto.grd_4c_Custo.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1287:         WITH loc_oPgCusto.grd_4c_Custo.Column2
1288:             .ControlSource = "csCusto.Dpros"
1289:             .Width         = 190
1290:             .Movable       = .F.
1291:             .Resizable     = .F.
1292:         ENDWITH
1293:         loc_oPgCusto.grd_4c_Custo.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1294:         loc_oPgCusto.grd_4c_Custo.Column2.ReadOnly = .T.
1295:         WITH loc_oPgCusto.grd_4c_Custo.Column3
1296:             .ColumnOrder   = 4
1297:             .ControlSource = "csCusto.Coefs"
1298:             .Width         = 70
1299:             .Movable       = .F.
1300:             .Resizable     = .F.
1301:             .Sparse        = .F.
1302:         ENDWITH
1303:         loc_oPgCusto.grd_4c_Custo.Column3.Header1.Caption = "Coeficiente"
1304:         loc_oPgCusto.grd_4c_Custo.Column3.Text1.InputMask = "999.9999"
1305:         WITH loc_oPgCusto.grd_4c_Custo.Column4
1306:             .ColumnOrder   = 3
1307:             .ControlSource = "csCusto.Seqs"
1308:             .Width         = 75
1309:             .Movable       = .F.
1310:             .Resizable     = .F.
1311:             .Sparse        = .F.
1312:         ENDWITH
1313:         loc_oPgCusto.grd_4c_Custo.Column4.Header1.Caption = "Sequencia"
1314:         loc_oPgCusto.grd_4c_Custo.Column4.Text1.InputMask = "99999"
1315:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "When",      THIS, "GradeCustoCol1When")
1316:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "Valid",     THIS, "GradeCustoCol1Valid")
1317:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "When",      THIS, "GradeCustoCol3When")
1318:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "KeyPress", THIS, "GradeCustoCol3LostFocus")
1319:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column4.Text1, "When",      THIS, "GradeCustoCol4When")
1320:         BINDEVENT(loc_oPgCusto, "Activate", THIS, "ConfigPage2Activate")
1321:     ENDPROC
1322: 
1323:     *==========================================================================
1324:     * CarregarLista - Carrega dados no cursor da lista
1325:     * Grid e ControlSource: adicionados na Fase 4
1326:     *==========================================================================
1327:     PROCEDURE CarregarLista()
1328:         LOCAL loc_lResultado, loc_oGrid
1329:         loc_lResultado = .F.
1330: 
1331:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1332:             RETURN .T.
1333:         ENDIF
1334: 
1335:         TRY
1336:             IF !THIS.this_oBusinessObject.Buscar("")
1337:                 loc_lResultado = .F.
1338:             ELSE
1339:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1340:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1341:                     loc_oGrid.ColumnCount = 2
1342:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1343:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1344:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1345:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1346:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1347:                     loc_oGrid.Refresh()
1348:                 ENDIF
1349:                 loc_lResultado = .T.
1350:             ENDIF
1351:         CATCH TO loException
1352:             MsgErro("Erro em FormFti.CarregarLista:" + CHR(13) + loException.Message + ;
1353:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1354:             loc_lResultado = .F.
1355:         ENDTRY
1356: 
1357:         RETURN loc_lResultado
1358:     ENDPROC
1359: 

*-- Linhas 1401 a 1466:
1401:             RETURN .F.
1402:         ENDIF
1403: 
1404:         SELECT cursor_4c_Dados
1405:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1406: 
1407:         IF EMPTY(loc_cCodigo)
1408:             MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
1409:             RETURN .F.
1410:         ENDIF
1411: 
1412:         TRY
1413:             THIS.LockScreen = .T.
1414:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "FEITIO", 2
1415:             THIS.this_cUltCodigo = loc_cCodigo
1416:             THIS.AlternarPagina(1)
1417:             IF USED("cursor_4c_Dados")
1418:                 SELECT cursor_4c_Dados
1419:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1420:             ENDIF
1421:             THIS.LockScreen = .F.
1422:             loc_lResultado = .T.
1423:         CATCH TO loException
1424:             THIS.LockScreen = .F.
1425:             MsgErro("Erro em FormFti.BtnExpXMLClick:" + CHR(13) + loException.Message, "Erro")
1426:         ENDTRY
1427: 
1428:         RETURN loc_lResultado
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * BtnImpXMLClick - Importa XML de feitio
1433:     *==========================================================================
1434:     PROCEDURE BtnImpXMLClick()
1435:         LOCAL loc_lResultado, loc_cCodigo
1436:         loc_lResultado = .F.
1437: 
1438:         TRY
1439:             THIS.LockScreen = .T.
1440:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1441:                 SELECT cursor_4c_Dados
1442:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1443:             ELSE
1444:                 loc_cCodigo = ""
1445:             ENDIF
1446: 
1447:             DO FORM SigOpXml WITH THIS, "", "I", "FEITIO", 2
1448:             THIS.this_cUltCodigo = loc_cCodigo
1449:             THIS.AlternarPagina(1)
1450:             IF USED("cursor_4c_Dados") AND !EMPTY(THIS.this_cUltCodigo)
1451:                 SELECT cursor_4c_Dados
1452:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1453:             ENDIF
1454:             THIS.LockScreen = .F.
1455:             loc_lResultado = .T.
1456:         CATCH TO loException
1457:             THIS.LockScreen = .F.
1458:             MsgErro("Erro em FormFti.BtnImpXMLClick:" + CHR(13) + loException.Message, "Erro")
1459:         ENDTRY
1460: 
1461:         RETURN loc_lResultado
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * BtnSalvarClick - Valida e salva registro + itens
1466:     *==========================================================================

*-- Linhas 1559 a 1585:
1559:         ENDIF
1560: 
1561:         TRY
1562:             SELECT (loc_cCursor)
1563:             loc_nPos   = RECNO()
1564:             COUNT TO loc_nTotal
1565: 
1566:             IF loc_nTotal > 1
1567:                 IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Excluir Linha")
1568:                     SELECT (loc_cCursor)
1569:                     GO (loc_nPos)
1570:                     DELETE
1571:                     PACK
1572:                 ENDIF
1573:             ELSE
1574:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir o " + ;
1575:                          CHR(250) + "nico registro.", "Excluir Linha")
1576:             ENDIF
1577:         CATCH TO loException
1578:             MsgErro("Erro em FormFti.BtnExcluirLinhaClick:" + CHR(13) + loException.Message, "Erro")
1579:         ENDTRY
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * FormParaBO - Transfere valores do Form para o BO
1584:     *==========================================================================
1585:     PROTECTED PROCEDURE FormParaBO()

*-- Linhas 1648 a 1670:
1648:         loc_oPg2.opt_4c_Etiquetas.Value = 3
1649: 
1650:         IF USED("csGrade")
1651:             SELECT csGrade
1652:             ZAP
1653:         ENDIF
1654:         IF USED("csCusto")
1655:             SELECT csCusto
1656:             ZAP
1657:         ENDIF
1658:     ENDPROC
1659: 
1660:     *==========================================================================
1661:     * HabilitarCampos - Habilita ou desabilita campos editaveis
1662:     *==========================================================================
1663:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1664:         LOCAL loc_oPg2
1665:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1666: 
1667:         loc_oPg2.txt_4c_Codigo.Enabled    = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1668:         loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
1669:         loc_oPg2.txt_4c_Valor.Enabled     = par_lHabilitar
1670:         loc_oPg2.txt_4c_CdMoeda.Enabled   = par_lHabilitar

*-- Linhas 1718 a 1786:
1718: 
1719:         TRY
1720:             IF USED("csGrade")
1721:                 SELECT csGrade
1722:                 ZAP
1723:             ENDIF
1724:             IF USED("csCusto")
1725:                 SELECT csCusto
1726:                 ZAP
1727:             ENDIF
1728: 
1729:             IF THIS.this_oBusinessObject.CarregarItens(par_cCodigo) AND USED("cursor_4c_Itens")
1730:                 SELECT cursor_4c_Itens
1731:                 GO TOP
1732:                 SCAN
1733:                     IF !EMPTY(ALLTRIM(cursor_4c_Itens.cgrus))
1734:                         INSERT INTO csGrade (Cgrus, CPros, Dgrus, Coefs, Ordem) ;
1735:                             VALUES (ALLTRIM(cursor_4c_Itens.cgrus), ;
1736:                                     ALLTRIM(cursor_4c_Itens.cpros), ;
1737:                                     "", ;
1738:                                     cursor_4c_Itens.coefs, ;
1739:                                     cursor_4c_Itens.ordem)
1740:                         IF USED("CrSigCdGrp")
1741:                             SELECT CrSigCdGrp
1742:                             IF SEEK(ALLTRIM(cursor_4c_Itens.cgrus), "CrSigCdGrp", "Cgrus")
1743:                                 SELECT csGrade
1744:                                 GO BOTTOM
1745:                                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus)
1746:                             ENDIF
1747:                         ENDIF
1748:                     ELSE
1749:                         INSERT INTO csCusto (Cpros, Dpros, Seqs, Coefs) ;
1750:                             VALUES (ALLTRIM(cursor_4c_Itens.cpros), ;
1751:                                     "", ;
1752:                                     cursor_4c_Itens.seqs, ;
1753:                                     cursor_4c_Itens.coefs)
1754:                         IF USED("CrSigCdPro")
1755:                             SELECT CrSigCdPro
1756:                             IF SEEK(ALLTRIM(cursor_4c_Itens.cpros), "CrSigCdPro", "Cpros")
1757:                                 SELECT csCusto
1758:                                 GO BOTTOM
1759:                                 REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros)
1760:                             ENDIF
1761:                         ENDIF
1762:                     ENDIF
1763:                 ENDSCAN
1764:             ENDIF
1765: 
1766:             INSERT INTO csGrade (Cgrus) VALUES ("")
1767:             INSERT INTO csCusto (Cpros) VALUES ("")
1768: 
1769:             SELECT csGrade
1770:             GO TOP
1771:             SELECT csCusto
1772:             GO TOP
1773: 
1774:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1, "grd_4c_Grade", 5)
1775:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade.Refresh()
1776:             ENDIF
1777:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
1778:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Refresh()
1779:             ENDIF
1780: 
1781:             loc_lResultado = .T.
1782:         CATCH TO loException
1783:             MsgErro("Erro em FormFti.CarregarItensNaGrade:" + CHR(13) + loException.Message, "Erro")
1784:         ENDTRY
1785: 
1786:         RETURN loc_lResultado

*-- Linhas 1851 a 1869:
1851:             RETURN
1852:         ENDIF
1853: 
1854:         SELECT cursor_4c_Dados
1855:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1856: 
1857:         IF EMPTY(loc_cCodigo)
1858:             MsgAviso("Selecione um registro.", "Visualizar")
1859:             RETURN
1860:         ENDIF
1861: 
1862:         THIS.this_cUltCodigo = loc_cCodigo
1863:         THIS.this_cModoAtual = "VISUALIZAR"
1864:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1865:         THIS.BOParaForm()
1866:         THIS.CriarCursoresGrade()
1867:         THIS.CarregarItensNaGrade(loc_cCodigo)
1868:         THIS.HabilitarCampos(.F.)
1869:         THIS.AjustarBotoesPorModo()

*-- Linhas 1882 a 1900:
1882:             RETURN
1883:         ENDIF
1884: 
1885:         SELECT cursor_4c_Dados
1886:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1887: 
1888:         IF EMPTY(loc_cCodigo)
1889:             MsgAviso("Selecione um registro para alterar.", "Alterar")
1890:             RETURN
1891:         ENDIF
1892: 
1893:         THIS.this_cUltCodigo = loc_cCodigo
1894:         THIS.this_cModoAtual = "ALTERAR"
1895:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1896:         THIS.this_oBusinessObject.EditarRegistro()
1897:         THIS.BOParaForm()
1898:         THIS.CriarCursoresGrade()
1899:         THIS.CarregarItensNaGrade(loc_cCodigo)
1900:         THIS.HabilitarCampos(.T.)

*-- Linhas 1915 a 1933:
1915:             RETURN
1916:         ENDIF
1917: 
1918:         SELECT cursor_4c_Dados
1919:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1920: 
1921:         IF EMPTY(loc_cCodigo)
1922:             MsgAviso("Selecione um registro para excluir.", "Excluir")
1923:             RETURN
1924:         ENDIF
1925: 
1926:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do feitio '" + loc_cCodigo + "'?", "Excluir")
1927:             RETURN
1928:         ENDIF
1929: 
1930:         TRY
1931:             THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1932:             IF THIS.this_oBusinessObject.Excluir()
1933:                 THIS.this_cUltCodigo = ""

*-- Linhas 1954 a 1981:
1954:             RETURN
1955:         ENDIF
1956: 
1957:         loc_cFiltro = "cods LIKE " + EscaparSQL(ALLTRIM(loc_cTexto) + "%")
1958: 
1959:         TRY
1960:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1961:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1962:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1963:                     loc_oGrid.ColumnCount = 2
1964:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1965:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1966:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1967:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1968:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1969:                     loc_oGrid.Refresh()
1970:                 ENDIF
1971:                 IF RECCOUNT("cursor_4c_Dados") = 0
1972:                     MsgAviso("Nenhum registro encontrado.", "Buscar")
1973:                 ENDIF
1974:             ENDIF
1975:         CATCH TO loException
1976:             MsgErro("Erro em FormFti.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
1977:         ENDTRY
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     * Destroy - Limpeza ao fechar

*-- Linhas 2171 a 2212:
2171: 
2172:         TRY
2173:             IF SEEK(loc_cCodigo, "CrSigCdGrp", "Cgrus")
2174:                 SELECT csGrade
2175:                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2176:                         Coefs WITH CrSigCdGrp.Coefs
2177:             ELSE
2178:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2179:                     "SigCdGrp", "cursor_4c_BuscaGrp", "Cgrus", loc_cCodigo, ;
2180:                     "Grupos de Produto")
2181:                 IF VARTYPE(loc_oBusca) = "O"
2182:                     IF !loc_oBusca.this_lAchouRegistro
2183:                         loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
2184:                         loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2185:                         loc_oBusca.Show()
2186:                     ENDIF
2187:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
2188:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaGrp.Cgrus)
2189:                         SELECT csGrade
2190:                         REPLACE Cgrus WITH loc_cSelecionado
2191:                         IF SEEK(loc_cSelecionado, "CrSigCdGrp", "Cgrus")
2192:                             SELECT csGrade
2193:                             REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2194:                                     Coefs WITH CrSigCdGrp.Coefs
2195:                         ENDIF
2196:                     ELSE
2197:                         SELECT csGrade
2198:                         REPLACE Cgrus WITH "", Dgrus WITH ""
2199:                     ENDIF
2200:                     loc_oBusca.Release()
2201:                 ENDIF
2202:                 IF USED("cursor_4c_BuscaGrp")
2203:                     USE IN cursor_4c_BuscaGrp
2204:                 ENDIF
2205:             ENDIF
2206:         CATCH TO loException
2207:             MsgErro("Erro em GradeGrupoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2208:             loc_lResultado = .F.
2209:         ENDTRY
2210: 
2211:         RETURN loc_lResultado
2212:     ENDPROC

*-- Linhas 2227 a 2250:
2227:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade
2228: 
2229:         TRY
2230:             SELECT * FROM csGrade WHERE (EMPTY(Cgrus) AND Ordem <> 0) INTO CURSOR TmpBranco
2231:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2232:                 SET CONFIRM OFF
2233:                 IF LASTKEY() = 13
2234:                     SELECT csGrade
2235:                     INSERT INTO csGrade (Cgrus) VALUES ("")
2236:                     loc_oPag.Refresh()
2237:                     loc_oPag.Column1.SetFocus()
2238:                     KEYBOARD "{DnArrow}"
2239:                 ENDIF
2240:             ENDIF
2241:         CATCH TO loException
2242:             MsgErro("Erro em GradeGrupoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2243:         ENDTRY
2244: 
2245:         IF USED("TmpBranco")
2246:             USE IN TmpBranco
2247:         ENDIF
2248:     ENDPROC
2249: 
2250:     *==========================================================================

*-- Linhas 2285 a 2307:
2285:                     loc_oBusca.Show()
2286:                 ENDIF
2287:                 IF loc_oBusca.this_lSelecionou AND USED("crListaRemota")
2288:                     SELECT csGrade
2289:                     REPLACE CPros WITH ALLTRIM(crListaRemota.CPros)
2290:                 ELSE
2291:                     IF LASTKEY() = 27
2292:                         SELECT csGrade
2293:                         REPLACE CPros WITH ""
2294:                     ENDIF
2295:                 ENDIF
2296:                 loc_oBusca.Release()
2297:             ENDIF
2298:             IF USED("crListaRemota")
2299:                 USE IN crListaRemota
2300:             ENDIF
2301:         CATCH TO loException
2302:             MsgErro("Erro em GradeGrupoCol4Valid:" + CHR(13) + loException.Message, "Erro")
2303:             loc_lResultado = .F.
2304:         ENDTRY
2305: 
2306:         RETURN loc_lResultado
2307:     ENDPROC

*-- Linhas 2335 a 2391:
2335: 
2336:         TRY
2337:             IF SEEK(loc_cCodigo, "CrSigCdPro", "Cpros")
2338:                 SELECT csCusto
2339:                 REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2340:                         Coefs WITH CrSigCdPro.pVens, ;
2341:                         Seqs  WITH RECNO("csCusto")
2342:             ELSE
2343:                 loc_cFiltro = ""
2344:                 IF USED("TmpParac") AND RECCOUNT("TmpParac") > 0
2345:                     SELECT TmpParac
2346:                     GO TOP
2347:                     IF !EMPTY(ALLTRIM(TmpParac.CgruCfxs))
2348:                         loc_cFiltro = "Cgrus = " + EscaparSQL(ALLTRIM(TmpParac.CgruCfxs))
2349:                     ENDIF
2350:                 ENDIF
2351:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2352:                     "SigCdPro", "cursor_4c_BuscaPro", "Cpros", loc_cCodigo, ;
2353:                     "Custos Fixo", .F., .T., loc_cFiltro)
2354:                 IF VARTYPE(loc_oBusca) = "O"
2355:                     IF !loc_oBusca.this_lAchouRegistro
2356:                         loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2357:                         loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2358:                         loc_oBusca.Show()
2359:                     ENDIF
2360:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
2361:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.Cpros)
2362:                         SELECT csCusto
2363:                         REPLACE Cpros WITH loc_cSelecionado
2364:                         IF SEEK(loc_cSelecionado, "CrSigCdPro", "Cpros")
2365:                             SELECT csCusto
2366:                             REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2367:                                     Coefs WITH CrSigCdPro.pVens, ;
2368:                                     Seqs  WITH RECNO("csCusto")
2369:                         ELSE
2370:                             SELECT csCusto
2371:                             REPLACE Dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros), ;
2372:                                     Coefs WITH cursor_4c_BuscaPro.pVens, ;
2373:                                     Seqs  WITH RECNO("csCusto")
2374:                         ENDIF
2375:                     ELSE
2376:                         SELECT csCusto
2377:                         REPLACE Cpros WITH "", Dpros WITH ""
2378:                     ENDIF
2379:                     loc_oBusca.Release()
2380:                 ENDIF
2381:                 IF USED("cursor_4c_BuscaPro")
2382:                     USE IN cursor_4c_BuscaPro
2383:                 ENDIF
2384:             ENDIF
2385:         CATCH TO loException
2386:             MsgErro("Erro em GradeCustoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2387:             loc_lResultado = .F.
2388:         ENDTRY
2389: 
2390:         RETURN loc_lResultado
2391:     ENDPROC

*-- Linhas 2405 a 2430:
2405:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo
2406: 
2407:         TRY
2408:             SELECT * FROM csCusto WHERE EMPTY(Cpros) INTO CURSOR TmpBranco
2409:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2410:                 SELECT csCusto
2411:                 INSERT INTO csCusto (Cpros) VALUES ("")
2412:                 GO BOTTOM IN csCusto
2413:             ENDIF
2414:             IF LASTKEY() = 13
2415:                 SELECT csCusto
2416:                 loc_oPag.Refresh()
2417:                 loc_oPag.Column1.SetFocus()
2418:                 KEYBOARD "{DnArrow}"
2419:             ENDIF
2420:         CATCH TO loException
2421:             MsgErro("Erro em GradeCustoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2422:         ENDTRY
2423: 
2424:         IF USED("TmpBranco")
2425:             USE IN TmpBranco
2426:         ENDIF
2427:     ENDPROC
2428: 
2429:     *==========================================================================
2430:     * GradeCustoCol4When - When do Col4 (Seqs) do grd_4c_Custo


### BO (C:\4c\projeto\app\classes\FtiBO.prg):
*==============================================================================
* FtiBO.prg - Business Object para Cadastro de Feitios
* Tabela principal : SigPrFti (cods = PK)
* Tabela de itens  : SigPrFto (cidchaves = PK)
* Gerado           : Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS FtiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades herdadas (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigPrFti"
    this_cCampoChave  = "cods"

    *--------------------------------------------------------------------------
    * Campos de SigPrFti
    *--------------------------------------------------------------------------
    this_cCodigo      = ""    && cods       char(2)  PK
    this_cDescricao   = ""    && descs      char(20)
    this_nValor       = 0     && valors     numeric(11,2)
    this_cMoeda       = ""    && moedas     char(3)
    this_nAcrescimo   = 0     && acrescs    numeric(11,6)
    this_nTipoFeitio  = 1     && tpftios    numeric(1,0)  1=Por Peso 2=Valor Adicional 3=Informativo
    this_nFaixaInicial = 0    && faixais    numeric(11,6)
    this_nFaixaFinal  = 0     && faixafs    numeric(11,6)
    this_nPerdas      = 0     && perdas     numeric(3,1)
    this_nLucros      = 0     && lucros     numeric(5,2)
    this_nDivMult     = 1     && divmults   numeric(1,0)  1=Multiplicador 2=Divisor
    this_nTipo        = 2     && tipos      numeric(1,0)  1=Custo 2=Venda
    this_nAplscus     = 2     && aplscus    numeric(1,0)  1=Sim 2=Nao
    this_nEtiquetas   = 3     && etiquetas  numeric(1,0)  1=Sim 2=Sim-AU 3=Nao
    this_cMcustos     = ""    && mcustos    char(3)
    this_nVcustos     = 0     && vcustos    numeric(11,2)
    this_cUsuarios    = ""    && usuars     char(10)
    this_dDataRs      = {}    && datars     datetime

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de controle
    *--------------------------------------------------------------------------
    this_cDescMoeda   = ""    && descricao da moeda (SigCdMoe.dmoes) - nao salvo
    this_lNovoRegistro = .F.

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrFti"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCodigo       = ""
        THIS.this_cDescricao    = ""
        THIS.this_nValor        = 0
        THIS.this_cMoeda        = ""
        THIS.this_cDescMoeda    = ""
        THIS.this_nAcrescimo    = 0
        THIS.this_nTipoFeitio   = 1
        THIS.this_nFaixaInicial = 0
        THIS.this_nFaixaFinal   = 0
        THIS.this_nPerdas       = 0
        THIS.this_nLucros       = 0
        THIS.this_nDivMult      = 1
        THIS.this_nTipo         = 2
        THIS.this_nAplscus      = 2
        THIS.this_nEtiquetas    = 3
        THIS.this_cMcustos      = ""
        THIS.this_nVcustos      = 0
        THIS.this_cUsuarios     = ""
        THIS.this_dDataRs       = {}
        THIS.this_lNovoRegistro = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo       = ALLTRIM(TratarNulo(cods,      "C"))
            THIS.this_cDescricao    = ALLTRIM(TratarNulo(descs,     "C"))
            THIS.this_nValor        = TratarNulo(valors,    "N")
            THIS.this_cMoeda        = ALLTRIM(TratarNulo(moedas,    "C"))
            THIS.this_nAcrescimo    = TratarNulo(acrescs,   "N")
            THIS.this_nTipoFeitio   = TratarNulo(tpftios,   "N")
            THIS.this_nFaixaInicial = TratarNulo(faixais,   "N")
            THIS.this_nFaixaFinal   = TratarNulo(faixafs,   "N")
            THIS.this_nPerdas       = TratarNulo(perdas,    "N")
            THIS.this_nLucros       = TratarNulo(lucros,    "N")
            THIS.this_nDivMult      = TratarNulo(divmults,  "N")
            THIS.this_nTipo         = TratarNulo(tipos,     "N")
            THIS.this_nAplscus      = TratarNulo(aplscus,   "N")
            THIS.this_nEtiquetas    = TratarNulo(etiquetas, "N")
            THIS.this_cMcustos      = ALLTRIM(TratarNulo(mcustos,   "C"))
            THIS.this_nVcustos      = TratarNulo(vcustos,   "N")
            THIS.this_cUsuarios     = ALLTRIM(TratarNulo(usuars,    "C"))
            THIS.this_dDataRs       = TratarNulo(datars,    "D")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros de SigPrFti (PUBLIC)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                       " FROM SigPrFti" + ;
                       " ORDER BY cods"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                           " FROM SigPrFti" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY cods"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar feitios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios," + ;
                       " faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       " aplscus, etiquetas, mcustos, vcustos, usuars, datars" + ;
                       " FROM SigPrFti" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrFti" + ;
                       " (cods, descs, valors, moedas, acrescs, tpftios," + ;
                       "  faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       "  aplscus, etiquetas, mcustos, vcustos, usuars, datars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)                          + ", " + ;
                       EscaparSQL(THIS.this_cDescricao)                       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValor)                    + ", " + ;
                       EscaparSQL(THIS.this_cMoeda)                           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAcrescimo)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoFeitio)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaInicial)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaFinal)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerdas)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLucros)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivMult)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo)                     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAplscus)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas)                + ", " + ;
                       EscaparSQL(THIS.this_cMcustos)                         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVcustos)                  + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))               + ", " + ;
                       "GETDATE()" + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrFti SET" + ;
                       "  descs    = " + EscaparSQL(THIS.this_cDescricao)          + ", " + ;
                       "  valors   = " + FormatarNumeroSQL(THIS.this_nValor)        + ", " + ;
                       "  moedas   = " + EscaparSQL(THIS.this_cMoeda)              + ", " + ;
                       "  acrescs  = " + FormatarNumeroSQL(THIS.this_nAcrescimo)    + ", " + ;
                       "  tpftios  = " + FormatarNumeroSQL(THIS.this_nTipoFeitio)   + ", " + ;
                       "  faixais  = " + FormatarNumeroSQL(THIS.this_nFaixaInicial) + ", " + ;
                       "  faixafs  = " + FormatarNumeroSQL(THIS.this_nFaixaFinal)   + ", " + ;
                       "  perdas   = " + FormatarNumeroSQL(THIS.this_nPerdas)       + ", " + ;
                       "  lucros   = " + FormatarNumeroSQL(THIS.this_nLucros)       + ", " + ;
                       "  divmults = " + FormatarNumeroSQL(THIS.this_nDivMult)      + ", " + ;
                       "  tipos    = " + FormatarNumeroSQL(THIS.this_nTipo)         + ", " + ;
                       "  aplscus  = " + FormatarNumeroSQL(THIS.this_nAplscus)      + ", " + ;
                       "  etiquetas= " + FormatarNumeroSQL(THIS.this_nEtiquetas)    + ", " + ;
                       "  mcustos  = " + EscaparSQL(THIS.this_cMcustos)            + ", " + ;
                       "  vcustos  = " + FormatarNumeroSQL(THIS.this_nVcustos)      + ", " + ;
                       "  usuars   = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))  + ", " + ;
                       "  datars   = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigPrFti + SigPrFto (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao excluir itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrFti WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarItens - Carrega itens de SigPrFto para o cursor de grade (PUBLIC)
    * Popula cursores csGrade (grupos) e csCusto (custos fixo)
    *==========================================================================
    PROCEDURE CarregarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT cgrus, cpros, coefs, cidchaves, sgrus, ordem, seqs" + ;
                       " FROM SigPrFto" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY seqs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarItens - Persiste cursores csGrade e csCusto em SigPrFto (PUBLIC)
    * Deleta itens anteriores e reinsere (igual ao legado)
    *==========================================================================
    PROCEDURE SalvarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            LOCAL loc_lErro
            loc_lErro = .F.

            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao limpar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lErro = .T.
            ENDIF

            IF USED("csGrade") AND !loc_lErro
                SELECT csGrade
                GO TOP
                SCAN
                    IF (!EMPTY(ALLTRIM(csGrade.Cgrus)) AND csGrade.Coefs <> 0) OR ;
                       (csGrade.Ordem <> 0 AND csGrade.Coefs <> 0)
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, ordem, seqs, calcfeitio, sgrus)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.Cgrus))    + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.CPros))    + ", " + ;
                                   FormatarNumeroSQL(csGrade.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csGrade.Ordem)      + ", " + ;
                                   "0"                                   + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir grupo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF USED("csCusto") AND !loc_lErro
                SELECT csCusto
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(csCusto.Cpros)) AND csCusto.Coefs <> 0
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, seqs, calcfeitio, sgrus, ordem)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   "''"                                  + ", " + ;
                                   EscaparSQL(ALLTRIM(csCusto.Cpros))    + ", " + ;
                                   FormatarNumeroSQL(csCusto.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csCusto.Seqs)       + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''"                                  + ", " + ;
                                   "0" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir custo fixo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF !loc_lErro
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.SalvarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega cursores auxiliares necessarios ao form (PUBLIC)
    * CrSigCdMoe (moedas), CrSigCdGrp (grupos produto), CrSigCdPro (produtos)
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lResultado, loc_cSQL, loc_cGrupoCfxs
        loc_lResultado = .F.

        TRY
            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMoe") < 1
                MsgErro("Erro ao carregar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON cmoes TAG CMoes

            IF USED("TmpParac")
                USE IN TmpParac
            ENDIF
            loc_cSQL = "SELECT CgruCfxs FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpParac") < 1
                MsgErro("Erro ao carregar parametros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            IF RECCOUNT("TmpParac") > 0
                SELECT TmpParac
                GO TOP
                loc_cGrupoCfxs = ALLTRIM(TmpParac.CgruCfxs)
            ELSE
                loc_cGrupoCfxs = ""
            ENDIF

            IF USED("CrSigCdGrp")
                USE IN CrSigCdGrp
            ENDIF
            loc_cSQL = "SELECT Cgrus, Dgrus, Coefs FROM SigCdGrp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGrp") < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdGrp
            INDEX ON Cgrus TAG Cgrus

            IF USED("CrSigCdPro")
                USE IN CrSigCdPro
            ENDIF
            IF !EMPTY(loc_cGrupoCfxs)
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro" + ;
                           " WHERE Cgrus = " + EscaparSQL(loc_cGrupoCfxs)
            ELSE
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro"
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPro") < 1
                MsgErro("Erro ao carregar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdPro
            INDEX ON cpros TAG Cpros

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarParametros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica duplicidade de grupos e custos na grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cgrus, CPros, SUM(1) AS Tot FROM csGrade ;
                WHERE Cgrus <> ' ' ;
                GROUP BY Cgrus, CPros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Grupos/Produtos configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cpros, SUM(1) AS Tot FROM csCusto ;
                WHERE Cpros <> ' ' ;
                GROUP BY Cpros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Custos Fixo configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarDuplicidade:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFaixa - Valida que o acrescimo esta dentro da faixa (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarFaixa()
        IF THIS.this_nFaixaFinal > 0
            IF !BETWEEN(THIS.this_nAcrescimo, THIS.this_nFaixaInicial, THIS.this_nFaixaFinal)
                MsgAviso("O multiplicador tem que estar dentro da Faixa!", "Valida" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarConflitoCampos - Valida que Multiplicador/Valor nao coexistem com grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarConflitoCampos()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF THIS.this_nAcrescimo <> 0 OR THIS.this_nValor <> 0
                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csGrade ;
                    WHERE Cgrus <> ' ' AND Coefs <> 0 ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csCusto ;
                    WHERE Cpros <> ' ' ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarConflitoCampos:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigo ja existe (para INSERT) (PUBLIC)
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT cods FROM SigPrFti WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") > 0
                loc_lExiste = (RECCOUNT("cursor_4c_Chk") > 0)
            ENDIF

            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.VerificarCodigoExistente:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Dados"
        loc_aCursores(2) = "cursor_4c_Carrega"
        loc_aCursores(3) = "cursor_4c_Itens"
        loc_aCursores(4) = "cursor_4c_Chk"
        loc_aCursores(5) = "CrSigCdMoe"
        loc_aCursores(6) = "TmpParac"
        loc_aCursores(7) = "CrSigCdGrp"
        loc_aCursores(8) = "CrSigCdPro"
        loc_aCursores(9) = "ChkDados"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

