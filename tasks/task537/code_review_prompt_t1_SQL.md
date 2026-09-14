# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = "crSigOpOpt.IndProds"
  ControlSource = "crSigOpOpt.Cods"
  ControlSource = "crSigOpOpt.AnaEsGrps"
  ControlSource = "crSigOpOpt.tfalhas"
  ControlSource = "crSigOpOpt.Descs"
  ControlSource = "crSigOpOpt.Pfalhas"
  ControlSource = "crSigOpOpt.Grupos"
  ControlSource = "crSigOpOpt.Contas"
  ControlSource = ""
  ControlSource = "crSigOpOpt.ctrlpds"
  ControlSource = "crSigOpOpt.valors"
  ControlSource = "crSigOpOpt.ChkDevs"
  ControlSource = "crSigOpOpt.Situas"
  ControlSource = "crSigOpOpt.Prodzs"
  ControlSource = "crSigOpOpt.Trabas"
  ControlSource = "crSigOpOpt.codAcbs"
  ControlSource = "crSigOpOpt.models"
  ControlSource = "crSigOpOpt.Emps"
  ControlSource = "crSigOpOpt.dupTpOps"
  ControlSource = "crSigOpOpt.retrab"
lcQryOpt = [Select * From SigOpOpt Where Emps = ']+_Empr+[' Or Emps = ' ' ]
Select crSigOpOpt
select crSigOpOpt
		select crSigOpOpt
	select crSigOpOpt

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormTml.prg) - TRECHOS RELEVANTES PARA PASS SQL (2262 linhas total):

*-- Linhas 358 a 376:
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle     = 2
361:             .DeleteMark         = .F.
362:             .RecordMark         = .F.
363:             .RowHeight          = 16
364:             .ScrollBars         = 2
365:             .GridLines          = 3
366:             .Visible            = .T.
367:         ENDWITH
368:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
369: 
370:         THIS.TornarControlesVisiveis(loc_oPagina)
371:     ENDPROC
372: 
373:     *===========================================================================
374:     * ConfigurarPaginaDados - Page2: cabecalho + container de botoes de acao
375:     * (Campos de dados: Fases 5-6; botoes Confirmar/Cancelar: Fase 4)
376:     *===========================================================================

*-- Linhas 1180 a 1203:
1180:         ENDIF
1181: 
1182:         TRY
1183:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1184:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
1185:                 "cursor_4c_ChkGcr")
1186: 
1187:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
1188:                 SELECT cursor_4c_ChkGcr
1189:                 loc_oPagina.txt_4c_G.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
1190:                 loc_oPagina.txt_4c__codacb.Enabled = .T.
1191:             ELSE
1192:                 loc_oPagina.txt_4c_G.Value = ""
1193:                 THIS.AbrirLookupGrupo()
1194:             ENDIF
1195: 
1196:             IF USED("cursor_4c_ChkGcr")
1197:                 USE IN cursor_4c_ChkGcr
1198:             ENDIF
1199:         CATCH TO loException
1200:             MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, "Erro")
1201:             IF USED("cursor_4c_ChkGcr")
1202:                 USE IN cursor_4c_ChkGcr
1203:             ENDIF

*-- Linhas 1217 a 1245:
1217:                 *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
1218:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
1219:                         AND USED("cursor_4c_BuscaGcr")
1220:                     SELECT cursor_4c_BuscaGcr
1221:                     loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1222:                     loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1223:                     loc_oPagina.txt_4c__codacb.Enabled = .T.
1224:                 ELSE
1225:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1226:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1227:                     loc_oBusca.Show()
1228: 
1229:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1230:                         SELECT cursor_4c_BuscaGcr
1231:                         IF !EOF("cursor_4c_BuscaGcr")
1232:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1233:                             loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1234:                             loc_oPagina.txt_4c__codacb.Enabled = .T.
1235:                         ELSE
1236:                             loc_oPagina.txt_4c_Grupo.Value = ""
1237:                             loc_oPagina.txt_4c_G.Value     = ""
1238:                             loc_oPagina.txt_4c__codacb.Enabled = .F.
1239:                         ENDIF
1240:                     ELSE
1241:                         loc_oPagina.txt_4c_Grupo.Value = ""
1242:                         loc_oPagina.txt_4c_G.Value     = ""
1243:                         loc_oPagina.txt_4c__codacb.Enabled = .F.
1244:                     ENDIF
1245:                 ENDIF

*-- Linhas 1295 a 1313:
1295:                 loc_oBusca.Show()
1296: 
1297:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1298:                     SELECT cursor_4c_BuscaGcr
1299:                     IF !EOF("cursor_4c_BuscaGcr")
1300:                         loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1301:                         loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1302:                         loc_oPagina.txt_4c__codacb.Enabled = .T.
1303:                     ELSE
1304:                         loc_oPagina.txt_4c_G.Value = ""
1305:                     ENDIF
1306:                 ELSE
1307:                     loc_oPagina.txt_4c_G.Value = ""
1308:                 ENDIF
1309: 
1310:                 loc_oBusca.Release()
1311:             ENDIF
1312: 
1313:             IF USED("cursor_4c_BuscaGcr")

*-- Linhas 1435 a 1458:
1435:         ENDIF
1436: 
1437:         TRY
1438:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1439:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCodigo), ;
1440:                 "cursor_4c_ChkAcb")
1441: 
1442:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkAcb") > 0
1443:                 SELECT cursor_4c_ChkAcb
1444:                 loc_oPagina.txt_4c__Dacb.Value = ALLTRIM(cursor_4c_ChkAcb.descrs)
1445:             ELSE
1446:                 loc_oPagina.txt_4c__Dacb.Value = ""
1447:                 THIS.AbrirLookupCodAcb()
1448:             ENDIF
1449: 
1450:             IF USED("cursor_4c_ChkAcb")
1451:                 USE IN cursor_4c_ChkAcb
1452:             ENDIF
1453:         CATCH TO loException
1454:             MsgErro("Erro ao validar tipo de acabamento:" + CHR(13) + loException.Message, "Erro")
1455:             IF USED("cursor_4c_ChkAcb")
1456:                 USE IN cursor_4c_ChkAcb
1457:             ENDIF
1458:         ENDTRY

*-- Linhas 1472 a 1499:
1472:                 *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
1473:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
1474:                         AND USED("cursor_4c_BuscaAcb")
1475:                     SELECT cursor_4c_BuscaAcb
1476:                     loc_oPagina.txt_4c__codacb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
1477:                     loc_oPagina.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
1478:                 ELSE
1479:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
1480:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1481:                     loc_oBusca.Show()
1482: 
1483:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
1484:                         SELECT cursor_4c_BuscaAcb
1485:                         IF !EOF("cursor_4c_BuscaAcb")
1486:                             loc_oPagina.txt_4c__codacb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
1487:                             loc_oPagina.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
1488:                         ELSE
1489:                             loc_oPagina.txt_4c__codacb.Value = ""
1490:                             loc_oPagina.txt_4c__Dacb.Value   = ""
1491:                         ENDIF
1492:                     ELSE
1493:                         loc_oPagina.txt_4c__codacb.Value = ""
1494:                         loc_oPagina.txt_4c__Dacb.Value   = ""
1495:                     ENDIF
1496:                 ENDIF
1497: 
1498:                 loc_oBusca.Release()
1499:             ENDIF

*-- Linhas 1536 a 1555:
1536:         ENDIF
1537: 
1538:         TRY
1539:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1540:                 "SELECT cEmps FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cCodigo), ;
1541:                 "cursor_4c_ChkEmp")
1542: 
1543:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkEmp") = 0
1544:                 THIS.AbrirLookupEmpPad()
1545:             ENDIF
1546: 
1547:             IF USED("cursor_4c_ChkEmp")
1548:                 USE IN cursor_4c_ChkEmp
1549:             ENDIF
1550:         CATCH TO loException
1551:             MsgErro("Erro ao validar empresa:" + CHR(13) + loException.Message, "Erro")
1552:             IF USED("cursor_4c_ChkEmp")
1553:                 USE IN cursor_4c_ChkEmp
1554:             ENDIF
1555:         ENDTRY

*-- Linhas 1568 a 1594:
1568:                 *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
1569:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
1570:                         AND USED("cursor_4c_BuscaEmp")
1571:                     SELECT cursor_4c_BuscaEmp
1572:                     loc_oPagina.txt_4c_EmpPad.Value = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1573:                 ELSE
1574:                     loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
1575:                     loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1576:                     loc_oBusca.Show()
1577: 
1578:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1579:                         SELECT cursor_4c_BuscaEmp
1580:                         loc_oPagina.txt_4c_EmpPad.Value = IIF(!EOF("cursor_4c_BuscaEmp"), ;
1581:                             ALLTRIM(cursor_4c_BuscaEmp.cEmps), "")
1582:                     ELSE
1583:                         loc_oPagina.txt_4c_EmpPad.Value = ""
1584:                     ENDIF
1585:                 ENDIF
1586: 
1587:                 loc_oBusca.Release()
1588:             ENDIF
1589: 
1590:             IF USED("cursor_4c_BuscaEmp")
1591:                 USE IN cursor_4c_BuscaEmp
1592:             ENDIF
1593:         CATCH TO loException
1594:             MsgErro("Erro ao abrir busca de empresa:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1600 a 1645:
1600: 
1601:     *===========================================================================
1602:     * CarregarLista - Carrega dados no grid da Page1
1603:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
1604:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
1605:     * Colunas (legado SIGCDTML.Init): Cods(115), descs(270), pfalhas(80),
1606:     * Grupos(80), CodAcbs(40, invisivel no legado - .f. no pColuna)
1607:     *===========================================================================
1608:     PROCEDURE CarregarLista()
1609:         LOCAL loc_lResultado, loc_oGrid
1610:         loc_lResultado = .F.
1611: 
1612:         TRY
1613:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1614:                 loc_lResultado = .T.
1615:             ELSE
1616:                 IF !THIS.this_oBusinessObject.Buscar("")
1617:                     loc_lResultado = .F.
1618:                 ELSE
1619:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1620: 
1621:                     *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
1622:                     loc_oGrid.ColumnCount = 5
1623:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1624: 
1625:                     *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
1626:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1627:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1628:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.pfalhas"
1629:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grupos"
1630:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.codacbs"
1631: 
1632:                     loc_oGrid.Column1.Width = 115
1633:                     loc_oGrid.Column2.Width = 270
1634:                     loc_oGrid.Column3.Width = 80
1635:                     loc_oGrid.Column4.Width = 80
1636:                     loc_oGrid.Column5.Width = 40
1637: 
1638:                     *-- Coluna CodAcbs eh invisivel no legado (pColuna(..., .f.))
1639:                     loc_oGrid.Column5.Visible = .F.
1640: 
1641:                     *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
1642:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1643:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1644:                     loc_oGrid.Column3.Header1.Caption = "Falha"
1645:                     loc_oGrid.Column4.Header1.Caption = "Grupo"

*-- Linhas 1801 a 1849:
1801:             *-- Descricao do Grupo (SigCdGcr.descrs) - somente consulta, sem abrir lookup
1802:             loc_oPagina.txt_4c_G.Value = ""
1803:             IF !EMPTY(ALLTRIM(loc_oBO.this_cGrupos))
1804:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1805:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cGrupos)), ;
1806:                     "cursor_4c_ChkGcr")
1807:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
1808:                     loc_oPagina.txt_4c_G.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
1809:                 ENDIF
1810:                 IF USED("cursor_4c_ChkGcr")
1811:                     USE IN cursor_4c_ChkGcr
1812:                 ENDIF
1813:             ENDIF
1814:             loc_oPagina.txt_4c__codacb.Enabled = !EMPTY(ALLTRIM(loc_oBO.this_cGrupos))
1815: 
1816:             *-- Descricao da Conta (SigCdCli.rclis) - somente consulta, sem abrir lookup
1817:             loc_oPagina.txt_4c_C.Value = ""
1818:             IF !EMPTY(ALLTRIM(loc_oBO.this_cContas))
1819:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1820:                     "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(ALLTRIM(loc_oBO.this_cContas)), ;
1821:                     "cursor_4c_ChkCli")
1822:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
1823:                     loc_oPagina.txt_4c_C.Value = ALLTRIM(cursor_4c_ChkCli.rclis)
1824:                 ENDIF
1825:                 IF USED("cursor_4c_ChkCli")
1826:                     USE IN cursor_4c_ChkCli
1827:                 ENDIF
1828:             ENDIF
1829: 
1830:             *-- Descricao do Tipo de Acabamento (SigCdAca.descrs) - somente consulta, sem abrir lookup
1831:             loc_oPagina.txt_4c__Dacb.Value = ""
1832:             IF !EMPTY(ALLTRIM(loc_oBO.this_cCodAcbs))
1833:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1834:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(ALLTRIM(loc_oBO.this_cCodAcbs)), ;
1835:                     "cursor_4c_ChkAcb")
1836:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkAcb") > 0
1837:                     loc_oPagina.txt_4c__Dacb.Value = ALLTRIM(cursor_4c_ChkAcb.descrs)
1838:                 ENDIF
1839:                 IF USED("cursor_4c_ChkAcb")
1840:                     USE IN cursor_4c_ChkAcb
1841:                 ENDIF
1842:             ENDIF
1843:         CATCH TO loException
1844:             MsgErro("Erro ao carregar dados no formul" + CHR(225) + "rio:" + CHR(13) + ;
1845:                 loException.Message, "Erro")
1846:         ENDTRY
1847:     ENDPROC
1848: 
1849:     *===========================================================================

*-- Linhas 1959 a 1977:
1959:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1960:                 MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1961:             ELSE
1962:                 SELECT cursor_4c_Dados
1963:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1964: 
1965:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1966:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.", "Erro")
1967:                 ELSE
1968:                     THIS.this_oBusinessObject.EditarRegistro()
1969:                     THIS.BOParaForm()
1970:                     THIS.this_cModoAtual = "ALTERAR"
1971:                     THIS.HabilitarCampos(.T.)
1972:                     THIS.AjustarBotoesPorModo()
1973:                     THIS.AlternarPagina(2)
1974:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
1975:                 ENDIF
1976:             ENDIF
1977:         CATCH TO loException

*-- Linhas 1990 a 2008:
1990:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1991:                 MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
1992:             ELSE
1993:                 SELECT cursor_4c_Dados
1994:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1995: 
1996:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1997:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.", "Erro")
1998:                 ELSE
1999:                     THIS.BOParaForm()
2000:                     THIS.this_cModoAtual = "VISUALIZAR"
2001:                     THIS.HabilitarCampos(.F.)
2002:                     THIS.AjustarBotoesPorModo()
2003:                     THIS.AlternarPagina(2)
2004:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
2005:                 ENDIF
2006:             ENDIF
2007:         CATCH TO loException
2008:             MsgErro("Erro ao visualizar registro:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 2020 a 2038:
2020:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2021:                 MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
2022:             ELSE
2023:                 SELECT cursor_4c_Dados
2024:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
2025:                 loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cods)
2026: 
2027:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do tipo de material " + ;
2028:                         loc_cCodigo + " ?", "Confirma" + CHR(231) + CHR(227) + "o de Exclus" + CHR(227) + "o")
2029:                     IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
2030:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro para " + ;
2031:                             "exclus" + CHR(227) + "o.", "Erro")
2032:                     ELSE
2033:                         IF THIS.this_oBusinessObject.Excluir()
2034:                             MsgExcluidoSucesso()
2035:                             THIS.CarregarLista()
2036:                         ELSE
2037:                             MsgErro("Erro ao excluir registro:" + CHR(13) + ;
2038:                                 THIS.this_oBusinessObject.this_cMensagemErro, "Erro")

*-- Linhas 2066 a 2096:
2066:                 loc_oBusca.Show()
2067: 
2068:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTml")
2069:                     SELECT cursor_4c_BuscaTml
2070:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTml.cods)
2071:                 ENDIF
2072: 
2073:                 loc_oBusca.Release()
2074:             ENDIF
2075: 
2076:             IF USED("cursor_4c_BuscaTml")
2077:                 USE IN cursor_4c_BuscaTml
2078:             ENDIF
2079: 
2080:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2081:                 SELECT cursor_4c_Dados
2082:                 LOCATE FOR ALLTRIM(cods) == loc_cCodigo
2083:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2084:             ENDIF
2085: 
2086:         CATCH TO loException
2087:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTml.BtnBuscarClick")
2088:             IF USED("cursor_4c_BuscaTml")
2089:                 USE IN cursor_4c_BuscaTml
2090:             ENDIF
2091:         ENDTRY
2092:     ENDPROC
2093: 
2094:     *===========================================================================
2095:     * BtnEncerrarClick - Fecha o formulario
2096:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)

*-- Linhas 2136 a 2155:
2136: 
2137:         IF THIS.this_cModoAtual = "INCLUIR"
2138:             TRY
2139:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2140:                     "SELECT cidchaves FROM SigOpOpt WHERE RTRIM(cods) = " + EscaparSQL(loc_cCodigo), ;
2141:                     "cursor_4c_ChkDup")
2142: 
2143:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
2144:                     loc_lDuplicado = .T.
2145:                 ENDIF
2146: 
2147:                 IF USED("cursor_4c_ChkDup")
2148:                     USE IN cursor_4c_ChkDup
2149:                 ENDIF
2150:             CATCH TO loException
2151:                 MsgErro("Erro ao validar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "Erro")
2152:                 loc_lErroValidacao = .T.
2153:                 IF USED("cursor_4c_ChkDup")
2154:                     USE IN cursor_4c_ChkDup
2155:                 ENDIF


### BO (C:\4c\projeto\app\classes\TmlBO.prg):
*====================================================================
* TmlBO.prg
*
* Business Object para Tipos de Material (SigCdTml / SIGCDTML)
* Tabela principal: SigOpOpt (cidchaves PK tecnica, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TmlBO AS BusinessBase

	*-- Propriedades da entidade (SigOpOpt) - todas as 21 colunas da tabela
	this_cCidchaves  = ""    && cidchaves char(20)  - PK tecnica (UUID fUniqueIds, Replace no legado)
	this_cCods       = ""    && cods char(15)       - codigo (chave de negocio, unicidade validada no Salvar)
	this_cDescs      = ""    && descs char(40)      - descricao do tipo de material
	this_cGeraccs    = " "   && geraccs char(1)     - NOT NULL, sem campo na UI legada (default espaco)
	this_nPfalhas    = 0     && pfalhas numeric(5,2)  - falha admitida
	this_cGrupos     = ""    && grupos char(10)     - grupo (FK SigCdGcr.Codigos)
	this_cContas     = ""    && contas char(10)     - conta (FK SigCdCli.Iclis)
	this_cTfalhas    = ""    && tfalhas char(1)     - [P]ercentual ou [Q]uantidade
	this_cCtrlpds    = ""    && ctrlpds char(1)     - Analisa Producao (S/N)
	this_nValors     = 0     && valors numeric(7,2)   - valor
	this_nSituas     = 1     && situas numeric(1,0)   - situacao (OptionGroup: 1=Ativo,2=Inativo,3=Falhas/Perdas)
	this_nProdzs     = 0     && prodzs numeric(1,0)   - checkbox Produzido
	this_nTrabas     = 0     && trabas numeric(1,0)   - checkbox Trabalhado
	this_cAnaEsGrps  = ""    && anaesgrps char(1)   - Lancar Somente (E/S)
	this_cChkDevs    = ""    && chkdevs char(1)     - Checar Devolucao (S/N)
	this_cCodAcbs    = ""    && codacbs char(3)     - Tipo Acabamento (FK SigCdAca.Cods)
	this_nModels     = 0     && models numeric(1,0)   - checkbox Modelagem
	this_cEmps       = ""    && cemps char(3)        - Empresa (FK SigCdEmp.CEmps)
	this_nDupTpOps   = 0     && duptpops numeric(1,0) - checkbox Checar Duplicidade
	this_nRetrab     = 0     && retrab numeric(1,0)   - checkbox Aceita Retrabalho
	this_nIndProds   = 0     && indprods numeric(4,2)  - indice de produtividade

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela     = "SigOpOpt"
		THIS.this_cCampoChave = "cidchaves"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de tipos de material no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
				           " grupos, contas, tfalhas, ctrlpds, valors," + ;
				           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
				           " codacbs, models, emps, duptpops, retrab, indprods" + ;
				           " FROM SigOpOpt" + ;
				           " ORDER BY cods"
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
				           " grupos, contas, tfalhas, ctrlpds, valors," + ;
				           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
				           " codacbs, models, emps, duptpops, retrab, indprods" + ;
				           " FROM SigOpOpt" + ;
				           " WHERE RTRIM(cods) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY cods"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tipos de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tipos de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
			           " grupos, contas, tfalhas, ctrlpds, valors," + ;
			           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
			           " codacbs, models, emps, duptpops, retrab, indprods" + ;
			           " FROM SigOpOpt" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			THIS.this_cGeraccs   = TratarNulo(geraccs, "C")
			THIS.this_nPfalhas   = TratarNulo(pfalhas, "N")
			THIS.this_cGrupos    = TratarNulo(grupos, "C")
			THIS.this_cContas    = TratarNulo(contas, "C")
			THIS.this_cTfalhas   = TratarNulo(tfalhas, "C")
			THIS.this_cCtrlpds   = TratarNulo(ctrlpds, "C")
			THIS.this_nValors    = TratarNulo(valors, "N")
			THIS.this_nSituas    = TratarNulo(situas, "N")
			THIS.this_nProdzs    = TratarNulo(prodzs, "N")
			THIS.this_nTrabas    = TratarNulo(trabas, "N")
			THIS.this_cAnaEsGrps = TratarNulo(anaesgrps, "C")
			THIS.this_cChkDevs   = TratarNulo(chkdevs, "C")
			THIS.this_cCodAcbs   = TratarNulo(codacbs, "C")
			THIS.this_nModels    = TratarNulo(models, "N")
			THIS.this_cEmps      = TratarNulo(emps, "C")
			THIS.this_nDupTpOps  = TratarNulo(duptpops, "N")
			THIS.this_nRetrab    = TratarNulo(retrab, "N")
			THIS.this_nIndProds  = TratarNulo(indprods, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SigOpOpt (cidchaves, cods, descs, geraccs, pfalhas," + ;
			           " grupos, contas, tfalhas, ctrlpds, valors," + ;
			           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
			           " codacbs, models, emps, duptpops, retrab, indprods)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 15)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 40)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cGeraccs, " ")), 1)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPfalhas, 2) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cTfalhas), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtrlpds), 1)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nValors, 2) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nProdzs, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrabas, 0) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cAnaEsGrps), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cChkDevs), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodAcbs), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nModels, 0) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nDupTpOps, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nRetrab, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nIndProds, 2) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigOpOpt SET" + ;
			           " cods = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 15)) + "," + ;
			           " descs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 40)) + "," + ;
			           " geraccs = " + EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cGeraccs, " ")), 1)) + "," + ;
			           " pfalhas = " + FormatarNumeroSQL(THIS.this_nPfalhas, 2) + "," + ;
			           " grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
			           " contas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
			           " tfalhas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTfalhas), 1)) + "," + ;
			           " ctrlpds = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtrlpds), 1)) + "," + ;
			           " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + "," + ;
			           " situas = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
			           " prodzs = " + FormatarNumeroSQL(THIS.this_nProdzs, 0) + "," + ;
			           " trabas = " + FormatarNumeroSQL(THIS.this_nTrabas, 0) + "," + ;
			           " anaesgrps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cAnaEsGrps), 1)) + "," + ;
			           " chkdevs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cChkDevs), 1)) + "," + ;
			           " codacbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodAcbs), 3)) + "," + ;
			           " models = " + FormatarNumeroSQL(THIS.this_nModels, 0) + "," + ;
			           " emps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
			           " duptpops = " + FormatarNumeroSQL(THIS.this_nDupTpOps, 0) + "," + ;
			           " retrab = " + FormatarNumeroSQL(THIS.this_nRetrab, 0) + "," + ;
			           " indprods = " + FormatarNumeroSQL(THIS.this_nIndProds, 2) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigOpOpt WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

