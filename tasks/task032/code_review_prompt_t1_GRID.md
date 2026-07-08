# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (3)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1140: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1247: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1346: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg) - TRECHOS RELEVANTES PARA PASS GRID (2212 linhas total):

*-- Linhas 1080 a 1098:
1080: 
1081:     *--------------------------------------------------------------------------
1082:     * ConfigurarGrids - Cria os tres grids apos cursores ja carregados
1083:     * grd_4c_Emps (Empresas), grd_4c_Tipo (Operacoes), grd_4c_Cla (Classificacoes)
1084:     *--------------------------------------------------------------------------
1085:     PROTECTED PROCEDURE ConfigurarGrids()
1086:         LOCAL loc_oPg1, loc_oGrd
1087:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1088: 
1089:         *======================================================================
1090:         *-- GRID EMPRESAS
1091:         *======================================================================
1092:         loc_oPg1.AddObject("lbl_4c_Label1", "Label")
1093:         WITH loc_oPg1.lbl_4c_Label1
1094:             .Top       = 181
1095:             .Left      = 24
1096:             .Width     = 60
1097:             .Height    = 15
1098:             .Caption   = "Empresas"

*-- Linhas 1119 a 1207:
1119:         ENDWITH
1120:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaEmp, "Click", THIS, "MarcaEmpClick")
1121: 
1122:         loc_oPg1.AddObject("grd_4c_Emps", "Grid")
1123:         loc_oGrd = loc_oPg1.grd_4c_Emps
1124:         WITH loc_oGrd
1125:             .Top               = 197
1126:             .Left              = 24
1127:             .Width             = 331
1128:             .Height            = 394
1129:             .ColumnCount       = 3
1130:             .FontName          = "Tahoma"
1131:             .FontSize          = 8
1132:             .AllowHeaderSizing = .F.
1133:             .AllowRowSizing    = .F.
1134:             .DeleteMark        = .F.
1135:             .RecordMark        = .F.
1136:             .RowHeight         = 17
1137:             .ScrollBars        = 2
1138:             .GridLineColor     = RGB(238, 238, 238)
1139:             .ReadOnly          = .F.
1140:             .RecordSource      = "cursor_4c_SigCdEmp"
1141:             .Visible           = .T.
1142:         ENDWITH
1143: 
1144:         WITH loc_oGrd.Column1
1145:             .Width         = 17
1146:             .ControlSource = "cursor_4c_SigCdEmp.Imps"
1147:             .FontName      = "Courier New"
1148:             .Movable       = .F.
1149:             .Resizable     = .F.
1150:             .ReadOnly      = .F.
1151:             .Sparse        = .F.
1152:         ENDWITH
1153:         loc_oGrd.Column1.Header1.Caption  = ""
1154:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1155:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
1156:         WITH loc_oGrd.Column1.Check1
1157:             .Alignment = 0
1158:             .Caption   = ""
1159:             .AutoSize  = .T.
1160:             .BackStyle = 0
1161:             .Visible   = .T.
1162:         ENDWITH
1163:         loc_oGrd.Column1.CurrentControl = "Check1"
1164:         BINDEVENT(loc_oGrd.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
1165:         BINDEVENT(loc_oGrd.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
1166:         BINDEVENT(loc_oGrd.Column1.Check1, "Click",     THIS, "EmpCheckClick")
1167:         BINDEVENT(loc_oGrd.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")
1168: 
1169:         WITH loc_oGrd.Column2
1170:             .Width         = 27
1171:             .ControlSource = "cursor_4c_SigCdEmp.cEmps"
1172:             .FontName      = "Courier New"
1173:             .Movable       = .F.
1174:             .Resizable     = .F.
1175:             .ReadOnly      = .T.
1176:         ENDWITH
1177:         loc_oGrd.Column2.Header1.Caption   = "Emp."
1178:         loc_oGrd.Column2.Header1.Alignment = 2
1179:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1180:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1181: 
1182:         WITH loc_oGrd.Column3
1183:             .Width         = 263
1184:             .ControlSource = "cursor_4c_SigCdEmp.Razas"
1185:             .FontName      = "Courier New"
1186:             .Movable       = .F.
1187:             .Resizable     = .F.
1188:             .ReadOnly      = .T.
1189:         ENDWITH
1190:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1191:         loc_oGrd.Column3.Header1.Alignment = 2
1192:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1193:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1194: 
1195:         *======================================================================
1196:         *-- GRID OPERACOES DE TITULO
1197:         *======================================================================
1198:         loc_oPg1.AddObject("lbl_4c_Label4", "Label")
1199:         WITH loc_oPg1.lbl_4c_Label4
1200:             .Top       = 181
1201:             .Left      = 369
1202:             .Width     = 120
1203:             .Height    = 15
1204:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulo"
1205:             .FontName  = "Tahoma"
1206:             .FontSize  = 8
1207:             .FontBold  = .T.

*-- Linhas 1225 a 1278:
1225:         ENDWITH
1226:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaOpe, "Click", THIS, "MarcaOpeClick")
1227: 
1228:         loc_oPg1.AddObject("grd_4c_Tipo", "Grid")
1229:         loc_oGrd = loc_oPg1.grd_4c_Tipo
1230:         WITH loc_oGrd
1231:             .Top               = 197
1232:             .Left              = 369
1233:             .Width             = 323
1234:             .Height            = 394
1235:             .ColumnCount       = 2
1236:             .FontName          = "Tahoma"
1237:             .FontSize          = 8
1238:             .AllowHeaderSizing = .F.
1239:             .AllowRowSizing    = .F.
1240:             .DeleteMark        = .F.
1241:             .RecordMark        = .F.
1242:             .HeaderHeight      = 17
1243:             .RowHeight         = 17
1244:             .ScrollBars        = 2
1245:             .GridLineColor     = RGB(238, 238, 238)
1246:             .ReadOnly          = .F.
1247:             .RecordSource      = "cursor_4c_SigOpOpe"
1248:             .Visible           = .T.
1249:         ENDWITH
1250: 
1251:         WITH loc_oGrd.Column1
1252:             .Width         = 17
1253:             .ControlSource = "cursor_4c_SigOpOpe.Imps"
1254:             .Alignment     = 0
1255:             .FontName      = "Courier New"
1256:             .Movable       = .F.
1257:             .Resizable     = .F.
1258:             .ReadOnly      = .F.
1259:             .Sparse        = .F.
1260:             .Enabled       = .T.
1261:         ENDWITH
1262:         loc_oGrd.Column1.Header1.Caption  = ""
1263:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1264:         loc_oGrd.Column1.AddObject("check12", "CheckBox")
1265:         WITH loc_oGrd.Column1.check12
1266:             .Alignment = 0
1267:             .Caption   = ""
1268:             .AutoSize  = .T.
1269:             .BackStyle = 0
1270:             .Enabled   = .T.
1271:             .Visible   = .T.
1272:         ENDWITH
1273:         loc_oGrd.Column1.CurrentControl = "check12"
1274:         BINDEVENT(loc_oGrd.Column1.check12, "MouseDown", THIS, "TipoCheckMouseDown")
1275:         BINDEVENT(loc_oGrd.Column1.check12, "MouseUp",   THIS, "TipoCheckMouseUp")
1276:         BINDEVENT(loc_oGrd.Column1.check12, "Click",     THIS, "TipoCheckClick")
1277:         BINDEVENT(loc_oGrd.Column1.check12, "KeyPress",  THIS, "TipoCheckKeyPress")
1278: 

*-- Linhas 1285 a 1305:
1285:             .ReadOnly      = .T.
1286:             .Enabled       = .T.
1287:         ENDWITH
1288:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1289:         loc_oGrd.Column2.Header1.Alignment = 2
1290:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1291:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1292:         loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
1293:         loc_oGrd.Column2.Text1.ReadOnly    = .T.
1294: 
1295:         *======================================================================
1296:         *-- GRID CLASSIFICACOES
1297:         *======================================================================
1298:         loc_oPg1.AddObject("lbl_4c_Label8", "Label")
1299:         WITH loc_oPg1.lbl_4c_Label8
1300:             .Top       = 180
1301:             .Left      = 706
1302:             .Width     = 95
1303:             .Height    = 15
1304:             .Caption   = "Classifica" + CHR(231) + CHR(245) + "es"
1305:             .FontName  = "Tahoma"

*-- Linhas 1325 a 1414:
1325:         ENDWITH
1326:         BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaCla, "Click", THIS, "MarcaClaClick")
1327: 
1328:         loc_oPg1.AddObject("grd_4c_Cla", "Grid")
1329:         loc_oGrd = loc_oPg1.grd_4c_Cla
1330:         WITH loc_oGrd
1331:             .Top               = 197
1332:             .Left              = 706
1333:             .Width             = 574
1334:             .Height            = 394
1335:             .ColumnCount       = 3
1336:             .FontName          = "Tahoma"
1337:             .FontSize          = 8
1338:             .AllowHeaderSizing = .F.
1339:             .AllowRowSizing    = .F.
1340:             .DeleteMark        = .F.
1341:             .RecordMark        = .F.
1342:             .RowHeight         = 17
1343:             .ScrollBars        = 2
1344:             .GridLineColor     = RGB(238, 238, 238)
1345:             .ReadOnly          = .F.
1346:             .RecordSource      = "cursor_4c_SigCdClc"
1347:             .Visible           = .T.
1348:         ENDWITH
1349: 
1350:         WITH loc_oGrd.Column1
1351:             .Width         = 19
1352:             .ControlSource = "cursor_4c_SigCdClc.Imps"
1353:             .FontName      = "Courier New"
1354:             .Movable       = .F.
1355:             .Resizable     = .F.
1356:             .ReadOnly      = .F.
1357:             .Sparse        = .F.
1358:         ENDWITH
1359:         loc_oGrd.Column1.Header1.Caption  = ""
1360:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
1361:         loc_oGrd.Column1.AddObject("check13", "CheckBox")
1362:         WITH loc_oGrd.Column1.check13
1363:             .Alignment = 0
1364:             .Caption   = ""
1365:             .AutoSize  = .T.
1366:             .BackStyle = 0
1367:             .Visible   = .T.
1368:         ENDWITH
1369:         loc_oGrd.Column1.CurrentControl = "check13"
1370:         BINDEVENT(loc_oGrd.Column1.check13, "MouseDown", THIS, "ClaCheckMouseDown")
1371:         BINDEVENT(loc_oGrd.Column1.check13, "MouseUp",   THIS, "ClaCheckMouseUp")
1372:         BINDEVENT(loc_oGrd.Column1.check13, "Click",     THIS, "ClaCheckClick")
1373:         BINDEVENT(loc_oGrd.Column1.check13, "KeyPress",  THIS, "ClaCheckKeyPress")
1374: 
1375:         WITH loc_oGrd.Column2
1376:             .Width         = 80
1377:             .ControlSource = "cursor_4c_SigCdClc.Codigos"
1378:             .FontName      = "Courier New"
1379:             .Movable       = .F.
1380:             .Resizable     = .F.
1381:             .ReadOnly      = .T.
1382:         ENDWITH
1383:         loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
1384:         loc_oGrd.Column2.Header1.Alignment = 2
1385:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
1386:         loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
1387:         loc_oGrd.Column2.Text1.ReadOnly    = .F.
1388: 
1389:         WITH loc_oGrd.Column3
1390:             .Width         = 452
1391:             .ControlSource = "cursor_4c_SigCdClc.Descs"
1392:             .FontName      = "Courier New"
1393:             .Movable       = .F.
1394:             .Resizable     = .F.
1395:             .ReadOnly      = .T.
1396:         ENDWITH
1397:         loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1398:         loc_oGrd.Column3.Header1.Alignment = 2
1399:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
1400:         loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
1401:         loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
1402:         loc_oGrd.Column3.Text1.ReadOnly    = .T.
1403: 
1404:     ENDPROC
1405: 
1406:     *--------------------------------------------------------------------------
1407:     * AtualizarEstadoControles - Report form: sem estado CRUD, ajusta botoes
1408:     *--------------------------------------------------------------------------
1409:     PROCEDURE AtualizarEstadoControles()
1410:         THIS.AjustarBotoesPorModo()
1411:     ENDPROC
1412: 
1413:     *--------------------------------------------------------------------------
1414:     * LimparCampos - Reseta todos os filtros para valores padrao

*-- Linhas 1568 a 1688:
1568:         LOCAL loc_nImps
1569:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaEmp.Value = 1, 1, 0)
1570:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1571:         THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1572:     ENDPROC
1573: 
1574:     PROCEDURE MarcaOpeClick()
1575:         LOCAL loc_nImps
1576:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaOpe.Value = 1, 1, 0)
1577:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1578:         THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1579:     ENDPROC
1580: 
1581:     PROCEDURE MarcaClaClick()
1582:         LOCAL loc_nImps
1583:         loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaCla.Value = 1, 1, 0)
1584:         REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdClc
1585:         THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1586:     ENDPROC
1587: 
1588:     *==========================================================================
1589:     * HANDLERS CHECKBOX DO GRID EMPRESAS
1590:     *==========================================================================
1591: 
1592:     PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1593:         LOCAL loc_nImps
1594:         loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 0, 1, 0)
1595:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1596:         THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1597:         NODEFAULT
1598:     ENDPROC
1599: 
1600:     PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1601:         NODEFAULT
1602:     ENDPROC
1603: 
1604:     PROCEDURE EmpCheckClick()
1605:         NODEFAULT
1606:     ENDPROC
1607: 
1608:     PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1609:         IF INLIST(par_nKeyCode, 13, 32)
1610:             LOCAL loc_nImps
1611:             loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 1, 0, 1)
1612:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
1613:             THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1614:             NODEFAULT
1615:         ENDIF
1616:     ENDPROC
1617: 
1618:     *==========================================================================
1619:     * HANDLERS CHECKBOX DO GRID TIPO (OPERACOES)
1620:     *==========================================================================
1621: 
1622:     PROCEDURE TipoCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1623:         LOCAL loc_nImps
1624:         loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 0, 1, 0)
1625:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1626:         THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1627:         NODEFAULT
1628:     ENDPROC
1629: 
1630:     PROCEDURE TipoCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1631:         NODEFAULT
1632:     ENDPROC
1633: 
1634:     PROCEDURE TipoCheckClick()
1635:         NODEFAULT
1636:     ENDPROC
1637: 
1638:     PROCEDURE TipoCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1639:         IF INLIST(par_nKeyCode, 13, 32)
1640:             LOCAL loc_nImps
1641:             loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 1, 0, 1)
1642:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
1643:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1644:             NODEFAULT
1645:         ENDIF
1646:     ENDPROC
1647: 
1648:     *==========================================================================
1649:     * HANDLERS CHECKBOX DO GRID CLASSIFICACOES
1650:     *==========================================================================
1651: 
1652:     PROCEDURE ClaCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1653:         LOCAL loc_nImps
1654:         loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 0, 1, 0)
1655:         REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
1656:         THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1657:         NODEFAULT
1658:     ENDPROC
1659: 
1660:     PROCEDURE ClaCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1661:         NODEFAULT
1662:     ENDPROC
1663: 
1664:     PROCEDURE ClaCheckClick()
1665:         NODEFAULT
1666:     ENDPROC
1667: 
1668:     PROCEDURE ClaCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1669:         IF INLIST(par_nKeyCode, 13, 32)
1670:             LOCAL loc_nImps
1671:             loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 1, 0, 1)
1672:             REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
1673:             THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
1674:             NODEFAULT
1675:         ENDIF
1676:     ENDPROC
1677: 
1678:     *==========================================================================
1679:     * HANDLERS MODO PAGREC E JUROS
1680:     *==========================================================================
1681: 
1682:     PROCEDURE PagamentosChange()
1683:         LOCAL loc_oPg1
1684:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1685:         IF loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1
1686:             loc_oPg1.chk_4c_Ck_Recebimentos.Value = 0
1687:         ENDIF
1688:         THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;

*-- Linhas 1780 a 1799:
1780:             THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1781:         ELSE
1782:             IF !loc_oForm.this_lAchouRegistro
1783:             loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1784:             loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1785:             loc_oForm.Show()
1786:             IF loc_oForm.this_lSelecionou
1787:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1788:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1789:                 loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1790:                 loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
1791:                 THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
1792:             ELSE
1793:                 THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
1794:                 THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
1795:                 THIS.this_oRelatorio.this_nVlCotacao = 1
1796:             ENDIF
1797:             ENDIF
1798:         ENDIF
1799: 

*-- Linhas 1864 a 1883:
1864:             THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1865:         ELSE
1866:             IF !loc_oForm.this_lAchouRegistro
1867:             loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1868:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1869:             loc_oForm.Show()
1870:             IF loc_oForm.this_lSelecionou
1871:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1872:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1873:             ELSE
1874:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ""
1875:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
1876:             ENDIF
1877:             ENDIF
1878:         ENDIF
1879: 
1880:         IF USED("cursor_4c_BuscaGrupo")
1881:             USE IN cursor_4c_BuscaGrupo
1882:         ENDIF
1883:         loc_oForm.Release()

*-- Linhas 1948 a 1967:
1948:             THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1949:         ELSE
1950:             IF !loc_oForm.this_lAchouRegistro
1951:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1952:             loc_oForm.mAddColuna("RClis", "", "Nome")
1953:             loc_oForm.Show()
1954:             IF loc_oForm.this_lSelecionou
1955:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1956:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1957:             ELSE
1958:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ""
1959:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
1960:             ENDIF
1961:             ENDIF
1962:         ENDIF
1963: 
1964:         IF USED("cursor_4c_BuscaConta")
1965:             USE IN cursor_4c_BuscaConta
1966:         ENDIF
1967:         loc_oForm.Release()

*-- Linhas 2029 a 2048:
2029:             THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
2030:         ELSE
2031:             IF !loc_oForm.this_lAchouRegistro
2032:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2033:             loc_oForm.mAddColuna("RClis", "", "Nome")
2034:             loc_oForm.Show()
2035:             IF loc_oForm.this_lSelecionou
2036:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
2037:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
2038:             ELSE
2039:                 THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
2040:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
2041:             ENDIF
2042:             ENDIF
2043:         ENDIF
2044: 
2045:         IF USED("cursor_4c_BuscaJobs")
2046:             USE IN cursor_4c_BuscaJobs
2047:         ENDIF
2048:         loc_oForm.Release()

*-- Linhas 2058 a 2078:
2058:         LOCAL loc_oPg1
2059:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2060:         THIS.ConfigurarGrids()
2061:         loc_oPg1.grd_4c_Emps.Visible    = .T.
2062:         loc_oPg1.grd_4c_Tipo.Visible    = .T.
2063:         loc_oPg1.grd_4c_Cla.Visible     = .T.
2064:     ENDPROC
2065: 
2066:     *--------------------------------------------------------------------------
2067:     * ConfigurarPaginaDados - Configura conteudo de pagina de dados
2068:     * Em forms REPORT (frmrelatorio) NAO existe Page2 (Dados): todos os
2069:     * filtros estao em Page1 e ja foram configurados por ConfigurarFiltros().
2070:     * Este metodo existe para manter compatibilidade com a API de forms CRUD
2071:     * e satisfaz validacoes do pipeline de migracao multi-fase.
2072:     *--------------------------------------------------------------------------
2073:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2074:         *-- Form REPORT usa layout FLAT com apenas Page1 contendo todos os filtros.
2075:         *-- Os campos de filtro sao adicionados em ConfigurarFiltros() que ja foi
2076:         *-- chamado durante InicializarForm(). Portanto nao ha controles adicionais
2077:         *-- a configurar nesta pagina.
2078:         IF THIS.pgf_4c_Paginas.PageCount >= 1

