# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1236: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1392: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS GRID (1837 linhas total):

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

*-- Linhas 972 a 991:
972:             THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
973:         ENDIF
974:         TRY
975:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
976:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
977:         CATCH TO loException
978:             MostrarErro(loException, "FormPrm.BOParaForm")
979:         ENDTRY
980:     ENDPROC
981: 
982:     *====================================================================
983:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
984:     *====================================================================
985:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
986:         LOCAL loc_oPg2
987:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
988: 
989:         *-- Promos e Codigo: editaveis somente em INCLUIR
990:         loc_oPg2.txt_4c_Promos.Enabled = par_lHabilitar AND ;
991:                                           (THIS.this_cModoAtual == "INCLUIR")

*-- Linhas 1008 a 1027:
1008: 
1009:         *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
1010:         IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
1011:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
1012:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
1013:             loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
1014:             loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
1015:         ENDIF
1016:     ENDPROC
1017: 
1018:     *====================================================================
1019:     * LimparCampos - Limpa valores de todos os campos da Page2
1020:     *====================================================================
1021:     PROTECTED PROCEDURE LimparCampos()
1022:         LOCAL loc_oPg2
1023:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1024: 
1025:         loc_oPg2.txt_4c_Promos.Value    = ""
1026:         loc_oPg2.txt_4c_Codigo.Value    = ""
1027:         loc_oPg2.chk_4c_Comissao.Value  = 0

*-- Linhas 1039 a 1088:
1039:             USE IN cursor_4c_Grupos
1040:         ENDIF
1041: 
1042:         SET NULL ON
1043:         CREATE CURSOR cursor_4c_Itens ;
1044:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1045:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1046:              PromoPro C(35), Vendavels N(1,0) NULL)
1047:         SET NULL OFF
1048:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1049: 
1050:         SET NULL ON
1051:         CREATE CURSOR cursor_4c_Grupos ;
1052:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1053:         SET NULL OFF
1054:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1055: 
1056:         *-- Reatribuir RecordSource e ControlSources apos recriar cursores (AUTOBIND VFP9)
1057:         TRY
1058:             LOCAL loc_oGridProd, loc_oGridGrp
1059:             loc_oGridProd = loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos
1060:             loc_oGridProd.ColumnCount = 6
1061:             loc_oGridProd.RecordSource              = "cursor_4c_Itens"
1062:             loc_oGridProd.Column1.ControlSource     = "cursor_4c_Itens.CPros"
1063:             loc_oGridProd.Column2.ControlSource     = "cursor_4c_Itens.DPros"
1064:             loc_oGridProd.Column3.ControlSource     = "cursor_4c_Itens.Pecas"
1065:             loc_oGridProd.Column4.ControlSource     = "cursor_4c_Itens.CBars"
1066:             loc_oGridProd.Column5.ControlSource     = "cursor_4c_Itens.Datas"
1067:             loc_oGridProd.Column6.ControlSource     = "cursor_4c_Itens.Vendavels"
1068:             loc_oGridProd.Column6.chk_4c_Vendavel.ControlSource = "cursor_4c_Itens.Vendavels"
1069:             loc_oGridProd.Refresh
1070: 
1071:             loc_oGridGrp = loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos
1072:             loc_oGridGrp.ColumnCount = 2
1073:             loc_oGridGrp.RecordSource           = "cursor_4c_Grupos"
1074:             loc_oGridGrp.Column1.ControlSource  = "cursor_4c_Grupos.Colecoes"
1075:             loc_oGridGrp.Column2.ControlSource  = "cursor_4c_Grupos.Datas"
1076:             loc_oGridGrp.Refresh
1077:         CATCH TO loException
1078:             MostrarErro(loException, "FormPrm.LimparCampos")
1079:         ENDTRY
1080:     ENDPROC
1081: 
1082:     *====================================================================
1083:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1084:     *====================================================================
1085:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1086:         LOCAL loc_oPg2
1087:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1088: 

*-- Linhas 1121 a 1139:
1121:         *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
1122:         THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
1123:         TRY
1124:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1125:         CATCH TO loException
1126:             MostrarErro(loException, "FormPrm.ValidarPromos")
1127:         ENDTRY
1128:     ENDPROC
1129: 
1130:     *====================================================================
1131:     * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
1132:     * Substitui fwBuscaExt para SigCdLpc
1133:     *====================================================================
1134:     PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
1135:         LOCAL loc_oPg2, loc_cLPrecos, loc_oBusca
1136:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1137:         loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
1138: 
1139:         IF EMPTY(loc_cLPrecos)

*-- Linhas 1203 a 1298:
1203:     ENDPROC
1204: 
1205:     *====================================================================
1206:     * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
1207:     * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
1208:     *====================================================================
1209:     PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
1210:         LOCAL loc_oGrid
1211: 
1212:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1213:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1214:         WITH loc_oGrid
1215:             .Top             = 3
1216:             .Left            = 8
1217:             .Width           = 742
1218:             .Height          = 220
1219:             .ColumnCount     = 6
1220:             .FontName        = "Tahoma"
1221:             .FontSize        = 8
1222:             .ForeColor       = RGB(90, 90, 90)
1223:             .BackColor       = RGB(255, 255, 255)
1224:             .GridLineColor   = RGB(238, 238, 238)
1225:             .GridLines       = 3
1226:             .HighlightStyle  = 2
1227:             .DeleteMark      = .F.
1228:             .RecordMark      = .F.
1229:             .RowHeight       = 18
1230:             .ScrollBars      = 3
1231:             .ReadOnly        = .F.
1232:         ENDWITH
1233: 
1234:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1235:         loc_oGrid.ColumnCount = 6
1236:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1237: 
1238:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1239:         WITH loc_oGrid.Column1
1240:             .ControlSource   = "cursor_4c_Itens.CPros"
1241:             .Width           = 100
1242:             .Sparse          = .F.
1243:             .Header1.Caption = ""
1244:         ENDWITH
1245:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1246: 
1247:         WITH loc_oGrid.Column2
1248:             .ControlSource   = "cursor_4c_Itens.DPros"
1249:             .Width           = 200
1250:             .ReadOnly        = .T.
1251:             .Sparse          = .F.
1252:             .Header1.Caption = ""
1253:         ENDWITH
1254: 
1255:         WITH loc_oGrid.Column3
1256:             .ControlSource   = "cursor_4c_Itens.Pecas"
1257:             .Width           = 70
1258:             .Sparse          = .F.
1259:             .Header1.Caption = ""
1260:         ENDWITH
1261: 
1262:         WITH loc_oGrid.Column4
1263:             .ControlSource   = "cursor_4c_Itens.CBars"
1264:             .Width           = 80
1265:             .Sparse          = .F.
1266:             .ReadOnly        = .T.
1267:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1268:         ENDWITH
1269: 
1270:         WITH loc_oGrid.Column5
1271:             .ControlSource   = "cursor_4c_Itens.Datas"
1272:             .Width           = 80
1273:             .Sparse          = .F.
1274:             .Header1.Caption = "Data Inicial"
1275:         ENDWITH
1276:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1277: 
1278:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1279:         WITH loc_oGrid.Column6
1280:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1281:             .Width           = 35
1282:             .Sparse          = .F.
1283:             .Header1.Caption = "V"
1284:             .AddObject("chk_4c_Vendavel", "CheckBox")
1285:             WITH .chk_4c_Vendavel
1286:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1287:                 .Caption       = ""
1288:                 .Alignment     = 0
1289:                 .ReadOnly      = .F.
1290:                 .Visible       = .T.
1291:                 .Top           = 9
1292:                 .Left          = 2
1293:                 .Height        = 17
1294:                 .Width         = 22
1295:             ENDWITH
1296:             .CurrentControl  = "chk_4c_Vendavel"
1297:         ENDWITH
1298:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")

*-- Linhas 1359 a 1422:
1359:     ENDPROC
1360: 
1361:     *====================================================================
1362:     * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
1363:     * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
1364:     *====================================================================
1365:     PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
1366:         LOCAL loc_oGrid
1367: 
1368:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1369:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1370:         WITH loc_oGrid
1371:             .Top             = 24
1372:             .Left            = 256
1373:             .Width           = 192
1374:             .Height          = 324
1375:             .ColumnCount     = 2
1376:             .FontName        = "Tahoma"
1377:             .FontSize        = 8
1378:             .ForeColor       = RGB(90, 90, 90)
1379:             .BackColor       = RGB(255, 255, 255)
1380:             .GridLineColor   = RGB(238, 238, 238)
1381:             .GridLines       = 3
1382:             .HighlightStyle  = 2
1383:             .DeleteMark      = .F.
1384:             .RecordMark      = .F.
1385:             .RowHeight       = 18
1386:             .ScrollBars      = 3
1387:             .ReadOnly        = .F.
1388:         ENDWITH
1389: 
1390:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1391:         loc_oGrid.ColumnCount = 2
1392:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1393: 
1394:         *-- ControlSources e Headers APOS RecordSource
1395:         WITH loc_oGrid.Column1
1396:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1397:             .Width           = 80
1398:             .Sparse          = .F.
1399:             .Header1.Caption = "Grp. Venda"
1400:         ENDWITH
1401:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1402: 
1403:         WITH loc_oGrid.Column2
1404:             .ControlSource   = "cursor_4c_Grupos.Datas"
1405:             .Width           = 80
1406:             .Sparse          = .F.
1407:             .Header1.Caption = "Data Inicial"
1408:         ENDWITH
1409:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1410: 
1411:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1412:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1413:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1414:             .Caption      = "Apagar"
1415:             .Top          = 161
1416:             .Left         = 451
1417:             .Width        = 50
1418:             .Height       = 50
1419:             .FontName     = "Tahoma"
1420:             .FontSize     = 8
1421:             .MousePointer = 15
1422:             .Visible      = .T.

*-- Linhas 1472 a 1490:
1472:     ENDPROC
1473: 
1474:     *====================================================================
1475:     * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
1476:     * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
1477:     * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
1478:     *====================================================================
1479:     PROCEDURE ValidarProdutoCodigo()
1480:         LOCAL loc_cCpros, loc_oBusca
1481: 
1482:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1483:             RETURN .T.
1484:         ENDIF
1485: 
1486:         loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)
1487: 
1488:         IF EMPTY(loc_cCpros)
1489:             REPLACE cursor_4c_Itens.DPros WITH ""
1490:             REPLACE cursor_4c_Itens.CBars WITH 0

*-- Linhas 1534 a 1588:
1534:             ENDIF
1535:         ENDTRY
1536: 
1537:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1538:         RETURN .T.
1539:     ENDPROC
1540: 
1541:     *====================================================================
1542:     * GridProdutosDatasValid - Column5 Valid: adiciona linha na ultima posicao
1543:     * Legado: Column5.Text1.Valid - insere blank se ultima linha e CPros preenchido
1544:     *====================================================================
1545:     PROCEDURE GridProdutosDatasValid()
1546:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1547:             RETURN .T.
1548:         ENDIF
1549: 
1550:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1551:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1552:             TRY
1553:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1554:                 GO BOTTOM IN cursor_4c_Itens
1555:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1556:             CATCH TO loException
1557:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1558:             ENDTRY
1559:         ENDIF
1560: 
1561:         RETURN .T.
1562:     ENDPROC
1563: 
1564:     *====================================================================
1565:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1566:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1567:     *====================================================================
1568:     PROCEDURE GridCheckVendavelClick()
1569:         LOCAL loc_oChk
1570:         TRY
1571:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1572:                 loc_oChk = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1 ;
1573:                     .grd_4c_Produtos.Column6.chk_4c_Vendavel
1574:                 IF VARTYPE(loc_oChk) = "O"
1575:                     REPLACE cursor_4c_Itens.Vendavels WITH IIF(loc_oChk.Value = 1, 1, 0)
1576:                 ENDIF
1577:             ENDIF
1578:         CATCH TO loException
1579:             MostrarErro(loException, "FormPrm.GridCheckVendavelClick")
1580:         ENDTRY
1581:     ENDPROC
1582: 
1583:     *====================================================================
1584:     * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
1585:     * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
1586:     *====================================================================
1587:     PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1588:         LOCAL loc_oPg2

*-- Linhas 1616 a 1656:
1616:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1617: 
1618:         IF FOUND()
1619:             loc_oPgP.grd_4c_Produtos.Refresh
1620:         ENDIF
1621: 
1622:         RETURN .T.
1623:     ENDPROC
1624: 
1625:     *====================================================================
1626:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1627:     * Legado: getBusca.LostFocus - focus col_CPros
1628:     *====================================================================
1629:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1630:         LOCAL loc_oPgP
1631:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1632: 
1633:         IF PEMSTATUS(loc_oPgP, "grd_4c_Produtos", 5)
1634:             loc_oPgP.grd_4c_Produtos.SetFocus
1635:             loc_oPgP.grd_4c_Produtos.ActiveColumn = 1
1636:             loc_oPgP.grd_4c_Produtos.Refresh
1637:         ENDIF
1638:     ENDPROC
1639: 
1640:     *====================================================================
1641:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1642:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1643:     *====================================================================
1644:     PROCEDURE BtnApagarItemClick()
1645:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1646:         loc_lAbortou = .F.
1647: 
1648:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1649:             RETURN
1650:         ENDIF
1651: 
1652:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1653:             RETURN
1654:         ENDIF
1655: 
1656:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)

*-- Linhas 1673 a 1699:
1673:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1674:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1675:                 ENDIF
1676:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1677:             ENDIF
1678:         CATCH TO loException
1679:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1680:         ENDTRY
1681:     ENDPROC
1682: 
1683:     *====================================================================
1684:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1685:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1686:     *====================================================================
1687:     PROCEDURE ValidarColecao()
1688:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1689: 
1690:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1691:             RETURN .T.
1692:         ENDIF
1693: 
1694:         loc_cColecoes = ALLTRIM(cursor_4c_Grupos.Colecoes)
1695: 
1696:         IF EMPTY(loc_cColecoes)
1697:             RETURN .T.
1698:         ENDIF
1699: 

*-- Linhas 1737 a 1783:
1737:             MostrarErro(loException, "FormPrm.ValidarColecao")
1738:         ENDTRY
1739: 
1740:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1741:         RETURN .T.
1742:     ENDPROC
1743: 
1744:     *====================================================================
1745:     * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
1746:     * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
1747:     *====================================================================
1748:     PROCEDURE ValidarDataGrupo()
1749:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1750:             RETURN .T.
1751:         ENDIF
1752: 
1753:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1754:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1755:             TRY
1756:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1757:                 GO BOTTOM IN cursor_4c_Grupos
1758:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1759:             CATCH TO loException
1760:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1761:             ENDTRY
1762:         ENDIF
1763: 
1764:         RETURN .T.
1765:     ENDPROC
1766: 
1767:     *====================================================================
1768:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1769:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1770:     *====================================================================
1771:     PROCEDURE BtnApagarGrupoClick()
1772:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1773:         loc_lAbortou = .F.
1774: 
1775:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1776:             RETURN
1777:         ENDIF
1778: 
1779:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1780:             RETURN
1781:         ENDIF
1782: 
1783:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)

*-- Linhas 1800 a 1818:
1800:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1801:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1802:                 ENDIF
1803:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1804:             ENDIF
1805:         CATCH TO loException
1806:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1807:         ENDTRY
1808:     ENDPROC
1809: 
1810:     *====================================================================
1811:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1812:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1813:     *====================================================================
1814:     PROCEDURE GradesActivate()
1815:         LOCAL loc_cPromos, loc_oPg2
1816:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1817:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1818: 

*-- Linhas 1828 a 1837:
1828:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1829:                     VALUES (loc_cPromos, DATETIME())
1830:             ENDIF
1831:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1832:         CATCH TO loException
1833:             MostrarErro(loException, "FormPrm.GradesActivate")
1834:         ENDTRY
1835:     ENDPROC
1836: 
1837: ENDDEFINE

