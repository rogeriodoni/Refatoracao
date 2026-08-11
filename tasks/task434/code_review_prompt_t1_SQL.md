# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODS, CPROS, VALORS, COEFS, ANTVALUE, ORDEM
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODS, CPROS, VALORS, COEFS, ANTVALUE, ORDEM
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODS, CPROS, VALORS, COEFS, ANTVALUE, ORDEM

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFti.prg) - TRECHOS RELEVANTES PARA PASS SQL (2466 linhas total):

*-- Linhas 85 a 112:
85:             USE IN csGrade
86:         ENDIF
87:         SET NULL ON
88:         CREATE CURSOR csGrade (Cgrus C(3), CPros C(14), Dgrus C(20), Coefs N(8,4), Ordem N(1,0))
89:         SET NULL OFF
90:         SELECT csGrade
91:         INDEX ON CPros TAG CPros
92: 
93:         IF USED("csCusto")
94:             USE IN csCusto
95:         ENDIF
96:         SET NULL ON
97:         CREATE CURSOR csCusto (Cpros C(14), Dpros C(40), Seqs N(5), Coefs N(8,4))
98:         SET NULL OFF
99:     ENDPROC
100: 
101:     *==========================================================================
102:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
103:     *==========================================================================
104:     PROTECTED PROCEDURE ConfigurarPageFrame()
105:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
106:         WITH THIS.pgf_4c_Paginas
107:             .Top       = -29
108:             .Left      = 0
109:             .Width     = THIS.Width
110:             .Height    = THIS.Height + 29
111:             .PageCount = 2
112:             .Tabs      = .F.

*-- Linhas 294 a 347:
294:             .HeaderHeight      = 16
295:             .AllowHeaderSizing = .F.
296:             .AllowRowSizing    = .F.
297:             .DeleteMark        = .F.
298:             .RecordMark        = .F.
299:             .ScrollBars        = 2
300:             .ReadOnly          = .T.
301:             .Visible           = .T.
302:         ENDWITH
303:         WITH loc_oPagina.grd_4c_Lista.Column1
304:             .ControlSource = "cursor_4c_Dados.cods"
305:             .Width         = 50
306:             .Movable       = .F.
307:             .Resizable     = .F.
308:         ENDWITH
309:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
310:         WITH loc_oPagina.grd_4c_Lista.Column2
311:             .ControlSource = "cursor_4c_Dados.descs"
312:             .Width         = 270
313:             .Movable       = .F.
314:             .Resizable     = .F.
315:         ENDWITH
316:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
317:         WITH loc_oPagina.grd_4c_Lista.Column3
318:             .ControlSource = "cursor_4c_Dados.valors"
319:             .Width         = 120
320:             .Movable       = .F.
321:             .Resizable     = .F.
322:         ENDWITH
323:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption = "Valor"
324:         WITH loc_oPagina.grd_4c_Lista.Column4
325:             .ControlSource = "cursor_4c_Dados.moedas"
326:             .Width         = 45
327:             .Movable       = .F.
328:             .Resizable     = .F.
329:         ENDWITH
330:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption = "Moeda"
331:         WITH loc_oPagina.grd_4c_Lista.Column5
332:             .ControlSource = "cursor_4c_Dados.acrescs"
333:             .Width         = 75
334:             .Movable       = .F.
335:             .Resizable     = .F.
336:         ENDWITH
337:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption = "Acr" + CHR(233) + "scimo"
338:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
339: 
340:         *-- Botoes CRUD dentro de cnt_4c_Botoes (Left=5/80/155/230/305, Top=5, W=75, H=75)
341:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
342:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
343:             .Caption         = "Incluir"
344:             .Top             = 5
345:             .Left            = 5
346:             .Width           = 75
347:             .Height          = 75

*-- Linhas 1206 a 1270:
1206:             .FontSize          = 8
1207:             .AllowHeaderSizing = .F.
1208:             .AllowRowSizing    = .F.
1209:             .DeleteMark        = .F.
1210:             .RecordMark        = .F.
1211:             .HeaderHeight      = 16
1212:             .RowHeight         = 16
1213:             .ScrollBars        = 2
1214:             .GridLineColor     = RGB(238, 238, 238)
1215:             .RecordSource      = "csGrade"
1216:             .Visible           = .T.
1217:         ENDWITH
1218:         WITH loc_oPgGrupos.grd_4c_Grade.Column1
1219:             .ColumnOrder   = 2
1220:             .ControlSource = "csGrade.Cgrus"
1221:             .Width         = 42
1222:             .Movable       = .F.
1223:             .Resizable     = .F.
1224:         ENDWITH
1225:         loc_oPgGrupos.grd_4c_Grade.Column1.Header1.Caption = "Grupo"
1226:         WITH loc_oPgGrupos.grd_4c_Grade.Column2
1227:             .ColumnOrder   = 4
1228:             .ControlSource = "csGrade.Dgrus"
1229:             .Width         = 224
1230:             .Movable       = .F.
1231:             .Resizable     = .F.
1232:         ENDWITH
1233:         loc_oPgGrupos.grd_4c_Grade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1234:         WITH loc_oPgGrupos.grd_4c_Grade.Column3
1235:             .ColumnOrder   = 5
1236:             .ControlSource = "csGrade.Coefs"
1237:             .Width         = 70
1238:             .Movable       = .F.
1239:             .Resizable     = .F.
1240:             .Sparse        = .F.
1241:         ENDWITH
1242:         loc_oPgGrupos.grd_4c_Grade.Column3.Header1.Caption = "Coeficiente"
1243:         loc_oPgGrupos.grd_4c_Grade.Column3.Text1.InputMask = "999.9999"
1244:         WITH loc_oPgGrupos.grd_4c_Grade.Column4
1245:             .ColumnOrder   = 3
1246:             .ControlSource = "csGrade.CPros"
1247:             .Width         = 108
1248:             .Movable       = .F.
1249:             .Resizable     = .F.
1250:             .Sparse        = .F.
1251:         ENDWITH
1252:         loc_oPgGrupos.grd_4c_Grade.Column4.Header1.Caption = "Produto"
1253:         WITH loc_oPgGrupos.grd_4c_Grade.Column5
1254:             .ColumnOrder   = 1
1255:             .ControlSource = "csGrade.Ordem"
1256:             .Width         = 42
1257:             .Movable       = .F.
1258:             .Resizable     = .F.
1259:         ENDWITH
1260:         loc_oPgGrupos.grd_4c_Grade.Column5.Header1.Caption = "Ordem"
1261:         loc_oPgGrupos.grd_4c_Grade.Column2.ReadOnly = .T.
1262:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "When",      THIS, "GradeGrupoCol1When")
1263:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "Valid",     THIS, "GradeGrupoCol1Valid")
1264:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "When",      THIS, "GradeGrupoCol3When")
1265:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "KeyPress", THIS, "GradeGrupoCol3LostFocus")
1266:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeGrupoCol4When")
1267:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "Valid",     THIS, "GradeGrupoCol4Valid")
1268:     ENDPROC
1269: 
1270:     *==========================================================================

*-- Linhas 1287 a 1381:
1287:             .FontSize          = 8
1288:             .AllowHeaderSizing = .F.
1289:             .AllowRowSizing    = .F.
1290:             .DeleteMark        = .F.
1291:             .RecordMark        = .F.
1292:             .HeaderHeight      = 16
1293:             .RowHeight         = 16
1294:             .ScrollBars        = 2
1295:             .GridLineColor     = RGB(238, 238, 238)
1296:             .RecordSource      = "csCusto"
1297:             .Visible           = .T.
1298:         ENDWITH
1299:         WITH loc_oPgCusto.grd_4c_Custo.Column1
1300:             .ControlSource = "csCusto.Cpros"
1301:             .Width         = 108
1302:             .Movable       = .F.
1303:             .Resizable     = .F.
1304:         ENDWITH
1305:         loc_oPgCusto.grd_4c_Custo.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1306:         WITH loc_oPgCusto.grd_4c_Custo.Column2
1307:             .ControlSource = "csCusto.Dpros"
1308:             .Width         = 190
1309:             .Movable       = .F.
1310:             .Resizable     = .F.
1311:         ENDWITH
1312:         loc_oPgCusto.grd_4c_Custo.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1313:         loc_oPgCusto.grd_4c_Custo.Column2.ReadOnly = .T.
1314:         WITH loc_oPgCusto.grd_4c_Custo.Column3
1315:             .ColumnOrder   = 4
1316:             .ControlSource = "csCusto.Coefs"
1317:             .Width         = 70
1318:             .Movable       = .F.
1319:             .Resizable     = .F.
1320:             .Sparse        = .F.
1321:         ENDWITH
1322:         loc_oPgCusto.grd_4c_Custo.Column3.Header1.Caption = "Coeficiente"
1323:         loc_oPgCusto.grd_4c_Custo.Column3.Text1.InputMask = "999.9999"
1324:         WITH loc_oPgCusto.grd_4c_Custo.Column4
1325:             .ColumnOrder   = 3
1326:             .ControlSource = "csCusto.Seqs"
1327:             .Width         = 75
1328:             .Movable       = .F.
1329:             .Resizable     = .F.
1330:             .Sparse        = .F.
1331:         ENDWITH
1332:         loc_oPgCusto.grd_4c_Custo.Column4.Header1.Caption = "Seq" + CHR(252) + "encia"
1333:         loc_oPgCusto.grd_4c_Custo.Column4.Text1.InputMask = "99999"
1334:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "When",      THIS, "GradeCustoCol1When")
1335:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "Valid",     THIS, "GradeCustoCol1Valid")
1336:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "When",      THIS, "GradeCustoCol3When")
1337:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "KeyPress", THIS, "GradeCustoCol3LostFocus")
1338:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column4.Text1, "When",      THIS, "GradeCustoCol4When")
1339:         BINDEVENT(loc_oPgCusto, "Activate", THIS, "ConfigPage2Activate")
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * CarregarLista - Carrega dados no cursor da lista
1344:     * Grid e ControlSource: adicionados na Fase 4
1345:     *==========================================================================
1346:     PROCEDURE CarregarLista()
1347:         LOCAL loc_lResultado, loc_oGrid
1348:         loc_lResultado = .F.
1349: 
1350:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1351:             RETURN .T.
1352:         ENDIF
1353: 
1354:         TRY
1355:             IF !THIS.this_oBusinessObject.Buscar("")
1356:                 loc_lResultado = .F.
1357:             ELSE
1358:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1359:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1360:                     loc_oGrid.ColumnCount = 5
1361:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1362:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1363:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1364:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.valors"
1365:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moedas"
1366:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.acrescs"
1367:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1368:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1369:                     loc_oGrid.Column3.Header1.Caption = "Valor"
1370:                     loc_oGrid.Column4.Header1.Caption = "Moeda"
1371:                     loc_oGrid.Column5.Header1.Caption = "Acr" + CHR(233) + "scimo"
1372:                     loc_oGrid.Refresh()
1373:                 ENDIF
1374:                 loc_lResultado = .T.
1375:             ENDIF
1376:         CATCH TO loException
1377:             MsgErro("Erro em FormFti.CarregarLista:" + CHR(13) + loException.Message + ;
1378:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1379:             loc_lResultado = .F.
1380:         ENDTRY
1381: 

*-- Linhas 1426 a 1491:
1426:             RETURN .F.
1427:         ENDIF
1428: 
1429:         SELECT cursor_4c_Dados
1430:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1431: 
1432:         IF EMPTY(loc_cCodigo)
1433:             MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
1434:             RETURN .F.
1435:         ENDIF
1436: 
1437:         TRY
1438:             THIS.LockScreen = .T.
1439:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "FEITIO", 2
1440:             THIS.this_cUltCodigo = loc_cCodigo
1441:             THIS.AlternarPagina(1)
1442:             IF USED("cursor_4c_Dados")
1443:                 SELECT cursor_4c_Dados
1444:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1445:             ENDIF
1446:             THIS.LockScreen = .F.
1447:             loc_lResultado = .T.
1448:         CATCH TO loException
1449:             THIS.LockScreen = .F.
1450:             MsgErro("Erro em FormFti.BtnExpXMLClick:" + CHR(13) + loException.Message, "Erro")
1451:         ENDTRY
1452: 
1453:         RETURN loc_lResultado
1454:     ENDPROC
1455: 
1456:     *==========================================================================
1457:     * BtnImpXMLClick - Importa XML de feitio
1458:     *==========================================================================
1459:     PROCEDURE BtnImpXMLClick()
1460:         LOCAL loc_lResultado, loc_cCodigo
1461:         loc_lResultado = .F.
1462: 
1463:         TRY
1464:             THIS.LockScreen = .T.
1465:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1466:                 SELECT cursor_4c_Dados
1467:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1468:             ELSE
1469:                 loc_cCodigo = ""
1470:             ENDIF
1471: 
1472:             DO FORM SigOpXml WITH THIS, "", "I", "FEITIO", 2
1473:             THIS.this_cUltCodigo = loc_cCodigo
1474:             THIS.AlternarPagina(1)
1475:             IF USED("cursor_4c_Dados") AND !EMPTY(THIS.this_cUltCodigo)
1476:                 SELECT cursor_4c_Dados
1477:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1478:             ENDIF
1479:             THIS.LockScreen = .F.
1480:             loc_lResultado = .T.
1481:         CATCH TO loException
1482:             THIS.LockScreen = .F.
1483:             MsgErro("Erro em FormFti.BtnImpXMLClick:" + CHR(13) + loException.Message, "Erro")
1484:         ENDTRY
1485: 
1486:         RETURN loc_lResultado
1487:     ENDPROC
1488: 
1489:     *==========================================================================
1490:     * BtnSalvarClick - Valida e salva registro + itens
1491:     *==========================================================================

*-- Linhas 1584 a 1610:
1584:         ENDIF
1585: 
1586:         TRY
1587:             SELECT (loc_cCursor)
1588:             loc_nPos   = RECNO()
1589:             COUNT TO loc_nTotal
1590: 
1591:             IF loc_nTotal > 1
1592:                 IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Excluir Linha")
1593:                     SELECT (loc_cCursor)
1594:                     GO (loc_nPos)
1595:                     DELETE
1596:                     PACK
1597:                 ENDIF
1598:             ELSE
1599:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir o " + ;
1600:                          CHR(250) + "nico registro.", "Excluir Linha")
1601:             ENDIF
1602:         CATCH TO loException
1603:             MsgErro("Erro em FormFti.BtnExcluirLinhaClick:" + CHR(13) + loException.Message, "Erro")
1604:         ENDTRY
1605:     ENDPROC
1606: 
1607:     *==========================================================================
1608:     * FormParaBO - Transfere valores do Form para o BO
1609:     *==========================================================================
1610:     PROTECTED PROCEDURE FormParaBO()

*-- Linhas 1673 a 1695:
1673:         loc_oPg2.opt_4c_Etiquetas.Value = 3
1674: 
1675:         IF USED("csGrade")
1676:             SELECT csGrade
1677:             ZAP
1678:         ENDIF
1679:         IF USED("csCusto")
1680:             SELECT csCusto
1681:             ZAP
1682:         ENDIF
1683:     ENDPROC
1684: 
1685:     *==========================================================================
1686:     * HabilitarCampos - Habilita ou desabilita campos editaveis
1687:     *==========================================================================
1688:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1689:         LOCAL loc_oPg2
1690:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1691: 
1692:         loc_oPg2.txt_4c_Codigo.Enabled    = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1693:         loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
1694:         loc_oPg2.txt_4c_Valor.Enabled     = par_lHabilitar
1695:         loc_oPg2.txt_4c_CdMoeda.Enabled   = par_lHabilitar

*-- Linhas 1743 a 1811:
1743: 
1744:         TRY
1745:             IF USED("csGrade")
1746:                 SELECT csGrade
1747:                 ZAP
1748:             ENDIF
1749:             IF USED("csCusto")
1750:                 SELECT csCusto
1751:                 ZAP
1752:             ENDIF
1753: 
1754:             IF THIS.this_oBusinessObject.CarregarItens(par_cCodigo) AND USED("cursor_4c_Itens")
1755:                 SELECT cursor_4c_Itens
1756:                 GO TOP
1757:                 SCAN
1758:                     IF !EMPTY(ALLTRIM(cursor_4c_Itens.cgrus))
1759:                         INSERT INTO csGrade (Cgrus, CPros, Dgrus, Coefs, Ordem) ;
1760:                             VALUES (ALLTRIM(cursor_4c_Itens.cgrus), ;
1761:                                     ALLTRIM(cursor_4c_Itens.cpros), ;
1762:                                     "", ;
1763:                                     cursor_4c_Itens.coefs, ;
1764:                                     cursor_4c_Itens.ordem)
1765:                         IF USED("CrSigCdGrp")
1766:                             SELECT CrSigCdGrp
1767:                             IF SEEK(ALLTRIM(cursor_4c_Itens.cgrus), "CrSigCdGrp", "Cgrus")
1768:                                 SELECT csGrade
1769:                                 GO BOTTOM
1770:                                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus)
1771:                             ENDIF
1772:                         ENDIF
1773:                     ELSE
1774:                         INSERT INTO csCusto (Cpros, Dpros, Seqs, Coefs) ;
1775:                             VALUES (ALLTRIM(cursor_4c_Itens.cpros), ;
1776:                                     "", ;
1777:                                     cursor_4c_Itens.seqs, ;
1778:                                     cursor_4c_Itens.coefs)
1779:                         IF USED("CrSigCdPro")
1780:                             SELECT CrSigCdPro
1781:                             IF SEEK(ALLTRIM(cursor_4c_Itens.cpros), "CrSigCdPro", "Cpros")
1782:                                 SELECT csCusto
1783:                                 GO BOTTOM
1784:                                 REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros)
1785:                             ENDIF
1786:                         ENDIF
1787:                     ENDIF
1788:                 ENDSCAN
1789:             ENDIF
1790: 
1791:             INSERT INTO csGrade (Cgrus) VALUES ("")
1792:             INSERT INTO csCusto (Cpros) VALUES ("")
1793: 
1794:             SELECT csGrade
1795:             GO TOP
1796:             SELECT csCusto
1797:             GO TOP
1798: 
1799:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1, "grd_4c_Grade", 5)
1800:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade.Refresh()
1801:             ENDIF
1802:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
1803:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Refresh()
1804:             ENDIF
1805: 
1806:             loc_lResultado = .T.
1807:         CATCH TO loException
1808:             MsgErro("Erro em FormFti.CarregarItensNaGrade:" + CHR(13) + loException.Message, "Erro")
1809:         ENDTRY
1810: 
1811:         RETURN loc_lResultado

*-- Linhas 1874 a 1892:
1874:             RETURN
1875:         ENDIF
1876: 
1877:         SELECT cursor_4c_Dados
1878:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1879: 
1880:         IF EMPTY(loc_cCodigo)
1881:             MsgAviso("Selecione um registro.", "Visualizar")
1882:             RETURN
1883:         ENDIF
1884: 
1885:         THIS.this_cUltCodigo = loc_cCodigo
1886:         THIS.this_cModoAtual = "VISUALIZAR"
1887:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1888:         THIS.BOParaForm()
1889:         THIS.CriarCursoresGrade()
1890:         THIS.CarregarItensNaGrade(loc_cCodigo)
1891:         THIS.HabilitarCampos(.F.)
1892:         THIS.AjustarBotoesPorModo()

*-- Linhas 1905 a 1923:
1905:             RETURN
1906:         ENDIF
1907: 
1908:         SELECT cursor_4c_Dados
1909:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1910: 
1911:         IF EMPTY(loc_cCodigo)
1912:             MsgAviso("Selecione um registro para alterar.", "Alterar")
1913:             RETURN
1914:         ENDIF
1915: 
1916:         THIS.this_cUltCodigo = loc_cCodigo
1917:         THIS.this_cModoAtual = "ALTERAR"
1918:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1919:         THIS.this_oBusinessObject.EditarRegistro()
1920:         THIS.BOParaForm()
1921:         THIS.CriarCursoresGrade()
1922:         THIS.CarregarItensNaGrade(loc_cCodigo)
1923:         THIS.HabilitarCampos(.T.)

*-- Linhas 1938 a 1956:
1938:             RETURN
1939:         ENDIF
1940: 
1941:         SELECT cursor_4c_Dados
1942:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1943: 
1944:         IF EMPTY(loc_cCodigo)
1945:             MsgAviso("Selecione um registro para excluir.", "Excluir")
1946:             RETURN
1947:         ENDIF
1948: 
1949:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do feitio '" + loc_cCodigo + "'?", "Excluir")
1950:             RETURN
1951:         ENDIF
1952: 
1953:         TRY
1954:             THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1955:             IF THIS.this_oBusinessObject.Excluir()
1956:                 THIS.this_cUltCodigo = ""

*-- Linhas 1977 a 2008:
1977:             RETURN
1978:         ENDIF
1979: 
1980:         loc_cFiltro = "(cods LIKE " + EscaparSQL(ALLTRIM(loc_cTexto) + "%") + ;
1981:                       " OR descs LIKE " + EscaparSQL(ALLTRIM(loc_cTexto) + "%") + ")"
1982: 
1983:         TRY
1984:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1985:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1986:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1987:                     loc_oGrid.ColumnCount = 5
1988:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1989:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1990:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1991:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.valors"
1992:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moedas"
1993:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.acrescs"
1994:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1995:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1996:                     loc_oGrid.Column3.Header1.Caption = "Valor"
1997:                     loc_oGrid.Column4.Header1.Caption = "Moeda"
1998:                     loc_oGrid.Column5.Header1.Caption = "Acr" + CHR(233) + "scimo"
1999:                     loc_oGrid.Refresh()
2000:                 ENDIF
2001:                 IF RECCOUNT("cursor_4c_Dados") = 0
2002:                     MsgAviso("Nenhum registro encontrado.", "Buscar")
2003:                 ENDIF
2004:             ENDIF
2005:         CATCH TO loException
2006:             MsgErro("Erro em FormFti.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
2007:         ENDTRY
2008:     ENDPROC

*-- Linhas 2201 a 2242:
2201: 
2202:         TRY
2203:             IF SEEK(loc_cCodigo, "CrSigCdGrp", "Cgrus")
2204:                 SELECT csGrade
2205:                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2206:                         Coefs WITH CrSigCdGrp.Coefs
2207:             ELSE
2208:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2209:                     "SigCdGrp", "cursor_4c_BuscaGrp", "Cgrus", loc_cCodigo, ;
2210:                     "Grupos de Produto")
2211:                 IF VARTYPE(loc_oBusca) = "O"
2212:                     IF !loc_oBusca.this_lAchouRegistro
2213:                         loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
2214:                         loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2215:                         loc_oBusca.Show()
2216:                     ENDIF
2217:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
2218:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaGrp.Cgrus)
2219:                         SELECT csGrade
2220:                         REPLACE Cgrus WITH loc_cSelecionado
2221:                         IF SEEK(loc_cSelecionado, "CrSigCdGrp", "Cgrus")
2222:                             SELECT csGrade
2223:                             REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2224:                                     Coefs WITH CrSigCdGrp.Coefs
2225:                         ENDIF
2226:                     ELSE
2227:                         SELECT csGrade
2228:                         REPLACE Cgrus WITH "", Dgrus WITH ""
2229:                     ENDIF
2230:                     loc_oBusca.Release()
2231:                 ENDIF
2232:                 IF USED("cursor_4c_BuscaGrp")
2233:                     USE IN cursor_4c_BuscaGrp
2234:                 ENDIF
2235:             ENDIF
2236:         CATCH TO loException
2237:             MsgErro("Erro em GradeGrupoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2238:             loc_lResultado = .F.
2239:         ENDTRY
2240: 
2241:         RETURN loc_lResultado
2242:     ENDPROC

*-- Linhas 2257 a 2280:
2257:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade
2258: 
2259:         TRY
2260:             SELECT * FROM csGrade WHERE (EMPTY(Cgrus) AND Ordem <> 0) INTO CURSOR TmpBranco
2261:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2262:                 SET CONFIRM OFF
2263:                 IF LASTKEY() = 13
2264:                     SELECT csGrade
2265:                     INSERT INTO csGrade (Cgrus) VALUES ("")
2266:                     loc_oPag.Refresh()
2267:                     loc_oPag.Column1.SetFocus()
2268:                     KEYBOARD "{DnArrow}"
2269:                 ENDIF
2270:             ENDIF
2271:         CATCH TO loException
2272:             MsgErro("Erro em GradeGrupoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2273:         ENDTRY
2274: 
2275:         IF USED("TmpBranco")
2276:             USE IN TmpBranco
2277:         ENDIF
2278:     ENDPROC
2279: 
2280:     *==========================================================================

*-- Linhas 2315 a 2337:
2315:                     loc_oBusca.Show()
2316:                 ENDIF
2317:                 IF loc_oBusca.this_lSelecionou AND USED("crListaRemota")
2318:                     SELECT csGrade
2319:                     REPLACE CPros WITH ALLTRIM(crListaRemota.CPros)
2320:                 ELSE
2321:                     IF LASTKEY() = 27
2322:                         SELECT csGrade
2323:                         REPLACE CPros WITH ""
2324:                     ENDIF
2325:                 ENDIF
2326:                 loc_oBusca.Release()
2327:             ENDIF
2328:             IF USED("crListaRemota")
2329:                 USE IN crListaRemota
2330:             ENDIF
2331:         CATCH TO loException
2332:             MsgErro("Erro em GradeGrupoCol4Valid:" + CHR(13) + loException.Message, "Erro")
2333:             loc_lResultado = .F.
2334:         ENDTRY
2335: 
2336:         RETURN loc_lResultado
2337:     ENDPROC

*-- Linhas 2365 a 2421:
2365: 
2366:         TRY
2367:             IF SEEK(loc_cCodigo, "CrSigCdPro", "Cpros")
2368:                 SELECT csCusto
2369:                 REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2370:                         Coefs WITH CrSigCdPro.pVens, ;
2371:                         Seqs  WITH RECNO("csCusto")
2372:             ELSE
2373:                 loc_cFiltro = ""
2374:                 IF USED("TmpParac") AND RECCOUNT("TmpParac") > 0
2375:                     SELECT TmpParac
2376:                     GO TOP
2377:                     IF !EMPTY(ALLTRIM(TmpParac.CgruCfxs))
2378:                         loc_cFiltro = "Cgrus = " + EscaparSQL(ALLTRIM(TmpParac.CgruCfxs))
2379:                     ENDIF
2380:                 ENDIF
2381:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2382:                     "SigCdPro", "cursor_4c_BuscaPro", "Cpros", loc_cCodigo, ;
2383:                     "Custos Fixo", .F., .T., loc_cFiltro)
2384:                 IF VARTYPE(loc_oBusca) = "O"
2385:                     IF !loc_oBusca.this_lAchouRegistro
2386:                         loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2387:                         loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2388:                         loc_oBusca.Show()
2389:                     ENDIF
2390:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
2391:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.Cpros)
2392:                         SELECT csCusto
2393:                         REPLACE Cpros WITH loc_cSelecionado
2394:                         IF SEEK(loc_cSelecionado, "CrSigCdPro", "Cpros")
2395:                             SELECT csCusto
2396:                             REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2397:                                     Coefs WITH CrSigCdPro.pVens, ;
2398:                                     Seqs  WITH RECNO("csCusto")
2399:                         ELSE
2400:                             SELECT csCusto
2401:                             REPLACE Dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros), ;
2402:                                     Coefs WITH cursor_4c_BuscaPro.pVens, ;
2403:                                     Seqs  WITH RECNO("csCusto")
2404:                         ENDIF
2405:                     ELSE
2406:                         SELECT csCusto
2407:                         REPLACE Cpros WITH "", Dpros WITH ""
2408:                     ENDIF
2409:                     loc_oBusca.Release()
2410:                 ENDIF
2411:                 IF USED("cursor_4c_BuscaPro")
2412:                     USE IN cursor_4c_BuscaPro
2413:                 ENDIF
2414:             ENDIF
2415:         CATCH TO loException
2416:             MsgErro("Erro em GradeCustoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2417:             loc_lResultado = .F.
2418:         ENDTRY
2419: 
2420:         RETURN loc_lResultado
2421:     ENDPROC

*-- Linhas 2435 a 2460:
2435:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo
2436: 
2437:         TRY
2438:             SELECT * FROM csCusto WHERE EMPTY(Cpros) INTO CURSOR TmpBranco
2439:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2440:                 SELECT csCusto
2441:                 INSERT INTO csCusto (Cpros) VALUES ("")
2442:                 GO BOTTOM IN csCusto
2443:             ENDIF
2444:             IF LASTKEY() = 13
2445:                 SELECT csCusto
2446:                 loc_oPag.Refresh()
2447:                 loc_oPag.Column1.SetFocus()
2448:                 KEYBOARD "{DnArrow}"
2449:             ENDIF
2450:         CATCH TO loException
2451:             MsgErro("Erro em GradeCustoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2452:         ENDTRY
2453: 
2454:         IF USED("TmpBranco")
2455:             USE IN TmpBranco
2456:         ENDIF
2457:     ENDPROC
2458: 
2459:     *==========================================================================
2460:     * GradeCustoCol4When - When do Col4 (Seqs) do grd_4c_Custo


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

