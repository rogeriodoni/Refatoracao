# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1165: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1571: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJrn.prg) - TRECHOS RELEVANTES PARA PASS GRID (2091 linhas total):

*-- Linhas 382 a 406:
382:         * Novo: Top=96+29=125, Left=32, Width=880 (ate cnt_4c_Saida.Left=917)
383:         * 14 colunas: iclis, cargos, refers, hora01-04, cDom-cSab
384:         *
385:         * ColumnCount FORA do WITH (Problema 36: nao criar colunas dentro de WITH)
386:         * ControlSource redefinido em CarregarLista apos RecordSource (Problema 48)
387:         *----------------------------------------------------------------------
388:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
389:         loc_oGrid = loc_oPagina.grd_4c_Lista
390: 
391:         loc_oGrid.ColumnCount = 14
392: 
393:         WITH loc_oGrid
394:             .Top                = 125
395:             .Left               = 32
396:             .Width              = 880
397:             .Height             = 470
398:             .FontName           = "Verdana"
399:             .FontSize           = 8
400:             .ForeColor          = RGB(90, 90, 90)
401:             .BackColor          = RGB(255, 255, 255)
402:             .GridLineColor      = RGB(238, 238, 238)
403:             .HighlightBackColor = RGB(255, 255, 255)
404:             .HighlightForeColor = RGB(15, 41, 104)
405:             .HighlightStyle     = 2
406:             .DeleteMark         = .F.

*-- Linhas 412 a 482:
412: 
413:             .Column1.Width           = 80
414:             .Column1.Alignment       = 0
415:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
416: 
417:             .Column2.Width           = 80
418:             .Column2.Alignment       = 0
419:             .Column2.Header1.Caption = "Cargo"
420: 
421:             .Column3.Width           = 52
422:             .Column3.Alignment       = 0
423:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
424: 
425:             .Column4.Width           = 45
426:             .Column4.Alignment       = 0
427:             .Column4.Header1.Caption = "Inicio"
428: 
429:             .Column5.Width           = 45
430:             .Column5.Alignment       = 0
431:             .Column5.Header1.Caption = "Intervalo"
432: 
433:             .Column6.Width           = 45
434:             .Column6.Alignment       = 0
435:             .Column6.Header1.Caption = "Intervalo"
436: 
437:             .Column7.Width           = 45
438:             .Column7.Alignment       = 0
439:             .Column7.Header1.Caption = "Fim"
440: 
441:             .Column8.Width            = 20
442:             .Column8.Alignment        = 2
443:             .Column8.Header1.Caption  = "Dom"
444: 
445:             .Column9.Width            = 20
446:             .Column9.Alignment        = 2
447:             .Column9.Header1.Caption  = "Seg"
448: 
449:             .Column10.Width           = 20
450:             .Column10.Alignment       = 2
451:             .Column10.Header1.Caption = "Ter"
452: 
453:             .Column11.Width           = 20
454:             .Column11.Alignment       = 2
455:             .Column11.Header1.Caption = "Qua"
456: 
457:             .Column12.Width           = 20
458:             .Column12.Alignment       = 2
459:             .Column12.Header1.Caption = "Qui"
460: 
461:             .Column13.Width           = 20
462:             .Column13.Alignment       = 2
463:             .Column13.Header1.Caption = "Sex"
464: 
465:             .Column14.Width           = 20
466:             .Column14.Alignment       = 2
467:             .Column14.Header1.Caption = "S" + CHR(225) + "b"
468:         ENDWITH
469: 
470:         *----------------------------------------------------------------------
471:         * Painel flutuante "Copiar Jornada do Mes" (Problema 26: iniciar oculto)
472:         * Original cntCopiaMes: Top=233, Left=280, Width=273, Height=136
473:         * Com compensacao PageFrame +29: Top=262
474:         *----------------------------------------------------------------------
475:         loc_oPagina.AddObject("cnt_4c_CopiaMes", "Container")
476:         WITH loc_oPagina.cnt_4c_CopiaMes
477:             .Top         = 262
478:             .Left        = 280
479:             .Width       = 273
480:             .Height      = 136
481:             .BackStyle   = 1
482:             .BackColor   = RGB(240, 240, 240)

*-- Linhas 533 a 551:
533:             .Left          = 71
534:             .Width         = 100
535:             .Height        = 24
536:             .ColumnCount   = 2
537:             .ColumnWidths  = "95,0"
538:             .BoundColumn   = 2
539:             .RowSourceType = 1
540:             .RowSource     = ""
541:             .Style         = 2
542:             .FontName      = "Tahoma"
543:             .FontSize      = 8
544:             .Visible       = .T.
545:         ENDWITH
546: 
547:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_Para", "Label")
548:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_Para
549:             .Caption   = "Para :"
550:             .Top       = 87
551:             .Left      = 31

*-- Linhas 565 a 583:
565:             .Left          = 71
566:             .Width         = 100
567:             .Height        = 24
568:             .ColumnCount   = 2
569:             .ColumnWidths  = "95,0"
570:             .BoundColumn   = 2
571:             .RowSourceType = 1
572:             .RowSource     = ""
573:             .Style         = 2
574:             .FontName      = "Tahoma"
575:             .FontSize      = 8
576:             .Visible       = .T.
577:         ENDWITH
578: 
579:         *-- Botao Confirmar (Command2 no legado: Top=39, Left=213, Width=40, Height=40)
580:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesOK", "CommandButton")
581:         WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK
582:             .Caption       = "OK"
583:             .Top           = 39

*-- Linhas 739 a 773:
739:             .Width           = 80
740:             .Height          = 24
741:             .BoundColumn     = 2
742:             .ColumnCount     = 2
743:             .ColumnWidths    = "0,70"
744:             .RowSourceType   = 1
745:             .RowSource       = loc_cRowMes
746:             .Style           = 2
747:             .FontName        = "Tahoma"
748:             .FontSize        = 8
749:             .Visible         = .T.
750:         ENDWITH
751: 
752:         loc_oPagina.AddObject("cbo_4c_CboAno", "ComboBox")
753:         WITH loc_oPagina.cbo_4c_CboAno
754:             .Top             = 165
755:             .Left            = 232
756:             .Width           = 60
757:             .Height          = 24
758:             .ColumnCount     = 1
759:             .ColumnWidths    = "55"
760:             .RowSourceType   = 1
761:             .RowSource       = loc_cAnos
762:             .Style           = 2
763:             .FontName        = "Tahoma"
764:             .FontSize        = 8
765:             .Visible         = .T.
766:         ENDWITH
767: 
768:         *----------------------------------------------------------------------
769:         * Funcionario: label + codigo + nome
770:         * Label2 "Funcionario :" Left=80, Top=166 -> Top=195
771:         * getCodCli: Left=148, Top=163 -> Top=192, Width=80
772:         * getDesCli: Left=232, Top=163 -> Top=192, Width=360
773:         *----------------------------------------------------------------------

*-- Linhas 1147 a 1183:
1147: 
1148:     *==========================================================================
1149:     * CarregarLista - Busca dados no BO e vincula ao grid
1150:     * Sequencia obrigatoria: Buscar -> RecordSource (fora WITH) -> AtualizarBinding
1151:     *==========================================================================
1152:     PROCEDURE CarregarLista()
1153:         LOCAL loc_lSucesso, loc_oGrid
1154:         loc_lSucesso = .F.
1155: 
1156:         TRY
1157:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1158:                 loc_lSucesso = .T.
1159:             ELSE
1160:                 IF THIS.this_oBusinessObject.Buscar("")
1161:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1162: 
1163:                     *-- RecordSource e ColumnCount FORA do WITH (Problema 36/48)
1164:                     loc_oGrid.ColumnCount = 3
1165:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1166:                     loc_oGrid.ColumnCount  = 14
1167: 
1168:                     *-- Redefine ControlSource + Headers apos RecordSource (Problema 48)
1169:                     THIS.AtualizarBindingGrid(loc_oGrid)
1170:                     THIS.FormatarGridLista(loc_oGrid)
1171:                     loc_oGrid.Refresh()
1172:                     loc_lSucesso = .T.
1173:                 ENDIF
1174:             ENDIF
1175:         CATCH TO loc_oErro
1176:             MsgErro("Erro em FormJrn.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
1177:         ENDTRY
1178: 
1179:         RETURN loc_lSucesso
1180:     ENDPROC
1181: 
1182:     *==========================================================================
1183:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)

*-- Linhas 1203 a 1293:
1203: 
1204:     *==========================================================================
1205:     * AtualizarBindingGrid - Redefine ControlSource, Width e Header das 14 colunas
1206:     * Chamado apos RecordSource (Problema 48: auto-bind reseta ControlSource)
1207:     *==========================================================================
1208:     PROTECTED PROCEDURE AtualizarBindingGrid(par_oGrid)
1209:         WITH par_oGrid
1210:             .Column1.ControlSource   = "cursor_4c_Dados.iclis"
1211:             .Column1.Width           = 80
1212:             .Column1.Alignment       = 0
1213:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
1214: 
1215:             .Column2.ControlSource   = "cursor_4c_Dados.cargos"
1216:             .Column2.Width           = 80
1217:             .Column2.Alignment       = 0
1218:             .Column2.Header1.Caption = "Cargo"
1219: 
1220:             .Column3.ControlSource   = "cursor_4c_Dados.refers"
1221:             .Column3.Width           = 52
1222:             .Column3.Alignment       = 0
1223:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
1224: 
1225:             .Column4.ControlSource   = "cursor_4c_Dados.hora01"
1226:             .Column4.Width           = 45
1227:             .Column4.Alignment       = 0
1228:             .Column4.Header1.Caption = "Inicio"
1229: 
1230:             .Column5.ControlSource   = "cursor_4c_Dados.hora02"
1231:             .Column5.Width           = 45
1232:             .Column5.Alignment       = 0
1233:             .Column5.Header1.Caption = "Intervalo"
1234: 
1235:             .Column6.ControlSource   = "cursor_4c_Dados.hora03"
1236:             .Column6.Width           = 45
1237:             .Column6.Alignment       = 0
1238:             .Column6.Header1.Caption = "Intervalo"
1239: 
1240:             .Column7.ControlSource   = "cursor_4c_Dados.hora04"
1241:             .Column7.Width           = 45
1242:             .Column7.Alignment       = 0
1243:             .Column7.Header1.Caption = "Fim"
1244: 
1245:             .Column8.ControlSource   = "cursor_4c_Dados.cDom"
1246:             .Column8.Width           = 20
1247:             .Column8.Alignment       = 2
1248:             .Column8.Header1.Caption = "Dom"
1249: 
1250:             .Column9.ControlSource   = "cursor_4c_Dados.cSeg"
1251:             .Column9.Width           = 20
1252:             .Column9.Alignment       = 2
1253:             .Column9.Header1.Caption = "Seg"
1254: 
1255:             .Column10.ControlSource  = "cursor_4c_Dados.cTer"
1256:             .Column10.Width          = 20
1257:             .Column10.Alignment      = 2
1258:             .Column10.Header1.Caption = "Ter"
1259: 
1260:             .Column11.ControlSource  = "cursor_4c_Dados.cQua"
1261:             .Column11.Width          = 20
1262:             .Column11.Alignment      = 2
1263:             .Column11.Header1.Caption = "Qua"
1264: 
1265:             .Column12.ControlSource  = "cursor_4c_Dados.cQui"
1266:             .Column12.Width          = 20
1267:             .Column12.Alignment      = 2
1268:             .Column12.Header1.Caption = "Qui"
1269: 
1270:             .Column13.ControlSource  = "cursor_4c_Dados.cSex"
1271:             .Column13.Width          = 20
1272:             .Column13.Alignment      = 2
1273:             .Column13.Header1.Caption = "Sex"
1274: 
1275:             .Column14.ControlSource  = "cursor_4c_Dados.cSab"
1276:             .Column14.Width          = 20
1277:             .Column14.Alignment      = 2
1278:             .Column14.Header1.Caption = "S" + CHR(225) + "b"
1279:         ENDWITH
1280:     ENDPROC
1281: 
1282:     *==========================================================================
1283:     * FormatarGridLista - Padroniza fonte de todas as colunas
1284:     *==========================================================================
1285:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1286:         WITH par_oGrid
1287:             .FontName = "Tahoma"
1288:             .FontSize = 8
1289:         ENDWITH
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * BOParaForm - Copia propriedades do BO para os controles de Page2

*-- Linhas 1557 a 1587:
1557: 
1558:             IF VARTYPE(loc_cBusca) = "C"
1559:                 loc_cBusca = ALLTRIM(CHRTRAN(loc_cBusca, "'", ""))
1560: 
1561:                 IF !EMPTY(loc_cBusca)
1562:                     loc_cFiltro = "(a.iclis LIKE '%" + loc_cBusca + "%'" + ;
1563:                                   " OR a.cargos LIKE '%" + loc_cBusca + "%'" + ;
1564:                                   " OR a.refers LIKE '%" + loc_cBusca + "%'" + ;
1565:                                   " OR b.rclis LIKE '%" + loc_cBusca + "%')"
1566:                 ENDIF
1567: 
1568:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1569:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1570:                     loc_oGrid.ColumnCount = 3
1571:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1572:                     loc_oGrid.ColumnCount  = 14
1573:                     THIS.AtualizarBindingGrid(loc_oGrid)
1574:                     THIS.FormatarGridLista(loc_oGrid)
1575:                     loc_oGrid.Refresh()
1576:                 ENDIF
1577:             ENDIF
1578:         CATCH TO loc_oErro
1579:             MsgErro("Erro em FormJrn.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1580:         ENDTRY
1581:     ENDPROC
1582: 
1583:     *==========================================================================
1584:     * BtnEncerrarClick - Fecha o formulario
1585:     *==========================================================================
1586:     PROCEDURE BtnEncerrarClick()
1587:         THIS.Release()

*-- Linhas 1655 a 1697:
1655:         loc_oPagina.cmd_4c_CopiarMes.Enabled = .F.
1656:         loc_oPagina.cnt_4c_Saida.Enabled     = .F.
1657:         loc_oPagina.cnt_4c_Botoes.Enabled    = .F.
1658:         loc_oPagina.grd_4c_Lista.Enabled     = .F.
1659:         loc_oPagina.cnt_4c_CopiaMes.Visible  = .T.
1660:         loc_oPagina.cnt_4c_CopiaMes.SetFocus()
1661:     ENDPROC
1662: 
1663:     *==========================================================================
1664:     * Lookup Cargo (txt_4c_CodCgo -> SigCdCrg)
1665:     *==========================================================================
1666:     PROCEDURE AbrirLookupCargo()
1667:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1668:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1669:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)
1670: 
1671:         TRY
1672:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1673:                 "SigCdCrg", "cursor_4c_Busca", "ccargs", loc_cValor, ;
1674:                 "Sele" + CHR(231) + CHR(227) + "o de Cargos")
1675: 
1676:             IF VARTYPE(loc_oForm) = "O"
1677:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1678:                     loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1679:                 ELSE
1680:                     IF !loc_oForm.this_lAchouRegistro
1681:                     loc_oForm.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
1682:                     loc_oForm.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
1683:                     loc_oForm.Show()
1684:                     IF loc_oForm.this_lSelecionou
1685:                         loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1686:                     ENDIF
1687:                     ENDIF
1688:                 ENDIF
1689:                 IF USED("cursor_4c_Busca")
1690:                     USE IN cursor_4c_Busca
1691:                 ENDIF
1692:                 loc_oForm.Release()
1693:             ENDIF
1694:         CATCH TO loc_oErro
1695:             MsgErro("Erro em FormJrn.AbrirLookupCargo:" + CHR(13) + loc_oErro.Message, "Erro")
1696:         ENDTRY
1697:     ENDPROC

*-- Linhas 1753 a 1772:
1753:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1754:                 ELSE
1755:                     IF !loc_oForm.this_lAchouRegistro
1756:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1757:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1758:                     loc_oForm.Show()
1759:                     IF loc_oForm.this_lSelecionou
1760:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1761:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1762:                     ENDIF
1763:                     ENDIF
1764:                 ENDIF
1765:                 IF USED("cursor_4c_BuscaCli")
1766:                     USE IN cursor_4c_BuscaCli
1767:                 ENDIF
1768:                 loc_oForm.Release()
1769:             ENDIF
1770:         CATCH TO loc_oErro
1771:             MsgErro("Erro em FormJrn.AbrirLookupFuncionario:" + CHR(13) + loc_oErro.Message, "Erro")
1772:         ENDTRY

*-- Linhas 1832 a 1851:
1832:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1833:                 ELSE
1834:                     IF !loc_oForm.this_lAchouRegistro
1835:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1836:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1837:                     loc_oForm.Show()
1838:                     IF loc_oForm.this_lSelecionou
1839:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1840:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1841:                     ENDIF
1842:                     ENDIF
1843:                 ENDIF
1844:                 IF USED("cursor_4c_BuscaCli")
1845:                     USE IN cursor_4c_BuscaCli
1846:                 ENDIF
1847:                 loc_oForm.Release()
1848:             ENDIF
1849:         CATCH TO loc_oErro
1850:             MsgErro("Erro em FormJrn.AbrirLookupFuncionarioPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
1851:         ENDTRY

*-- Linhas 2006 a 2026:
2006:             loc_oPagina.cmd_4c_CopiarMes.Enabled = .T.
2007:             loc_oPagina.cnt_4c_Saida.Enabled     = .T.
2008:             loc_oPagina.cnt_4c_Botoes.Enabled    = .T.
2009:             loc_oPagina.grd_4c_Lista.Enabled     = .T.
2010:             loc_oPagina.grd_4c_Lista.SetFocus()
2011:             loc_oPagina.grd_4c_Lista.Refresh()
2012:         CATCH TO loc_oErro
2013:             MsgErro("Erro em FormJrn.CopiaMesCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2014:         ENDTRY
2015:     ENDPROC
2016: 
2017:     *==========================================================================
2018:     * CopiaMesConfirmarClick - Executa copia da jornada para o mes selecionado
2019:     * Equivale ao Command2.Click de cntCopiaMes no legado
2020:     * Usa JrnBO.CopiarParaMes(ano, mes) com o registro carregado em BtnCopiarMesClick
2021:     *==========================================================================
2022:     PROCEDURE CopiaMesConfirmarClick()
2023:         LOCAL loc_oPagina, loc_cMesPara, loc_cRefsDest
2024:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
2025:         loc_cMesPara = ALLTRIM(NVL(loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para.Value, ""))
2026: 

