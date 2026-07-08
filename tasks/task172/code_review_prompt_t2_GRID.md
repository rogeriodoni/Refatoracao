# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (3)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 761: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2543: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2602: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS GRID (2852 linhas total):

*-- Linhas 379 a 421:
379:         ENDWITH
380: 
381:         *-- Grid principal (Grade no legado - SigPrDis via cursor_4c_Lista)
382:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
383:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
384: 
385:         WITH loc_oPagina.grd_4c_Lista
386:             .Top                = 165
387:             .Left               = 24
388:             .Width              = 900
389:             .Height             = 420
390:             .FontName           = "Verdana"
391:             .FontSize           = 8
392:             .ForeColor          = RGB(90, 90, 90)
393:             .BackColor          = RGB(255, 255, 255)
394:             .GridLineColor      = RGB(238, 238, 238)
395:             .HighlightBackColor = RGB(255, 255, 255)
396:             .HighlightForeColor = RGB(15, 41, 104)
397:             .HighlightStyle     = 2
398:             .DeleteMark         = .F.
399:             .RecordMark         = .F.
400:             .RowHeight          = 16
401:             .ScrollBars         = 2
402:             .GridLines          = 3
403:             .Visible            = .T.
404:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
405:             .Column1.Width           = 150
406:             .Column2.Header1.Caption = "Data"
407:             .Column2.Width           = 150
408:         ENDWITH
409: 
410:         *-- BINDEVENTs
411:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
412:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
413:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
414:         BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
415:         BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
416:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
417:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "LostFocus",     THIS, "DtInicialValid")
418:         BINDEVENT(loc_oPagina.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
419: 
420:         THIS.TornarControlesVisiveis(loc_oPagina)
421:     ENDPROC

*-- Linhas 571 a 622:
571:         ENDWITH
572: 
573:         *-- Grid de Estoques (grdEstoque no legado: top=207, left=335, width=271, height=244)
574:         loc_oPage.AddObject("grd_4c_Estoque", "Grid")
575:         loc_oPage.grd_4c_Estoque.ColumnCount = 4
576: 
577:         WITH loc_oPage.grd_4c_Estoque
578:             .Top                = 207
579:             .Left               = 335
580:             .Width              = 271
581:             .Height             = 244
582:             .FontName           = "Verdana"
583:             .FontSize           = 8
584:             .ForeColor          = RGB(90, 90, 90)
585:             .BackColor          = RGB(255, 255, 255)
586:             .GridLineColor      = RGB(238, 238, 238)
587:             .HighlightBackColor = RGB(255, 255, 255)
588:             .HighlightForeColor = RGB(15, 41, 104)
589:             .HighlightStyle     = 2
590:             .DeleteMark         = .F.
591:             .RecordMark         = .F.
592:             .RowHeight          = 18
593:             .ScrollBars         = 2
594:             .GridLines          = 3
595:             .Visible            = .T.
596:             .Column1.Header1.Caption = ""
597:             .Column1.Width           = 25
598:             .Column2.Header1.Caption = "Empresa"
599:             .Column2.Width           = 80
600:             .Column3.Header1.Caption = "Grupo"
601:             .Column3.Width           = 80
602:             .Column4.Header1.Caption = "Conta"
603:             .Column4.Width           = 80
604:         ENDWITH
605: 
606:         *-- CheckBox em Column1 para toggle nMarca (Check1 no legado)
607:         loc_oGrid = loc_oPage.grd_4c_Estoque
608:         loc_oGrid.Column1.AddObject("chk_4c_nMarca", "CheckBox")
609:         WITH loc_oGrid.Column1.chk_4c_nMarca
610:             .Caption = ""
611:             .Width   = 22
612:             .Height  = 17
613:             .Left    = 2
614:             .Top     = 1
615:             .Value   = 0
616:             .Visible = .T.
617:         ENDWITH
618:         loc_oGrid.Column1.CurrentControl = "chk_4c_nMarca"
619: 
620:         *-- TextBox read-only nas colunas de dados (When=.F. no legado)
621:         loc_oGrid.Column2.AddObject("txt_4c_Empresa", "TextBox")
622:         loc_oGrid.Column2.txt_4c_Empresa.ReadOnly = .T.

*-- Linhas 673 a 691:
673:                 loc_lResultado = .T.
674:             ELSE
675:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
676:                 loc_oGrid   = loc_oPagina.grd_4c_Lista
677:                 loc_dDatai  = loc_oPagina.txt_4c_DtInicial.Value
678:                 loc_dDataf  = loc_oPagina.txt_4c_DtFinal.Value
679: 
680:                 loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
681:                            " WHERE CAST(Datas AS DATE) BETWEEN" + ;
682:                            " CAST(" + FormatarDataSQL(loc_dDatai) + " AS DATE)" + ;
683:                            " AND CAST(" + FormatarDataSQL(loc_dDataf) + " AS DATE)"
684: 
685:                 IF USED("cursor_4c_ListaTemp")
686:                     USE IN cursor_4c_ListaTemp
687:                 ENDIF
688:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaTemp")
689: 
690:                 IF loc_nRet < 0
691:                     MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")

*-- Linhas 702 a 786:
702:                     IF USED("cursor_4c_ListaTemp")
703:                         USE IN cursor_4c_ListaTemp
704:                     ENDIF
705:                     loc_oGrid.ColumnCount = 2
706:                     loc_oGrid.RecordSource            = "cursor_4c_Lista"
707:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.Codigos"
708:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.Datas"
709:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
710:                     loc_oGrid.Column2.Header1.Caption = "Data"
711:                     loc_oGrid.Column1.Width           = 150
712:                     loc_oGrid.Column2.Width           = 150
713:                     THIS.FormatarGridLista(loc_oGrid)
714:                     loc_lResultado = .T.
715:                 ENDIF
716:             ENDIF
717: 
718:         CATCH TO loc_oErro
719:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
720:             loc_lResultado = .F.
721:         ENDTRY
722: 
723:         RETURN loc_lResultado
724:     ENDPROC
725: 
726:     *==========================================================================
727:     * CarregarEstoque - Carrega grd_4c_Estoque com SigCdCeg (estoques TpCads=3)
728:     *==========================================================================
729:     PROTECTED PROCEDURE CarregarEstoque()
730:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_cSQL, loc_nRet, loc_oErro
731:         loc_lResultado = .F.
732: 
733:         TRY
734:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
735:                 loc_lResultado = .T.
736:             ELSE
737:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
738:                 loc_oGrid = loc_oPage.grd_4c_Estoque
739: 
740:                 IF USED("cursor_4c_Estoque")
741:                     USE IN cursor_4c_Estoque
742:                 ENDIF
743:                 IF USED("cursor_4c_EstoqueTemp")
744:                     USE IN cursor_4c_EstoqueTemp
745:                 ENDIF
746: 
747:                 loc_cSQL = "SELECT 0 AS nMarca, Emps, Grupos, Contas" + ;
748:                            " FROM SigCdCeg WHERE TpCads = 3 ORDER BY Emps"
749: 
750:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstoqueTemp")
751: 
752:                 IF loc_nRet < 0
753:                     MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
754:                     loc_lResultado = .F.
755:                 ELSE
756:                     SELECT * FROM cursor_4c_EstoqueTemp INTO CURSOR cursor_4c_Estoque READWRITE
757:                     IF USED("cursor_4c_EstoqueTemp")
758:                         USE IN cursor_4c_EstoqueTemp
759:                     ENDIF
760:                     loc_oGrid.ColumnCount = 4
761:                     loc_oGrid.RecordSource = "cursor_4c_Estoque"
762: 
763:                     loc_oGrid.Column1.chk_4c_nMarca.ControlSource  = "cursor_4c_Estoque.nMarca"
764:                     loc_oGrid.Column2.txt_4c_Empresa.ControlSource  = "cursor_4c_Estoque.Emps"
765:                     loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.Grupos"
766:                     loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.Contas"
767: 
768:                     loc_oGrid.Column1.Header1.Caption = ""
769:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
770:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
771:                     loc_oGrid.Column4.Header1.Caption = "Conta"
772: 
773:                     loc_lResultado = .T.
774:                 ENDIF
775:             ENDIF
776: 
777:         CATCH TO loc_oErro
778:             MsgErro("Erro em CarregarEstoque:" + CHR(13) + loc_oErro.Message, "Erro")
779:             loc_lResultado = .F.
780:         ENDTRY
781: 
782:         RETURN loc_lResultado
783:     ENDPROC
784: 
785:     *==========================================================================
786:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)

*-- Linhas 978 a 996:
978:                 ELSE
979:                     REPLACE ALL nMarca WITH 0 IN cursor_4c_Estoque
980:                 ENDIF
981:                 loc_oPage.grd_4c_Estoque.Refresh()
982:             ENDIF
983: 
984:         CATCH TO loc_oErro
985:             MsgErro("Erro em CmgMarcaDesmarcaClick:" + CHR(13) + loc_oErro.Message, "Erro")
986:         ENDTRY
987:     ENDPROC
988: 
989:     *==========================================================================
990:     * BtnProcessarClick - Processa selecao de estoques e abre aba Distribuicao
991:     *==========================================================================
992:     PROCEDURE BtnProcessarClick()
993:         LOCAL loc_oErro
994: 
995:         IF !USED("cursor_4c_Estoque") OR RECCOUNT("cursor_4c_Estoque") = 0
996:             MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para processar.", "Processar")

*-- Linhas 1231 a 1288:
1231:         ENDWITH
1232: 
1233:         *-- Grid Disponivel (grdDisponivel: top=141, left=1, width=663, height=327, 7 colunas)
1234:         loc_oPage.AddObject("grd_4c_Disponivel", "Grid")
1235:         loc_oPage.grd_4c_Disponivel.ColumnCount = 7
1236: 
1237:         WITH loc_oPage.grd_4c_Disponivel
1238:             .Top                = 141
1239:             .Left               = 1
1240:             .Width              = 663
1241:             .Height             = 327
1242:             .FontName           = "Verdana"
1243:             .FontSize           = 8
1244:             .ForeColor          = RGB(90, 90, 90)
1245:             .BackColor          = RGB(255, 255, 255)
1246:             .GridLineColor      = RGB(238, 238, 238)
1247:             .HighlightBackColor = RGB(255, 255, 255)
1248:             .HighlightForeColor = RGB(15, 41, 104)
1249:             .HighlightStyle     = 2
1250:             .DeleteMark         = .F.
1251:             .RecordMark         = .F.
1252:             .RowHeight          = 18
1253:             .ScrollBars         = 2
1254:             .GridLines          = 3
1255:             .Visible            = .T.
1256:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1257:             .Column1.Width           = 90
1258:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1259:             .Column2.Width           = 200
1260:             .Column3.Header1.Caption = "Cor"
1261:             .Column3.Width           = 60
1262:             .Column4.Header1.Caption = "Tam"
1263:             .Column4.Width           = 40
1264:             .Column5.Header1.Caption = "Estoque"
1265:             .Column5.Width           = 70
1266:             .Column6.Header1.Caption = "Saldo"
1267:             .Column6.Width           = 70
1268:             .Column7.Header1.Caption = "Distribuido"
1269:             .Column7.Width           = 70
1270:         ENDWITH
1271: 
1272:         *-- Controles read-only nas colunas (When=.F. no legado)
1273:         loc_oGrid = loc_oPage.grd_4c_Disponivel
1274: 
1275:         loc_oGrid.Column1.AddObject("txt_4c_Cod01", "TextBox")
1276:         loc_oGrid.Column1.txt_4c_Cod01.ReadOnly = .T.
1277:         loc_oGrid.Column1.CurrentControl = "txt_4c_Cod01"
1278: 
1279:         loc_oGrid.Column2.AddObject("txt_4c_Dsc02", "TextBox")
1280:         loc_oGrid.Column2.txt_4c_Dsc02.ReadOnly = .T.
1281:         loc_oGrid.Column2.CurrentControl = "txt_4c_Dsc02"
1282: 
1283:         loc_oGrid.Column3.AddObject("txt_4c_Cor03", "TextBox")
1284:         loc_oGrid.Column3.txt_4c_Cor03.ReadOnly = .T.
1285:         loc_oGrid.Column3.CurrentControl = "txt_4c_Cor03"
1286: 
1287:         loc_oGrid.Column4.AddObject("txt_4c_Tam04", "TextBox")
1288:         loc_oGrid.Column4.txt_4c_Tam04.ReadOnly = .T.

*-- Linhas 1301 a 1352:
1301:         loc_oGrid.Column7.CurrentControl = "txt_4c_Dis07"
1302: 
1303:         *-- Grid Distribui (grdDistribui: top=141, left=664, width=334, height=327, 4 colunas)
1304:         loc_oPage.AddObject("grd_4c_Distribui", "Grid")
1305:         loc_oPage.grd_4c_Distribui.ColumnCount = 4
1306: 
1307:         WITH loc_oPage.grd_4c_Distribui
1308:             .Top                = 141
1309:             .Left               = 664
1310:             .Width              = 334
1311:             .Height             = 327
1312:             .FontName           = "Verdana"
1313:             .FontSize           = 8
1314:             .ForeColor          = RGB(90, 90, 90)
1315:             .BackColor          = RGB(255, 255, 255)
1316:             .GridLineColor      = RGB(238, 238, 238)
1317:             .HighlightBackColor = RGB(255, 255, 255)
1318:             .HighlightForeColor = RGB(15, 41, 104)
1319:             .HighlightStyle     = 2
1320:             .DeleteMark         = .F.
1321:             .RecordMark         = .F.
1322:             .RowHeight          = 18
1323:             .ScrollBars         = 2
1324:             .GridLines          = 3
1325:             .Visible            = .T.
1326:             .Column1.Header1.Caption = "Empresa"
1327:             .Column1.Width           = 60
1328:             .Column2.Header1.Caption = "Saldo"
1329:             .Column2.Width           = 70
1330:             .Column3.Header1.Caption = "Distribuido"
1331:             .Column3.Width           = 80
1332:             .Column4.Header1.Caption = "Local"
1333:             .Column4.Width           = 90
1334:         ENDWITH
1335: 
1336:         *-- Col1/Col2 read-only; Col3 editavel (QtdDistr); Col4 editavel com lookup Local
1337:         loc_oGrid = loc_oPage.grd_4c_Distribui
1338: 
1339:         loc_oGrid.Column1.AddObject("txt_4c_Emp01", "TextBox")
1340:         loc_oGrid.Column1.txt_4c_Emp01.ReadOnly = .T.
1341:         loc_oGrid.Column1.CurrentControl = "txt_4c_Emp01"
1342: 
1343:         loc_oGrid.Column2.AddObject("txt_4c_Sal02", "TextBox")
1344:         loc_oGrid.Column2.txt_4c_Sal02.ReadOnly = .T.
1345:         loc_oGrid.Column2.CurrentControl = "txt_4c_Sal02"
1346: 
1347:         loc_oGrid.Column3.AddObject("txt_4c_Dis03", "TextBox")
1348:         loc_oGrid.Column3.CurrentControl = "txt_4c_Dis03"
1349: 
1350:         loc_oGrid.Column4.AddObject("txt_4c_Loc04", "TextBox")
1351:         loc_oGrid.Column4.CurrentControl = "txt_4c_Loc04"
1352: 

*-- Linhas 1615 a 1757:
1615:         ENDWITH
1616: 
1617:         *-- BINDEVENTs
1618:         BINDEVENT(loc_oPage.grd_4c_Disponivel, "AfterRowColChange", ;
1619:             THIS, "GrdDisponivelAfterRowColChange")
1620:         BINDEVENT(loc_oPage.grd_4c_Distribui.Column3.txt_4c_Dis03, ;
1621:             "LostFocus", THIS, "DistribuidoLostFocus")
1622:         BINDEVENT(loc_oPage.grd_4c_Distribui.Column4.txt_4c_Loc04, ;
1623:             "Valid", THIS, "LocalDistribuidoValid")
1624:         BINDEVENT(loc_oPage.txt_4c_CodGrupoDist,   "KeyPress", THIS, "GrupoCodDistValid")
1625:         BINDEVENT(loc_oPage.txt_4c_DscGrupoDist,   "KeyPress", THIS, "GrupoDscDistValid")
1626:         BINDEVENT(loc_oPage.txt_4c_CodSgrupoDist,  "KeyPress", THIS, "SgrupoCodDistValid")
1627:         BINDEVENT(loc_oPage.txt_4c_DscSgrupoDist,  "KeyPress", THIS, "SgrupoDscDistValid")
1628:         BINDEVENT(loc_oPage.cmd_4c_Filtrar,        "Click", THIS, "FiltrarDisponivelClick")
1629:         BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProdutoInicialValid")
1630: 
1631:         THIS.TornarControlesVisiveis(loc_oPage)
1632:     ENDPROC
1633: 
1634:     *==========================================================================
1635:     * CarregarDisponivel - Vincula grd_4c_Disponivel ao cursor_4c_Disponivel
1636:     *==========================================================================
1637:     PROTECTED PROCEDURE CarregarDisponivel()
1638:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1639:         loc_lResultado = .F.
1640: 
1641:         TRY
1642:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1643:                 loc_lResultado = .T.
1644:             ELSE
1645:                 IF USED("cursor_4c_Disponivel")
1646:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1647:                 loc_oGrid = loc_oPage.grd_4c_Disponivel
1648: 
1649:                 loc_oGrid.ColumnCount = 7
1650:                 loc_oGrid.RecordSource = "cursor_4c_Disponivel"
1651: 
1652:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Disponivel.Cpros"
1653:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Disponivel.Dpros"
1654:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Disponivel.CodCors"
1655:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Disponivel.CodTams"
1656:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Disponivel.Sqtds"
1657:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1658:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1659: 
1660:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1661:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1662:                 loc_oGrid.Column3.Header1.Caption = "Cor"
1663:                 loc_oGrid.Column4.Header1.Caption = "Tam"
1664:                 loc_oGrid.Column5.Header1.Caption = "Estoque"
1665:                 loc_oGrid.Column6.Header1.Caption = "Saldo"
1666:                 loc_oGrid.Column7.Header1.Caption = "Distribuido"
1667: 
1668:                 THIS.FormatarGridLista(loc_oGrid)
1669:                 loc_oGrid.Refresh()
1670: 
1671:                 THIS.CarregarDistribui()
1672: 
1673:                 loc_lResultado = .T.
1674:                 ENDIF
1675:             ENDIF
1676: 
1677:         CATCH TO loc_oErro
1678:             MsgErro("Erro em CarregarDisponivel:" + CHR(13) + loc_oErro.Message, "Erro")
1679:             loc_lResultado = .F.
1680:         ENDTRY
1681: 
1682:         RETURN loc_lResultado
1683:     ENDPROC
1684: 
1685:     *==========================================================================
1686:     * CarregarDistribui - Vincula grd_4c_Distribui ao cursor_4c_Distribui
1687:     *==========================================================================
1688:     PROTECTED PROCEDURE CarregarDistribui()
1689:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1690:         loc_lResultado = .F.
1691: 
1692:         TRY
1693:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1694:                 loc_lResultado = .T.
1695:             ELSE
1696:                 IF USED("cursor_4c_Distribui")
1697:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1698:                 loc_oGrid = loc_oPage.grd_4c_Distribui
1699: 
1700:                 loc_oGrid.ColumnCount = 4
1701:                 loc_oGrid.RecordSource = "cursor_4c_Distribui"
1702: 
1703:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Distribui.Cemps"
1704:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1705:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1706:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"
1707: 
1708:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1709:                 loc_oGrid.Column2.Header1.Caption = "Saldo"
1710:                 loc_oGrid.Column3.Header1.Caption = "Distribuido"
1711:                 loc_oGrid.Column4.Header1.Caption = "Local"
1712: 
1713:                 THIS.FormatarGridLista(loc_oGrid)
1714:                 loc_oGrid.Refresh()
1715: 
1716:                 loc_lResultado = .T.
1717:                 ENDIF
1718:             ENDIF
1719: 
1720:         CATCH TO loc_oErro
1721:             MsgErro("Erro em CarregarDistribui:" + CHR(13) + loc_oErro.Message, "Erro")
1722:             loc_lResultado = .F.
1723:         ENDTRY
1724: 
1725:         RETURN loc_lResultado
1726:     ENDPROC
1727: 
1728:     *==========================================================================
1729:     * GrdDisponivelAfterRowColChange - Filtra grd_4c_Distribui pelo produto atual
1730:     *==========================================================================
1731:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1732:         LOCAL loc_cCodPro, loc_oPage, loc_oErro
1733: 
1734:         TRY
1735:             IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel") ;
1736:                AND USED("cursor_4c_Distribui")
1737:                 SELECT cursor_4c_Disponivel
1738:                 loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1739:                 SELECT cursor_4c_Distribui
1740:                 SET FILTER TO ALLTRIM(Cpros) = loc_cCodPro
1741:                 GO TOP IN cursor_4c_Distribui
1742:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Distribui.Refresh()
1743:                 THIS.PopularInfoProduto(loc_cCodPro)
1744:             ENDIF
1745: 
1746:         CATCH TO loc_oErro
1747:             MsgErro("Erro em GrdDisponivelAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1748:         ENDTRY
1749:     ENDPROC
1750: 
1751:     *==========================================================================
1752:     * DistribuidoLostFocus - Recalcula saldo ao sair do campo Distribuido
1753:     *==========================================================================
1754:     PROCEDURE DistribuidoLostFocus()
1755:         THIS.CalcularSaldo()
1756:     ENDPROC
1757: 

*-- Linhas 1797 a 1849:
1797:                     ENDIF
1798: 
1799:                     loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1800:                     loc_oPage.grd_4c_Disponivel.Refresh()
1801:                     loc_oPage.grd_4c_Distribui.Refresh()
1802:                 ENDIF
1803:             ENDIF
1804: 
1805:         CATCH TO loc_oErro
1806:             MsgErro("Erro em CalcularSaldo:" + CHR(13) + loc_oErro.Message, "Erro")
1807:         ENDTRY
1808:     ENDPROC
1809: 
1810:     *==========================================================================
1811:     * LocalDistribuidoValid - Lookup localizacao SigPrLcl (Column4 grdDistribui)
1812:     *==========================================================================
1813:     PROCEDURE LocalDistribuidoValid()
1814:         LOCAL loc_oBusca, loc_cValor, loc_oPage, loc_oErro
1815: 
1816:         TRY
1817:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1818:             loc_cValor = ALLTRIM(loc_oPage.grd_4c_Distribui.Column4.txt_4c_Loc04.Value)
1819: 
1820:             IF !EMPTY(loc_cValor)
1821:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1822:                     "SigPrLcl", "cursor_4c_BuscaLocal", "Codigos", loc_cValor, ;
1823:                     "Localiza" + CHR(231) + CHR(227) + "o")
1824: 
1825:                 IF VARTYPE(loc_oBusca) = "O"
1826:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1827:                         IF USED("cursor_4c_BuscaLocal")
1828:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1829:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1830:                         ENDIF
1831:                     ELSE
1832:                         IF !loc_oBusca.this_lAchouRegistro
1833:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1834:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1835:                         loc_oBusca.Show()
1836:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
1837:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1838:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1839:                         ENDIF
1840:                     ELSE
1841:                         REPLACE cursor_4c_Distribui.CidChaves WITH ""
1842:                         ENDIF
1843:                     ENDIF
1844:                     loc_oBusca.Release()
1845:                 ENDIF
1846: 
1847:                 IF USED("cursor_4c_BuscaLocal")
1848:                     USE IN cursor_4c_BuscaLocal
1849:                 ENDIF

*-- Linhas 1879 a 1898:
1879:                         ENDIF
1880:                     ELSE
1881:                         IF !loc_oBusca.this_lAchouRegistro
1882:                         loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1883:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1884:                         loc_oBusca.Show()
1885:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1886:                             loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1887:                             loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1888:                         ENDIF
1889:                     ELSE
1890:                         loc_oPage.txt_4c_CodGrupoDist.Value = ""
1891:                         loc_oPage.txt_4c_DscGrupoDist.Value = ""
1892:                         ENDIF
1893:                     ENDIF
1894:                     loc_oBusca.Release()
1895:                 ENDIF
1896: 
1897:                 IF USED("cursor_4c_BuscaGrp")
1898:                     USE IN cursor_4c_BuscaGrp

*-- Linhas 1929 a 1948:
1929:                         ENDIF
1930:                     ELSE
1931:                         IF !loc_oBusca.this_lAchouRegistro
1932:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1933:                         loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1934:                         loc_oBusca.Show()
1935:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1936:                             loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1937:                             loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1938:                         ENDIF
1939:                     ELSE
1940:                         loc_oPage.txt_4c_CodGrupoDist.Value = ""
1941:                         loc_oPage.txt_4c_DscGrupoDist.Value = ""
1942:                         ENDIF
1943:                     ENDIF
1944:                     loc_oBusca.Release()
1945:                 ENDIF
1946: 
1947:                 IF USED("cursor_4c_BuscaGrp")
1948:                     USE IN cursor_4c_BuscaGrp

*-- Linhas 1979 a 1998:
1979:                         ENDIF
1980:                     ELSE
1981:                         IF !loc_oBusca.this_lAchouRegistro
1982:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1983:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1984:                         loc_oBusca.Show()
1985:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrp")
1986:                             loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
1987:                             loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
1988:                         ENDIF
1989:                     ELSE
1990:                         loc_oPage.txt_4c_CodSgrupoDist.Value = ""
1991:                         loc_oPage.txt_4c_DscSgrupoDist.Value = ""
1992:                         ENDIF
1993:                     ENDIF
1994:                     loc_oBusca.Release()
1995:                 ENDIF
1996: 
1997:                 IF USED("cursor_4c_BuscaSgrp")
1998:                     USE IN cursor_4c_BuscaSgrp

*-- Linhas 2029 a 2048:
2029:                         ENDIF
2030:                     ELSE
2031:                         IF !loc_oBusca.this_lAchouRegistro
2032:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2033:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
2034:                         loc_oBusca.Show()
2035:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrp")
2036:                             loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
2037:                             loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
2038:                         ENDIF
2039:                     ELSE
2040:                         loc_oPage.txt_4c_CodSgrupoDist.Value = ""
2041:                         loc_oPage.txt_4c_DscSgrupoDist.Value = ""
2042:                         ENDIF
2043:                     ENDIF
2044:                     loc_oBusca.Release()
2045:                 ENDIF
2046: 
2047:                 IF USED("cursor_4c_BuscaSgrp")
2048:                     USE IN cursor_4c_BuscaSgrp

*-- Linhas 2055 a 2073:
2055:     ENDPROC
2056: 
2057:     *==========================================================================
2058:     * FiltrarDisponivelClick - Filtra grd_4c_Disponivel por grupo e/ou subgrupo
2059:     *==========================================================================
2060:     PROCEDURE FiltrarDisponivelClick()
2061:         LOCAL loc_cCodGrp, loc_cCodSgrp, loc_oPage, loc_oErro
2062: 
2063:         TRY
2064:             IF USED("cursor_4c_Disponivel")
2065:                 loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2066:                 loc_cCodGrp  = ALLTRIM(loc_oPage.txt_4c_CodGrupoDist.Value)
2067:                 loc_cCodSgrp = ALLTRIM(loc_oPage.txt_4c_CodSgrupoDist.Value)
2068: 
2069:                 SELECT cursor_4c_Disponivel
2070: 
2071:                 IF EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2072:                     SET FILTER TO
2073:                 ELSE

*-- Linhas 2084 a 2125:
2084:                 ENDIF
2085: 
2086:                 GO TOP IN cursor_4c_Disponivel
2087:                 loc_oPage.grd_4c_Disponivel.Refresh()
2088:             ENDIF
2089: 
2090:         CATCH TO loc_oErro
2091:             MsgErro("Erro em FiltrarDisponivelClick:" + CHR(13) + loc_oErro.Message, "Erro")
2092:         ENDTRY
2093:     ENDPROC
2094: 
2095:     *==========================================================================
2096:     * ProdutoInicialValid - Navega grd_4c_Disponivel para o produto informado
2097:     *==========================================================================
2098:     PROCEDURE ProdutoInicialValid()
2099:         LOCAL loc_cProd, loc_oPage, loc_oErro
2100: 
2101:         TRY
2102:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2103:             loc_cProd = ALLTRIM(loc_oPage.txt_4c_ProdutoInicial.Value)
2104: 
2105:             IF !EMPTY(loc_cProd) AND USED("cursor_4c_Disponivel")
2106:                 SELECT cursor_4c_Disponivel
2107:                 GO TOP
2108:                 LOCATE FOR ALLTRIM(Cpros) >= loc_cProd
2109:                 IF !EOF("cursor_4c_Disponivel")
2110:                     loc_oPage.grd_4c_Disponivel.Refresh()
2111:                 ENDIF
2112:             ENDIF
2113: 
2114:         CATCH TO loc_oErro
2115:             MsgErro("Erro em ProdutoInicialValid:" + CHR(13) + loc_oErro.Message, "Erro")
2116:         ENDTRY
2117:     ENDPROC
2118: 
2119:     *==========================================================================
2120:     * PopularInfoProduto - Preenche o painel info com dados do produto selecionado
2121:     *==========================================================================
2122:     PROCEDURE PopularInfoProduto(par_cCodPro)
2123:         LOCAL loc_oPage, loc_cSQL, loc_nRet, loc_oErro
2124: 
2125:         TRY

*-- Linhas 2306 a 2366:
2306:         ENDWITH
2307:         loc_oPgfOp = loc_oPage.pgf_4c_Operacoes
2308: 
2309:         *-- grd_4c_CabOperas na Page1 (grdCabOperas: 8 cols, top=6, left=9, width=975, height=339)
2310:         loc_oPgfOp.Page1.AddObject("grd_4c_CabOperas", "Grid")
2311:         loc_oPgfOp.Page1.grd_4c_CabOperas.ColumnCount = 8
2312: 
2313:         WITH loc_oPgfOp.Page1.grd_4c_CabOperas
2314:             .Top                = 6
2315:             .Left               = 9
2316:             .Width              = 975
2317:             .Height             = 339
2318:             .FontName           = "Verdana"
2319:             .FontSize           = 8
2320:             .ForeColor          = RGB(90, 90, 90)
2321:             .BackColor          = RGB(255, 255, 255)
2322:             .GridLineColor      = RGB(238, 238, 238)
2323:             .HighlightBackColor = RGB(255, 255, 255)
2324:             .HighlightForeColor = RGB(15, 41, 104)
2325:             .HighlightStyle     = 2
2326:             .DeleteMark         = .F.
2327:             .RecordMark         = .F.
2328:             .RowHeight          = 18
2329:             .ScrollBars         = 3
2330:             .GridLines          = 3
2331:             .ReadOnly           = .T.
2332:             .Visible            = .T.
2333:             .Column1.Header1.Caption = "Emp O"
2334:             .Column1.Width           = 55
2335:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2336:             .Column2.Width           = 110
2337:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
2338:             .Column3.Width           = 130
2339:             .Column4.Header1.Caption = "Emp D"
2340:             .Column4.Width           = 55
2341:             .Column5.Header1.Caption = "Grupo Orig"
2342:             .Column5.Width           = 105
2343:             .Column6.Header1.Caption = "Conta Orig"
2344:             .Column6.Width           = 105
2345:             .Column7.Header1.Caption = "Grupo Dest"
2346:             .Column7.Width           = 105
2347:             .Column8.Header1.Caption = "Conta Dest"
2348:             .Column8.Width           = 105
2349:         ENDWITH
2350: 
2351:         loc_oGrid = loc_oPgfOp.Page1.grd_4c_CabOperas
2352:         loc_oGrid.Column1.AddObject("txt_4c_Col01", "TextBox")
2353:         loc_oGrid.Column1.txt_4c_Col01.ReadOnly = .T.
2354:         loc_oGrid.Column1.CurrentControl = "txt_4c_Col01"
2355:         loc_oGrid.Column2.AddObject("txt_4c_Col02", "TextBox")
2356:         loc_oGrid.Column2.txt_4c_Col02.ReadOnly = .T.
2357:         loc_oGrid.Column2.CurrentControl = "txt_4c_Col02"
2358:         loc_oGrid.Column3.AddObject("txt_4c_Col03", "TextBox")
2359:         loc_oGrid.Column3.txt_4c_Col03.ReadOnly = .T.
2360:         loc_oGrid.Column3.CurrentControl = "txt_4c_Col03"
2361:         loc_oGrid.Column4.AddObject("txt_4c_Col04", "TextBox")
2362:         loc_oGrid.Column4.txt_4c_Col04.ReadOnly = .T.
2363:         loc_oGrid.Column4.CurrentControl = "txt_4c_Col04"
2364:         loc_oGrid.Column5.AddObject("txt_4c_Col05", "TextBox")
2365:         loc_oGrid.Column5.txt_4c_Col05.ReadOnly = .T.
2366:         loc_oGrid.Column5.CurrentControl = "txt_4c_Col05"

*-- Linhas 2374 a 2436:
2374:         loc_oGrid.Column8.txt_4c_Col08.ReadOnly = .T.
2375:         loc_oGrid.Column8.CurrentControl = "txt_4c_Col08"
2376: 
2377:         *-- grd_4c_ItnOperas na Page2 (grdItnOperas: 9 cols, top=5, left=9, width=975, height=340)
2378:         loc_oPgfOp.Page2.AddObject("grd_4c_ItnOperas", "Grid")
2379:         loc_oPgfOp.Page2.grd_4c_ItnOperas.ColumnCount = 9
2380: 
2381:         WITH loc_oPgfOp.Page2.grd_4c_ItnOperas
2382:             .Top                = 5
2383:             .Left               = 9
2384:             .Width              = 975
2385:             .Height             = 340
2386:             .FontName           = "Verdana"
2387:             .FontSize           = 8
2388:             .ForeColor          = RGB(90, 90, 90)
2389:             .BackColor          = RGB(255, 255, 255)
2390:             .GridLineColor      = RGB(238, 238, 238)
2391:             .HighlightBackColor = RGB(255, 255, 255)
2392:             .HighlightForeColor = RGB(15, 41, 104)
2393:             .HighlightStyle     = 2
2394:             .DeleteMark         = .F.
2395:             .RecordMark         = .F.
2396:             .RowHeight          = 18
2397:             .ScrollBars         = 3
2398:             .GridLines          = 3
2399:             .ReadOnly           = .T.
2400:             .Visible            = .T.
2401:             .Column1.Header1.Caption = "Item"
2402:             .Column1.Width           = 50
2403:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
2404:             .Column2.Width           = 100
2405:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2406:             .Column3.Width           = 200
2407:             .Column4.Header1.Caption = "Uni"
2408:             .Column4.Width           = 40
2409:             .Column5.Header1.Caption = "Quantidade"
2410:             .Column5.Width           = 90
2411:             .Column6.Header1.Caption = "Unit" + CHR(225) + "rio"
2412:             .Column6.Width           = 90
2413:             .Column7.Header1.Caption = "Total"
2414:             .Column7.Width           = 90
2415:             .Column8.Header1.Caption = "Cor"
2416:             .Column8.Width           = 60
2417:             .Column9.Header1.Caption = "Tam"
2418:             .Column9.Width           = 60
2419:         ENDWITH
2420: 
2421:         loc_oGrid = loc_oPgfOp.Page2.grd_4c_ItnOperas
2422:         loc_oGrid.Column1.AddObject("txt_4c_Itn01", "TextBox")
2423:         loc_oGrid.Column1.txt_4c_Itn01.ReadOnly = .T.
2424:         loc_oGrid.Column1.CurrentControl = "txt_4c_Itn01"
2425:         loc_oGrid.Column2.AddObject("txt_4c_Itn02", "TextBox")
2426:         loc_oGrid.Column2.txt_4c_Itn02.ReadOnly = .T.
2427:         loc_oGrid.Column2.CurrentControl = "txt_4c_Itn02"
2428:         loc_oGrid.Column3.AddObject("txt_4c_Itn03", "TextBox")
2429:         loc_oGrid.Column3.txt_4c_Itn03.ReadOnly = .T.
2430:         loc_oGrid.Column3.CurrentControl = "txt_4c_Itn03"
2431:         loc_oGrid.Column4.AddObject("txt_4c_Itn04", "TextBox")
2432:         loc_oGrid.Column4.txt_4c_Itn04.ReadOnly = .T.
2433:         loc_oGrid.Column4.CurrentControl = "txt_4c_Itn04"
2434:         loc_oGrid.Column5.AddObject("txt_4c_Itn05", "TextBox")
2435:         loc_oGrid.Column5.txt_4c_Itn05.ReadOnly = .T.
2436:         loc_oGrid.Column5.CurrentControl = "txt_4c_Itn05"

*-- Linhas 2453 a 2481:
2453:     ENDPROC
2454: 
2455:     *==========================================================================
2456:     * PgItensActivate - Atualiza grd_4c_ItnOperas ao ativar aba Itens
2457:     *==========================================================================
2458:     PROCEDURE PgItensActivate()
2459:         LOCAL loc_oPage, loc_oErro
2460: 
2461:         TRY
2462:             IF USED("cursor_4c_ItnOperas")
2463:                 GO TOP IN cursor_4c_ItnOperas
2464:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2465:                 IF VARTYPE(loc_oPage) = "O" AND VARTYPE(loc_oPage.grd_4c_ItnOperas) = "O"
2466:                     loc_oPage.grd_4c_ItnOperas.Refresh()
2467:                 ENDIF
2468:             ENDIF
2469: 
2470:         CATCH TO loc_oErro
2471:             MsgErro("Erro em PgItensActivate:" + CHR(13) + loc_oErro.Message, "Erro")
2472:         ENDTRY
2473:     ENDPROC
2474: 
2475:     *==========================================================================
2476:     * BtnProcessarFinalClick - Valida, salva lote em sigprdis e exibe operacoes
2477:     *==========================================================================
2478:     PROCEDURE BtnProcessarFinalClick()
2479:         LOCAL loc_oErro
2480: 
2481:         TRY

*-- Linhas 2496 a 2522:
2496:     ENDPROC
2497: 
2498:     *==========================================================================
2499:     * CarregarCabOperas - Carrega grd_4c_CabOperas com movimentos do lote
2500:     *==========================================================================
2501:     PROTECTED PROCEDURE CarregarCabOperas()
2502:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2503:         loc_oErro = .NULL.
2504: 
2505:         TRY
2506:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page1
2507:             loc_oGrid   = loc_oPage.grd_4c_CabOperas
2508:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2509: 
2510:             IF USED("cursor_4c_CabOperas")
2511:                 USE IN cursor_4c_CabOperas
2512:             ENDIF
2513:             IF USED("cursor_4c_CabOperasTemp")
2514:                 USE IN cursor_4c_CabOperasTemp
2515:             ENDIF
2516: 
2517:             loc_cSQL = "SELECT DISTINCT RTRIM(c.emps) AS emps, " + ;
2518:                        "RTRIM(c.dopes) AS dopes, " + ;
2519:                        "c.numes AS numes, " + ;
2520:                        "RTRIM(c.empds) AS empds, " + ;
2521:                        "RTRIM(c.grupoos) AS grupoos, RTRIM(c.contaos) AS contaos, " + ;
2522:                        "RTRIM(c.grupods) AS grupods, RTRIM(c.contads) AS contads " + ;

*-- Linhas 2529 a 2618:
2529:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)))" + ;
2530:                        " ORDER BY c.emps, c.dopes"
2531: 
2532:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOperasTemp")
2533: 
2534:             IF loc_nRet < 0
2535:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
2536:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2537:             ELSE
2538:                 SELECT * FROM cursor_4c_CabOperasTemp INTO CURSOR cursor_4c_CabOperas READWRITE
2539:                 IF USED("cursor_4c_CabOperasTemp")
2540:                     USE IN cursor_4c_CabOperasTemp
2541:                 ENDIF
2542:                 loc_oGrid.ColumnCount = 8
2543:                 loc_oGrid.RecordSource = "cursor_4c_CabOperas"
2544:                 loc_oGrid.Column1.txt_4c_Col01.ControlSource = "cursor_4c_CabOperas.emps"
2545:                 loc_oGrid.Column2.txt_4c_Col02.ControlSource = "cursor_4c_CabOperas.dopes"
2546:                 loc_oGrid.Column3.txt_4c_Col03.ControlSource = "cursor_4c_CabOperas.numes"
2547:                 loc_oGrid.Column4.txt_4c_Col04.ControlSource = "cursor_4c_CabOperas.empds"
2548:                 loc_oGrid.Column5.txt_4c_Col05.ControlSource = "cursor_4c_CabOperas.grupoos"
2549:                 loc_oGrid.Column6.txt_4c_Col06.ControlSource = "cursor_4c_CabOperas.contaos"
2550:                 loc_oGrid.Column7.txt_4c_Col07.ControlSource = "cursor_4c_CabOperas.grupods"
2551:                 loc_oGrid.Column8.txt_4c_Col08.ControlSource = "cursor_4c_CabOperas.contads"
2552:                 loc_oGrid.Refresh()
2553:             ENDIF
2554: 
2555:         CATCH TO loc_oErro
2556:             MsgErro("Erro em CarregarCabOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2557:         ENDTRY
2558:     ENDPROC
2559: 
2560:     *==========================================================================
2561:     * CarregarItnOperas - Carrega grd_4c_ItnOperas com itens de movimentos do lote
2562:     *==========================================================================
2563:     PROTECTED PROCEDURE CarregarItnOperas()
2564:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2565:         loc_oErro = .NULL.
2566: 
2567:         TRY
2568:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2569:             loc_oGrid   = loc_oPage.grd_4c_ItnOperas
2570:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2571: 
2572:             IF USED("cursor_4c_ItnOperas")
2573:                 USE IN cursor_4c_ItnOperas
2574:             ENDIF
2575:             IF USED("cursor_4c_ItnOperasTemp")
2576:                 USE IN cursor_4c_ItnOperasTemp
2577:             ENDIF
2578: 
2579:             loc_cSQL = "SELECT RTRIM(b.cItens) AS Citens, RTRIM(b.CPros) AS CPros, " + ;
2580:                        "RTRIM(ISNULL(b.DPros,'')) AS Dpros, " + ;
2581:                        "RTRIM(b.Cunis) AS CUnis, b.Qtds, b.Units, b.totas, " + ;
2582:                        "RTRIM(c.CodCors) AS CodCors, RTRIM(c.CodTams) AS CodTams " + ;
2583:                        "FROM (SELECT DISTINCT d.EmpDopNums FROM sigprdis d" + ;
2584:                        " WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2585:                        " AND RTRIM(d.EmpDopNums) <> '') x " + ;
2586:                        "INNER JOIN SigMvItn b ON x.EmpDopNums = b.EmpDopNums " + ;
2587:                        "INNER JOIN SigMvIts c ON b.EmpDopNums = c.EmpDopNums" + ;
2588:                        " AND b.cItens = c.Citens " + ;
2589:                        "ORDER BY b.cItens"
2590: 
2591:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOperasTemp")
2592: 
2593:             IF loc_nRet < 0
2594:                 MsgErro("Erro ao carregar itens de opera" + CHR(231) + CHR(245) + "es:" + ;
2595:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2596:             ELSE
2597:                 SELECT * FROM cursor_4c_ItnOperasTemp INTO CURSOR cursor_4c_ItnOperas READWRITE
2598:                 IF USED("cursor_4c_ItnOperasTemp")
2599:                     USE IN cursor_4c_ItnOperasTemp
2600:                 ENDIF
2601:                 loc_oGrid.ColumnCount = 9
2602:                 loc_oGrid.RecordSource = "cursor_4c_ItnOperas"
2603:                 loc_oGrid.Column1.txt_4c_Itn01.ControlSource = "cursor_4c_ItnOperas.Citens"
2604:                 loc_oGrid.Column2.txt_4c_Itn02.ControlSource = "cursor_4c_ItnOperas.CPros"
2605:                 loc_oGrid.Column3.txt_4c_Itn03.ControlSource = "cursor_4c_ItnOperas.Dpros"
2606:                 loc_oGrid.Column4.txt_4c_Itn04.ControlSource = "cursor_4c_ItnOperas.CUnis"
2607:                 loc_oGrid.Column5.txt_4c_Itn05.ControlSource = "cursor_4c_ItnOperas.Qtds"
2608:                 loc_oGrid.Column6.txt_4c_Itn06.ControlSource = "cursor_4c_ItnOperas.Units"
2609:                 loc_oGrid.Column7.txt_4c_Itn07.ControlSource = "cursor_4c_ItnOperas.totas"
2610:                 loc_oGrid.Column8.txt_4c_Itn08.ControlSource = "cursor_4c_ItnOperas.CodCors"
2611:                 loc_oGrid.Column9.txt_4c_Itn09.ControlSource = "cursor_4c_ItnOperas.CodTams"
2612:                 loc_oGrid.Refresh()
2613:             ENDIF
2614: 
2615:         CATCH TO loc_oErro
2616:             MsgErro("Erro em CarregarItnOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2617:         ENDTRY
2618:     ENDPROC

*-- Linhas 2727 a 2745:
2727:                 IF VARTYPE(loc_oPage2Dados.cmd_4c_Filtrar)        = "O"
2728:                     loc_oPage2Dados.cmd_4c_Filtrar.Enabled         = par_lHabilitar
2729:                 ENDIF
2730:                 loc_oGrid = loc_oPage2Dados.grd_4c_Distribui
2731:                 IF VARTYPE(loc_oGrid) = "O"
2732:                     loc_oGrid.Column3.txt_4c_Dis03.ReadOnly = !par_lHabilitar
2733:                     loc_oGrid.Column4.txt_4c_Loc04.ReadOnly = !par_lHabilitar
2734:                 ENDIF
2735:             ENDIF
2736:             *-- Aba1 Estoques: processar e marca/desmarca
2737:             loc_oPage1Aba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2738:             IF VARTYPE(loc_oPage1Aba) = "O"
2739:                 IF VARTYPE(loc_oPage1Aba.cmd_4c_Processar)      = "O"
2740:                     loc_oPage1Aba.cmd_4c_Processar.Enabled      = par_lHabilitar
2741:                 ENDIF
2742:                 IF VARTYPE(loc_oPage1Aba.cmg_4c_MarcaDesmarca)  = "O"
2743:                     loc_oPage1Aba.cmg_4c_MarcaDesmarca.Enabled  = par_lHabilitar
2744:                 ENDIF
2745:             ENDIF

