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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS GRID (3043 linhas total):

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

*-- Linhas 1345 a 1550:
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
1532:     PROTECTED PROCEDURE ReconfigurarGrade()
1533:     *==========================================================================
1534:         WITH THIS.grd_4c_Produto
1535:             .RecordSource          = "cursor_4c_Produtos"
1536:             .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
1537:             .Column2.ControlSource = "cursor_4c_Produtos.CPros"
1538:             .Column3.ControlSource = "cursor_4c_Produtos.DPros"
1539:             .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
1540:             .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
1541:             .Column6.ControlSource = "cursor_4c_Produtos.PVarias"
1542:             .Column7.ControlSource = "cursor_4c_Produtos.CustoAfs"
1543:             .Column8.ControlSource = "cursor_4c_Produtos.CustoFs"
1544:             .Column9.ControlSource = "cursor_4c_Produtos.CVarias"
1545:         ENDWITH
1546:     ENDPROC
1547: 
1548:     *==========================================================================
1549:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1550:     *==========================================================================

*-- Linhas 1705 a 1723:
1705:                         GO TOP
1706:                         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1707:                         THIS.cmd_4c_Imprimir.Enabled          = .T.
1708:                         THIS.grd_4c_Produto.SetFocus()
1709:                     ELSE
1710:                         MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
1711:                         THIS.txt_4c_CFornecs.SetFocus()
1712:                     ENDIF
1713:                 OTHERWISE
1714:                     THIS.ConfigurarPaginaLista()
1715:             ENDCASE
1716: 
1717:             THIS.Refresh()
1718:         CATCH TO loc_oErro
1719:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1720:                     "Erro AlternarPagina")
1721:         ENDTRY
1722:     ENDPROC
1723: 

*-- Linhas 1798 a 1816:
1798:             SELECT cursor_4c_Produtos
1799:             IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1800:                 MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
1801:                 THIS.grd_4c_Produto.SetFocus()
1802:                 RETURN
1803:             ENDIF
1804: 
1805:             *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
1806:             THIS.GrdAfterRowColChange(1)
1807:             THIS.img_4c_Produto.Visible = .T.
1808:             THIS.img_4c_Produto.Refresh()
1809:         CATCH TO loc_oErro
1810:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1811:                     "Erro BtnVisualizarClick")
1812:         ENDTRY
1813:     ENDPROC
1814: 
1815:     *==========================================================================
1816:     * BtnExcluirClick - Remove produto(s) do resultado corrente do recalculo

*-- Linhas 1844 a 1884:
1844:                 IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1845:                     MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
1846:                              "Aviso")
1847:                     THIS.grd_4c_Produto.SetFocus()
1848:                     RETURN
1849:                 ENDIF
1850:                 loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1851:                 IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
1852:                                 " do rec" + CHR(225) + "lculo?", ;
1853:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1854:                     RETURN
1855:                 ENDIF
1856:                 SELECT cursor_4c_Produtos
1857:                 DELETE
1858:                 PACK
1859:             ENDIF
1860: 
1861:             *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
1862:             IF RECCOUNT("cursor_4c_Produtos") = 0
1863:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1864:                 THIS.cmd_4c_Imprimir.Enabled          = .F.
1865:                 THIS.img_4c_Produto.Visible           = .F.
1866:                 THIS.img_4c_Produto.Picture           = ""
1867:             ENDIF
1868: 
1869:             THIS.grd_4c_Produto.Refresh()
1870:         CATCH TO loc_oErro
1871:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1872:                     "Erro BtnExcluirClick")
1873:         ENDTRY
1874:     ENDPROC
1875: 
1876:     *==========================================================================
1877:     PROCEDURE BtnProcessarClick()
1878:     *==========================================================================
1879:         LOCAL loc_lSucesso, loc_nVaria, loc_oErro
1880:         loc_lSucesso = .F.
1881:         TRY
1882:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1883:                 IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
1884:                     RETURN

*-- Linhas 1904 a 1941:
1904:                 THIS.cmd_4c_Imprimir.Enabled = .T.
1905:                 THIS.cmd_4c_Imprimir.Refresh()
1906:                 THIS.ReconfigurarGrade()
1907:                 THIS.grd_4c_Produto.Column1.SetFocus()
1908:                 THIS.grd_4c_Produto.Refresh()
1909:                 loc_lSucesso = .T.
1910:             ENDIF
1911:         CATCH TO loc_oErro
1912:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
1913:         ENDTRY
1914:         RETURN loc_lSucesso
1915:     ENDPROC
1916: 
1917:     *==========================================================================
1918:     PROCEDURE BtnAtualizarClick()
1919:     *==========================================================================
1920:         LOCAL loc_lImpEtiq, loc_oErro
1921:         TRY
1922:             loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?")
1923:             IF THIS.this_oBusinessObject.AtualizarPrecos(loc_lImpEtiq)
1924:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1925:                 THIS.cmd_4c_Imprimir.Enabled = .F.
1926:                 THIS.grd_4c_Produto.Refresh()
1927:             ENDIF
1928:         CATCH TO loc_oErro
1929:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnAtualizarClick")
1930:         ENDTRY
1931:     ENDPROC
1932: 
1933:     *==========================================================================
1934:     PROCEDURE BtnEncerrarClick()
1935:     *==========================================================================
1936:         THIS.Release()
1937:     ENDPROC
1938: 
1939:     *==========================================================================
1940:     PROCEDURE BtnImprimirClick()
1941:     *==========================================================================

*-- Linhas 1959 a 1989:
1959:         LOCAL loc_oErro
1960:         TRY
1961:             UPDATE cursor_4c_Produtos SET lMarca = 1
1962:             THIS.grd_4c_Produto.Refresh()
1963:         CATCH TO loc_oErro
1964:             MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
1965:         ENDTRY
1966:     ENDPROC
1967: 
1968:     *==========================================================================
1969:     PROCEDURE BtnDesmarcarClick()
1970:     *==========================================================================
1971:         LOCAL loc_oErro
1972:         TRY
1973:             UPDATE cursor_4c_Produtos SET lMarca = 0
1974:             THIS.grd_4c_Produto.Refresh()
1975:         CATCH TO loc_oErro
1976:             MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
1977:         ENDTRY
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1982:     *==========================================================================
1983:         LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
1984:         TRY
1985:             IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1986:                 RETURN
1987:             ENDIF
1988:             loc_cArquivo = SYS(2023) + "\TempCj.jpg"
1989:             SELECT cursor_4c_Produtos

*-- Linhas 2057 a 2076:
2057:                 RETURN
2058:             ENDIF
2059:             IF !loc_oForm.this_lSelecionou
2060:                 loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2061:                 loc_oForm.mAddColuna("RClis", "", "Nome")
2062:                 loc_oForm.Show()
2063:             ENDIF
2064:             IF loc_oForm.this_lSelecionou
2065:                 IF USED("cursor_4c_BuscaFor")
2066:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.IClis)
2067:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.RClis)
2068:                 ENDIF
2069:             ENDIF
2070:             IF USED("cursor_4c_BuscaFor")
2071:                 USE IN cursor_4c_BuscaFor
2072:             ENDIF
2073:             loc_oForm.Release()
2074:         CATCH TO loc_oErro
2075:             IF USED("cursor_4c_BuscaFor")
2076:                 USE IN cursor_4c_BuscaFor

*-- Linhas 2146 a 2165:
2146:                 RETURN
2147:             ENDIF
2148:             IF !loc_oForm.this_lSelecionou
2149:                 loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2150:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2151:                 loc_oForm.Show()
2152:             ENDIF
2153:             IF loc_oForm.this_lSelecionou
2154:                 IF USED("cursor_4c_BuscaGGr")
2155:                     IF par_lIni
2156:                         THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2157:                     ELSE
2158:                         THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2159:                     ENDIF
2160:                 ENDIF
2161:             ENDIF
2162:             IF USED("cursor_4c_BuscaGGr")
2163:                 USE IN cursor_4c_BuscaGGr
2164:             ENDIF
2165:             loc_oForm.Release()

*-- Linhas 2238 a 2257:
2238:                 RETURN
2239:             ENDIF
2240:             IF !loc_oForm.this_lSelecionou
2241:                 loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
2242:                 loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2243:                 loc_oForm.Show()
2244:             ENDIF
2245:             IF loc_oForm.this_lSelecionou
2246:                 IF USED("cursor_4c_BuscaGrp")
2247:                     IF par_lIni
2248:                         THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2249:                     ELSE
2250:                         THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2251:                     ENDIF
2252:                 ENDIF
2253:             ENDIF
2254:             IF USED("cursor_4c_BuscaGrp")
2255:                 USE IN cursor_4c_BuscaGrp
2256:             ENDIF
2257:             loc_oForm.Release()

*-- Linhas 2330 a 2349:
2330:                 RETURN
2331:             ENDIF
2332:             IF !loc_oForm.this_lSelecionou
2333:                 loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
2334:                 loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2335:                 loc_oForm.Show()
2336:             ENDIF
2337:             IF loc_oForm.this_lSelecionou
2338:                 IF USED("cursor_4c_BuscaSgr")
2339:                     IF par_lIni
2340:                         THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2341:                     ELSE
2342:                         THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2343:                     ENDIF
2344:                 ENDIF
2345:             ENDIF
2346:             IF USED("cursor_4c_BuscaSgr")
2347:                 USE IN cursor_4c_BuscaSgr
2348:             ENDIF
2349:             loc_oForm.Release()

*-- Linhas 2422 a 2441:
2422:                 RETURN
2423:             ENDIF
2424:             IF !loc_oForm.this_lSelecionou
2425:                 loc_oForm.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2426:                 loc_oForm.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2427:                 loc_oForm.Show()
2428:             ENDIF
2429:             IF loc_oForm.this_lSelecionou
2430:                 IF USED("cursor_4c_BuscaUni")
2431:                     IF par_lIni
2432:                         THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2433:                     ELSE
2434:                         THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2435:                     ENDIF
2436:                 ENDIF
2437:             ENDIF
2438:             IF USED("cursor_4c_BuscaUni")
2439:                 USE IN cursor_4c_BuscaUni
2440:             ENDIF
2441:             loc_oForm.Release()

*-- Linhas 2514 a 2533:
2514:                 RETURN
2515:             ENDIF
2516:             IF !loc_oForm.this_lSelecionou
2517:                 loc_oForm.mAddColuna("Linhas", "", "Linha")
2518:                 loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2519:                 loc_oForm.Show()
2520:             ENDIF
2521:             IF loc_oForm.this_lSelecionou
2522:                 IF USED("cursor_4c_BuscaLin")
2523:                     IF par_lIni
2524:                         THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2525:                     ELSE
2526:                         THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2527:                     ENDIF
2528:                 ENDIF
2529:             ENDIF
2530:             IF USED("cursor_4c_BuscaLin")
2531:                 USE IN cursor_4c_BuscaLin
2532:             ENDIF
2533:             loc_oForm.Release()

*-- Linhas 2606 a 2625:
2606:                 RETURN
2607:             ENDIF
2608:             IF !loc_oForm.this_lSelecionou
2609:                 loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
2610:                 loc_oForm.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2611:                 loc_oForm.Show()
2612:             ENDIF
2613:             IF loc_oForm.this_lSelecionou
2614:                 IF USED("cursor_4c_BuscaCol")
2615:                     IF par_lIni
2616:                         THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2617:                     ELSE
2618:                         THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2619:                     ENDIF
2620:                 ENDIF
2621:             ENDIF
2622:             IF USED("cursor_4c_BuscaCol")
2623:                 USE IN cursor_4c_BuscaCol
2624:             ENDIF
2625:             loc_oForm.Release()

*-- Linhas 2698 a 2717:
2698:                 RETURN
2699:             ENDIF
2700:             IF !loc_oForm.this_lSelecionou
2701:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2702:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2703:                 loc_oForm.Show()
2704:             ENDIF
2705:             IF loc_oForm.this_lSelecionou
2706:                 IF USED("cursor_4c_BuscaMoe")
2707:                     IF par_lIni
2708:                         THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2709:                     ELSE
2710:                         THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2711:                     ENDIF
2712:                 ENDIF
2713:             ENDIF
2714:             IF USED("cursor_4c_BuscaMoe")
2715:                 USE IN cursor_4c_BuscaMoe
2716:             ENDIF
2717:             loc_oForm.Release()

*-- Linhas 2762 a 2781:
2762:                 RETURN
2763:             ENDIF
2764:             IF !loc_oForm.this_lSelecionou
2765:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2766:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2767:                 loc_oForm.Show()
2768:             ENDIF
2769:             IF loc_oForm.this_lSelecionou
2770:                 IF USED("cursor_4c_BuscaFti")
2771:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_BuscaFti.Cods)
2772:                 ENDIF
2773:             ENDIF
2774:             IF USED("cursor_4c_BuscaFti")
2775:                 USE IN cursor_4c_BuscaFti
2776:             ENDIF
2777:             loc_oForm.Release()
2778:         CATCH TO loc_oErro
2779:             IF USED("cursor_4c_BuscaFti")
2780:                 USE IN cursor_4c_BuscaFti
2781:             ENDIF

*-- Linhas 2822 a 2841:
2822:                 RETURN
2823:             ENDIF
2824:             IF !loc_oForm.this_lSelecionou
2825:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2826:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2827:                 loc_oForm.Show()
2828:             ENDIF
2829:             IF loc_oForm.this_lSelecionou
2830:                 IF USED("cursor_4c_BuscaNMkp")
2831:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_BuscaNMkp.Cods)
2832:                 ENDIF
2833:             ENDIF
2834:             IF USED("cursor_4c_BuscaNMkp")
2835:                 USE IN cursor_4c_BuscaNMkp
2836:             ENDIF
2837:             loc_oForm.Release()
2838:         CATCH TO loc_oErro
2839:             IF USED("cursor_4c_BuscaNMkp")
2840:                 USE IN cursor_4c_BuscaNMkp
2841:             ENDIF

*-- Linhas 2989 a 3007:
2989:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
2990:                 THIS.cmd_4c_Imprimir.Enabled          = .T.
2991:                 THIS.ReconfigurarGrade()
2992:                 THIS.grd_4c_Produto.Refresh()
2993:                 loc_lSucesso = .T.
2994:             ENDIF
2995:         CATCH TO loc_oErro
2996:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
2997:                 "Erro CarregarLista")
2998:         ENDTRY
2999:         RETURN loc_lSucesso
3000:     ENDPROC
3001: 
3002:     *==========================================================================
3003:     PROCEDURE BtnBuscarClick()
3004:     *-- Buscar = Processar no contexto OPERACIONAL.
3005:     *-- Executa o recalculo com os filtros atuais e popula o grid.
3006:     *==========================================================================
3007:         THIS.BtnProcessarClick()

