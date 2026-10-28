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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS SQL (5888 linhas total):

*-- Linhas 213 a 263:
213:     *--------------------------------------------------------------------------
214:     * CriarCursoresFiltros - Cria os cursores placeholder da Page1 ANTES do
215:     * ConfigurarPaginaFiltros() poder bindar os Grids (regra #41 - Column.
216:     * ControlSource exige que o cursor ja exista). Estrutura IDENTICA a que
217:     * CarregarTiposOperacao()/CarregarFiltrosSalvos() (SQLEXEC + SELECT INTO
218:     * CURSOR) recriam depois ("cursor placeholder = cursor real").
219:     *--------------------------------------------------------------------------
220:     PROTECTED PROCEDURE CriarCursoresFiltros()
221:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2, loc_cFiltros
222: 
223:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
224:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
225:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
226:         loc_cFiltros   = THIS.this_oBusinessObject.this_cCursorFiltros
227: 
228:         IF !USED(loc_cTipos)
229:             CREATE CURSOR (loc_cTipos) (Imps N(1,0), Dopes C(20), Opers C(2), RealPrevs N(1,0))
230:             INDEX ON Dopes TAG Dopes
231:         ENDIF
232: 
233:         IF !USED(loc_cClientes)
234:             CREATE CURSOR (loc_cClientes) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
235:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
236:             SELECT (loc_cClientes)
237:             APPEND BLANK
238:         ENDIF
239: 
240:         IF !USED(loc_cClientes2)
241:             CREATE CURSOR (loc_cClientes2) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
242:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
243:             SELECT (loc_cClientes2)
244:             APPEND BLANK
245:         ENDIF
246: 
247:         IF !USED(loc_cFiltros)
248:             CREATE CURSOR (loc_cFiltros) (Cidparams C(64), Ctpparams C(1), Mxmls M, Descrs C(40))
249:         ENDIF
250:     ENDPROC
251: 
252:     *--------------------------------------------------------------------------
253:     * ConfigurarPaginaFiltros - Monta todo o conteudo da Page1 (cabecalho,
254:     * campos de filtro, OptionGroups, grades e botoes).
255:     *--------------------------------------------------------------------------
256:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
257:         LOCAL loc_oPag
258:         loc_oPag = THIS.pgf_4c_Paginas.Page1
259: 
260:         THIS.ConfigurarCabecalhoFiltros(loc_oPag)
261:         THIS.ConfigurarCamposFiltros(loc_oPag)
262:         THIS.ConfigurarOptionGroupsFiltros(loc_oPag)
263:         THIS.ConfigurarGradesFiltros(loc_oPag)

*-- Linhas 1408 a 1448:
1408:             .FontName = "Tahoma"
1409:             .AllowHeaderSizing = .F.
1410:             .AllowRowSizing = .F.
1411:             .DeleteMark = .F.
1412:             .RecordMark = .F.
1413:             .HeaderHeight = 17
1414:             .RowHeight = 17
1415:             .ScrollBars = 2
1416:             .GridLineColor = RGB(238, 238, 238)
1417:             .ColumnCount = 2
1418:             .RecordSource = loc_cTipos
1419: 
1420:             .Column1.ControlSource = loc_cTipos + ".Imps"
1421:             .Column1.Width = 17
1422:             .Column1.Alignment = 0
1423:             .Column1.Sparse = .F.
1424:             .Column1.Header1.Caption = ""
1425:             .Column1.AddObject("Check1", "CheckBox")
1426:             .Column1.Check1.Top = 23
1427:             .Column1.Check1.Left = 35
1428:             .Column1.Check1.Width = 60
1429:             .Column1.Check1.Height = 17
1430:             .Column1.Check1.Caption = ""
1431:             .Column1.CurrentControl = "Check1"
1432: 
1433:             .Column2.ControlSource = loc_cTipos + ".Dopes"
1434:             .Column2.Width = 220
1435:             .Column2.Movable = .F.
1436:             .Column2.Resizable = .F.
1437:             .Column2.ReadOnly = .T.
1438:             .Column2.Text1.ReadOnly = .T.
1439:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
1440:             .Column2.Header1.Alignment = 2
1441:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1442: 
1443:             .Visible = .T.
1444:         ENDWITH
1445: 
1446:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "KeyPress", THIS, "ChkTipoKeyPress")
1447:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseUp", THIS, "ChkTipoMouseUp")
1448:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseDown", THIS, "ChkTipoMouseDown")

*-- Linhas 1505 a 1618:
1505:             .FontName = "Tahoma"
1506:             .AllowHeaderSizing = .F.
1507:             .AllowRowSizing = .F.
1508:             .DeleteMark = .F.
1509:             .RecordMark = .F.
1510:             .ScrollBars = 2
1511:             .GridLineColor = RGB(238, 238, 238)
1512:             .ColumnCount = 8
1513:             .RecordSource = par_cCursor
1514: 
1515:             .Column1.ControlSource = par_cCursor + ".Grupo"
1516:             .Column1.Width = 90
1517:             .Column1.Movable = .F.
1518:             .Column1.Resizable = .F.
1519:             .Column1.Text1.MaxLength = 10
1520:             .Column1.Header1.Caption = "Grupo"
1521:             .Column1.Header1.Alignment = 2
1522:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1523: 
1524:             .Column4.ColumnOrder = 2
1525:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1526:             .Column4.Width = 166
1527:             .Column4.Text1.MaxLength = 20
1528:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1529:             .Column4.Header1.Alignment = 2
1530:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1531: 
1532:             .Column2.ColumnOrder = 3
1533:             .Column2.ControlSource = par_cCursor + ".Conta"
1534:             .Column2.Width = 90
1535:             .Column2.Movable = .F.
1536:             .Column2.Resizable = .F.
1537:             .Column2.Text1.MaxLength = 10
1538:             .Column2.Header1.Caption = "Conta"
1539:             .Column2.Header1.Alignment = 2
1540:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1541: 
1542:             .Column3.ColumnOrder = 4
1543:             .Column3.ControlSource = par_cCursor + ".Nome"
1544:             .Column3.Width = 360
1545:             .Column3.Movable = .F.
1546:             .Column3.Resizable = .F.
1547:             .Column3.Text1.MaxLength = 50
1548:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1549:             .Column3.Header1.Alignment = 2
1550:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
1551: 
1552:             .Column5.ControlSource = par_cCursor + ".CheckE"
1553:             .Column5.Width = 17
1554:             .Column5.Sparse = .F.
1555:             .Column5.ToolTipText = "Emitente"
1556:             .Column5.Header1.Caption = "E"
1557:             .Column5.Header1.Alignment = 2
1558:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
1559:             .Column5.Header1.ToolTipText = "Emitente"
1560:             .Column5.AddObject("Check1", "CheckBox")
1561:             .Column5.Check1.Top = 31
1562:             .Column5.Check1.Left = 9
1563:             .Column5.Check1.Width = 60
1564:             .Column5.Check1.Height = 17
1565:             .Column5.Check1.Caption = ""
1566:             .Column5.Check1.ToolTipText = "Emitente"
1567:             .Column5.CurrentControl = "Check1"
1568: 
1569:             .Column6.ControlSource = par_cCursor + ".CheckP"
1570:             .Column6.Width = 17
1571:             .Column6.Sparse = .F.
1572:             .Column6.ToolTipText = "Portador"
1573:             .Column6.Header1.Caption = "P"
1574:             .Column6.Header1.Alignment = 2
1575:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
1576:             .Column6.Header1.ToolTipText = "Portador"
1577:             .Column6.AddObject("Check1", "CheckBox")
1578:             .Column6.Check1.Top = 31
1579:             .Column6.Check1.Left = 9
1580:             .Column6.Check1.Width = 60
1581:             .Column6.Check1.Height = 17
1582:             .Column6.Check1.Caption = ""
1583:             .Column6.Check1.ToolTipText = "Portador"
1584:             .Column6.CurrentControl = "Check1"
1585: 
1586:             .Column7.ControlSource = par_cCursor + ".CheckC"
1587:             .Column7.Width = 17
1588:             .Column7.Sparse = .F.
1589:             .Column7.ToolTipText = "Centro de Custo"
1590:             .Column7.Header1.Caption = "C"
1591:             .Column7.Header1.Alignment = 2
1592:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1593:             .Column7.Header1.ToolTipText = "Centro de Custo"
1594:             .Column7.AddObject("Check1", "CheckBox")
1595:             .Column7.Check1.Top = 30
1596:             .Column7.Check1.Left = 9
1597:             .Column7.Check1.Width = 60
1598:             .Column7.Check1.Height = 17
1599:             .Column7.Check1.Caption = ""
1600:             .Column7.Check1.ToolTipText = "Centro de Custo"
1601:             .Column7.CurrentControl = "Check1"
1602: 
1603:             .Column8.ControlSource = par_cCursor + ".CheckA"
1604:             .Column8.Width = 17
1605:             .Column8.Sparse = .F.
1606:             .Column8.ToolTipText = "Agente Cobrador"
1607:             .Column8.Header1.Caption = "A"
1608:             .Column8.Header1.Alignment = 2
1609:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
1610:             .Column8.Header1.ToolTipText = "Agente Cobrador"
1611:             .Column8.AddObject("Check1", "CheckBox")
1612:             .Column8.Check1.Top = 33
1613:             .Column8.Check1.Left = 11
1614:             .Column8.Check1.Width = 60
1615:             .Column8.Check1.Height = 17
1616:             .Column8.Check1.Caption = ""
1617:             .Column8.Check1.ToolTipText = "Agente Cobrador"
1618:             .Column8.CurrentControl = "Check1"

*-- Linhas 2203 a 2221:
2203:     * ValidarTitBansFiltro/AbrirLookupTitBans - Titulo Banco. Legado busca em
2204:     * GradeOpOpe (cursor local carregado de SigOpFp no Init, Where Situas In
2205:     * ('P','R','A') And Infos='K') via fwBuscaSel; aqui a mesma fonte e
2206:     * filtro vao direto no FormBuscaAuxiliar (SQLEXEC sobre a tabela, regra
2207:     * #36 - 1o argumento eh SEMPRE o handle de conexao).
2208:     *--------------------------------------------------------------------------
2209:     PROCEDURE ValidarTitBansFiltro()
2210:         LOCAL loc_oPag, loc_cValor
2211:         IF THIS.this_lEmLookup
2212:             RETURN
2213:         ENDIF
2214:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2215:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_TitBans.Value)
2216:         IF loc_cValor == THIS.this_cUltimoValidarTitBansFiltroValidado
2217:             RETURN
2218:         ENDIF
2219:         THIS.this_cUltimoValidarTitBansFiltroValidado = loc_cValor
2220:         IF EMPTY(loc_cValor)
2221:             RETURN

*-- Linhas 2231 a 2249:
2231:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2232:                 "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", par_cValor, ;
2233:                 "T" + CHR(237) + "tulo Banco", .F., .T., ;
2234:                 "Situas IN ('P','R','A') AND Infos = " + EscaparSQL("K"))
2235: 
2236:             IF VARTYPE(loc_oBusca) = "O"
2237:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2238:                     IF USED("cursor_4c_BuscaTitBan")
2239:                         THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2240:                     ENDIF
2241:                 ELSE
2242:                     IF !loc_oBusca.this_lAchouRegistro
2243:                         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2244:                         loc_oBusca.Show()
2245:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
2246:                             THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2247:                         ENDIF
2248:                     ENDIF
2249:                 ENDIF

*-- Linhas 3210 a 3306:
3210: 
3211:     *--------------------------------------------------------------------------
3212:     * ApagaClick/SelTudoClick - grdTipo: desmarca/marca todos os tipos de
3213:     * operacao (equivalente ao Update crSigOpOpe Set Imps=.. do legado).
3214:     *--------------------------------------------------------------------------
3215:     PROCEDURE ApagaClick()
3216:         LOCAL loc_cCursor
3217:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3218: 
3219:         IF USED(loc_cCursor)
3220:             SELECT (loc_cCursor)
3221:             REPLACE ALL Imps WITH 0
3222:             GO TOP
3223:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3224:         ENDIF
3225:     ENDPROC
3226: 
3227:     PROCEDURE SelTudoClick()
3228:         LOCAL loc_cCursor
3229:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3230: 
3231:         IF USED(loc_cCursor)
3232:             SELECT (loc_cCursor)
3233:             REPLACE ALL Imps WITH 1 FOR !EMPTY(Dopes)
3234:             GO TOP
3235:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3236:         ENDIF
3237:     ENDPROC
3238: 
3239:     *--------------------------------------------------------------------------
3240:     * InserirLinhaGrade/ExcluirLinhaGrade/LimparGrade - CRUD de linha
3241:     * compartilhado pelas duas grades de Grupo/Conta (equivalente aos
3242:     * btnInserir*/btnExcluir*/btnApagaG* do legado sobre TmpCliente/
3243:     * TmpCliente2).
3244:     *--------------------------------------------------------------------------
3245:     PROTECTED PROCEDURE InserirLinhaGrade(par_cCursor, par_oGrid)
3246:         IF !USED(par_cCursor)
3247:             RETURN
3248:         ENDIF
3249: 
3250:         SELECT (par_cCursor)
3251:         GO TOP
3252:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3253:         IF EOF()
3254:             APPEND BLANK
3255:             GO BOTTOM
3256:         ENDIF
3257: 
3258:         par_oGrid.Refresh()
3259:         par_oGrid.SetFocus()
3260:         par_oGrid.Column1.SetFocus()
3261:     ENDPROC
3262: 
3263:     PROTECTED PROCEDURE ExcluirLinhaGrade(par_cCursor, par_oGrid)
3264:         IF !USED(par_cCursor)
3265:             RETURN
3266:         ENDIF
3267: 
3268:         SELECT (par_cCursor)
3269:         IF !EMPTY(Grupo) OR !EMPTY(Conta)
3270:             DELETE
3271:         ENDIF
3272: 
3273:         GO TOP
3274:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3275:         IF EOF()
3276:             APPEND BLANK
3277:             GO BOTTOM
3278:         ENDIF
3279: 
3280:         par_oGrid.Refresh()
3281:         par_oGrid.SetFocus()
3282:         par_oGrid.Column1.SetFocus()
3283:     ENDPROC
3284: 
3285:     PROTECTED PROCEDURE LimparGrade(par_cCursor, par_oGrid)
3286:         IF !USED(par_cCursor)
3287:             RETURN
3288:         ENDIF
3289: 
3290:         ZAP IN (par_cCursor)
3291:         SELECT (par_cCursor)
3292:         APPEND BLANK
3293:         par_oGrid.Refresh()
3294:     ENDPROC
3295: 
3296:     PROCEDURE BtnInserirClick()
3297:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3298:     ENDPROC
3299: 
3300:     PROCEDURE BtnExcluirClick()
3301:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3302:     ENDPROC
3303: 
3304:     PROCEDURE BtnInserir2Click()
3305:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3306:     ENDPROC

*-- Linhas 3328 a 3346:
3328:     *--------------------------------------------------------------------------
3329:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3330:         IF USED(par_cCursor)
3331:             SELECT (par_cCursor)
3332:             IF !EOF()
3333:                 REPLACE (par_cCampo) WITH IIF(EVALUATE(par_cCampo) = 0, 1, 0)
3334:             ENDIF
3335:         ENDIF
3336:         par_oGrid.Refresh()
3337:     ENDPROC
3338: 
3339:     *-- grdTipo.Column1.Check1 (Imps)
3340:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3341:         IF INLIST(par_nKeyCode, 13, 32)
3342:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorTipos, "Imps", THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos)
3343:             NODEFAULT
3344:         ENDIF
3345:     ENDPROC
3346:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nX, par_nY)

*-- Linhas 3533 a 3565:
3533:             loc_cValores = THIS.SerializarFiltros()
3534:             loc_nExiste  = 0
3535: 
3536:             IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId), "cursor_4c_FiltroExiste") > 0
3537:                 loc_nExiste = cursor_4c_FiltroExiste.nExiste
3538:                 USE IN cursor_4c_FiltroExiste
3539:             ENDIF
3540: 
3541:             IF loc_nExiste > 0
3542:                 loc_cSQL = "UPDATE SigSyPar SET mxmls = " + EscaparSQL(loc_cValores) + ;
3543:                            " WHERE cidparams = " + EscaparSQL(loc_cId)
3544:             ELSE
3545:                 loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
3546:                            EscaparSQL(loc_cId) + ", " + EscaparSQL("F") + ", " + ;
3547:                            EscaparSQL(LEFT(loc_cNome, 40)) + ", " + EscaparSQL(loc_cValores) + ")"
3548:             ENDIF
3549: 
3550:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3551:                 loc_oPag.txt_4c_NewFiltro.Visible = .F.
3552:                 loc_oPag.txt_4c_Filtros.Visible   = .T.
3553:                 loc_oPag.txt_4c_Filtros.Value     = loc_cNome
3554:                 THIS.CarregarFiltrosSalvos()
3555:                 MsgInfo("Filtro grav" + CHR(225) + "do com sucesso!", "Confirmar")
3556:             ELSE
3557:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3558:             ENDIF
3559:         CATCH TO loc_oErro
3560:             MsgErro(loc_oErro.Message, "Erro")
3561:         ENDTRY
3562:     ENDPROC
3563: 
3564:     PROCEDURE CmdDelFiltroClick()
3565:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cSQL, loc_oErro

*-- Linhas 3581 a 3601:
3581: 
3582:         TRY
3583:             loc_cId  = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3584:             loc_cSQL = "DELETE FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId)
3585: 
3586:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3587:                 loc_oPag.txt_4c_Filtros.Value = ""
3588:                 THIS.CarregarFiltrosSalvos()
3589:             ELSE
3590:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3591:             ENDIF
3592:         CATCH TO loc_oErro
3593:             MsgErro(loc_oErro.Message, "Erro")
3594:         ENDTRY
3595:     ENDPROC
3596: 
3597:     *--------------------------------------------------------------------------
3598:     * GetFiltrosLostFocus - Ao sair do campo com um nome existente em
3599:     * cursor_4c_Filtros, restaura os valores salvos nos campos de filtro
3600:     * (equivalente ao mLerCfg() do Framework legado).
3601:     *--------------------------------------------------------------------------

*-- Linhas 3610 a 3628:
3610:             RETURN
3611:         ENDIF
3612: 
3613:         SELECT (loc_cCursor)
3614:         LOCATE FOR ALLTRIM(Descrs) == loc_cNome
3615: 
3616:         IF FOUND()
3617:             THIS.RestaurarFiltros(ALLTRIM(Mxmls))
3618:         ENDIF
3619:     ENDPROC
3620: 
3621:     *--------------------------------------------------------------------------
3622:     * SerializarFiltros/RestaurarFiltros - Serializacao plana (CHR(9) como
3623:     * separador) dos campos de filtro para gravar/recarregar um filtro
3624:     * nomeado em SigSyPar.Mxmls.
3625:     *--------------------------------------------------------------------------
3626:     PROTECTED PROCEDURE SerializarFiltros()
3627:         LOCAL loc_oBO
3628: 

*-- Linhas 3749 a 3794:
3749: 
3750:     *--------------------------------------------------------------------------
3751:     * CarregarTiposOperacao - Popula cursor_4c_Tipos a partir de SigOpOpe
3752:     * (equivalente ao Select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe
3753:     * Order By Dopes + Insert Into ...(0, Space(20), 'C') do legado).
3754:     *--------------------------------------------------------------------------
3755:     PROTECTED PROCEDURE CarregarTiposOperacao()
3756:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL
3757: 
3758:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3759:             RETURN
3760:         ENDIF
3761: 
3762:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorTipos
3763:         loc_cCursorTmp = loc_cCursor + "Tmp"
3764:         loc_cSQL       = "SELECT 1 AS Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes"
3765: 
3766:         *-- cursor_4c_Tipos esta ligado a grd_4c_Tipos.RecordSource - SQLEXEC
3767:         *-- direto nele zeraria o ColumnCount (regra do Grid/SQLEXEC). O
3768:         *-- SQLEXEC vai para um cursor TEMPORARIO e o placeholder (criado em
3769:         *-- CriarCursoresFiltros, com a MESMA estrutura/indice) e recarregado
3770:         *-- com ZAP + APPEND FROM DBF, preservando a estrutura do Grid.
3771:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3772:             SELECT (loc_cCursor)
3773:             ZAP
3774:             APPEND FROM DBF(loc_cCursorTmp)
3775:             IF USED(loc_cCursorTmp)
3776:                 USE IN (loc_cCursorTmp)
3777:             ENDIF
3778: 
3779:             SELECT (loc_cCursor)
3780:             APPEND BLANK
3781:             REPLACE Imps WITH 0, Dopes WITH SPACE(20), Opers WITH "C", RealPrevs WITH 0
3782:             GO TOP
3783: 
3784:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3785:         ENDIF
3786:     ENDPROC
3787: 
3788:     *--------------------------------------------------------------------------
3789:     * CarregarFiltrosSalvos - Popula cursor_4c_Filtros com os filtros
3790:     * nomeados ja gravados em SigSyPar para este form (cidparams iniciando
3791:     * por "SIGOPCGF").
3792:     *--------------------------------------------------------------------------
3793:     PROTECTED PROCEDURE CarregarFiltrosSalvos()
3794:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cId

*-- Linhas 3801 a 3829:
3801:         loc_cCursorTmp = loc_cCursor + "Tmp"
3802:         loc_cId        = PADR("SIGOPCGF", 8)
3803: 
3804:         loc_cSQL = "SELECT cidparams, ctpparams, descrs, mxmls FROM SigSyPar WHERE LEFT(cidparams, 8) = " + ;
3805:                    EscaparSQL(loc_cId) + " ORDER BY descrs"
3806: 
3807:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3808:             SELECT (loc_cCursor)
3809:             ZAP
3810:             APPEND FROM DBF(loc_cCursorTmp)
3811:             IF USED(loc_cCursorTmp)
3812:                 USE IN (loc_cCursorTmp)
3813:             ENDIF
3814:             SELECT (loc_cCursor)
3815:             GO TOP
3816:         ENDIF
3817:     ENDPROC
3818: 
3819:     *--------------------------------------------------------------------------
3820:     * BtnCarregarClick/CarregarFPubs - Carrega em grd_4c_Clientes os pares
3821:     * Grupo/Conta vinculados a Forma de Publicidade digitada (equivalente ao
3822:     * ThisForm.CarregarFPubs do legado). A checagem extra de acesso por
3823:     * usuario/conta (fAcessoContas/fChecarInativas no legado) depende de
3824:     * tabelas de controle de acesso do Framework (SigSyAgc/SigCdAcG/
3825:     * SigSyAcc) fora do escopo desta tela de filtro - o filtro principal
3826:     * (FPubls = codigo informado) e o mesmo usado pelo legado para
3827:     * restringir o universo de clientes.
3828:     *--------------------------------------------------------------------------
3829:     PROCEDURE BtnCarregarClick()

*-- Linhas 3852 a 3907:
3852:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorClientes
3853:         loc_cCursorTmp = loc_cCursor + "Tmp"
3854: 
3855:         loc_cSQL = "SELECT a.Grupos AS Grupo, b.Descrs AS NomeGrupo, a.IClis AS Conta, " + ;
3856:                    "a.RClis AS Nome, 0 AS CheckE, 0 AS CheckP, 0 AS CheckC, 0 AS CheckA " + ;
3857:                    "FROM SigCdCli a, SigCdGcr b " + ;
3858:                    "WHERE a.Grupos = b.Codigos AND a.FPubls = " + EscaparSQL(loc_cPub)
3859: 
3860:         *-- cursor_4c_Clientes esta ligado a grd_4c_Clientes.RecordSource -
3861:         *-- ZAP + APPEND FROM DBF preserva a estrutura/binding do Grid.
3862:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) > 0
3863:             SELECT (loc_cCursor)
3864:             ZAP
3865:             APPEND FROM DBF(loc_cCursorTmp)
3866:             IF USED(loc_cCursorTmp)
3867:                 USE IN (loc_cCursorTmp)
3868:             ENDIF
3869:             SELECT (loc_cCursor)
3870:             GO TOP
3871:             loc_oPag.grd_4c_Clientes.Refresh()
3872:         ELSE
3873:             MsgAviso("Nenhum cliente encontrado para a Forma de Publicidade [" + loc_cPub + "].", "Aten" + CHR(231) + CHR(227) + "o")
3874:         ENDIF
3875:     ENDPROC
3876: 
3877:     *--------------------------------------------------------------------------
3878:     * ConfigurarGradeDados - cria grd_4c_Dados (grade de resultado da
3879:     * consulta, equivalente a grdDados1/LocalDados do legado). SO estrutura
3880:     * estatica (posicao/tamanho/propriedades de grade) - ColumnCount/
3881:     * RecordSource/ControlSource ficam em MontarGradeDados(), chamado DEPOIS
3882:     * de Processamento() povoar cursor_4c_Dados (regra #41 do CLAUDE.md:
3883:     * ControlSource de cursor que ainda nao existe derruba o Init).
3884:     *--------------------------------------------------------------------------
3885:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3886:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3887:         WITH par_oPag.grd_4c_Dados
3888:             .Top               = 202
3889:             .Left              = 7
3890:             .Width             = 986
3891:             .Height            = 355
3892:             .DeleteMark        = .F.
3893:             .RecordMark        = .F.
3894:             .ReadOnly          = .T.
3895:             .AllowHeaderSizing = .F.
3896:             .AllowRowSizing    = .F.
3897:             .GridLineColor     = RGB(238, 238, 238)
3898:             .ScrollBars        = 2
3899:             .Visible           = .T.
3900:         ENDWITH
3901:         BINDEVENT(par_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
3902:     ENDPROC
3903: 
3904:     *--------------------------------------------------------------------------
3905:     * MontarGradeDados - Equivalente a ThisForm.MontaGradeD do legado. Religa
3906:     * as 12 colunas a cursor_4c_Dados. RecordSource reseta Column.Width e
3907:     * Header1.Caption (regra #48) - por isso TUDO e refeito aqui, sempre

*-- Linhas 3922 a 3986:
3922:             .ColumnCount  = 12
3923:             .RecordSource = loc_cCursor
3924: 
3925:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3926:             .Column1.Width           = 64
3927:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3928: 
3929:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3930:             .Column2.Width           = 64
3931:             .Column2.Header1.Caption = "Vencto."
3932: 
3933:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3934:             .Column3.Width           = 64
3935:             .Column3.Header1.Caption = "Lancto."
3936: 
3937:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3938:             .Column4.Width           = 64
3939:             .Column4.Header1.Caption = "Baixa"
3940: 
3941:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3942:             .Column5.Width           = 70
3943:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3944: 
3945:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3946:             .Column6.Width           = 240
3947:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3948: 
3949:             .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
3950:             .Column7.Width           = 20
3951:             .Column7.Header1.Caption = "$"
3952: 
3953:             .Column8.ControlSource   = loc_cCursor + ".Valors"
3954:             .Column8.Width           = 68
3955:             .Column8.Header1.Caption = "Valor"
3956: 
3957:             *-- Legado usa goSistema.TxtDebito/TxtCredito (rotulo customizavel
3958:             *-- por cliente) - essa customizacao NAO foi portada; caption fixo.
3959:             .Column9.ControlSource   = loc_cCursor + ".Debitos"
3960:             .Column9.Width           = 68
3961:             .Column9.Header1.Caption = "D" + CHR(233) + "bito"
3962: 
3963:             .Column10.ControlSource   = loc_cCursor + ".Creditos"
3964:             .Column10.Width           = 68
3965:             .Column10.Header1.Caption = "Cr" + CHR(233) + "dito"
3966: 
3967:             .Column11.ControlSource   = loc_cCursor + ".SaldoDia"
3968:             .Column11.Width           = 82
3969:             .Column11.Header1.Caption = "Saldo"
3970: 
3971:             .Column12.ControlSource   = loc_cCursor + ".SaldoTot"
3972:             .Column12.Width           = 82
3973:             .Column12.Header1.Caption = "Acumulado"
3974: 
3975:             .SetAll("DynamicBackColor", loc_cCor, "Column")
3976:             .FontName = "Arial"
3977:             .SetAll("Movable", .F., "Column")
3978:             .SetAll("Resizable", .F., "Column")
3979:             .SetAll("ReadOnly", .T., "Column")
3980:         ENDWITH
3981: 
3982:         GO TOP IN (loc_cCursor)
3983:         loc_oGrid.Refresh()
3984:     ENDPROC
3985: 
3986:     *--------------------------------------------------------------------------

*-- Linhas 4061 a 4091:
4061: 
4062:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorContas
4063:         IF !USED(loc_cCursor)
4064:             CREATE CURSOR (loc_cCursor) (IClis C(10), RClis C(50))
4065:             INDEX ON IClis TAG IClis
4066:         ENDIF
4067: 
4068:         SELECT (loc_cCursor)
4069:         IF SEEK(PADR(loc_cCodigo, 10), loc_cCursor, "IClis")
4070:             RETURN ALLTRIM(RClis)
4071:         ENDIF
4072: 
4073:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
4074:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp") > 0
4075:             IF !EOF("cursor_4c_RazaoTmp")
4076:                 INSERT INTO (loc_cCursor) (IClis, RClis) VALUES ;
4077:                     (PADR(ALLTRIM(cursor_4c_RazaoTmp.IClis), 10), cursor_4c_RazaoTmp.RClis)
4078:                 loc_cResultado = ALLTRIM(cursor_4c_RazaoTmp.RClis)
4079:             ENDIF
4080:             IF USED("cursor_4c_RazaoTmp")
4081:                 USE IN cursor_4c_RazaoTmp
4082:             ENDIF
4083:         ENDIF
4084: 
4085:         RETURN loc_cResultado
4086:     ENDFUNC
4087: 
4088:     *--------------------------------------------------------------------------
4089:     * CboOrdemInteractiveChange / ChkTotaisClick - equivalentes ao
4090:     * InteractiveChange de cmbOrdem e ao Valid de chkTotais: atualizam
4091:     * this_cOrdem/this_nOrdem e reordenam a grade (OrdenaGrade).

*-- Linhas 4142 a 4160:
4142: 
4143:         loc_cOrd = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "", "_") + loc_oBO.this_cOrdem
4144: 
4145:         SELECT (loc_cCursor)
4146:         SET ORDER TO TAG (loc_cOrd)
4147: 
4148:         IF INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
4149:             THIS.CalcSaldoCta()
4150:         ELSE
4151:             THIS.CalcSaldo()
4152:         ENDIF
4153: 
4154:         GO TOP IN (loc_cCursor)
4155:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
4156:     ENDPROC
4157: 
4158:     *--------------------------------------------------------------------------
4159:     * CalcSaldo - transcricao literal de ThisForm.CalcSaldo: recalcula
4160:     * Debitos/Creditos/SaldoDia/SaldoTot linha a linha e insere as linhas

*-- Linhas 4171 a 4208:
4171:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4172:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4173: 
4174:         SELECT (loc_cCursor)
4175:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4176: 
4177:         loc_nSdD = 0
4178:         loc_nSD1 = 0
4179:         loc_nSC1 = 0
4180:         loc_nSD2 = 0
4181:         loc_nSC2 = 0
4182:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4183:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4184:         loc_nOrd = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value
4185: 
4186:         IF USED(loc_cTotais)
4187:             USE IN (loc_cTotais)
4188:         ENDIF
4189:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4190: 
4191:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4192: 
4193:         SELECT (loc_cCursor)
4194:         GO TOP
4195:         loc_dDat = TTOD(DtEmis)
4196:         DO CASE
4197:         CASE loc_nOrd = 2
4198:             loc_dDat = TTOD(Vencs)
4199:         CASE loc_nOrd = 3
4200:             loc_dDat = TTOD(Datas)
4201:         CASE loc_nOrd = 4
4202:             loc_dDat = TTOD(DtBaixa)
4203:         ENDCASE
4204: 
4205:         loc_cMoe = ALLTRIM(Moedas)
4206: 
4207:         IF !EMPTY(loc_nSdT)
4208:             IF (loc_cMsd <> loc_cMoe)

*-- Linhas 4227 a 4249:
4227:             m.OrdHs    = "1"
4228:             m.Titulos  = ""
4229: 
4230:             INSERT INTO (loc_cTotais) FROM MEMVAR
4231:             REPLACE SInis WITH 1 IN (loc_cTotais)
4232:         ENDIF
4233: 
4234:         SELECT (loc_cCursor)
4235:         SCAN
4236:             loc_dRla = TTOD(DtEmis)
4237:             DO CASE
4238:             CASE loc_nOrd = 2
4239:                 loc_dRla = TTOD(Vencs)
4240:             CASE loc_nOrd = 3
4241:                 loc_dRla = TTOD(Datas)
4242:             CASE loc_nOrd = 4
4243:                 loc_dRla = TTOD(DtBaixa)
4244:             ENDCASE
4245: 
4246:             IF (loc_cMoe <> ALLTRIM(Moedas))
4247:                 SCATTER MEMVAR
4248:                 m.Nopers   = 9999999
4249:                 m.Valors   = 0

*-- Linhas 4259 a 4277:
4259:                 m.Moedas   = loc_cMoe
4260:                 m.OrdHs    = CHR(254)
4261:                 m.Titulos  = REPLICATE(CHR(254), 10)
4262:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4263:                 loc_nSD1 = 0
4264:                 loc_nSC1 = 0
4265: 
4266:                 IF INLIST(loc_cOrdem, "Titulos", "Hists")
4267:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
4268:                     loc_nSdD = 0
4269:                 ENDIF
4270:             ENDIF
4271: 
4272:             IF !INLIST(loc_cOrdem, "Titulos", "Hists")
4273:                 IF ((loc_dDat <> loc_dRla) OR (loc_cMoe <> ALLTRIM(Moedas))) AND INLIST(loc_nOrd, 1, 2, 3, 4)
4274:                     SCATTER MEMVAR
4275:                     m.Nopers   = 9999998
4276:                     m.Valors   = 0
4277:                     m.DtEmis   = loc_dDat

*-- Linhas 4284 a 4302:
4284:                     m.SaldoDia = loc_nSdD
4285:                     m.SaldoTot = loc_nSdT
4286:                     m.Moedas   = loc_cMoe
4287:                     INSERT INTO (loc_cTotais) FROM MEMVAR
4288: 
4289:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
4290:                     loc_nSdD = 0
4291:                     loc_nSD2 = 0
4292:                     loc_nSC2 = 0
4293:                 ENDIF
4294:             ENDIF
4295: 
4296:             loc_dDat = loc_dRla
4297:             loc_cMoe = ALLTRIM(Moedas)
4298:             loc_nVal = ABS(Valors)
4299: 
4300:             loc_nSdD = loc_nSdD + (loc_nVal * IIF(Opers = "D", 1, -1))
4301:             loc_nSdT = loc_nSdT + (loc_nVal * IIF(Opers = "D", 1, -1))
4302: 

*-- Linhas 4311 a 4410:
4311:                     SaldoTot WITH loc_nSdT
4312:         ENDSCAN
4313: 
4314:         SELECT (loc_cCursor)
4315:         SKIP -1
4316:         IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
4317:             IF !INLIST(loc_cOrdem, "Titulos", "Hists")
4318:                 SCATTER MEMVAR
4319:                 m.Nopers   = 9999998
4320:                 m.Valors   = 0
4321:                 m.DtEmis   = loc_dDat
4322:                 m.Vencs    = loc_dDat
4323:                 m.Datas    = loc_dDat
4324:                 m.DtBaixa  = loc_dDat
4325:                 m.Hists    = "Saldo do dia " + DTOC(loc_dDat) + ":"
4326:                 m.Debitos  = loc_nSD2
4327:                 m.Creditos = loc_nSC2
4328:                 m.SaldoDia = loc_nSdD
4329:                 m.SaldoTot = loc_nSdT
4330:                 m.Moedas   = loc_cMoe
4331:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4332:             ENDIF
4333: 
4334:             SCATTER MEMVAR
4335:             m.Nopers   = 9999999
4336:             m.Valors   = 0
4337:             m.DtEmis   = loc_dDat
4338:             m.Vencs    = loc_dDat
4339:             m.Datas    = loc_dDat
4340:             m.DtBaixa  = loc_dDat
4341:             m.Hists    = "Saldo da Moeda " + loc_cMoe + ":"
4342:             m.Debitos  = loc_nSD1
4343:             m.Creditos = loc_nSC1
4344:             m.SaldoDia = loc_nSdD
4345:             m.SaldoTot = loc_nSdT
4346:             m.Moedas   = loc_cMoe
4347:             m.OrdHs    = CHR(254)
4348:             m.Titulos  = REPLICATE(CHR(254), 10)
4349:             INSERT INTO (loc_cTotais) FROM MEMVAR
4350:         ENDIF
4351: 
4352:         SELECT (loc_cTotais)
4353:         SCAN
4354:             SCATTER MEMVAR
4355:             INSERT INTO (loc_cCursor) FROM MEMVAR
4356:         ENDSCAN
4357: 
4358:         GO TOP IN (loc_cCursor)
4359:     ENDPROC
4360: 
4361:     *--------------------------------------------------------------------------
4362:     * CalcSaldoCta - transcricao literal de ThisForm.CalcSaldoCta: mesma
4363:     * logica de CalcSaldo, mas agrupando por Emitente (ContEms) ou Portador
4364:     * (Contas) em vez de por data, com a razao social (ObterRazaoSocial)
4365:     * compondo a linha sintetica de saldo.
4366:     *--------------------------------------------------------------------------
4367:     PROTECTED PROCEDURE CalcSaldoCta()
4368:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4369:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4370:         LOCAL loc_cMsd, loc_dDat, loc_cMoe, loc_cEmi, loc_cPor, loc_nVal
4371: 
4372:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4373:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4374:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4375:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4376: 
4377:         SELECT (loc_cCursor)
4378:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4379: 
4380:         loc_nSdD = 0
4381:         loc_nSD1 = 0
4382:         loc_nSC1 = 0
4383:         loc_nSD2 = 0
4384:         loc_nSC2 = 0
4385:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4386:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4387: 
4388:         IF USED(loc_cTotais)
4389:             USE IN (loc_cTotais)
4390:         ENDIF
4391:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4392: 
4393:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4394: 
4395:         SELECT (loc_cCursor)
4396:         GO TOP
4397:         loc_dDat = TTOD(DtEmis)
4398:         loc_cMoe = ALLTRIM(Moedas)
4399:         loc_cEmi = ALLTRIM(ContEms)
4400:         loc_cPor = ALLTRIM(Contas)
4401: 
4402:         SCAN
4403:             IF (loc_cMoe <> ALLTRIM(Moedas)) OR ;
4404:                (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4405:                (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor)
4406: 
4407:                 SCATTER MEMVAR
4408:                 m.Nopers   = 9999999
4409:                 m.Valors   = 0
4410:                 m.DtEmis   = loc_dDat

*-- Linhas 4435 a 4453:
4435:                 m.Contas   = loc_cPor
4436:                 m.OrdHs    = CHR(254)
4437:                 m.Titulos  = REPLICATE(CHR(254), 10)
4438:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4439:                 loc_nSD1 = 0
4440:                 loc_nSC1 = 0
4441: 
4442:                 IF INLIST(loc_cOrdem, "Titulos", "Hists", "ContEms", "Contas")
4443:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas) OR ;
4444:                                    (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4445:                                    (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor), 0, loc_nSdT)
4446:                     loc_nSdD = 0
4447:                 ENDIF
4448:             ENDIF
4449: 
4450:             loc_cMoe = ALLTRIM(Moedas)
4451:             loc_cEmi = ALLTRIM(ContEms)
4452:             loc_cPor = ALLTRIM(Contas)
4453:             loc_nVal = ABS(Valors)

*-- Linhas 4466 a 4484:
4466:                     SaldoTot WITH loc_nSdT
4467:         ENDSCAN
4468: 
4469:         SELECT (loc_cCursor)
4470:         SKIP -1
4471:         IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
4472:             SCATTER MEMVAR
4473:             m.Nopers   = 9999999
4474:             m.Valors   = 0
4475:             m.DtEmis   = loc_dDat
4476:             m.Vencs    = loc_dDat
4477:             m.Datas    = loc_dDat
4478:             m.DtBaixa  = loc_dDat
4479:             m.Hists    = ""
4480:             IF (loc_cOrdem = "ContEms")
4481:                 m.Hists = "Saldo " + ALLTRIM(loc_cMoe)
4482:                 IF !EMPTY(loc_cEmi)
4483:                     m.Hists = m.Hists + " / " + loc_cEmi + " " + ALLTRIM(THIS.ObterRazaoSocial(loc_cEmi))
4484:                 ENDIF

*-- Linhas 4498 a 4522:
4498:             m.Moedas   = loc_cMoe
4499:             m.OrdHs    = CHR(254)
4500:             m.Titulos  = REPLICATE(CHR(254), 10)
4501:             INSERT INTO (loc_cTotais) FROM MEMVAR
4502:         ENDIF
4503: 
4504:         SELECT (loc_cTotais)
4505:         SCAN
4506:             SCATTER MEMVAR
4507:             INSERT INTO (loc_cCursor) FROM MEMVAR
4508:         ENDSCAN
4509: 
4510:         GO TOP IN (loc_cCursor)
4511:     ENDPROC
4512: 
4513:     *--------------------------------------------------------------------------
4514:     * AplicarFiltroGrupoContaManter / AplicarFiltroGrupoContaExcluirTodas -
4515:     * helpers do filtro de Grupo/Conta informado nas duas grades de
4516:     * selecao (cursor_4c_Clientes/cursor_4c_Clientes2), transcritos do Do
4517:     * Case do Processamento legado. A versao "ExcluirTodas" preserva, de
4518:     * proposito, a assimetria do dump original (quando os DOIS campos estao
4519:     * preenchidos, o grupo usa "<>" e a conta usa "=" em vez de "<>") -
4520:     * regra #17 do CLAUDE.md: transcrever, nunca reescrever.
4521:     *--------------------------------------------------------------------------
4522:     PROTECTED PROCEDURE AplicarFiltroGrupoContaManter(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)

*-- Linhas 4537 a 4576:
4537:             RETURN
4538:         ENDCASE
4539: 
4540:         UPDATE (par_cCursorDados) SET ManterDados = 1 WHERE &loc_cWhere.
4541:     ENDPROC
4542: 
4543:     PROTECTED PROCEDURE AplicarFiltroGrupoContaExcluirTodas(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4544:         LOCAL loc_cWhere
4545: 
4546:         IF EMPTY(par_cColGrupo)
4547:             RETURN
4548:         ENDIF
4549: 
4550:         DO CASE
4551:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4552:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "' OR " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4553:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4554:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "'"
4555:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4556:             loc_cWhere = par_cColConta + " <> '" + ALLTRIM(par_cConta) + "'"
4557:         OTHERWISE
4558:             RETURN
4559:         ENDCASE
4560: 
4561:         UPDATE (par_cCursorDados) SET ManterDados = 0 WHERE &loc_cWhere.
4562:     ENDPROC
4563: 
4564:     *--------------------------------------------------------------------------
4565:     * DataFimDiaSQL - monta o literal SQL Server do limite SUPERIOR de uma
4566:     * faixa de data (23:59:59), equivalente a fDtoSql(valor, [23:59:59]) do
4567:     * legado. Data vazia usa o sentinela 31/12/2099 (igual ao legado).
4568:     *--------------------------------------------------------------------------
4569:     PROTECTED FUNCTION DataFimDiaSQL(par_dData)
4570:         LOCAL loc_dData
4571:         loc_dData = par_dData
4572:         IF EMPTY(loc_dData)
4573:             loc_dData = {^2099-12-31}
4574:         ENDIF
4575:         RETURN "'" + PADL(YEAR(loc_dData), 4, "0") + "-" + PADL(MONTH(loc_dData), 2, "0") + "-" + ;
4576:                PADL(DAY(loc_dData), 2, "0") + " 23:59:59'"

*-- Linhas 4611 a 4675:
4611:         IF !EMPTY(loc_oPag1.txt_4c_Empresa.Value)
4612:             loc_cCodEmp = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
4613:             loc_cRes = loc_cRes + " / Empresa: " + loc_cCodEmp
4614:             loc_cEmp = " AND (CASE WHEN a.EmpCcs <> '' AND a.EmpCcs = " + EscaparSQL(loc_cCodEmp) + " THEN 1 " + ;
4615:                        "ELSE CASE WHEN a.EmpCcs = '' AND a.Emps = " + EscaparSQL(loc_cCodEmp) + " THEN 1 ELSE 0 END END) = 1"
4616:         ENDIF
4617: 
4618:         *-- Emissao
4619:         loc_cDem = ""
4620:         IF !EMPTY(loc_oPag1.txt_4c_DtEmiI.Value)
4621:             loc_dDeI = loc_oPag1.txt_4c_DtEmiI.Value
4622:             loc_dDeF = loc_oPag1.txt_4c_DtEmiF.Value
4623:             loc_cDem = " AND (a.DtEmis BETWEEN " + FormatarDataSQL(loc_dDeI) + " AND " + THIS.DataFimDiaSQL(loc_dDeF) + ;
4624:                        IIF(loc_oPag1.chk_4c_Brancos.Value = 0, "", " OR a.DtEmis IS NULL") + ")"
4625:             loc_cRes = loc_cRes + " / Emiss" + CHR(227) + "o: " + DTOC(loc_dDeI) + " a " + ;
4626:                        DTOC(IIF(EMPTY(loc_dDeF), {^2099-12-31}, loc_dDeF))
4627:         ENDIF
4628: 
4629:         *-- Vencimento
4630:         loc_cDvc = ""
4631:         IF !EMPTY(loc_oPag1.txt_4c_VencsI.Value)
4632:             loc_dDvI = loc_oPag1.txt_4c_VencsI.Value
4633:             loc_dDvF = loc_oPag1.txt_4c_VencsF.Value
4634:             loc_cDvc = " AND a.Vencs BETWEEN " + FormatarDataSQL(loc_dDvI) + " AND " + THIS.DataFimDiaSQL(loc_dDvF)
4635:             loc_cRes = loc_cRes + " / Vencimento: " + DTOC(loc_dDvI) + " a " + ;
4636:                        DTOC(IIF(EMPTY(loc_dDvF), {^2099-12-31}, loc_dDvF))
4637:         ENDIF
4638: 
4639:         *-- Lancamento
4640:         loc_cDla = ""
4641:         IF !EMPTY(loc_oPag1.txt_4c_DatasI.Value)
4642:             loc_dDlI = loc_oPag1.txt_4c_DatasI.Value
4643:             loc_dDlF = loc_oPag1.txt_4c_DatasF.Value
4644:             loc_cDla = " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDlI) + " AND " + THIS.DataFimDiaSQL(loc_dDlF)
4645:             loc_cRes = loc_cRes + " / Lan" + CHR(231) + "amento: " + DTOC(loc_dDlI) + " a " + ;
4646:                        DTOC(IIF(EMPTY(loc_dDlF), {^2099-12-31}, loc_dDlF))
4647:         ENDIF
4648: 
4649:         *-- Acerto (data de baixa) - o legado comenta o fragmento no WHERE
4650:         *-- (lcDbx fica so na descricao); o filtro real roda DEPOIS do
4651:         *-- preenchimento da Data de Baixa, mais abaixo neste metodo.
4652:         IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
4653:             loc_cRes = loc_cRes + " / Acerto: " + DTOC(loc_oPag1.txt_4c_DtBxI.Value) + " a " + ;
4654:                        DTOC(IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value))
4655:         ENDIF
4656: 
4657:         *-- Moeda filtro
4658:         loc_cMoe = ""
4659:         IF !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
4660:             loc_cMoe = " AND a.Moedas = " + EscaparSQL(ALLTRIM(loc_oPag1.txt_4c_CMoes.Value))
4661:             loc_cRes = loc_cRes + " / Moeda Filtro: " + ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
4662:         ENDIF
4663: 
4664:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4665:             loc_cRes = loc_cRes + " / Moeda Convers" + CHR(227) + "o: " + ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value) + " (" + ;
4666:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 1, "Emiss" + CHR(227) + "o", ;
4667:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 2, "Vencimento", ;
4668:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 3, "Lan" + CHR(231) + "amento", ;
4669:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 4, "Data Atual", "Data Acerto")))) + ")"
4670:         ENDIF
4671: 
4672:         *-- Pagamento
4673:         loc_cPag = ""
4674:         IF loc_oPag1.opt_4c_Pagos.Value <> 1
4675:             loc_cPag = " AND a.Pagos = " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "'0'", "'1'")

*-- Linhas 4705 a 4875:
4705:         *-- Titulo / Nota Fiscal / Titulo Banco / Especie
4706:         loc_cTit = ""
4707:         IF !EMPTY(loc_oPag1.txt_4c_Titulos.Value)
4708:             loc_cTit = " AND a.Titulos = " + EscaparSQL(loc_oPag1.txt_4c_Titulos.Value)
4709:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo: " + ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
4710:         ENDIF
4711: 
4712:         loc_cNfs = ""
4713:         IF !EMPTY(loc_oPag1.txt_4c_NFs.Value)
4714:             loc_cNfs = " AND a.NFs = " + EscaparSQL(loc_oPag1.txt_4c_NFs.Value)
4715:             loc_cRes = loc_cRes + " / Nota Fiscal: " + ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
4716:         ENDIF
4717: 
4718:         loc_cTba = ""
4719:         IF !EMPTY(loc_oPag1.txt_4c_TitBans.Value)
4720:             loc_cTba = " AND a.TitBans = " + EscaparSQL(loc_oPag1.txt_4c_TitBans.Value)
4721:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo Banco: " + ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
4722:         ENDIF
4723: 
4724:         loc_cEsp = ""
4725:         IF !EMPTY(loc_oPag1.txt_4c_EspecieNfs.Value)
4726:             loc_cEsp = " AND a.EspecieNfs = " + EscaparSQL(loc_oPag1.txt_4c_EspecieNfs.Value)
4727:             loc_cRes = loc_cRes + " / Esp" + CHR(233) + "cie: " + ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
4728:         ENDIF
4729: 
4730:         IF !EMPTY(loc_oPag1.txt_4c_Saldo.Value)
4731:             loc_cRes = loc_cRes + " / Saldo Inicial: " + ALLTRIM(TRANSFORM(loc_oPag1.txt_4c_Saldo.Value, "999999999999.99")) + ;
4732:                        " " + ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4733:         ENDIF
4734: 
4735:         *-- Filtro de Movimentacao de Titulos (grd_4c_Tipos - cursor_4c_Tipos.Imps=1)
4736:         loc_cOpT = ""
4737:         SELECT (loc_oBO.this_cCursorTipos)
4738:         GO TOP
4739:         COUNT FOR Imps = 1 TO loc_nOpe
4740: 
4741:         DO CASE
4742:         CASE loc_nOpe = 1
4743:             GO TOP
4744:             LOCATE FOR Imps = 1
4745:             loc_cOpT = " AND a.Dopcs = " + EscaparSQL(ALLTRIM(Dopes))
4746:             loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: " + ALLTRIM(Dopes)
4747:         CASE loc_nOpe > 1
4748:             loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: "
4749:             loc_lPrimeira = .T.
4750:             loc_cOpT = " AND a.Dopcs IN ("
4751:             SCAN
4752:                 IF Imps = 1
4753:                     loc_cOpT = loc_cOpT + IIF(loc_lPrimeira, "", ",") + EscaparSQL(ALLTRIM(Dopes))
4754:                     loc_cRes = loc_cRes + IIF(loc_lPrimeira, "", ", ") + ALLTRIM(Dopes)
4755:                     loc_lPrimeira = .F.
4756:                 ENDIF
4757:             ENDSCAN
4758:             loc_cOpT = loc_cOpT + ")"
4759:         OTHERWISE
4760:             *-- Nao faz nada: carrega todos os lancamentos
4761:         ENDCASE
4762: 
4763:         *-- Consulta principal (SigMvCcr + SigCdPit + SigOpMvv)
4764:         loc_cCursorTmp = loc_cCursor + "Tmp"
4765:         loc_cSQL = "SELECT a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
4766:                    "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
4767:                    "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Moedas AS MoeOrigs, a.Cotacaos, a.ValOcurs, " + ;
4768:                    "a.Saldos, a.ValPags, a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, " + ;
4769:                    "a.Emps, a.Dopcs, a.EmpDopNums, a.EmpDopNcs, 1 AS ManterDados, a.DtEmis AS DtBaixa, " + ;
4770:                    "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoDia, CAST(9999999999.99 AS NUMERIC(15,2)) AS Debitos, " + ;
4771:                    "'8' AS OrdHs, a.Numes, a.Numcs, a.VOpers, " + ;
4772:                    "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoTot, CAST(9999999999.99 AS NUMERIC(15,2)) AS Creditos, " + ;
4773:                    "MAX(d.Vencs) AS Prorrogs, 0 AS SInis " + ;
4774:                    "FROM SigMvCcr a " + ;
4775:                    "LEFT JOIN SigCdPit b ON a.Nopers = b.Nopers " + ;
4776:                    "LEFT JOIN SigOpMvv d ON a.EmpDopNcs = d.EmpDopNcs " + ;
4777:                    "WHERE 0 = 0 " + loc_cEmp + loc_cDem + loc_cDvc + loc_cDla + loc_cMoe + loc_cPag + loc_cOpc + ;
4778:                    loc_cTit + loc_cNfs + loc_cTba + loc_cEsp + loc_cCan + loc_cCcl + loc_cOpT + " " + ;
4779:                    "GROUP BY a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
4780:                    "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
4781:                    "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Cotacaos, a.ValOcurs, a.Saldos, a.ValPags, " + ;
4782:                    "a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, a.Emps, a.Dopcs, " + ;
4783:                    "a.EmpDopNums, a.EmpDopNcs, a.Numes, a.Numcs, a.VOpers"
4784: 
4785:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) < 1
4786:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
4787:             RETURN .F.
4788:         ENDIF
4789: 
4790:         IF USED(loc_cCursor)
4791:             USE IN (loc_cCursor)
4792:         ENDIF
4793:         SELECT * FROM (loc_cCursorTmp) INTO CURSOR (loc_cCursor) READWRITE
4794:         IF USED(loc_cCursorTmp)
4795:             USE IN (loc_cCursorTmp)
4796:         ENDIF
4797: 
4798:         SELECT (loc_cCursor)
4799:         REPLACE ALL Saldos   WITH 0, ;
4800:                     DtBaixa  WITH CTOT(""), ;
4801:                     DtEmis   WITH TratarNulo(DtEmis, CTOT("")), ;
4802:                     Vencs    WITH TratarNulo(Vencs, CTOT("")), ;
4803:                     Datas    WITH TratarNulo(Datas, CTOT("")), ;
4804:                     Prorrogs WITH TratarNulo(Prorrogs, CTOT(""))
4805: 
4806:         SELECT (loc_cCursor)
4807:         GO TOP
4808:         IF EOF()
4809:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4810:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4811:             RETURN .F.
4812:         ENDIF
4813: 
4814:         IF loc_oPag1.chk_4c_ValPends.Value = 1
4815:             REPLACE ALL Valors WITH Valors - ValPags
4816:         ENDIF
4817: 
4818:         *-- Filtrando Grupos/Contas informados na grade 1 (cursor_4c_Clientes)
4819:         SELECT (loc_oBO.this_cCursorClientes)
4820:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4821:         IF FOUND()
4822:             UPDATE (loc_cCursor) SET ManterDados = 0
4823: 
4824:             SELECT (loc_oBO.this_cCursorClientes)
4825:             SCAN
4826:                 IF CheckE = 1
4827:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4828:                 ENDIF
4829:                 IF CheckP = 1
4830:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4831:                 ENDIF
4832:                 IF CheckC = 1
4833:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4834:                 ENDIF
4835:                 IF CheckA = 1
4836:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4837:                 ENDIF
4838:             ENDSCAN
4839: 
4840:             loc_cRes = loc_cRes + " / Grupos-Contas: "
4841:             SELECT (loc_oBO.this_cCursorClientes)
4842:             SCAN
4843:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4844:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4845:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4846:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4847:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4848:             ENDSCAN
4849: 
4850:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4851:         ENDIF
4852: 
4853:         *-- Filtrando Grupos/Contas informados na grade 2 (Todas/Alguma)
4854:         loc_nFl2 = loc_oPag1.opt_4c_FilGrd2.Value
4855:         SELECT (loc_oBO.this_cCursorClientes2)
4856:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4857:         IF FOUND()
4858:             UPDATE (loc_cCursor) SET ManterDados = IIF(loc_nFl2 = 1, 1, 0)
4859: 
4860:             SELECT (loc_oBO.this_cCursorClientes2)
4861:             SCAN
4862:                 IF loc_nFl2 = 1
4863:                     IF CheckE = 1
4864:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4865:                     ENDIF
4866:                     IF CheckP = 1
4867:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4868:                     ENDIF
4869:                     IF CheckC = 1
4870:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4871:                     ENDIF
4872:                     IF CheckA = 1
4873:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4874:                     ENDIF
4875:                 ELSE

*-- Linhas 4889 a 4973:
4889:             ENDSCAN
4890: 
4891:             loc_cRes = loc_cRes + " / Grupos-Contas (" + IIF(loc_nFl2 = 1, "Todas", "Alguma") + "): "
4892:             SELECT (loc_oBO.this_cCursorClientes2)
4893:             SCAN
4894:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4895:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4896:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4897:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4898:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4899:             ENDSCAN
4900: 
4901:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4902:         ENDIF
4903: 
4904:         *-- Filtrando os Titulos Prorrogados
4905:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4906:             IF loc_oPag1.opt_4c_Prorrogs.Value = 2
4907:                 DELETE FROM (loc_cCursor) WHERE EMPTY(Prorrogs)
4908:             ELSE
4909:                 DELETE FROM (loc_cCursor) WHERE !EMPTY(Prorrogs)
4910:             ENDIF
4911:         ENDIF
4912: 
4913:         *-- Preenchendo a Data da Baixa (titulos em aberto, Pagos = "0")
4914:         SELECT (loc_cCursor)
4915:         SCAN FOR Pagos = "0"
4916:             loc_nNop = Nopers
4917:             loc_cSQL = "SELECT b.DatarCs FROM SigCdPit a, SigCdPgr b " + ;
4918:                        "WHERE a.Nopers = " + FormatarNumeroSQL(loc_nNop, 0) + " AND a.EmpDopNums = b.EmpDopNums " + ;
4919:                        "ORDER BY b.DatarCs DESC"
4920:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4921:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
4922:                 RETURN .F.
4923:             ENDIF
4924:             IF !EOF("cursor_4c_ConsPgtDtBx")
4925:                 REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DatarCs IN (loc_cCursor)
4926:             ELSE
4927:                 IF USED("cursor_4c_ConsPgtDtBx")
4928:                     USE IN cursor_4c_ConsPgtDtBx
4929:                 ENDIF
4930:                 loc_cSQL = "SELECT Datas AS DataRcs FROM SigTtCcr WHERE NOpers = " + FormatarNumeroSQL(loc_nNop, 0) + " " + ;
4931:                            "ORDER BY Datas DESC"
4932:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4933:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
4934:                     RETURN .F.
4935:                 ENDIF
4936:                 IF !EOF("cursor_4c_ConsPgtDtBx")
4937:                     REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DataRcs IN (loc_cCursor)
4938:                 ENDIF
4939:             ENDIF
4940:             IF USED("cursor_4c_ConsPgtDtBx")
4941:                 USE IN cursor_4c_ConsPgtDtBx
4942:             ENDIF
4943:             SELECT (loc_cCursor)
4944:         ENDSCAN
4945: 
4946:         *-- Filtro de Acerto (Data de Baixa), aplicado SO depois do
4947:         *-- preenchimento acima - igual ao legado.
4948:         IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
4949:             loc_dPbI = loc_oPag1.txt_4c_DtBxI.Value
4950:             loc_dPbF = IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value)
4951:             DELETE FROM (loc_cCursor) WHERE !BETWEEN(TTOD(DtBaixa), loc_dPbI, loc_dPbF)
4952:         ENDIF
4953: 
4954:         *-- Convertendo valores para a moeda de conversao
4955:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4956:             loc_cMdO = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)
4957: 
4958:             SELECT (loc_cCursor)
4959:             SCAN
4960:                 IF ALLTRIM(Moedas) <> loc_cMdO
4961:                     loc_dTDat = TTOD(DtEmis)
4962:                     DO CASE
4963:                     CASE loc_oPag1.opt_4c_CotEm.Value = 2
4964:                         loc_dTDat = TTOD(Vencs)
4965:                     CASE loc_oPag1.opt_4c_CotEm.Value = 3
4966:                         loc_dTDat = TTOD(Datas)
4967:                     CASE loc_oPag1.opt_4c_CotEm.Value = 4
4968:                         loc_dTDat = DATE()
4969:                     CASE loc_oPag1.opt_4c_CotEm.Value = 5
4970:                         IF !EMPTY(DtBaixa)
4971:                             loc_dTDat = TTOD(DtBaixa)
4972:                         ENDIF
4973:                     ENDCASE

*-- Linhas 4991 a 5017:
4991:             ENDSCAN
4992:         ENDIF
4993: 
4994:         SELECT (loc_cCursor)
4995:         GO TOP
4996:         IF EOF()
4997:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4998:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4999:             RETURN .F.
5000:         ENDIF
5001: 
5002:         SELECT (loc_cCursor)
5003:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR (Nopers < 9999997) AND (SInis <> 1)
5004:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR (Nopers < 9999997) AND (SInis <> 1)
5005:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR (Nopers < 9999997) AND (SInis <> 1)
5006:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR (Nopers < 9999997) AND (SInis <> 1)
5007:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR (Nopers < 9999997) AND (SInis <> 1)
5008:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR (Nopers < 9999997) AND (SInis <> 1)
5009:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR (Nopers < 9999997) AND (SInis <> 1)
5010:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR (Nopers < 9999997) AND (SInis <> 1)
5011: 
5012:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG DtEmis
5013:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG Vencs
5014:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG Datas
5015:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG DtBaixa
5016:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG Titulos
5017:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG Hists

*-- Linhas 5028 a 5202:
5028:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value = loc_cRes
5029:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Refresh()
5030: 
5031:         SELECT (loc_cCursor)
5032:         GO TOP
5033: 
5034:         RETURN .T.
5035:     ENDPROC
5036: 
5037:     *--------------------------------------------------------------------------
5038:     * BtnMovimentoClick - equivalente ao Click de btnMovimento: identifica em
5039:     * qual tabela a movimentacao do titulo esta registrada (ChkRegister nao
5040:     * existe em BusinessBase - regra do CLAUDE.md - substituido por
5041:     * SELECT COUNT(*)) e abre a tela legada correspondente via DO FORM.
5042:     *--------------------------------------------------------------------------
5043:     PROCEDURE BtnMovimentoClick()
5044:         LOCAL loc_oBO, loc_cEmpDopNums, loc_nQtd, loc_cSQL
5045: 
5046:         loc_oBO = THIS.this_oBusinessObject
5047: 
5048:         IF loc_oBO.this_cLinTipos = "P" OR EMPTY(loc_oBO.this_nLinNopers)
5049:             RETURN
5050:         ENDIF
5051: 
5052:         loc_cEmpDopNums = PADR(loc_oBO.this_cLinEmps, 3) + PADR(loc_oBO.this_cLinDopes, 20) + STR(loc_oBO.this_nLinNumes, 6)
5053: 
5054:         *-- SigCdPgr (titulo em carteira de pagamento)
5055:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdPgr WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5056:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5057:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5058:         loc_nQtd = 0
5059:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPgr") > 0
5060:             loc_nQtd = cursor_4c_ChkPgr.Nreg
5061:             USE IN cursor_4c_ChkPgr
5062:         ENDIF
5063:         IF loc_nQtd > 0
5064:             DO FORM SigCdPgr WITH LEFT(loc_oBO.this_cLinDopes, 1), .T., loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5065:             RETURN
5066:         ENDIF
5067: 
5068:         *-- SigMvCab (movimento de estoque)
5069:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)
5070:         loc_nQtd = 0
5071:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab") > 0
5072:             loc_nQtd = cursor_4c_ChkMvCab.Nreg
5073:             USE IN cursor_4c_ChkMvCab
5074:         ENDIF
5075:         IF loc_nQtd > 0
5076:             IF WEXIST("FORM_")
5077:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Consultar o Movimento" + CHR(13) + ;
5078:                           "Existe Outra Movimenta" + CHR(231) + CHR(227) + "o Aberta!!!", "Movimento de Estoque Em Uso")
5079:             ELSE
5080:                 DO FORM SigMvExp WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5081:             ENDIF
5082:             RETURN
5083:         ENDIF
5084: 
5085:         *-- SigOpOpe (titulo vinculado a movimentacao de titulo bancario)
5086:         IF !EMPTY(loc_oBO.this_cLinEmps) AND !EMPTY(loc_oBO.this_cLinDopes) AND !EMPTY(loc_oBO.this_nLinNumes)
5087:             loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes)
5088:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpOpe") < 1
5089:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (cursor_4c_ChkOpOpe)")
5090:                 RETURN
5091:             ENDIF
5092:             IF !EOF("cursor_4c_ChkOpOpe")
5093:                 IF fChecaAcesso("C" + PADL(ALLTRIM(TRANSFORM(cursor_4c_ChkOpOpe.NDopes)), 8, "0"), "CONSULTAR")
5094:                     DO FORM SigPgTit WITH loc_oBO.this_cLinDopes, "CONSULTAR", loc_oBO.this_cLinEmps, ;
5095:                              STR(loc_oBO.this_nLinNumes, 6), (cursor_4c_ChkOpOpe.RealPrevs = 2)
5096:                 ELSE
5097:                     MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso a Consultar T" + CHR(237) + "tulos!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5098:                 ENDIF
5099:                 IF USED("cursor_4c_ChkOpOpe")
5100:                     USE IN cursor_4c_ChkOpOpe
5101:                 ENDIF
5102:                 RETURN
5103:             ENDIF
5104:             IF USED("cursor_4c_ChkOpOpe")
5105:                 USE IN cursor_4c_ChkOpOpe
5106:             ENDIF
5107:         ENDIF
5108: 
5109:         *-- SigCqChm (cheque)
5110:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCqChm WHERE Emps = " + EscaparSQL(LEFT(loc_oBO.this_cLinVOpers, 3)) + ;
5111:                    " AND Numos = " + FormatarNumeroSQL(VAL(PADL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)), 9)), 0)
5112:         loc_nQtd = 0
5113:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChm") > 0
5114:             loc_nQtd = cursor_4c_ChkChm.Nreg
5115:             USE IN cursor_4c_ChkChm
5116:         ENDIF
5117:         IF loc_nQtd > 0
5118:             DO FORM SigCdLch WITH .T., LEFT(loc_oBO.this_cLinVOpers, 3), VAL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)))
5119:             RETURN
5120:         ENDIF
5121: 
5122:         *-- SigPrCtb (contabilizacao)
5123:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigPrCtb WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5124:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5125:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5126:         loc_nQtd = 0
5127:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtb") > 0
5128:             loc_nQtd = cursor_4c_ChkCtb.Nreg
5129:             USE IN cursor_4c_ChkCtb
5130:         ENDIF
5131:         IF loc_nQtd > 0
5132:             DO FORM SigCdPgb WITH loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5133:             RETURN
5134:         ENDIF
5135: 
5136:         *-- SigCdNec (necessidade de material vinculada ao movimento)
5137:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdNec WHERE EmpDnPs = " + ;
5138:                    EscaparSQL(loc_oBO.this_cLinEmps + loc_oBO.this_cLinDopes + STR(loc_oBO.this_nLinNumes, 10))
5139:         loc_nQtd = 0
5140:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNec") > 0
5141:             loc_nQtd = cursor_4c_ChkNec.Nreg
5142:             USE IN cursor_4c_ChkNec
5143:         ENDIF
5144:         IF loc_nQtd > 0
5145:             DO FORM SigMvPdt WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5146:         ENDIF
5147:     ENDPROC
5148: 
5149:     *--------------------------------------------------------------------------
5150:     * BtnRecebeClick - equivalente ao Click de btnRecebe: busca o(s)
5151:     * recebimento(s) do titulo corrente (SigCdPit/SigCdPgr/SigCdPbx) e, se
5152:     * nao achar, cai no fallback de SigTtCcr - igual ao legado.
5153:     *--------------------------------------------------------------------------
5154:     PROCEDURE BtnRecebeClick()
5155:         LOCAL loc_oBO, loc_cSQL
5156: 
5157:         loc_oBO = THIS.this_oBusinessObject
5158: 
5159:         loc_cSQL = "SELECT DISTINCT a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques " + ;
5160:                    "FROM SigCdPit a, SigCdPgr b, SigCdPbx c " + ;
5161:                    "WHERE a.Nopers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + ;
5162:                    " AND a.EmpDopNums = b.EmpDopNums AND a.EmpDopNums = c.EmpDopNums " + ;
5163:                    "ORDER BY a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques"
5164: 
5165:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5166:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
5167:             RETURN
5168:         ENDIF
5169: 
5170:         IF !EOF("cursor_4c_ConsPgt")
5171:             IF USED("cursor_4c_ConsPgt")
5172:                 USE IN cursor_4c_ConsPgt
5173:             ENDIF
5174:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5175:             RETURN
5176:         ENDIF
5177:         IF USED("cursor_4c_ConsPgt")
5178:             USE IN cursor_4c_ConsPgt
5179:         ENDIF
5180: 
5181:         loc_cSQL = "SELECT Emps, Dopcs AS Dopes, Numcs AS Numes, Nopers, Datas AS DataRcs, 0 AS Acertos, " + ;
5182:                    "'   ' AS Moedas, Dopcs AS Fpags, ' ' AS NCheques " + ;
5183:                    "FROM SigTtCcr " + ;
5184:                    "WHERE NOpers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + " " + ;
5185:                    "ORDER BY Emps, Dopcs, Numcs, Nopers, Datas"
5186: 
5187:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5188:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
5189:             RETURN
5190:         ENDIF
5191: 
5192:         IF !EOF("cursor_4c_ConsPgt")
5193:             IF USED("cursor_4c_ConsPgt")
5194:                 USE IN cursor_4c_ConsPgt
5195:             ENDIF
5196:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5197:         ELSE
5198:             IF USED("cursor_4c_ConsPgt")
5199:                 USE IN cursor_4c_ConsPgt
5200:             ENDIF
5201:             MsgAviso("Nenhum Recebimento Localizado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5202:         ENDIF

*-- Linhas 5325 a 5403:
5325:         IF USED("cursor_4c_RelFin")
5326:             USE IN cursor_4c_RelFin
5327:         ENDIF
5328:         SELECT 9999999999 AS Ordem, Nopers, SPACE(1) AS Tipo, SaldoDia AS Saldos, SaldoTot AS SaldosP, Debitos, ;
5329:                Creditos, SPACE(10) AS ContaCobs, Grupos, Contas, ContEms, OrdHs, Hists, Hist2s, NFs, Datas, ;
5330:                Vencs, DtEmis, DtBaixa, Titulos, Moedas, SInis, SPACE(50) AS RClis ;
5331:           FROM (loc_cCursor) ;
5332:           INTO CURSOR cursor_4c_RelFin READWRITE
5333: 
5334:         SELECT cursor_4c_RelFin
5335:         GO TOP
5336:         IF EOF()
5337:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Impress" + CHR(227) + "o!!!", "Impress" + CHR(227) + "o")
5338:             USE IN cursor_4c_RelFin
5339:             RETURN
5340:         ENDIF
5341: 
5342:         loc_cTit = "Relat" + CHR(243) + "rio Financeiro"
5343:         loc_cSub = PROPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Filtros.Value)) + " - Ordem: " + ;
5344:                    PROPER(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.List(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.ListIndex))
5345:         loc_cRes = ALLTRIM(SUBSTR(ALLTRIM(THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value), 2))
5346: 
5347:         IF USED("cursor_4c_RelFinCab")
5348:             USE IN cursor_4c_RelFinCab
5349:         ENDIF
5350:         CREATE CURSOR cursor_4c_RelFinCab (Titulo C(80), SubTitulo C(80), Moeda1 C(80), RodRelCC M(4))
5351:         INSERT INTO cursor_4c_RelFinCab (Titulo, SubTitulo, RodRelCC) VALUES (loc_cTit, loc_cSub, loc_cRes)
5352:         GO TOP IN cursor_4c_RelFinCab
5353: 
5354:         loc_cFor = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "0=0", "(Nopers < 9999997) AND (SInis <> 1)")
5355: 
5356:         SELECT cursor_4c_RelFin
5357:         DO CASE
5358:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtEmis"
5359:             INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR &loc_cFor.
5360:         CASE THIS.this_oBusinessObject.this_cOrdem = "Vencs"
5361:             INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR &loc_cFor.
5362:         CASE THIS.this_oBusinessObject.this_cOrdem = "Datas"
5363:             INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR &loc_cFor.
5364:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtBaixa"
5365:             INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR &loc_cFor.
5366:         CASE THIS.this_oBusinessObject.this_cOrdem = "Titulos"
5367:             INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR &loc_cFor.
5368:         CASE THIS.this_oBusinessObject.this_cOrdem = "Hists"
5369:             INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR &loc_cFor.
5370:         CASE THIS.this_oBusinessObject.this_cOrdem = "ContEms"
5371:             INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR &loc_cFor.
5372:         CASE THIS.this_oBusinessObject.this_cOrdem = "Contas"
5373:             INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR &loc_cFor.
5374:         ENDCASE
5375: 
5376:         SELECT cursor_4c_RelFin
5377:         GO TOP
5378: 
5379:         IF !FILE(FULLPATH(loc_cFrx + ".frx"))
5380:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + FULLPATH(loc_cFrx + ".frx"), "Erro")
5381:         ELSE
5382:             THIS.ExecutarReportForm("SigReCgf", "PREVIEW")
5383:         ENDIF
5384: 
5385:         USE IN cursor_4c_RelFinCab
5386:         USE IN cursor_4c_RelFin
5387: 
5388:         SELECT (loc_cCursor)
5389:         GO TOP
5390:     ENDPROC
5391: 
5392:     *--------------------------------------------------------------------------
5393:     * Planilha - transcricao de ThisForm.Planilha: exporta cursor_4c_Dados
5394:     * para XLS/TXT via PUTFILE + COPY TO, igual ao legado (fVerificaPasta/
5395:     * fLimpaTexto ja portadas em utils/functions.prg).
5396:     *--------------------------------------------------------------------------
5397:     PROCEDURE Planilha()
5398:         LOCAL loc_cCursor, loc_cArq, loc_cDeb, loc_cCrd
5399: 
5400:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5401: 
5402:         IF !USED(loc_cCursor)
5403:             RETURN

*-- Linhas 5416 a 5464:
5416:             IF USED("cursor_4c_RelExcel")
5417:                 USE IN cursor_4c_RelExcel
5418:             ENDIF
5419:             SELECT IIF((Nopers < 9999997) AND (SInis <> 1), SPACE(5), "TOTAL") AS Linhas, ;
5420:                    TTOD(DtEmis) AS Emissao, TTOD(Vencs) AS Vencimento, TTOD(Datas) AS Lancamento, ;
5421:                    TTOD(DtBaixa) AS Baixa, Titulos AS Titulo, NFs AS NF, TitBans AS Bancos, ;
5422:                    EspecieNfs AS Especie, IIF(Pagos = "1", "Baixado ", "Pendente") AS Situacao, ;
5423:                    Hists AS Historico, Hist2s AS Historico2, Moedas AS Moeda, Valors AS Valor, ;
5424:                    Debitos AS Debito, Creditos AS Credito, SaldoDia AS Saldo, SaldoTot AS Acumulado, ;
5425:                    GrupEms AS Grp_Emitente, ContEms AS Cta_Emitente, Grupos AS Grp_Portador, Contas AS Cta_Portador, ;
5426:                    SGrupos AS Grp_CCusto, SContas AS Cta_CCusto, GrupAges AS Grp_Agente, ContAges AS Cta_Agente ;
5427:               FROM (loc_cCursor) ;
5428:               INTO CURSOR cursor_4c_RelExcel
5429: 
5430:             SELECT cursor_4c_RelExcel
5431:             GO TOP
5432: 
5433:             IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) = "xls"
5434:                 COPY TO (loc_cArq) TYPE XLS
5435:             ELSE
5436:                 COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
5437:             ENDIF
5438: 
5439:             IF FILE(loc_cArq)
5440:                 MsgInfo("Planilha Gerada Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
5441:             ENDIF
5442: 
5443:             USE IN cursor_4c_RelExcel
5444:         ELSE
5445:             MsgAviso("Ocorreu Um Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha, Verifique" + CHR(10) + ;
5446:                       "O Diret" + CHR(243) + "rio Ou Se a Planilha Se Encontra Em Uso!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5447:         ENDIF
5448: 
5449:         SELECT (loc_cCursor)
5450:         GO TOP
5451:     ENDPROC
5452: 
5453:     *==========================================================================
5454:     * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
5455:     *
5456:     * Os metodos abaixo sao os FUNIS unicos das acoes que o legado espalha
5457:     * entre os Click/When dos CommandGroups e o AfterRowColChange da grade.
5458:     * NENHUM botao novo foi criado (PILAR 1 / "NUNCA inventar"): cada funil e
5459:     * acionado pelo handler do controle que o SCX legado realmente tem.
5460:     *
5461:     *   BtnBuscarClick       <- cmgFiltros.Buttons(1) "Consultar"
5462:     *   BtnCancelarClick     <- cmgRetornar (volta da Page2) e, na Page1,
5463:     *                           cmgFiltros.Buttons(2) "Sair"
5464:     *   BtnEncerrarClick     <- cmgFiltros.Buttons(2) "Sair" (ThisForm.Release)

*-- Linhas 5550 a 5568:
5550:             RETURN .F.
5551:         ENDIF
5552: 
5553:         SELECT (loc_cCursor)
5554:         GO TOP
5555:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
5556: 
5557:         IF EOF(loc_cCursor)
5558:             THIS.LimparCampos()
5559:             THIS.AjustarBotoesPorModo()
5560:         ELSE
5561:             THIS.GrdDadosAfterRowColChange(1)
5562:         ENDIF
5563: 
5564:         loc_lResultado = .T.
5565:         RETURN loc_lResultado
5566:     ENDPROC
5567: 
5568:     *--------------------------------------------------------------------------


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

