# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DTENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, LNNRTIPO, EMPS, NOTAS, GRUCARTS, CONCARTS, GRUPOS, CONTAS, GRCLIS, ICLIS, LCTITULO, CONTAT, NUMS, 0, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VENCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, LNNRTIPO, EMPS, NOTAS, GRUCARTS, CONCARTS, GRUPOS, CONTAS, GRCLIS, ICLIS, LCTITULO, CONTAT, NUMS, 0, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, LNNRTIPO, EMPS, NOTAS, GRUCARTS, CONCARTS, GRUPOS, CONTAS, GRCLIS, ICLIS, LCTITULO, CONTAT, NUMS, 0, OPERACAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, LNNRTIPO, EMPS, NOTAS, GRUCARTS, CONCARTS, GRUPOS, CONTAS, GRCLIS, ICLIS, LCTITULO, CONTAT, NUMS, 0, OPERACAOS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
		.SqlExecute([Select * From SigCdOpt],'crSigCdOpt')
lcSql = [Select TitOpcS, TitOpcN, TitOpcA From SigCdPac]
If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac') < 1
Select LocalParac
Select crSigCdOpt
	Insert Into csOperacaos (Marcas, Operacaos, Tipos) Values (.f., crSigCdOpt.Operacaos, crSigCdOpt.Tipos)
Select csOperacaos
	.DeleteMark = .f.
	.Column1.ControlSource = 'csOperacaos.Marcas'
	.Column2.ControlSource = 'csOperacaos.Operacaos'
	.Column3.ControlSource = 'csOperacaos.Tipos'
	.DeleteMark = .f.
	.Column1.ControlSource = 'csImprimir.Marcas'
	.Column2.ControlSource = 'csImprimir.Campos'
Insert Into csImprimir (Marcas, Campos) Values (.t., 'Código')
Insert Into csImprimir (Marcas, Campos) Values (.f., 'C.P.F.')
Insert Into csImprimir (Marcas, Campos) Values (.f., 'Nome')
Insert Into csImprimir (Marcas, Campos) Values (.f., 'C.P.F. T')
Select csOperacaos
Select csSelecionados
Insert Into CsCabecalho (NomeEmpresa, Titulo, Periodo, Operacao, Carteira, Deposito, ;
vSql = [Select a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ]+;
       [From SigCqChm a, SigCdCli d, SigCdCli e, ]+;
       [SigChe b left join SigCdCli f on b.grupot = f.grupos and b.contat = f.iclis ] +; 
ThisForm.podatamgr.SqlExecute(vSql,"csRelatorio0")
	Select *,Space(Len(lcQuebra)+20) as Quebra From CsRelatorio0 Where 0 = 1 Into Cursor CsResultado ReadWrite
	Select a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
		   From csRelatorio0 a, csOperacaos c ;
	Select CsSelecao
		Select CsResultado
		Select CsSelecao
	Select a.* From CsResultado a ;
	Select a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
		   From csRelatorio0 a, csOperacaos c ;
Select csRelatorio
	Select * From csOperacaos Where Marcas Into Cursor csTmpOpe
	Select * From csImprimir Where Marcas Into Cursor csSelecionados
	Select csImprimir
	Select csImprimir
Select csImprimir
	Select csOperacaos
Select csOperacaos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreche.prg) - TRECHOS RELEVANTES PARA PASS SQL (2194 linhas total):

*-- Linhas 1070 a 1125:
1070:             .ColumnCount  = 3
1071:             .RecordSource = "cursor_4c_Operacoes"
1072:             .RecordMark   = .F.
1073:             .DeleteMark   = .F.
1074:             .ScrollBars   = 2
1075:             .RowHeight    = 18
1076:             .FontName     = "Verdana"
1077:             .FontSize     = 8
1078:             .ForeColor    = RGB(90, 90, 90)
1079:             .BackColor    = RGB(255, 255, 255)
1080:             .GridLineColor = RGB(238, 238, 238)
1081:             .HighlightStyle = 2
1082:             .Visible      = .T.
1083: 
1084:             *-- Coluna 1: CheckBox para marcar operacao (LOGICAL)
1085:             WITH .Column1
1086:                 .Width   = 22
1087:                 .Resizable = .F.
1088:                 .AddObject("Check1", "CheckBox")
1089:                 WITH .Check1
1090:                     .Caption  = ""
1091:                     .Value    = 0
1092:                     .Visible  = .T.
1093:                 ENDWITH
1094:                 .CurrentControl  = "Check1"
1095:                 .ControlSource   = "cursor_4c_Operacoes.Marcas"
1096:                 .Header1.Caption = ""
1097:             ENDWITH
1098: 
1099:             *-- Coluna 2: Descricao da operacao
1100:             WITH .Column2
1101:                 .Width          = 96
1102:                 .ControlSource  = "cursor_4c_Operacoes.Operacaos"
1103:                 .ReadOnly       = .T.
1104:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1105:             ENDWITH
1106: 
1107:             *-- Coluna 3: Tipo da operacao
1108:             WITH .Column3
1109:                 .Width          = 40
1110:                 .ControlSource  = "cursor_4c_Operacoes.Tipos"
1111:                 .ReadOnly       = .T.
1112:                 .Header1.Caption = "Tipo"
1113:             ENDWITH
1114:         ENDWITH
1115: 
1116:         loc_oGrid = THIS.grd_4c_Operacoes
1117:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckOperacoes")
1118:         BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckOperacoes")
1119:     ENDPROC
1120: 
1121:     *==========================================================================
1122:     * CONFIGURARGRIDIMPRIMIR - Grid de selecao de campos de impressao (2 colunas)
1123:     * Cursor: cursor_4c_Imprimir (Marcas L, Campos C20)
1124:     * Original: grdImprimir Top=311, Left=101, Width=188, Height=58
1125:     *==========================================================================

*-- Linhas 1149 a 1196:
1149:             .ColumnCount  = 2
1150:             .RecordSource = "cursor_4c_Imprimir"
1151:             .RecordMark   = .F.
1152:             .DeleteMark   = .F.
1153:             .ScrollBars   = 2
1154:             .RowHeight    = 18
1155:             .FontName     = "Verdana"
1156:             .FontSize     = 8
1157:             .ForeColor    = RGB(90, 90, 90)
1158:             .BackColor    = RGB(255, 255, 255)
1159:             .GridLineColor = RGB(238, 238, 238)
1160:             .HighlightStyle = 2
1161:             .Visible      = .T.
1162: 
1163:             *-- Coluna 1: CheckBox para marcar campo (LOGICAL)
1164:             WITH .Column1
1165:                 .Width   = 22
1166:                 .Resizable = .F.
1167:                 .AddObject("Check1", "CheckBox")
1168:                 WITH .Check1
1169:                     .Caption  = ""
1170:                     .Value    = 0
1171:                     .Visible  = .T.
1172:                 ENDWITH
1173:                 .CurrentControl  = "Check1"
1174:                 .ControlSource   = "cursor_4c_Imprimir.Marcas"
1175:                 .Header1.Caption = ""
1176:             ENDWITH
1177: 
1178:             *-- Coluna 2: Nome do campo de impressao
1179:             WITH .Column2
1180:                 .Width           = 146
1181:                 .ControlSource   = "cursor_4c_Imprimir.Campos"
1182:                 .ReadOnly        = .T.
1183:                 .Header1.Caption = "Campo"
1184:             ENDWITH
1185:         ENDWITH
1186: 
1187:         loc_oGrid = THIS.grd_4c_Imprimir
1188:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckImprimir")
1189:         BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckImprimir")
1190:     ENDPROC
1191: 
1192:     *==========================================================================
1193:     * LIMPARCAMPOS - Restaura campos de filtro para valores padrao
1194:     *==========================================================================
1195:     PROCEDURE LimparCampos()
1196:         IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)

*-- Linhas 1415 a 1462:
1415:     PROCEDURE TeclaCheckOperacoes(par_nKeyCode, par_nShift)
1416:         IF par_nKeyCode = 13 OR par_nKeyCode = 32
1417:             IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
1418:                 SELECT cursor_4c_Operacoes
1419:                 REPLACE Marcas WITH !Marcas
1420:                 THIS.grd_4c_Operacoes.Refresh()
1421:             ENDIF
1422:         ENDIF
1423:         IF par_nKeyCode = 9
1424:             IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
1425:                 THIS.obj_4c_NrTipo.Buttons(1).SetFocus()
1426:             ENDIF
1427:         ENDIF
1428:     ENDPROC
1429: 
1430:     PROCEDURE TeclaCheckImprimir(par_nKeyCode, par_nShift)
1431:         IF par_nKeyCode = 13 OR par_nKeyCode = 32
1432:             IF USED("cursor_4c_Imprimir") AND !EOF("cursor_4c_Imprimir")
1433:                 SELECT cursor_4c_Imprimir
1434:                 REPLACE Marcas WITH !Marcas
1435:                 THIS.grd_4c_Imprimir.Refresh()
1436:             ENDIF
1437:         ENDIF
1438:         IF par_nKeyCode = 9
1439:             IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
1440:                 THIS.cbo_4c_Ordem.SetFocus()
1441:             ENDIF
1442:         ENDIF
1443:     ENDPROC
1444: 
1445:     *==========================================================================
1446:     * CLIQUECHECKOPERACOES - Refresh do grid apos toggle por clique de mouse
1447:     * O ControlSource atualiza Marcas automaticamente; apenas sincroniza display
1448:     *==========================================================================
1449:     PROCEDURE CliqueCheckOperacoes()
1450:         IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
1451:             THIS.grd_4c_Operacoes.Refresh()
1452:         ENDIF
1453:     ENDPROC
1454: 
1455:     *==========================================================================
1456:     * CLIQUECHECKIMPRIMIR - Refresh do grid apos toggle por clique de mouse
1457:     *==========================================================================
1458:     PROCEDURE CliqueCheckImprimir()
1459:         IF PEMSTATUS(THIS, "grd_4c_Imprimir", 5)
1460:             THIS.grd_4c_Imprimir.Refresh()
1461:         ENDIF
1462:     ENDPROC

*-- Linhas 1472 a 1493:
1472:             THIS.txt_4c_DsEmpresa.Value = ""
1473:             RETURN
1474:         ENDIF
1475:         loc_cSQL    = "SELECT cEmps, Razas FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cCodigo)
1476:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1477:         IF loc_nResult > 0 AND USED("cursor_4c_EmpVal")
1478:             SELECT cursor_4c_EmpVal
1479:             IF !EOF()
1480:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(Razas)
1481:             ELSE
1482:                 THIS.txt_4c_CdEmpresa.Value = ""
1483:                 THIS.txt_4c_DsEmpresa.Value = ""
1484:                 THIS.AbrirBuscaEmpresa()
1485:             ENDIF
1486:             USE IN cursor_4c_EmpVal
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     PROCEDURE ValidarDsEmpresa()
1491:         LOCAL loc_cNome
1492:         loc_cNome = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
1493:         IF EMPTY(loc_cNome)

*-- Linhas 1532 a 1554:
1532:             THIS.txt_4c_DsCarConta.Value = ""
1533:             RETURN
1534:         ENDIF
1535:         loc_cSQL    = "SELECT DISTINCT GruCarts AS Codigo, GruCarts AS Descricao " + ;
1536:                       "FROM SigCqChm WHERE GruCarts = " + EscaparSQL(loc_cCodigo)
1537:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoVal")
1538:         IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoVal")
1539:             SELECT cursor_4c_CarGrupoVal
1540:             IF !EOF()
1541:                 THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(Codigo)
1542:             ELSE
1543:                 THIS.txt_4c_CdCarGrupo.Value = ""
1544:                 THIS.txt_4c_DsCarGrupo.Value = ""
1545:                 THIS.txt_4c_CdCarConta.Value = ""
1546:                 THIS.txt_4c_DsCarConta.Value = ""
1547:             ENDIF
1548:             USE IN cursor_4c_CarGrupoVal
1549:         ENDIF
1550:     ENDPROC
1551: 
1552:     PROCEDURE ValidarDsCarGrupo()
1553:         LOCAL loc_cDescricao
1554:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarGrupo.Value)

*-- Linhas 1564 a 1584:
1564:     PROCEDURE AbrirBuscaCarGrupo()
1565:         LOCAL loLookup, loc_cSQL, loc_nResult
1566:         TRY
1567:             loc_cSQL = "SELECT DISTINCT GruCarts AS codigo, GruCarts AS descricao " + ;
1568:                        "FROM SigCqChm ORDER BY GruCarts"
1569:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoLst")
1570:             IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoLst")
1571:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1572:                 IF VARTYPE(loLookup) = "O"
1573:                     loLookup.ConfigurarBuscaCursor("cursor_4c_CarGrupoLst", ;
1574:                         "codigo", "descricao", "Grupo Carteira", ;
1575:                         ALLTRIM(THIS.txt_4c_CdCarGrupo.Value))
1576:                     loLookup.Show()
1577:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1578:                         THIS.txt_4c_CdCarGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1579:                         THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1580:                         THIS.txt_4c_CdCarConta.Value = ""
1581:                         THIS.txt_4c_DsCarConta.Value = ""
1582:                     ENDIF
1583:                     loLookup = .NULL.
1584:                 ENDIF

*-- Linhas 1601 a 1626:
1601:             THIS.txt_4c_DsCarConta.Value = ""
1602:             RETURN
1603:         ENDIF
1604:         loc_cSQL = "SELECT DISTINCT ConCarts AS Codigo, Iclis AS Descricao " + ;
1605:                    "FROM SigCqChm WHERE ConCarts = " + EscaparSQL(loc_cCodigo)
1606:         IF !EMPTY(loc_cGrupo)
1607:             loc_cSQL = loc_cSQL + " AND GruCarts = " + EscaparSQL(loc_cGrupo)
1608:         ENDIF
1609:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaVal")
1610:         IF loc_nResult > 0 AND USED("cursor_4c_CarContaVal")
1611:             SELECT cursor_4c_CarContaVal
1612:             IF !EOF()
1613:                 THIS.txt_4c_DsCarConta.Value = ALLTRIM(Codigo)
1614:             ELSE
1615:                 MsgAviso("Acesso Negado!!", "Carteira")
1616:                 THIS.txt_4c_CdCarConta.Value = ""
1617:                 THIS.txt_4c_DsCarConta.Value = ""
1618:             ENDIF
1619:             USE IN cursor_4c_CarContaVal
1620:         ENDIF
1621:     ENDPROC
1622: 
1623:     PROCEDURE ValidarDsCarConta()
1624:         LOCAL loc_cDescricao
1625:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarConta.Value)
1626:         IF EMPTY(loc_cDescricao)

*-- Linhas 1634 a 1658:
1634:         LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
1635:         TRY
1636:             loc_cGrupo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
1637:             loc_cSQL   = "SELECT DISTINCT ConCarts AS codigo, ConCarts AS descricao " + ;
1638:                          "FROM SigCqChm WHERE 1=1"
1639:             IF !EMPTY(loc_cGrupo)
1640:                 loc_cSQL = loc_cSQL + " AND GruCarts = " + EscaparSQL(loc_cGrupo)
1641:             ENDIF
1642:             loc_cSQL = loc_cSQL + " ORDER BY ConCarts"
1643:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaLst")
1644:             IF loc_nResult > 0 AND USED("cursor_4c_CarContaLst")
1645:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1646:                 IF VARTYPE(loLookup) = "O"
1647:                     loLookup.ConfigurarBuscaCursor("cursor_4c_CarContaLst", ;
1648:                         "codigo", "descricao", "Conta Carteira", ;
1649:                         ALLTRIM(THIS.txt_4c_CdCarConta.Value))
1650:                     loLookup.Show()
1651:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1652:                         THIS.txt_4c_CdCarConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1653:                         THIS.txt_4c_DsCarConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1654:                     ENDIF
1655:                     loLookup = .NULL.
1656:                 ENDIF
1657:                 USE IN cursor_4c_CarContaLst
1658:             ENDIF

*-- Linhas 1673 a 1695:
1673:             THIS.txt_4c_DsDepConta.Value = ""
1674:             RETURN
1675:         ENDIF
1676:         loc_cSQL    = "SELECT DISTINCT Grupos AS Codigo, Grupos AS Descricao " + ;
1677:                       "FROM SigCqChm WHERE Grupos = " + EscaparSQL(loc_cCodigo)
1678:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoVal")
1679:         IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoVal")
1680:             SELECT cursor_4c_DepGrupoVal
1681:             IF !EOF()
1682:                 THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(Codigo)
1683:             ELSE
1684:                 THIS.txt_4c_CdDepGrupo.Value = ""
1685:                 THIS.txt_4c_DsDepGrupo.Value = ""
1686:                 THIS.txt_4c_CdDepConta.Value = ""
1687:                 THIS.txt_4c_DsDepConta.Value = ""
1688:             ENDIF
1689:             USE IN cursor_4c_DepGrupoVal
1690:         ENDIF
1691:     ENDPROC
1692: 
1693:     PROCEDURE ValidarDsDepGrupo()
1694:         LOCAL loc_cDescricao
1695:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepGrupo.Value)

*-- Linhas 1705 a 1725:
1705:     PROCEDURE AbrirBuscaDepGrupo()
1706:         LOCAL loLookup, loc_cSQL, loc_nResult
1707:         TRY
1708:             loc_cSQL    = "SELECT DISTINCT Grupos AS codigo, Grupos AS descricao " + ;
1709:                           "FROM SigCqChm ORDER BY Grupos"
1710:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoLst")
1711:             IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoLst")
1712:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1713:                 IF VARTYPE(loLookup) = "O"
1714:                     loLookup.ConfigurarBuscaCursor("cursor_4c_DepGrupoLst", ;
1715:                         "codigo", "descricao", "Grupo Dep" + CHR(243) + "sito", ;
1716:                         ALLTRIM(THIS.txt_4c_CdDepGrupo.Value))
1717:                     loLookup.Show()
1718:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1719:                         THIS.txt_4c_CdDepGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1720:                         THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1721:                         THIS.txt_4c_CdDepConta.Value = ""
1722:                         THIS.txt_4c_DsDepConta.Value = ""
1723:                     ENDIF
1724:                     loLookup = .NULL.
1725:                 ENDIF

*-- Linhas 1742 a 1768:
1742:             THIS.txt_4c_DsDepConta.Value = ""
1743:             RETURN
1744:         ENDIF
1745:         loc_cSQL = "SELECT a.Contas AS Codigo, e.Rclis AS Descricao " + ;
1746:                    "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis " + ;
1747:                    "WHERE a.Contas = " + EscaparSQL(loc_cCodigo)
1748:         IF !EMPTY(loc_cGrupo)
1749:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1750:         ENDIF
1751:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaVal")
1752:         IF loc_nResult > 0 AND USED("cursor_4c_DepContaVal")
1753:             SELECT cursor_4c_DepContaVal
1754:             IF !EOF()
1755:                 THIS.txt_4c_DsDepConta.Value = ALLTRIM(Descricao)
1756:             ELSE
1757:                 MsgAviso("Acesso Negado!!", "Dep" + CHR(243) + "sito")
1758:                 THIS.txt_4c_CdDepConta.Value = ""
1759:                 THIS.txt_4c_DsDepConta.Value = ""
1760:             ENDIF
1761:             USE IN cursor_4c_DepContaVal
1762:         ENDIF
1763:     ENDPROC
1764: 
1765:     PROCEDURE ValidarDsDepConta()
1766:         LOCAL loc_cDescricao
1767:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepConta.Value)
1768:         IF EMPTY(loc_cDescricao)

*-- Linhas 1776 a 1800:
1776:         LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
1777:         TRY
1778:             loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
1779:             loc_cSQL    = "SELECT DISTINCT a.Contas AS codigo, e.Rclis AS descricao " + ;
1780:                           "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis WHERE 1=1"
1781:             IF !EMPTY(loc_cGrupo)
1782:                 loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1783:             ENDIF
1784:             loc_cSQL    = loc_cSQL + " ORDER BY e.Rclis"
1785:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaLst")
1786:             IF loc_nResult > 0 AND USED("cursor_4c_DepContaLst")
1787:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1788:                 IF VARTYPE(loLookup) = "O"
1789:                     loLookup.ConfigurarBuscaCursor("cursor_4c_DepContaLst", ;
1790:                         "codigo", "descricao", "Conta Dep" + CHR(243) + "sito", ;
1791:                         ALLTRIM(THIS.txt_4c_CdDepConta.Value))
1792:                     loLookup.Show()
1793:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1794:                         THIS.txt_4c_CdDepConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1795:                         THIS.txt_4c_DsDepConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1796:                     ENDIF
1797:                     loLookup = .NULL.
1798:                 ENDIF
1799:                 USE IN cursor_4c_DepContaLst
1800:             ENDIF

*-- Linhas 1815 a 1837:
1815:             THIS.txt_4c_DsEmiConta.Value = ""
1816:             RETURN
1817:         ENDIF
1818:         loc_cSQL    = "SELECT DISTINCT Grclis AS Codigo, Grclis AS Descricao " + ;
1819:                       "FROM SigCqChm WHERE Grclis = " + EscaparSQL(loc_cCodigo)
1820:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoVal")
1821:         IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoVal")
1822:             SELECT cursor_4c_EmiGrupoVal
1823:             IF !EOF()
1824:                 THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(Codigo)
1825:             ELSE
1826:                 THIS.txt_4c_CdEmiGrupo.Value = ""
1827:                 THIS.txt_4c_DsEmiGrupo.Value = ""
1828:                 THIS.txt_4c_CdEmiConta.Value = ""
1829:                 THIS.txt_4c_DsEmiConta.Value = ""
1830:             ENDIF
1831:             USE IN cursor_4c_EmiGrupoVal
1832:         ENDIF
1833:     ENDPROC
1834: 
1835:     PROCEDURE ValidarDsEmiGrupo()
1836:         LOCAL loc_cDescricao
1837:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiGrupo.Value)

*-- Linhas 1847 a 1867:
1847:     PROCEDURE AbrirBuscaEmiGrupo()
1848:         LOCAL loLookup, loc_cSQL, loc_nResult
1849:         TRY
1850:             loc_cSQL    = "SELECT DISTINCT Grclis AS codigo, Grclis AS descricao " + ;
1851:                           "FROM SigCqChm ORDER BY Grclis"
1852:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoLst")
1853:             IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoLst")
1854:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1855:                 IF VARTYPE(loLookup) = "O"
1856:                     loLookup.ConfigurarBuscaCursor("cursor_4c_EmiGrupoLst", ;
1857:                         "codigo", "descricao", "Grupo Emissor", ;
1858:                         ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value))
1859:                     loLookup.Show()
1860:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1861:                         THIS.txt_4c_CdEmiGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1862:                         THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1863:                         THIS.txt_4c_CdEmiConta.Value = ""
1864:                         THIS.txt_4c_DsEmiConta.Value = ""
1865:                     ENDIF
1866:                     loLookup = .NULL.
1867:                 ENDIF

*-- Linhas 1884 a 1910:
1884:             THIS.txt_4c_DsEmiConta.Value = ""
1885:             RETURN
1886:         ENDIF
1887:         loc_cSQL = "SELECT DISTINCT a.Iclis AS Codigo, d.Rclis AS Descricao " + ;
1888:                    "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis " + ;
1889:                    "WHERE a.Iclis = " + EscaparSQL(loc_cCodigo)
1890:         IF !EMPTY(loc_cGrupo)
1891:             loc_cSQL = loc_cSQL + " AND a.Grclis = " + EscaparSQL(loc_cGrupo)
1892:         ENDIF
1893:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaVal")
1894:         IF loc_nResult > 0 AND USED("cursor_4c_EmiContaVal")
1895:             SELECT cursor_4c_EmiContaVal
1896:             IF !EOF()
1897:                 THIS.txt_4c_DsEmiConta.Value = ALLTRIM(Descricao)
1898:             ELSE
1899:                 MsgAviso("Acesso Negado!!", "Emissor")
1900:                 THIS.txt_4c_CdEmiConta.Value = ""
1901:                 THIS.txt_4c_DsEmiConta.Value = ""
1902:             ENDIF
1903:             USE IN cursor_4c_EmiContaVal
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     PROCEDURE ValidarDsEmiConta()
1908:         LOCAL loc_cDescricao
1909:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiConta.Value)
1910:         IF EMPTY(loc_cDescricao)

*-- Linhas 1918 a 1942:
1918:         LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
1919:         TRY
1920:             loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
1921:             loc_cSQL    = "SELECT DISTINCT a.Iclis AS codigo, d.Rclis AS descricao " + ;
1922:                           "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis WHERE 1=1"
1923:             IF !EMPTY(loc_cGrupo)
1924:                 loc_cSQL = loc_cSQL + " AND a.Grclis = " + EscaparSQL(loc_cGrupo)
1925:             ENDIF
1926:             loc_cSQL    = loc_cSQL + " ORDER BY d.Rclis"
1927:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaLst")
1928:             IF loc_nResult > 0 AND USED("cursor_4c_EmiContaLst")
1929:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1930:                 IF VARTYPE(loLookup) = "O"
1931:                     loLookup.ConfigurarBuscaCursor("cursor_4c_EmiContaLst", ;
1932:                         "codigo", "descricao", "Conta Emissor", ;
1933:                         ALLTRIM(THIS.txt_4c_CdEmiConta.Value))
1934:                     loLookup.Show()
1935:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1936:                         THIS.txt_4c_CdEmiConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1937:                         THIS.txt_4c_DsEmiConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1938:                     ENDIF
1939:                     loLookup = .NULL.
1940:                 ENDIF
1941:                 USE IN cursor_4c_EmiContaLst
1942:             ENDIF


### BO (C:\4c\projeto\app\classes\sigrecheBO.prg):
*==============================================================================
* SIGRECHEBO.PRG
* Business Object para Relatorio de Cheques (SIGRECHE)
*
* Herda de RelatorioBase
* Filtros: periodo, empresa, tipo, opcao, ordem, ultima movimentacao,
*          carteira (grupo/conta), deposito (grupo/conta), emissor (grupo/conta)
* Tabelas principais: SigCqChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdEmp
*==============================================================================

DEFINE CLASS sigrecheBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorImprimir    = "cursor_4c_Imprimir"

    *-- Filtros de periodo (get_dt_inicial / get_dt_final)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Tipo de relatorio: 1=Abertos, 2=Geral, 3=DtOperacao, 4=DtVencimento
    this_nNrTipo            = 1

    *-- Opcao (com/sem nota): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Ordem de classificacao: 1=Carteira,2=Deposito,3=Emissor,4=DtEntrada,5=CPF,6=Nome
    this_nOrdem             = 1

    *-- Apenas ultima movimentacao por cheque
    this_lUltima            = .T.

    *-- Titulos dinamicos carregados de SigCdPac
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtros de carteira (get_cd_car_grupo / get_ds_car_grupo / ...)
    this_cCdCarGrupo        = ""
    this_cDsCarGrupo        = ""
    this_cCdCarConta        = ""
    this_cDsCarConta        = ""

    *-- Filtros de deposito (get_cd_dep_grupo / get_ds_dep_grupo / ...)
    this_cCdDepGrupo        = ""
    this_cDsDepGrupo        = ""
    this_cCdDepConta        = ""
    this_cDsDepConta        = ""

    *-- Filtros de emissor (get_cd_emi_grupo / get_ds_emi_grupo / ...)
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do FRX e titulo; inicializa datas com hoje
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReChe.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor_4c_Imprimir (campos opcionals de impressao)
    * e cursor_4c_Operacoes vazio (preenchido por CarregarOpcoes)
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorImprimir)
                USE IN (THIS.this_cCursorImprimir)
            ENDIF
            CREATE CURSOR cursor_4c_Imprimir (Marcas L(1), Campos C(20))
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.T., "C" + CHR(243) + "digo")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F.")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "Nome")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F. T")
            GO TOP IN cursor_4c_Imprimir

            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF
            CREATE CURSOR cursor_4c_Operacoes (Marcas L(1), Operacaos C(15), Tipos C(2))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarCursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOpcoes - Carrega SigCdOpt ? cursor_4c_Operacoes
    * e titulos de opcao de SigCdPac (para o OptionGroup do form)
    * Chamado pelo Form apos InicializarCursores()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOpcoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Operacaos, Tipos FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpt")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpOpt")
                SELECT cursor_4c_TmpOpt
                GO TOP
                SCAN
                    INSERT INTO cursor_4c_Operacoes (Marcas, Operacaos, Tipos) ;
                        VALUES (.F., cursor_4c_TmpOpt.Operacaos, cursor_4c_TmpOpt.Tipos)
                ENDSCAN
                USE IN cursor_4c_TmpOpt
            ENDIF
            GO TOP IN cursor_4c_Operacoes

            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPac")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpPac")
                SELECT cursor_4c_TmpPac
                GO TOP
                IF !EOF()
                    IF !EMPTY(ALLTRIM(TitOpcS))
                        THIS.this_cTituloOpcao1 = ALLTRIM(TitOpcS)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcN))
                        THIS.this_cTituloOpcao2 = ALLTRIM(TitOpcN)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcA))
                        THIS.this_cTituloOpcao3 = ALLTRIM(TitOpcA)
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpPac
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarOpcoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida filtros antes de gerar relatorio
    * Retorna .T. se tudo ok; caso contrario seta this_cMensagemErro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_nMarcados

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "Data inicial maior que data final!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorOperacoes)
            SELECT (THIS.this_cCursorOperacoes)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos uma Opera" + CHR(231) + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos um Campo para Impress" + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF !Marcas
                    IF (Campos = "C.P.F." .AND. THIS.this_nOrdem = 5) .OR. ;
                       (Campos = "Nome"   .AND. THIS.this_nOrdem = 6)
                        THIS.this_cMensagemErro = "Esta Ordem Necessita Que Selecione o " + ;
                            "Campo de Impress" + CHR(227) + "o " + ALLTRIM(Campos) + "!"
                        RETURN .F.
                    ENDIF
                ENDIF
            ENDSCAN
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa via SQLEXEC, filtra
    * por operacoes selecionadas e popula cursor_4c_Cabecalho + cursor_4c_Relatorio
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerCarGrupo, loc_cVerCarConta
        LOCAL loc_cVerDepGrupo, loc_cVerDepConta
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerAberto, loc_cOrdenaPor, loc_cQuebra, loc_cTituloOrdem
        LOCAL loc_cTitulo, loc_cNomeEmpresa, loc_cPeriodo
        LOCAL loc_cCarteira, loc_cDeposito, loc_cEmissor, loc_cOperacao
        LOCAL loc_lCpfs, loc_lRclis, loc_lCpft
        LOCAL loc_cSQL, loc_cNum

        loc_lSucesso = .F.
        loc_lCpfs    = .F.
        loc_lRclis   = .F.
        loc_lCpft    = .F.

        TRY
            *-- 1. Condicao de data conforme tipo
            IF THIS.this_nNrTipo = 3
                loc_cVerData = " AND a.dtents BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ELSE
                loc_cVerData = " AND b.vencs BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            *-- 2. Filtros opcionais de empresa, opcao, carteira, deposito, emissor
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND a.notas <> '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 3
                loc_cVerOpcao = ""
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdCarGrupo))
                loc_cVerCarGrupo = ""
            ELSE
                loc_cVerCarGrupo = " AND a.grucarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdCarConta))
                loc_cVerCarConta = ""
            ELSE
                loc_cVerCarConta = " AND a.concarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdDepGrupo))
                loc_cVerDepGrupo = ""
            ELSE
                loc_cVerDepGrupo = " AND a.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdDepConta))
                loc_cVerDepConta = ""
            ELSE
                loc_cVerDepConta = " AND a.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND a.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Filtro de abertos aplicado no filtro local pos-SQLEXEC
            IF THIS.this_nNrTipo = 1
                loc_cVerAberto = " AND c.Tipos = 'DB'"
            ELSE
                loc_cVerAberto = ""
            ENDIF

            *-- 3. ORDER BY, campo Quebra e sufixo do titulo conforme ordem
            DO CASE
                CASE THIS.this_nOrdem = 1
                    loc_cOrdenaPor  = "a.GruCarts, a.ConCarts, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Carteira: ' + a.GruCarts + '/' + a.ConCarts"
                    loc_cTituloOrdem = "Carteira"
                CASE THIS.this_nOrdem = 2
                    loc_cOrdenaPor  = "a.Grupos, a.Contas, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Dep' + CHR(243) + 'sito: ' + a.Grupos + '/' + a.Contas"
                    loc_cTituloOrdem = "Dep" + CHR(243) + "sito"
                CASE THIS.this_nOrdem = 3
                    loc_cOrdenaPor  = "a.Grclis, a.Iclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Emissor: ' + a.Grclis + '/' + a.Iclis"
                    loc_cTituloOrdem = "Emissor"
                CASE THIS.this_nOrdem = 4
                    loc_cOrdenaPor  = "a.Dtents, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Entrada: ' + DTOC(a.Dtents)"
                    loc_cTituloOrdem = "Data de Entrada"
                CASE THIS.this_nOrdem = 5
                    loc_cOrdenaPor  = "a.Cpfs, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'C.P.F.: ' + a.Cpfs"
                    loc_cTituloOrdem = "C.P.F."
                OTHERWISE
                    loc_cOrdenaPor  = "a.Rclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Nome: ' + a.Rclis"
                    loc_cTituloOrdem = "Nome do Cliente"
            ENDCASE

            *-- 4. Titulo do relatorio
            loc_cTitulo = "Relat" + CHR(243) + "rio de Cheques - "
            DO CASE
                CASE THIS.this_nNrTipo = 1
                    loc_cTitulo = loc_cTitulo + "Abertos"
                CASE THIS.this_nNrTipo = 2
                    loc_cTitulo = loc_cTitulo + "Geral"
                CASE THIS.this_nNrTipo = 3
                    loc_cTitulo = loc_cTitulo + "Data de Opera" + CHR(231) + CHR(227) + "o"
                OTHERWISE
                    loc_cTitulo = loc_cTitulo + "Data de Vencimento"
            ENDCASE
            loc_cTitulo = loc_cTitulo + " - Ordem: " + loc_cTituloOrdem

            *-- 5. Nome da empresa corrente
            loc_cNomeEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpEmp")
                SELECT cursor_4c_TmpEmp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_TmpEmp
            ENDIF

            *-- 6. Textos descritivos para o cabecalho do relatorio
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cCarteira = "Grupo / Conta Carteira : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdCarGrupo) + " - " + ALLTRIM(THIS.this_cDsCarGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdCarConta) + " - " + ALLTRIM(THIS.this_cDsCarConta))

            loc_cDeposito = "Grupo / Conta Deposito : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdDepGrupo) + " - " + ALLTRIM(THIS.this_cDsDepGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdDepConta) + " - " + ALLTRIM(THIS.this_cDsDepConta))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdEmiConta) + " - " + ALLTRIM(THIS.this_cDsEmiConta))

            *-- 7. Texto das operacoes selecionadas
            loc_cOperacao = "Opera" + CHR(231) + CHR(227) + "o : "
            IF USED(THIS.this_cCursorOperacoes)
                SELECT (THIS.this_cCursorOperacoes)
                SCAN
                    IF Marcas
                        IF LEN(ALLTRIM(loc_cOperacao)) > 12
                            loc_cOperacao = loc_cOperacao + " / "
                        ENDIF
                        loc_cOperacao = loc_cOperacao + ALLTRIM(Operacaos)
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 8. Flags de campos de impressao (Cpfs, Rclis, CpfsT)
            IF USED(THIS.this_cCursorImprimir)
                SELECT (THIS.this_cCursorImprimir)
                SCAN
                    IF Marcas
                        IF Campos = "C.P.F."
                            loc_lCpfs = (THIS.this_nOrdem # 5)
                        ENDIF
                        IF Campos = "Nome"
                            loc_lRclis = (THIS.this_nOrdem # 6)
                        ENDIF
                        IF Campos = "C.P.F. T"
                            loc_lCpft = .T.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 9. Cursor de cabecalho do relatorio
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                               Operacao C(200), Carteira C(80), Deposito C(80), ;
                                               Emissor C(80), Tipo N(1), ;
                                               Cpfs L(1), Rclis L(1), Cpfst L(1))
            INSERT INTO cursor_4c_Cabecalho ;
                (NomeEmpresa, Titulo, Periodo, Operacao, Carteira, ;
                 Deposito, Emissor, Tipo, Cpfs, Rclis, Cpfst) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cOperacao, ;
                        loc_cCarteira, loc_cDeposito, loc_cEmissor, THIS.this_nOrdem, ;
                        loc_lCpfs, loc_lRclis, loc_lCpft)

            *-- 10. SQL principal via SQLEXEC (SigCqChm + SigChe + SigCdCli x3)
            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF
            loc_cSQL = "SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, " + ;
                       "a.Contas + '-' + e.rclis AS Contas, a.Grclis, a.Iclis, a.Dtsis, " + ;
                       "b.Vencs, b.Valors, b.Emps, b.Bancos, b.Agencias, b.Ncontas, b.Ncheques, " + ;
                       "b.Bancos + '-' + b.Agencias + '-' + b.Ncontas + '-' + b.Ncheques AS Cheques, " + ;
                       "a.codigos AS Operacaos, d.Cpfs, d.Rclis, a.hists, f.cpfs AS cpfsT " + ;
                       "FROM SigCqChm a, SigCdCli d, SigCdCli e, " + ;
                       "SigChe b LEFT JOIN SigCdCli f ON b.grupot = f.grupos AND b.contat = f.iclis " + ;
                       "WHERE a.Nums = b.Nums AND b.Iclis = d.Iclis AND a.contas = e.Iclis" + ;
                       loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerCarGrupo + loc_cVerCarConta + ;
                       loc_cVerDepGrupo + loc_cVerDepConta + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Relatorio0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cheques."
                loc_lSucesso = .F.
            ENDIF

            *-- 11. Filtrar por operacoes selecionadas e montar cursor final
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            IF THIS.this_lUltima
                *-- Apenas ultima movimentacao por numero de cheque
                *-- Cria cursor-modelo com campo Quebra adicional
                SELECT *, SPACE(100) AS Quebra ;
                    FROM cursor_4c_Relatorio0 ;
                    WHERE 0 = 1 ;
                    INTO CURSOR cursor_4c_Resultado READWRITE

                *-- Seleciona com Quebra calculada, ordenado por Nums + Dtsis DESC
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, a.cpfsT, ;
                       &loc_cQuebra. AS Quebra, a.hists ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       INTO CURSOR cursor_4c_Selecao ;
                       ORDER BY a.Nums, a.Dtsis DESCENDING

                *-- Pega primeiro registro de cada grupo Nums (= mais recente)
                SELECT cursor_4c_Selecao
                GO TOP
                SCAN
                    loc_cNum = Nums
                    SCATTER MEMVAR MEMO
                    SELECT cursor_4c_Resultado
                    APPEND BLANK
                    GATHER MEMVAR MEMO
                    SELECT cursor_4c_Selecao
                    SCAN WHILE Nums = loc_cNum
                    ENDSCAN
                    SKIP -1
                ENDSCAN

                SELECT a.* FROM cursor_4c_Resultado a ;
                    ORDER BY &loc_cOrdenaPor. ;
                    INTO CURSOR cursor_4c_Relatorio

                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF
                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF
            ELSE
                *-- Todas as movimentacoes
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, &loc_cQuebra. AS Quebra, a.hists, a.cpfsT ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       ORDER BY &loc_cOrdenaPor. ;
                       INTO CURSOR cursor_4c_Relatorio
            ENDIF

            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF

            SELECT cursor_4c_Relatorio
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Valida, prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Valida, prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdem, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";CAR="  + ALLTRIM(THIS.this_cCdCarGrupo) + "/" + ALLTRIM(THIS.this_cCdCarConta) + ;
                     ";DEP="  + ALLTRIM(THIS.this_cCdDepGrupo) + "/" + ALLTRIM(THIS.this_cCdDepConta) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";ULT="  + IIF(THIS.this_lUltima, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.dDtInicial") = "D"
                        THIS.this_dDtInicial = m.dDtInicial
                    ENDIF
                    IF TYPE("m.dDtFinal") = "D"
                        THIS.this_dDtFinal = m.dDtFinal
                    ENDIF
                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.nOrdem") = "N"
                        THIS.this_nOrdem = m.nOrdem
                    ENDIF
                    IF TYPE("m.lUltima") = "L"
                        THIS.this_lUltima = m.lUltima
                    ENDIF
                    IF TYPE("m.cCdCarGrupo") = "C"
                        THIS.this_cCdCarGrupo = ALLTRIM(m.cCdCarGrupo)
                    ENDIF
                    IF TYPE("m.cDsCarGrupo") = "C"
                        THIS.this_cDsCarGrupo = ALLTRIM(m.cDsCarGrupo)
                    ENDIF
                    IF TYPE("m.cCdCarConta") = "C"
                        THIS.this_cCdCarConta = ALLTRIM(m.cCdCarConta)
                    ENDIF
                    IF TYPE("m.cDsCarConta") = "C"
                        THIS.this_cDsCarConta = ALLTRIM(m.cDsCarConta)
                    ENDIF
                    IF TYPE("m.cCdDepGrupo") = "C"
                        THIS.this_cCdDepGrupo = ALLTRIM(m.cCdDepGrupo)
                    ENDIF
                    IF TYPE("m.cDsDepGrupo") = "C"
                        THIS.this_cDsDepGrupo = ALLTRIM(m.cDsDepGrupo)
                    ENDIF
                    IF TYPE("m.cCdDepConta") = "C"
                        THIS.this_cCdDepConta = ALLTRIM(m.cCdDepConta)
                    ENDIF
                    IF TYPE("m.cDsDepConta") = "C"
                        THIS.this_cDsDepConta = ALLTRIM(m.cDsDepConta)
                    ENDIF
                    IF TYPE("m.cCdEmiGrupo") = "C"
                        THIS.this_cCdEmiGrupo = ALLTRIM(m.cCdEmiGrupo)
                    ENDIF
                    IF TYPE("m.cDsEmiGrupo") = "C"
                        THIS.this_cDsEmiGrupo = ALLTRIM(m.cDsEmiGrupo)
                    ENDIF
                    IF TYPE("m.cCdEmiConta") = "C"
                        THIS.this_cCdEmiConta = ALLTRIM(m.cCdEmiConta)
                    ENDIF
                    IF TYPE("m.cDsEmiConta") = "C"
                        THIS.this_cDsEmiConta = ALLTRIM(m.cDsEmiConta)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReChe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores locais e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_Relatorio")
            USE IN cursor_4c_Relatorio
        ENDIF
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        IF USED(THIS.this_cCursorImprimir)
            USE IN (THIS.this_cCursorImprimir)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

