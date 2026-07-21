# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2444: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2450: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS GRID (3680 linhas total):

*-- Linhas 412 a 437:
412:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
413: 
414:         *-- Grid de lista de lotes - abaixo dos filtros de data
415:         *-- ColumnCount ANTES do WITH para que Column1..N existam no bloco
416:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
417:         loc_oPagina.grd_4c_Dados.Top         = 155
418:         loc_oPagina.grd_4c_Dados.Left        = 12
419:         loc_oPagina.grd_4c_Dados.Width       = 1100
420:         loc_oPagina.grd_4c_Dados.Height      = 430
421:         loc_oPagina.grd_4c_Dados.ColumnCount = 6
422:         WITH loc_oPagina.grd_4c_Dados
423:             .FontName           = "Verdana"
424:             .FontSize           = 8
425:             .ForeColor          = RGB(90, 90, 90)
426:             .BackColor          = RGB(255, 255, 255)
427:             .GridLineColor      = RGB(238, 238, 238)
428:             .HighlightBackColor = RGB(255, 255, 255)
429:             .HighlightForeColor = RGB(15, 41, 104)
430:             .HighlightStyle     = 2
431:             .DeleteMark         = .F.
432:             .RecordMark         = .F.
433:             .RowHeight          = 16
434:             .ScrollBars         = 2
435:             .GridLines          = 3
436:             .Visible            = .T.
437:             .Column1.Width = 80

*-- Linhas 546 a 564:
546:     * OptionGroups: opt_4c_Custo (2 botoes), opt_4c_Fil (3 botoes)
547:     * Botoes: cmd_4c_Processar, cmd_4c_BotConsulta, cmd_4c_BtnCadastros,
548:     *         cmd_4c_Command12, cmd_4c_CmdOperacao (CommandGroup)
549:     * Grid: grd_4c_Estoque (5 colunas: Empresa, Movimentacao, Numero, Grupo, Conta)
550:     * Offset +29 em Top para compensar aba oculta do inner PageFrame
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarPaginaDadosLote()
553:         LOCAL loc_oPg2P1
554:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
555: 
556:         *-- Label: Fornecedores (Say4: top=69+29=98)
557:         loc_oPg2P1.AddObject("lbl_4c_Forn", "Label")
558:         WITH loc_oPg2P1.lbl_4c_Forn
559:             .Caption   = "Fornecedores :"
560:             .AutoSize  = .T.
561:             .Top = 98
562:             .Left = 228
563:             .Height = 15
564:             .FontName  = "Tahoma"

*-- Linhas 852 a 900:
852:             .Visible = .T.
853:         ENDWITH
854: 
855:         *-- Grid: grdEstoque / grd_4c_Estoque (top=206+29=235)
856:         *-- ColumnCount OBRIGATORIAMENTE antes do WITH
857:         loc_oPg2P1.AddObject("grd_4c_Estoque", "Grid")
858:         loc_oPg2P1.grd_4c_Estoque.Top         = 235
859:         loc_oPg2P1.grd_4c_Estoque.Left        = 307
860:         loc_oPg2P1.grd_4c_Estoque.Width       = 545
861:         loc_oPg2P1.grd_4c_Estoque.Height      = 340
862:         loc_oPg2P1.grd_4c_Estoque.ColumnCount = 5
863:         WITH loc_oPg2P1.grd_4c_Estoque
864:             .FontName          = "Tahoma"
865:             .FontSize          = 8
866:             .ForeColor         = RGB(90, 90, 90)
867:             .BackColor         = RGB(237, 242, 243)
868:             .GridLineColor     = RGB(238, 238, 238)
869:             .AllowHeaderSizing = .F.
870:             .AllowRowSizing    = .F.
871:             .DeleteMark        = .F.
872:             .RecordMark        = .F.
873:             .RowHeight         = 16
874:             .ScrollBars        = 2
875:             .Visible           = .T.
876:             .Column1.Width = 70
877:             .Column1.Header1.Caption = "Empresa"
878:             .Column2.Width = 200
879:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
880:             .Column3.Width = 80
881:             .Column3.Header1.Caption = "Numero"
882:             .Column4.Width = 80
883:             .Column4.Header1.Caption = "Grupo"
884:             .Column5.Width = 80
885:             .Column5.Header1.Caption = "Conta"
886:             .Column4.ReadOnly = .T.
887:             .Column5.ReadOnly = .T.
888:         ENDWITH
889: 
890:         *-- Button: Bot_Consulta / cmd_4c_BotConsulta (top=70+29=99, left=667)
891:         loc_oPg2P1.AddObject("cmd_4c_BotConsulta", "CommandButton")
892:         WITH loc_oPg2P1.cmd_4c_BotConsulta
893:             .Caption     = ""
894:             .Picture     = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
895:             .Top = 99
896:             .Left = 667
897:             .Width = 40
898:             .Height = 40
899:             .BackColor = RGB(255,255,255)
900:             .ForeColor = RGB(90,90,90)

*-- Linhas 1205 a 1223:
1205:             IF USED("cursor_4c_Linhas")
1206:                 ZAP IN cursor_4c_Linhas
1207:             ELSE
1208:                 CREATE CURSOR cursor_4c_Linhas ;
1209:                     (Cpros    C(14), CodCors C(4),   CodTams  C(4),  ;
1210:                      OriDopNums C(29), Qtds N(12,2), QtdOs    N(12,2), ;
1211:                      Contas   C(10),  Arquivo C(200), Moedas  C(3),   ;
1212:                      Precific N(12,2), FkChaves C(20))
1213:             ENDIF
1214: 
1215:             IF USED("cursor_4c_TmpJoin") AND RECCOUNT("cursor_4c_TmpJoin") > 0
1216:                 SELECT cursor_4c_TmpJoin
1217:                 GO TOP
1218:                 SCAN
1219:                     loc_nQtdOs = IIF(cursor_4c_TmpJoin.QtdXml > cursor_4c_TmpJoin.Qtds, ;
1220:                                      cursor_4c_TmpJoin.Qtds, cursor_4c_TmpJoin.QtdXml)
1221:                     INSERT INTO cursor_4c_Linhas ;
1222:                         (Cpros, CodCors, CodTams, OriDopNums, Qtds, QtdOs, ;
1223:                          Contas, Arquivo, Moedas, Precific, FkChaves) ;

*-- Linhas 1425 a 1445:
1425:     ENDPROC
1426: 
1427:     *--------------------------------------------------------------------------
1428:     * CarregarLista - Busca lotes do banco e popula grd_4c_Dados
1429:     * Propaga datas de this_dDataInicial/this_dDataFinal para o BO
1430:     * grd_4c_Dados e controles de filtro sao criados na Fase 4;
1431:     *   este metodo le os controles se existirem, graciosamente ignora se nao
1432:     *--------------------------------------------------------------------------
1433:     PROCEDURE CarregarLista()
1434:         LOCAL loc_lResultado, loc_oPg1, loc_oGrid
1435:         loc_lResultado = .F.
1436: 
1437:         TRY
1438:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1439:                 loc_lResultado = .T.
1440:             ELSE
1441:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1442: 
1443:                 *-- Propagar filtros de data a partir dos controles (Fase 4 cria os controles)
1444:                 IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
1445:                     THIS.this_oBusinessObject.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value

*-- Linhas 1455 a 1491:
1455: 
1456:                 IF THIS.this_oBusinessObject.Buscar("")
1457:                     *-- Popula grid quando existir (criado na Fase 4)
1458:                     IF PEMSTATUS(loc_oPg1, "grd_4c_Dados", 5)
1459:                         loc_oGrid = loc_oPg1.grd_4c_Dados
1460:                         loc_oGrid.ColumnCount = 3
1461:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1462: 
1463:                         WITH loc_oGrid
1464:                             .Column1.ControlSource = "cursor_4c_Dados.Codigos"
1465:                             .Column2.ControlSource = "cursor_4c_Dados.Datas"
1466:                             .Column3.ControlSource = "cursor_4c_Dados.Contas"
1467:                             .Column4.ControlSource = "cursor_4c_Dados.Rclis"
1468:                             .Column5.ControlSource = "cursor_4c_Dados.Usuars"
1469:                             .Column6.ControlSource = "cursor_4c_Dados.OriDopNums"
1470: 
1471:                             .Column1.Header1.Caption = "Lote"
1472:                             .Column2.Header1.Caption = "Data"
1473:                             .Column3.Header1.Caption = "Conta"
1474:                             .Column4.Header1.Caption = "Fornecedor"
1475:                             .Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
1476:                             .Column6.Header1.Caption = "Origem"
1477:                         ENDWITH
1478: 
1479:                         THIS.FormatarGridLista(loc_oGrid)
1480:                     ENDIF
1481: 
1482:                     loc_lResultado = .T.
1483:                 ENDIF
1484:             ENDIF
1485:         CATCH TO loc_oErro
1486:             MsgErro("Erro em FormSigPrCtr.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
1487:         ENDTRY
1488: 
1489:         RETURN loc_lResultado
1490:     ENDPROC
1491: 

*-- Linhas 1573 a 1592:
1573:                         USE IN cursor_4c_BuscaGrp
1574:                     ENDIF
1575:                     =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1576:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
1577:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1578:                     loc_oBusca.Show()
1579:                 ENDIF
1580:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1581:                     loc_oPg2P1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1582:                     THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1583:                 ENDIF
1584:                 IF USED("cursor_4c_BuscaGrp")
1585:                     USE IN cursor_4c_BuscaGrp
1586:                 ENDIF
1587:                 loc_oBusca.Release()
1588:             ENDIF
1589:         CATCH TO loc_oErro
1590:             MsgErro("Erro em FormSigPrCtr.AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "Erro")
1591:         ENDTRY
1592:     ENDPROC

*-- Linhas 1630 a 1650:
1630:                         USE IN cursor_4c_BuscaCli
1631:                     ENDIF
1632:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1633:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1634:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1635:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1636:                     loc_oBusca.Show()
1637:                 ENDIF
1638:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1639:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1640:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1641:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1642:                     ENDIF
1643:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1644:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1645:                     ENDIF
1646:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1647:                 ENDIF
1648:                 IF USED("cursor_4c_BuscaCli")
1649:                     USE IN cursor_4c_BuscaCli
1650:                 ENDIF

*-- Linhas 1694 a 1714:
1694:                         USE IN cursor_4c_BuscaCli
1695:                     ENDIF
1696:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1697:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1698:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1699:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1700:                     loc_oBusca.Show()
1701:                 ENDIF
1702:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1703:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1704:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1705:                     ENDIF
1706:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1707:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1708:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1709:                     ENDIF
1710:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1711:                 ENDIF
1712:                 IF USED("cursor_4c_BuscaCli")
1713:                     USE IN cursor_4c_BuscaCli
1714:                 ENDIF

*-- Linhas 1758 a 1777:
1758:                         USE IN cursor_4c_BuscaMoe
1759:                     ENDIF
1760:                     =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1761:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1762:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1763:                     loc_oBusca.Show()
1764:                 ENDIF
1765:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1766:                     loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1767:                 ENDIF
1768:                 IF USED("cursor_4c_BuscaMoe")
1769:                     USE IN cursor_4c_BuscaMoe
1770:                 ENDIF
1771:                 loc_oBusca.Release()
1772:             ENDIF
1773:         CATCH TO loc_oErro
1774:             MsgErro("Erro em FormSigPrCtr.AbrirLookupMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
1775:         ENDTRY
1776:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1777:             loc_oPg2P1.txt_4c_Moeda.Refresh

*-- Linhas 1858 a 1878:
1858:                                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", ;
1859:                                 "cursor_4c_BuscaCli")
1860:                         ENDIF
1861:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1862:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1863:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1864:                         loc_oBusca.Show()
1865:                     ENDIF
1866:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1867:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1868:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1869:                             loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1870:                         ENDIF
1871:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1872:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1873:                         ENDIF
1874:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1875:                     ELSE
1876:                         loc_oPg2P1.txt_4c_Conta.Value = ""
1877:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1878:                             loc_oPg2P1.txt_4c_Dconta.Value = ""

*-- Linhas 1966 a 1986:
1966:                         =SQLEXEC(gnConnHandle, ;
1967:                             "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
1968:                             "cursor_4c_BuscaCli")
1969:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1970:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1971:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1972:                         loc_oBusca.Show()
1973:                     ENDIF
1974:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1975:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1976:                             loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1977:                         ENDIF
1978:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1979:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1980:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1981:                         ENDIF
1982:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1983:                     ELSE
1984:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1985:                             loc_oPg2P1.txt_4c_Conta.Value = ""
1986:                         ENDIF

*-- Linhas 2120 a 2139:
2120:                         =SQLEXEC(gnConnHandle, ;
2121:                             "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2122:                             "cursor_4c_BuscaMoe")
2123:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2124:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2125:                         loc_oBusca.Show()
2126:                     ENDIF
2127:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2128:                         loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2129:                     ELSE
2130:                         loc_oPg2P1.txt_4c_Moeda.Value = ""
2131:                     ENDIF
2132:                     IF USED("cursor_4c_BuscaMoe")
2133:                         USE IN cursor_4c_BuscaMoe
2134:                     ENDIF
2135:                     loc_oBusca.Release()
2136:                 ENDIF
2137:             ENDIF
2138:         CATCH TO loc_oErro
2139:             MsgErro("Erro em FormSigPrCtr.TxtMoedaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 2397 a 2415:
2397: 
2398:             IF !loc_lAbortou AND EMPTY(loc_cListaOriDopNums)
2399:                 loc_cListaOriDopNums = ""  && keep var in scope
2400:                 CREATE CURSOR cursor_4c_Movimentos ;
2401:                     ( Cpros C(14), Dpros C(30), Units N(12,4), ;
2402:                       Qtds N(12,2), QtBaixas N(12,2), QtReservas N(12,2), Saldo N(12,2), ;
2403:                       OriDopNums C(29), Cgrus C(10), Sgrus C(10), ;
2404:                       CidChaves C(20), Moedas C(3) )
2405:             ENDIF
2406: 
2407:             *-- Passo 5: aplica filtro Opt_Fil
2408:             loc_nTipo = 3
2409:             IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
2410:                 loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
2411:             ENDIF
2412: 
2413:             IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
2414:                RECCOUNT("cursor_4c_Distribui") > 0 AND ;
2415:                USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0

*-- Linhas 2430 a 2466:
2430:                 ENDIF
2431:                 IF USED("cursor_4c_MovFiltro")
2432:                     SELECT * FROM cursor_4c_MovFiltro ;
2433:                         INTO CURSOR cursor_4c_Movimentos READWRITE
2434:                     USE IN cursor_4c_MovFiltro
2435:                     GO TOP IN cursor_4c_Movimentos
2436:                 ENDIF
2437:             ENDIF
2438: 
2439:             *-- Passo 6: vincula grids de Page2 e muda para ela
2440:             IF USED("cursor_4c_Movimentos") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_Disponivel", 5)
2441:                 WITH loc_oPgDados.Page2.grd_4c_Disponivel
2442:                     .RecordSourceType = 1
2443:                     .RecordSource     = "cursor_4c_Movimentos"
2444:                 ENDWITH
2445:             ENDIF
2446:             IF USED("cursor_4c_Distribui") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_ItemXml", 5)
2447:                 WITH loc_oPgDados.Page2.grd_4c_ItemXml
2448:                     .RecordSourceType = 1
2449:                     .RecordSource     = "cursor_4c_Distribui"
2450:                 ENDWITH
2451:             ENDIF
2452:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Sistema", 5)
2453:                 loc_oPgDados.Page2.txt_4c_Sistema.Value = "Sistema"
2454:             ENDIF
2455:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Arquivo", 5)
2456:                 loc_oPgDados.Page2.txt_4c_Arquivo.Value = "Arquivo"
2457:             ENDIF
2458:             IF PEMSTATUS(loc_oPgDados, "ActivePage", 5)
2459:                 loc_oPgDados.ActivePage = 2
2460:             ENDIF
2461: 
2462:         CATCH TO loc_oErro
2463:             MsgErro("Erro em FormSigPrCtr.CmdProcessarClick:" + CHR(13) + ;
2464:                     loc_oErro.Message, "Erro")
2465:         ENDTRY
2466:     ENDPROC

*-- Linhas 2480 a 2498:
2480:             IF USED("cursor_4c_Itens")
2481:                 USE IN cursor_4c_Itens
2482:             ENDIF
2483:             CREATE CURSOR cursor_4c_Itens ;
2484:                 ( codigo C(15), Descr C(60), quant C(15), valor_uni C(15), ;
2485:                   valor_tot C(15), unid C(5), cfop C(4), ncm C(8), ;
2486:                   desconto C(15), frete C(15) )
2487: 
2488:             loc_oXML = CREATEOBJECT("MSXML2.DOMDocument")
2489:             IF VARTYPE(loc_oXML) != "O"
2490:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2491:                         "vel criar objeto MSXML2.DOMDocument.", "Erro COM")
2492:             ELSE
2493:                 loc_oXML.async = .F.
2494:                 WAIT WINDOW "Carregando: " + JUSTFNAME(par_cArquivo) NOWAIT
2495: 
2496:                 IF !loc_oXML.Load(par_cArquivo)
2497:                     MsgErro(JUSTFNAME(par_cArquivo) + " est" + CHR(225) + ;
2498:                             " corrompido.", "Erro XML")

*-- Linhas 2561 a 2579:
2561:         IF USED("cursor_4c_Distribui")
2562:             USE IN cursor_4c_Distribui
2563:         ENDIF
2564:         CREATE CURSOR cursor_4c_Distribui ;
2565:             ( Cpros C(14), Dpros C(30), Qtds N(12,2), Units N(12,4), Total N(14,2) )
2566: 
2567:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2568:             RETURN
2569:         ENDIF
2570: 
2571:         TRY
2572:             SELECT cursor_4c_Itens
2573:             GO TOP
2574: 
2575:             SCAN
2576:                 loc_cCodigo = ALLTRIM(cursor_4c_Itens.codigo)
2577:                 loc_nQtd    = VAL(ALLTRIM(cursor_4c_Itens.quant))
2578:                 loc_nVal    = VAL(ALLTRIM(cursor_4c_Itens.valor_uni))
2579:                 loc_nTot    = VAL(ALLTRIM(cursor_4c_Itens.valor_tot))

*-- Linhas 2646 a 2676:
2646:     ENDPROC
2647: 
2648:     *--------------------------------------------------------------------------
2649:     *   Chama BO e vincula grd_4c_Estoque com dados de movimentacao
2650:     *--------------------------------------------------------------------------
2651:     PROTECTED PROCEDURE CarregarMovimentosPendentes(par_cConta, par_lFiltrar)
2652:         LOCAL loc_oPg2P1, loc_oGrid, loc_lResultado, loc_oErro
2653:         loc_lResultado = .F.
2654: 
2655:         TRY
2656:             IF THIS.this_oBusinessObject.BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
2657:                 loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2658:                 IF PEMSTATUS(loc_oPg2P1, "grd_4c_Estoque", 5)
2659:                     loc_oGrid = loc_oPg2P1.grd_4c_Estoque
2660:                     loc_oGrid.ColumnCount = 5
2661:                     loc_oGrid.RecordSource = "cursor_4c_Pendentes"
2662:                     WITH loc_oGrid
2663:                         .Column1.ControlSource = "cursor_4c_Pendentes.Emps"
2664:                         .Column2.ControlSource = "cursor_4c_Pendentes.Dopes"
2665:                         .Column3.ControlSource = "cursor_4c_Pendentes.Numes"
2666:                         .Column4.ControlSource = "cursor_4c_Pendentes.Grupos"
2667:                         .Column5.ControlSource = "cursor_4c_Pendentes.Contas"
2668:                     ENDWITH
2669:                 ENDIF
2670:                 loc_lResultado = .T.
2671:             ENDIF
2672:         CATCH TO loc_oErro
2673:             MsgErro("Erro em FormSigPrCtr.CarregarMovimentosPendentes:" + CHR(13) + ;
2674:                     loc_oErro.Message, "Erro")
2675:         ENDTRY
2676: 

*-- Linhas 2800 a 2825:
2800:         ENDWITH
2801:         BINDEVENT(loc_oPg2P2.txt_4c__produto_inicial, "KeyPress", THIS, "TxtProdutoInicialLostFocus")
2802: 
2803:         *-- Grid disponivel / grd_4c_Disponivel (7 colunas, top=134+29=163)
2804:         loc_oPg2P2.AddObject("grd_4c_Disponivel", "Grid")
2805:         loc_oPg2P2.grd_4c_Disponivel.ColumnCount = 7
2806:         loc_oPg2P2.grd_4c_Disponivel.Top         = 163
2807:         loc_oPg2P2.grd_4c_Disponivel.Left        = 8
2808:         loc_oPg2P2.grd_4c_Disponivel.Width       = 684
2809:         loc_oPg2P2.grd_4c_Disponivel.Height      = 344
2810:         WITH loc_oPg2P2.grd_4c_Disponivel
2811:             .FontName  = "Tahoma"
2812:             .FontSize = 8
2813:             .ReadOnly  = .T.
2814:             .RecordMark = .F.
2815:             .RowHeight = 17
2816:             .Panel = 1
2817:             .BackColor = RGB(237, 242, 243)
2818:             .GridLineColor = RGB(238, 238, 238)
2819:             .AllowHeaderSizing = .F.
2820:             .AllowRowSizing = .F.
2821:             .ScrollBars = 2
2822:             .Visible = .T.
2823: 
2824:             WITH .Column1
2825:                 .Width = 100

*-- Linhas 2831 a 3004:
2831:                 .MousePointer = 15
2832:                 .FontBold = .T.
2833:                 .FontUnderline = .T.
2834:                 .Header1.Caption = "C" + CHR(243) + "digo"
2835:                 .Header1.Alignment = 2
2836:                 .Header1.ForeColor = RGB(90, 90, 90)
2837:                 .ControlSource = "cursor_4c_Movimentos.Cpros"
2838:             ENDWITH
2839: 
2840:             WITH .Column2
2841:                 .Width = 235
2842:                 .Movable = .F.
2843:                 .Resizable = .F.
2844:                 .ReadOnly = .T.
2845:                 .BackColor = RGB(237, 242, 243)
2846:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2847:                 .Header1.Alignment = 2
2848:                 .Header1.ForeColor = RGB(90, 90, 90)
2849:                 .ControlSource = "cursor_4c_Movimentos.Dpros"
2850:             ENDWITH
2851: 
2852:             WITH .Column3
2853:                 .Width = 70
2854:                 .Movable = .F.
2855:                 .Resizable = .F.
2856:                 .ReadOnly = .T.
2857:                 .BackColor = RGB(237, 242, 243)
2858:                 .Header1.Caption = "Valor"
2859:                 .Header1.Alignment = 2
2860:                 .Header1.ForeColor = RGB(90, 90, 90)
2861:                 .ControlSource = "cursor_4c_Movimentos.Units"
2862:             ENDWITH
2863: 
2864:             WITH .Column4
2865:                 .Width = 63
2866:                 .Movable = .F.
2867:                 .Resizable = .F.
2868:                 .ReadOnly = .T.
2869:                 .BackColor = RGB(237, 242, 243)
2870:                 .FontBold = .T.
2871:                 .Header1.Caption = "Quantidade"
2872:                 .Header1.Alignment = 2
2873:                 .Header1.ForeColor = RGB(90, 90, 90)
2874:                 .ControlSource = "cursor_4c_Movimentos.Qtds"
2875:             ENDWITH
2876: 
2877:             WITH .Column5
2878:                 .Width = 63
2879:                 .Movable = .F.
2880:                 .Resizable = .F.
2881:                 .ReadOnly = .T.
2882:                 .BackColor = RGB(237, 242, 243)
2883:                 .FontBold = .T.
2884:                 .Header1.Caption = "Baixado"
2885:                 .Header1.Alignment = 2
2886:                 .Header1.ForeColor = RGB(90, 90, 90)
2887:                 .ControlSource = "cursor_4c_Movimentos.QtBaixas"
2888:             ENDWITH
2889: 
2890:             WITH .Column6
2891:                 .Width = 63
2892:                 .Movable = .F.
2893:                 .Resizable = .F.
2894:                 .ReadOnly = .T.
2895:                 .BackColor = RGB(237, 242, 243)
2896:                 .FontBold = .T.
2897:                 .Header1.Caption = "Reservado"
2898:                 .Header1.Alignment = 2
2899:                 .Header1.ForeColor = RGB(90, 90, 90)
2900:                 .ControlSource = "cursor_4c_Movimentos.QtReservas"
2901:             ENDWITH
2902: 
2903:             WITH .Column7
2904:                 .Width = 63
2905:                 .Movable = .F.
2906:                 .Resizable = .F.
2907:                 .ReadOnly = .T.
2908:                 .BackColor = RGB(237, 242, 243)
2909:                 .FontBold = .T.
2910:                 .Header1.Caption = "Saldo"
2911:                 .Header1.Alignment = 2
2912:                 .Header1.ForeColor = RGB(90, 90, 90)
2913:                 .ControlSource = "cursor_4c_Movimentos.Saldo"
2914:             ENDWITH
2915:         ENDWITH
2916:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
2917:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")
2918: 
2919:         *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
2920:         loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
2921:         loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
2922:         loc_oPg2P2.grd_4c_ItemXml.Top         = 163
2923:         loc_oPg2P2.grd_4c_ItemXml.Left        = 693
2924:         loc_oPg2P2.grd_4c_ItemXml.Width       = 493
2925:         loc_oPg2P2.grd_4c_ItemXml.Height      = 344
2926:         WITH loc_oPg2P2.grd_4c_ItemXml
2927:             .FontName  = "Tahoma"
2928:             .FontSize = 8
2929:             .RecordMark = .F.
2930:             .Panel = 1
2931:             .BackColor = RGB(237, 242, 243)
2932:             .GridLineColor = RGB(238, 238, 238)
2933:             .AllowHeaderSizing = .F.
2934:             .AllowRowSizing = .F.
2935:             .RowHeight = 17
2936:             .Visible = .T.
2937: 
2938:             WITH .Column1
2939:                 .Width = 100
2940:                 .Movable = .F.
2941:                 .Resizable = .F.
2942:                 .ReadOnly = .T.
2943:                 .Enabled = .F.
2944:                 .ForeColor = RGB(0, 0, 0)
2945:                 .BackColor = RGB(237, 242, 243)
2946:                 .Header1.Caption = "C" + CHR(243) + "digo"
2947:                 .Header1.Alignment = 2
2948:                 .Header1.ForeColor = RGB(90, 90, 90)
2949:                 .ControlSource = "cursor_4c_Distribui.Cpros"
2950:             ENDWITH
2951: 
2952:             WITH .Column2
2953:                 .Width = 235
2954:                 .Movable = .F.
2955:                 .Resizable = .F.
2956:                 .ReadOnly = .T.
2957:                 .Enabled = .F.
2958:                 .ForeColor = RGB(0, 0, 0)
2959:                 .BackColor = RGB(237, 242, 243)
2960:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2961:                 .Header1.Alignment = 2
2962:                 .Header1.ForeColor = RGB(90, 90, 90)
2963:                 .ControlSource = "cursor_4c_Distribui.Dpros"
2964:             ENDWITH
2965: 
2966:             WITH .Column3
2967:                 .Width = 63
2968:                 .Movable = .F.
2969:                 .Resizable = .F.
2970:                 .InputMask = "999999"
2971:                 .ForeColor = RGB(0, 0, 0)
2972:                 .BackColor = RGB(237, 242, 243)
2973:                 .Header1.Caption = "Quantidade"
2974:                 .Header1.Alignment = 2
2975:                 .Header1.ForeColor = RGB(90, 90, 90)
2976:                 .ControlSource = "cursor_4c_Distribui.Qtds"
2977:             ENDWITH
2978: 
2979:             WITH .Column4
2980:                 .Width = 70
2981:                 .Movable = .F.
2982:                 .Resizable = .F.
2983:                 .ReadOnly = .T.
2984:                 .Enabled = .F.
2985:                 .ForeColor = RGB(0, 0, 0)
2986:                 .BackColor = RGB(237, 242, 243)
2987:                 .Header1.Caption = "Valor"
2988:                 .Header1.Alignment = 2
2989:                 .Header1.ForeColor = RGB(90, 90, 90)
2990:                 .ControlSource = "cursor_4c_Distribui.Total"
2991:             ENDWITH
2992:         ENDWITH
2993: 
2994:         *-- Botao excluir Grade Sistema / cmd_4c_BtnExcluirSis (top=479+29=508)
2995:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
2996:         WITH loc_oPg2P2.cmd_4c_BtnExcluirSis
2997:             .Caption = ""
2998:             .Themes = .F.
2999:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3000:             .Top = 508
3001:             .Left = 663
3002:             .Width = 40
3003:             .Height = 37
3004:             .ForeColor = RGB(255, 0, 0)

*-- Linhas 3332 a 3362:
3332:         LOCAL loc_oPg2P2, loc_oErro
3333:         TRY
3334:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3335:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3336:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3337:             ENDIF
3338:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3339:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3340:             ENDIF
3341:         CATCH TO loc_oErro
3342:             MsgErro("Erro em FormSigPrCtr.PgfDadosPage2Activate:" + CHR(13) + loc_oErro.Message, "Erro")
3343:         ENDTRY
3344:     ENDPROC
3345: 
3346:     *--------------------------------------------------------------------------
3347:     * GrdDisponivelAfterRowColChange - Ao mover linha em grd_4c_Disponivel:
3348:     *   busca detalhes SigCdPro e popula campos inferiores + FigJpg
3349:     *--------------------------------------------------------------------------
3350:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
3351:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult, loc_cArqTemp
3352:         LOCAL loc_cFigJpgs, loc_cFoto, loc_lTemFig
3353:         LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda, loc_nValVenda
3354:         LOCAL loc_lAbortou, loc_oErro
3355:         loc_lAbortou = .F.
3356: 
3357:         TRY
3358:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3359:                 loc_lAbortou = .T.
3360:             ENDIF
3361: 
3362:             IF !loc_lAbortou

*-- Linhas 3485 a 3530:
3485:                 GO TOP IN cursor_4c_Movimentos
3486:             ENDIF
3487:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3488:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3489:                 loc_oPg2P2.grd_4c_Disponivel.SetFocus()
3490:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3491:             ENDIF
3492:         CATCH TO loc_oErro
3493:             MsgErro("Erro em FormSigPrCtr.BtnExcluirSisClick:" + CHR(13) + loc_oErro.Message, "Erro")
3494:         ENDTRY
3495:     ENDPROC
3496: 
3497:     *--------------------------------------------------------------------------
3498:     * BtnExcluirArqClick - Delete linha corrente de cursor_4c_Distribui
3499:     *--------------------------------------------------------------------------
3500:     PROCEDURE BtnExcluirArqClick()
3501:         LOCAL loc_oPg2P2, loc_oErro
3502:         TRY
3503:             IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
3504:                 SELECT cursor_4c_Distribui
3505:                 DELETE
3506:                 IF !EOF("cursor_4c_Distribui")
3507:                     SKIP
3508:                     SKIP -1
3509:                 ENDIF
3510:                 GO TOP IN cursor_4c_Distribui
3511:             ENDIF
3512:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3513:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3514:                 loc_oPg2P2.grd_4c_ItemXml.SetFocus()
3515:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3516:             ENDIF
3517:         CATCH TO loc_oErro
3518:             MsgErro("Erro em FormSigPrCtr.BtnExcluirArqClick:" + CHR(13) + loc_oErro.Message, "Erro")
3519:         ENDTRY
3520:     ENDPROC
3521: 
3522:     *--------------------------------------------------------------------------
3523:     * TxtProdutoInicialLostFocus - Localiza produto em cursor_4c_Movimentos
3524:     *--------------------------------------------------------------------------
3525:     PROCEDURE TxtProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3526:         LOCAL loc_oPg2P2, loc_cValor, loc_nRecno, loc_oErro
3527:         TRY
3528:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3529:             IF PEMSTATUS(loc_oPg2P2, "txt_4c__produto_inicial", 5)
3530:                 loc_cValor = ALLTRIM(loc_oPg2P2.txt_4c__produto_inicial.Value)

*-- Linhas 3608 a 3627:
3608:         LOCAL loc_oPg2P2, loc_cCpros, loc_oErro
3609:         TRY
3610:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3611:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3612:                 IF loc_oPg2P2.grd_4c_Disponivel.ActiveColumn # 1
3613:                     RETURN
3614:                 ENDIF
3615:             ENDIF
3616:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3617:                 RETURN
3618:             ENDIF
3619:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3620:             IF EMPTY(loc_cCpros)
3621:                 RETURN
3622:             ENDIF
3623:             IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg") OR ;
3624:                FILE(gc_4c_CaminhoForms + "FormSigOpCgp.prg")
3625:                 DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg")
3626:             ELSE
3627:                 MsgInfo("Produto: " + loc_cCpros + CHR(13) + ;

