# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 3407: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbv.prg) - TRECHOS RELEVANTES PARA PASS GRID (4203 linhas total):

*-- Linhas 4 a 22:
4: * Legado: SIGCDTBV.SCX (frmcadastro)
5: *
6: * FASE 10 - Sub-pagina "Descontos / Comissoes" (pgDesconto) completa:
7: * grd_4c_Gradei (composicao/formula), grd_4c_Gradec (comissoes),
8: * cnt_4c_Formula1/2, Desconto Maximo, Combo_Comis, DescFats/FatorPads,
9: * Ignora Cotacao. Ver tambem ConfigurarPgPgConfDesconto ("Configuracao
10: * de Desconto") e TbvBO (Carregar/SalvarComposicaoDesconto,
11: * Carregar/SalvarComissoesDesconto, Carregar/SalvarFaixasDesconto).
12: *==============================================================================
13: 
14: DEFINE CLASS FormTbv AS FormBase
15: 
16:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
17:     Height       = 600
18:     Width        = 1000
19:     Caption      = "Tabelas de Descontos"
20:     AutoCenter   = .T.
21:     ShowWindow   = 1
22:     WindowType   = 1

*-- Linhas 337 a 360:
337:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
338: 
339:         *-- Grid de lista (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
340:         *-- RecordSource/ColumnCount definidos aqui (fora de WITH) para evitar
341:         *-- "Unknown member COLUMN1" - colunas configuradas de fato em CarregarLista()
342:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
343:         loc_oGrid = loc_oPagina.grd_4c_Lista
344:         loc_oGrid.RecordSource = ""
345:         loc_oGrid.ColumnCount  = 4
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 880
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)
354:             .BackColor          = RGB(255, 255, 255)
355:             .DeleteMark         = .F.
356:             .RecordMark         = .F.
357:             .GridLines          = 3
358:             .GridLineColor      = RGB(238, 238, 238)
359:             .HighlightStyle     = 2
360:             .HighlightBackColor = RGB(255, 255, 255)

*-- Linhas 384 a 431:
384:                 IF USED("cursor_4c_Dados")
385:                     USE IN cursor_4c_Dados
386:                 ENDIF
387:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(30), moerefs C(3), descos N(5,2))
388:                 INSERT INTO cursor_4c_Dados VALUES ("0000000001", "Tabela Teste", "REA", 0)
389:                 SET DATASESSION TO (loc_nDsAtual)
390:                 loc_lResultado = .T.
391:             ELSE
392:                 IF THIS.this_oBusinessObject.Buscar("")
393:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
394: 
395:                     loc_oGrid.ColumnCount   = 4
396:                     loc_oGrid.RecordSource  = "cursor_4c_Dados"
397: 
398:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
399:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
400:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.moerefs"
401:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descos"
402: 
403:                     loc_oGrid.Column1.Width         = 110
404:                     loc_oGrid.Column2.Width         = 480
405:                     loc_oGrid.Column3.Width         = 100
406:                     loc_oGrid.Column4.Width         = 130
407: 
408:                     loc_oGrid.Column1.ReadOnly      = .T.
409:                     loc_oGrid.Column2.ReadOnly      = .T.
410:                     loc_oGrid.Column3.ReadOnly      = .T.
411:                     loc_oGrid.Column4.ReadOnly      = .T.
412: 
413:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
414:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
415:                     loc_oGrid.Column3.Header1.Caption = "Moeda Ref" + CHR(234) + "ncia"
416:                     loc_oGrid.Column4.Header1.Caption = "Desconto (%)"
417: 
418:                     THIS.FormatarGridLista(loc_oGrid)
419:                     loc_lResultado = .T.
420:                 ENDIF
421:             ENDIF
422:         CATCH TO loException
423:             MostrarErro(loException, "FormTbv.CarregarLista")
424:             loc_lResultado = .F.
425:         ENDTRY
426: 
427:         RETURN loc_lResultado
428:     ENDPROC
429: 
430:     *--------------------------------------------------------------------------
431:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)

*-- Linhas 1199 a 1217:
1199:             .Style          = 2
1200:             .RowSourceType  = 6
1201:             .RowSource      = "cursor_4c_TipoDesconto.Descrs,cursor_4c_TipoDesconto.Ordem"
1202:             .ColumnCount    = 2
1203:             .ColumnWidths   = "205,0"
1204:             .BoundColumn    = 2
1205:             .Value          = 0
1206:             .ToolTipText    = "Usado Para diversas tabelas para um mesmo item"
1207:             .FontName       = "Tahoma"
1208:             .FontSize       = 8
1209:             .Visible        = .T.
1210:         ENDWITH
1211:         BINDEVENT(loc_oPagina.cbo_4c_CmbTpDesc, "InteractiveChange", THIS, "TipoDescontoInteractiveChange")
1212: 
1213:         *----------------------------------------------------------------------
1214:         * Container1 / GrdEmp - Lista de empresas para tipo de desconto 11
1215:         * (Desconto Gerente-Extra/loja) - this_cListaEmpresas / listaemp memo
1216:         * Legado: Container1 (top=354,left=608,width=289,height=97), visivel apenas
1217:         * quando cmbTpDesc = 11 (ThisForm...container1.visible = tpdesc=11)

*-- Linhas 1228 a 1288:
1228:             .Visible   = .F.
1229:         ENDWITH
1230: 
1231:         loc_oPagina.cnt_4c_Container1.AddObject("grd_4c_Empresas", "Grid")
1232:         loc_oGridEmp = loc_oPagina.cnt_4c_Container1.grd_4c_Empresas
1233:         loc_oGridEmp.RecordSource = ""
1234:         loc_oGridEmp.ColumnCount  = 2
1235:         WITH loc_oGridEmp
1236:             .Top          = 3
1237:             .Left         = 6
1238:             .Width        = 228
1239:             .Height       = 90
1240:             .FontName     = "Verdana"
1241:             .FontSize     = 8
1242:             .DeleteMark   = .F.
1243:             .RecordMark   = .F.
1244:             .GridLines    = 3
1245:             .HeaderHeight = 0
1246:             .RowHeight    = 18
1247:             .ScrollBars   = 2
1248:             .Visible      = .T.
1249:         ENDWITH
1250: 
1251:         WITH loc_oGridEmp.Column1
1252:             .Width    = 30
1253:             .Sparse   = .F.
1254:             .ReadOnly = .F.
1255:         ENDWITH
1256:         loc_oGridEmp.Column1.Header1.Caption = ""
1257:         loc_oGridEmp.Column1.AddObject("chk_4c_Marca", "CheckBox")
1258:         WITH loc_oGridEmp.Column1.chk_4c_Marca
1259:             .Caption   = ""
1260:             .Alignment = 0
1261:             .Visible   = .T.
1262:             .Top       = 2
1263:             .Left      = 6
1264:             .Height    = 17
1265:             .Width     = 18
1266:         ENDWITH
1267:         loc_oGridEmp.Column1.CurrentControl = "chk_4c_Marca"
1268: 
1269:         WITH loc_oGridEmp.Column2
1270:             .Width    = 190
1271:             .ReadOnly = .T.
1272:         ENDWITH
1273:         loc_oGridEmp.Column2.Header1.Caption = "Empresa"
1274: 
1275:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseDown", THIS, "EmpresaCheckboxMouseDown")
1276:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseUp",   THIS, "EmpresaCheckboxMouseUp")
1277:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "Click",     THIS, "EmpresaCheckboxClick")
1278:         BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "KeyPress",  THIS, "EmpresaCheckboxKeyPress")
1279: 
1280:         loc_oPagina.cnt_4c_Container1.AddObject("cmd_4c_Command1", "CommandButton")
1281:         WITH loc_oPagina.cnt_4c_Container1.cmd_4c_Command1
1282:             .Caption     = ""
1283:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1284:             .ToolTipText = "Desmarcar"
1285:             .Top         = 48
1286:             .Left        = 239
1287:             .Width       = 45
1288:             .Height      = 45

*-- Linhas 1336 a 1360:
1336:     * ConfigurarPgPgConfDesconto - Controles da 3a sub-pagina do legado
1337:     * ("Configuracao de Desconto" - SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto)
1338:     *
1339:     * Grade mestre (grd_4c_GradeI) espelha as linhas de SigOpTdt (tipo/codigo/
1340:     * tipo de desconto progressivo) cadastradas via grd_4c_Gradei da aba
1341:     * "Descontos / Comissoes" (ConfigurarPgPgDesconto - MESMA cursor_4c_Tdt).
1342:     * Colunas Tipo/Codigo sao SOMENTE LEITURA aqui (legado: Column1/2.When
1343:     * sempre Return(.f.)); apenas a coluna "Tipos Desconto" e editavel.
1344:     *
1345:     * Grade de detalhe (grd_4c_GradeD) mostra/edita as faixas (SigOpTds) da
1346:     * combinacao tipo+codigo+tipoDesconto selecionada na grade mestre,
1347:     * reconfigurando colunas conforme MontarConfiguracaoDesconto() (equiva-
1348:     * lente ao "MontaTbDes" do legado).
1349:     *--------------------------------------------------------------------------
1350:     PROTECTED PROCEDURE ConfigurarPgPgConfDesconto()
1351:         LOCAL loc_oPg, loc_oGradei, loc_oGradeD
1352: 
1353:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1354: 
1355:         *-- Registros excluidos da grade de faixas (BtnExcluirFaixaDescontoClick)
1356:         *-- nao devem reaparecer - DataSession=2 (privado) isola este SET do
1357:         *-- resto do sistema (CLAUDE.md #9.4)
1358:         SET DELETED ON
1359: 
1360:         THIS.CriarCursorDiaSemana()

*-- Linhas 1430 a 1636:
1430:         ENDWITH
1431: 
1432:         *----------------------------------------------------------------------
1433:         * grd_4c_GradeI - grade mestre (espelha SigOpTdt), Tipo/Codigo
1434:         * somente leitura, Tipos Desconto editavel (dispara reconfiguracao
1435:         * da grade de faixas)
1436:         *----------------------------------------------------------------------
1437:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeI", "Grid")
1438:         loc_oGradei = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeI
1439:         loc_oGradei.RecordSource = ""
1440:         loc_oGradei.ColumnCount  = 3
1441:         WITH loc_oGradei
1442:             .Top       = 10
1443:             .Left      = 122
1444:             .Width     = 314
1445:             .Height    = 439
1446:             .FontName  = "Verdana"
1447:             .FontSize  = 8
1448:             .RowHeight = 20
1449:             .ForeColor = RGB(36, 84, 155)
1450:             .Visible   = .T.
1451:         ENDWITH
1452: 
1453:         WITH loc_oGradei.Column1
1454:             .Width              = 80
1455:             .Header1.Caption    = "Tipo"
1456:             .Header1.Alignment  = 2
1457:             .Header1.FontName   = "Verdana"
1458:             .Header1.FontSize   = 8
1459:             .ReadOnly           = .T.
1460:         ENDWITH
1461:         loc_oGradei.Column1.AddObject("cbo_4c_GiTipo", "ComboBox")
1462:         WITH loc_oGradei.Column1.cbo_4c_GiTipo
1463:             .Top             = 27
1464:             .Left            = 4
1465:             .SpecialEffect   = 1
1466:             .RowSourceType   = 1
1467:             .RowSource       = "Grupo,Linha,Gr Venda,Produto,Moeda,Unidade,Feitio,SubGrupo,Finalidade"
1468:             .Style           = 2
1469:             .ForeColor       = RGB(36, 84, 155)
1470:             .BackColor       = RGB(255, 255, 255)
1471:             .ItemBackColor   = RGB(255, 255, 128)
1472:         ENDWITH
1473:         loc_oGradei.Column1.CurrentControl = "cbo_4c_GiTipo"
1474: 
1475:         WITH loc_oGradei.Column2
1476:             .Width              = 80
1477:             .Header1.Caption    = "C" + CHR(243) + "digo "
1478:             .Header1.Alignment  = 2
1479:             .Header1.FontName   = "Verdana"
1480:             .Header1.FontSize   = 8
1481:             .Text1.BorderStyle  = 0
1482:             .Text1.Margin       = 2
1483:             .Text1.ForeColor    = RGB(36, 84, 155)
1484:             .Text1.BackColor    = RGB(255, 255, 255)
1485:             .ReadOnly           = .T.
1486:         ENDWITH
1487: 
1488:         WITH loc_oGradei.Column3
1489:             .Width              = 121
1490:             .Header1.Caption    = "Tipos Desconto"
1491:             .Header1.Alignment  = 2
1492:             .Header1.FontName   = "Verdana"
1493:             .Header1.FontSize   = 8
1494:         ENDWITH
1495:         loc_oGradei.Column3.AddObject("cbo_4c_GiTipoDs", "ComboBox")
1496:         WITH loc_oGradei.Column3.cbo_4c_GiTipoDs
1497:             .Top             = 30
1498:             .Left            = 15
1499:             .SpecialEffect   = 1
1500:             .RowSourceType   = 1
1501:             .RowSource       = "Nenhum,Dia da Semana,Dia do Mes,Hor" + CHR(225) + "rio,Data"
1502:             .Style           = 2
1503:             .ForeColor       = RGB(36, 84, 155)
1504:             .ItemBackColor   = RGB(255, 255, 128)
1505:         ENDWITH
1506:         loc_oGradei.Column3.CurrentControl = "cbo_4c_GiTipoDs"
1507: 
1508:         BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiConfAfterRowColChange")
1509:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "When", THIS, "GradeiConfColumn3When")
1510:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "LostFocus", THIS, "GradeiConfColumn3Valid")
1511:         BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "KeyPress", THIS, "GradeiConfColumn3LostFocus")
1512: 
1513:         *----------------------------------------------------------------------
1514:         * grd_4c_GradeD - grade de detalhe (espelha SigOpTds da combinacao
1515:         * selecionada em grd_4c_GradeI). Colunas 1/2 (Inicial/Final) tem
1516:         * ControlSource/InputMask reconfigurados dinamicamente por
1517:         * MontarConfiguracaoDesconto() conforme o Tipo de Desconto (dia da
1518:         * semana/dia do mes/horario/data). Colunas 3/4 sao a faixa de
1519:         * horario dentro do dia (sempre Campo2is/Campo2fs); 5/6 sao
1520:         * Preco/Fator.
1521:         *----------------------------------------------------------------------
1522:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeD", "Grid")
1523:         loc_oGradeD = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeD
1524:         loc_oGradeD.RecordSource = ""
1525:         loc_oGradeD.ColumnCount  = 6
1526:         WITH loc_oGradeD
1527:             .Top        = 26
1528:             .Left       = 462
1529:             .Width      = 358
1530:             .Height     = 419
1531:             .FontName   = "Verdana"
1532:             .FontSize   = 8
1533:             .RowHeight  = 20
1534:             .RecordMark = .F.
1535:             .ForeColor  = RGB(36, 84, 155)
1536:             .Enabled    = .F.
1537:             .Visible    = .T.
1538:         ENDWITH
1539: 
1540:         WITH loc_oGradeD.Column1
1541:             .Width             = 79
1542:             .Header1.Caption   = "Inicial"
1543:             .Header1.Alignment = 2
1544:             .Header1.FontName  = "Verdana"
1545:             .Header1.FontSize  = 8
1546:             .Text1.Top         = 32
1547:             .Text1.Height      = 23
1548:             .Text1.Margin      = 2
1549:             .Text1.ForeColor   = RGB(36, 84, 155)
1550:         ENDWITH
1551:         BINDEVENT(loc_oGradeD.Column1.Text1, "When", THIS, "GradeDColumn1When")
1552:         BINDEVENT(loc_oGradeD.Column1.Text1, "Valid", THIS, "GradeDColumn1Valid")
1553: 
1554:         WITH loc_oGradeD.Column2
1555:             .Width             = 79
1556:             .Header1.Caption   = "Final"
1557:             .Header1.Alignment = 2
1558:             .Header1.FontName  = "Verdana"
1559:             .Header1.FontSize  = 8
1560:             .Text1.BorderStyle = 0
1561:             .Text1.Margin      = 2
1562:             .Text1.ForeColor   = RGB(36, 84, 155)
1563:         ENDWITH
1564:         BINDEVENT(loc_oGradeD.Column2.Text1, "When", THIS, "GradeDColumn2When")
1565:         BINDEVENT(loc_oGradeD.Column2.Text1, "Valid", THIS, "GradeDColumn2Valid")
1566: 
1567:         WITH loc_oGradeD.Column3
1568:             .Width             = 40
1569:             .Header1.Caption   = "Inicial"
1570:             .Header1.Alignment = 2
1571:             .Header1.FontName  = "Verdana"
1572:             .Header1.FontSize  = 8
1573:             .ControlSource     = "cursor_4c_Tds.Campo2is"
1574:             .Format            = "R"
1575:             .InputMask         = "99:99"
1576:             .Text1.InputMask   = "99:99"
1577:         ENDWITH
1578:         BINDEVENT(loc_oGradeD.Column3.Text1, "When", THIS, "GradeDColumn3When")
1579:         BINDEVENT(loc_oGradeD.Column3.Text1, "Valid", THIS, "GradeDColumn3Valid")
1580: 
1581:         WITH loc_oGradeD.Column4
1582:             .Width             = 40
1583:             .Header1.Caption   = "Final"
1584:             .Header1.Alignment = 2
1585:             .Header1.FontName  = "Verdana"
1586:             .Header1.FontSize  = 8
1587:             .ControlSource     = "cursor_4c_Tds.Campo2fs"
1588:             .Format            = "R"
1589:             .InputMask         = "99:99"
1590:             .Text1.InputMask   = "99:99"
1591:         ENDWITH
1592:         BINDEVENT(loc_oGradeD.Column4.Text1, "When", THIS, "GradeDColumn4When")
1593:         BINDEVENT(loc_oGradeD.Column4.Text1, "Valid", THIS, "GradeDColumn4Valid")
1594: 
1595:         WITH loc_oGradeD.Column5
1596:             .Width             = 48
1597:             .Header1.Caption   = "Pre" + CHR(231) + "o"
1598:             .Header1.Alignment = 2
1599:             .Header1.FontName  = "Verdana"
1600:             .Header1.FontSize  = 8
1601:             .ControlSource     = "cursor_4c_Tds.descos"
1602:             .InputMask         = "999.99"
1603:             .Text1.InputMask   = "999.99"
1604:         ENDWITH
1605:         BINDEVENT(loc_oGradeD.Column5.Text1, "When", THIS, "GradeDColumn5When")
1606: 
1607:         WITH loc_oGradeD.Column6
1608:             .Width             = 46
1609:             .Header1.Caption   = "Fator"
1610:             .Header1.Alignment = 2
1611:             .Header1.FontName  = "Verdana"
1612:             .Header1.FontSize  = 8
1613:             .ControlSource     = "cursor_4c_Tds.dfators"
1614:             .InputMask         = "999.99"
1615:             .Text1.InputMask   = "999.99"
1616:         ENDWITH
1617:         BINDEVENT(loc_oGradeD.Column6.Text1, "When", THIS, "GradeDColumn5When")
1618:         BINDEVENT(loc_oGradeD.Column6.Text1, "Valid", THIS, "GradeDColumn6Valid")
1619: 
1620:         *----------------------------------------------------------------------
1621:         * cmdExcluir - remove a faixa corrente de grd_4c_GradeD
1622:         *----------------------------------------------------------------------
1623:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("cmd_4c_CmdExcluir", "CommandButton")
1624:         WITH loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir
1625:             .Caption         = ""
1626:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1627:             .ToolTipText     = "Excluir"
1628:             .PicturePosition = 1
1629:             .Top             = 203
1630:             .Left            = 832
1631:             .Width           = 45
1632:             .Height          = 45
1633:             .BackColor       = RGB(255, 255, 255)
1634:             .ForeColor       = RGB(36, 84, 155)
1635:             .FontName        = "Verdana"
1636:             .FontSize        = 8

*-- Linhas 1644 a 1838:
1644:     * ConfigurarPgPgDesconto - Controles da 2a sub-pagina do legado
1645:     * ("Descontos / Comissoes" - SIGCDTBV.Pagina.Dados.Page1.pgDesconto)
1646:     *
1647:     * grd_4c_Gradei (8 colunas) e a grade MESTRE editavel de composicao/
1648:     * formula (SigOpTdt via cursor_4c_Tdt) - inclui/altera/exclui linhas
1649:     * (Tipo/Codigo/Valor/Fator/Exclui/Faixa/Inicial/Final). E a MESMA
1650:     * cursor_4c_Tdt usada (somente leitura) por grd_4c_GradeI da pagina
1651:     * "Configuracao de Desconto" (ConfigurarPgPgConfDesconto).
1652:     *
1653:     * grd_4c_Gradec (6 colunas) mostra as comissoes por grupo/conta
1654:     * (SigOpTdi via cursor_4c_Tdi) da linha corrente de grd_4c_Gradei
1655:     * (filtro local via MontarComissoesDesconto - equivalente ao
1656:     * "MontaTbCom" do legado).
1657:     *
1658:     * cnt_4c_Formula1/cnt_4c_Formula2 mostram a 1a/2a formula de calculo
1659:     * (Campo/Operador/Constante/Moeda) da linha corrente de grd_4c_Gradei,
1660:     * bindados diretamente via ControlSource a cursor_4c_Tdt (mesmo padrao
1661:     * usado pelas colunas de grd_4c_GradeD em ConfigurarPgPgConfDesconto).
1662:     *--------------------------------------------------------------------------
1663:     PROTECTED PROCEDURE ConfigurarPgPgDesconto()
1664:         LOCAL loc_oPg, loc_oCnt, loc_oGradei, loc_oGradec, loc_oF1, loc_oF2
1665: 
1666:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1667: 
1668:         loc_oPg.AddObject("cnt_4c_PgDesconto", "Container")
1669:         loc_oCnt = loc_oPg.cnt_4c_PgDesconto
1670:         WITH loc_oCnt
1671:             .Top       = 151
1672:             .Left      = -1
1673:             .Width     = 1004
1674:             .Height    = 482
1675:             .BackStyle = 0
1676:             .Visible   = .T.
1677:         ENDWITH
1678: 
1679:         *----------------------------------------------------------------------
1680:         * Label2 - cabecalho "Descontos" (acima de grd_4c_Gradei)
1681:         *----------------------------------------------------------------------
1682:         loc_oCnt.AddObject("lbl_4c_Descontos", "Label")
1683:         WITH loc_oCnt.lbl_4c_Descontos
1684:             .Caption   = "Descontos"
1685:             .Top       = 2
1686:             .Left      = 4
1687:             .Width     = 59
1688:             .Height    = 15
1689:             .BackStyle = 0
1690:             .FontName  = "Tahoma"
1691:             .FontSize  = 8
1692:             .FontBold  = .T.
1693:             .WordWrap  = .T.
1694:             .ForeColor = RGB(90, 90, 90)
1695:             .Visible   = .T.
1696:         ENDWITH
1697: 
1698:         *----------------------------------------------------------------------
1699:         * grd_4c_Gradei - grade MESTRE editavel de composicao (cursor_4c_Tdt)
1700:         *----------------------------------------------------------------------
1701:         loc_oCnt.AddObject("grd_4c_Gradei", "Grid")
1702:         loc_oGradei = loc_oCnt.grd_4c_Gradei
1703:         loc_oGradei.RecordSource = ""
1704:         loc_oGradei.ColumnCount  = 8
1705:         WITH loc_oGradei
1706:             .Top       = 16
1707:             .Left      = 4
1708:             .Width     = 568
1709:             .Height    = 279
1710:             .FontName  = "Verdana"
1711:             .FontSize  = 8
1712:             .RowHeight = 20
1713:             .ForeColor = RGB(36, 84, 155)
1714:             .Visible   = .T.
1715:         ENDWITH
1716: 
1717:         WITH loc_oGradei.Column1
1718:             .Width              = 130
1719:             .Header1.Caption    = "Tipo"
1720:             .Header1.Alignment  = 2
1721:             .Header1.FontName   = "Verdana"
1722:             .Header1.FontSize   = 8
1723:         ENDWITH
1724:         loc_oGradei.Column1.AddObject("cbo_4c_GiTipo", "ComboBox")
1725:         WITH loc_oGradei.Column1.cbo_4c_GiTipo
1726:             .Top             = 27
1727:             .Left            = 4
1728:             .SpecialEffect   = 1
1729:             .RowSourceType   = 1
1730:             .RowSource       = "Grupo,Linha,Gr Venda,Produto,Moeda,Unidade,Feitio,SubGrupo,Finalidade"
1731:             .Style           = 2
1732:             .ForeColor       = RGB(36, 84, 155)
1733:             .BackColor       = RGB(255, 255, 255)
1734:         ENDWITH
1735:         loc_oGradei.Column1.CurrentControl = "cbo_4c_GiTipo"
1736:         BINDEVENT(loc_oGradei.Column1.cbo_4c_GiTipo, "When", THIS, "GradeiDescColunaEditavelWhen")
1737: 
1738:         WITH loc_oGradei.Column2
1739:             .Width             = 100
1740:             .Header1.Caption   = "C" + CHR(243) + "digo "
1741:             .Header1.Alignment = 2
1742:             .Header1.FontName  = "Verdana"
1743:             .Header1.FontSize  = 8
1744:             .Text1.BorderStyle = 0
1745:             .Text1.Margin      = 2
1746:             .Text1.ForeColor   = RGB(36, 84, 155)
1747:             .Text1.BackColor   = RGB(255, 255, 255)
1748:         ENDWITH
1749:         BINDEVENT(loc_oGradei.Column2.Text1, "When",     THIS, "GradeiDescColunaEditavelWhen")
1750:         BINDEVENT(loc_oGradei.Column2.Text1, "KeyPress",  THIS, "GradeiDescCodigoKeyPress")
1751:         BINDEVENT(loc_oGradei.Column2.Text1, "DblClick",  THIS, "GradeiDescCodigoDblClick")
1752: 
1753:         WITH loc_oGradei.Column3
1754:             .Width             = 55
1755:             .Header1.Caption   = "Valor"
1756:             .Header1.Alignment = 2
1757:             .Header1.FontName  = "Verdana"
1758:             .Header1.FontSize  = 8
1759:             .InputMask         = "9999.99"
1760:             .Text1.InputMask   = "9999.99"
1761:             .Text1.ForeColor   = RGB(36, 84, 155)
1762:         ENDWITH
1763:         BINDEVENT(loc_oGradei.Column3.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")
1764: 
1765:         WITH loc_oGradei.Column4
1766:             .Width             = 55
1767:             .Header1.Caption   = "Fator"
1768:             .Header1.Alignment = 2
1769:             .Header1.FontName  = "Verdana"
1770:             .Header1.FontSize  = 8
1771:             .InputMask         = "9999.99"
1772:             .Text1.InputMask   = "9999.99"
1773:             .Text1.ForeColor   = RGB(36, 84, 155)
1774:         ENDWITH
1775:         BINDEVENT(loc_oGradei.Column4.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")
1776: 
1777:         WITH loc_oGradei.Column5
1778:             .Width             = 17
1779:             .Header1.Caption   = "E"
1780:             .Header1.Alignment = 2
1781:             .Header1.FontName  = "Verdana"
1782:             .Header1.FontSize  = 8
1783:             .Header1.ToolTipText = "Exclui - N" + CHR(227) + "o calcula desconto"
1784:             .Text1.ForeColor   = RGB(36, 84, 155)
1785:             .Text1.MaxLength   = 1
1786:         ENDWITH
1787:         BINDEVENT(loc_oGradei.Column5.Text1, "When",  THIS, "GradeiDescColunaEditavelWhen")
1788:         BINDEVENT(loc_oGradei.Column5.Text1, "Valid", THIS, "GradeiDescColumn5Valid")
1789: 
1790:         WITH loc_oGradei.Column6
1791:             .Width             = 66
1792:             .Header1.Caption   = "Faixa"
1793:             .Header1.Alignment = 2
1794:             .Header1.FontName  = "Verdana"
1795:             .Header1.FontSize  = 8
1796:         ENDWITH
1797:         loc_oGradei.Column6.AddObject("cbo_4c_GiFaixa", "ComboBox")
1798:         WITH loc_oGradei.Column6.cbo_4c_GiFaixa
1799:             .Top             = 18
1800:             .Left            = 28
1801:             .SpecialEffect   = 1
1802:             .RowSourceType   = 1
1803:             .RowSource       = "Nenhuma,Qtde,Peso,Tot.Peso"
1804:             .Style           = 2
1805:             .ForeColor       = RGB(36, 84, 155)
1806:         ENDWITH
1807:         loc_oGradei.Column6.CurrentControl = "cbo_4c_GiFaixa"
1808: 
1809:         WITH loc_oGradei.Column7
1810:             .Width             = 38
1811:             .Header1.Caption   = "Inicial"
1812:             .Header1.Alignment = 2
1813:             .Header1.FontName  = "Verdana"
1814:             .Header1.FontSize  = 8
1815:             .Text1.ForeColor   = RGB(0, 0, 0)
1816:         ENDWITH
1817: 
1818:         WITH loc_oGradei.Column8
1819:             .Width             = 38
1820:             .Header1.Caption   = "Final"
1821:             .Header1.Alignment = 2
1822:             .Header1.FontName  = "Verdana"
1823:             .Header1.FontSize  = 8
1824:             .Text1.ForeColor   = RGB(0, 0, 0)
1825:         ENDWITH
1826: 
1827:         BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiDescAfterRowColChange")
1828: 
1829:         *----------------------------------------------------------------------
1830:         * inserir/excluir - incluem/removem linhas de composicao (cursor_4c_Tdt)
1831:         *----------------------------------------------------------------------
1832:         loc_oCnt.AddObject("cmd_4c_InserirComposicao", "CommandButton")
1833:         WITH loc_oCnt.cmd_4c_InserirComposicao
1834:             .Caption   = ""
1835:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1836:             .Top       = 296
1837:             .Left      = 5
1838:             .Width     = 40

*-- Linhas 1946 a 2062:
1946:         ENDWITH
1947: 
1948:         *----------------------------------------------------------------------
1949:         * lbl_4c_Comissoes - cabecalho "Comissoes" (acima de grd_4c_Gradec)
1950:         *----------------------------------------------------------------------
1951:         loc_oCnt.AddObject("lbl_4c_Comissoes", "Label")
1952:         WITH loc_oCnt.lbl_4c_Comissoes
1953:             .Caption   = "Comiss" + CHR(245) + "es"
1954:             .Top       = 2
1955:             .Left      = 575
1956:             .Width     = 60
1957:             .Height    = 15
1958:             .BackStyle = 0
1959:             .FontName  = "Tahoma"
1960:             .FontSize  = 8
1961:             .FontBold  = .T.
1962:             .ForeColor = RGB(90, 90, 90)
1963:             .Visible   = .T.
1964:         ENDWITH
1965: 
1966:         *----------------------------------------------------------------------
1967:         * grd_4c_Gradec - comissoes por grupo/conta da linha corrente de
1968:         * grd_4c_Gradei (cursor_4c_Tdi filtrado localmente)
1969:         *----------------------------------------------------------------------
1970:         loc_oCnt.AddObject("grd_4c_Gradec", "Grid")
1971:         loc_oGradec = loc_oCnt.grd_4c_Gradec
1972:         loc_oGradec.RecordSource = ""
1973:         loc_oGradec.ColumnCount  = 6
1974:         WITH loc_oGradec
1975:             .Top       = 16
1976:             .Left      = 575
1977:             .Width     = 422
1978:             .Height    = 279
1979:             .FontName  = "Verdana"
1980:             .FontSize  = 8
1981:             .RowHeight = 20
1982:             .RecordMark = .F.
1983:             .ForeColor = RGB(36, 84, 155)
1984:             .Visible   = .T.
1985:         ENDWITH
1986: 
1987:         WITH loc_oGradec.Column1
1988:             .Width             = 100
1989:             .Header1.Caption   = "Grupo"
1990:             .Header1.Alignment = 2
1991:             .Header1.FontName  = "Verdana"
1992:             .Header1.FontSize  = 8
1993:             .Text1.ForeColor   = RGB(0, 0, 0)
1994:         ENDWITH
1995:         BINDEVENT(loc_oGradec.Column1.Text1, "Valid", THIS, "GradecColumn1Valid")
1996: 
1997:         WITH loc_oGradec.Column2
1998:             .Width             = 100
1999:             .Header1.Caption   = "Conta"
2000:             .Header1.Alignment = 2
2001:             .Header1.FontName  = "Verdana"
2002:             .Header1.FontSize  = 8
2003:             .InputMask         = "XXXXXXXXXX"
2004:             .Text1.InputMask   = "XXXXXXXXXX"
2005:             .Text1.ForeColor   = RGB(0, 0, 0)
2006:         ENDWITH
2007:         BINDEVENT(loc_oGradec.Column2.Text1, "Valid", THIS, "GradecColumn2Valid")
2008: 
2009:         WITH loc_oGradec.Column3
2010:             .Width             = 55
2011:             .Header1.Caption   = "Integral"
2012:             .Header1.Alignment = 2
2013:             .Header1.FontName  = "Verdana"
2014:             .Header1.FontSize  = 8
2015:             .InputMask         = "999.99"
2016:             .Text1.InputMask   = "999.99"
2017:             .Text1.ForeColor   = RGB(0, 0, 0)
2018:         ENDWITH
2019: 
2020:         WITH loc_oGradec.Column4
2021:             .Width             = 55
2022:             .Header1.Caption   = "Dividida"
2023:             .Header1.Alignment = 2
2024:             .Header1.FontName  = "Verdana"
2025:             .Header1.FontSize  = 8
2026:             .InputMask         = "999.99"
2027:             .Text1.InputMask   = "999.99"
2028:             .Text1.ForeColor   = RGB(0, 0, 0)
2029:         ENDWITH
2030: 
2031:         WITH loc_oGradec.Column5
2032:             .Width             = 55
2033:             .Header1.Caption   = "Atendim"
2034:             .Header1.Alignment = 2
2035:             .Header1.FontName  = "Verdana"
2036:             .Header1.FontSize  = 8
2037:             .InputMask         = "999.99"
2038:             .Text1.InputMask   = "999.99"
2039:             .Text1.ForeColor   = RGB(0, 0, 0)
2040:         ENDWITH
2041: 
2042:         WITH loc_oGradec.Column6
2043:             .Width             = 30
2044:             .Header1.Caption   = "Moe"
2045:             .Header1.Alignment = 2
2046:             .Header1.FontName  = "Verdana"
2047:             .Header1.FontSize  = 8
2048:             .Text1.ForeColor   = RGB(0, 0, 0)
2049:             .Text1.BackColor   = RGB(255, 255, 255)
2050:         ENDWITH
2051: 
2052:         *----------------------------------------------------------------------
2053:         * Inscomis/exccomis - incluem/removem comissoes (cursor_4c_Tdi)
2054:         *----------------------------------------------------------------------
2055:         loc_oCnt.AddObject("cmd_4c_InserirComissao", "CommandButton")
2056:         WITH loc_oCnt.cmd_4c_InserirComissao
2057:             .Caption   = ""
2058:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2059:             .Top       = 296
2060:             .Left      = 577
2061:             .Width     = 40
2062:             .Height    = 40

*-- Linhas 2545 a 2569:
2545:             loc_oPg2.cbo_4c_CmbTpDesc.Enabled     = par_lHabilitar
2546: 
2547:             *-- Grade de empresas (tipo de desconto 11): ReadOnly nos modos nao-edicao
2548:             loc_oPg2.cnt_4c_Container1.grd_4c_Empresas.ReadOnly = !par_lHabilitar
2549: 
2550:             *-- Pagina "Descontos / Comissoes"
2551:             WITH loc_oPg2.cnt_4c_PgDesconto
2552:                 .txt_4c_DescontoMaximo.Enabled  = par_lHabilitar
2553:                 .grd_4c_Gradei.ReadOnly         = !par_lHabilitar
2554:                 .grd_4c_Gradec.ReadOnly         = !par_lHabilitar
2555:                 .cmd_4c_InserirComposicao.Enabled = par_lHabilitar
2556:                 .cmd_4c_ExcluirComposicao.Enabled = par_lHabilitar
2557:                 .cmd_4c_InserirComissao.Enabled   = par_lHabilitar
2558:                 .cmd_4c_ExcluirComissao.Enabled   = par_lHabilitar
2559:                 .cbo_4c_ComboComis.Enabled      = par_lHabilitar
2560:                 .txt_4c_DescFats.Enabled        = par_lHabilitar
2561:                 .txt_4c_FatorPads.Enabled       = par_lHabilitar
2562:                 .chk_4c_IgnoraCotacao.Enabled   = par_lHabilitar
2563:                 .cnt_4c_Formula1.cbo_4c_Campo1.Enabled = par_lHabilitar
2564:                 .cnt_4c_Formula1.cbo_4c_Oper1.Enabled  = par_lHabilitar
2565:                 .cnt_4c_Formula1.txt_4c_Const1.Enabled = par_lHabilitar
2566:                 .cnt_4c_Formula1.cbo_4c_Campo2.Enabled = par_lHabilitar
2567:                 .cnt_4c_Formula1.cbo_4c_Oper2.Enabled  = par_lHabilitar
2568:                 .cnt_4c_Formula1.txt_4c_Const2.Enabled = par_lHabilitar
2569:                 .cnt_4c_Formula1.cbo_4c_Campo3.Enabled = par_lHabilitar

*-- Linhas 2876 a 2901:
2876: 
2877:     *--------------------------------------------------------------------------
2878:     * CriarCursorTipoDesconto - Cria cursor local (lista fixa) para cbo_4c_CmbTpDesc
2879:     * Legado: Create Cursor crTpDesc (Descrs c(40), ordem N(2,0)) no Init()
2880:     *--------------------------------------------------------------------------
2881:     PROTECTED PROCEDURE CriarCursorTipoDesconto()
2882:         IF USED("cursor_4c_TipoDesconto")
2883:             RETURN
2884:         ENDIF
2885: 
2886:         CREATE CURSOR cursor_4c_TipoDesconto (Descrs C(40), Ordem N(2, 0))
2887:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("1-Anivers" + CHR(225) + "rio", 1)
2888:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("2-Desconto Vendedor", 2)
2889:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("3-Desconto Gerente-Grupo", 3)
2890:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("4-Desconto Gerente-Lancamento", 4)
2891:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("5-Desconto Gerente-qq pe" + CHR(231) + "a", 5)
2892:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("6-Troca Zerada", 6)
2893:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("7-Troca Upgrade", 7)
2894:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("8-Desconto Supervisor", 8)
2895:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("9-Desconto Diretoria", 9)
2896:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("10-Troca Up Alianca", 10)
2897:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("11-Desconto Gerente-Extra/loja", 11)
2898:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("12-Desconto Gerente-Brinde", 12)
2899:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("13-Desconto Gerente-Troca de pre" + CHR(231) + "o", 13)
2900:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES (SPACE(40), 0)
2901:         GO TOP IN cursor_4c_TipoDesconto

*-- Linhas 2918 a 2937:
2918:             SELECT cursor_4c_Empresas
2919:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2920:             GO TOP IN cursor_4c_Empresas
2921:             IF PEMSTATUS(loc_oPg.cnt_4c_Container1, "grd_4c_Empresas", 5)
2922:                 loc_oPg.cnt_4c_Container1.grd_4c_Empresas.Refresh()
2923:             ENDIF
2924:         ENDIF
2925:     ENDPROC
2926: 
2927:     *--------------------------------------------------------------------------
2928:     * CarregarGradeEmpresas - Carrega grade de empresas (SigCdEmp) e marca as
2929:     * empresas presentes em this_cListaEmpresas (formato ";EMP1;EMP2;...")
2930:     *--------------------------------------------------------------------------
2931:     PROCEDURE CarregarGradeEmpresas()
2932:         LOCAL loc_lResultado, loc_oGrid, loc_cListaEmpresas
2933: 
2934:         loc_lResultado = .F.
2935: 
2936:         TRY
2937:             IF THIS.this_oBusinessObject.CarregarEmpresas()

*-- Linhas 2947 a 2972:
2947:                 ENDSCAN
2948:                 GO TOP IN cursor_4c_Empresas
2949: 
2950:                 *-- NAO reatribuir ColumnCount aqui: destruiria o chk_4c_Marca
2951:                 *-- (AddObject em Column1) criado em ConfigurarPaginaDados (Pattern #183)
2952:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas
2953:                 loc_oGrid.RecordSource = "cursor_4c_Empresas"
2954:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Empresas.nMarca"
2955:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Empresas.cemps"
2956:                 loc_oGrid.Column1.Header1.Caption = ""
2957:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
2958:                 loc_oGrid.Column1.Width  = 30
2959:                 loc_oGrid.Column2.Width  = 190
2960:                 loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
2961:                 loc_oGrid.Column2.ReadOnly = .T.
2962:                 loc_oGrid.Refresh()
2963: 
2964:                 loc_lResultado = .T.
2965:             ENDIF
2966:         CATCH TO loException
2967:             MostrarErro(loException, "FormTbv.CarregarGradeEmpresas")
2968:             loc_lResultado = .F.
2969:         ENDTRY
2970: 
2971:         RETURN loc_lResultado
2972:     ENDPROC

*-- Linhas 3002 a 3048:
3002:             SELECT cursor_4c_Empresas
3003:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
3004:             GO TOP IN cursor_4c_Empresas
3005:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3006:         ENDIF
3007:     ENDPROC
3008: 
3009:     *--------------------------------------------------------------------------
3010:     * BtnEmpresasMarcarClick - Marca todas as empresas da grade
3011:     * PUBLIC: BINDEVENT requer metodo publico
3012:     *--------------------------------------------------------------------------
3013:     PROCEDURE BtnEmpresasMarcarClick()
3014:         IF USED("cursor_4c_Empresas")
3015:             SELECT cursor_4c_Empresas
3016:             REPLACE ALL nMarca WITH 1 IN cursor_4c_Empresas
3017:             GO TOP IN cursor_4c_Empresas
3018:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3019:         ENDIF
3020:     ENDPROC
3021: 
3022:     *--------------------------------------------------------------------------
3023:     * EmpresaCheckboxMouseDown - Toggle nMarca em cursor_4c_Empresas via mouse
3024:     * Grid nao alterna CheckBox pelo binding nativo (campo numerico) - alterna
3025:     * manualmente e suprime o toggle padrao com NODEFAULT
3026:     * PUBLIC: BINDEVENT requer metodo publico
3027:     *--------------------------------------------------------------------------
3028:     PROCEDURE EmpresaCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3029:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3030:             SELECT cursor_4c_Empresas
3031:             REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3032:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3033:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3034:             ENDIF
3035:         ENDIF
3036:         NODEFAULT
3037:     ENDPROC
3038: 
3039:     *--------------------------------------------------------------------------
3040:     * EmpresaCheckboxMouseUp - Suprime comportamento padrao
3041:     * PUBLIC: BINDEVENT requer metodo publico
3042:     *--------------------------------------------------------------------------
3043:     PROCEDURE EmpresaCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3044:         NODEFAULT
3045:     ENDPROC
3046: 
3047:     *--------------------------------------------------------------------------
3048:     * EmpresaCheckboxClick - Suprime toggle automatico (MouseDown ja atualizou)

*-- Linhas 3061 a 3080:
3061:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3062:                 SELECT cursor_4c_Empresas
3063:                 REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3064:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3065:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3066:                 ENDIF
3067:             ENDIF
3068:             NODEFAULT
3069:         ENDIF
3070:     ENDPROC
3071: 
3072:     *--------------------------------------------------------------------------
3073:     * MoedaRefLookupKeyPress / MoedaRefLookupDblClick - F4/DblClick para
3074:     * lookup de Moeda de Referencia (SigCdMoe) em txt_4c__moerefs
3075:     * PUBLIC: BINDEVENT requer metodo publico
3076:     *--------------------------------------------------------------------------
3077:     PROCEDURE MoedaRefLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3078:         IF par_nKeyCode = 28  && F4
3079:             THIS.AbrirLookupMoedaRef()
3080:         ENDIF

*-- Linhas 3101 a 3120:
3101: 
3102:             IF VARTYPE(loc_oBusca) = "O"
3103:                 IF !loc_oBusca.this_lAchouRegistro
3104:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3105:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3106:                     loc_oBusca.Show()
3107:                 ENDIF
3108: 
3109:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3110:                     SELECT cursor_4c_BuscaMoeda
3111:                     loc_oPg.txt_4c__moerefs.Value      = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3112:                     loc_oPg.txt_4c__moerefs_desc.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
3113:                 ENDIF
3114: 
3115:                 loc_oBusca.Release()
3116:             ENDIF
3117:         CATCH TO loException
3118:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaRef")
3119:         ENDTRY
3120: 

*-- Linhas 3155 a 3326:
3155: 
3156:             IF VARTYPE(loc_oBusca) = "O"
3157:                 IF !loc_oBusca.this_lAchouRegistro
3158:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3159:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3160:                     loc_oBusca.Show()
3161:                 ENDIF
3162: 
3163:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedaFator")
3164:                     SELECT cursor_4c_BuscaMoedaFator
3165:                     loc_oPg.txt_4c_MoeFat.Value = ALLTRIM(cursor_4c_BuscaMoedaFator.cmoes)
3166:                 ENDIF
3167: 
3168:                 loc_oBusca.Release()
3169:             ENDIF
3170:         CATCH TO loException
3171:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaFator")
3172:         ENDTRY
3173: 
3174:         IF USED("cursor_4c_BuscaMoedaFator")
3175:             USE IN cursor_4c_BuscaMoedaFator
3176:         ENDIF
3177:     ENDPROC
3178: 
3179:     *--------------------------------------------------------------------------
3180:     * CriarCursorDiaSemana - Cria cursor local (lista fixa) com os 7 dias da
3181:     * semana, usado na validacao de faixas de desconto por Dia da Semana
3182:     * Legado: Create Cursor DiaSemana (ndias n(1), Descrs c(7)) no Init()
3183:     *--------------------------------------------------------------------------
3184:     PROTECTED PROCEDURE CriarCursorDiaSemana()
3185:         IF USED("cursor_4c_DiaSemana")
3186:             RETURN
3187:         ENDIF
3188: 
3189:         CREATE CURSOR cursor_4c_DiaSemana (nDias N(1), Descrs C(7))
3190:         INDEX ON Descrs TAG Descrs
3191:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (1, "DOMINGO")
3192:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (2, "SEGUNDA")
3193:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (3, "TERCA  ")
3194:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (4, "QUARTA ")
3195:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (5, "QUINTA ")
3196:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (6, "SEXTA  ")
3197:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (7, "SABADO ")
3198:         GO TOP IN cursor_4c_DiaSemana
3199:     ENDPROC
3200: 
3201:     *--------------------------------------------------------------------------
3202:     * CarregarConfiguracaoDesconto - Carrega grd_4c_GradeI (SigOpTdt) e
3203:     * grd_4c_GradeD (SigOpTds) do codigo corrente. Chamado por BOParaForm()
3204:     * ao entrar em ALTERAR/VISUALIZAR/EXCLUIR e por LimparCampos() (INCLUIR).
3205:     *--------------------------------------------------------------------------
3206:     PROCEDURE CarregarConfiguracaoDesconto()
3207:         LOCAL loc_oPgConf, loc_oPgDesc, loc_oGradei, loc_oGradeiDesc, loc_oGradec, loc_cCodigo
3208: 
3209:         TRY
3210:             loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3211:             loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3212:             loc_oGradei     = loc_oPgConf.grd_4c_GradeI
3213:             loc_oGradeiDesc = loc_oPgDesc.grd_4c_Gradei
3214:             loc_oGradec     = loc_oPgDesc.grd_4c_Gradec
3215:             loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
3216: 
3217:             IF EMPTY(loc_cCodigo)
3218:                 loc_oGradei.RecordSource        = ""
3219:                 loc_oPgConf.grd_4c_GradeD.RecordSource = ""
3220:                 loc_oPgConf.grd_4c_GradeD.Enabled      = .F.
3221:                 loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3222:                 loc_oGradeiDesc.RecordSource    = ""
3223:                 loc_oGradec.RecordSource        = ""
3224:                 RETURN
3225:             ENDIF
3226: 
3227:             THIS.this_oBusinessObject.CarregarComposicaoDesconto(loc_cCodigo)
3228:             THIS.this_oBusinessObject.CarregarComissoesDesconto(loc_cCodigo)
3229:             THIS.this_oBusinessObject.CarregarFaixasDesconto(loc_cCodigo)
3230: 
3231:             loc_oGradei.RecordSource        = "cursor_4c_Tdt"
3232:             loc_oGradei.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3233:             loc_oGradei.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3234:             loc_oGradei.Column3.ControlSource = "cursor_4c_Tdt.tipods"
3235:             loc_oGradei.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3236:             loc_oGradei.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3237:             loc_oGradei.Refresh()
3238: 
3239:             *-- grd_4c_Gradei (pgDesconto) - MESMA cursor_4c_Tdt, colunas
3240:             *-- adicionais de valor/fator/exclui/faixa/inicial/final
3241:             loc_oGradeiDesc.RecordSource        = "cursor_4c_Tdt"
3242:             loc_oGradeiDesc.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3243:             loc_oGradeiDesc.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3244:             loc_oGradeiDesc.Column3.ControlSource = "cursor_4c_Tdt.descos"
3245:             loc_oGradeiDesc.Column4.ControlSource = "cursor_4c_Tdt.dfators"
3246:             loc_oGradeiDesc.Column5.ControlSource = "cursor_4c_Tdt.texclus"
3247:             loc_oGradeiDesc.Column6.ControlSource = "cursor_4c_Tdt.faixas"
3248:             loc_oGradeiDesc.Column7.ControlSource = "cursor_4c_Tdt.finicias"
3249:             loc_oGradeiDesc.Column8.ControlSource = "cursor_4c_Tdt.ffinals"
3250:             loc_oGradeiDesc.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3251:             loc_oGradeiDesc.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3252:             *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180 -
3253:             *-- VFP pode resetar Header1.Caption ao reatribuir RecordSource)
3254:             loc_oGradeiDesc.Column1.Header1.Caption = "Tipo"
3255:             loc_oGradeiDesc.Column2.Header1.Caption = "C" + CHR(243) + "digo "
3256:             loc_oGradeiDesc.Column3.Header1.Caption = "Valor"
3257:             loc_oGradeiDesc.Column4.Header1.Caption = "Fator"
3258:             loc_oGradeiDesc.Column5.Header1.Caption = "E"
3259:             loc_oGradeiDesc.Column6.Header1.Caption = "Faixa"
3260:             loc_oGradeiDesc.Column7.Header1.Caption = "Inicial"
3261:             loc_oGradeiDesc.Column8.Header1.Caption = "Final"
3262:             loc_oGradeiDesc.Refresh()
3263: 
3264:             IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3265:                 SELECT cursor_4c_Tdt
3266:                 REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3267:                 REPLACE regs WITH 1 IN cursor_4c_Tdt
3268:                 GO TOP IN cursor_4c_Tdt
3269:             ENDIF
3270: 
3271:             *-- grd_4c_Gradec (comissoes) - filtrado pela linha corrente de
3272:             *-- cursor_4c_Tdt via MontarComissoesDesconto()
3273:             loc_oGradec.ColumnCount = 6
3274:             loc_oGradec.RecordSource        = "cursor_4c_Tdi"
3275:             loc_oGradec.Column1.ControlSource = "cursor_4c_Tdi.grupos"
3276:             loc_oGradec.Column2.ControlSource = "cursor_4c_Tdi.contas"
3277:             loc_oGradec.Column3.ControlSource = "cursor_4c_Tdi.pintegrals"
3278:             loc_oGradec.Column4.ControlSource = "cursor_4c_Tdi.pdivididas"
3279:             loc_oGradec.Column5.ControlSource = "cursor_4c_Tdi.patendes"
3280:             loc_oGradec.Column6.ControlSource = "cursor_4c_Tdi.moedas"
3281:             *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180)
3282:             loc_oGradec.Column1.Header1.Caption = "Grupo"
3283:             loc_oGradec.Column2.Header1.Caption = "Conta"
3284:             loc_oGradec.Column3.Header1.Caption = "Integral"
3285:             loc_oGradec.Column4.Header1.Caption = "Dividida"
3286:             loc_oGradec.Column5.Header1.Caption = "Atendim"
3287:             loc_oGradec.Column6.Header1.Caption = "Moe"
3288: 
3289:             THIS.MontarConfiguracaoDesconto()
3290:             THIS.MontarComissoesDesconto()
3291:         CATCH TO loException
3292:             MostrarErro(loException, "FormTbv.CarregarConfiguracaoDesconto")
3293:         ENDTRY
3294:     ENDPROC
3295: 
3296:     *--------------------------------------------------------------------------
3297:     * GradeiConfAfterRowColChange - troca de linha em grd_4c_GradeI: marca a
3298:     * linha corrente (flag "regs", equivalente ao legado) e reconfigura a
3299:     * grade de faixas (grd_4c_GradeD) para a nova combinacao Tipo/Codigo
3300:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3301:     *--------------------------------------------------------------------------
3302:     PROCEDURE GradeiConfAfterRowColChange(par_nColIndex)
3303:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3304:             RETURN
3305:         ENDIF
3306: 
3307:         SELECT cursor_4c_Tdt
3308:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3309:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3310: 
3311:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3312:         THIS.MontarConfiguracaoDesconto()
3313:     ENDPROC
3314: 
3315:     *--------------------------------------------------------------------------
3316:     * GradeiConfColumn3When - habilita edicao da coluna "Tipos Desconto"
3317:     * apenas em INCLUIR/ALTERAR (equivalente ao When original)
3318:     * PUBLIC: BINDEVENT requer metodo publico
3319:     *--------------------------------------------------------------------------
3320:     PROCEDURE GradeiConfColumn3When()
3321:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3322:     ENDPROC
3323: 
3324:     *--------------------------------------------------------------------------
3325:     * GradeiConfColumn3Valid / GradeiConfColumn3LostFocus - reconfigura a
3326:     * grade de faixas ao mudar o tipo de desconto progressivo da linha

*-- Linhas 3333 a 3371:
3333:     PROCEDURE GradeiConfColumn3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3334:         THIS.MontarConfiguracaoDesconto()
3335:         IF LASTKEY() = 9
3336:             THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD.Column1.SetFocus
3337:         ENDIF
3338:     ENDPROC
3339: 
3340:     *--------------------------------------------------------------------------
3341:     * MontarConfiguracaoDesconto - Equivalente ao "MontaTbDes" do legado.
3342:     * Filtra cursor_4c_Tds pela combinacao Tipo+Codigo+TipoDesconto da linha
3343:     * corrente de grd_4c_GradeI, cria a faixa inicial (00:00-23:59) quando
3344:     * ainda nao existe nenhuma, e reconfigura grd_4c_GradeD (ControlSource/
3345:     * InputMask das colunas Inicial/Final) conforme o Tipo de Desconto:
3346:     * 2=Dia da Semana, 3=Dia do Mes, 4=Horario, 5=Data
3347:     *--------------------------------------------------------------------------
3348:     PROTECTED PROCEDURE MontarConfiguracaoDesconto()
3349:         LOCAL loc_oGD, loc_oPgConf, loc_cCodigo, loc_nTipos, loc_cCodTips, ;
3350:               loc_nTipoDs, loc_cTitulo
3351: 
3352:         loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3353:         loc_oGD     = loc_oPgConf.grd_4c_GradeD
3354: 
3355:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3356:             loc_oGD.RecordSource = ""
3357:             loc_oGD.Enabled      = .F.
3358:             loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3359:             RETURN
3360:         ENDIF
3361: 
3362:         loc_cCodigo  = ALLTRIM(cursor_4c_Tdt.codigos)
3363:         loc_nTipos   = cursor_4c_Tdt.tipos
3364:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3365:         loc_nTipoDs  = cursor_4c_Tdt.tipods
3366: 
3367:         DO CASE
3368:             CASE loc_nTipoDs = 2
3369:                 loc_cTitulo = "Dia da Semana"
3370:             CASE loc_nTipoDs = 3
3371:                 loc_cTitulo = "Dia do Mes"

*-- Linhas 3393 a 3423:
3393:                 GO TOP
3394:             ENDIF
3395:         ENDIF
3396: 
3397:         WITH loc_oGD
3398:             .RecordSource = ""
3399:             DO CASE
3400:                 CASE loc_nTipoDs = 5
3401:                     .Column1.ControlSource = "cursor_4c_Tds.Campo3is"
3402:                     .Column2.ControlSource = "cursor_4c_Tds.Campo3fs"
3403:                 OTHERWISE
3404:                     .Column1.ControlSource = "cursor_4c_Tds.Campo1is"
3405:                     .Column2.ControlSource = "cursor_4c_Tds.Campo1fs"
3406:             ENDCASE
3407:             .RecordSource = "cursor_4c_Tds"
3408: 
3409:             DO CASE
3410:                 CASE loc_nTipoDs = 2
3411:                     .Column1.Text1.InputMask = "XXXXXXX"
3412:                     .Column1.Text1.MaxLength = 7
3413:                     .Column2.Text1.InputMask = "XXXXXXX"
3414:                     .Column2.Text1.MaxLength = 7
3415:                 CASE loc_nTipoDs = 3
3416:                     .Column1.Text1.InputMask = "99"
3417:                     .Column1.Text1.MaxLength = 2
3418:                     .Column2.Text1.InputMask = "99"
3419:                     .Column2.Text1.MaxLength = 2
3420:                 CASE loc_nTipoDs = 4
3421:                     .Column1.Text1.InputMask = "99:99"
3422:                     .Column1.Text1.MaxLength = 5
3423:                     .Column2.Text1.InputMask = "99:99"

*-- Linhas 3443 a 3461:
3443:     *--------------------------------------------------------------------------
3444:     * FormatarHorarioValidado - Valida um horario digitado (HH:MM, 00:00 a
3445:     * 23:59) e retorna a versao formatada, ou "" se invalido (mostrando
3446:     * aviso). Compartilhado pelas colunas de horario de grd_4c_GradeD.
3447:     *--------------------------------------------------------------------------
3448:     PROTECTED FUNCTION FormatarHorarioValidado(par_cValor)
3449:         LOCAL loc_cValor, loc_nHora, loc_nMin
3450: 
3451:         loc_cValor = TRANSFORM(par_cValor, "@L 99:99")
3452:         loc_nHora  = VAL(SUBSTR(loc_cValor, 1, 2))
3453:         loc_nMin   = VAL(SUBSTR(loc_cValor, 4, 2))
3454: 
3455:         IF !BETWEEN(loc_nHora, 0, 23)
3456:             MsgAviso("Horas s" + CHR(243) + " pode ser entre 00:00 e 23:59", "")
3457:             RETURN ""
3458:         ENDIF
3459:         IF !BETWEEN(loc_nMin, 0, 59)
3460:             MsgAviso("Minutos s" + CHR(243) + " pode ser entre 00 e 59", "")
3461:             RETURN ""

*-- Linhas 3467 a 3485:
3467:     *--------------------------------------------------------------------------
3468:     * FaixaTemInicial - Indica se a faixa (linha corrente de cursor_4c_Tds)
3469:     * ja tem o valor Inicial preenchido, condicao para habilitar as demais
3470:     * colunas de grd_4c_GradeD (equivalente ao "Left(Campo1is,2)" do legado).
3471:     * Quando o Tipo de Desconto e "Data" (5), o Inicial fica em Campo3is
3472:     * (nao em Campo1is - ver MontarConfiguracaoDesconto)
3473:     *--------------------------------------------------------------------------
3474:     PROTECTED FUNCTION FaixaTemInicial()
3475:         LOCAL loc_nTipoDs
3476: 
3477:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3478:             RETURN .F.
3479:         ENDIF
3480: 
3481:         loc_nTipoDs = 0
3482:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3483:             loc_nTipoDs = cursor_4c_Tdt.tipods
3484:         ENDIF
3485: 

*-- Linhas 3494 a 3526:
3494:     * GradeD Column1/Column2 (Inicial/Final) - When/Valid
3495:     * Equivalente ao "PgConfDesconto.GradeD.Column1/2.Text1" do legado:
3496:     * validacao/formatacao depende do Tipo de Desconto (tipods) da linha
3497:     * corrente de grd_4c_GradeI (cursor_4c_Tdt)
3498:     * PUBLIC: BINDEVENT requer metodo publico
3499:     *--------------------------------------------------------------------------
3500:     PROCEDURE GradeDColumn1When()
3501:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3502:     ENDPROC
3503: 
3504:     PROCEDURE GradeDColumn1Valid()
3505:         LOCAL loc_oGD, loc_cValor, loc_cFormatado
3506: 
3507:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3508:             RETURN
3509:         ENDIF
3510: 
3511:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3512:         loc_cValor = ALLTRIM(loc_oGD.Column1.Text1.Value)
3513: 
3514:         IF EMPTY(loc_cValor)
3515:             RETURN
3516:         ENDIF
3517: 
3518:         DO CASE
3519:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3520:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3521:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido. Informe Domingo, Segunda, Terca, Quarta, Quinta, Sexta ou Sabado.", "")
3522:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3523:                 ELSE
3524:                     REPLACE Campo1is WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3525:                     IF EMPTY(ALLTRIM(cursor_4c_Tds.Campo1fs))
3526:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds

*-- Linhas 3569 a 3587:
3569:             RETURN
3570:         ENDIF
3571: 
3572:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3573:         loc_cValor = ALLTRIM(loc_oGD.Column2.Text1.Value)
3574: 
3575:         IF EMPTY(loc_cValor)
3576:             RETURN
3577:         ENDIF
3578: 
3579:         DO CASE
3580:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3581:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3582:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido.", "")
3583:                     RETURN
3584:                 ENDIF
3585:                 IF SEEK(PADR(UPPER(ALLTRIM(cursor_4c_Tds.Campo1is)), 7), "cursor_4c_DiaSemana", "Descrs")
3586:                     loc_nDiaIni = cursor_4c_DiaSemana.nDias
3587:                     IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs") OR cursor_4c_DiaSemana.nDias < loc_nDiaIni

*-- Linhas 3644 a 3662:
3644:             RETURN
3645:         ENDIF
3646: 
3647:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3648:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column3.Text1.Value))
3649:         IF EMPTY(loc_cFormatado)
3650:             RETURN
3651:         ENDIF
3652: 
3653:         REPLACE Campo2is WITH loc_cFormatado IN cursor_4c_Tds
3654:         IF EMPTY(cursor_4c_Tds.Campo2fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo2fs, ":", ""))
3655:             REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3656:         ENDIF
3657: 
3658:         loc_oGD.Refresh()
3659:     ENDPROC
3660: 
3661:     PROCEDURE GradeDColumn4When()
3662:         RETURN THIS.GradeDColumn3When()

*-- Linhas 3669 a 3687:
3669:             RETURN
3670:         ENDIF
3671: 
3672:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3673:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column4.Text1.Value))
3674:         IF EMPTY(loc_cFormatado)
3675:             RETURN
3676:         ENDIF
3677: 
3678:         IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo2is, ":", ""))
3679:             MsgAviso("Intervalo de horas inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3680:             RETURN
3681:         ENDIF
3682: 
3683:         REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3684:         loc_oGD.Refresh()
3685:     ENDPROC
3686: 
3687:     *--------------------------------------------------------------------------

*-- Linhas 3701 a 3751:
3701:             RETURN
3702:         ENDIF
3703: 
3704:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3705: 
3706:         SELECT cursor_4c_Tds
3707:         SKIP
3708:         IF EOF()
3709:             APPEND BLANK
3710:             REPLACE cidchaves WITH fUniqueIds(), ;
3711:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3712:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3713:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3714:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3715:                     campo2is  WITH "00:00", ;
3716:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3717:             GO BOTTOM IN cursor_4c_Tds
3718:         ENDIF
3719: 
3720:         loc_oGD.Refresh()
3721:     ENDPROC
3722: 
3723:     *--------------------------------------------------------------------------
3724:     * BtnExcluirFaixaDescontoClick - remove a faixa corrente de grd_4c_GradeD;
3725:     * garante que sempre reste ao menos uma faixa (equivalente ao legado)
3726:     * PUBLIC: BINDEVENT requer metodo publico
3727:     *--------------------------------------------------------------------------
3728:     PROCEDURE BtnExcluirFaixaDescontoClick()
3729:         LOCAL loc_oGD, loc_nRegistros
3730: 
3731:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tds") ;
3732:                 OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3733:             RETURN
3734:         ENDIF
3735: 
3736:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3737: 
3738:         SELECT cursor_4c_Tds
3739:         IF !EOF()
3740:             DELETE
3741:         ENDIF
3742: 
3743:         COUNT FOR !DELETED() TO loc_nRegistros
3744:         IF loc_nRegistros = 0
3745:             APPEND BLANK
3746:             REPLACE cidchaves WITH fUniqueIds(), ;
3747:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3748:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3749:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3750:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3751:                     campo2is  WITH "00:00", ;

*-- Linhas 3760 a 3857:
3760:     *--------------------------------------------------------------------------
3761:     * MontarComissoesDesconto - Equivalente ao "MontaTbCom" do legado.
3762:     * Filtra localmente cursor_4c_Tdi pela combinacao Tipo+Codigo da linha
3763:     * corrente de grd_4c_Gradei (cursor_4c_Tdt) e atualiza grd_4c_Gradec.
3764:     *--------------------------------------------------------------------------
3765:     PROTECTED PROCEDURE MontarComissoesDesconto()
3766:         LOCAL loc_oGradec, loc_nTipos, loc_cCodTips
3767: 
3768:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
3769: 
3770:         IF !USED("cursor_4c_Tdi")
3771:             RETURN
3772:         ENDIF
3773: 
3774:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3775:             SELECT cursor_4c_Tdi
3776:             SET FILTER TO .F.
3777:             loc_oGradec.Refresh()
3778:             RETURN
3779:         ENDIF
3780: 
3781:         loc_nTipos   = cursor_4c_Tdt.tipos
3782:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3783: 
3784:         SELECT cursor_4c_Tdi
3785:         SET FILTER TO tipos = loc_nTipos AND ALLTRIM(codtips) = loc_cCodTips
3786:         GO TOP IN cursor_4c_Tdi
3787:         loc_oGradec.Refresh()
3788:     ENDPROC
3789: 
3790:     *--------------------------------------------------------------------------
3791:     * GradeiDescAfterRowColChange - troca de linha em grd_4c_Gradei (pagina
3792:     * "Descontos / Comissoes"): marca a linha corrente (flag "regs",
3793:     * compartilhada com grd_4c_GradeI de PgConfDesconto), refresca os
3794:     * controles bindados a cursor_4c_Tdt (formulas 1a/2a, comissao, fator/
3795:     * descritivo, ignora cotacao) e reconfigura grd_4c_Gradec (comissoes)
3796:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3797:     *--------------------------------------------------------------------------
3798:     PROCEDURE GradeiDescAfterRowColChange(par_nColIndex)
3799:         LOCAL loc_oCnt
3800: 
3801:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3802:             RETURN
3803:         ENDIF
3804: 
3805:         SELECT cursor_4c_Tdt
3806:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3807:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3808: 
3809:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3810:         loc_oCnt.grd_4c_Gradei.Refresh()
3811:         loc_oCnt.cnt_4c_Formula1.Refresh()
3812:         loc_oCnt.cnt_4c_Formula2.Refresh()
3813:         loc_oCnt.cbo_4c_ComboComis.Refresh()
3814:         loc_oCnt.txt_4c_DescFats.Refresh()
3815:         loc_oCnt.txt_4c_FatorPads.Refresh()
3816:         loc_oCnt.chk_4c_IgnoraCotacao.Refresh()
3817: 
3818:         *-- grd_4c_GradeI de PgConfDesconto compartilha a mesma cursor_4c_Tdt
3819:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3820: 
3821:         THIS.MontarComissoesDesconto()
3822:     ENDPROC
3823: 
3824:     *--------------------------------------------------------------------------
3825:     * GradeiDescColunaEditavelWhen - habilita edicao das colunas de
3826:     * grd_4c_Gradei (Tipo/Codigo/Valor/Fator/Exclui) apenas em INCLUIR/
3827:     * ALTERAR (equivalente ao When original de cada coluna)
3828:     * PUBLIC: BINDEVENT requer metodo publico
3829:     *--------------------------------------------------------------------------
3830:     PROCEDURE GradeiDescColunaEditavelWhen()
3831:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3832:     ENDPROC
3833: 
3834:     *--------------------------------------------------------------------------
3835:     * GradeiDescColumn5Valid - valida coluna "E" (texclus): apenas S, N ou
3836:     * vazio (equivalente ao legado)
3837:     * PUBLIC: BINDEVENT requer metodo publico
3838:     *--------------------------------------------------------------------------
3839:     PROCEDURE GradeiDescColumn5Valid()
3840:         LOCAL loc_oText, loc_cValor
3841: 
3842:         loc_oText = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei.Column5.Text1
3843:         loc_cValor = UPPER(ALLTRIM(loc_oText.Value))
3844: 
3845:         IF !INLIST(loc_cValor, "S", "N", "")
3846:             MsgAviso("Dados Inv" + CHR(225) + "lidos. Informe [S/N/ ]", "")
3847:             RETURN .F.
3848:         ENDIF
3849: 
3850:         RETURN .T.
3851:     ENDPROC
3852: 
3853:     *--------------------------------------------------------------------------
3854:     * GradeiDescCodigoKeyPress / GradeiDescCodigoDblClick - F4/DblClick para
3855:     * lookup do codigo da linha de composicao (Column2), conforme o Tipo
3856:     * (Column1) selecionado na mesma linha
3857:     * PUBLIC: BINDEVENT requer metodo publico + parametros do evento

*-- Linhas 3868 a 3901:
3868: 
3869:     *--------------------------------------------------------------------------
3870:     * AbrirLookupCodigoComposicao - Busca o codigo da linha corrente de
3871:     * grd_4c_Gradei (cursor_4c_Tdt.codtips) na tabela correspondente ao
3872:     * Tipo (cursor_4c_Tdt.tipos), igual ao Do Case do legado:
3873:     * 1=Grupo(SigCdGrp/cgrus) 2=Linha(SigCdLin/linhas) 3=Gr.Venda(SigCdCol/
3874:     * colecoes) 4=Produto(SigCdPro/cpros) 5=Moeda(SigCdMoe/cmoes)
3875:     * 6=Unidade(SigCdUni/cunis) 7=Feitio(SigPrFti/cods) 8=SubGrupo(SigCdPsg/
3876:     * codigos) 9=Finalidade(SigCdFip/cods)
3877:     *--------------------------------------------------------------------------
3878:     PROCEDURE AbrirLookupCodigoComposicao()
3879:         LOCAL loc_oGradei, loc_nTipos, loc_cTabela, loc_cCampo, loc_cDescCampo, ;
3880:               loc_cTitulo, loc_cValor, loc_oBusca
3881: 
3882:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3883:             RETURN
3884:         ENDIF
3885: 
3886:         loc_oGradei = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei
3887:         loc_nTipos  = cursor_4c_Tdt.tipos
3888:         loc_cValor  = ALLTRIM(cursor_4c_Tdt.codtips)
3889: 
3890:         DO CASE
3891:             CASE loc_nTipos = 1
3892:                 loc_cTabela = "SigCdGrp"  && Grupo
3893:                 loc_cCampo = "cgrus"
3894:                 loc_cDescCampo = "dgrus"
3895:                 loc_cTitulo = "Grupos"
3896:             CASE loc_nTipos = 2
3897:                 loc_cTabela = "SigCdLin"  && Linha
3898:                 loc_cCampo = "linhas"
3899:                 loc_cDescCampo = "descs"
3900:                 loc_cTitulo = "Linhas"
3901:             CASE loc_nTipos = 3

*-- Linhas 3945 a 3964:
3945: 
3946:             IF VARTYPE(loc_oBusca) = "O"
3947:                 IF !loc_oBusca.this_lAchouRegistro
3948:                     loc_oBusca.mAddColuna(loc_cCampo, "", "C" + CHR(243) + "digo")
3949:                     loc_oBusca.mAddColuna(loc_cDescCampo, "", "Descri" + CHR(231) + CHR(227) + "o")
3950:                     loc_oBusca.Show()
3951:                 ENDIF
3952: 
3953:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaComposicao")
3954:                     SELECT cursor_4c_BuscaComposicao
3955:                     REPLACE codtips WITH ALLTRIM(EVALUATE("cursor_4c_BuscaComposicao." + loc_cCampo)) IN cursor_4c_Tdt
3956:                     loc_oGradei.Refresh()
3957:                 ENDIF
3958: 
3959:                 loc_oBusca.Release()
3960:             ENDIF
3961:         CATCH TO loException
3962:             MostrarErro(loException, "FormTbv.AbrirLookupCodigoComposicao")
3963:         ENDTRY
3964: 

*-- Linhas 3985 a 4005:
3985:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3986:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3987: 
3988:         loc_oPgDesc.grd_4c_Gradei.Refresh()
3989:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3990:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
3991:         THIS.MontarComissoesDesconto()
3992:     ENDPROC
3993: 
3994:     *--------------------------------------------------------------------------
3995:     * BtnExcluirComposicaoClick - Remove a linha corrente de composicao
3996:     * (cursor_4c_Tdt); bloqueia se ainda houver comissoes vinculadas
3997:     * (equivalente ao legado - "Exclua primeiro as comissoes...")
3998:     * PUBLIC: BINDEVENT requer metodo publico
3999:     *--------------------------------------------------------------------------
4000:     PROCEDURE BtnExcluirComposicaoClick()
4001:         LOCAL loc_oPgDesc
4002: 
4003:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
4004:             RETURN
4005:         ENDIF

*-- Linhas 4020 a 4102:
4020:             REPLACE regs WITH 1 IN cursor_4c_Tdt
4021:         ENDIF
4022: 
4023:         loc_oPgDesc.grd_4c_Gradei.Refresh()
4024:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
4025:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4026:         THIS.MontarComissoesDesconto()
4027:     ENDPROC
4028: 
4029:     *--------------------------------------------------------------------------
4030:     * BtnInserirComissaoClick - Inclui uma nova comissao (cursor_4c_Tdi)
4031:     * para a linha corrente de composicao (Tipo/Codigo)
4032:     * PUBLIC: BINDEVENT requer metodo publico
4033:     *--------------------------------------------------------------------------
4034:     PROCEDURE BtnInserirComissaoClick()
4035:         LOCAL loc_oPgDesc
4036: 
4037:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") ;
4038:                 OR EOF("cursor_4c_Tdt") OR !USED("cursor_4c_Tdi")
4039:             RETURN
4040:         ENDIF
4041: 
4042:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4043: 
4044:         INSERT INTO cursor_4c_Tdi (codigos, tipos, codtips) VALUES ;
4045:             (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo), cursor_4c_Tdt.tipos, ALLTRIM(cursor_4c_Tdt.codtips))
4046: 
4047:         THIS.MontarComissoesDesconto()
4048:         loc_oPgDesc.grd_4c_Gradec.Column1.SetFocus
4049:     ENDPROC
4050: 
4051:     *--------------------------------------------------------------------------
4052:     * BtnExcluirComissaoClick - Remove a comissao corrente (cursor_4c_Tdi)
4053:     * PUBLIC: BINDEVENT requer metodo publico
4054:     *--------------------------------------------------------------------------
4055:     PROCEDURE BtnExcluirComissaoClick()
4056:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4057:             RETURN
4058:         ENDIF
4059: 
4060:         SELECT cursor_4c_Tdi
4061:         DELETE
4062:         GO BOTTOM IN cursor_4c_Tdi
4063: 
4064:         THIS.MontarComissoesDesconto()
4065:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec.Column1.SetFocus
4066:     ENDPROC
4067: 
4068:     *--------------------------------------------------------------------------
4069:     * GradecColumn1Valid / GradecColumn2Valid - Grupo/Conta da comissao.
4070:     * Simplificado em relacao ao legado: NAO reproduz as checagens de
4071:     * acesso contabil (fAcessoContab/fAcessoContas do Framework legado -
4072:     * fora do escopo desta migracao). Column2 (Conta) valida contra
4073:     * SigCdCli e preenche automaticamente o Grupo quando vazio.
4074:     * PUBLIC: BINDEVENT requer metodo publico
4075:     *--------------------------------------------------------------------------
4076:     PROCEDURE GradecColumn1Valid()
4077:         RETURN .T.
4078:     ENDPROC
4079: 
4080:     PROCEDURE GradecColumn2Valid()
4081:         LOCAL loc_oGradec, loc_cConta, loc_cSQL
4082: 
4083:         IF !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4084:             RETURN .T.
4085:         ENDIF
4086: 
4087:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
4088:         loc_cConta  = ALLTRIM(loc_oGradec.Column2.Text1.Value)
4089: 
4090:         IF EMPTY(loc_cConta)
4091:             RETURN .T.
4092:         ENDIF
4093: 
4094:         TRY
4095:             loc_cSQL = "SELECT iclis, grupos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
4096: 
4097:             IF USED("cursor_4c_BuscaConta")
4098:                 USE IN cursor_4c_BuscaConta
4099:             ENDIF
4100: 
4101:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") < 1 OR !USED("cursor_4c_BuscaConta") OR EOF("cursor_4c_BuscaConta")
4102:                 MsgAviso("Conta Inv" + CHR(225) + "lida !!!", "Acesso Negado")

