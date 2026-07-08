# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, NUMES, VALPRES, VALINIS, EMPDOPNUMS, CIDQUERYS, VENDS, OPERS, CEMPS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, NUMES, VALPRES, VALINIS, EMPDOPNUMS, CIDQUERYS, VENDS, OPERS, CEMPS, DATAS

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
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
		.SqlExecute([Select MoePadVens, GrPadVens From SigCdPam],"crSigCdPam")
SqlEmp = [Select cEmps, Razas, TipoNFs From SigCdEmp Where not SigCdEmp.tiponfs = 2]
ThisForm.poDatamgr.SqlExecute(SqlEmp,"JanEmp")
Select JanEmp
lcSQLCmd = [Select Codigos, Descrs From SigCdTom]
If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, 'crSigCdTom') < 1)
Select crSigCdTom
	Insert Into Cs_SigCdTom (Marca,Codigos,Descri) ;
Select cs_SigCdTom
Insert Into csCabecalho (NomeEmp, Titulo, Titulo2, Titulo3, tObs, Analitico, NVend, Titulos) ;
	Select cs_SigCdTom
SqlEest = [Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, b.nSinals, b.ValItens, b.Moeds, a.Datas, ]+;
  		  [From SigMvCab a, SigMvMov b, SigCdCli c, SigCdOpe O ]+;
ThisForm.poDatamgr.SqlExecute(SqlEest,"csSqlEest")
Select csSqlEest
Select Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
  	   From csSqlEest ;
SqlEest = [Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, a.ValInis, o.cMoes, a.Datas, ]+;
  		  [From SigMvCab a, SigCdCli c, SigCdOpe O ]+;
ThisForm.poDatamgr.SqlExecute(SqlEest,"csSqlEest2")
Select csSqlEest2
Select Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
  	   From csSqlEest2 ;
Select Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, Tp, Soma, ;
       From TmpCsRelat ;
Select Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs,  Tp, Soma, ;
       From TmpCsRela2 ;
Select Emps, Dopes, Numes, Obses From  csSqlEest ;
Select Emps, Dopes, Numes, Obses From  csSqlEest2 ;
Select a.*,b.Obses from csRelatorio1 a Left Join TmpObses b ;
Select csRelatorio
	Select csRelatorio
			Delete
	Select csRelatorio 
		Insert Into CrSigTempR From MemVar
		Select CsRelatorio
	If ThisForm.poDataMgr.Update('CrSigTempR')
	SqlEesti = [Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.cPros As Vends, a.Razas As RClis, a.Qtds As ValInis, ]+;
	       	   [From SigTempR a, SigMvItn b ]+;
	ThisForm.poDatamgr.SqlExecute(SqlEesti,"csProdutos")
	Select csProdutos
	Select csProdutos
		Select crSigMvMov
	Select csProdutos
		oProg.Update(.t.)
	Select csProdutos
		oProg.Update( .t. )																			
		Insert Into csRelatorio (Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, Obses, Tp, ;
	Select csRelatorio
Select csRelatorio
	Select Emps, Count(1) as TotSoma ;
	       From TmpCsRelat ;
	Select Emps, Count(1) as TotSoma ;
	       From TmpCsRela2 ;
	Select Emps, Sum(ValInis) as ValInis, Sum(Valos) as Valos,  ;
      From csRelatorio ;
	Select csRelatorio
		If Seek(csRelatorio.Emps, 'csTot1', 'Emps')
		If Seek(csRelatorio.Emps, 'csTot2', 'Emps')
Select csRelatorio
Select crSigCdPam
Select crSigCdPam
	Select Janemp
	Select Janemp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREADS.prg) - TRECHOS RELEVANTES PARA PASS SQL (1779 linhas total):

*-- Linhas 375 a 435:
375: 
376:         *-- Garantir cursor disponivel (pode estar ausente em modo de valida" + CHR(231) + CHR(227) + "o UI)
377:         IF !USED(loc_cCursor)
378:             CREATE CURSOR (loc_cCursor) (Marca N(1), Codigos N(2), Descri C(40))
379:         ENDIF
380: 
381:         *-- Grid de tipos de opera" + CHR(231) + CHR(227) + "o (GrdTipo original: width=279, height=110)
382:         loc_oPagina.AddObject("grd_4c_TipoOps", "Grid")
383:         loc_oGrid = loc_oPagina.grd_4c_TipoOps
384: 
385:         *-- ColumnCount ANTES do WITH para criar colunas antes de configurar
386:         loc_oGrid.ColumnCount = 2
387: 
388:         WITH loc_oGrid
389:             .Top                = 110
390:             .Left               = 277
391:             .Width              = 279
392:             .Height             = 110
393:             .RecordMark         = .F.
394:             .DeleteMark         = .F.
395:             .GridLineColor      = RGB(238, 238, 238)
396:             .HighlightStyle     = 2
397:             .HighlightBackColor = RGB(255, 255, 255)
398:             .HighlightForeColor = RGB(15, 41, 104)
399:             .ScrollBars         = 2
400:             .RowHeight          = 16
401:             .FontName           = "Verdana"
402:             .FontSize           = 8
403:         ENDWITH
404: 
405:         *-- Column1: CheckBox para Marca (sele" + CHR(231) + CHR(227) + "o do tipo)
406:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS de CurrentControl
407:         WITH loc_oGrid.Column1
408:             .Width = 25
409:             .AddObject("Check1", "CheckBox")
410:             .Check1.Caption = ""
411:             .Check1.Value   = 0
412:             .CurrentControl = "Check1"
413:             .ControlSource  = loc_cCursor + ".Marca"
414:             .Header1.Caption = ""
415:         ENDWITH
416: 
417:         *-- Column2: Descri" + CHR(231) + CHR(227) + "o do tipo de opera" + CHR(231) + CHR(227) + "o (read-only)
418:         WITH loc_oGrid.Column2
419:             .Width         = 250
420:             .ControlSource = loc_cCursor + ".Descri"
421:             .ReadOnly      = .T.
422:             .FontName      = "Verdana"
423:             .FontSize      = 8
424:             .ForeColor     = RGB(90, 90, 90)
425:         ENDWITH
426: 
427:         *-- RecordSource APOS configurar colunas (evita reset antecipado de headers)
428:         loc_oGrid.RecordSource = loc_cCursor
429: 
430:         *-- Reconfigurar headers APOS RecordSource (RecordSource reseta headers)
431:         loc_oGrid.Column1.Header1.Caption = ""
432:         loc_oGrid.Column2.Header1.Caption = "Descrs"
433:         loc_oGrid.Column2.Header1.FontName = "Tahoma"
434:         loc_oGrid.Column2.Header1.FontSize = 8
435: 

*-- Linhas 485 a 522:
485:         TRY
486:             loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
487:             IF USED(loc_cCursor)
488:                 SELECT (loc_cCursor)
489:                 REPLACE ALL Marca WITH 1
490:                 GO TOP
491:                 THIS.pgf_4c_Paginas.Page1.grd_4c_TipoOps.Refresh()
492:             ENDIF
493:         CATCH TO loc_oErro
494:             MsgErro(loc_oErro.Message, "Erro")
495:         ENDTRY
496:     ENDPROC
497: 
498:     *--------------------------------------------------------------------------
499:     * BtnApagaClick - Desmarca todos os tipos de opera" + CHR(231) + CHR(227) + "o no grid
500:     *   Equivale ao apaga.Click do original: replace all marca with 0
501:     *--------------------------------------------------------------------------
502:     PROCEDURE BtnApagaClick()
503:         LOCAL loc_cCursor
504:         TRY
505:             loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
506:             IF USED(loc_cCursor)
507:                 SELECT (loc_cCursor)
508:                 REPLACE ALL Marca WITH 0
509:                 GO TOP
510:                 THIS.pgf_4c_Paginas.Page1.grd_4c_TipoOps.Refresh()
511:             ENDIF
512:         CATCH TO loc_oErro
513:             MsgErro(loc_oErro.Message, "Erro")
514:         ENDTRY
515:     ENDPROC
516: 
517:     *--------------------------------------------------------------------------
518:     * AlternarPagina - Navega para a pagina solicitada no PageFrame
519:     *   Form REPORT possui apenas 1 pagina; navega se o indice for valido
520:     *--------------------------------------------------------------------------
521:     PROCEDURE AlternarPagina(par_nPagina)
522:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;

*-- Linhas 1146 a 1168:
1146:                 loc_oPagina.txt_4c_Dempresa.Value = ""
1147:                 RETURN
1148:             ENDIF
1149:             loc_cSQL = "SELECT TOP 1 cEmps, Razas FROM SigCdEmp WHERE cEmps = " + ;
1150:                        EscaparSQL(loc_cCodigo)
1151:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrEmpVal")
1152:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpVal")
1153:                 SELECT cursor_4c_SigrEmpVal
1154:                 loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_SigrEmpVal.cEmps)
1155:                 loc_oPagina.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_SigrEmpVal.Razas)
1156:             ELSE
1157:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
1158:                 loc_oPagina.txt_4c_Empresa.Value  = ""
1159:                 loc_oPagina.txt_4c_Dempresa.Value = ""
1160:                 THIS.AbrirBuscaEmpresa()
1161:             ENDIF
1162:             IF USED("cursor_4c_SigrEmpVal")
1163:                 USE IN cursor_4c_SigrEmpVal
1164:             ENDIF
1165:         CATCH TO loc_oErro
1166:             MsgErro(loc_oErro.Message, "Erro")
1167:         ENDTRY
1168:     ENDPROC

*-- Linhas 1193 a 1211:
1193:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1194:                 loc_oBusca.Show()
1195:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1196:                     SELECT (loc_cCursor)
1197:                     loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cEmps)
1198:                     loc_oPagina.txt_4c_Dempresa.Value = ALLTRIM(Razas)
1199:                 ENDIF
1200:                 loc_oBusca.Release()
1201:             ENDIF
1202:         CATCH TO loc_oErro
1203:             MsgErro(loc_oErro.Message, "Erro")
1204:         ENDTRY
1205:         IF USED("cursor_4c_SigrJanEmp")
1206:             USE IN cursor_4c_SigrJanEmp
1207:         ENDIF
1208:     ENDPROC
1209: 
1210:     *==========================================================================
1211:     *  VALIDACAO + LOOKUP - Vendedor

*-- Linhas 1223 a 1245:
1223:                 loc_oPagina.txt_4c_Dvend.Value = ""
1224:                 RETURN
1225:             ENDIF
1226:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + ;
1227:                        EscaparSQL(loc_cCodigo)
1228:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrVendVal")
1229:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrVendVal")
1230:                 SELECT cursor_4c_SigrVendVal
1231:                 loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendVal.Iclis)
1232:                 loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendVal.Rclis)
1233:             ELSE
1234:                 MsgAviso("Vendedor n" + CHR(227) + "o encontrado.", "Vendedor")
1235:                 loc_oPagina.txt_4c_Vended.Value = ""
1236:                 loc_oPagina.txt_4c_Dvend.Value  = ""
1237:                 THIS.AbrirBuscaVended()
1238:             ENDIF
1239:             IF USED("cursor_4c_SigrVendVal")
1240:                 USE IN cursor_4c_SigrVendVal
1241:             ENDIF
1242:         CATCH TO loc_oErro
1243:             MsgErro(loc_oErro.Message, "Erro")
1244:         ENDTRY
1245:     ENDPROC

*-- Linhas 1257 a 1293:
1257:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1258:                 loc_cGrupo = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
1259:             ENDIF
1260:             loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "CdGrps = " + EscaparSQL(loc_cGrupo), "")
1261: 
1262:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1263:                 "SigCdCli", "cursor_4c_SigrVendBusca", "Iclis", loc_cValor, ;
1264:                 "Selecionar Vendedor", loc_cFiltro)
1265:             IF VARTYPE(loc_oBusca) = "O"
1266:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1267:                     IF USED("cursor_4c_SigrVendBusca")
1268:                         SELECT cursor_4c_SigrVendBusca
1269:                         loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendBusca.Iclis)
1270:                         loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendBusca.Rclis)
1271:                     ENDIF
1272:                 ELSE
1273:                     IF !loc_oBusca.this_lAchouRegistro
1274:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1275:                     loc_oBusca.mAddColuna("Rclis", "", "Nome")
1276:                     loc_oBusca.Show()
1277:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrVendBusca")
1278:                         SELECT cursor_4c_SigrVendBusca
1279:                         loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendBusca.Iclis)
1280:                         loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendBusca.Rclis)
1281:                     ENDIF
1282:                     ENDIF
1283:                 ENDIF
1284:                 loc_oBusca.Release()
1285:             ENDIF
1286:         CATCH TO loc_oErro
1287:             MsgErro(loc_oErro.Message, "Erro")
1288:         ENDTRY
1289:         IF USED("cursor_4c_SigrVendBusca")
1290:             USE IN cursor_4c_SigrVendBusca
1291:         ENDIF
1292:     ENDPROC
1293: 

*-- Linhas 1306 a 1328:
1306:             IF EMPTY(loc_cCodigo)
1307:                 RETURN
1308:             ENDIF
1309:             loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + ;
1310:                        EscaparSQL(loc_cCodigo)
1311:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrOpeVal")
1312:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrOpeVal")
1313:                 SELECT cursor_4c_SigrOpeVal
1314:                 loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeVal.Dopes)
1315:             ELSE
1316:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", ;
1317:                          "Opera" + CHR(231) + CHR(227) + "o")
1318:                 loc_oPagina.txt_4c_Operacao.Value = ""
1319:                 THIS.AbrirBuscaOperacao()
1320:             ENDIF
1321:             IF USED("cursor_4c_SigrOpeVal")
1322:                 USE IN cursor_4c_SigrOpeVal
1323:             ENDIF
1324:         CATCH TO loc_oErro
1325:             MsgErro(loc_oErro.Message, "Erro")
1326:         ENDTRY
1327:     ENDPROC
1328: 

*-- Linhas 1341 a 1367:
1341:             IF VARTYPE(loc_oBusca) = "O"
1342:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1343:                     IF USED("cursor_4c_SigrOpeBusca")
1344:                         SELECT cursor_4c_SigrOpeBusca
1345:                         loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeBusca.Dopes)
1346:                     ENDIF
1347:                 ELSE
1348:                     IF !loc_oBusca.this_lAchouRegistro
1349:                     loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1350:                     loc_oBusca.Show()
1351:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrOpeBusca")
1352:                         SELECT cursor_4c_SigrOpeBusca
1353:                         loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeBusca.Dopes)
1354:                     ENDIF
1355:                     ENDIF
1356:                 ENDIF
1357:                 loc_oBusca.Release()
1358:             ENDIF
1359:         CATCH TO loc_oErro
1360:             MsgErro(loc_oErro.Message, "Erro")
1361:         ENDTRY
1362:         IF USED("cursor_4c_SigrOpeBusca")
1363:             USE IN cursor_4c_SigrOpeBusca
1364:         ENDIF
1365:     ENDPROC
1366: 
1367:     *==========================================================================

*-- Linhas 1380 a 1402:
1380:                 loc_oPagina.txt_4c_Dmoeda.Value = ""
1381:                 RETURN
1382:             ENDIF
1383:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1384:                        EscaparSQL(loc_cCodigo)
1385:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrMoeVal")
1386:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrMoeVal")
1387:                 SELECT cursor_4c_SigrMoeVal
1388:                 loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeVal.CMoes)
1389:                 loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeVal.DMoes)
1390:             ELSE
1391:                 MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Moeda")
1392:                 loc_oPagina.txt_4c_Cmoeda.Value = ""
1393:                 loc_oPagina.txt_4c_Dmoeda.Value = ""
1394:                 THIS.AbrirBuscaMoeda()
1395:             ENDIF
1396:             IF USED("cursor_4c_SigrMoeVal")
1397:                 USE IN cursor_4c_SigrMoeVal
1398:             ENDIF
1399:         CATCH TO loc_oErro
1400:             MsgErro(loc_oErro.Message, "Erro")
1401:         ENDTRY
1402:     ENDPROC

*-- Linhas 1417 a 1445:
1417:             IF VARTYPE(loc_oBusca) = "O"
1418:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1419:                     IF USED("cursor_4c_SigrMoeBusca")
1420:                         SELECT cursor_4c_SigrMoeBusca
1421:                         loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.CMoes)
1422:                         loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.DMoes)
1423:                     ENDIF
1424:                 ELSE
1425:                     IF !loc_oBusca.this_lAchouRegistro
1426:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1427:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1428:                     loc_oBusca.Show()
1429:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrMoeBusca")
1430:                         SELECT cursor_4c_SigrMoeBusca
1431:                         loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.CMoes)
1432:                         loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.DMoes)
1433:                     ENDIF
1434:                     ENDIF
1435:                 ENDIF
1436:                 loc_oBusca.Release()
1437:             ENDIF
1438:         CATCH TO loc_oErro
1439:             MsgErro(loc_oErro.Message, "Erro")
1440:         ENDTRY
1441:         IF USED("cursor_4c_SigrMoeBusca")
1442:             USE IN cursor_4c_SigrMoeBusca
1443:         ENDIF
1444:     ENDPROC
1445: 


### BO (C:\4c\projeto\app\classes\SIGREADSBO.prg):
*==============================================================================
* SIGREADSBO.PRG
* Business Object para Relatorio de Apuracao de Descontos/Acrescimos
*
* Form: FormSIGREADS
* Tabelas: SigMvCab, SigMvMov, SigCdCli, SigCdOpe, SigTempR
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREADSBO AS RelatorioBase

    *-- Filtros de empresa
    this_cEmpresa        = ""    && codigo empresa (cEmps em SigCdEmp - Get_Empresa)
    this_cDEmpresa       = ""    && razao social empresa (Razas em SigCdEmp - Get_Dempresa)

    *-- Filtros de vendedor
    this_cVendedor       = ""    && codigo vendedor (Iclis em SigCdCli - Get_Vended)
    this_cDVendedor      = ""    && nome vendedor (Rclis em SigCdCli - Get_Dvend)

    *-- Filtro de operacao
    this_cNmOperacao     = ""    && codigo da operacao (Dopes em SigCdOpe - get_nm_operacao, max 20)

    *-- Filtros de periodo
    this_dDtInicial      = {}    && data inicial do periodo (get_dt_inicial)
    this_dDtFinal        = {}    && data final do periodo (get_dt_final)

    *-- Filtros de moeda
    this_cMoeda          = ""    && codigo moeda (CMoes em SigCdMoe - getCmoeda, max 3)
    this_cDMoeda         = ""    && descricao moeda (DMoes em SigCdMoe - getDmoeda, max 15)

    *-- Filtro de margem
    this_nMargem         = 0     && margem de tolerancia percentual (getMargem, formato 99.99)

    *-- Opcoes de relatorio
    this_nTipoVars       = 1     && tipo variacao: 1=Desconto, 2=Acrescimo, 3=Ambos, 4=Geral (Opt_TipoVars)
    this_nObs            = 0     && imprimir observacoes: 1=Sim, 0=Nao (Opt_obs)
    this_nTipoRel        = 2     && tipo relatorio: 1=Sintetico, 2=Analitico, 3=Resumo (optTipoRel)

    *-- Flags de acesso (fChecaAcesso)
    this_lTitulos        = .F.   && exibe titulos completos (fChecaAcesso 'SigReAds','TITULOS')
    this_lNomeVend       = .F.   && exibe nome do vendedor (fChecaAcesso 'SigReAds','NOMEVEND')

    *-- Dados auxiliares carregados no Init
    this_cGrPadVens      = ""    && GrPadVens de SigCdPam (grupo padrao de vendas para lookup de vendedor)

    *-- Cursores
    this_cCursorDados    = "csRelatorio"         && cursor principal de saida para REPORT FORM
    this_cCursorTipos    = "cursor_4c_TipoOps"   && cursor com tipos de operacao selecionados no grid
    this_cIdQuery        = ""                     && ID unico para cleanup de SigTempR no modo analitico

    *--------------------------------------------------------------------------
    * Init - Configura o BO e carrega flags de acesso
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "Numes"
            THIS.this_lTitulos    = fChecaAcesso("SigReAds", "TITULOS")
            THIS.this_lNomeVend   = fChecaAcesso("SigReAds", "NOMEVEND")
            loc_lSucesso          = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosPadrao - Carrega valores iniciais de SigCdPam e empresa
    * Chamado pelo Form apos CREATEOBJECT para pre-preencher campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosPadrao()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar SigCdPam para moeda e grupo padrao de vendas
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 MoePadVens, GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrPam")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrPam")
                SELECT cursor_4c_SigrPam
                THIS.this_cMoeda     = ALLTRIM(cursor_4c_SigrPam.MoePadVens)
                THIS.this_cGrPadVens = ALLTRIM(cursor_4c_SigrPam.GrPadVens)
            ENDIF
            IF USED("cursor_4c_SigrPam")
                USE IN cursor_4c_SigrPam
            ENDIF

            *-- Empresa e datas padrao
            THIS.this_cEmpresa   = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()

            *-- Descricao da moeda padrao
            IF !EMPTY(THIS.this_cMoeda)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 DMoes FROM SigCdMoe WHERE CMoes = " + ;
                    EscaparSQL(THIS.this_cMoeda), "cursor_4c_SigrMoe")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrMoe")
                    SELECT cursor_4c_SigrMoe
                    THIS.this_cDMoeda = ALLTRIM(cursor_4c_SigrMoe.DMoes)
                ENDIF
                IF USED("cursor_4c_SigrMoe")
                    USE IN cursor_4c_SigrMoe
                ENDIF
            ENDIF

            *-- Descricao da empresa padrao
            IF !EMPTY(THIS.this_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(THIS.this_cEmpresa), "cursor_4c_SigrEmpPad")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpPad")
                    SELECT cursor_4c_SigrEmpPad
                    THIS.this_cDEmpresa = ALLTRIM(cursor_4c_SigrEmpPad.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpPad")
                    USE IN cursor_4c_SigrEmpPad
                ENDIF
            ENDIF

            *-- Valores padrao das opcoes (igual ao legado: TipoVars=3, TipoRel=2)
            THIS.this_nTipoVars = 3
            THIS.this_nTipoRel  = 2
            THIS.this_nObs      = 0
            THIS.this_nMargem   = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacao - Carrega SigCdTom para cursor do grid de tipos
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_TipoOps)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacao(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult, loc_nMarca
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            CREATE CURSOR (par_cCursorDestino) (Marca N(1), Codigos N(2), Descri C(40))
            INDEX ON Codigos TAG Codigos

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_SigrTomTmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrTomTmp
                SCAN
                    loc_nMarca = IIF(INLIST(cursor_4c_SigrTomTmp.Codigos, 4, 5), 1, 0)
                    INSERT INTO (par_cCursorDestino) (Marca, Codigos, Descri) ;
                        VALUES (loc_nMarca, cursor_4c_SigrTomTmp.Codigos, ;
                                ALLTRIM(STR(cursor_4c_SigrTomTmp.Codigos, 2)) + "-" + ;
                                ALLTRIM(cursor_4c_SigrTomTmp.Descrs))
                ENDSCAN
                USE IN cursor_4c_SigrTomTmp
            ENDIF

            SELECT (par_cCursorDestino)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega SigCdEmp (exceto oficiais) para lookup
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_SigrJanEmp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cEmps, Razas, TipoNFs FROM SigCdEmp " + ;
                "WHERE NOT TipoNFs = 2 ORDER BY cEmps", ;
                par_cCursorDestino)
            IF loc_nResult > 0
                SELECT (par_cCursorDestino)
                INDEX ON cEmps TAG cEmps
                INDEX ON Razas TAG Razas
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Descontos/Acrescimos
    * Equivale ao PROCEDURE processamento do legado (SIGREADS.SCX)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_cEmpresa, loc_cOperacao, loc_cVendedor, loc_cMoedaOper
        LOCAL loc_cDtIniStr, loc_cDtFimStr, loc_cDtIniBase, loc_cDtFimBase
        LOCAL loc_nTipoVars, loc_nObs, loc_nTipoRel, loc_nMargem
        LOCAL loc_lAnalitico, loc_cIdQuery
        LOCAL loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, loc_lNomeVend, loc_cNmEmpresa
        LOCAL loc_cSQL, loc_nResult, loc_cWhere, loc_cNumOp, loc_cWhere1, loc_cWhere2
        LOCAL loc_cEmpDopNums, loc_cUniqueId, loc_nDif, loc_nRec
        LOCAL loc_nTotI1, loc_nTotI2, loc_nResto, loc_nRateio, loc_nVlVend
        LOCAL loc_nItnV, loc_nGerV, loc_cEmpV, loc_cVenV, loc_nNumV
        LOCAL loc_cEmpO, loc_cVenO, loc_nNumO, loc_nMarca

        loc_lSucesso = .F.
        TRY
            *-- 1. Ler filtros das propriedades THIS
            loc_cEmpresa   = ALLTRIM(THIS.this_cEmpresa)
            loc_cOperacao  = ALLTRIM(THIS.this_cNmOperacao)
            loc_cMoedaOper = ALLTRIM(THIS.this_cMoeda)
            loc_cVendedor  = ALLTRIM(THIS.this_cVendedor)
            loc_nTipoVars  = THIS.this_nTipoVars
            loc_nObs       = THIS.this_nObs
            loc_nTipoRel   = THIS.this_nTipoRel
            loc_nMargem    = THIS.this_nMargem
            loc_lAnalitico = (loc_nTipoRel # 1)

            *-- Formatar datas para SQL (DTOS retorna YYYYMMDD)
            loc_cDtIniBase = DTOS(THIS.this_dDtInicial)
            loc_cDtFimBase = DTOS(THIS.this_dDtFinal)
            loc_cDtIniStr  = "'" + SUBSTR(loc_cDtIniBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtIniBase,5,2) + "-" + SUBSTR(loc_cDtIniBase,7,2) + "'"
            loc_cDtFimStr  = "'" + SUBSTR(loc_cDtFimBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtFimBase,5,2) + "-" + SUBSTR(loc_cDtFimBase,7,2) + ;
                              " 23:59:59'"

            *-- 2. Textos do cabecalho
            loc_lcPeriodo = "PERIODO : " + DTOC(THIS.this_dDtInicial) + ;
                            " A " + DTOC(THIS.this_dDtFinal)
            IF THIS.this_lTitulos
                loc_lcTitulo  = "RELA" + CHR(199) + CHR(195) + "O DE APURA" + ;
                                CHR(199) + CHR(195) + "O DE DESCONTOS/ACR" + ;
                                CHR(201) + "SCIMOS"
                loc_lcSubTit  = "MOEDA : " + loc_cMoedaOper + " - " + ;
                                ALLTRIM(THIS.this_cDMoeda) + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - Margem : " + ALLTRIM(STR(loc_nMargem,5,2)) + "%", "")
                loc_lNomeVend = THIS.this_lNomeVend
            ELSE
                loc_lcTitulo  = "RAPDE"
                loc_lcSubTit  = loc_cMoedaOper + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - (" + ALLTRIM(STR(loc_nMargem,5,2)) + "%)", "")
                loc_lNomeVend = .F.
            ENDIF

            *-- 3. Nome da empresa
            loc_cNmEmpresa = loc_cEmpresa
            IF !EMPTY(loc_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(loc_cEmpresa), "cursor_4c_SigrEmpRel")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpRel")
                    SELECT cursor_4c_SigrEmpRel
                    loc_cNmEmpresa = ALLTRIM(cursor_4c_SigrEmpRel.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpRel")
                    USE IN cursor_4c_SigrEmpRel
                ENDIF
            ENDIF

            *-- 4. Cursor de cabecalho do relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (NomeEmp C(80), Titulo C(80), Titulo2 C(200), ;
                                        Titulo3 C(200), tObs N(1), Analitico L(1), ;
                                        NVend L(1), Titulos L(1))
            INSERT INTO csCabecalho ;
                (NomeEmp, Titulo, Titulo2, Titulo3, tObs, Analitico, NVend, Titulos) ;
                VALUES (loc_cNmEmpresa, loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, ;
                        loc_nObs, loc_lAnalitico, loc_lNomeVend, THIS.this_lTitulos)

            *-- 5. Limpar cursores de execucao anterior
            IF USED("csRelatorio")
                USE IN csRelatorio
            ENDIF
            IF USED("csProdutos")
                USE IN csProdutos
            ENDIF
            IF USED("csSqlEest")
                USE IN csSqlEest
            ENDIF
            IF USED("csSqlEest2")
                USE IN csSqlEest2
            ENDIF
            IF USED("TmpCsRelat")
                USE IN TmpCsRelat
            ENDIF
            IF USED("TmpCsRela2")
                USE IN TmpCsRela2
            ENDIF
            IF USED("csRelatorio1")
                USE IN csRelatorio1
            ENDIF

            *-- 6. Montar clausula de tipos de operacao selecionados no grid
            loc_cNumOp = ""
            IF EMPTY(loc_cOperacao) AND USED(THIS.this_cCursorTipos)
                SELECT (THIS.this_cCursorTipos)
                SCAN
                    IF Marca > 0
                        loc_cNumOp = loc_cNumOp + ;
                            IIF(!EMPTY(loc_cNumOp), " Or ", "(") + ;
                            "o.TipoOps = " + ALLTRIM(STR(Codigos, 2))
                    ENDIF
                ENDSCAN
                IF LEN(loc_cNumOp) > 1
                    loc_cNumOp = loc_cNumOp + ")"
                ENDIF
            ENDIF

            SET DECIMALS TO 2
            SET FIXED ON

            *-- 7. Query 1: SigMvCab+SigMvMov+SigCdCli+SigCdOpe (ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Emps = b.Emps And a.Dopes = b.Dopes And a.Numes = b.Numes And " + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "(o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "b.nSinals, b.ValItens, b.Moeds, a.Datas, " + ;
                       "b.ValTots, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigMvMov b, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest)"
                loc_lSucesso = .F.
            ENDIF

            *-- 8. VFP SELECT cotacao -> TmpCsRelat
            SELECT csSqlEest
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(IIF(nSinals < 0, -1, 1) * ValItens * ;
                       fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                       fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (ValTots * fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                    fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest ;
                   INTO CURSOR TmpCsRelat ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 9. Query 2: SigMvCab+SigCdCli+SigCdOpe (NOT ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "Not a.Valvars = 0 And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "Not (o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "a.ValInis, o.cMoes, a.Datas, " + ;
                       "a.Valos, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest2")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest2)"
                loc_lSucesso = .F.
            ENDIF

            *-- 10. VFP SELECT cotacao -> TmpCsRela2
            SELECT csSqlEest2
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(ValInis * ;
                       IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                       fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (Valos * ;
                    IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                    fBuscarCotacao(loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest2 ;
                   INTO CURSOR TmpCsRela2 ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 11. Condicoes de filtro por tipo de variacao
            loc_cWhere1 = IIF(loc_nTipoVars=1, ;
                              "ValInis > Valos Or (ValInis = 0 And Not Valos = 0)", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos Or ValInis = 0", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            loc_cWhere2 = IIF(loc_nTipoVars=1, "ValInis > Valos", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            *-- 12. UNION ALL das duas selects -> csRelatorio1
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRelat ;
                   WHERE &loc_cWhere1. ;
                   UNION ALL ;
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRela2 ;
                   WHERE &loc_cWhere2. ;
                   INTO CURSOR csRelatorio1 ;
                   ORDER BY 1, 5, 2, 3, 11

            *-- 13. Cursor de observacoes unificado
            IF USED("TmpObses")
                USE IN TmpObses
            ENDIF
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest ;
            UNION ALL ;
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest2 ;
            INTO CURSOR TmpObses ;
            ORDER BY 1, 2, 3

            *-- 14. Left join observacoes -> csRelatorio READWRITE
            SELECT a.*, b.Obses FROM csRelatorio1 a ;
                               LEFT JOIN TmpObses b ;
                               ON a.Emps = b.Emps AND a.Dopes = b.Dopes AND ;
                                  a.Numes = b.Numes ;
                               INTO CURSOR csRelatorio READWRITE

            SELECT csRelatorio
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            INDEX ON Emps + Vends + Dopes + STR(Numes, 6) + Tp TAG VdDpNmTp

            *-- 15. Filtrar pela margem de tolerancia
            IF !EMPTY(loc_nMargem)
                SELECT csRelatorio
                SCAN
                    IF ABS(100 - ((Valos*100) / IIF(ValInis#0, ValInis, 1))) < loc_nMargem
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 16. Modo analitico: inserir cabecalhos em SigTempR e buscar produtos
            IF loc_lAnalitico
                loc_cIdQuery = SYS(2015)
                THIS.this_cIdQuery = loc_cIdQuery

                *-- Limpar registros anteriores desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))

                *-- Inserir cada cabecalho no SigTempR via SQL
                SELECT csRelatorio
                GO TOP
                SCAN
                    loc_cEmpDopNums = PADR(csRelatorio.Emps, 3) + ;
                                      PADR(csRelatorio.Dopes, 20) + ;
                                      STR(csRelatorio.Numes, 6)
                    loc_cUniqueId = SYS(2015)

                    loc_cSQL = "INSERT INTO SigTempR " + ;
                               "(Emps, Dopes, Numes, MascNum, CPros, Razas, Valors, Qtds, " + ;
                               "CodObs, Obss, EmpDopNums, CIdQuerys, CIdChaves, Contas) " + ;
                               "VALUES (" + ;
                               EscaparSQL(csRelatorio.Emps) + ", " + ;
                               EscaparSQL(csRelatorio.Dopes) + ", " + ;
                               TRANSFORM(csRelatorio.Numes) + ", " + ;
                               EscaparSQL(csRelatorio.MascNum) + ", " + ;
                               EscaparSQL(csRelatorio.Vends) + ", " + ;
                               EscaparSQL(csRelatorio.RClis) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.Valos) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.ValInis) + ", " + ;
                               EscaparSQL(csRelatorio.CodObs) + ", " + ;
                               EscaparSQL(csRelatorio.Obses) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(loc_cIdQuery) + ", " + ;
                               EscaparSQL(loc_cUniqueId) + ", " + ;
                               EscaparSQL(csRelatorio.Usuars) + ")"

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT csRelatorio
                ENDSCAN

                *-- Buscar produtos de SigTempR + SigMvItn
                loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.CPros As Vends, " + ;
                           "a.Razas As RClis, a.Qtds As ValInis, a.Valors As Valos, " + ;
                           "a.CodObs, a.Obss as Obses, 'ITN' as Tp, 0 as Soma, " + ;
                           "b.CPros, b.CodBarras as CBars, b.DPros, b.Opers, b.Qtds, " + ;
                           "b.Totas As Units, b.Totas, 99999999.99 as DifVal, " + ;
                           "a.Contas as Usuars " + ;
                           "From SigTempR a, SigMvItn b " + ;
                           "Where a.EmpDopNums = b.EmpDopNums And a.CIdQuerys = " + ;
                           EscaparSQL(loc_cIdQuery)

                IF USED("csProdutos")
                    USE IN csProdutos
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csProdutos")

                IF loc_nResult > 0
                    SELECT csProdutos
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                    INDEX ON Emps + Vends + STR(Numes, 6) TAG EmpVenNum

                    *-- Calcular DifVal (diferenca real paga) por nota
                    SET ORDER TO EmpDopNum
                    REPLACE ALL DifVal WITH 0

                    SCAN
                        loc_nDif = 0
                        IF USED("crSigMvMov")
                            USE IN crSigMvMov
                        ENDIF
                        loc_cSQL = "SELECT ValtOts, Nsinals, ValItens FROM SigMvMov " + ;
                                   "WHERE EmpDopNums = " + ;
                                   EscaparSQL(csProdutos.Emps + csProdutos.Dopes + ;
                                              STR(csProdutos.Numes, 6))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvMov") > 0
                            SELECT crSigMvMov
                            SCAN
                                loc_nDif = loc_nDif + crSigMvMov.Valtots - ;
                                           (crSigMvMov.Nsinals * crSigMvMov.Valitens)
                            ENDSCAN
                            USE IN crSigMvMov
                        ENDIF
                        REPLACE DifVal WITH loc_nDif IN csProdutos
                        SELECT csProdutos
                    ENDSCAN

                    *-- Calcular rateio de desconto/acrescimo por produto
                    SET ORDER TO EmpVenNum
                    GO TOP
                    DO WHILE !EOF()
                        loc_cEmpV  = csProdutos.Emps
                        loc_cVenV  = csProdutos.Vends
                        loc_nNumV  = csProdutos.Numes
                        loc_nTotI1 = 0
                        loc_nRec   = RECNO()
                        loc_nDif   = 0
                        loc_nItnV  = 0
                        loc_nGerV  = 0

                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nItnV  = loc_nItnV + csProdutos.Totas
                                loc_nTotI1 = loc_nTotI1 + 1
                            ENDIF
                            loc_nGerV = loc_nGerV + csProdutos.Totas
                            loc_nDif  = IIF(EMPTY(loc_nDif), csProdutos.DifVal, loc_nDif)
                        ENDSCAN

                        loc_nResto = loc_nDif
                        IF loc_nGerV < 0
                            loc_nResto = ABS(loc_nResto)
                        ENDIF

                        loc_nTotI2 = 0
                        GO loc_nRec
                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nTotI2 = loc_nTotI2 + 1
                                loc_nRateio = ROUND(loc_nDif * ;
                                    (csProdutos.Totas / IIF(loc_nItnV <> 0, loc_nItnV, 1)), 0)
                                IF loc_nTotI1 = loc_nTotI2
                                    loc_nVlVend = csProdutos.Totas + loc_nResto
                                ELSE
                                    loc_nVlVend = csProdutos.Totas + loc_nRateio
                                    loc_nResto  = loc_nResto - loc_nRateio
                                ENDIF
                                REPLACE Totas WITH loc_nVlVend IN csProdutos
                            ENDIF
                        ENDSCAN
                    ENDDO

                    *-- Inserir produtos processados no csRelatorio
                    SELECT csProdutos
                    SCAN
                        INSERT INTO csRelatorio ;
                            (Emps, Dopes, Numes, MascNum, Vends, Rclis, ;
                             ValInis, Valos, CodObs, Obses, Tp, Soma, ;
                             CPros, CBars, DPros, Opers, Qtds, Units, ;
                             Totas, DifVal, Usuars) ;
                            VALUES (csProdutos.Emps, csProdutos.Dopes, ;
                                    csProdutos.Numes, csProdutos.MascNum, ;
                                    csProdutos.Vends, csProdutos.RClis, ;
                                    0, 0, csProdutos.CodObs, csProdutos.Obses, ;
                                    csProdutos.Tp, csProdutos.Soma, ;
                                    csProdutos.CPros, csProdutos.CBars, ;
                                    csProdutos.DPros, csProdutos.Opers, ;
                                    csProdutos.Qtds, csProdutos.Units, ;
                                    csProdutos.Totas, csProdutos.DifVal, ;
                                    csProdutos.Usuars)
                    ENDSCAN
                ENDIF

                *-- Limpar SigTempR desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))
                THIS.this_cIdQuery = ""
            ENDIF

            *-- 17. Processar observacoes (marcar registros OB)
            IF loc_nObs = 1
                SELECT csRelatorio
                SET ORDER TO VdDpNmTp DESCENDING
                loc_cEmpO = ""
                loc_cVenO = ""
                loc_nNumO = 0
                SCAN
                    IF loc_cEmpO # csRelatorio.Emps OR ;
                       loc_cVenO # csRelatorio.Vends OR ;
                       loc_nNumO # csRelatorio.Numes
                        REPLACE Tp WITH "OB" + SUBS(csRelatorio.Tp, 1, 1) IN csRelatorio
                        loc_cEmpO = csRelatorio.Emps
                        loc_cVenO = csRelatorio.Vends
                        loc_nNumO = csRelatorio.Numes
                    ENDIF
                ENDSCAN
                SET ORDER TO VdDpNmTp ASCENDING
            ENDIF

            *-- 18. Modo Resumo: agregar por empresa
            IF loc_nTipoRel = 3
                IF USED("csTot1")
                    USE IN csTot1
                ENDIF
                IF USED("csTot2")
                    USE IN csTot2
                ENDIF

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRelat ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot1
                INDEX ON Emps TAG Emps

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRela2 ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot2
                INDEX ON Emps TAG Emps

                IF USED("csRelatorio")
                    USE IN csRelatorio
                ENDIF
                SELECT Emps, ;
                       SUM(ValInis) as ValInis, ;
                       SUM(Valos) as Valos, ;
                       SUM(IIF(ValInis > Valos, ValInis - Valos, 0)) as Desconto, ;
                       SUM(IIF(Valos > ValInis, Valos - ValInis, 0)) as Acrescimo, ;
                       SUM(Soma) as Soma, ;
                       0 as TotSoma ;
                       FROM csRelatorio ;
                       GROUP BY Emps ;
                       INTO CURSOR csRelatorio READWRITE

                SELECT csRelatorio
                SCAN
                    IF SEEK(csRelatorio.Emps, "csTot1", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot1.TotSoma IN csRelatorio
                    ENDIF
                    IF SEEK(csRelatorio.Emps, "csTot2", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot2.TotSoma IN csRelatorio
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 19. Posicionar no inicio
            SELECT csRelatorio
            SET ORDER TO VdDpNmTp
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirRelatorio - Executa REPORT FORM com dados preparados
    * par_lVisualizar: .T. = visualizar na tela, .F. = imprimir direto
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirRelatorio(par_lVisualizar)
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.this_cMensagemErro = "Erro ao preparar dados para o relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            IF !USED("csRelatorio") OR RECCOUNT("csRelatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", ;
                         "Relat" + CHR(243) + "rio")
                loc_lSucesso = .T.
            ENDIF

            IF THIS.this_nTipoRel = 3
                loc_cFrx = "SigReAd2"
            ELSE
                loc_cFrx = "SigReAd1"
            ENDIF

            IF par_lVisualizar
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao do relatorio
    * par_cAliasCursor: nome do cursor com colunas de filtro (formato preset)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset nao disponivel: " + ;
                                          ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- SCATTER MEMVAR para acessar colunas dinamicamente
            SCATTER MEMVAR

            IF TYPE("m.cEmpresa") = "C"
                THIS.this_cEmpresa = ALLTRIM(m.cEmpresa)
            ENDIF
            IF TYPE("m.cDEmpresa") = "C"
                THIS.this_cDEmpresa = ALLTRIM(m.cDEmpresa)
            ENDIF
            IF TYPE("m.cVendedor") = "C"
                THIS.this_cVendedor = ALLTRIM(m.cVendedor)
            ENDIF
            IF TYPE("m.cDVendedor") = "C"
                THIS.this_cDVendedor = ALLTRIM(m.cDVendedor)
            ENDIF
            IF TYPE("m.cNmOperacao") = "C"
                THIS.this_cNmOperacao = ALLTRIM(m.cNmOperacao)
            ENDIF
            IF TYPE("m.dDtInicial") = "D"
                THIS.this_dDtInicial = m.dDtInicial
            ENDIF
            IF TYPE("m.dDtFinal") = "D"
                THIS.this_dDtFinal = m.dDtFinal
            ENDIF
            IF TYPE("m.cMoeda") = "C"
                THIS.this_cMoeda = ALLTRIM(m.cMoeda)
            ENDIF
            IF TYPE("m.cDMoeda") = "C"
                THIS.this_cDMoeda = ALLTRIM(m.cDMoeda)
            ENDIF
            IF TYPE("m.nMargem") = "N"
                THIS.this_nMargem = m.nMargem
            ENDIF
            IF TYPE("m.nTipoVars") = "N"
                THIS.this_nTipoVars = m.nTipoVars
            ENDIF
            IF TYPE("m.nObs") = "N"
                THIS.this_nObs = m.nObs
            ENDIF
            IF TYPE("m.nTipoRel") = "N"
                THIS.this_nTipoRel = m.nTipoRel
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Delega para ImprimirRelatorio(.F.) e registra auditoria de impressao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.F.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Delega para ImprimirRelatorio(.T.) e registra auditoria de visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.T.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = "EMP=" + ALLTRIM(THIS.this_cEmpresa) + ;
                         ";PER=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal) + ;
                         ";VEND=" + ALLTRIM(THIS.this_cVendedor) + ;
                         ";OPE=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                         ";MOE=" + ALLTRIM(THIS.this_cMoeda) + ;
                         ";TR=" + ALLTRIM(STR(THIS.this_nTipoRel, 1))

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(dtOperacao, cUsuario, cTabela, cOperacao, cChave) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReAds") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e remove registros temporarios de SigTempR
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cIdQuery)
            SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigTempR WHERE CIdQuerys = " + ;
                EscaparSQL(THIS.this_cIdQuery))
            THIS.this_cIdQuery = ""
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("csProdutos")
            USE IN csProdutos
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("csSqlEest")
            USE IN csSqlEest
        ENDIF
        IF USED("csSqlEest2")
            USE IN csSqlEest2
        ENDIF
        IF USED("TmpCsRelat")
            USE IN TmpCsRelat
        ENDIF
        IF USED("TmpCsRela2")
            USE IN TmpCsRela2
        ENDIF
        IF USED("TmpObses")
            USE IN TmpObses
        ENDIF
        IF USED("csRelatorio1")
            USE IN csRelatorio1
        ENDIF
        IF USED("csTot1")
            USE IN csTot1
        ENDIF
        IF USED("csTot2")
            USE IN csTot2
        ENDIF
        IF USED(THIS.this_cCursorTipos)
            USE IN (THIS.this_cCursorTipos)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

