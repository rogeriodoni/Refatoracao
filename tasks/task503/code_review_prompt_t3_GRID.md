# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1233: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1389: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS GRID (1820 linhas total):

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

*-- Linhas 1039 a 1074:
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
1056:         *-- Atualizar grids com cursores limpos
1057:         TRY
1058:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1059:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1060:         CATCH TO loException
1061:             MostrarErro(loException, "FormPrm.LimparCampos")
1062:         ENDTRY
1063:     ENDPROC
1064: 
1065:     *====================================================================
1066:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1067:     *====================================================================
1068:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1069:         LOCAL loc_oPg2
1070:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1071: 
1072:         DO CASE
1073:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1074:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

*-- Linhas 1104 a 1122:
1104:         *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
1105:         THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
1106:         TRY
1107:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1108:         CATCH TO loException
1109:             MostrarErro(loException, "FormPrm.ValidarPromos")
1110:         ENDTRY
1111:     ENDPROC
1112: 
1113:     *====================================================================
1114:     * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
1115:     * Substitui fwBuscaExt para SigCdLpc
1116:     *====================================================================
1117:     PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
1118:         LOCAL loc_oPg2, loc_cLPrecos, loc_oBusca
1119:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1120:         loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
1121: 
1122:         IF EMPTY(loc_cLPrecos)

*-- Linhas 1186 a 1281:
1186:     ENDPROC
1187: 
1188:     *====================================================================
1189:     * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
1190:     * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
1191:     *====================================================================
1192:     PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
1193:         LOCAL loc_oGrid
1194: 
1195:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1196:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1197:         WITH loc_oGrid
1198:             .Top             = 3
1199:             .Left            = 8
1200:             .Width           = 742
1201:             .Height          = 220
1202:             .ColumnCount     = 6
1203:             .FontName        = "Tahoma"
1204:             .FontSize        = 8
1205:             .ForeColor       = RGB(90, 90, 90)
1206:             .BackColor       = RGB(255, 255, 255)
1207:             .GridLineColor   = RGB(238, 238, 238)
1208:             .GridLines       = 3
1209:             .HighlightStyle  = 2
1210:             .DeleteMark      = .F.
1211:             .RecordMark      = .F.
1212:             .RowHeight       = 18
1213:             .ScrollBars      = 3
1214:             .ReadOnly        = .F.
1215:         ENDWITH
1216: 
1217:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1218:         loc_oGrid.ColumnCount = 6
1219:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1220: 
1221:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1222:         WITH loc_oGrid.Column1
1223:             .ControlSource   = "cursor_4c_Itens.CPros"
1224:             .Width           = 100
1225:             .Sparse          = .F.
1226:             .Header1.Caption = ""
1227:         ENDWITH
1228:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1229: 
1230:         WITH loc_oGrid.Column2
1231:             .ControlSource   = "cursor_4c_Itens.DPros"
1232:             .Width           = 200
1233:             .ReadOnly        = .T.
1234:             .Sparse          = .F.
1235:             .Header1.Caption = ""
1236:         ENDWITH
1237: 
1238:         WITH loc_oGrid.Column3
1239:             .ControlSource   = "cursor_4c_Itens.Pecas"
1240:             .Width           = 70
1241:             .Sparse          = .F.
1242:             .Header1.Caption = ""
1243:         ENDWITH
1244: 
1245:         WITH loc_oGrid.Column4
1246:             .ControlSource   = "cursor_4c_Itens.CBars"
1247:             .Width           = 80
1248:             .Sparse          = .F.
1249:             .ReadOnly        = .T.
1250:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1251:         ENDWITH
1252: 
1253:         WITH loc_oGrid.Column5
1254:             .ControlSource   = "cursor_4c_Itens.Datas"
1255:             .Width           = 80
1256:             .Sparse          = .F.
1257:             .Header1.Caption = "Data Inicial"
1258:         ENDWITH
1259:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1260: 
1261:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1262:         WITH loc_oGrid.Column6
1263:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1264:             .Width           = 35
1265:             .Sparse          = .F.
1266:             .Header1.Caption = "V"
1267:             .AddObject("chk_4c_Vendavel", "CheckBox")
1268:             WITH .chk_4c_Vendavel
1269:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1270:                 .Caption       = ""
1271:                 .Alignment     = 0
1272:                 .ReadOnly      = .F.
1273:                 .Visible       = .T.
1274:                 .Top           = 9
1275:                 .Left          = 2
1276:                 .Height        = 17
1277:                 .Width         = 22
1278:             ENDWITH
1279:             .CurrentControl  = "chk_4c_Vendavel"
1280:         ENDWITH
1281:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")

*-- Linhas 1342 a 1405:
1342:     ENDPROC
1343: 
1344:     *====================================================================
1345:     * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
1346:     * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
1347:     *====================================================================
1348:     PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
1349:         LOCAL loc_oGrid
1350: 
1351:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1352:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1353:         WITH loc_oGrid
1354:             .Top             = 24
1355:             .Left            = 256
1356:             .Width           = 192
1357:             .Height          = 324
1358:             .ColumnCount     = 2
1359:             .FontName        = "Tahoma"
1360:             .FontSize        = 8
1361:             .ForeColor       = RGB(90, 90, 90)
1362:             .BackColor       = RGB(255, 255, 255)
1363:             .GridLineColor   = RGB(238, 238, 238)
1364:             .GridLines       = 3
1365:             .HighlightStyle  = 2
1366:             .DeleteMark      = .F.
1367:             .RecordMark      = .F.
1368:             .RowHeight       = 18
1369:             .ScrollBars      = 3
1370:             .ReadOnly        = .F.
1371:         ENDWITH
1372: 
1373:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1374:         loc_oGrid.ColumnCount = 2
1375:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1376: 
1377:         *-- ControlSources e Headers APOS RecordSource
1378:         WITH loc_oGrid.Column1
1379:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1380:             .Width           = 80
1381:             .Sparse          = .F.
1382:             .Header1.Caption = "Grp. Venda"
1383:         ENDWITH
1384:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1385: 
1386:         WITH loc_oGrid.Column2
1387:             .ControlSource   = "cursor_4c_Grupos.Datas"
1388:             .Width           = 80
1389:             .Sparse          = .F.
1390:             .Header1.Caption = "Data Inicial"
1391:         ENDWITH
1392:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1393: 
1394:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1395:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1396:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1397:             .Caption      = "Apagar"
1398:             .Top          = 161
1399:             .Left         = 451
1400:             .Width        = 50
1401:             .Height       = 50
1402:             .FontName     = "Tahoma"
1403:             .FontSize     = 8
1404:             .MousePointer = 15
1405:             .Visible      = .T.

*-- Linhas 1455 a 1473:
1455:     ENDPROC
1456: 
1457:     *====================================================================
1458:     * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
1459:     * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
1460:     * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
1461:     *====================================================================
1462:     PROCEDURE ValidarProdutoCodigo()
1463:         LOCAL loc_cCpros, loc_oBusca
1464: 
1465:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1466:             RETURN .T.
1467:         ENDIF
1468: 
1469:         loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)
1470: 
1471:         IF EMPTY(loc_cCpros)
1472:             REPLACE cursor_4c_Itens.DPros WITH ""
1473:             REPLACE cursor_4c_Itens.CBars WITH 0

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

*-- Linhas 1720 a 1766:
1720:             MostrarErro(loException, "FormPrm.ValidarColecao")
1721:         ENDTRY
1722: 
1723:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1724:         RETURN .T.
1725:     ENDPROC
1726: 
1727:     *====================================================================
1728:     * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
1729:     * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
1730:     *====================================================================
1731:     PROCEDURE ValidarDataGrupo()
1732:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1733:             RETURN .T.
1734:         ENDIF
1735: 
1736:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1737:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1738:             TRY
1739:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1740:                 GO BOTTOM IN cursor_4c_Grupos
1741:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1742:             CATCH TO loException
1743:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1744:             ENDTRY
1745:         ENDIF
1746: 
1747:         RETURN .T.
1748:     ENDPROC
1749: 
1750:     *====================================================================
1751:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1752:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1753:     *====================================================================
1754:     PROCEDURE BtnApagarGrupoClick()
1755:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1756:         loc_lAbortou = .F.
1757: 
1758:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1759:             RETURN
1760:         ENDIF
1761: 
1762:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1763:             RETURN
1764:         ENDIF
1765: 
1766:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)

*-- Linhas 1783 a 1801:
1783:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1784:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1785:                 ENDIF
1786:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1787:             ENDIF
1788:         CATCH TO loException
1789:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1790:         ENDTRY
1791:     ENDPROC
1792: 
1793:     *====================================================================
1794:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1795:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1796:     *====================================================================
1797:     PROCEDURE GradesActivate()
1798:         LOCAL loc_cPromos, loc_oPg2
1799:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1800:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1801: 

*-- Linhas 1811 a 1820:
1811:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1812:                     VALUES (loc_cPromos, DATETIME())
1813:             ENDIF
1814:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1815:         CATCH TO loException
1816:             MostrarErro(loException, "FormPrm.GradesActivate")
1817:         ENDTRY
1818:     ENDPROC
1819: 
1820: ENDDEFINE

