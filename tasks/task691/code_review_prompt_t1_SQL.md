# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PLACEHOLDER' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDPARAMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, LOCALTOTA, CONTEMS, CONTAS, ICLIS, ORDHS, GRUPOS, SINIS, I, SITUAS, EMPS, EMPCCS, DTEMIS, VENCS, DATAS, DATARCS, MOEDAS, PAGOS, TITULOS, NFS, TITBANS, ESPECIENFS, IMPS, DOPCS, LNCHK, LCCPO, MANTERDADOS, NOPERS, DESCRS, DOPES, TITCANCS, ORDEM, FPUBLS, INFOS, EMPDOPNUMS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS SQL (5835 linhas total):

*-- Linhas 196 a 246:
196:     *--------------------------------------------------------------------------
197:     * CriarCursoresFiltros - Cria os cursores placeholder da Page1 ANTES do
198:     * ConfigurarPaginaFiltros() poder bindar os Grids (regra #41 - Column.
199:     * ControlSource exige que o cursor ja exista). Estrutura IDENTICA a que
200:     * CarregarTiposOperacao()/CarregarFiltrosSalvos() (SQLEXEC + SELECT INTO
201:     * CURSOR) recriam depois ("cursor placeholder = cursor real").
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE CriarCursoresFiltros()
204:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2, loc_cFiltros
205: 
206:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
207:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
208:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
209:         loc_cFiltros   = THIS.this_oBusinessObject.this_cCursorFiltros
210: 
211:         IF !USED(loc_cTipos)
212:             CREATE CURSOR (loc_cTipos) (Imps N(1,0), Dopes C(20), Opers C(2), RealPrevs N(1,0))
213:             INDEX ON Dopes TAG Dopes
214:         ENDIF
215: 
216:         IF !USED(loc_cClientes)
217:             CREATE CURSOR (loc_cClientes) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
218:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
219:             SELECT (loc_cClientes)
220:             APPEND BLANK
221:         ENDIF
222: 
223:         IF !USED(loc_cClientes2)
224:             CREATE CURSOR (loc_cClientes2) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
225:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
226:             SELECT (loc_cClientes2)
227:             APPEND BLANK
228:         ENDIF
229: 
230:         IF !USED(loc_cFiltros)
231:             CREATE CURSOR (loc_cFiltros) (Cidparams C(64), Ctpparams C(1), Mxmls M, Descrs C(40))
232:         ENDIF
233:     ENDPROC
234: 
235:     *--------------------------------------------------------------------------
236:     * ConfigurarPaginaFiltros - Monta todo o conteudo da Page1 (cabecalho,
237:     * campos de filtro, OptionGroups, grades e botoes).
238:     *--------------------------------------------------------------------------
239:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
240:         LOCAL loc_oPag
241:         loc_oPag = THIS.pgf_4c_Paginas.Page1
242: 
243:         THIS.ConfigurarCabecalhoFiltros(loc_oPag)
244:         THIS.ConfigurarCamposFiltros(loc_oPag)
245:         THIS.ConfigurarOptionGroupsFiltros(loc_oPag)
246:         THIS.ConfigurarGradesFiltros(loc_oPag)

*-- Linhas 1391 a 1431:
1391:             .FontName = "Tahoma"
1392:             .AllowHeaderSizing = .F.
1393:             .AllowRowSizing = .F.
1394:             .DeleteMark = .F.
1395:             .RecordMark = .F.
1396:             .HeaderHeight = 17
1397:             .RowHeight = 17
1398:             .ScrollBars = 2
1399:             .GridLineColor = RGB(238, 238, 238)
1400:             .ColumnCount = 2
1401:             .RecordSource = loc_cTipos
1402: 
1403:             .Column1.ControlSource = loc_cTipos + ".Imps"
1404:             .Column1.Width = 17
1405:             .Column1.Alignment = 0
1406:             .Column1.Sparse = .F.
1407:             .Column1.Header1.Caption = ""
1408:             .Column1.AddObject("Check1", "CheckBox")
1409:             .Column1.Check1.Top = 23
1410:             .Column1.Check1.Left = 35
1411:             .Column1.Check1.Width = 60
1412:             .Column1.Check1.Height = 17
1413:             .Column1.Check1.Caption = ""
1414:             .Column1.CurrentControl = "Check1"
1415: 
1416:             .Column2.ControlSource = loc_cTipos + ".Dopes"
1417:             .Column2.Width = 220
1418:             .Column2.Movable = .F.
1419:             .Column2.Resizable = .F.
1420:             .Column2.ReadOnly = .T.
1421:             .Column2.Text1.ReadOnly = .T.
1422:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
1423:             .Column2.Header1.Alignment = 2
1424:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1425: 
1426:             .Visible = .T.
1427:         ENDWITH
1428: 
1429:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "KeyPress", THIS, "ChkTipoKeyPress")
1430:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseUp", THIS, "ChkTipoMouseUp")
1431:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseDown", THIS, "ChkTipoMouseDown")

*-- Linhas 1488 a 1601:
1488:             .FontName = "Tahoma"
1489:             .AllowHeaderSizing = .F.
1490:             .AllowRowSizing = .F.
1491:             .DeleteMark = .F.
1492:             .RecordMark = .F.
1493:             .ScrollBars = 2
1494:             .GridLineColor = RGB(238, 238, 238)
1495:             .ColumnCount = 8
1496:             .RecordSource = par_cCursor
1497: 
1498:             .Column1.ControlSource = par_cCursor + ".Grupo"
1499:             .Column1.Width = 90
1500:             .Column1.Movable = .F.
1501:             .Column1.Resizable = .F.
1502:             .Column1.Text1.MaxLength = 10
1503:             .Column1.Header1.Caption = "Grupo"
1504:             .Column1.Header1.Alignment = 2
1505:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1506: 
1507:             .Column4.ColumnOrder = 2
1508:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1509:             .Column4.Width = 166
1510:             .Column4.Text1.MaxLength = 20
1511:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1512:             .Column4.Header1.Alignment = 2
1513:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1514: 
1515:             .Column2.ColumnOrder = 3
1516:             .Column2.ControlSource = par_cCursor + ".Conta"
1517:             .Column2.Width = 90
1518:             .Column2.Movable = .F.
1519:             .Column2.Resizable = .F.
1520:             .Column2.Text1.MaxLength = 10
1521:             .Column2.Header1.Caption = "Conta"
1522:             .Column2.Header1.Alignment = 2
1523:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1524: 
1525:             .Column3.ColumnOrder = 4
1526:             .Column3.ControlSource = par_cCursor + ".Nome"
1527:             .Column3.Width = 360
1528:             .Column3.Movable = .F.
1529:             .Column3.Resizable = .F.
1530:             .Column3.Text1.MaxLength = 50
1531:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1532:             .Column3.Header1.Alignment = 2
1533:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
1534: 
1535:             .Column5.ControlSource = par_cCursor + ".CheckE"
1536:             .Column5.Width = 17
1537:             .Column5.Sparse = .F.
1538:             .Column5.ToolTipText = "Emitente"
1539:             .Column5.Header1.Caption = "E"
1540:             .Column5.Header1.Alignment = 2
1541:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
1542:             .Column5.Header1.ToolTipText = "Emitente"
1543:             .Column5.AddObject("Check1", "CheckBox")
1544:             .Column5.Check1.Top = 31
1545:             .Column5.Check1.Left = 9
1546:             .Column5.Check1.Width = 60
1547:             .Column5.Check1.Height = 17
1548:             .Column5.Check1.Caption = ""
1549:             .Column5.Check1.ToolTipText = "Emitente"
1550:             .Column5.CurrentControl = "Check1"
1551: 
1552:             .Column6.ControlSource = par_cCursor + ".CheckP"
1553:             .Column6.Width = 17
1554:             .Column6.Sparse = .F.
1555:             .Column6.ToolTipText = "Portador"
1556:             .Column6.Header1.Caption = "P"
1557:             .Column6.Header1.Alignment = 2
1558:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
1559:             .Column6.Header1.ToolTipText = "Portador"
1560:             .Column6.AddObject("Check1", "CheckBox")
1561:             .Column6.Check1.Top = 31
1562:             .Column6.Check1.Left = 9
1563:             .Column6.Check1.Width = 60
1564:             .Column6.Check1.Height = 17
1565:             .Column6.Check1.Caption = ""
1566:             .Column6.Check1.ToolTipText = "Portador"
1567:             .Column6.CurrentControl = "Check1"
1568: 
1569:             .Column7.ControlSource = par_cCursor + ".CheckC"
1570:             .Column7.Width = 17
1571:             .Column7.Sparse = .F.
1572:             .Column7.ToolTipText = "Centro de Custo"
1573:             .Column7.Header1.Caption = "C"
1574:             .Column7.Header1.Alignment = 2
1575:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1576:             .Column7.Header1.ToolTipText = "Centro de Custo"
1577:             .Column7.AddObject("Check1", "CheckBox")
1578:             .Column7.Check1.Top = 30
1579:             .Column7.Check1.Left = 9
1580:             .Column7.Check1.Width = 60
1581:             .Column7.Check1.Height = 17
1582:             .Column7.Check1.Caption = ""
1583:             .Column7.Check1.ToolTipText = "Centro de Custo"
1584:             .Column7.CurrentControl = "Check1"
1585: 
1586:             .Column8.ControlSource = par_cCursor + ".CheckA"
1587:             .Column8.Width = 17
1588:             .Column8.Sparse = .F.
1589:             .Column8.ToolTipText = "Agente Cobrador"
1590:             .Column8.Header1.Caption = "A"
1591:             .Column8.Header1.Alignment = 2
1592:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
1593:             .Column8.Header1.ToolTipText = "Agente Cobrador"
1594:             .Column8.AddObject("Check1", "CheckBox")
1595:             .Column8.Check1.Top = 33
1596:             .Column8.Check1.Left = 11
1597:             .Column8.Check1.Width = 60
1598:             .Column8.Check1.Height = 17
1599:             .Column8.Check1.Caption = ""
1600:             .Column8.Check1.ToolTipText = "Agente Cobrador"
1601:             .Column8.CurrentControl = "Check1"

*-- Linhas 2154 a 2172:
2154:     * ValidarTitBansFiltro/AbrirLookupTitBans - Titulo Banco. Legado busca em
2155:     * GradeOpOpe (cursor local carregado de SigOpFp no Init, Where Situas In
2156:     * ('P','R','A') And Infos='K') via fwBuscaSel; aqui a mesma fonte e
2157:     * filtro vao direto no FormBuscaAuxiliar (SQLEXEC sobre a tabela, regra
2158:     * #36 - 1o argumento eh SEMPRE o handle de conexao).
2159:     *--------------------------------------------------------------------------
2160:     PROCEDURE ValidarTitBansFiltro()
2161:         LOCAL loc_oPag, loc_cValor
2162:         IF THIS.this_lEmLookup
2163:             RETURN
2164:         ENDIF
2165:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2166:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_TitBans.Value)
2167:         IF EMPTY(loc_cValor)
2168:             RETURN
2169:         ENDIF
2170:         THIS.AbrirLookupTitBans(loc_cValor)
2171:     ENDPROC
2172: 

*-- Linhas 2178 a 2196:
2178:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2179:                 "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", par_cValor, ;
2180:                 "T" + CHR(237) + "tulo Banco", .F., .T., ;
2181:                 "Situas IN ('P','R','A') AND Infos = " + EscaparSQL("K"))
2182: 
2183:             IF VARTYPE(loc_oBusca) = "O"
2184:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2185:                     IF USED("cursor_4c_BuscaTitBan")
2186:                         THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2187:                     ENDIF
2188:                 ELSE
2189:                     IF !loc_oBusca.this_lAchouRegistro
2190:                         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2191:                         loc_oBusca.Show()
2192:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
2193:                             THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2194:                         ENDIF
2195:                     ENDIF
2196:                 ENDIF

*-- Linhas 3157 a 3253:
3157: 
3158:     *--------------------------------------------------------------------------
3159:     * ApagaClick/SelTudoClick - grdTipo: desmarca/marca todos os tipos de
3160:     * operacao (equivalente ao Update crSigOpOpe Set Imps=.. do legado).
3161:     *--------------------------------------------------------------------------
3162:     PROCEDURE ApagaClick()
3163:         LOCAL loc_cCursor
3164:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3165: 
3166:         IF USED(loc_cCursor)
3167:             SELECT (loc_cCursor)
3168:             REPLACE ALL Imps WITH 0
3169:             GO TOP
3170:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3171:         ENDIF
3172:     ENDPROC
3173: 
3174:     PROCEDURE SelTudoClick()
3175:         LOCAL loc_cCursor
3176:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3177: 
3178:         IF USED(loc_cCursor)
3179:             SELECT (loc_cCursor)
3180:             REPLACE ALL Imps WITH 1 FOR !EMPTY(Dopes)
3181:             GO TOP
3182:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3183:         ENDIF
3184:     ENDPROC
3185: 
3186:     *--------------------------------------------------------------------------
3187:     * InserirLinhaGrade/ExcluirLinhaGrade/LimparGrade - CRUD de linha
3188:     * compartilhado pelas duas grades de Grupo/Conta (equivalente aos
3189:     * btnInserir*/btnExcluir*/btnApagaG* do legado sobre TmpCliente/
3190:     * TmpCliente2).
3191:     *--------------------------------------------------------------------------
3192:     PROTECTED PROCEDURE InserirLinhaGrade(par_cCursor, par_oGrid)
3193:         IF !USED(par_cCursor)
3194:             RETURN
3195:         ENDIF
3196: 
3197:         SELECT (par_cCursor)
3198:         GO TOP
3199:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3200:         IF EOF()
3201:             APPEND BLANK
3202:             GO BOTTOM
3203:         ENDIF
3204: 
3205:         par_oGrid.Refresh()
3206:         par_oGrid.SetFocus()
3207:         par_oGrid.Column1.SetFocus()
3208:     ENDPROC
3209: 
3210:     PROTECTED PROCEDURE ExcluirLinhaGrade(par_cCursor, par_oGrid)
3211:         IF !USED(par_cCursor)
3212:             RETURN
3213:         ENDIF
3214: 
3215:         SELECT (par_cCursor)
3216:         IF !EMPTY(Grupo) OR !EMPTY(Conta)
3217:             DELETE
3218:         ENDIF
3219: 
3220:         GO TOP
3221:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3222:         IF EOF()
3223:             APPEND BLANK
3224:             GO BOTTOM
3225:         ENDIF
3226: 
3227:         par_oGrid.Refresh()
3228:         par_oGrid.SetFocus()
3229:         par_oGrid.Column1.SetFocus()
3230:     ENDPROC
3231: 
3232:     PROTECTED PROCEDURE LimparGrade(par_cCursor, par_oGrid)
3233:         IF !USED(par_cCursor)
3234:             RETURN
3235:         ENDIF
3236: 
3237:         ZAP IN (par_cCursor)
3238:         SELECT (par_cCursor)
3239:         APPEND BLANK
3240:         par_oGrid.Refresh()
3241:     ENDPROC
3242: 
3243:     PROCEDURE BtnInserirClick()
3244:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3245:     ENDPROC
3246: 
3247:     PROCEDURE BtnExcluirClick()
3248:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3249:     ENDPROC
3250: 
3251:     PROCEDURE BtnInserir2Click()
3252:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3253:     ENDPROC

*-- Linhas 3275 a 3293:
3275:     *--------------------------------------------------------------------------
3276:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3277:         IF USED(par_cCursor)
3278:             SELECT (par_cCursor)
3279:             IF !EOF()
3280:                 REPLACE (par_cCampo) WITH IIF(EVALUATE(par_cCampo) = 0, 1, 0)
3281:             ENDIF
3282:         ENDIF
3283:         par_oGrid.Refresh()
3284:     ENDPROC
3285: 
3286:     *-- grdTipo.Column1.Check1 (Imps)
3287:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3288:         IF INLIST(par_nKeyCode, 13, 32)
3289:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorTipos, "Imps", THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos)
3290:             NODEFAULT
3291:         ENDIF
3292:     ENDPROC
3293:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nX, par_nY)

*-- Linhas 3480 a 3512:
3480:             loc_cValores = THIS.SerializarFiltros()
3481:             loc_nExiste  = 0
3482: 
3483:             IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId), "cursor_4c_FiltroExiste") > 0
3484:                 loc_nExiste = cursor_4c_FiltroExiste.nExiste
3485:                 USE IN cursor_4c_FiltroExiste
3486:             ENDIF
3487: 
3488:             IF loc_nExiste > 0
3489:                 loc_cSQL = "UPDATE SigSyPar SET mxmls = " + EscaparSQL(loc_cValores) + ;
3490:                            " WHERE cidparams = " + EscaparSQL(loc_cId)
3491:             ELSE
3492:                 loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
3493:                            EscaparSQL(loc_cId) + ", " + EscaparSQL("F") + ", " + ;
3494:                            EscaparSQL(LEFT(loc_cNome, 40)) + ", " + EscaparSQL(loc_cValores) + ")"
3495:             ENDIF
3496: 
3497:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3498:                 loc_oPag.txt_4c_NewFiltro.Visible = .F.
3499:                 loc_oPag.txt_4c_Filtros.Visible   = .T.
3500:                 loc_oPag.txt_4c_Filtros.Value     = loc_cNome
3501:                 THIS.CarregarFiltrosSalvos()
3502:                 MsgInfo("Filtro grav" + CHR(225) + "do com sucesso!", "Confirmar")
3503:             ELSE
3504:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3505:             ENDIF
3506:         CATCH TO loc_oErro
3507:             MsgErro(loc_oErro.Message, "Erro")
3508:         ENDTRY
3509:     ENDPROC
3510: 
3511:     PROCEDURE CmdDelFiltroClick()
3512:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cSQL, loc_oErro

*-- Linhas 3528 a 3548:
3528: 
3529:         TRY
3530:             loc_cId  = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3531:             loc_cSQL = "DELETE FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId)
3532: 
3533:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3534:                 loc_oPag.txt_4c_Filtros.Value = ""
3535:                 THIS.CarregarFiltrosSalvos()
3536:             ELSE
3537:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3538:             ENDIF
3539:         CATCH TO loc_oErro
3540:             MsgErro(loc_oErro.Message, "Erro")
3541:         ENDTRY
3542:     ENDPROC
3543: 
3544:     *--------------------------------------------------------------------------
3545:     * GetFiltrosLostFocus - Ao sair do campo com um nome existente em
3546:     * cursor_4c_Filtros, restaura os valores salvos nos campos de filtro
3547:     * (equivalente ao mLerCfg() do Framework legado).
3548:     *--------------------------------------------------------------------------

*-- Linhas 3557 a 3575:
3557:             RETURN
3558:         ENDIF
3559: 
3560:         SELECT (loc_cCursor)
3561:         LOCATE FOR ALLTRIM(Descrs) == loc_cNome
3562: 
3563:         IF FOUND()
3564:             THIS.RestaurarFiltros(ALLTRIM(Mxmls))
3565:         ENDIF
3566:     ENDPROC
3567: 
3568:     *--------------------------------------------------------------------------
3569:     * SerializarFiltros/RestaurarFiltros - Serializacao plana (CHR(9) como
3570:     * separador) dos campos de filtro para gravar/recarregar um filtro
3571:     * nomeado em SigSyPar.Mxmls.
3572:     *--------------------------------------------------------------------------
3573:     PROTECTED PROCEDURE SerializarFiltros()
3574:         LOCAL loc_oBO
3575: 

*-- Linhas 3696 a 3741:
3696: 
3697:     *--------------------------------------------------------------------------
3698:     * CarregarTiposOperacao - Popula cursor_4c_Tipos a partir de SigOpOpe
3699:     * (equivalente ao Select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe
3700:     * Order By Dopes + Insert Into ...(0, Space(20), 'C') do legado).
3701:     *--------------------------------------------------------------------------
3702:     PROTECTED PROCEDURE CarregarTiposOperacao()
3703:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL
3704: 
3705:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3706:             RETURN
3707:         ENDIF
3708: 
3709:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorTipos
3710:         loc_cCursorTmp = loc_cCursor + "Tmp"
3711:         loc_cSQL       = "SELECT 1 AS Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes"
3712: 
3713:         *-- cursor_4c_Tipos esta ligado a grd_4c_Tipos.RecordSource - SQLEXEC
3714:         *-- direto nele zeraria o ColumnCount (regra do Grid/SQLEXEC). O
3715:         *-- SQLEXEC vai para um cursor TEMPORARIO e o placeholder (criado em
3716:         *-- CriarCursoresFiltros, com a MESMA estrutura/indice) e recarregado
3717:         *-- com ZAP + APPEND FROM DBF, preservando a estrutura do Grid.
3718:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3719:             SELECT (loc_cCursor)
3720:             ZAP
3721:             APPEND FROM DBF(loc_cCursorTmp)
3722:             IF USED(loc_cCursorTmp)
3723:                 USE IN (loc_cCursorTmp)
3724:             ENDIF
3725: 
3726:             SELECT (loc_cCursor)
3727:             APPEND BLANK
3728:             REPLACE Imps WITH 0, Dopes WITH SPACE(20), Opers WITH "C", RealPrevs WITH 0
3729:             GO TOP
3730: 
3731:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3732:         ENDIF
3733:     ENDPROC
3734: 
3735:     *--------------------------------------------------------------------------
3736:     * CarregarFiltrosSalvos - Popula cursor_4c_Filtros com os filtros
3737:     * nomeados ja gravados em SigSyPar para este form (cidparams iniciando
3738:     * por "SIGOPCGF").
3739:     *--------------------------------------------------------------------------
3740:     PROTECTED PROCEDURE CarregarFiltrosSalvos()
3741:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cId

*-- Linhas 3748 a 3776:
3748:         loc_cCursorTmp = loc_cCursor + "Tmp"
3749:         loc_cId        = PADR("SIGOPCGF", 8)
3750: 
3751:         loc_cSQL = "SELECT cidparams, ctpparams, descrs, mxmls FROM SigSyPar WHERE LEFT(cidparams, 8) = " + ;
3752:                    EscaparSQL(loc_cId) + " ORDER BY descrs"
3753: 
3754:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3755:             SELECT (loc_cCursor)
3756:             ZAP
3757:             APPEND FROM DBF(loc_cCursorTmp)
3758:             IF USED(loc_cCursorTmp)
3759:                 USE IN (loc_cCursorTmp)
3760:             ENDIF
3761:             SELECT (loc_cCursor)
3762:             GO TOP
3763:         ENDIF
3764:     ENDPROC
3765: 
3766:     *--------------------------------------------------------------------------
3767:     * BtnCarregarClick/CarregarFPubs - Carrega em grd_4c_Clientes os pares
3768:     * Grupo/Conta vinculados a Forma de Publicidade digitada (equivalente ao
3769:     * ThisForm.CarregarFPubs do legado). A checagem extra de acesso por
3770:     * usuario/conta (fAcessoContas/fChecarInativas no legado) depende de
3771:     * tabelas de controle de acesso do Framework (SigSyAgc/SigCdAcG/
3772:     * SigSyAcc) fora do escopo desta tela de filtro - o filtro principal
3773:     * (FPubls = codigo informado) e o mesmo usado pelo legado para
3774:     * restringir o universo de clientes.
3775:     *--------------------------------------------------------------------------
3776:     PROCEDURE BtnCarregarClick()

*-- Linhas 3799 a 3854:
3799:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorClientes
3800:         loc_cCursorTmp = loc_cCursor + "Tmp"
3801: 
3802:         loc_cSQL = "SELECT a.Grupos AS Grupo, b.Descrs AS NomeGrupo, a.IClis AS Conta, " + ;
3803:                    "a.RClis AS Nome, 0 AS CheckE, 0 AS CheckP, 0 AS CheckC, 0 AS CheckA " + ;
3804:                    "FROM SigCdCli a, SigCdGcr b " + ;
3805:                    "WHERE a.Grupos = b.Codigos AND a.FPubls = " + EscaparSQL(loc_cPub)
3806: 
3807:         *-- cursor_4c_Clientes esta ligado a grd_4c_Clientes.RecordSource -
3808:         *-- ZAP + APPEND FROM DBF preserva a estrutura/binding do Grid.
3809:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) > 0
3810:             SELECT (loc_cCursor)
3811:             ZAP
3812:             APPEND FROM DBF(loc_cCursorTmp)
3813:             IF USED(loc_cCursorTmp)
3814:                 USE IN (loc_cCursorTmp)
3815:             ENDIF
3816:             SELECT (loc_cCursor)
3817:             GO TOP
3818:             loc_oPag.grd_4c_Clientes.Refresh()
3819:         ELSE
3820:             MsgAviso("Nenhum cliente encontrado para a Forma de Publicidade [" + loc_cPub + "].", "Aten" + CHR(231) + CHR(227) + "o")
3821:         ENDIF
3822:     ENDPROC
3823: 
3824:     *--------------------------------------------------------------------------
3825:     * ConfigurarGradeDados - cria grd_4c_Dados (grade de resultado da
3826:     * consulta, equivalente a grdDados1/LocalDados do legado). SO estrutura
3827:     * estatica (posicao/tamanho/propriedades de grade) - ColumnCount/
3828:     * RecordSource/ControlSource ficam em MontarGradeDados(), chamado DEPOIS
3829:     * de Processamento() povoar cursor_4c_Dados (regra #41 do CLAUDE.md:
3830:     * ControlSource de cursor que ainda nao existe derruba o Init).
3831:     *--------------------------------------------------------------------------
3832:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3833:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3834:         WITH par_oPag.grd_4c_Dados
3835:             .Top               = 202
3836:             .Left              = 7
3837:             .Width             = 986
3838:             .Height            = 355
3839:             .DeleteMark        = .F.
3840:             .RecordMark        = .F.
3841:             .ReadOnly          = .T.
3842:             .AllowHeaderSizing = .F.
3843:             .AllowRowSizing    = .F.
3844:             .GridLineColor     = RGB(238, 238, 238)
3845:             .ScrollBars        = 2
3846:             .Visible           = .T.
3847:         ENDWITH
3848:         BINDEVENT(par_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
3849:     ENDPROC
3850: 
3851:     *--------------------------------------------------------------------------
3852:     * MontarGradeDados - Equivalente a ThisForm.MontaGradeD do legado. Religa
3853:     * as 12 colunas a cursor_4c_Dados. RecordSource reseta Column.Width e
3854:     * Header1.Caption (regra #48) - por isso TUDO e refeito aqui, sempre

*-- Linhas 3869 a 3933:
3869:             .ColumnCount  = 12
3870:             .RecordSource = loc_cCursor
3871: 
3872:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3873:             .Column1.Width           = 64
3874:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3875: 
3876:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3877:             .Column2.Width           = 64
3878:             .Column2.Header1.Caption = "Vencto."
3879: 
3880:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3881:             .Column3.Width           = 64
3882:             .Column3.Header1.Caption = "Lancto."
3883: 
3884:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3885:             .Column4.Width           = 64
3886:             .Column4.Header1.Caption = "Baixa"
3887: 
3888:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3889:             .Column5.Width           = 70
3890:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3891: 
3892:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3893:             .Column6.Width           = 240
3894:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3895: 
3896:             .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
3897:             .Column7.Width           = 20
3898:             .Column7.Header1.Caption = "$"
3899: 
3900:             .Column8.ControlSource   = loc_cCursor + ".Valors"
3901:             .Column8.Width           = 68
3902:             .Column8.Header1.Caption = "Valor"
3903: 
3904:             *-- Legado usa goSistema.TxtDebito/TxtCredito (rotulo customizavel
3905:             *-- por cliente) - essa customizacao NAO foi portada; caption fixo.
3906:             .Column9.ControlSource   = loc_cCursor + ".Debitos"
3907:             .Column9.Width           = 68
3908:             .Column9.Header1.Caption = "D" + CHR(233) + "bito"
3909: 
3910:             .Column10.ControlSource   = loc_cCursor + ".Creditos"
3911:             .Column10.Width           = 68
3912:             .Column10.Header1.Caption = "Cr" + CHR(233) + "dito"
3913: 
3914:             .Column11.ControlSource   = loc_cCursor + ".SaldoDia"
3915:             .Column11.Width           = 82
3916:             .Column11.Header1.Caption = "Saldo"
3917: 
3918:             .Column12.ControlSource   = loc_cCursor + ".SaldoTot"
3919:             .Column12.Width           = 82
3920:             .Column12.Header1.Caption = "Acumulado"
3921: 
3922:             .SetAll("DynamicBackColor", loc_cCor, "Column")
3923:             .FontName = "Arial"
3924:             .SetAll("Movable", .F., "Column")
3925:             .SetAll("Resizable", .F., "Column")
3926:             .SetAll("ReadOnly", .T., "Column")
3927:         ENDWITH
3928: 
3929:         GO TOP IN (loc_cCursor)
3930:         loc_oGrid.Refresh()
3931:     ENDPROC
3932: 
3933:     *--------------------------------------------------------------------------

*-- Linhas 4008 a 4038:
4008: 
4009:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorContas
4010:         IF !USED(loc_cCursor)
4011:             CREATE CURSOR (loc_cCursor) (IClis C(10), RClis C(50))
4012:             INDEX ON IClis TAG IClis
4013:         ENDIF
4014: 
4015:         SELECT (loc_cCursor)
4016:         IF SEEK(PADR(loc_cCodigo, 10), loc_cCursor, "IClis")
4017:             RETURN ALLTRIM(RClis)
4018:         ENDIF
4019: 
4020:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
4021:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp") > 0
4022:             IF !EOF("cursor_4c_RazaoTmp")
4023:                 INSERT INTO (loc_cCursor) (IClis, RClis) VALUES ;
4024:                     (PADR(ALLTRIM(cursor_4c_RazaoTmp.IClis), 10), cursor_4c_RazaoTmp.RClis)
4025:                 loc_cResultado = ALLTRIM(cursor_4c_RazaoTmp.RClis)
4026:             ENDIF
4027:             IF USED("cursor_4c_RazaoTmp")
4028:                 USE IN cursor_4c_RazaoTmp
4029:             ENDIF
4030:         ENDIF
4031: 
4032:         RETURN loc_cResultado
4033:     ENDFUNC
4034: 
4035:     *--------------------------------------------------------------------------
4036:     * CboOrdemInteractiveChange / ChkTotaisClick - equivalentes ao
4037:     * InteractiveChange de cmbOrdem e ao Valid de chkTotais: atualizam
4038:     * this_cOrdem/this_nOrdem e reordenam a grade (OrdenaGrade).

*-- Linhas 4089 a 4107:
4089: 
4090:         loc_cOrd = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "", "_") + loc_oBO.this_cOrdem
4091: 
4092:         SELECT (loc_cCursor)
4093:         SET ORDER TO TAG (loc_cOrd)
4094: 
4095:         IF INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
4096:             THIS.CalcSaldoCta()
4097:         ELSE
4098:             THIS.CalcSaldo()
4099:         ENDIF
4100: 
4101:         GO TOP IN (loc_cCursor)
4102:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
4103:     ENDPROC
4104: 
4105:     *--------------------------------------------------------------------------
4106:     * CalcSaldo - transcricao literal de ThisForm.CalcSaldo: recalcula
4107:     * Debitos/Creditos/SaldoDia/SaldoTot linha a linha e insere as linhas

*-- Linhas 4118 a 4155:
4118:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4119:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4120: 
4121:         SELECT (loc_cCursor)
4122:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4123: 
4124:         loc_nSdD = 0
4125:         loc_nSD1 = 0
4126:         loc_nSC1 = 0
4127:         loc_nSD2 = 0
4128:         loc_nSC2 = 0
4129:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4130:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4131:         loc_nOrd = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value
4132: 
4133:         IF USED(loc_cTotais)
4134:             USE IN (loc_cTotais)
4135:         ENDIF
4136:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4137: 
4138:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4139: 
4140:         SELECT (loc_cCursor)
4141:         GO TOP
4142:         loc_dDat = TTOD(DtEmis)
4143:         DO CASE
4144:         CASE loc_nOrd = 2
4145:             loc_dDat = TTOD(Vencs)
4146:         CASE loc_nOrd = 3
4147:             loc_dDat = TTOD(Datas)
4148:         CASE loc_nOrd = 4
4149:             loc_dDat = TTOD(DtBaixa)
4150:         ENDCASE
4151: 
4152:         loc_cMoe = ALLTRIM(Moedas)
4153: 
4154:         IF !EMPTY(loc_nSdT)
4155:             IF (loc_cMsd <> loc_cMoe)

*-- Linhas 4174 a 4196:
4174:             m.OrdHs    = "1"
4175:             m.Titulos  = ""
4176: 
4177:             INSERT INTO (loc_cTotais) FROM MEMVAR
4178:             REPLACE SInis WITH 1 IN (loc_cTotais)
4179:         ENDIF
4180: 
4181:         SELECT (loc_cCursor)
4182:         SCAN
4183:             loc_dRla = TTOD(DtEmis)
4184:             DO CASE
4185:             CASE loc_nOrd = 2
4186:                 loc_dRla = TTOD(Vencs)
4187:             CASE loc_nOrd = 3
4188:                 loc_dRla = TTOD(Datas)
4189:             CASE loc_nOrd = 4
4190:                 loc_dRla = TTOD(DtBaixa)
4191:             ENDCASE
4192: 
4193:             IF (loc_cMoe <> ALLTRIM(Moedas))
4194:                 SCATTER MEMVAR
4195:                 m.Nopers   = 9999999
4196:                 m.Valors   = 0

*-- Linhas 4206 a 4224:
4206:                 m.Moedas   = loc_cMoe
4207:                 m.OrdHs    = CHR(254)
4208:                 m.Titulos  = REPLICATE(CHR(254), 10)
4209:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4210:                 loc_nSD1 = 0
4211:                 loc_nSC1 = 0
4212: 
4213:                 IF INLIST(loc_cOrdem, "Titulos", "Hists")
4214:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
4215:                     loc_nSdD = 0
4216:                 ENDIF
4217:             ENDIF
4218: 
4219:             IF !INLIST(loc_cOrdem, "Titulos", "Hists")
4220:                 IF ((loc_dDat <> loc_dRla) OR (loc_cMoe <> ALLTRIM(Moedas))) AND INLIST(loc_nOrd, 1, 2, 3, 4)
4221:                     SCATTER MEMVAR
4222:                     m.Nopers   = 9999998
4223:                     m.Valors   = 0
4224:                     m.DtEmis   = loc_dDat

*-- Linhas 4231 a 4249:
4231:                     m.SaldoDia = loc_nSdD
4232:                     m.SaldoTot = loc_nSdT
4233:                     m.Moedas   = loc_cMoe
4234:                     INSERT INTO (loc_cTotais) FROM MEMVAR
4235: 
4236:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
4237:                     loc_nSdD = 0
4238:                     loc_nSD2 = 0
4239:                     loc_nSC2 = 0
4240:                 ENDIF
4241:             ENDIF
4242: 
4243:             loc_dDat = loc_dRla
4244:             loc_cMoe = ALLTRIM(Moedas)
4245:             loc_nVal = ABS(Valors)
4246: 
4247:             loc_nSdD = loc_nSdD + (loc_nVal * IIF(Opers = "D", 1, -1))
4248:             loc_nSdT = loc_nSdT + (loc_nVal * IIF(Opers = "D", 1, -1))
4249: 

*-- Linhas 4258 a 4357:
4258:                     SaldoTot WITH loc_nSdT
4259:         ENDSCAN
4260: 
4261:         SELECT (loc_cCursor)
4262:         SKIP -1
4263:         IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
4264:             IF !INLIST(loc_cOrdem, "Titulos", "Hists")
4265:                 SCATTER MEMVAR
4266:                 m.Nopers   = 9999998
4267:                 m.Valors   = 0
4268:                 m.DtEmis   = loc_dDat
4269:                 m.Vencs    = loc_dDat
4270:                 m.Datas    = loc_dDat
4271:                 m.DtBaixa  = loc_dDat
4272:                 m.Hists    = "Saldo do dia " + DTOC(loc_dDat) + ":"
4273:                 m.Debitos  = loc_nSD2
4274:                 m.Creditos = loc_nSC2
4275:                 m.SaldoDia = loc_nSdD
4276:                 m.SaldoTot = loc_nSdT
4277:                 m.Moedas   = loc_cMoe
4278:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4279:             ENDIF
4280: 
4281:             SCATTER MEMVAR
4282:             m.Nopers   = 9999999
4283:             m.Valors   = 0
4284:             m.DtEmis   = loc_dDat
4285:             m.Vencs    = loc_dDat
4286:             m.Datas    = loc_dDat
4287:             m.DtBaixa  = loc_dDat
4288:             m.Hists    = "Saldo da Moeda " + loc_cMoe + ":"
4289:             m.Debitos  = loc_nSD1
4290:             m.Creditos = loc_nSC1
4291:             m.SaldoDia = loc_nSdD
4292:             m.SaldoTot = loc_nSdT
4293:             m.Moedas   = loc_cMoe
4294:             m.OrdHs    = CHR(254)
4295:             m.Titulos  = REPLICATE(CHR(254), 10)
4296:             INSERT INTO (loc_cTotais) FROM MEMVAR
4297:         ENDIF
4298: 
4299:         SELECT (loc_cTotais)
4300:         SCAN
4301:             SCATTER MEMVAR
4302:             INSERT INTO (loc_cCursor) FROM MEMVAR
4303:         ENDSCAN
4304: 
4305:         GO TOP IN (loc_cCursor)
4306:     ENDPROC
4307: 
4308:     *--------------------------------------------------------------------------
4309:     * CalcSaldoCta - transcricao literal de ThisForm.CalcSaldoCta: mesma
4310:     * logica de CalcSaldo, mas agrupando por Emitente (ContEms) ou Portador
4311:     * (Contas) em vez de por data, com a razao social (ObterRazaoSocial)
4312:     * compondo a linha sintetica de saldo.
4313:     *--------------------------------------------------------------------------
4314:     PROTECTED PROCEDURE CalcSaldoCta()
4315:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4316:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4317:         LOCAL loc_cMsd, loc_dDat, loc_cMoe, loc_cEmi, loc_cPor, loc_nVal
4318: 
4319:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4320:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4321:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4322:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4323: 
4324:         SELECT (loc_cCursor)
4325:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4326: 
4327:         loc_nSdD = 0
4328:         loc_nSD1 = 0
4329:         loc_nSC1 = 0
4330:         loc_nSD2 = 0
4331:         loc_nSC2 = 0
4332:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4333:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4334: 
4335:         IF USED(loc_cTotais)
4336:             USE IN (loc_cTotais)
4337:         ENDIF
4338:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4339: 
4340:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4341: 
4342:         SELECT (loc_cCursor)
4343:         GO TOP
4344:         loc_dDat = TTOD(DtEmis)
4345:         loc_cMoe = ALLTRIM(Moedas)
4346:         loc_cEmi = ALLTRIM(ContEms)
4347:         loc_cPor = ALLTRIM(Contas)
4348: 
4349:         SCAN
4350:             IF (loc_cMoe <> ALLTRIM(Moedas)) OR ;
4351:                (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4352:                (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor)
4353: 
4354:                 SCATTER MEMVAR
4355:                 m.Nopers   = 9999999
4356:                 m.Valors   = 0
4357:                 m.DtEmis   = loc_dDat

*-- Linhas 4382 a 4400:
4382:                 m.Contas   = loc_cPor
4383:                 m.OrdHs    = CHR(254)
4384:                 m.Titulos  = REPLICATE(CHR(254), 10)
4385:                 INSERT INTO (loc_cTotais) FROM MEMVAR
4386:                 loc_nSD1 = 0
4387:                 loc_nSC1 = 0
4388: 
4389:                 IF INLIST(loc_cOrdem, "Titulos", "Hists", "ContEms", "Contas")
4390:                     loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas) OR ;
4391:                                    (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4392:                                    (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor), 0, loc_nSdT)
4393:                     loc_nSdD = 0
4394:                 ENDIF
4395:             ENDIF
4396: 
4397:             loc_cMoe = ALLTRIM(Moedas)
4398:             loc_cEmi = ALLTRIM(ContEms)
4399:             loc_cPor = ALLTRIM(Contas)
4400:             loc_nVal = ABS(Valors)

*-- Linhas 4413 a 4431:
4413:                     SaldoTot WITH loc_nSdT
4414:         ENDSCAN
4415: 
4416:         SELECT (loc_cCursor)
4417:         SKIP -1
4418:         IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
4419:             SCATTER MEMVAR
4420:             m.Nopers   = 9999999
4421:             m.Valors   = 0
4422:             m.DtEmis   = loc_dDat
4423:             m.Vencs    = loc_dDat
4424:             m.Datas    = loc_dDat
4425:             m.DtBaixa  = loc_dDat
4426:             m.Hists    = ""
4427:             IF (loc_cOrdem = "ContEms")
4428:                 m.Hists = "Saldo " + ALLTRIM(loc_cMoe)
4429:                 IF !EMPTY(loc_cEmi)
4430:                     m.Hists = m.Hists + " / " + loc_cEmi + " " + ALLTRIM(THIS.ObterRazaoSocial(loc_cEmi))
4431:                 ENDIF

*-- Linhas 4445 a 4469:
4445:             m.Moedas   = loc_cMoe
4446:             m.OrdHs    = CHR(254)
4447:             m.Titulos  = REPLICATE(CHR(254), 10)
4448:             INSERT INTO (loc_cTotais) FROM MEMVAR
4449:         ENDIF
4450: 
4451:         SELECT (loc_cTotais)
4452:         SCAN
4453:             SCATTER MEMVAR
4454:             INSERT INTO (loc_cCursor) FROM MEMVAR
4455:         ENDSCAN
4456: 
4457:         GO TOP IN (loc_cCursor)
4458:     ENDPROC
4459: 
4460:     *--------------------------------------------------------------------------
4461:     * AplicarFiltroGrupoContaManter / AplicarFiltroGrupoContaExcluirTodas -
4462:     * helpers do filtro de Grupo/Conta informado nas duas grades de
4463:     * selecao (cursor_4c_Clientes/cursor_4c_Clientes2), transcritos do Do
4464:     * Case do Processamento legado. A versao "ExcluirTodas" preserva, de
4465:     * proposito, a assimetria do dump original (quando os DOIS campos estao
4466:     * preenchidos, o grupo usa "<>" e a conta usa "=" em vez de "<>") -
4467:     * regra #17 do CLAUDE.md: transcrever, nunca reescrever.
4468:     *--------------------------------------------------------------------------
4469:     PROTECTED PROCEDURE AplicarFiltroGrupoContaManter(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)

*-- Linhas 4484 a 4523:
4484:             RETURN
4485:         ENDCASE
4486: 
4487:         UPDATE (par_cCursorDados) SET ManterDados = 1 WHERE &loc_cWhere.
4488:     ENDPROC
4489: 
4490:     PROTECTED PROCEDURE AplicarFiltroGrupoContaExcluirTodas(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4491:         LOCAL loc_cWhere
4492: 
4493:         IF EMPTY(par_cColGrupo)
4494:             RETURN
4495:         ENDIF
4496: 
4497:         DO CASE
4498:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4499:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "' OR " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4500:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4501:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "'"
4502:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4503:             loc_cWhere = par_cColConta + " <> '" + ALLTRIM(par_cConta) + "'"
4504:         OTHERWISE
4505:             RETURN
4506:         ENDCASE
4507: 
4508:         UPDATE (par_cCursorDados) SET ManterDados = 0 WHERE &loc_cWhere.
4509:     ENDPROC
4510: 
4511:     *--------------------------------------------------------------------------
4512:     * DataFimDiaSQL - monta o literal SQL Server do limite SUPERIOR de uma
4513:     * faixa de data (23:59:59), equivalente a fDtoSql(valor, [23:59:59]) do
4514:     * legado. Data vazia usa o sentinela 31/12/2099 (igual ao legado).
4515:     *--------------------------------------------------------------------------
4516:     PROTECTED FUNCTION DataFimDiaSQL(par_dData)
4517:         LOCAL loc_dData
4518:         loc_dData = par_dData
4519:         IF EMPTY(loc_dData)
4520:             loc_dData = {^2099-12-31}
4521:         ENDIF
4522:         RETURN "'" + PADL(YEAR(loc_dData), 4, "0") + "-" + PADL(MONTH(loc_dData), 2, "0") + "-" + ;
4523:                PADL(DAY(loc_dData), 2, "0") + " 23:59:59'"

*-- Linhas 4558 a 4622:
4558:         IF !EMPTY(loc_oPag1.txt_4c_Empresa.Value)
4559:             loc_cCodEmp = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
4560:             loc_cRes = loc_cRes + " / Empresa: " + loc_cCodEmp
4561:             loc_cEmp = " AND (CASE WHEN a.EmpCcs <> '' AND a.EmpCcs = " + EscaparSQL(loc_cCodEmp) + " THEN 1 " + ;
4562:                        "ELSE CASE WHEN a.EmpCcs = '' AND a.Emps = " + EscaparSQL(loc_cCodEmp) + " THEN 1 ELSE 0 END END) = 1"
4563:         ENDIF
4564: 
4565:         *-- Emissao
4566:         loc_cDem = ""
4567:         IF !EMPTY(loc_oPag1.txt_4c_DtEmiI.Value)
4568:             loc_dDeI = loc_oPag1.txt_4c_DtEmiI.Value
4569:             loc_dDeF = loc_oPag1.txt_4c_DtEmiF.Value
4570:             loc_cDem = " AND (a.DtEmis BETWEEN " + FormatarDataSQL(loc_dDeI) + " AND " + THIS.DataFimDiaSQL(loc_dDeF) + ;
4571:                        IIF(loc_oPag1.chk_4c_Brancos.Value = 0, "", " OR a.DtEmis IS NULL") + ")"
4572:             loc_cRes = loc_cRes + " / Emiss" + CHR(227) + "o: " + DTOC(loc_dDeI) + " a " + ;
4573:                        DTOC(IIF(EMPTY(loc_dDeF), {^2099-12-31}, loc_dDeF))
4574:         ENDIF
4575: 
4576:         *-- Vencimento
4577:         loc_cDvc = ""
4578:         IF !EMPTY(loc_oPag1.txt_4c_VencsI.Value)
4579:             loc_dDvI = loc_oPag1.txt_4c_VencsI.Value
4580:             loc_dDvF = loc_oPag1.txt_4c_VencsF.Value
4581:             loc_cDvc = " AND a.Vencs BETWEEN " + FormatarDataSQL(loc_dDvI) + " AND " + THIS.DataFimDiaSQL(loc_dDvF)
4582:             loc_cRes = loc_cRes + " / Vencimento: " + DTOC(loc_dDvI) + " a " + ;
4583:                        DTOC(IIF(EMPTY(loc_dDvF), {^2099-12-31}, loc_dDvF))
4584:         ENDIF
4585: 
4586:         *-- Lancamento
4587:         loc_cDla = ""
4588:         IF !EMPTY(loc_oPag1.txt_4c_DatasI.Value)
4589:             loc_dDlI = loc_oPag1.txt_4c_DatasI.Value
4590:             loc_dDlF = loc_oPag1.txt_4c_DatasF.Value
4591:             loc_cDla = " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDlI) + " AND " + THIS.DataFimDiaSQL(loc_dDlF)
4592:             loc_cRes = loc_cRes + " / Lan" + CHR(231) + "amento: " + DTOC(loc_dDlI) + " a " + ;
4593:                        DTOC(IIF(EMPTY(loc_dDlF), {^2099-12-31}, loc_dDlF))
4594:         ENDIF
4595: 
4596:         *-- Acerto (data de baixa) - o legado comenta o fragmento no WHERE
4597:         *-- (lcDbx fica so na descricao); o filtro real roda DEPOIS do
4598:         *-- preenchimento da Data de Baixa, mais abaixo neste metodo.
4599:         IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
4600:             loc_cRes = loc_cRes + " / Acerto: " + DTOC(loc_oPag1.txt_4c_DtBxI.Value) + " a " + ;
4601:                        DTOC(IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value))
4602:         ENDIF
4603: 
4604:         *-- Moeda filtro
4605:         loc_cMoe = ""
4606:         IF !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
4607:             loc_cMoe = " AND a.Moedas = " + EscaparSQL(ALLTRIM(loc_oPag1.txt_4c_CMoes.Value))
4608:             loc_cRes = loc_cRes + " / Moeda Filtro: " + ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
4609:         ENDIF
4610: 
4611:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4612:             loc_cRes = loc_cRes + " / Moeda Convers" + CHR(227) + "o: " + ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value) + " (" + ;
4613:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 1, "Emiss" + CHR(227) + "o", ;
4614:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 2, "Vencimento", ;
4615:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 3, "Lan" + CHR(231) + "amento", ;
4616:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 4, "Data Atual", "Data Acerto")))) + ")"
4617:         ENDIF
4618: 
4619:         *-- Pagamento
4620:         loc_cPag = ""
4621:         IF loc_oPag1.opt_4c_Pagos.Value <> 1
4622:             loc_cPag = " AND a.Pagos = " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "'0'", "'1'")

*-- Linhas 4652 a 4822:
4652:         *-- Titulo / Nota Fiscal / Titulo Banco / Especie
4653:         loc_cTit = ""
4654:         IF !EMPTY(loc_oPag1.txt_4c_Titulos.Value)
4655:             loc_cTit = " AND a.Titulos = " + EscaparSQL(loc_oPag1.txt_4c_Titulos.Value)
4656:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo: " + ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
4657:         ENDIF
4658: 
4659:         loc_cNfs = ""
4660:         IF !EMPTY(loc_oPag1.txt_4c_NFs.Value)
4661:             loc_cNfs = " AND a.NFs = " + EscaparSQL(loc_oPag1.txt_4c_NFs.Value)
4662:             loc_cRes = loc_cRes + " / Nota Fiscal: " + ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
4663:         ENDIF
4664: 
4665:         loc_cTba = ""
4666:         IF !EMPTY(loc_oPag1.txt_4c_TitBans.Value)
4667:             loc_cTba = " AND a.TitBans = " + EscaparSQL(loc_oPag1.txt_4c_TitBans.Value)
4668:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo Banco: " + ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
4669:         ENDIF
4670: 
4671:         loc_cEsp = ""
4672:         IF !EMPTY(loc_oPag1.txt_4c_EspecieNfs.Value)
4673:             loc_cEsp = " AND a.EspecieNfs = " + EscaparSQL(loc_oPag1.txt_4c_EspecieNfs.Value)
4674:             loc_cRes = loc_cRes + " / Esp" + CHR(233) + "cie: " + ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
4675:         ENDIF
4676: 
4677:         IF !EMPTY(loc_oPag1.txt_4c_Saldo.Value)
4678:             loc_cRes = loc_cRes + " / Saldo Inicial: " + ALLTRIM(TRANSFORM(loc_oPag1.txt_4c_Saldo.Value, "999999999999.99")) + ;
4679:                        " " + ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4680:         ENDIF
4681: 
4682:         *-- Filtro de Movimentacao de Titulos (grd_4c_Tipos - cursor_4c_Tipos.Imps=1)
4683:         loc_cOpT = ""
4684:         SELECT (loc_oBO.this_cCursorTipos)
4685:         GO TOP
4686:         COUNT FOR Imps = 1 TO loc_nOpe
4687: 
4688:         DO CASE
4689:         CASE loc_nOpe = 1
4690:             GO TOP
4691:             LOCATE FOR Imps = 1
4692:             loc_cOpT = " AND a.Dopcs = " + EscaparSQL(ALLTRIM(Dopes))
4693:             loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: " + ALLTRIM(Dopes)
4694:         CASE loc_nOpe > 1
4695:             loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: "
4696:             loc_lPrimeira = .T.
4697:             loc_cOpT = " AND a.Dopcs IN ("
4698:             SCAN
4699:                 IF Imps = 1
4700:                     loc_cOpT = loc_cOpT + IIF(loc_lPrimeira, "", ",") + EscaparSQL(ALLTRIM(Dopes))
4701:                     loc_cRes = loc_cRes + IIF(loc_lPrimeira, "", ", ") + ALLTRIM(Dopes)
4702:                     loc_lPrimeira = .F.
4703:                 ENDIF
4704:             ENDSCAN
4705:             loc_cOpT = loc_cOpT + ")"
4706:         OTHERWISE
4707:             *-- Nao faz nada: carrega todos os lancamentos
4708:         ENDCASE
4709: 
4710:         *-- Consulta principal (SigMvCcr + SigCdPit + SigOpMvv)
4711:         loc_cCursorTmp = loc_cCursor + "Tmp"
4712:         loc_cSQL = "SELECT a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
4713:                    "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
4714:                    "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Moedas AS MoeOrigs, a.Cotacaos, a.ValOcurs, " + ;
4715:                    "a.Saldos, a.ValPags, a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, " + ;
4716:                    "a.Emps, a.Dopcs, a.EmpDopNums, a.EmpDopNcs, 1 AS ManterDados, a.DtEmis AS DtBaixa, " + ;
4717:                    "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoDia, CAST(9999999999.99 AS NUMERIC(15,2)) AS Debitos, " + ;
4718:                    "'8' AS OrdHs, a.Numes, a.Numcs, a.VOpers, " + ;
4719:                    "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoTot, CAST(9999999999.99 AS NUMERIC(15,2)) AS Creditos, " + ;
4720:                    "MAX(d.Vencs) AS Prorrogs, 0 AS SInis " + ;
4721:                    "FROM SigMvCcr a " + ;
4722:                    "LEFT JOIN SigCdPit b ON a.Nopers = b.Nopers " + ;
4723:                    "LEFT JOIN SigOpMvv d ON a.EmpDopNcs = d.EmpDopNcs " + ;
4724:                    "WHERE 1 = 1 " + loc_cEmp + loc_cDem + loc_cDvc + loc_cDla + loc_cMoe + loc_cPag + loc_cOpc + ;
4725:                    loc_cTit + loc_cNfs + loc_cTba + loc_cEsp + loc_cCan + loc_cCcl + loc_cOpT + " " + ;
4726:                    "GROUP BY a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
4727:                    "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
4728:                    "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Cotacaos, a.ValOcurs, a.Saldos, a.ValPags, " + ;
4729:                    "a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, a.Emps, a.Dopcs, " + ;
4730:                    "a.EmpDopNums, a.EmpDopNcs, a.Numes, a.Numcs, a.VOpers"
4731: 
4732:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) < 1
4733:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
4734:             RETURN .F.
4735:         ENDIF
4736: 
4737:         IF USED(loc_cCursor)
4738:             USE IN (loc_cCursor)
4739:         ENDIF
4740:         SELECT * FROM (loc_cCursorTmp) INTO CURSOR (loc_cCursor) READWRITE
4741:         IF USED(loc_cCursorTmp)
4742:             USE IN (loc_cCursorTmp)
4743:         ENDIF
4744: 
4745:         SELECT (loc_cCursor)
4746:         REPLACE ALL Saldos   WITH 0, ;
4747:                     DtBaixa  WITH CTOT(""), ;
4748:                     DtEmis   WITH TratarNulo(DtEmis, CTOT("")), ;
4749:                     Vencs    WITH TratarNulo(Vencs, CTOT("")), ;
4750:                     Datas    WITH TratarNulo(Datas, CTOT("")), ;
4751:                     Prorrogs WITH TratarNulo(Prorrogs, CTOT(""))
4752: 
4753:         SELECT (loc_cCursor)
4754:         GO TOP
4755:         IF EOF()
4756:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4757:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4758:             RETURN .F.
4759:         ENDIF
4760: 
4761:         IF loc_oPag1.chk_4c_ValPends.Value = 1
4762:             REPLACE ALL Valors WITH Valors - ValPags
4763:         ENDIF
4764: 
4765:         *-- Filtrando Grupos/Contas informados na grade 1 (cursor_4c_Clientes)
4766:         SELECT (loc_oBO.this_cCursorClientes)
4767:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4768:         IF FOUND()
4769:             UPDATE (loc_cCursor) SET ManterDados = 0
4770: 
4771:             SELECT (loc_oBO.this_cCursorClientes)
4772:             SCAN
4773:                 IF CheckE = 1
4774:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4775:                 ENDIF
4776:                 IF CheckP = 1
4777:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4778:                 ENDIF
4779:                 IF CheckC = 1
4780:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4781:                 ENDIF
4782:                 IF CheckA = 1
4783:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4784:                 ENDIF
4785:             ENDSCAN
4786: 
4787:             loc_cRes = loc_cRes + " / Grupos-Contas: "
4788:             SELECT (loc_oBO.this_cCursorClientes)
4789:             SCAN
4790:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4791:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4792:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4793:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4794:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4795:             ENDSCAN
4796: 
4797:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4798:         ENDIF
4799: 
4800:         *-- Filtrando Grupos/Contas informados na grade 2 (Todas/Alguma)
4801:         loc_nFl2 = loc_oPag1.opt_4c_FilGrd2.Value
4802:         SELECT (loc_oBO.this_cCursorClientes2)
4803:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4804:         IF FOUND()
4805:             UPDATE (loc_cCursor) SET ManterDados = IIF(loc_nFl2 = 1, 1, 0)
4806: 
4807:             SELECT (loc_oBO.this_cCursorClientes2)
4808:             SCAN
4809:                 IF loc_nFl2 = 1
4810:                     IF CheckE = 1
4811:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4812:                     ENDIF
4813:                     IF CheckP = 1
4814:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4815:                     ENDIF
4816:                     IF CheckC = 1
4817:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4818:                     ENDIF
4819:                     IF CheckA = 1
4820:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4821:                     ENDIF
4822:                 ELSE

*-- Linhas 4836 a 4920:
4836:             ENDSCAN
4837: 
4838:             loc_cRes = loc_cRes + " / Grupos-Contas (" + IIF(loc_nFl2 = 1, "Todas", "Alguma") + "): "
4839:             SELECT (loc_oBO.this_cCursorClientes2)
4840:             SCAN
4841:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4842:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4843:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4844:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4845:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4846:             ENDSCAN
4847: 
4848:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4849:         ENDIF
4850: 
4851:         *-- Filtrando os Titulos Prorrogados
4852:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4853:             IF loc_oPag1.opt_4c_Prorrogs.Value = 2
4854:                 DELETE FROM (loc_cCursor) WHERE EMPTY(Prorrogs)
4855:             ELSE
4856:                 DELETE FROM (loc_cCursor) WHERE !EMPTY(Prorrogs)
4857:             ENDIF
4858:         ENDIF
4859: 
4860:         *-- Preenchendo a Data da Baixa (titulos em aberto, Pagos = "0")
4861:         SELECT (loc_cCursor)
4862:         SCAN FOR Pagos = "0"
4863:             loc_nNop = Nopers
4864:             loc_cSQL = "SELECT b.DatarCs FROM SigCdPit a, SigCdPgr b " + ;
4865:                        "WHERE a.Nopers = " + FormatarNumeroSQL(loc_nNop, 0) + " AND a.EmpDopNums = b.EmpDopNums " + ;
4866:                        "ORDER BY b.DatarCs DESC"
4867:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4868:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
4869:                 RETURN .F.
4870:             ENDIF
4871:             IF !EOF("cursor_4c_ConsPgtDtBx")
4872:                 REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DatarCs IN (loc_cCursor)
4873:             ELSE
4874:                 IF USED("cursor_4c_ConsPgtDtBx")
4875:                     USE IN cursor_4c_ConsPgtDtBx
4876:                 ENDIF
4877:                 loc_cSQL = "SELECT Datas AS DataRcs FROM SigTtCcr WHERE NOpers = " + FormatarNumeroSQL(loc_nNop, 0) + " " + ;
4878:                            "ORDER BY Datas DESC"
4879:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4880:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
4881:                     RETURN .F.
4882:                 ENDIF
4883:                 IF !EOF("cursor_4c_ConsPgtDtBx")
4884:                     REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DataRcs IN (loc_cCursor)
4885:                 ENDIF
4886:             ENDIF
4887:             IF USED("cursor_4c_ConsPgtDtBx")
4888:                 USE IN cursor_4c_ConsPgtDtBx
4889:             ENDIF
4890:             SELECT (loc_cCursor)
4891:         ENDSCAN
4892: 
4893:         *-- Filtro de Acerto (Data de Baixa), aplicado SO depois do
4894:         *-- preenchimento acima - igual ao legado.
4895:         IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
4896:             loc_dPbI = loc_oPag1.txt_4c_DtBxI.Value
4897:             loc_dPbF = IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value)
4898:             DELETE FROM (loc_cCursor) WHERE !BETWEEN(TTOD(DtBaixa), loc_dPbI, loc_dPbF)
4899:         ENDIF
4900: 
4901:         *-- Convertendo valores para a moeda de conversao
4902:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4903:             loc_cMdO = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)
4904: 
4905:             SELECT (loc_cCursor)
4906:             SCAN
4907:                 IF ALLTRIM(Moedas) <> loc_cMdO
4908:                     loc_dTDat = TTOD(DtEmis)
4909:                     DO CASE
4910:                     CASE loc_oPag1.opt_4c_CotEm.Value = 2
4911:                         loc_dTDat = TTOD(Vencs)
4912:                     CASE loc_oPag1.opt_4c_CotEm.Value = 3
4913:                         loc_dTDat = TTOD(Datas)
4914:                     CASE loc_oPag1.opt_4c_CotEm.Value = 4
4915:                         loc_dTDat = DATE()
4916:                     CASE loc_oPag1.opt_4c_CotEm.Value = 5
4917:                         IF !EMPTY(DtBaixa)
4918:                             loc_dTDat = TTOD(DtBaixa)
4919:                         ENDIF
4920:                     ENDCASE

*-- Linhas 4938 a 4964:
4938:             ENDSCAN
4939:         ENDIF
4940: 
4941:         SELECT (loc_cCursor)
4942:         GO TOP
4943:         IF EOF()
4944:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4945:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4946:             RETURN .F.
4947:         ENDIF
4948: 
4949:         SELECT (loc_cCursor)
4950:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR (Nopers < 9999997) AND (SInis <> 1)
4951:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR (Nopers < 9999997) AND (SInis <> 1)
4952:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR (Nopers < 9999997) AND (SInis <> 1)
4953:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR (Nopers < 9999997) AND (SInis <> 1)
4954:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR (Nopers < 9999997) AND (SInis <> 1)
4955:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR (Nopers < 9999997) AND (SInis <> 1)
4956:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR (Nopers < 9999997) AND (SInis <> 1)
4957:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR (Nopers < 9999997) AND (SInis <> 1)
4958: 
4959:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG DtEmis
4960:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG Vencs
4961:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG Datas
4962:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG DtBaixa
4963:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG Titulos
4964:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG Hists

*-- Linhas 4975 a 5149:
4975:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value = loc_cRes
4976:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Refresh()
4977: 
4978:         SELECT (loc_cCursor)
4979:         GO TOP
4980: 
4981:         RETURN .T.
4982:     ENDPROC
4983: 
4984:     *--------------------------------------------------------------------------
4985:     * BtnMovimentoClick - equivalente ao Click de btnMovimento: identifica em
4986:     * qual tabela a movimentacao do titulo esta registrada (ChkRegister nao
4987:     * existe em BusinessBase - regra do CLAUDE.md - substituido por
4988:     * SELECT COUNT(*)) e abre a tela legada correspondente via DO FORM.
4989:     *--------------------------------------------------------------------------
4990:     PROCEDURE BtnMovimentoClick()
4991:         LOCAL loc_oBO, loc_cEmpDopNums, loc_nQtd, loc_cSQL
4992: 
4993:         loc_oBO = THIS.this_oBusinessObject
4994: 
4995:         IF loc_oBO.this_cLinTipos = "P" OR EMPTY(loc_oBO.this_nLinNopers)
4996:             RETURN
4997:         ENDIF
4998: 
4999:         loc_cEmpDopNums = PADR(loc_oBO.this_cLinEmps, 3) + PADR(loc_oBO.this_cLinDopes, 20) + STR(loc_oBO.this_nLinNumes, 6)
5000: 
5001:         *-- SigCdPgr (titulo em carteira de pagamento)
5002:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdPgr WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5003:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5004:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5005:         loc_nQtd = 0
5006:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPgr") > 0
5007:             loc_nQtd = cursor_4c_ChkPgr.Nreg
5008:             USE IN cursor_4c_ChkPgr
5009:         ENDIF
5010:         IF loc_nQtd > 0
5011:             DO FORM SigCdPgr WITH LEFT(loc_oBO.this_cLinDopes, 1), .T., loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5012:             RETURN
5013:         ENDIF
5014: 
5015:         *-- SigMvCab (movimento de estoque)
5016:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)
5017:         loc_nQtd = 0
5018:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab") > 0
5019:             loc_nQtd = cursor_4c_ChkMvCab.Nreg
5020:             USE IN cursor_4c_ChkMvCab
5021:         ENDIF
5022:         IF loc_nQtd > 0
5023:             IF WEXIST("FORM_")
5024:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Consultar o Movimento" + CHR(13) + ;
5025:                           "Existe Outra Movimenta" + CHR(231) + CHR(227) + "o Aberta!!!", "Movimento de Estoque Em Uso")
5026:             ELSE
5027:                 DO FORM SigMvExp WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5028:             ENDIF
5029:             RETURN
5030:         ENDIF
5031: 
5032:         *-- SigOpOpe (titulo vinculado a movimentacao de titulo bancario)
5033:         IF !EMPTY(loc_oBO.this_cLinEmps) AND !EMPTY(loc_oBO.this_cLinDopes) AND !EMPTY(loc_oBO.this_nLinNumes)
5034:             loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes)
5035:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpOpe") < 1
5036:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (cursor_4c_ChkOpOpe)")
5037:                 RETURN
5038:             ENDIF
5039:             IF !EOF("cursor_4c_ChkOpOpe")
5040:                 IF fChecaAcesso("C" + PADL(ALLTRIM(TRANSFORM(cursor_4c_ChkOpOpe.NDopes)), 8, "0"), "CONSULTAR")
5041:                     DO FORM SigPgTit WITH loc_oBO.this_cLinDopes, "CONSULTAR", loc_oBO.this_cLinEmps, ;
5042:                              STR(loc_oBO.this_nLinNumes, 6), (cursor_4c_ChkOpOpe.RealPrevs = 2)
5043:                 ELSE
5044:                     MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso a Consultar T" + CHR(237) + "tulos!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5045:                 ENDIF
5046:                 IF USED("cursor_4c_ChkOpOpe")
5047:                     USE IN cursor_4c_ChkOpOpe
5048:                 ENDIF
5049:                 RETURN
5050:             ENDIF
5051:             IF USED("cursor_4c_ChkOpOpe")
5052:                 USE IN cursor_4c_ChkOpOpe
5053:             ENDIF
5054:         ENDIF
5055: 
5056:         *-- SigCqChm (cheque)
5057:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCqChm WHERE Emps = " + EscaparSQL(LEFT(loc_oBO.this_cLinVOpers, 3)) + ;
5058:                    " AND Numos = " + FormatarNumeroSQL(VAL(PADL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)), 9)), 0)
5059:         loc_nQtd = 0
5060:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChm") > 0
5061:             loc_nQtd = cursor_4c_ChkChm.Nreg
5062:             USE IN cursor_4c_ChkChm
5063:         ENDIF
5064:         IF loc_nQtd > 0
5065:             DO FORM SigCdLch WITH .T., LEFT(loc_oBO.this_cLinVOpers, 3), VAL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)))
5066:             RETURN
5067:         ENDIF
5068: 
5069:         *-- SigPrCtb (contabilizacao)
5070:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigPrCtb WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5071:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5072:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5073:         loc_nQtd = 0
5074:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtb") > 0
5075:             loc_nQtd = cursor_4c_ChkCtb.Nreg
5076:             USE IN cursor_4c_ChkCtb
5077:         ENDIF
5078:         IF loc_nQtd > 0
5079:             DO FORM SigCdPgb WITH loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5080:             RETURN
5081:         ENDIF
5082: 
5083:         *-- SigCdNec (necessidade de material vinculada ao movimento)
5084:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdNec WHERE EmpDnPs = " + ;
5085:                    EscaparSQL(loc_oBO.this_cLinEmps + loc_oBO.this_cLinDopes + STR(loc_oBO.this_nLinNumes, 10))
5086:         loc_nQtd = 0
5087:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNec") > 0
5088:             loc_nQtd = cursor_4c_ChkNec.Nreg
5089:             USE IN cursor_4c_ChkNec
5090:         ENDIF
5091:         IF loc_nQtd > 0
5092:             DO FORM SigMvPdt WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5093:         ENDIF
5094:     ENDPROC
5095: 
5096:     *--------------------------------------------------------------------------
5097:     * BtnRecebeClick - equivalente ao Click de btnRecebe: busca o(s)
5098:     * recebimento(s) do titulo corrente (SigCdPit/SigCdPgr/SigCdPbx) e, se
5099:     * nao achar, cai no fallback de SigTtCcr - igual ao legado.
5100:     *--------------------------------------------------------------------------
5101:     PROCEDURE BtnRecebeClick()
5102:         LOCAL loc_oBO, loc_cSQL
5103: 
5104:         loc_oBO = THIS.this_oBusinessObject
5105: 
5106:         loc_cSQL = "SELECT DISTINCT a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques " + ;
5107:                    "FROM SigCdPit a, SigCdPgr b, SigCdPbx c " + ;
5108:                    "WHERE a.Nopers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + ;
5109:                    " AND a.EmpDopNums = b.EmpDopNums AND a.EmpDopNums = c.EmpDopNums " + ;
5110:                    "ORDER BY a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques"
5111: 
5112:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5113:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
5114:             RETURN
5115:         ENDIF
5116: 
5117:         IF !EOF("cursor_4c_ConsPgt")
5118:             IF USED("cursor_4c_ConsPgt")
5119:                 USE IN cursor_4c_ConsPgt
5120:             ENDIF
5121:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5122:             RETURN
5123:         ENDIF
5124:         IF USED("cursor_4c_ConsPgt")
5125:             USE IN cursor_4c_ConsPgt
5126:         ENDIF
5127: 
5128:         loc_cSQL = "SELECT Emps, Dopcs AS Dopes, Numcs AS Numes, Nopers, Datas AS DataRcs, 0 AS Acertos, " + ;
5129:                    "'   ' AS Moedas, Dopcs AS Fpags, ' ' AS NCheques " + ;
5130:                    "FROM SigTtCcr " + ;
5131:                    "WHERE NOpers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + " " + ;
5132:                    "ORDER BY Emps, Dopcs, Numcs, Nopers, Datas"
5133: 
5134:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5135:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
5136:             RETURN
5137:         ENDIF
5138: 
5139:         IF !EOF("cursor_4c_ConsPgt")
5140:             IF USED("cursor_4c_ConsPgt")
5141:                 USE IN cursor_4c_ConsPgt
5142:             ENDIF
5143:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5144:         ELSE
5145:             IF USED("cursor_4c_ConsPgt")
5146:                 USE IN cursor_4c_ConsPgt
5147:             ENDIF
5148:             MsgAviso("Nenhum Recebimento Localizado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5149:         ENDIF

*-- Linhas 5272 a 5350:
5272:         IF USED("cursor_4c_RelFin")
5273:             USE IN cursor_4c_RelFin
5274:         ENDIF
5275:         SELECT 9999999999 AS Ordem, Nopers, SPACE(1) AS Tipo, SaldoDia AS Saldos, SaldoTot AS SaldosP, Debitos, ;
5276:                Creditos, SPACE(10) AS ContaCobs, Grupos, Contas, ContEms, OrdHs, Hists, Hist2s, NFs, Datas, ;
5277:                Vencs, DtEmis, DtBaixa, Titulos, Moedas, SInis, SPACE(50) AS RClis ;
5278:           FROM (loc_cCursor) ;
5279:           INTO CURSOR cursor_4c_RelFin READWRITE
5280: 
5281:         SELECT cursor_4c_RelFin
5282:         GO TOP
5283:         IF EOF()
5284:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Impress" + CHR(227) + "o!!!", "Impress" + CHR(227) + "o")
5285:             USE IN cursor_4c_RelFin
5286:             RETURN
5287:         ENDIF
5288: 
5289:         loc_cTit = "Relat" + CHR(243) + "rio Financeiro"
5290:         loc_cSub = PROPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Filtros.Value)) + " - Ordem: " + ;
5291:                    PROPER(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.List(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.ListIndex))
5292:         loc_cRes = ALLTRIM(SUBSTR(ALLTRIM(THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value), 2))
5293: 
5294:         IF USED("cursor_4c_RelFinCab")
5295:             USE IN cursor_4c_RelFinCab
5296:         ENDIF
5297:         CREATE CURSOR cursor_4c_RelFinCab (Titulo C(80), SubTitulo C(80), Moeda1 C(80), RodRelCC M(4))
5298:         INSERT INTO cursor_4c_RelFinCab (Titulo, SubTitulo, RodRelCC) VALUES (loc_cTit, loc_cSub, loc_cRes)
5299:         GO TOP IN cursor_4c_RelFinCab
5300: 
5301:         loc_cFor = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "0=0", "(Nopers < 9999997) AND (SInis <> 1)")
5302: 
5303:         SELECT cursor_4c_RelFin
5304:         DO CASE
5305:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtEmis"
5306:             INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR &loc_cFor.
5307:         CASE THIS.this_oBusinessObject.this_cOrdem = "Vencs"
5308:             INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR &loc_cFor.
5309:         CASE THIS.this_oBusinessObject.this_cOrdem = "Datas"
5310:             INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR &loc_cFor.
5311:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtBaixa"
5312:             INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR &loc_cFor.
5313:         CASE THIS.this_oBusinessObject.this_cOrdem = "Titulos"
5314:             INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR &loc_cFor.
5315:         CASE THIS.this_oBusinessObject.this_cOrdem = "Hists"
5316:             INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR &loc_cFor.
5317:         CASE THIS.this_oBusinessObject.this_cOrdem = "ContEms"
5318:             INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR &loc_cFor.
5319:         CASE THIS.this_oBusinessObject.this_cOrdem = "Contas"
5320:             INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR &loc_cFor.
5321:         ENDCASE
5322: 
5323:         SELECT cursor_4c_RelFin
5324:         GO TOP
5325: 
5326:         IF !FILE(FULLPATH(loc_cFrx + ".frx"))
5327:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + FULLPATH(loc_cFrx + ".frx"), "Erro")
5328:         ELSE
5329:             THIS.ExecutarReportForm("SigReCgf", "PREVIEW")
5330:         ENDIF
5331: 
5332:         USE IN cursor_4c_RelFinCab
5333:         USE IN cursor_4c_RelFin
5334: 
5335:         SELECT (loc_cCursor)
5336:         GO TOP
5337:     ENDPROC
5338: 
5339:     *--------------------------------------------------------------------------
5340:     * Planilha - transcricao de ThisForm.Planilha: exporta cursor_4c_Dados
5341:     * para XLS/TXT via PUTFILE + COPY TO, igual ao legado (fVerificaPasta/
5342:     * fLimpaTexto ja portadas em utils/functions.prg).
5343:     *--------------------------------------------------------------------------
5344:     PROCEDURE Planilha()
5345:         LOCAL loc_cCursor, loc_cArq, loc_cDeb, loc_cCrd
5346: 
5347:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5348: 
5349:         IF !USED(loc_cCursor)
5350:             RETURN

*-- Linhas 5363 a 5411:
5363:             IF USED("cursor_4c_RelExcel")
5364:                 USE IN cursor_4c_RelExcel
5365:             ENDIF
5366:             SELECT IIF((Nopers < 9999997) AND (SInis <> 1), SPACE(5), "TOTAL") AS Linhas, ;
5367:                    TTOD(DtEmis) AS Emissao, TTOD(Vencs) AS Vencimento, TTOD(Datas) AS Lancamento, ;
5368:                    TTOD(DtBaixa) AS Baixa, Titulos AS Titulo, NFs AS NF, TitBans AS Bancos, ;
5369:                    EspecieNfs AS Especie, IIF(Pagos = "1", "Baixado ", "Pendente") AS Situacao, ;
5370:                    Hists AS Historico, Hist2s AS Historico2, Moedas AS Moeda, Valors AS Valor, ;
5371:                    Debitos AS Debito, Creditos AS Credito, SaldoDia AS Saldo, SaldoTot AS Acumulado, ;
5372:                    GrupEms AS Grp_Emitente, ContEms AS Cta_Emitente, Grupos AS Grp_Portador, Contas AS Cta_Portador, ;
5373:                    SGrupos AS Grp_CCusto, SContas AS Cta_CCusto, GrupAges AS Grp_Agente, ContAges AS Cta_Agente ;
5374:               FROM (loc_cCursor) ;
5375:               INTO CURSOR cursor_4c_RelExcel
5376: 
5377:             SELECT cursor_4c_RelExcel
5378:             GO TOP
5379: 
5380:             IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) = "xls"
5381:                 COPY TO (loc_cArq) TYPE XLS
5382:             ELSE
5383:                 COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
5384:             ENDIF
5385: 
5386:             IF FILE(loc_cArq)
5387:                 MsgInfo("Planilha Gerada Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
5388:             ENDIF
5389: 
5390:             USE IN cursor_4c_RelExcel
5391:         ELSE
5392:             MsgAviso("Ocorreu Um Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha, Verifique" + CHR(10) + ;
5393:                       "O Diret" + CHR(243) + "rio Ou Se a Planilha Se Encontra Em Uso!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5394:         ENDIF
5395: 
5396:         SELECT (loc_cCursor)
5397:         GO TOP
5398:     ENDPROC
5399: 
5400:     *==========================================================================
5401:     * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
5402:     *
5403:     * Os metodos abaixo sao os FUNIS unicos das acoes que o legado espalha
5404:     * entre os Click/When dos CommandGroups e o AfterRowColChange da grade.
5405:     * NENHUM botao novo foi criado (PILAR 1 / "NUNCA inventar"): cada funil e
5406:     * acionado pelo handler do controle que o SCX legado realmente tem.
5407:     *
5408:     *   BtnBuscarClick       <- cmgFiltros.Buttons(1) "Consultar"
5409:     *   BtnCancelarClick     <- cmgRetornar (volta da Page2) e, na Page1,
5410:     *                           cmgFiltros.Buttons(2) "Sair"
5411:     *   BtnEncerrarClick     <- cmgFiltros.Buttons(2) "Sair" (ThisForm.Release)

*-- Linhas 5497 a 5515:
5497:             RETURN .F.
5498:         ENDIF
5499: 
5500:         SELECT (loc_cCursor)
5501:         GO TOP
5502:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
5503: 
5504:         IF EOF(loc_cCursor)
5505:             THIS.LimparCampos()
5506:             THIS.AjustarBotoesPorModo()
5507:         ELSE
5508:             THIS.GrdDadosAfterRowColChange(1)
5509:         ENDIF
5510: 
5511:         loc_lResultado = .T.
5512:         RETURN loc_lResultado
5513:     ENDPROC
5514: 
5515:     *--------------------------------------------------------------------------


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

