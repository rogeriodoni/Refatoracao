# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1163: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1569: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJrn.prg) - TRECHOS RELEVANTES PARA PASS GRID (2089 linhas total):

*-- Linhas 380 a 404:
380:         * Novo: Top=96+29=125, Left=32, Width=880 (ate cnt_4c_Saida.Left=917)
381:         * 14 colunas: iclis, cargos, refers, hora01-04, cDom-cSab
382:         *
383:         * ColumnCount FORA do WITH (Problema 36: nao criar colunas dentro de WITH)
384:         * ControlSource redefinido em CarregarLista apos RecordSource (Problema 48)
385:         *----------------------------------------------------------------------
386:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
387:         loc_oGrid = loc_oPagina.grd_4c_Lista
388: 
389:         loc_oGrid.ColumnCount = 14
390: 
391:         WITH loc_oGrid
392:             .Top                = 125
393:             .Left               = 32
394:             .Width              = 880
395:             .Height             = 470
396:             .FontName           = "Verdana"
397:             .FontSize           = 8
398:             .ForeColor          = RGB(90, 90, 90)
399:             .BackColor          = RGB(255, 255, 255)
400:             .GridLineColor      = RGB(238, 238, 238)
401:             .HighlightBackColor = RGB(255, 255, 255)
402:             .HighlightForeColor = RGB(15, 41, 104)
403:             .HighlightStyle     = 2
404:             .DeleteMark         = .F.

*-- Linhas 410 a 480:
410: 
411:             .Column1.Width           = 80
412:             .Column1.Alignment       = 0
413:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
414: 
415:             .Column2.Width           = 80
416:             .Column2.Alignment       = 0
417:             .Column2.Header1.Caption = "Cargo"
418: 
419:             .Column3.Width           = 52
420:             .Column3.Alignment       = 0
421:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
422: 
423:             .Column4.Width           = 45
424:             .Column4.Alignment       = 0
425:             .Column4.Header1.Caption = "Inicio"
426: 
427:             .Column5.Width           = 45
428:             .Column5.Alignment       = 0
429:             .Column5.Header1.Caption = "Intervalo"
430: 
431:             .Column6.Width           = 45
432:             .Column6.Alignment       = 0
433:             .Column6.Header1.Caption = "Intervalo"
434: 
435:             .Column7.Width           = 45
436:             .Column7.Alignment       = 0
437:             .Column7.Header1.Caption = "Fim"
438: 
439:             .Column8.Width            = 20
440:             .Column8.Alignment        = 2
441:             .Column8.Header1.Caption  = "Dom"
442: 
443:             .Column9.Width            = 20
444:             .Column9.Alignment        = 2
445:             .Column9.Header1.Caption  = "Seg"
446: 
447:             .Column10.Width           = 20
448:             .Column10.Alignment       = 2
449:             .Column10.Header1.Caption = "Ter"
450: 
451:             .Column11.Width           = 20
452:             .Column11.Alignment       = 2
453:             .Column11.Header1.Caption = "Qua"
454: 
455:             .Column12.Width           = 20
456:             .Column12.Alignment       = 2
457:             .Column12.Header1.Caption = "Qui"
458: 
459:             .Column13.Width           = 20
460:             .Column13.Alignment       = 2
461:             .Column13.Header1.Caption = "Sex"
462: 
463:             .Column14.Width           = 20
464:             .Column14.Alignment       = 2
465:             .Column14.Header1.Caption = "S" + CHR(225) + "b"
466:         ENDWITH
467: 
468:         *----------------------------------------------------------------------
469:         * Painel flutuante "Copiar Jornada do Mes" (Problema 26: iniciar oculto)
470:         * Original cntCopiaMes: Top=233, Left=280, Width=273, Height=136
471:         * Com compensacao PageFrame +29: Top=262
472:         *----------------------------------------------------------------------
473:         loc_oPagina.AddObject("cnt_4c_CopiaMes", "Container")
474:         WITH loc_oPagina.cnt_4c_CopiaMes
475:             .Top         = 262
476:             .Left        = 280
477:             .Width       = 273
478:             .Height      = 136
479:             .BackStyle   = 1
480:             .BackColor   = RGB(240, 240, 240)

*-- Linhas 531 a 549:
531:             .Left          = 71
532:             .Width         = 100
533:             .Height        = 24
534:             .ColumnCount   = 2
535:             .ColumnWidths  = "95,0"
536:             .BoundColumn   = 2
537:             .RowSourceType = 1
538:             .RowSource     = ""
539:             .Style         = 2
540:             .FontName      = "Tahoma"
541:             .FontSize      = 8
542:             .Visible       = .T.
543:         ENDWITH
544: 
545:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_Para", "Label")
546:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_Para
547:             .Caption   = "Para :"
548:             .Top       = 87
549:             .Left      = 31

*-- Linhas 563 a 581:
563:             .Left          = 71
564:             .Width         = 100
565:             .Height        = 24
566:             .ColumnCount   = 2
567:             .ColumnWidths  = "95,0"
568:             .BoundColumn   = 2
569:             .RowSourceType = 1
570:             .RowSource     = ""
571:             .Style         = 2
572:             .FontName      = "Tahoma"
573:             .FontSize      = 8
574:             .Visible       = .T.
575:         ENDWITH
576: 
577:         *-- Botao Confirmar (Command2 no legado: Top=39, Left=213, Width=40, Height=40)
578:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesOK", "CommandButton")
579:         WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK
580:             .Caption       = "OK"
581:             .Top           = 39

*-- Linhas 737 a 771:
737:             .Width           = 80
738:             .Height          = 24
739:             .BoundColumn     = 2
740:             .ColumnCount     = 2
741:             .ColumnWidths    = "0,70"
742:             .RowSourceType   = 1
743:             .RowSource       = loc_cRowMes
744:             .Style           = 2
745:             .FontName        = "Tahoma"
746:             .FontSize        = 8
747:             .Visible         = .T.
748:         ENDWITH
749: 
750:         loc_oPagina.AddObject("cbo_4c_CboAno", "ComboBox")
751:         WITH loc_oPagina.cbo_4c_CboAno
752:             .Top             = 165
753:             .Left            = 232
754:             .Width           = 60
755:             .Height          = 24
756:             .ColumnCount     = 1
757:             .ColumnWidths    = "55"
758:             .RowSourceType   = 1
759:             .RowSource       = loc_cAnos
760:             .Style           = 2
761:             .FontName        = "Tahoma"
762:             .FontSize        = 8
763:             .Visible         = .T.
764:         ENDWITH
765: 
766:         *----------------------------------------------------------------------
767:         * Funcionario: label + codigo + nome
768:         * Label2 "Funcionario :" Left=80, Top=166 -> Top=195
769:         * getCodCli: Left=148, Top=163 -> Top=192, Width=80
770:         * getDesCli: Left=232, Top=163 -> Top=192, Width=360
771:         *----------------------------------------------------------------------

*-- Linhas 1145 a 1181:
1145: 
1146:     *==========================================================================
1147:     * CarregarLista - Busca dados no BO e vincula ao grid
1148:     * Sequencia obrigatoria: Buscar -> RecordSource (fora WITH) -> AtualizarBinding
1149:     *==========================================================================
1150:     PROCEDURE CarregarLista()
1151:         LOCAL loc_lSucesso, loc_oGrid
1152:         loc_lSucesso = .F.
1153: 
1154:         TRY
1155:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1156:                 loc_lSucesso = .T.
1157:             ELSE
1158:                 IF THIS.this_oBusinessObject.Buscar("")
1159:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1160: 
1161:                     *-- RecordSource e ColumnCount FORA do WITH (Problema 36/48)
1162:                     loc_oGrid.ColumnCount = 3
1163:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1164:                     loc_oGrid.ColumnCount  = 14
1165: 
1166:                     *-- Redefine ControlSource + Headers apos RecordSource (Problema 48)
1167:                     THIS.AtualizarBindingGrid(loc_oGrid)
1168:                     THIS.FormatarGridLista(loc_oGrid)
1169:                     loc_oGrid.Refresh()
1170:                     loc_lSucesso = .T.
1171:                 ENDIF
1172:             ENDIF
1173:         CATCH TO loc_oErro
1174:             MsgErro("Erro em FormJrn.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
1175:         ENDTRY
1176: 
1177:         RETURN loc_lSucesso
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)

*-- Linhas 1201 a 1291:
1201: 
1202:     *==========================================================================
1203:     * AtualizarBindingGrid - Redefine ControlSource, Width e Header das 14 colunas
1204:     * Chamado apos RecordSource (Problema 48: auto-bind reseta ControlSource)
1205:     *==========================================================================
1206:     PROTECTED PROCEDURE AtualizarBindingGrid(par_oGrid)
1207:         WITH par_oGrid
1208:             .Column1.ControlSource   = "cursor_4c_Dados.iclis"
1209:             .Column1.Width           = 80
1210:             .Column1.Alignment       = 0
1211:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
1212: 
1213:             .Column2.ControlSource   = "cursor_4c_Dados.cargos"
1214:             .Column2.Width           = 80
1215:             .Column2.Alignment       = 0
1216:             .Column2.Header1.Caption = "Cargo"
1217: 
1218:             .Column3.ControlSource   = "cursor_4c_Dados.refers"
1219:             .Column3.Width           = 52
1220:             .Column3.Alignment       = 0
1221:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
1222: 
1223:             .Column4.ControlSource   = "cursor_4c_Dados.hora01"
1224:             .Column4.Width           = 45
1225:             .Column4.Alignment       = 0
1226:             .Column4.Header1.Caption = "Inicio"
1227: 
1228:             .Column5.ControlSource   = "cursor_4c_Dados.hora02"
1229:             .Column5.Width           = 45
1230:             .Column5.Alignment       = 0
1231:             .Column5.Header1.Caption = "Intervalo"
1232: 
1233:             .Column6.ControlSource   = "cursor_4c_Dados.hora03"
1234:             .Column6.Width           = 45
1235:             .Column6.Alignment       = 0
1236:             .Column6.Header1.Caption = "Intervalo"
1237: 
1238:             .Column7.ControlSource   = "cursor_4c_Dados.hora04"
1239:             .Column7.Width           = 45
1240:             .Column7.Alignment       = 0
1241:             .Column7.Header1.Caption = "Fim"
1242: 
1243:             .Column8.ControlSource   = "cursor_4c_Dados.cDom"
1244:             .Column8.Width           = 20
1245:             .Column8.Alignment       = 2
1246:             .Column8.Header1.Caption = "Dom"
1247: 
1248:             .Column9.ControlSource   = "cursor_4c_Dados.cSeg"
1249:             .Column9.Width           = 20
1250:             .Column9.Alignment       = 2
1251:             .Column9.Header1.Caption = "Seg"
1252: 
1253:             .Column10.ControlSource  = "cursor_4c_Dados.cTer"
1254:             .Column10.Width          = 20
1255:             .Column10.Alignment      = 2
1256:             .Column10.Header1.Caption = "Ter"
1257: 
1258:             .Column11.ControlSource  = "cursor_4c_Dados.cQua"
1259:             .Column11.Width          = 20
1260:             .Column11.Alignment      = 2
1261:             .Column11.Header1.Caption = "Qua"
1262: 
1263:             .Column12.ControlSource  = "cursor_4c_Dados.cQui"
1264:             .Column12.Width          = 20
1265:             .Column12.Alignment      = 2
1266:             .Column12.Header1.Caption = "Qui"
1267: 
1268:             .Column13.ControlSource  = "cursor_4c_Dados.cSex"
1269:             .Column13.Width          = 20
1270:             .Column13.Alignment      = 2
1271:             .Column13.Header1.Caption = "Sex"
1272: 
1273:             .Column14.ControlSource  = "cursor_4c_Dados.cSab"
1274:             .Column14.Width          = 20
1275:             .Column14.Alignment      = 2
1276:             .Column14.Header1.Caption = "S" + CHR(225) + "b"
1277:         ENDWITH
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * FormatarGridLista - Padroniza fonte de todas as colunas
1282:     *==========================================================================
1283:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1284:         WITH par_oGrid
1285:             .FontName = "Tahoma"
1286:             .FontSize = 8
1287:         ENDWITH
1288:     ENDPROC
1289: 
1290:     *==========================================================================
1291:     * BOParaForm - Copia propriedades do BO para os controles de Page2

*-- Linhas 1555 a 1585:
1555: 
1556:             IF VARTYPE(loc_cBusca) = "C"
1557:                 loc_cBusca = ALLTRIM(CHRTRAN(loc_cBusca, "'", ""))
1558: 
1559:                 IF !EMPTY(loc_cBusca)
1560:                     loc_cFiltro = "(a.iclis LIKE '%" + loc_cBusca + "%'" + ;
1561:                                   " OR a.cargos LIKE '%" + loc_cBusca + "%'" + ;
1562:                                   " OR a.refers LIKE '%" + loc_cBusca + "%'" + ;
1563:                                   " OR b.rclis LIKE '%" + loc_cBusca + "%')"
1564:                 ENDIF
1565: 
1566:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1567:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1568:                     loc_oGrid.ColumnCount = 3
1569:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1570:                     loc_oGrid.ColumnCount  = 14
1571:                     THIS.AtualizarBindingGrid(loc_oGrid)
1572:                     THIS.FormatarGridLista(loc_oGrid)
1573:                     loc_oGrid.Refresh()
1574:                 ENDIF
1575:             ENDIF
1576:         CATCH TO loc_oErro
1577:             MsgErro("Erro em FormJrn.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1578:         ENDTRY
1579:     ENDPROC
1580: 
1581:     *==========================================================================
1582:     * BtnEncerrarClick - Fecha o formulario
1583:     *==========================================================================
1584:     PROCEDURE BtnEncerrarClick()
1585:         THIS.Release()

*-- Linhas 1653 a 1695:
1653:         loc_oPagina.cmd_4c_CopiarMes.Enabled = .F.
1654:         loc_oPagina.cnt_4c_Saida.Enabled     = .F.
1655:         loc_oPagina.cnt_4c_Botoes.Enabled    = .F.
1656:         loc_oPagina.grd_4c_Lista.Enabled     = .F.
1657:         loc_oPagina.cnt_4c_CopiaMes.Visible  = .T.
1658:         loc_oPagina.cnt_4c_CopiaMes.SetFocus()
1659:     ENDPROC
1660: 
1661:     *==========================================================================
1662:     * Lookup Cargo (txt_4c_CodCgo -> SigCdCrg)
1663:     *==========================================================================
1664:     PROCEDURE AbrirLookupCargo()
1665:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1666:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1667:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)
1668: 
1669:         TRY
1670:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1671:                 "SigCdCrg", "cursor_4c_Busca", "ccargs", loc_cValor, ;
1672:                 "Sele" + CHR(231) + CHR(227) + "o de Cargos")
1673: 
1674:             IF VARTYPE(loc_oForm) = "O"
1675:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1676:                     loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1677:                 ELSE
1678:                     IF !loc_oForm.this_lAchouRegistro
1679:                     loc_oForm.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
1680:                     loc_oForm.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
1681:                     loc_oForm.Show()
1682:                     IF loc_oForm.this_lSelecionou
1683:                         loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1684:                     ENDIF
1685:                     ENDIF
1686:                 ENDIF
1687:                 IF USED("cursor_4c_Busca")
1688:                     USE IN cursor_4c_Busca
1689:                 ENDIF
1690:                 loc_oForm.Release()
1691:             ENDIF
1692:         CATCH TO loc_oErro
1693:             MsgErro("Erro em FormJrn.AbrirLookupCargo:" + CHR(13) + loc_oErro.Message, "Erro")
1694:         ENDTRY
1695:     ENDPROC

*-- Linhas 1751 a 1770:
1751:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1752:                 ELSE
1753:                     IF !loc_oForm.this_lAchouRegistro
1754:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1755:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1756:                     loc_oForm.Show()
1757:                     IF loc_oForm.this_lSelecionou
1758:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1759:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1760:                     ENDIF
1761:                     ENDIF
1762:                 ENDIF
1763:                 IF USED("cursor_4c_BuscaCli")
1764:                     USE IN cursor_4c_BuscaCli
1765:                 ENDIF
1766:                 loc_oForm.Release()
1767:             ENDIF
1768:         CATCH TO loc_oErro
1769:             MsgErro("Erro em FormJrn.AbrirLookupFuncionario:" + CHR(13) + loc_oErro.Message, "Erro")
1770:         ENDTRY

*-- Linhas 1830 a 1849:
1830:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1831:                 ELSE
1832:                     IF !loc_oForm.this_lAchouRegistro
1833:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1834:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1835:                     loc_oForm.Show()
1836:                     IF loc_oForm.this_lSelecionou
1837:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1838:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1839:                     ENDIF
1840:                     ENDIF
1841:                 ENDIF
1842:                 IF USED("cursor_4c_BuscaCli")
1843:                     USE IN cursor_4c_BuscaCli
1844:                 ENDIF
1845:                 loc_oForm.Release()
1846:             ENDIF
1847:         CATCH TO loc_oErro
1848:             MsgErro("Erro em FormJrn.AbrirLookupFuncionarioPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
1849:         ENDTRY

*-- Linhas 2004 a 2024:
2004:             loc_oPagina.cmd_4c_CopiarMes.Enabled = .T.
2005:             loc_oPagina.cnt_4c_Saida.Enabled     = .T.
2006:             loc_oPagina.cnt_4c_Botoes.Enabled    = .T.
2007:             loc_oPagina.grd_4c_Lista.Enabled     = .T.
2008:             loc_oPagina.grd_4c_Lista.SetFocus()
2009:             loc_oPagina.grd_4c_Lista.Refresh()
2010:         CATCH TO loc_oErro
2011:             MsgErro("Erro em FormJrn.CopiaMesCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2012:         ENDTRY
2013:     ENDPROC
2014: 
2015:     *==========================================================================
2016:     * CopiaMesConfirmarClick - Executa copia da jornada para o mes selecionado
2017:     * Equivale ao Command2.Click de cntCopiaMes no legado
2018:     * Usa JrnBO.CopiarParaMes(ano, mes) com o registro carregado em BtnCopiarMesClick
2019:     *==========================================================================
2020:     PROCEDURE CopiaMesConfirmarClick()
2021:         LOCAL loc_oPagina, loc_cMesPara, loc_cRefsDest
2022:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
2023:         loc_cMesPara = ALLTRIM(NVL(loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para.Value, ""))
2024: 

