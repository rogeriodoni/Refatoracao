# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LNORDEM' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, LNFATOR, DBUN, ICLIS, LINHAS, COLECOES, CGRUS, SQTDS, DATAS, CPROS, LNPESO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, LNFATOR, DBUN, ICLIS, LINHAS, COLECOES, CGRUS, SQTDS, DATAS, CPROS, LNPESO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, LNFATOR, DBUN, ICLIS, LINHAS, COLECOES, CGRUS, SQTDS, DATAS, CPROS, LNPESO

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cemps,razas From SigCdEmp Where cemps = ']+lcEmpresa+[' ],'CrSigCdEmp')
Select CrSigCdEmp
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdMoe ],'CrSigCdMoe')
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot')
Select CrSigCdMoe
Select CrSigCdCot
Insert Into dbCabecalho (NomeEmpresa,Titulo,SubTitulo,Cabecalho,SubTitulo2) ;
	lnQueryOk = Thisform.poDataMgr.SqlExecute([Select rclis From SigCdCli Where iclis = ']+lcEstoque+[' ],'TmpEsto')
	Select TmpEsto
	lcsql = [Select a.grupos,a.estos,a.cpros,b.cgrus,a.sqtds As valos,b.pvens,b.moevs,]+;
		[From SigMvEst a ]+;
		[Left Join SigCdPro b On b.cpros=a.cpros ]+;
		[Left Join SigCdLin l On l.linhas=b.linhas ]+;
		[Left Join SigCdCol c On c.colecoes=b.colecoes ]+;
		[Left Join SigCdGrp g On g.cgrus=b.cgrus ]+;
	lnQueryOk = Thisform.poDataMgr.SqlExecute(lcsql,'Tempo')
	Select Tempo
	lnQueryOk = Thisform.poDataMgr.SqlExecute([Select a.grupos,a.estos,a.cpros,b.cgrus,a.qtds,b.pvens,b.moevs,]+;
		[From SigMvHst a, SigCdPro b ]+;
	Select grupos,estos,cpros,cgrus,pvens,moevs,fvendas,moepvs,;
		From TmpHisPro ;
	Select Tempo
Select Tempo
	Select Tempo
		loBarra.Update(.T.,'Produto: ' + Tempo.cpros)
			lnQueryOk = Thisform.poDataMgr.SqlExecute([Select a.cpros,g.dgrus,l.descs As desclin,l.tpcustos,l.tpvendas,]+;
				[From SigCdPro a ]+;
				[Left Join SigCdLin l On l.linhas = a.linhas ]+;
				[Left Join SigCdCol c On c.colecoes = a.colecoes ]+;
				[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
		Select Tempo
		Select TempMoe
		=Seek(Nvl(Tempo.moevs,''),'TempMoe','cmoes')
		Select TempMoe
		=Seek(lcMoeda,'TempMoe','cmoes')
		Select TempMoe
		=Seek(Nvl(Tempo.moecusfs,''),'TempMoe','cmoes')
		Select TempMoe
		=Seek(Nvl(Tempo.moepvs,''),'TempMoe','cmoes')
		Select TempMoe
		Select dbRelat
		=Seek(&lcChave.,'dbRelat','cgrus')
		Select dbRelat
					lnQueryOk = Thisform.poDataMgr.SqlExecute([Select rclis From SigCdCli Where iclis = ']+lcEstos+[' ],'TmpEsto')
				Select TmpEsto
		Select dbUnis
		Select Tempo
	Select dbRelat
		loBarraFim.Update(.T.)
		Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
	Insert Into dbRelatorio (Detalhe) Values (cTotal)
	Insert Into dbRelatorio (Detalhe) Values (cTotal)
		Select dbUnis
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
				Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
		Select TempMoe
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
			Insert Into dbRelatorio (Detalhe) Values ('')
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
			Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
				Insert Into dbRelatorio (Detalhe) Values (cDetalhe)
Select dbRelatorio

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreegp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1932 linhas total):

*-- Linhas 296 a 318:
296:             IF USED("cursor_4c_SigCdEmp")
297:                 USE IN cursor_4c_SigCdEmp
298:             ENDIF
299:             loc_nResult = SQLEXEC(gnConnHandle, ;
300:                 "SELECT cemps, razas, ativas FROM SigCdEmp ORDER BY cemps", ;
301:                 "cursor_4c_SigCdEmp")
302:             IF loc_nResult > 0
303:                 SELECT cursor_4c_SigCdEmp
304:                 INDEX ON cemps TAG cemps ADDITIVE
305:                 GO TOP
306:             ELSE
307:                 MsgAviso("Falha ao carregar empresas." + CHR(13) + ;
308:                     "Valida" + CHR(231) + CHR(227) + "o de empresa usar" + ;
309:                     CHR(225) + " consulta direta.", "Aviso")
310:             ENDIF
311:         CATCH TO loc_oErro
312:             MsgErro(loc_oErro.Message, "Erro")
313:         ENDTRY
314:     ENDPROC
315: 
316:     *--------------------------------------------------------------------------
317:     * ConfigurarPaginaDados - Campos de filtro em Page1
318:     *   Tops ajustados: Top_page = Top_original - 85

*-- Linhas 1303 a 1321:
1303:                 loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
1304:                 loc_oBusca.Show()
1305:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1306:                     SELECT (loc_cCursor)
1307:                     loc_oPagina.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
1308:                     loc_oPagina.txt_4c__ds_empresa.Value = ALLTRIM(razas)
1309:                 ENDIF
1310:                 loc_oBusca.Release()
1311:             ENDIF
1312:         CATCH TO loc_oErro
1313:             MsgErro(loc_oErro.Message, "Erro")
1314:         ENDTRY
1315:         IF USED(loc_cCursor)
1316:             USE IN (loc_cCursor)
1317:         ENDIF
1318:     ENDPROC
1319: 
1320:     *==========================================================================
1321:     * VALIDACAO + LOOKUP - Grupo de Estoque (SigCdGcr)

*-- Linhas 1332 a 1354:
1332:                 loc_oPagina.txt_4c__ds_estoque.Value   = ""
1333:                 RETURN
1334:             ENDIF
1335:             loc_cSQL    = "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
1336:                           EscaparSQL(loc_cCodigo)
1337:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreegpGcrVal")
1338:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreegpGcrVal")
1339:                 SELECT cursor_4c_SigreegpGcrVal
1340:                 loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_SigreegpGcrVal.codigos)
1341:                 loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_SigreegpGcrVal.descs)
1342:             ELSE
1343:                 MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
1344:                     "Grupo de Estoque")
1345:                 loc_oPagina.txt_4c__Cd_GrEstoque.Value = ""
1346:                 loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
1347:                 THIS.AbrirBuscaGrEstoque()
1348:             ENDIF
1349:             IF USED("cursor_4c_SigreegpGcrVal")
1350:                 USE IN cursor_4c_SigreegpGcrVal
1351:             ENDIF
1352:         CATCH TO loc_oErro
1353:             MsgErro(loc_oErro.Message, "Erro")
1354:         ENDTRY

*-- Linhas 1369 a 1387:
1369:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1370:                 loc_oBusca.Show()
1371:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1372:                     SELECT (loc_cCursor)
1373:                     loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
1374:                     loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descs)
1375:                     loc_oPagina.txt_4c__cd_estoque.Value   = ""
1376:                     loc_oPagina.txt_4c__ds_estoque.Value   = ""
1377:                 ENDIF
1378:                 loc_oBusca.Release()
1379:             ENDIF
1380:         CATCH TO loc_oErro
1381:             MsgErro(loc_oErro.Message, "Erro")
1382:         ENDTRY
1383:         IF USED(loc_cCursor)
1384:             USE IN (loc_cCursor)
1385:         ENDIF
1386:     ENDPROC
1387: 

*-- Linhas 1401 a 1425:
1401:             loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
1402:             loc_cFiltro = ""
1403:             IF !EMPTY(loc_cGrupo)
1404:                 loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
1405:             ENDIF
1406:             loc_cSQL    = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
1407:                           EscaparSQL(loc_cCodigo) + loc_cFiltro
1408:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreegpCliVal")
1409:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreegpCliVal")
1410:                 SELECT cursor_4c_SigreegpCliVal
1411:                 loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_SigreegpCliVal.iclis)
1412:                 loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_SigreegpCliVal.rclis)
1413:             ELSE
1414:                 MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
1415:                     "Conta de Estoque")
1416:                 loc_oPagina.txt_4c__cd_estoque.Value = ""
1417:                 loc_oPagina.txt_4c__ds_estoque.Value = ""
1418:                 THIS.AbrirBuscaEstoque()
1419:             ENDIF
1420:             IF USED("cursor_4c_SigreegpCliVal")
1421:                 USE IN cursor_4c_SigreegpCliVal
1422:             ENDIF
1423:         CATCH TO loc_oErro
1424:             MsgErro(loc_oErro.Message, "Erro")
1425:         ENDTRY

*-- Linhas 1434 a 1463:
1434:             loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
1435:             loc_cFiltro = ""
1436:             IF !EMPTY(loc_cGrupo)
1437:                 loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
1438:             ENDIF
1439: 
1440:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1441:                 "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
1442:                 "Selecionar Conta de Estoque", loc_cFiltro)
1443:             IF VARTYPE(loc_oBusca) = "O"
1444:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1445:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1446:                 loc_oBusca.Show()
1447:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1448:                     SELECT (loc_cCursor)
1449:                     loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(iclis)
1450:                     loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(rclis)
1451:                 ENDIF
1452:                 loc_oBusca.Release()
1453:             ENDIF
1454:         CATCH TO loc_oErro
1455:             MsgErro(loc_oErro.Message, "Erro")
1456:         ENDTRY
1457:         IF USED(loc_cCursor)
1458:             USE IN (loc_cCursor)
1459:         ENDIF
1460:     ENDPROC
1461: 
1462:     *==========================================================================
1463:     * VALIDACAO + LOOKUP - Grupo de Produto (SigCdGrp)

*-- Linhas 1472 a 1494:
1472:                 loc_oPagina.txt_4c__ds_grupo.Value = ""
1473:                 RETURN
1474:             ENDIF
1475:             loc_cSQL    = "SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + ;
1476:                           EscaparSQL(loc_cCodigo)
1477:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreegpGrpVal")
1478:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreegpGrpVal")
1479:                 SELECT cursor_4c_SigreegpGrpVal
1480:                 loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cursor_4c_SigreegpGrpVal.cgrus)
1481:                 loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_SigreegpGrpVal.dgrus)
1482:             ELSE
1483:                 MsgAviso("Grupo de Produto n" + CHR(227) + "o encontrado.", ;
1484:                     "Grupo de Produto")
1485:                 loc_oPagina.txt_4c__cd_grupo.Value = ""
1486:                 loc_oPagina.txt_4c__ds_grupo.Value = ""
1487:                 THIS.AbrirBuscaGrupo()
1488:             ENDIF
1489:             IF USED("cursor_4c_SigreegpGrpVal")
1490:                 USE IN cursor_4c_SigreegpGrpVal
1491:             ENDIF
1492:         CATCH TO loc_oErro
1493:             MsgErro(loc_oErro.Message, "Erro")
1494:         ENDTRY

*-- Linhas 1509 a 1527:
1509:                 loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1510:                 loc_oBusca.Show()
1511:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1512:                     SELECT (loc_cCursor)
1513:                     loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cgrus)
1514:                     loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(dgrus)
1515:                 ENDIF
1516:                 loc_oBusca.Release()
1517:             ENDIF
1518:         CATCH TO loc_oErro
1519:             MsgErro(loc_oErro.Message, "Erro")
1520:         ENDTRY
1521:         IF USED(loc_cCursor)
1522:             USE IN (loc_cCursor)
1523:         ENDIF
1524:     ENDPROC
1525: 
1526:     *==========================================================================
1527:     * VALIDACAO + LOOKUP - Linha (SigCdLin)

*-- Linhas 1536 a 1558:
1536:                 loc_oPagina.txt_4c_DLin.Value = ""
1537:                 RETURN
1538:             ENDIF
1539:             loc_cSQL    = "SELECT TOP 1 linhas, descs FROM SigCdLin WHERE linhas = " + ;
1540:                           EscaparSQL(loc_cCodigo)
1541:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreegpLinVal")
1542:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreegpLinVal")
1543:                 SELECT cursor_4c_SigreegpLinVal
1544:                 loc_oPagina.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_SigreegpLinVal.linhas)
1545:                 loc_oPagina.txt_4c_DLin.Value = ALLTRIM(cursor_4c_SigreegpLinVal.descs)
1546:             ELSE
1547:                 MsgAviso("Linha n" + CHR(227) + "o encontrada.", "Linha")
1548:                 loc_oPagina.txt_4c_Lin.Value  = ""
1549:                 loc_oPagina.txt_4c_DLin.Value = ""
1550:                 THIS.AbrirBuscaLinha()
1551:             ENDIF
1552:             IF USED("cursor_4c_SigreegpLinVal")
1553:                 USE IN cursor_4c_SigreegpLinVal
1554:             ENDIF
1555:         CATCH TO loc_oErro
1556:             MsgErro(loc_oErro.Message, "Erro")
1557:         ENDTRY
1558:     ENDPROC

*-- Linhas 1572 a 1590:
1572:                 loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1573:                 loc_oBusca.Show()
1574:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1575:                     SELECT (loc_cCursor)
1576:                     loc_oPagina.txt_4c_Lin.Value  = ALLTRIM(linhas)
1577:                     loc_oPagina.txt_4c_DLin.Value = ALLTRIM(descs)
1578:                 ENDIF
1579:                 loc_oBusca.Release()
1580:             ENDIF
1581:         CATCH TO loc_oErro
1582:             MsgErro(loc_oErro.Message, "Erro")
1583:         ENDTRY
1584:         IF USED(loc_cCursor)
1585:             USE IN (loc_cCursor)
1586:         ENDIF
1587:     ENDPROC
1588: 
1589:     *==========================================================================
1590:     * VALIDACAO + LOOKUP - Grupo de Venda/Colecao (SigCdCol)

*-- Linhas 1599 a 1621:
1599:                 loc_oPagina.txt_4c_DCol.Value = ""
1600:                 RETURN
1601:             ENDIF
1602:             loc_cSQL    = "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
1603:                           EscaparSQL(loc_cCodigo)
1604:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreegpColVal")
1605:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreegpColVal")
1606:                 SELECT cursor_4c_SigreegpColVal
1607:                 loc_oPagina.txt_4c_Col.Value  = ALLTRIM(cursor_4c_SigreegpColVal.colecoes)
1608:                 loc_oPagina.txt_4c_DCol.Value = ALLTRIM(cursor_4c_SigreegpColVal.descs)
1609:             ELSE
1610:                 MsgAviso("Grupo de Venda n" + CHR(227) + "o encontrado.", ;
1611:                     "Grupo de Venda")
1612:                 loc_oPagina.txt_4c_Col.Value  = ""
1613:                 loc_oPagina.txt_4c_DCol.Value = ""
1614:                 THIS.AbrirBuscaGrupoVenda()
1615:             ENDIF
1616:             IF USED("cursor_4c_SigreegpColVal")
1617:                 USE IN cursor_4c_SigreegpColVal
1618:             ENDIF
1619:         CATCH TO loc_oErro
1620:             MsgErro(loc_oErro.Message, "Erro")
1621:         ENDTRY

*-- Linhas 1636 a 1654:
1636:                 loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
1637:                 loc_oBusca.Show()
1638:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1639:                     SELECT (loc_cCursor)
1640:                     loc_oPagina.txt_4c_Col.Value  = ALLTRIM(colecoes)
1641:                     loc_oPagina.txt_4c_DCol.Value = ALLTRIM(descs)
1642:                 ENDIF
1643:                 loc_oBusca.Release()
1644:             ENDIF
1645:         CATCH TO loc_oErro
1646:             MsgErro(loc_oErro.Message, "Erro")
1647:         ENDTRY
1648:         IF USED(loc_cCursor)
1649:             USE IN (loc_cCursor)
1650:         ENDIF
1651:     ENDPROC
1652: 
1653:     *==========================================================================
1654:     * VALIDACAO + LOOKUP - Moeda (SigCdMoe)

*-- Linhas 1663 a 1685:
1663:                 loc_oPagina.txt_4c__moeda_desc.Value = ""
1664:                 RETURN
1665:             ENDIF
1666:             loc_cSQL    = "SELECT TOP 1 cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + ;
1667:                           EscaparSQL(loc_cCodigo)
1668:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreegpMoeVal")
1669:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreegpMoeVal")
1670:                 SELECT cursor_4c_SigreegpMoeVal
1671:                 loc_oPagina.txt_4c__moeda.Value      = ALLTRIM(cursor_4c_SigreegpMoeVal.cmoes)
1672:                 loc_oPagina.txt_4c__moeda_desc.Value = ALLTRIM(cursor_4c_SigreegpMoeVal.dmoes)
1673:             ELSE
1674:                 MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Moeda")
1675:                 loc_oPagina.txt_4c__moeda.Value      = ""
1676:                 loc_oPagina.txt_4c__moeda_desc.Value = ""
1677:                 THIS.AbrirBuscaMoeda()
1678:             ENDIF
1679:             THIS.AtualizarEstadoDtCotacao()
1680:             IF USED("cursor_4c_SigreegpMoeVal")
1681:                 USE IN cursor_4c_SigreegpMoeVal
1682:             ENDIF
1683:         CATCH TO loc_oErro
1684:             MsgErro(loc_oErro.Message, "Erro")
1685:         ENDTRY

*-- Linhas 1700 a 1718:
1700:                 loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1701:                 loc_oBusca.Show()
1702:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1703:                     SELECT (loc_cCursor)
1704:                     loc_oPagina.txt_4c__moeda.Value      = ALLTRIM(cmoes)
1705:                     loc_oPagina.txt_4c__moeda_desc.Value = ALLTRIM(dmoes)
1706:                     THIS.AtualizarEstadoDtCotacao()
1707:                 ENDIF
1708:                 loc_oBusca.Release()
1709:             ENDIF
1710:         CATCH TO loc_oErro
1711:             MsgErro(loc_oErro.Message, "Erro")
1712:         ENDTRY
1713:         IF USED(loc_cCursor)
1714:             USE IN (loc_cCursor)
1715:         ENDIF
1716:     ENDPROC
1717: 
1718:     *==========================================================================

*-- Linhas 1824 a 1842:
1824:                 THIS.this_oRelatorio.LimparCursores()
1825:                 RETURN
1826:             ENDIF
1827:             SELECT dbRelatorio
1828:             loc_cArquivo = PUTFILE("Salvar como...", "PosicaoEstoqueGrupoProduto", "xls")
1829:             IF EMPTY(loc_cArquivo)
1830:                 THIS.this_oRelatorio.LimparCursores()
1831:                 RETURN
1832:             ENDIF
1833:             COPY TO (loc_cArquivo) TYPE XL5
1834:             MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
1835:             THIS.this_oRelatorio.LimparCursores()
1836:         CATCH TO loc_oErro
1837:             MsgErro(loc_oErro.Message, "Erro")
1838:         ENDTRY
1839:     ENDPROC
1840: 
1841:     PROCEDURE BtnEncerrarClick()
1842:         THIS.Release()


### BO (C:\4c\projeto\app\classes\sigreegpBO.prg):
*==============================================================================
* SIGREEGPBO.PRG
* Business Object - Relatorio de Posicao de Estoque por Grupo de Produto
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigreegpBO AS RelatorioBase

    *-- Empresa
    this_cCdEmpresa       = ""
    this_cDsEmpresa       = ""

    *-- Grupo de Estoque
    this_cCdGrEstoque     = ""
    this_cDsGrEstoque     = ""

    *-- Estoque (Conta/Cliente)
    this_cCdEstoque       = ""
    this_cDsEstoque       = ""

    *-- Grupo de Produto
    this_cCdGrupo         = ""
    this_cDsGrupo         = ""

    *-- Data de posicao
    this_dData            = {}

    *-- Moeda
    this_cCdMoeda         = ""
    this_cDsMoeda         = ""
    this_dDtCotacao       = {}
    this_nOptDadosCotacao = 1

    *-- Linha de produto
    this_cCdLinha         = ""
    this_cDsLinha         = ""

    *-- Colecao / Grupo de Venda
    this_cCdColecao       = ""
    this_cDsColecao       = ""

    *-- Opcoes de exibicao (1=Sim, 2=Nao)
    this_nCmbOrdem        = 4
    this_nOpcVenda        = 1
    this_nOpcCusto        = 1
    this_nOpcPeso         = 2
    this_nOpcFator        = 2
    this_nOptUnis         = 2

    *-- Propriedades internas do relatorio
    this_cNomeRelatorio   = "SigReEg2"
    this_cCursorDados     = "cursor_4c_EgpRelatorio"
    this_cCursorCabecalho = "cursor_4c_EgpCabecalho"
    this_cTipo            = "ESTOQUE"

    *--------------------------------------------------------------------------
    * Init - Inicializa propriedades com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_dData            = DATE()
            THIS.this_dDtCotacao       = DATE()
            THIS.this_cCdEmpresa       = go_4c_Sistema.cCodEmpresa
            THIS.this_nCmbOrdem        = 4
            THIS.this_nOptDadosCotacao = 1
            THIS.this_nOpcVenda        = 1
            THIS.this_nOpcCusto        = 1
            THIS.this_nOpcPeso         = 2
            THIS.this_nOpcFator        = 2
            THIS.this_nOptUnis         = 2
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.LimparCursores()
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + THIS.this_cNomeRelatorio + ".frx"
                IF FILE(loc_cFrx)
                    REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                        "o encontrado: " + loc_cFrx, "Erro")
                ENDIF
                THIS.LimparCursores()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.LimparCursores()
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.LimparCursores()
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + THIS.this_cNomeRelatorio + ".frx"
                IF FILE(loc_cFrx)
                    REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                        "o encontrado: " + loc_cFrx, "Erro")
                ENDIF
                THIS.LimparCursores()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.LimparCursores()
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Hook que chama processamento real
    *--------------------------------------------------------------------------
    FUNCTION PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.ExecutarProcessamento()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarProcessamento - Logica principal do relatorio
    * Replica fielmente o procedure "processamento" do sistema legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarProcessamento()
        LOCAL lcEmpresa, lcNomeEmpresa, lcTitulo, lcSubTitulo, lcOrdenaCab
        LOCAL lcGrest, lcEstoque, lcGrupo, lcMoeda, lcDescMoeda
        LOCAL ldData, ldDtCotacao, lnDadosCotacao
        LOCAL lcCabecalho, lcOrdem, lcChave
        LOCAL lnValCust, lnValVend, lnPeso, lnFator, lnOrdem
        LOCAL lnValCot, lnValorProd, lnCustoProd, lnValFat
        LOCAL nTotQtds, nTotPeso, nTotCusto, nTotVenda
        LOCAL cDetalhe, cTotal, cAnt, cAnte, lnEspaco
        LOCAL lcLinha, lcGrupoVenda
        LOCAL lcEmpIni, lcEmpFim, lcGrEstIni, lcGrEstFim, lcEstIni, lcEstFim
        LOCAL loc_cSQL, loc_nResult, llPosAtu, llUnis
        LOCAL lcFatVens, lcCodCors, lcEstos, lcRclis, lcCodPro
        LOCAL lcWhere1, lcWhere1H

        *-- Ler propriedades do BO definidas pelo Form via FormParaRelatorio
        lcGrest        = ALLTRIM(THIS.this_cCdGrEstoque)
        lcEstoque      = ALLTRIM(THIS.this_cCdEstoque)
        lcGrupo        = ALLTRIM(THIS.this_cCdGrupo)
        ldData         = THIS.this_dData
        lcMoeda        = ALLTRIM(THIS.this_cCdMoeda)
        lcLinha        = ALLTRIM(THIS.this_cCdLinha)
        lcGrupoVenda   = ALLTRIM(THIS.this_cCdColecao)
        lcDescMoeda    = ALLTRIM(THIS.this_cDsMoeda)
        ldDtCotacao    = THIS.this_dDtCotacao
        lnDadosCotacao = THIS.this_nOptDadosCotacao
        lnValCust      = THIS.this_nOpcCusto
        lnValVend      = THIS.this_nOpcVenda
        lnPeso         = THIS.this_nOpcPeso
        lnFator        = THIS.this_nOpcFator
        lnOrdem        = THIS.this_nCmbOrdem
        lcEmpresa      = ALLTRIM(THIS.this_cCdEmpresa)
        llUnis         = (THIS.this_nOptUnis = 1)

        IF EMPTY(ldData)
            ldData = DATE()
        ENDIF

        *-- Posicao atual (hoje) ou historico?
        llPosAtu = (ldData = DATE())

        *-- Carregar nome da empresa via SQLEXEC
        lcNomeEmpresa = ""
        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(lcEmpresa)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EgpEmpresa")
        IF loc_nResult > 0
            SELECT cursor_4c_EgpEmpresa
            GO TOP
            IF !EOF()
                lcNomeEmpresa = ALLTRIM(cursor_4c_EgpEmpresa.razas)
            ENDIF
            USE IN cursor_4c_EgpEmpresa
        ENDIF
        THIS.this_cDsEmpresa = lcNomeEmpresa

        *-- Montar titulo e subtitulo do relatorio
        lcTitulo    = "Posi" + CHR(231) + CHR(227) + "o de Estoque p/ Grupo de Produto em " + DTOC(ldData)
        lcSubTitulo = IIF(EMPTY(lcMoeda), "", "Valores em " + lcDescMoeda)
        IF !EMPTY(lcGrest)
            lcSubTitulo = lcSubTitulo + " - Grupo de Estoque: " + ALLTRIM(lcGrest)
        ENDIF
        IF !EMPTY(lcEstoque)
            lcSubTitulo = lcSubTitulo + " - Estoque : " + ALLTRIM(lcEstoque)
        ENDIF
        IF !EMPTY(lcGrupo)
            lcSubTitulo = lcSubTitulo + " - Grupo de Produto: " + ALLTRIM(lcGrupo)
        ENDIF
        IF !EMPTY(lcLinha)
            lcSubTitulo = lcSubTitulo + " - Linha : " + ALLTRIM(lcLinha)
        ENDIF
        IF !EMPTY(lcGrupoVenda)
            lcSubTitulo = lcSubTitulo + " - Grupo de Venda : " + ALLTRIM(lcGrupoVenda)
        ENDIF

        *-- Descricao da ordenacao
        DO CASE
        CASE lnOrdem = 1
            lcOrdenaCab = "Ordenado por Grupo de Produto"
        CASE lnOrdem = 2
            lcOrdenaCab = "Ordenado por Linha"
        CASE lnOrdem = 3
            lcOrdenaCab = "Ordenado por Grupo de Venda"
        CASE lnOrdem = 4
            lcOrdenaCab = "Ordenado por Estoque"
        OTHERWISE
            lcOrdenaCab = ""
            lnOrdem     = 1
        ENDCASE

        *-- Montar cabecalho de colunas conforme opcoes selecionadas
        lcCabecalho = PADC("Grupo", 10, "_") + " "
        IF lnOrdem <> 4
            lcCabecalho = lcCabecalho + PADC("Conta", 10, "_") + " "
        ENDIF
        lcCabecalho = lcCabecalho + PADC("C" + CHR(243) + "digo", 10, "_") + " "
        lcCabecalho = lcCabecalho + PADC("Descri" + CHR(231) + CHR(227) + "o", ;
            IIF((lnPeso = 1 OR lnFator = 1) AND lnOrdem <> 4, 18, 30), "_") + " "
        IF lnFator = 1
            lcCabecalho = lcCabecalho + PADC("FV.", 3, "_") + " "
        ENDIF
        lcCabecalho = lcCabecalho + PADC("Qtde.", 10, "_") + " "
        IF lnPeso = 1
            lcCabecalho = lcCabecalho + PADC("Peso M" + CHR(233) + "dio", 10, "_") + " "
        ENDIF
        IF lnValCust = 1
            lcCabecalho = lcCabecalho + PADC("Vl.Custo", 17, "_") + " "
        ENDIF
        IF lnValVend = 1
            lcCabecalho = lcCabecalho + PADC("Vl.Venda", 17, "_")
        ENDIF

        *-- Criar cursores temporarios do relatorio
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), SubTitulo C(200), ;
            Cabecalho C(200), SubTitulo2 C(100))
        INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Cabecalho, SubTitulo2) ;
            VALUES (lcNomeEmpresa, lcTitulo, lcSubTitulo, lcCabecalho, lcOrdenaCab)

        IF USED("dbRelatorio")
            USE IN dbRelatorio
        ENDIF
        CREATE CURSOR dbRelatorio (Detalhe C(200))

        IF USED("dbUnis")
            USE IN dbUnis
        ENDIF
        CREATE CURSOR dbUnis (cUnis C(3), nValors N(15, 3))
        INDEX ON cUnis TAG cUnis
        SET ORDER TO cUnis

        IF USED("TempMoe")
            USE IN TempMoe
        ENDIF
        CREATE CURSOR TempMoe (cmoes C(3), cotacao N(14, 4))
        INDEX ON cmoes TAG cmoes

        IF USED("dbRelat")
            USE IN dbRelat
        ENDIF
        CREATE CURSOR dbRelat (codigo C(10), Descr C(30), qtds N(12, 3), ;
            vends N(15, 2), custs N(15, 2), fatvens C(3), pesom N(12, 3), ;
            grupos C(10), estos C(10), codCors C(4), sPesos N(12, 3), ;
            cUnis C(3), cUniPs C(3))
        IF !llUnis
            INDEX ON grupos + estos + codigo + codCors + fatvens TAG cgrus
        ELSE
            INDEX ON grupos + estos + cUnis + codigo + codCors + fatvens TAG cgrus
        ENDIF
        INDEX ON Descr + fatvens TAG descrs

        *-- Ranges para filtros BETWEEN
        lcEmpIni   = IIF(!EMPTY(lcEmpresa), lcEmpresa, SPACE(3))
        lcEmpFim   = IIF(!EMPTY(lcEmpresa), lcEmpresa, REPLICATE(CHR(254), 3))
        lcGrEstIni = IIF(!EMPTY(lcGrest),   lcGrest,   SPACE(10))
        lcGrEstFim = IIF(!EMPTY(lcGrest),   lcGrest,   REPLICATE(CHR(254), 10))
        lcEstIni   = IIF(!EMPTY(lcEstoque),  lcEstoque, SPACE(10))
        lcEstFim   = IIF(!EMPTY(lcEstoque),  lcEstoque, REPLICATE(CHR(254), 10))

        *-- Definir ordenacao e chave de agrupamento conforme lnOrdem
        DO CASE
        CASE lnOrdem = 1
            lcOrdem = "1,2,4,3,14"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + PADR(NVL(Tempo.cgrus,''),10) + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + PADR(NVL(Tempo.cgrus,''),10) + lcCodCors + lcFatVens"
            ENDIF
        CASE lnOrdem = 2
            lcOrdem = "1,2,12,3"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + NVL(Tempo.linhas,'') + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + NVL(Tempo.linhas,'') + lcCodCors + lcFatVens"
            ENDIF
        CASE lnOrdem = 3
            lcOrdem = "1,2,13,3"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + NVL(Tempo.colecoes,'') + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + NVL(Tempo.colecoes,'') + lcCodCors + lcFatVens"
            ENDIF
        CASE lnOrdem = 4
            lcOrdem = "1,2,3"
            IF !llUnis
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.estos + lcCodCors + lcFatVens"
            ELSE
                lcChave = "Tempo.grupos + Tempo.estos + Tempo.cUnis + Tempo.estos + lcCodCors + lcFatVens"
            ENDIF
        OTHERWISE
            lnOrdem = 1
            lcOrdem = "1,2,4,3"
            lcChave = "PADR(NVL(Tempo.cgrus,''),10) + lcCodCors + lcFatVens"
        ENDCASE

        *-- Carregar descricao do estoque filtrado (se especificado)
        IF USED("TmpEsto")
            USE IN TmpEsto
        ENDIF
        IF !EMPTY(lcEstoque)
            loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(lcEstoque)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEsto")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados do estoque"
                RETURN .F.
            ENDIF
            SELECT TmpEsto
            GO TOP
        ENDIF

        *-- Buscar dados de movimentacao de estoque
        IF USED("Tempo")
            USE IN Tempo
        ENDIF

        WAIT WINDOW "Aguarde! Selecionando produtos..." NOWAIT

        IF llPosAtu
            *-- Posicao atual: consultar SigMvEst no SQL Server
            lcWhere1 = "a.emps+a.grupos+a.estos Between '" + ;
                lcEmpIni + lcGrEstIni + lcEstIni + ;
                "' And '" + ;
                lcEmpFim + lcGrEstFim + lcEstFim + "'"
            IF !EMPTY(lcLinha)
                lcWhere1 = lcWhere1 + " And b.linhas=" + EscaparSQL(lcLinha)
            ENDIF
            IF !EMPTY(lcGrupoVenda)
                lcWhere1 = lcWhere1 + " And b.colecoes=" + EscaparSQL(lcGrupoVenda)
            ENDIF
            IF !EMPTY(lcGrupo)
                lcWhere1 = lcWhere1 + " And b.cgrus=" + EscaparSQL(lcGrupo) + " And a.Sqtds <> 0"
            ENDIF

            loc_cSQL = "Select a.grupos,a.estos,a.cpros,b.cgrus,a.sqtds As valos," + ;
                "b.pvens,b.moevs,b.fvendas,b.moepvs,b.custofs,b.moecusfs," + ;
                "b.linhas,b.colecoes,a.CodCors,b.pesoms,b.Cunis,b.cUniPs,a.sPesos," + ;
                "l.descs As desclin,l.tpcustos,l.tpvendas,g.dgrus,c.descs As desccol " + ;
                "From SigMvEst a " + ;
                "Left Join SigCdPro b On b.cpros=a.cpros " + ;
                "Left Join SigCdLin l On l.linhas=b.linhas " + ;
                "Left Join SigCdCol c On c.colecoes=b.colecoes " + ;
                "Left Join SigCdGrp g On g.cgrus=b.cgrus " + ;
                "Where " + lcWhere1 + " " + ;
                "Order By " + lcOrdem
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tempo")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar dados de estoque"
                RETURN .F.
            ENDIF
            SELECT Tempo
            GO TOP
        ELSE
            *-- Historico: consultar SigMvHst
            IF USED("TmpHisPro")
                USE IN TmpHisPro
            ENDIF

            IF !EMPTY(lcEmpresa) AND !EMPTY(lcGrest) AND !EMPTY(lcEstoque)
                lcWhere1H = "a.empgruests = '" + lcEmpresa + lcGrest + lcEstoque + "'"
            ELSE
                lcWhere1H = "a.empgruests Between '" + ;
                    lcEmpIni + lcGrEstIni + lcEstIni + ;
                    "' And '" + ;
                    lcEmpFim + lcGrEstFim + lcEstFim + "'"
            ENDIF
            lcWhere1H = lcWhere1H + " And a.datas <= " + FormatarDataSQL(ldData) + ;
                " And a.cpros = b.cpros"
            IF !EMPTY(lcLinha)
                lcWhere1H = lcWhere1H + " And b.linhas = " + EscaparSQL(lcLinha)
            ENDIF
            IF !EMPTY(lcGrupoVenda)
                lcWhere1H = lcWhere1H + " And b.colecoes = " + EscaparSQL(lcGrupoVenda)
            ENDIF
            IF !EMPTY(lcGrupo)
                lcWhere1H = lcWhere1H + " And b.cgrus = " + EscaparSQL(lcGrupo)
            ENDIF

            loc_cSQL = "Select a.grupos,a.estos,a.cpros,b.cgrus,a.qtds," + ;
                "b.pvens,b.moevs,b.fvendas,b.moepvs,b.custofs,b.moecusfs," + ;
                "b.linhas,b.colecoes,a.CodCors,b.pesoms,a.opers,b.CUnis,b.cUniPs,a.Pesos " + ;
                "From SigMvHst a, SigCdPro b " + ;
                "Where " + lcWhere1H
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHisPro")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico de estoque"
                RETURN .F.
            ENDIF

            WAIT WINDOW "Aguarde! Verificando movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT
            SELECT grupos, estos, cpros, cgrus, pvens, moevs, fvendas, moepvs, ;
                custofs, moecusfs, linhas, colecoes, codCors, pesoms, cUnis, cUniPs, ;
                SUM(qtds * IIF(opers = "E", 1, -1)) AS valos, ;
                SUM(Pesos * IIF(opers = "E", 1, -1)) AS sPesos ;
                FROM TmpHisPro ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY &lcOrdem. ;
                INTO CURSOR Tempo
            SELECT Tempo
            GO TOP
        ENDIF

        *-- Processar registros de Tempo
        SELECT Tempo
        GO TOP
        IF !EOF()
            lnValCot = THIS.CarregarCambio(lcMoeda, ldData)

            SELECT Tempo
            GO TOP
            SCAN
                lcCodPro = Tempo.cpros

                IF Tempo.valos = 0
                    LOOP
                ENDIF

                IF !llPosAtu
                    *-- Buscar detalhes do produto na consulta historica
                    loc_cSQL = "Select a.cpros,g.dgrus,l.descs As desclin," + ;
                        "l.tpcustos,l.tpvendas,c.descs As desccol " + ;
                        "From SigCdPro a " + ;
                        "Left Join SigCdLin l On l.linhas = a.linhas " + ;
                        "Left Join SigCdCol c On c.colecoes = a.colecoes " + ;
                        "Left Join SigCdGrp g On g.cgrus = a.cgrus " + ;
                        "Where a.cpros = " + EscaparSQL(lcCodPro)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPro")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar dados do produto"
                        RETURN .F.
                    ENDIF
                ENDIF

                SELECT Tempo
                lnValorProd = NVL(Tempo.pvens, 0) * Tempo.valos
                lnValorProd = lnValorProd * THIS.CarregarCambio(NVL(Tempo.moevs, ""), ldData) / lnValCot
                lnCustoProd = NVL(Tempo.custofs, 0)

                IF llPosAtu
                    IF NVL(Tempo.tpcustos, "") = "2"
                        lnCustoProd = NVL(Tempo.pesoms, 0) * NVL(Tempo.custofs, 0)
                    ENDIF
                    IF NVL(Tempo.tpvendas, "") = "2"
                        lnValorProd = NVL(Tempo.pesoms, 0) * lnValorProd
                    ENDIF
                ELSE
                    IF NVL(TmpPro.tpcustos, "") = "2"
                        lnCustoProd = NVL(Tempo.pesoms, 0) * NVL(Tempo.custofs, 0)
                    ENDIF
                    IF NVL(TmpPro.tpvendas, "") = "2"
                        lnValorProd = NVL(Tempo.pesoms, 0) * lnValorProd
                    ENDIF
                ENDIF

                lnCustoProd = lnCustoProd * Tempo.valos * ;
                    THIS.CarregarCambio(NVL(Tempo.moecusfs, ""), ldData) / lnValCot
                lnValFat = IIF(NVL(Tempo.fvendas, 0) = 0, 1, ;
                    NVL(Tempo.fvendas, 0) * THIS.CarregarCambio(NVL(Tempo.moepvs, ""), ldData))
                lnValorProd = lnValorProd * lnValFat

                *-- Registrar cotacoes utilizadas em TempMoe
                SELECT TempMoe
                SET ORDER TO cmoes
                =SEEK(NVL(Tempo.moevs, ""), "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH NVL(Tempo.moevs, "")
                    REPLACE TempMoe.cotacao WITH THIS.CarregarCambio(NVL(Tempo.moevs, ""), ldData)
                ENDIF
                =SEEK(lcMoeda, "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH lcMoeda
                    REPLACE TempMoe.cotacao WITH lnValCot
                ENDIF
                =SEEK(NVL(Tempo.moecusfs, ""), "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH NVL(Tempo.moecusfs, "")
                    REPLACE TempMoe.cotacao WITH THIS.CarregarCambio(NVL(Tempo.moecusfs, ""), ldData)
                ENDIF
                =SEEK(NVL(Tempo.moepvs, ""), "TempMoe", "cmoes")
                SELECT TempMoe
                IF EOF()
                    APPEND BLANK
                    REPLACE TempMoe.cmoes   WITH NVL(Tempo.moepvs, "")
                    REPLACE TempMoe.cotacao WITH THIS.CarregarCambio(NVL(Tempo.moepvs, ""), ldData)
                ENDIF

                *-- Adicionar ou acumular registro em dbRelat
                SELECT dbRelat
                SET ORDER TO cgrus

                lcFatVens = ""
                IF lnFator = 1
                    lcFatVens = NVL(Tempo.moepvs, "")
                ENDIF
                lcCodCors = SPACE(4)
                IF lnOrdem = 1
                    lcCodCors = Tempo.codCors
                ENDIF

                =SEEK(&lcChave., "dbRelat", "cgrus")
                SELECT dbRelat
                IF EOF()
                    APPEND BLANK
                    REPLACE dbRelat.fatvens WITH lcFatVens, ;
                        dbRelat.grupos  WITH Tempo.grupos, ;
                        dbRelat.estos   WITH Tempo.estos, ;
                        dbRelat.cUnis   WITH Tempo.cUnis, ;
                        dbRelat.cUniPs  WITH Tempo.cUniPs, ;
                        dbRelat.codCors WITH lcCodCors IN dbRelat
                    DO CASE
                    CASE lnOrdem = 1
                        REPLACE dbRelat.codigo WITH NVL(Tempo.cgrus, "")
                        IF llPosAtu
                            REPLACE dbRelat.Descr WITH NVL(Tempo.dgrus, "")
                        ELSE
                            REPLACE dbRelat.Descr WITH NVL(TmpPro.dgrus, "")
                        ENDIF
                    CASE lnOrdem = 2
                        REPLACE dbRelat.codigo WITH NVL(Tempo.linhas, "")
                        IF llPosAtu
                            REPLACE dbRelat.Descr WITH NVL(Tempo.desclin, "")
                        ELSE
                            REPLACE dbRelat.Descr WITH NVL(TmpPro.desclin, "")
                        ENDIF
                    CASE lnOrdem = 3
                        REPLACE dbRelat.codigo WITH NVL(Tempo.colecoes, "")
                        IF llPosAtu
                            REPLACE dbRelat.Descr WITH NVL(Tempo.desccol, "")
                        ELSE
                            REPLACE dbRelat.Descr WITH NVL(TmpPro.desccol, "")
                        ENDIF
                    CASE lnOrdem = 4
                        lcEstos = Tempo.estos
                        lcRclis = ""
                        IF EMPTY(lcEstoque)
                            IF USED("TmpEsto")
                                USE IN TmpEsto
                            ENDIF
                            loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(lcEstos)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEsto")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar descri" + CHR(231) + CHR(227) + "o do estoque"
                                RETURN .F.
                            ENDIF
                        ENDIF
                        SELECT TmpEsto
                        GO TOP
                        IF !EOF()
                            lcRclis = TmpEsto.rclis
                        ENDIF
                        REPLACE dbRelat.codigo WITH lcEstos
                        REPLACE dbRelat.Descr  WITH lcRclis
                    ENDCASE
                ENDIF

                *-- Acumular totais no registro de dbRelat
                REPLACE dbRelat.qtds   WITH dbRelat.qtds   + Tempo.valos
                REPLACE dbRelat.vends  WITH dbRelat.vends  + lnValorProd
                REPLACE dbRelat.custs  WITH dbRelat.custs  + lnCustoProd
                REPLACE dbRelat.sPesos WITH dbRelat.sPesos + Tempo.sPesos
                REPLACE dbRelat.pesom  WITH dbRelat.pesom  + NVL(Tempo.pesoms, 0) * Tempo.valos

                *-- Acumular por unidade
                SELECT dbUnis
                SEEK Tempo.cUnis
                IF !FOUND()
                    APPEND BLANK
                    REPLACE cUnis WITH Tempo.cUnis
                ENDIF
                REPLACE nValors WITH nValors + Tempo.valos

                SELECT Tempo
            ENDSCAN

            *-- Montar linhas de detalhe do relatorio
            nTotQtds  = 0
            nTotPeso  = 0
            nTotCusto = 0
            nTotVenda = 0
            cAnt      = " "
            cAnte     = " "

            SELECT dbRelat
            GO TOP
            SCAN
                cDetalhe = PADR(dbRelat.codigo, 10) + " "
                cDetalhe = cDetalhe + PADR(dbRelat.Descr, ;
                    IIF((lnPeso = 1 OR lnFator = 1) AND lnOrdem <> 4, ;
                    IIF(lnOrdem = 1, 13, 18), 27)) + " "
                cDetalhe = cDetalhe + IIF(lnOrdem = 1, dbRelat.codCors + " ", "")
                IF lnFator = 1
                    cDetalhe = cDetalhe + PADC(dbRelat.fatvens, 3) + " "
                ENDIF
                cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.qtds, "999999.999"), 10) + " " + ;
                    IIF(llUnis, dbRelat.cUnis + " ", "")
                IF lnPeso = 1
                    cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.pesom, "999,999.99"), 10) + " "
                ENDIF
                IF lnValCust = 1
                    cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.custs, "99999,999,999.99"), 16) + " "
                ENDIF
                IF lnValVend = 1
                    cDetalhe = cDetalhe + PADL(TRANSFORM(dbRelat.vends, "99999,999,999.99"), 16)
                ENDIF
                IF lnOrdem <> 4
                    cDetalhe = IIF(cAnt = dbRelat.grupos, SPACE(10), dbRelat.grupos) + ;
                        " " + dbRelat.estos + " " + cDetalhe
                ELSE
                    cDetalhe = IIF(cAnt = dbRelat.grupos, SPACE(10), dbRelat.grupos) + ;
                        " " + cDetalhe
                ENDIF
                cAnt  = dbRelat.grupos
                cAnte = dbRelat.estos

                INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)

                nTotQtds  = nTotQtds  + dbRelat.qtds
                nTotPeso  = nTotPeso  + dbRelat.pesom
                nTotCusto = nTotCusto + dbRelat.custs
                nTotVenda = nTotVenda + dbRelat.vends
            ENDSCAN

            *-- Calcular espaco para alinhamento dos totais
            lnEspaco = IIF((lnFator = 1 OR lnPeso = 1) AND lnOrdem <> 4, ;
                IIF(lnPeso = 1 AND lnFator <> 1, 39, 43), ;
                IIF(lnPeso = 1 AND lnFator <> 1, 51, ;
                IIF(lnPeso <> 1 AND lnFator <> 1, IIF(lnOrdem <> 4, 56, 51), 55))) + ;
                IIF(lnOrdem = 1, 13, IIF(lnOrdem <> 4, IIF(lnPeso = 1 OR lnFator = 1, 13, 8), 2))

            *-- Linha separadora
            cTotal = SPACE(lnEspaco)
            cTotal = cTotal + REPLICATE("_", 10) + " "
            IF lnPeso = 1
                cTotal = cTotal + REPLICATE("_", 10) + " "
            ENDIF
            IF lnValCust = 1
                cTotal = cTotal + REPLICATE("_", 16) + " "
            ENDIF
            IF lnValVend = 1
                cTotal = cTotal + REPLICATE("_", 16) + " "
            ENDIF
            INSERT INTO dbRelatorio (Detalhe) VALUES (cTotal)

            *-- Linha de totais gerais
            cTotal = PADL("Total : ", lnEspaco)
            cTotal = cTotal + PADL(TRANSFORM(nTotQtds, "999,999.99"), 10) + " "
            IF lnPeso = 1
                cTotal = cTotal + PADL(TRANSFORM(nTotPeso, "999,999.99"), 10) + " "
            ENDIF
            IF lnValCust = 1
                cTotal = cTotal + PADL(TRANSFORM(nTotCusto, "99999,999,999.99"), 16) + " "
            ENDIF
            IF lnValVend = 1
                cTotal = cTotal + PADL(TRANSFORM(nTotVenda, "99999,999,999.99"), 16) + " "
            ENDIF
            INSERT INTO dbRelatorio (Detalhe) VALUES (cTotal)

            *-- Totais por unidade (se habilitado)
            IF llUnis
                SELECT dbUnis
                GO TOP
                IF !EOF()
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = "Totais Por Unidade"
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = PADC("Unidade", 7) + " "
                    cDetalhe = cDetalhe + PADC("Total", 14)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    cDetalhe = REPLICATE("_", 7) + " "
                    cDetalhe = cDetalhe + REPLICATE("_", 20)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    SCAN
                        cDetalhe = "  " + dbUnis.cUnis + "   "
                        cDetalhe = cDetalhe + PADL(TRANSFORM(dbUnis.nValors, "9999,999,999,999.999"), 20)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Dados de cotacoes de moeda (se habilitado e moeda informada)
            IF lnDadosCotacao = 1 AND !EMPTY(lcMoeda)
                SELECT TempMoe
                GO TOP
                IF !EOF()
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = "Cota" + CHR(231) + CHR(245) + "es de " + DTOC(ldDtCotacao)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                    cDetalhe = PADC("Moeda", 5) + " "
                    cDetalhe = cDetalhe + PADC("Cota" + CHR(231) + CHR(227) + "o", 14)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    cDetalhe = REPLICATE("_", 5) + " "
                    cDetalhe = cDetalhe + REPLICATE("_", 14)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    SCAN
                        cDetalhe = PADR(TempMoe.cmoes, 5) + " "
                        cDetalhe = cDetalhe + PADL(TRANSFORM(TempMoe.cotacao, "999,999,999.99"), 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (cDetalhe)
                    ENDSCAN
                ENDIF
            ENDIF
        ENDIF

        WAIT CLEAR

        SELECT dbRelatorio
        GO TOP

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data especificada
    * Replica logica de fCarregarCambio do sistema legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 cotacao FROM SigCdCot " + ;
                "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                " AND datas <= " + FormatarDataSQL(par_dData) + ;
                " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EgpCambio")
            IF loc_nResult > 0
                SELECT cursor_4c_EgpCambio
                GO TOP
                IF !EOF()
                    loc_nCotacao = NVL(cursor_4c_EgpCambio.cotacao, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_EgpCambio
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor de parametros
    * BO de RELATORIO nao tem cursor de dados persistido: a procedure existe
    * para compatibilidade com a interface esperada pelo pipeline e para permitir
    * que um cursor temporario de parametros seja relido (por exemplo, ao
    * reabrir o form com filtros salvos). Mapeia colunas conhecidas para as
    * propriedades correspondentes do BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        IF VARTYPE(par_cAliasCursor) <> "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF
        loc_cAlias = ALLTRIM(par_cAliasCursor)
        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF
        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".cemps")     = "C"
                    THIS.this_cCdEmpresa = TratarNulo(EVALUATE(loc_cAlias + ".cemps"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".grupos")    = "C"
                    THIS.this_cCdGrEstoque = TratarNulo(EVALUATE(loc_cAlias + ".grupos"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".estos")     = "C"
                    THIS.this_cCdEstoque = TratarNulo(EVALUATE(loc_cAlias + ".estos"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".cgrus")     = "C"
                    THIS.this_cCdGrupo = TratarNulo(EVALUATE(loc_cAlias + ".cgrus"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".datas")     = "D"
                    THIS.this_dData = TratarNulo(EVALUATE(loc_cAlias + ".datas"), "D")
                ENDIF
                IF TYPE(loc_cAlias + ".cmoes")     = "C"
                    THIS.this_cCdMoeda = TratarNulo(EVALUATE(loc_cAlias + ".cmoes"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".linhas")    = "C"
                    THIS.this_cCdLinha = TratarNulo(EVALUATE(loc_cAlias + ".linhas"), "C")
                ENDIF
                IF TYPE(loc_cAlias + ".colecoes")  = "C"
                    THIS.this_cCdColecao = TratarNulo(EVALUATE(loc_cAlias + ".colecoes"), "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persistencia desabilitada
    * BO de RELATORIO nao grava registros em tabela. Mantemos o metodo na
    * interface publica para compatibilidade com chamadas genericas do pipeline,
    * mas qualquer chamada eh tratada como erro de uso: emite mensagem clara,
    * NAO falha silenciosamente e retorna .F. para sinalizar a opcao invalida.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o aplic" + CHR(225) + "vel: este relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o realiza inser" + CHR(231) + CHR(227) + "o de registros em tabela. " + ;
            "Use Imprimir() ou Visualizar() para gerar o relat" + CHR(243) + "rio."
        THIS.RegistrarAuditoria("INSERIR_INVALIDA")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Persistencia desabilitada
    * BO de RELATORIO nao atualiza registros. Mesma logica de Inserir():
    * mantemos a assinatura para compatibilidade, mas qualquer chamada eh
    * tratada como uso indevido com mensagem explicita e retorno .F.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o aplic" + CHR(225) + "vel: este relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o realiza atualiza" + CHR(231) + CHR(227) + "o de registros em tabela. " + ;
            "Use Imprimir() ou Visualizar() para gerar o relat" + CHR(243) + "rio."
        THIS.RegistrarAuditoria("ATUALIZAR_INVALIDA")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da emissao do relatorio
    * Como o relatorio nao tem registro persistido com PK, montamos um
    * identificador unico baseado nos filtros principais (empresa + data de
    * posicao + grupo de estoque). Usado por RegistrarAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmp, loc_cData, loc_cGrEst
        loc_cEmp   = ALLTRIM(NVL(THIS.this_cCdEmpresa, ""))
        loc_cGrEst = ALLTRIM(NVL(THIS.this_cCdGrEstoque, ""))
        IF VARTYPE(THIS.this_dData) = "D" AND !EMPTY(THIS.this_dData)
            loc_cData = DTOS(THIS.this_dData)
        ELSE
            loc_cData = DTOS(DATE())
        ENDIF
        loc_cChave = "SIGREEGP|" + loc_cEmp + "|" + loc_cData + "|" + loc_cGrEst
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava log de emissao/uso do relatorio
    * Para BO de RELATORIO registra a operacao executada (EMISSAO_IMPRIMIR,
    * EMISSAO_VISUALIZAR, INSERIR_INVALIDA, ATUALIZAR_INVALIDA) na tabela
    * LogAuditoria com a chave gerada por ObterChavePrimaria. Falhas no INSERT
    * de auditoria nao devem propagar (auditoria nao pode bloquear a emissao
    * do relatorio), portanto sao capturadas e silenciadas via TRY/CATCH.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cOperacao, loc_cChave, loc_cUsuario, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cOperacao) <> "C" OR EMPTY(par_cOperacao)
                loc_cOperacao = "EMISSAO_RELATORIO"
            ELSE
                loc_cOperacao = ALLTRIM(par_cOperacao)
            ENDIF
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                    "VALUES (" + EscaparSQL("SIGREEGP") + ", " + EscaparSQL(loc_cOperacao) + ", " + ;
                    EscaparSQL(loc_cChave) + ", " + EscaparSQL(loc_cUsuario) + ", GETDATE())"
                =SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha todos os cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("dbRelatorio")
            USE IN dbRelatorio
        ENDIF
        IF USED("TempMoe")
            USE IN TempMoe
        ENDIF
        IF USED("dbRelat")
            USE IN dbRelat
        ENDIF
        IF USED("Tempo")
            USE IN Tempo
        ENDIF
        IF USED("TmpHisPro")
            USE IN TmpHisPro
        ENDIF
        IF USED("TmpEsto")
            USE IN TmpEsto
        ENDIF
        IF USED("TmpPro")
            USE IN TmpPro
        ENDIF
        IF USED("dbUnis")
            USE IN dbUnis
        ENDIF
    ENDPROC

ENDDEFINE

