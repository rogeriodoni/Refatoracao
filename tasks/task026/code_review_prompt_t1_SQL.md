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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREADS.prg) - TRECHOS RELEVANTES PARA PASS SQL (1776 linhas total):

*-- Linhas 372 a 432:
372: 
373:         *-- Garantir cursor disponivel (pode estar ausente em modo de valida" + CHR(231) + CHR(227) + "o UI)
374:         IF !USED(loc_cCursor)
375:             CREATE CURSOR (loc_cCursor) (Marca N(1), Codigos N(2), Descri C(40))
376:         ENDIF
377: 
378:         *-- Grid de tipos de opera" + CHR(231) + CHR(227) + "o (GrdTipo original: width=279, height=110)
379:         loc_oPagina.AddObject("grd_4c_TipoOps", "Grid")
380:         loc_oGrid = loc_oPagina.grd_4c_TipoOps
381: 
382:         *-- ColumnCount ANTES do WITH para criar colunas antes de configurar
383:         loc_oGrid.ColumnCount = 2
384: 
385:         WITH loc_oGrid
386:             .Top                = 110
387:             .Left               = 277
388:             .Width              = 279
389:             .Height             = 110
390:             .RecordMark         = .F.
391:             .DeleteMark         = .F.
392:             .GridLineColor      = RGB(238, 238, 238)
393:             .HighlightStyle     = 2
394:             .HighlightBackColor = RGB(255, 255, 255)
395:             .HighlightForeColor = RGB(15, 41, 104)
396:             .ScrollBars         = 2
397:             .RowHeight          = 16
398:             .FontName           = "Verdana"
399:             .FontSize           = 8
400:         ENDWITH
401: 
402:         *-- Column1: CheckBox para Marca (sele" + CHR(231) + CHR(227) + "o do tipo)
403:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS de CurrentControl
404:         WITH loc_oGrid.Column1
405:             .Width = 25
406:             .AddObject("Check1", "CheckBox")
407:             .Check1.Caption = ""
408:             .Check1.Value   = 0
409:             .CurrentControl = "Check1"
410:             .ControlSource  = loc_cCursor + ".Marca"
411:             .Header1.Caption = ""
412:         ENDWITH
413: 
414:         *-- Column2: Descri" + CHR(231) + CHR(227) + "o do tipo de opera" + CHR(231) + CHR(227) + "o (read-only)
415:         WITH loc_oGrid.Column2
416:             .Width         = 250
417:             .ControlSource = loc_cCursor + ".Descri"
418:             .ReadOnly      = .T.
419:             .FontName      = "Verdana"
420:             .FontSize      = 8
421:             .ForeColor     = RGB(90, 90, 90)
422:         ENDWITH
423: 
424:         *-- RecordSource APOS configurar colunas (evita reset antecipado de headers)
425:         loc_oGrid.RecordSource = loc_cCursor
426: 
427:         *-- Reconfigurar headers APOS RecordSource (RecordSource reseta headers)
428:         loc_oGrid.Column1.Header1.Caption = ""
429:         loc_oGrid.Column2.Header1.Caption = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
430:         loc_oGrid.Column2.Header1.FontName = "Tahoma"
431:         loc_oGrid.Column2.Header1.FontSize = 8
432: 

*-- Linhas 482 a 519:
482:         TRY
483:             loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
484:             IF USED(loc_cCursor)
485:                 SELECT (loc_cCursor)
486:                 REPLACE ALL Marca WITH 1
487:                 GO TOP
488:                 THIS.pgf_4c_Paginas.Page1.grd_4c_TipoOps.Refresh()
489:             ENDIF
490:         CATCH TO loc_oErro
491:             MsgErro(loc_oErro.Message, "Erro")
492:         ENDTRY
493:     ENDPROC
494: 
495:     *--------------------------------------------------------------------------
496:     * BtnApagaClick - Desmarca todos os tipos de opera" + CHR(231) + CHR(227) + "o no grid
497:     *   Equivale ao apaga.Click do original: replace all marca with 0
498:     *--------------------------------------------------------------------------
499:     PROCEDURE BtnApagaClick()
500:         LOCAL loc_cCursor
501:         TRY
502:             loc_cCursor = THIS.this_oRelatorio.this_cCursorTipos
503:             IF USED(loc_cCursor)
504:                 SELECT (loc_cCursor)
505:                 REPLACE ALL Marca WITH 0
506:                 GO TOP
507:                 THIS.pgf_4c_Paginas.Page1.grd_4c_TipoOps.Refresh()
508:             ENDIF
509:         CATCH TO loc_oErro
510:             MsgErro(loc_oErro.Message, "Erro")
511:         ENDTRY
512:     ENDPROC
513: 
514:     *--------------------------------------------------------------------------
515:     * AlternarPagina - Navega para a pagina solicitada no PageFrame
516:     *   Form REPORT possui apenas 1 pagina; navega se o indice for valido
517:     *--------------------------------------------------------------------------
518:     PROCEDURE AlternarPagina(par_nPagina)
519:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;

*-- Linhas 1143 a 1165:
1143:                 loc_oPagina.txt_4c_Dempresa.Value = ""
1144:                 RETURN
1145:             ENDIF
1146:             loc_cSQL = "SELECT TOP 1 cEmps, Razas FROM SigCdEmp WHERE cEmps = " + ;
1147:                        EscaparSQL(loc_cCodigo)
1148:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrEmpVal")
1149:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpVal")
1150:                 SELECT cursor_4c_SigrEmpVal
1151:                 loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_SigrEmpVal.cEmps)
1152:                 loc_oPagina.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_SigrEmpVal.Razas)
1153:             ELSE
1154:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
1155:                 loc_oPagina.txt_4c_Empresa.Value  = ""
1156:                 loc_oPagina.txt_4c_Dempresa.Value = ""
1157:                 THIS.AbrirBuscaEmpresa()
1158:             ENDIF
1159:             IF USED("cursor_4c_SigrEmpVal")
1160:                 USE IN cursor_4c_SigrEmpVal
1161:             ENDIF
1162:         CATCH TO loc_oErro
1163:             MsgErro(loc_oErro.Message, "Erro")
1164:         ENDTRY
1165:     ENDPROC

*-- Linhas 1190 a 1208:
1190:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1191:                 loc_oBusca.Show()
1192:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1193:                     SELECT (loc_cCursor)
1194:                     loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cEmps)
1195:                     loc_oPagina.txt_4c_Dempresa.Value = ALLTRIM(Razas)
1196:                 ENDIF
1197:                 loc_oBusca.Release()
1198:             ENDIF
1199:         CATCH TO loc_oErro
1200:             MsgErro(loc_oErro.Message, "Erro")
1201:         ENDTRY
1202:         IF USED("cursor_4c_SigrJanEmp")
1203:             USE IN cursor_4c_SigrJanEmp
1204:         ENDIF
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     *  VALIDACAO + LOOKUP - Vendedor

*-- Linhas 1220 a 1242:
1220:                 loc_oPagina.txt_4c_Dvend.Value = ""
1221:                 RETURN
1222:             ENDIF
1223:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + ;
1224:                        EscaparSQL(loc_cCodigo)
1225:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrVendVal")
1226:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrVendVal")
1227:                 SELECT cursor_4c_SigrVendVal
1228:                 loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendVal.Iclis)
1229:                 loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendVal.Rclis)
1230:             ELSE
1231:                 MsgAviso("Vendedor n" + CHR(227) + "o encontrado.", "Vendedor")
1232:                 loc_oPagina.txt_4c_Vended.Value = ""
1233:                 loc_oPagina.txt_4c_Dvend.Value  = ""
1234:                 THIS.AbrirBuscaVended()
1235:             ENDIF
1236:             IF USED("cursor_4c_SigrVendVal")
1237:                 USE IN cursor_4c_SigrVendVal
1238:             ENDIF
1239:         CATCH TO loc_oErro
1240:             MsgErro(loc_oErro.Message, "Erro")
1241:         ENDTRY
1242:     ENDPROC

*-- Linhas 1254 a 1290:
1254:             IF VARTYPE(THIS.this_oRelatorio) = "O"
1255:                 loc_cGrupo = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
1256:             ENDIF
1257:             loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "CdGrps = " + EscaparSQL(loc_cGrupo), "")
1258: 
1259:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1260:                 "SigCdCli", "cursor_4c_SigrVendBusca", "Iclis", loc_cValor, ;
1261:                 "Selecionar Vendedor", loc_cFiltro)
1262:             IF VARTYPE(loc_oBusca) = "O"
1263:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1264:                     IF USED("cursor_4c_SigrVendBusca")
1265:                         SELECT cursor_4c_SigrVendBusca
1266:                         loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendBusca.Iclis)
1267:                         loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendBusca.Rclis)
1268:                     ENDIF
1269:                 ELSE
1270:                     IF !loc_oBusca.this_lAchouRegistro
1271:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1272:                     loc_oBusca.mAddColuna("Rclis", "", "Nome")
1273:                     loc_oBusca.Show()
1274:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrVendBusca")
1275:                         SELECT cursor_4c_SigrVendBusca
1276:                         loc_oPagina.txt_4c_Vended.Value = ALLTRIM(cursor_4c_SigrVendBusca.Iclis)
1277:                         loc_oPagina.txt_4c_Dvend.Value  = ALLTRIM(cursor_4c_SigrVendBusca.Rclis)
1278:                     ENDIF
1279:                     ENDIF
1280:                 ENDIF
1281:                 loc_oBusca.Release()
1282:             ENDIF
1283:         CATCH TO loc_oErro
1284:             MsgErro(loc_oErro.Message, "Erro")
1285:         ENDTRY
1286:         IF USED("cursor_4c_SigrVendBusca")
1287:             USE IN cursor_4c_SigrVendBusca
1288:         ENDIF
1289:     ENDPROC
1290: 

*-- Linhas 1303 a 1325:
1303:             IF EMPTY(loc_cCodigo)
1304:                 RETURN
1305:             ENDIF
1306:             loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + ;
1307:                        EscaparSQL(loc_cCodigo)
1308:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrOpeVal")
1309:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrOpeVal")
1310:                 SELECT cursor_4c_SigrOpeVal
1311:                 loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeVal.Dopes)
1312:             ELSE
1313:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", ;
1314:                          "Opera" + CHR(231) + CHR(227) + "o")
1315:                 loc_oPagina.txt_4c_Operacao.Value = ""
1316:                 THIS.AbrirBuscaOperacao()
1317:             ENDIF
1318:             IF USED("cursor_4c_SigrOpeVal")
1319:                 USE IN cursor_4c_SigrOpeVal
1320:             ENDIF
1321:         CATCH TO loc_oErro
1322:             MsgErro(loc_oErro.Message, "Erro")
1323:         ENDTRY
1324:     ENDPROC
1325: 

*-- Linhas 1338 a 1364:
1338:             IF VARTYPE(loc_oBusca) = "O"
1339:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1340:                     IF USED("cursor_4c_SigrOpeBusca")
1341:                         SELECT cursor_4c_SigrOpeBusca
1342:                         loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeBusca.Dopes)
1343:                     ENDIF
1344:                 ELSE
1345:                     IF !loc_oBusca.this_lAchouRegistro
1346:                     loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1347:                     loc_oBusca.Show()
1348:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrOpeBusca")
1349:                         SELECT cursor_4c_SigrOpeBusca
1350:                         loc_oPagina.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_SigrOpeBusca.Dopes)
1351:                     ENDIF
1352:                     ENDIF
1353:                 ENDIF
1354:                 loc_oBusca.Release()
1355:             ENDIF
1356:         CATCH TO loc_oErro
1357:             MsgErro(loc_oErro.Message, "Erro")
1358:         ENDTRY
1359:         IF USED("cursor_4c_SigrOpeBusca")
1360:             USE IN cursor_4c_SigrOpeBusca
1361:         ENDIF
1362:     ENDPROC
1363: 
1364:     *==========================================================================

*-- Linhas 1377 a 1399:
1377:                 loc_oPagina.txt_4c_Dmoeda.Value = ""
1378:                 RETURN
1379:             ENDIF
1380:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1381:                        EscaparSQL(loc_cCodigo)
1382:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrMoeVal")
1383:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrMoeVal")
1384:                 SELECT cursor_4c_SigrMoeVal
1385:                 loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeVal.CMoes)
1386:                 loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeVal.DMoes)
1387:             ELSE
1388:                 MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Moeda")
1389:                 loc_oPagina.txt_4c_Cmoeda.Value = ""
1390:                 loc_oPagina.txt_4c_Dmoeda.Value = ""
1391:                 THIS.AbrirBuscaMoeda()
1392:             ENDIF
1393:             IF USED("cursor_4c_SigrMoeVal")
1394:                 USE IN cursor_4c_SigrMoeVal
1395:             ENDIF
1396:         CATCH TO loc_oErro
1397:             MsgErro(loc_oErro.Message, "Erro")
1398:         ENDTRY
1399:     ENDPROC

*-- Linhas 1414 a 1442:
1414:             IF VARTYPE(loc_oBusca) = "O"
1415:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1416:                     IF USED("cursor_4c_SigrMoeBusca")
1417:                         SELECT cursor_4c_SigrMoeBusca
1418:                         loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.CMoes)
1419:                         loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.DMoes)
1420:                     ENDIF
1421:                 ELSE
1422:                     IF !loc_oBusca.this_lAchouRegistro
1423:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1424:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1425:                     loc_oBusca.Show()
1426:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigrMoeBusca")
1427:                         SELECT cursor_4c_SigrMoeBusca
1428:                         loc_oPagina.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.CMoes)
1429:                         loc_oPagina.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_SigrMoeBusca.DMoes)
1430:                     ENDIF
1431:                     ENDIF
1432:                 ENDIF
1433:                 loc_oBusca.Release()
1434:             ENDIF
1435:         CATCH TO loc_oErro
1436:             MsgErro(loc_oErro.Message, "Erro")
1437:         ENDTRY
1438:         IF USED("cursor_4c_SigrMoeBusca")
1439:             USE IN cursor_4c_SigrMoeBusca
1440:         ENDIF
1441:     ENDPROC
1442: 


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

