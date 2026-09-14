# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PLEXCLUIR, LNCNT, CODIGOS, EMPS, PROGS, ARQS, TIPOS, ORDENS, DEVOLVIDOS, UMOVS, GRUPOS, CONTAS, CIDCHAVES, LCBANCO, LNTECLA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERACAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PLEXCLUIR, LNCNT, CODIGOS, EMPS, PROGS, ARQS, TIPOS, ORDENS, DEVOLVIDOS, UMOVS, GRUPOS, CONTAS, CIDCHAVES, LCBANCO, LNTECLA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PLEXCLUIR, LNCNT, CODIGOS, EMPS, PROGS, ARQS, TIPOS, ORDENS, DEVOLVIDOS, UMOVS, GRUPOS, CONTAS, CIDCHAVES, LCBANCO, LNTECLA

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
  ControlSource = "crSigCdBch.Codigos"
  ControlSource = "crSigCdBch.Operacaos"
  ControlSource = "crSigCdBch.Tipos"
  ControlSource = "crSigCdBch.DataInis"
  ControlSource = "crSigCdBch.DataFims"
  ControlSource = "crSigCdBch.Grupos"
  ControlSource = "crSigCdBch.Contas"
  ControlSource = "crSigCdBCh.Codigos"
  ControlSource = "crSigCdBCh.Tipos"
  ControlSource = "crSigCdBCh.Contas"
  ControlSource = "crSigCdBCh.DataFims"
  ControlSource = "crSigCdBCh.DataInis"
  ControlSource = "crSigCdBCh.Grupos"
  ControlSource = "crSigCdBCh.Operacaos"
  DeleteMark = .F.
  ControlSource = "TEMPCHQ.BANCOS"
  ControlSource = "TEMPCHQ.AGENCIAS"
  ControlSource = "TEMPCHQ.NCONTAS"
  ControlSource = "TEMPCHQ.NCHEQUES"
  ControlSource = "TEMPCHQ.VALORS"
	Select CrSigCdGrl
Select (pcCursor)
	loBarraGrv.Update(.T.,'SigCdBch...')
			Select CrSigCdGrl
			If !Seek(pcArqs + pcForms + Str(pcCodigos,6),'CrSigCdGrl','Arqs')
				Insert Into CrSigCdGrl From MemVar
			Select (pcCursor)
					Insert Into (lcCursor) From MemVar
					Select (pcCursor)
				If !ThisForm.poDataMg2.Update(lcCursor)
					MessageBox('Favor reinicializar o processo!!!',16,'Falha na Conexão (Update - ' + lcCursor + ')')
					Select (lcCursor)
					Select CrSigCdGrl
					If !ThisForm.poDataMg2.Update('CrSigCdGrl')
						MessageBox('Favor reinicializar o processo!!!',16,'Falha na Conexão (Update - CrSigCdGrl')
				Select (pcCursor)
	Set Deleted Off
	Select (pcCursor)
		loBarraExc.Update(.T.)
		If Deleted()
			Insert Into (lcCursor) From MemVar
		Select (pcCursor)
	Set Deleted On
	Select (lcCursor)
	Delete From (lcCursor)
	If !ThisForm.poDataMg2.Update(lcCursor)
		MessageBox('Favor reinicializar o processo!!!',16,'Falha na Conexão (Delete - ' + lcCursor + ')')
	Select Historico
	If Seek(lcTipo + lcCheque)
		Select Balanco
		=Seek(lcCheque)
lcQryBal = [Select * From SigCqBal Where Codigos = ?lnCodigos ]
lcQryHis = [Select * From SigCqHis Where Codigos = ?lnCodigos ]
	lcQGrLog  = [Select * From SigCdGrl ]+;
	.Column2.ControlSource = [Nvl(CrSigCdBch.DataInis,'')]
	.Column3.ControlSource = [Nvl(CrSigCdBch.DataFims,'')]
	.Column4.ControlSource = ;
Select * From crSigSyCom Where Tipos = 'Leitora cheques' Into Cursor CrCfCom
Select CrSigCdBch
	.Column2.ControlSource = [Nvl(CrSigCdBch.DataInis,'')]
	.Column3.ControlSource = [Nvl(CrSigCdBch.DataFims,'')]
	.Column4.ControlSource = ;
	.Column1.ControlSource = 'Historico.Bancos'
	.Column2.ControlSource = 'Historico.Agencias'
	.Column3.ControlSource = 'Historico.NContas'
	.Column4.ControlSource = 'Historico.NCheques'
	.Column5.ControlSource = [Nvl(Historico.Vencs,'')]
	.Column6.ControlSource = 'Historico.Valors'
Select Balanco
Delete From Balanco
Select Historico
Delete From Historico
llOk = ThisForm.poDataMg2.Update('Balanco')
	llOk = ThisForm.poDataMg2.Update('Historico')
	MessageBox('Favor reinicializar o processo !!!',16,'Falha na Conexão (Update - Excluir)')
lStrQuery = [Select a.Bancos,a.Agencias,a.NContas,a.NCheques,a.Nums,a.UMovs,a.Valors,a.Vencs,a.GrClis,a.IClis,]+;
			[From SigChe a, SigCdOpt b ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsBalanco') < 1
Select CsBalanco
	loBarra.Update(.T.)
	Insert Into Balanco From MemVar
llOk = ThisForm.poDataMgr.Update('CrSigCdBch')
	MessageBox('Favor reinicializar o processo !!!',16,'Falha na Conexão (Update SigCqBal)')
		Select CrSigCdBch
Select CrSigCdBch
Select CrSigCdBch
Select Balanco
Select Historico
Select Historico
		.Column1.ControlSource = 'Historico.Bancos'
		.Column2.ControlSource = 'Historico.Agencias'
		.Column3.ControlSource = 'Historico.NContas'
		.Column4.ControlSource = 'Historico.NCheques'
		.Column5.ControlSource = [Nvl(Historico.Vencs,'')]
		.Column6.ControlSource = 'Historico.Valors'
Select CrSigCdBch
	Select CrSigCdBch
	ThisForm.poDataMgr.Update('CrSigCdBch')
Select Historico
Select Historico
	loBarraHis.Update(.T.)
	If Seek(Historico.Bancos + Historico.Agencias + Historico.NContas + Historico.NCheques,'Balanco','Cheque')
			lcUpdate = [Update SigCqBal Set Lidos = 1 Where CIdChaves = ']+Balanco.CIdChaves+[' ]
			lcUpdate = [Update SigCqBal Set Relidos = 1 Where CIdChaves = ']+Balanco.CIdChaves+[' ]
		If ThisForm.poDataMgr.SqlExecute(lcUpdate,'') < 1
			MessageBox('Favor reinicializar o processo !!!',16,'Falha na Conexão (Update SigCqBal)')
Select Historico
	Select Historico
	Delete
	=Seek(lcBuscaChq,'Balanco','Cheque')
	Select Balanco
	Select Historico
			Insert Into Historico From MemVar
		Select Historico

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS SQL (2932 linhas total):

*-- Linhas 387 a 405:
387:             .HighlightBackColor = RGB(255, 255, 255)
388:             .HighlightForeColor = RGB(15, 41, 104)
389:             .HighlightStyle     = 2
390:             .DeleteMark         = .F.
391:             .RecordMark         = .F.
392:             .RowHeight          = 16
393:             .ScrollBars         = 2
394:             .GridLines          = 3
395:             .Visible            = .T.
396:         ENDWITH
397: 
398:         WITH loc_oGrid.Column1
399:             .Width = 60
400:             .Header1.Caption = "C" + CHR(243) + "digo"
401:         ENDWITH
402:         WITH loc_oGrid.Column2
403:             .Width = 90
404:             .Header1.Caption = "In" + CHR(237) + "cio"
405:         ENDWITH

*-- Linhas 1275 a 1311:
1275:             .Height        = 192
1276:             .ReadOnly      = .T.
1277:             .RecordMark    = .F.
1278:             .DeleteMark    = .F.
1279:             .GridLines     = 2
1280:             .GridLineWidth = 1
1281:             .GridLineColor = RGB(192, 192, 192)
1282:             .HeaderHeight  = 20
1283:             .RowHeight     = 20
1284:             .ScrollBars    = 3
1285:             .Visible       = .T.
1286:         ENDWITH
1287:         loc_oGrid.ColumnCount  = 6
1288:         loc_oGrid.RecordSource = "cursor_4c_Historico"
1289: 
1290:         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1291:         loc_oGrid.Column1.ControlSource = "cursor_4c_Historico.bancos"
1292:         loc_oGrid.Column2.ControlSource = "cursor_4c_Historico.agencias"
1293:         loc_oGrid.Column3.ControlSource = "cursor_4c_Historico.ncontas"
1294:         loc_oGrid.Column4.ControlSource = "cursor_4c_Historico.ncheques"
1295:         loc_oGrid.Column5.ControlSource = "cursor_4c_Historico.vencs"
1296:         loc_oGrid.Column6.ControlSource = "cursor_4c_Historico.valors"
1297: 
1298:         WITH loc_oGrid.Column1
1299:             .Width         = 55
1300:             .ReadOnly      = .T.
1301:             .Resizable     = .T.
1302:         ENDWITH
1303:         loc_oGrid.Column1.Header1.Caption = "Banco"
1304: 
1305:         WITH loc_oGrid.Column2
1306:             .Width         = 55
1307:             .ReadOnly      = .T.
1308:             .Resizable     = .T.
1309:         ENDWITH
1310:         loc_oGrid.Column2.Header1.Caption = "Ag" + CHR(234) + "ncia"
1311: 

*-- Linhas 1424 a 1478:
1424:             .HighlightBackColor = RGB(255, 255, 255)
1425:             .HighlightForeColor = RGB(15, 41, 104)
1426:             .HighlightStyle     = 2
1427:             .DeleteMark         = .F.
1428:             .RecordMark         = .F.
1429:             .RowHeight          = 16
1430:             .ScrollBars         = 2
1431:             .GridLines          = 3
1432:             .ReadOnly           = .T.
1433:             .Visible            = .T.
1434:         ENDWITH
1435: 
1436:         WITH loc_oGrid.Column1
1437:             .Width           = 80
1438:             .ControlSource   = "cursor_4c_Historico.bancos"
1439:             .Header1.Caption = "Banco"
1440:         ENDWITH
1441:         WITH loc_oGrid.Column2
1442:             .Width           = 80
1443:             .ControlSource   = "cursor_4c_Historico.agencias"
1444:             .Header1.Caption = "Ag" + CHR(234) + "ncia"
1445:         ENDWITH
1446:         WITH loc_oGrid.Column3
1447:             .Width           = 90
1448:             .ControlSource   = "cursor_4c_Historico.ncontas"
1449:             .Header1.Caption = "N" + CHR(186) + " Conta"
1450:         ENDWITH
1451:         WITH loc_oGrid.Column4
1452:             .Width           = 90
1453:             .ControlSource   = "cursor_4c_Historico.ncheques"
1454:             .Header1.Caption = "N" + CHR(186) + " Cheque"
1455:         ENDWITH
1456:         WITH loc_oGrid.Column5
1457:             .Width           = 80
1458:             .ControlSource   = "cursor_4c_Historico.vencs"
1459:             .Header1.Caption = "Vencimento"
1460:         ENDWITH
1461:         WITH loc_oGrid.Column6
1462:             .Width           = 80
1463:             .ControlSource   = "cursor_4c_Historico.valors"
1464:             .Header1.Caption = "Valor"
1465:         ENDWITH
1466: 
1467:         THIS.TornarControlesVisiveis(loc_oPg3)
1468:     ENDPROC
1469: 
1470:     *--------------------------------------------------------------------------
1471:     * CarregarLista - Carrega registros de SigCdBch no grid da Page1
1472:     *--------------------------------------------------------------------------
1473:     PROCEDURE CarregarLista()
1474:         LOCAL loc_lResultado, loc_oGrid
1475:         loc_lResultado = .F.
1476: 
1477:         TRY
1478:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI

*-- Linhas 1487 a 1514:
1487:                         loc_oGrid.ColumnCount = 6
1488:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1489: 
1490:                         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1491:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1492:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
1493:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
1494:                         loc_oGrid.Column4.ControlSource = ;
1495:                             "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
1496:                             "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
1497:                             "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
1498:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1499:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1500: 
1501:                         *-- Reconfigurar headers (RecordSource reseta captions)
1502:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1503:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1504:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1505:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1506:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1507:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1508: 
1509:                         THIS.FormatarGridLista(loc_oGrid)
1510:                     ENDIF
1511:                     loc_lResultado = .T.
1512:                 ENDIF
1513:             ENDIF
1514:         CATCH TO loc_oErro

*-- Linhas 1581 a 1622:
1581:             RETURN
1582:         ENDIF
1583: 
1584:         SELECT cursor_4c_Dados
1585:         loc_nCodigo = cursor_4c_Dados.codigos
1586: 
1587:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1588:             THIS.this_cModoAtual = "VISUALIZAR"
1589:             THIS.BOParaForm()
1590:             THIS.HabilitarCampos(.F.)
1591:             THIS.AjustarBotoesPorModo()
1592:             THIS.AlternarPagina(2)
1593:         ENDIF
1594:     ENDPROC
1595: 
1596:     *--------------------------------------------------------------------------
1597:     * BtnAlterarClick - Edita balanco selecionado
1598:     *--------------------------------------------------------------------------
1599:     PROCEDURE BtnAlterarClick()
1600:         LOCAL loc_nCodigo
1601: 
1602:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1603:             MsgAviso("Selecione um registro na lista.", "")
1604:             RETURN
1605:         ENDIF
1606: 
1607:         SELECT cursor_4c_Dados
1608: 
1609:         IF cursor_4c_Dados.encerras
1610:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1611:                      "vel alterar balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1612:             RETURN
1613:         ENDIF
1614: 
1615:         loc_nCodigo = cursor_4c_Dados.codigos
1616: 
1617:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1618:             THIS.this_oBusinessObject.EditarRegistro()
1619:             THIS.this_cModoAtual = "ALTERAR"
1620:             THIS.BOParaForm()
1621:             THIS.HabilitarCampos(.T.)
1622:             THIS.AjustarBotoesPorModo()

*-- Linhas 1635 a 1653:
1635:             RETURN
1636:         ENDIF
1637: 
1638:         SELECT cursor_4c_Dados
1639: 
1640:         IF cursor_4c_Dados.encerras
1641:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1642:                      "vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1643:             RETURN
1644:         ENDIF
1645: 
1646:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1647:                         "Confirmar")
1648:             RETURN
1649:         ENDIF
1650: 
1651:         loc_nCodigo = cursor_4c_Dados.codigos
1652: 
1653:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)

*-- Linhas 1678 a 1700:
1678:                 loc_oBusca.Show()
1679: 
1680:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
1681:                     SELECT cursor_4c_BuscaBch
1682:                     IF !EOF("cursor_4c_BuscaBch")
1683:                         loc_nCodigo = cursor_4c_BuscaBch.codigos
1684:                         THIS.this_oBusinessObject.Buscar( ;
1685:                             "codigos = " + FormatarNumeroSQL(loc_nCodigo))
1686:                         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1687:                             THIS.CarregarLista()
1688:                         ENDIF
1689:                     ENDIF
1690:                 ELSE
1691:                     THIS.CarregarLista()
1692:                 ENDIF
1693: 
1694:                 loc_oBusca.Release()
1695:             ENDIF
1696:         CATCH TO loc_oErro
1697:             MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
1698:         ENDTRY
1699: 
1700:         IF USED("cursor_4c_BuscaBch")

*-- Linhas 1753 a 1771:
1753:             RETURN
1754:         ENDIF
1755: 
1756:         SELECT cursor_4c_Dados
1757: 
1758:         IF cursor_4c_Dados.encerras
1759:             MsgAviso("Invent" + CHR(225) + "rio J" + CHR(225) + " Encerrado !!!", "")
1760:             RETURN
1761:         ENDIF
1762: 
1763:         loc_nCodigo = cursor_4c_Dados.codigos
1764: 
1765:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1766:             THIS.this_cModoAtual = "LEITURA"
1767:             THIS.AlternarPagina(3)
1768:         ENDIF
1769:     ENDPROC
1770: 
1771:     *--------------------------------------------------------------------------

*-- Linhas 1779 a 1797:
1779:             RETURN
1780:         ENDIF
1781: 
1782:         SELECT cursor_4c_Dados
1783: 
1784:         IF cursor_4c_Dados.encerras
1785:             MsgAviso("Balan" + CHR(231) + "o J" + CHR(225) + " Encerrado !!!", "")
1786:             RETURN
1787:         ENDIF
1788: 
1789:         IF !MsgConfirma("Este Balan" + CHR(231) + "o ser" + CHR(225) + " finalizado, n" + ;
1790:                         CHR(227) + "o podendo ser efetuada mais nenhuma leitura..." + CHR(13) + ;
1791:                         "Deseja encerrar o Balan" + CHR(231) + "o ???", ;
1792:                         "ATEN" + CHR(199) + CHR(195) + "O")
1793:             RETURN
1794:         ENDIF
1795: 
1796:         loc_nCodigo = cursor_4c_Dados.codigos
1797: 

*-- Linhas 1824 a 1883:
1824:             loc_lContinuar = .T.
1825: 
1826:             *-- Carrega SigCqBal para obter cidchaves (padrao original: cursor local)
1827:             SQLEXEC(gnConnHandle, ;
1828:                 "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
1829:                 " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
1830:                 "cursor_4c_BalCid")
1831: 
1832:             SELECT cursor_4c_Historico
1833:             GO TOP
1834: 
1835:             DO WHILE !EOF("cursor_4c_Historico") AND loc_lContinuar
1836:                 loc_cBcoH = ALLTRIM(cursor_4c_Historico.bancos)
1837:                 loc_cAgeH = ALLTRIM(cursor_4c_Historico.agencias)
1838:                 loc_cCntH = ALLTRIM(cursor_4c_Historico.ncontas)
1839:                 loc_cChqH = ALLTRIM(cursor_4c_Historico.ncheques)
1840:                 loc_nTipH = cursor_4c_Historico.tipos
1841: 
1842:                 loc_cCidChaveBal = ""
1843:                 IF USED("cursor_4c_BalCid")
1844:                     SELECT cursor_4c_BalCid
1845:                     LOCATE FOR ALLTRIM(bancos) = loc_cBcoH AND ALLTRIM(agencias) = loc_cAgeH ;
1846:                         AND ALLTRIM(ncontas) = loc_cCntH AND ALLTRIM(ncheques) = loc_cChqH
1847:                     IF FOUND()
1848:                         loc_cCidChaveBal = ALLTRIM(cidchaves)
1849:                     ENDIF
1850:                 ENDIF
1851: 
1852:                 IF !EMPTY(loc_cCidChaveBal)
1853:                     IF loc_nTipH = 2
1854:                         loc_cSQL = "UPDATE SigCqBal SET ReLidos = 1" + ;
1855:                                    " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
1856:                     ELSE
1857:                         loc_cSQL = "UPDATE SigCqBal SET Lidos = 1" + ;
1858:                                    " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
1859:                     ENDIF
1860: 
1861:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1862:                     IF loc_nResult < 0
1863:                         MsgErro("Erro ao atualizar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
1864:                         loc_lContinuar = .F.
1865:                     ENDIF
1866:                 ENDIF
1867: 
1868:                 SELECT cursor_4c_Historico
1869:                 IF loc_lContinuar
1870:                     SKIP
1871:                 ENDIF
1872:             ENDDO
1873: 
1874:             IF USED("cursor_4c_BalCid")
1875:                 USE IN cursor_4c_BalCid
1876:             ENDIF
1877: 
1878:             IF loc_lContinuar AND THIS.this_oBusinessObject.MarcarGravado()
1879:                 MsgInfo("Leitura gravada com sucesso!", "")
1880:                 THIS.this_cModoAtual = "LISTA"
1881:                 THIS.AlternarPagina(1)
1882:             ENDIF
1883:         CATCH TO loc_oErro

*-- Linhas 1903 a 1961:
1903:         ENDIF
1904: 
1905:         TRY
1906:             SELECT cursor_4c_Historico
1907:             loc_nCodigos     = cursor_4c_Historico.codigos
1908:             loc_cCidChaveHis = ALLTRIM(cursor_4c_Historico.cidchaves)
1909:             loc_cBancos      = ALLTRIM(cursor_4c_Historico.bancos)
1910:             loc_cAgencias    = ALLTRIM(cursor_4c_Historico.agencias)
1911:             loc_cNContas     = ALLTRIM(cursor_4c_Historico.ncontas)
1912:             loc_cNCheques    = ALLTRIM(cursor_4c_Historico.ncheques)
1913:             loc_nTipos       = cursor_4c_Historico.tipos
1914: 
1915:             loc_cSQL = "DELETE FROM SigCqHis WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveHis)
1916: 
1917:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1918:             IF loc_nResult < 0
1919:                 MsgErro("Erro ao excluir hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
1920:             ELSE
1921:                 *-- Localiza cidchaves em SigCqBal para resetar flag (padrao original: cursor local)
1922:                 loc_cCidChaveBal = ""
1923:                 SQLEXEC(gnConnHandle, ;
1924:                     "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
1925:                     " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
1926:                     "cursor_4c_BalCid")
1927:                 IF USED("cursor_4c_BalCid")
1928:                     SELECT cursor_4c_BalCid
1929:                     LOCATE FOR ALLTRIM(bancos) = loc_cBancos AND ALLTRIM(agencias) = loc_cAgencias ;
1930:                         AND ALLTRIM(ncontas) = loc_cNContas AND ALLTRIM(ncheques) = loc_cNCheques
1931:                     IF FOUND()
1932:                         loc_cCidChaveBal = ALLTRIM(cidchaves)
1933:                     ENDIF
1934:                     USE IN cursor_4c_BalCid
1935:                 ENDIF
1936: 
1937:                 IF !EMPTY(loc_cCidChaveBal)
1938:                     IF loc_nTipos = 2
1939:                         loc_cSQL = "UPDATE SigCqBal SET ReLidos = 0" + ;
1940:                                    " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
1941:                     ELSE
1942:                         loc_cSQL = "UPDATE SigCqBal SET Lidos = 0" + ;
1943:                                    " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
1944:                     ENDIF
1945: 
1946:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1947:                     IF loc_nResult < 0
1948:                         MsgErro("Erro ao resetar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
1949:                     ENDIF
1950:                 ENDIF
1951: 
1952:                 THIS.CarregarGradeLeitura(loc_nCodigos)
1953:             ENDIF
1954:         CATCH TO loc_oErro
1955:             MsgErro(loc_oErro.Message, "FormBch.BtnExcluirHistoricoClick")
1956:             IF USED("cursor_4c_BalCid")
1957:                 USE IN cursor_4c_BalCid
1958:             ENDIF
1959:         ENDTRY
1960:     ENDPROC
1961: 

*-- Linhas 2146 a 2187:
2146:         TRY
2147:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2148:                 IF !EMPTY(loc_cGrupo)
2149:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2150:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2151:                         "cursor_4c_DescGcr")
2152:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2153:                         SELECT cursor_4c_DescGcr
2154:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2155:                     ELSE
2156:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2157:                     ENDIF
2158:                     IF USED("cursor_4c_DescGcr")
2159:                         USE IN cursor_4c_DescGcr
2160:                     ENDIF
2161:                 ELSE
2162:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2163:                 ENDIF
2164:             ENDIF
2165: 
2166:             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2167:                 IF !EMPTY(loc_cConta)
2168:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2169:                         "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
2170:                         "cursor_4c_DescCli")
2171:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
2172:                         SELECT cursor_4c_DescCli
2173:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DescCli.razaos)
2174:                     ELSE
2175:                         loc_oPg2.txt_4c_DConta.Value = ""
2176:                     ENDIF
2177:                     IF USED("cursor_4c_DescCli")
2178:                         USE IN cursor_4c_DescCli
2179:                     ENDIF
2180:                 ELSE
2181:                     loc_oPg2.txt_4c_DConta.Value = ""
2182:                 ENDIF
2183:             ENDIF
2184:         CATCH TO loc_oErro
2185:             MsgErro(loc_oErro.Message, "FormBch.BOParaForm")
2186:             IF USED("cursor_4c_DescGcr")
2187:                 USE IN cursor_4c_DescGcr

*-- Linhas 2211 a 2244:
2211:         ENDIF
2212: 
2213:         TRY
2214:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2215:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cCodigo), ;
2216:                 "cursor_4c_ChkOpt")
2217: 
2218:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkOpt") = 0
2219:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2220:                     "SigCdOpt", "cursor_4c_BuscaOpt", "operacaos", loc_cCodigo, ;
2221:                     "Opera" + CHR(231) + CHR(227) + "o")
2222: 
2223:                 IF VARTYPE(loc_oBusca) = "O"
2224:                     loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
2225:                     loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2226:                     loc_oBusca.Show()
2227: 
2228:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2229:                         SELECT cursor_4c_BuscaOpt
2230:                         loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
2231:                             ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
2232:                     ELSE
2233:                         loc_oPg2.txt_4c_Oper.Value = ""
2234:                     ENDIF
2235: 
2236:                     loc_oBusca.Release()
2237:                 ENDIF
2238:             ENDIF
2239: 
2240:             IF USED("cursor_4c_ChkOpt")
2241:                 USE IN cursor_4c_ChkOpt
2242:             ENDIF
2243:             IF USED("cursor_4c_BuscaOpt")
2244:                 USE IN cursor_4c_BuscaOpt

*-- Linhas 2278 a 2318:
2278:         ENDIF
2279: 
2280:         TRY
2281:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2282:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
2283:                 "cursor_4c_ChkGcr")
2284: 
2285:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
2286:                 SELECT cursor_4c_ChkGcr
2287:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2288:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
2289:                 ENDIF
2290:             ELSE
2291:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2292:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2293:                 ENDIF
2294:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2295:                     "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
2296: 
2297:                 IF VARTYPE(loc_oBusca) = "O"
2298:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2299:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2300:                     loc_oBusca.Show()
2301: 
2302:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2303:                         SELECT cursor_4c_BuscaGcr
2304:                         IF !EOF("cursor_4c_BuscaGcr")
2305:                             loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2306:                             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2307:                                 loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2308:                             ENDIF
2309:                         ELSE
2310:                             loc_oPg2.txt_4c_Grupo.Value = ""
2311:                         ENDIF
2312:                     ELSE
2313:                         loc_oPg2.txt_4c_Grupo.Value = ""
2314:                     ENDIF
2315: 
2316:                     loc_oBusca.Release()
2317:                 ENDIF
2318:             ENDIF

*-- Linhas 2368 a 2386:
2368:                 loc_oBusca.Show()
2369: 
2370:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2371:                     SELECT cursor_4c_BuscaGcr
2372:                     IF !EOF("cursor_4c_BuscaGcr")
2373:                         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2374:                             loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2375:                         ENDIF
2376:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2377:                     ELSE
2378:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2379:                     ENDIF
2380:                 ELSE
2381:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2382:                 ENDIF
2383: 
2384:                 loc_oBusca.Release()
2385:             ENDIF
2386: 

*-- Linhas 2419 a 2459:
2419:         ENDIF
2420: 
2421:         TRY
2422:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2423:                 "SELECT iclis, razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cCodigo), ;
2424:                 "cursor_4c_ChkCli")
2425: 
2426:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
2427:                 SELECT cursor_4c_ChkCli
2428:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2429:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ChkCli.razaos)
2430:                 ENDIF
2431:             ELSE
2432:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2433:                     loc_oPg2.txt_4c_DConta.Value = ""
2434:                 ENDIF
2435:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2436:                     "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")
2437: 
2438:                 IF VARTYPE(loc_oBusca) = "O"
2439:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2440:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
2441:                     loc_oBusca.Show()
2442: 
2443:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2444:                         SELECT cursor_4c_BuscaCli
2445:                         IF !EOF("cursor_4c_BuscaCli")
2446:                             loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
2447:                             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2448:                                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2449:                             ENDIF
2450:                         ELSE
2451:                             loc_oPg2.txt_4c_Conta.Value = ""
2452:                         ENDIF
2453:                     ELSE
2454:                         loc_oPg2.txt_4c_Conta.Value = ""
2455:                     ENDIF
2456: 
2457:                     loc_oBusca.Release()
2458:                 ENDIF
2459:             ENDIF

*-- Linhas 2509 a 2527:
2509:                 loc_oBusca.Show()
2510: 
2511:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2512:                     SELECT cursor_4c_BuscaCli
2513:                     IF !EOF("cursor_4c_BuscaCli")
2514:                         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2515:                             loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2516:                         ENDIF
2517:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2518:                     ELSE
2519:                         loc_oPg2.txt_4c_DConta.Value = ""
2520:                     ENDIF
2521:                 ELSE
2522:                     loc_oPg2.txt_4c_DConta.Value = ""
2523:                 ENDIF
2524: 
2525:                 loc_oBusca.Release()
2526:             ENDIF
2527: 

*-- Linhas 2622 a 2674:
2622: 
2623:         TRY
2624:             IF !EMPTY(loc_cGrupo) AND VARTYPE(loc_oPg3.txt_4c_DGrupoDisp) = "O"
2625:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2626:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2627:                     "cursor_4c_DescGcr")
2628:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2629:                     SELECT cursor_4c_DescGcr
2630:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2631:                 ELSE
2632:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ""
2633:                 ENDIF
2634:                 IF USED("cursor_4c_DescGcr")
2635:                     USE IN cursor_4c_DescGcr
2636:                 ENDIF
2637:             ENDIF
2638: 
2639:             IF !EMPTY(loc_cConta) AND VARTYPE(loc_oPg3.txt_4c_DContaDisp) = "O"
2640:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2641:                     "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
2642:                     "cursor_4c_DescCli")
2643:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
2644:                     SELECT cursor_4c_DescCli
2645:                     loc_oPg3.txt_4c_DContaDisp.Value = ALLTRIM(cursor_4c_DescCli.razaos)
2646:                 ELSE
2647:                     loc_oPg3.txt_4c_DContaDisp.Value = ""
2648:                 ENDIF
2649:                 IF USED("cursor_4c_DescCli")
2650:                     USE IN cursor_4c_DescCli
2651:                 ENDIF
2652:             ENDIF
2653: 
2654:             IF !EMPTY(loc_cOperacaos) AND VARTYPE(loc_oPg3.txt_4c_OperAbDisp) = "O"
2655:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2656:                     "SELECT descrs FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cOperacaos), ;
2657:                     "cursor_4c_DescOpt")
2658:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescOpt") > 0
2659:                     SELECT cursor_4c_DescOpt
2660:                     loc_oPg3.txt_4c_OperAbDisp.Value = ALLTRIM(cursor_4c_DescOpt.descrs)
2661:                 ELSE
2662:                     loc_oPg3.txt_4c_OperAbDisp.Value = ""
2663:                 ENDIF
2664:                 IF USED("cursor_4c_DescOpt")
2665:                     USE IN cursor_4c_DescOpt
2666:                 ENDIF
2667:             ENDIF
2668:         CATCH TO loc_oErro
2669:             MsgErro(loc_oErro.Message, "FormBch.PopularCamposLeitura")
2670:             IF USED("cursor_4c_DescGcr")
2671:                 USE IN cursor_4c_DescGcr
2672:             ENDIF
2673:             IF USED("cursor_4c_DescCli")
2674:                 USE IN cursor_4c_DescCli

*-- Linhas 2681 a 2725:
2681: 
2682:     *--------------------------------------------------------------------------
2683:     * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
2684:     * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
2685:     *--------------------------------------------------------------------------
2686:     PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
2687:         LOCAL loc_cSQL, loc_nResultado
2688: 
2689:         TRY
2690:             IF !USED("cursor_4c_Historico")
2691:                 SET NULL ON
2692:                 CREATE CURSOR cursor_4c_Historico ;
2693:                     (cidchaves C(20), codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
2694:                      ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
2695:                      valors N(14,2), vencs D)
2696:                 SET NULL OFF
2697:             ENDIF
2698: 
2699:             loc_cSQL = "SELECT cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
2700:                        " usuarios, valors, vencs" + ;
2701:                        " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
2702:                        " ORDER BY datas, ncheques"
2703: 
2704:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
2705: 
2706:             IF loc_nResultado >= 0
2707:                 SELECT cursor_4c_Historico
2708:                 ZAP
2709:                 IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
2710:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
2711:                 ENDIF
2712:                 IF USED("cursor_4c_HistoricoTemp")
2713:                     USE IN cursor_4c_HistoricoTemp
2714:                 ENDIF
2715:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
2716:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.ColumnCount = 3
2717:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.RecordSource = "cursor_4c_Historico"
2718:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.Refresh()
2719:                 ENDIF
2720:             ELSE
2721:                 MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2722:             ENDIF
2723:         CATCH TO loc_oErro
2724:             MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
2725:             IF USED("cursor_4c_HistoricoTemp")

*-- Linhas 2790 a 2874:
2790:             ENDIF
2791: 
2792:             *-- Carrega SigCqBal para verificar cheque (padrao original: cursor local)
2793:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2794:                 "SELECT cidchaves, bancos, agencias, ncontas, ncheques, valors, vencs" + ;
2795:                 " FROM SigCqBal WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
2796:                 "cursor_4c_BalDisp")
2797: 
2798:             *-- Verificar se cheque existe no balanco (LOCATE em cursor local)
2799:             IF loc_nResultado >= 0 AND USED("cursor_4c_BalDisp")
2800:                 SELECT cursor_4c_BalDisp
2801:                 LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
2802:                     AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
2803:                 IF FOUND()
2804:                     loc_nValor = TratarNulo(valors, "N")
2805:                     loc_dVecto = TratarNulo(vencs,  "D")
2806:                 ELSE
2807:                     MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2808:                     loc_lContinuar = .F.
2809:                 ENDIF
2810:                 USE IN cursor_4c_BalDisp
2811:             ELSE
2812:                 MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2813:                 loc_lContinuar = .F.
2814:             ENDIF
2815: 
2816:             IF loc_lContinuar
2817:                 *-- Verificar duplicidade no historico (LOCATE em cursor local)
2818:                 IF USED("cursor_4c_Historico")
2819:                     SELECT cursor_4c_Historico
2820:                     LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
2821:                         AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
2822:                     IF FOUND()
2823:                         MsgAviso("Cheque j" + CHR(225) + " consta no hist" + CHR(243) + "rico!", "")
2824:                         loc_lContinuar = .F.
2825:                     ENDIF
2826:                 ENDIF
2827:             ENDIF
2828: 
2829:             IF loc_lContinuar
2830:                 *-- Gerar cidchaves para SigCqHis
2831:                 loc_cCidChaveHis = ""
2832:                 loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", ;
2833:                     "cursor_4c_Uuid")
2834:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
2835:                     SELECT cursor_4c_Uuid
2836:                     loc_cCidChaveHis = ALLTRIM(cursor_4c_Uuid.novo_uuid)
2837:                 ENDIF
2838:                 IF USED("cursor_4c_Uuid")
2839:                     USE IN cursor_4c_Uuid
2840:                 ENDIF
2841: 
2842:                 *-- Inserir no historico de leitura
2843:                 loc_cSQL = "INSERT INTO SigCqHis" + ;
2844:                            " (cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas, usuarios, valors, vencs)" + ;
2845:                            " VALUES (" + ;
2846:                            EscaparSQL(loc_cCidChaveHis) + "," + ;
2847:                            FormatarNumeroSQL(loc_nCodigos) + "," + ;
2848:                            EscaparSQL(LEFT(loc_cBco,   10)) + "," + ;
2849:                            EscaparSQL(LEFT(loc_cAge,   10)) + "," + ;
2850:                            EscaparSQL(LEFT(loc_cConta, 10)) + "," + ;
2851:                            EscaparSQL(LEFT(loc_cNum,   10)) + "," + ;
2852:                            FormatarNumeroSQL(loc_nTipos) + "," + ;
2853:                            "GETDATE()," + ;
2854:                            EscaparSQL(LEFT(gc_4c_UsuarioLogado, 15)) + "," + ;
2855:                            FormatarNumeroSQL(loc_nValor) + "," + ;
2856:                            FormatarDataSQL(loc_dVecto) + ;
2857:                            ")"
2858: 
2859:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
2860: 
2861:                 IF loc_nResultado >= 0
2862:                     IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2863:                         loc_oPg3.txt_4c_Valor.Value = loc_nValor
2864:                     ENDIF
2865:                     IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
2866:                         loc_oPg3.txt_4c_Vecto.Value = loc_dVecto
2867:                     ENDIF
2868:                     THIS.CarregarGradeLeitura(loc_nCodigos)
2869:                     THIS.LimparCamposLeitura()
2870:                 ELSE
2871:                     MsgErro("Erro ao inserir no hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2872:                 ENDIF
2873:             ENDIF
2874:         CATCH TO loc_oErro


### BO (C:\4c\projeto\app\classes\BchBO.prg):
*====================================================================
* BchBO.prg
*
* Business Object para Balanco de Cheques
* Tabela: SigCdBch
* PK: Codigos (numeric 6,0)
*
* Colunas (schema.sql):
*   operacaos  char(15)      NOT NULL
*   codigos    numeric(6,0)  NOT NULL  <- PK
*   datafims   datetime      NULL
*   datainis   datetime      NULL
*   encerras   bit           NOT NULL
*   tipos      numeric(1,0)  NOT NULL
*   grupos     char(10)      NOT NULL
*   contas     char(10)      NOT NULL
*   grvs       bit           NOT NULL
*====================================================================

DEFINE CLASS BchBO AS BusinessBase

	*-- Propriedades da tabela SigCdBch
	this_nCodigos  = 0
	this_cOperacaos = ""
	this_dDataInis = {}
	this_dDataFims = {}
	this_lEncerras = .F.
	this_nTipos    = 0
	this_cGrupos   = ""
	this_cContas   = ""
	this_lGrvs     = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdBch"
			THIS.this_cCampoChave = "Codigos"
			loc_lResultado = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Busca registros de SigCdBch
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cWhere = " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch" + loc_cWhere + " ORDER BY codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros de Balan" + CHR(231) + "o de Cheques: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_nCodigos   = TratarNulo(codigos,   "N")
				THIS.this_cOperacaos = TratarNulo(operacaos, "C")
				THIS.this_dDataInis  = TratarNulo(datainis,  "D")
				THIS.this_dDataFims  = TratarNulo(datafims,  "D")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				THIS.this_cGrupos    = TratarNulo(grupos,    "C")
				THIS.this_cContas    = TratarNulo(contas,    "C")
				THIS.this_lEncerras  = ConverterParaLogico(encerras)
				THIS.this_lGrvs      = ConverterParaLogico(grvs)
				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nNovoCodigo
		loc_lResultado = .F.

		TRY
			*-- Gerar novo codigo (PK)
			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT ISNULL(MAX(codigos),0)+1 AS proximo FROM SigCdBch", ;
				"cursor_4c_ProxCod")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nNovoCodigo = proximo
			ELSE
				loc_nNovoCodigo = 1
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF

			THIS.this_nCodigos = loc_nNovoCodigo

			loc_cSQL = "INSERT INTO SigCdBch" + ;
					   " (codigos, operacaos, datainis, datafims, tipos," + ;
					   "  grupos, contas, encerras, grvs)" + ;
					   " VALUES (" + ;
					   FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   IIF(THIS.this_lGrvs, "1", "0") + ;
					   ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET" + ;
					   " operacaos = " + EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   " datainis  = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   " datafims  = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   " tipos     = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   " grupos    = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   " contas    = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   " encerras  = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   " grvs      = " + IIF(THIS.this_lGrvs, "1", "0") + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdBch
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
					"vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			THIS.RegistrarAuditoria("DELETE")

			loc_cSQL = "DELETE FROM SigCdBch WHERE codigos = " + ;
					   FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* EncerrarBalanco - Encerra o balanco de cheques (DataFims + Encerras=.T.)
	*====================================================================
	PROCEDURE EncerrarBalanco()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("Balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "UPDATE SigCdBch SET datafims = GETDATE(), encerras = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lEncerras = .T.
				THIS.this_dDataFims = DATE()
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao encerrar balan" + CHR(231) + "o: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* MarcarGravado - Define Grvs=1 em SigCdBch apos gravar leitura
	*====================================================================
	PROCEDURE MarcarGravado()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET grvs = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lGrvs = .T.
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao marcar gravado: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

