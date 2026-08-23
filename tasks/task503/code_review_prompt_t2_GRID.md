# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1231: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1387: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS GRID (1832 linhas total):

*-- Linhas 96 a 137:
96:     * csSigPrPmv: grupos de venda da promocao (edicao em grid)
97:     *====================================================================
98:     PROTECTED PROCEDURE CriarCursoresLocais()
99:         SET NULL ON
100:         CREATE CURSOR csSigPrPmi (CPros c(14), DPros c(40), Pecas c(10), ;
101:             Promos c(25), CBars n(8), Datas d NULL, DtAlts t NULL, ;
102:             PromoPro c(35), Vendavels n(1), cIdChaves c(20))
103:         SELECT csSigPrPmi
104:         INDEX ON CPros TAG CPros
105: 
106:         CREATE CURSOR TcrSigPrPmi (CPros c(14), Datas d NULL, Pecas c(10), Vendavels n(1))
107:         INDEX ON CPros TAG idxTcpros
108: 
109:         CREATE CURSOR csSigPrPmv (Promos c(25), Colecoes c(10), Datas t NULL, cIdChaves c(20))
110:         SELECT csSigPrPmv
111: 
112:         CREATE CURSOR cursor_4c_Itens ;
113:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
114:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
115:              PromoPro C(35), Vendavels N(1,0) NULL)
116:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
117: 
118:         CREATE CURSOR cursor_4c_Grupos ;
119:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
120:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
121: 
122:         SET NULL OFF
123:     ENDPROC
124: 
125:     *====================================================================
126:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
127:     *====================================================================
128:     PROTECTED PROCEDURE ConfigurarPageFrame()
129:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
130:         WITH THIS.pgf_4c_Paginas
131:             .Top       = -29
132:             .Left      = 0
133:             .Width     = THIS.Width
134:             .Height    = THIS.Height + 29
135:             .PageCount = 2
136:             .Tabs      = .F.
137:             .TabStop   = .F.

*-- Linhas 364 a 385:
364:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
365: 
366:         *-- Grid principal: Top=117 (88+29), Width=910 (nao sobrepoem cnt_4c_Saida em Left=917)
367:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
368:         loc_oGrid = loc_oPagina.grd_4c_Lista
369:         loc_oGrid.RecordSource = ""
370:         loc_oGrid.ColumnCount  = 5
371:         WITH loc_oGrid
372:             .Top                = 117
373:             .Left               = 0
374:             .Width              = 910
375:             .Height             = 478
376:             .FontName           = "Verdana"
377:             .FontSize           = 8
378:             .ForeColor          = RGB(90, 90, 90)
379:             .BackColor          = RGB(255, 255, 255)
380:             .GridLineColor      = RGB(238, 238, 238)
381:             .GridLines          = 3
382:             .HighlightBackColor = RGB(255, 255, 255)
383:             .HighlightForeColor = RGB(15, 41, 104)
384:             .HighlightStyle     = 2
385:             .DeleteMark         = .F.

*-- Linhas 643 a 674:
643:                 IF !THIS.this_oBusinessObject.Buscar("")
644:                     loc_lSucesso = .F.
645:                 ELSE
646:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
647:                     loc_oGrid.ColumnCount = 5
648:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
649:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Promos"
650:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cods"
651:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Comiss"
652:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
653:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
654:                     *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
655:                     loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
656:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "d."
657:                     loc_oGrid.Column3.Header1.Caption = "Comiss%"
658:                     loc_oGrid.Column4.Header1.Caption = "e-Com."
659:                     loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
660:                     loc_oGrid.Column3.Alignment = 1
661:                     loc_oGrid.Column4.Alignment = 1
662:                     THIS.FormatarGridLista(loc_oGrid)
663:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
664:                         GO TOP IN cursor_4c_Dados
665:                     ENDIF
666:                     loc_lSucesso = .T.
667:                 ENDIF
668:             CATCH TO loException
669:                 MostrarErro(loException, "FormPrm.CarregarLista")
670:             ENDTRY
671:         ENDIF
672: 
673:         RETURN loc_lSucesso
674:     ENDPROC

*-- Linhas 970 a 989:
970:             THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
971:         ENDIF
972:         TRY
973:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
974:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
975:         CATCH TO loException
976:             MostrarErro(loException, "FormPrm.BOParaForm")
977:         ENDTRY
978:     ENDPROC
979: 
980:     *====================================================================
981:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
982:     *====================================================================
983:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
984:         LOCAL loc_oPg2
985:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
986: 
987:         *-- Promos e Codigo: editaveis somente em INCLUIR
988:         loc_oPg2.txt_4c_Promos.Enabled = par_lHabilitar AND ;
989:                                           (THIS.this_cModoAtual == "INCLUIR")

*-- Linhas 1006 a 1025:
1006: 
1007:         *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
1008:         IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
1009:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
1010:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
1011:             loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
1012:             loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
1013:         ENDIF
1014:     ENDPROC
1015: 
1016:     *====================================================================
1017:     * LimparCampos - Limpa valores de todos os campos da Page2
1018:     *====================================================================
1019:     PROTECTED PROCEDURE LimparCampos()
1020:         LOCAL loc_oPg2
1021:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1022: 
1023:         loc_oPg2.txt_4c_Promos.Value    = ""
1024:         loc_oPg2.txt_4c_Codigo.Value    = ""
1025:         loc_oPg2.chk_4c_Comissao.Value  = 0

*-- Linhas 1037 a 1072:
1037:             USE IN cursor_4c_Grupos
1038:         ENDIF
1039: 
1040:         SET NULL ON
1041:         CREATE CURSOR cursor_4c_Itens ;
1042:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1043:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1044:              PromoPro C(35), Vendavels N(1,0) NULL)
1045:         SET NULL OFF
1046:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1047: 
1048:         SET NULL ON
1049:         CREATE CURSOR cursor_4c_Grupos ;
1050:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1051:         SET NULL OFF
1052:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1053: 
1054:         *-- Atualizar grids com cursores limpos
1055:         TRY
1056:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1057:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1058:         CATCH TO loException
1059:             MostrarErro(loException, "FormPrm.LimparCampos")
1060:         ENDTRY
1061:     ENDPROC
1062: 
1063:     *====================================================================
1064:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1065:     *====================================================================
1066:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1067:         LOCAL loc_oPg2
1068:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1069: 
1070:         DO CASE
1071:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1072:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

*-- Linhas 1102 a 1120:
1102:         *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
1103:         THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
1104:         TRY
1105:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1106:         CATCH TO loException
1107:             MostrarErro(loException, "FormPrm.ValidarPromos")
1108:         ENDTRY
1109:     ENDPROC
1110: 
1111:     *====================================================================
1112:     * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
1113:     * Substitui fwBuscaExt para SigCdLpc
1114:     *====================================================================
1115:     PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
1116:         LOCAL loc_oPg2, loc_cLPrecos, loc_nResult, loc_oBusca
1117:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1118:         loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
1119: 
1120:         IF EMPTY(loc_cLPrecos)

*-- Linhas 1198 a 1293:
1198:     ENDPROC
1199: 
1200:     *====================================================================
1201:     * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
1202:     * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
1203:     *====================================================================
1204:     PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
1205:         LOCAL loc_oGrid
1206: 
1207:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1208:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1209:         WITH loc_oGrid
1210:             .Top             = 3
1211:             .Left            = 8
1212:             .Width           = 742
1213:             .Height          = 220
1214:             .ColumnCount     = 6
1215:             .FontName        = "Tahoma"
1216:             .FontSize        = 8
1217:             .ForeColor       = RGB(90, 90, 90)
1218:             .BackColor       = RGB(255, 255, 255)
1219:             .GridLineColor   = RGB(238, 238, 238)
1220:             .GridLines       = 3
1221:             .HighlightStyle  = 2
1222:             .DeleteMark      = .F.
1223:             .RecordMark      = .F.
1224:             .RowHeight       = 18
1225:             .ScrollBars      = 3
1226:             .ReadOnly        = .F.
1227:         ENDWITH
1228: 
1229:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1230:         loc_oGrid.ColumnCount = 3
1231:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1232: 
1233:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1234:         WITH loc_oGrid.Column1
1235:             .ControlSource   = "cursor_4c_Itens.CPros"
1236:             .Width           = 100
1237:             .Sparse          = .F.
1238:             .Header1.Caption = "Produto"
1239:         ENDWITH
1240:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1241: 
1242:         WITH loc_oGrid.Column2
1243:             .ControlSource   = "cursor_4c_Itens.DPros"
1244:             .Width           = 200
1245:             .ReadOnly        = .T.
1246:             .Sparse          = .F.
1247:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1248:         ENDWITH
1249: 
1250:         WITH loc_oGrid.Column3
1251:             .ControlSource   = "cursor_4c_Itens.Pecas"
1252:             .Width           = 70
1253:             .Sparse          = .F.
1254:             .Header1.Caption = "Pe" + CHR(231) + "a"
1255:         ENDWITH
1256: 
1257:         WITH loc_oGrid.Column4
1258:             .ControlSource   = "cursor_4c_Itens.CBars"
1259:             .Width           = 80
1260:             .Sparse          = .F.
1261:             .ReadOnly        = .T.
1262:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1263:         ENDWITH
1264: 
1265:         WITH loc_oGrid.Column5
1266:             .ControlSource   = "cursor_4c_Itens.Datas"
1267:             .Width           = 80
1268:             .Sparse          = .F.
1269:             .Header1.Caption = "Data Inicial"
1270:         ENDWITH
1271:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1272: 
1273:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1274:         WITH loc_oGrid.Column6
1275:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1276:             .Width           = 35
1277:             .Sparse          = .F.
1278:             .Header1.Caption = "V"
1279:             .AddObject("chk_4c_Vendavel", "CheckBox")
1280:             WITH .chk_4c_Vendavel
1281:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1282:                 .Caption       = ""
1283:                 .Alignment     = 0
1284:                 .ReadOnly      = .F.
1285:                 .Visible       = .T.
1286:                 .Top           = 9
1287:                 .Left          = 2
1288:                 .Height        = 17
1289:                 .Width         = 22
1290:             ENDWITH
1291:             .CurrentControl  = "chk_4c_Vendavel"
1292:         ENDWITH
1293:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")

*-- Linhas 1354 a 1417:
1354:     ENDPROC
1355: 
1356:     *====================================================================
1357:     * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
1358:     * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
1359:     *====================================================================
1360:     PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
1361:         LOCAL loc_oGrid
1362: 
1363:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1364:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1365:         WITH loc_oGrid
1366:             .Top             = 24
1367:             .Left            = 256
1368:             .Width           = 192
1369:             .Height          = 324
1370:             .ColumnCount     = 2
1371:             .FontName        = "Tahoma"
1372:             .FontSize        = 8
1373:             .ForeColor       = RGB(90, 90, 90)
1374:             .BackColor       = RGB(255, 255, 255)
1375:             .GridLineColor   = RGB(238, 238, 238)
1376:             .GridLines       = 3
1377:             .HighlightStyle  = 2
1378:             .DeleteMark      = .F.
1379:             .RecordMark      = .F.
1380:             .RowHeight       = 18
1381:             .ScrollBars      = 3
1382:             .ReadOnly        = .F.
1383:         ENDWITH
1384: 
1385:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1386:         loc_oGrid.ColumnCount = 3
1387:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1388: 
1389:         *-- ControlSources e Headers APOS RecordSource
1390:         WITH loc_oGrid.Column1
1391:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1392:             .Width           = 80
1393:             .Sparse          = .F.
1394:             .Header1.Caption = "Grp. Venda"
1395:         ENDWITH
1396:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1397: 
1398:         WITH loc_oGrid.Column2
1399:             .ControlSource   = "cursor_4c_Grupos.Datas"
1400:             .Width           = 80
1401:             .Sparse          = .F.
1402:             .Header1.Caption = "Data Inicial"
1403:         ENDWITH
1404:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1405: 
1406:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1407:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1408:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1409:             .Caption      = "Apagar"
1410:             .Top          = 161
1411:             .Left         = 451
1412:             .Width        = 50
1413:             .Height       = 50
1414:             .FontName     = "Tahoma"
1415:             .FontSize     = 8
1416:             .MousePointer = 15
1417:             .Visible      = .T.

*-- Linhas 1467 a 1485:
1467:     ENDPROC
1468: 
1469:     *====================================================================
1470:     * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
1471:     * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
1472:     * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
1473:     *====================================================================
1474:     PROCEDURE ValidarProdutoCodigo()
1475:         LOCAL loc_cCpros, loc_oBusca
1476: 
1477:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1478:             RETURN .T.
1479:         ENDIF
1480: 
1481:         loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)
1482: 
1483:         IF EMPTY(loc_cCpros)
1484:             REPLACE cursor_4c_Itens.DPros WITH ""
1485:             REPLACE cursor_4c_Itens.CBars WITH 0

*-- Linhas 1529 a 1583:
1529:             ENDIF
1530:         ENDTRY
1531: 
1532:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1533:         RETURN .T.
1534:     ENDPROC
1535: 
1536:     *====================================================================
1537:     * GridProdutosDatasValid - Column5 Valid: adiciona linha na ultima posicao
1538:     * Legado: Column5.Text1.Valid - insere blank se ultima linha e CPros preenchido
1539:     *====================================================================
1540:     PROCEDURE GridProdutosDatasValid()
1541:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1542:             RETURN .T.
1543:         ENDIF
1544: 
1545:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1546:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1547:             TRY
1548:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1549:                 GO BOTTOM IN cursor_4c_Itens
1550:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1551:             CATCH TO loException
1552:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1553:             ENDTRY
1554:         ENDIF
1555: 
1556:         RETURN .T.
1557:     ENDPROC
1558: 
1559:     *====================================================================
1560:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1561:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1562:     *====================================================================
1563:     PROCEDURE GridCheckVendavelClick()
1564:         LOCAL loc_oChk
1565:         TRY
1566:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1567:                 loc_oChk = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1 ;
1568:                     .grd_4c_Produtos.Column6.chk_4c_Vendavel
1569:                 IF VARTYPE(loc_oChk) = "O"
1570:                     REPLACE cursor_4c_Itens.Vendavels WITH IIF(loc_oChk.Value = 1, 1, 0)
1571:                 ENDIF
1572:             ENDIF
1573:         CATCH TO loException
1574:             MostrarErro(loException, "FormPrm.GridCheckVendavelClick")
1575:         ENDTRY
1576:     ENDPROC
1577: 
1578:     *====================================================================
1579:     * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
1580:     * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
1581:     *====================================================================
1582:     PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1583:         LOCAL loc_oPg2

*-- Linhas 1611 a 1651:
1611:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1612: 
1613:         IF FOUND()
1614:             loc_oPgP.grd_4c_Produtos.Refresh
1615:         ENDIF
1616: 
1617:         RETURN .T.
1618:     ENDPROC
1619: 
1620:     *====================================================================
1621:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1622:     * Legado: getBusca.LostFocus - focus col_CPros
1623:     *====================================================================
1624:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1625:         LOCAL loc_oPgP
1626:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1627: 
1628:         IF PEMSTATUS(loc_oPgP, "grd_4c_Produtos", 5)
1629:             loc_oPgP.grd_4c_Produtos.SetFocus
1630:             loc_oPgP.grd_4c_Produtos.ActiveColumn = 1
1631:             loc_oPgP.grd_4c_Produtos.Refresh
1632:         ENDIF
1633:     ENDPROC
1634: 
1635:     *====================================================================
1636:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1637:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1638:     *====================================================================
1639:     PROCEDURE BtnApagarItemClick()
1640:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1641:         loc_lAbortou = .F.
1642: 
1643:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1644:             RETURN
1645:         ENDIF
1646: 
1647:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1648:             RETURN
1649:         ENDIF
1650: 
1651:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)

*-- Linhas 1668 a 1694:
1668:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1669:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1670:                 ENDIF
1671:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1672:             ENDIF
1673:         CATCH TO loException
1674:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1675:         ENDTRY
1676:     ENDPROC
1677: 
1678:     *====================================================================
1679:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1680:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1681:     *====================================================================
1682:     PROCEDURE ValidarColecao()
1683:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1684: 
1685:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1686:             RETURN .T.
1687:         ENDIF
1688: 
1689:         loc_cColecoes = ALLTRIM(cursor_4c_Grupos.Colecoes)
1690: 
1691:         IF EMPTY(loc_cColecoes)
1692:             RETURN .T.
1693:         ENDIF
1694: 

*-- Linhas 1732 a 1778:
1732:             MostrarErro(loException, "FormPrm.ValidarColecao")
1733:         ENDTRY
1734: 
1735:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1736:         RETURN .T.
1737:     ENDPROC
1738: 
1739:     *====================================================================
1740:     * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
1741:     * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
1742:     *====================================================================
1743:     PROCEDURE ValidarDataGrupo()
1744:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1745:             RETURN .T.
1746:         ENDIF
1747: 
1748:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1749:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1750:             TRY
1751:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1752:                 GO BOTTOM IN cursor_4c_Grupos
1753:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1754:             CATCH TO loException
1755:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1756:             ENDTRY
1757:         ENDIF
1758: 
1759:         RETURN .T.
1760:     ENDPROC
1761: 
1762:     *====================================================================
1763:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1764:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1765:     *====================================================================
1766:     PROCEDURE BtnApagarGrupoClick()
1767:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1768:         loc_lAbortou = .F.
1769: 
1770:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1771:             RETURN
1772:         ENDIF
1773: 
1774:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1775:             RETURN
1776:         ENDIF
1777: 
1778:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)

*-- Linhas 1795 a 1813:
1795:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1796:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1797:                 ENDIF
1798:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1799:             ENDIF
1800:         CATCH TO loException
1801:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1802:         ENDTRY
1803:     ENDPROC
1804: 
1805:     *====================================================================
1806:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1807:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1808:     *====================================================================
1809:     PROCEDURE GradesActivate()
1810:         LOCAL loc_cPromos, loc_oPg2
1811:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1812:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1813: 

*-- Linhas 1823 a 1832:
1823:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1824:                     VALUES (loc_cPromos, DATETIME())
1825:             ENDIF
1826:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1827:         CATCH TO loException
1828:             MostrarErro(loException, "FormPrm.GradesActivate")
1829:         ENDTRY
1830:     ENDPROC
1831: 
1832: ENDDEFINE

