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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCLC.prg) - TRECHOS RELEVANTES PARA PASS SQL (2788 linhas total):

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
377:             .Column1.Header1.Caption = ""
378:             .Column2.Header1.Caption = "Emp"
379:             .Column3.Header1.Caption = "Local"
380:             .Column4.Header1.Caption = "Local"
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

*-- Linhas 1448 a 1475:
1448:             .HighlightBackColor = RGB(255, 255, 255)
1449:             .HighlightForeColor = RGB(15, 41, 104)
1450:             .HighlightStyle     = 2
1451:             .DeleteMark         = .F.
1452:             .RecordMark         = .F.
1453:             .RowHeight          = 16
1454:             .ScrollBars         = 3
1455:             .GridLines          = 3
1456:             .Visible            = .T.
1457:             .Column1.ControlSource = "cursor_4c_EstoqueA.Marca"
1458:             .Column2.ControlSource = "cursor_4c_EstoqueA.Emps"
1459:             .Column3.ControlSource = "cursor_4c_EstoqueA.Grupos"
1460:             .Column4.ControlSource = "cursor_4c_EstoqueA.Contas"
1461:             .Column1.Width = 22
1462:             .Column2.Width = 35
1463:             .Column3.Width = 90
1464:             .Column4.Width = 95
1465:             .Column1.Header1.Caption = ""
1466:             .Column2.Header1.Caption = "Emp"
1467:             .Column3.Header1.Caption = "Grupo"
1468:             .Column4.Header1.Caption = "Conta"
1469:             .Column1.Sparse   = .F.
1470:             .Column1.ReadOnly = .F.
1471:             .Column2.ReadOnly = .T.
1472:             .Column3.ReadOnly = .T.
1473:             .Column4.ReadOnly = .T.
1474:         ENDWITH
1475: 

*-- Linhas 1540 a 1567:
1540:             .HighlightBackColor = RGB(255, 255, 255)
1541:             .HighlightForeColor = RGB(15, 41, 104)
1542:             .HighlightStyle     = 2
1543:             .DeleteMark         = .F.
1544:             .RecordMark         = .F.
1545:             .RowHeight          = 16
1546:             .ScrollBars         = 3
1547:             .GridLines          = 3
1548:             .Visible            = .T.
1549:             .Column1.ControlSource = "cursor_4c_EstoqueB.Marca"
1550:             .Column2.ControlSource = "cursor_4c_EstoqueB.Emps"
1551:             .Column3.ControlSource = "cursor_4c_EstoqueB.Grupos"
1552:             .Column4.ControlSource = "cursor_4c_EstoqueB.Contas"
1553:             .Column1.Width = 22
1554:             .Column2.Width = 35
1555:             .Column3.Width = 90
1556:             .Column4.Width = 95
1557:             .Column1.Header1.Caption = ""
1558:             .Column2.Header1.Caption = "Emp"
1559:             .Column3.Header1.Caption = "Grupo"
1560:             .Column4.Header1.Caption = "Conta"
1561:             .Column1.Sparse   = .F.
1562:             .Column1.ReadOnly = .F.
1563:             .Column2.ReadOnly = .T.
1564:             .Column3.ReadOnly = .T.
1565:             .Column4.ReadOnly = .T.
1566:         ENDWITH
1567: 

*-- Linhas 1605 a 1676:
1605:     * CriarCursoresOperacoesVazios - Cursores placeholder com tipos corretos
1606:     *--------------------------------------------------------------------------
1607:     PROTECTED PROCEDURE CriarCursoresOperacoesVazios()
1608:         SET NULL ON
1609: 
1610:         IF USED("cursor_4c_Operacoes")
1611:             USE IN cursor_4c_Operacoes
1612:         ENDIF
1613:         CREATE CURSOR cursor_4c_Operacoes (cIdChaves C(36), Codigos C(20), ;
1614:             Emps C(3), Cods C(20), Operacoes C(20), ;
1615:             GrupoOs C(40), ContaOs C(40), ;
1616:             GrupoDs C(40), ContaDs C(40), Agrupar L, EnvRecs C(1))
1617: 
1618:         IF USED("cursor_4c_EstoqueA")
1619:             USE IN cursor_4c_EstoqueA
1620:         ENDIF
1621:         CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
1622:             Emps C(3), Grupos C(40), Contas C(40), Marca L)
1623: 
1624:         IF USED("cursor_4c_EstoqueB")
1625:             USE IN cursor_4c_EstoqueB
1626:         ENDIF
1627:         CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
1628:             Emps C(3), Grupos C(40), Contas C(40), Marca L)
1629: 
1630:         SET NULL OFF
1631:     ENDPROC
1632: 
1633:     *--------------------------------------------------------------------------
1634:     * CarregarGridOperacoes - Carrega grd_4c_OpeGerA com dados de SigLcLoI
1635:     *--------------------------------------------------------------------------
1636:     PROTECTED PROCEDURE CarregarGridOperacoes(par_cCodigos)
1637:         LOCAL loc_lSucesso, loc_oGrid
1638:         loc_lSucesso = .F.
1639: 
1640:         TRY
1641:             loc_lSucesso = THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)
1642: 
1643:             IF !loc_lSucesso OR !USED("cursor_4c_Operacoes")
1644:                 THIS.CriarCursoresOperacoesVazios()
1645:                 loc_lSucesso = .T.
1646:             ENDIF
1647: 
1648:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1649:             loc_oGrid.RecordSource = ""
1650:             loc_oGrid.ColumnCount = 8
1651:             loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1652:             loc_oGrid.ColumnCount  = 8
1653: 
1654:             loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Emps"
1655:             loc_oGrid.Column2.ControlSource = "cursor_4c_Operacoes.Cods"
1656:             loc_oGrid.Column3.ControlSource = "cursor_4c_Operacoes.Operacoes"
1657:             loc_oGrid.Column4.ControlSource = "cursor_4c_Operacoes.GrupoOs"
1658:             loc_oGrid.Column5.ControlSource = "cursor_4c_Operacoes.ContaOs"
1659:             loc_oGrid.Column6.ControlSource = "cursor_4c_Operacoes.GrupoDs"
1660:             loc_oGrid.Column7.ControlSource = "cursor_4c_Operacoes.ContaDs"
1661:             loc_oGrid.Column8.ControlSource = "cursor_4c_Operacoes.Agrupar"
1662: 
1663:             loc_oGrid.Column1.Width = 35
1664:             loc_oGrid.Column2.Width = 80
1665:             loc_oGrid.Column3.Width = 80
1666:             loc_oGrid.Column4.Width = 90
1667:             loc_oGrid.Column5.Width = 100
1668:             loc_oGrid.Column6.Width = 90
1669:             loc_oGrid.Column7.Width = 100
1670:             loc_oGrid.Column8.Width = 28
1671: 
1672:             loc_oGrid.Column1.Header1.Caption = "Emp"
1673:             loc_oGrid.Column2.Header1.Caption = "Local"
1674:             loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1675:             loc_oGrid.Column4.Header1.Caption = "Grupo Origem"
1676:             loc_oGrid.Column5.Header1.Caption = "Conta Origem"

*-- Linhas 1723 a 1754:
1723:                     USE IN cursor_4c_EstoqueA
1724:                 ENDIF
1725:                 SET NULL ON
1726:                 CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
1727:                     Emps C(3), Grupos C(40), Contas C(40), Marca L)
1728:                 SET NULL OFF
1729:             ENDIF
1730: 
1731:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA
1732:             loc_oGrid.RecordSource = ""
1733:             loc_oGrid.ColumnCount = 4
1734:             loc_oGrid.RecordSource = "cursor_4c_EstoqueA"
1735:             loc_oGrid.ColumnCount  = 4
1736:             loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueA.Marca"
1737:             loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueA.Emps"
1738:             loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueA.Grupos"
1739:             loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueA.Contas"
1740:             loc_oGrid.Column1.Width = 22
1741:             loc_oGrid.Column2.Width = 35
1742:             loc_oGrid.Column3.Width = 90
1743:             loc_oGrid.Column4.Width = 95
1744:             loc_oGrid.Column1.Header1.Caption = ""
1745:             loc_oGrid.Column2.Header1.Caption = "Emp"
1746:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1747:             loc_oGrid.Column4.Header1.Caption = "Conta"
1748:             loc_oGrid.Column1.Sparse   = .F.
1749:             loc_oGrid.Column1.ReadOnly = .F.
1750:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
1751:                 loc_oGrid.Column1.Check1.Alignment = 0
1752:                 loc_oGrid.Column1.Check1.ReadOnly  = .F.
1753:                 loc_oGrid.Column1.Check1.Visible   = .T.
1754:                 loc_oGrid.Column1.Check1.Top       = 9

*-- Linhas 1770 a 1801:
1770:                     USE IN cursor_4c_EstoqueB
1771:                 ENDIF
1772:                 SET NULL ON
1773:                 CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
1774:                     Emps C(3), Grupos C(40), Contas C(40), Marca L)
1775:                 SET NULL OFF
1776:             ENDIF
1777: 
1778:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB
1779:             loc_oGrid.RecordSource = ""
1780:             loc_oGrid.ColumnCount = 4
1781:             loc_oGrid.RecordSource = "cursor_4c_EstoqueB"
1782:             loc_oGrid.ColumnCount  = 4
1783:             loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueB.Marca"
1784:             loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueB.Emps"
1785:             loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueB.Grupos"
1786:             loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueB.Contas"
1787:             loc_oGrid.Column1.Width = 22
1788:             loc_oGrid.Column2.Width = 35
1789:             loc_oGrid.Column3.Width = 90
1790:             loc_oGrid.Column4.Width = 95
1791:             loc_oGrid.Column1.Header1.Caption = ""
1792:             loc_oGrid.Column2.Header1.Caption = "Emp"
1793:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1794:             loc_oGrid.Column4.Header1.Caption = "Conta"
1795:             loc_oGrid.Column1.Sparse   = .F.
1796:             loc_oGrid.Column1.ReadOnly = .F.
1797:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
1798:                 loc_oGrid.Column1.Check1.Alignment = 0
1799:                 loc_oGrid.Column1.Check1.ReadOnly  = .F.
1800:                 loc_oGrid.Column1.Check1.Visible   = .T.
1801:                 loc_oGrid.Column1.Check1.Top       = 9

*-- Linhas 1833 a 1875:
1833:         TRY
1834:             *-- Excluir operacoes anteriores
1835:             loc_oBO.ExcluirOperacoes(par_cCodigos)
1836: 
1837:             *-- Reinserir operacoes validas do cursor
1838:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
1839:                 SELECT cursor_4c_Operacoes
1840:                 GO TOP
1841: 
1842:                 loc_nEnvRecs = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Value
1843: 
1844:                 SCAN
1845:                     IF !EMPTY(ALLTRIM(cursor_4c_Operacoes.Cods)) OR ;
1846:                        !EMPTY(ALLTRIM(cursor_4c_Operacoes.Operacoes))
1847: 
1848:                         loc_cIdChave = TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS") + ;
1849:                                        PADL(TRANSFORM(RECNO()), 4, "0")
1850: 
1851:                         loc_oBO.InserirOperacao(par_cCodigos, ;
1852:                             loc_cIdChave, ;
1853:                             ALLTRIM(cursor_4c_Operacoes.Emps), ;
1854:                             ALLTRIM(cursor_4c_Operacoes.Cods), ;
1855:                             ALLTRIM(cursor_4c_Operacoes.Operacoes), ;
1856:                             ALLTRIM(cursor_4c_Operacoes.GrupoOs), ;
1857:                             ALLTRIM(cursor_4c_Operacoes.ContaOs), ;
1858:                             ALLTRIM(cursor_4c_Operacoes.GrupoDs), ;
1859:                             ALLTRIM(cursor_4c_Operacoes.ContaDs), ;
1860:                             IIF(cursor_4c_Operacoes.Agrupar, 1, 0), ;
1861:                             IIF(loc_nEnvRecs = 1, "A", "B"))
1862:                     ENDIF
1863:                 ENDSCAN
1864:             ENDIF
1865: 
1866:             *-- Gravar estoques A e B
1867:             IF !EMPTY(loc_cLocalA)
1868:                 loc_oBO.GravarEstoques(par_cCodigos, loc_cLocalA, "cursor_4c_EstoqueA")
1869:             ENDIF
1870: 
1871:             IF !EMPTY(loc_cLocalB)
1872:                 loc_oBO.GravarEstoques(par_cCodigos, loc_cLocalB, "cursor_4c_EstoqueB")
1873:             ENDIF
1874: 
1875:             loc_lSucesso = .T.

*-- Linhas 1888 a 1972:
1888:         LOCAL loc_oGrid
1889:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1890:             RETURN
1891:         ENDIF
1892: 
1893:         IF !USED("cursor_4c_Operacoes")
1894:             THIS.CriarCursoresOperacoesVazios()
1895:         ENDIF
1896: 
1897:         SELECT cursor_4c_Operacoes
1898:         INSERT INTO cursor_4c_Operacoes (cIdChaves, Codigos, Emps, Cods, Operacoes, ;
1899:             GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs) ;
1900:             VALUES ("", THIS.this_oBusinessObject.this_cCodigos, "", "", "", ;
1901:                     "", "", "", "", .F., "")
1902: 
1903:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1904:         loc_oGrid.Refresh()
1905:         GO BOTTOM IN cursor_4c_Operacoes
1906:         loc_oGrid.Column1.SetFocus()
1907:     ENDPROC
1908: 
1909:     *--------------------------------------------------------------------------
1910:     * BtnExcluirLinhaClick - Remove linha corrente do cursor de operacoes
1911:     *--------------------------------------------------------------------------
1912:     PROCEDURE BtnExcluirLinhaClick()
1913:         LOCAL loc_oGrid
1914:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1915:             RETURN
1916:         ENDIF
1917: 
1918:         IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes") OR ;
1919:            RECCOUNT("cursor_4c_Operacoes") = 0
1920:             MsgAviso("Nenhuma linha para excluir!", "Aviso")
1921:             RETURN
1922:         ENDIF
1923: 
1924:         IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Confirmar")
1925:             SELECT cursor_4c_Operacoes
1926:             DELETE
1927:             PACK IN cursor_4c_Operacoes
1928:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1929:             loc_oGrid.Refresh()
1930:         ENDIF
1931:     ENDPROC
1932: 
1933:     *--------------------------------------------------------------------------
1934:     * OpeGerAAfterRowColChange - Atualiza opt_4c_EnvRecs ao mudar linha do grid
1935:     *--------------------------------------------------------------------------
1936:     PROCEDURE OpeGerAAfterRowColChange(par_nColIndex)
1937:         TRY
1938:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Refresh()
1939:         CATCH TO loc_oErro
1940:             MsgErro("Erro em OpeGerAAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1941:         ENDTRY
1942:     ENDPROC
1943: 
1944:     *--------------------------------------------------------------------------
1945:     * EnvRecsInteractiveChange - Grava direcao de movimentacao na linha corrente do grid
1946:     *--------------------------------------------------------------------------
1947:     PROCEDURE EnvRecsInteractiveChange()
1948:         LOCAL loc_nVal
1949:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1950:             RETURN
1951:         ENDIF
1952:         IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes")
1953:             RETURN
1954:         ENDIF
1955:         TRY
1956:             loc_nVal = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Value
1957:             REPLACE EnvRecs WITH IIF(loc_nVal = 1, "A", "B") IN cursor_4c_Operacoes
1958:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
1959:         CATCH TO loc_oErro
1960:             MsgErro(loc_oErro.Message, "EnvRecsInteractiveChange")
1961:         ENDTRY
1962:     ENDPROC
1963: 
1964:     *--------------------------------------------------------------------------
1965:     * BtnMarcarTodosAClick/BtnDesmarcarTodosAClick - Estoque A
1966:     *--------------------------------------------------------------------------
1967:     PROCEDURE BtnMarcarTodosAClick()
1968:         IF USED("cursor_4c_EstoqueA") AND RECCOUNT("cursor_4c_EstoqueA") > 0
1969:             REPLACE ALL Marca WITH .T. IN cursor_4c_EstoqueA
1970:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
1971:         ENDIF
1972:     ENDPROC

*-- Linhas 1997 a 2030:
1997: 
1998:     *--------------------------------------------------------------------------
1999:     * OpeGerACheckKeyPress - Enter/Space na coluna Agrupar do grid OpeGerA
2000:     *--------------------------------------------------------------------------
2001:     PROCEDURE OpeGerACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2002:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Operacoes") AND ;
2003:            !EOF("cursor_4c_Operacoes")
2004:             IF par_nKeyCode = 13
2005:                 REPLACE Agrupar WITH .NOT. Agrupar IN cursor_4c_Operacoes
2006:             ENDIF
2007:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
2008:         ENDIF
2009:     ENDPROC
2010: 
2011:     *--------------------------------------------------------------------------
2012:     * OpeGerACheckMouseDown - Clique na coluna Agrupar do grid OpeGerA
2013:     *--------------------------------------------------------------------------
2014:     PROCEDURE OpeGerACheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
2015:         IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
2016:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
2017:         ENDIF
2018:     ENDPROC
2019: 
2020:     *--------------------------------------------------------------------------
2021:     * EstoqueACheckKeyPress - Enter/Space na coluna Marca do Estoque A
2022:     *--------------------------------------------------------------------------
2023:     PROCEDURE EstoqueACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2024:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_EstoqueA") AND ;
2025:            !EOF("cursor_4c_EstoqueA")
2026:             IF par_nKeyCode = 13
2027:                 REPLACE Marca WITH .NOT. Marca IN cursor_4c_EstoqueA
2028:             ENDIF
2029:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
2030:         ENDIF

*-- Linhas 2107 a 2125:
2107:             loc_oBusca.Show()
2108: 
2109:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2110:                 SELECT cursor_4c_BuscaEmp
2111:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2112:             ENDIF
2113: 
2114:             loc_oBusca.Release()
2115:         ENDIF
2116: 
2117:         IF USED("cursor_4c_BuscaEmp")
2118:             USE IN cursor_4c_BuscaEmp
2119:         ENDIF
2120:     ENDPROC
2121: 
2122:     *--------------------------------------------------------------------------
2123:     * LocalAKeyPress - F4 abre lookup de Local A
2124:     *--------------------------------------------------------------------------
2125:     PROCEDURE LocalAKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2157 a 2175:
2157:             loc_oBusca.Show()
2158: 
2159:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
2160:                 SELECT cursor_4c_BuscaLoc
2161:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
2162:             ENDIF
2163: 
2164:             loc_oBusca.Release()
2165:         ENDIF
2166: 
2167:         IF USED("cursor_4c_BuscaLoc")
2168:             USE IN cursor_4c_BuscaLoc
2169:         ENDIF
2170:     ENDPROC
2171: 
2172:     *--------------------------------------------------------------------------
2173:     * AbrirLookupLocalB - Lookup em SigCdLoc para Local B
2174:     *--------------------------------------------------------------------------
2175:     PROCEDURE AbrirLookupLocalB()

*-- Linhas 2189 a 2227:
2189:             loc_oBusca.Show()
2190: 
2191:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
2192:                 SELECT cursor_4c_BuscaLoc
2193:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
2194:             ENDIF
2195: 
2196:             loc_oBusca.Release()
2197:         ENDIF
2198: 
2199:         IF USED("cursor_4c_BuscaLoc")
2200:             USE IN cursor_4c_BuscaLoc
2201:         ENDIF
2202:     ENDPROC
2203: 
2204:     *--------------------------------------------------------------------------
2205:     * Destroy - Libera recursos
2206:     *--------------------------------------------------------------------------
2207:     PROCEDURE Destroy()
2208:         LOCAL loc_i
2209:         LOCAL ARRAY loc_aCursores(6)
2210:         loc_aCursores(1) = "cursor_4c_Dados"
2211:         loc_aCursores(2) = "cursor_4c_Carrega"
2212:         loc_aCursores(3) = "cursor_4c_Operacoes"
2213:         loc_aCursores(4) = "cursor_4c_Estoques"
2214:         loc_aCursores(5) = "cursor_4c_EstoqueA"
2215:         loc_aCursores(6) = "cursor_4c_EstoqueB"
2216: 
2217:         FOR loc_i = 1 TO ALEN(loc_aCursores)
2218:             IF USED(loc_aCursores(loc_i))
2219:                 USE IN (loc_aCursores(loc_i))
2220:             ENDIF
2221:         ENDFOR
2222: 
2223:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2224:             THIS.this_oBusinessObject = .NULL.
2225:         ENDIF
2226: 
2227:         DODEFAULT()

*-- Linhas 2248 a 2269:
2248:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
2249:                 loc_oGrid.ColumnCount  = 4
2250: 
2251:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
2252:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
2253:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.LocalA"
2254:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.LocalB"
2255: 
2256:                 loc_oGrid.Column1.Width = 150
2257:                 loc_oGrid.Column2.Width = 70
2258:                 loc_oGrid.Column3.Width = 150
2259:                 loc_oGrid.Column4.Width = 150
2260: 
2261:                 loc_oGrid.Column1.Header1.Caption = ""
2262:                 loc_oGrid.Column2.Header1.Caption = "Emp"
2263:                 loc_oGrid.Column3.Header1.Caption = "Local"
2264:                 loc_oGrid.Column4.Header1.Caption = "Local"
2265: 
2266:                 THIS.FormatarGridLista(loc_oGrid)
2267:                 loc_lResultado = .T.
2268:             ENDIF
2269:         CATCH TO loc_oErro

*-- Linhas 2515 a 2533:
2515:         loc_cCodigo = ""
2516: 
2517:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2518:             SELECT cursor_4c_Dados
2519:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2520:         ENDIF
2521: 
2522:         IF EMPTY(loc_cCodigo)
2523:             MsgAviso("Selecione um registro na lista!", "Aviso")
2524:             RETURN
2525:         ENDIF
2526: 
2527:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2528:             THIS.this_cModoAtual = "VISUALIZAR"
2529:             THIS.BOParaForm()
2530:             THIS.HabilitarCampos(.F.)
2531:             THIS.AjustarBotoesPorModo()
2532:             THIS.pgf_4c_Paginas.ActivePage = 2
2533:             THIS.CarregarGridOperacoes(loc_cCodigo)

*-- Linhas 2545 a 2563:
2545:         loc_cCodigo = ""
2546: 
2547:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2548:             SELECT cursor_4c_Dados
2549:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2550:         ENDIF
2551: 
2552:         IF EMPTY(loc_cCodigo)
2553:             MsgAviso("Selecione um registro na lista!", "Aviso")
2554:             RETURN
2555:         ENDIF
2556: 
2557:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2558:             THIS.this_oBusinessObject.EditarRegistro()
2559:             THIS.this_cModoAtual = "ALTERAR"
2560:             THIS.BOParaForm()
2561:             THIS.HabilitarCampos(.T.)
2562:             THIS.AjustarBotoesPorModo()
2563:             THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 2576 a 2594:
2576:         loc_cCodigo = ""
2577: 
2578:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2579:             SELECT cursor_4c_Dados
2580:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2581:         ENDIF
2582: 
2583:         IF EMPTY(loc_cCodigo)
2584:             MsgAviso("Selecione um registro na lista!", "Aviso")
2585:             RETURN
2586:         ENDIF
2587: 
2588:         IF !MsgConfirma("Deseja excluir o comparativo '" + loc_cCodigo + "'?" + CHR(13) + ;
2589:                         "Todas as opera" + CHR(231) + CHR(245) + "es e estoques vinculados ser" + CHR(227) + "o exclu" + CHR(237) + "dos!", ;
2590:                         "Confirmar Exclus" + CHR(227) + "o")
2591:             RETURN
2592:         ENDIF
2593: 
2594:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 2624 a 2657:
2624:                 loc_oBusca.Show()
2625: 
2626:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClc")
2627:                     SELECT cursor_4c_BuscaClc
2628:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaClc.Codigos)
2629:                 ENDIF
2630: 
2631:                 loc_oBusca.Release()
2632:             ENDIF
2633:         CATCH TO loc_oErro
2634:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2635:         ENDTRY
2636: 
2637:         IF USED("cursor_4c_BuscaClc")
2638:             USE IN cursor_4c_BuscaClc
2639:         ENDIF
2640: 
2641:         IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2642:             SELECT cursor_4c_Dados
2643:             LOCATE FOR ALLTRIM(cursor_4c_Dados.Codigos) == loc_cCodigo
2644:             IF FOUND()
2645:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2646:             ENDIF
2647:         ENDIF
2648:     ENDPROC
2649: 
2650:     *--------------------------------------------------------------------------
2651:     * GridListaDblClick - DblClick no grid abre modo Visualizar
2652:     *--------------------------------------------------------------------------
2653:     PROCEDURE GridListaDblClick()
2654:         THIS.BtnVisualizarClick()
2655:     ENDPROC
2656: 
2657:     *--------------------------------------------------------------------------


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
                    IF VARTYPE(EmpContas) = "L"
                        THIS.this_lEmpContas = EmpContas
                    ELSE
                        IF VARTYPE(EmpContas) = "L"
                            THIS.this_lEmpContas = EmpContas
                        ELSE
                            IF VARTYPE(EmpContas) = "L"
                                THIS.this_lEmpContas = EmpContas
                            ELSE
                                THIS.this_lEmpContas = (NVL(EmpContas, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
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
                    IF VARTYPE(Autos) = "L"
                        THIS.this_lAutos = Autos
                    ELSE
                        IF VARTYPE(Autos) = "L"
                            THIS.this_lAutos = Autos
                        ELSE
                            IF VARTYPE(Autos) = "L"
                                THIS.this_lAutos = Autos
                            ELSE
                                THIS.this_lAutos = (NVL(Autos, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
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
                    IF VARTYPE(EtiquetaA) = "L"
                        THIS.this_lEtiquetaA = EtiquetaA
                    ELSE
                        IF VARTYPE(EtiquetaA) = "L"
                            THIS.this_lEtiquetaA = EtiquetaA
                        ELSE
                            IF VARTYPE(EtiquetaA) = "L"
                                THIS.this_lEtiquetaA = EtiquetaA
                            ELSE
                                THIS.this_lEtiquetaA = (NVL(EtiquetaA, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmA) = "L"
                THIS.this_lPalmA = PalmA
            ELSE
                IF VARTYPE(PalmA) = "L"
                    THIS.this_lPalmA = PalmA
                ELSE
                    IF VARTYPE(PalmA) = "L"
                        THIS.this_lPalmA = PalmA
                    ELSE
                        IF VARTYPE(PalmA) = "L"
                            THIS.this_lPalmA = PalmA
                        ELSE
                            IF VARTYPE(PalmA) = "L"
                                THIS.this_lPalmA = PalmA
                            ELSE
                                THIS.this_lPalmA = (NVL(PalmA, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
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
                    IF VARTYPE(EtiquetaB) = "L"
                        THIS.this_lEtiquetaB = EtiquetaB
                    ELSE
                        IF VARTYPE(EtiquetaB) = "L"
                            THIS.this_lEtiquetaB = EtiquetaB
                        ELSE
                            IF VARTYPE(EtiquetaB) = "L"
                                THIS.this_lEtiquetaB = EtiquetaB
                            ELSE
                                THIS.this_lEtiquetaB = (NVL(EtiquetaB, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmB) = "L"
                THIS.this_lPalmB = PalmB
            ELSE
                IF VARTYPE(PalmB) = "L"
                    THIS.this_lPalmB = PalmB
                ELSE
                    IF VARTYPE(PalmB) = "L"
                        THIS.this_lPalmB = PalmB
                    ELSE
                        IF VARTYPE(PalmB) = "L"
                            THIS.this_lPalmB = PalmB
                        ELSE
                            IF VARTYPE(PalmB) = "L"
                                THIS.this_lPalmB = PalmB
                            ELSE
                                THIS.this_lPalmB = (NVL(PalmB, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
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

