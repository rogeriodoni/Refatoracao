# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1359: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS GRID (3021 linhas total):

*-- Linhas 91 a 109:
91:                     BINDEVENT(THIS.txt_4c_NMrk,    "KeyPress", THIS, "TxtNMrkKeyPress")
92:                     BINDEVENT(THIS.txt_4c_Encargo, "KeyPress", THIS, "TxtEncargoKeyPress")
93: 
94:                     BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")
95: 
96:                     THIS.TornarControlesVisiveis(THIS)
97: 
98:                     THIS.opt_4c_Compra.Value   = 3
99:                     THIS.opt_4c_Pven.Value     = 2
100: 
101:                     THIS.OptRecalcChange()
102: 
103:                     THIS.txt_4c_CFornecs.SetFocus()
104: 
105:                     IF THIS.this_lAutomatico
106:                         THIS.this_oBusinessObject.ProcessaAutomatico()
107:                         THIS.Release()
108:                         loc_lSucesso = .T.
109:                     ENDIF

*-- Linhas 1345 a 1536:
1345:     *==========================================================================
1346:     PROTECTED PROCEDURE ConfigurarGrade()
1347:     *==========================================================================
1348:         THIS.AddObject("grd_4c_Produto", "Grid")
1349:         WITH THIS.grd_4c_Produto
1350:             .Top          = 351
1351:             .Left         = 12
1352:             .Width        = 935
1353:             .Height       = 244
1354:             .ColumnCount  = 9
1355:             .FontName     = "Tahoma"
1356:             .FontSize     = 8
1357:             .RowHeight    = 18
1358:             .ScrollBars   = 2
1359:             .RecordSource = "cursor_4c_Produtos"
1360:             .ReadOnly     = .F.
1361: 
1362:             *-- Column1: CheckBox lMarca
1363:             WITH .Column1
1364:                 .Width        = 17
1365:                 .HeaderHeight       = 0
1366:                 .Alignment    = 3
1367:                 .Movable      = .F.
1368:                 .Resizable    = .F.
1369:                 .Sparse       = .F.
1370:                 .FontName     = "Tahoma"
1371:                 .FontSize     = 8
1372:                 .AddObject("Check1", "CheckBox")
1373:                 .Check1.Caption = ""
1374:                 .Check1.Value   = 0
1375:                 .CurrentControl = "Check1"
1376:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
1377:                 WITH .Header1
1378:                     .Caption   = ""
1379:                     .FontName  = "Tahoma"
1380:                     .FontSize  = 8
1381:                     .Alignment = 2
1382:                     .ForeColor = RGB(36, 84, 155)
1383:                 ENDWITH
1384:             ENDWITH
1385: 
1386:             *-- Column2: CPros
1387:             WITH .Column2
1388:                 .Width         = 108
1389:                 .Movable       = .F.
1390:                 .Resizable     = .F.
1391:                 .FontName      = "Tahoma"
1392:                 .FontSize      = 8
1393:                 .ControlSource = "cursor_4c_Produtos.CPros"
1394:                 WITH .Header1
1395:                     .Caption   = "Produto"
1396:                     .FontName  = "Tahoma"
1397:                     .FontSize  = 8
1398:                     .Alignment = 2
1399:                     .ForeColor = RGB(36, 84, 155)
1400:                 ENDWITH
1401:             ENDWITH
1402: 
1403:             *-- Column3: DPros
1404:             WITH .Column3
1405:                 .Width         = 290
1406:                 .Movable       = .F.
1407:                 .Resizable     = .F.
1408:                 .FontName      = "Tahoma"
1409:                 .FontSize      = 8
1410:                 .ControlSource = "cursor_4c_Produtos.DPros"
1411:                 WITH .Header1
1412:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1413:                     .FontName  = "Tahoma"
1414:                     .FontSize  = 8
1415:                     .Alignment = 2
1416:                     .ForeColor = RGB(36, 84, 155)
1417:                 ENDWITH
1418:             ENDWITH
1419: 
1420:             *-- Column4: ValAnt
1421:             WITH .Column4
1422:                 .Width         = 80
1423:                 .Movable       = .F.
1424:                 .Resizable     = .F.
1425:                 .FontName      = "Tahoma"
1426:                 .FontSize      = 8
1427:                 .InputMask     = "999,999,999.99"
1428:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
1429:                 WITH .Header1
1430:                     .Caption   = "Venda Ant."
1431:                     .FontName  = "Tahoma"
1432:                     .FontSize  = 8
1433:                     .Alignment = 2
1434:                     .ForeColor = RGB(36, 84, 155)
1435:                 ENDWITH
1436:             ENDWITH
1437: 
1438:             *-- Column5: ValAtu
1439:             WITH .Column5
1440:                 .Width         = 80
1441:                 .Movable       = .F.
1442:                 .Resizable     = .F.
1443:                 .FontName      = "Tahoma"
1444:                 .FontSize      = 8
1445:                 .InputMask     = "999,999,999.99"
1446:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
1447:                 WITH .Header1
1448:                     .Caption   = "Venda Atual"
1449:                     .FontName  = "Tahoma"
1450:                     .FontSize  = 8
1451:                     .Alignment = 2
1452:                     .ForeColor = RGB(36, 84, 155)
1453:                 ENDWITH
1454:             ENDWITH
1455: 
1456:             *-- Column6: PVarias (ReadOnly)
1457:             WITH .Column6
1458:                 .Width         = 80
1459:                 .Movable       = .F.
1460:                 .Resizable     = .F.
1461:                 .ReadOnly      = .T.
1462:                 .FontName      = "Tahoma"
1463:                 .FontSize      = 8
1464:                 .InputMask     = "999,999.99"
1465:                 .ControlSource = "cursor_4c_Produtos.PVarias"
1466:                 WITH .Header1
1467:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1468:                     .FontName  = "Tahoma"
1469:                     .FontSize  = 8
1470:                     .Alignment = 2
1471:                     .ForeColor = RGB(36, 84, 155)
1472:                 ENDWITH
1473:             ENDWITH
1474: 
1475:             *-- Column7: CustoAfs (ReadOnly)
1476:             WITH .Column7
1477:                 .Width         = 80
1478:                 .Movable       = .F.
1479:                 .Resizable     = .F.
1480:                 .ReadOnly      = .T.
1481:                 .FontName      = "Tahoma"
1482:                 .FontSize      = 8
1483:                 .InputMask     = "999,999,999.9999"
1484:                 .ControlSource = "cursor_4c_Produtos.CustoAfs"
1485:                 WITH .Header1
1486:                     .Caption   = "Custo Ant."
1487:                     .FontName  = "Tahoma"
1488:                     .FontSize  = 8
1489:                     .Alignment = 2
1490:                 ENDWITH
1491:             ENDWITH
1492: 
1493:             *-- Column8: CustoFs (ReadOnly)
1494:             WITH .Column8
1495:                 .Width         = 80
1496:                 .Movable       = .F.
1497:                 .Resizable     = .F.
1498:                 .ReadOnly      = .T.
1499:                 .FontName      = "Tahoma"
1500:                 .FontSize      = 8
1501:                 .InputMask     = "999,999,999.9999"
1502:                 .ControlSource = "cursor_4c_Produtos.CustoFs"
1503:                 WITH .Header1
1504:                     .Caption   = "Custo Atual"
1505:                     .FontName  = "Tahoma"
1506:                     .FontSize  = 8
1507:                     .Alignment = 2
1508:                 ENDWITH
1509:             ENDWITH
1510: 
1511:             *-- Column9: CVarias (ReadOnly)
1512:             WITH .Column9
1513:                 .Width         = 80
1514:                 .Movable       = .F.
1515:                 .Resizable     = .F.
1516:                 .ReadOnly      = .T.
1517:                 .FontName      = "Tahoma"
1518:                 .FontSize      = 8
1519:                 .InputMask     = "999,999.99"
1520:                 .ControlSource = "cursor_4c_Produtos.CVarias"
1521:                 WITH .Header1
1522:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1523:                     .FontName  = "Tahoma"
1524:                     .FontSize  = 8
1525:                     .Alignment = 2
1526:                 ENDWITH
1527:             ENDWITH
1528:         ENDWITH
1529:     ENDPROC
1530: 
1531:     *==========================================================================
1532:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1533:     *==========================================================================
1534:         LOCAL loc_i, loc_oControl
1535:         FOR loc_i = 1 TO par_oContainer.ControlCount
1536:             loc_oControl = par_oContainer.Controls(loc_i)

*-- Linhas 1685 a 1703:
1685:                         GO TOP
1686:                         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1687:                         THIS.cmd_4c_Imprimir.Enabled          = .T.
1688:                         THIS.grd_4c_Produto.SetFocus()
1689:                     ELSE
1690:                         MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
1691:                         THIS.txt_4c_CFornecs.SetFocus()
1692:                     ENDIF
1693:                 OTHERWISE
1694:                     THIS.ConfigurarPaginaLista()
1695:             ENDCASE
1696: 
1697:             THIS.Refresh()
1698:         CATCH TO loc_oErro
1699:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1700:                     "Erro AlternarPagina")
1701:         ENDTRY
1702:     ENDPROC
1703: 

*-- Linhas 1778 a 1796:
1778:             SELECT cursor_4c_Produtos
1779:             IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1780:                 MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
1781:                 THIS.grd_4c_Produto.SetFocus()
1782:                 RETURN
1783:             ENDIF
1784: 
1785:             *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
1786:             THIS.GrdAfterRowColChange(1)
1787:             THIS.img_4c_Produto.Visible = .T.
1788:             THIS.img_4c_Produto.Refresh()
1789:         CATCH TO loc_oErro
1790:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1791:                     "Erro BtnVisualizarClick")
1792:         ENDTRY
1793:     ENDPROC
1794: 
1795:     *==========================================================================
1796:     * BtnExcluirClick - Remove produto(s) do resultado corrente do recalculo

*-- Linhas 1824 a 1864:
1824:                 IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1825:                     MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
1826:                              "Aviso")
1827:                     THIS.grd_4c_Produto.SetFocus()
1828:                     RETURN
1829:                 ENDIF
1830:                 loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1831:                 IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
1832:                                 " do rec" + CHR(225) + "lculo?", ;
1833:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1834:                     RETURN
1835:                 ENDIF
1836:                 SELECT cursor_4c_Produtos
1837:                 DELETE
1838:                 PACK
1839:             ENDIF
1840: 
1841:             *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
1842:             IF RECCOUNT("cursor_4c_Produtos") = 0
1843:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1844:                 THIS.cmd_4c_Imprimir.Enabled          = .F.
1845:                 THIS.img_4c_Produto.Visible           = .F.
1846:                 THIS.img_4c_Produto.Picture           = ""
1847:             ENDIF
1848: 
1849:             THIS.grd_4c_Produto.Refresh()
1850:         CATCH TO loc_oErro
1851:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1852:                     "Erro BtnExcluirClick")
1853:         ENDTRY
1854:     ENDPROC
1855: 
1856:     *==========================================================================
1857:     PROCEDURE BtnProcessarClick()
1858:     *==========================================================================
1859:         LOCAL loc_lSucesso, loc_nVaria, loc_oErro
1860:         loc_lSucesso = .F.
1861:         TRY
1862:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1863:                 IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
1864:                     RETURN

*-- Linhas 1883 a 1920:
1883:                 THIS.cmg_4c_Botoes.Buttons(2).Refresh()
1884:                 THIS.cmd_4c_Imprimir.Enabled = .T.
1885:                 THIS.cmd_4c_Imprimir.Refresh()
1886:                 THIS.grd_4c_Produto.Column1.SetFocus()
1887:                 THIS.grd_4c_Produto.Refresh()
1888:                 loc_lSucesso = .T.
1889:             ENDIF
1890:         CATCH TO loc_oErro
1891:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
1892:         ENDTRY
1893:         RETURN loc_lSucesso
1894:     ENDPROC
1895: 
1896:     *==========================================================================
1897:     PROCEDURE BtnAtualizarClick()
1898:     *==========================================================================
1899:         LOCAL loc_lImpEtiq, loc_oErro
1900:         TRY
1901:             loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?")
1902:             IF THIS.this_oBusinessObject.AtualizarPrecos(loc_lImpEtiq)
1903:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1904:                 THIS.cmd_4c_Imprimir.Enabled = .F.
1905:                 THIS.grd_4c_Produto.Refresh()
1906:             ENDIF
1907:         CATCH TO loc_oErro
1908:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnAtualizarClick")
1909:         ENDTRY
1910:     ENDPROC
1911: 
1912:     *==========================================================================
1913:     PROCEDURE BtnEncerrarClick()
1914:     *==========================================================================
1915:         THIS.Release()
1916:     ENDPROC
1917: 
1918:     *==========================================================================
1919:     PROCEDURE BtnImprimirClick()
1920:     *==========================================================================

*-- Linhas 1938 a 1968:
1938:         LOCAL loc_oErro
1939:         TRY
1940:             UPDATE cursor_4c_Produtos SET lMarca = 1
1941:             THIS.grd_4c_Produto.Refresh()
1942:         CATCH TO loc_oErro
1943:             MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
1944:         ENDTRY
1945:     ENDPROC
1946: 
1947:     *==========================================================================
1948:     PROCEDURE BtnDesmarcarClick()
1949:     *==========================================================================
1950:         LOCAL loc_oErro
1951:         TRY
1952:             UPDATE cursor_4c_Produtos SET lMarca = 0
1953:             THIS.grd_4c_Produto.Refresh()
1954:         CATCH TO loc_oErro
1955:             MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
1956:         ENDTRY
1957:     ENDPROC
1958: 
1959:     *==========================================================================
1960:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1961:     *==========================================================================
1962:         LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
1963:         TRY
1964:             IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1965:                 RETURN
1966:             ENDIF
1967:             loc_cArquivo = SYS(2023) + "\TempCj.jpg"
1968:             SELECT cursor_4c_Produtos

*-- Linhas 2036 a 2055:
2036:                 RETURN
2037:             ENDIF
2038:             IF !loc_oForm.this_lSelecionou
2039:                 loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2040:                 loc_oForm.mAddColuna("RClis", "", "Nome")
2041:                 loc_oForm.Show()
2042:             ENDIF
2043:             IF loc_oForm.this_lSelecionou
2044:                 IF USED("cursor_4c_BuscaFor")
2045:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.IClis)
2046:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.RClis)
2047:                 ENDIF
2048:             ENDIF
2049:             IF USED("cursor_4c_BuscaFor")
2050:                 USE IN cursor_4c_BuscaFor
2051:             ENDIF
2052:             loc_oForm.Release()
2053:         CATCH TO loc_oErro
2054:             IF USED("cursor_4c_BuscaFor")
2055:                 USE IN cursor_4c_BuscaFor

*-- Linhas 2125 a 2144:
2125:                 RETURN
2126:             ENDIF
2127:             IF !loc_oForm.this_lSelecionou
2128:                 loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2129:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2130:                 loc_oForm.Show()
2131:             ENDIF
2132:             IF loc_oForm.this_lSelecionou
2133:                 IF USED("cursor_4c_BuscaGGr")
2134:                     IF par_lIni
2135:                         THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2136:                     ELSE
2137:                         THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2138:                     ENDIF
2139:                 ENDIF
2140:             ENDIF
2141:             IF USED("cursor_4c_BuscaGGr")
2142:                 USE IN cursor_4c_BuscaGGr
2143:             ENDIF
2144:             loc_oForm.Release()

*-- Linhas 2217 a 2236:
2217:                 RETURN
2218:             ENDIF
2219:             IF !loc_oForm.this_lSelecionou
2220:                 loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
2221:                 loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2222:                 loc_oForm.Show()
2223:             ENDIF
2224:             IF loc_oForm.this_lSelecionou
2225:                 IF USED("cursor_4c_BuscaGrp")
2226:                     IF par_lIni
2227:                         THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2228:                     ELSE
2229:                         THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2230:                     ENDIF
2231:                 ENDIF
2232:             ENDIF
2233:             IF USED("cursor_4c_BuscaGrp")
2234:                 USE IN cursor_4c_BuscaGrp
2235:             ENDIF
2236:             loc_oForm.Release()

*-- Linhas 2309 a 2328:
2309:                 RETURN
2310:             ENDIF
2311:             IF !loc_oForm.this_lSelecionou
2312:                 loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
2313:                 loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2314:                 loc_oForm.Show()
2315:             ENDIF
2316:             IF loc_oForm.this_lSelecionou
2317:                 IF USED("cursor_4c_BuscaSgr")
2318:                     IF par_lIni
2319:                         THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2320:                     ELSE
2321:                         THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2322:                     ENDIF
2323:                 ENDIF
2324:             ENDIF
2325:             IF USED("cursor_4c_BuscaSgr")
2326:                 USE IN cursor_4c_BuscaSgr
2327:             ENDIF
2328:             loc_oForm.Release()

*-- Linhas 2401 a 2420:
2401:                 RETURN
2402:             ENDIF
2403:             IF !loc_oForm.this_lSelecionou
2404:                 loc_oForm.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2405:                 loc_oForm.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2406:                 loc_oForm.Show()
2407:             ENDIF
2408:             IF loc_oForm.this_lSelecionou
2409:                 IF USED("cursor_4c_BuscaUni")
2410:                     IF par_lIni
2411:                         THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2412:                     ELSE
2413:                         THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2414:                     ENDIF
2415:                 ENDIF
2416:             ENDIF
2417:             IF USED("cursor_4c_BuscaUni")
2418:                 USE IN cursor_4c_BuscaUni
2419:             ENDIF
2420:             loc_oForm.Release()

*-- Linhas 2493 a 2512:
2493:                 RETURN
2494:             ENDIF
2495:             IF !loc_oForm.this_lSelecionou
2496:                 loc_oForm.mAddColuna("Linhas", "", "Linha")
2497:                 loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2498:                 loc_oForm.Show()
2499:             ENDIF
2500:             IF loc_oForm.this_lSelecionou
2501:                 IF USED("cursor_4c_BuscaLin")
2502:                     IF par_lIni
2503:                         THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2504:                     ELSE
2505:                         THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2506:                     ENDIF
2507:                 ENDIF
2508:             ENDIF
2509:             IF USED("cursor_4c_BuscaLin")
2510:                 USE IN cursor_4c_BuscaLin
2511:             ENDIF
2512:             loc_oForm.Release()

*-- Linhas 2585 a 2604:
2585:                 RETURN
2586:             ENDIF
2587:             IF !loc_oForm.this_lSelecionou
2588:                 loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
2589:                 loc_oForm.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2590:                 loc_oForm.Show()
2591:             ENDIF
2592:             IF loc_oForm.this_lSelecionou
2593:                 IF USED("cursor_4c_BuscaCol")
2594:                     IF par_lIni
2595:                         THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2596:                     ELSE
2597:                         THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2598:                     ENDIF
2599:                 ENDIF
2600:             ENDIF
2601:             IF USED("cursor_4c_BuscaCol")
2602:                 USE IN cursor_4c_BuscaCol
2603:             ENDIF
2604:             loc_oForm.Release()

*-- Linhas 2677 a 2696:
2677:                 RETURN
2678:             ENDIF
2679:             IF !loc_oForm.this_lSelecionou
2680:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2681:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2682:                 loc_oForm.Show()
2683:             ENDIF
2684:             IF loc_oForm.this_lSelecionou
2685:                 IF USED("cursor_4c_BuscaMoe")
2686:                     IF par_lIni
2687:                         THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2688:                     ELSE
2689:                         THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2690:                     ENDIF
2691:                 ENDIF
2692:             ENDIF
2693:             IF USED("cursor_4c_BuscaMoe")
2694:                 USE IN cursor_4c_BuscaMoe
2695:             ENDIF
2696:             loc_oForm.Release()

*-- Linhas 2741 a 2760:
2741:                 RETURN
2742:             ENDIF
2743:             IF !loc_oForm.this_lSelecionou
2744:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2745:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2746:                 loc_oForm.Show()
2747:             ENDIF
2748:             IF loc_oForm.this_lSelecionou
2749:                 IF USED("cursor_4c_BuscaFti")
2750:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_BuscaFti.Cods)
2751:                 ENDIF
2752:             ENDIF
2753:             IF USED("cursor_4c_BuscaFti")
2754:                 USE IN cursor_4c_BuscaFti
2755:             ENDIF
2756:             loc_oForm.Release()
2757:         CATCH TO loc_oErro
2758:             IF USED("cursor_4c_BuscaFti")
2759:                 USE IN cursor_4c_BuscaFti
2760:             ENDIF

*-- Linhas 2801 a 2820:
2801:                 RETURN
2802:             ENDIF
2803:             IF !loc_oForm.this_lSelecionou
2804:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2805:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2806:                 loc_oForm.Show()
2807:             ENDIF
2808:             IF loc_oForm.this_lSelecionou
2809:                 IF USED("cursor_4c_BuscaNMkp")
2810:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_BuscaNMkp.Cods)
2811:                 ENDIF
2812:             ENDIF
2813:             IF USED("cursor_4c_BuscaNMkp")
2814:                 USE IN cursor_4c_BuscaNMkp
2815:             ENDIF
2816:             loc_oForm.Release()
2817:         CATCH TO loc_oErro
2818:             IF USED("cursor_4c_BuscaNMkp")
2819:                 USE IN cursor_4c_BuscaNMkp
2820:             ENDIF

*-- Linhas 2967 a 2985:
2967:                 GO TOP
2968:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
2969:                 THIS.cmd_4c_Imprimir.Enabled          = .T.
2970:                 THIS.grd_4c_Produto.Refresh()
2971:                 loc_lSucesso = .T.
2972:             ENDIF
2973:         CATCH TO loc_oErro
2974:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
2975:                 "Erro CarregarLista")
2976:         ENDTRY
2977:         RETURN loc_lSucesso
2978:     ENDPROC
2979: 
2980:     *==========================================================================
2981:     PROCEDURE BtnBuscarClick()
2982:     *-- Buscar = Processar no contexto OPERACIONAL.
2983:     *-- Executa o recalculo com os filtros atuais e popula o grid.
2984:     *==========================================================================
2985:         THIS.BtnProcessarClick()

