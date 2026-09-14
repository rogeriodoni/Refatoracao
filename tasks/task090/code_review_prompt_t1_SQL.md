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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2208 linhas total):

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
78:             *-- Page1: grid de selecao de tipos de operacao + botoes Sel/Des todos
79:             *-- (em forms REPORT, ConfigurarPaginaLista monta a "pagina de selecao" -
80:             *--  equivalente ao papel da Page1/Lista em forms CRUD)
81:             THIS.ConfigurarPaginaLista()

*-- Linhas 151 a 176:
151: 
152:     *==========================================================================
153:     * CRIARCURSOROPERACOES - Cria cursor vazio de tipos de operacao
154:     * Espelha o "Create Cursor crOperacoes" do Init() original + Index
155:     * Fase 4 ira popular com dados do SQL Server (SigCdTom) e configurar grid
156:     *==========================================================================
157:     PROTECTED PROCEDURE CriarCursorOperacoes()
158:         IF USED("crOperacoes")
159:             USE IN crOperacoes
160:         ENDIF
161:         CREATE CURSOR crOperacoes (SelImp L(1), Codigos N(2), Descrs C(30), SelImp2 L(1), SelImp3 L(1))
162:         INDEX ON Codigos TAG Codigos
163:     ENDPROC
164: 
165:     *==========================================================================
166:     * CONFIGURARCABECALHO - Cabecalho escuro com titulo
167:     * Equivalente a cntSombra do framework.vcx
168:     * BackColor=RGB(100,100,100), Width=THIS.Width (nao subtrair!)
169:     *==========================================================================
170:     PROTECTED PROCEDURE ConfigurarCabecalho()
171:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
172:         WITH THIS.cnt_4c_Cabecalho
173:             .Top        = 0
174:             .Left       = 0
175:             .Width      = THIS.Width
176:             .Height     = 80

*-- Linhas 436 a 510:
436:             .Left               = 439
437:             .Width              = 309
438:             .Height             = 115
439:             .DeleteMark         = .F.
440:             .RecordMark         = .F.
441:             .HighlightStyle     = 2
442:             .HighlightBackColor = RGB(255, 255, 255)
443:             .HighlightForeColor = RGB(15, 41, 104)
444:             .GridLineColor      = RGB(238, 238, 238)
445:             .FontName           = "Verdana"
446:             .FontSize           = 8
447:             .ScrollBars         = 2
448:             .RowHeight          = 16
449:         ENDWITH
450: 
451:         *-- Coluna 1: CheckBox para SelImp (selecao principal - Header "M")
452:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS
453:         WITH loc_oGrid.Column1
454:             .Width = 22
455:             .AddObject("Check1", "CheckBox")
456:             .Check1.Caption = ""
457:             .Check1.Value   = 0
458:             .CurrentControl = "Check1"
459:             .ControlSource  = "crOperacoes.SelImp"
460:             .Check1.Visible = .T.
461:         ENDWITH
462: 
463:         *-- Coluna 2: Codigos (somente leitura)
464:         WITH loc_oGrid.Column2
465:             .Width         = 30
466:             .ControlSource = "crOperacoes.Codigos"
467:             .ReadOnly      = .T.
468:         ENDWITH
469: 
470:         *-- Coluna 3: Descricao - Movimentacoes (somente leitura)
471:         WITH loc_oGrid.Column3
472:             .Width         = 185
473:             .ControlSource = "crOperacoes.Descrs"
474:             .ReadOnly      = .T.
475:         ENDWITH
476: 
477:         *-- Coluna 4: CheckBox para SelImp2 (Header "E")
478:         WITH loc_oGrid.Column4
479:             .Width = 37
480:             .AddObject("Check1", "CheckBox")
481:             .Check1.Caption = ""
482:             .Check1.Value   = 0
483:             .CurrentControl = "Check1"
484:             .ControlSource  = "crOperacoes.SelImp2"
485:             .Check1.Visible = .T.
486:         ENDWITH
487: 
488:         *-- Coluna 5: CheckBox para SelImp3 (Header "C")
489:         WITH loc_oGrid.Column5
490:             .Width = 35
491:             .AddObject("Check1", "CheckBox")
492:             .Check1.Caption = ""
493:             .Check1.Value   = 0
494:             .CurrentControl = "Check1"
495:             .ControlSource  = "crOperacoes.SelImp3"
496:             .Check1.Visible = .T.
497:         ENDWITH
498: 
499:         *-- RecordSource APOS configurar colunas (RecordSource reseta headers)
500:         loc_oGrid.RecordSource = "crOperacoes"
501: 
502:         *-- Reconfigurar Headers APOS RecordSource (OBRIGATORIO)
503:         loc_oGrid.Column1.Header1.Caption = "M"
504:         loc_oGrid.Column2.Header1.Caption = ""
505:         loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
506:         loc_oGrid.Column4.Header1.Caption = "E"
507:         loc_oGrid.Column5.Header1.Caption = "C"
508: 
509:         loc_oGrid.Visible = .T.
510: 

*-- Linhas 1375 a 1455:
1375:     *==========================================================================
1376:     PROCEDURE CarregarOperacoes()
1377:         LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs
1378:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"
1379: 
1380:         TRY
1381:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
1382:             IF loc_nResult > 0
1383:                 SELECT crOperacoes
1384:                 ZAP
1385:                 SELECT cursor_4c_TmpOpe
1386:                 SCAN
1387:                     loc_nCodigos = cursor_4c_TmpOpe.Codigos
1388:                     loc_cDescrs  = ALLTRIM(cursor_4c_TmpOpe.Descrs)
1389:                     SELECT crOperacoes
1390:                     APPEND BLANK
1391:                     REPLACE SelImp  WITH .T., ;
1392:                             SelImp2 WITH .T., ;
1393:                             SelImp3 WITH .F., ;
1394:                             Codigos WITH loc_nCodigos, ;
1395:                             Descrs  WITH loc_cDescrs
1396:                     SELECT cursor_4c_TmpOpe
1397:                 ENDSCAN
1398:                 IF USED("cursor_4c_TmpOpe")
1399:                     USE IN cursor_4c_TmpOpe
1400:                 ENDIF
1401:                 SELECT crOperacoes
1402:                 GO TOP
1403:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
1404:                    VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes) = "O"
1405:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1406:                 ENDIF
1407:             ENDIF
1408:         CATCH TO loc_oErro
1409:             MsgErro(loc_oErro.Message, "CarregarOperacoes")
1410:         ENDTRY
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     * BTNGRADESCLICK - Seleciona ou desmarca todos os tipos de operacao
1415:     *   Value=1 -> marca todos (SelImp=.T., SelImp2=.T.)
1416:     *   Value=2 -> desmarca todos (SelImp=.F., SelImp2=.F.)
1417:     *   Logica identica ao cmdBtnGradeS.Click original.
1418:     *==========================================================================
1419:     PROCEDURE BtnGradeSClick()
1420:         LOCAL loc_lMarcar, loc_oGrid
1421:         loc_lMarcar = (THIS.pgf_4c_Paginas.Page1.cmg_4c_GradeS.Value = 1)
1422:         IF USED("crOperacoes")
1423:             UPDATE crOperacoes SET SelImp = loc_lMarcar, SelImp2 = loc_lMarcar
1424:             GO TOP IN crOperacoes
1425:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1426:             IF VARTYPE(loc_oGrid) = "O"
1427:                 loc_oGrid.Refresh()
1428:             ENDIF
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     *==========================================================================
1433:     * GRDOPECHECK1KEYPRESS - Togla SelImp via teclado (Enter=13, Espaco=32)
1434:     * Equivalente ao KeyPress do Check1 da Column1 do grdOperacoes original
1435:     *==========================================================================
1436:     PROCEDURE GrdOpeCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1437:         LOCAL loc_oGrid
1438:         IF INLIST(par_nKeyCode, 13, 32)
1439:             IF USED("crOperacoes") AND !EOF("crOperacoes")
1440:                 SELECT crOperacoes
1441:                 REPLACE SelImp WITH !crOperacoes.SelImp
1442:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1443:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1444:                     IF VARTYPE(loc_oGrid) = "O"
1445:                         loc_oGrid.Refresh()
1446:                     ENDIF
1447:                 ENDIF
1448:             ENDIF
1449:             NODEFAULT
1450:         ENDIF
1451:     ENDPROC
1452: 
1453:     *==========================================================================
1454:     * DESTROY - Limpeza de recursos
1455:     * NAO usar .Release() em BO Custom - apenas .NULL.

*-- Linhas 1504 a 1522:
1504:                 .this_cDsMoeda    = ALLTRIM(loc_oPag.txt_4c_DsMoeda.Value)
1505:             ENDWITH
1506:             IF USED("crOperacoes")
1507:                 SELECT crOperacoes
1508:                 GO TOP
1509:                 SCAN
1510:                     IF crOperacoes.SelImp
1511:                         loc_cTpOpeM = loc_cTpOpeM + IIF(EMPTY(loc_cTpOpeM),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
1512:                     ENDIF
1513:                     IF crOperacoes.SelImp2
1514:                         loc_cTpOpeE = loc_cTpOpeE + IIF(EMPTY(loc_cTpOpeE),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
1515:                     ENDIF
1516:                     IF crOperacoes.SelImp3
1517:                         loc_cTpOpeC = loc_cTpOpeC + IIF(EMPTY(loc_cTpOpeC),"",",") + ALLTRIM(STR(crOperacoes.Codigos))
1518:                     ENDIF
1519:                 ENDSCAN
1520:             ENDIF
1521:             THIS.this_oRelatorio.this_cTpOpeM = IIF(EMPTY(loc_cTpOpeM), "0", loc_cTpOpeM)
1522:             THIS.this_oRelatorio.this_cTpOpeE = IIF(EMPTY(loc_cTpOpeE), "0", loc_cTpOpeE)

*-- Linhas 1744 a 1763:
1744:             RETURN
1745:         ENDIF
1746:         TRY
1747:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
1748:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTpOpe")
1749:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValTpOpe") = 1
1750:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_ValTpOpe.Descrs)
1751:             ELSE
1752:                 MsgAviso("C" + CHR(243) + "digo de tipo n" + CHR(227) + "o encontrado.")
1753:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = 0
1754:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
1755:                 THIS.AbrirLookupTpOpePorCodigo()
1756:             ENDIF
1757:         CATCH TO loc_oErro
1758:             MsgErro(loc_oErro.Message, "ValidarTpOpeCodigo")
1759:         ENDTRY
1760:         IF USED("cursor_4c_ValTpOpe")
1761:             USE IN cursor_4c_ValTpOpe
1762:         ENDIF
1763:     ENDPROC

*-- Linhas 1843 a 1862:
1843:             RETURN
1844:         ENDIF
1845:         TRY
1846:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1847:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEstoque")
1848:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValEstoque") = 1
1849:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_ValEstoque.nomes)
1850:             ELSE
1851:                 MsgAviso("C" + CHR(243) + "digo de conta n" + CHR(227) + "o encontrado.")
1852:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = SPACE(10)
1853:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
1854:                 THIS.AbrirLookupEstoquePorCodigo()
1855:             ENDIF
1856:         CATCH TO loc_oErro
1857:             MsgErro(loc_oErro.Message, "ValidarEstoqueCodigo")
1858:         ENDTRY
1859:         IF USED("cursor_4c_ValEstoque")
1860:             USE IN cursor_4c_ValEstoque
1861:         ENDIF
1862:     ENDPROC

*-- Linhas 1942 a 1961:
1942:             RETURN
1943:         ENDIF
1944:         TRY
1945:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1946:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValVendedor")
1947:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValVendedor") = 1
1948:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_ValVendedor.nomes)
1949:             ELSE
1950:                 MsgAviso("C" + CHR(243) + "digo de vendedor n" + CHR(227) + "o encontrado.")
1951:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = SPACE(10)
1952:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
1953:                 THIS.AbrirLookupVendedorPorCodigo()
1954:             ENDIF
1955:         CATCH TO loc_oErro
1956:             MsgErro(loc_oErro.Message, "ValidarVendedorCodigo")
1957:         ENDTRY
1958:         IF USED("cursor_4c_ValVendedor")
1959:             USE IN cursor_4c_ValVendedor
1960:         ENDIF
1961:     ENDPROC

*-- Linhas 2076 a 2095:
2076:             RETURN
2077:         ENDIF
2078:         TRY
2079:             loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE CAST(cmoes AS VARCHAR(10)) = " + EscaparSQL(loc_cCod)
2080:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValMoeda")
2081:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValMoeda") = 1
2082:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_ValMoeda.dmoes)
2083:             ELSE
2084:                 MsgAviso("C" + CHR(243) + "digo de moeda n" + CHR(227) + "o encontrado.")
2085:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = SPACE(3)
2086:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
2087:                 THIS.AbrirLookupMoedaPorCodigo()
2088:             ENDIF
2089:         CATCH TO loc_oErro
2090:             MsgErro(loc_oErro.Message, "ValidarMoedaCodigo")
2091:         ENDTRY
2092:         IF USED("cursor_4c_ValMoeda")
2093:             USE IN cursor_4c_ValMoeda
2094:         ENDIF
2095:     ENDPROC

