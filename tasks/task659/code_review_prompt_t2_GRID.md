# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1198: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1723: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS GRID (3430 linhas total):

*-- Linhas 1097 a 1116:
1097: 
1098:             IF VARTYPE(loc_oBusca) = "O"
1099:                 IF !loc_oBusca.this_lAchouRegistro
1100:                     loc_oBusca.mAddColuna("Cods",  "", "S" + CHR(233) + "rie")
1101:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1102:                     loc_oBusca.Show()
1103:                 ENDIF
1104: 
1105:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSerie")
1106:                     SELECT cursor_4c_BuscaSerie
1107:                     THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_BuscaSerie.Cods)
1108:                 ENDIF
1109: 
1110:                 IF USED("cursor_4c_BuscaSerie")
1111:                     USE IN cursor_4c_BuscaSerie
1112:                 ENDIF
1113:                 loc_oBusca.Release()
1114:             ENDIF
1115:         CATCH TO loc_oErro
1116:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1133 a 1226:
1133:     * povoado por THIS.CarregarLista() -> sigprnfeBO.BuscarOperacoes().
1134:     * Column.ControlSource exige o cursor JA existir antes do bind (regra
1135:     * #41), por isso a estrutura abaixo e criada ANTES do AddObject do Grid,
1136:     * com os MESMOS nomes/ordem de campos do "Create Cursor csOperacoes" do
1137:     * legado (Processamento/Init).
1138:     *--------------------------------------------------------------------------
1139:     PROTECTED PROCEDURE ConfigurarGrade()
1140:         LOCAL loc_oCnt, loc_oGrd
1141: 
1142:         IF USED("cursor_4c_Operacoes")
1143:             USE IN cursor_4c_Operacoes
1144:         ENDIF
1145:         SET NULL ON
1146:         CREATE CURSOR cursor_4c_Operacoes ( ;
1147:             SelImp   L, ;
1148:             Emps     C(3), ;
1149:             Dopes    C(20), ;
1150:             Numes    N(6), ;
1151:             Datas    D, ;
1152:             Valos    N(12,2), ;
1153:             Notas    C(10), ;
1154:             Series   C(3), ;
1155:             NFMemo   M, ;
1156:             Erros    M, ;
1157:             Tipos    N(1), ;
1158:             stats    C(3), ;
1159:             ids      C(47), ;
1160:             lotes    C(15), ;
1161:             recibos  C(15), ;
1162:             prots    C(15), ;
1163:             statts   C(1))
1164:         SET NULL OFF
1165:         INDEX ON Notas TAG Notas
1166: 
1167:         THIS.AddObject("cnt_4c_Grade", "Container")
1168:         WITH THIS.cnt_4c_Grade
1169:             .Top           = 247
1170:             .Left          = 50
1171:             .Width         = 820
1172:             .Height        = 344
1173:             .BackStyle     = 0
1174:             .BorderWidth   = 0
1175:             .SpecialEffect = 0
1176:             .Visible       = .T.
1177:         ENDWITH
1178:         loc_oCnt = THIS.cnt_4c_Grade
1179: 
1180:         loc_oCnt.AddObject("grd_4c_Dados", "Grid")
1181:         loc_oGrd = loc_oCnt.grd_4c_Dados
1182:         WITH loc_oGrd
1183:             .Top           = 1
1184:             .Left          = 3
1185:             .Width         = 813
1186:             .Height        = 340
1187:             .FontName      = "Tahoma"
1188:             .FontSize      = 8
1189:             .AllowHeaderSizing = .F.
1190:             .AllowRowSizing    = .F.
1191:             .DeleteMark    = .F.
1192:             .RecordMark    = .F.
1193:             .HeaderHeight  = 16
1194:             .RowHeight     = 16
1195:             .ScrollBars    = 2
1196:             .GridLineColor = RGB(238, 238, 238)
1197:             .ColumnCount   = 9
1198:             .RecordSource  = "cursor_4c_Operacoes"
1199:             .Visible       = .T.
1200:         ENDWITH
1201: 
1202:         *-- Column1: Check1 (SelImp) - unica coluna editavel da grade
1203:         loc_oGrd.Column1.AddObject("chk_4c_Check1", "CheckBox")
1204:         WITH loc_oGrd.Column1
1205:             .Width          = 19
1206:             .ControlSource  = "cursor_4c_Operacoes.SelImp"
1207:             .CurrentControl = "chk_4c_Check1"
1208:             .Sparse         = .F.
1209:             .Header1.Caption   = ""
1210:             .Header1.Alignment = 2
1211:             .Header1.ForeColor = RGB(36, 84, 155)
1212:         ENDWITH
1213:         WITH loc_oGrd.Column1.chk_4c_Check1
1214:             .Top         = 9
1215:             .Left        = 2
1216:             .Height      = 17
1217:             .Width       = 22
1218:             .Alignment   = 0
1219:             .Caption     = ""
1220:             .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
1221:             .ReadOnly    = .F.
1222:             .Visible     = .T.
1223:         ENDWITH
1224: 
1225:         *-- CheckBox de coluna de Grid nao alterna pelo binding nativo: o
1226:         *-- legado suprime o toggle padrao (Click/MouseDown com NoDefault) e

*-- Linhas 1240 a 1361:
1240:         WITH loc_oGrd.Column2
1241:             .Width          = 63
1242:             .ControlSource  = "cursor_4c_Operacoes.Dopes"
1243:             .Header1.Caption   = "C" + CHR(243) + "digo"
1244:             .Header1.Alignment = 2
1245:             .Header1.ForeColor = RGB(36, 84, 155)
1246:             .Text1.BorderStyle = 1
1247:             .Text1.Margin      = 0
1248:             .Text1.ReadOnly    = .T.
1249:             .Text1.ForeColor   = RGB(0, 0, 0)
1250:             .Text1.ToolTipText = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o na Origem"
1251:         ENDWITH
1252: 
1253:         *-- Column3: Emissao (Datas)
1254:         WITH loc_oGrd.Column3
1255:             .Width          = 80
1256:             .ControlSource  = "cursor_4c_Operacoes.Datas"
1257:             .Header1.Caption   = "Emiss" + CHR(227) + "o"
1258:             .Header1.Alignment = 2
1259:             .Header1.ForeColor = RGB(36, 84, 155)
1260:             .Text1.Margin      = 0
1261:             .Text1.ReadOnly    = .T.
1262:             .Text1.ToolTipText = "Data da Opera" + CHR(231) + CHR(227) + "o na Origem"
1263:         ENDWITH
1264: 
1265:         *-- Column4: Valor (Valos)
1266:         WITH loc_oGrd.Column4
1267:             .Width          = 129
1268:             .ControlSource  = "cursor_4c_Operacoes.Valos"
1269:             .Header1.Caption   = "Valor"
1270:             .Header1.Alignment = 2
1271:             .Header1.ForeColor = RGB(36, 84, 155)
1272:             .Text1.BorderStyle = 0
1273:             .Text1.Margin      = 0
1274:             .Text1.ReadOnly    = .T.
1275:             .Text1.ForeColor   = RGB(0, 0, 0)
1276:             .Text1.BackColor   = RGB(255, 255, 255)
1277:             .Text1.ToolTipText = "Valor da Opera" + CHR(231) + CHR(227) + "o na Origem"
1278:         ENDWITH
1279: 
1280:         *-- Column5: Nota Fiscal (Notas)
1281:         WITH loc_oGrd.Column5
1282:             .Width          = 75
1283:             .ControlSource  = "cursor_4c_Operacoes.Notas"
1284:             .Header1.Caption   = "Nota Fiscal"
1285:             .Header1.Alignment = 2
1286:             .Header1.ForeColor = RGB(36, 84, 155)
1287:             .Text1.BorderStyle = 0
1288:             .Text1.Margin      = 0
1289:             .Text1.ReadOnly    = .T.
1290:             .Text1.ForeColor   = RGB(0, 0, 0)
1291:             .Text1.BackColor   = RGB(255, 255, 255)
1292:             .Text1.ToolTipText = "Documento da Opera" + CHR(231) + CHR(227) + "o na Origem"
1293:         ENDWITH
1294: 
1295:         *-- Column6: Serie (Series)
1296:         WITH loc_oGrd.Column6
1297:             .Width          = 40
1298:             .ControlSource  = "cursor_4c_Operacoes.Series"
1299:             .Header1.Caption   = "S" + CHR(233) + "rie"
1300:             .Header1.Alignment = 2
1301:             .Header1.ForeColor = RGB(36, 84, 155)
1302:             .Text1.BorderStyle = 0
1303:             .Text1.Margin      = 0
1304:             .Text1.ReadOnly    = .T.
1305:             .Text1.ForeColor   = RGB(0, 0, 0)
1306:             .Text1.BackColor   = RGB(255, 255, 255)
1307:             .Text1.ToolTipText = "Usu" + CHR(225) + "rio Que Gerou a Opera" + CHR(231) + CHR(227) + "o na Origem"
1308:         ENDWITH
1309: 
1310:         *-- Column7: Movimentacao (Numes)
1311:         WITH loc_oGrd.Column7
1312:             .Width          = 307
1313:             .ControlSource  = "cursor_4c_Operacoes.Numes"
1314:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1315:             .Header1.Alignment = 2
1316:             .Header1.ForeColor = RGB(36, 84, 155)
1317:             .Text1.BorderStyle = 0
1318:             .Text1.Margin      = 0
1319:             .Text1.ReadOnly    = .T.
1320:             .Text1.ForeColor   = RGB(0, 0, 0)
1321:             .Text1.BackColor   = RGB(255, 255, 255)
1322:             .Text1.ToolTipText = "Conta de Origem da Opera" + CHR(231) + CHR(227) + "o na Origem"
1323:         ENDWITH
1324: 
1325:         *-- Column8: Emp (Emps)
1326:         WITH loc_oGrd.Column8
1327:             .Width          = 38
1328:             .ControlSource  = "cursor_4c_Operacoes.Emps"
1329:             .Header1.Caption   = "Emp"
1330:             .Header1.Alignment = 2
1331:             .Header1.ForeColor = RGB(36, 84, 155)
1332:             .Text1.BorderStyle = 0
1333:             .Text1.Margin      = 0
1334:             .Text1.ReadOnly    = .T.
1335:             .Text1.ForeColor   = RGB(0, 0, 0)
1336:             .Text1.BackColor   = RGB(255, 255, 255)
1337:             .Text1.ToolTipText = "Conta de Destino da Opera" + CHR(231) + CHR(227) + "o na Origem"
1338:         ENDWITH
1339: 
1340:         *-- Column9: Stat (stats)
1341:         WITH loc_oGrd.Column9
1342:             .Width          = 33
1343:             .ControlSource  = "cursor_4c_Operacoes.stats"
1344:             .Header1.Caption   = "Stat"
1345:             .Header1.Alignment = 2
1346:             .Header1.ForeColor = RGB(36, 84, 155)
1347:             .Text1.Alignment   = 2
1348:             .Text1.BorderStyle = 0
1349:             .Text1.Margin      = 0
1350:             .Text1.ReadOnly    = .T.
1351:             .Text1.ForeColor   = RGB(0, 0, 0)
1352:             .Text1.BackColor   = RGB(255, 255, 255)
1353:         ENDWITH
1354:     ENDPROC
1355: 
1356:     *--------------------------------------------------------------------------
1357:     * ConfigurarBotoesAcao - Grupos de botoes de acao do form principal:
1358:     * cmdBtnForm (Limpar Selecao/Processar/Encerrar), cmdSelecionar (botao
1359:     * avulso que dispara a selecao das operacoes), Commandgroup1 (abre o
1360:     * painel de inutilizacao) e cmdBtnGrade (Selecionar/Desmarcar/
1361:     * Documento/Danfe Simplificado - agem sobre a grade cntGrade). Posicoes,

*-- Linhas 1498 a 1516:
1498:         ENDWITH
1499: 
1500:         *-- cmdBtnGrade: Selecionar/Desmarcar/Documento/Danfe Simpl - agem
1501:         *-- sobre a grade cnt_4c_Grade.grd_4c_Dados
1502:         THIS.AddObject("obj_4c_CmdBtnGrade", "CommandGroup")
1503:         WITH THIS.obj_4c_CmdBtnGrade
1504:             .AutoSize      = .T.
1505:             .ButtonCount   = 4
1506:             .BackStyle     = 0
1507:             .BorderStyle   = 0
1508:             .Value         = 1
1509:             .Height        = 232
1510:             .Left          = 865
1511:             .SpecialEffect = 1
1512:             .Top           = 264
1513:             .Width         = 85
1514:             .BorderColor   = RGB(136, 189, 188)
1515:             .Themes        = .F.
1516:             .Visible       = .T.

*-- Linhas 1619 a 1654:
1619:         IF USED("cursor_4c_Inutil")
1620:             USE IN cursor_4c_Inutil
1621:         ENDIF
1622:         SET NULL ON
1623:         CREATE CURSOR cursor_4c_Inutil ( ;
1624:             nMarca N(1), ;
1625:             Emps   C(3), ;
1626:             Cnpj   C(14), ;
1627:             Series C(3), ;
1628:             Notai  C(9), ;
1629:             Notaf  C(9))
1630:         SET NULL OFF
1631: 
1632:         *-- cursor_4c_NotasAInutilizar (nfAinu do legado) - faixas de
1633:         *-- numeracao NAO usadas, calculadas por BtnPrepararInutilizacaoClick
1634:         *-- ("A Inutilizar"). cmdInu.Click (AbrirPainelInutilizacao) filtra
1635:         *-- este cursor pela Empresa digitada para montar cursor_4c_Inutil.
1636:         IF USED("cursor_4c_NotasAInutilizar")
1637:             USE IN cursor_4c_NotasAInutilizar
1638:         ENDIF
1639:         CREATE CURSOR cursor_4c_NotasAInutilizar ( ;
1640:             Emps   C(3), ;
1641:             Cnpj   C(14), ;
1642:             Series C(3), ;
1643:             Notai  C(9), ;
1644:             Notaf  C(9))
1645: 
1646:         THIS.AddObject("cnt_4c_Inu", "Container")
1647:         WITH THIS.cnt_4c_Inu
1648:             .Top           = 156
1649:             .Left          = 203
1650:             .Width         = 504
1651:             .Height        = 392
1652:             .SpecialEffect = 0
1653:             .BackColor     = RGB(255, 255, 255)
1654:             .Visible       = .F.

*-- Linhas 1705 a 1836:
1705:             .Visible      = .T.
1706:         ENDWITH
1707: 
1708:         loc_oPnl.AddObject("grd_4c_Inu", "Grid")
1709:         loc_oGrd = loc_oPnl.grd_4c_Inu
1710:         WITH loc_oGrd
1711:             .Top           = 28
1712:             .Left          = 17
1713:             .Width         = 382
1714:             .Height        = 355
1715:             .FontName      = "Tahoma"
1716:             .FontSize      = 8
1717:             .DeleteMark    = .F.
1718:             .RecordMark    = .F.
1719:             .RowHeight     = 16
1720:             .ScrollBars    = 2
1721:             .GridLineColor = RGB(238, 238, 238)
1722:             .ColumnCount   = 6
1723:             .RecordSource  = "cursor_4c_Inutil"
1724:             .Visible       = .T.
1725:         ENDWITH
1726: 
1727:         *-- ColumnOrder reproduz a ordem visual do legado: Check1 (Column6)
1728:         *-- aparece PRIMEIRO (ColumnOrder=1), seguido por Emp/Serie/Nota
1729:         *-- Inicial/Nota Final/CPF-CNPJ (ColumnOrder 2..6)
1730:         WITH loc_oGrd.Column1
1731:             .ColumnOrder = 2
1732:             .Width       = 40
1733:             .Movable     = .F.
1734:             .Resizable   = .F.
1735:             .ReadOnly    = .T.
1736:             .ControlSource     = "cursor_4c_Inutil.Emps"
1737:             .Header1.Caption   = "Emp"
1738:             .Header1.Alignment = 2
1739:             .Text1.BorderStyle = 0
1740:             .Text1.Margin      = 0
1741:             .Text1.ReadOnly    = .T.
1742:             .Text1.ForeColor   = RGB(0, 0, 0)
1743:             .Text1.BackColor   = RGB(255, 255, 255)
1744:         ENDWITH
1745:         WITH loc_oGrd.Column2
1746:             .ColumnOrder = 3
1747:             .Width       = 50
1748:             .Movable     = .F.
1749:             .Resizable   = .F.
1750:             .ReadOnly    = .T.
1751:             .ControlSource     = "cursor_4c_Inutil.Series"
1752:             .Header1.Caption   = "S" + CHR(233) + "rie"
1753:             .Header1.Alignment = 2
1754:             .Text1.BorderStyle = 0
1755:             .Text1.Margin      = 0
1756:             .Text1.ReadOnly    = .T.
1757:             .Text1.ForeColor   = RGB(0, 0, 0)
1758:             .Text1.BackColor   = RGB(255, 255, 255)
1759:         ENDWITH
1760:         WITH loc_oGrd.Column3
1761:             .ColumnOrder = 4
1762:             .Width       = 70
1763:             .Movable     = .F.
1764:             .Resizable   = .F.
1765:             .ReadOnly    = .T.
1766:             .ControlSource     = "cursor_4c_Inutil.Notai"
1767:             .Header1.Caption   = "Nota Inicial"
1768:             .Header1.Alignment = 2
1769:             .Text1.BorderStyle = 0
1770:             .Text1.Margin      = 0
1771:             .Text1.ReadOnly    = .T.
1772:             .Text1.ForeColor   = RGB(0, 0, 0)
1773:             .Text1.BackColor   = RGB(255, 255, 255)
1774:         ENDWITH
1775:         WITH loc_oGrd.Column4
1776:             .ColumnOrder = 5
1777:             .Width       = 70
1778:             .Movable     = .F.
1779:             .Resizable   = .F.
1780:             .ReadOnly    = .T.
1781:             .ControlSource     = "cursor_4c_Inutil.Notaf"
1782:             .Header1.Caption   = "Nota Final"
1783:             .Header1.Alignment = 2
1784:             .Text1.BorderStyle = 0
1785:             .Text1.Margin      = 0
1786:             .Text1.ReadOnly    = .T.
1787:             .Text1.ForeColor   = RGB(0, 0, 0)
1788:             .Text1.BackColor   = RGB(255, 255, 255)
1789:         ENDWITH
1790:         WITH loc_oGrd.Column5
1791:             .ColumnOrder = 6
1792:             .Width       = 110
1793:             .Movable     = .F.
1794:             .Resizable   = .F.
1795:             .ReadOnly    = .T.
1796:             .ControlSource     = "cursor_4c_Inutil.Cnpj"
1797:             .Header1.Caption   = "CPF/CNPJ"
1798:             .Header1.Alignment = 2
1799:             .Text1.BorderStyle = 0
1800:             .Text1.Margin      = 0
1801:             .Text1.ReadOnly    = .T.
1802:             .Text1.ForeColor   = RGB(0, 0, 0)
1803:             .Text1.BackColor   = RGB(255, 255, 255)
1804:         ENDWITH
1805: 
1806:         *-- Column6: Check1 (nMarca) - unica coluna editavel, 1a na ordem visual
1807:         *-- ORDEM OBRIGATORIA: o ControlSource da COLUNA vem ANTES do
1808:         *-- AddObject do CheckBox. O RecordSource do Grid ja amarrou Column6 ao
1809:         *-- 6o campo do cursor (Notaf, char) e o controle novo HERDA essa
1810:         *-- amarracao: adicionar o CheckBox antes de reapontar a coluna para
1811:         *-- nMarca (numerico) estoura "Error with CHK_4C_CHECK1 - Value : Data
1812:         *-- type mismatch" dentro do Init, o CREATEOBJECT devolve .F. e a tela
1813:         *-- NAO ABRE. Medido no VFP9 em 2026-10-17.
1814:         WITH loc_oGrd.Column6
1815:             .ColumnOrder    = 1
1816:             .Width          = 21
1817:             .Movable        = .F.
1818:             .Resizable      = .F.
1819:             .Sparse         = .F.
1820:             .ControlSource  = "cursor_4c_Inutil.nMarca"
1821:             .Header1.Caption = ""
1822:         ENDWITH
1823:         loc_oGrd.Column6.AddObject("chk_4c_Check1", "CheckBox")
1824:         WITH loc_oGrd.Column6.chk_4c_Check1
1825:             .Top       = 19
1826:             .Left      = 12
1827:             .Height    = 17
1828:             .Width     = 60
1829:             .Alignment = 0
1830:             .Caption   = ""
1831:             .ReadOnly  = .F.
1832:             .Visible   = .T.
1833:         ENDWITH
1834:         *-- CurrentControl por ULTIMO: sem ele a coluna segue desenhando o
1835:         *-- Text1 e o CheckBox nunca aparece (regra #18)
1836:         loc_oGrd.Column6.CurrentControl = "chk_4c_Check1"

*-- Linhas 2590 a 2609:
2590:             ENDIF
2591: 
2592:             IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
2593:                 IF PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
2594:                     THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2595:                 ENDIF
2596:             ENDIF
2597:         CATCH TO loc_oErro
2598:             MsgErro(loc_oErro.Message + CHR(13) + ;
2599:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2600:                     "Procedure: " + loc_oErro.Procedure, ;
2601:                     "Erro ao atualizar a grade")
2602:         ENDTRY
2603:     ENDPROC
2604: 
2605:     *--------------------------------------------------------------------------
2606:     * LimparSelecao - "PROCEDURE limpaselecao" do legado: esvazia a grade,
2607:     * devolve os criterios a edicao e repinta.
2608:     *--------------------------------------------------------------------------
2609:     PROCEDURE LimparSelecao()

*-- Linhas 2776 a 2794:
2776:                     REPLACE SelImp WITH !cursor_4c_Operacoes.SelImp ;
2777:                         IN cursor_4c_Operacoes
2778:                     IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
2779:                         THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2780:                     ENDIF
2781:                 ENDIF
2782:             ENDIF
2783:         CATCH TO loc_oErro
2784:             MsgErro(loc_oErro.Message + CHR(13) + ;
2785:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2786:                     "Procedure: " + loc_oErro.Procedure, ;
2787:                     "Erro ao marcar a opera" + CHR(231) + CHR(227) + "o")
2788:         ENDTRY
2789:     ENDPROC
2790: 
2791:     *--------------------------------------------------------------------------
2792:     * Handlers da coluna de marcacao da grade. Os quatro sao obrigatorios: os
2793:     * dois primeiros existem SO para suprimir o toggle nativo (senao o valor
2794:     * alterna duas vezes e volta ao que era).

*-- Linhas 2967 a 2985:
2967:     *
2968:     * O 1o SqlExecute do legado ("...where stats = 'xxx'") so existia para
2969:     * criar nfAinu com a ESTRUTURA certa (nenhum status real vale 'xxx') -
2970:     * aqui vira CREATE CURSOR direto, mais claro para o mesmo efeito.
2971:     *--------------------------------------------------------------------------
2972:     PROCEDURE BtnPrepararInutilizacaoClick()
2973:         LOCAL loc_cSQL, loc_nResult, loc_cCnpj, loc_cSerie, loc_nNotaInu, loc_oErro
2974: 
2975:         TRY
2976:             IF USED("cursor_4c_NotasAInutilizar")
2977:                 SELECT cursor_4c_NotasAInutilizar
2978:                 ZAP
2979:             ENDIF
2980: 
2981:             *-- Numeros USADOS (emitidos ou ja inutilizados), com a mesma
2982:             *-- substituicao de CNPJ->'SVP' do legado (regra de negocio de
2983:             *-- um cliente especifico - transcrita literal, nao generalizada)
2984:             loc_cSQL = "SELECT DISTINCT CASE WHEN SUBSTRING(ids,7,14) = '12136108000195' THEN 'SVP' ELSE emps END AS emps," + ;
2985:                 " SUBSTRING(ids,7,14) AS cnpj, SUBSTRING(ids,23,3) AS series, SUBSTRING(ids,26,9) AS notai, SUBSTRING(ids,26,9) AS notaf" + ;

*-- Linhas 3089 a 3107:
3089:                 ENDSCAN
3090:             ENDIF
3091: 
3092:             THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
3093:             THIS.cnt_4c_Inu.Visible = .T.
3094:         CATCH TO loc_oErro
3095:             MsgErro(loc_oErro.Message + CHR(13) + ;
3096:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3097:                     "Procedure: " + loc_oErro.Procedure, ;
3098:                     "Erro ao abrir pain" + CHR(233) + "l de inutiliza" + CHR(231) + CHR(227) + "o")
3099:         ENDTRY
3100:     ENDPROC
3101: 
3102:     *--------------------------------------------------------------------------
3103:     * FecharPainelInutilizacao - CntInu.LostFocus do legado ("This.Visible =
3104:     * .f."), que e' o FUNIL de fechamento do painel: tanto o botao Encerrar
3105:     * do painel quanto o fim do processamento passam por aqui.
3106:     *--------------------------------------------------------------------------
3107:     PROCEDURE FecharPainelInutilizacao()

*-- Linhas 3306 a 3328:
3306:                 IF USED("cursor_4c_DanfeSimpl")
3307:                     USE IN cursor_4c_DanfeSimpl
3308:                 ENDIF
3309:                 SET NULL ON
3310:                 CREATE CURSOR cursor_4c_DanfeSimpl (fin C(30), numero C(30), emissao C(30), ;
3311:                     chavea C(30), chave C(50), linha1e C(70), linha2e C(70), linha1d C(70), ;
3312:                     linha2d C(70), danfes C(30), prot C(60), prota C(60))
3313:                 SET NULL OFF
3314:                 INSERT INTO cursor_4c_DanfeSimpl (fin, numero, emissao, chavea, chave, linha1e, ;
3315:                     linha2e, linha1d, linha2d, danfes, prot, prota) VALUES ( ;
3316:                     loc_cFin, loc_cNumero, loc_cEmissao, "Chave de acesso", loc_cChave, ;
3317:                     loc_cLinha1E, loc_cLinha2E, loc_cLinha1D, loc_cLinha2D, ;
3318:                     "DANFE SIMPLIFICADO", loc_cProtCompleto, "Protocolo de autorizacao de uso")
3319: 
3320:                 SELECT cursor_4c_DanfeSimpl
3321:                 THIS.ExecutarReportForm("SigReDsi", "PREVIEW", "cursor_4c_DanfeSimpl")
3322:             ENDIF
3323: 
3324:             IF USED("cursor_4c_NfiDsi")
3325:                 USE IN cursor_4c_NfiDsi
3326:             ENDIF
3327:         CATCH TO loc_oErro
3328:             MsgErro(loc_oErro.Message + CHR(13) + ;

