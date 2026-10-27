# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (9)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1569: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1611: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1713: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1742: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1803: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1897: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1937: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2107: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2203: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgc.prg) - TRECHOS RELEVANTES PARA PASS GRID (3820 linhas total):

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

*-- Linhas 1520 a 1585:
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
1565:         WITH loc_oGrdH
1566:             .ColumnCount = IIF(loc_lSaldo, 8, 7)
1567:             THIS.FormatarGradeResultado(loc_oGrdH)
1568:             .Width          = 588
1569:             .RecordSource   = "cursor_4c_Historico"
1570:             .LinkMaster     = "cursor_4c_Saldo"
1571:             .ChildOrder     = "moedata"
1572:             .RelationalExpr = "moedas"
1573: 
1574:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Historico.emps", ;
1575:                 31, "Emp", 2, "", "")
1576:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Historico.datas", ;
1577:                 80, "Data", 2, "", "")
1578:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Historico.valors", ;
1579:                 94, "Valor", 2, "9,999,999.99", "9,999,999.99")
1580:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Historico.opers", ;
1581:                 18, "O", 2, "", "")
1582: 
1583:             IF loc_lSaldo
1584:                 THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Historico.saldos", ;
1585:                     94, "Saldo", 2, "9,999,999.99", "9,999,999.99")

*-- Linhas 1597 a 1627:
1597:                     80, "Nota", 2, "", "")
1598:                 THIS.ConfigurarColunaResultado(.Column7, ;
1599:                     "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
1600:                     20, "Pg", 2, "", "")
1601:             ENDIF
1602:         ENDWITH
1603: 
1604:         *---------------------------------------------------------------
1605:         *-- Grade de SALDO POR MOEDA (grade mae)
1606:         *---------------------------------------------------------------
1607:         WITH loc_oGrdS
1608:             .ColumnCount = IIF(loc_lSaldo, 2, 1)
1609:             THIS.FormatarGradeResultado(loc_oGrdS)
1610:             .Width        = IIF(loc_lSaldo, 156, 156 - 94)
1611:             .RecordSource = "cursor_4c_Saldo"
1612: 
1613:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Saldo.moedas", ;
1614:                 31, "M.", 2, "", "")
1615: 
1616:             IF loc_lSaldo
1617:                 THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Saldo.saldos", ;
1618:                     94, "Saldo", 2, "", "")
1619:             ENDIF
1620:         ENDWITH
1621: 
1622:         *-- moldura e titulo acompanham o numero de colunas (legado)
1623:         loc_oPage.shp_4c_MoldSaldo.Width = IIF(loc_lSaldo, 165, 165 - 94)
1624:         loc_oPage.lbl_4c_TitSaldo.Caption = IIF(loc_lSaldo, "Saldo por Moeda", "Moedas")
1625:     ENDPROC
1626: 
1627:     *==========================================================================

*-- Linhas 1648 a 1670:
1648:                 .InputMask = par_cMask
1649:             ENDIF
1650: 
1651:             .Header1.Caption   = par_cCaption
1652:             .Header1.Alignment = par_nAlinhaHeader
1653:             .Header1.FontName  = "Tahoma"
1654:             .Header1.FontSize  = 8
1655:             .Header1.ForeColor = RGB(90, 90, 90)
1656: 
1657:             .Text1.BorderStyle = 0
1658:             .Text1.Margin      = 0
1659:             .Text1.ReadOnly    = .T.
1660:         ENDWITH
1661:     ENDPROC
1662: 
1663:     *==========================================================================
1664:     * ConfigurarAbaPendencias - Page "Pendencias" do Result: parcelas e
1665:     * lancamentos de conta corrente em aberto (cursor_4c_Parcela).
1666:     *
1667:     * Grid1 do legado (a grade de baixo) nasce Visible = .F. / Enabled = .F.
1668:     * com TODAS as colunas invisiveis - eh um resto de layout que o legado
1669:     * nunca mostra. Reproduzida para nao perder objeto da tela, e por isso
1670:     * entra na lista de excecao de TornarControlesVisiveis.

*-- Linhas 1699 a 1758:
1699:             .Caption    = "Pend" + CHR(234) + "ncias"
1700:         ENDWITH
1701: 
1702:         par_oPage.AddObject("grd_4c_Pendente", "Grid")
1703:         loc_oGrd = par_oPage.grd_4c_Pendente
1704:         WITH loc_oGrd
1705:             .Top               = 23
1706:             .Left              = 14
1707:             .Width             = 652
1708:             .Height            = 184
1709:             .AllowHeaderSizing = .F.
1710:             .AllowRowSizing    = .F.
1711:             .ColumnCount       = 4
1712:             THIS.FormatarGradeResultado(loc_oGrd)
1713:             .RecordSource      = "cursor_4c_Parcela"
1714: 
1715:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.valos", ;
1716:                 77, "Valor", 2, "", "999,999,999.99")
1717:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.moefpgs", ;
1718:                 30, "Moe", 2, "", "")
1719:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.vencs", ;
1720:                 90, "Vecto", 2, "", "")
1721:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.hists", ;
1722:                 370, "Tipo", 2, "", "")
1723: 
1724:             .Column1.ColumnOrder = 2
1725:             .Column2.ColumnOrder = 3
1726:             .Column3.ColumnOrder = 1
1727:             .Column4.ColumnOrder = 4
1728:         ENDWITH
1729: 
1730:         *-- Grid1 do legado: oculta e desabilitada, mantida por fidelidade
1731:         par_oPage.AddObject("grd_4c_PendenteOculta", "Grid")
1732:         loc_oGrd = par_oPage.grd_4c_PendenteOculta
1733:         WITH loc_oGrd
1734:             .Top               = 222
1735:             .Left              = 5
1736:             .Width             = 557
1737:             .Height            = 166
1738:             .AllowHeaderSizing = .F.
1739:             .AllowRowSizing    = .F.
1740:             .ColumnCount       = 5
1741:             THIS.FormatarGradeResultado(loc_oGrd)
1742:             .RecordSource      = "cursor_4c_Parcela"
1743: 
1744:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.fpags", ;
1745:                 177, "Tipo", 2, "", "")
1746:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.valos", ;
1747:                 77, "Valor", 2, "", "999,999,999.99")
1748:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.moefpgs", ;
1749:                 30, "Moe", 2, "", "")
1750:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.vencs", ;
1751:                 90, "Vecto", 2, "", "")
1752:             THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Parcela.hists", ;
1753:                 192, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1754: 
1755:             .Column1.ColumnOrder = 4
1756:             .Column3.ColumnOrder = 3
1757:             .Column4.ColumnOrder = 1
1758: 

*-- Linhas 1788 a 1819:
1788:         ENDWITH
1789: 
1790:         *-- Grd_Produto: 10 colunas, ColumnOrder do legado
1791:         par_oPage.AddObject("grd_4c_Produto", "Grid")
1792:         loc_oGrd = par_oPage.grd_4c_Produto
1793:         WITH loc_oGrd
1794:             .Top          = 44
1795:             .Left         = 2
1796:             .Width        = 690
1797:             .Height       = 106
1798:             .ColumnCount  = 10
1799:             THIS.FormatarGradeResultado(loc_oGrd)
1800:             .RowHeight    = 17
1801:             .Highlight    = .T.
1802:             .HighlightRow = .T.
1803:             .RecordSource = "cursor_4c_ProdFor"
1804: 
1805:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_ProdFor.cpros", ;
1806:                 108, "Produto", 2, "", "")
1807:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_ProdFor.custofs", ;
1808:                 70, "Custo", 2, "", "999,999,999.99")
1809:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_ProdFor.moecusfs", ;
1810:                 21, "Moe", 2, "", "")
1811:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_ProdFor.marca", ;
1812:                 10, "", 2, "", "")
1813:             THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_ProdFor.qtvend", ;
1814:                 70, "Qt. Vendas", 2, "", "999,999.999")
1815:             THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_ProdFor.vlvend", ;
1816:                 70, "Valor Vendas", 2, "", "99,999,999.99")
1817:             THIS.ConfigurarColunaResultado(.Column7, "cursor_4c_ProdFor.estoque", ;
1818:                 70, "Estoque Atual", 2, "9999,999.999", "")
1819:             THIS.ConfigurarColunaResultado(.Column8, "cursor_4c_ProdFor.pvens", ;

*-- Linhas 1840 a 1865:
1840: 
1841:         *-- Click/DblClick dos headers ordenam a grade (ascendente /
1842:         *-- descendente), igual ao legado
1843:         BINDEVENT(loc_oGrd.Column1.Header1,  "Click",    THIS, "HeaderProdutoClick")
1844:         BINDEVENT(loc_oGrd.Column1.Header1,  "DblClick", THIS, "HeaderProdutoDblClick")
1845:         BINDEVENT(loc_oGrd.Column5.Header1,  "Click",    THIS, "HeaderQtVendClick")
1846:         BINDEVENT(loc_oGrd.Column5.Header1,  "DblClick", THIS, "HeaderQtVendDblClick")
1847:         BINDEVENT(loc_oGrd.Column6.Header1,  "Click",    THIS, "HeaderVlVendClick")
1848:         BINDEVENT(loc_oGrd.Column6.Header1,  "DblClick", THIS, "HeaderVlVendDblClick")
1849:         BINDEVENT(loc_oGrd.Column10.Header1, "Click",    THIS, "HeaderReffsClick")
1850:         BINDEVENT(loc_oGrd.Column10.Header1, "DblClick", THIS, "HeaderReffsDblClick")
1851: 
1852:         *-- shp_produto / lbl_produto + Grd_Resumo (total por operacao)
1853:         par_oPage.AddObject("shp_4c_MoldResumo", "Shape")
1854:         WITH par_oPage.shp_4c_MoldResumo
1855:             .Top           = 173
1856:             .Left          = 10
1857:             .Width         = 329
1858:             .Height        = 127
1859:             .BackStyle     = 0
1860:             .SpecialEffect = 1
1861:             .BorderColor   = RGB(136, 188, 189)
1862:         ENDWITH
1863: 
1864:         par_oPage.AddObject("lbl_4c_TitResumo", "Label")
1865:         WITH par_oPage.lbl_4c_TitResumo

*-- Linhas 1883 a 1913:
1883:         *-- existe neste form (residuo de copia de outra grade). As ligacoes
1884:         *-- abaixo vem dos captions dos headers e da estrutura de dbResumo -
1885:         *-- deixar o ControlSource vazio exibiria a grade em branco.
1886:         par_oPage.AddObject("grd_4c_Resumo", "Grid")
1887:         loc_oGrd = par_oPage.grd_4c_Resumo
1888:         WITH loc_oGrd
1889:             .Top          = 180
1890:             .Left         = 14
1891:             .Width        = 320
1892:             .Height       = 113
1893:             .ColumnCount  = 3
1894:             THIS.FormatarGradeResultado(loc_oGrd)
1895:             .Highlight    = .T.
1896:             .HighlightRow = .T.
1897:             .RecordSource = "cursor_4c_Resumo"
1898: 
1899:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Resumo.dopes", ;
1900:                 150, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1901:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Resumo.valos", ;
1902:                 90, "Valor Total", 2, "", "999,999,999.99")
1903:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Resumo.qtds", ;
1904:                 58, "Qtds", 0, "99999.99", "")
1905: 
1906:             .Column1.ColumnOrder = 1
1907:             .Column1.Alignment   = 3
1908:             .Column2.ColumnOrder = 3
1909:             .Column2.Alignment   = 3
1910:             .Column3.ColumnOrder = 2
1911:         ENDWITH
1912: 
1913:         *-- Shape2 + Grd_OperaProd (operacoes do produto selecionado)

*-- Linhas 1922 a 1953:
1922:             .BorderColor   = RGB(136, 188, 189)
1923:         ENDWITH
1924: 
1925:         par_oPage.AddObject("grd_4c_OperaProd", "Grid")
1926:         loc_oGrd = par_oPage.grd_4c_OperaProd
1927:         WITH loc_oGrd
1928:             .Top            = 154
1929:             .Left           = 340
1930:             .Width          = 324
1931:             .Height         = 88
1932:             .ColumnCount    = 3
1933:             THIS.FormatarGradeResultado(loc_oGrd)
1934:             .RowHeight      = 17
1935:             .Highlight      = .T.
1936:             .HighlightRow   = .T.
1937:             .RecordSource   = "cursor_4c_OperaProd"
1938:             .LinkMaster     = "cursor_4c_ProdFor"
1939:             .ChildOrder     = "cprosdopes"
1940:             .RelationalExpr = "cpros"
1941: 
1942:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_OperaProd.dopes", ;
1943:                 127, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
1944:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_OperaProd.valos", ;
1945:                 80, "Valor Total", 2, "", "999,999,999.99")
1946:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_OperaProd.qtds", ;
1947:                 55, "Qtde.", 2, "", "999,999.999")
1948: 
1949:             .Column1.ColumnOrder = 1
1950:             .Column1.Alignment   = 3
1951:             .Column2.ColumnOrder = 3
1952:             .Column2.Alignment   = 3
1953:             .Column3.ColumnOrder = 2

*-- Linhas 2093 a 2123:
2093:             .Caption    = "Produtos em seu poder"
2094:         ENDWITH
2095: 
2096:         par_oPage.AddObject("grd_4c_EstoqueProd", "Grid")
2097:         loc_oGrd = par_oPage.grd_4c_EstoqueProd
2098:         WITH loc_oGrd
2099:             .Top          = 34
2100:             .Left         = 18
2101:             .Width        = 229
2102:             .Height       = 346
2103:             .ColumnCount  = 2
2104:             THIS.FormatarGradeResultado(loc_oGrd)
2105:             .Highlight    = .T.
2106:             .HighlightRow = .T.
2107:             .RecordSource = "cursor_4c_Estoque"
2108: 
2109:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Estoque.cpros", ;
2110:                 108, "Produto", 2, "", "")
2111:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Estoque.sqtds", ;
2112:                 100, "Qtde.", 2, "", "99,999,999.999")
2113: 
2114:             .Column1.ColumnOrder = 1
2115:             .Column1.Alignment   = 3
2116:             .Column2.ColumnOrder = 2
2117:             .Column2.Alignment   = 3
2118:         ENDWITH
2119:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEstoqueAfterRowColChange")
2120: 
2121:         par_oPage.AddObject("shp_4c_MoldFoto", "Shape")
2122:         WITH par_oPage.shp_4c_MoldFoto
2123:             .Top           = 27

*-- Linhas 2189 a 2219:
2189:             .Caption    = "Consertos Pendentes"
2190:         ENDWITH
2191: 
2192:         par_oPage.AddObject("grd_4c_Conserto", "Grid")
2193:         loc_oGrd = par_oPage.grd_4c_Conserto
2194:         WITH loc_oGrd
2195:             .Top          = 37
2196:             .Left         = 11
2197:             .Width        = 654
2198:             .Height       = 275
2199:             .ColumnCount  = 4
2200:             THIS.FormatarGradeResultado(loc_oGrd)
2201:             .Highlight    = .T.
2202:             .HighlightRow = .T.
2203:             .RecordSource = "cursor_4c_Conserto"
2204: 
2205:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Conserto.datas", ;
2206:                 75, "Data", 2, "", "")
2207:             THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Conserto.emps", ;
2208:                 27, "Emp", 2, "", "")
2209:             THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Conserto.opers", ;
2210:                 130, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
2211:             THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Conserto.obscon", ;
2212:                 399, "Observa" + CHR(231) + CHR(227) + "o", 2, "", "")
2213: 
2214:             .Column1.ColumnOrder = 1
2215:             .Column1.Alignment   = 3
2216:             .Column2.ColumnOrder = 2
2217:             .Column2.Alignment   = 3
2218:             .Column3.ColumnOrder = 3
2219:             .Column3.Alignment   = 3

*-- Linhas 2584 a 2616:
2584:             loc_lAnalise = (loc_oPag1.obj_4c_Opt_Analise.Value = 1)
2585: 
2586:             *-- grades de totais x mensagens (legado: If lnAnalise = 1)
2587:             loc_oMov.grd_4c_Resumo.Visible    = loc_lAnalise
2588:             loc_oMov.grd_4c_OperaProd.Visible = loc_lAnalise
2589:             loc_oMov.lbl_4c_Mensagem1.Visible = !loc_lAnalise
2590:             loc_oMov.lbl_4c_Mensagem2.Visible = !loc_lAnalise
2591: 
2592:             *-- _TitMoeda do legado: a moeda do filtro entra entre parenteses
2593:             *-- no caption das tres colunas de valor
2594:             loc_cTitMoeda = ""
2595:             IF !EMPTY(ALLTRIM(loc_oPag1.txt_4c_Moeda.Value))
2596:                 loc_cTitMoeda = "(" + ALLTRIM(loc_oPag1.txt_4c_Moeda.Value) + ")"
2597:             ENDIF
2598: 
2599:             loc_oMov.grd_4c_Produto.Column6.Header1.Caption   = "Total Vendas" + loc_cTitMoeda
2600:             loc_oMov.grd_4c_OperaProd.Column2.Header1.Caption = "Valor Total" + loc_cTitMoeda
2601:             loc_oMov.grd_4c_Resumo.Column2.Header1.Caption    = "Valor Total" + loc_cTitMoeda
2602: 
2603:             THIS.AtualizarFotoFornecedor()
2604:             THIS.AtualizarGrades()
2605: 
2606:             loc_oRes.ActivePage = 1
2607:             loc_lSucesso = .T.
2608:         CATCH TO loc_oErro
2609:             MsgErro(loc_oErro.Message + CHR(13) + ;
2610:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2611:                 "Procedure: " + loc_oErro.Procedure, "Erro ao exibir o resultado")
2612:         ENDTRY
2613: 
2614:         RETURN loc_lSucesso
2615:     ENDPROC
2616: 

*-- Linhas 2632 a 2659:
2632: 
2633:             loc_oRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result
2634: 
2635:             loc_oRes.Page1.grd_4c_Saldo.Refresh()
2636:             loc_oRes.Page1.grd_4c_Historico.Refresh()
2637:             loc_oRes.Page1.txt_4c_Hists.Refresh()
2638:             loc_oRes.Page1.txt_4c_Hist2s.Refresh()
2639:             loc_oRes.Page2.grd_4c_Pendente.Refresh()
2640:             loc_oRes.Page3.grd_4c_Produto.Refresh()
2641:             loc_oRes.Page3.grd_4c_Resumo.Refresh()
2642:             loc_oRes.Page3.grd_4c_OperaProd.Refresh()
2643:             loc_oRes.Page4.grd_4c_EstoqueProd.Refresh()
2644:             loc_oRes.Page5.grd_4c_Conserto.Refresh()
2645: 
2646:             *-- foto do produto da linha corrente da aba Estoque (o legado
2647:             *-- dispara "Result.Estoque.Grd_Produto.AfterRowColChange" a mao)
2648:             THIS.GradeEstoqueAfterRowColChange(1)
2649:         CATCH TO loc_oErro
2650:             MsgErro(loc_oErro.Message + CHR(13) + ;
2651:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao atualizar as grades")
2652:         ENDTRY
2653:     ENDPROC
2654: 
2655:     *==========================================================================
2656:     * MostrarBlocoCadastro / MostrarBlocoMovimento - o par de blocos "With
2657:     * ThisForm.Fld_Principal.Pag_Resultado" do legado, que alterna a Pagina
2658:     * Resultado entre o cadastro do fornecedor e o resultado da consulta, e
2659:     * troca qual botao de navegacao (Cmd_MudaFor / Cmd_MudaMov) fica visivel.

*-- Linhas 2781 a 2817:
2781:         THIS.MostrarBlocoMovimento()
2782: 
2783:         *-- O legado refaz a configuracao das duas grades da aba Saldo a cada
2784:         *-- clique neste botao (ColumnCount depende da permissao) - mexer em
2785:         *-- ColumnCount recria as Column, por isso ControlSource/Width/Header
2786:         *-- sao reaplicados dentro de ConfigurarGradesSaldo.
2787:         THIS.ConfigurarGradesSaldo()
2788: 
2789:         THIS.AlternarPagina(2)
2790: 
2791:         *-- "Select dbHistorico / Go Bottom" do legado: o extrato abre no
2792:         *-- lancamento mais RECENTE. Tem de vir DEPOIS de AlternarPagina, que
2793:         *-- chama AtualizarGrades -> PosicionarCursores (GO TOP em todos os
2794:         *-- cursores) - antes dela, o GO TOP desfaria este GO BOTTOM.
2795:         IF USED("cursor_4c_Historico")
2796:             SELECT cursor_4c_Historico
2797:             GO BOTTOM
2798:         ENDIF
2799: 
2800:         TRY
2801:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2802:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.SetFocus()
2803:         CATCH TO loc_oErro
2804:             *-- SetFocus falha quando a grade ainda nao esta visivel; eh so o
2805:             *-- foco inicial, nao afeta o conteudo exibido
2806:         ENDTRY
2807:     ENDPROC
2808: 
2809:     *==========================================================================
2810:     * BtnCancelarClick - botao "Encerrar" do grp_operacao (Page1), que no
2811:     * legado eh o objeto cmd_cancela (Cancel = .T., ou seja tambem responde ao
2812:     * ESC) e cujo Click eh apenas "ThisForm.Release".
2813:     *==========================================================================
2814:     PROCEDURE BtnCancelarClick()
2815:         THIS.Release()
2816:     ENDPROC
2817: 

*-- Linhas 2864 a 2882:
2864:         LOCAL loc_oErro
2865: 
2866:         TRY
2867:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2868:         CATCH TO loc_oErro
2869:             MsgErro(loc_oErro.Message, "Erro")
2870:         ENDTRY
2871:     ENDPROC
2872: 
2873:     *==========================================================================
2874:     * GradeHistoricoAfterRowColChange - AfterRowColChange de grd_historico:
2875:     * os dois campos de historico abaixo da grade acompanham a linha corrente.
2876:     *==========================================================================
2877:     PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
2878:         LOCAL loc_oPage, loc_oErro
2879: 
2880:         TRY
2881:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
2882:             loc_oPage.txt_4c_Hists.Refresh()

*-- Linhas 2954 a 2972:
2954:             ENDIF
2955: 
2956:             GO TOP IN cursor_4c_ProdFor
2957:             loc_oPage.grd_4c_Produto.Refresh()
2958:         CATCH TO loc_oErro
2959:             MsgErro(loc_oErro.Message, "Erro")
2960:         ENDTRY
2961:     ENDPROC
2962: 
2963:     *==========================================================================
2964:     * OrdenarGradeProdutos - corpo comum aos 8 handlers de Click/DblClick dos
2965:     * headers da grade de produtos: o legado troca a ordem corrente do cursor
2966:     * (Click = ascendente, DblClick = descendente) e repinta a grade.
2967:     *==========================================================================
2968:     PROTECTED PROCEDURE OrdenarGradeProdutos(par_cTag, par_lDescendente)
2969:         LOCAL loc_oErro
2970: 
2971:         IF !USED("cursor_4c_ProdFor")
2972:             RETURN

*-- Linhas 2980 a 2998:
2980:                 SET ORDER TO (par_cTag) ASCENDING
2981:             ENDIF
2982:             GO TOP IN cursor_4c_ProdFor
2983:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3.grd_4c_Produto.Refresh()
2984:         CATCH TO loc_oErro
2985:             MsgErro(loc_oErro.Message, "Erro")
2986:         ENDTRY
2987:     ENDPROC
2988: 
2989:     PROCEDURE HeaderProdutoClick()
2990:         THIS.OrdenarGradeProdutos("cpros", .F.)
2991:     ENDPROC
2992: 
2993:     PROCEDURE HeaderProdutoDblClick()
2994:         THIS.OrdenarGradeProdutos("cpros", .T.)
2995:     ENDPROC
2996: 
2997:     PROCEDURE HeaderQtVendClick()
2998:         THIS.OrdenarGradeProdutos("qtvend", .F.)

*-- Linhas 3326 a 3345:
3326:                     loc_oBusca.this_cTitulo        = "Moedas"
3327:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Moedas"
3328:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Moedas"
3329:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3330:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3331:                     loc_oBusca.Show()
3332:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3333:                         SELECT cursor_4c_BuscaMoeda
3334:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3335:                     ELSE
3336:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3337:                     ENDIF
3338:                     loc_oBusca.Release()
3339:                 ENDIF
3340:             ELSE
3341:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3342:             ENDIF
3343:         CATCH TO loc_oErro
3344:             MsgErro(loc_oErro.Message, "Erro")
3345:         ENDTRY

*-- Linhas 3441 a 3460:
3441:                     loc_oBusca.this_cTitulo        = loc_cTitulo
3442:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
3443:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
3444:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
3445:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
3446:                     loc_oBusca.Show()
3447:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
3448:                         SELECT cursor_4c_BuscaEmp
3449:                         IF VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_BuscaEmp.Cemps))
3450:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
3451:                         ELSE
3452:                             MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3453:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3454:                         ENDIF
3455:                     ELSE
3456:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3457:                     ENDIF
3458:                     loc_oBusca.Release()
3459:                 ENDIF
3460:             ELSE

*-- Linhas 3645 a 3663:
3645:     *==========================================================================
3646:     * ValidarCpf - KeyPress de txt_4c_Cpf (container cnt_4c_Origem, Page1).
3647:     * Legado (Origem.Get_cpf.Valid): fwbuscaext em SigCdCli.cpfs (aqui via
3648:     * FormBuscaAuxiliar - mAddColuna cpfs/iclis/rclis) + fAcessoContas para
3649:     * validar o acesso ao registro escolhido e preencher Conta/DConta.
3650:     *==========================================================================
3651:     PROCEDURE ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
3652:         LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_oBusca, loc_oErro
3653: 
3654:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3655: 
3656:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3657:             RETURN
3658:         ENDIF
3659: 
3660:         loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3661:         loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
3662:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
3663: 

*-- Linhas 3677 a 3697:
3677: 
3678:             IF VARTYPE(loc_oBusca) = "O"
3679:                 IF !loc_oBusca.this_lAchouRegistro
3680:                     loc_oBusca.mAddColuna("cpfs",  "", "CPF / CGC")
3681:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
3682:                     loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
3683:                     loc_oBusca.Show()
3684:                 ENDIF
3685: 
3686:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
3687:                     SELECT cursor_4c_BuscaCpf
3688:                     loc_cVal = ALLTRIM(cursor_4c_BuscaCpf.iclis)
3689: 
3690:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
3691:                             loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3692:                         MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3693:                         loc_oOrigem.txt_4c_Cpf.Value    = ""
3694:                         loc_oOrigem.txt_4c_Conta.Value  = ""
3695:                         loc_oOrigem.txt_4c_Dconta.Value = ""
3696:                     ELSE
3697:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)

*-- Linhas 3784 a 3808:
3784:             *--   CMG_4C_MUDAFOR / CMG_4C_MUDAMOV - so um por vez, alternados
3785:             *--   PGF_4C_RESULT         - a Pagina Resultado abre no cadastro
3786:             *--   CNT_4C_IMPRIMEOPCOES  - painel de opcoes de impressao
3787:             *--   GRD_4C_PENDENTEOCULTA - Grid1 do legado, nunca exibida
3788:             *--   IMG_4C_FIGURA / IMG_4C_FOTOPRODUTO - so com foto disponivel
3789:             *--   LBL_4C_MSGFOTO / LBL_4C_MSGFOTOPRODUTO - so SEM foto
3790:             *--   LBL_4C_MENSAGEM1 / 2 - so sem Analise de Vendas
3791:             loc_lPularVisible = INLIST(UPPER(loc_oObjeto.Name), ;
3792:                 "CMG_4C_MUDAFOR", "CMG_4C_MUDAMOV", "PGF_4C_RESULT", ;
3793:                 "CNT_4C_IMPRIMEOPCOES", "GRD_4C_PENDENTEOCULTA", ;
3794:                 "IMG_4C_FIGURA", "IMG_4C_FOTOPRODUTO", "LBL_4C_MSGFOTO", ;
3795:                 "LBL_4C_MSGFOTOPRODUTO", "LBL_4C_MENSAGEM1", "LBL_4C_MENSAGEM2")
3796: 
3797:             IF !loc_lPularVisible AND PEMSTATUS(loc_oObjeto, "Visible", 5)
3798:                 loc_oObjeto.Visible = .T.
3799:             ENDIF
3800: 
3801:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3802:                 FOR loc_nP = 1 TO loc_oObjeto.PageCount
3803:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3804:                 ENDFOR
3805:             ELSE
3806:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3807:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3808:                 ENDIF

