# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'BANCOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PLEXCLUIR, LNCNT, CODIGOS, EMPS, PROGS, ARQS, TIPOS, ORDENS, DEVOLVIDOS, UMOVS, GRUPOS, CONTAS, CIDCHAVES, LCBANCO, LNTECLA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'AGENCIAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PLEXCLUIR, LNCNT, CODIGOS, EMPS, PROGS, ARQS, TIPOS, ORDENS, DEVOLVIDOS, UMOVS, GRUPOS, CONTAS, CIDCHAVES, LCBANCO, LNTECLA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NCONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PLEXCLUIR, LNCNT, CODIGOS, EMPS, PROGS, ARQS, TIPOS, ORDENS, DEVOLVIDOS, UMOVS, GRUPOS, CONTAS, CIDCHAVES, LCBANCO, LNTECLA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NCHEQUES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PLEXCLUIR, LNCNT, CODIGOS, EMPS, PROGS, ARQS, TIPOS, ORDENS, DEVOLVIDOS, UMOVS, GRUPOS, CONTAS, CIDCHAVES, LCBANCO, LNTECLA
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS SQL (2825 linhas total):

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

*-- Linhas 1427 a 1454:
1427:                         loc_oGrid.ColumnCount = 6
1428:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1429: 
1430:                         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1431:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1432:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
1433:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
1434:                         loc_oGrid.Column4.ControlSource = ;
1435:                             "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
1436:                             "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
1437:                             "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
1438:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1439:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1440: 
1441:                         *-- Reconfigurar headers (RecordSource reseta captions)
1442:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1443:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1444:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1445:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1446:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1447:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1448: 
1449:                         THIS.FormatarGridLista(loc_oGrid)
1450:                     ENDIF
1451:                     loc_lResultado = .T.
1452:                 ENDIF
1453:             ENDIF
1454:         CATCH TO loc_oErro

*-- Linhas 1521 a 1562:
1521:             RETURN
1522:         ENDIF
1523: 
1524:         SELECT cursor_4c_Dados
1525:         loc_nCodigo = cursor_4c_Dados.codigos
1526: 
1527:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1528:             THIS.this_cModoAtual = "VISUALIZAR"
1529:             THIS.BOParaForm()
1530:             THIS.HabilitarCampos(.F.)
1531:             THIS.AjustarBotoesPorModo()
1532:             THIS.AlternarPagina(2)
1533:         ENDIF
1534:     ENDPROC
1535: 
1536:     *--------------------------------------------------------------------------
1537:     * BtnAlterarClick - Edita balanco selecionado
1538:     *--------------------------------------------------------------------------
1539:     PROCEDURE BtnAlterarClick()
1540:         LOCAL loc_nCodigo
1541: 
1542:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1543:             MsgAviso("Selecione um registro na lista.", "")
1544:             RETURN
1545:         ENDIF
1546: 
1547:         SELECT cursor_4c_Dados
1548: 
1549:         IF cursor_4c_Dados.encerras
1550:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1551:                      "vel alterar balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1552:             RETURN
1553:         ENDIF
1554: 
1555:         loc_nCodigo = cursor_4c_Dados.codigos
1556: 
1557:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1558:             THIS.this_oBusinessObject.EditarRegistro()
1559:             THIS.this_cModoAtual = "ALTERAR"
1560:             THIS.BOParaForm()
1561:             THIS.HabilitarCampos(.T.)
1562:             THIS.AjustarBotoesPorModo()

*-- Linhas 1575 a 1593:
1575:             RETURN
1576:         ENDIF
1577: 
1578:         SELECT cursor_4c_Dados
1579: 
1580:         IF cursor_4c_Dados.encerras
1581:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1582:                      "vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1583:             RETURN
1584:         ENDIF
1585: 
1586:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1587:                         "Confirmar")
1588:             RETURN
1589:         ENDIF
1590: 
1591:         loc_nCodigo = cursor_4c_Dados.codigos
1592: 
1593:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)

*-- Linhas 1618 a 1640:
1618:                 loc_oBusca.Show()
1619: 
1620:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
1621:                     SELECT cursor_4c_BuscaBch
1622:                     IF !EOF("cursor_4c_BuscaBch")
1623:                         loc_nCodigo = cursor_4c_BuscaBch.codigos
1624:                         THIS.this_oBusinessObject.Buscar( ;
1625:                             "codigos = " + FormatarNumeroSQL(loc_nCodigo))
1626:                         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1627:                             THIS.CarregarLista()
1628:                         ENDIF
1629:                     ENDIF
1630:                 ELSE
1631:                     THIS.CarregarLista()
1632:                 ENDIF
1633: 
1634:                 loc_oBusca.Release()
1635:             ENDIF
1636:         CATCH TO loc_oErro
1637:             MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
1638:         ENDTRY
1639: 
1640:         IF USED("cursor_4c_BuscaBch")

*-- Linhas 1693 a 1711:
1693:             RETURN
1694:         ENDIF
1695: 
1696:         SELECT cursor_4c_Dados
1697: 
1698:         IF cursor_4c_Dados.encerras
1699:             MsgAviso("Invent" + CHR(225) + "rio J" + CHR(225) + " Encerrado !!!", "")
1700:             RETURN
1701:         ENDIF
1702: 
1703:         loc_nCodigo = cursor_4c_Dados.codigos
1704: 
1705:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1706:             THIS.this_cModoAtual = "LEITURA"
1707:             THIS.AlternarPagina(3)
1708:         ENDIF
1709:     ENDPROC
1710: 
1711:     *--------------------------------------------------------------------------

*-- Linhas 1719 a 1737:
1719:             RETURN
1720:         ENDIF
1721: 
1722:         SELECT cursor_4c_Dados
1723: 
1724:         IF cursor_4c_Dados.encerras
1725:             MsgAviso("Balan" + CHR(231) + "o J" + CHR(225) + " Encerrado !!!", "")
1726:             RETURN
1727:         ENDIF
1728: 
1729:         IF !MsgConfirma("Este Balan" + CHR(231) + "o ser" + CHR(225) + " finalizado, n" + ;
1730:                         CHR(227) + "o podendo ser efetuada mais nenhuma leitura..." + CHR(13) + ;
1731:                         "Deseja encerrar o Balan" + CHR(231) + "o ???", ;
1732:                         "ATEN" + CHR(199) + CHR(195) + "O")
1733:             RETURN
1734:         ENDIF
1735: 
1736:         loc_nCodigo = cursor_4c_Dados.codigos
1737: 

*-- Linhas 1762 a 1800:
1762:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
1763:             loc_lContinuar = .T.
1764: 
1765:             SELECT cursor_4c_Historico
1766:             GO TOP
1767: 
1768:             DO WHILE !EOF("cursor_4c_Historico") AND loc_lContinuar
1769:                 IF cursor_4c_Historico.tipos = 2
1770:                     loc_cSQL = "UPDATE SigCqBal SET ReLidos = 1" + ;
1771:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1772:                                " AND Bancos = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.bancos)) + ;
1773:                                " AND Agencias = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.agencias)) + ;
1774:                                " AND NContas = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncontas)) + ;
1775:                                " AND NCheques = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncheques))
1776:                 ELSE
1777:                     loc_cSQL = "UPDATE SigCqBal SET Lidos = 1" + ;
1778:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1779:                                " AND Bancos = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.bancos)) + ;
1780:                                " AND Agencias = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.agencias)) + ;
1781:                                " AND NContas = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncontas)) + ;
1782:                                " AND NCheques = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncheques))
1783:                 ENDIF
1784: 
1785:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1786:                 IF loc_nResult < 0
1787:                     MsgErro("Erro ao atualizar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
1788:                     loc_lContinuar = .F.
1789:                 ELSE
1790:                     SKIP IN cursor_4c_Historico
1791:                 ENDIF
1792:             ENDDO
1793: 
1794:             IF loc_lContinuar AND THIS.this_oBusinessObject.MarcarGravado()
1795:                 MsgInfo("Leitura gravada com sucesso!", "")
1796:                 THIS.this_cModoAtual = "LISTA"
1797:                 THIS.AlternarPagina(1)
1798:             ENDIF
1799:         CATCH TO loc_oErro
1800:             MsgErro(loc_oErro.Message, "FormBch.BtnGravarLeituraClick")

*-- Linhas 1815 a 1868:
1815:         ENDIF
1816: 
1817:         TRY
1818:             SELECT cursor_4c_Historico
1819:             loc_nCodigos  = cursor_4c_Historico.codigos
1820:             loc_cBancos   = ALLTRIM(cursor_4c_Historico.bancos)
1821:             loc_cAgencias = ALLTRIM(cursor_4c_Historico.agencias)
1822:             loc_cNContas  = ALLTRIM(cursor_4c_Historico.ncontas)
1823:             loc_cNCheques = ALLTRIM(cursor_4c_Historico.ncheques)
1824:             loc_nTipos    = cursor_4c_Historico.tipos
1825: 
1826:             loc_cSQL = "DELETE FROM SigCqHis" + ;
1827:                        " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1828:                        " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1829:                        " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1830:                        " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1831:                        " AND NCheques = " + EscaparSQL(loc_cNCheques)
1832: 
1833:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1834:             IF loc_nResult < 0
1835:                 MsgErro("Erro ao excluir hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
1836:             ELSE
1837:                 IF loc_nTipos = 2
1838:                     loc_cSQL = "UPDATE SigCqBal SET ReLidos = 0" + ;
1839:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1840:                                " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1841:                                " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1842:                                " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1843:                                " AND NCheques = " + EscaparSQL(loc_cNCheques)
1844:                 ELSE
1845:                     loc_cSQL = "UPDATE SigCqBal SET Lidos = 0" + ;
1846:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1847:                                " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1848:                                " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1849:                                " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1850:                                " AND NCheques = " + EscaparSQL(loc_cNCheques)
1851:                 ENDIF
1852: 
1853:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1854:                 IF loc_nResult < 0
1855:                     MsgErro("Erro ao resetar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
1856:                 ENDIF
1857: 
1858:                 THIS.CarregarGradeLeitura(loc_nCodigos)
1859:             ENDIF
1860:         CATCH TO loc_oErro
1861:             MsgErro(loc_oErro.Message, "FormBch.BtnExcluirHistoricoClick")
1862:         ENDTRY
1863:     ENDPROC
1864: 
1865:     *--------------------------------------------------------------------------
1866:     * BtnCancelarLeituraClick - Cancela leitura e retorna para lista (Page3)
1867:     *--------------------------------------------------------------------------
1868:     PROCEDURE BtnCancelarLeituraClick()

*-- Linhas 2049 a 2090:
2049:         TRY
2050:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2051:                 IF !EMPTY(loc_cGrupo)
2052:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2053:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2054:                         "cursor_4c_DescGcr")
2055:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2056:                         SELECT cursor_4c_DescGcr
2057:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2058:                     ELSE
2059:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2060:                     ENDIF
2061:                     IF USED("cursor_4c_DescGcr")
2062:                         USE IN cursor_4c_DescGcr
2063:                     ENDIF
2064:                 ELSE
2065:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2066:                 ENDIF
2067:             ENDIF
2068: 
2069:             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2070:                 IF !EMPTY(loc_cConta)
2071:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2072:                         "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
2073:                         "cursor_4c_DescCli")
2074:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
2075:                         SELECT cursor_4c_DescCli
2076:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DescCli.razaos)
2077:                     ELSE
2078:                         loc_oPg2.txt_4c_DConta.Value = ""
2079:                     ENDIF
2080:                     IF USED("cursor_4c_DescCli")
2081:                         USE IN cursor_4c_DescCli
2082:                     ENDIF
2083:                 ELSE
2084:                     loc_oPg2.txt_4c_DConta.Value = ""
2085:                 ENDIF
2086:             ENDIF
2087:         CATCH TO loc_oErro
2088:             MsgErro(loc_oErro.Message, "FormBch.BOParaForm")
2089:             IF USED("cursor_4c_DescGcr")
2090:                 USE IN cursor_4c_DescGcr

*-- Linhas 2114 a 2147:
2114:         ENDIF
2115: 
2116:         TRY
2117:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2118:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cCodigo), ;
2119:                 "cursor_4c_ChkOpt")
2120: 
2121:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkOpt") = 0
2122:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2123:                     "SigCdOpt", "cursor_4c_BuscaOpt", "operacaos", loc_cCodigo, ;
2124:                     "Opera" + CHR(231) + CHR(227) + "o")
2125: 
2126:                 IF VARTYPE(loc_oBusca) = "O"
2127:                     loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
2128:                     loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2129:                     loc_oBusca.Show()
2130: 
2131:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2132:                         SELECT cursor_4c_BuscaOpt
2133:                         loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
2134:                             ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
2135:                     ELSE
2136:                         loc_oPg2.txt_4c_Oper.Value = ""
2137:                     ENDIF
2138: 
2139:                     loc_oBusca.Release()
2140:                 ENDIF
2141:             ENDIF
2142: 
2143:             IF USED("cursor_4c_ChkOpt")
2144:                 USE IN cursor_4c_ChkOpt
2145:             ENDIF
2146:             IF USED("cursor_4c_BuscaOpt")
2147:                 USE IN cursor_4c_BuscaOpt

*-- Linhas 2181 a 2221:
2181:         ENDIF
2182: 
2183:         TRY
2184:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2185:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
2186:                 "cursor_4c_ChkGcr")
2187: 
2188:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
2189:                 SELECT cursor_4c_ChkGcr
2190:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2191:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
2192:                 ENDIF
2193:             ELSE
2194:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2195:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2196:                 ENDIF
2197:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2198:                     "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
2199: 
2200:                 IF VARTYPE(loc_oBusca) = "O"
2201:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2202:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2203:                     loc_oBusca.Show()
2204: 
2205:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2206:                         SELECT cursor_4c_BuscaGcr
2207:                         IF !EOF("cursor_4c_BuscaGcr")
2208:                             loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2209:                             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2210:                                 loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2211:                             ENDIF
2212:                         ELSE
2213:                             loc_oPg2.txt_4c_Grupo.Value = ""
2214:                         ENDIF
2215:                     ELSE
2216:                         loc_oPg2.txt_4c_Grupo.Value = ""
2217:                     ENDIF
2218: 
2219:                     loc_oBusca.Release()
2220:                 ENDIF
2221:             ENDIF

*-- Linhas 2271 a 2289:
2271:                 loc_oBusca.Show()
2272: 
2273:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2274:                     SELECT cursor_4c_BuscaGcr
2275:                     IF !EOF("cursor_4c_BuscaGcr")
2276:                         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2277:                             loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2278:                         ENDIF
2279:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2280:                     ELSE
2281:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2282:                     ENDIF
2283:                 ELSE
2284:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2285:                 ENDIF
2286: 
2287:                 loc_oBusca.Release()
2288:             ENDIF
2289: 

*-- Linhas 2322 a 2362:
2322:         ENDIF
2323: 
2324:         TRY
2325:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2326:                 "SELECT iclis, razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cCodigo), ;
2327:                 "cursor_4c_ChkCli")
2328: 
2329:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
2330:                 SELECT cursor_4c_ChkCli
2331:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2332:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ChkCli.razaos)
2333:                 ENDIF
2334:             ELSE
2335:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2336:                     loc_oPg2.txt_4c_DConta.Value = ""
2337:                 ENDIF
2338:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2339:                     "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")
2340: 
2341:                 IF VARTYPE(loc_oBusca) = "O"
2342:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2343:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
2344:                     loc_oBusca.Show()
2345: 
2346:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2347:                         SELECT cursor_4c_BuscaCli
2348:                         IF !EOF("cursor_4c_BuscaCli")
2349:                             loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
2350:                             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2351:                                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2352:                             ENDIF
2353:                         ELSE
2354:                             loc_oPg2.txt_4c_Conta.Value = ""
2355:                         ENDIF
2356:                     ELSE
2357:                         loc_oPg2.txt_4c_Conta.Value = ""
2358:                     ENDIF
2359: 
2360:                     loc_oBusca.Release()
2361:                 ENDIF
2362:             ENDIF

*-- Linhas 2412 a 2430:
2412:                 loc_oBusca.Show()
2413: 
2414:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2415:                     SELECT cursor_4c_BuscaCli
2416:                     IF !EOF("cursor_4c_BuscaCli")
2417:                         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2418:                             loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2419:                         ENDIF
2420:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2421:                     ELSE
2422:                         loc_oPg2.txt_4c_DConta.Value = ""
2423:                     ENDIF
2424:                 ELSE
2425:                     loc_oPg2.txt_4c_DConta.Value = ""
2426:                 ENDIF
2427: 
2428:                 loc_oBusca.Release()
2429:             ENDIF
2430: 

*-- Linhas 2519 a 2571:
2519: 
2520:         TRY
2521:             IF !EMPTY(loc_cGrupo) AND VARTYPE(loc_oPg3.txt_4c_DGrupoDisp) = "O"
2522:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2523:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2524:                     "cursor_4c_DescGcr")
2525:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2526:                     SELECT cursor_4c_DescGcr
2527:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2528:                 ELSE
2529:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ""
2530:                 ENDIF
2531:                 IF USED("cursor_4c_DescGcr")
2532:                     USE IN cursor_4c_DescGcr
2533:                 ENDIF
2534:             ENDIF
2535: 
2536:             IF !EMPTY(loc_cConta) AND VARTYPE(loc_oPg3.txt_4c_DContaDisp) = "O"
2537:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2538:                     "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
2539:                     "cursor_4c_DescCli")
2540:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
2541:                     SELECT cursor_4c_DescCli
2542:                     loc_oPg3.txt_4c_DContaDisp.Value = ALLTRIM(cursor_4c_DescCli.razaos)
2543:                 ELSE
2544:                     loc_oPg3.txt_4c_DContaDisp.Value = ""
2545:                 ENDIF
2546:                 IF USED("cursor_4c_DescCli")
2547:                     USE IN cursor_4c_DescCli
2548:                 ENDIF
2549:             ENDIF
2550: 
2551:             IF !EMPTY(loc_cOperacaos) AND VARTYPE(loc_oPg3.txt_4c_OperAbDisp) = "O"
2552:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2553:                     "SELECT descrs FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cOperacaos), ;
2554:                     "cursor_4c_DescOpt")
2555:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescOpt") > 0
2556:                     SELECT cursor_4c_DescOpt
2557:                     loc_oPg3.txt_4c_OperAbDisp.Value = ALLTRIM(cursor_4c_DescOpt.descrs)
2558:                 ELSE
2559:                     loc_oPg3.txt_4c_OperAbDisp.Value = ""
2560:                 ENDIF
2561:                 IF USED("cursor_4c_DescOpt")
2562:                     USE IN cursor_4c_DescOpt
2563:                 ENDIF
2564:             ENDIF
2565:         CATCH TO loc_oErro
2566:             MsgErro(loc_oErro.Message, "FormBch.PopularCamposLeitura")
2567:             IF USED("cursor_4c_DescGcr")
2568:                 USE IN cursor_4c_DescGcr
2569:             ENDIF
2570:             IF USED("cursor_4c_DescCli")
2571:                 USE IN cursor_4c_DescCli

*-- Linhas 2578 a 2622:
2578: 
2579:     *--------------------------------------------------------------------------
2580:     * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
2581:     * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
2582:     *--------------------------------------------------------------------------
2583:     PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
2584:         LOCAL loc_cSQL, loc_nResultado
2585: 
2586:         TRY
2587:             IF !USED("cursor_4c_Historico")
2588:                 SET NULL ON
2589:                 CREATE CURSOR cursor_4c_Historico ;
2590:                     (codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
2591:                      ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
2592:                      valors N(14,2), vencs D)
2593:                 SET NULL OFF
2594:             ENDIF
2595: 
2596:             loc_cSQL = "SELECT codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
2597:                        " usuarios, valors, vencs" + ;
2598:                        " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
2599:                        " ORDER BY datas, ncheques"
2600: 
2601:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
2602: 
2603:             IF loc_nResultado >= 0
2604:                 SELECT cursor_4c_Historico
2605:                 ZAP
2606:                 IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
2607:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
2608:                 ENDIF
2609:                 IF USED("cursor_4c_HistoricoTemp")
2610:                     USE IN cursor_4c_HistoricoTemp
2611:                 ENDIF
2612:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
2613:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.Refresh()
2614:                 ENDIF
2615:             ELSE
2616:                 MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2617:             ENDIF
2618:         CATCH TO loc_oErro
2619:             MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
2620:             IF USED("cursor_4c_HistoricoTemp")
2621:                 USE IN cursor_4c_HistoricoTemp
2622:             ENDIF

*-- Linhas 2685 a 2767:
2685:             ENDIF
2686: 
2687:             *-- Verificar se cheque existe no balanco
2688:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2689:                 "SELECT valors, vencs FROM SigCqBal" + ;
2690:                 " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
2691:                 " AND Bancos = " + EscaparSQL(loc_cBco) + ;
2692:                 " AND Agencias = " + EscaparSQL(loc_cAge) + ;
2693:                 " AND NContas = " + EscaparSQL(loc_cConta) + ;
2694:                 " AND NCheques = " + EscaparSQL(loc_cNum), ;
2695:                 "cursor_4c_VerifBal")
2696: 
2697:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_VerifBal") = 0
2698:                 MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2699:                 IF USED("cursor_4c_VerifBal")
2700:                     USE IN cursor_4c_VerifBal
2701:                 ENDIF
2702:                 loc_lContinuar = .F.
2703:             ENDIF
2704: 
2705:             IF loc_lContinuar
2706:                 SELECT cursor_4c_VerifBal
2707:                 loc_nValor = TratarNulo(valors, "N")
2708:                 loc_dVecto = TratarNulo(vencs,  "D")
2709:                 IF USED("cursor_4c_VerifBal")
2710:                     USE IN cursor_4c_VerifBal
2711:                 ENDIF
2712: 
2713:                 *-- Verificar duplicidade no historico
2714:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2715:                     "SELECT COUNT(*) AS qtd FROM SigCqHis" + ;
2716:                     " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
2717:                     " AND Bancos = " + EscaparSQL(loc_cBco) + ;
2718:                     " AND Agencias = " + EscaparSQL(loc_cAge) + ;
2719:                     " AND NContas = " + EscaparSQL(loc_cConta) + ;
2720:                     " AND NCheques = " + EscaparSQL(loc_cNum), ;
2721:                     "cursor_4c_VerifDup")
2722: 
2723:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VerifDup") > 0
2724:                     SELECT cursor_4c_VerifDup
2725:                     IF cursor_4c_VerifDup.qtd > 0
2726:                         MsgAviso("Cheque j" + CHR(225) + " consta no hist" + CHR(243) + "rico!", "")
2727:                         loc_lContinuar = .F.
2728:                     ENDIF
2729:                 ENDIF
2730:                 IF USED("cursor_4c_VerifDup")
2731:                     USE IN cursor_4c_VerifDup
2732:                 ENDIF
2733:             ENDIF
2734: 
2735:             IF loc_lContinuar
2736:                 *-- Inserir no historico de leitura
2737:                 loc_cSQL = "INSERT INTO SigCqHis" + ;
2738:                            " (codigos, bancos, agencias, ncontas, ncheques, tipos, datas, usuarios, valors, vencs)" + ;
2739:                            " VALUES (" + ;
2740:                            FormatarNumeroSQL(loc_nCodigos) + "," + ;
2741:                            EscaparSQL(LEFT(loc_cBco,   10)) + "," + ;
2742:                            EscaparSQL(LEFT(loc_cAge,   10)) + "," + ;
2743:                            EscaparSQL(LEFT(loc_cConta, 10)) + "," + ;
2744:                            EscaparSQL(LEFT(loc_cNum,   10)) + "," + ;
2745:                            FormatarNumeroSQL(loc_nTipos) + "," + ;
2746:                            "GETDATE()," + ;
2747:                            EscaparSQL(LEFT(gc_4c_UsuarioLogado, 15)) + "," + ;
2748:                            FormatarNumeroSQL(loc_nValor) + "," + ;
2749:                            FormatarDataSQL(loc_dVecto) + ;
2750:                            ")"
2751: 
2752:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
2753: 
2754:                 IF loc_nResultado >= 0
2755:                     IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2756:                         loc_oPg3.txt_4c_Valor.Value = loc_nValor
2757:                     ENDIF
2758:                     IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
2759:                         loc_oPg3.txt_4c_Vecto.Value = loc_dVecto
2760:                     ENDIF
2761:                     THIS.CarregarGradeLeitura(loc_nCodigos)
2762:                     THIS.LimparCamposLeitura()
2763:                 ELSE
2764:                     MsgErro("Erro ao inserir no hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2765:                 ENDIF
2766:             ENDIF
2767:         CATCH TO loc_oErro


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

