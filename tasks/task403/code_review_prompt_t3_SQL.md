# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CRSIGCDM' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, PCEXTERNO, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MARCAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, PCEXTERNO, ICLIS, EXISTES, PCESCOLHA, GESIND

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
  ControlSource = "crSigCdMin.Retiras"
Select CrSigCdMin
	.Column1.ControlSource = 'CrSigCdMin.emps'
	.Column2.ControlSource = 'CrSigCdMin.qmins'
	.Column3.ControlSource = 'CrSigCdMin.codtams'
	.Column4.ControlSource = 'CrSigCdMin.codcores'
	.Column5.ControlSource = 'CrSigCdMin.grupos'
	.Column6.ControlSource = 'CrSigCdMin.contas'
	.Column7.ControlSource = 'CrSigCdMin.Locals'
	.Column8.ControlSource = 'CrSigCdMin.qideal'
Insert Into CrSigCdMin (cpros,cidchaves) Values (ThisForm.Pagina.Dados.Get_Produto.Value,fUniqueIds())
Select CrSigCdMin
Select crSigCdMin
	lStrQuery = [Select b.cores,b.tams,b.tipoestos From SigCdPro a, SigCdGrp b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpProGru') < 1
	Select TmpProGru
lcQProds  = [Select a.cpros,b.dpros,b.ifors,b.reffs,b.sgrus ]+;
			[From SigCdMin a ]+;
			[Inner Join SigCdPro b On b.cpros = a.cpros ]+;
lcQPrEmp  = [Select a.*,b.dpros,b.ifors,b.reffs,b.cgrus,b.situas,c.rclis,g.dgrus ]+;
			[From SigCdMin a, SigCdPro b ]+;
			[Left Join SigCdCli c On b.ifors = c.iclis ]+;
			[Left Join SigCdGrp g On b.cgrus = g.cgrus ]+;
lcQCopia  = [Select 1 As marcas,0 As existes,a.cpros,a.emps,a.locals,a.qmins,a.qideal,a.codtams,a.codcores,a.cidchaves,a.grupos,a.contas ]+;
			[From SigCdMin a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMin b ]+;
			[Select 0 As marcas,1 As existes,a.cpros,a.emps,a.locals,a.qmins,a.qideal,a.codtams,a.codcores,a.cidchaves,a.grupos,a.contas ]+;
			[From SigCdMin a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMin b ]+;
			[Select 0 As marcas,2 As existes,a.cpros,a.emps,a.locals,a.qmins,a.qideal,a.codtams,a.codcores,a.cidchaves,a.grupos,a.contas ]+;
			[From SigCdMin a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMin b ]+;
If ThisForm.poDataMgr.SqlExecute([Select gesind From SigCdPam ],'CrSigCdPam') < 1
ThisForm.poDataMgr.Update('CrSigCdMin')
Select CrSigCdMin
Delete From CrSigCdMin
Delete From CrSigCdMin
ThisForm.poDataMgr.Update('CrSigCdMin')
ThisForm.poDataMgr.Update('CrSigCdMin')
Select CrProdutos
Select Distinct cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,qmins,qideal,situas ;
  From CrSigCdMin ;
	Insert Into CsCabec (cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,qmins,qideal,situas) ;
Select CrSigCdMin
	lStrQuery = [Select rclis From SigCdCli Where iclis = ']+ThisForm.pcIFors+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpIFors') < 1
	lStrQuery = [Select Dgrus From SigCdGrp Where CGrus = ']+ThisForm.pcCGrus+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpCGrus') < 1
	Select CrSigCdMin
	Insert Into CrSigCdMin (cpros,cidchaves) Values (ThisForm.pcCPros,fUniqueIds())
	Select CrSigCdMin
	Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
		Select CrSigCdMin
	Select CrSigCdMin
			Delete
	Select CrSigCdMin
		Insert Into CrSigCdMin (cpros,cidchaves) Values (Thisform.pagina.dados.get_Produto.Value,fUniqueIds())
		Select CrSigCdMin
		Select CrSigCdMin
			Select Cpros, Emps, Grupos, Contas, CodCores, CodTams ;
			  From CrSigCdMin ;
		If ThisForm.poDataMgr.SqlExecute([Select nEstMins From SigCdPac],'CrSigCdPac') < 1
			Select CrSigCdMin
Select CsCopia
		Insert Into CrSigCdMin (cpros,emps,locals,qmins,qideal,codtams,codcores,cidchaves,contas,grupos) ;
ThisForm.poDataMgr.Update('CrSigCdMin')
	Select CsCopia
	Select CsCopia
		.Column1.ControlSource = 'CsCopia.marcas'
		.Column2.ControlSource = 'CsCopia.cpros'
		.Column3.ControlSource = 'CsCopia.qmins'
		.Column4.ControlSource = 'CsCopia.codtams'
		.Column5.ControlSource = 'CsCopia.codcores'
		.Column6.ControlSource = 'CsCopia.qideal'		
Select CsCopia
Update CsCopia Set Marcas = 1 Where existes = 0
Select CsCopia
Update CsCopia Set Marcas = 0 Where existes = 0
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMin
		Insert Into CrSigCdMin (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMin
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
Select CrSigCdMin
Delete From CrSigCdMin Where emps = lcEmps
Select CrSigCdMin
	Insert Into CrSigCdMin (cpros,cidchaves) Values (This.Parent.Get_Produto.Value,fUniqueIds())
Select CrSigCdMin
	Select CrSigCdMin
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMin
		Insert Into CrSigCdMin (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMin
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormEmn.prg) - TRECHOS RELEVANTES PARA PASS SQL (2315 linhas total):

*-- Linhas 355 a 380:
355:             .GridLines         = 3
356:             .RowHeight         = 16
357:             .HeaderHeight      = 20
358:             .DeleteMark        = .F.
359:             .RecordMark        = .F.
360:             .ScrollBars        = 2
361:             .HighlightStyle    = 2
362:             .HighlightBackColor = RGB(15, 41, 104)
363:             .HighlightForeColor = RGB(255, 255, 255)
364:             .ReadOnly          = .T.
365:             .AllowCellSelection = .F.
366:             .AllowHeaderSizing = .F.
367:             .ColumnCount       = 5
368:             .Visible           = .T.
369:         ENDWITH
370: 
371:         BINDEVENT(par_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnAlterarClick")
372: 
373:         THIS.TornarControlesVisiveis(par_oPagina)
374:     ENDPROC
375: 
376:     *==========================================================================
377:     * CarregarLista - Carrega registros na grid da Page1 (cursor CrProdutos)
378:     *==========================================================================
379:     PROCEDURE CarregarLista()
380:         LOCAL loc_lResultado, loc_oGrid

*-- Linhas 395 a 445:
395:                         *-- Configurar RecordSource + colunas
396:                         loc_oGrid.RecordSource = "CrProdutos"
397: 
398:                         loc_oGrid.Column1.ControlSource   = "CrProdutos.cpros"
399:                         loc_oGrid.Column1.Width           = 100
400:                         loc_oGrid.Column1.Header1.Caption = ""
401:                         loc_oGrid.Column1.Header1.Alignment = 2
402:                         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
403:                         loc_oGrid.Column1.Header1.FontSize  = 8
404:                         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
405: 
406:                         loc_oGrid.Column2.ControlSource   = "CrProdutos.dpros"
407:                         loc_oGrid.Column2.Width           = 430
408:                         loc_oGrid.Column2.Header1.Caption = "Produto"
409:                         loc_oGrid.Column2.Header1.Alignment = 2
410:                         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
411:                         loc_oGrid.Column2.Header1.FontSize  = 8
412:                         loc_oGrid.Column2.Header1.ForeColor = RGB(90, 90, 90)
413: 
414:                         loc_oGrid.Column3.ControlSource   = "CrProdutos.ifors"
415:                         loc_oGrid.Column3.Width           = 100
416:                         loc_oGrid.Column3.Header1.Caption = ""
417:                         loc_oGrid.Column3.Header1.Alignment = 2
418:                         loc_oGrid.Column3.Header1.FontName  = "Tahoma"
419:                         loc_oGrid.Column3.Header1.FontSize  = 8
420:                         loc_oGrid.Column3.Header1.ForeColor = RGB(90, 90, 90)
421: 
422:                         loc_oGrid.Column4.ControlSource   = "CrProdutos.reffs"
423:                         loc_oGrid.Column4.Width           = 150
424:                         loc_oGrid.Column4.Header1.Caption = ""
425:                         loc_oGrid.Column4.Header1.Alignment = 2
426:                         loc_oGrid.Column4.Header1.FontName  = "Tahoma"
427:                         loc_oGrid.Column4.Header1.FontSize  = 8
428:                         loc_oGrid.Column4.Header1.ForeColor = RGB(90, 90, 90)
429: 
430:                         loc_oGrid.Column5.ControlSource   = "CrProdutos.sgrus"
431:                         loc_oGrid.Column5.Width           = 140
432:                         loc_oGrid.Column5.Header1.Caption = ""
433:                         loc_oGrid.Column5.Header1.Alignment = 2
434:                         loc_oGrid.Column5.Header1.FontName  = "Tahoma"
435:                         loc_oGrid.Column5.Header1.FontSize  = 8
436:                         loc_oGrid.Column5.Header1.ForeColor = RGB(90, 90, 90)
437: 
438:                         THIS.FormatarGridLista(loc_oGrid)
439:                         loc_oGrid.Refresh()
440: 
441:                         loc_lResultado = .T.
442:                     ENDIF
443:                 ENDIF
444:             ENDIF
445:         CATCH TO loc_oErro

*-- Linhas 516 a 534:
516:             ENDIF
517: 
518:             IF loc_lProsseguir
519:                 SELECT CrProdutos
520:                 loc_cCPros = ALLTRIM(CrProdutos.cpros)
521:                 IF EMPTY(loc_cCPros)
522:                     MsgAviso("Produto inv" + CHR(225) + "lido.", "Visualizar")
523:                     loc_lProsseguir = .F.
524:                 ENDIF
525:             ENDIF
526: 
527:             IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
528:                 loc_lProsseguir = .F.
529:             ENDIF
530: 
531:             IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
532:                 MsgErro("Falha ao carregar produto " + loc_cCPros, "Visualizar")
533:                 loc_lProsseguir = .F.
534:             ENDIF

*-- Linhas 566 a 584:
566:             ENDIF
567: 
568:             IF loc_lProsseguir
569:                 SELECT CrProdutos
570:                 loc_cCPros = ALLTRIM(CrProdutos.cpros)
571:                 IF EMPTY(loc_cCPros)
572:                     MsgAviso("Produto inv" + CHR(225) + "lido.", "Alterar")
573:                     loc_lProsseguir = .F.
574:                 ENDIF
575:             ENDIF
576: 
577:             IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
578:                 loc_lProsseguir = .F.
579:             ENDIF
580: 
581:             IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
582:                 MsgErro("Falha ao carregar produto " + loc_cCPros, "Alterar")
583:                 loc_lProsseguir = .F.
584:             ENDIF

*-- Linhas 618 a 636:
618:             ENDIF
619: 
620:             IF loc_lProsseguir
621:                 SELECT CrProdutos
622:                 loc_cCPros = ALLTRIM(CrProdutos.cpros)
623:                 IF EMPTY(loc_cCPros)
624:                     MsgAviso("Produto inv" + CHR(225) + "lido.", "Excluir")
625:                     loc_lProsseguir = .F.
626:                 ENDIF
627:             ENDIF
628: 
629:             IF loc_lProsseguir
630:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto " + loc_cCPros + " ?", "Excluir")
631:                 IF !loc_lConfirma
632:                     loc_lProsseguir = .F.
633:                 ENDIF
634:             ENDIF
635: 
636:             IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"

*-- Linhas 1108 a 1140:
1108:             .GridLines          = 3
1109:             .RowHeight          = 18
1110:             .HeaderHeight       = 22
1111:             .DeleteMark         = .F.
1112:             .RecordMark         = .F.
1113:             .ScrollBars         = 3
1114:             .HighlightStyle     = 2
1115:             .HighlightBackColor = RGB(15, 41, 104)
1116:             .HighlightForeColor = RGB(255, 255, 255)
1117:             .AllowCellSelection = .T.
1118:             .AllowHeaderSizing  = .F.
1119:             .Visible            = .T.
1120:         ENDWITH
1121: 
1122:         *-- ColumnCount FORA do WITH (Problem 36 - cria Text1 imediatamente)
1123:         par_oPagina.grd_4c_GradeI.ColumnCount = 8
1124: 
1125:         *-- Configurar colunas (ControlSource sera setado em ConfigurarRecordSourceGrid)
1126:         WITH par_oPagina.grd_4c_GradeI
1127:             .Column1.Width            = 45
1128:             .Column1.Header1.Caption  = "Emp"
1129:             .Column1.Header1.Alignment = 2
1130:             .Column1.ReadOnly         = .F.
1131:             .Column1.Sparse           = .F.
1132: 
1133:             .Column2.Width            = 90
1134:             .Column2.Header1.Caption  = "Qtde. M" + CHR(237) + "nima"
1135:             .Column2.Header1.Alignment = 2
1136:             .Column2.ReadOnly         = .F.
1137:             .Column2.Sparse           = .F.
1138: 
1139:             .Column3.Width            = 70
1140:             .Column3.Header1.Caption  = "Tamanho"

*-- Linhas 1399 a 1418:
1399:                 MsgAviso("Informe o produto antes de salvar.", "Salvar")
1400:             ELSE
1401:                 IF USED("CrSigCdMin")
1402:                     SELECT CrSigCdMin
1403:                     SCAN FOR !DELETED()
1404:                         IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
1405:                             loc_lTemLinhas = .T.
1406:                             EXIT
1407:                         ENDIF
1408:                     ENDSCAN
1409:                 ENDIF
1410: 
1411:                 IF !loc_lTemLinhas
1412:                     MsgAviso("Inclua pelo menos um item na grade antes de salvar.", "Salvar")
1413:                 ELSE
1414:                     THIS.FormParaBO()
1415:                     IF THIS.this_oBusinessObject.Salvar()
1416:                         MsgInfo("Registros salvos com sucesso.", "Salvar")
1417:                         THIS.AlternarPagina(1)
1418:                     ENDIF

*-- Linhas 1544 a 1581:
1544:     ENDPROC
1545: 
1546:     *==========================================================================
1547:     * ConfigurarRecordSourceGrid - Vincula CrSigCdMin ao grid e seta ControlSources
1548:     * Deve ser chamado APOS qualquer mudanca no cursor (Problem 48)
1549:     *==========================================================================
1550:     PROTECTED PROCEDURE ConfigurarRecordSourceGrid()
1551:         TRY
1552:             LOCAL loc_oGrid, loc_oBO
1553:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
1554:             loc_oBO   = THIS.this_oBusinessObject
1555: 
1556:             loc_oGrid.RecordSource = "CrSigCdMin"
1557: 
1558:             *-- ControlSources APOS RecordSource (Problem 48 - RecordSource reseta bindings)
1559:             loc_oGrid.Column1.ControlSource = "CrSigCdMin.emps"
1560:             loc_oGrid.Column2.ControlSource = "CrSigCdMin.qmins"
1561:             loc_oGrid.Column3.ControlSource = "CrSigCdMin.codtams"
1562:             loc_oGrid.Column4.ControlSource = "CrSigCdMin.codcores"
1563:             loc_oGrid.Column5.ControlSource = "CrSigCdMin.grupos"
1564:             loc_oGrid.Column6.ControlSource = "CrSigCdMin.contas"
1565:             loc_oGrid.Column7.ControlSource = "CrSigCdMin.locals"
1566:             loc_oGrid.Column8.ControlSource = "CrSigCdMin.qideal"
1567: 
1568:             *-- Resetar headers (RecordSource pode ter limpo as captions)
1569:             loc_oGrid.Column1.Header1.Caption = "Emp"
1570:             loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(237) + "nima"
1571:             loc_oGrid.Column3.Header1.Caption = "Tamanho"
1572:             loc_oGrid.Column4.Header1.Caption = "Cor"
1573:             loc_oGrid.Column5.Header1.Caption = "Grupo"
1574:             loc_oGrid.Column6.Header1.Caption = "Conta"
1575:             loc_oGrid.Column7.Header1.Caption = "Local"
1576:             loc_oGrid.Column8.Header1.Caption = "Estoque Alvo"
1577: 
1578:             *-- Habilitar/desabilitar colunas Tamanho e Cor conforme flags do produto
1579:             loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
1580:             loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor
1581: 

*-- Linhas 1596 a 1624:
1596:             ENDIF
1597: 
1598:             SET NULL ON
1599:             CREATE CURSOR CrSigCdMin ( ;
1600:                 cpros    C(14), emps     C(3),   locals   C(10), ;
1601:                 qmins    N(8,2), codtams  C(4),   codcores C(4),  ;
1602:                 ordems   C(1),  cidchaves C(20),  contas   C(10), ;
1603:                 grupos   C(10), qideal   N(7,2),  retiras  N(1,0), ;
1604:                 pideal   N(7,3), pmins    N(7,3),  dpros    C(65), ;
1605:                 ifors    C(10), reffs    C(20),  cgrus    C(3),  ;
1606:                 situas   N(1,0), rclis    C(50),  dgrus    C(20))
1607:             SET NULL OFF
1608: 
1609:             INSERT INTO CrSigCdMin ;
1610:                 (cpros,      emps, locals, qmins, codtams, codcores, ;
1611:                  ordems,     cidchaves, contas, grupos, qideal, ;
1612:                  retiras,    pideal, pmins) ;
1613:                 VALUES ;
1614:                 (par_cCPros, "",   "",    0,     "",      "",       ;
1615:                  " ",        "",   "",    "",    0,       ;
1616:                  1,          0,    0)
1617: 
1618:             GO TOP IN CrSigCdMin
1619:         CATCH TO loc_oErro
1620:             SET NULL OFF
1621:             MsgErro(loc_oErro.Message, "FormEmn.CriarCursorGridVazio")
1622:         ENDTRY
1623:     ENDPROC
1624: 

*-- Linhas 1634 a 1694:
1634:             LOCAL loc_cCPros, loc_oGrid
1635:             loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)
1636: 
1637:             INSERT INTO CrSigCdMin ;
1638:                 (cpros,      emps, locals, qmins, codtams, codcores, ;
1639:                  ordems,     cidchaves, contas, grupos, qideal, ;
1640:                  retiras,    pideal, pmins) ;
1641:                 VALUES ;
1642:                 (loc_cCPros, "",   "",    0,     "",      "",       ;
1643:                  " ",        "",   "",    "",    0,       ;
1644:                  1,          0,    0)
1645: 
1646:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
1647:             SELECT CrSigCdMin
1648:             GO BOTTOM
1649:             loc_oGrid.Refresh()
1650:             loc_oGrid.ActivateCell(RECCOUNT("CrSigCdMin"), 1)
1651:         CATCH TO loc_oErro
1652:             MsgErro(loc_oErro.Message, "FormEmn.AdicionarLinhaGrid")
1653:         ENDTRY
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * CarregarDadosProduto - Popula cabecalho ao selecionar produto novo
1658:     *==========================================================================
1659:     PROTECTED PROCEDURE CarregarDadosProduto(par_cCPros)
1660:         IF EMPTY(ALLTRIM(par_cCPros))
1661:             RETURN
1662:         ENDIF
1663: 
1664:         LOCAL loc_cSQL, loc_nRes
1665:         loc_cSQL = ""
1666:         loc_nRes = 0
1667: 
1668:         TRY
1669:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1670:                 " b.rclis, g.dgrus" + ;
1671:                 " FROM SigCdPro a" + ;
1672:                 " LEFT JOIN SigCdCli b ON b.iclis = a.ifors" + ;
1673:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1674:                 " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))
1675: 
1676:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdDados")
1677: 
1678:             IF loc_nRes > 0 AND USED("cursor_4c_ProdDados") AND RECCOUNT("cursor_4c_ProdDados") > 0
1679:                 SELECT cursor_4c_ProdDados
1680:                 GO TOP
1681: 
1682:                 LOCAL loc_oPg2, loc_oBO, loc_nSituas
1683:                 loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1684:                 loc_oBO     = THIS.this_oBusinessObject
1685:                 loc_nSituas = TratarNulo(cursor_4c_ProdDados.situas, "N")
1686: 
1687:                 loc_oPg2.txt_4c_Produto.Value = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
1688:                 loc_oPg2.txt_4c_Dpro.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dpros, "C"))
1689:                 loc_oPg2.txt_4c_Cgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cgrus, "C"))
1690:                 loc_oPg2.txt_4c_Dgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dgrus, "C"))
1691:                 loc_oPg2.txt_4c_Ifor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.ifors, "C"))
1692:                 loc_oPg2.txt_4c_Dfor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.rclis, "C"))
1693:                 loc_oPg2.txt_4c_Refs.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.reffs, "C"))
1694:                 loc_oPg2.obj_4c_Opc_situacao.Value = IIF(loc_nSituas = 1, 1, 2)

*-- Linhas 2195 a 2214:
2195:                 LOCAL loc_lTemVazia
2196:                 loc_lTemVazia = .F.
2197: 
2198:                 SELECT CrSigCdMin
2199:                 SCAN FOR !DELETED()
2200:                     IF EMPTY(ALLTRIM(CrSigCdMin.emps))
2201:                         loc_lTemVazia = .T.
2202:                         EXIT
2203:                     ENDIF
2204:                 ENDSCAN
2205: 
2206:                 IF !loc_lTemVazia
2207:                     THIS.AdicionarLinhaGrid()
2208:                 ENDIF
2209:             ENDIF
2210:         CATCH TO loc_oErro
2211:             MsgErro(loc_oErro.Message, "FormEmn.LocalColLostFocus")
2212:         ENDTRY
2213:     ENDPROC
2214: 

*-- Linhas 2302 a 2315:
2302:             loc_lConfirma = MsgConfirma("Excluir esta linha da grade?", "Excluir Linha")
2303: 
2304:             IF loc_lConfirma
2305:                 SELECT CrSigCdMin
2306:                 DELETE
2307:                 PACK
2308:                 THIS.ConfigurarRecordSourceGrid()
2309:             ENDIF
2310:         CATCH TO loc_oErro
2311:             MsgErro(loc_oErro.Message, "FormEmn.BtnExcluirLinhaClick")
2312:         ENDTRY
2313:     ENDPROC
2314: 
2315: ENDDEFINE


### BO (C:\4c\projeto\app\classes\EmnBO.prg):
*==============================================================================
* EmnBO.prg - Business Object para Estoque Alvo (Minimo por Produto/Empresa)
* Tabela: SigCdMin
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS EmnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades do cabecalho do produto (SigCdPro + lookups)
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && Codigo do produto          char(14)
    this_cDPros     = ""    && Descricao do produto
    this_cCGrus     = ""    && Codigo do grupo do produto
    this_cDGrus     = ""    && Descricao do grupo do produto
    this_cIFors     = ""    && Codigo do fornecedor
    this_cRClis     = ""    && Razao social do fornecedor
    this_cReffs     = ""    && Referencia do fornecedor
    this_nQMins     = 0     && Quantidade minima geral   numeric(8,2)
    this_nSituas    = 1     && Situacao: 1=Ativo, 2=Inativo

    *--------------------------------------------------------------------------
    * Propriedades de um item do grid (linha de SigCdMin)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && Chave unica / PRIMARY KEY  char(20)
    this_cEmps      = ""    && Empresa                    char(3)
    this_cLocals    = ""    && Local                      char(10)
    this_nQMinsItem = 0     && Quantidade minima          numeric(8,2)
    this_cCodTams   = ""    && Codigo do tamanho          char(4)
    this_cCodCores  = ""    && Codigo da cor              char(4)
    this_cOrdems    = ""    && Ordem                      char(1)
    this_cContas    = ""    && Conta                      char(10)
    this_cGrupos    = ""    && Grupo                      char(10)
    this_nQIdeal    = 0     && Quantidade ideal            numeric(7,2)
    this_nRetiras   = 1     && Retiravel: 1=Sim, 2=Nao, 3=Produto  numeric(1,0)
    this_nPIdeal    = 0     && Preco ideal                numeric(7,3)
    this_nPMins     = 0     && Preco minimo               numeric(7,3)

    *--------------------------------------------------------------------------
    * Flags de produto (determinam habilitacao de colunas na grade)
    *--------------------------------------------------------------------------
    this_lTemCor    = .F.   && Produto tem variacoes de cor
    this_lTemTam    = .F.   && Produto tem variacoes de tamanho
    this_nTipoEstos = 0     && Tipo de estoque do grupo do produto

    *--------------------------------------------------------------------------
    * Controle de modo externo (form chamado por outro form)
    *--------------------------------------------------------------------------
    this_cProdutoExterno = ""   && Codigo do produto fixado externamente
    this_cModoExterno    = ""   && Modo de operacao externo (INSERIR/ALTERAR)

    *--------------------------------------------------------------------------
    * Cursor principal do grid (preserva nome legado para compatibilidade)
    *--------------------------------------------------------------------------
    this_cCursorGrid  = "CrSigCdMin"   && Cursor do grid de minimos por empresa
    this_cCursorLista = "CrProdutos"   && Cursor da lista de produtos (Page1)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico usando NEWID() do SQL Server
    *==========================================================================
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRes
        loc_cChave = ""

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36),NEWID()),'-',''),20) AS id", ;
                "cursor_4c_NewId")
            IF loc_nRes > 0 AND USED("cursor_4c_NewId") AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                GO TOP
                loc_cChave = ALLTRIM(cursor_4c_NewId.id)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.GerarChaveUnica")
        ENDTRY

        IF USED("cursor_4c_NewId")
            USE IN cursor_4c_NewId
        ENDIF

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(DTOS(DATE()) + STRTRAN(TRANSFORM(SECONDS()), ".", "") + SYS(2015), 20)
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor de SigCdMin
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor) AND RECCOUNT(par_cAliasCursor) > 0
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCPros     = TratarNulo(cpros,     "C")
                THIS.this_cEmps      = TratarNulo(emps,      "C")
                THIS.this_cLocals    = TratarNulo(locals,    "C")
                THIS.this_nQMinsItem = TratarNulo(qmins,     "N")
                THIS.this_cCodTams   = TratarNulo(codtams,   "C")
                THIS.this_cCodCores  = TratarNulo(codcores,  "C")
                THIS.this_cOrdems    = TratarNulo(ordems,    "C")
                THIS.this_cContas    = TratarNulo(contas,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nQIdeal    = TratarNulo(qideal,    "N")
                THIS.this_nRetiras   = TratarNulo(retiras,   "N")
                THIS.this_nPIdeal    = TratarNulo(pideal,    "N")
                THIS.this_nPMins     = TratarNulo(pmins,     "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista produtos que possuem estoque alvo configurado
    *          Retorna cursor CrProdutos para a grade da Page1
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrProdutos")
            USE IN CrProdutos
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = loc_cSQL + " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrProdutos")

            IF loc_nRes > 0
                SELECT CrProdutos
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar produtos: " + CapturarErroSQL(), "EmnBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarItens - Carrega grid de itens para um produto especifico
    *               Retorna cursor CrSigCdMin (com colunas do JOIN)
    *               Tambem cria CsCabec e seta flags lTemCor/lTemTam
    *==========================================================================
    PROCEDURE BuscarItens(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrSigCdMin")
            USE IN CrSigCdMin
        ENDIF
        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, a.emps, a.locals, a.qmins, a.codtams, a.codcores," + ;
                " a.ordems, a.cidchaves, a.contas, a.grupos, a.qideal, a.retiras," + ;
                " a.pideal, a.pmins," + ;
                " b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " ORDER BY a.emps, a.codtams, a.codcores"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMin")

            IF loc_nRes > 0
                SELECT CrSigCdMin
                GO TOP

                *-- Criar CsCabec com dados de cabecalho do produto
                THIS.CarregarCabecalho()

                *-- Atualizar flags de cor/tamanho
                THIS.BuscarFlags(par_cCPros)

                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar itens do produto: " + CapturarErroSQL(), "EmnBO.BuscarItens")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarItens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarFlags - Carrega flags lTemCor/lTemTam de SigCdPro x SigCdGrp
    *==========================================================================
    PROCEDURE BuscarFlags(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        THIS.this_lTemCor    = .F.
        THIS.this_lTemTam    = .F.
        THIS.this_nTipoEstos = 0

        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.cores, b.tams, b.tipoestos" + ;
                " FROM SigCdPro a" + ;
                " INNER JOIN SigCdGrp b ON b.cgrus = a.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Flags")

            IF loc_nRes > 0 AND USED("cursor_4c_Flags") AND RECCOUNT("cursor_4c_Flags") > 0
                SELECT cursor_4c_Flags
                GO TOP
                THIS.this_nTipoEstos = TratarNulo(tipoestos, "N")
                THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR (TratarNulo(cores, "N") = 1)
                THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR (TratarNulo(tams,  "N") = 1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarFlags")
        ENDTRY

        IF USED("cursor_4c_Flags")
            USE IN cursor_4c_Flags
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Cria cursor CsCabec com dados de cabecalho do produto
    *                     a partir do CrSigCdMin ja carregado
    *==========================================================================
    PROTECTED PROCEDURE CarregarCabecalho()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            IF USED("CrSigCdMin") AND RECCOUNT("CrSigCdMin") > 0
                SELECT DISTINCT cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas ;
                    FROM CrSigCdMin ;
                    INTO CURSOR CsCabec READWRITE
                GO TOP IN CsCabec
            ELSE
                CREATE CURSOR CsCabec ( ;
                    cpros    C(14), dpros C(65), cgrus  C(3), ;
                    dgrus    C(20), ifors C(10), rclis  C(50), ;
                    reffs    C(20), qmins N(8,2), qideal N(7,2), ;
                    situas   N(1,0))
                INSERT INTO CsCabec (cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas) ;
                    VALUES (SPACE(14), SPACE(65), SPACE(3), SPACE(20), SPACE(10), SPACE(50), SPACE(20), 0, 0, 1)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarCabecalho")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega propriedades de cabecalho para um produto
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCPros))
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas," + ;
                " c.rclis, g.dgrus, a.qmins, a.qideal" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus, a.qmins, a.qideal"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cabec")

            IF loc_nRes > 0 AND USED("cursor_4c_Cabec") AND RECCOUNT("cursor_4c_Cabec") > 0
                SELECT cursor_4c_Cabec
                GO TOP
                THIS.this_cCPros    = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros    = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cIFors    = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cReffs    = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_cCGrus    = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_nSituas   = TratarNulo(situas, "N")
                THIS.this_cRClis    = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cDGrus    = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_nQMins    = TratarNulo(qmins,  "N")
                THIS.this_nQIdeal   = TratarNulo(qideal, "N")
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Cabec")
            USE IN cursor_4c_Cabec
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarGrid - Salva todos os itens do grid no SQL Server
    *              Estrategia: DELETE todos os itens do produto, INSERT novos
    *              Apenas linhas com emps preenchido sao salvas
    *==========================================================================
    PROTECTED PROCEDURE SalvarGrid(par_cCPros)
        LOCAL loc_lResultado, loc_nRes, loc_lTransacao
        LOCAL loc_cSQL, loc_cCidChaves
        loc_lResultado = .F.
        loc_lTransacao = .F.

        IF EMPTY(ALLTRIM(par_cCPros))
            MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido para SalvarGrid.")
            RETURN .F.
        ENDIF

        IF !USED("CrSigCdMin")
            MsgErro("Cursor CrSigCdMin n" + CHR(227) + "o encontrado.", "EmnBO.SalvarGrid")
            RETURN .F.
        ENDIF

        TRY
            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Deletar todos os registros existentes para este produto
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
                "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nRes < 0
                MsgErro("Erro ao excluir registros antigos: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
            ELSE
                *-- Inserir linhas validas do cursor local
                loc_lResultado = .T.
                SELECT CrSigCdMin
                GO TOP

                SCAN FOR !DELETED()
                    IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
                        *-- Gerar cidchaves se necessario
                        loc_cCidChaves = ALLTRIM(CrSigCdMin.cidchaves)
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdMin" + ;
                            " (cpros, emps, locals, qmins, codtams, codcores," + ;
                            " ordems, cidchaves, contas, grupos, qideal, retiras, pideal, pmins)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.cpros))    + ", " + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.emps))     + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.locals),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qmins)      + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codtams),   4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codcores),  4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.ordems),    1)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCidChaves,               20)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.contas),   10)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.grupos),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.retiras)    + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pmins)      + ;
                            ")"

                        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nRes < 0
                            MsgErro("Erro ao inserir item: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    THIS.RegistrarAuditoria("SAVE")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo), "EmnBO.SalvarGrid")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Chamado pelo BusinessBase.Salvar() para novo produto
    *           Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Chamado pelo BusinessBase.Salvar() para produto existente
    *             Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui TODOS os itens SigCdMin de um produto
    *                    Chamado via BusinessBase.Excluir()
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCPros))
                MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido.")
            ELSE
                loc_cSQL = "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Exc")

                IF USED("cursor_4c_Exc")
                    USE IN cursor_4c_Exc
                ENDIF

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir: " + CapturarErroSQL(), "EmnBO.ExecutarExclusao")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarCopia - Cria cursor CsCopia com comparacao de itens entre empresas
    *                  Cores Vermelho(0/naoexiste-dest) Preto(0/existe) Azul(2/naoexiste-orig)
    *==========================================================================
    PROCEDURE ProcessarCopia(par_cEmpO, par_cEmpD, par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cFiltroO, loc_cFiltroD, loc_cFiltroProd
        loc_lResultado = .F.

        IF USED("CsCopia")
            USE IN CsCopia
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresas Origem e Destino s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "EmnBO.ProcessarCopia")
            ELSE
                loc_cFiltroO   = EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))
                loc_cFiltroD   = EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))
                loc_cFiltroProd = ""
                IF !EMPTY(ALLTRIM(par_cCPros))
                    loc_cFiltroProd = " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCPros), 14))
                ENDIF

                *-- Itens que existem na Origem mas NAO no Destino (marcas=1, existes=0)
                loc_cSQL = "SELECT CAST(1 AS int) AS marcas, CAST(0 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND (a.cpros + a.codtams + a.codcores) NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(1 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(2 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroD + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroO + ")"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CsCopia")

                IF loc_nRes > 0
                    SELECT CsCopia
                    GO TOP
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao processar c" + CHR(243) + "pia: " + CapturarErroSQL(), "EmnBO.ProcessarCopia")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ProcessarCopia")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CopiarItens - Copia itens marcados de CsCopia para empresa destino
    *               Apenas linhas marcas=1 E existes=0 sao copiadas
    *==========================================================================
    PROCEDURE CopiarItens(par_cEmpD)
        LOCAL loc_lResultado, loc_nRes, loc_nCopias, loc_nTotal
        LOCAL loc_cSQL, loc_cCidChaves, loc_lTransacao
        loc_lResultado = .F.
        loc_nCopias    = 0
        loc_nTotal     = 0
        loc_lTransacao = .F.

        TRY
            IF !USED("CsCopia") OR RECCOUNT("CsCopia") = 0
                MsgErro("Cursor CsCopia vazio. Execute ProcessarCopia primeiro.", "EmnBO.CopiarItens")
            ELSE
                IF EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresa Destino inv" + CHR(225) + "lida.", "EmnBO.CopiarItens")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.
                loc_lResultado = .T.

                SELECT CsCopia
                COUNT FOR !DELETED() TO loc_nTotal
                GO TOP

                SCAN FOR !DELETED() AND CsCopia.marcas = 1 AND CsCopia.existes = 0
                    loc_cCidChaves = THIS.GerarChaveUnica()

                    loc_cSQL = "INSERT INTO SigCdMin" + ;
                        " (cpros, emps, locals, qmins, qideal, codtams, codcores," + ;
                        " cidchaves, contas, grupos, ordems, retiras, pideal, pmins)" + ;
                        " VALUES (" + ;
                        EscaparSQL(ALLTRIM(CsCopia.cpros))               + ", " + ;
                        EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))          + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.locals),  10))   + ", " + ;
                        FormatarNumeroSQL(CsCopia.qmins)                 + ", " + ;
                        FormatarNumeroSQL(CsCopia.qideal)                + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codtams), 4))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codcores), 4))   + ", " + ;
                        EscaparSQL(LEFT(loc_cCidChaves, 20))             + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.contas), 10))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.grupos), 10))    + ", " + ;
                        "' ', 1, 0, 0)"

                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")
                    IF USED("cursor_4c_Copia")
                        USE IN cursor_4c_Copia
                    ENDIF

                    IF loc_nRes >= 0
                        loc_nCopias = loc_nCopias + 1
                    ELSE
                        MsgErro("Erro ao copiar item: " + CapturarErroSQL(), "EmnBO.CopiarItens")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    MsgInfo("Foram copiados " + TRANSFORM(loc_nCopias) + " de " + ;
                        TRANSFORM(loc_nTotal) + " registros.")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CopiarItens")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

