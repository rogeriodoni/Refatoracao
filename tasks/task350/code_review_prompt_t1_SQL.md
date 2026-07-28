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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS SQL (2832 linhas total):

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

*-- Linhas 1275 a 1347:
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
1290:         WITH loc_oGrid.Column1
1291:             .Width         = 55
1292:             .ControlSource = "cursor_4c_Historico.bancos"
1293:             .ReadOnly      = .T.
1294:             .Resizable     = .T.
1295:         ENDWITH
1296:         loc_oGrid.Column1.Header1.Caption = "Banco"
1297: 
1298:         WITH loc_oGrid.Column2
1299:             .Width         = 55
1300:             .ControlSource = "cursor_4c_Historico.agencias"
1301:             .ReadOnly      = .T.
1302:             .Resizable     = .T.
1303:         ENDWITH
1304:         loc_oGrid.Column2.Header1.Caption = "Ag" + CHR(234) + "ncia"
1305: 
1306:         WITH loc_oGrid.Column3
1307:             .Width         = 70
1308:             .ControlSource = "cursor_4c_Historico.ncontas"
1309:             .ReadOnly      = .T.
1310:             .Resizable     = .T.
1311:         ENDWITH
1312:         loc_oGrid.Column3.Header1.Caption = "N" + CHR(250) + ". Conta"
1313: 
1314:         WITH loc_oGrid.Column4
1315:             .Width         = 70
1316:             .ControlSource = "cursor_4c_Historico.ncheques"
1317:             .ReadOnly      = .T.
1318:             .Resizable     = .T.
1319:         ENDWITH
1320:         loc_oGrid.Column4.Header1.Caption = "N" + CHR(250) + ". Cheque"
1321: 
1322:         WITH loc_oGrid.Column5
1323:             .Width         = 75
1324:             .ControlSource = "cursor_4c_Historico.vencs"
1325:             .ReadOnly      = .T.
1326:             .Resizable     = .T.
1327:         ENDWITH
1328:         loc_oGrid.Column5.Header1.Caption = "Vencimento"
1329: 
1330:         WITH loc_oGrid.Column6
1331:             .Width         = 80
1332:             .ControlSource = "cursor_4c_Historico.valors"
1333:             .ReadOnly      = .T.
1334:             .Resizable     = .T.
1335:         ENDWITH
1336:         loc_oGrid.Column6.Header1.Caption = "Valor"
1337: 
1338:         *======================================================
1339:         * 7. Container botoes: Excluir / Gravar / Cancelar
1340:         *======================================================
1341:         loc_oPg3.AddObject("cnt_4c_BotoesLeitura", "Container")
1342:         loc_oBotoesLeitura = loc_oPg3.cnt_4c_BotoesLeitura
1343:         WITH loc_oBotoesLeitura
1344:             .Top         = 31
1345:             .Left        = 773
1346:             .Width       = 225
1347:             .Height      = 85

*-- Linhas 1436 a 1463:
1436:                         loc_oGrid.ColumnCount = 6
1437:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1438: 
1439:                         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1440:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1441:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
1442:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
1443:                         loc_oGrid.Column4.ControlSource = ;
1444:                             "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
1445:                             "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
1446:                             "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
1447:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1448:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1449: 
1450:                         *-- Reconfigurar headers (RecordSource reseta captions)
1451:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1452:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1453:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1454:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1455:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1456:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1457: 
1458:                         THIS.FormatarGridLista(loc_oGrid)
1459:                     ENDIF
1460:                     loc_lResultado = .T.
1461:                 ENDIF
1462:             ENDIF
1463:         CATCH TO loc_oErro

*-- Linhas 1530 a 1571:
1530:             RETURN
1531:         ENDIF
1532: 
1533:         SELECT cursor_4c_Dados
1534:         loc_nCodigo = cursor_4c_Dados.codigos
1535: 
1536:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1537:             THIS.this_cModoAtual = "VISUALIZAR"
1538:             THIS.BOParaForm()
1539:             THIS.HabilitarCampos(.F.)
1540:             THIS.AjustarBotoesPorModo()
1541:             THIS.AlternarPagina(2)
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     *--------------------------------------------------------------------------
1546:     * BtnAlterarClick - Edita balanco selecionado
1547:     *--------------------------------------------------------------------------
1548:     PROCEDURE BtnAlterarClick()
1549:         LOCAL loc_nCodigo
1550: 
1551:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1552:             MsgAviso("Selecione um registro na lista.", "")
1553:             RETURN
1554:         ENDIF
1555: 
1556:         SELECT cursor_4c_Dados
1557: 
1558:         IF cursor_4c_Dados.encerras
1559:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1560:                      "vel alterar balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1561:             RETURN
1562:         ENDIF
1563: 
1564:         loc_nCodigo = cursor_4c_Dados.codigos
1565: 
1566:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1567:             THIS.this_oBusinessObject.EditarRegistro()
1568:             THIS.this_cModoAtual = "ALTERAR"
1569:             THIS.BOParaForm()
1570:             THIS.HabilitarCampos(.T.)
1571:             THIS.AjustarBotoesPorModo()

*-- Linhas 1584 a 1602:
1584:             RETURN
1585:         ENDIF
1586: 
1587:         SELECT cursor_4c_Dados
1588: 
1589:         IF cursor_4c_Dados.encerras
1590:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1591:                      "vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1592:             RETURN
1593:         ENDIF
1594: 
1595:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1596:                         "Confirmar")
1597:             RETURN
1598:         ENDIF
1599: 
1600:         loc_nCodigo = cursor_4c_Dados.codigos
1601: 
1602:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)

*-- Linhas 1627 a 1649:
1627:                 loc_oBusca.Show()
1628: 
1629:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
1630:                     SELECT cursor_4c_BuscaBch
1631:                     IF !EOF("cursor_4c_BuscaBch")
1632:                         loc_nCodigo = cursor_4c_BuscaBch.codigos
1633:                         THIS.this_oBusinessObject.Buscar( ;
1634:                             "codigos = " + FormatarNumeroSQL(loc_nCodigo))
1635:                         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1636:                             THIS.CarregarLista()
1637:                         ENDIF
1638:                     ENDIF
1639:                 ELSE
1640:                     THIS.CarregarLista()
1641:                 ENDIF
1642: 
1643:                 loc_oBusca.Release()
1644:             ENDIF
1645:         CATCH TO loc_oErro
1646:             MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
1647:         ENDTRY
1648: 
1649:         IF USED("cursor_4c_BuscaBch")

*-- Linhas 1702 a 1720:
1702:             RETURN
1703:         ENDIF
1704: 
1705:         SELECT cursor_4c_Dados
1706: 
1707:         IF cursor_4c_Dados.encerras
1708:             MsgAviso("Invent" + CHR(225) + "rio J" + CHR(225) + " Encerrado !!!", "")
1709:             RETURN
1710:         ENDIF
1711: 
1712:         loc_nCodigo = cursor_4c_Dados.codigos
1713: 
1714:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1715:             THIS.this_cModoAtual = "LEITURA"
1716:             THIS.AlternarPagina(3)
1717:         ENDIF
1718:     ENDPROC
1719: 
1720:     *--------------------------------------------------------------------------

*-- Linhas 1728 a 1746:
1728:             RETURN
1729:         ENDIF
1730: 
1731:         SELECT cursor_4c_Dados
1732: 
1733:         IF cursor_4c_Dados.encerras
1734:             MsgAviso("Balan" + CHR(231) + "o J" + CHR(225) + " Encerrado !!!", "")
1735:             RETURN
1736:         ENDIF
1737: 
1738:         IF !MsgConfirma("Este Balan" + CHR(231) + "o ser" + CHR(225) + " finalizado, n" + ;
1739:                         CHR(227) + "o podendo ser efetuada mais nenhuma leitura..." + CHR(13) + ;
1740:                         "Deseja encerrar o Balan" + CHR(231) + "o ???", ;
1741:                         "ATEN" + CHR(199) + CHR(195) + "O")
1742:             RETURN
1743:         ENDIF
1744: 
1745:         loc_nCodigo = cursor_4c_Dados.codigos
1746: 

*-- Linhas 1771 a 1809:
1771:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
1772:             loc_lContinuar = .T.
1773: 
1774:             SELECT cursor_4c_Historico
1775:             GO TOP
1776: 
1777:             DO WHILE !EOF("cursor_4c_Historico") AND loc_lContinuar
1778:                 IF cursor_4c_Historico.tipos = 2
1779:                     loc_cSQL = "UPDATE SigCqBal SET ReLidos = 1" + ;
1780:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1781:                                " AND Bancos = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.bancos)) + ;
1782:                                " AND Agencias = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.agencias)) + ;
1783:                                " AND NContas = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncontas)) + ;
1784:                                " AND NCheques = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncheques))
1785:                 ELSE
1786:                     loc_cSQL = "UPDATE SigCqBal SET Lidos = 1" + ;
1787:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1788:                                " AND Bancos = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.bancos)) + ;
1789:                                " AND Agencias = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.agencias)) + ;
1790:                                " AND NContas = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncontas)) + ;
1791:                                " AND NCheques = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncheques))
1792:                 ENDIF
1793: 
1794:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1795:                 IF loc_nResult < 0
1796:                     MsgErro("Erro ao atualizar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
1797:                     loc_lContinuar = .F.
1798:                 ELSE
1799:                     SKIP IN cursor_4c_Historico
1800:                 ENDIF
1801:             ENDDO
1802: 
1803:             IF loc_lContinuar AND THIS.this_oBusinessObject.MarcarGravado()
1804:                 MsgInfo("Leitura gravada com sucesso!", "")
1805:                 THIS.this_cModoAtual = "LISTA"
1806:                 THIS.AlternarPagina(1)
1807:             ENDIF
1808:         CATCH TO loc_oErro
1809:             MsgErro(loc_oErro.Message, "FormBch.BtnGravarLeituraClick")

*-- Linhas 1824 a 1877:
1824:         ENDIF
1825: 
1826:         TRY
1827:             SELECT cursor_4c_Historico
1828:             loc_nCodigos  = cursor_4c_Historico.codigos
1829:             loc_cBancos   = ALLTRIM(cursor_4c_Historico.bancos)
1830:             loc_cAgencias = ALLTRIM(cursor_4c_Historico.agencias)
1831:             loc_cNContas  = ALLTRIM(cursor_4c_Historico.ncontas)
1832:             loc_cNCheques = ALLTRIM(cursor_4c_Historico.ncheques)
1833:             loc_nTipos    = cursor_4c_Historico.tipos
1834: 
1835:             loc_cSQL = "DELETE FROM SigCqHis" + ;
1836:                        " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1837:                        " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1838:                        " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1839:                        " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1840:                        " AND NCheques = " + EscaparSQL(loc_cNCheques)
1841: 
1842:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1843:             IF loc_nResult < 0
1844:                 MsgErro("Erro ao excluir hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
1845:             ELSE
1846:                 IF loc_nTipos = 2
1847:                     loc_cSQL = "UPDATE SigCqBal SET ReLidos = 0" + ;
1848:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1849:                                " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1850:                                " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1851:                                " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1852:                                " AND NCheques = " + EscaparSQL(loc_cNCheques)
1853:                 ELSE
1854:                     loc_cSQL = "UPDATE SigCqBal SET Lidos = 0" + ;
1855:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1856:                                " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1857:                                " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1858:                                " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1859:                                " AND NCheques = " + EscaparSQL(loc_cNCheques)
1860:                 ENDIF
1861: 
1862:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1863:                 IF loc_nResult < 0
1864:                     MsgErro("Erro ao resetar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
1865:                 ENDIF
1866: 
1867:                 THIS.CarregarGradeLeitura(loc_nCodigos)
1868:             ENDIF
1869:         CATCH TO loc_oErro
1870:             MsgErro(loc_oErro.Message, "FormBch.BtnExcluirHistoricoClick")
1871:         ENDTRY
1872:     ENDPROC
1873: 
1874:     *--------------------------------------------------------------------------
1875:     * BtnCancelarLeituraClick - Cancela leitura e retorna para lista (Page3)
1876:     *--------------------------------------------------------------------------
1877:     PROCEDURE BtnCancelarLeituraClick()

*-- Linhas 2058 a 2099:
2058:         TRY
2059:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2060:                 IF !EMPTY(loc_cGrupo)
2061:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2062:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2063:                         "cursor_4c_DescGcr")
2064:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2065:                         SELECT cursor_4c_DescGcr
2066:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2067:                     ELSE
2068:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2069:                     ENDIF
2070:                     IF USED("cursor_4c_DescGcr")
2071:                         USE IN cursor_4c_DescGcr
2072:                     ENDIF
2073:                 ELSE
2074:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2075:                 ENDIF
2076:             ENDIF
2077: 
2078:             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2079:                 IF !EMPTY(loc_cConta)
2080:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2081:                         "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
2082:                         "cursor_4c_DescCli")
2083:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
2084:                         SELECT cursor_4c_DescCli
2085:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DescCli.razaos)
2086:                     ELSE
2087:                         loc_oPg2.txt_4c_DConta.Value = ""
2088:                     ENDIF
2089:                     IF USED("cursor_4c_DescCli")
2090:                         USE IN cursor_4c_DescCli
2091:                     ENDIF
2092:                 ELSE
2093:                     loc_oPg2.txt_4c_DConta.Value = ""
2094:                 ENDIF
2095:             ENDIF
2096:         CATCH TO loc_oErro
2097:             MsgErro(loc_oErro.Message, "FormBch.BOParaForm")
2098:             IF USED("cursor_4c_DescGcr")
2099:                 USE IN cursor_4c_DescGcr

*-- Linhas 2123 a 2156:
2123:         ENDIF
2124: 
2125:         TRY
2126:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2127:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cCodigo), ;
2128:                 "cursor_4c_ChkOpt")
2129: 
2130:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkOpt") = 0
2131:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2132:                     "SigCdOpt", "cursor_4c_BuscaOpt", "operacaos", loc_cCodigo, ;
2133:                     "Opera" + CHR(231) + CHR(227) + "o")
2134: 
2135:                 IF VARTYPE(loc_oBusca) = "O"
2136:                     loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
2137:                     loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2138:                     loc_oBusca.Show()
2139: 
2140:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2141:                         SELECT cursor_4c_BuscaOpt
2142:                         loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
2143:                             ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
2144:                     ELSE
2145:                         loc_oPg2.txt_4c_Oper.Value = ""
2146:                     ENDIF
2147: 
2148:                     loc_oBusca.Release()
2149:                 ENDIF
2150:             ENDIF
2151: 
2152:             IF USED("cursor_4c_ChkOpt")
2153:                 USE IN cursor_4c_ChkOpt
2154:             ENDIF
2155:             IF USED("cursor_4c_BuscaOpt")
2156:                 USE IN cursor_4c_BuscaOpt

*-- Linhas 2190 a 2230:
2190:         ENDIF
2191: 
2192:         TRY
2193:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2194:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
2195:                 "cursor_4c_ChkGcr")
2196: 
2197:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
2198:                 SELECT cursor_4c_ChkGcr
2199:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2200:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
2201:                 ENDIF
2202:             ELSE
2203:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2204:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2205:                 ENDIF
2206:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2207:                     "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
2208: 
2209:                 IF VARTYPE(loc_oBusca) = "O"
2210:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2211:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2212:                     loc_oBusca.Show()
2213: 
2214:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2215:                         SELECT cursor_4c_BuscaGcr
2216:                         IF !EOF("cursor_4c_BuscaGcr")
2217:                             loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2218:                             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2219:                                 loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2220:                             ENDIF
2221:                         ELSE
2222:                             loc_oPg2.txt_4c_Grupo.Value = ""
2223:                         ENDIF
2224:                     ELSE
2225:                         loc_oPg2.txt_4c_Grupo.Value = ""
2226:                     ENDIF
2227: 
2228:                     loc_oBusca.Release()
2229:                 ENDIF
2230:             ENDIF

*-- Linhas 2280 a 2298:
2280:                 loc_oBusca.Show()
2281: 
2282:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2283:                     SELECT cursor_4c_BuscaGcr
2284:                     IF !EOF("cursor_4c_BuscaGcr")
2285:                         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2286:                             loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2287:                         ENDIF
2288:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2289:                     ELSE
2290:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2291:                     ENDIF
2292:                 ELSE
2293:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2294:                 ENDIF
2295: 
2296:                 loc_oBusca.Release()
2297:             ENDIF
2298: 

*-- Linhas 2331 a 2371:
2331:         ENDIF
2332: 
2333:         TRY
2334:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2335:                 "SELECT iclis, razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cCodigo), ;
2336:                 "cursor_4c_ChkCli")
2337: 
2338:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
2339:                 SELECT cursor_4c_ChkCli
2340:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2341:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ChkCli.razaos)
2342:                 ENDIF
2343:             ELSE
2344:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2345:                     loc_oPg2.txt_4c_DConta.Value = ""
2346:                 ENDIF
2347:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2348:                     "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")
2349: 
2350:                 IF VARTYPE(loc_oBusca) = "O"
2351:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2352:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
2353:                     loc_oBusca.Show()
2354: 
2355:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2356:                         SELECT cursor_4c_BuscaCli
2357:                         IF !EOF("cursor_4c_BuscaCli")
2358:                             loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
2359:                             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2360:                                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2361:                             ENDIF
2362:                         ELSE
2363:                             loc_oPg2.txt_4c_Conta.Value = ""
2364:                         ENDIF
2365:                     ELSE
2366:                         loc_oPg2.txt_4c_Conta.Value = ""
2367:                     ENDIF
2368: 
2369:                     loc_oBusca.Release()
2370:                 ENDIF
2371:             ENDIF

*-- Linhas 2421 a 2439:
2421:                 loc_oBusca.Show()
2422: 
2423:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2424:                     SELECT cursor_4c_BuscaCli
2425:                     IF !EOF("cursor_4c_BuscaCli")
2426:                         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2427:                             loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2428:                         ENDIF
2429:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2430:                     ELSE
2431:                         loc_oPg2.txt_4c_DConta.Value = ""
2432:                     ENDIF
2433:                 ELSE
2434:                     loc_oPg2.txt_4c_DConta.Value = ""
2435:                 ENDIF
2436: 
2437:                 loc_oBusca.Release()
2438:             ENDIF
2439: 

*-- Linhas 2526 a 2578:
2526: 
2527:         TRY
2528:             IF !EMPTY(loc_cGrupo) AND VARTYPE(loc_oPg3.txt_4c_DGrupoDisp) = "O"
2529:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2530:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2531:                     "cursor_4c_DescGcr")
2532:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2533:                     SELECT cursor_4c_DescGcr
2534:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2535:                 ELSE
2536:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ""
2537:                 ENDIF
2538:                 IF USED("cursor_4c_DescGcr")
2539:                     USE IN cursor_4c_DescGcr
2540:                 ENDIF
2541:             ENDIF
2542: 
2543:             IF !EMPTY(loc_cConta) AND VARTYPE(loc_oPg3.txt_4c_DContaDisp) = "O"
2544:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2545:                     "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
2546:                     "cursor_4c_DescCli")
2547:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
2548:                     SELECT cursor_4c_DescCli
2549:                     loc_oPg3.txt_4c_DContaDisp.Value = ALLTRIM(cursor_4c_DescCli.razaos)
2550:                 ELSE
2551:                     loc_oPg3.txt_4c_DContaDisp.Value = ""
2552:                 ENDIF
2553:                 IF USED("cursor_4c_DescCli")
2554:                     USE IN cursor_4c_DescCli
2555:                 ENDIF
2556:             ENDIF
2557: 
2558:             IF !EMPTY(loc_cOperacaos) AND VARTYPE(loc_oPg3.txt_4c_OperAbDisp) = "O"
2559:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2560:                     "SELECT descrs FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cOperacaos), ;
2561:                     "cursor_4c_DescOpt")
2562:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescOpt") > 0
2563:                     SELECT cursor_4c_DescOpt
2564:                     loc_oPg3.txt_4c_OperAbDisp.Value = ALLTRIM(cursor_4c_DescOpt.descrs)
2565:                 ELSE
2566:                     loc_oPg3.txt_4c_OperAbDisp.Value = ""
2567:                 ENDIF
2568:                 IF USED("cursor_4c_DescOpt")
2569:                     USE IN cursor_4c_DescOpt
2570:                 ENDIF
2571:             ENDIF
2572:         CATCH TO loc_oErro
2573:             MsgErro(loc_oErro.Message, "FormBch.PopularCamposLeitura")
2574:             IF USED("cursor_4c_DescGcr")
2575:                 USE IN cursor_4c_DescGcr
2576:             ENDIF
2577:             IF USED("cursor_4c_DescCli")
2578:                 USE IN cursor_4c_DescCli

*-- Linhas 2585 a 2629:
2585: 
2586:     *--------------------------------------------------------------------------
2587:     * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
2588:     * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
2589:     *--------------------------------------------------------------------------
2590:     PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
2591:         LOCAL loc_cSQL, loc_nResultado
2592: 
2593:         TRY
2594:             IF !USED("cursor_4c_Historico")
2595:                 SET NULL ON
2596:                 CREATE CURSOR cursor_4c_Historico ;
2597:                     (codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
2598:                      ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
2599:                      valors N(14,2), vencs D)
2600:                 SET NULL OFF
2601:             ENDIF
2602: 
2603:             loc_cSQL = "SELECT codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
2604:                        " usuarios, valors, vencs" + ;
2605:                        " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
2606:                        " ORDER BY datas, ncheques"
2607: 
2608:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
2609: 
2610:             IF loc_nResultado >= 0
2611:                 SELECT cursor_4c_Historico
2612:                 ZAP
2613:                 IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
2614:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
2615:                 ENDIF
2616:                 IF USED("cursor_4c_HistoricoTemp")
2617:                     USE IN cursor_4c_HistoricoTemp
2618:                 ENDIF
2619:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
2620:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.Refresh()
2621:                 ENDIF
2622:             ELSE
2623:                 MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2624:             ENDIF
2625:         CATCH TO loc_oErro
2626:             MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
2627:             IF USED("cursor_4c_HistoricoTemp")
2628:                 USE IN cursor_4c_HistoricoTemp
2629:             ENDIF

*-- Linhas 2692 a 2774:
2692:             ENDIF
2693: 
2694:             *-- Verificar se cheque existe no balanco
2695:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2696:                 "SELECT valors, vencs FROM SigCqBal" + ;
2697:                 " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
2698:                 " AND Bancos = " + EscaparSQL(loc_cBco) + ;
2699:                 " AND Agencias = " + EscaparSQL(loc_cAge) + ;
2700:                 " AND NContas = " + EscaparSQL(loc_cConta) + ;
2701:                 " AND NCheques = " + EscaparSQL(loc_cNum), ;
2702:                 "cursor_4c_VerifBal")
2703: 
2704:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_VerifBal") = 0
2705:                 MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2706:                 IF USED("cursor_4c_VerifBal")
2707:                     USE IN cursor_4c_VerifBal
2708:                 ENDIF
2709:                 loc_lContinuar = .F.
2710:             ENDIF
2711: 
2712:             IF loc_lContinuar
2713:                 SELECT cursor_4c_VerifBal
2714:                 loc_nValor = TratarNulo(valors, "N")
2715:                 loc_dVecto = TratarNulo(vencs,  "D")
2716:                 IF USED("cursor_4c_VerifBal")
2717:                     USE IN cursor_4c_VerifBal
2718:                 ENDIF
2719: 
2720:                 *-- Verificar duplicidade no historico
2721:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2722:                     "SELECT COUNT(*) AS qtd FROM SigCqHis" + ;
2723:                     " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
2724:                     " AND Bancos = " + EscaparSQL(loc_cBco) + ;
2725:                     " AND Agencias = " + EscaparSQL(loc_cAge) + ;
2726:                     " AND NContas = " + EscaparSQL(loc_cConta) + ;
2727:                     " AND NCheques = " + EscaparSQL(loc_cNum), ;
2728:                     "cursor_4c_VerifDup")
2729: 
2730:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VerifDup") > 0
2731:                     SELECT cursor_4c_VerifDup
2732:                     IF cursor_4c_VerifDup.qtd > 0
2733:                         MsgAviso("Cheque j" + CHR(225) + " consta no hist" + CHR(243) + "rico!", "")
2734:                         loc_lContinuar = .F.
2735:                     ENDIF
2736:                 ENDIF
2737:                 IF USED("cursor_4c_VerifDup")
2738:                     USE IN cursor_4c_VerifDup
2739:                 ENDIF
2740:             ENDIF
2741: 
2742:             IF loc_lContinuar
2743:                 *-- Inserir no historico de leitura
2744:                 loc_cSQL = "INSERT INTO SigCqHis" + ;
2745:                            " (codigos, bancos, agencias, ncontas, ncheques, tipos, datas, usuarios, valors, vencs)" + ;
2746:                            " VALUES (" + ;
2747:                            FormatarNumeroSQL(loc_nCodigos) + "," + ;
2748:                            EscaparSQL(LEFT(loc_cBco,   10)) + "," + ;
2749:                            EscaparSQL(LEFT(loc_cAge,   10)) + "," + ;
2750:                            EscaparSQL(LEFT(loc_cConta, 10)) + "," + ;
2751:                            EscaparSQL(LEFT(loc_cNum,   10)) + "," + ;
2752:                            FormatarNumeroSQL(loc_nTipos) + "," + ;
2753:                            "GETDATE()," + ;
2754:                            EscaparSQL(LEFT(gc_4c_UsuarioLogado, 15)) + "," + ;
2755:                            FormatarNumeroSQL(loc_nValor) + "," + ;
2756:                            FormatarDataSQL(loc_dVecto) + ;
2757:                            ")"
2758: 
2759:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
2760: 
2761:                 IF loc_nResultado >= 0
2762:                     IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2763:                         loc_oPg3.txt_4c_Valor.Value = loc_nValor
2764:                     ENDIF
2765:                     IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
2766:                         loc_oPg3.txt_4c_Vecto.Value = loc_dVecto
2767:                     ENDIF
2768:                     THIS.CarregarGradeLeitura(loc_nCodigos)
2769:                     THIS.LimparCamposLeitura()
2770:                 ELSE
2771:                     MsgErro("Erro ao inserir no hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2772:                 ENDIF
2773:             ENDIF
2774:         CATCH TO loc_oErro


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

