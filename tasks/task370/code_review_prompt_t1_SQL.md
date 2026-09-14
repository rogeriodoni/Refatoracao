# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-SQL] Campo 'Cods' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Operacoes' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'GrupoOs' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'ContaOs' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'GrupoDs' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'ContaDs' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Agrupar' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LOCALS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, I, CODIGOS

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
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = "crEstoqueA.Marca"
  Column2.ControlSource = "crEstoqueA.Emps"
  Column3.ControlSource = "crEstoqueA.Grupos"
  Column4.ControlSource = "crEstoqueA.Contas"
  DeleteMark = .F.
  Column1.ControlSource = "crEstoqueB.Marca"
  Column2.ControlSource = "crEstoqueB.Emps"
  Column3.ControlSource = "crEstoqueB.Grupos"
  Column4.ControlSource = "crEstoqueB.Contas"
		lcQuery = [Select Distinct a.Emps, a.Grupos, a.Estos as Contas ] + ;
					[From SigMvEst a ] + ;
		If (ThisForm.poDataAux.SqlExecute(lcQuery, [LocalEst]) < 1)
		Select LocalEst
			Insert Into crEstoqueA (Marca, Emps, Grupos, Contas) Values (.f., LocalEst.Emps, LocalEst.Grupos, LocalEst.Contas)
		Select crSigLcLoE
				Update crEstoqueA ;
		lcQuery = [Select Distinct a.Emps, a.Grupos, a.Estos as Contas ] + ;
					[From SigMvEst a ] + ;
		If (ThisForm.poDataAux.SqlExecute(lcQuery, [LocalEst]) < 1)
		Select LocalEst
			Insert Into crEstoqueB (Marca, Emps, Grupos, Contas) Values (.f., LocalEst.Emps, LocalEst.Grupos, LocalEst.Contas)
		Select crSigLcLoE
				Update crEstoqueB ;
	.getCodigos.ControlSource     = 'crSigLcLo.Codigos'
	.getEmpresas.ControlSource    = 'crSigLcLo.Emps'
	.chkEmpContas.ControlSource   = 'crSigLcLo.EmpContas'
	.getTransitoria.ControlSource = 'crSigLcLo.EmpTrans'
	.optDigitos.ControlSource     = 'crSigLcLo.Digitos'
	.chkAutos.ControlSource       = 'crSigLcLo.Autos'
	.getToleras.ControlSource     = 'crSigLcLo.Toleras'
	.getPercents.ControlSource    = 'crSigLcLo.Percents'
	.getLocalA.ControlSource    = 'crSigLcLo.LocalA'
	.getGrupoA.ControlSource    = 'crSigLcLo.GrupoA'
	.getContaA.ControlSource    = 'crSigLcLo.ContaA'
	.getOperacaoA.ControlSource = 'crSigLcLo.OperacaoA'
	.getGdeGrupoA.ControlSource = 'crSigLcLo.GdeGrupoA'
	.getDataA.ControlSource     = 'crSigLcLo.DataA'
	.chkEtiquetaA.ControlSource = 'crSigLcLo.EtiquetaA'
	.chkPalmA.ControlSource     = 'crSigLcLo.PalmA'
	.getDivisaos.ControlSource  = 'crSigLcLo.DivisaoA'
	.getLocalB.ControlSource    = 'crSigLcLo.LocalB'
	.getGrupoB.ControlSource    = 'crSigLcLo.GrupoB'
	.getContaB.ControlSource    = 'crSigLcLo.ContaB'
	.getOperacaoB.ControlSource = 'crSigLcLo.OperacaoB'
	.getGdeGrupoB.ControlSource = 'crSigLcLo.GdeGrupoB'
	.getDataB.ControlSource     = 'crSigLcLo.DataB'
	.chkEtiquetaB.ControlSource = 'crSigLcLo.EtiquetaB'
	.chkPalmB.ControlSource     = 'crSigLcLo.PalmB'
	.getDivisaos.ControlSource  = 'crSigLcLo.DivisaoB'
	.Column1.ControlSource = 'crSigLcLoI.Emps'
	.Column2.ControlSource = 'crSigLcLoI.Cods'
	.Column3.ControlSource = 'crSigLcLoI.Operacoes'
	.Column4.ControlSource = 'crSigLcLoI.GrupoOs'
	.Column5.ControlSource = 'crSigLcLoI.ContaOs'
	.Column6.ControlSource = 'crSigLcLoI.GrupoDs'
	.Column7.ControlSource = 'crSigLcLoI.ContaDs'
	.Column8.ControlSource   = 'crSigLcLoI.Agrupar'
ThisForm.Pagina.Dados.pgComplementos.pgOpeGerA.optEnvRecs.ControlSource = 'crSigLcLoI.EnvRecs'
lcQryCLoc  = [Select * From SigLcLo]
lcQryCLocI = [Select * From SigLcLoI Where Codigos = ?pCod]
lcQryCLocE = [Select * From SigLcLoE Where Codigos = ?pCod]
Select crSigLcLo
If Not ThisForm.poDataMgr.Update('crSigLcLoI')
If llOks And Not ThisForm.poDataMgr.Update('crSigLcLoE')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigLcLoI Where Codigos = ?pCod], '') < 1)
If Not ThisForm.poDataMgr.Update('crSigLcLoI')
If llOks And Not ThisForm.poDataMgr.Update('crSigLcLoE')
Select crSigLcLo
Select crSigLcLo
	Insert Into crSigLcLoI (Codigos) Values (crSigLcLo.Codigos)
Select crSigLcLo
	Select crSigLcLoI
			Delete In crSigLcLoI
	lcQuery = [Delete From SigLcLoE ] + ;
	If (ThisForm.poDatamGR.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete - SigLcLoE)])
		Select crEstoqueA
				Insert Into crSigLcLoE (Codigos, Locals, Emps, Grupos, Contas, cIdChaves) ;
		Select crEstoqueB
				Insert Into crSigLcLoE (Codigos, Locals, Emps, Grupos, Contas, cIdChaves) ;
	Select crSigLcLoI
Select crSigLcLoI
Insert Into crSigLcLoI (Codigos) Values (crSigLcLo.Codigos)
Select crSigLcLoI
	Delete
Update crEstoqueA Set Marca = (This.Value = 1)
Update crEstoqueB Set Marca = (This.Value = 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCLC.prg) - TRECHOS RELEVANTES PARA PASS SQL (2766 linhas total):

*-- Linhas 360 a 387:
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .HighlightStyle     = 2
363:             .DeleteMark         = .F.
364:             .RecordMark         = .F.
365:             .RowHeight          = 16
366:             .ScrollBars         = 2
367:             .GridLines          = 3
368:             .Visible            = .T.
369:             .Column1.ControlSource = "cursor_4c_Dados.Codigos"
370:             .Column2.ControlSource = "cursor_4c_Dados.Emps"
371:             .Column3.ControlSource = "cursor_4c_Dados.LocalA"
372:             .Column4.ControlSource = "cursor_4c_Dados.LocalB"
373:             .Column1.Width = 150
374:             .Column2.Width = 70
375:             .Column3.Width = 150
376:             .Column4.Width = 150
377:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
378:             .Column2.Header1.Caption = "Empresa"
379:             .Column3.Header1.Caption = "Local A"
380:             .Column4.Header1.Caption = "Local B"
381:         ENDWITH
382: 
383:         BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "GridListaDblClick")
384: 
385:         THIS.TornarControlesVisiveis(loc_oPg1)
386:     ENDPROC
387: 

*-- Linhas 1272 a 1319:
1272:         loc_oPg2C = loc_oPgf.Page2
1273: 
1274:         *-- Page1: Grid de Operacoes Gerenciais (grdOpeGerA - 8 colunas)
1275:         loc_oPg1C.AddObject("grd_4c_OpeGerA", "Grid")
1276:         loc_oPg1C.grd_4c_OpeGerA.ColumnCount = 3
1277:         loc_oPg1C.grd_4c_OpeGerA.RecordSource = "cursor_4c_Operacoes"
1278:         loc_oPg1C.grd_4c_OpeGerA.ColumnCount  = 8
1279:         WITH loc_oPg1C.grd_4c_OpeGerA
1280:             .Top                = 10
1281:             .Left               = 8
1282:             .Width              = 723
1283:             .Height             = 122
1284:             .FontName           = "Verdana"
1285:             .FontSize           = 8
1286:             .BackColor          = RGB(255, 255, 255)
1287:             .GridLineColor      = RGB(238, 238, 238)
1288:             .HighlightBackColor = RGB(255, 255, 255)
1289:             .HighlightForeColor = RGB(15, 41, 104)
1290:             .HighlightStyle     = 2
1291:             .DeleteMark         = .F.
1292:             .RecordMark         = .F.
1293:             .RowHeight          = 16
1294:             .ScrollBars         = 3
1295:             .GridLines          = 3
1296:             .Visible            = .T.
1297:             .Column1.ControlSource = "cursor_4c_Operacoes.Emps"
1298:             .Column2.ControlSource = "cursor_4c_Operacoes.Cods"
1299:             .Column3.ControlSource = "cursor_4c_Operacoes.Operacoes"
1300:             .Column4.ControlSource = "cursor_4c_Operacoes.GrupoOs"
1301:             .Column5.ControlSource = "cursor_4c_Operacoes.ContaOs"
1302:             .Column6.ControlSource = "cursor_4c_Operacoes.GrupoDs"
1303:             .Column7.ControlSource = "cursor_4c_Operacoes.ContaDs"
1304:             .Column8.ControlSource = "cursor_4c_Operacoes.Agrupar"
1305:             .Column1.Width = 35
1306:             .Column2.Width = 80
1307:             .Column3.Width = 80
1308:             .Column4.Width = 90
1309:             .Column5.Width = 100
1310:             .Column6.Width = 90
1311:             .Column7.Width = 100
1312:             .Column8.Width = 28
1313:             .Column1.Header1.Caption = "Emp"
1314:             .Column2.Header1.Caption = "Local"
1315:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1316:             .Column4.Header1.Caption = "Grupo Origem"
1317:             .Column5.Header1.Caption = "Conta Origem"
1318:             .Column6.Header1.Caption = "Grupo Destino"
1319:             .Column7.Header1.Caption = "Conta Destino"

*-- Linhas 1446 a 1473:
1446:             .HighlightBackColor = RGB(255, 255, 255)
1447:             .HighlightForeColor = RGB(15, 41, 104)
1448:             .HighlightStyle     = 2
1449:             .DeleteMark         = .F.
1450:             .RecordMark         = .F.
1451:             .RowHeight          = 16
1452:             .ScrollBars         = 3
1453:             .GridLines          = 3
1454:             .Visible            = .T.
1455:             .Column1.ControlSource = "cursor_4c_EstoqueA.Marca"
1456:             .Column2.ControlSource = "cursor_4c_EstoqueA.Emps"
1457:             .Column3.ControlSource = "cursor_4c_EstoqueA.Grupos"
1458:             .Column4.ControlSource = "cursor_4c_EstoqueA.Contas"
1459:             .Column1.Width = 22
1460:             .Column2.Width = 35
1461:             .Column3.Width = 90
1462:             .Column4.Width = 95
1463:             .Column1.Header1.Caption = ""
1464:             .Column2.Header1.Caption = "Emp"
1465:             .Column3.Header1.Caption = "Grupo"
1466:             .Column4.Header1.Caption = "Conta"
1467:             .Column1.Sparse   = .F.
1468:             .Column1.ReadOnly = .F.
1469:             .Column2.ReadOnly = .T.
1470:             .Column3.ReadOnly = .T.
1471:             .Column4.ReadOnly = .T.
1472:         ENDWITH
1473: 

*-- Linhas 1538 a 1565:
1538:             .HighlightBackColor = RGB(255, 255, 255)
1539:             .HighlightForeColor = RGB(15, 41, 104)
1540:             .HighlightStyle     = 2
1541:             .DeleteMark         = .F.
1542:             .RecordMark         = .F.
1543:             .RowHeight          = 16
1544:             .ScrollBars         = 3
1545:             .GridLines          = 3
1546:             .Visible            = .T.
1547:             .Column1.ControlSource = "cursor_4c_EstoqueB.Marca"
1548:             .Column2.ControlSource = "cursor_4c_EstoqueB.Emps"
1549:             .Column3.ControlSource = "cursor_4c_EstoqueB.Grupos"
1550:             .Column4.ControlSource = "cursor_4c_EstoqueB.Contas"
1551:             .Column1.Width = 22
1552:             .Column2.Width = 35
1553:             .Column3.Width = 90
1554:             .Column4.Width = 95
1555:             .Column1.Header1.Caption = ""
1556:             .Column2.Header1.Caption = "Emp"
1557:             .Column3.Header1.Caption = "Grupo"
1558:             .Column4.Header1.Caption = "Conta"
1559:             .Column1.Sparse   = .F.
1560:             .Column1.ReadOnly = .F.
1561:             .Column2.ReadOnly = .T.
1562:             .Column3.ReadOnly = .T.
1563:             .Column4.ReadOnly = .T.
1564:         ENDWITH
1565: 

*-- Linhas 1603 a 1674:
1603:     * CriarCursoresOperacoesVazios - Cursores placeholder com tipos corretos
1604:     *--------------------------------------------------------------------------
1605:     PROTECTED PROCEDURE CriarCursoresOperacoesVazios()
1606:         SET NULL ON
1607: 
1608:         IF USED("cursor_4c_Operacoes")
1609:             USE IN cursor_4c_Operacoes
1610:         ENDIF
1611:         CREATE CURSOR cursor_4c_Operacoes (cIdChaves C(36), Codigos C(20), ;
1612:             Emps C(3), Cods C(20), Operacoes C(20), ;
1613:             GrupoOs C(40), ContaOs C(40), ;
1614:             GrupoDs C(40), ContaDs C(40), Agrupar L, EnvRecs C(1))
1615: 
1616:         IF USED("cursor_4c_EstoqueA")
1617:             USE IN cursor_4c_EstoqueA
1618:         ENDIF
1619:         CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
1620:             Emps C(3), Grupos C(40), Contas C(40), Marca L)
1621: 
1622:         IF USED("cursor_4c_EstoqueB")
1623:             USE IN cursor_4c_EstoqueB
1624:         ENDIF
1625:         CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
1626:             Emps C(3), Grupos C(40), Contas C(40), Marca L)
1627: 
1628:         SET NULL OFF
1629:     ENDPROC
1630: 
1631:     *--------------------------------------------------------------------------
1632:     * CarregarGridOperacoes - Carrega grd_4c_OpeGerA com dados de SigLcLoI
1633:     *--------------------------------------------------------------------------
1634:     PROTECTED PROCEDURE CarregarGridOperacoes(par_cCodigos)
1635:         LOCAL loc_lSucesso, loc_oGrid
1636:         loc_lSucesso = .F.
1637: 
1638:         TRY
1639:             loc_lSucesso = THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)
1640: 
1641:             IF !loc_lSucesso OR !USED("cursor_4c_Operacoes")
1642:                 THIS.CriarCursoresOperacoesVazios()
1643:                 loc_lSucesso = .T.
1644:             ENDIF
1645: 
1646:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1647:             loc_oGrid.RecordSource = ""
1648:             loc_oGrid.ColumnCount = 8
1649:             loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1650:             loc_oGrid.ColumnCount  = 8
1651: 
1652:             loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Emps"
1653:             loc_oGrid.Column2.ControlSource = "cursor_4c_Operacoes.Cods"
1654:             loc_oGrid.Column3.ControlSource = "cursor_4c_Operacoes.Operacoes"
1655:             loc_oGrid.Column4.ControlSource = "cursor_4c_Operacoes.GrupoOs"
1656:             loc_oGrid.Column5.ControlSource = "cursor_4c_Operacoes.ContaOs"
1657:             loc_oGrid.Column6.ControlSource = "cursor_4c_Operacoes.GrupoDs"
1658:             loc_oGrid.Column7.ControlSource = "cursor_4c_Operacoes.ContaDs"
1659:             loc_oGrid.Column8.ControlSource = "cursor_4c_Operacoes.Agrupar"
1660: 
1661:             loc_oGrid.Column1.Width = 35
1662:             loc_oGrid.Column2.Width = 80
1663:             loc_oGrid.Column3.Width = 80
1664:             loc_oGrid.Column4.Width = 90
1665:             loc_oGrid.Column5.Width = 100
1666:             loc_oGrid.Column6.Width = 90
1667:             loc_oGrid.Column7.Width = 100
1668:             loc_oGrid.Column8.Width = 28
1669: 
1670:             loc_oGrid.Column1.Header1.Caption = "Emp"
1671:             loc_oGrid.Column2.Header1.Caption = "Local"
1672:             loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1673:             loc_oGrid.Column4.Header1.Caption = "Grupo Origem"
1674:             loc_oGrid.Column5.Header1.Caption = "Conta Origem"

*-- Linhas 1721 a 1752:
1721:                     USE IN cursor_4c_EstoqueA
1722:                 ENDIF
1723:                 SET NULL ON
1724:                 CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
1725:                     Emps C(3), Grupos C(40), Contas C(40), Marca L)
1726:                 SET NULL OFF
1727:             ENDIF
1728: 
1729:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA
1730:             loc_oGrid.RecordSource = ""
1731:             loc_oGrid.ColumnCount = 4
1732:             loc_oGrid.RecordSource = "cursor_4c_EstoqueA"
1733:             loc_oGrid.ColumnCount  = 4
1734:             loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueA.Marca"
1735:             loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueA.Emps"
1736:             loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueA.Grupos"
1737:             loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueA.Contas"
1738:             loc_oGrid.Column1.Width = 22
1739:             loc_oGrid.Column2.Width = 35
1740:             loc_oGrid.Column3.Width = 90
1741:             loc_oGrid.Column4.Width = 95
1742:             loc_oGrid.Column1.Header1.Caption = ""
1743:             loc_oGrid.Column2.Header1.Caption = "Emp"
1744:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1745:             loc_oGrid.Column4.Header1.Caption = "Conta"
1746:             loc_oGrid.Column1.Sparse   = .F.
1747:             loc_oGrid.Column1.ReadOnly = .F.
1748:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
1749:                 loc_oGrid.Column1.Check1.Alignment = 0
1750:                 loc_oGrid.Column1.Check1.ReadOnly  = .F.
1751:                 loc_oGrid.Column1.Check1.Visible   = .T.
1752:                 loc_oGrid.Column1.Check1.Top       = 9

*-- Linhas 1768 a 1799:
1768:                     USE IN cursor_4c_EstoqueB
1769:                 ENDIF
1770:                 SET NULL ON
1771:                 CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
1772:                     Emps C(3), Grupos C(40), Contas C(40), Marca L)
1773:                 SET NULL OFF
1774:             ENDIF
1775: 
1776:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB
1777:             loc_oGrid.RecordSource = ""
1778:             loc_oGrid.ColumnCount = 4
1779:             loc_oGrid.RecordSource = "cursor_4c_EstoqueB"
1780:             loc_oGrid.ColumnCount  = 4
1781:             loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueB.Marca"
1782:             loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueB.Emps"
1783:             loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueB.Grupos"
1784:             loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueB.Contas"
1785:             loc_oGrid.Column1.Width = 22
1786:             loc_oGrid.Column2.Width = 35
1787:             loc_oGrid.Column3.Width = 90
1788:             loc_oGrid.Column4.Width = 95
1789:             loc_oGrid.Column1.Header1.Caption = ""
1790:             loc_oGrid.Column2.Header1.Caption = "Emp"
1791:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1792:             loc_oGrid.Column4.Header1.Caption = "Conta"
1793:             loc_oGrid.Column1.Sparse   = .F.
1794:             loc_oGrid.Column1.ReadOnly = .F.
1795:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
1796:                 loc_oGrid.Column1.Check1.Alignment = 0
1797:                 loc_oGrid.Column1.Check1.ReadOnly  = .F.
1798:                 loc_oGrid.Column1.Check1.Visible   = .T.
1799:                 loc_oGrid.Column1.Check1.Top       = 9

*-- Linhas 1831 a 1873:
1831:         TRY
1832:             *-- Excluir operacoes anteriores
1833:             loc_oBO.ExcluirOperacoes(par_cCodigos)
1834: 
1835:             *-- Reinserir operacoes validas do cursor
1836:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
1837:                 SELECT cursor_4c_Operacoes
1838:                 GO TOP
1839: 
1840:                 loc_nEnvRecs = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Value
1841: 
1842:                 SCAN
1843:                     IF !EMPTY(ALLTRIM(cursor_4c_Operacoes.Cods)) OR ;
1844:                        !EMPTY(ALLTRIM(cursor_4c_Operacoes.Operacoes))
1845: 
1846:                         loc_cIdChave = TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS") + ;
1847:                                        PADL(TRANSFORM(RECNO()), 4, "0")
1848: 
1849:                         loc_oBO.InserirOperacao(par_cCodigos, ;
1850:                             loc_cIdChave, ;
1851:                             ALLTRIM(cursor_4c_Operacoes.Emps), ;
1852:                             ALLTRIM(cursor_4c_Operacoes.Cods), ;
1853:                             ALLTRIM(cursor_4c_Operacoes.Operacoes), ;
1854:                             ALLTRIM(cursor_4c_Operacoes.GrupoOs), ;
1855:                             ALLTRIM(cursor_4c_Operacoes.ContaOs), ;
1856:                             ALLTRIM(cursor_4c_Operacoes.GrupoDs), ;
1857:                             ALLTRIM(cursor_4c_Operacoes.ContaDs), ;
1858:                             IIF(cursor_4c_Operacoes.Agrupar, 1, 0), ;
1859:                             IIF(loc_nEnvRecs = 1, "A", "B"))
1860:                     ENDIF
1861:                 ENDSCAN
1862:             ENDIF
1863: 
1864:             *-- Gravar estoques A e B
1865:             IF !EMPTY(loc_cLocalA)
1866:                 loc_oBO.GravarEstoques(par_cCodigos, loc_cLocalA, "cursor_4c_EstoqueA")
1867:             ENDIF
1868: 
1869:             IF !EMPTY(loc_cLocalB)
1870:                 loc_oBO.GravarEstoques(par_cCodigos, loc_cLocalB, "cursor_4c_EstoqueB")
1871:             ENDIF
1872: 
1873:             loc_lSucesso = .T.

*-- Linhas 1886 a 1940:
1886:         LOCAL loc_oGrid
1887:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1888:             RETURN
1889:         ENDIF
1890: 
1891:         IF !USED("cursor_4c_Operacoes")
1892:             THIS.CriarCursoresOperacoesVazios()
1893:         ENDIF
1894: 
1895:         SELECT cursor_4c_Operacoes
1896:         INSERT INTO cursor_4c_Operacoes (cIdChaves, Codigos, Emps, Cods, Operacoes, ;
1897:             GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs) ;
1898:             VALUES ("", THIS.this_oBusinessObject.this_cCodigos, "", "", "", ;
1899:                     "", "", "", "", .F., "")
1900: 
1901:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1902:         loc_oGrid.Refresh()
1903:         GO BOTTOM IN cursor_4c_Operacoes
1904:         loc_oGrid.Column1.SetFocus()
1905:     ENDPROC
1906: 
1907:     *--------------------------------------------------------------------------
1908:     * BtnExcluirLinhaClick - Remove linha corrente do cursor de operacoes
1909:     *--------------------------------------------------------------------------
1910:     PROCEDURE BtnExcluirLinhaClick()
1911:         LOCAL loc_oGrid
1912:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1913:             RETURN
1914:         ENDIF
1915: 
1916:         IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes") OR ;
1917:            RECCOUNT("cursor_4c_Operacoes") = 0
1918:             MsgAviso("Nenhuma linha para excluir!", "Aviso")
1919:             RETURN
1920:         ENDIF
1921: 
1922:         IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Confirmar")
1923:             SELECT cursor_4c_Operacoes
1924:             DELETE
1925:             PACK IN cursor_4c_Operacoes
1926:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1927:             loc_oGrid.Refresh()
1928:         ENDIF
1929:     ENDPROC
1930: 
1931:     *--------------------------------------------------------------------------
1932:     * OpeGerAAfterRowColChange - Atualiza opt_4c_EnvRecs ao mudar linha do grid
1933:     *--------------------------------------------------------------------------
1934:     PROCEDURE OpeGerAAfterRowColChange(par_nColIndex)
1935:         TRY
1936:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Refresh()
1937:         CATCH TO loc_oErro
1938:             MsgErro("Erro em OpeGerAAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1939:         ENDTRY
1940:     ENDPROC

*-- Linhas 1975 a 2008:
1975: 
1976:     *--------------------------------------------------------------------------
1977:     * OpeGerACheckKeyPress - Enter/Space na coluna Agrupar do grid OpeGerA
1978:     *--------------------------------------------------------------------------
1979:     PROCEDURE OpeGerACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1980:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Operacoes") AND ;
1981:            !EOF("cursor_4c_Operacoes")
1982:             IF par_nKeyCode = 13
1983:                 REPLACE Agrupar WITH .NOT. Agrupar IN cursor_4c_Operacoes
1984:             ENDIF
1985:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
1986:         ENDIF
1987:     ENDPROC
1988: 
1989:     *--------------------------------------------------------------------------
1990:     * OpeGerACheckMouseDown - Clique na coluna Agrupar do grid OpeGerA
1991:     *--------------------------------------------------------------------------
1992:     PROCEDURE OpeGerACheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1993:         IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
1994:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
1995:         ENDIF
1996:     ENDPROC
1997: 
1998:     *--------------------------------------------------------------------------
1999:     * EstoqueACheckKeyPress - Enter/Space na coluna Marca do Estoque A
2000:     *--------------------------------------------------------------------------
2001:     PROCEDURE EstoqueACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2002:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_EstoqueA") AND ;
2003:            !EOF("cursor_4c_EstoqueA")
2004:             IF par_nKeyCode = 13
2005:                 REPLACE Marca WITH .NOT. Marca IN cursor_4c_EstoqueA
2006:             ENDIF
2007:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
2008:         ENDIF

*-- Linhas 2085 a 2103:
2085:             loc_oBusca.Show()
2086: 
2087:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2088:                 SELECT cursor_4c_BuscaEmp
2089:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2090:             ENDIF
2091: 
2092:             loc_oBusca.Release()
2093:         ENDIF
2094: 
2095:         IF USED("cursor_4c_BuscaEmp")
2096:             USE IN cursor_4c_BuscaEmp
2097:         ENDIF
2098:     ENDPROC
2099: 
2100:     *--------------------------------------------------------------------------
2101:     * LocalAKeyPress - F4 abre lookup de Local A
2102:     *--------------------------------------------------------------------------
2103:     PROCEDURE LocalAKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2135 a 2153:
2135:             loc_oBusca.Show()
2136: 
2137:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
2138:                 SELECT cursor_4c_BuscaLoc
2139:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
2140:             ENDIF
2141: 
2142:             loc_oBusca.Release()
2143:         ENDIF
2144: 
2145:         IF USED("cursor_4c_BuscaLoc")
2146:             USE IN cursor_4c_BuscaLoc
2147:         ENDIF
2148:     ENDPROC
2149: 
2150:     *--------------------------------------------------------------------------
2151:     * AbrirLookupLocalB - Lookup em SigCdLoc para Local B
2152:     *--------------------------------------------------------------------------
2153:     PROCEDURE AbrirLookupLocalB()

*-- Linhas 2167 a 2205:
2167:             loc_oBusca.Show()
2168: 
2169:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
2170:                 SELECT cursor_4c_BuscaLoc
2171:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
2172:             ENDIF
2173: 
2174:             loc_oBusca.Release()
2175:         ENDIF
2176: 
2177:         IF USED("cursor_4c_BuscaLoc")
2178:             USE IN cursor_4c_BuscaLoc
2179:         ENDIF
2180:     ENDPROC
2181: 
2182:     *--------------------------------------------------------------------------
2183:     * Destroy - Libera recursos
2184:     *--------------------------------------------------------------------------
2185:     PROCEDURE Destroy()
2186:         LOCAL loc_i
2187:         LOCAL ARRAY loc_aCursores(6)
2188:         loc_aCursores(1) = "cursor_4c_Dados"
2189:         loc_aCursores(2) = "cursor_4c_Carrega"
2190:         loc_aCursores(3) = "cursor_4c_Operacoes"
2191:         loc_aCursores(4) = "cursor_4c_Estoques"
2192:         loc_aCursores(5) = "cursor_4c_EstoqueA"
2193:         loc_aCursores(6) = "cursor_4c_EstoqueB"
2194: 
2195:         FOR loc_i = 1 TO ALEN(loc_aCursores)
2196:             IF USED(loc_aCursores(loc_i))
2197:                 USE IN (loc_aCursores(loc_i))
2198:             ENDIF
2199:         ENDFOR
2200: 
2201:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2202:             THIS.this_oBusinessObject = .NULL.
2203:         ENDIF
2204: 
2205:         DODEFAULT()

*-- Linhas 2226 a 2247:
2226:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
2227:                 loc_oGrid.ColumnCount  = 4
2228: 
2229:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
2230:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
2231:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.LocalA"
2232:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.LocalB"
2233: 
2234:                 loc_oGrid.Column1.Width = 150
2235:                 loc_oGrid.Column2.Width = 70
2236:                 loc_oGrid.Column3.Width = 150
2237:                 loc_oGrid.Column4.Width = 150
2238: 
2239:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2240:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
2241:                 loc_oGrid.Column3.Header1.Caption = "Local A"
2242:                 loc_oGrid.Column4.Header1.Caption = "Local B"
2243: 
2244:                 THIS.FormatarGridLista(loc_oGrid)
2245:                 loc_lResultado = .T.
2246:             ENDIF
2247:         CATCH TO loc_oErro

*-- Linhas 2493 a 2511:
2493:         loc_cCodigo = ""
2494: 
2495:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2496:             SELECT cursor_4c_Dados
2497:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2498:         ENDIF
2499: 
2500:         IF EMPTY(loc_cCodigo)
2501:             MsgAviso("Selecione um registro na lista!", "Aviso")
2502:             RETURN
2503:         ENDIF
2504: 
2505:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2506:             THIS.this_cModoAtual = "VISUALIZAR"
2507:             THIS.BOParaForm()
2508:             THIS.HabilitarCampos(.F.)
2509:             THIS.AjustarBotoesPorModo()
2510:             THIS.pgf_4c_Paginas.ActivePage = 2
2511:             THIS.CarregarGridOperacoes(loc_cCodigo)

*-- Linhas 2523 a 2541:
2523:         loc_cCodigo = ""
2524: 
2525:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2526:             SELECT cursor_4c_Dados
2527:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2528:         ENDIF
2529: 
2530:         IF EMPTY(loc_cCodigo)
2531:             MsgAviso("Selecione um registro na lista!", "Aviso")
2532:             RETURN
2533:         ENDIF
2534: 
2535:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2536:             THIS.this_oBusinessObject.EditarRegistro()
2537:             THIS.this_cModoAtual = "ALTERAR"
2538:             THIS.BOParaForm()
2539:             THIS.HabilitarCampos(.T.)
2540:             THIS.AjustarBotoesPorModo()
2541:             THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 2554 a 2572:
2554:         loc_cCodigo = ""
2555: 
2556:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2557:             SELECT cursor_4c_Dados
2558:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2559:         ENDIF
2560: 
2561:         IF EMPTY(loc_cCodigo)
2562:             MsgAviso("Selecione um registro na lista!", "Aviso")
2563:             RETURN
2564:         ENDIF
2565: 
2566:         IF !MsgConfirma("Deseja excluir o comparativo '" + loc_cCodigo + "'?" + CHR(13) + ;
2567:                         "Todas as opera" + CHR(231) + CHR(245) + "es e estoques vinculados ser" + CHR(227) + "o exclu" + CHR(237) + "dos!", ;
2568:                         "Confirmar Exclus" + CHR(227) + "o")
2569:             RETURN
2570:         ENDIF
2571: 
2572:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 2602 a 2635:
2602:                 loc_oBusca.Show()
2603: 
2604:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClc")
2605:                     SELECT cursor_4c_BuscaClc
2606:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaClc.Codigos)
2607:                 ENDIF
2608: 
2609:                 loc_oBusca.Release()
2610:             ENDIF
2611:         CATCH TO loc_oErro
2612:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2613:         ENDTRY
2614: 
2615:         IF USED("cursor_4c_BuscaClc")
2616:             USE IN cursor_4c_BuscaClc
2617:         ENDIF
2618: 
2619:         IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2620:             SELECT cursor_4c_Dados
2621:             LOCATE FOR ALLTRIM(cursor_4c_Dados.Codigos) == loc_cCodigo
2622:             IF FOUND()
2623:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2624:             ENDIF
2625:         ENDIF
2626:     ENDPROC
2627: 
2628:     *--------------------------------------------------------------------------
2629:     * GridListaDblClick - DblClick no grid abre modo Visualizar
2630:     *--------------------------------------------------------------------------
2631:     PROCEDURE GridListaDblClick()
2632:         THIS.BtnVisualizarClick()
2633:     ENDPROC
2634: 
2635:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\CLCBO.prg):
*===============================================================================
* CLCBO.prg - Business Object para Comparativos Entre Locais
* Tabela principal: SigLcLo (PK: Codigos)
* Tabelas relacionadas: SigLcLoI (operacoes), SigLcLoE (estoques avaliados)
*===============================================================================
DEFINE CLASS CLCBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigLcLo"
    this_cCampoChave = "Codigos"

    *---------------------------------------------------------------------------
    * Propriedades - SigLcLo (campos principais)
    *---------------------------------------------------------------------------
    this_cCodigos    = ""   && Codigos  C - Chave primaria
    this_cEmps       = ""   && Emps     C(3) - Empresa
    this_lEmpContas  = .F.  && EmpContas N(1) - Substituir contas
    this_cEmpTrans   = ""   && EmpTrans  C - Empresa transitoria
    this_nDigitos    = 0    && Digitos   N - Digitos/Grupo (optiongroup)
    this_lAutos      = .F.  && Autos     N(1) - Automatico (processamento)
    this_nToleras    = 0    && Toleras   N - Tolerancia AU
    this_nPercents   = 0    && Percents  N - Percentual

    *-- Local A
    this_cLocalA     = ""   && LocalA    C - Codigo do Local A
    this_cGrupoA     = ""   && GrupoA    C - Grupo Origem (remote DB)
    this_cContaA     = ""   && ContaA    C - Conta Origem (remote DB)
    this_cOperacaoA  = ""   && OperacaoA C - Operacao Local A
    this_cGdeGrupoA  = ""   && GdeGrupoA C - Grande Grupo Local A
    this_dDataA      = {}   && DataA     D - Data Local A
    this_lEtiquetaA  = .F.  && EtiquetaA N(1) - Etiquetas Local A
    this_lPalmA      = .F.  && PalmA     N(1) - Checar Venda Palm A
    this_nDivisaoA   = 0    && DivisaoA  N - Divisao Local A

    *-- Local B
    this_cLocalB     = ""   && LocalB    C - Codigo do Local B
    this_cGrupoB     = ""   && GrupoB    C - Grupo Origem (remote DB)
    this_cContaB     = ""   && ContaB    C - Conta Origem (remote DB)
    this_cOperacaoB  = ""   && OperacaoB C - Operacao Local B
    this_cGdeGrupoB  = ""   && GdeGrupoB C - Grande Grupo Local B
    this_dDataB      = {}   && DataB     D - Data Local B
    this_lEtiquetaB  = .F.  && EtiquetaB N(1) - Etiquetas Local B
    this_lPalmB      = .F.  && PalmB     N(1) - Checar Venda Palm B
    this_nDivisaoB   = 0    && DivisaoB  N - Divisao Local B

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigLcLo"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *---------------------------------------------------------------------------
    * Buscar - SELECT de todos os registros de SigLcLo
    *---------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo ORDER BY Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro especifico pelo codigo
    *---------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            IF VARTYPE(EmpContas) = "L"
                THIS.this_lEmpContas = EmpContas
            ELSE
                IF VARTYPE(EmpContas) = "L"
                    THIS.this_lEmpContas = EmpContas
                ELSE
                    THIS.this_lEmpContas = (NVL(EmpContas, 0) = 1)
                ENDIF
            ENDIF
            THIS.this_cEmpTrans  = TratarNulo(EmpTrans,  "C")
            THIS.this_nDigitos   = TratarNulo(Digitos,   "N")
            IF VARTYPE(Autos) = "L"
                THIS.this_lAutos = Autos
            ELSE
                IF VARTYPE(Autos) = "L"
                    THIS.this_lAutos = Autos
                ELSE
                    THIS.this_lAutos = (NVL(Autos, 0) = 1)
                ENDIF
            ENDIF
            THIS.this_nToleras   = TratarNulo(Toleras,   "N")
            THIS.this_nPercents  = TratarNulo(Percents,  "N")
            THIS.this_cLocalA    = TratarNulo(LocalA,    "C")
            THIS.this_cGrupoA    = TratarNulo(GrupoA,    "C")
            THIS.this_cContaA    = TratarNulo(ContaA,    "C")
            THIS.this_cOperacaoA = TratarNulo(OperacaoA, "C")
            THIS.this_cGdeGrupoA = TratarNulo(GdeGrupoA, "C")
            THIS.this_dDataA     = TratarNulo(DataA,     "D")
            IF VARTYPE(EtiquetaA) = "L"
                THIS.this_lEtiquetaA = EtiquetaA
            ELSE
                IF VARTYPE(EtiquetaA) = "L"
                    THIS.this_lEtiquetaA = EtiquetaA
                ELSE
                    THIS.this_lEtiquetaA = (NVL(EtiquetaA, 0) = 1)
                ENDIF
            ENDIF
            IF VARTYPE(PalmA) = "L"
                THIS.this_lPalmA = PalmA
            ELSE
                IF VARTYPE(PalmA) = "L"
                    THIS.this_lPalmA = PalmA
                ELSE
                    THIS.this_lPalmA = (NVL(PalmA, 0) = 1)
                ENDIF
            ENDIF
            THIS.this_nDivisaoA  = TratarNulo(DivisaoA,  "N")
            THIS.this_cLocalB    = TratarNulo(LocalB,    "C")
            THIS.this_cGrupoB    = TratarNulo(GrupoB,    "C")
            THIS.this_cContaB    = TratarNulo(ContaB,    "C")
            THIS.this_cOperacaoB = TratarNulo(OperacaoB, "C")
            THIS.this_cGdeGrupoB = TratarNulo(GdeGrupoB, "C")
            THIS.this_dDataB     = TratarNulo(DataB,     "D")
            IF VARTYPE(EtiquetaB) = "L"
                THIS.this_lEtiquetaB = EtiquetaB
            ELSE
                IF VARTYPE(EtiquetaB) = "L"
                    THIS.this_lEtiquetaB = EtiquetaB
                ELSE
                    THIS.this_lEtiquetaB = (NVL(EtiquetaB, 0) = 1)
                ENDIF
            ENDIF
            IF VARTYPE(PalmB) = "L"
                THIS.this_lPalmB = PalmB
            ELSE
                IF VARTYPE(PalmB) = "L"
                    THIS.this_lPalmB = PalmB
                ELSE
                    THIS.this_lPalmB = (NVL(PalmB, 0) = 1)
                ENDIF
            ENDIF
            THIS.this_nDivisaoB  = TratarNulo(DivisaoB,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarOperacoes - Carrega SigLcLoI para o cursor do grid de operacoes
    *---------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF

        TRY
            loc_cSQL = "SELECT cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       " FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cIdChaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Operacoes")
                    GO TOP IN cursor_4c_Operacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarEstoques - Carrega SigLcLoE (estoques avaliados) para um local
    *---------------------------------------------------------------------------
    PROCEDURE CarregarEstoques(par_cCodigos, par_cLocal, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cCursorDestino)
            USE IN (par_cCursorDestino)
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Locals, Emps, Grupos, Contas, Marca" + ;
                       " FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal) + ;
                       " ORDER BY Emps, Grupos, Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                IF USED(par_cCursorDestino)
                    GO TOP IN (par_cCursorDestino)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarCodigoDuplicado - Verifica se o codigo ja existe na tabela
    *---------------------------------------------------------------------------
    PROCEDURE VerificarCodigoDuplicado(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                GO TOP IN cursor_4c_ChkDup
                loc_lExiste = (cursor_4c_ChkDup.Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarCodigoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - INSERT INTO SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLo (" + ;
                       " Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents," + ;
                       " LocalA, GrupoA, ContaA, OperacaoA, GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB, GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cEmps)      + "," + ;
                       IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       EscaparSQL(THIS.this_cContaA)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       EscaparSQL(THIS.this_cContaB)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - UPDATE SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigLcLo SET" + ;
                       " Emps      = " + EscaparSQL(THIS.this_cEmps)      + "," + ;
                       " EmpContas = " + IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       " EmpTrans  = " + EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       " Digitos   = " + FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       " Autos     = " + IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       " Toleras   = " + FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       " Percents  = " + FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       " LocalA    = " + EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       " GrupoA    = " + EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       " ContaA    = " + EscaparSQL(THIS.this_cContaA)    + "," + ;
                       " OperacaoA = " + EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       " GdeGrupoA = " + EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       " DataA     = " + FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       " EtiquetaA = " + IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       " PalmA     = " + IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       " DivisaoA  = " + FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       " LocalB    = " + EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       " GrupoB    = " + EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       " ContaB    = " + EscaparSQL(THIS.this_cContaB)    + "," + ;
                       " OperacaoB = " + EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       " GdeGrupoB = " + EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       " DataB     = " + FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       " EtiquetaB = " + IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       " PalmB     = " + IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       " DivisaoB  = " + FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigLcLoI + SigLcLoE + SigLcLo (PROTECTED)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros filhos de SigLcLoI primeiro
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir registros filhos de SigLcLoE
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir estoques avaliados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir o registro principal
            loc_cSQL = "DELETE FROM SigLcLo WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * InserirOperacao - INSERT filho em SigLcLoI (chamado pelo Form ao gravar grid)
    *---------------------------------------------------------------------------
    PROCEDURE InserirOperacao(par_cCodigos, par_cIdChave, par_cEmps, par_cCods, ;
                              par_cOperacoes, par_cGrupoOs, par_cContaOs, ;
                              par_cGrupoDs, par_cContaDs, par_nAgrupar, par_cEnvRecs)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLoI (" + ;
                       " cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       ") VALUES (" + ;
                       EscaparSQL(par_cIdChave)   + "," + ;
                       EscaparSQL(par_cCodigos)   + "," + ;
                       EscaparSQL(par_cEmps)      + "," + ;
                       EscaparSQL(par_cCods)      + "," + ;
                       EscaparSQL(par_cOperacoes) + "," + ;
                       EscaparSQL(par_cGrupoOs)   + "," + ;
                       EscaparSQL(par_cContaOs)   + "," + ;
                       EscaparSQL(par_cGrupoDs)   + "," + ;
                       EscaparSQL(par_cContaDs)   + "," + ;
                       FormatarNumeroSQL(par_nAgrupar) + "," + ;
                       EscaparSQL(par_cEnvRecs)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InserirOperacao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExcluirOperacoes - DELETE todos os filhos de SigLcLoI para um codigo
    *---------------------------------------------------------------------------
    PROCEDURE ExcluirOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExcluirOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * GravarEstoques - DELETE + re-INSERT em SigLcLoE para um local
    *---------------------------------------------------------------------------
    PROCEDURE GravarEstoques(par_cCodigos, par_cLocal, par_cCursorOrigem)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros anteriores deste local
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Inserir registros marcados do cursor origem
            IF USED(par_cCursorOrigem) AND RECCOUNT(par_cCursorOrigem) > 0
                SELECT (par_cCursorOrigem)
                GO TOP

                SCAN
                    SELECT (par_cCursorOrigem)
                    IF Marca
                        loc_cSQL = "INSERT INTO SigLcLoE (Codigos, Locals, Emps, Grupos, Contas, Marca)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(par_cCodigos) + "," + ;
                                   EscaparSQL(par_cLocal)   + "," + ;
                                   EscaparSQL(ALLTRIM(Emps))   + "," + ;
                                   EscaparSQL(ALLTRIM(Grupos)) + "," + ;
                                   EscaparSQL(ALLTRIM(Contas)) + "," + ;
                                   "1)"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao gravar estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em GravarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

