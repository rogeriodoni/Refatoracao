# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1222: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1375: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS GRID (1819 linhas total):

*-- Linhas 94 a 135:
94:     * csSigPrPmv: grupos de venda da promocao (edicao em grid)
95:     *====================================================================
96:     PROTECTED PROCEDURE CriarCursoresLocais()
97:         SET NULL ON
98:         CREATE CURSOR csSigPrPmi (CPros c(14), DPros c(40), Pecas c(10), ;
99:             Promos c(25), CBars n(8), Datas d NULL, DtAlts t NULL, ;
100:             PromoPro c(35), Vendavels n(1), cIdChaves c(20))
101:         SELECT csSigPrPmi
102:         INDEX ON CPros TAG CPros
103: 
104:         CREATE CURSOR TcrSigPrPmi (CPros c(14), Datas d NULL, Pecas c(10), Vendavels n(1))
105:         INDEX ON CPros TAG idxTcpros
106: 
107:         CREATE CURSOR csSigPrPmv (Promos c(25), Colecoes c(10), Datas t NULL, cIdChaves c(20))
108:         SELECT csSigPrPmv
109: 
110:         CREATE CURSOR cursor_4c_Itens ;
111:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
112:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
113:              PromoPro C(35), Vendavels N(1,0) NULL)
114:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
115: 
116:         CREATE CURSOR cursor_4c_Grupos ;
117:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
118:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
119: 
120:         SET NULL OFF
121:     ENDPROC
122: 
123:     *====================================================================
124:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
125:     *====================================================================
126:     PROTECTED PROCEDURE ConfigurarPageFrame()
127:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
128:         WITH THIS.pgf_4c_Paginas
129:             .Top       = -29
130:             .Left      = 0
131:             .Width     = THIS.Width
132:             .Height    = THIS.Height + 29
133:             .PageCount = 2
134:             .Tabs      = .F.
135:             .TabStop   = .F.

*-- Linhas 362 a 383:
362:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
363: 
364:         *-- Grid principal: Top=117 (88+29), Width=910 (nao sobrepoem cnt_4c_Saida em Left=917)
365:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
366:         loc_oGrid = loc_oPagina.grd_4c_Lista
367:         loc_oGrid.RecordSource = ""
368:         loc_oGrid.ColumnCount  = 5
369:         WITH loc_oGrid
370:             .Top                = 117
371:             .Left               = 0
372:             .Width              = 910
373:             .Height             = 478
374:             .FontName           = "Verdana"
375:             .FontSize           = 8
376:             .ForeColor          = RGB(90, 90, 90)
377:             .BackColor          = RGB(255, 255, 255)
378:             .GridLineColor      = RGB(238, 238, 238)
379:             .GridLines          = 3
380:             .HighlightBackColor = RGB(255, 255, 255)
381:             .HighlightForeColor = RGB(15, 41, 104)
382:             .HighlightStyle     = 2
383:             .DeleteMark         = .F.

*-- Linhas 641 a 672:
641:                 IF !THIS.this_oBusinessObject.Buscar("")
642:                     loc_lSucesso = .F.
643:                 ELSE
644:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
645:                     loc_oGrid.ColumnCount = 5
646:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
647:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Promos"
648:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cods"
649:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Comiss"
650:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
651:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
652:                     *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
653:                     loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
654:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "d."
655:                     loc_oGrid.Column3.Header1.Caption = "Comiss%"
656:                     loc_oGrid.Column4.Header1.Caption = "e-Com."
657:                     loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
658:                     loc_oGrid.Column3.Alignment = 1
659:                     loc_oGrid.Column4.Alignment = 1
660:                     THIS.FormatarGridLista(loc_oGrid)
661:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
662:                         GO TOP IN cursor_4c_Dados
663:                     ENDIF
664:                     loc_lSucesso = .T.
665:                 ENDIF
666:             CATCH TO loException
667:                 MostrarErro(loException, "FormPrm.CarregarLista")
668:             ENDTRY
669:         ENDIF
670: 
671:         RETURN loc_lSucesso
672:     ENDPROC

*-- Linhas 966 a 985:
966:             THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
967:         ENDIF
968:         TRY
969:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
970:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
971:         CATCH TO loException
972:             MostrarErro(loException, "FormPrm.BOParaForm")
973:         ENDTRY
974:     ENDPROC
975: 
976:     *====================================================================
977:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
978:     *====================================================================
979:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
980:         LOCAL loc_oPg2
981:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
982: 
983:         *-- Promos e Codigo: editaveis somente em INCLUIR
984:         loc_oPg2.txt_4c_Promos.Enabled = par_lHabilitar AND ;
985:                                           (THIS.this_cModoAtual == "INCLUIR")

*-- Linhas 1002 a 1021:
1002: 
1003:         *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
1004:         IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
1005:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
1006:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
1007:             loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
1008:             loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
1009:         ENDIF
1010:     ENDPROC
1011: 
1012:     *====================================================================
1013:     * LimparCampos - Limpa valores de todos os campos da Page2
1014:     *====================================================================
1015:     PROTECTED PROCEDURE LimparCampos()
1016:         LOCAL loc_oPg2
1017:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1018: 
1019:         loc_oPg2.txt_4c_Promos.Value    = ""
1020:         loc_oPg2.txt_4c_Codigo.Value    = ""
1021:         loc_oPg2.chk_4c_Comissao.Value  = 0

*-- Linhas 1033 a 1068:
1033:             USE IN cursor_4c_Grupos
1034:         ENDIF
1035: 
1036:         SET NULL ON
1037:         CREATE CURSOR cursor_4c_Itens ;
1038:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1039:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1040:              PromoPro C(35), Vendavels N(1,0) NULL)
1041:         SET NULL OFF
1042:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1043: 
1044:         SET NULL ON
1045:         CREATE CURSOR cursor_4c_Grupos ;
1046:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1047:         SET NULL OFF
1048:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1049: 
1050:         *-- Atualizar grids com cursores limpos
1051:         TRY
1052:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1053:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1054:         CATCH TO loException
1055:             MostrarErro(loException, "FormPrm.LimparCampos")
1056:         ENDTRY
1057:     ENDPROC
1058: 
1059:     *====================================================================
1060:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1061:     *====================================================================
1062:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1063:         LOCAL loc_oPg2
1064:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1065: 
1066:         DO CASE
1067:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1068:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

*-- Linhas 1098 a 1116:
1098:         *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
1099:         THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
1100:         TRY
1101:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1102:         CATCH TO loException
1103:             MostrarErro(loException, "FormPrm.ValidarPromos")
1104:         ENDTRY
1105:     ENDPROC
1106: 
1107:     *====================================================================
1108:     * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
1109:     * Substitui fwBuscaExt para SigCdLpc
1110:     *====================================================================
1111:     PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
1112:         LOCAL loc_oPg2, loc_cLPrecos, loc_nResult, loc_oBusca
1113:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1114:         loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
1115: 
1116:         IF EMPTY(loc_cLPrecos)

*-- Linhas 1193 a 1285:
1193:     ENDPROC
1194: 
1195:     *====================================================================
1196:     * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
1197:     * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
1198:     *====================================================================
1199:     PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
1200:         LOCAL loc_oGrid
1201: 
1202:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1203:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1204:         WITH loc_oGrid
1205:             .Top             = 3
1206:             .Left            = 8
1207:             .Width           = 742
1208:             .Height          = 220
1209:             .ColumnCount     = 6
1210:             .FontName        = "Tahoma"
1211:             .FontSize        = 8
1212:             .ForeColor       = RGB(90, 90, 90)
1213:             .BackColor       = RGB(255, 255, 255)
1214:             .GridLineColor   = RGB(238, 238, 238)
1215:             .GridLines       = 3
1216:             .HighlightStyle  = 2
1217:             .DeleteMark      = .F.
1218:             .RecordMark      = .F.
1219:             .RowHeight       = 18
1220:             .ScrollBars      = 3
1221:             .ReadOnly        = .F.
1222:             .RecordSource    = "cursor_4c_Itens"
1223:         ENDWITH
1224: 
1225:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1226:         WITH loc_oGrid.Column1
1227:             .ControlSource   = "cursor_4c_Itens.CPros"
1228:             .Width           = 100
1229:             .Sparse          = .F.
1230:             .Header1.Caption = "Produto"
1231:         ENDWITH
1232:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1233: 
1234:         WITH loc_oGrid.Column2
1235:             .ControlSource   = "cursor_4c_Itens.DPros"
1236:             .Width           = 200
1237:             .ReadOnly        = .T.
1238:             .Sparse          = .F.
1239:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1240:         ENDWITH
1241: 
1242:         WITH loc_oGrid.Column3
1243:             .ControlSource   = "cursor_4c_Itens.Pecas"
1244:             .Width           = 70
1245:             .Sparse          = .F.
1246:             .Header1.Caption = "Pe" + CHR(231) + "a"
1247:         ENDWITH
1248: 
1249:         WITH loc_oGrid.Column4
1250:             .ControlSource   = "cursor_4c_Itens.CBars"
1251:             .Width           = 80
1252:             .Sparse          = .F.
1253:             .ReadOnly        = .T.
1254:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1255:         ENDWITH
1256: 
1257:         WITH loc_oGrid.Column5
1258:             .ControlSource   = "cursor_4c_Itens.Datas"
1259:             .Width           = 80
1260:             .Sparse          = .F.
1261:             .Header1.Caption = "Data Inicial"
1262:         ENDWITH
1263:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1264: 
1265:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1266:         WITH loc_oGrid.Column6
1267:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1268:             .Width           = 35
1269:             .Sparse          = .F.
1270:             .Header1.Caption = "V"
1271:             .AddObject("chk_4c_Vendavel", "CheckBox")
1272:             WITH .chk_4c_Vendavel
1273:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1274:                 .Caption       = ""
1275:                 .Alignment     = 0
1276:                 .ReadOnly      = .F.
1277:                 .Visible       = .T.
1278:                 .Top           = 9
1279:                 .Left          = 2
1280:                 .Height        = 17
1281:                 .Width         = 22
1282:             ENDWITH
1283:             .CurrentControl  = "chk_4c_Vendavel"
1284:         ENDWITH
1285:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")

*-- Linhas 1346 a 1406:
1346:     ENDPROC
1347: 
1348:     *====================================================================
1349:     * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
1350:     * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
1351:     *====================================================================
1352:     PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
1353:         LOCAL loc_oGrid
1354: 
1355:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1356:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1357:         WITH loc_oGrid
1358:             .Top             = 24
1359:             .Left            = 256
1360:             .Width           = 192
1361:             .Height          = 324
1362:             .ColumnCount     = 2
1363:             .FontName        = "Tahoma"
1364:             .FontSize        = 8
1365:             .ForeColor       = RGB(90, 90, 90)
1366:             .BackColor       = RGB(255, 255, 255)
1367:             .GridLineColor   = RGB(238, 238, 238)
1368:             .GridLines       = 3
1369:             .HighlightStyle  = 2
1370:             .DeleteMark      = .F.
1371:             .RecordMark      = .F.
1372:             .RowHeight       = 18
1373:             .ScrollBars      = 3
1374:             .ReadOnly        = .F.
1375:             .RecordSource    = "cursor_4c_Grupos"
1376:         ENDWITH
1377: 
1378:         *-- ControlSources e Headers APOS RecordSource
1379:         WITH loc_oGrid.Column1
1380:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1381:             .Width           = 80
1382:             .Sparse          = .F.
1383:             .Header1.Caption = "Grp. Venda"
1384:         ENDWITH
1385:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1386: 
1387:         WITH loc_oGrid.Column2
1388:             .ControlSource   = "cursor_4c_Grupos.Datas"
1389:             .Width           = 80
1390:             .Sparse          = .F.
1391:             .Header1.Caption = "Data Inicial"
1392:         ENDWITH
1393:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1394: 
1395:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1396:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1397:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1398:             .Caption      = "Apagar"
1399:             .Top          = 161
1400:             .Left         = 451
1401:             .Width        = 50
1402:             .Height       = 50
1403:             .FontName     = "Tahoma"
1404:             .FontSize     = 8
1405:             .MousePointer = 15
1406:             .Visible      = .T.

*-- Linhas 1456 a 1474:
1456:     ENDPROC
1457: 
1458:     *====================================================================
1459:     * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
1460:     * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
1461:     * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
1462:     *====================================================================
1463:     PROCEDURE ValidarProdutoCodigo()
1464:         LOCAL loc_cCpros, loc_oBusca
1465: 
1466:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1467:             RETURN .T.
1468:         ENDIF
1469: 
1470:         loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)
1471: 
1472:         IF EMPTY(loc_cCpros)
1473:             REPLACE cursor_4c_Itens.DPros WITH ""
1474:             REPLACE cursor_4c_Itens.CBars WITH 0

*-- Linhas 1517 a 1571:
1517:             ENDIF
1518:         ENDTRY
1519: 
1520:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1521:         RETURN .T.
1522:     ENDPROC
1523: 
1524:     *====================================================================
1525:     * GridProdutosDatasValid - Column5 Valid: adiciona linha na ultima posicao
1526:     * Legado: Column5.Text1.Valid - insere blank se ultima linha e CPros preenchido
1527:     *====================================================================
1528:     PROCEDURE GridProdutosDatasValid()
1529:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1530:             RETURN .T.
1531:         ENDIF
1532: 
1533:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1534:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1535:             TRY
1536:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1537:                 GO BOTTOM IN cursor_4c_Itens
1538:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1539:             CATCH TO loException
1540:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1541:             ENDTRY
1542:         ENDIF
1543: 
1544:         RETURN .T.
1545:     ENDPROC
1546: 
1547:     *====================================================================
1548:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1549:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1550:     *====================================================================
1551:     PROCEDURE GridCheckVendavelClick()
1552:         LOCAL loc_oChk
1553:         TRY
1554:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1555:                 loc_oChk = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1 ;
1556:                     .grd_4c_Produtos.Column6.chk_4c_Vendavel
1557:                 IF VARTYPE(loc_oChk) = "O"
1558:                     REPLACE cursor_4c_Itens.Vendavels WITH IIF(loc_oChk.Value = 1, 1, 0)
1559:                 ENDIF
1560:             ENDIF
1561:         CATCH TO loException
1562:             MostrarErro(loException, "FormPrm.GridCheckVendavelClick")
1563:         ENDTRY
1564:     ENDPROC
1565: 
1566:     *====================================================================
1567:     * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
1568:     * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
1569:     *====================================================================
1570:     PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1571:         LOCAL loc_oPg2

*-- Linhas 1599 a 1639:
1599:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1600: 
1601:         IF FOUND()
1602:             loc_oPgP.grd_4c_Produtos.Refresh
1603:         ENDIF
1604: 
1605:         RETURN .T.
1606:     ENDPROC
1607: 
1608:     *====================================================================
1609:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1610:     * Legado: getBusca.LostFocus - focus col_CPros
1611:     *====================================================================
1612:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1613:         LOCAL loc_oPgP
1614:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1615: 
1616:         IF PEMSTATUS(loc_oPgP, "grd_4c_Produtos", 5)
1617:             loc_oPgP.grd_4c_Produtos.SetFocus
1618:             loc_oPgP.grd_4c_Produtos.ActiveColumn = 1
1619:             loc_oPgP.grd_4c_Produtos.Refresh
1620:         ENDIF
1621:     ENDPROC
1622: 
1623:     *====================================================================
1624:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1625:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1626:     *====================================================================
1627:     PROCEDURE BtnApagarItemClick()
1628:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1629:         loc_lAbortou = .F.
1630: 
1631:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1632:             RETURN
1633:         ENDIF
1634: 
1635:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1636:             RETURN
1637:         ENDIF
1638: 
1639:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)

*-- Linhas 1656 a 1682:
1656:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1657:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1658:                 ENDIF
1659:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1660:             ENDIF
1661:         CATCH TO loException
1662:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1663:         ENDTRY
1664:     ENDPROC
1665: 
1666:     *====================================================================
1667:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1668:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1669:     *====================================================================
1670:     PROCEDURE ValidarColecao()
1671:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1672: 
1673:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1674:             RETURN .T.
1675:         ENDIF
1676: 
1677:         loc_cColecoes = ALLTRIM(cursor_4c_Grupos.Colecoes)
1678: 
1679:         IF EMPTY(loc_cColecoes)
1680:             RETURN .T.
1681:         ENDIF
1682: 

*-- Linhas 1719 a 1765:
1719:             MostrarErro(loException, "FormPrm.ValidarColecao")
1720:         ENDTRY
1721: 
1722:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1723:         RETURN .T.
1724:     ENDPROC
1725: 
1726:     *====================================================================
1727:     * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
1728:     * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
1729:     *====================================================================
1730:     PROCEDURE ValidarDataGrupo()
1731:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1732:             RETURN .T.
1733:         ENDIF
1734: 
1735:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1736:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1737:             TRY
1738:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1739:                 GO BOTTOM IN cursor_4c_Grupos
1740:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1741:             CATCH TO loException
1742:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1743:             ENDTRY
1744:         ENDIF
1745: 
1746:         RETURN .T.
1747:     ENDPROC
1748: 
1749:     *====================================================================
1750:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1751:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1752:     *====================================================================
1753:     PROCEDURE BtnApagarGrupoClick()
1754:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1755:         loc_lAbortou = .F.
1756: 
1757:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1758:             RETURN
1759:         ENDIF
1760: 
1761:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1762:             RETURN
1763:         ENDIF
1764: 
1765:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)

*-- Linhas 1782 a 1800:
1782:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1783:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1784:                 ENDIF
1785:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1786:             ENDIF
1787:         CATCH TO loException
1788:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1789:         ENDTRY
1790:     ENDPROC
1791: 
1792:     *====================================================================
1793:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1794:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1795:     *====================================================================
1796:     PROCEDURE GradesActivate()
1797:         LOCAL loc_cPromos, loc_oPg2
1798:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1799:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1800: 

*-- Linhas 1810 a 1819:
1810:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1811:                     VALUES (loc_cPromos, DATETIME())
1812:             ENDIF
1813:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1814:         CATCH TO loException
1815:             MostrarErro(loException, "FormPrm.GradesActivate")
1816:         ENDTRY
1817:     ENDPROC
1818: 
1819: ENDDEFINE

