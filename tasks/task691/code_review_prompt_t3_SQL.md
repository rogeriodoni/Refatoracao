# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PLACEHOLDER' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDPARAMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDNPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  Column11.ControlSource = ""
Update LocalDados Set SaldoDia = 0, SaldoTot = 0, Debitos = 0, Creditos = 0
Select * From LocalDados Where 0=1 Into Cursor LocalTotais ReadWrite
Delete From LocalDados Where (Nopers > 9999997) Or (SInis = 1)
Select LocalDados
	Insert Into LocalTotais From Memvar		
		Insert Into LocalTotais From Memvar
			Insert Into LocalTotais From Memvar
Select LocalDados
		Insert Into LocalTotais From Memvar
	Insert Into LocalTotais From Memvar	
Select LocalTotais
	Insert Into LocalDados From Memvar
Update LocalDados Set SaldoDia = 0, SaldoTot = 0, Debitos = 0, Creditos = 0
Select * From LocalDados Where 0=1 Into Cursor LocalTotais ReadWrite
Delete From LocalDados Where (Nopers > 9999997) Or (SInis = 1)
Select LocalDados
				If Not Seek(lcEmi, [TmpContas], [IClis])
					lcQuery = [Select IClis, RClis ] + ;
							    [From SigCdCli ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
					Insert Into TmpContas (IClis, RClis) Values (LocalCli.IClis, LocalCli.RClis)
				If Not Seek(lcPor, [TmpContas], [IClis])
					lcQuery = [Select IClis, RClis ] + ;
							    [From SigCdCli ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
					Insert Into TmpContas (IClis, RClis) Values (LocalCli.IClis, LocalCli.RClis)
		Insert Into LocalTotais From Memvar
Select LocalDados
			If Not Seek(lcEmi, [TmpContas], [IClis])
				lcQuery = [Select IClis, RClis ] + ;
						    [From SigCdCli ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
				Insert Into TmpContas (IClis, RClis) Values (LocalCli.IClis, LocalCli.RClis)
			If Not Seek(lcPor, [TmpContas], [IClis])
				lcQuery = [Select IClis, RClis ] + ;
						    [From SigCdCli ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
				Insert Into TmpContas (IClis, RClis) Values (LocalCli.IClis, LocalCli.RClis)
	Insert Into LocalTotais From Memvar	
Select LocalTotais
	Insert Into LocalDados From Memvar
lcQuery = [Select a.Grupos, b.Descrs, a.IClis, a.RClis ] + ;
		    [From SigCdCli a, SigCdGcr b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalFPubs]) < 1)
Select LocalFPubs
	Delete From TmpCliente
	Select LocalFPubs
			Insert Into TmpCliente (Grupo, NomeGrupo, Conta, Nome, CheckE) ;
Select 9999999999 as Ordem, Nopers, ' ' as Tipo, SaldoDia as Saldos, SaldoTot as SaldosP, Debitos, ;
  From LocalDados ;
Select crMccr
	Insert Into dbCabecalho (Titulo, SubTitulo, RodRelCC) Values (lcTit, lcSub, lcRes)
	Select crMccr
	Select crMccr
Select LocalDados
	.DeleteMark        = .f.
	.Column1.ControlSource    = [Iif(LocalDados.Nopers > 9999997 Or LocalDados.SInis=1, '', Dtoc(Ttod(LocalDados.DtEmis)))]
	.Column2.ControlSource    = [Iif(LocalDados.Nopers > 9999997 Or LocalDados.SInis=1, '', Dtoc(Ttod(LocalDados.Vencs)))]
	.Column3.ControlSource    = [Iif(LocalDados.Nopers > 9999997 Or LocalDados.SInis=1, '', Dtoc(Ttod(LocalDados.Datas)))]
	.Column4.ControlSource    = [Iif(LocalDados.Nopers > 9999997 Or LocalDados.SInis=1, '', Dtoc(Ttod(LocalDados.DtBaixa)))]
	.Column5.ControlSource    = [Iif(LocalDados.Nopers > 9999997 Or LocalDados.SInis=1, '', LocalDados.Titulos)]
	.Column6.ControlSource    = [LocalDados.Hists]
	.Column7.ControlSource    = [Iif(LocalDados.Nopers > 9999997, '', LocalDados.Moedas)]
	.Column8.ControlSource    = [LocalDados.Valors]
	.Column9.ControlSource    = [LocalDados.Debitos]
	.Column10.ControlSource   = [LocalDados.Creditos]
	.Column11.ControlSource   = [LocalDados.SaldoDia]
	.Column12.ControlSource   = [LocalDados.SaldoTot]
lcQuery = [Select 1 as Imps, Dopes, Opers, RealPrevs ] + ;
		    [From SigOpOpe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigOpOpe]) < 1)
Insert Into crSigOpOpe(Imps,Dopes,Opers) Values(0,Space(20),[C])
	.DeleteMark        = .f.
	.Column1.ControlSource   = 'crSigOpOpe.Imps'
	.Column2.ControlSource   = 'crSigOpOpe.Dopes'
lcQuery = [Select * ] + ;
		    [From SigOpFp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [GradeOpOpe]) < 1)
Select GradeOpOpe
Select LocalDados
	Select Iif((Nopers < 9999997) And (SInis <> 1), Space(5), [TOTAL]) as Linhas, ;
	  From LocalDados ;
	Select LocalExcel
Select LocalDados
Select crSigOpOpe
lcQuery = [Select a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, ] + ;
			[From SigMvCcr a ] + ;
			[Left Join SigCdPit b On a.Nopers = b.Nopers ] + ;
			[Left Join SigOpMvv d On a.EmpDopNcs = d.EmpDopNcs ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalDados]) < 1)
Update LocalDados ;
Select LocalDados
	Update LocalDados Set Valors = Valors - Valpags
Select TmpCliente
	Update LocalDados Set ManterDados = 0
	Select TmpCliente
						Update LocalDados Set ManterDados = 1 Where &lcCpo. = TmpCliente.Grupo And &lcCpp. = TmpCliente.Conta
						Update LocalDados Set ManterDados = 1 Where &lcCpo. = TmpCliente.Grupo
						Update LocalDados Set ManterDados = 1 Where &lcCpp. = TmpCliente.Conta
	Select TmpCliente
	Delete From LocalDados Where ManterDados = 0
Select TmpCliente2
	Update LocalDados Set ManterDados = Iif(lnFl2 = 1, 1, 0)
	Select TmpCliente2
							Update LocalDados Set ManterDados = 0 Where &lcCpo. <> TmpCliente2.Grupo Or &lcCpp. = TmpCliente2.Conta
							Update LocalDados Set ManterDados = 0 Where &lcCpo. <> TmpCliente2.Grupo
							Update LocalDados Set ManterDados = 0 Where &lcCpp. <> TmpCliente2.Conta
							Update LocalDados Set ManterDados = 1 Where &lcCpo. = TmpCliente2.Grupo And &lcCpp. = TmpCliente2.Conta
							Update LocalDados Set ManterDados = 1 Where &lcCpo. = TmpCliente2.Grupo
							Update LocalDados Set ManterDados = 1 Where &lcCpp. = TmpCliente2.Conta
	Select TmpCliente2
	Delete From LocalDados Where ManterDados = 0
		Delete From LocalDados Where Empty(Prorrogs)
		Delete From LocalDados Where Not Empty(Prorrogs)
Select LocalDados
		lcQuery = [Select b.DatarCs ] + ;
				    [From SigCdPit a, SigCdPgr b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [ConsPgt]) < 1)
			lcQuery = [Select Datas as DataRcs ] + ;
						[From SigTtCcr ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [ConsPgt]) < 1)
	Delete From LocalDados Where Not Between(DtBaixa, pDbI, pDbF) 
	Select LocalDados
Select LocalDados
	Select LocalDados
		lcQuery = [Select * ] + ;
				    [From SigSyPar ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [LocalSyPar]) < 1)
		Select LocalSyPar
			Insert Into crFiltros (Descrs) Values (LocalSyPar.Descrs)
Select TmpCliente
Select TmpCliente2
	Select crFiltros
		lcQuery = [Select * ] + ;
				    [From SigSyPar ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSyPar]) < 1)
		Select LocalSyPar
			Insert Into crFiltros (Descrs) Values (ThisForm.poSigSyPar.pcDescs)
	Select GradeOpOpe
	If Not Seek(This.Value)
Select crFiltros
Update crSigOpOpe Set Imps = 0
Update crSigOpOpe Set Imps = 1 Where Not Empty(Dopes)
	Select TmpCliente2
	Select TmpCliente2
	Delete In TmpCliente2
Select TmpCliente2
Select TmpCliente2
	Select TmpCliente
	Select TmpCliente
	Delete In TmpCliente
Select TmpCliente
Select TmpCliente
	lcQuery = [Delete From SigSyPar ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSyPar]) < 1)
	Delete In crFiltros
Select TmpCliente
Select LocalDados
	Select LocalDados
				lcQuery = [Select NDopes, RealPrevs From SigOpOpe Where Dopes = '] + LocalDados.Dopcs + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalOpOpe]) < 1)
lcQuery = [Select Distinct a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques ] + ;
		    [From SigCdPit a, SigCdPgr b, SigCdPbx c ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [ConsPgt]) < 1)
	lcQuery = [Select Emps, Dopcs as Dopes, Numcs as Numes, Nopers, Datas as DataRcs, 0 as Acertos, ] + ;
				[From SigTtCcr ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [ConsPgt]) < 1)
			If Not Seek(LocalDados.&lcCta., [TmpContas], [IClis])
				lcQuery = [Select IClis, RClis ] + ;
						    [From SigCdCli ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
				Insert Into TmpContas (IClis, RClis) Values (LocalCli.IClis, LocalCli.RClis)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS SQL (5909 linhas total):

*-- Linhas 220 a 270:
220:     *--------------------------------------------------------------------------
221:     * CriarCursoresFiltros - Cria os cursores placeholder da Page1 ANTES do
222:     * ConfigurarPaginaFiltros() poder bindar os Grids (regra #41 - Column.
223:     * ControlSource exige que o cursor ja exista). Estrutura IDENTICA a que
224:     * CarregarTiposOperacao()/CarregarFiltrosSalvos() (SQLEXEC + SELECT INTO
225:     * CURSOR) recriam depois ("cursor placeholder = cursor real").
226:     *--------------------------------------------------------------------------
227:     PROTECTED PROCEDURE CriarCursoresFiltros()
228:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2, loc_cFiltros
229: 
230:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
231:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
232:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
233:         loc_cFiltros   = THIS.this_oBusinessObject.this_cCursorFiltros
234: 
235:         IF !USED(loc_cTipos)
236:             CREATE CURSOR (loc_cTipos) (Imps N(1,0), Dopes C(20), Opers C(2), RealPrevs N(1,0))
237:             INDEX ON Dopes TAG Dopes
238:         ENDIF
239: 
240:         IF !USED(loc_cClientes)
241:             CREATE CURSOR (loc_cClientes) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
242:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
243:             SELECT (loc_cClientes)
244:             APPEND BLANK
245:         ENDIF
246: 
247:         IF !USED(loc_cClientes2)
248:             CREATE CURSOR (loc_cClientes2) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
249:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
250:             SELECT (loc_cClientes2)
251:             APPEND BLANK
252:         ENDIF
253: 
254:         IF !USED(loc_cFiltros)
255:             CREATE CURSOR (loc_cFiltros) (Cidparams C(64), Ctpparams C(1), Mxmls M, Descrs C(40))
256:         ENDIF
257:     ENDPROC
258: 
259:     *--------------------------------------------------------------------------
260:     * ConfigurarPaginaFiltros - Monta todo o conteudo da Page1 (cabecalho,
261:     * campos de filtro, OptionGroups, grades e botoes).
262:     *--------------------------------------------------------------------------
263:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
264:         LOCAL loc_oPag
265:         loc_oPag = THIS.pgf_4c_Paginas.Page1
266: 
267:         THIS.ConfigurarCabecalhoFiltros(loc_oPag)
268:         THIS.ConfigurarCamposFiltros(loc_oPag)
269:         THIS.ConfigurarOptionGroupsFiltros(loc_oPag)
270:         THIS.ConfigurarGradesFiltros(loc_oPag)

*-- Linhas 1415 a 1460:
1415:             .FontName = "Tahoma"
1416:             .AllowHeaderSizing = .F.
1417:             .AllowRowSizing = .F.
1418:             .DeleteMark = .F.
1419:             .RecordMark = .F.
1420:             .HeaderHeight = 17
1421:             .RowHeight = 17
1422:             .ScrollBars = 2
1423:             .GridLineColor = RGB(238, 238, 238)
1424:         ENDWITH
1425: 
1426:         *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
1427:         *-- .Column1/.Column2 - evita 'Unknown member COLUMN1'.
1428:         par_oPag.grd_4c_Tipos.ColumnCount  = 2
1429:         par_oPag.grd_4c_Tipos.RecordSource = loc_cTipos
1430: 
1431:         WITH par_oPag.grd_4c_Tipos
1432:             .Column1.ControlSource = loc_cTipos + ".Imps"
1433:             .Column1.Width = 17
1434:             .Column1.Alignment = 0
1435:             .Column1.Sparse = .F.
1436:             .Column1.Header1.Caption = ""
1437:             .Column1.AddObject("Check1", "CheckBox")
1438:             .Column1.Check1.Top = 23
1439:             .Column1.Check1.Left = 35
1440:             .Column1.Check1.Width = 60
1441:             .Column1.Check1.Height = 17
1442:             .Column1.Check1.Caption = ""
1443:             .Column1.CurrentControl = "Check1"
1444: 
1445:             .Column2.ControlSource = loc_cTipos + ".Dopes"
1446:             .Column2.Width = 220
1447:             .Column2.Movable = .F.
1448:             .Column2.Resizable = .F.
1449:             .Column2.ReadOnly = .T.
1450:             .Column2.Text1.ReadOnly = .T.
1451:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
1452:             .Column2.Header1.Alignment = 2
1453:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1454: 
1455:             .Visible = .T.
1456:         ENDWITH
1457: 
1458:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "KeyPress", THIS, "ChkTipoKeyPress")
1459:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseUp", THIS, "ChkTipoMouseUp")
1460:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseDown", THIS, "ChkTipoMouseDown")

*-- Linhas 1517 a 1635:
1517:             .FontName = "Tahoma"
1518:             .AllowHeaderSizing = .F.
1519:             .AllowRowSizing = .F.
1520:             .DeleteMark = .F.
1521:             .RecordMark = .F.
1522:             .ScrollBars = 2
1523:             .GridLineColor = RGB(238, 238, 238)
1524:         ENDWITH
1525: 
1526:         *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
1527:         *-- .Column1..8 - evita 'Unknown member COLUMN1'.
1528:         loc_oGrid.ColumnCount  = 8
1529:         loc_oGrid.RecordSource = par_cCursor
1530: 
1531:         WITH loc_oGrid
1532:             .Column1.ControlSource = par_cCursor + ".Grupo"
1533:             .Column1.Width = 90
1534:             .Column1.Movable = .F.
1535:             .Column1.Resizable = .F.
1536:             .Column1.Text1.MaxLength = 10
1537:             .Column1.Header1.Caption = "Grupo"
1538:             .Column1.Header1.Alignment = 2
1539:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1540: 
1541:             .Column4.ColumnOrder = 2
1542:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1543:             .Column4.Width = 166
1544:             .Column4.Text1.MaxLength = 20
1545:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1546:             .Column4.Header1.Alignment = 2
1547:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1548: 
1549:             .Column2.ColumnOrder = 3
1550:             .Column2.ControlSource = par_cCursor + ".Conta"
1551:             .Column2.Width = 90
1552:             .Column2.Movable = .F.
1553:             .Column2.Resizable = .F.
1554:             .Column2.Text1.MaxLength = 10
1555:             .Column2.Header1.Caption = "Conta"
1556:             .Column2.Header1.Alignment = 2
1557:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1558: 
1559:             .Column3.ColumnOrder = 4
1560:             .Column3.ControlSource = par_cCursor + ".Nome"
1561:             .Column3.Width = 360
1562:             .Column3.Movable = .F.
1563:             .Column3.Resizable = .F.
1564:             .Column3.Text1.MaxLength = 50
1565:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1566:             .Column3.Header1.Alignment = 2
1567:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
1568: 
1569:             .Column5.ControlSource = par_cCursor + ".CheckE"
1570:             .Column5.Width = 17
1571:             .Column5.Sparse = .F.
1572:             .Column5.ToolTipText = "Emitente"
1573:             .Column5.Header1.Caption = "E"
1574:             .Column5.Header1.Alignment = 2
1575:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
1576:             .Column5.Header1.ToolTipText = "Emitente"
1577:             .Column5.AddObject("Check1", "CheckBox")
1578:             .Column5.Check1.Top = 31
1579:             .Column5.Check1.Left = 9
1580:             .Column5.Check1.Width = 60
1581:             .Column5.Check1.Height = 17
1582:             .Column5.Check1.Caption = ""
1583:             .Column5.Check1.ToolTipText = "Emitente"
1584:             .Column5.CurrentControl = "Check1"
1585: 
1586:             .Column6.ControlSource = par_cCursor + ".CheckP"
1587:             .Column6.Width = 17
1588:             .Column6.Sparse = .F.
1589:             .Column6.ToolTipText = "Portador"
1590:             .Column6.Header1.Caption = "P"
1591:             .Column6.Header1.Alignment = 2
1592:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
1593:             .Column6.Header1.ToolTipText = "Portador"
1594:             .Column6.AddObject("Check1", "CheckBox")
1595:             .Column6.Check1.Top = 31
1596:             .Column6.Check1.Left = 9
1597:             .Column6.Check1.Width = 60
1598:             .Column6.Check1.Height = 17
1599:             .Column6.Check1.Caption = ""
1600:             .Column6.Check1.ToolTipText = "Portador"
1601:             .Column6.CurrentControl = "Check1"
1602: 
1603:             .Column7.ControlSource = par_cCursor + ".CheckC"
1604:             .Column7.Width = 17
1605:             .Column7.Sparse = .F.
1606:             .Column7.ToolTipText = "Centro de Custo"
1607:             .Column7.Header1.Caption = "C"
1608:             .Column7.Header1.Alignment = 2
1609:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1610:             .Column7.Header1.ToolTipText = "Centro de Custo"
1611:             .Column7.AddObject("Check1", "CheckBox")
1612:             .Column7.Check1.Top = 30
1613:             .Column7.Check1.Left = 9
1614:             .Column7.Check1.Width = 60
1615:             .Column7.Check1.Height = 17
1616:             .Column7.Check1.Caption = ""
1617:             .Column7.Check1.ToolTipText = "Centro de Custo"
1618:             .Column7.CurrentControl = "Check1"
1619: 
1620:             .Column8.ControlSource = par_cCursor + ".CheckA"
1621:             .Column8.Width = 17
1622:             .Column8.Sparse = .F.
1623:             .Column8.ToolTipText = "Agente Cobrador"
1624:             .Column8.Header1.Caption = "A"
1625:             .Column8.Header1.Alignment = 2
1626:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
1627:             .Column8.Header1.ToolTipText = "Agente Cobrador"
1628:             .Column8.AddObject("Check1", "CheckBox")
1629:             .Column8.Check1.Top = 33
1630:             .Column8.Check1.Left = 11
1631:             .Column8.Check1.Width = 60
1632:             .Column8.Check1.Height = 17
1633:             .Column8.Check1.Caption = ""
1634:             .Column8.Check1.ToolTipText = "Agente Cobrador"
1635:             .Column8.CurrentControl = "Check1"

*-- Linhas 2220 a 2238:
2220:     * ValidarTitBansFiltro/AbrirLookupTitBans - Titulo Banco. Legado busca em
2221:     * GradeOpOpe (cursor local carregado de SigOpFp no Init, Where Situas In
2222:     * ('P','R','A') And Infos='K') via fwBuscaSel; aqui a mesma fonte e
2223:     * filtro vao direto no FormBuscaAuxiliar (SQLEXEC sobre a tabela, regra
2224:     * #36 - 1o argumento eh SEMPRE o handle de conexao).
2225:     *--------------------------------------------------------------------------
2226:     PROCEDURE ValidarTitBansFiltro()
2227:         LOCAL loc_oPag, loc_cValor
2228:         IF THIS.this_lEmLookup
2229:             RETURN
2230:         ENDIF
2231:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2232:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_TitBans.Value)
2233:         IF loc_cValor == THIS.this_cUltimoValidarTitBansFiltroValidado
2234:             RETURN
2235:         ENDIF
2236:         THIS.this_cUltimoValidarTitBansFiltroValidado = loc_cValor
2237:         IF EMPTY(loc_cValor)
2238:             RETURN

*-- Linhas 2248 a 2266:
2248:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2249:                 "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", par_cValor, ;
2250:                 "T" + CHR(237) + "tulo Banco", .F., .T., ;
2251:                 "Situas IN ('P','R','A') AND Infos = " + EscaparSQL("K"))
2252: 
2253:             IF VARTYPE(loc_oBusca) = "O"
2254:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2255:                     IF USED("cursor_4c_BuscaTitBan")
2256:                         THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2257:                     ENDIF
2258:                 ELSE
2259:                     IF !loc_oBusca.this_lAchouRegistro
2260:                         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2261:                         loc_oBusca.Show()
2262:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
2263:                             THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2264:                         ENDIF
2265:                     ENDIF
2266:                 ENDIF

*-- Linhas 3227 a 3323:
3227: 
3228:     *--------------------------------------------------------------------------
3229:     * ApagaClick/SelTudoClick - grdTipo: desmarca/marca todos os tipos de
3230:     * operacao (equivalente ao Update crSigOpOpe Set Imps=.. do legado).
3231:     *--------------------------------------------------------------------------
3232:     PROCEDURE ApagaClick()
3233:         LOCAL loc_cCursor
3234:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3235: 
3236:         IF USED(loc_cCursor)
3237:             SELECT (loc_cCursor)
3238:             REPLACE ALL Imps WITH 0
3239:             GO TOP
3240:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3241:         ENDIF
3242:     ENDPROC
3243: 
3244:     PROCEDURE SelTudoClick()
3245:         LOCAL loc_cCursor
3246:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3247: 
3248:         IF USED(loc_cCursor)
3249:             SELECT (loc_cCursor)
3250:             REPLACE ALL Imps WITH 1 FOR !EMPTY(Dopes)
3251:             GO TOP
3252:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3253:         ENDIF
3254:     ENDPROC
3255: 
3256:     *--------------------------------------------------------------------------
3257:     * InserirLinhaGrade/ExcluirLinhaGrade/LimparGrade - CRUD de linha
3258:     * compartilhado pelas duas grades de Grupo/Conta (equivalente aos
3259:     * btnInserir*/btnExcluir*/btnApagaG* do legado sobre TmpCliente/
3260:     * TmpCliente2).
3261:     *--------------------------------------------------------------------------
3262:     PROTECTED PROCEDURE InserirLinhaGrade(par_cCursor, par_oGrid)
3263:         IF !USED(par_cCursor)
3264:             RETURN
3265:         ENDIF
3266: 
3267:         SELECT (par_cCursor)
3268:         GO TOP
3269:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3270:         IF EOF()
3271:             APPEND BLANK
3272:             GO BOTTOM
3273:         ENDIF
3274: 
3275:         par_oGrid.Refresh()
3276:         par_oGrid.SetFocus()
3277:         par_oGrid.Column1.SetFocus()
3278:     ENDPROC
3279: 
3280:     PROTECTED PROCEDURE ExcluirLinhaGrade(par_cCursor, par_oGrid)
3281:         IF !USED(par_cCursor)
3282:             RETURN
3283:         ENDIF
3284: 
3285:         SELECT (par_cCursor)
3286:         IF !EMPTY(Grupo) OR !EMPTY(Conta)
3287:             DELETE
3288:         ENDIF
3289: 
3290:         GO TOP
3291:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3292:         IF EOF()
3293:             APPEND BLANK
3294:             GO BOTTOM
3295:         ENDIF
3296: 
3297:         par_oGrid.Refresh()
3298:         par_oGrid.SetFocus()
3299:         par_oGrid.Column1.SetFocus()
3300:     ENDPROC
3301: 
3302:     PROTECTED PROCEDURE LimparGrade(par_cCursor, par_oGrid)
3303:         IF !USED(par_cCursor)
3304:             RETURN
3305:         ENDIF
3306: 
3307:         ZAP IN (par_cCursor)
3308:         SELECT (par_cCursor)
3309:         APPEND BLANK
3310:         par_oGrid.Refresh()
3311:     ENDPROC
3312: 
3313:     PROCEDURE BtnInserirClick()
3314:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3315:     ENDPROC
3316: 
3317:     PROCEDURE BtnExcluirClick()
3318:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3319:     ENDPROC
3320: 
3321:     PROCEDURE BtnInserir2Click()
3322:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3323:     ENDPROC

*-- Linhas 3345 a 3363:
3345:     *--------------------------------------------------------------------------
3346:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3347:         IF USED(par_cCursor)
3348:             SELECT (par_cCursor)
3349:             IF !EOF()
3350:                 REPLACE (par_cCampo) WITH IIF(EVALUATE(par_cCampo) = 0, 1, 0)
3351:             ENDIF
3352:         ENDIF
3353:         par_oGrid.Refresh()
3354:     ENDPROC
3355: 
3356:     *-- grdTipo.Column1.Check1 (Imps)
3357:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3358:         IF INLIST(par_nKeyCode, 13, 32)
3359:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorTipos, "Imps", THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos)
3360:             NODEFAULT
3361:         ENDIF
3362:     ENDPROC
3363:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nX, par_nY)

*-- Linhas 3550 a 3582:
3550:             loc_cValores = THIS.SerializarFiltros()
3551:             loc_nExiste  = 0
3552: 
3553:             IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId), "cursor_4c_FiltroExiste") > 0
3554:                 loc_nExiste = cursor_4c_FiltroExiste.nExiste
3555:                 USE IN cursor_4c_FiltroExiste
3556:             ENDIF
3557: 
3558:             IF loc_nExiste > 0
3559:                 loc_cSQL = "UPDATE SigSyPar SET mxmls = " + EscaparSQL(loc_cValores) + ;
3560:                            " WHERE cidparams = " + EscaparSQL(loc_cId)
3561:             ELSE
3562:                 loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
3563:                            EscaparSQL(loc_cId) + ", " + EscaparSQL("F") + ", " + ;
3564:                            EscaparSQL(LEFT(loc_cNome, 40)) + ", " + EscaparSQL(loc_cValores) + ")"
3565:             ENDIF
3566: 
3567:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3568:                 loc_oPag.txt_4c_NewFiltro.Visible = .F.
3569:                 loc_oPag.txt_4c_Filtros.Visible   = .T.
3570:                 loc_oPag.txt_4c_Filtros.Value     = loc_cNome
3571:                 THIS.CarregarFiltrosSalvos()
3572:                 MsgInfo("Filtro grav" + CHR(225) + "do com sucesso!", "Confirmar")
3573:             ELSE
3574:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3575:             ENDIF
3576:         CATCH TO loc_oErro
3577:             MsgErro(loc_oErro.Message, "Erro")
3578:         ENDTRY
3579:     ENDPROC
3580: 
3581:     PROCEDURE CmdDelFiltroClick()
3582:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cSQL, loc_oErro

*-- Linhas 3598 a 3618:
3598: 
3599:         TRY
3600:             loc_cId  = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3601:             loc_cSQL = "DELETE FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId)
3602: 
3603:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3604:                 loc_oPag.txt_4c_Filtros.Value = ""
3605:                 THIS.CarregarFiltrosSalvos()
3606:             ELSE
3607:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3608:             ENDIF
3609:         CATCH TO loc_oErro
3610:             MsgErro(loc_oErro.Message, "Erro")
3611:         ENDTRY
3612:     ENDPROC
3613: 
3614:     *--------------------------------------------------------------------------
3615:     * GetFiltrosLostFocus - Ao sair do campo com um nome existente em
3616:     * cursor_4c_Filtros, restaura os valores salvos nos campos de filtro
3617:     * (equivalente ao mLerCfg() do Framework legado).
3618:     *--------------------------------------------------------------------------

*-- Linhas 3627 a 3645:
3627:             RETURN
3628:         ENDIF
3629: 
3630:         SELECT (loc_cCursor)
3631:         LOCATE FOR ALLTRIM(Descrs) == loc_cNome
3632: 
3633:         IF FOUND()
3634:             THIS.RestaurarFiltros(ALLTRIM(Mxmls))
3635:         ENDIF
3636:     ENDPROC
3637: 
3638:     *--------------------------------------------------------------------------
3639:     * SerializarFiltros/RestaurarFiltros - Serializacao plana (CHR(9) como
3640:     * separador) dos campos de filtro para gravar/recarregar um filtro
3641:     * nomeado em SigSyPar.Mxmls.
3642:     *--------------------------------------------------------------------------
3643:     PROTECTED PROCEDURE SerializarFiltros()
3644:         LOCAL loc_oBO
3645: 

*-- Linhas 3766 a 3811:
3766: 
3767:     *--------------------------------------------------------------------------
3768:     * CarregarTiposOperacao - Popula cursor_4c_Tipos a partir de SigOpOpe
3769:     * (equivalente ao Select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe
3770:     * Order By Dopes + Insert Into ...(0, Space(20), 'C') do legado).
3771:     *--------------------------------------------------------------------------
3772:     PROTECTED PROCEDURE CarregarTiposOperacao()
3773:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL
3774: 
3775:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3776:             RETURN
3777:         ENDIF
3778: 
3779:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorTipos
3780:         loc_cCursorTmp = loc_cCursor + "Tmp"
3781:         loc_cSQL       = "SELECT 1 AS Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes"
3782: 
3783:         *-- cursor_4c_Tipos esta ligado a grd_4c_Tipos.RecordSource - SQLEXEC
3784:         *-- direto nele zeraria o ColumnCount (regra do Grid/SQLEXEC). O
3785:         *-- SQLEXEC vai para um cursor TEMPORARIO e o placeholder (criado em
3786:         *-- CriarCursoresFiltros, com a MESMA estrutura/indice) e recarregado
3787:         *-- com ZAP + APPEND FROM DBF, preservando a estrutura do Grid.
3788:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3789:             SELECT (loc_cCursor)
3790:             ZAP
3791:             APPEND FROM DBF(loc_cCursorTmp)
3792:             IF USED(loc_cCursorTmp)
3793:                 USE IN (loc_cCursorTmp)
3794:             ENDIF
3795: 
3796:             SELECT (loc_cCursor)
3797:             APPEND BLANK
3798:             REPLACE Imps WITH 0, Dopes WITH SPACE(20), Opers WITH "C", RealPrevs WITH 0
3799:             GO TOP
3800: 
3801:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3802:         ENDIF
3803:     ENDPROC
3804: 
3805:     *--------------------------------------------------------------------------
3806:     * CarregarFiltrosSalvos - Popula cursor_4c_Filtros com os filtros
3807:     * nomeados ja gravados em SigSyPar para este form (cidparams iniciando
3808:     * por "SIGOPCGF").
3809:     *--------------------------------------------------------------------------
3810:     PROTECTED PROCEDURE CarregarFiltrosSalvos()
3811:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cId

*-- Linhas 3818 a 3846:
3818:         loc_cCursorTmp = loc_cCursor + "Tmp"
3819:         loc_cId        = PADR("SIGOPCGF", 8)
3820: 
3821:         loc_cSQL = "SELECT cidparams, ctpparams, descrs, mxmls FROM SigSyPar WHERE LEFT(cidparams, 8) = " + ;
3822:                    EscaparSQL(loc_cId) + " ORDER BY descrs"
3823: 
3824:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3825:             SELECT (loc_cCursor)
3826:             ZAP
3827:             APPEND FROM DBF(loc_cCursorTmp)
3828:             IF USED(loc_cCursorTmp)
3829:                 USE IN (loc_cCursorTmp)
3830:             ENDIF
3831:             SELECT (loc_cCursor)
3832:             GO TOP
3833:         ENDIF
3834:     ENDPROC
3835: 
3836:     *--------------------------------------------------------------------------
3837:     * BtnCarregarClick/CarregarFPubs - Carrega em grd_4c_Clientes os pares
3838:     * Grupo/Conta vinculados a Forma de Publicidade digitada (equivalente ao
3839:     * ThisForm.CarregarFPubs do legado). A checagem extra de acesso por
3840:     * usuario/conta (fAcessoContas/fChecarInativas no legado) depende de
3841:     * tabelas de controle de acesso do Framework (SigSyAgc/SigCdAcG/
3842:     * SigSyAcc) fora do escopo desta tela de filtro - o filtro principal
3843:     * (FPubls = codigo informado) e o mesmo usado pelo legado para
3844:     * restringir o universo de clientes.
3845:     *--------------------------------------------------------------------------
3846:     PROCEDURE BtnCarregarClick()

*-- Linhas 3869 a 3924:
3869:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorClientes
3870:         loc_cCursorTmp = loc_cCursor + "Tmp"
3871: 
3872:         loc_cSQL = "SELECT a.Grupos AS Grupo, b.Descrs AS NomeGrupo, a.IClis AS Conta, " + ;
3873:                    "a.RClis AS Nome, 0 AS CheckE, 0 AS CheckP, 0 AS CheckC, 0 AS CheckA " + ;
3874:                    "FROM SigCdCli a, SigCdGcr b " + ;
3875:                    "WHERE a.Grupos = b.Codigos AND a.FPubls = " + EscaparSQL(loc_cPub)
3876: 
3877:         *-- cursor_4c_Clientes esta ligado a grd_4c_Clientes.RecordSource -
3878:         *-- ZAP + APPEND FROM DBF preserva a estrutura/binding do Grid.
3879:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) > 0
3880:             SELECT (loc_cCursor)
3881:             ZAP
3882:             APPEND FROM DBF(loc_cCursorTmp)
3883:             IF USED(loc_cCursorTmp)
3884:                 USE IN (loc_cCursorTmp)
3885:             ENDIF
3886:             SELECT (loc_cCursor)
3887:             GO TOP
3888:             loc_oPag.grd_4c_Clientes.Refresh()
3889:         ELSE
3890:             MsgAviso("Nenhum cliente encontrado para a Forma de Publicidade [" + loc_cPub + "].", "Aten" + CHR(231) + CHR(227) + "o")
3891:         ENDIF
3892:     ENDPROC
3893: 
3894:     *--------------------------------------------------------------------------
3895:     * ConfigurarGradeDados - cria grd_4c_Dados (grade de resultado da
3896:     * consulta, equivalente a grdDados1/LocalDados do legado). SO estrutura
3897:     * estatica (posicao/tamanho/propriedades de grade) - ColumnCount/
3898:     * RecordSource/ControlSource ficam em MontarGradeDados(), chamado DEPOIS
3899:     * de Processamento() povoar cursor_4c_Dados (regra #41 do CLAUDE.md:
3900:     * ControlSource de cursor que ainda nao existe derruba o Init).
3901:     *--------------------------------------------------------------------------
3902:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3903:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3904:         WITH par_oPag.grd_4c_Dados
3905:             .Top               = 202
3906:             .Left              = 7
3907:             .Width             = 986
3908:             .Height            = 355
3909:             .DeleteMark        = .F.
3910:             .RecordMark        = .F.
3911:             .ReadOnly          = .T.
3912:             .AllowHeaderSizing = .F.
3913:             .AllowRowSizing    = .F.
3914:             .GridLineColor     = RGB(238, 238, 238)
3915:             .ScrollBars        = 2
3916:             .Visible           = .T.
3917:         ENDWITH
3918:         BINDEVENT(par_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
3919:     ENDPROC
3920: 
3921:     *--------------------------------------------------------------------------
3922:     * MontarGradeDados - Equivalente a ThisForm.MontaGradeD do legado. Religa
3923:     * as 12 colunas a cursor_4c_Dados. RecordSource reseta Column.Width e
3924:     * Header1.Caption (regra #48) - por isso TUDO e refeito aqui, sempre

*-- Linhas 3941 a 4005:
3941:         loc_oGrid.RecordSource = loc_cCursor
3942: 
3943:         WITH loc_oGrid
3944:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3945:             .Column1.Width           = 64
3946:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3947: 
3948:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3949:             .Column2.Width           = 64
3950:             .Column2.Header1.Caption = "Vencto."
3951: 
3952:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3953:             .Column3.Width           = 64
3954:             .Column3.Header1.Caption = "Lancto."
3955: 
3956:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3957:             .Column4.Width           = 64
3958:             .Column4.Header1.Caption = "Baixa"
3959: 
3960:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3961:             .Column5.Width           = 70
3962:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3963: 
3964:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3965:             .Column6.Width           = 240
3966:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3967: 
3968:             .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
3969:             .Column7.Width           = 20
3970:             .Column7.Header1.Caption = "$"
3971: 
3972:             .Column8.ControlSource   = loc_cCursor + ".Valors"
3973:             .Column8.Width           = 68
3974:             .Column8.Header1.Caption = "Valor"
3975: 
3976:             *-- Legado usa goSistema.TxtDebito/TxtCredito (rotulo customizavel
3977:             *-- por cliente) - essa customizacao NAO foi portada; caption fixo.
3978:             .Column9.ControlSource   = loc_cCursor + ".Debitos"
3979:             .Column9.Width           = 68
3980:             .Column9.Header1.Caption = "D" + CHR(233) + "bito"
3981: 
3982:             .Column10.ControlSource   = loc_cCursor + ".Creditos"
3983:             .Column10.Width           = 68
3984:             .Column10.Header1.Caption = "Cr" + CHR(233) + "dito"
3985: 
3986:             .Column11.ControlSource   = loc_cCursor + ".SaldoDia"
3987:             .Column11.Width           = 82
3988:             .Column11.Header1.Caption = "Saldo"
3989: 
3990:             .Column12.ControlSource   = loc_cCursor + ".SaldoTot"
3991:             .Column12.Width           = 82
3992:             .Column12.Header1.Caption = "Acumulado"
3993: 
3994:             .SetAll("DynamicBackColor", loc_cCor, "Column")
3995:             .FontName = "Arial"
3996:             .SetAll("Movable", .F., "Column")
3997:             .SetAll("Resizable", .F., "Column")
3998:             .SetAll("ReadOnly", .T., "Column")
3999:         ENDWITH
4000: 
4001:         GO TOP IN (loc_cCursor)
4002:         loc_oGrid.Refresh()
4003:     ENDPROC
4004: 
4005:     *--------------------------------------------------------------------------

*-- Linhas 4080 a 4110:
4080: 
4081:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorContas
4082:         IF !USED(loc_cCursor)
4083:             CREATE CURSOR (loc_cCursor) (IClis C(10), RClis C(50))
4084:             INDEX ON IClis TAG IClis
4085:         ENDIF
4086: 
4087:         SELECT (loc_cCursor)
4088:         IF SEEK(PADR(loc_cCodigo, 10), loc_cCursor, "IClis")
4089:             RETURN ALLTRIM(RClis)
4090:         ENDIF
4091: 
4092:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
4093:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp") > 0
4094:             IF !EOF("cursor_4c_RazaoTmp")
4095:                 INSERT INTO (loc_cCursor) (IClis, RClis) VALUES ;
4096:                     (PADR(ALLTRIM(cursor_4c_RazaoTmp.IClis), 10), cursor_4c_RazaoTmp.RClis)
4097:                 loc_cResultado = ALLTRIM(cursor_4c_RazaoTmp.RClis)
4098:             ENDIF
4099:             IF USED("cursor_4c_RazaoTmp")
4100:                 USE IN cursor_4c_RazaoTmp
4101:             ENDIF
4102:         ENDIF
4103: 
4104:         RETURN loc_cResultado
4105:     ENDFUNC
4106: 
4107:     *--------------------------------------------------------------------------
4108:     * CboOrdemInteractiveChange / ChkTotaisClick - equivalentes ao
4109:     * InteractiveChange de cmbOrdem e ao Valid de chkTotais: atualizam
4110:     * this_cOrdem/this_nOrdem e reordenam a grade (OrdenaGrade).

*-- Linhas 4161 a 4179:
4161: 
4162:         loc_cOrd = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "", "_") + loc_oBO.this_cOrdem
4163: 
4164:         SELECT (loc_cCursor)
4165:         SET ORDER TO TAG (loc_cOrd)
4166: 
4167:         IF INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
4168:             THIS.CalcSaldoCta()
4169:         ELSE
4170:             THIS.CalcSaldo()
4171:         ENDIF
4172: 
4173:         GO TOP IN (loc_cCursor)
4174:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
4175:     ENDPROC
4176: 
4177:     *--------------------------------------------------------------------------
4178:     * CalcSaldo - transcricao literal de ThisForm.CalcSaldo: recalcula
4179:     * Debitos/Creditos/SaldoDia/SaldoTot linha a linha e insere as linhas

*-- Linhas 4190 a 4227:
4190:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4191:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4192: 
4193:         SELECT (loc_cCursor)
4194:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4195: 
4196:         loc_nSdD = 0
4197:         loc_nSD1 = 0
4198:         loc_nSC1 = 0
4199:         loc_nSD2 = 0
4200:         loc_nSC2 = 0
4201:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4202:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4203:         loc_nOrd = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value
4204: 
4205:         IF USED(loc_cTotais)
4206:             USE IN (loc_cTotais)
4207:         ENDIF
4208:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4209: 
4210:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4211: 
4212:         SELECT (loc_cCursor)
4213:         GO TOP
4214:         loc_dDat = TTOD(DtEmis)
4215:         DO CASE
4216:         CASE loc_nOrd = 2
4217:             loc_dDat = TTOD(Vencs)
4218:         CASE loc_nOrd = 3
4219:             loc_dDat = TTOD(Datas)
4220:         CASE loc_nOrd = 4
4221:             loc_dDat = TTOD(DtBaixa)
4222:         ENDCASE
4223: 
4224:         loc_cMoe = ALLTRIM(Moedas)
4225: 
4226:         IF !EMPTY(loc_nSdT)
4227:             IF (loc_cMsd <> loc_cMoe)

*-- Linhas 4246 a 4268:
4246:             m.OrdHs    = "1"
4247:             m.Titulos  = ""
4248: 
4249:             INSERT INTO (loc_cTotais) FROM MEMVAR
4250:             REPLACE SInis WITH 1 IN (loc_cTotais)
4251:         ENDIF
4252: 
4253:         SELECT (loc_cCursor)
4254:         SCAN
4255:             loc_dRla = TTOD(DtEmis)
4256:             DO CASE
4257:             CASE loc_nOrd = 2
4258:                 loc_dRla = TTOD(Vencs)
4259:             CASE loc_nOrd = 3
4260:                 loc_dRla = TTOD(Datas)
4261:             CASE loc_nOrd = 4
4262:                 loc_dRla = TTOD(DtBaixa)
4263:             ENDCASE
4264: 
4265:             IF (loc_cMoe <> ALLTRIM(Moedas))
4266:                 SCATTER MEMVAR
4267:                 m.Nopers   = 9999999
4268:                 m.Valors   = 0

*-- Linhas 4278 a 4296:
4278:                 m.Moedas   = loc_cMoe
4279:                 m.OrdHs    = CHR(254)
4280:                 m.Titulos  = REPLICATE(CHR(254), 10)
4281:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4282:                 loc_nSD1 = 0
4283:                 loc_nSC1 = 0
4284: 
4285:                 IF INLIST(loc_cOrdem, "Titulos", "Hists")
4286:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
4287:                     loc_nSdD = 0
4288:                 ENDIF
4289:             ENDIF
4290: 
4291:             IF !INLIST(loc_cOrdem, "Titulos", "Hists")
4292:                 IF ((loc_dDat <> loc_dRla) OR (loc_cMoe <> ALLTRIM(Moedas))) AND INLIST(loc_nOrd, 1, 2, 3, 4)
4293:                     SCATTER MEMVAR
4294:                     m.Nopers   = 9999998
4295:                     m.Valors   = 0
4296:                     m.DtEmis   = loc_dDat

*-- Linhas 4303 a 4321:
4303:                     m.SaldoDia = loc_nSdD
4304:                     m.SaldoTot = loc_nSdT
4305:                     m.Moedas   = loc_cMoe
4306:                     INSERT INTO (loc_cTotais) FROM MEMVAR
4307: 
4308:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
4309:                     loc_nSdD = 0
4310:                     loc_nSD2 = 0
4311:                     loc_nSC2 = 0
4312:                 ENDIF
4313:             ENDIF
4314: 
4315:             loc_dDat = loc_dRla
4316:             loc_cMoe = ALLTRIM(Moedas)
4317:             loc_nVal = ABS(Valors)
4318: 
4319:             loc_nSdD = loc_nSdD + (loc_nVal * IIF(Opers = "D", 1, -1))
4320:             loc_nSdT = loc_nSdT + (loc_nVal * IIF(Opers = "D", 1, -1))
4321: 

*-- Linhas 4330 a 4429:
4330:                     SaldoTot WITH loc_nSdT
4331:         ENDSCAN
4332: 
4333:         SELECT (loc_cCursor)
4334:         SKIP -1
4335:         IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
4336:             IF !INLIST(loc_cOrdem, "Titulos", "Hists")
4337:                 SCATTER MEMVAR
4338:                 m.Nopers   = 9999998
4339:                 m.Valors   = 0
4340:                 m.DtEmis   = loc_dDat
4341:                 m.Vencs    = loc_dDat
4342:                 m.Datas    = loc_dDat
4343:                 m.DtBaixa  = loc_dDat
4344:                 m.Hists    = "Saldo do dia " + DTOC(loc_dDat) + ":"
4345:                 m.Debitos  = loc_nSD2
4346:                 m.Creditos = loc_nSC2
4347:                 m.SaldoDia = loc_nSdD
4348:                 m.SaldoTot = loc_nSdT
4349:                 m.Moedas   = loc_cMoe
4350:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4351:             ENDIF
4352: 
4353:             SCATTER MEMVAR
4354:             m.Nopers   = 9999999
4355:             m.Valors   = 0
4356:             m.DtEmis   = loc_dDat
4357:             m.Vencs    = loc_dDat
4358:             m.Datas    = loc_dDat
4359:             m.DtBaixa  = loc_dDat
4360:             m.Hists    = "Saldo da Moeda " + loc_cMoe + ":"
4361:             m.Debitos  = loc_nSD1
4362:             m.Creditos = loc_nSC1
4363:             m.SaldoDia = loc_nSdD
4364:             m.SaldoTot = loc_nSdT
4365:             m.Moedas   = loc_cMoe
4366:             m.OrdHs    = CHR(254)
4367:             m.Titulos  = REPLICATE(CHR(254), 10)
4368:             INSERT INTO (loc_cTotais) FROM MEMVAR
4369:         ENDIF
4370: 
4371:         SELECT (loc_cTotais)
4372:         SCAN
4373:             SCATTER MEMVAR
4374:             INSERT INTO (loc_cCursor) FROM MEMVAR
4375:         ENDSCAN
4376: 
4377:         GO TOP IN (loc_cCursor)
4378:     ENDPROC
4379: 
4380:     *--------------------------------------------------------------------------
4381:     * CalcSaldoCta - transcricao literal de ThisForm.CalcSaldoCta: mesma
4382:     * logica de CalcSaldo, mas agrupando por Emitente (ContEms) ou Portador
4383:     * (Contas) em vez de por data, com a razao social (ObterRazaoSocial)
4384:     * compondo a linha sintetica de saldo.
4385:     *--------------------------------------------------------------------------
4386:     PROTECTED PROCEDURE CalcSaldoCta()
4387:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4388:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4389:         LOCAL loc_cMsd, loc_dDat, loc_cMoe, loc_cEmi, loc_cPor, loc_nVal
4390: 
4391:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4392:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4393:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4394:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4395: 
4396:         SELECT (loc_cCursor)
4397:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4398: 
4399:         loc_nSdD = 0
4400:         loc_nSD1 = 0
4401:         loc_nSC1 = 0
4402:         loc_nSD2 = 0
4403:         loc_nSC2 = 0
4404:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4405:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4406: 
4407:         IF USED(loc_cTotais)
4408:             USE IN (loc_cTotais)
4409:         ENDIF
4410:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4411: 
4412:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4413: 
4414:         SELECT (loc_cCursor)
4415:         GO TOP
4416:         loc_dDat = TTOD(DtEmis)
4417:         loc_cMoe = ALLTRIM(Moedas)
4418:         loc_cEmi = ALLTRIM(ContEms)
4419:         loc_cPor = ALLTRIM(Contas)
4420: 
4421:         SCAN
4422:             IF (loc_cMoe <> ALLTRIM(Moedas)) OR ;
4423:                (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4424:                (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor)
4425: 
4426:                 SCATTER MEMVAR
4427:                 m.Nopers   = 9999999
4428:                 m.Valors   = 0
4429:                 m.DtEmis   = loc_dDat

*-- Linhas 4454 a 4472:
4454:                 m.Contas   = loc_cPor
4455:                 m.OrdHs    = CHR(254)
4456:                 m.Titulos  = REPLICATE(CHR(254), 10)
4457:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4458:                 loc_nSD1 = 0
4459:                 loc_nSC1 = 0
4460: 
4461:                 IF INLIST(loc_cOrdem, "Titulos", "Hists", "ContEms", "Contas")
4462:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas) OR ;
4463:                                    (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4464:                                    (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor), 0, loc_nSdT)
4465:                     loc_nSdD = 0
4466:                 ENDIF
4467:             ENDIF
4468: 
4469:             loc_cMoe = ALLTRIM(Moedas)
4470:             loc_cEmi = ALLTRIM(ContEms)
4471:             loc_cPor = ALLTRIM(Contas)
4472:             loc_nVal = ABS(Valors)

*-- Linhas 4485 a 4503:
4485:                     SaldoTot WITH loc_nSdT
4486:         ENDSCAN
4487: 
4488:         SELECT (loc_cCursor)
4489:         SKIP -1
4490:         IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
4491:             SCATTER MEMVAR
4492:             m.Nopers   = 9999999
4493:             m.Valors   = 0
4494:             m.DtEmis   = loc_dDat
4495:             m.Vencs    = loc_dDat
4496:             m.Datas    = loc_dDat
4497:             m.DtBaixa  = loc_dDat
4498:             m.Hists    = ""
4499:             IF (loc_cOrdem = "ContEms")
4500:                 m.Hists = "Saldo " + ALLTRIM(loc_cMoe)
4501:                 IF !EMPTY(loc_cEmi)
4502:                     m.Hists = m.Hists + " / " + loc_cEmi + " " + ALLTRIM(THIS.ObterRazaoSocial(loc_cEmi))
4503:                 ENDIF

*-- Linhas 4517 a 4541:
4517:             m.Moedas   = loc_cMoe
4518:             m.OrdHs    = CHR(254)
4519:             m.Titulos  = REPLICATE(CHR(254), 10)
4520:             INSERT INTO (loc_cTotais) FROM MEMVAR
4521:         ENDIF
4522: 
4523:         SELECT (loc_cTotais)
4524:         SCAN
4525:             SCATTER MEMVAR
4526:             INSERT INTO (loc_cCursor) FROM MEMVAR
4527:         ENDSCAN
4528: 
4529:         GO TOP IN (loc_cCursor)
4530:     ENDPROC
4531: 
4532:     *--------------------------------------------------------------------------
4533:     * AplicarFiltroGrupoContaManter / AplicarFiltroGrupoContaExcluirTodas -
4534:     * helpers do filtro de Grupo/Conta informado nas duas grades de
4535:     * selecao (cursor_4c_Clientes/cursor_4c_Clientes2), transcritos do Do
4536:     * Case do Processamento legado. A versao "ExcluirTodas" preserva, de
4537:     * proposito, a assimetria do dump original (quando os DOIS campos estao
4538:     * preenchidos, o grupo usa "<>" e a conta usa "=" em vez de "<>") -
4539:     * regra #17 do CLAUDE.md: transcrever, nunca reescrever.
4540:     *--------------------------------------------------------------------------
4541:     PROTECTED PROCEDURE AplicarFiltroGrupoContaManter(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)

*-- Linhas 4556 a 4595:
4556:             RETURN
4557:         ENDCASE
4558: 
4559:         UPDATE (par_cCursorDados) SET ManterDados = 1 WHERE &loc_cWhere.
4560:     ENDPROC
4561: 
4562:     PROTECTED PROCEDURE AplicarFiltroGrupoContaExcluirTodas(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4563:         LOCAL loc_cWhere
4564: 
4565:         IF EMPTY(par_cColGrupo)
4566:             RETURN
4567:         ENDIF
4568: 
4569:         DO CASE
4570:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4571:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "' OR " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4572:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4573:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "'"
4574:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4575:             loc_cWhere = par_cColConta + " <> '" + ALLTRIM(par_cConta) + "'"
4576:         OTHERWISE
4577:             RETURN
4578:         ENDCASE
4579: 
4580:         UPDATE (par_cCursorDados) SET ManterDados = 0 WHERE &loc_cWhere.
4581:     ENDPROC
4582: 
4583:     *--------------------------------------------------------------------------
4584:     * DataFimDiaSQL - monta o literal SQL Server do limite SUPERIOR de uma
4585:     * faixa de data (23:59:59), equivalente a fDtoSql(valor, [23:59:59]) do
4586:     * legado. Data vazia usa o sentinela 31/12/2099 (igual ao legado).
4587:     *--------------------------------------------------------------------------
4588:     PROTECTED FUNCTION DataFimDiaSQL(par_dData)
4589:         LOCAL loc_dData
4590:         loc_dData = par_dData
4591:         IF EMPTY(loc_dData)
4592:             loc_dData = {^2099-12-31}
4593:         ENDIF
4594:         RETURN "'" + PADL(YEAR(loc_dData), 4, "0") + "-" + PADL(MONTH(loc_dData), 2, "0") + "-" + ;
4595:                PADL(DAY(loc_dData), 2, "0") + " 23:59:59'"

*-- Linhas 4630 a 4694:
4630:         IF !EMPTY(loc_oPag1.txt_4c_Empresa.Value)
4631:             loc_cCodEmp = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
4632:             loc_cRes = loc_cRes + " / Empresa: " + loc_cCodEmp
4633:             loc_cEmp = " AND (CASE WHEN a.EmpCcs <> '' AND a.EmpCcs = " + EscaparSQL(loc_cCodEmp) + " THEN 1 " + ;
4634:                        "ELSE CASE WHEN a.EmpCcs = '' AND a.Emps = " + EscaparSQL(loc_cCodEmp) + " THEN 1 ELSE 0 END END) = 1"
4635:         ENDIF
4636: 
4637:         *-- Emissao
4638:         loc_cDem = ""
4639:         IF !EMPTY(loc_oPag1.txt_4c_DtEmiI.Value)
4640:             loc_dDeI = loc_oPag1.txt_4c_DtEmiI.Value
4641:             loc_dDeF = loc_oPag1.txt_4c_DtEmiF.Value
4642:             loc_cDem = " AND (a.DtEmis BETWEEN " + FormatarDataSQL(loc_dDeI) + " AND " + THIS.DataFimDiaSQL(loc_dDeF) + ;
4643:                        IIF(loc_oPag1.chk_4c_Brancos.Value = 0, "", " OR a.DtEmis IS NULL") + ")"
4644:             loc_cRes = loc_cRes + " / Emiss" + CHR(227) + "o: " + DTOC(loc_dDeI) + " a " + ;
4645:                        DTOC(IIF(EMPTY(loc_dDeF), {^2099-12-31}, loc_dDeF))
4646:         ENDIF
4647: 
4648:         *-- Vencimento
4649:         loc_cDvc = ""
4650:         IF !EMPTY(loc_oPag1.txt_4c_VencsI.Value)
4651:             loc_dDvI = loc_oPag1.txt_4c_VencsI.Value
4652:             loc_dDvF = loc_oPag1.txt_4c_VencsF.Value
4653:             loc_cDvc = " AND a.Vencs BETWEEN " + FormatarDataSQL(loc_dDvI) + " AND " + THIS.DataFimDiaSQL(loc_dDvF)
4654:             loc_cRes = loc_cRes + " / Vencimento: " + DTOC(loc_dDvI) + " a " + ;
4655:                        DTOC(IIF(EMPTY(loc_dDvF), {^2099-12-31}, loc_dDvF))
4656:         ENDIF
4657: 
4658:         *-- Lancamento
4659:         loc_cDla = ""
4660:         IF !EMPTY(loc_oPag1.txt_4c_DatasI.Value)
4661:             loc_dDlI = loc_oPag1.txt_4c_DatasI.Value
4662:             loc_dDlF = loc_oPag1.txt_4c_DatasF.Value
4663:             loc_cDla = " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDlI) + " AND " + THIS.DataFimDiaSQL(loc_dDlF)
4664:             loc_cRes = loc_cRes + " / Lan" + CHR(231) + "amento: " + DTOC(loc_dDlI) + " a " + ;
4665:                        DTOC(IIF(EMPTY(loc_dDlF), {^2099-12-31}, loc_dDlF))
4666:         ENDIF
4667: 
4668:         *-- Acerto (data de baixa) - o legado comenta o fragmento no WHERE
4669:         *-- (lcDbx fica so na descricao); o filtro real roda DEPOIS do
4670:         *-- preenchimento da Data de Baixa, mais abaixo neste metodo.
4671:         IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
4672:             loc_cRes = loc_cRes + " / Acerto: " + DTOC(loc_oPag1.txt_4c_DtBxI.Value) + " a " + ;
4673:                        DTOC(IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value))
4674:         ENDIF
4675: 
4676:         *-- Moeda filtro
4677:         loc_cMoe = ""
4678:         IF !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
4679:             loc_cMoe = " AND a.Moedas = " + EscaparSQL(ALLTRIM(loc_oPag1.txt_4c_CMoes.Value))
4680:             loc_cRes = loc_cRes + " / Moeda Filtro: " + ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
4681:         ENDIF
4682: 
4683:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4684:             loc_cRes = loc_cRes + " / Moeda Convers" + CHR(227) + "o: " + ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value) + " (" + ;
4685:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 1, "Emiss" + CHR(227) + "o", ;
4686:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 2, "Vencimento", ;
4687:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 3, "Lan" + CHR(231) + "amento", ;
4688:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 4, "Data Atual", "Data Acerto")))) + ")"
4689:         ENDIF
4690: 
4691:         *-- Pagamento
4692:         loc_cPag = ""
4693:         IF loc_oPag1.opt_4c_Pagos.Value <> 1
4694:             loc_cPag = " AND a.Pagos = " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "'0'", "'1'")

*-- Linhas 4724 a 4894:
4724:         *-- Titulo / Nota Fiscal / Titulo Banco / Especie
4725:         loc_cTit = ""
4726:         IF !EMPTY(loc_oPag1.txt_4c_Titulos.Value)
4727:             loc_cTit = " AND a.Titulos = " + EscaparSQL(loc_oPag1.txt_4c_Titulos.Value)
4728:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo: " + ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
4729:         ENDIF
4730: 
4731:         loc_cNfs = ""
4732:         IF !EMPTY(loc_oPag1.txt_4c_NFs.Value)
4733:             loc_cNfs = " AND a.NFs = " + EscaparSQL(loc_oPag1.txt_4c_NFs.Value)
4734:             loc_cRes = loc_cRes + " / Nota Fiscal: " + ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
4735:         ENDIF
4736: 
4737:         loc_cTba = ""
4738:         IF !EMPTY(loc_oPag1.txt_4c_TitBans.Value)
4739:             loc_cTba = " AND a.TitBans = " + EscaparSQL(loc_oPag1.txt_4c_TitBans.Value)
4740:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo Banco: " + ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
4741:         ENDIF
4742: 
4743:         loc_cEsp = ""
4744:         IF !EMPTY(loc_oPag1.txt_4c_EspecieNfs.Value)
4745:             loc_cEsp = " AND a.EspecieNfs = " + EscaparSQL(loc_oPag1.txt_4c_EspecieNfs.Value)
4746:             loc_cRes = loc_cRes + " / Esp" + CHR(233) + "cie: " + ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
4747:         ENDIF
4748: 
4749:         IF !EMPTY(loc_oPag1.txt_4c_Saldo.Value)
4750:             loc_cRes = loc_cRes + " / Saldo Inicial: " + ALLTRIM(TRANSFORM(loc_oPag1.txt_4c_Saldo.Value, "999999999999.99")) + ;
4751:                        " " + ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4752:         ENDIF
4753: 
4754:         *-- Filtro de Movimentacao de Titulos (grd_4c_Tipos - cursor_4c_Tipos.Imps=1)
4755:         loc_cOpT = ""
4756:         SELECT (loc_oBO.this_cCursorTipos)
4757:         GO TOP
4758:         COUNT FOR Imps = 1 TO loc_nOpe
4759: 
4760:         DO CASE
4761:         CASE loc_nOpe = 1
4762:             GO TOP
4763:             LOCATE FOR Imps = 1
4764:             loc_cOpT = " AND a.Dopcs = " + EscaparSQL(ALLTRIM(Dopes))
4765:             loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: " + ALLTRIM(Dopes)
4766:         CASE loc_nOpe > 1
4767:             loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: "
4768:             loc_lPrimeira = .T.
4769:             loc_cOpT = " AND a.Dopcs IN ("
4770:             SCAN
4771:                 IF Imps = 1
4772:                     loc_cOpT = loc_cOpT + IIF(loc_lPrimeira, "", ",") + EscaparSQL(ALLTRIM(Dopes))
4773:                     loc_cRes = loc_cRes + IIF(loc_lPrimeira, "", ", ") + ALLTRIM(Dopes)
4774:                     loc_lPrimeira = .F.
4775:                 ENDIF
4776:             ENDSCAN
4777:             loc_cOpT = loc_cOpT + ")"
4778:         OTHERWISE
4779:             *-- Nao faz nada: carrega todos os lancamentos
4780:         ENDCASE
4781: 
4782:         *-- Consulta principal (SigMvCcr + SigCdPit + SigOpMvv)
4783:         loc_cCursorTmp = loc_cCursor + "Tmp"
4784:         loc_cSQL = "SELECT a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
4785:                    "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
4786:                    "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Moedas AS MoeOrigs, a.Cotacaos, a.ValOcurs, " + ;
4787:                    "a.Saldos, a.ValPags, a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, " + ;
4788:                    "a.Emps, a.Dopcs, a.EmpDopNums, a.EmpDopNcs, 1 AS ManterDados, a.DtEmis AS DtBaixa, " + ;
4789:                    "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoDia, CAST(9999999999.99 AS NUMERIC(15,2)) AS Debitos, " + ;
4790:                    "'8' AS OrdHs, a.Numes, a.Numcs, a.VOpers, " + ;
4791:                    "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoTot, CAST(9999999999.99 AS NUMERIC(15,2)) AS Creditos, " + ;
4792:                    "MAX(d.Vencs) AS Prorrogs, 0 AS SInis " + ;
4793:                    "FROM SigMvCcr a " + ;
4794:                    "LEFT JOIN SigCdPit b ON a.Nopers = b.Nopers " + ;
4795:                    "LEFT JOIN SigOpMvv d ON a.EmpDopNcs = d.EmpDopNcs " + ;
4796:                    "WHERE 0 = 0 " + loc_cEmp + loc_cDem + loc_cDvc + loc_cDla + loc_cMoe + loc_cPag + loc_cOpc + ;
4797:                    loc_cTit + loc_cNfs + loc_cTba + loc_cEsp + loc_cCan + loc_cCcl + loc_cOpT + " " + ;
4798:                    "GROUP BY a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
4799:                    "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
4800:                    "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Cotacaos, a.ValOcurs, a.Saldos, a.ValPags, " + ;
4801:                    "a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, a.Emps, a.Dopcs, " + ;
4802:                    "a.EmpDopNums, a.EmpDopNcs, a.Numes, a.Numcs, a.VOpers"
4803: 
4804:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) < 1
4805:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
4806:             RETURN .F.
4807:         ENDIF
4808: 
4809:         IF USED(loc_cCursor)
4810:             USE IN (loc_cCursor)
4811:         ENDIF
4812:         SELECT * FROM (loc_cCursorTmp) INTO CURSOR (loc_cCursor) READWRITE
4813:         IF USED(loc_cCursorTmp)
4814:             USE IN (loc_cCursorTmp)
4815:         ENDIF
4816: 
4817:         SELECT (loc_cCursor)
4818:         REPLACE ALL Saldos   WITH 0, ;
4819:                     DtBaixa  WITH CTOT(""), ;
4820:                     DtEmis   WITH TratarNulo(DtEmis, CTOT("")), ;
4821:                     Vencs    WITH TratarNulo(Vencs, CTOT("")), ;
4822:                     Datas    WITH TratarNulo(Datas, CTOT("")), ;
4823:                     Prorrogs WITH TratarNulo(Prorrogs, CTOT(""))
4824: 
4825:         SELECT (loc_cCursor)
4826:         GO TOP
4827:         IF EOF()
4828:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4829:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4830:             RETURN .F.
4831:         ENDIF
4832: 
4833:         IF loc_oPag1.chk_4c_ValPends.Value = 1
4834:             REPLACE ALL Valors WITH Valors - ValPags
4835:         ENDIF
4836: 
4837:         *-- Filtrando Grupos/Contas informados na grade 1 (cursor_4c_Clientes)
4838:         SELECT (loc_oBO.this_cCursorClientes)
4839:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4840:         IF FOUND()
4841:             UPDATE (loc_cCursor) SET ManterDados = 0
4842: 
4843:             SELECT (loc_oBO.this_cCursorClientes)
4844:             SCAN
4845:                 IF CheckE = 1
4846:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4847:                 ENDIF
4848:                 IF CheckP = 1
4849:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4850:                 ENDIF
4851:                 IF CheckC = 1
4852:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4853:                 ENDIF
4854:                 IF CheckA = 1
4855:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4856:                 ENDIF
4857:             ENDSCAN
4858: 
4859:             loc_cRes = loc_cRes + " / Grupos-Contas: "
4860:             SELECT (loc_oBO.this_cCursorClientes)
4861:             SCAN
4862:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4863:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4864:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4865:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4866:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4867:             ENDSCAN
4868: 
4869:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4870:         ENDIF
4871: 
4872:         *-- Filtrando Grupos/Contas informados na grade 2 (Todas/Alguma)
4873:         loc_nFl2 = loc_oPag1.opt_4c_FilGrd2.Value
4874:         SELECT (loc_oBO.this_cCursorClientes2)
4875:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4876:         IF FOUND()
4877:             UPDATE (loc_cCursor) SET ManterDados = IIF(loc_nFl2 = 1, 1, 0)
4878: 
4879:             SELECT (loc_oBO.this_cCursorClientes2)
4880:             SCAN
4881:                 IF loc_nFl2 = 1
4882:                     IF CheckE = 1
4883:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4884:                     ENDIF
4885:                     IF CheckP = 1
4886:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4887:                     ENDIF
4888:                     IF CheckC = 1
4889:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4890:                     ENDIF
4891:                     IF CheckA = 1
4892:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4893:                     ENDIF
4894:                 ELSE

*-- Linhas 4908 a 4992:
4908:             ENDSCAN
4909: 
4910:             loc_cRes = loc_cRes + " / Grupos-Contas (" + IIF(loc_nFl2 = 1, "Todas", "Alguma") + "): "
4911:             SELECT (loc_oBO.this_cCursorClientes2)
4912:             SCAN
4913:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4914:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4915:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4916:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4917:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4918:             ENDSCAN
4919: 
4920:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4921:         ENDIF
4922: 
4923:         *-- Filtrando os Titulos Prorrogados
4924:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4925:             IF loc_oPag1.opt_4c_Prorrogs.Value = 2
4926:                 DELETE FROM (loc_cCursor) WHERE EMPTY(Prorrogs)
4927:             ELSE
4928:                 DELETE FROM (loc_cCursor) WHERE !EMPTY(Prorrogs)
4929:             ENDIF
4930:         ENDIF
4931: 
4932:         *-- Preenchendo a Data da Baixa (titulos em aberto, Pagos = "0")
4933:         SELECT (loc_cCursor)
4934:         SCAN FOR Pagos = "0"
4935:             loc_nNop = Nopers
4936:             loc_cSQL = "SELECT b.DatarCs FROM SigCdPit a, SigCdPgr b " + ;
4937:                        "WHERE a.Nopers = " + FormatarNumeroSQL(loc_nNop, 0) + " AND a.EmpDopNums = b.EmpDopNums " + ;
4938:                        "ORDER BY b.DatarCs DESC"
4939:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4940:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
4941:                 RETURN .F.
4942:             ENDIF
4943:             IF !EOF("cursor_4c_ConsPgtDtBx")
4944:                 REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DatarCs IN (loc_cCursor)
4945:             ELSE
4946:                 IF USED("cursor_4c_ConsPgtDtBx")
4947:                     USE IN cursor_4c_ConsPgtDtBx
4948:                 ENDIF
4949:                 loc_cSQL = "SELECT Datas AS DataRcs FROM SigTtCcr WHERE NOpers = " + FormatarNumeroSQL(loc_nNop, 0) + " " + ;
4950:                            "ORDER BY Datas DESC"
4951:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4952:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
4953:                     RETURN .F.
4954:                 ENDIF
4955:                 IF !EOF("cursor_4c_ConsPgtDtBx")
4956:                     REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DataRcs IN (loc_cCursor)
4957:                 ENDIF
4958:             ENDIF
4959:             IF USED("cursor_4c_ConsPgtDtBx")
4960:                 USE IN cursor_4c_ConsPgtDtBx
4961:             ENDIF
4962:             SELECT (loc_cCursor)
4963:         ENDSCAN
4964: 
4965:         *-- Filtro de Acerto (Data de Baixa), aplicado SO depois do
4966:         *-- preenchimento acima - igual ao legado.
4967:         IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
4968:             loc_dPbI = loc_oPag1.txt_4c_DtBxI.Value
4969:             loc_dPbF = IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value)
4970:             DELETE FROM (loc_cCursor) WHERE !BETWEEN(TTOD(DtBaixa), loc_dPbI, loc_dPbF)
4971:         ENDIF
4972: 
4973:         *-- Convertendo valores para a moeda de conversao
4974:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4975:             loc_cMdO = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)
4976: 
4977:             SELECT (loc_cCursor)
4978:             SCAN
4979:                 IF ALLTRIM(Moedas) <> loc_cMdO
4980:                     loc_dTDat = TTOD(DtEmis)
4981:                     DO CASE
4982:                     CASE loc_oPag1.opt_4c_CotEm.Value = 2
4983:                         loc_dTDat = TTOD(Vencs)
4984:                     CASE loc_oPag1.opt_4c_CotEm.Value = 3
4985:                         loc_dTDat = TTOD(Datas)
4986:                     CASE loc_oPag1.opt_4c_CotEm.Value = 4
4987:                         loc_dTDat = DATE()
4988:                     CASE loc_oPag1.opt_4c_CotEm.Value = 5
4989:                         IF !EMPTY(DtBaixa)
4990:                             loc_dTDat = TTOD(DtBaixa)
4991:                         ENDIF
4992:                     ENDCASE

*-- Linhas 5010 a 5036:
5010:             ENDSCAN
5011:         ENDIF
5012: 
5013:         SELECT (loc_cCursor)
5014:         GO TOP
5015:         IF EOF()
5016:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
5017:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
5018:             RETURN .F.
5019:         ENDIF
5020: 
5021:         SELECT (loc_cCursor)
5022:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR (Nopers < 9999997) AND (SInis <> 1)
5023:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR (Nopers < 9999997) AND (SInis <> 1)
5024:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR (Nopers < 9999997) AND (SInis <> 1)
5025:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR (Nopers < 9999997) AND (SInis <> 1)
5026:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR (Nopers < 9999997) AND (SInis <> 1)
5027:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR (Nopers < 9999997) AND (SInis <> 1)
5028:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR (Nopers < 9999997) AND (SInis <> 1)
5029:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR (Nopers < 9999997) AND (SInis <> 1)
5030: 
5031:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG DtEmis
5032:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG Vencs
5033:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG Datas
5034:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG DtBaixa
5035:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG Titulos
5036:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG Hists

*-- Linhas 5047 a 5221:
5047:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value = loc_cRes
5048:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Refresh()
5049: 
5050:         SELECT (loc_cCursor)
5051:         GO TOP
5052: 
5053:         RETURN .T.
5054:     ENDPROC
5055: 
5056:     *--------------------------------------------------------------------------
5057:     * BtnMovimentoClick - equivalente ao Click de btnMovimento: identifica em
5058:     * qual tabela a movimentacao do titulo esta registrada (ChkRegister nao
5059:     * existe em BusinessBase - regra do CLAUDE.md - substituido por
5060:     * SELECT COUNT(*)) e abre a tela legada correspondente via DO FORM.
5061:     *--------------------------------------------------------------------------
5062:     PROCEDURE BtnMovimentoClick()
5063:         LOCAL loc_oBO, loc_cEmpDopNums, loc_nQtd, loc_cSQL
5064: 
5065:         loc_oBO = THIS.this_oBusinessObject
5066: 
5067:         IF loc_oBO.this_cLinTipos = "P" OR EMPTY(loc_oBO.this_nLinNopers)
5068:             RETURN
5069:         ENDIF
5070: 
5071:         loc_cEmpDopNums = PADR(loc_oBO.this_cLinEmps, 3) + PADR(loc_oBO.this_cLinDopes, 20) + STR(loc_oBO.this_nLinNumes, 6)
5072: 
5073:         *-- SigCdPgr (titulo em carteira de pagamento)
5074:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdPgr WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5075:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5076:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5077:         loc_nQtd = 0
5078:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPgr") > 0
5079:             loc_nQtd = cursor_4c_ChkPgr.Nreg
5080:             USE IN cursor_4c_ChkPgr
5081:         ENDIF
5082:         IF loc_nQtd > 0
5083:             DO FORM SigCdPgr WITH LEFT(loc_oBO.this_cLinDopes, 1), .T., loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5084:             RETURN
5085:         ENDIF
5086: 
5087:         *-- SigMvCab (movimento de estoque)
5088:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)
5089:         loc_nQtd = 0
5090:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab") > 0
5091:             loc_nQtd = cursor_4c_ChkMvCab.Nreg
5092:             USE IN cursor_4c_ChkMvCab
5093:         ENDIF
5094:         IF loc_nQtd > 0
5095:             IF WEXIST("FORM_")
5096:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Consultar o Movimento" + CHR(13) + ;
5097:                           "Existe Outra Movimenta" + CHR(231) + CHR(227) + "o Aberta!!!", "Movimento de Estoque Em Uso")
5098:             ELSE
5099:                 DO FORM SigMvExp WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5100:             ENDIF
5101:             RETURN
5102:         ENDIF
5103: 
5104:         *-- SigOpOpe (titulo vinculado a movimentacao de titulo bancario)
5105:         IF !EMPTY(loc_oBO.this_cLinEmps) AND !EMPTY(loc_oBO.this_cLinDopes) AND !EMPTY(loc_oBO.this_nLinNumes)
5106:             loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes)
5107:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpOpe") < 1
5108:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (cursor_4c_ChkOpOpe)")
5109:                 RETURN
5110:             ENDIF
5111:             IF !EOF("cursor_4c_ChkOpOpe")
5112:                 IF fChecaAcesso("C" + PADL(ALLTRIM(TRANSFORM(cursor_4c_ChkOpOpe.NDopes)), 8, "0"), "CONSULTAR")
5113:                     DO FORM SigPgTit WITH loc_oBO.this_cLinDopes, "CONSULTAR", loc_oBO.this_cLinEmps, ;
5114:                              STR(loc_oBO.this_nLinNumes, 6), (cursor_4c_ChkOpOpe.RealPrevs = 2)
5115:                 ELSE
5116:                     MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso a Consultar T" + CHR(237) + "tulos!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5117:                 ENDIF
5118:                 IF USED("cursor_4c_ChkOpOpe")
5119:                     USE IN cursor_4c_ChkOpOpe
5120:                 ENDIF
5121:                 RETURN
5122:             ENDIF
5123:             IF USED("cursor_4c_ChkOpOpe")
5124:                 USE IN cursor_4c_ChkOpOpe
5125:             ENDIF
5126:         ENDIF
5127: 
5128:         *-- SigCqChm (cheque)
5129:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCqChm WHERE Emps = " + EscaparSQL(LEFT(loc_oBO.this_cLinVOpers, 3)) + ;
5130:                    " AND Numos = " + FormatarNumeroSQL(VAL(PADL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)), 9)), 0)
5131:         loc_nQtd = 0
5132:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChm") > 0
5133:             loc_nQtd = cursor_4c_ChkChm.Nreg
5134:             USE IN cursor_4c_ChkChm
5135:         ENDIF
5136:         IF loc_nQtd > 0
5137:             DO FORM SigCdLch WITH .T., LEFT(loc_oBO.this_cLinVOpers, 3), VAL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)))
5138:             RETURN
5139:         ENDIF
5140: 
5141:         *-- SigPrCtb (contabilizacao)
5142:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigPrCtb WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5143:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5144:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5145:         loc_nQtd = 0
5146:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtb") > 0
5147:             loc_nQtd = cursor_4c_ChkCtb.Nreg
5148:             USE IN cursor_4c_ChkCtb
5149:         ENDIF
5150:         IF loc_nQtd > 0
5151:             DO FORM SigCdPgb WITH loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5152:             RETURN
5153:         ENDIF
5154: 
5155:         *-- SigCdNec (necessidade de material vinculada ao movimento)
5156:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdNec WHERE EmpDnPs = " + ;
5157:                    EscaparSQL(loc_oBO.this_cLinEmps + loc_oBO.this_cLinDopes + STR(loc_oBO.this_nLinNumes, 10))
5158:         loc_nQtd = 0
5159:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNec") > 0
5160:             loc_nQtd = cursor_4c_ChkNec.Nreg
5161:             USE IN cursor_4c_ChkNec
5162:         ENDIF
5163:         IF loc_nQtd > 0
5164:             DO FORM SigMvPdt WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5165:         ENDIF
5166:     ENDPROC
5167: 
5168:     *--------------------------------------------------------------------------
5169:     * BtnRecebeClick - equivalente ao Click de btnRecebe: busca o(s)
5170:     * recebimento(s) do titulo corrente (SigCdPit/SigCdPgr/SigCdPbx) e, se
5171:     * nao achar, cai no fallback de SigTtCcr - igual ao legado.
5172:     *--------------------------------------------------------------------------
5173:     PROCEDURE BtnRecebeClick()
5174:         LOCAL loc_oBO, loc_cSQL
5175: 
5176:         loc_oBO = THIS.this_oBusinessObject
5177: 
5178:         loc_cSQL = "SELECT DISTINCT a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques " + ;
5179:                    "FROM SigCdPit a, SigCdPgr b, SigCdPbx c " + ;
5180:                    "WHERE a.Nopers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + ;
5181:                    " AND a.EmpDopNums = b.EmpDopNums AND a.EmpDopNums = c.EmpDopNums " + ;
5182:                    "ORDER BY a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques"
5183: 
5184:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5185:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
5186:             RETURN
5187:         ENDIF
5188: 
5189:         IF !EOF("cursor_4c_ConsPgt")
5190:             IF USED("cursor_4c_ConsPgt")
5191:                 USE IN cursor_4c_ConsPgt
5192:             ENDIF
5193:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5194:             RETURN
5195:         ENDIF
5196:         IF USED("cursor_4c_ConsPgt")
5197:             USE IN cursor_4c_ConsPgt
5198:         ENDIF
5199: 
5200:         loc_cSQL = "SELECT Emps, Dopcs AS Dopes, Numcs AS Numes, Nopers, Datas AS DataRcs, 0 AS Acertos, " + ;
5201:                    "'   ' AS Moedas, Dopcs AS Fpags, ' ' AS NCheques " + ;
5202:                    "FROM SigTtCcr " + ;
5203:                    "WHERE NOpers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + " " + ;
5204:                    "ORDER BY Emps, Dopcs, Numcs, Nopers, Datas"
5205: 
5206:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5207:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
5208:             RETURN
5209:         ENDIF
5210: 
5211:         IF !EOF("cursor_4c_ConsPgt")
5212:             IF USED("cursor_4c_ConsPgt")
5213:                 USE IN cursor_4c_ConsPgt
5214:             ENDIF
5215:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5216:         ELSE
5217:             IF USED("cursor_4c_ConsPgt")
5218:                 USE IN cursor_4c_ConsPgt
5219:             ENDIF
5220:             MsgAviso("Nenhum Recebimento Localizado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5221:         ENDIF

*-- Linhas 5344 a 5424:
5344:         IF USED("cursor_4c_RelFin")
5345:             USE IN cursor_4c_RelFin
5346:         ENDIF
5347:         SELECT 9999999999 AS Ordem, Nopers, SPACE(1) AS Tipo, SaldoDia AS Saldos, SaldoTot AS SaldosP, Debitos, ;
5348:                Creditos, SPACE(10) AS ContaCobs, Grupos, Contas, ContEms, OrdHs, Hists, Hist2s, NFs, Datas, ;
5349:                Vencs, DtEmis, DtBaixa, Titulos, Moedas, SInis, SPACE(50) AS RClis ;
5350:           FROM (loc_cCursor) ;
5351:           INTO CURSOR cursor_4c_RelFin READWRITE
5352: 
5353:         SELECT cursor_4c_RelFin
5354:         GO TOP
5355:         IF EOF()
5356:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Impress" + CHR(227) + "o!!!", "Impress" + CHR(227) + "o")
5357:             USE IN cursor_4c_RelFin
5358:             RETURN
5359:         ENDIF
5360: 
5361:         loc_cTit = "Relat" + CHR(243) + "rio Financeiro"
5362:         loc_cSub = PROPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Filtros.Value)) + " - Ordem: " + ;
5363:                    PROPER(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.List(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.ListIndex))
5364:         loc_cRes = ALLTRIM(SUBSTR(ALLTRIM(THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value), 2))
5365: 
5366:         IF USED("cursor_4c_RelFinCab")
5367:             USE IN cursor_4c_RelFinCab
5368:         ENDIF
5369:         SET NULL ON
5370:         CREATE CURSOR cursor_4c_RelFinCab (Titulo C(80), SubTitulo C(80), Moeda1 C(80), RodRelCC M(4))
5371:         SET NULL OFF
5372:         INSERT INTO cursor_4c_RelFinCab (Titulo, SubTitulo, RodRelCC) VALUES (loc_cTit, loc_cSub, loc_cRes)
5373:         GO TOP IN cursor_4c_RelFinCab
5374: 
5375:         loc_cFor = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "0=0", "(Nopers < 9999997) AND (SInis <> 1)")
5376: 
5377:         SELECT cursor_4c_RelFin
5378:         DO CASE
5379:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtEmis"
5380:             INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR &loc_cFor.
5381:         CASE THIS.this_oBusinessObject.this_cOrdem = "Vencs"
5382:             INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR &loc_cFor.
5383:         CASE THIS.this_oBusinessObject.this_cOrdem = "Datas"
5384:             INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR &loc_cFor.
5385:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtBaixa"
5386:             INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR &loc_cFor.
5387:         CASE THIS.this_oBusinessObject.this_cOrdem = "Titulos"
5388:             INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR &loc_cFor.
5389:         CASE THIS.this_oBusinessObject.this_cOrdem = "Hists"
5390:             INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR &loc_cFor.
5391:         CASE THIS.this_oBusinessObject.this_cOrdem = "ContEms"
5392:             INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR &loc_cFor.
5393:         CASE THIS.this_oBusinessObject.this_cOrdem = "Contas"
5394:             INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR &loc_cFor.
5395:         ENDCASE
5396: 
5397:         SELECT cursor_4c_RelFin
5398:         GO TOP
5399: 
5400:         IF !FILE(FULLPATH(loc_cFrx + ".frx"))
5401:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + FULLPATH(loc_cFrx + ".frx"), "Erro")
5402:         ELSE
5403:             THIS.ExecutarReportForm("SigReCgf", "PREVIEW")
5404:         ENDIF
5405: 
5406:         USE IN cursor_4c_RelFinCab
5407:         USE IN cursor_4c_RelFin
5408: 
5409:         SELECT (loc_cCursor)
5410:         GO TOP
5411:     ENDPROC
5412: 
5413:     *--------------------------------------------------------------------------
5414:     * Planilha - transcricao de ThisForm.Planilha: exporta cursor_4c_Dados
5415:     * para XLS/TXT via PUTFILE + COPY TO, igual ao legado (fVerificaPasta/
5416:     * fLimpaTexto ja portadas em utils/functions.prg).
5417:     *--------------------------------------------------------------------------
5418:     PROCEDURE Planilha()
5419:         LOCAL loc_cCursor, loc_cArq, loc_cDeb, loc_cCrd
5420: 
5421:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5422: 
5423:         IF !USED(loc_cCursor)
5424:             RETURN

*-- Linhas 5437 a 5485:
5437:             IF USED("cursor_4c_RelExcel")
5438:                 USE IN cursor_4c_RelExcel
5439:             ENDIF
5440:             SELECT IIF((Nopers < 9999997) AND (SInis <> 1), SPACE(5), "TOTAL") AS Linhas, ;
5441:                    TTOD(DtEmis) AS Emissao, TTOD(Vencs) AS Vencimento, TTOD(Datas) AS Lancamento, ;
5442:                    TTOD(DtBaixa) AS Baixa, Titulos AS Titulo, NFs AS NF, TitBans AS Bancos, ;
5443:                    EspecieNfs AS Especie, IIF(Pagos = "1", "Baixado ", "Pendente") AS Situacao, ;
5444:                    Hists AS Historico, Hist2s AS Historico2, Moedas AS Moeda, Valors AS Valor, ;
5445:                    Debitos AS Debito, Creditos AS Credito, SaldoDia AS Saldo, SaldoTot AS Acumulado, ;
5446:                    GrupEms AS Grp_Emitente, ContEms AS Cta_Emitente, Grupos AS Grp_Portador, Contas AS Cta_Portador, ;
5447:                    SGrupos AS Grp_CCusto, SContas AS Cta_CCusto, GrupAges AS Grp_Agente, ContAges AS Cta_Agente ;
5448:               FROM (loc_cCursor) ;
5449:               INTO CURSOR cursor_4c_RelExcel
5450: 
5451:             SELECT cursor_4c_RelExcel
5452:             GO TOP
5453: 
5454:             IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) = "xls"
5455:                 COPY TO (loc_cArq) TYPE XLS
5456:             ELSE
5457:                 COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
5458:             ENDIF
5459: 
5460:             IF FILE(loc_cArq)
5461:                 MsgInfo("Planilha Gerada Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
5462:             ENDIF
5463: 
5464:             USE IN cursor_4c_RelExcel
5465:         ELSE
5466:             MsgAviso("Ocorreu Um Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha, Verifique" + CHR(10) + ;
5467:                       "O Diret" + CHR(243) + "rio Ou Se a Planilha Se Encontra Em Uso!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5468:         ENDIF
5469: 
5470:         SELECT (loc_cCursor)
5471:         GO TOP
5472:     ENDPROC
5473: 
5474:     *==========================================================================
5475:     * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
5476:     *
5477:     * Os metodos abaixo sao os FUNIS unicos das acoes que o legado espalha
5478:     * entre os Click/When dos CommandGroups e o AfterRowColChange da grade.
5479:     * NENHUM botao novo foi criado (PILAR 1 / "NUNCA inventar"): cada funil e
5480:     * acionado pelo handler do controle que o SCX legado realmente tem.
5481:     *
5482:     *   BtnBuscarClick       <- cmgFiltros.Buttons(1) "Consultar"
5483:     *   BtnCancelarClick     <- cmgRetornar (volta da Page2) e, na Page1,
5484:     *                           cmgFiltros.Buttons(2) "Sair"
5485:     *   BtnEncerrarClick     <- cmgFiltros.Buttons(2) "Sair" (ThisForm.Release)

*-- Linhas 5571 a 5589:
5571:             RETURN .F.
5572:         ENDIF
5573: 
5574:         SELECT (loc_cCursor)
5575:         GO TOP
5576:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
5577: 
5578:         IF EOF(loc_cCursor)
5579:             THIS.LimparCampos()
5580:             THIS.AjustarBotoesPorModo()
5581:         ELSE
5582:             THIS.GrdDadosAfterRowColChange(1)
5583:         ENDIF
5584: 
5585:         loc_lResultado = .T.
5586:         RETURN loc_lResultado
5587:     ENDPROC
5588: 
5589:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SIGOPCGFBO.prg):
*============================================================================
* SIGOPCGFBO.prg - Business Object para Consulta Global Financeira
*
* Form OPERACIONAL (sem tabela/PK unica) - consulta sobre titulos financeiros
* (SigCdPit) movimentados contra contas (SigCdCli), com filtros amplos de
* data, titulo, moeda, publicidade, empresa e grupos de contas selecionaveis
* em duas grades auxiliares (equivalentes a TmpCliente/TmpCliente2 do legado).
*
* Legado  : SIGOPCGF.SCX (form generico "form", NAO frmcadastro)
* Cursores de trabalho (equivalentes ao LocalDados/LocalTotais/crSigOpOpe/
* TmpCliente/TmpCliente2/TmpContas/crFiltros do legado):
*   cursor_4c_Dados     - resultado da consulta (um registro por titulo)
*   cursor_4c_Totais    - estrutura vazia usada para acumular totalizadores
*   cursor_4c_Tipos     - tipos de operacao de titulo (SigOpOpe) com flag de
*                         selecao (Imps) para o filtro por tipo de movimento
*   cursor_4c_Clientes  - grade 1 de contas/grupos selecionaveis no filtro
*   cursor_4c_Clientes2 - grade 2 de contas/grupos selecionaveis no filtro
*   cursor_4c_Contas    - cache de contas (IClis/RClis) usado pelas grades
*   cursor_4c_Filtros   - filtros nomeados salvos (SigSyPar)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGOPCGFBO AS BusinessBase

    *==========================================================================
    * Nomes dos cursores de trabalho (constantes de instancia - usados pelos
    * metodos de carga/consulta criados nas proximas fases)
    *==========================================================================
    this_cCursorDados     = "cursor_4c_Dados"
    this_cCursorTotais    = "cursor_4c_Totais"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorClientes  = "cursor_4c_Clientes"
    this_cCursorClientes2 = "cursor_4c_Clientes2"
    this_cCursorContas    = "cursor_4c_Contas"
    this_cCursorFiltros   = "cursor_4c_Filtros"

    *==========================================================================
    * Filtros de data (getDtEmiI/F, getVencsI/F, getDatasI/F, getDtBxI/F)
    *==========================================================================
    this_dDtEmiI = {}    && Emissao - de
    this_dDtEmiF = {}    && Emissao - ate
    this_dVencsI = {}    && Vencimento - de
    this_dVencsF = {}    && Vencimento - ate
    this_dDatasI = {}    && Lancamento - de
    this_dDatasF = {}    && Lancamento - ate
    this_dDtBxI  = {}    && Baixa - de
    this_dDtBxF  = {}    && Baixa - ate

    *==========================================================================
    * Filtros de texto/codigo (getTitulos, getTitBans, getEspecieNfs, getNFs)
    *==========================================================================
    this_cTitulos    = ""    && Titulo (SigCdPit.Titulos)
    this_cTitBans    = ""    && Titulo Banco (SigCdPgr.FPags, busca local fwBuscaSel)
    this_cEspecieNfs = ""    && Especie da NF - codigo (SigCdEsp.Especies)
    this_cNFs        = ""    && Numero da Nota Fiscal

    *==========================================================================
    * Moeda (getCMoes/getDMoes, getCMoesC/getDMoesC, getMoeSaldo)
    *==========================================================================
    this_cCMoes    = ""    && Moeda Filtro - codigo (SigCdMoe.CMoes)
    this_cDMoes    = ""    && Moeda Filtro - descricao (SigCdMoe.DMoes)
    this_cCMoesC   = ""    && Moeda Conversao - codigo (SigCdMoe.CMoes)
    this_cDMoesC   = ""    && Moeda Conversao - descricao (SigCdMoe.DMoes)
    this_cMoeSaldo = ""    && Moeda do Saldo Inicial - codigo (SigCdMoe.CMoes)
    this_nSaldo    = 0     && Saldo Inicial (valor digitado pelo usuario)

    *==========================================================================
    * Publicidade (getCFPublis/getDFPublis)
    *==========================================================================
    this_cCFPublis = ""    && Forma de Publicidade - codigo (SigCdFpb.Cods)
    this_cDFPublis = ""    && Forma de Publicidade - descricao (SigCdFpb.Descs)

    *==========================================================================
    * Empresa (Get_Empresa)
    *==========================================================================
    this_cEmpresa = ""    && Empresa - codigo (SigCdEmp.Cemps)

    *==========================================================================
    * Flags de filtro (chkBrancos, chkValpags, chkTotais)
    *==========================================================================
    this_lBrancos  = .F.    && Branco (chkBrancos) - filtra lancamentos em branco
    this_lValPends = .F.    && Valor Pendente (chkValpags)
    this_lTotais   = .T.    && Exibir Totalizadores (chkTotais)

    *==========================================================================
    * OptionGroups de filtro - indice 1-based, espelha o Value do grupo
    * (optPagos, optOpcao, optCotEm, optCancs, optConcs, optProrrogs,
    * optFilGrd2)
    *==========================================================================
    this_nPagos    = 1    && Pagamento (3 opcoes)
    this_nOpcao    = 1    && Opcao (3 opcoes)
    this_nCotEm    = 1    && Conversao em (5 opcoes)
    this_nCancs    = 1    && Cancelamento (3 opcoes)
    this_nConcs    = 1    && Conciliacao (3 opcoes)
    this_nProrrogs = 1    && Prorrogacao (3 opcoes)
    this_nFilGrd2  = 1    && Filtro da grade 2 (2 opcoes)

    *==========================================================================
    * Ordenacao da grade de resultado (cmbOrdem.Value + ThisForm.Ordem legado)
    *==========================================================================
    this_nOrdem = 1          && Indice selecionado no combo de ordem
    this_cOrdem = "DtEmis"   && Nome da coluna correspondente, usado no SET ORDER

    *==========================================================================
    * Filtro nomeado (getFiltros/getNewFiltro - SigSyPar)
    *==========================================================================
    this_cFiltros   = ""    && Nome do filtro selecionado/carregado
    this_cNewFiltro = ""    && Nome digitado ao cadastrar um novo filtro

    *==========================================================================
    * Totalizadores calculados sobre cursor_4c_Dados (CalcSaldo/CalcSaldoCta)
    *==========================================================================
    this_nSaldoDia = 0
    this_nSaldoTot = 0
    this_nDebitos  = 0
    this_nCreditos = 0

    *==========================================================================
    * Linha corrente de cursor_4c_Dados (equivalente ao registro corrente de
    * LocalDados no legado) - carregada por CarregarDoCursor() quando o
    * usuario seleciona uma linha na grade, e consumida pelos botoes de
    * acao (Movimento/Recebimento/FollowUp/Imprimir) das proximas fases.
    *==========================================================================
    this_nLinNopers     = 0     && Numero da operacao (chave de navegacao)
    this_cLinTipos      = ""    && Tipo do lancamento
    this_nLinSaldoDia   = 0     && Saldo do dia (linha)
    this_nLinSaldoTot   = 0     && Saldo total/progressivo (linha)
    this_nLinDebitos    = 0     && Debito (linha)
    this_nLinCreditos   = 0     && Credito (linha)
    this_cLinContaCobs  = ""    && Conta cobradora
    this_cLinGrupos     = ""    && Grupo da conta
    this_cLinContas     = ""    && Codigo da conta/portador
    this_cLinContEms    = ""    && Codigo do emitente/cliente
    this_cLinOrdHs      = ""    && Ordem do historico
    this_cLinHists      = ""    && Historico
    this_cLinHist2s     = ""    && Historico complementar
    this_cLinNFs        = ""    && Nota Fiscal
    this_dLinDatas      = {}    && Data de lancamento
    this_dLinVencs      = {}    && Data de vencimento
    this_dLinDtEmis     = {}    && Data de emissao
    this_dLinDtBaixa    = {}    && Data de baixa
    this_cLinTitulos    = ""    && Numero do titulo
    this_cLinMoedas     = ""    && Codigo da moeda
    this_nLinSInis      = 0     && Flag "e totalizador/sintetico" (SInis)
    this_cLinRClis      = ""    && Razao social do cliente/emitente
    this_cLinEmps       = ""    && Empresa (chave de movimento)
    this_cLinDopes      = ""    && Documento de origem (chave de movimento)
    this_nLinNumes      = 0     && Numero do movimento (chave de movimento)
    this_cLinVOpers     = ""    && Movimento vinculado (ContEms+Numos)
    this_nLinAcertos    = 0     && Flag de acerto (usado no Recebimento)
    this_cLinGrupEms    = ""    && Grupo do emitente
    this_cLinSGrupos    = ""    && Grupo do centro de custo
    this_cLinSContas    = ""    && Codigo do centro de custo
    this_cLinGrupAges   = ""    && Grupo do agente cobrador
    this_cLinContAges   = ""    && Codigo do agente cobrador
    this_cLinTitBans    = ""    && Titulo no banco (SigCdPgr.FPags)
    this_cLinEspecieNfs = ""    && Especie da Nota Fiscal
    this_nLinValOcurs   = 0     && Valor ocorrido
    this_nLinTitCancs   = 0     && Flag "titulo cancelado" (Botao1)
    this_cLinPagos      = ""    && Flag/codigo de pagamento - "0"=pendente (Botao2)
    this_lLinConcs      = .F.   && Flag "titulo conciliado" (Botao3)
    this_dLinProrrogs   = {}    && Data de prorrogacao, vazia = nao prorrogado (Botao4)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Form de consulta sem tabela/PK unica (nao eh CRUD) - this_cTabela e
    * this_cCampoChave ficam vazios de proposito; a consulta principal eh
    * montada dinamicamente (varias tabelas) nos metodos das proximas fases.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE de cursor_4c_Dados (grade
    * de resultado da consulta) para as propriedades this_nLin*/this_cLin*/
    * this_dLin*, equivalente a ler LocalDados.<campo> diretamente no legado
    * (AfterRowColChange/Click dos botoes de acao). Chamado pelo Form sempre
    * que a linha selecionada na grade mudar.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF() OR BOF()
            RETURN .F.
        ENDIF

        THIS.this_nLinNopers    = TratarNulo(Nopers, 0)
        THIS.this_cLinTipos     = TratarNulo(Tipos, "")
        THIS.this_nLinSaldoDia  = TratarNulo(SaldoDia, 0)
        THIS.this_nLinSaldoTot  = TratarNulo(SaldoTot, 0)
        THIS.this_nLinDebitos   = TratarNulo(Debitos, 0)
        THIS.this_nLinCreditos  = TratarNulo(Creditos, 0)
        THIS.this_cLinContaCobs = TratarNulo(ContaCobs, "")
        THIS.this_cLinGrupos    = TratarNulo(Grupos, "")
        THIS.this_cLinContas    = TratarNulo(Contas, "")
        THIS.this_cLinContEms   = TratarNulo(ContEms, "")
        THIS.this_cLinOrdHs     = TratarNulo(OrdHs, "")
        THIS.this_cLinHists     = TratarNulo(Hists, "")
        THIS.this_cLinHist2s    = TratarNulo(Hist2s, "")
        THIS.this_cLinNFs       = TratarNulo(NFs, "")
        THIS.this_dLinDatas     = TratarNulo(Datas, {})
        THIS.this_dLinVencs     = TratarNulo(Vencs, {})
        THIS.this_dLinDtEmis    = TratarNulo(DtEmis, {})
        THIS.this_dLinDtBaixa   = TratarNulo(DtBaixa, {})
        THIS.this_cLinTitulos   = TratarNulo(Titulos, "")
        THIS.this_cLinMoedas    = TratarNulo(Moedas, "")
        THIS.this_nLinSInis     = TratarNulo(SInis, 0)
        THIS.this_cLinRClis     = TratarNulo(RClis, "")

        IF TYPE("Emps") = "C"
            THIS.this_cLinEmps = TratarNulo(Emps, "")
        ENDIF
        IF TYPE("Dopes") = "C"
            THIS.this_cLinDopes = TratarNulo(Dopes, "")
        ENDIF
        IF TYPE("Numes") = "N"
            THIS.this_nLinNumes = TratarNulo(Numes, 0)
        ENDIF
        IF TYPE("VOpers") = "C"
            THIS.this_cLinVOpers = TratarNulo(VOpers, "")
        ENDIF
        IF TYPE("Acertos") = "N"
            THIS.this_nLinAcertos = TratarNulo(Acertos, 0)
        ENDIF
        IF TYPE("GrupEms") = "C"
            THIS.this_cLinGrupEms = TratarNulo(GrupEms, "")
        ENDIF
        IF TYPE("SGrupos") = "C"
            THIS.this_cLinSGrupos = TratarNulo(SGrupos, "")
        ENDIF
        IF TYPE("SContas") = "C"
            THIS.this_cLinSContas = TratarNulo(SContas, "")
        ENDIF
        IF TYPE("GrupAges") = "C"
            THIS.this_cLinGrupAges = TratarNulo(GrupAges, "")
        ENDIF
        IF TYPE("ContAges") = "C"
            THIS.this_cLinContAges = TratarNulo(ContAges, "")
        ENDIF
        IF TYPE("TitBans") = "C"
            THIS.this_cLinTitBans = TratarNulo(TitBans, "")
        ENDIF
        IF TYPE("EspecieNfs") = "C"
            THIS.this_cLinEspecieNfs = TratarNulo(EspecieNfs, "")
        ENDIF
        IF TYPE("ValOcurs") = "N"
            THIS.this_nLinValOcurs = TratarNulo(ValOcurs, 0)
        ENDIF
        IF TYPE("TitCancs") = "N"
            THIS.this_nLinTitCancs = TratarNulo(TitCancs, 0)
        ENDIF
        IF TYPE("Pagos") = "C"
            THIS.this_cLinPagos = TratarNulo(Pagos, "")
        ENDIF
        IF TYPE("Concs") = "L"
            THIS.this_lLinConcs = TratarNulo(Concs, .F.)
        ENDIF
        IF TYPE("Prorrogs") = "D" OR TYPE("Prorrogs") = "T"
            THIS.this_dLinProrrogs = TratarNulo(Prorrogs, {})
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao
    *
    * SIGOPCGF e um form OPERACIONAL de consulta ("Consulta Global
    * Financeira"): o legado apura o resultado so no cursor local LocalDados
    * (via SqlExecute + filtros), nunca grava numa tabela propria do SQL
    * Server - os dados persistidos que ele le/altera pertencem a outras
    * entidades (SigCdPit/SigMvCab/SigCdPgr/SigSyPar, etc), cada uma com seu
    * proprio BO. Por isso esta tela nao tem INSERT/UPDATE/DELETE proprios;
    * o comportamento padrao herdado de BusinessBase (recusar a operacao e
    * expor THIS.this_cMensagemErro) ja e o correto aqui.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o exclui registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao ha registro proprio persistido por esta BO
    * (ver Inserir/Atualizar/ExecutarExclusao acima). Mantido PROTECTED para
    * compatibilidade com a interface de BusinessBase, devolvendo o numero
    * da operacao (Nopers) da linha corrente como chave de referencia.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nLinNopers)
    ENDPROC

ENDDEFINE

