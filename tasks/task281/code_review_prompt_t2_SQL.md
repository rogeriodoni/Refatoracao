# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS

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
		lcQuery = [Select GrPadVens ] + ;
				    [From SigCdPam ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalParam') < 1)
		Select CqSigCdCli
lcQuery = [Select a.* ] + ;
		    [From SigMvCab a, SigCdOpe b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csTemporario') < 1)
Select csTemporario
Update csTemporario ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS SQL (2111 linhas total):

*-- Linhas 1205 a 1232:
1205:         LOCAL loc_oBusca, loc_nResultado, loc_cSQL
1206:         TRY
1207:             IF par_cModo = "C"
1208:                 loc_cSQL = "SELECT TOP 200 Cemps AS Cemps, Razas AS Razas FROM SigCdEmp ORDER BY Cemps"
1209:             ELSE
1210:                 loc_cSQL = "SELECT TOP 200 Cemps AS Cemps, Razas AS Razas FROM SigCdEmp ORDER BY Razas"
1211:             ENDIF
1212: 
1213:             IF USED("cursor_4c_BuscaEmp")
1214:                 USE IN cursor_4c_BuscaEmp
1215:             ENDIF
1216: 
1217:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
1218:             IF loc_nResultado < 1
1219:                 RETURN
1220:             ENDIF
1221: 
1222:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
1223:                 "cursor_4c_BuscaEmp", "Cemps", "", ;
1224:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
1225:             loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
1226:             loc_oBusca.mAddColuna("Razas", "", "Empresa")
1227:             loc_oBusca.Show()
1228: 
1229:             IF loc_oBusca.this_lSelecionou
1230:                 THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = ALLTRIM(NVL(cursor_4c_BuscaEmp.Cemps, ""))
1231:                 THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = ALLTRIM(NVL(cursor_4c_BuscaEmp.Razas, ""))
1232:             ENDIF

*-- Linhas 1247 a 1274:
1247:         TRY
1248:             loc_cWhere = ""
1249:             IF !EMPTY(ALLTRIM(par_cValor))
1250:                 loc_cWhere = "WHERE Dopes LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
1251:             ENDIF
1252: 
1253:             loc_cSQL = "SELECT TOP 200 Dopes FROM SigCdOpe " + loc_cWhere + " ORDER BY Dopes"
1254: 
1255:             IF USED("cursor_4c_BuscaOpe")
1256:                 USE IN cursor_4c_BuscaOpe
1257:             ENDIF
1258: 
1259:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
1260:             IF loc_nResultado < 1
1261:                 RETURN
1262:             ENDIF
1263: 
1264:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
1265:                 "cursor_4c_BuscaOpe", "Dopes", "", ;
1266:                 "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
1267:             loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1268:             loc_oBusca.Show()
1269: 
1270:             IF loc_oBusca.this_lSelecionou
1271:                 THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))
1272:             ENDIF
1273: 
1274:             IF USED("cursor_4c_BuscaOpe")

*-- Linhas 1287 a 1319:
1287:         TRY
1288:             IF par_cModo = "C"
1289:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
1290:                     "WHERE CMoes LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
1291:                 loc_cSQL = "SELECT TOP 100 CMoes, DMoes FROM SigCdMoe " + ;
1292:                     loc_cWhere + " ORDER BY CMoes"
1293:             ELSE
1294:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
1295:                     "WHERE RTRIM(DMoes) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
1296:                 loc_cSQL = "SELECT TOP 100 CMoes, DMoes FROM SigCdMoe " + ;
1297:                     loc_cWhere + " ORDER BY DMoes"
1298:             ENDIF
1299: 
1300:             IF USED("cursor_4c_BuscaMoe")
1301:                 USE IN cursor_4c_BuscaMoe
1302:             ENDIF
1303: 
1304:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
1305:             IF loc_nResultado < 1
1306:                 RETURN
1307:             ENDIF
1308: 
1309:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
1310:                 "cursor_4c_BuscaMoe", IIF(par_cModo = "C", "CMoes", "DMoes"), "", ;
1311:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda", .T., .T., "")
1312:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
1313:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1314:             loc_oBusca.Show()
1315: 
1316:             IF loc_oBusca.this_lSelecionou
1317:                 THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_BuscaMoe.CMoes, ""))
1318:                 THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_BuscaMoe.DMoes, ""))
1319:             ENDIF

*-- Linhas 1334 a 1372:
1334:         LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
1335:         TRY
1336:             IF par_cModo = "C"
1337:                 loc_cWhere = "WHERE IClis LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
1338:             ELSE
1339:                 loc_cWhere = "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
1340:             ENDIF
1341: 
1342:             IF !EMPTY(ALLTRIM(par_cGrupo))
1343:                 loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10))
1344:             ENDIF
1345: 
1346:             loc_cSQL = "SELECT TOP 200 IClis, RClis, Cpfs FROM SigCdCli " + ;
1347:                 loc_cWhere + " ORDER BY IClis"
1348: 
1349:             IF USED("cursor_4c_BuscaCli")
1350:                 USE IN cursor_4c_BuscaCli
1351:             ENDIF
1352: 
1353:             IF EMPTY(ALLTRIM(par_cValor))
1354:                 loc_cSQL = "SELECT TOP 200 IClis, RClis, Cpfs FROM SigCdCli ORDER BY IClis"
1355:             ENDIF
1356: 
1357:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1358:             IF loc_nResultado < 1
1359:                 RETURN
1360:             ENDIF
1361: 
1362:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
1363:                 "cursor_4c_BuscaCli", IIF(par_cModo = "C", "IClis", "RClis"), "", ;
1364:                 "Sele" + CHR(231) + CHR(227) + "o de Conta", .T., .T., "")
1365:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1366:             loc_oBusca.mAddColuna("RClis", "", "Nome")
1367:             loc_oBusca.Show()
1368: 
1369:             IF loc_oBusca.this_lSelecionou
1370:                 THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_BuscaCli.IClis, ""))
1371:                 THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_BuscaCli.RClis, ""))
1372:                 THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_BuscaCli.Cpfs, ""))

*-- Linhas 1393 a 1436:
1393:             ENDIF
1394: 
1395:             IF par_cModo = "C"
1396:                 loc_cWhere = "WHERE IClis LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
1397:             ELSE
1398:                 loc_cWhere = "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
1399:             ENDIF
1400: 
1401:             IF !EMPTY(loc_cGrPadVens)
1402:                 loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(PADR(loc_cGrPadVens, 10))
1403:             ENDIF
1404: 
1405:             loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli " + ;
1406:                 loc_cWhere + " ORDER BY IClis"
1407: 
1408:             IF EMPTY(ALLTRIM(par_cValor))
1409:                 IF EMPTY(loc_cGrPadVens)
1410:                     loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli ORDER BY IClis"
1411:                 ELSE
1412:                     loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli WHERE Grupos = " + ;
1413:                         EscaparSQL(PADR(loc_cGrPadVens, 10)) + " ORDER BY IClis"
1414:                 ENDIF
1415:             ENDIF
1416: 
1417:             IF USED("cursor_4c_BuscaResp")
1418:                 USE IN cursor_4c_BuscaResp
1419:             ENDIF
1420: 
1421:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp")
1422:             IF loc_nResultado < 1
1423:                 RETURN
1424:             ENDIF
1425: 
1426:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
1427:                 "cursor_4c_BuscaResp", IIF(par_cModo = "C", "IClis", "RClis"), "", ;
1428:                 "Sele" + CHR(231) + CHR(227) + "o de Respons" + CHR(225) + "vel", .T., .T., "")
1429:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1430:             loc_oBusca.mAddColuna("RClis", "", "Nome")
1431:             loc_oBusca.Show()
1432: 
1433:             IF loc_oBusca.this_lSelecionou
1434:                 THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_BuscaResp.IClis, ""))
1435:                 THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_BuscaResp.RClis, ""))
1436:             ENDIF

*-- Linhas 1445 a 1488:
1445: 
1446:     *===========================================================================
1447:     * ValidarCdEmpresa - Handler KeyPress de txt_4c_CdEmpresa
1448:     * ENTER/TAB: SELECT exato; miss -> AbrirBuscaEmpresa
1449:     * F4: abre picker direto
1450:     *===========================================================================
1451:     PROCEDURE ValidarCdEmpresa
1452:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1453:         LOCAL loc_nResultado, loc_cSQL, loc_cCod
1454:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1455:             RETURN
1456:         ENDIF
1457:         IF par_nKeyCode = 115
1458:             THIS.AbrirBuscaEmpresa("C")
1459:             RETURN
1460:         ENDIF
1461:         loc_cCod = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value)
1462:         IF EMPTY(loc_cCod)
1463:             THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value = ""
1464:             RETURN
1465:         ENDIF
1466:         TRY
1467:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1468:             IF USED("cursor_4c_EmpTmp")
1469:                 USE IN cursor_4c_EmpTmp
1470:             ENDIF
1471:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
1472:             IF loc_nResultado >= 1
1473:                 SELECT cursor_4c_EmpTmp
1474:                 IF !EOF("cursor_4c_EmpTmp")
1475:                     THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
1476:                     THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
1477:                     USE IN cursor_4c_EmpTmp
1478:                     RETURN
1479:                 ENDIF
1480:                 USE IN cursor_4c_EmpTmp
1481:             ENDIF
1482:             THIS.AbrirBuscaEmpresa("C")
1483:         CATCH TO loc_oErro
1484:             MsgErro(loc_oErro.Message, "Erro ValidarCdEmpresa")
1485:         ENDTRY
1486:     ENDPROC
1487: 
1488:     *===========================================================================

*-- Linhas 1504 a 1529:
1504:             RETURN
1505:         ENDIF
1506:         TRY
1507:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) LIKE " + ;
1508:                 EscaparSQL(loc_cDs + "%")
1509:             IF USED("cursor_4c_EmpTmp")
1510:                 USE IN cursor_4c_EmpTmp
1511:             ENDIF
1512:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
1513:             IF loc_nResultado >= 1
1514:                 SELECT cursor_4c_EmpTmp
1515:                 IF !EOF("cursor_4c_EmpTmp")
1516:                     THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
1517:                     THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
1518:                     USE IN cursor_4c_EmpTmp
1519:                     RETURN
1520:                 ENDIF
1521:                 USE IN cursor_4c_EmpTmp
1522:             ENDIF
1523:             THIS.AbrirBuscaEmpresa("D")
1524:         CATCH TO loc_oErro
1525:             MsgErro(loc_oErro.Message, "Erro ValidarDsEmpresa")
1526:         ENDTRY
1527:     ENDPROC
1528: 
1529:     *===========================================================================

*-- Linhas 1545 a 1569:
1545:             RETURN
1546:         ENDIF
1547:         TRY
1548:             loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(PADR(loc_cOpe, 20))
1549:             IF USED("cursor_4c_OpeTmp")
1550:                 USE IN cursor_4c_OpeTmp
1551:             ENDIF
1552:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTmp")
1553:             IF loc_nResultado >= 1
1554:                 SELECT cursor_4c_OpeTmp
1555:                 IF !EOF("cursor_4c_OpeTmp")
1556:                     THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = ALLTRIM(NVL(cursor_4c_OpeTmp.Dopes, ""))
1557:                     USE IN cursor_4c_OpeTmp
1558:                     RETURN
1559:                 ENDIF
1560:                 USE IN cursor_4c_OpeTmp
1561:             ENDIF
1562:             THIS.AbrirBuscaOperacao(loc_cOpe)
1563:         CATCH TO loc_oErro
1564:             MsgErro(loc_oErro.Message, "Erro ValidarNmOperacao")
1565:         ENDTRY
1566:     ENDPROC
1567: 
1568:     *===========================================================================
1569:     * ValidarCdGrupo - Handler KeyPress de txt_4c_Grupo

*-- Linhas 1581 a 1606:
1581:             RETURN
1582:         ENDIF
1583:         TRY
1584:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
1585:                 EscaparSQL(PADR(loc_cGrp, 10))
1586:             IF USED("cursor_4c_GrpTmp")
1587:                 USE IN cursor_4c_GrpTmp
1588:             ENDIF
1589:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
1590:             IF loc_nResultado >= 1
1591:                 SELECT cursor_4c_GrpTmp
1592:                 IF !EOF("cursor_4c_GrpTmp")
1593:                     THIS.cnt_4c_Container1.txt_4c_Grupo.Value    = ALLTRIM(NVL(cursor_4c_GrpTmp.codigos, ""))
1594:                     THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value  = ALLTRIM(NVL(cursor_4c_GrpTmp.descrs, ""))
1595:                     USE IN cursor_4c_GrpTmp
1596:                     RETURN
1597:                 ENDIF
1598:                 USE IN cursor_4c_GrpTmp
1599:             ENDIF
1600:             THIS.AbrirBuscaGrupoContabil("C", loc_cGrp)
1601:         CATCH TO loc_oErro
1602:             MsgErro(loc_oErro.Message, "Erro ValidarCdGrupo")
1603:         ENDTRY
1604:     ENDPROC
1605: 
1606:     *===========================================================================

*-- Linhas 1618 a 1676:
1618:             RETURN
1619:         ENDIF
1620:         TRY
1621:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(descrs) LIKE " + ;
1622:                 EscaparSQL(loc_cDs + "%")
1623:             IF USED("cursor_4c_GrpTmp")
1624:                 USE IN cursor_4c_GrpTmp
1625:             ENDIF
1626:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
1627:             IF loc_nResultado >= 1
1628:                 SELECT cursor_4c_GrpTmp
1629:                 IF !EOF("cursor_4c_GrpTmp")
1630:                     THIS.cnt_4c_Container1.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_GrpTmp.codigos, ""))
1631:                     THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value = ALLTRIM(NVL(cursor_4c_GrpTmp.descrs, ""))
1632:                     USE IN cursor_4c_GrpTmp
1633:                     RETURN
1634:                 ENDIF
1635:                 USE IN cursor_4c_GrpTmp
1636:             ENDIF
1637:             THIS.AbrirBuscaGrupoContabil("D", loc_cDs)
1638:         CATCH TO loc_oErro
1639:             MsgErro(loc_oErro.Message, "Erro ValidarDsGrupo")
1640:         ENDTRY
1641:     ENDPROC
1642: 
1643:     *===========================================================================
1644:     * AbrirBuscaGrupoContabil - Picker SigCdGcr (codigos/descrs com r)
1645:     *===========================================================================
1646:     PROCEDURE AbrirBuscaGrupoContabil(par_cModo, par_cValor)
1647:         LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
1648:         TRY
1649:             IF par_cModo = "C"
1650:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
1651:                     "WHERE codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
1652:             ELSE
1653:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
1654:                     "WHERE RTRIM(descrs) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
1655:             ENDIF
1656:             loc_cSQL = "SELECT TOP 200 codigos, descrs FROM SigCdGcr " + loc_cWhere + " ORDER BY codigos"
1657: 
1658:             IF USED("cursor_4c_BuscaGcr")
1659:                 USE IN cursor_4c_BuscaGcr
1660:             ENDIF
1661:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
1662:             IF loc_nResultado < 1
1663:                 RETURN
1664:             ENDIF
1665: 
1666:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
1667:                 "cursor_4c_BuscaGcr", IIF(par_cModo = "C", "codigos", "descrs"), "", ;
1668:                 "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
1669:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1670:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1671:             loc_oBusca.Show()
1672: 
1673:             IF loc_oBusca.this_lSelecionou
1674:                 THIS.cnt_4c_Container1.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_BuscaGcr.codigos, ""))
1675:                 THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value = ALLTRIM(NVL(cursor_4c_BuscaGcr.descrs, ""))
1676:             ENDIF

*-- Linhas 1699 a 1727:
1699:             RETURN
1700:         ENDIF
1701:         TRY
1702:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE IClis = " + ;
1703:                 EscaparSQL(PADR(loc_cCta, 10))
1704:             IF !EMPTY(loc_cGrp)
1705:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
1706:             ENDIF
1707:             IF USED("cursor_4c_CtaTmp")
1708:                 USE IN cursor_4c_CtaTmp
1709:             ENDIF
1710:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
1711:             IF loc_nResultado >= 1
1712:                 SELECT cursor_4c_CtaTmp
1713:                 IF !EOF("cursor_4c_CtaTmp")
1714:                     THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_CtaTmp.IClis, ""))
1715:                     THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_CtaTmp.RClis, ""))
1716:                     THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_CtaTmp.Cpfs, ""))
1717:                     USE IN cursor_4c_CtaTmp
1718:                     RETURN
1719:                 ENDIF
1720:                 USE IN cursor_4c_CtaTmp
1721:             ENDIF
1722:             THIS.AbrirBuscaConta("C", loc_cGrp, loc_cCta)
1723:         CATCH TO loc_oErro
1724:             MsgErro(loc_oErro.Message, "Erro ValidarCdConta")
1725:         ENDTRY
1726:     ENDPROC
1727: 

*-- Linhas 1741 a 1769:
1741:             RETURN
1742:         ENDIF
1743:         TRY
1744:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1745:                 EscaparSQL(loc_cDs + "%")
1746:             IF !EMPTY(loc_cGrp)
1747:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
1748:             ENDIF
1749:             IF USED("cursor_4c_CtaTmp")
1750:                 USE IN cursor_4c_CtaTmp
1751:             ENDIF
1752:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
1753:             IF loc_nResultado >= 1
1754:                 SELECT cursor_4c_CtaTmp
1755:                 IF !EOF("cursor_4c_CtaTmp")
1756:                     THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_CtaTmp.IClis, ""))
1757:                     THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_CtaTmp.RClis, ""))
1758:                     THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_CtaTmp.Cpfs, ""))
1759:                     USE IN cursor_4c_CtaTmp
1760:                     RETURN
1761:                 ENDIF
1762:                 USE IN cursor_4c_CtaTmp
1763:             ENDIF
1764:             THIS.AbrirBuscaConta("D", loc_cGrp, loc_cDs)
1765:         CATCH TO loc_oErro
1766:             MsgErro(loc_oErro.Message, "Erro ValidarDsConta")
1767:         ENDTRY
1768:     ENDPROC
1769: 

*-- Linhas 1821 a 1849:
1821:             RETURN
1822:         ENDIF
1823:         TRY
1824:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1825:                 EscaparSQL(PADR(loc_cCod, 10))
1826:             IF !EMPTY(loc_cGrpPad)
1827:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrpPad, 10))
1828:             ENDIF
1829:             IF USED("cursor_4c_RespTmp")
1830:                 USE IN cursor_4c_RespTmp
1831:             ENDIF
1832:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespTmp")
1833:             IF loc_nResultado >= 1
1834:                 SELECT cursor_4c_RespTmp
1835:                 IF !EOF("cursor_4c_RespTmp")
1836:                     THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_RespTmp.IClis, ""))
1837:                     THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_RespTmp.RClis, ""))
1838:                     USE IN cursor_4c_RespTmp
1839:                     RETURN
1840:                 ENDIF
1841:                 USE IN cursor_4c_RespTmp
1842:             ENDIF
1843:             THIS.AbrirBuscaResponsavel("C", loc_cCod)
1844:         CATCH TO loc_oErro
1845:             MsgErro(loc_oErro.Message, "Erro ValidarCdResps")
1846:         ENDTRY
1847:     ENDPROC
1848: 
1849:     *===========================================================================

*-- Linhas 1863 a 1891:
1863:             RETURN
1864:         ENDIF
1865:         TRY
1866:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1867:                 EscaparSQL(loc_cDs + "%")
1868:             IF !EMPTY(loc_cGrpPad)
1869:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrpPad, 10))
1870:             ENDIF
1871:             IF USED("cursor_4c_RespTmp")
1872:                 USE IN cursor_4c_RespTmp
1873:             ENDIF
1874:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespTmp")
1875:             IF loc_nResultado >= 1
1876:                 SELECT cursor_4c_RespTmp
1877:                 IF !EOF("cursor_4c_RespTmp")
1878:                     THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_RespTmp.IClis, ""))
1879:                     THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_RespTmp.RClis, ""))
1880:                     USE IN cursor_4c_RespTmp
1881:                     RETURN
1882:                 ENDIF
1883:                 USE IN cursor_4c_RespTmp
1884:             ENDIF
1885:             THIS.AbrirBuscaResponsavel("D", loc_cDs)
1886:         CATCH TO loc_oErro
1887:             MsgErro(loc_oErro.Message, "Erro ValidarDsResps")
1888:         ENDTRY
1889:     ENDPROC
1890: 
1891:     *===========================================================================

*-- Linhas 1903 a 1927:
1903:             RETURN
1904:         ENDIF
1905:         TRY
1906:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cCod)
1907:             IF USED("cursor_4c_MoeTmp")
1908:                 USE IN cursor_4c_MoeTmp
1909:             ENDIF
1910:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeTmp")
1911:             IF loc_nResultado >= 1
1912:                 SELECT cursor_4c_MoeTmp
1913:                 IF !EOF("cursor_4c_MoeTmp")
1914:                     THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.CMoes, ""))
1915:                     THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.DMoes, ""))
1916:                     USE IN cursor_4c_MoeTmp
1917:                     RETURN
1918:                 ENDIF
1919:                 USE IN cursor_4c_MoeTmp
1920:             ENDIF
1921:             THIS.AbrirBuscaMoeda("C", loc_cCod)
1922:         CATCH TO loc_oErro
1923:             MsgErro(loc_oErro.Message, "Erro ValidarCdMoeda")
1924:         ENDTRY
1925:     ENDPROC
1926: 
1927:     *===========================================================================

*-- Linhas 1939 a 1964:
1939:             RETURN
1940:         ENDIF
1941:         TRY
1942:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE RTRIM(DMoes) LIKE " + ;
1943:                 EscaparSQL(loc_cDs + "%")
1944:             IF USED("cursor_4c_MoeTmp")
1945:                 USE IN cursor_4c_MoeTmp
1946:             ENDIF
1947:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeTmp")
1948:             IF loc_nResultado >= 1
1949:                 SELECT cursor_4c_MoeTmp
1950:                 IF !EOF("cursor_4c_MoeTmp")
1951:                     THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.CMoes, ""))
1952:                     THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.DMoes, ""))
1953:                     USE IN cursor_4c_MoeTmp
1954:                     RETURN
1955:                 ENDIF
1956:                 USE IN cursor_4c_MoeTmp
1957:             ENDIF
1958:             THIS.AbrirBuscaMoeda("D", loc_cDs)
1959:         CATCH TO loc_oErro
1960:             MsgErro(loc_oErro.Message, "Erro ValidarDsMoeda")
1961:         ENDTRY
1962:     ENDPROC
1963: 
1964:     *===========================================================================


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de BusinessBase
* Form OPERACIONAL - consulta/filtro de movimentacoes em SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Empresa
    this_cEmpresa      = ""
    this_cDsEmpresa    = ""
    this_nEmpD         = 0

    *-- Operacao / Movimentacao
    this_cNmOperacao   = ""
    this_nNumero       = 0
    this_nOp           = 0

    *-- Periodo
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nPeriodo      = 1

    *-- Grupo contabil
    this_cGrupo        = ""
    this_cDsGrupo      = ""

    *-- Conta
    this_cConta        = ""
    this_cDsConta      = ""

    *-- CPF/CNPJ
    this_cCpf          = ""

    *-- Responsavel / Vendedor
    this_cResps        = ""
    this_cDsResps      = ""

    *-- Moeda
    this_cMoeda        = ""
    this_cDsMoeda      = ""

    *-- Opcoes de filtro
    this_nSituacao     = 3
    this_nImpressao    = 1
    this_nCotacao      = 1
    this_cStatus       = ""

    *-- Grupo padrao de vendedores (SigCdPam.grpadvens) - carregado em Init
    this_cGrPadVens    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.CarregarGrPadVens()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrPadVens - Carrega o grupo padrao de vendedores de SigCdPam
    * Necessario para validacao de Responsavel via fAcessoContab
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrPadVens()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens AS GrPadVens FROM SigCdPam"

            IF USED("cursor_4c_ParamPam")
                USE IN cursor_4c_ParamPam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamPam")

            IF loc_nResultado >= 1
                SELECT cursor_4c_ParamPam
                GO TOP
                IF !EOF("cursor_4c_ParamPam")
                    THIS.this_cGrPadVens = NVL(cursor_4c_ParamPam.GrPadVens, "")
                    loc_lResultado = .T.
                ENDIF
                USE IN cursor_4c_ParamPam
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de executar consulta
    * Retorna .T. se valido; popula this_cMensagemErro se invalido
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cNmOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                    "Data Final Menor do Que a Inicial!!!"
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - Executa a consulta principal contra SigMvCab
    * Cria cursor csTemporario com resultados indexados
    * Retorna .T. se encontrou registros, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ExecutarConsulta()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResultado
        LOCAL loc_cEmp, loc_cNmO, loc_cGrupo, loc_cConta, loc_cResps, loc_cSta
        LOCAL loc_nEmpD, loc_nNrP, loc_nPen, loc_nOp, loc_nNum
        LOCAL loc_dDtI, loc_dDtF, loc_cDtISQL, loc_cDtFSQL, loc_cEmpFilter

        loc_lResultado = .F.

        TRY
            loc_cEmp    = ALLTRIM(THIS.this_cEmpresa)
            loc_cNmO    = ALLTRIM(THIS.this_cNmOperacao)
            loc_cGrupo  = ALLTRIM(THIS.this_cGrupo)
            loc_cConta  = ALLTRIM(THIS.this_cConta)
            loc_cResps  = ALLTRIM(THIS.this_cResps)
            loc_cSta    = ALLTRIM(THIS.this_cStatus)
            loc_nEmpD   = THIS.this_nEmpD
            loc_nNrP    = THIS.this_nPeriodo
            loc_nPen    = THIS.this_nSituacao
            loc_nOp     = THIS.this_nOp
            loc_nNum    = THIS.this_nNumero
            loc_dDtI    = THIS.this_dDtInicial
            loc_dDtF    = THIS.this_dDtFinal

            *-- Formata datas para SQL Server (com componente de hora)
            loc_cDtISQL = "'" + PADL(YEAR(loc_dDtI), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtI), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtI), 2, "0") + " 00:00:00'"
            loc_cDtFSQL = "'" + PADL(YEAR(loc_dDtF), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF), 2, "0") + " 23:59:59'"

            *-- Monta WHERE replicando logica de consulta.Click do legado
            loc_cWhere = ""

            IF !EMPTY(loc_cNmO)
                loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(loc_cNmO) + " And "
            ENDIF

            IF loc_nNrP = 1
                loc_cWhere = loc_cWhere + "a.Datas "
            ELSE
                loc_cWhere = loc_cWhere + "a.PrazoEnts "
            ENDIF
            loc_cWhere = loc_cWhere + "BetWeen " + loc_cDtISQL + " And " + loc_cDtFSQL + " And "

            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
                    " Or a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ") And "
            ENDIF

            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(loc_cConta) + ;
                    " Or a.ContaDs = " + EscaparSQL(loc_cConta) + ") And "
            ENDIF

            IF loc_nOp > 0
                loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(loc_nOp, 0) + " And "
            ENDIF

            IF loc_nNum > 0
                loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(loc_nNum, 0) + " And "
            ENDIF

            IF !EMPTY(loc_cResps)
                loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(loc_cResps) + " And "
            ENDIF

            DO CASE
                CASE loc_nPen = 1
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
                CASE loc_nPen = 2
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
            ENDCASE

            IF !EMPTY(loc_cSta)
                loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(loc_cSta) + " And "
            ENDIF

            *-- Filtro de empresa (com empresa destino opcional)
            loc_cEmpFilter = "(a.Emps = " + EscaparSQL(loc_cEmp)
            IF loc_nEmpD != 0
                loc_cEmpFilter = loc_cEmpFilter + " Or a.Empds = " + EscaparSQL(loc_cEmp)
            ENDIF
            loc_cEmpFilter = loc_cEmpFilter + ")"

            loc_cSQL = "Select a.* " + ;
                "From SigMvCab a, SigCdOpe b " + ;
                "Where " + loc_cEmpFilter + " And " + ;
                loc_cWhere + ;
                "a.Dopes = b.Dopes"

            IF USED("csTemporario")
                USE IN csTemporario
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "csTemporario")

            IF loc_nResultado >= 1
                SELECT csTemporario
                IF RECCOUNT("csTemporario") > 0
                    INDEX ON EmpDopNums TAG EmpDopNums
                    *-- Corrige PrazoEnts NULL (replica Update Set PrazoEnts = Iif(IsNull,Ctod(''),PrazoEnts))
                    REPLACE ALL prazoents WITH IIF(ISNULL(prazoents), CTOD(""), prazoents) IN csTemporario
                    GO TOP IN csTemporario
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum Registro Selecionado!!!"
                    USE IN csTemporario
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao executar consulta (csTemporario)"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCpfPorConta - Carrega CPF do cliente pelo codigo da conta (iclis)
    * Retorna o CPF (string) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarCpfPorConta(par_cConta)
        LOCAL loc_cCpf, loc_cSQL, loc_nResultado
        loc_cCpf = ""

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN ""
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Cpfs FROM SigCdCli " + ;
                "WHERE iClis = " + EscaparSQL(PADR(ALLTRIM(par_cConta), 10))

            IF USED("cursor_4c_CpfCli")
                USE IN cursor_4c_CpfCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfCli")

            IF loc_nResultado >= 1
                SELECT cursor_4c_CpfCli
                IF !EOF("cursor_4c_CpfCli")
                    loc_cCpf = NVL(cursor_4c_CpfCli.Cpfs, "")
                ENDIF
                USE IN cursor_4c_CpfCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cCpf
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCpfCnpj - Valida CPF/CNPJ e localiza conta vinculada em SigCdCli
    * Retorna objeto Empty com: lValido, cConta, cDsConta, cCpf, cErro
    * Replica logica de Get_cpf.Valid do legado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCpfCnpj(par_cCpfCnpj)
        LOCAL loc_oRet, loc_cCgc, loc_cCgc1, loc_nLen, loc_nVerCpfCgc, loc_nResultado

        loc_oRet = CREATEOBJECT("Empty")
        ADDPROPERTY(loc_oRet, "lValido",  .F.)
        ADDPROPERTY(loc_oRet, "cConta",   "")
        ADDPROPERTY(loc_oRet, "cDsConta", "")
        ADDPROPERTY(loc_oRet, "cCpf",     "")
        ADDPROPERTY(loc_oRet, "cErro",    "")

        IF EMPTY(ALLTRIM(par_cCpfCnpj))
            loc_oRet.lValido = .T.
            RETURN loc_oRet
        ENDIF

        loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(par_cCpfCnpj), ".", ""), "-", ""), "/", "")
        loc_nLen = LEN(ALLTRIM(loc_cCgc))
        loc_nVerCpfCgc = 0

        IF loc_nLen <> 14
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 999.999.999-99")
            IF loc_nLen = 11
                loc_nVerCpfCgc = IIF(ValidarCPF(loc_cCgc1), 1, 2)
            ENDIF
        ELSE
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99")
            loc_nVerCpfCgc = IIF(ValidarCNPJ(loc_cCgc1), 1, 2)
        ENDIF

        IF loc_nVerCpfCgc = 2
            loc_oRet.cErro = "CPF / CGC Incorreto !!!"
            RETURN loc_oRet
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 iclis, rclis, cpfs FROM SigCdCli " + ;
                "WHERE cpfs = " + EscaparSQL(PADR(ALLTRIM(loc_cCgc1), 20))

            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")

            IF loc_nResultado >= 1
                SELECT cursor_4c_BuscaCpf
                IF !EOF("cursor_4c_BuscaCpf")
                    loc_oRet.cConta   = NVL(cursor_4c_BuscaCpf.iclis, "")
                    loc_oRet.cDsConta = NVL(cursor_4c_BuscaCpf.rclis, "")
                    loc_oRet.cCpf     = NVL(cursor_4c_BuscaCpf.cpfs, "")
                    loc_oRet.lValido  = .T.
                ELSE
                    IF loc_nVerCpfCgc = 1
                        loc_oRet.cErro = "CPF / CGC n" + CHR(227) + "o encontrado !!!"
                    ELSE
                        loc_oRet.lValido = .T.
                    ENDIF
                ENDIF
                USE IN cursor_4c_BuscaCpf
            ELSE
                loc_oRet.cErro = "Falha ao buscar CPF/CGC em SigCdCli"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oRet.cErro = loc_oErro.Message
        ENDTRY

        RETURN loc_oRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de SigMvCab (Emps + Dopes + Nums)
    * Usada em RegistrarAuditoria para log de consulta/operacoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpresa) + "|" + ;
               ALLTRIM(THIS.this_cNmOperacao) + "|" + ;
               ALLTRIM(TRANSFORM(THIS.this_nNumero))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega chave e campos principais de SigMvCab
    * a partir da linha corrente do cursor (usado quando usuario seleciona
    * uma movimentacao no grid de resultados de ExecutarConsulta)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cEmpresa    = TratarNulo(emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".empds") != "U"
                THIS.this_nEmpD       = IIF(NVL(empds, "") != THIS.this_cEmpresa AND !EMPTY(NVL(empds, "")), 1, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = TratarNulo(dopes, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp         = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero     = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupos") != "U"
                THIS.this_cGrupo      = TratarNulo(grupos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".iclis") != "U"
                THIS.this_cConta      = TratarNulo(iclis, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps      = TratarNulo(vends, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial  = TratarNulo(datas, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".prazoents") != "U"
                THIS.this_dDtFinal    = TratarNulo(prazoents, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cStatus     = TratarNulo(pstatus, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                THIS.this_nSituacao   = IIF(NVL(chksubn, .F.), 2, 1)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEs1BO.CarregarDoCursor")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a form OPERACIONAL de consulta
    * SigPrEs1 (Posicao Por Movimentacao) apenas LE registros de SigMvCab
    * atraves de ExecutarConsulta. Inclusao de movimentacoes ocorre nos
    * forms de entrada de operacao (SigMvCab tem forms proprios de CRUD).
    * Metodo mantido para conformidade com contrato BusinessBase; sempre
    * retorna .F. com mensagem clara para prevenir uso indevido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para incluir movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a form OPERACIONAL de consulta
    * Mesma razao de Inserir(): SigPrEs1 apenas consulta SigMvCab.
    * Atualizacoes ocorrem nos forms de operacao correspondentes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para atualizar movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra em LogAuditoria a consulta executada
    * Sobrescreve BusinessBase para logar operacao "CONSULTA" com filtros
    * aplicados (empresa, operacao, periodo). DataHora usa GETDATE() (regra
    * canonica - GETDATE() rejeita tipo T).
    *--------------------------------------------------------------------------
    FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cUsuario, loc_cDetalhes
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                              ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")
            loc_cChave = THIS.ObterChavePrimaria()

            loc_cDetalhes = "Empresa=" + ALLTRIM(THIS.this_cEmpresa) + ;
                "; Operacao=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                "; Periodo=" + DTOC(THIS.this_dDtInicial) + ".." + DTOC(THIS.this_dDtFinal)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
                "VALUES (" + ;
                EscaparSQL("SigPrEs1") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(loc_cDetalhes) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe operacao principal
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

