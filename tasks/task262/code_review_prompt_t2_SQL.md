# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLECOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS

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
lcQuery = [Select * From SigCdPro ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigCdPro') < 1)
Select CrSigCdPro
lcQuery = [Select * From SigPrCpo Where 1=0 ]
If (Thisform.poDataMgr.SqlExecute(lcQuery, [TmpPrCpo]) < 1)
Select TmpPrCpo
lcQuery = [Select * From SigPrFti ]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFti') < 1)
Select CrSigPrFti
lcQuery = [Select a.*, b.Dgrus From SigPrFto a, SigCdGrp b Where ]+;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFtiG') < 1)
Select CrSigPrFtiG
lcQuery = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where ]+;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFtiP') < 1)
Select CrSigPrFtiP
Select CrSigPrCpo
	Select CrSigCdPro
		loBarra.Update(.T.)
		lcQuery = [Select * From SigPrCpo Where CPros = '] + pPro + [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [TmpCompo]) < 1)
		Select TmpCompo
				lcQuery = [Select a.PesoMs, b.CfgGerGprs ] + ;
					[From SigCdPro a, SigCdGrp b ] + ;
				If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalProCp]) < 1)
							lcQuery = [Update SigPrCpo Set Qtds = ] + Str(lnVal, 9, 3) + [ ] + ;
							If (Thisform.poDataMgr.SqlExecute(lcQuery, []) < 1)
							lcQuery = [Update SigPrCpo Set Pesos = ] + Str(lnVal, 9, 3) + [ ] + ;
							If (Thisform.poDataMgr.SqlExecute(lcQuery, []) < 1)
			Insert Into crProdutos (Cpros, DPros) Values (CrSigCdPro.Cpros, CrSigCdPro.DPros)
	Select CrSigCdPro
		lcSql = [Select * From SigPrCpo Where Cpros = ']+pPro+[']
		If Thisform.poDataMgr.SqlExecute(lcSql,'CrSigPrCpo') < 1
		Select CrSigPrCpo
		Insert Into crProdutos (Cpros, DPros, ValAnt, CustoAfs ) ;
		Select CrSigCdPro
		=Seek(CrSigCdPro.Moecs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moepcs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moedas, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Cgrus,'CrSigCdGrp','Cgrus')
		Select TotGrupo
		Select CrSigPrCpo
		=Seek(pPro)
			lcQuery = [Select Distinct Matprincs From SigCdPro Where MatPrincs <> Space(14) and MatPrincs = ']+CrSigPrCpo.Mats+[' ]
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crMatPrinc') < 1)
			Select crMatPrinc
				lcSql = [Select Custofs, MoeCusfs, Cunis, Cgrus, Moevs, cUniPs, pVens From SigCdPro ]+;
				If Thisform.poDataMgr.SqlExecute(lcSql,'CrCompoPro') < 1
				=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
				Select TotGrupo
					Insert Into TotGrupo (Grupo, Cpros, Moeda) Values (CrSigPrCpo.Cgrus, CrSigPrCpo.Mats, CrSigPrCpo.Moeds)
				=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
				=Seek(crCompoPro.Moevs, 'crSigCdMoe', 'CMoes' )
					=Seek(CrSigPrCpo.UniCompos,'CrSigCdUni','Cunis')
					=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
						=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
						=Seek(crCompoPro.Moevs, 'crSigCdMoe', 'CMoes' )
				=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
				=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
					=Seek(Iif(CrSigCdGrp.BPesos=1,crCompoPro.Cunis,crCompoPro.CUniPs),'CrSigCdUni','Cunis')
					Select CrSigPrCpo
		Select CrSigCdPro
		Select CrSigPrCpo
			Select TmpPrCpo
			Select CrSigPrCpo
		Select Cgrus As Grupo, Mats As Cpros, dCompos As Dgrus, Moeds As Moeda, Pesos, Qtds, PCompos, 00000000.000 As ValGrupo, OrdTs ;
			From CrSigPrCpo ;
		Update LocalTGrupo Set ValGrupo = Iif(CrSigCdGrp.chkInstalas=2, Pesos, Qtds) * PCompos
			lcSql = [Select * From SigPrFti Where Cods = ']+MarkCus+[']
			Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtio')
			Select TmpFtio
				lcSql = [Select a.*, IsNull(b.Dgrus,'') as Dgrus From SigPrFto a Left Join SigCdGrp b on a.Cgrus = b.Cgrus Where a.Cods = ']+MarkCus+[' ]+;
				Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtioC')
					Select LocalTGrupo
						Select TmpFtioC
				lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkCus+[' And ]+;
				Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtioC')
				Select TmpFtioC
		=Seek(MarkVen,'CrSigPrFti','Cods')
				Select CrSigPrFtiG
				Select TotGrupo
					Select CrSigPrFtiG
				Select CrSigPrFtiP
				Select CrSigPrFtiP
		=Seek(CrSigCdPro.Cgrus,'CrSigCdGrp','Cgrus')
		=Seek(CrSigCdPro.Moecs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moepcs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moevs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.MoeCusfs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moedas, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.mFtios, 'crSigCdMoe', 'CMoes' )
		=Seek(cFtioV,'CrSigPrFti','Cods')
		Select CrSigCdPro
			Select CrSigCdPro
		Select crProdutos
		loBarra.Update(.T.)
lnOldSel = Select()
Select CrProdutos
lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdCcp') < 1)
Select crSigCdCcp
	Select CrProdutos
	Select crSigCdCcp
		Select CrProdutos
			Delete For PVarias < lnVaria
			Delete For PVarias > lnVaria
	Select crSigCdCcp
Select(lnOldSel)
	Select * From CrProdutos Where lMarca = 1 Order By CPros Into Cursor CsProdutos ReadWrite
	Select CsProdutos
	Select CsProdutos
		loBarra.Update(.T.,'Produto: ' + CsProdutos.CPros)
		If Seek(CsProdutos.CPros,'CrSigCdPro','CPros')
			Select CrSigCdPro
			Insert Into GrSigCdPro From Memvar
			lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpPro2') < 1
			Select TmpPro2
			Insert Into CrSigCdPrc From MemVar
			If ThisForm.poDataMgr.SqlExecute([Select * From SigPrCpo Where CPros = ']+m.CPros+[' ],'TmpCompo') < 1
			Select TmpCompo
				Insert Into CrSigPrCp2 From MemVar
			If ThisForm.poDataMgr.SqlExecute([Delete From SigPrPrt Where CPros = '] + m.CPros + [' ], []) < 1
			Select TmpPrCpo
			=Seek(m.cpros)
				Insert Into GrSigPrCpo From Memvar
		Select CsProdutos
		Select grSigCdPro
			lcQrySGru  = [Select * From SigCdPsg Where CGrus = ']+grSigCdPro.cGrus+[' Order By nFaixaFins]
			If (ThisForm.poDatamgr.SqlExecute(lcQrySGru,'csSigCdPsg') < 1)
			Select csSigCdPsg
					Select grSigCdPro
					Select grSigCdPro
	loBarraFim.Update(.T.,'SigCdPro (1/4)...')
	llOk = ThisForm.poDataMgr.Update('grSigCdPro')
		loBarraFim.Update(.T.,'SigCdPrc (2/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigCdPrc')
		loBarraFim.Update(.T.,'SigPrCp2 (3/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigPrCp2')
		loBarraFim.Update(.T.,'SigPrCpo (4/4)...')
		llOk = ThisForm.poDataMgr.Update('grSigPrCpo')
		lcSql = [Select * From SigCdMoe ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdMoe')
		lcSql = [Select * From SigCdCot ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdCot')
		lcSql = [Select * From SigCdGrp ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdGrp')
		lcSql = [Select * From SigCdUni ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdUni')
		Select CrSigCdGrp
		Select CrSigCdUni
		Select CrSigCdCot
		Select CrSigCdMoe
		Select CrProdutos
			.Column1.ControlSource = 'CrProdutos.lMarca'
			.Column2.ControlSource = 'CrProdutos.CPros'
			.Column3.ControlSource = 'CrProdutos.DPros'
			.Column4.ControlSource = 'CrProdutos.ValAnt'
			.Column5.ControlSource = 'CrProdutos.ValAtu'
			.Column6.ControlSource = 'CrProdutos.pVarias'
			.Column7.ControlSource = 'CrProdutos.CustoAfs'
			.Column8.ControlSource = 'CrProdutos.CustoFs'
			.Column9.ControlSource = 'CrProdutos.cVarias'
Select CrProdutos
lcSql = [Select FigJpgs From SigCdPro Where Cpros = ']+lcCodPro+[']
If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpPro') < 1
Select TmpPro
	Select CrProdutos
		Select CrProdutos
			Delete For PVarias < lnVaria
			Delete For PVarias > lnVaria
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti ]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')
Select crprodutos
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
		Delete File (lcArquivo)
Update CrProdutos Set lMarca = 1
Update CrProdutos Set lMarca = 0
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti ] + lcFiltro
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS SQL (3043 linhas total):

*-- Linhas 1373 a 1559:
1373:                 .Check1.Caption = ""
1374:                 .Check1.Value   = 0
1375:                 .CurrentControl = "Check1"
1376:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
1377:                 WITH .Header1
1378:                     .Caption   = ""
1379:                     .FontName  = "Tahoma"
1380:                     .FontSize  = 8
1381:                     .Alignment = 2
1382:                     .ForeColor = RGB(36, 84, 155)
1383:                 ENDWITH
1384:             ENDWITH
1385: 
1386:             *-- Column2: CPros
1387:             WITH .Column2
1388:                 .Width         = 108
1389:                 .Movable       = .F.
1390:                 .Resizable     = .F.
1391:                 .FontName      = "Tahoma"
1392:                 .FontSize      = 8
1393:                 .ControlSource = "cursor_4c_Produtos.CPros"
1394:                 WITH .Header1
1395:                     .Caption   = "Produto"
1396:                     .FontName  = "Tahoma"
1397:                     .FontSize  = 8
1398:                     .Alignment = 2
1399:                     .ForeColor = RGB(36, 84, 155)
1400:                 ENDWITH
1401:             ENDWITH
1402: 
1403:             *-- Column3: DPros
1404:             WITH .Column3
1405:                 .Width         = 290
1406:                 .Movable       = .F.
1407:                 .Resizable     = .F.
1408:                 .FontName      = "Tahoma"
1409:                 .FontSize      = 8
1410:                 .ControlSource = "cursor_4c_Produtos.DPros"
1411:                 WITH .Header1
1412:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1413:                     .FontName  = "Tahoma"
1414:                     .FontSize  = 8
1415:                     .Alignment = 2
1416:                     .ForeColor = RGB(36, 84, 155)
1417:                 ENDWITH
1418:             ENDWITH
1419: 
1420:             *-- Column4: ValAnt
1421:             WITH .Column4
1422:                 .Width         = 80
1423:                 .Movable       = .F.
1424:                 .Resizable     = .F.
1425:                 .FontName      = "Tahoma"
1426:                 .FontSize      = 8
1427:                 .InputMask     = "999,999,999.99"
1428:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
1429:                 WITH .Header1
1430:                     .Caption   = "Venda Ant."
1431:                     .FontName  = "Tahoma"
1432:                     .FontSize  = 8
1433:                     .Alignment = 2
1434:                     .ForeColor = RGB(36, 84, 155)
1435:                 ENDWITH
1436:             ENDWITH
1437: 
1438:             *-- Column5: ValAtu
1439:             WITH .Column5
1440:                 .Width         = 80
1441:                 .Movable       = .F.
1442:                 .Resizable     = .F.
1443:                 .FontName      = "Tahoma"
1444:                 .FontSize      = 8
1445:                 .InputMask     = "999,999,999.99"
1446:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
1447:                 WITH .Header1
1448:                     .Caption   = "Venda Atual"
1449:                     .FontName  = "Tahoma"
1450:                     .FontSize  = 8
1451:                     .Alignment = 2
1452:                     .ForeColor = RGB(36, 84, 155)
1453:                 ENDWITH
1454:             ENDWITH
1455: 
1456:             *-- Column6: PVarias (ReadOnly)
1457:             WITH .Column6
1458:                 .Width         = 80
1459:                 .Movable       = .F.
1460:                 .Resizable     = .F.
1461:                 .ReadOnly      = .T.
1462:                 .FontName      = "Tahoma"
1463:                 .FontSize      = 8
1464:                 .InputMask     = "999,999.99"
1465:                 .ControlSource = "cursor_4c_Produtos.PVarias"
1466:                 WITH .Header1
1467:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1468:                     .FontName  = "Tahoma"
1469:                     .FontSize  = 8
1470:                     .Alignment = 2
1471:                     .ForeColor = RGB(36, 84, 155)
1472:                 ENDWITH
1473:             ENDWITH
1474: 
1475:             *-- Column7: CustoAfs (ReadOnly)
1476:             WITH .Column7
1477:                 .Width         = 80
1478:                 .Movable       = .F.
1479:                 .Resizable     = .F.
1480:                 .ReadOnly      = .T.
1481:                 .FontName      = "Tahoma"
1482:                 .FontSize      = 8
1483:                 .InputMask     = "999,999,999.9999"
1484:                 .ControlSource = "cursor_4c_Produtos.CustoAfs"
1485:                 WITH .Header1
1486:                     .Caption   = "Custo Ant."
1487:                     .FontName  = "Tahoma"
1488:                     .FontSize  = 8
1489:                     .Alignment = 2
1490:                 ENDWITH
1491:             ENDWITH
1492: 
1493:             *-- Column8: CustoFs (ReadOnly)
1494:             WITH .Column8
1495:                 .Width         = 80
1496:                 .Movable       = .F.
1497:                 .Resizable     = .F.
1498:                 .ReadOnly      = .T.
1499:                 .FontName      = "Tahoma"
1500:                 .FontSize      = 8
1501:                 .InputMask     = "999,999,999.9999"
1502:                 .ControlSource = "cursor_4c_Produtos.CustoFs"
1503:                 WITH .Header1
1504:                     .Caption   = "Custo Atual"
1505:                     .FontName  = "Tahoma"
1506:                     .FontSize  = 8
1507:                     .Alignment = 2
1508:                 ENDWITH
1509:             ENDWITH
1510: 
1511:             *-- Column9: CVarias (ReadOnly)
1512:             WITH .Column9
1513:                 .Width         = 80
1514:                 .Movable       = .F.
1515:                 .Resizable     = .F.
1516:                 .ReadOnly      = .T.
1517:                 .FontName      = "Tahoma"
1518:                 .FontSize      = 8
1519:                 .InputMask     = "999,999.99"
1520:                 .ControlSource = "cursor_4c_Produtos.CVarias"
1521:                 WITH .Header1
1522:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1523:                     .FontName  = "Tahoma"
1524:                     .FontSize  = 8
1525:                     .Alignment = 2
1526:                 ENDWITH
1527:             ENDWITH
1528:         ENDWITH
1529:     ENDPROC
1530: 
1531:     *==========================================================================
1532:     PROTECTED PROCEDURE ReconfigurarGrade()
1533:     *==========================================================================
1534:         WITH THIS.grd_4c_Produto
1535:             .RecordSource          = "cursor_4c_Produtos"
1536:             .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
1537:             .Column2.ControlSource = "cursor_4c_Produtos.CPros"
1538:             .Column3.ControlSource = "cursor_4c_Produtos.DPros"
1539:             .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
1540:             .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
1541:             .Column6.ControlSource = "cursor_4c_Produtos.PVarias"
1542:             .Column7.ControlSource = "cursor_4c_Produtos.CustoAfs"
1543:             .Column8.ControlSource = "cursor_4c_Produtos.CustoFs"
1544:             .Column9.ControlSource = "cursor_4c_Produtos.CVarias"
1545:         ENDWITH
1546:     ENDPROC
1547: 
1548:     *==========================================================================
1549:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1550:     *==========================================================================
1551:         LOCAL loc_i, loc_oControl
1552:         FOR loc_i = 1 TO par_oContainer.ControlCount
1553:             loc_oControl = par_oContainer.Controls(loc_i)
1554:             IF INLIST(UPPER(loc_oControl.Name), "IMG_4C_PRODUTO", "CNT_4C_CABECALHO")
1555:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1556:                     THIS.TornarControlesVisiveis(loc_oControl)
1557:                 ENDIF
1558:                 LOOP
1559:             ENDIF

*-- Linhas 1620 a 1638:
1620:         TRY
1621:             *-- Zera cursor de produtos (grid principal)
1622:             IF USED("cursor_4c_Produtos")
1623:                 SELECT cursor_4c_Produtos
1624:                 ZAP
1625:             ENDIF
1626: 
1627:             *-- Limpa filtros (textboxes de sele" + CHR(231) + CHR(227) + "o)
1628:             THIS.txt_4c_CFornecs.Value = ""
1629:             THIS.txt_4c_DFornecs.Value = ""
1630:             THIS.txt_4c_MercI.Value    = ""
1631:             THIS.txt_4c_MercF.Value    = ""
1632:             THIS.txt_4c_CGrui.Value    = ""
1633:             THIS.txt_4c_CGruf.Value    = ""
1634:             THIS.txt_4c_SgruI.Value    = ""
1635:             THIS.txt_4c_SgruF.Value    = ""
1636:             THIS.txt_4c_CUnii.Value    = ""
1637:             THIS.txt_4c_CUnif.Value    = ""
1638:             THIS.txt_4c_Lini.Value     = ""

*-- Linhas 1700 a 1718:
1700:                 CASE loc_nPagina = 2
1701:                     *-- Modo DADOS/GRID: foco no grid apos processamento
1702:                     IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1703:                         SELECT cursor_4c_Produtos
1704:                         SET ORDER TO CPros
1705:                         GO TOP
1706:                         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1707:                         THIS.cmd_4c_Imprimir.Enabled          = .T.
1708:                         THIS.grd_4c_Produto.SetFocus()
1709:                     ELSE
1710:                         MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
1711:                         THIS.txt_4c_CFornecs.SetFocus()
1712:                     ENDIF
1713:                 OTHERWISE
1714:                     THIS.ConfigurarPaginaLista()
1715:             ENDCASE
1716: 
1717:             THIS.Refresh()
1718:         CATCH TO loc_oErro

*-- Linhas 1795 a 1813:
1795:                 RETURN
1796:             ENDIF
1797: 
1798:             SELECT cursor_4c_Produtos
1799:             IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1800:                 MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
1801:                 THIS.grd_4c_Produto.SetFocus()
1802:                 RETURN
1803:             ENDIF
1804: 
1805:             *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
1806:             THIS.GrdAfterRowColChange(1)
1807:             THIS.img_4c_Produto.Visible = .T.
1808:             THIS.img_4c_Produto.Refresh()
1809:         CATCH TO loc_oErro
1810:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1811:                     "Erro BtnVisualizarClick")
1812:         ENDTRY
1813:     ENDPROC

*-- Linhas 1827 a 1872:
1827:                 RETURN
1828:             ENDIF
1829: 
1830:             SELECT cursor_4c_Produtos
1831:             COUNT FOR lMarca = 1 TO loc_nMarcados
1832: 
1833:             IF loc_nMarcados > 0
1834:                 IF !MsgConfirma("Remover " + TRANSFORM(loc_nMarcados) + ;
1835:                                 " produto(s) marcado(s) do rec" + CHR(225) + ;
1836:                                 "lculo?", ;
1837:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1838:                     RETURN
1839:                 ENDIF
1840:                 SELECT cursor_4c_Produtos
1841:                 DELETE FOR lMarca = 1
1842:                 PACK
1843:             ELSE
1844:                 IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1845:                     MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
1846:                              "Aviso")
1847:                     THIS.grd_4c_Produto.SetFocus()
1848:                     RETURN
1849:                 ENDIF
1850:                 loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1851:                 IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
1852:                                 " do rec" + CHR(225) + "lculo?", ;
1853:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1854:                     RETURN
1855:                 ENDIF
1856:                 SELECT cursor_4c_Produtos
1857:                 DELETE
1858:                 PACK
1859:             ENDIF
1860: 
1861:             *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
1862:             IF RECCOUNT("cursor_4c_Produtos") = 0
1863:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1864:                 THIS.cmd_4c_Imprimir.Enabled          = .F.
1865:                 THIS.img_4c_Produto.Visible           = .F.
1866:                 THIS.img_4c_Produto.Picture           = ""
1867:             ENDIF
1868: 
1869:             THIS.grd_4c_Produto.Refresh()
1870:         CATCH TO loc_oErro
1871:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1872:                     "Erro BtnExcluirClick")

*-- Linhas 1890 a 1913:
1890: 
1891:             IF THIS.this_oBusinessObject.Processar()
1892:                 loc_nVaria = THIS.txt_4c_Variacao.Value
1893:                 SELECT cursor_4c_Produtos
1894:                 IF loc_nVaria > 0
1895:                     DELETE FOR PVarias < loc_nVaria
1896:                 ENDIF
1897:                 IF loc_nVaria < 0
1898:                     DELETE FOR PVarias > loc_nVaria
1899:                 ENDIF
1900:                 SET ORDER TO CPros
1901:                 GO TOP
1902:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1903:                 THIS.cmg_4c_Botoes.Buttons(2).Refresh()
1904:                 THIS.cmd_4c_Imprimir.Enabled = .T.
1905:                 THIS.cmd_4c_Imprimir.Refresh()
1906:                 THIS.ReconfigurarGrade()
1907:                 THIS.grd_4c_Produto.Column1.SetFocus()
1908:                 THIS.grd_4c_Produto.Refresh()
1909:                 loc_lSucesso = .T.
1910:             ENDIF
1911:         CATCH TO loc_oErro
1912:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
1913:         ENDTRY

*-- Linhas 1958 a 2011:
1958:     *==========================================================================
1959:         LOCAL loc_oErro
1960:         TRY
1961:             UPDATE cursor_4c_Produtos SET lMarca = 1
1962:             THIS.grd_4c_Produto.Refresh()
1963:         CATCH TO loc_oErro
1964:             MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
1965:         ENDTRY
1966:     ENDPROC
1967: 
1968:     *==========================================================================
1969:     PROCEDURE BtnDesmarcarClick()
1970:     *==========================================================================
1971:         LOCAL loc_oErro
1972:         TRY
1973:             UPDATE cursor_4c_Produtos SET lMarca = 0
1974:             THIS.grd_4c_Produto.Refresh()
1975:         CATCH TO loc_oErro
1976:             MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
1977:         ENDTRY
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1982:     *==========================================================================
1983:         LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
1984:         TRY
1985:             IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1986:                 RETURN
1987:             ENDIF
1988:             loc_cArquivo = SYS(2023) + "\TempCj.jpg"
1989:             SELECT cursor_4c_Produtos
1990:             loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1991:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
1992:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFig") < 1
1993:                 THIS.img_4c_Produto.Visible = .F.
1994:                 RETURN
1995:             ENDIF
1996:             SELECT cursor_4c_TmpFig
1997:             THIS.img_4c_Produto.Visible  = .F.
1998:             THIS.img_4c_Produto.Picture  = ""
1999:             IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
2000:                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_TmpFig.FigJpgs, ;
2001:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
2002:                     "data:image/jpg;base64,", ""), 14)
2003:                 STRTOFILE(loc_cFoto, loc_cArquivo)
2004:                 THIS.img_4c_Produto.Picture = loc_cArquivo
2005:                 THIS.img_4c_Produto.Visible = .T.
2006:             ENDIF
2007:             IF USED("cursor_4c_TmpFig")
2008:                 USE IN cursor_4c_TmpFig
2009:             ENDIF
2010:         CATCH TO loc_oErro
2011:             IF USED("cursor_4c_TmpFig")

*-- Linhas 2027 a 2047:
2027:                 THIS.txt_4c_DFornecs.Value = ""
2028:                 RETURN
2029:             ENDIF
2030:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2031:                        EscaparSQL(loc_cVal), "cursor_4c_TmpFor") > 0
2032:                 SELECT cursor_4c_TmpFor
2033:                 IF !EOF("cursor_4c_TmpFor")
2034:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_TmpFor.IClis)
2035:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_TmpFor.RClis)
2036:                     USE IN cursor_4c_TmpFor
2037:                     RETURN
2038:                 ENDIF
2039:                 USE IN cursor_4c_TmpFor
2040:             ENDIF
2041:             THIS.AbrirBuscaFornecedor()
2042:         CATCH TO loc_oErro
2043:             IF USED("cursor_4c_TmpFor")
2044:                 USE IN cursor_4c_TmpFor
2045:             ENDIF
2046:             MsgErro(loc_oErro.Message, "Erro TxtCFornecKeyPress")
2047:         ENDTRY

*-- Linhas 2089 a 2109:
2089:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercI.Value))
2090:                 RETURN
2091:             ENDIF
2092:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2093:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercI.Value)), "cursor_4c_TmpGGr") > 0
2094:                 SELECT cursor_4c_TmpGGr
2095:                 IF !EOF("cursor_4c_TmpGGr")
2096:                     THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2097:                     USE IN cursor_4c_TmpGGr
2098:                     RETURN
2099:                 ENDIF
2100:                 USE IN cursor_4c_TmpGGr
2101:             ENDIF
2102:             THIS.AbrirBuscaGrandeGrupo(.T.)
2103:         CATCH TO loc_oErro
2104:             IF USED("cursor_4c_TmpGGr")
2105:                 USE IN cursor_4c_TmpGGr
2106:             ENDIF
2107:             MsgErro(loc_oErro.Message, "Erro TxtMercIKeyPress")
2108:         ENDTRY
2109:     ENDPROC

*-- Linhas 2117 a 2137:
2117:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercF.Value))
2118:                 RETURN
2119:             ENDIF
2120:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2121:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercF.Value)), "cursor_4c_TmpGGr") > 0
2122:                 SELECT cursor_4c_TmpGGr
2123:                 IF !EOF("cursor_4c_TmpGGr")
2124:                     THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2125:                     USE IN cursor_4c_TmpGGr
2126:                     RETURN
2127:                 ENDIF
2128:                 USE IN cursor_4c_TmpGGr
2129:             ENDIF
2130:             THIS.AbrirBuscaGrandeGrupo(.F.)
2131:         CATCH TO loc_oErro
2132:             IF USED("cursor_4c_TmpGGr")
2133:                 USE IN cursor_4c_TmpGGr
2134:             ENDIF
2135:             MsgErro(loc_oErro.Message, "Erro TxtMercFKeyPress")
2136:         ENDTRY
2137:     ENDPROC

*-- Linhas 2181 a 2201:
2181:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGrui.Value))
2182:                 RETURN
2183:             ENDIF
2184:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2185:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGrui.Value)), "cursor_4c_TmpGrp") > 0
2186:                 SELECT cursor_4c_TmpGrp
2187:                 IF !EOF("cursor_4c_TmpGrp")
2188:                     THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2189:                     USE IN cursor_4c_TmpGrp
2190:                     RETURN
2191:                 ENDIF
2192:                 USE IN cursor_4c_TmpGrp
2193:             ENDIF
2194:             THIS.AbrirBuscaGrupo(.T.)
2195:         CATCH TO loc_oErro
2196:             IF USED("cursor_4c_TmpGrp")
2197:                 USE IN cursor_4c_TmpGrp
2198:             ENDIF
2199:             MsgErro(loc_oErro.Message, "Erro TxtCGruiKeyPress")
2200:         ENDTRY
2201:     ENDPROC

*-- Linhas 2209 a 2229:
2209:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGruf.Value))
2210:                 RETURN
2211:             ENDIF
2212:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2213:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGruf.Value)), "cursor_4c_TmpGrp") > 0
2214:                 SELECT cursor_4c_TmpGrp
2215:                 IF !EOF("cursor_4c_TmpGrp")
2216:                     THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2217:                     USE IN cursor_4c_TmpGrp
2218:                     RETURN
2219:                 ENDIF
2220:                 USE IN cursor_4c_TmpGrp
2221:             ENDIF
2222:             THIS.AbrirBuscaGrupo(.F.)
2223:         CATCH TO loc_oErro
2224:             IF USED("cursor_4c_TmpGrp")
2225:                 USE IN cursor_4c_TmpGrp
2226:             ENDIF
2227:             MsgErro(loc_oErro.Message, "Erro TxtCGrufKeyPress")
2228:         ENDTRY
2229:     ENDPROC

*-- Linhas 2273 a 2293:
2273:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruI.Value))
2274:                 RETURN
2275:             ENDIF
2276:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2277:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruI.Value)), "cursor_4c_TmpSgr") > 0
2278:                 SELECT cursor_4c_TmpSgr
2279:                 IF !EOF("cursor_4c_TmpSgr")
2280:                     THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2281:                     USE IN cursor_4c_TmpSgr
2282:                     RETURN
2283:                 ENDIF
2284:                 USE IN cursor_4c_TmpSgr
2285:             ENDIF
2286:             THIS.AbrirBuscaSubgrupo(.T.)
2287:         CATCH TO loc_oErro
2288:             IF USED("cursor_4c_TmpSgr")
2289:                 USE IN cursor_4c_TmpSgr
2290:             ENDIF
2291:             MsgErro(loc_oErro.Message, "Erro TxtSgruIKeyPress")
2292:         ENDTRY
2293:     ENDPROC

*-- Linhas 2301 a 2321:
2301:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruF.Value))
2302:                 RETURN
2303:             ENDIF
2304:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2305:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruF.Value)), "cursor_4c_TmpSgr") > 0
2306:                 SELECT cursor_4c_TmpSgr
2307:                 IF !EOF("cursor_4c_TmpSgr")
2308:                     THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2309:                     USE IN cursor_4c_TmpSgr
2310:                     RETURN
2311:                 ENDIF
2312:                 USE IN cursor_4c_TmpSgr
2313:             ENDIF
2314:             THIS.AbrirBuscaSubgrupo(.F.)
2315:         CATCH TO loc_oErro
2316:             IF USED("cursor_4c_TmpSgr")
2317:                 USE IN cursor_4c_TmpSgr
2318:             ENDIF
2319:             MsgErro(loc_oErro.Message, "Erro TxtSgruFKeyPress")
2320:         ENDTRY
2321:     ENDPROC

*-- Linhas 2365 a 2385:
2365:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnii.Value))
2366:                 RETURN
2367:             ENDIF
2368:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2369:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnii.Value)), "cursor_4c_TmpUni") > 0
2370:                 SELECT cursor_4c_TmpUni
2371:                 IF !EOF("cursor_4c_TmpUni")
2372:                     THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2373:                     USE IN cursor_4c_TmpUni
2374:                     RETURN
2375:                 ENDIF
2376:                 USE IN cursor_4c_TmpUni
2377:             ENDIF
2378:             THIS.AbrirBuscaUnidade(.T.)
2379:         CATCH TO loc_oErro
2380:             IF USED("cursor_4c_TmpUni")
2381:                 USE IN cursor_4c_TmpUni
2382:             ENDIF
2383:             MsgErro(loc_oErro.Message, "Erro TxtCUniiKeyPress")
2384:         ENDTRY
2385:     ENDPROC

*-- Linhas 2393 a 2413:
2393:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnif.Value))
2394:                 RETURN
2395:             ENDIF
2396:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2397:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnif.Value)), "cursor_4c_TmpUni") > 0
2398:                 SELECT cursor_4c_TmpUni
2399:                 IF !EOF("cursor_4c_TmpUni")
2400:                     THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2401:                     USE IN cursor_4c_TmpUni
2402:                     RETURN
2403:                 ENDIF
2404:                 USE IN cursor_4c_TmpUni
2405:             ENDIF
2406:             THIS.AbrirBuscaUnidade(.F.)
2407:         CATCH TO loc_oErro
2408:             IF USED("cursor_4c_TmpUni")
2409:                 USE IN cursor_4c_TmpUni
2410:             ENDIF
2411:             MsgErro(loc_oErro.Message, "Erro TxtCUnifKeyPress")
2412:         ENDTRY
2413:     ENDPROC

*-- Linhas 2457 a 2477:
2457:             IF EMPTY(ALLTRIM(THIS.txt_4c_Lini.Value))
2458:                 RETURN
2459:             ENDIF
2460:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2461:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Lini.Value)), "cursor_4c_TmpLin") > 0
2462:                 SELECT cursor_4c_TmpLin
2463:                 IF !EOF("cursor_4c_TmpLin")
2464:                     THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2465:                     USE IN cursor_4c_TmpLin
2466:                     RETURN
2467:                 ENDIF
2468:                 USE IN cursor_4c_TmpLin
2469:             ENDIF
2470:             THIS.AbrirBuscaLinha(.T.)
2471:         CATCH TO loc_oErro
2472:             IF USED("cursor_4c_TmpLin")
2473:                 USE IN cursor_4c_TmpLin
2474:             ENDIF
2475:             MsgErro(loc_oErro.Message, "Erro TxtLiniKeyPress")
2476:         ENDTRY
2477:     ENDPROC

*-- Linhas 2485 a 2505:
2485:             IF EMPTY(ALLTRIM(THIS.txt_4c_Linf.Value))
2486:                 RETURN
2487:             ENDIF
2488:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2489:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Linf.Value)), "cursor_4c_TmpLin") > 0
2490:                 SELECT cursor_4c_TmpLin
2491:                 IF !EOF("cursor_4c_TmpLin")
2492:                     THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2493:                     USE IN cursor_4c_TmpLin
2494:                     RETURN
2495:                 ENDIF
2496:                 USE IN cursor_4c_TmpLin
2497:             ENDIF
2498:             THIS.AbrirBuscaLinha(.F.)
2499:         CATCH TO loc_oErro
2500:             IF USED("cursor_4c_TmpLin")
2501:                 USE IN cursor_4c_TmpLin
2502:             ENDIF
2503:             MsgErro(loc_oErro.Message, "Erro TxtLinfKeyPress")
2504:         ENDTRY
2505:     ENDPROC

*-- Linhas 2549 a 2569:
2549:             IF EMPTY(ALLTRIM(THIS.txt_4c_Coli.Value))
2550:                 RETURN
2551:             ENDIF
2552:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2553:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Coli.Value)), "cursor_4c_TmpCol") > 0
2554:                 SELECT cursor_4c_TmpCol
2555:                 IF !EOF("cursor_4c_TmpCol")
2556:                     THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2557:                     USE IN cursor_4c_TmpCol
2558:                     RETURN
2559:                 ENDIF
2560:                 USE IN cursor_4c_TmpCol
2561:             ENDIF
2562:             THIS.AbrirBuscaColecao(.T.)
2563:         CATCH TO loc_oErro
2564:             IF USED("cursor_4c_TmpCol")
2565:                 USE IN cursor_4c_TmpCol
2566:             ENDIF
2567:             MsgErro(loc_oErro.Message, "Erro TxtColiKeyPress")
2568:         ENDTRY
2569:     ENDPROC

*-- Linhas 2577 a 2597:
2577:             IF EMPTY(ALLTRIM(THIS.txt_4c_Colf.Value))
2578:                 RETURN
2579:             ENDIF
2580:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2581:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Colf.Value)), "cursor_4c_TmpCol") > 0
2582:                 SELECT cursor_4c_TmpCol
2583:                 IF !EOF("cursor_4c_TmpCol")
2584:                     THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2585:                     USE IN cursor_4c_TmpCol
2586:                     RETURN
2587:                 ENDIF
2588:                 USE IN cursor_4c_TmpCol
2589:             ENDIF
2590:             THIS.AbrirBuscaColecao(.F.)
2591:         CATCH TO loc_oErro
2592:             IF USED("cursor_4c_TmpCol")
2593:                 USE IN cursor_4c_TmpCol
2594:             ENDIF
2595:             MsgErro(loc_oErro.Message, "Erro TxtColfKeyPress")
2596:         ENDTRY
2597:     ENDPROC

*-- Linhas 2641 a 2661:
2641:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedai.Value))
2642:                 RETURN
2643:             ENDIF
2644:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2645:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedai.Value)), "cursor_4c_TmpMoe") > 0
2646:                 SELECT cursor_4c_TmpMoe
2647:                 IF !EOF("cursor_4c_TmpMoe")
2648:                     THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2649:                     USE IN cursor_4c_TmpMoe
2650:                     RETURN
2651:                 ENDIF
2652:                 USE IN cursor_4c_TmpMoe
2653:             ENDIF
2654:             THIS.AbrirBuscaMoeda(.T.)
2655:         CATCH TO loc_oErro
2656:             IF USED("cursor_4c_TmpMoe")
2657:                 USE IN cursor_4c_TmpMoe
2658:             ENDIF
2659:             MsgErro(loc_oErro.Message, "Erro TxtMoedaiKeyPress")
2660:         ENDTRY
2661:     ENDPROC

*-- Linhas 2669 a 2689:
2669:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedaf.Value))
2670:                 RETURN
2671:             ENDIF
2672:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2673:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedaf.Value)), "cursor_4c_TmpMoe") > 0
2674:                 SELECT cursor_4c_TmpMoe
2675:                 IF !EOF("cursor_4c_TmpMoe")
2676:                     THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2677:                     USE IN cursor_4c_TmpMoe
2678:                     RETURN
2679:                 ENDIF
2680:                 USE IN cursor_4c_TmpMoe
2681:             ENDIF
2682:             THIS.AbrirBuscaMoeda(.F.)
2683:         CATCH TO loc_oErro
2684:             IF USED("cursor_4c_TmpMoe")
2685:                 USE IN cursor_4c_TmpMoe
2686:             ENDIF
2687:             MsgErro(loc_oErro.Message, "Erro TxtMoedafKeyPress")
2688:         ENDTRY
2689:     ENDPROC

*-- Linhas 2733 a 2753:
2733:             IF EMPTY(ALLTRIM(THIS.txt_4c_Feitio.Value))
2734:                 RETURN
2735:             ENDIF
2736:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2737:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Feitio.Value)), "cursor_4c_TmpFti") > 0
2738:                 SELECT cursor_4c_TmpFti
2739:                 IF !EOF("cursor_4c_TmpFti")
2740:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_TmpFti.Cods)
2741:                     USE IN cursor_4c_TmpFti
2742:                     RETURN
2743:                 ENDIF
2744:                 USE IN cursor_4c_TmpFti
2745:             ENDIF
2746:             THIS.AbrirBuscaFeitio()
2747:         CATCH TO loc_oErro
2748:             IF USED("cursor_4c_TmpFti")
2749:                 USE IN cursor_4c_TmpFti
2750:             ENDIF
2751:             MsgErro(loc_oErro.Message, "Erro TxtFeitioKeyPress")
2752:         ENDTRY
2753:     ENDPROC

*-- Linhas 2793 a 2813:
2793:             IF EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
2794:                 RETURN
2795:             ENDIF
2796:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2797:                        EscaparSQL(ALLTRIM(THIS.txt_4c_NewMkp.Value)) + " AND Tipos = 1", "cursor_4c_TmpNMkp") > 0
2798:                 SELECT cursor_4c_TmpNMkp
2799:                 IF !EOF("cursor_4c_TmpNMkp")
2800:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_TmpNMkp.Cods)
2801:                     USE IN cursor_4c_TmpNMkp
2802:                     RETURN
2803:                 ENDIF
2804:                 USE IN cursor_4c_TmpNMkp
2805:             ENDIF
2806:             THIS.AbrirBuscaNewMkp()
2807:         CATCH TO loc_oErro
2808:             IF USED("cursor_4c_TmpNMkp")
2809:                 USE IN cursor_4c_TmpNMkp
2810:             ENDIF
2811:             MsgErro(loc_oErro.Message, "Erro TxtNewMkpKeyPress")
2812:         ENDTRY
2813:     ENDPROC

*-- Linhas 2971 a 3000:
2971:         loc_lSucesso = .F.
2972:         TRY
2973:             IF USED("cursor_4c_Produtos")
2974:                 SELECT cursor_4c_Produtos
2975:                 ZAP
2976:             ENDIF
2977:             THIS.FormParaBO()
2978:             IF THIS.this_oBusinessObject.Processar()
2979:                 loc_nVaria = THIS.txt_4c_Variacao.Value
2980:                 SELECT cursor_4c_Produtos
2981:                 IF loc_nVaria > 0
2982:                     DELETE FOR PVarias < loc_nVaria
2983:                 ENDIF
2984:                 IF loc_nVaria < 0
2985:                     DELETE FOR PVarias > loc_nVaria
2986:                 ENDIF
2987:                 SET ORDER TO CPros
2988:                 GO TOP
2989:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
2990:                 THIS.cmd_4c_Imprimir.Enabled          = .T.
2991:                 THIS.ReconfigurarGrade()
2992:                 THIS.grd_4c_Produto.Refresh()
2993:                 loc_lSucesso = .T.
2994:             ENDIF
2995:         CATCH TO loc_oErro
2996:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
2997:                 "Erro CarregarLista")
2998:         ENDTRY
2999:         RETURN loc_lSucesso
3000:     ENDPROC

