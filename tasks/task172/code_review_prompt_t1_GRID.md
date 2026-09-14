# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (3)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 738: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2511: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2567: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS GRID (2807 linhas total):

*-- Linhas 377 a 419:
377:         ENDWITH
378: 
379:         *-- Grid principal (Grade no legado - SigPrDis via cursor_4c_Lista)
380:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
381:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
382: 
383:         WITH loc_oPagina.grd_4c_Lista
384:             .Top                = 165
385:             .Left               = 24
386:             .Width              = 900
387:             .Height             = 420
388:             .FontName           = "Verdana"
389:             .FontSize           = 8
390:             .ForeColor          = RGB(90, 90, 90)
391:             .BackColor          = RGB(255, 255, 255)
392:             .GridLineColor      = RGB(238, 238, 238)
393:             .HighlightBackColor = RGB(255, 255, 255)
394:             .HighlightForeColor = RGB(15, 41, 104)
395:             .HighlightStyle     = 2
396:             .DeleteMark         = .F.
397:             .RecordMark         = .F.
398:             .RowHeight          = 16
399:             .ScrollBars         = 2
400:             .GridLines          = 3
401:             .Visible            = .T.
402:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
403:             .Column1.Width           = 150
404:             .Column2.Header1.Caption = "Data"
405:             .Column2.Width           = 150
406:         ENDWITH
407: 
408:         *-- BINDEVENTs
409:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
410:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
411:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
412:         BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
413:         BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
414:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
415:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "LostFocus",     THIS, "DtInicialValid")
416:         BINDEVENT(loc_oPagina.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
417: 
418:         THIS.TornarControlesVisiveis(loc_oPagina)
419:     ENDPROC

*-- Linhas 569 a 620:
569:         ENDWITH
570: 
571:         *-- Grid de Estoques (grdEstoque no legado: top=207, left=335, width=271, height=244)
572:         loc_oPage.AddObject("grd_4c_Estoque", "Grid")
573:         loc_oPage.grd_4c_Estoque.ColumnCount = 4
574: 
575:         WITH loc_oPage.grd_4c_Estoque
576:             .Top                = 207
577:             .Left               = 335
578:             .Width              = 271
579:             .Height             = 244
580:             .FontName           = "Verdana"
581:             .FontSize           = 8
582:             .ForeColor          = RGB(90, 90, 90)
583:             .BackColor          = RGB(255, 255, 255)
584:             .GridLineColor      = RGB(238, 238, 238)
585:             .HighlightBackColor = RGB(255, 255, 255)
586:             .HighlightForeColor = RGB(15, 41, 104)
587:             .HighlightStyle     = 2
588:             .DeleteMark         = .F.
589:             .RecordMark         = .F.
590:             .RowHeight          = 18
591:             .ScrollBars         = 2
592:             .GridLines          = 3
593:             .Visible            = .T.
594:             .Column1.Header1.Caption = ""
595:             .Column1.Width           = 25
596:             .Column2.Header1.Caption = "Empresa"
597:             .Column2.Width           = 80
598:             .Column3.Header1.Caption = "Grupo"
599:             .Column3.Width           = 80
600:             .Column4.Header1.Caption = "Conta"
601:             .Column4.Width           = 80
602:         ENDWITH
603: 
604:         *-- CheckBox em Column1 para toggle nMarca (Check1 no legado)
605:         loc_oGrid = loc_oPage.grd_4c_Estoque
606:         loc_oGrid.Column1.AddObject("chk_4c_nMarca", "CheckBox")
607:         WITH loc_oGrid.Column1.chk_4c_nMarca
608:             .Caption = ""
609:             .Width   = 22
610:             .Height  = 17
611:             .Left    = 2
612:             .Top     = 1
613:             .Value   = 0
614:             .Visible = .T.
615:         ENDWITH
616:         loc_oGrid.Column1.CurrentControl = "chk_4c_nMarca"
617: 
618:         *-- TextBox read-only nas colunas de dados (When=.F. no legado)
619:         loc_oGrid.Column2.AddObject("txt_4c_Empresa", "TextBox")
620:         loc_oGrid.Column2.txt_4c_Empresa.ReadOnly = .T.

*-- Linhas 671 a 763:
671:                 loc_lResultado = .T.
672:             ELSE
673:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
674:                 loc_oGrid   = loc_oPagina.grd_4c_Lista
675:                 loc_dDatai  = loc_oPagina.txt_4c_DtInicial.Value
676:                 loc_dDataf  = loc_oPagina.txt_4c_DtFinal.Value
677: 
678:                 loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
679:                            " WHERE CAST(Datas AS DATE) BETWEEN" + ;
680:                            " CAST(" + FormatarDataSQL(loc_dDatai) + " AS DATE)" + ;
681:                            " AND CAST(" + FormatarDataSQL(loc_dDataf) + " AS DATE)"
682: 
683:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
684: 
685:                 IF loc_nRet < 0
686:                     MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
687:                     loc_lResultado = .F.
688:                 ELSE
689:                     loc_oGrid.ColumnCount = 2
690:                     loc_oGrid.RecordSource            = "cursor_4c_Lista"
691:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.Codigos"
692:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.Datas"
693:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
694:                     loc_oGrid.Column2.Header1.Caption = "Data"
695:                     loc_oGrid.Column1.Width           = 150
696:                     loc_oGrid.Column2.Width           = 150
697:                     THIS.FormatarGridLista(loc_oGrid)
698:                     loc_lResultado = .T.
699:                 ENDIF
700:             ENDIF
701: 
702:         CATCH TO loc_oErro
703:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
704:             loc_lResultado = .F.
705:         ENDTRY
706: 
707:         RETURN loc_lResultado
708:     ENDPROC
709: 
710:     *==========================================================================
711:     * CarregarEstoque - Carrega grd_4c_Estoque com SigCdCeg (estoques TpCads=3)
712:     *==========================================================================
713:     PROTECTED PROCEDURE CarregarEstoque()
714:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_cSQL, loc_nRet, loc_oErro
715:         loc_lResultado = .F.
716: 
717:         TRY
718:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
719:                 loc_lResultado = .T.
720:             ELSE
721:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
722:                 loc_oGrid = loc_oPage.grd_4c_Estoque
723: 
724:                 IF USED("cursor_4c_Estoque")
725:                     USE IN cursor_4c_Estoque
726:                 ENDIF
727: 
728:                 loc_cSQL = "SELECT 0 AS nMarca, Emps, Grupos, Contas" + ;
729:                            " FROM SigCdCeg WHERE TpCads = 3 ORDER BY Emps"
730: 
731:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")
732: 
733:                 IF loc_nRet < 0
734:                     MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
735:                     loc_lResultado = .F.
736:                 ELSE
737:                     loc_oGrid.ColumnCount = 3
738:                     loc_oGrid.RecordSource = "cursor_4c_Estoque"
739: 
740:                     loc_oGrid.Column1.chk_4c_nMarca.ControlSource  = "cursor_4c_Estoque.nMarca"
741:                     loc_oGrid.Column2.txt_4c_Empresa.ControlSource  = "cursor_4c_Estoque.Emps"
742:                     loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.Grupos"
743:                     loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.Contas"
744: 
745:                     loc_oGrid.Column1.Header1.Caption = ""
746:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
747:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
748:                     loc_oGrid.Column4.Header1.Caption = "Conta"
749: 
750:                     loc_lResultado = .T.
751:                 ENDIF
752:             ENDIF
753: 
754:         CATCH TO loc_oErro
755:             MsgErro("Erro em CarregarEstoque:" + CHR(13) + loc_oErro.Message, "Erro")
756:             loc_lResultado = .F.
757:         ENDTRY
758: 
759:         RETURN loc_lResultado
760:     ENDPROC
761: 
762:     *==========================================================================
763:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)

*-- Linhas 955 a 973:
955:                 ELSE
956:                     REPLACE ALL nMarca WITH 0 IN cursor_4c_Estoque
957:                 ENDIF
958:                 loc_oPage.grd_4c_Estoque.Refresh()
959:             ENDIF
960: 
961:         CATCH TO loc_oErro
962:             MsgErro("Erro em CmgMarcaDesmarcaClick:" + CHR(13) + loc_oErro.Message, "Erro")
963:         ENDTRY
964:     ENDPROC
965: 
966:     *==========================================================================
967:     * BtnProcessarClick - Processa selecao de estoques e abre aba Distribuicao
968:     *==========================================================================
969:     PROCEDURE BtnProcessarClick()
970:         LOCAL loc_oErro
971: 
972:         IF !USED("cursor_4c_Estoque") OR RECCOUNT("cursor_4c_Estoque") = 0
973:             MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para processar.", "Processar")

*-- Linhas 1208 a 1265:
1208:         ENDWITH
1209: 
1210:         *-- Grid Disponivel (grdDisponivel: top=141, left=1, width=663, height=327, 7 colunas)
1211:         loc_oPage.AddObject("grd_4c_Disponivel", "Grid")
1212:         loc_oPage.grd_4c_Disponivel.ColumnCount = 7
1213: 
1214:         WITH loc_oPage.grd_4c_Disponivel
1215:             .Top                = 141
1216:             .Left               = 1
1217:             .Width              = 663
1218:             .Height             = 327
1219:             .FontName           = "Verdana"
1220:             .FontSize           = 8
1221:             .ForeColor          = RGB(90, 90, 90)
1222:             .BackColor          = RGB(255, 255, 255)
1223:             .GridLineColor      = RGB(238, 238, 238)
1224:             .HighlightBackColor = RGB(255, 255, 255)
1225:             .HighlightForeColor = RGB(15, 41, 104)
1226:             .HighlightStyle     = 2
1227:             .DeleteMark         = .F.
1228:             .RecordMark         = .F.
1229:             .RowHeight          = 18
1230:             .ScrollBars         = 2
1231:             .GridLines          = 3
1232:             .Visible            = .T.
1233:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1234:             .Column1.Width           = 90
1235:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1236:             .Column2.Width           = 200
1237:             .Column3.Header1.Caption = "Cor"
1238:             .Column3.Width           = 60
1239:             .Column4.Header1.Caption = "Tam"
1240:             .Column4.Width           = 40
1241:             .Column5.Header1.Caption = "Estoque"
1242:             .Column5.Width           = 70
1243:             .Column6.Header1.Caption = "Saldo"
1244:             .Column6.Width           = 70
1245:             .Column7.Header1.Caption = "Distribu" + CHR(237) + "do"
1246:             .Column7.Width           = 70
1247:         ENDWITH
1248: 
1249:         *-- Controles read-only nas colunas (When=.F. no legado)
1250:         loc_oGrid = loc_oPage.grd_4c_Disponivel
1251: 
1252:         loc_oGrid.Column1.AddObject("txt_4c_Cod01", "TextBox")
1253:         loc_oGrid.Column1.txt_4c_Cod01.ReadOnly = .T.
1254:         loc_oGrid.Column1.CurrentControl = "txt_4c_Cod01"
1255: 
1256:         loc_oGrid.Column2.AddObject("txt_4c_Dsc02", "TextBox")
1257:         loc_oGrid.Column2.txt_4c_Dsc02.ReadOnly = .T.
1258:         loc_oGrid.Column2.CurrentControl = "txt_4c_Dsc02"
1259: 
1260:         loc_oGrid.Column3.AddObject("txt_4c_Cor03", "TextBox")
1261:         loc_oGrid.Column3.txt_4c_Cor03.ReadOnly = .T.
1262:         loc_oGrid.Column3.CurrentControl = "txt_4c_Cor03"
1263: 
1264:         loc_oGrid.Column4.AddObject("txt_4c_Tam04", "TextBox")
1265:         loc_oGrid.Column4.txt_4c_Tam04.ReadOnly = .T.

*-- Linhas 1278 a 1329:
1278:         loc_oGrid.Column7.CurrentControl = "txt_4c_Dis07"
1279: 
1280:         *-- Grid Distribui (grdDistribui: top=141, left=664, width=334, height=327, 4 colunas)
1281:         loc_oPage.AddObject("grd_4c_Distribui", "Grid")
1282:         loc_oPage.grd_4c_Distribui.ColumnCount = 4
1283: 
1284:         WITH loc_oPage.grd_4c_Distribui
1285:             .Top                = 141
1286:             .Left               = 664
1287:             .Width              = 334
1288:             .Height             = 327
1289:             .FontName           = "Verdana"
1290:             .FontSize           = 8
1291:             .ForeColor          = RGB(90, 90, 90)
1292:             .BackColor          = RGB(255, 255, 255)
1293:             .GridLineColor      = RGB(238, 238, 238)
1294:             .HighlightBackColor = RGB(255, 255, 255)
1295:             .HighlightForeColor = RGB(15, 41, 104)
1296:             .HighlightStyle     = 2
1297:             .DeleteMark         = .F.
1298:             .RecordMark         = .F.
1299:             .RowHeight          = 18
1300:             .ScrollBars         = 2
1301:             .GridLines          = 3
1302:             .Visible            = .T.
1303:             .Column1.Header1.Caption = "Empresa"
1304:             .Column1.Width           = 60
1305:             .Column2.Header1.Caption = "Saldo"
1306:             .Column2.Width           = 70
1307:             .Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
1308:             .Column3.Width           = 80
1309:             .Column4.Header1.Caption = "Local"
1310:             .Column4.Width           = 90
1311:         ENDWITH
1312: 
1313:         *-- Col1/Col2 read-only; Col3 editavel (QtdDistr); Col4 editavel com lookup Local
1314:         loc_oGrid = loc_oPage.grd_4c_Distribui
1315: 
1316:         loc_oGrid.Column1.AddObject("txt_4c_Emp01", "TextBox")
1317:         loc_oGrid.Column1.txt_4c_Emp01.ReadOnly = .T.
1318:         loc_oGrid.Column1.CurrentControl = "txt_4c_Emp01"
1319: 
1320:         loc_oGrid.Column2.AddObject("txt_4c_Sal02", "TextBox")
1321:         loc_oGrid.Column2.txt_4c_Sal02.ReadOnly = .T.
1322:         loc_oGrid.Column2.CurrentControl = "txt_4c_Sal02"
1323: 
1324:         loc_oGrid.Column3.AddObject("txt_4c_Dis03", "TextBox")
1325:         loc_oGrid.Column3.CurrentControl = "txt_4c_Dis03"
1326: 
1327:         loc_oGrid.Column4.AddObject("txt_4c_Loc04", "TextBox")
1328:         loc_oGrid.Column4.CurrentControl = "txt_4c_Loc04"
1329: 

*-- Linhas 1592 a 1734:
1592:         ENDWITH
1593: 
1594:         *-- BINDEVENTs
1595:         BINDEVENT(loc_oPage.grd_4c_Disponivel, "AfterRowColChange", ;
1596:             THIS, "GrdDisponivelAfterRowColChange")
1597:         BINDEVENT(loc_oPage.grd_4c_Distribui.Column3.txt_4c_Dis03, ;
1598:             "LostFocus", THIS, "DistribuidoLostFocus")
1599:         BINDEVENT(loc_oPage.grd_4c_Distribui.Column4.txt_4c_Loc04, ;
1600:             "Valid", THIS, "LocalDistribuidoValid")
1601:         BINDEVENT(loc_oPage.txt_4c_CodGrupoDist,   "KeyPress", THIS, "GrupoCodDistValid")
1602:         BINDEVENT(loc_oPage.txt_4c_DscGrupoDist,   "KeyPress", THIS, "GrupoDscDistValid")
1603:         BINDEVENT(loc_oPage.txt_4c_CodSgrupoDist,  "KeyPress", THIS, "SgrupoCodDistValid")
1604:         BINDEVENT(loc_oPage.txt_4c_DscSgrupoDist,  "KeyPress", THIS, "SgrupoDscDistValid")
1605:         BINDEVENT(loc_oPage.cmd_4c_Filtrar,        "Click", THIS, "FiltrarDisponivelClick")
1606:         BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProdutoInicialValid")
1607: 
1608:         THIS.TornarControlesVisiveis(loc_oPage)
1609:     ENDPROC
1610: 
1611:     *==========================================================================
1612:     * CarregarDisponivel - Vincula grd_4c_Disponivel ao cursor_4c_Disponivel
1613:     *==========================================================================
1614:     PROTECTED PROCEDURE CarregarDisponivel()
1615:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1616:         loc_lResultado = .F.
1617: 
1618:         TRY
1619:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1620:                 loc_lResultado = .T.
1621:             ELSE
1622:                 IF USED("cursor_4c_Disponivel")
1623:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1624:                 loc_oGrid = loc_oPage.grd_4c_Disponivel
1625: 
1626:                 loc_oGrid.ColumnCount = 7
1627:                 loc_oGrid.RecordSource = "cursor_4c_Disponivel"
1628: 
1629:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Disponivel.Cpros"
1630:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Disponivel.Dpros"
1631:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Disponivel.CodCors"
1632:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Disponivel.CodTams"
1633:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Disponivel.Sqtds"
1634:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1635:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1636: 
1637:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1638:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1639:                 loc_oGrid.Column3.Header1.Caption = "Cor"
1640:                 loc_oGrid.Column4.Header1.Caption = "Tam"
1641:                 loc_oGrid.Column5.Header1.Caption = "Estoque"
1642:                 loc_oGrid.Column6.Header1.Caption = "Saldo"
1643:                 loc_oGrid.Column7.Header1.Caption = "Distribu" + CHR(237) + "do"
1644: 
1645:                 THIS.FormatarGridLista(loc_oGrid)
1646:                 loc_oGrid.Refresh()
1647: 
1648:                 THIS.CarregarDistribui()
1649: 
1650:                 loc_lResultado = .T.
1651:                 ENDIF
1652:             ENDIF
1653: 
1654:         CATCH TO loc_oErro
1655:             MsgErro("Erro em CarregarDisponivel:" + CHR(13) + loc_oErro.Message, "Erro")
1656:             loc_lResultado = .F.
1657:         ENDTRY
1658: 
1659:         RETURN loc_lResultado
1660:     ENDPROC
1661: 
1662:     *==========================================================================
1663:     * CarregarDistribui - Vincula grd_4c_Distribui ao cursor_4c_Distribui
1664:     *==========================================================================
1665:     PROTECTED PROCEDURE CarregarDistribui()
1666:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1667:         loc_lResultado = .F.
1668: 
1669:         TRY
1670:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1671:                 loc_lResultado = .T.
1672:             ELSE
1673:                 IF USED("cursor_4c_Distribui")
1674:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1675:                 loc_oGrid = loc_oPage.grd_4c_Distribui
1676: 
1677:                 loc_oGrid.ColumnCount = 4
1678:                 loc_oGrid.RecordSource = "cursor_4c_Distribui"
1679: 
1680:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Distribui.Cemps"
1681:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1682:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1683:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"
1684: 
1685:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1686:                 loc_oGrid.Column2.Header1.Caption = "Saldo"
1687:                 loc_oGrid.Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
1688:                 loc_oGrid.Column4.Header1.Caption = "Local"
1689: 
1690:                 THIS.FormatarGridLista(loc_oGrid)
1691:                 loc_oGrid.Refresh()
1692: 
1693:                 loc_lResultado = .T.
1694:                 ENDIF
1695:             ENDIF
1696: 
1697:         CATCH TO loc_oErro
1698:             MsgErro("Erro em CarregarDistribui:" + CHR(13) + loc_oErro.Message, "Erro")
1699:             loc_lResultado = .F.
1700:         ENDTRY
1701: 
1702:         RETURN loc_lResultado
1703:     ENDPROC
1704: 
1705:     *==========================================================================
1706:     * GrdDisponivelAfterRowColChange - Filtra grd_4c_Distribui pelo produto atual
1707:     *==========================================================================
1708:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1709:         LOCAL loc_cCodPro, loc_oPage, loc_oErro
1710: 
1711:         TRY
1712:             IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel") ;
1713:                AND USED("cursor_4c_Distribui")
1714:                 SELECT cursor_4c_Disponivel
1715:                 loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1716:                 SELECT cursor_4c_Distribui
1717:                 SET FILTER TO ALLTRIM(Cpros) = loc_cCodPro
1718:                 GO TOP IN cursor_4c_Distribui
1719:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Distribui.Refresh()
1720:                 THIS.PopularInfoProduto(loc_cCodPro)
1721:             ENDIF
1722: 
1723:         CATCH TO loc_oErro
1724:             MsgErro("Erro em GrdDisponivelAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1725:         ENDTRY
1726:     ENDPROC
1727: 
1728:     *==========================================================================
1729:     * DistribuidoLostFocus - Recalcula saldo ao sair do campo Distribuido
1730:     *==========================================================================
1731:     PROCEDURE DistribuidoLostFocus()
1732:         THIS.CalcularSaldo()
1733:     ENDPROC
1734: 

*-- Linhas 1774 a 1826:
1774:                     ENDIF
1775: 
1776:                     loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1777:                     loc_oPage.grd_4c_Disponivel.Refresh()
1778:                     loc_oPage.grd_4c_Distribui.Refresh()
1779:                 ENDIF
1780:             ENDIF
1781: 
1782:         CATCH TO loc_oErro
1783:             MsgErro("Erro em CalcularSaldo:" + CHR(13) + loc_oErro.Message, "Erro")
1784:         ENDTRY
1785:     ENDPROC
1786: 
1787:     *==========================================================================
1788:     * LocalDistribuidoValid - Lookup localizacao SigPrLcl (Column4 grdDistribui)
1789:     *==========================================================================
1790:     PROCEDURE LocalDistribuidoValid()
1791:         LOCAL loc_oBusca, loc_cValor, loc_oPage, loc_oErro
1792: 
1793:         TRY
1794:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1795:             loc_cValor = ALLTRIM(loc_oPage.grd_4c_Distribui.Column4.txt_4c_Loc04.Value)
1796: 
1797:             IF !EMPTY(loc_cValor)
1798:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1799:                     "SigPrLcl", "cursor_4c_BuscaLocal", "Codigos", loc_cValor, ;
1800:                     "Localiza" + CHR(231) + CHR(227) + "o")
1801: 
1802:                 IF VARTYPE(loc_oBusca) = "O"
1803:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1804:                         IF USED("cursor_4c_BuscaLocal")
1805:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1806:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1807:                         ENDIF
1808:                     ELSE
1809:                         IF !loc_oBusca.this_lAchouRegistro
1810:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1811:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1812:                         loc_oBusca.Show()
1813:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
1814:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1815:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1816:                         ENDIF
1817:                     ELSE
1818:                         REPLACE cursor_4c_Distribui.CidChaves WITH ""
1819:                         ENDIF
1820:                     ENDIF
1821:                     loc_oBusca.Release()
1822:                 ENDIF
1823: 
1824:                 IF USED("cursor_4c_BuscaLocal")
1825:                     USE IN cursor_4c_BuscaLocal
1826:                 ENDIF

*-- Linhas 1856 a 1875:
1856:                         ENDIF
1857:                     ELSE
1858:                         IF !loc_oBusca.this_lAchouRegistro
1859:                         loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1860:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1861:                         loc_oBusca.Show()
1862:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1863:                             loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1864:                             loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1865:                         ENDIF
1866:                     ELSE
1867:                         loc_oPage.txt_4c_CodGrupoDist.Value = ""
1868:                         loc_oPage.txt_4c_DscGrupoDist.Value = ""
1869:                         ENDIF
1870:                     ENDIF
1871:                     loc_oBusca.Release()
1872:                 ENDIF
1873: 
1874:                 IF USED("cursor_4c_BuscaGrp")
1875:                     USE IN cursor_4c_BuscaGrp

*-- Linhas 1906 a 1925:
1906:                         ENDIF
1907:                     ELSE
1908:                         IF !loc_oBusca.this_lAchouRegistro
1909:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1910:                         loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1911:                         loc_oBusca.Show()
1912:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1913:                             loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1914:                             loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1915:                         ENDIF
1916:                     ELSE
1917:                         loc_oPage.txt_4c_CodGrupoDist.Value = ""
1918:                         loc_oPage.txt_4c_DscGrupoDist.Value = ""
1919:                         ENDIF
1920:                     ENDIF
1921:                     loc_oBusca.Release()
1922:                 ENDIF
1923: 
1924:                 IF USED("cursor_4c_BuscaGrp")
1925:                     USE IN cursor_4c_BuscaGrp

*-- Linhas 1956 a 1975:
1956:                         ENDIF
1957:                     ELSE
1958:                         IF !loc_oBusca.this_lAchouRegistro
1959:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1960:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1961:                         loc_oBusca.Show()
1962:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrp")
1963:                             loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
1964:                             loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
1965:                         ENDIF
1966:                     ELSE
1967:                         loc_oPage.txt_4c_CodSgrupoDist.Value = ""
1968:                         loc_oPage.txt_4c_DscSgrupoDist.Value = ""
1969:                         ENDIF
1970:                     ENDIF
1971:                     loc_oBusca.Release()
1972:                 ENDIF
1973: 
1974:                 IF USED("cursor_4c_BuscaSgrp")
1975:                     USE IN cursor_4c_BuscaSgrp

*-- Linhas 2006 a 2025:
2006:                         ENDIF
2007:                     ELSE
2008:                         IF !loc_oBusca.this_lAchouRegistro
2009:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2010:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
2011:                         loc_oBusca.Show()
2012:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrp")
2013:                             loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
2014:                             loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
2015:                         ENDIF
2016:                     ELSE
2017:                         loc_oPage.txt_4c_CodSgrupoDist.Value = ""
2018:                         loc_oPage.txt_4c_DscSgrupoDist.Value = ""
2019:                         ENDIF
2020:                     ENDIF
2021:                     loc_oBusca.Release()
2022:                 ENDIF
2023: 
2024:                 IF USED("cursor_4c_BuscaSgrp")
2025:                     USE IN cursor_4c_BuscaSgrp

*-- Linhas 2032 a 2050:
2032:     ENDPROC
2033: 
2034:     *==========================================================================
2035:     * FiltrarDisponivelClick - Filtra grd_4c_Disponivel por grupo e/ou subgrupo
2036:     *==========================================================================
2037:     PROCEDURE FiltrarDisponivelClick()
2038:         LOCAL loc_cCodGrp, loc_cCodSgrp, loc_oPage, loc_oErro
2039: 
2040:         TRY
2041:             IF USED("cursor_4c_Disponivel")
2042:                 loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2043:                 loc_cCodGrp  = ALLTRIM(loc_oPage.txt_4c_CodGrupoDist.Value)
2044:                 loc_cCodSgrp = ALLTRIM(loc_oPage.txt_4c_CodSgrupoDist.Value)
2045: 
2046:                 SELECT cursor_4c_Disponivel
2047: 
2048:                 IF EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2049:                     SET FILTER TO
2050:                 ELSE

*-- Linhas 2061 a 2102:
2061:                 ENDIF
2062: 
2063:                 GO TOP IN cursor_4c_Disponivel
2064:                 loc_oPage.grd_4c_Disponivel.Refresh()
2065:             ENDIF
2066: 
2067:         CATCH TO loc_oErro
2068:             MsgErro("Erro em FiltrarDisponivelClick:" + CHR(13) + loc_oErro.Message, "Erro")
2069:         ENDTRY
2070:     ENDPROC
2071: 
2072:     *==========================================================================
2073:     * ProdutoInicialValid - Navega grd_4c_Disponivel para o produto informado
2074:     *==========================================================================
2075:     PROCEDURE ProdutoInicialValid()
2076:         LOCAL loc_cProd, loc_oPage, loc_oErro
2077: 
2078:         TRY
2079:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2080:             loc_cProd = ALLTRIM(loc_oPage.txt_4c_ProdutoInicial.Value)
2081: 
2082:             IF !EMPTY(loc_cProd) AND USED("cursor_4c_Disponivel")
2083:                 SELECT cursor_4c_Disponivel
2084:                 GO TOP
2085:                 LOCATE FOR ALLTRIM(Cpros) >= loc_cProd
2086:                 IF !EOF("cursor_4c_Disponivel")
2087:                     loc_oPage.grd_4c_Disponivel.Refresh()
2088:                 ENDIF
2089:             ENDIF
2090: 
2091:         CATCH TO loc_oErro
2092:             MsgErro("Erro em ProdutoInicialValid:" + CHR(13) + loc_oErro.Message, "Erro")
2093:         ENDTRY
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * PopularInfoProduto - Preenche o painel info com dados do produto selecionado
2098:     *==========================================================================
2099:     PROCEDURE PopularInfoProduto(par_cCodPro)
2100:         LOCAL loc_oPage, loc_cSQL, loc_nRet, loc_oErro
2101: 
2102:         TRY

*-- Linhas 2283 a 2343:
2283:         ENDWITH
2284:         loc_oPgfOp = loc_oPage.pgf_4c_Operacoes
2285: 
2286:         *-- grd_4c_CabOperas na Page1 (grdCabOperas: 8 cols, top=6, left=9, width=975, height=339)
2287:         loc_oPgfOp.Page1.AddObject("grd_4c_CabOperas", "Grid")
2288:         loc_oPgfOp.Page1.grd_4c_CabOperas.ColumnCount = 8
2289: 
2290:         WITH loc_oPgfOp.Page1.grd_4c_CabOperas
2291:             .Top                = 6
2292:             .Left               = 9
2293:             .Width              = 975
2294:             .Height             = 339
2295:             .FontName           = "Verdana"
2296:             .FontSize           = 8
2297:             .ForeColor          = RGB(90, 90, 90)
2298:             .BackColor          = RGB(255, 255, 255)
2299:             .GridLineColor      = RGB(238, 238, 238)
2300:             .HighlightBackColor = RGB(255, 255, 255)
2301:             .HighlightForeColor = RGB(15, 41, 104)
2302:             .HighlightStyle     = 2
2303:             .DeleteMark         = .F.
2304:             .RecordMark         = .F.
2305:             .RowHeight          = 18
2306:             .ScrollBars         = 3
2307:             .GridLines          = 3
2308:             .ReadOnly           = .T.
2309:             .Visible            = .T.
2310:             .Column1.Header1.Caption = "Emp O"
2311:             .Column1.Width           = 55
2312:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2313:             .Column2.Width           = 110
2314:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
2315:             .Column3.Width           = 130
2316:             .Column4.Header1.Caption = "Emp D"
2317:             .Column4.Width           = 55
2318:             .Column5.Header1.Caption = "Grupo Orig"
2319:             .Column5.Width           = 105
2320:             .Column6.Header1.Caption = "Conta Orig"
2321:             .Column6.Width           = 105
2322:             .Column7.Header1.Caption = "Grupo Dest"
2323:             .Column7.Width           = 105
2324:             .Column8.Header1.Caption = "Conta Dest"
2325:             .Column8.Width           = 105
2326:         ENDWITH
2327: 
2328:         loc_oGrid = loc_oPgfOp.Page1.grd_4c_CabOperas
2329:         loc_oGrid.Column1.AddObject("txt_4c_Col01", "TextBox")
2330:         loc_oGrid.Column1.txt_4c_Col01.ReadOnly = .T.
2331:         loc_oGrid.Column1.CurrentControl = "txt_4c_Col01"
2332:         loc_oGrid.Column2.AddObject("txt_4c_Col02", "TextBox")
2333:         loc_oGrid.Column2.txt_4c_Col02.ReadOnly = .T.
2334:         loc_oGrid.Column2.CurrentControl = "txt_4c_Col02"
2335:         loc_oGrid.Column3.AddObject("txt_4c_Col03", "TextBox")
2336:         loc_oGrid.Column3.txt_4c_Col03.ReadOnly = .T.
2337:         loc_oGrid.Column3.CurrentControl = "txt_4c_Col03"
2338:         loc_oGrid.Column4.AddObject("txt_4c_Col04", "TextBox")
2339:         loc_oGrid.Column4.txt_4c_Col04.ReadOnly = .T.
2340:         loc_oGrid.Column4.CurrentControl = "txt_4c_Col04"
2341:         loc_oGrid.Column5.AddObject("txt_4c_Col05", "TextBox")
2342:         loc_oGrid.Column5.txt_4c_Col05.ReadOnly = .T.
2343:         loc_oGrid.Column5.CurrentControl = "txt_4c_Col05"

*-- Linhas 2351 a 2413:
2351:         loc_oGrid.Column8.txt_4c_Col08.ReadOnly = .T.
2352:         loc_oGrid.Column8.CurrentControl = "txt_4c_Col08"
2353: 
2354:         *-- grd_4c_ItnOperas na Page2 (grdItnOperas: 9 cols, top=5, left=9, width=975, height=340)
2355:         loc_oPgfOp.Page2.AddObject("grd_4c_ItnOperas", "Grid")
2356:         loc_oPgfOp.Page2.grd_4c_ItnOperas.ColumnCount = 9
2357: 
2358:         WITH loc_oPgfOp.Page2.grd_4c_ItnOperas
2359:             .Top                = 5
2360:             .Left               = 9
2361:             .Width              = 975
2362:             .Height             = 340
2363:             .FontName           = "Verdana"
2364:             .FontSize           = 8
2365:             .ForeColor          = RGB(90, 90, 90)
2366:             .BackColor          = RGB(255, 255, 255)
2367:             .GridLineColor      = RGB(238, 238, 238)
2368:             .HighlightBackColor = RGB(255, 255, 255)
2369:             .HighlightForeColor = RGB(15, 41, 104)
2370:             .HighlightStyle     = 2
2371:             .DeleteMark         = .F.
2372:             .RecordMark         = .F.
2373:             .RowHeight          = 18
2374:             .ScrollBars         = 3
2375:             .GridLines          = 3
2376:             .ReadOnly           = .T.
2377:             .Visible            = .T.
2378:             .Column1.Header1.Caption = "Item"
2379:             .Column1.Width           = 50
2380:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
2381:             .Column2.Width           = 100
2382:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2383:             .Column3.Width           = 200
2384:             .Column4.Header1.Caption = "Uni"
2385:             .Column4.Width           = 40
2386:             .Column5.Header1.Caption = "Quantidade"
2387:             .Column5.Width           = 90
2388:             .Column6.Header1.Caption = "Unit" + CHR(225) + "rio"
2389:             .Column6.Width           = 90
2390:             .Column7.Header1.Caption = "Total"
2391:             .Column7.Width           = 90
2392:             .Column8.Header1.Caption = "Cor"
2393:             .Column8.Width           = 60
2394:             .Column9.Header1.Caption = "Tam"
2395:             .Column9.Width           = 60
2396:         ENDWITH
2397: 
2398:         loc_oGrid = loc_oPgfOp.Page2.grd_4c_ItnOperas
2399:         loc_oGrid.Column1.AddObject("txt_4c_Itn01", "TextBox")
2400:         loc_oGrid.Column1.txt_4c_Itn01.ReadOnly = .T.
2401:         loc_oGrid.Column1.CurrentControl = "txt_4c_Itn01"
2402:         loc_oGrid.Column2.AddObject("txt_4c_Itn02", "TextBox")
2403:         loc_oGrid.Column2.txt_4c_Itn02.ReadOnly = .T.
2404:         loc_oGrid.Column2.CurrentControl = "txt_4c_Itn02"
2405:         loc_oGrid.Column3.AddObject("txt_4c_Itn03", "TextBox")
2406:         loc_oGrid.Column3.txt_4c_Itn03.ReadOnly = .T.
2407:         loc_oGrid.Column3.CurrentControl = "txt_4c_Itn03"
2408:         loc_oGrid.Column4.AddObject("txt_4c_Itn04", "TextBox")
2409:         loc_oGrid.Column4.txt_4c_Itn04.ReadOnly = .T.
2410:         loc_oGrid.Column4.CurrentControl = "txt_4c_Itn04"
2411:         loc_oGrid.Column5.AddObject("txt_4c_Itn05", "TextBox")
2412:         loc_oGrid.Column5.txt_4c_Itn05.ReadOnly = .T.
2413:         loc_oGrid.Column5.CurrentControl = "txt_4c_Itn05"

*-- Linhas 2430 a 2458:
2430:     ENDPROC
2431: 
2432:     *==========================================================================
2433:     * PgItensActivate - Atualiza grd_4c_ItnOperas ao ativar aba Itens
2434:     *==========================================================================
2435:     PROCEDURE PgItensActivate()
2436:         LOCAL loc_oPage, loc_oErro
2437: 
2438:         TRY
2439:             IF USED("cursor_4c_ItnOperas")
2440:                 GO TOP IN cursor_4c_ItnOperas
2441:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2442:                 IF VARTYPE(loc_oPage) = "O" AND VARTYPE(loc_oPage.grd_4c_ItnOperas) = "O"
2443:                     loc_oPage.grd_4c_ItnOperas.Refresh()
2444:                 ENDIF
2445:             ENDIF
2446: 
2447:         CATCH TO loc_oErro
2448:             MsgErro("Erro em PgItensActivate:" + CHR(13) + loc_oErro.Message, "Erro")
2449:         ENDTRY
2450:     ENDPROC
2451: 
2452:     *==========================================================================
2453:     * BtnProcessarFinalClick - Valida, salva lote em sigprdis e exibe operacoes
2454:     *==========================================================================
2455:     PROCEDURE BtnProcessarFinalClick()
2456:         LOCAL loc_oErro
2457: 
2458:         TRY

*-- Linhas 2473 a 2583:
2473:     ENDPROC
2474: 
2475:     *==========================================================================
2476:     * CarregarCabOperas - Carrega grd_4c_CabOperas com movimentos do lote
2477:     *==========================================================================
2478:     PROTECTED PROCEDURE CarregarCabOperas()
2479:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2480:         loc_oErro = .NULL.
2481: 
2482:         TRY
2483:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page1
2484:             loc_oGrid   = loc_oPage.grd_4c_CabOperas
2485:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2486: 
2487:             IF USED("cursor_4c_CabOperas")
2488:                 USE IN cursor_4c_CabOperas
2489:             ENDIF
2490: 
2491:             loc_cSQL = "SELECT DISTINCT RTRIM(c.emps) AS emps, " + ;
2492:                        "RTRIM(c.dopes) AS dopes, " + ;
2493:                        "c.numes AS numes, " + ;
2494:                        "RTRIM(c.empds) AS empds, " + ;
2495:                        "RTRIM(c.grupoos) AS grupoos, RTRIM(c.contaos) AS contaos, " + ;
2496:                        "RTRIM(c.grupods) AS grupods, RTRIM(c.contads) AS contads " + ;
2497:                        "FROM SigMvCab c " + ;
2498:                        "WHERE EXISTS (" + ;
2499:                        " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2500:                        " AND (RTRIM(d.empdopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2501:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)" + ;
2502:                        " OR RTRIM(d.oridopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2503:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)))" + ;
2504:                        " ORDER BY c.emps, c.dopes"
2505: 
2506:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOperas")
2507: 
2508:             IF loc_nRet < 0
2509:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
2510:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2511:             ELSE
2512:                 loc_oGrid.ColumnCount = 3
2513:                 loc_oGrid.RecordSource = "cursor_4c_CabOperas"
2514:                 IF RECCOUNT("cursor_4c_CabOperas") > 0
2515:                     loc_oGrid.Column1.txt_4c_Col01.ControlSource = "cursor_4c_CabOperas.emps"
2516:                     loc_oGrid.Column2.txt_4c_Col02.ControlSource = "cursor_4c_CabOperas.dopes"
2517:                     loc_oGrid.Column3.txt_4c_Col03.ControlSource = "cursor_4c_CabOperas.numes"
2518:                     loc_oGrid.Column4.txt_4c_Col04.ControlSource = "cursor_4c_CabOperas.empds"
2519:                     loc_oGrid.Column5.txt_4c_Col05.ControlSource = "cursor_4c_CabOperas.grupoos"
2520:                     loc_oGrid.Column6.txt_4c_Col06.ControlSource = "cursor_4c_CabOperas.contaos"
2521:                     loc_oGrid.Column7.txt_4c_Col07.ControlSource = "cursor_4c_CabOperas.grupods"
2522:                     loc_oGrid.Column8.txt_4c_Col08.ControlSource = "cursor_4c_CabOperas.contads"
2523:                 ENDIF
2524:                 loc_oGrid.Refresh()
2525:             ENDIF
2526: 
2527:         CATCH TO loc_oErro
2528:             MsgErro("Erro em CarregarCabOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2529:         ENDTRY
2530:     ENDPROC
2531: 
2532:     *==========================================================================
2533:     * CarregarItnOperas - Carrega grd_4c_ItnOperas com itens de movimentos do lote
2534:     *==========================================================================
2535:     PROTECTED PROCEDURE CarregarItnOperas()
2536:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2537:         loc_oErro = .NULL.
2538: 
2539:         TRY
2540:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2541:             loc_oGrid   = loc_oPage.grd_4c_ItnOperas
2542:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2543: 
2544:             IF USED("cursor_4c_ItnOperas")
2545:                 USE IN cursor_4c_ItnOperas
2546:             ENDIF
2547: 
2548:             loc_cSQL = "SELECT RTRIM(b.cItens) AS Citens, RTRIM(b.CPros) AS CPros, " + ;
2549:                        "RTRIM(ISNULL(b.DPros,'')) AS Dpros, " + ;
2550:                        "RTRIM(b.Cunis) AS CUnis, b.Qtds, b.Units, b.totas, " + ;
2551:                        "RTRIM(c.CodCors) AS CodCors, RTRIM(c.CodTams) AS CodTams " + ;
2552:                        "FROM (SELECT DISTINCT d.EmpDopNums FROM sigprdis d" + ;
2553:                        " WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2554:                        " AND RTRIM(d.EmpDopNums) <> '') x " + ;
2555:                        "INNER JOIN SigMvItn b ON x.EmpDopNums = b.EmpDopNums " + ;
2556:                        "INNER JOIN SigMvIts c ON b.EmpDopNums = c.EmpDopNums" + ;
2557:                        " AND b.cItens = c.Citens " + ;
2558:                        "ORDER BY b.cItens"
2559: 
2560:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOperas")
2561: 
2562:             IF loc_nRet < 0
2563:                 MsgErro("Erro ao carregar itens de opera" + CHR(231) + CHR(245) + "es:" + ;
2564:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2565:             ELSE
2566:                 loc_oGrid.ColumnCount = 3
2567:                 loc_oGrid.RecordSource = "cursor_4c_ItnOperas"
2568:                 IF RECCOUNT("cursor_4c_ItnOperas") > 0
2569:                     loc_oGrid.Column1.txt_4c_Itn01.ControlSource = "cursor_4c_ItnOperas.Citens"
2570:                     loc_oGrid.Column2.txt_4c_Itn02.ControlSource = "cursor_4c_ItnOperas.CPros"
2571:                     loc_oGrid.Column3.txt_4c_Itn03.ControlSource = "cursor_4c_ItnOperas.Dpros"
2572:                     loc_oGrid.Column4.txt_4c_Itn04.ControlSource = "cursor_4c_ItnOperas.CUnis"
2573:                     loc_oGrid.Column5.txt_4c_Itn05.ControlSource = "cursor_4c_ItnOperas.Qtds"
2574:                     loc_oGrid.Column6.txt_4c_Itn06.ControlSource = "cursor_4c_ItnOperas.Units"
2575:                     loc_oGrid.Column7.txt_4c_Itn07.ControlSource = "cursor_4c_ItnOperas.totas"
2576:                     loc_oGrid.Column8.txt_4c_Itn08.ControlSource = "cursor_4c_ItnOperas.CodCors"
2577:                     loc_oGrid.Column9.txt_4c_Itn09.ControlSource = "cursor_4c_ItnOperas.CodTams"
2578:                 ENDIF
2579:                 loc_oGrid.Refresh()
2580:             ENDIF
2581: 
2582:         CATCH TO loc_oErro
2583:             MsgErro("Erro em CarregarItnOperas:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 2682 a 2700:
2682:                 IF VARTYPE(loc_oPage2Dados.cmd_4c_Filtrar)        = "O"
2683:                     loc_oPage2Dados.cmd_4c_Filtrar.Enabled         = par_lHabilitar
2684:                 ENDIF
2685:                 loc_oGrid = loc_oPage2Dados.grd_4c_Distribui
2686:                 IF VARTYPE(loc_oGrid) = "O"
2687:                     loc_oGrid.Column3.txt_4c_Dis03.ReadOnly = !par_lHabilitar
2688:                     loc_oGrid.Column4.txt_4c_Loc04.ReadOnly = !par_lHabilitar
2689:                 ENDIF
2690:             ENDIF
2691:             *-- Aba1 Estoques: processar e marca/desmarca
2692:             loc_oPage1Aba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2693:             IF VARTYPE(loc_oPage1Aba) = "O"
2694:                 IF VARTYPE(loc_oPage1Aba.cmd_4c_Processar)      = "O"
2695:                     loc_oPage1Aba.cmd_4c_Processar.Enabled      = par_lHabilitar
2696:                 ENDIF
2697:                 IF VARTYPE(loc_oPage1Aba.cmg_4c_MarcaDesmarca)  = "O"
2698:                     loc_oPage1Aba.cmg_4c_MarcaDesmarca.Enabled  = par_lHabilitar
2699:                 ENDIF
2700:             ENDIF

