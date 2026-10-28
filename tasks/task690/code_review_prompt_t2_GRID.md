# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (9)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1567: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1610: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1707: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1736: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1796: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1891: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1930: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2101: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2197: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgc.prg) - TRECHOS RELEVANTES PARA PASS GRID (3822 linhas total):

*-- Linhas 1270 a 1288:
1270:     * Os grids sao ligados aos cursores AQUI porque os 8 cursores locais ja
1271:     * existem neste ponto: o BO eh instanciado no inicio de InicializarForm e
1272:     * cria todos em InicializarCursoresDados. Column.Width vem DEPOIS de
1273:     * RecordSource/ControlSource, que resetam a largura para o default 90.
1274:     *==========================================================================
1275:     PROTECTED PROCEDURE ConfigurarPaginaResultado(par_oPag)
1276:         LOCAL loc_oPgf
1277: 
1278:         par_oPag.AddObject("pgf_4c_Result", "PageFrame")
1279:         loc_oPgf = par_oPag.pgf_4c_Result
1280: 
1281:         WITH loc_oPgf
1282:             .PageCount = 5
1283:             .Top       = 186
1284:             .Left      = 59
1285:             .Width     = 701
1286:             .Height    = 421
1287:             .Tabs      = .T.
1288: 

*-- Linhas 1346 a 1364:
1346:             .DeleteMark       = .F.
1347:             .RecordMark       = .F.
1348:             .ScrollBars       = 2
1349:             .RecordSourceType = 1
1350:             .GridLineColor    = RGB(238, 238, 238)
1351:             .FontName         = "Tahoma"
1352:             .FontSize         = 8
1353:         ENDWITH
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     * ConfigurarAbaSaldo - Page "Saldo" do Result: historico de conta corrente
1358:     * (grade FILHA da grade de saldos pela moeda), saldo por moeda, os dois
1359:     * campos de historico da linha corrente e o botao de impressao do extrato.
1360:     *==========================================================================
1361:     PROTECTED PROCEDURE ConfigurarAbaSaldo(par_oPage)
1362:         *-- shp_historico / shp_saldo / Shape1 - molduras do legado
1363:         par_oPage.AddObject("shp_4c_MoldHistorico", "Shape")
1364:         WITH par_oPage.shp_4c_MoldHistorico

*-- Linhas 1446 a 1475:
1446:         *-- Grades. A configuracao das COLUNAS fica em
1447:         *-- ConfigurarGradesSaldo(), porque o legado a refaz a cada clique em
1448:         *-- Movimentacao (o numero de colunas depende da permissao de SALDO).
1449:         par_oPage.AddObject("grd_4c_Historico", "Grid")
1450:         WITH par_oPage.grd_4c_Historico
1451:             .Top    = 27
1452:             .Left   = 14
1453:             .Width  = 653
1454:             .Height = 220
1455:             .RecordMark   = .F.
1456:             .DeleteMark   = .F.
1457:         ENDWITH
1458: 
1459:         par_oPage.AddObject("grd_4c_Saldo", "Grid")
1460:         WITH par_oPage.grd_4c_Saldo
1461:             .Top    = 274
1462:             .Left   = 14
1463:             .Width  = 156
1464:             .Height = 112
1465:             .RecordMark   = .F.
1466:             .DeleteMark   = .F.
1467:         ENDWITH
1468: 
1469:         *-- Get_Hists / Get_Hist2s: exibem o historico da linha corrente da
1470:         *-- grade. ReadOnly porque o When do legado devolve .F. (o campo
1471:         *-- nunca recebe foco).
1472:         par_oPage.AddObject("txt_4c_Hists", "TextBox")
1473:         WITH par_oPage.txt_4c_Hists
1474:             .Top           = 276
1475:             .Left          = 187

*-- Linhas 1520 a 1583:
1520:         ENDWITH
1521:         BINDEVENT(par_oPage.cmd_4c_ImprimirExtrato, "Click", THIS, "BtnImprimirExtratoClick")
1522: 
1523:         BINDEVENT(par_oPage.grd_4c_Saldo, "AfterRowColChange", THIS, "GradeSaldoAfterRowColChange")
1524:         BINDEVENT(par_oPage.grd_4c_Historico, "AfterRowColChange", THIS, "GradeHistoricoAfterRowColChange")
1525: 
1526:         THIS.ConfigurarGradesSaldo()
1527:     ENDPROC
1528: 
1529:     *==========================================================================
1530:     * ConfigurarGradesSaldo - (re)configura grd_4c_Saldo e grd_4c_Historico.
1531:     *
1532:     * O legado faz isso DENTRO do cmd_movimenta.Click, e nao no SCX, porque o
1533:     * numero de colunas depende da permissao: com acesso ao saldo a grade de
1534:     * historico tem 8 colunas (inclui Saldo) e a de moedas tem 2; sem acesso,
1535:     * 7 e 1, a moldura encolhe 94px e o titulo muda de "Saldo por Moeda" para
1536:     * "Moedas". Como mexer em ColumnCount RECRIA os objetos Column, toda a
1537:     * configuracao (ControlSource / Width / Header) eh refeita aqui - e a
1538:     * Width sempre DEPOIS do ControlSource, que a reseta para o default 90.
1539:     *
1540:     * llSaldo transcrito do legado:
1541:     *     llSaldo = !fChecaAcesso('SIGOPCGC','SALDO') Or llSupervis
1542:     * ATENCAO: o "!" eh do legado e esta preservado (regra #17 - nao inverter
1543:     * sinal de regra de negocio). Como fChecaAcesso em utils\functions.prg eh
1544:     * um stub que devolve SEMPRE .T., o efeito pratico hoje eh: coluna Saldo
1545:     * visivel apenas para o usuario 4CONTROL. Se a intencao do negocio for o
1546:     * contrario, a correcao eh de UMA linha aqui - mas inverter sem confirmar
1547:     * exporia saldo financeiro a quem o legado esconde.
1548:     *==========================================================================
1549:     PROTECTED PROCEDURE ConfigurarGradesSaldo()
1550:         LOCAL loc_oPage, loc_oGrdH, loc_oGrdS, loc_lSaldo, loc_lSupervis, loc_nCol
1551: 
1552:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
1553:         loc_oGrdH = loc_oPage.grd_4c_Historico
1554:         loc_oGrdS = loc_oPage.grd_4c_Saldo
1555: 
1556:         loc_lSupervis = .F.
1557:         IF TYPE("gc_4c_UsuarioLogado") = "C"
1558:             loc_lSupervis = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) == "4CONTROL")
1559:         ENDIF
1560:         loc_lSaldo    = !fChecaAcesso("SIGOPCGC", "SALDO") OR loc_lSupervis
1561: 
1562:         *---------------------------------------------------------------
1563:         *-- Grade de HISTORICO (grade filha da grade de saldos)
1564:         *---------------------------------------------------------------
1565:         loc_oGrdH.ColumnCount  = IIF(loc_lSaldo, 8, 7)
1566:         loc_oGrdH.ColumnCount = 3
1567:         loc_oGrdH.RecordSource = "cursor_4c_Historico"
1568:         WITH loc_oGrdH
1569:             THIS.FormatarGradeResultado(loc_oGrdH)
1570:             .Width          = 588
1571:             .LinkMaster     = "cursor_4c_Saldo"
1572:             .ChildOrder     = "moedata"
1573:             .RelationalExpr = "moedas"
1574: 
1575:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Historico.emps", ;
1576:                 31, "Emp", 2, "", "")
1577:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Historico.datas", ;
1578:                 80, "Data", 2, "", "")
1579:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Historico.valors", ;
1580:                 94, "Valor", 2, "9,999,999.99", "9,999,999.99")
1581:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Historico.opers", ;
1582:                 18, "O", 2, "", "")
1583: 

*-- Linhas 1596 a 1626:
1596:                     80, "Vencimento", 2, "", "")
1597:                 THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_Historico.nfs", ;
1598:                     80, "Nota", 2, "", "")
1599:                 THIS.ConfigurarColunaResultado(.Column7, ;
1600:                     "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
1601:                     20, "Pg", 2, "", "")
1602:             ENDIF
1603:         ENDWITH
1604: 
1605:         *---------------------------------------------------------------
1606:         *-- Grade de SALDO POR MOEDA (grade mae)
1607:         *---------------------------------------------------------------
1608:         loc_oGrdS.ColumnCount  = IIF(loc_lSaldo, 2, 1)
1609:         loc_oGrdS.ColumnCount = 3
1610:         loc_oGrdS.RecordSource = "cursor_4c_Saldo"
1611:         WITH loc_oGrdS
1612:             THIS.FormatarGradeResultado(loc_oGrdS)
1613:             .Width        = IIF(loc_lSaldo, 156, 156 - 94)
1614: 
1615:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Saldo.moedas", ;
1616:                 31, "M.", 2, "", "")
1617: 
1618:             IF loc_lSaldo
1619:                 THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Saldo.saldos", ;
1620:                     94, "Saldo", 2, "", "")
1621:             ENDIF
1622:         ENDWITH
1623: 
1624:         *-- moldura e titulo acompanham o numero de colunas (legado)
1625:         loc_oPage.shp_4c_MoldSaldo.Width = IIF(loc_lSaldo, 165, 165 - 94)
1626:         loc_oPage.lbl_4c_TitSaldo.Caption = IIF(loc_lSaldo, "Saldo por Moeda", "Moedas")

*-- Linhas 1650 a 1672:
1650:                 .InputMask = par_cMask
1651:             ENDIF
1652: 
1653:             .Header1.Caption   = par_cCaption
1654:             .Header1.Alignment = par_nAlinhaHeader
1655:             .Header1.FontName  = "Tahoma"
1656:             .Header1.FontSize  = 8
1657:             .Header1.ForeColor = RGB(90, 90, 90)
1658: 
1659:             .Text1.BorderStyle = 0
1660:             .Text1.Margin      = 0
1661:             .Text1.ReadOnly    = .T.
1662:         ENDWITH
1663:     ENDPROC
1664: 
1665:     *==========================================================================
1666:     * ConfigurarAbaPendencias - Page "Pendencias" do Result: parcelas e
1667:     * lancamentos de conta corrente em aberto (cursor_4c_Parcela).
1668:     *
1669:     * Grid1 do legado (a grade de baixo) nasce Visible = .F. / Enabled = .F.
1670:     * com TODAS as colunas invisiveis - eh um resto de layout que o legado
1671:     * nunca mostra. Reproduzida para nao perder objeto da tela, e por isso
1672:     * entra na lista de excecao de TornarControlesVisiveis.

*-- Linhas 1693 a 1752:
1693:             .AutoSize   = .F.
1694:             .FontName   = "Tahoma"
1695:             .FontSize   = 8
1696:             .FontBold   = .T.
1697:             .FontItalic = .T.
1698:             .BackStyle  = 0
1699:             .Alignment  = 0
1700:             .ForeColor  = RGB(90, 90, 90)
1701:             .Caption    = "Pend" + CHR(234) + "ncias"
1702:         ENDWITH
1703: 
1704:         par_oPage.AddObject("grd_4c_Pendente", "Grid")
1705:         loc_oGrd = par_oPage.grd_4c_Pendente
1706:         loc_oGrd.ColumnCount  = 4
1707:         loc_oGrd.RecordSource = "cursor_4c_Parcela"
1708:         WITH loc_oGrd
1709:             .Top               = 23
1710:             .Left              = 14
1711:             .Width             = 652
1712:             .Height            = 184
1713:             .AllowHeaderSizing = .F.
1714:             .AllowRowSizing    = .F.
1715:             THIS.FormatarGradeResultado(loc_oGrd)
1716: 
1717:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.valos", ;
1718:                 77, "Valor", 2, "", "999,999,999.99")
1719:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.moefpgs", ;
1720:                 30, "Moe", 2, "", "")
1721:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.vencs", ;
1722:                 90, "Vecto", 2, "", "")
1723:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.hists", ;
1724:                 370, "Tipo", 2, "", "")
1725: 
1726:             .Column1.ColumnOrder = 2
1727:             .Column2.ColumnOrder = 3
1728:             .Column3.ColumnOrder = 1
1729:             .Column4.ColumnOrder = 4
1730:         ENDWITH
1731: 
1732:         *-- Grid1 do legado: oculta e desabilitada, mantida por fidelidade
1733:         par_oPage.AddObject("grd_4c_PendenteOculta", "Grid")
1734:         loc_oGrd = par_oPage.grd_4c_PendenteOculta
1735:         loc_oGrd.ColumnCount  = 5
1736:         loc_oGrd.RecordSource = "cursor_4c_Parcela"
1737:         WITH loc_oGrd
1738:             .Top               = 222
1739:             .Left              = 5
1740:             .Width             = 557
1741:             .Height            = 166
1742:             .AllowHeaderSizing = .F.
1743:             .AllowRowSizing    = .F.
1744:             THIS.FormatarGradeResultado(loc_oGrd)
1745: 
1746:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.fpags", ;
1747:                 177, "Tipo", 2, "", "")
1748:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.valos", ;
1749:                 77, "Valor", 2, "", "999,999,999.99")
1750:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.moefpgs", ;
1751:                 30, "Moe", 2, "", "")
1752:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.vencs", ;

*-- Linhas 1782 a 1812:
1782:             .FontName   = "Tahoma"
1783:             .FontSize   = 8
1784:             .FontBold   = .T.
1785:             .FontItalic = .T.
1786:             .BackStyle  = 0
1787:             .Alignment  = 0
1788:             .ForeColor  = RGB(90, 90, 90)
1789:             .Caption    = " Produtos "
1790:         ENDWITH
1791: 
1792:         *-- Grd_Produto: 10 colunas, ColumnOrder do legado
1793:         par_oPage.AddObject("grd_4c_Produto", "Grid")
1794:         loc_oGrd = par_oPage.grd_4c_Produto
1795:         loc_oGrd.ColumnCount  = 10
1796:         loc_oGrd.RecordSource = "cursor_4c_ProdFor"
1797:         WITH loc_oGrd
1798:             .Top          = 44
1799:             .Left         = 2
1800:             .Width        = 690
1801:             .Height       = 106
1802:             THIS.FormatarGradeResultado(loc_oGrd)
1803:             .RowHeight    = 17
1804:             .Highlight    = .T.
1805:             .HighlightRow = .T.
1806: 
1807:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_ProdFor.cpros", ;
1808:                 108, "Produto", 2, "", "")
1809:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_ProdFor.custofs", ;
1810:                 70, "Custo", 2, "", "999,999,999.99")
1811:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_ProdFor.moecusfs", ;
1812:                 21, "Moe", 2, "", "")

*-- Linhas 1842 a 1867:
1842: 
1843:         *-- Click/DblClick dos headers ordenam a grade (ascendente /
1844:         *-- descendente), igual ao legado
1845:         BINDEVENT(loc_oGrd.Column1.Header1,  "Click",    THIS, "HeaderProdutoClick")
1846:         BINDEVENT(loc_oGrd.Column1.Header1,  "DblClick", THIS, "HeaderProdutoDblClick")
1847:         BINDEVENT(loc_oGrd.Column5.Header1,  "Click",    THIS, "HeaderQtVendClick")
1848:         BINDEVENT(loc_oGrd.Column5.Header1,  "DblClick", THIS, "HeaderQtVendDblClick")
1849:         BINDEVENT(loc_oGrd.Column6.Header1,  "Click",    THIS, "HeaderVlVendClick")
1850:         BINDEVENT(loc_oGrd.Column6.Header1,  "DblClick", THIS, "HeaderVlVendDblClick")
1851:         BINDEVENT(loc_oGrd.Column10.Header1, "Click",    THIS, "HeaderReffsClick")
1852:         BINDEVENT(loc_oGrd.Column10.Header1, "DblClick", THIS, "HeaderReffsDblClick")
1853: 
1854:         *-- shp_produto / lbl_produto + Grd_Resumo (total por operacao)
1855:         par_oPage.AddObject("shp_4c_MoldResumo", "Shape")
1856:         WITH par_oPage.shp_4c_MoldResumo
1857:             .Top           = 173
1858:             .Left          = 10
1859:             .Width         = 329
1860:             .Height        = 127
1861:             .BackStyle     = 0
1862:             .SpecialEffect = 1
1863:             .BorderColor   = RGB(136, 188, 189)
1864:         ENDWITH
1865: 
1866:         par_oPage.AddObject("lbl_4c_TitResumo", "Label")
1867:         WITH par_oPage.lbl_4c_TitResumo

*-- Linhas 1877 a 1907:
1877:             .BackStyle  = 0
1878:             .Alignment  = 0
1879:             .ForeColor  = RGB(90, 90, 90)
1880:             .Caption    = " Total por Opera" + CHR(231) + CHR(227) + "o "
1881:         ENDWITH
1882: 
1883:         *-- No SCX as Columns de grd_resumo ficaram com ControlSource VAZIO e
1884:         *-- os Text1 internos apontando para um alias "dbproduto" que nao
1885:         *-- existe neste form (residuo de copia de outra grade). As ligacoes
1886:         *-- abaixo vem dos captions dos headers e da estrutura de dbResumo -
1887:         *-- deixar o ControlSource vazio exibiria a grade em branco.
1888:         par_oPage.AddObject("grd_4c_Resumo", "Grid")
1889:         loc_oGrd = par_oPage.grd_4c_Resumo
1890:         loc_oGrd.ColumnCount  = 3
1891:         loc_oGrd.RecordSource = "cursor_4c_Resumo"
1892:         WITH loc_oGrd
1893:             .Top          = 180
1894:             .Left         = 14
1895:             .Width        = 320
1896:             .Height       = 113
1897:             THIS.FormatarGradeResultado(loc_oGrd)
1898:             .Highlight    = .T.
1899:             .HighlightRow = .T.
1900: 
1901:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Resumo.dopes", ;
1902:                 150, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1903:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Resumo.valos", ;
1904:                 90, "Valor Total", 2, "", "999,999,999.99")
1905:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Resumo.qtds", ;
1906:                 58, "Qtds", 0, "99999.99", "")
1907: 

*-- Linhas 1916 a 1946:
1916:         par_oPage.AddObject("shp_4c_MoldOperaProd", "Shape")
1917:         WITH par_oPage.shp_4c_MoldOperaProd
1918:             .Top           = 152
1919:             .Left          = 337
1920:             .Width         = 332
1921:             .Height        = 93
1922:             .BackStyle     = 0
1923:             .SpecialEffect = 1
1924:             .BorderColor   = RGB(136, 188, 189)
1925:         ENDWITH
1926: 
1927:         par_oPage.AddObject("grd_4c_OperaProd", "Grid")
1928:         loc_oGrd = par_oPage.grd_4c_OperaProd
1929:         loc_oGrd.ColumnCount  = 3
1930:         loc_oGrd.RecordSource = "cursor_4c_OperaProd"
1931:         WITH loc_oGrd
1932:             .Top            = 154
1933:             .Left           = 340
1934:             .Width          = 324
1935:             .Height         = 88
1936:             THIS.FormatarGradeResultado(loc_oGrd)
1937:             .RowHeight      = 17
1938:             .Highlight      = .T.
1939:             .HighlightRow   = .T.
1940:             .LinkMaster     = "cursor_4c_ProdFor"
1941:             .ChildOrder     = "cprosdopes"
1942:             .RelationalExpr = "cpros"
1943: 
1944:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_OperaProd.dopes", ;
1945:                 127, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1946:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_OperaProd.valos", ;

*-- Linhas 2087 a 2117:
2087:             .AutoSize   = .F.
2088:             .FontName   = "Tahoma"
2089:             .FontSize   = 8
2090:             .FontBold   = .T.
2091:             .FontItalic = .T.
2092:             .BackStyle  = 0
2093:             .Alignment  = 0
2094:             .ForeColor  = RGB(90, 90, 90)
2095:             .Caption    = "Produtos em seu poder"
2096:         ENDWITH
2097: 
2098:         par_oPage.AddObject("grd_4c_EstoqueProd", "Grid")
2099:         loc_oGrd = par_oPage.grd_4c_EstoqueProd
2100:         loc_oGrd.ColumnCount  = 2
2101:         loc_oGrd.RecordSource = "cursor_4c_Estoque"
2102:         WITH loc_oGrd
2103:             .Top          = 34
2104:             .Left         = 18
2105:             .Width        = 229
2106:             .Height       = 346
2107:             THIS.FormatarGradeResultado(loc_oGrd)
2108:             .Highlight    = .T.
2109:             .HighlightRow = .T.
2110: 
2111:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Estoque.cpros", ;
2112:                 108, "Produto", 2, "", "")
2113:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Estoque.sqtds", ;
2114:                 100, "Qtde.", 2, "", "99,999,999.999")
2115: 
2116:             .Column1.ColumnOrder = 1
2117:             .Column1.Alignment   = 3

*-- Linhas 2183 a 2213:
2183:             .AutoSize   = .F.
2184:             .FontName   = "Tahoma"
2185:             .FontSize   = 8
2186:             .FontBold   = .T.
2187:             .FontItalic = .T.
2188:             .BackStyle  = 0
2189:             .Alignment  = 0
2190:             .ForeColor  = RGB(90, 90, 90)
2191:             .Caption    = "Consertos Pendentes"
2192:         ENDWITH
2193: 
2194:         par_oPage.AddObject("grd_4c_Conserto", "Grid")
2195:         loc_oGrd = par_oPage.grd_4c_Conserto
2196:         loc_oGrd.ColumnCount  = 4
2197:         loc_oGrd.RecordSource = "cursor_4c_Conserto"
2198:         WITH loc_oGrd
2199:             .Top          = 37
2200:             .Left         = 11
2201:             .Width        = 654
2202:             .Height       = 275
2203:             THIS.FormatarGradeResultado(loc_oGrd)
2204:             .Highlight    = .T.
2205:             .HighlightRow = .T.
2206: 
2207:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Conserto.datas", ;
2208:                 75, "Data", 2, "", "")
2209:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Conserto.emps", ;
2210:                 27, "Emp", 2, "", "")
2211:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Conserto.opers", ;
2212:                 130, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
2213:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Conserto.obscon", ;

*-- Linhas 2586 a 2618:
2586:             loc_lAnalise = (loc_oPag1.obj_4c_Opt_Analise.Value = 1)
2587: 
2588:             *-- grades de totais x mensagens (legado: If lnAnalise = 1)
2589:             loc_oMov.grd_4c_Resumo.Visible    = loc_lAnalise
2590:             loc_oMov.grd_4c_OperaProd.Visible = loc_lAnalise
2591:             loc_oMov.lbl_4c_Mensagem1.Visible = !loc_lAnalise
2592:             loc_oMov.lbl_4c_Mensagem2.Visible = !loc_lAnalise
2593: 
2594:             *-- _TitMoeda do legado: a moeda do filtro entra entre parenteses
2595:             *-- no caption das tres colunas de valor
2596:             loc_cTitMoeda = ""
2597:             IF !EMPTY(ALLTRIM(loc_oPag1.txt_4c_Moeda.Value))
2598:                 loc_cTitMoeda = "(" + ALLTRIM(loc_oPag1.txt_4c_Moeda.Value) + ")"
2599:             ENDIF
2600: 
2601:             loc_oMov.grd_4c_Produto.Column6.Header1.Caption   = "Total Vendas" + loc_cTitMoeda
2602:             loc_oMov.grd_4c_OperaProd.Column2.Header1.Caption = "Valor Total" + loc_cTitMoeda
2603:             loc_oMov.grd_4c_Resumo.Column2.Header1.Caption    = "Valor Total" + loc_cTitMoeda
2604: 
2605:             THIS.AtualizarFotoFornecedor()
2606:             THIS.AtualizarGrades()
2607: 
2608:             loc_oRes.ActivePage = 1
2609:             loc_lSucesso = .T.
2610:         CATCH TO loc_oErro
2611:             MsgErro(loc_oErro.Message + CHR(13) + ;
2612:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2613:                 "Procedure: " + loc_oErro.Procedure, "Erro ao exibir o resultado")
2614:         ENDTRY
2615: 
2616:         RETURN loc_lSucesso
2617:     ENDPROC
2618: 

*-- Linhas 2634 a 2661:
2634: 
2635:             loc_oRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result
2636: 
2637:             loc_oRes.Page1.grd_4c_Saldo.Refresh()
2638:             loc_oRes.Page1.grd_4c_Historico.Refresh()
2639:             loc_oRes.Page1.txt_4c_Hists.Refresh()
2640:             loc_oRes.Page1.txt_4c_Hist2s.Refresh()
2641:             loc_oRes.Page2.grd_4c_Pendente.Refresh()
2642:             loc_oRes.Page3.grd_4c_Produto.Refresh()
2643:             loc_oRes.Page3.grd_4c_Resumo.Refresh()
2644:             loc_oRes.Page3.grd_4c_OperaProd.Refresh()
2645:             loc_oRes.Page4.grd_4c_EstoqueProd.Refresh()
2646:             loc_oRes.Page5.grd_4c_Conserto.Refresh()
2647: 
2648:             *-- foto do produto da linha corrente da aba Estoque (o legado
2649:             *-- dispara "Result.Estoque.Grd_Produto.AfterRowColChange" a mao)
2650:             THIS.GradeEstoqueAfterRowColChange(1)
2651:         CATCH TO loc_oErro
2652:             MsgErro(loc_oErro.Message + CHR(13) + ;
2653:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao atualizar as grades")
2654:         ENDTRY
2655:     ENDPROC
2656: 
2657:     *==========================================================================
2658:     * MostrarBlocoCadastro / MostrarBlocoMovimento - o par de blocos "With
2659:     * ThisForm.Fld_Principal.Pag_Resultado" do legado, que alterna a Pagina
2660:     * Resultado entre o cadastro do fornecedor e o resultado da consulta, e
2661:     * troca qual botao de navegacao (Cmd_MudaFor / Cmd_MudaMov) fica visivel.

*-- Linhas 2783 a 2819:
2783:         THIS.MostrarBlocoMovimento()
2784: 
2785:         *-- O legado refaz a configuracao das duas grades da aba Saldo a cada
2786:         *-- clique neste botao (ColumnCount depende da permissao) - mexer em
2787:         *-- ColumnCount recria as Column, por isso ControlSource/Width/Header
2788:         *-- sao reaplicados dentro de ConfigurarGradesSaldo.
2789:         THIS.ConfigurarGradesSaldo()
2790: 
2791:         THIS.AlternarPagina(2)
2792: 
2793:         *-- "Select dbHistorico / Go Bottom" do legado: o extrato abre no
2794:         *-- lancamento mais RECENTE. Tem de vir DEPOIS de AlternarPagina, que
2795:         *-- chama AtualizarGrades -> PosicionarCursores (GO TOP em todos os
2796:         *-- cursores) - antes dela, o GO TOP desfaria este GO BOTTOM.
2797:         IF USED("cursor_4c_Historico")
2798:             SELECT cursor_4c_Historico
2799:             GO BOTTOM
2800:         ENDIF
2801: 
2802:         TRY
2803:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2804:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.SetFocus()
2805:         CATCH TO loc_oErro
2806:             *-- SetFocus falha quando a grade ainda nao esta visivel; eh so o
2807:             *-- foco inicial, nao afeta o conteudo exibido
2808:         ENDTRY
2809:     ENDPROC
2810: 
2811:     *==========================================================================
2812:     * BtnCancelarClick - botao "Encerrar" do grp_operacao (Page1), que no
2813:     * legado eh o objeto cmd_cancela (Cancel = .T., ou seja tambem responde ao
2814:     * ESC) e cujo Click eh apenas "ThisForm.Release".
2815:     *==========================================================================
2816:     PROCEDURE BtnCancelarClick()
2817:         THIS.Release()
2818:     ENDPROC
2819: 

*-- Linhas 2866 a 2884:
2866:         LOCAL loc_oErro
2867: 
2868:         TRY
2869:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2870:         CATCH TO loc_oErro
2871:             MsgErro(loc_oErro.Message, "Erro")
2872:         ENDTRY
2873:     ENDPROC
2874: 
2875:     *==========================================================================
2876:     * GradeHistoricoAfterRowColChange - AfterRowColChange de grd_historico:
2877:     * os dois campos de historico abaixo da grade acompanham a linha corrente.
2878:     *==========================================================================
2879:     PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
2880:         LOCAL loc_oPage, loc_oErro
2881: 
2882:         TRY
2883:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
2884:             loc_oPage.txt_4c_Hists.Refresh()

*-- Linhas 2956 a 2974:
2956:             ENDIF
2957: 
2958:             GO TOP IN cursor_4c_ProdFor
2959:             loc_oPage.grd_4c_Produto.Refresh()
2960:         CATCH TO loc_oErro
2961:             MsgErro(loc_oErro.Message, "Erro")
2962:         ENDTRY
2963:     ENDPROC
2964: 
2965:     *==========================================================================
2966:     * OrdenarGradeProdutos - corpo comum aos 8 handlers de Click/DblClick dos
2967:     * headers da grade de produtos: o legado troca a ordem corrente do cursor
2968:     * (Click = ascendente, DblClick = descendente) e repinta a grade.
2969:     *==========================================================================
2970:     PROTECTED PROCEDURE OrdenarGradeProdutos(par_cTag, par_lDescendente)
2971:         LOCAL loc_oErro
2972: 
2973:         IF !USED("cursor_4c_ProdFor")
2974:             RETURN

*-- Linhas 2982 a 3000:
2982:                 SET ORDER TO (par_cTag) ASCENDING
2983:             ENDIF
2984:             GO TOP IN cursor_4c_ProdFor
2985:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3.grd_4c_Produto.Refresh()
2986:         CATCH TO loc_oErro
2987:             MsgErro(loc_oErro.Message, "Erro")
2988:         ENDTRY
2989:     ENDPROC
2990: 
2991:     PROCEDURE HeaderProdutoClick()
2992:         THIS.OrdenarGradeProdutos("cpros", .F.)
2993:     ENDPROC
2994: 
2995:     PROCEDURE HeaderProdutoDblClick()
2996:         THIS.OrdenarGradeProdutos("cpros", .T.)
2997:     ENDPROC
2998: 
2999:     PROCEDURE HeaderQtVendClick()
3000:         THIS.OrdenarGradeProdutos("qtvend", .F.)

*-- Linhas 3328 a 3347:
3328:                     loc_oBusca.this_cTitulo        = "Moedas"
3329:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Moedas"
3330:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Moedas"
3331:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3332:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3333:                     loc_oBusca.Show()
3334:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3335:                         SELECT cursor_4c_BuscaMoeda
3336:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3337:                     ELSE
3338:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3339:                     ENDIF
3340:                     loc_oBusca.Release()
3341:                 ENDIF
3342:             ELSE
3343:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3344:             ENDIF
3345:         CATCH TO loc_oErro
3346:             MsgErro(loc_oErro.Message, "Erro")
3347:         ENDTRY

*-- Linhas 3443 a 3462:
3443:                     loc_oBusca.this_cTitulo        = loc_cTitulo
3444:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
3445:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
3446:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
3447:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
3448:                     loc_oBusca.Show()
3449:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
3450:                         SELECT cursor_4c_BuscaEmp
3451:                         IF VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_BuscaEmp.Cemps))
3452:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
3453:                         ELSE
3454:                             MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3455:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3456:                         ENDIF
3457:                     ELSE
3458:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3459:                     ENDIF
3460:                     loc_oBusca.Release()
3461:                 ENDIF
3462:             ELSE

*-- Linhas 3647 a 3665:
3647:     *==========================================================================
3648:     * ValidarCpf - KeyPress de txt_4c_Cpf (container cnt_4c_Origem, Page1).
3649:     * Legado (Origem.Get_cpf.Valid): fwbuscaext em SigCdCli.cpfs (aqui via
3650:     * FormBuscaAuxiliar - mAddColuna cpfs/iclis/rclis) + fAcessoContas para
3651:     * validar o acesso ao registro escolhido e preencher Conta/DConta.
3652:     *==========================================================================
3653:     PROCEDURE ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
3654:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_oBusca, loc_oErro
3655: 
3656:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3657: 
3658:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3659:             RETURN
3660:         ENDIF
3661: 
3662:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3663:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
3664:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3665: 

*-- Linhas 3679 a 3699:
3679: 
3680:             IF VARTYPE(loc_oBusca) = "O"
3681:                 IF !loc_oBusca.this_lAchouRegistro
3682:                     loc_oBusca.mAddColuna("cpfs",  "", "CPF / CGC")
3683:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
3684:                     loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
3685:                     loc_oBusca.Show()
3686:                 ENDIF
3687: 
3688:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
3689:                     SELECT cursor_4c_BuscaCpf
3690:                     loc_cVal = ALLTRIM(cursor_4c_BuscaCpf.iclis)
3691: 
3692:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
3693:                             loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3694:                         MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3695:                         loc_oOrigem.txt_4c_Cpf.Value    = ""
3696:                         loc_oOrigem.txt_4c_Conta.Value  = ""
3697:                         loc_oOrigem.txt_4c_Dconta.Value = ""
3698:                     ELSE
3699:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)

*-- Linhas 3786 a 3810:
3786:             *--   CMG_4C_MUDAFOR / CMG_4C_MUDAMOV - so um por vez, alternados
3787:             *--   PGF_4C_RESULT         - a Pagina Resultado abre no cadastro
3788:             *--   CNT_4C_IMPRIMEOPCOES  - painel de opcoes de impressao
3789:             *--   GRD_4C_PENDENTEOCULTA - Grid1 do legado, nunca exibida
3790:             *--   IMG_4C_FIGURA / IMG_4C_FOTOPRODUTO - so com foto disponivel
3791:             *--   LBL_4C_MSGFOTO / LBL_4C_MSGFOTOPRODUTO - so SEM foto
3792:             *--   LBL_4C_MENSAGEM1 / 2 - so sem Analise de Vendas
3793:             loc_lPularVisible = INLIST(UPPER(loc_oObjeto.Name), ;
3794:                 "CMG_4C_MUDAFOR", "CMG_4C_MUDAMOV", "PGF_4C_RESULT", ;
3795:                 "CNT_4C_IMPRIMEOPCOES", "GRD_4C_PENDENTEOCULTA", ;
3796:                 "IMG_4C_FIGURA", "IMG_4C_FOTOPRODUTO", "LBL_4C_MSGFOTO", ;
3797:                 "LBL_4C_MSGFOTOPRODUTO", "LBL_4C_MENSAGEM1", "LBL_4C_MENSAGEM2")
3798: 
3799:             IF !loc_lPularVisible AND PEMSTATUS(loc_oObjeto, "Visible", 5)
3800:                 loc_oObjeto.Visible = .T.
3801:             ENDIF
3802: 
3803:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3804:                 FOR loc_nP = 1 TO loc_oObjeto.PageCount
3805:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3806:                 ENDFOR
3807:             ELSE
3808:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3809:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3810:                 ENDIF

