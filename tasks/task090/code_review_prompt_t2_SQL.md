# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, CONTAOS, SERVICOS, NOPS, UTILIZADOS, CPROS, CITENS, CODCORS, CODTAMS, QTDOPS, EMPS, NUMES, LNCITEM, QTRESERVAS, CONTADS, CODIGOS, TIPOS, VALUE, EMPDOPNOPS, EMPSUBNS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, CONTAOS, SERVICOS, NOPS, UTILIZADOS, CPROS, CITENS, CODCORS, CODTAMS, QTDOPS, EMPS, NUMES, LNCITEM, QTRESERVAS, CONTADS, CODIGOS, TIPOS, VALUE, EMPDOPNOPS, EMPSUBNS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMB' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, CONTAOS, SERVICOS, NOPS, UTILIZADOS, CPROS, CITENS, CODCORS, CODTAMS, QTDOPS, EMPS, NUMES, LNCITEM, QTRESERVAS, CONTADS, CODIGOS, TIPOS, VALUE, EMPDOPNOPS, EMPSUBNS

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
  ControlSource = ""
		Select crSigCdTom
			Insert Into crOperacoes (SelImp, SelImp2, SelImp3, Codigos, Descrs) ;
		.grdOperacoes.column1.ControlSource = 'crOperacoes.SelImp'
		.grdOperacoes.column2.ControlSource = 'crOperacoes.Codigos'
		.grdOperacoes.column3.ControlSource = 'crOperacoes.Descrs'
		.grdOperacoes.column4.ControlSource = 'crOperacoes.SelImp2'				
		.grdOperacoes.column5.ControlSource = 'crOperacoes.SelImp3'
Select crOperacoes
thisform.podatamgr.SqlExecute([Select a.Dopes, a.Abrevs, a.Globalizas, a.Servicos, b.CarCompos From SigCdOpe a inner join SigOpCdc b on a.Dopes = b.Dopes],[crSigCdOpe])
Insert Into csCabecalho (nm_empresa, nm_titulo, nm_periodo, mostrar, cidade, ImpVals);
Select crSigCdOpe
lcQuery = [Select a.Emps, a.Dopes, a.Numes, c.Iclis, c.Rclis, c.Cidas, c.Estas, a.Qtds, b.Utilizados, ] + ;
			[From SigMvCab b, SigMvItn a, SigCdCli c, SigCdOpe o ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'ResPed1') < 1)
Select a.Emps, a.Dopes, a.Numes, a.Iclis, a.Rclis, a.Cidas, a.Estas, a.Utilizados, a.Nops, ;
  From ResPed1 a, CrSigCdOpe b ;
Select Emps+dopes+Str(Numes,6) as EmpDopNums, sum(Qtds) as Qtds From ResPed Into Cursor TotPed group by 1
Select Totped
Select Distinct Emps, Dopes, Numes ;
  From ResPed ;
Select TmpFab
	oProg.Update(.t.)
	lcQuery = [Select a.EmpdopNums, b.chksubn, b.Lccs, Sum(a.Qtds) as Qtds ] + ;
				[From SigOpPic a, SigCdNec b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csQtde') < 1)
	Select csQtde
	Select TotPed
	=Seek(lcEdn)
		If Not Seek(lcEdn, 'Fabricado', 'EmpDopNum')
			Insert Into Fabricado (Emps, Dopes, Numes) Values (TmpFab.Emps, TmpFab.Dopes, TmpFab.Numes)
Select ResPed
	oProg.Update(.t.)
	Select Fabricado
			Select crSigBxEst
		Select csRelatorio
			lcQuery = [Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas,  b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] +;
						[c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] +; 
						[(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] +; 
						[From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] +;
						[left Join SigOpPic a On a.EmpDopNums = c.EmpDopNums And a.Cpros = c.Cpros And a.Citens = c.Citens And a.CodCors = c.CodCors ] +;
						[Left Join SigCdNec b On a.EmpDopNops = b.EmpDNps ] +;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csQtde') < 1)
			Select Emps, Dopes, Numes, EmpdopNums, Citens, Cpros, Nvl(chksubn,.t.) as chksubn, Nvl(Lccs,.f.) as Lccs, Nvl(Nops,0000000000) as Nops, moedas, ;
				from csQtde into cursor csQtde 
			Select csQtde
					Select CsRelatorio
						Select csRelatorio
								lcSql = [Select a.Cpros, Sum(a.Qtds) as QtMovs from SigOpEtq a Inner Join ] +;
											[(Select top 1 a.Emps, a.Dopps, a.Numps, a.EmpDNps, a.Codpds from SigPdMvf a ] +;
											[Inner Join SigOpPic b On a.Nops = b.Nops where b.Nops = ?csQtde.Nops And b.Empdopnums = ?lcEdn And b.Citens = ?csQtde.Citens ] +;
											[Inner Join SigMvHst c On a.Cbars = c.Codbarras ] +;
											[Inner Join SigCdOpe d On c.Dopes = d.Dopes And d.TipoOps in ] + lcTpOpeM +;
								If ThisForm.podatamgr.Sqlexecute(lcsql,'CrTmpMov') < 1
							lcQuery = [Select b.nDopes, a.Numes From SigMvCab a Inner Join SigCdOpe b On a.Dopes = b.Dopes ] +;
							If Thisform.PoDataMgr.SqlExecute(lcQuery,'CrxOpe') < 1
							lcQuery = [Select a.Cpros, count(c.Dopes) as QtMovs from ] + ;
										[(Select d.cpros, d.codbarras, d.Qtds ] + ;
										[From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
										[Select d.cpros, d.codbarras, d.Qtds ] + ;
										[From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
										[Inner Join SigMvHst b On a.codbarras = b.Codbarras ] + ;
										[Left Join SigCdOpe c On b.Dopes = c.Dopes And c.TipoOps in ] + lcTpOpeM + ;
							If ThisForm.poDataMgr.Sqlexecute(lcQuery,'TmpEmpenho') < 1
							Select Nvl(QtMovs, 000000.000) as QtMovs from TmpEmpenho into cursor TmpEmpenho
							lcQuery = [Select a.Cpros, Sum(a.Qtds) as QtMovs from ] + ;
										[(Select d.cpros, d.codbarras, d.Qtds ] + ;
										[From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
										[Select d.cpros, d.codbarras, d.Qtds ] + ;
										[From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
							If ThisForm.poDataMgr.Sqlexecute(lcQuery,'TmpEmpenho') < 1
							Select Nvl(QtMovs, 000000.000) as QtMovs from TmpEmpenho into cursor TmpEmpenho
			Select csRelatorio
			Select Sum(Qtds) as Qtds, Sum(QtReservas) as QtReservas, Sum(QtdCancs) as QtdCancs, Sum(QtProds) as QtProds, ;
				from csRelatorio Where Emps + Dopes + Str(Numes,6) = lcEdn And Tipos  = '2' Into Cursor TmpTotal
			Select csRelatorio
Select csRelatorio
Select '5'as Tipos, Sum(1) as Qps, Sum(Iif(Qtds - Qtdfs <= 0, 1, 0)) as Qpes, Sum(Qtds) as QtdPcs, ;
   From csRelatorio Where tipos <> '2' ;
Select csRelatorio
Select csRelatorio
Select csTotal
	Select Sum(Nvl(Valors,0000000000.00)) as TotUnits, Sum(Nvl(QtProds * ValUnits,0000000000.00)) as ValProds , Sum(Nvl(QtdMovPds * ValUnits,0000000000.00)) as ValMovPds,;
		From csRelatorio Where tipos = '2' Into Cursor csTotal2
Select csRelatorio
	Delete From csRelatorio Where Tipos = '2'
Select csRelatorio
	Select crOperacoes
Select crOperacoes
Update crOperacoes Set SelImp = (This.Value = 1), SelImp2 = (This.Value = 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2213 linhas total):

*-- Linhas 63 a 81:
63:             ENDIF
64: 
65:             *-- Cursor placeholder para grdOperacoes (cria estrutura vazia)
66:             *-- Equivalente ao "Create Cursor crOperacoes" do Init() legado
67:             THIS.CriarCursorOperacoes()
68: 
69:             *-- Cabecalho escuro com titulo (padrao frmrelatorio - cntSombra)
70:             THIS.ConfigurarCabecalho()
71: 
72:             *-- CommandGroup de 4 botoes de relatorio (padrao framework.vcx - btnReport)
73:             THIS.ConfigurarBotoes()
74: 
75:             *-- PageFrame com 1 pagina (Filtros) - container dos controles abaixo do cabecalho
76:             THIS.ConfigurarPageFrame()
77: 
78:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80: 
81:             *-- Page1: grid de selecao de tipos de operacao + botoes Sel/Des todos

*-- Linhas 154 a 179:
154: 
155:     *==========================================================================
156:     * CRIARCURSOROPERACOES - Cria cursor vazio de tipos de operacao
157:     * Espelha o "Create Cursor crOperacoes" do Init() original + Index
158:     * Fase 4 ira popular com dados do SQL Server (SigCdTom) e configurar grid
159:     *==========================================================================
160:     PROTECTED PROCEDURE CriarCursorOperacoes()
161:         IF USED("crOperacoes")
162:             USE IN crOperacoes
163:         ENDIF
164:         CREATE CURSOR crOperacoes (SelImp L(1), Codigos N(2), Descrs C(30), SelImp2 L(1), SelImp3 L(1))
165:         INDEX ON Codigos TAG Codigos
166:     ENDPROC
167: 
168:     *==========================================================================
169:     * CONFIGURARCABECALHO - Cabecalho escuro com titulo
170:     * Equivalente a cntSombra do framework.vcx
171:     * BackColor=RGB(100,100,100), Width=THIS.Width (nao subtrair!)
172:     *==========================================================================
173:     PROTECTED PROCEDURE ConfigurarCabecalho()
174:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
175:         WITH THIS.cnt_4c_Cabecalho
176:             .Top        = 0
177:             .Left       = 0
178:             .Width      = THIS.Width
179:             .Height     = 80

*-- Linhas 439 a 513:
439:             .Left               = 439
440:             .Width              = 309
441:             .Height             = 115
442:             .DeleteMark         = .F.
443:             .RecordMark         = .F.
444:             .HighlightStyle     = 2
445:             .HighlightBackColor = RGB(255, 255, 255)
446:             .HighlightForeColor = RGB(15, 41, 104)
447:             .GridLineColor      = RGB(238, 238, 238)
448:             .FontName           = "Verdana"
449:             .FontSize           = 8
450:             .ScrollBars         = 2
451:             .RowHeight          = 16
452:         ENDWITH
453: 
454:         *-- Coluna 1: CheckBox para SelImp (selecao principal - Header "M")
455:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS
456:         WITH loc_oGrid.Column1
457:             .Width = 22
458:             .AddObject("Check1", "CheckBox")
459:             .Check1.Caption = ""
460:             .Check1.Value   = 0
461:             .CurrentControl = "Check1"
462:             .ControlSource  = "crOperacoes.SelImp"
463:             .Check1.Visible = .T.
464:         ENDWITH
465: 
466:         *-- Coluna 2: Codigos (somente leitura)
467:         WITH loc_oGrid.Column2
468:             .Width         = 30
469:             .ControlSource = "crOperacoes.Codigos"
470:             .ReadOnly      = .T.
471:         ENDWITH
472: 
473:         *-- Coluna 3: Descricao - Movimentacoes (somente leitura)
474:         WITH loc_oGrid.Column3
475:             .Width         = 185
476:             .ControlSource = "crOperacoes.Descrs"
477:             .ReadOnly      = .T.
478:         ENDWITH
479: 
480:         *-- Coluna 4: CheckBox para SelImp2 (Header "E")
481:         WITH loc_oGrid.Column4
482:             .Width = 37
483:             .AddObject("Check1", "CheckBox")
484:             .Check1.Caption = ""
485:             .Check1.Value   = 0
486:             .CurrentControl = "Check1"
487:             .ControlSource  = "crOperacoes.SelImp2"
488:             .Check1.Visible = .T.
489:         ENDWITH
490: 
491:         *-- Coluna 5: CheckBox para SelImp3 (Header "C")
492:         WITH loc_oGrid.Column5
493:             .Width = 35
494:             .AddObject("Check1", "CheckBox")
495:             .Check1.Caption = ""
496:             .Check1.Value   = 0
497:             .CurrentControl = "Check1"
498:             .ControlSource  = "crOperacoes.SelImp3"
499:             .Check1.Visible = .T.
500:         ENDWITH
501: 
502:         *-- RecordSource APOS configurar colunas (RecordSource reseta headers)
503:         loc_oGrid.RecordSource = "crOperacoes"
504: 
505:         *-- Reconfigurar Headers APOS RecordSource (OBRIGATORIO)
506:         loc_oGrid.Column1.Header1.Caption = "M"
507:         loc_oGrid.Column2.Header1.Caption = ""
508:         loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
509:         loc_oGrid.Column4.Header1.Caption = "E"
510:         loc_oGrid.Column5.Header1.Caption = "C"
511: 
512:         loc_oGrid.Visible = .T.
513: 

*-- Linhas 1380 a 1460:
1380:     *==========================================================================
1381:     PROCEDURE CarregarOperacoes()
1382:         LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs
1383:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"
1384: 
1385:         TRY
1386:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
1387:             IF loc_nResult > 0
1388:                 SELECT crOperacoes
1389:                 ZAP
1390:                 SELECT cursor_4c_TmpOpe
1391:                 SCAN
1392:                     loc_nCodigos = cursor_4c_TmpOpe.Codigos
1393:                     loc_cDescrs  = ALLTRIM(cursor_4c_TmpOpe.Descrs)
1394:                     SELECT crOperacoes
1395:                     APPEND BLANK
1396:                     REPLACE SelImp  WITH .T., ;
1397:                             SelImp2 WITH .T., ;
1398:                             SelImp3 WITH .F., ;
1399:                             Codigos WITH loc_nCodigos, ;
1400:                             Descrs  WITH loc_cDescrs
1401:                     SELECT cursor_4c_TmpOpe
1402:                 ENDSCAN
1403:                 IF USED("cursor_4c_TmpOpe")
1404:                     USE IN cursor_4c_TmpOpe
1405:                 ENDIF
1406:                 SELECT crOperacoes
1407:                 GO TOP
1408:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
1409:                    VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes) = "O"
1410:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1411:                 ENDIF
1412:             ENDIF
1413:         CATCH TO loc_oErro
1414:             MsgErro(loc_oErro.Message, "CarregarOperacoes")
1415:         ENDTRY
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     * BTNGRADESCLICK - Seleciona ou desmarca todos os tipos de operacao
1420:     *   Value=1 -> marca todos (SelImp=.T., SelImp2=.T.)
1421:     *   Value=2 -> desmarca todos (SelImp=.F., SelImp2=.F.)
1422:     *   Logica identica ao cmdBtnGradeS.Click original.
1423:     *==========================================================================
1424:     PROCEDURE BtnGradeSClick()
1425:         LOCAL loc_lMarcar, loc_oGrid
1426:         loc_lMarcar = (THIS.pgf_4c_Paginas.Page1.cmg_4c_GradeS.Value = 1)
1427:         IF USED("crOperacoes")
1428:             UPDATE crOperacoes SET SelImp = loc_lMarcar, SelImp2 = loc_lMarcar
1429:             GO TOP IN crOperacoes
1430:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1431:             IF VARTYPE(loc_oGrid) = "O"
1432:                 loc_oGrid.Refresh()
1433:             ENDIF
1434:         ENDIF
1435:     ENDPROC
1436: 
1437:     *==========================================================================
1438:     * GRDOPECHECK1KEYPRESS - Togla SelImp via teclado (Enter=13, Espaco=32)
1439:     * Equivalente ao KeyPress do Check1 da Column1 do grdOperacoes original
1440:     *==========================================================================
1441:     PROCEDURE GrdOpeCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1442:         LOCAL loc_oGrid
1443:         IF INLIST(par_nKeyCode, 13, 32)
1444:             IF USED("crOperacoes") AND !EOF("crOperacoes")
1445:                 SELECT crOperacoes
1446:                 REPLACE SelImp WITH !crOperacoes.SelImp
1447:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1448:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1449:                     IF VARTYPE(loc_oGrid) = "O"
1450:                         loc_oGrid.Refresh()
1451:                     ENDIF
1452:                 ENDIF
1453:             ENDIF
1454:             NODEFAULT
1455:         ENDIF
1456:     ENDPROC
1457: 
1458:     *==========================================================================
1459:     * DESTROY - Limpeza de recursos
1460:     * NAO usar .Release() em BO Custom - apenas .NULL.

*-- Linhas 1509 a 1527:
1509:                 .this_cDsMoeda    = ALLTRIM(loc_oPag.txt_4c_DsMoeda.Value)
1510:             ENDWITH
1511:             IF USED("crOperacoes")
1512:                 SELECT crOperacoes
1513:                 GO TOP
1514:                 SCAN
1515:                     IF crOperacoes.SelImp
1516:                         loc_cTpOpeM = loc_cTpOpeM + IIF(EMPTY(loc_cTpOpeM),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
1517:                     ENDIF
1518:                     IF crOperacoes.SelImp2
1519:                         loc_cTpOpeE = loc_cTpOpeE + IIF(EMPTY(loc_cTpOpeE),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
1520:                     ENDIF
1521:                     IF crOperacoes.SelImp3
1522:                         loc_cTpOpeC = loc_cTpOpeC + IIF(EMPTY(loc_cTpOpeC),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
1523:                     ENDIF
1524:                 ENDSCAN
1525:             ENDIF
1526:             THIS.this_oRelatorio.this_cTpOpeM = IIF(EMPTY(loc_cTpOpeM), "0", loc_cTpOpeM)
1527:             THIS.this_oRelatorio.this_cTpOpeE = IIF(EMPTY(loc_cTpOpeE), "0", loc_cTpOpeE)

*-- Linhas 1749 a 1768:
1749:             RETURN
1750:         ENDIF
1751:         TRY
1752:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
1753:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTpOpe")
1754:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValTpOpe") = 1
1755:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_ValTpOpe.Descrs)
1756:             ELSE
1757:                 MsgAviso("C" + CHR(243) + "digo de tipo n" + CHR(227) + "o encontrado.")
1758:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = 0
1759:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
1760:                 THIS.AbrirLookupTpOpePorCodigo()
1761:             ENDIF
1762:         CATCH TO loc_oErro
1763:             MsgErro(loc_oErro.Message, "ValidarTpOpeCodigo")
1764:         ENDTRY
1765:         IF USED("cursor_4c_ValTpOpe")
1766:             USE IN cursor_4c_ValTpOpe
1767:         ENDIF
1768:     ENDPROC

*-- Linhas 1848 a 1867:
1848:             RETURN
1849:         ENDIF
1850:         TRY
1851:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1852:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEstoque")
1853:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValEstoque") = 1
1854:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_ValEstoque.nomes)
1855:             ELSE
1856:                 MsgAviso("C" + CHR(243) + "digo de conta n" + CHR(227) + "o encontrado.")
1857:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = SPACE(10)
1858:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
1859:                 THIS.AbrirLookupEstoquePorCodigo()
1860:             ENDIF
1861:         CATCH TO loc_oErro
1862:             MsgErro(loc_oErro.Message, "ValidarEstoqueCodigo")
1863:         ENDTRY
1864:         IF USED("cursor_4c_ValEstoque")
1865:             USE IN cursor_4c_ValEstoque
1866:         ENDIF
1867:     ENDPROC

*-- Linhas 1947 a 1966:
1947:             RETURN
1948:         ENDIF
1949:         TRY
1950:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1951:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValVendedor")
1952:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValVendedor") = 1
1953:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_ValVendedor.nomes)
1954:             ELSE
1955:                 MsgAviso("C" + CHR(243) + "digo de vendedor n" + CHR(227) + "o encontrado.")
1956:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = SPACE(10)
1957:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
1958:                 THIS.AbrirLookupVendedorPorCodigo()
1959:             ENDIF
1960:         CATCH TO loc_oErro
1961:             MsgErro(loc_oErro.Message, "ValidarVendedorCodigo")
1962:         ENDTRY
1963:         IF USED("cursor_4c_ValVendedor")
1964:             USE IN cursor_4c_ValVendedor
1965:         ENDIF
1966:     ENDPROC

*-- Linhas 2081 a 2100:
2081:             RETURN
2082:         ENDIF
2083:         TRY
2084:             loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE CAST(cmoes AS VARCHAR(10)) = " + EscaparSQL(loc_cCod)
2085:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValMoeda")
2086:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValMoeda") = 1
2087:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_ValMoeda.dmoes)
2088:             ELSE
2089:                 MsgAviso("C" + CHR(243) + "digo de moeda n" + CHR(227) + "o encontrado.")
2090:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = SPACE(3)
2091:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
2092:                 THIS.AbrirLookupMoedaPorCodigo()
2093:             ENDIF
2094:         CATCH TO loc_oErro
2095:             MsgErro(loc_oErro.Message, "ValidarMoedaCodigo")
2096:         ENDTRY
2097:         IF USED("cursor_4c_ValMoeda")
2098:             USE IN cursor_4c_ValMoeda
2099:         ENDIF
2100:     ENDPROC

