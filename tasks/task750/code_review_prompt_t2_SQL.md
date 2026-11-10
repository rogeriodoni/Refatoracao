# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '3' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, SALDOS, MATRIZES, CONTAMATS, ICLIS, CONTAS, GRUCONMOES, 0, EMPCCS, TITCANCS, TIPO, MOEDAS, PO, EMPDOPNUMS, OPERS, EMPDOPNCS, SITUAS, LCSTRTOIN, LNCONTA1, LNCONTA2, NORDRELS, VCNT, SELECIONA, CEMPS, EMPS, NOPERS, ONLINES, LOPAGINA, CONCILIAS, DOPES, EMPDNPS, NOPERCS, CIDCHAVES, CANAUDITS, CHKCONCS, ICL, TAXAS, DATAS, NUMES, TIPOS, NUMOS, EMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, SALDOS, MATRIZES, CONTAMATS, ICLIS, CONTAS, GRUCONMOES, 0, EMPCCS, TITCANCS, TIPO, MOEDAS, PO, EMPDOPNUMS, OPERS, EMPDOPNCS, SITUAS, LCSTRTOIN, LNCONTA1, LNCONTA2, NORDRELS, VCNT, SELECIONA, CEMPS, EMPS, NOPERS, ONLINES, LOPAGINA, CONCILIAS, DOPES, EMPDNPS, NOPERCS, CIDCHAVES, CANAUDITS, CHKCONCS, ICL, TAXAS, DATAS, NUMES, TIPOS, NUMOS, EMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAPGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, SALDOS, MATRIZES, CONTAMATS, ICLIS, CONTAS, GRUCONMOES, 0, EMPCCS, TITCANCS, TIPO, MOEDAS, PO, EMPDOPNUMS, OPERS, EMPDOPNCS, SITUAS, LCSTRTOIN, LNCONTA1, LNCONTA2, NORDRELS, VCNT, SELECIONA, CEMPS, EMPS, NOPERS, ONLINES, LOPAGINA, CONCILIAS, DOPES, EMPDNPS, NOPERCS, CIDCHAVES, CANAUDITS, CHKCONCS, ICL, TAXAS, DATAS, NUMES, TIPOS, NUMOS, EMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMNCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, SALDOS, MATRIZES, CONTAMATS, ICLIS, CONTAS, GRUCONMOES, 0, EMPCCS, TITCANCS, TIPO, MOEDAS, PO, EMPDOPNUMS, OPERS, EMPDOPNCS, SITUAS, LCSTRTOIN, LNCONTA1, LNCONTA2, NORDRELS, VCNT, SELECIONA, CEMPS, EMPS, NOPERS, ONLINES, LOPAGINA, CONCILIAS, DOPES, EMPDNPS, NOPERCS, CIDCHAVES, CANAUDITS, CHKCONCS, ICL, TAXAS, DATAS, NUMES, TIPOS, NUMOS, EMPOS

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
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column10.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigMvCcr.usualts"
  ControlSource = "crSigMvCcr.hists"
  ControlSource = "crSigMvCcr.hist2s"
  ControlSource = ""
  ControlSource = "crSigMvCcr.Jobs"
  ControlSource = "crSigMvCcr.Auditors"
  ControlSource = "crSigMvCcr.UsuConcs"
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "xTmpBaixa.Emps"
  Column2.ControlSource = "xTmpBaixa.Dopes"
  Column3.ControlSource = "xTmpBaixa.Numes"
  Column4.ControlSource = "xTmpBaixa.Valos"
  Column5.ControlSource = "xTmpBaixa.Moedas"
Select xConta
Select CrSigMvCcr
				Insert Into xConta ( Datas, Saldos, Hists, seleciona ) ;
				Insert Into xConta ( Datas, Saldos, Hists, Concs, seleciona ) ;
				Insert Into xConta ( Datas, Saldos, Hists, seleciona ) ;
				Insert Into xConta ( Datas, Saldos, Hists, seleciona ) ;
Select xConta
Select CrSigMvCcr
lcQuery = [Select a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, b.RClis, b.Situas, b.Cpfs, b.ContaMats, ' ' as Matriz ] + ;
		    [From SigMvSlc a, SigCdCli b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvSlc]) < 1)
Update CrSigMvSlc Set Matriz = Iif(Empty(ContaMats), '', Iif(Contas = ContaMats, 'M', 'F'))
Select CrSigMvSlc
		Delete From crSigMvSlc Where Saldos <= 0
		Delete From crSigMvSlc Where Saldos >= 0
	.Column1.ControlSource = 'CrSigMvSlc.contas'
	.Column2.ControlSource = 'CrSigMvSlc.rclis'
	.Column3.ControlSource = 'CrSigMvSlc.moedas'
	.Column4.ControlSource = 'CrSigMvSlc.saldos'
	.Column5.ControlSource = 'CrSigMvSlc.Emps'
	.Column6.ControlSource = 'CrSigMvSlc.Cpfs'
	.Column7.ControlSource = 'CrSigMvSlc.Matriz'
	=Seek(Padr(ThisForm.Page.Hist.get_grupo.Value , 10), [crSigCdGcr], [Codigos])
	Insert Into crMatrizes (Grupos, Contas, Moedas) Values (lcGru, lcCon, lcMoeda)
	Select * From CrSigMvSlc Into Cursor LocalMvSlc ReadWrite
			lcQuery = [Select Grupos, IClis From SigCdCli Where ContaMats = '] + CrSigMvSlc.Contas + [' And IClis <> '] + CrSigMvSlc.Contas + [']
			lcQuery = [Select IClis, Grupos From SigCdCli Where ContaMats = '] + CrSigMvSlc.ContaMats + [' And IClis <> '] + CrSigMvSlc.Contas + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMat') < 1)
		Select crTmpMat
			Insert Into crMatrizes (Grupos, Contas, Moedas) Values (crTmpMat.Grupos, crTmpMat.IClis, lcMoeda)
			lcQuery = [Select a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, b.RClis, b.Situas, b.Cpfs, b.ContaMats, ' ' as Matriz ] + ;
					    [From SigMvSlc a, SigCdCli b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMvSlc1]) < 1)
			Update LocalMvSlc1 Set Matriz = Iif(Empty(ContaMats), '', Iif(Contas = ContaMats, 'M', 'F'))
			Select LocalMvSlc
				Select LocalMvSlc1
				Insert Into LocalMvSlc From Memvar
	lcQuery = [Select 9999999999 as Ordem, ' ' as Tipo, a.Saldos as SaldosP, a.Valors as Debitos, a.Valors as Creditos, ] + ;
				[From SigMvCcr a, SigCdCli b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crMccr') < 1)
	Select * From CrSigMvSlc Where 0=1 Into Cursor TmpSccr ReadWrite
	Select crMatrizes
		lcQuery = [Select 'R' as Tipo, a.Saldos as SaldosP, a.Valors as Debitos, a.Valors as Creditos, a.*, b.RClis, 0 as Seleciona ] +;
					[From SigMvCcr a, SigCdCli b ] + ;
		lnErro4 = ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrMcc1' )
		lcquery = [Select 'P' as Tipo, a.Saldos as SaldosP, a.Valors as Debitos, a.Valors as Creditos, a.*, b.RClis ] + ;
					[From SigMvCpv a, SigCdCli b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crMcpv') < 1)
		Select CrMcc1
			Insert Into crMccr From Memvar
		Select CrMcpv
			Insert Into crMccr From Memvar
			Delete From crMccr Where TitCancs = 1
					Delete From crMccr Where Empty(NFs)
					Delete From crMccr Where Not Empty(NFs)
		Select * ;
		  From LocalMvSlc ;
		Select TmpSccr1
			Insert Into TmpSccr From Memvar
		Update crMccr Set ContaCobs = Contas, Contas = lcMat, GruConMoes = crMccr.Grupos + lcMat + crMccr.Moedas
		lcQuery = [Select IClis, Grupos From SigCdCli Where ContaMats = '] + CrSigMvSlc.Contas + [' And IClis = ContaMats]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMat') < 1)
			Update crMccr Set Grupos = LocalMat.Grupos, Contas = LocalMat.IClis
			Update crMccr Set Grupos = crMatrizes.Grupos, Contas = crMatrizes.Contas
	Select CrMccr
			Delete From crMccr Where Not Concs && Richard Em 06/08/2012 Pois Selects Ignoram Index Com Filtros
			Delete From crMccr Where Concs && Richard Em 06/08/2012 Pois Selects Ignoram Index Com Filtros
			Select CrMccr
				Delete From crMccr Where Not Tipo = [R] && Richard Em 06/08/2012 Pois Selects Ignoram Index Com Filtros
				Select CrMccr
				Delete From crMccr Where Not Tipo = [R] && Richard Em 06/08/2012 Pois Selects Ignoram Index Com Filtros
		Select crMccr
			Select CrMccr
			Select CrMccr
		Select * From crMccr Where 0 = 1 Into Cursor TmpMccr ReadWrite
		Select Moedas, Sum(Debitos) as Debitos, Sum(Creditos) as Creditos ;
		  From crMccr ;
				Update crMccr Set Saldos = 0, SaldosP = 0
				Select CrMccr
		Select TmpMoes
			Insert Into crMccr (Concs, Tipo, Grupos, Contas, Moedas, RClis, Datas, DataConcs, Titulos, ;
		Select Padr([VENCIDOS EM ] + Alltrim(Moedas) + [ :], 30) as Hists, Sum(Debitos) as Debitos, Sum(Creditos) as Creditos ;
	  	  From crMccr ;
		Select Padr([A VENCER EM ] + Alltrim(Moedas) + [ :], 30) as Hists, Sum(Debitos) as Debitos, Sum(Creditos) as Creditos ;
	  	  From crMccr ;
		Select crVencimentos
			Insert Into crMccr (Concs, Tipo, Grupos, Contas, Moedas, RClis, Datas, DataConcs, Titulos, ;
		Select crMccr
		Select TmpSccr
			Select crMoedas
			Select CrMccr
				=Seek(CrMccr.Grupos, [crSigCdGcr], [Codigos])
					Select TmpHist
					If Not Seek(CrMccr.Grupos + CrMccr.Contas) 
						Insert Into TmpHist (Grupos, Contas, Hists, Opers, Emps, Dopes, ;
				If !Seek( Str( crMoedas.NOrdRels, 1 ) + crMoedas.Cmoes, 'TmpMoeda' )
					Insert Into TmpMoeda ( Tipo, Moeda ) ;
		Select TmpSccr
			Select crMoedas
			Select CrMccr
				=Seek(CrMccr.Grupos, [crSigCdGcr], [Codigos])
				If (Seek(CrMccr.Moedas,'crMoedas','Cmoes') And BetWeen(crMoedas.nOrdRels,1,5)) Or ;
					Select TmpHist
					Insert Into TmpHist ( Concs, Audits, Datas, Grupos, Contas, Hists, Hist2s, ;
		Select TmpHist
			Select TmpHist
			Select TmpMoeda
			Select dbCabecalho
			Insert Into dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Moeda1, Moeda2, Moeda3, Moeda4, Moeda5, RodRelCC) ;
				lcQuery = [Select * ] + ;
						    [From SigPrTxc ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalTaxas]) < 1)
				Select LocalTaxas
					Update TmpHist ;
			Select TmpHist
			Insert Into dbCabecalho (NomeEmpresa, Titulo, SubTitulo, RodRelCC) ;
		Select [] as Agrupar, Sum(Valor4s + Valor5s) as Valor, Sum(Saldo4 + Saldo5) as Saldo ;
		  From TmpHist ;
		Select TmpHist
		Update TmpHist Set RClis = Iif(llDct, Iif(InList(Alltrim(RClis), [TOTAIS POR MOEDA], [VENCIMENTOS POR MOEDA], [SALDO ANTERIOR]), RClis, Contas), RClis)
			Select crMccr
			Insert Into crMccr (Concs, Tipo, Grupos, Contas, Moedas, RClis, Datas, DataConcs, Titulos, ;
						Select crMccr
						Update crMccr Set RClis = Iif(llDct, Iif(InList(Alltrim(RClis), [TOTAIS POR MOEDA], [VENCIMENTOS POR MOEDA], [SALDO ANTERIOR]), RClis, Contas), RClis)
						Select TmpHist		&& Mena-13/02/2012 - seleciona cursor pois estava dando erro no report 
						Select crMccr
						Update crMccr Set RClis = Iif(llDct, Iif(InList(Alltrim(RClis), [TOTAIS POR MOEDA], [VENCIMENTOS POR MOEDA], [SALDO ANTERIOR]), RClis, Contas), RClis)
						Select TmpHist		&& Mena-13/02/2012 - seleciona cursor pois estava dando erro no report 
	=Seek(Padr(ThisForm.Page.Hist.get_grupo.Value , 10), [crSigCdGcr], [Codigos])
	lcQuery = [Select x.cIdChaves, x.GruConMoes, x.DataConcs, x.Nopers, x.Concs, x.Saldocs, x.Datas, x.Saldons, x.Saldos, x.Grupos, x.Contas, ] + ;
				[From ( ] + ;
			  [Select a.cIdChaves, a.GruConMoes, a.DataConcs, a.Nopers, a.Concs, a.Saldocs, a.Datas, a.Saldons, a.Saldos, a.Grupos, a.Contas, ] + ;
			    [From SigMvCcr a ] + ;
			  [Select d.cIdChaves, d.GruConMoes, d.DataConcs, d.Nopers, d.Concs, d.Saldocs, d.Datas, d.Saldons, d.Saldos, d.Grupos, d.Contas, ] + ;
			  	[From SigMvCcr d ] + ;
			   [Where d.EmpDopNums In (Select Distinct e.EmpDopNums From SigMvCcr e ] + ;
			   		 [((d.Dopcs In (Select s.Dopes From SigOpOpe s) And d.Opers = 'D') Or Not d.Dopcs In (Select s.Dopes From SigOpOpe s)) ] + ;
			  [Select g.cIdChaves, g.GruConMoes, g.DataConcs, g.Nopers, g.Concs, g.Saldocs, g.Datas, g.Saldons, g.Saldos, g.Grupos, g.Contas, ] + ;
			  	[From SigMvCcr g ] + ;
			   [Where g.EmpDopNcs In (Select Distinct h.EmpDopNcs From SigMvCcr h ]+ ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crMccr]) < 1)
		Update crMccr Set Contas = lcMat, GruConMoes = crMccr.Grupos + lcMat + crMccr.Moedas
	Select * ;
	  From crSigMvSlc ;
	Select crMccr
	Select TmpSccr
		Select crMoedas
		Select CrMccr
			=Seek(crMccr.Grupos, [crSigCdGcr], [Codigos])
				Select TmpHist
				If Not Seek(crMccr.Grupos + crMccr.Contas)
					Insert Into TmpHist (Grupos, Contas, Hists, Opers, Emps, Dopes, Numes, Contador, Classes, RClis, RContas, cIdChaves, Tipos) ;
			If Not Seek(Str(crMoedas.NOrdRels, 1) + crMoedas.Cmoes, [TmpMoeda])
				Insert Into TmpMoeda (Tipo, Moeda) Values (crMoedas.NOrdRels, crMoedas.CMoes)
	Select TmpSccr
		Select crMoedas
		Select CrMccr
			=Seek(crMccr.Grupos, [crSigCdGcr], [Codigos])
			If (Seek(crMccr.Moedas, [crMoedas], [CMoes]) And BetWeen(crMoedas.NOrdRels,1,5)) Or (Not Empty(lcMoe) And crMccr.Moedas = lcMoe)
				Select TmpHist
				Insert Into TmpHist (Concs, Audits, Datas, Grupos, Contas, Hists, Hist2s, Opers, Emps, Dopes, Numes, ;
	Select TmpHist
		Select TmpHist
		Select TmpMoeda
		Select dbCabecalho
		Insert Into dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Moeda1, Moeda2, Moeda3, Moeda4, Moeda5, RodRelCC) ;
		Select crMccr
				Select TmpHist
				Insert Into TmpHist (Concs, Audits, Datas, Grupos, Contas, Hists, Hist2s, Opers, Emps, Dopes, Numes, ;
		Select TmpHist
Select crMoedas
insert into dbcabecalho (NomeEmpresa,Titulo,SubTit,cb_Moe1,cb_Moe2,cb_Moe3,cb_Moe4,cb_Moe5,Total) ;
Select Contas, Moedas, Saldos From CrSigMvSlc ;
	lcquery = [Select GruConMoes, CidChaves, Grupos, Contas, Moedas, Datas, Nopers, Saldos ]+;
				[From SigMvCcr Where Grupos = ?lcGrupo order by CidChaves ]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crMccr') < 1)
	Select CrMccr
Select TmpSal
		Select CrMccr
		Select TmpSaldo
		Select TmpSaldo
Select TmpSaldo
Select TS2
Update crMoedas Set CMoes = CHRTRAN(CMoes, lcStrToIn, lcStrToOt)
		If Seek(StrTran(Upper(AllTrim(AImpCampo(m.lnConta2,1))),'C_',''),'crMoedas','Cmoes').And.((Empty(lcMoeda) And crMoedas.nOrdRels==m.lnConta1) Or (!Empty(lcMoeda) And lnConta1 = 1 ))
Select TS2
	Select CrSigCdCli
	Insert Into ImpSaldo ( Contas, Nome, Valor1, Valor2, Valor3, Valor4, Valor5, Ord ) ;
	Insert Into ImpSaldo ( Contas, Nome, Valor1, Valor2, Valor3, Valor4, Valor5, Ord ) ;
Select ImpSaldo 
SELECT crSigmvCcr
SELECT * from crSigmvCcr where Seleciona = 1 into cursor crCcr
SELECT crCcr
lcQueryCot     = [Select a.* From SigCdCot a]
lcQueryEmp     = [Select a.* From SigCdEmp a Where a.cemps = ']+_empr+[' ]
lcQueryMoe     = [Select a.* From SigCdMoe a]
lcQueryParam   = [Select a.gesind,a.moedetqs,a.grupoests,a.contaests,a.transfres,a.empmasters, a.SaldConcs, ]+;
				  [From SigCdPam a]
lcQueryGccr    = [Select a.Codigos, a.Descrs From SigCdGcr a]
lcQueryCli     = [Select a.Iclis, a.Rclis, a.Concilias ]+;
					[From SigCdCli a Where a.Iclis = ?lcCliente ]
lcQueryAltc    = [Select * From SigMvCcr Where Emps = ?pEmp and Nopers = ?pNoper ]
lcQueryUsu     = [Select * From SigCdUsu Where Not cAtivos='N' ]
lcQueryCar     = [Select * From SigCdCrg  ]
lcSql = [Select * From SigCdPac]
Thisform.Podatamgr.Sqlexecute(lcSql,'CrSigCdPac')
lcQuery = [Select Codigos, Classes, Descrs, RodRelCC From SigCdGcr]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdGcr]) < 1)
Select crSigCdGcr
lcQuery = [Select Razas From SigCdEmp Where CEmps = '] + _Empr + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crEmpresa]) < 1)
Select crEmpresa
lcQuery = [Select CMoes, NOrdRels From SigCdMoe]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crMoedas]) < 1)
Select crMoedas
lcSql = [Select * From SigOpCls Where Onlines = 1]
ThisForm.Podatamgr.Sqlexecute(lcSql,'LocCalcS')
	lcQuery = [Select a.grupos, a.contas ]+;
		   [From SigMvSlc a ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSaldo') < 1)
	Select CrSaldo
	Select CrSigMvSlc
	lcquery = [Select a.grupos, a.contas ]+;
				[From SigMvSlc a ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSaldo') < 1)
	Select CrSaldo
Select CrSigCdCli
Insert Into crMatrizes (Grupos, Contas, Moedas) Values (lcGSccr, lcCSccr, lcMSccr)
		lcQuery = [Select IClis, Grupos From SigCdCli Where ContaMats = '] + CrSigMvSlc.Contas + [' And IClis <> '] + CrSigMvSlc.Contas + [']
		lcQuery = [Select IClis, Grupos From SigCdCli Where ContaMats = '] + CrSigMvSlc.ContaMats + [' And IClis <> '] + CrSigMvSlc.Contas + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMat') < 1)
	Select crTmpMat
		Insert Into crMatrizes (Grupos, Contas, Moedas) Values (crTmpMat.Grupos, crTmpMat.IClis, lcMSccr)
lcQuery = [Select ' ' as Tipo, a.Saldos as SaldosP, a.*, 0 as Seleciona From SigMvCcr a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMccr') < 1)
Select crMatrizes
	lcQuery = [Select 'R' as Tipo, a.Saldos as SaldosP, a.*, 0 as Seleciona From SigMvCcr a ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMcc1') < 1)
	lcQuery = [Select 'P' as Tipo, b.Saldos as SaldosP, b.* From SigMvCpv b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMcpv') < 1)
	Select CrTmpMcc1
		Insert Into crTmpMccr From Memvar
	Select CrTmpMcpv
		Insert Into crTmpMccr From Memvar
Select *, .f. as Prorrogados From CrTmpMccr Into Cursor TMccr ;
Select tMccr
	Update crSigMvCcr Set Contas = lcMat, GruConMoes = crSigMvCcr.Grupos + lcMat + crSigMvCcr.Moedas
Select crSigMvCcr
	lcQuery = [Select * From SigOpMvv Where EmpDopNcs = '] + crSigMvCcr.EmpDopNcs + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalOpMvv') < 1)
Select CrSigMvCcr
		Select CrSigMvCcr
		Select CrSigMvCcr
		.Col_data.ControlSource = "Datas"
		.Col_saldo.ControlSource = "Saldos"
		.Col_hist.ControlSource = "Hists"
		.col_valor.ControlSource = "Valors"
		.col_oper.ControlSource = "Alltrim(Iif(CrSigMvCcr.Opers=[D], ThisForm.TxtDeb, ThisForm.TxtCre))"
		.col_emp.ControlSource = "iif(!Empty(CrSigMvCcr.EmpCCs),CrSigMvCcr.EmpCcs,CrSigMvCcr.Emps)" && Tiago - 22/02/2016 - Se tiver empresa no EMPCCS mostra ela
		.Column1.ControlSource = "Docus"
		.Column2.ControlSource = "NFs"
		.Column3.ControlSource = "Titulos"
		.Column4.ControlSource = "Tipo"
		.Col_selec.ControlSource = "Seleciona"
SELECT crSigmvCcr
Select CrSigCdCli
	Select (This.RecordSource)
lcQuery = [Select NDopes, RealPrevs ] + ;
		    [From SigOpOpe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpOpe') < 1)
lcQuery = [Select cIdChaves ] + ;
		    [From SigCdPgr ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigCqChm ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigPrCtb ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
lcQuery = [Select cIdChaves ] + ;
		    [From SigCdPbx ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigCdPbx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crAchou') < 1)
lcSql = [Select * From SigCqOch Where Nopers = ]+Str(crSigMvCcr.Nopers)
If ThisForm.Podatamgr.SqlExecute(lcSql,'CrAchou') > 0 And Reccount('CrAchou') > 0
Select CrSigMvCcr
lcWher  = [Select a.Contas, b.RClis ] + ;
			[From SigMvCcr a, SigCdCli b ] + ;
lnErro  = ThisForm.Podatamgr.SqlExecute(lcWher,'LocalCta')
lcWher  = [Select RClis From SigCdCli Where Iclis = '] + lcJob + [']
lnErro  = ThisForm.Podatamgr.SqlExecute(lcWher,'LocalCta')
lnSel=SELECT()
SELECT (lcCur)
SELECT (lcCur)
SELECT (lnSel)
	Select CrSigMvCcr
		Select crAltcc
			Select CrAltcc
		Select crAltcc
		Select CrSigMvCcr
	lcQuery = [Select NDopes, RealPrevs From SigOpOpe Where Dopes = ?lcDopc ]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpOpe') < 1)
	Select crSigMvCcr
	Select CrSigMvCcr
		Select crAltcc
		Locate For Opers = crSigMvCcr.Opers && 01/10/2014 - Richard - Não posicionava na perna correta, dependia de como vinha a select
	Select CrSigMvCcr
		Select crAltcc
			Select CrAltcc
		Select crAltcc
			Select crAltcc
		Select CrSigMvCcr
Select CrSigMvSlc
	Select xTmpBaixa
	Delete All
	lcQuery = [Select * From SigCdPbx Where ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdPbx') < 1)
	Select CrSigCdPbx
		Insert Into xTmpBaixa ( Emps, Dopes, Numes, Valos, Moedas ) ;
	Select xTmpBaixa
Insert Into crMatrizes (Grupos, Contas, Moedas) Values (lcGSccr, lcCSccr, lcMSccr)
		lcQuery = [Select IClis, Grupos From SigCdCli Where ContaMats = '] + CrSigMvSlc.Contas + [' And IClis <> '] + CrSigMvSlc.Contas + [']
		lcQuery = [Select IClis, Grupos From SigCdCli Where ContaMats = '] + CrSigMvSlc.ContaMats + [' And IClis <> '] + CrSigMvSlc.Contas + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMat') < 1)
	Select crTmpMat
		Insert Into crMatrizes (Grupos, Contas, Moedas) Values (crTmpMat.Grupos, crTmpMat.IClis, lcMSccr)
lcQuery = [Select ' ' as Tipo, a.Saldos as SaldosP, a.*, 0 as Seleciona From SigMvCcr a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMccr') < 1)
Select crMatrizes
    lcQuery = [Select 'R' as Tipo, a.Saldos as SaldosP, a.*, 0 as Seleciona From SigMvCcr a ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMcc1') < 1)
	lcQuery = [Select 'P' as Tipo, b.Saldos as SaldosP, b.* From SigMvCpv b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMcpv') < 1)
	Select CrTmpMcc1
		Insert Into crTmpMccr From Memvar
	Select CrTmpMcpv
		Insert Into crTmpMccr From Memvar
Select *, .f. as Prorrogados From CrTmpMccr Into Cursor TMccr ;
Select tMccr
	Update crSigMvCcr Set Contas = lcMat, GruConMoes = crSigMvCcr.Grupos + lcMat + crSigMvCcr.Moedas
Select crSigMvCcr
	lcQuery = [Select * From SigOpMvv Where EmpDopNcs = '] + crSigMvCcr.EmpDopNcs + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalOpMvv') < 1)
Select CrSigMvCcr
	Select CrSigMvCcr
	Select CrSigMvCcr
		ThisForm.page.hist.grd_lancamento.col_data.ControlSource = "Datas"
		ThisForm.page.hist.grd_lancamento.col_saldo.ControlSource = "Saldos"
		ThisForm.page.hist.grd_lancamento.col_data.ControlSource = "DataConcs"
		ThisForm.page.hist.grd_lancamento.col_saldo.ControlSource = "Saldocs"
		ThisForm.page.hist.grd_lancamento.col_data.ControlSource = "Datas"
		ThisForm.page.hist.grd_lancamento.col_saldo.ControlSource = "Saldons"
		ThisForm.page.hist.grd_lancamento.col_data.ControlSource = "Datas"
		ThisForm.page.hist.grd_lancamento.col_saldo.ControlSource = "SaldosP"
		ThisForm.page.hist.grd_lancamento.col_data.ControlSource = "Datas"
		ThisForm.page.hist.grd_lancamento.col_saldo.ControlSource = "Saldos"
ThisForm.page.hist.grd_lancamento.col_hist.ControlSource = "Hists"
ThisForm.page.hist.grd_lancamento.col_valor.ControlSource = "Valors"
ThisForm.page.hist.grd_lancamento.col_oper.ControlSource = "Alltrim(Iif(CrSigMvCcr.Opers=[D], ThisForm.TxtDeb, ThisForm.TxtCre))"
ThisForm.page.hist.grd_lancamento.col_emp.ControlSource = [iif(!Empty(CrSigMvCcr.EmpCCs),CrSigMvCcr.EmpCcs,CrSigMvCcr.Emps)]
ThisForm.page.hist.grd_lancamento.Column1.ControlSource = "Docus"
ThisForm.page.hist.grd_lancamento.Column2.ControlSource = "NFs"
ThisForm.page.hist.grd_lancamento.Column3.ControlSource = "Titulos"
ThisForm.page.hist.grd_lancamento.Column4.ControlSource = "Tipo"
ThisForm.page.hist.grd_lancamento.col_selec.ControlSource = "Seleciona"
	Select CrSigMvCcr
		Select CrSigMvCcr
Select CrSigMvCcr
	Select CrSigCqOch
	Select CrSigMvCcr
		lcQuery = [Select DtAudits, Auditors, Cidchaves From SigMvCcr Where GruConMoes = ']+crSigMvCcr.Grupos + lcCta + crSigMvCcr.Moedas+[' ]+;
		lnErro = ThisForm.poDataMgr.SqlExecute(lcQuery,'TmpMccr2')
				lcUpdate = [Update SigMvCcr Set DtAudits = ?llData, Auditors = ']+Usuar+[ ' Where Cidchaves = ']+TmpMccr2.CidChaves+[']
				lcUpdate = [Update SigMvCcr Set DtAudits = ?llData, Auditors = '          ' Where Cidchaves = ']+TmpMccr2.CidChaves+[']
			Insert into CrSigCqOch (Nopers, Datars, TpLancs, Datas, Usuars, CidChaves,DtLancs ) Values ;
				If ThisForm.PodataMgr.update('CrSigCqOch')
					lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
					Select CrSigMvCcr
	Select CrSigMvCcr
		lcSql = [Select * From SigSyBlq ]
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpBloq') < 1
		Select CrSigMvCcr
			Select CrSigMvCcr
		Select CrSigCqOch
		Select CrSigMvCcr
		lcQuery = [Select DataConcs, Concs, UsuConcs, Cidchaves From SigMvCcr Where CidChaves = ']+CrSigMvCcr.CidChaves+[']
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'TmpMccr') > 0 And Reccount('TmpMccr') > 0
			Select TmpMccr
				Select CrSigMvCcr
				lcUpdate = [Update SigMvCcr Set DataConcs = ?llData, Concs = ?llConc , UsuConcs = ']+Usuar+[ ' Where CidChaves = ']+TmpMccr.CidChaves+[']
				lcUpdate = [Update SigMvCcr Set DataConcs = ?llData, Concs = ?llConc , UsuConcs = ' ' Where CidChaves = ']+TmpMccr.CidChaves+[']
			Insert into CrSigCqOch (Nopers, Datars, TpLancs, Datas, Usuars, CidChaves ) Values ;
			If ThisForm.PodataMgr.update('CrSigCqOch')
				lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
					Select CrSigMvCcr
		Select CrSigMvCcr	&& Mena - 29/11/2017 - concilia todas marcadas
	lcSql = [Select * From SigCqOch where Nopers = ]+Str(CrSigMvCcr.Nopers)
	Thisform.PodataMgr.SqlExecute(lcSql,'lancto')
	Select Lancto
	Select CrSigMvCcr

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopind.prg) - TRECHOS RELEVANTES PARA PASS SQL (6924 linhas total):

*-- Linhas 72 a 118:
72:             THIS.this_dDataConcilia = {}
73:             THIS.this_cOperacao     = ""
74: 
75:             *-- Criar cursor placeholder para grd_saldo (mesma estrutura do SQLEXEC)
76:             SET NULL ON
77:             CREATE CURSOR cursor_4c_Saldos ;
78:                 (Emps C(3) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
79:                  Moedas C(3) NULL, Saldos N(14,2) NULL, Rclis C(60) NULL, ;
80:                  Situas C(4) NULL, Cpfs C(20) NULL, ContaMats C(10) NULL, ;
81:                  Matriz C(1) NULL)
82:             SET NULL OFF
83: 
84:             *-- Tags do MontaGrade legado ("Index On Rclis Tag rclis / Contas
85:             *-- Tag Contas / Cpfs Tag Cpfs"), que tambem sao os cordertag/
86:             *-- cseektag declarados nos Ingrid1 das Columns 1/2/6 do dump.
87:             *-- Criados aqui (e nao no MontaGrade) porque o cursor eh
88:             *-- PERSISTENTE no migrado: MontaGrade recarrega por ZAP+APPEND,
89:             *-- que preserva estrutura e indices - recria-los a cada carga
90:             *-- seria trabalho repetido.
91:             SELECT cursor_4c_Saldos
92:             INDEX ON Contas TAG Contas ADDITIVE
93:             INDEX ON Rclis  TAG Rclis  ADDITIVE
94:             INDEX ON Cpfs   TAG Cpfs   ADDITIVE
95:             SET ORDER TO
96: 
97:             *-- Carregar labels de D/C a partir de SigCdPam (parametros)
98:             IF gnConnHandle > 0
99:                 LOCAL loc_cSQLPam
100:                 loc_cSQLPam = "SELECT Drivets FROM SigCdPam"
101:                 IF SQLEXEC(gnConnHandle, loc_cSQLPam, "cursor_4c_PamTemp") >= 1
102:                     IF RECCOUNT("cursor_4c_PamTemp") > 0
103:                         SELECT cursor_4c_PamTemp
104:                         GO TOP
105:                         THIS.this_cTxtDeb = IIF(EMPTY(SUBSTR(cursor_4c_PamTemp.Drivets, 1, 3)), ;
106:                                                 "D", SUBSTR(cursor_4c_PamTemp.Drivets, 1, 3))
107:                         THIS.this_cTxtCre = IIF(EMPTY(SUBSTR(cursor_4c_PamTemp.Drivets, 5, 3)), ;
108:                                                 "C", SUBSTR(cursor_4c_PamTemp.Drivets, 5, 3))
109:                     ELSE
110:                         THIS.this_cTxtDeb = "D"
111:                         THIS.this_cTxtCre = "C"
112:                     ENDIF
113:                     IF USED("cursor_4c_PamTemp")
114:                         USE IN cursor_4c_PamTemp
115:                     ENDIF
116:                 ELSE
117:                     THIS.this_cTxtDeb = "D"
118:                     THIS.this_cTxtCre = "C"

*-- Linhas 489 a 627:
489:         * Propriedades TRANSCRITAS do dump legado (SIGOPIND.Page.SALDO.grd_saldo,
490:         * tasks/task750/sigopind_form_codigo_fonte.txt linhas 1059-1145):
491:         *   Top=140 Left=10 Width=980 Height=453 ColumnCount=7 ReadOnly=.T.
492:         *   RecordMark=.T. DeleteMark=.F. ScrollBars=2 GridLineColor=238,238,238
493:         *   Themes=.F. FontName="Tahoma"
494:         * GridLines e HeaderHeight NAO constam do dump - nao declarar (PILAR 1:
495:         * "nao inventar"). GridLines=0 em particular CONTRADIZ o
496:         * GridLineColor=238,238,238 que o legado declara, porque esconde as
497:         * linhas que essa cor existe para pintar.
498:         *----------------------------------------------------------------------
499:         loc_oPagina.AddObject("grd_4c_Saldos", "Grid")
500:         loc_oGrd = loc_oPagina.grd_4c_Saldos
501:         WITH loc_oGrd
502:             .Top           = 140
503:             .Left          = 10
504:             .Width         = 980
505:             .Height        = 453
506:             .ReadOnly      = .T.
507:             .FontName      = "Tahoma"
508:             .FontSize      = 8
509:             .RecordMark    = .T.
510:             .DeleteMark    = .F.
511:             .ScrollBars    = 2
512:             .GridLineColor = RGB(238, 238, 238)
513:             .Themes        = .F.
514:         ENDWITH
515:         loc_oGrd.ColumnCount  = 7
516:         loc_oGrd.RecordSource = "cursor_4c_Saldos"
517: 
518:         *-- Reconfigurar ControlSources, Width/ColumnOrder e Headers DEPOIS do
519:         *-- RecordSource: atribuir RecordSource recalcula Column.Width para o
520:         *-- default 90 e reseta Header1.Caption (regra #41 / Problema 48).
521:         *-- Width e ColumnOrder vem do dump legado: a ORDEM VISUAL das colunas
522:         *-- no legado eh Conta, Descricao, CPF/CNPJ, Saldo, Moeda, Emp, M/F
523:         *-- (ColumnOrder 1,2,5,4,6,3,7 sobre as Columns 1..7).
524:         loc_oGrd.Column1.ControlSource     = "cursor_4c_Saldos.Contas"
525:         loc_oGrd.Column1.ColumnOrder       = 1
526:         loc_oGrd.Column1.Width             = 100
527:         loc_oGrd.Column1.Movable           = .F.
528:         loc_oGrd.Column1.Resizable         = .F.
529:         loc_oGrd.Column1.ReadOnly          = .T.
530:         loc_oGrd.Column1.Header1.Caption   = "Conta"
531:         loc_oGrd.Column1.Header1.FontName  = "Tahoma"
532:         loc_oGrd.Column1.Header1.FontSize  = 8
533:         loc_oGrd.Column1.Header1.FontBold  = .T.
534:         loc_oGrd.Column1.Header1.Alignment = 2
535:         loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
536:         loc_oGrd.Column1.Header1.BackColor = RGB(255, 255, 255)
537: 
538:         loc_oGrd.Column2.ControlSource     = "cursor_4c_Saldos.Rclis"
539:         loc_oGrd.Column2.ColumnOrder       = 2
540:         loc_oGrd.Column2.Width             = 433
541:         loc_oGrd.Column2.Movable           = .F.
542:         loc_oGrd.Column2.Resizable         = .F.
543:         loc_oGrd.Column2.ReadOnly          = .T.
544:         loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
545:         loc_oGrd.Column2.Header1.FontName  = "Tahoma"
546:         loc_oGrd.Column2.Header1.FontSize  = 8
547:         loc_oGrd.Column2.Header1.FontBold  = .T.
548:         loc_oGrd.Column2.Header1.Alignment = 2
549:         loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
550:         loc_oGrd.Column2.Header1.BackColor = RGB(255, 255, 255)
551: 
552:         loc_oGrd.Column3.ControlSource     = "cursor_4c_Saldos.Moedas"
553:         loc_oGrd.Column3.ColumnOrder       = 5
554:         loc_oGrd.Column3.Width             = 43
555:         loc_oGrd.Column3.Movable           = .F.
556:         loc_oGrd.Column3.Resizable         = .F.
557:         loc_oGrd.Column3.ReadOnly          = .T.
558:         loc_oGrd.Column3.Text1.Alignment   = 3
559:         loc_oGrd.Column3.Header1.Caption   = "Moeda"
560:         loc_oGrd.Column3.Header1.FontName  = "Tahoma"
561:         loc_oGrd.Column3.Header1.FontSize  = 8
562:         loc_oGrd.Column3.Header1.FontBold  = .T.
563:         loc_oGrd.Column3.Header1.Alignment = 2
564:         loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
565:         loc_oGrd.Column3.Header1.BackColor = RGB(255, 255, 255)
566: 
567:         loc_oGrd.Column4.ControlSource     = "cursor_4c_Saldos.Saldos"
568:         loc_oGrd.Column4.ColumnOrder       = 4
569:         loc_oGrd.Column4.Width             = 140
570:         loc_oGrd.Column4.Movable           = .F.
571:         loc_oGrd.Column4.Resizable         = .F.
572:         loc_oGrd.Column4.ReadOnly          = .T.
573:         loc_oGrd.Column4.Text1.InputMask   = "99,999,999,999.99"
574:         loc_oGrd.Column4.Header1.Caption   = "Saldo"
575:         loc_oGrd.Column4.Header1.FontName  = "Tahoma"
576:         loc_oGrd.Column4.Header1.FontSize  = 8
577:         loc_oGrd.Column4.Header1.FontBold  = .T.
578:         loc_oGrd.Column4.Header1.Alignment = 2
579:         loc_oGrd.Column4.Header1.ForeColor = RGB(90, 90, 90)
580:         loc_oGrd.Column4.Header1.BackColor = RGB(255, 255, 255)
581: 
582:         loc_oGrd.Column5.ControlSource     = "cursor_4c_Saldos.Emps"
583:         loc_oGrd.Column5.ColumnOrder       = 6
584:         loc_oGrd.Column5.Width             = 41
585:         loc_oGrd.Column5.ReadOnly          = .T.
586:         loc_oGrd.Column5.Header1.Caption   = "Emp"
587:         loc_oGrd.Column5.Header1.FontName  = "Tahoma"
588:         loc_oGrd.Column5.Header1.FontSize  = 8
589:         loc_oGrd.Column5.Header1.FontBold  = .T.
590:         loc_oGrd.Column5.Header1.Alignment = 2
591:         loc_oGrd.Column5.Header1.ForeColor = RGB(90, 90, 90)
592:         loc_oGrd.Column5.Header1.BackColor = RGB(255, 255, 255)
593: 
594:         loc_oGrd.Column6.ControlSource     = "cursor_4c_Saldos.Cpfs"
595:         loc_oGrd.Column6.ColumnOrder       = 3
596:         loc_oGrd.Column6.Width             = 136
597:         loc_oGrd.Column6.Movable           = .F.
598:         loc_oGrd.Column6.Resizable         = .F.
599:         loc_oGrd.Column6.ReadOnly          = .T.
600:         loc_oGrd.Column6.Header1.Caption   = "CPF/CNPJ"
601:         loc_oGrd.Column6.Header1.FontName  = "Tahoma"
602:         loc_oGrd.Column6.Header1.FontSize  = 8
603:         loc_oGrd.Column6.Header1.FontBold  = .T.
604:         loc_oGrd.Column6.Header1.Alignment = 2
605:         loc_oGrd.Column6.Header1.ForeColor = RGB(90, 90, 90)
606:         loc_oGrd.Column6.Header1.BackColor = RGB(255, 255, 255)
607: 
608:         *-- Column7 = Matriz (M/F), NAO Situas: o legado liga
609:         *-- ".Column7.ControlSource = 'CrSigMvSlc.Matriz'" no MontaGrade, e o
610:         *-- Header1.Caption "M/F" so faz sentido sobre esse campo. O
611:         *-- Header1 do Column7 NAO declara Alignment nem BackColor no dump.
612:         loc_oGrd.Column7.ControlSource     = "cursor_4c_Saldos.Matriz"
613:         loc_oGrd.Column7.ColumnOrder       = 7
614:         loc_oGrd.Column7.Width             = 28
615:         loc_oGrd.Column7.Alignment         = 2
616:         loc_oGrd.Column7.ReadOnly          = .T.
617:         loc_oGrd.Column7.Text1.Alignment   = 2
618:         loc_oGrd.Column7.Header1.Caption   = "M/F"
619:         loc_oGrd.Column7.Header1.FontName  = "Tahoma"
620:         loc_oGrd.Column7.Header1.FontSize  = 8
621:         loc_oGrd.Column7.Header1.FontBold  = .T.
622:         loc_oGrd.Column7.Header1.ForeColor = RGB(90, 90, 90)
623: 
624:         *-- DynamicBackColor transcrito do MontaGrade legado: matriz em verde
625:         *-- claro, filial em amarelo, conta sem vinculo em branco.
626:         loc_oGrd.SetAll("DynamicBackColor", ;
627:             "IIF(cursor_4c_Saldos.Matriz = 'M', RGB(220,255,220), " + ;

*-- Linhas 1932 a 1954:
1932: 
1933:         *----------------------------------------------------------------------
1934:         * Cursor placeholder para grd_4c_Lancamento
1935:         * (sera populado por BtnConsultarSaldoClick via SQLEXEC)
1936:         *----------------------------------------------------------------------
1937:         IF !USED("CrSigMvCcr")
1938:             SET NULL ON
1939:             CREATE CURSOR CrSigMvCcr ( ;
1940:                 Emps        C(3),    ;
1941:                 Grupos      C(10),   ;
1942:                 Contas      C(10),   ;
1943:                 Moedas      C(3),    ;
1944:                 Datas       D,       ;
1945:                 DataConcs   D,       ;
1946:                 Hists       C(60),   ;
1947:                 Hist2s      C(80),   ;
1948:                 Valors      N(11,2), ;
1949:                 Saldos      N(15,2), ;
1950:                 Opers       C(1),    ;
1951:                 Nopers      N(7),    ;
1952:                 Numes       N(6),    ;
1953:                 Dopes       C(20),   ;
1954:                 Dopcs       C(20),   ;

*-- Linhas 1997 a 2015:
1997:             .FontSize   = 8
1998:             .GridLines  = 0
1999:             .RecordMark = .F.
2000:             .DeleteMark = .F.
2001:             .ReadOnly   = .T.
2002:         ENDWITH
2003:         loc_oGrd.ColumnCount = 11
2004: 
2005:         *----------------------------------------------------------------------
2006:         * Column11 (col_selec no legado): coluna de MARCACAO da linha.
2007:         * Legado: ColumnOrder = 1 (primeira na tela), Width = 22, Movable = .F.,
2008:         * ReadOnly = .F., Sparse = .F., Header1 com Picture CHECKBX.BMP.
2009:         * O CheckBox precisa de AddObject + CurrentControl para APARECER
2010:         * (a Column nasce so com Header1/Text1).
2011:         *----------------------------------------------------------------------
2012:         loc_oGrd.Column11.AddObject("chk_4c_Selec", "CheckBox")
2013:         WITH loc_oGrd.Column11.chk_4c_Selec
2014:             .Top       = 23
2015:             .Left      = 4

*-- Linhas 2036 a 2164:
2036:         *-- Column1: Datas (Data)
2037:         WITH loc_oGrd.Column1
2038:             .Header1.Caption = "Data"
2039:             .ControlSource   = "CrSigMvCcr.Datas"
2040:             .Width           = 72
2041:             .Alignment       = 0
2042:             .Text1.FontName  = "Tahoma"
2043:             .Text1.FontSize  = 8
2044:         ENDWITH
2045: 
2046:         *-- Column2: Hists (Historico)
2047:         WITH loc_oGrd.Column2
2048:             .Header1.Caption = "Hist" + CHR(243) + "rico"
2049:             .ControlSource   = "CrSigMvCcr.Hists"
2050:             .Width           = 240
2051:             .Alignment       = 0
2052:             .Text1.FontName  = "Tahoma"
2053:             .Text1.FontSize  = 8
2054:         ENDWITH
2055: 
2056:         *-- Column3: Valors (Valor)
2057:         WITH loc_oGrd.Column3
2058:             .Header1.Caption = "Valor"
2059:             .ControlSource   = "CrSigMvCcr.Valors"
2060:             .Width           = 90
2061:             .Alignment       = 1
2062:             .Text1.FontName  = "Tahoma"
2063:             .Text1.FontSize  = 8
2064:         ENDWITH
2065: 
2066:         *-- Column4: Opers (Mov)
2067:         WITH loc_oGrd.Column4
2068:             .Header1.Caption = "Mov"
2069:             .ControlSource   = "CrSigMvCcr.Opers"
2070:             .Width           = 40
2071:             .Alignment       = 2
2072:             .Text1.FontName  = "Tahoma"
2073:             .Text1.FontSize  = 8
2074:         ENDWITH
2075: 
2076:         *-- Column5: Emps (Emp)
2077:         WITH loc_oGrd.Column5
2078:             .Header1.Caption = "Emp"
2079:             .ControlSource   = "CrSigMvCcr.Emps"
2080:             .Width           = 40
2081:             .Alignment       = 2
2082:             .Text1.FontName  = "Tahoma"
2083:             .Text1.FontSize  = 8
2084:         ENDWITH
2085: 
2086:         *-- Column6: Saldos (Saldo)
2087:         WITH loc_oGrd.Column6
2088:             .Header1.Caption = "Saldo"
2089:             .ControlSource   = "CrSigMvCcr.Saldos"
2090:             .Width           = 90
2091:             .Alignment       = 1
2092:             .Text1.FontName  = "Tahoma"
2093:             .Text1.FontSize  = 8
2094:         ENDWITH
2095: 
2096:         *-- Column7: Docus (Documento)
2097:         WITH loc_oGrd.Column7
2098:             .Header1.Caption = "Documento"
2099:             .ControlSource   = "CrSigMvCcr.Docus"
2100:             .Width           = 110
2101:             .Alignment       = 0
2102:             .Text1.FontName  = "Tahoma"
2103:             .Text1.FontSize  = 8
2104:         ENDWITH
2105: 
2106:         *-- Column8: NFs (Nota)
2107:         WITH loc_oGrd.Column8
2108:             .Header1.Caption = "Nota"
2109:             .ControlSource   = "CrSigMvCcr.NFs"
2110:             .Width           = 80
2111:             .Alignment       = 0
2112:             .Text1.FontName  = "Tahoma"
2113:             .Text1.FontSize  = 8
2114:         ENDWITH
2115: 
2116:         *-- Column9: Titulos (Titulo)
2117:         WITH loc_oGrd.Column9
2118:             .Header1.Caption = "T" + CHR(237) + "tulo"
2119:             .ControlSource   = "CrSigMvCcr.Titulos"
2120:             .Width           = 115
2121:             .Alignment       = 0
2122:             .Text1.FontName  = "Tahoma"
2123:             .Text1.FontSize  = 8
2124:         ENDWITH
2125: 
2126:         *-- Column10: Tipo (T)
2127:         WITH loc_oGrd.Column10
2128:             .Header1.Caption = "T"
2129:             .ControlSource   = "CrSigMvCcr.Tipo"
2130:             .Width           = 40
2131:             .Alignment       = 2
2132:             .Text1.FontName  = "Tahoma"
2133:             .Text1.FontSize  = 8
2134:         ENDWITH
2135: 
2136:         *-- RecordSource APOS configurar todas as colunas
2137:         loc_oGrd.RecordSource = "CrSigMvCcr"
2138: 
2139:         *-- Reconfirmar TODOS ControlSources apos RecordSource (auto-bind pode reordenar)
2140:         loc_oGrd.Column1.ControlSource  = "CrSigMvCcr.Datas"
2141:         loc_oGrd.Column2.ControlSource  = "CrSigMvCcr.Hists"
2142:         loc_oGrd.Column3.ControlSource  = "CrSigMvCcr.Valors"
2143:         loc_oGrd.Column4.ControlSource  = "CrSigMvCcr.Opers"
2144:         loc_oGrd.Column5.ControlSource  = "CrSigMvCcr.Emps"
2145:         loc_oGrd.Column6.ControlSource  = "CrSigMvCcr.Saldos"
2146:         loc_oGrd.Column7.ControlSource  = "CrSigMvCcr.Docus"
2147:         loc_oGrd.Column8.ControlSource  = "CrSigMvCcr.NFs"
2148:         loc_oGrd.Column9.ControlSource  = "CrSigMvCcr.Titulos"
2149:         loc_oGrd.Column10.ControlSource = "CrSigMvCcr.Tipo"
2150:         THIS.RestaurarColunaSelecao(loc_oGrd)
2151: 
2152:         *-- BINDEVENT: AfterRowColChange + KeyPress em todas as 10 colunas
2153:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdLancamentoAfterRowColChange")
2154:         BINDEVENT(loc_oGrd.Column1.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2155:         BINDEVENT(loc_oGrd.Column2.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2156:         BINDEVENT(loc_oGrd.Column3.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2157:         BINDEVENT(loc_oGrd.Column4.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2158:         BINDEVENT(loc_oGrd.Column5.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2159:         BINDEVENT(loc_oGrd.Column6.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2160:         BINDEVENT(loc_oGrd.Column7.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2161:         BINDEVENT(loc_oGrd.Column8.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2162:         BINDEVENT(loc_oGrd.Column9.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
2163:         BINDEVENT(loc_oGrd.Column10.Text1, "KeyPress", THIS, "GrdLancamentoKeyPress")
2164: 

*-- Linhas 2696 a 2741:
2696: 
2697:             *-- grade (grid): top=34, left=13, width=469, height=180, columnCount=6
2698:             SET NULL ON
2699:             CREATE CURSOR cursor_4c_Baixas ;
2700:                 (Emps C(3) NULL, Dopes C(20) NULL, Numes C(6) NULL, ;
2701:                  Valos N(12,2) NULL, Moedas C(3) NULL, Datarcs D NULL)
2702:             SET NULL OFF
2703: 
2704:             loc_oCnt.AddObject("grd_4c_Grade", "Grid")
2705:             loc_oGrd = loc_oCnt.grd_4c_Grade
2706:             WITH loc_oGrd
2707:                 .Top      = 34
2708:                 .Left     = 13
2709:                 .Width    = 469
2710:                 .Height   = 180
2711:                 .ReadOnly = .T.
2712:                 .FontName = "Tahoma"
2713:                 .FontSize = 8
2714:                 .RecordMark   = .F.
2715:                 .DeleteMark   = .F.
2716:             ENDWITH
2717:             loc_oGrd.ColumnCount  = 6
2718:             loc_oGrd.RecordSource = "cursor_4c_Baixas"
2719: 
2720:             *-- Reconfigurar ControlSources e Headers apos RecordSource
2721:             loc_oGrd.Column1.ControlSource   = "cursor_4c_Baixas.Emps"
2722:             loc_oGrd.Column2.ControlSource   = "cursor_4c_Baixas.Dopes"
2723:             loc_oGrd.Column3.ControlSource   = "cursor_4c_Baixas.Numes"
2724:             loc_oGrd.Column4.ControlSource   = "cursor_4c_Baixas.Valos"
2725:             loc_oGrd.Column5.ControlSource   = "cursor_4c_Baixas.Moedas"
2726:             loc_oGrd.Column6.ControlSource   = "cursor_4c_Baixas.Datarcs"
2727:             loc_oGrd.Column1.Header1.Caption = "Emp"
2728:             loc_oGrd.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2729:             loc_oGrd.Column3.Header1.Caption = "C" + CHR(243) + "digo"
2730:             loc_oGrd.Column4.Header1.Caption = "Valor"
2731:             loc_oGrd.Column5.Header1.Caption = "Moe"
2732:             loc_oGrd.Column6.Header1.Caption = "Data"
2733:             loc_oGrd.Column1.Width = 35
2734:             loc_oGrd.Column2.Width = 120
2735:             loc_oGrd.Column3.Width = 60
2736:             loc_oGrd.Column4.Width = 80
2737:             loc_oGrd.Column5.Width = 35
2738:             loc_oGrd.Column6.Width = 70
2739: 
2740:             *-- cmd_grupo (Voltar): top=214, left=432, width=50, height=50, buttonCount=1
2741:             loc_oCnt.AddObject("obj_4c_QuitasVoltar", "CommandGroup")

*-- Linhas 2857 a 2940:
2857: 
2858:             IF EMPTY(TRIM(par_cGrupo))
2859:                 *-- Sem grupo selecionado: apenas zerar grid
2860:                 SELECT cursor_4c_Saldos
2861:                 ZAP
2862:             ELSE
2863:                 *-- Montar query SQL identica ao MontaGrade original
2864:                 loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
2865:                            "a.Saldos, b.RClis, b.Situas, b.Cpfs, " + ;
2866:                            "b.ContaMats, ' ' AS Matriz " + ;
2867:                            "FROM SigMvSlc a, SigCdCli b " + ;
2868:                            "WHERE a.Grupos = " + EscaparSQL(TRIM(par_cGrupo)) + ;
2869:                            " AND a.Contas = b.IClis " + ;
2870:                            "ORDER BY a.Contas, a.Moedas"
2871: 
2872:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldosTemp") >= 1
2873:                     SELECT cursor_4c_Saldos
2874:                     ZAP
2875:                     APPEND FROM DBF("cursor_4c_SaldosTemp")
2876: 
2877:                     IF USED("cursor_4c_SaldosTemp")
2878:                         USE IN cursor_4c_SaldosTemp
2879:                     ENDIF
2880: 
2881:                     *-- Marcar matriz/filial. Transcrito do MontaGrade legado:
2882:                     *-- "Update CrSigMvSlc Set Matriz = Iif(Empty(ContaMats),
2883:                     *--  '', Iif(Contas = ContaMats, 'M', 'F'))".
2884:                     *-- O SELECT traz Matriz como ' ' constante; sem este
2885:                     *-- UPDATE a coluna "M/F" fica sempre em branco, o
2886:                     *-- DynamicBackColor nunca pinta verde/amarelo e o ramo
2887:                     *-- matriz/filial de ExecutarConsultaSaldo (que le
2888:                     *-- cursor_4c_Saldos.Matriz) nunca executa.
2889:                     *-- NVL obrigatorio: o cursor nasce NULL-enabled (SET NULL
2890:                     *-- ON no CREATE CURSOR) e EMPTY(.NULL.) devolve .F. - sem
2891:                     *-- NVL uma ContaMats nula seria classificada como filial.
2892:                     UPDATE cursor_4c_Saldos ;
2893:                         SET Matriz = IIF(EMPTY(NVL(ContaMats, "")), "", ;
2894:                                          IIF(NVL(Contas, "") = NVL(ContaMats, ""), "M", "F"))
2895: 
2896:                     *-- Aplicar filtro do optFiltro
2897:                     SELECT cursor_4c_Saldos
2898:                     DO CASE
2899:                         CASE loc_nFiltro = 2
2900:                             SET FILTER TO Saldos > 0
2901:                         CASE loc_nFiltro = 3
2902:                             SET FILTER TO Saldos < 0
2903:                         OTHERWISE
2904:                             SET FILTER TO
2905:                     ENDCASE
2906:                     GO TOP
2907:                 ELSE
2908:                     MsgErro("Erro ao carregar saldos. Verifique a conex" + ;
2909:                             CHR(227) + "o.", "Erro")
2910:                 ENDIF
2911:             ENDIF
2912: 
2913:             *-- Reconfigurar RecordSource apos recarga
2914:             loc_oGrd.ColumnCount = 7
2915:             loc_oGrd.RecordSource = "cursor_4c_Saldos"
2916: 
2917:             *-- Reconfigurar ControlSources (RecordSource os redefine).
2918:             *-- Column7 = Matriz, como no MontaGrade legado - NAO Situas.
2919:             loc_oGrd.Column1.ControlSource = "cursor_4c_Saldos.Contas"
2920:             loc_oGrd.Column2.ControlSource = "cursor_4c_Saldos.Rclis"
2921:             loc_oGrd.Column3.ControlSource = "cursor_4c_Saldos.Moedas"
2922:             loc_oGrd.Column4.ControlSource = "cursor_4c_Saldos.Saldos"
2923:             loc_oGrd.Column5.ControlSource = "cursor_4c_Saldos.Emps"
2924:             loc_oGrd.Column6.ControlSource = "cursor_4c_Saldos.Cpfs"
2925:             loc_oGrd.Column7.ControlSource = "cursor_4c_Saldos.Matriz"
2926: 
2927:             *-- Reconfigurar Width e ColumnOrder (RecordSource recalcula as
2928:             *-- larguras para o default 90 - regra #41 / Problema 48). Valores
2929:             *-- do dump legado: larguras 100/433/43/140/41/136/28 e
2930:             *-- ColumnOrder 1/2/5/4/6/3/7.
2931:             loc_oGrd.Column1.ColumnOrder = 1
2932:             loc_oGrd.Column1.Width       = 100
2933:             loc_oGrd.Column2.ColumnOrder = 2
2934:             loc_oGrd.Column2.Width       = 433
2935:             loc_oGrd.Column3.ColumnOrder = 5
2936:             loc_oGrd.Column3.Width       = 43
2937:             loc_oGrd.Column4.ColumnOrder = 4
2938:             loc_oGrd.Column4.Width       = 140
2939:             loc_oGrd.Column5.ColumnOrder = 6
2940:             loc_oGrd.Column5.Width       = 41

*-- Linhas 2959 a 2977:
2959:                 "IIF(cursor_4c_Saldos.Matriz = 'F', RGB(245,251,136), " + ;
2960:                 "RGB(255,255,255)))", "Column")
2961: 
2962:             SELECT cursor_4c_Saldos
2963:             GO TOP
2964:             loc_oGrd.Refresh()
2965:             loc_lSucesso = .T.
2966: 
2967:         CATCH TO loc_oErro
2968:             MsgErro(loc_oErro.Message, "Erro em MontaGrade")
2969:         ENDTRY
2970: 
2971:         RETURN loc_lSucesso
2972:     ENDPROC
2973: 
2974:     *==========================================================================
2975:     * PROCEDURE ProcessaSaldo
2976:     * Gera relatorio de saldos de conta corrente.
2977:     * par_cTipo: 'E'=Excel, 'I'=Impressora, 'V'=Video (preview)

*-- Linhas 3012 a 3064:
3012:             loc_oCnt.Refresh()
3013: 
3014:             *-- Montar SQL para relatorio
3015:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
3016:                        "a.Saldos, b.RClis, b.Situas, b.Cpfs, b.ContaMats " + ;
3017:                        "FROM SigMvSlc a, SigCdCli b " + ;
3018:                        "WHERE a.Grupos = " + EscaparSQL(THIS.this_cGrupoOper) + ;
3019:                        " AND a.Contas = b.IClis"
3020: 
3021:             IF !EMPTY(loc_cMoeda)
3022:                 loc_cSQL = loc_cSQL + " AND a.Moedas = " + EscaparSQL(loc_cMoeda)
3023:             ENDIF
3024: 
3025:             IF !EMPTY(loc_cSitua)
3026:                 loc_cSQL = loc_cSQL + " AND b.Situas = " + EscaparSQL(loc_cSitua)
3027:             ENDIF
3028: 
3029:             IF !loc_lSaldoZero
3030:                 loc_cSQL = loc_cSQL + " AND a.Saldos <> 0"
3031:             ENDIF
3032: 
3033:             DO CASE
3034:                 CASE loc_nOrdem = 1
3035:                     loc_cSQL = loc_cSQL + " ORDER BY a.Contas" + IIF(loc_lAscen, " ASC", " DESC")
3036:                 CASE loc_nOrdem = 2
3037:                     loc_cSQL = loc_cSQL + " ORDER BY a.Moedas" + IIF(loc_lAscen, " ASC", " DESC")
3038:                 CASE loc_nOrdem = 3
3039:                     loc_cSQL = loc_cSQL + " ORDER BY a.Saldos" + IIF(loc_lAscen, " ASC", " DESC")
3040:                 OTHERWISE
3041:                     loc_cSQL = loc_cSQL + " ORDER BY a.Contas ASC"
3042:             ENDCASE
3043: 
3044:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelSaldos") >= 1
3045:                 DO CASE
3046:                     CASE par_cTipo = "E"
3047:                         *-- Exportar para Excel
3048:                         loc_cArqXls = gc_4c_CaminhoBase + "relatorio_saldos.xls"
3049:                         SELECT cursor_4c_RelSaldos
3050:                         COPY TO (loc_cArqXls) TYPE XL5
3051:                         MsgInfo("Arquivo Excel gerado: " + loc_cArqXls, "Excel")
3052:                     CASE par_cTipo = "I" OR par_cTipo = "V"
3053:                         *-- Relatorio visual ou impressao
3054:                         loc_cImprime = IIF(par_cTipo = "I", "TO PRINT PROMPT", "PREVIEW")
3055:                         REPORT FORM (gc_4c_CaminhoReports + "RelSaldos.frx") &loc_cImprime
3056:                     OTHERWISE
3057:                         *-- Nada
3058:                 ENDCASE
3059: 
3060:                 IF USED("cursor_4c_RelSaldos")
3061:                     USE IN cursor_4c_RelSaldos
3062:                 ENDIF
3063:             ELSE
3064:                 MsgErro("Erro ao gerar relat" + CHR(243) + "rio de saldos.", "Erro")

*-- Linhas 3122 a 3140:
3122:             RETURN
3123:         ENDIF
3124: 
3125:         SELECT cursor_4c_Saldos
3126:         IF EOF()
3127:             GO TOP
3128:         ENDIF
3129: 
3130:         loc_cCliente = TRIM(cursor_4c_Saldos.Contas)
3131:         loc_cGrupo   = TRIM(cursor_4c_Saldos.Grupos)
3132:         loc_cMoeda   = TRIM(cursor_4c_Saldos.Moedas)
3133: 
3134:         IF EMPTY(loc_cCliente)
3135:             MsgAviso("Nenhuma Conta/Saldo foi escolhida para consulta!", ;
3136:                      "Aten" + CHR(231) + CHR(227) + "o")
3137:             RETURN
3138:         ENDIF
3139: 
3140:         THIS.this_cCliente   = loc_cCliente

*-- Linhas 3173 a 3384:
3173: 
3174:         *-- Criar cursor de matrizes (grupo/conta/moeda a processar)
3175:         SET NULL ON
3176:         CREATE CURSOR cursor_4c_Matrizes (Grupos C(10), Contas C(10), Moedas C(3))
3177:         SET NULL OFF
3178:         INSERT INTO cursor_4c_Matrizes (Grupos, Contas, Moedas) ;
3179:             VALUES (loc_cGrupo, loc_cCliente, loc_cMoeda)
3180: 
3181:         *-- Verificar se a conta pertence a grupo de cobranca (Matriz/Filial)
3182:         loc_lMatrizes = .F.
3183:         IF TRIM(cursor_4c_Saldos.Matriz) # " " AND !EMPTY(cursor_4c_Saldos.Matriz)
3184:             loc_lMatrizes = MsgConfirma( ;
3185:                 "Esta Conta Pertence a Um Grupo de Cobran" + CHR(231) + "a." + CHR(13) + ;
3186:                 "Deseja Processar Todas Contas do Grupo?", ;
3187:                 "Empresa " + IIF(cursor_4c_Saldos.Matriz = "M", "Matriz", "Filial"))
3188:         ENDIF
3189:         THIS.this_lMatrizes = loc_lMatrizes
3190: 
3191:         IF loc_lMatrizes
3192:             IF cursor_4c_Saldos.Matriz = "M"
3193:                 loc_cSQL = "SELECT IClis, Grupos FROM SigCdCli " + ;
3194:                            "WHERE ContaMats = " + EscaparSQL(loc_cCliente) + ;
3195:                            " AND IClis <> " + EscaparSQL(loc_cCliente)
3196:             ELSE
3197:                 loc_cSQL = "SELECT IClis, Grupos FROM SigCdCli " + ;
3198:                            "WHERE ContaMats = " + EscaparSQL(TRIM(cursor_4c_Saldos.ContaMats)) + ;
3199:                            " AND IClis <> " + EscaparSQL(loc_cCliente)
3200:             ENDIF
3201: 
3202:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMat") < 1
3203:                 MsgErro("Favor Reinicializar o Processo!", "Falha na Conex" + CHR(227) + "o (TmpMat)")
3204:                 RETURN
3205:             ENDIF
3206:             SELECT cursor_4c_TmpMat
3207:             SCAN
3208:                 INSERT INTO cursor_4c_Matrizes (Grupos, Contas, Moedas) ;
3209:                     VALUES (cursor_4c_TmpMat.Grupos, cursor_4c_TmpMat.IClis, loc_cMoeda)
3210:             ENDSCAN
3211:             IF USED("cursor_4c_TmpMat")
3212:                 USE IN cursor_4c_TmpMat
3213:             ENDIF
3214:         ENDIF
3215: 
3216:         *-- Criar cursor base vazio com estrutura de SigMvCcr + campos extras
3217:         loc_cSQL = "SELECT ' ' AS Tipo, a.Saldos AS SaldosP, a.*, 0 AS Seleciona " + ;
3218:                    "FROM SigMvCcr a " + ;
3219:                    "WHERE 0 = 1"
3220: 
3221:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr") < 1
3222:             MsgErro("Favor Reinicializar o Processo!", ;
3223:                     "Falha na Conex" + CHR(227) + "o (TmpMccr)")
3224:             RETURN
3225:         ENDIF
3226: 
3227:         *-- Para cada conta/grupo/moeda, buscar lancamentos de SigMvCcr e SigMvCpv
3228:         SELECT cursor_4c_Matrizes
3229:         SCAN
3230:             loc_cGCM = cursor_4c_Matrizes.Grupos + ;
3231:                        cursor_4c_Matrizes.Contas + ;
3232:                        cursor_4c_Matrizes.Moedas
3233: 
3234:             *-- Lancamentos realizados (SigMvCcr)
3235:             loc_cSQL = "SELECT 'R' AS Tipo, a.Saldos AS SaldosP, a.*, 0 AS Seleciona " + ;
3236:                        "FROM SigMvCcr a " + ;
3237:                        "WHERE a.GruConMoes = " + EscaparSQL(loc_cGCM) + ;
3238:                        " AND a.Datas BETWEEN " + loc_cDataI + " AND " + loc_cDataF
3239: 
3240:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMcc1") < 1
3241:                 MsgErro("Favor Reinicializar o Processo!", ;
3242:                         "Falha na Conex" + CHR(227) + "o (TmpMcc1)")
3243:                 RETURN
3244:             ENDIF
3245: 
3246:             *-- Previsoes (SigMvCpv)
3247:             loc_cSQL = "SELECT 'P' AS Tipo, b.Saldos AS SaldosP, b.*, 0 AS Seleciona " + ;
3248:                        "FROM SigMvCpv b " + ;
3249:                        "WHERE b.GruConMoes = " + EscaparSQL(loc_cGCM) + ;
3250:                        " AND b.Datas BETWEEN " + loc_cDataI + " AND " + loc_cDataF
3251: 
3252:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMcpv") < 1
3253:                 MsgErro("Favor Reinicializar o Processo!", ;
3254:                         "Falha na Conex" + CHR(227) + "o (TmpMcpv)")
3255:                 RETURN
3256:             ENDIF
3257: 
3258:             *-- Inserir lancamentos realizados no cursor base
3259:             SELECT cursor_4c_TmpMcc1
3260:             SCAN
3261:                 SCATTER MEMVAR MEMO
3262:                 INSERT INTO cursor_4c_TmpMccr FROM MEMVAR
3263:             ENDSCAN
3264: 
3265:             *-- Inserir previsoes no cursor base
3266:             SELECT cursor_4c_TmpMcpv
3267:             SCAN
3268:                 SCATTER MEMVAR MEMO
3269:                 INSERT INTO cursor_4c_TmpMccr FROM MEMVAR
3270:             ENDSCAN
3271:         ENDSCAN
3272: 
3273:         *-- Limpar cursores temporarios
3274:         IF USED("cursor_4c_TmpMcc1")
3275:             USE IN cursor_4c_TmpMcc1
3276:         ENDIF
3277:         IF USED("cursor_4c_TmpMcpv")
3278:             USE IN cursor_4c_TmpMcpv
3279:         ENDIF
3280:         IF USED("cursor_4c_Matrizes")
3281:             USE IN cursor_4c_Matrizes
3282:         ENDIF
3283: 
3284:         *-- Ordenar e criar cursor final CrSigMvCcr com campo Prorrogados
3285:         GO TOP IN cursor_4c_TmpMccr
3286: 
3287:         SELECT *, .F. AS Prorrogados FROM cursor_4c_TmpMccr ;
3288:             INTO CURSOR cursor_4c_TmpOrdenado ;
3289:             ORDER BY Grupos, Contas, Moedas, Datas, Nopers
3290: 
3291:         SELECT cursor_4c_TmpOrdenado
3292:         USE DBF("cursor_4c_TmpOrdenado") IN 0 ALIAS CrSigMvCcr AGAIN
3293:         USE IN cursor_4c_TmpOrdenado
3294: 
3295:         USE IN cursor_4c_TmpMccr
3296: 
3297:         *-- Se Matrizes: consolidar contas e recalcular saldos
3298:         IF THIS.this_lMatrizes
3299:             LOCAL loc_cMat
3300:             loc_cMat = PADR(IIF(cursor_4c_Saldos.Matriz = "M", ;
3301:                                 loc_cCliente, ;
3302:                                 TRIM(cursor_4c_Saldos.ContaMats)), 10)
3303:             UPDATE CrSigMvCcr ;
3304:                 SET Contas = loc_cMat, ;
3305:                     GruConMoes = CrSigMvCcr.Grupos + loc_cMat + CrSigMvCcr.Moedas
3306:         ENDIF
3307: 
3308:         *-- Marcar titulos Prorrogados (verificar SigOpMvv)
3309:         SELECT CrSigMvCcr
3310:         SCAN
3311:             loc_cSQL = "SELECT * FROM SigOpMvv " + ;
3312:                        "WHERE EmpDopNcs = " + EscaparSQL(CrSigMvCcr.EmpDopNcs)
3313:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpMvv") < 1
3314:                 MsgErro("Favor Reinicializar o Processo!", ;
3315:                         "Falha na Conex" + CHR(227) + "o (LocalOpMvv)")
3316:                 RETURN
3317:             ENDIF
3318:             IF RECCOUNT("cursor_4c_LocalOpMvv") > 0
3319:                 REPLACE Prorrogados WITH .T. IN CrSigMvCcr
3320:             ENDIF
3321:         ENDSCAN
3322:         IF USED("cursor_4c_LocalOpMvv")
3323:             USE IN cursor_4c_LocalOpMvv
3324:         ENDIF
3325: 
3326:         *-- Criar indices para navegacao e filtros
3327:         SELECT CrSigMvCcr
3328:         INDEX ON Datas TAG Vencs
3329:         INDEX ON Valors TAG Valor
3330:         INDEX ON Hists TAG Historico
3331:         INDEX ON GruConMoes + DTOS(Datas) + CidChaves TAG GruConMoe FOR Tipo = "R"
3332:         INDEX ON GruConMoes + DTOS(DataConcs) + CidChaves TAG GruConMoec FOR Concs
3333:         INDEX ON GruConMoes + DTOS(Datas) + CidChaves TAG GruConMoen FOR !Concs
3334:         INDEX ON GruConMoes + DTOS(Datas) + CidChaves TAG GruConMoeP
3335:         SET ORDER TO GruConMoe
3336:         GO BOTTOM
3337: 
3338:         IF RECCOUNT() > 0
3339:             *-- Se Matrizes: recalcular saldos acumulados
3340:             IF THIS.this_lMatrizes
3341:                 SELECT CrSigMvCcr
3342:                 GO TOP
3343:                 loc_nSal = 0
3344:                 SCAN
3345:                     IF CrSigMvCcr.Opers = "D"
3346:                         loc_nSal = loc_nSal + ABS(CrSigMvCcr.Valors)
3347:                     ELSE
3348:                         loc_nSal = loc_nSal - ABS(CrSigMvCcr.Valors)
3349:                     ENDIF
3350:                     REPLACE Saldos WITH loc_nSal
3351:                 ENDSCAN
3352:             ENDIF
3353: 
3354:             *-- Configurar grd_4c_Lancamento com novo cursor
3355:             IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
3356:                 loc_oGrd = loc_oPagHist.grd_4c_Lancamento
3357:                 loc_oGrd.RecordSource = "CrSigMvCcr"
3358: 
3359:                 *-- Reconfirmar TODOS os ControlSources apos RecordSource
3360:                 loc_oGrd.Column1.ControlSource  = "CrSigMvCcr.Datas"
3361:                 loc_oGrd.Column2.ControlSource  = "CrSigMvCcr.Hists"
3362:                 loc_oGrd.Column3.ControlSource  = "CrSigMvCcr.Valors"
3363:                 loc_oGrd.Column4.ControlSource  = "CrSigMvCcr.Opers"
3364:                 loc_oGrd.Column5.ControlSource  = "CrSigMvCcr.Emps"
3365:                 loc_oGrd.Column6.ControlSource  = "CrSigMvCcr.Saldos"
3366:                 loc_oGrd.Column7.ControlSource  = "CrSigMvCcr.Docus"
3367:                 loc_oGrd.Column8.ControlSource  = "CrSigMvCcr.NFs"
3368:                 loc_oGrd.Column9.ControlSource  = "CrSigMvCcr.Titulos"
3369:                 loc_oGrd.Column10.ControlSource = "CrSigMvCcr.Tipo"
3370:                 THIS.RestaurarColunaSelecao(loc_oGrd)
3371: 
3372:                 *-- DynamicForeColor: Cancelado=Vermelho, Conciliado=Azul, Baixado=Verde, Prorrogado=Laranja, Normal=Preto
3373:                 LOCAL loc_i, loc_cForeExpr, loc_cBackExpr
3374:                 loc_cForeExpr = "IIF(CrSigMvCcr.TitCancs=1,RGB(255,0,0)," + ;
3375:                                 "IIF(CrSigMvCcr.Concs,RGB(0,0,255)," + ;
3376:                                 "IIF(CrSigMvCcr.Pagos='0',RGB(0,128,0)," + ;
3377:                                 "IIF(CrSigMvCcr.Prorrogados,RGB(255,128,0)," + ;
3378:                                 "RGB(0,0,0)))))"
3379:                 loc_cBackExpr = "IIF(CrSigMvCcr.Tipo='P',RGB(245,251,136)," + ;
3380:                                 "IIF(!EMPTY(CrSigMvCcr.DtAudits),RGB(220,255,220)," + ;
3381:                                 "RGB(255,255,255)))"
3382:                 FOR loc_i = 1 TO loc_oGrd.ColumnCount
3383:                     loc_oGrd.Columns(loc_i).DynamicForeColor = loc_cForeExpr
3384:                     loc_oGrd.Columns(loc_i).DynamicBackColor = loc_cBackExpr

*-- Linhas 3462 a 3480:
3462:         TRY
3463:             THIS.MontaGrade(TRIM(THIS.pgf_4c_1.Page1.txt_4c_Grupo.Value))
3464:             IF USED("cursor_4c_Saldos")
3465:                 SELECT cursor_4c_Saldos
3466:                 GO TOP
3467:             ENDIF
3468:             THIS.pgf_4c_1.Page1.grd_4c_Saldos.Refresh()
3469:         CATCH TO loc_oErro
3470:             MsgErro(loc_oErro.Message, "Erro em OptFiltroSaldoChange")
3471:         ENDTRY
3472:     ENDPROC
3473: 
3474:     *-- TxtGrupo KeyPress -> ENTER/TAB valida acesso ao grupo (fAcessoContab em
3475:     *   modo lookup, preenchendo Grupo/DGrupo) e carrega a grade.
3476:     *   Equivale ao Get_Grupo.Valid do legado (via KeyPress):
3477:     *     lcGrupo = Repli(Chr(255),10)
3478:     *     If !Empty(This.Value)
3479:     *         If fAcessoContab(Usuar,'C',This.Value,Get_Grupo,Get_DGrupo)
3480:     *             lcGrupo = This.Value

*-- Linhas 3546 a 3564:
3546:     PROCEDURE GrdSaldoAfterRowColChange(par_nColIndex)
3547:         TRY
3548:             IF USED("cursor_4c_Saldos") AND !EOF("cursor_4c_Saldos")
3549:                 SELECT cursor_4c_Saldos
3550:                 THIS.this_cCliente   = TRIM(cursor_4c_Saldos.Contas)
3551:                 THIS.this_cGrupoOper = TRIM(cursor_4c_Saldos.Grupos)
3552:             ENDIF
3553:         CATCH TO loc_oErro
3554:             MsgErro(loc_oErro.Message, "Erro em GrdSaldoAfterRowColChange")
3555:         ENDTRY
3556:     ENDPROC
3557: 
3558:     *==========================================================================
3559:     * Handlers - Container cntSaldo (relatorio de saldos)
3560:     *==========================================================================
3561: 
3562:     *-- TxtCdMoeda KeyPress -> lookup moeda pelo codigo
3563:     PROCEDURE TxtCdMoedaSaldoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3564:         LOCAL loc_oCnt, loc_cMoeda

*-- Linhas 3600 a 3618:
3600:                     loc_oBusca.Show()
3601:                 ENDIF
3602:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3603:                     SELECT cursor_4c_Busca
3604:                     GO TOP
3605:                     par_oCnt.txt_4c__cd_moeda.Value = TRIM(cursor_4c_Busca.cmoes)
3606:                     par_oCnt.txt_4c__ds_moeda.Value = TRIM(cursor_4c_Busca.dmoes)
3607:                 ENDIF
3608:                 IF USED("cursor_4c_Busca")
3609:                     USE IN cursor_4c_Busca
3610:                 ENDIF
3611:                 loc_oBusca.Release()
3612:             ENDIF
3613:         CATCH TO loc_oErro
3614:             MsgErro(loc_oErro.Message, "Erro em AbrirLookupMoedaSaldo")
3615:         ENDTRY
3616:     ENDPROC
3617: 
3618:     *-- TxtSituacao KeyPress -> lookup SigCdCst (Situacao de Conta)

*-- Linhas 3646 a 3664:
3646:                     loc_oBusca.Show()
3647:                 ENDIF
3648:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3649:                     SELECT cursor_4c_Busca
3650:                     GO TOP
3651:                     par_oCnt.txt_4c_Situa.Value = TRIM(cursor_4c_Busca.Codigos)
3652:                 ENDIF
3653:                 IF USED("cursor_4c_Busca")
3654:                     USE IN cursor_4c_Busca
3655:                 ENDIF
3656:                 loc_oBusca.Release()
3657:             ENDIF
3658:         CATCH TO loc_oErro
3659:             MsgErro(loc_oErro.Message, "Erro em AbrirLookupSituacao")
3660:         ENDTRY
3661:     ENDPROC
3662: 
3663:     *-- OptOrdem InteractiveChange -> habilitar/desabilitar chkAscendente
3664:     PROCEDURE OptOrdemSaldoChange()

*-- Linhas 3709 a 3739:
3709:             IF !EMPTY(loc_cConta) AND gnConnHandle > 0
3710:                 TRY
3711:                     *-- Verificar se conta existe no grupo
3712:                     loc_cSQL = "SELECT a.grupos, a.contas " + ;
3713:                                "FROM SigMvSlc a " + ;
3714:                                "WHERE a.grupos = " + EscaparSQL(THIS.this_cGrupoOper) + ;
3715:                                " AND a.Contas = " + EscaparSQL(loc_cConta)
3716: 
3717:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaTemp")
3718:                     IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_ContaTemp") > 0
3719:                         *-- Buscar descricao na tabela de clientes
3720:                         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
3721:                                    "WHERE IClis = " + EscaparSQL(loc_cConta)
3722:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliTemp") >= 1
3723:                             IF RECCOUNT("cursor_4c_CliTemp") > 0
3724:                                 SELECT cursor_4c_CliTemp
3725:                                 GO TOP
3726:                                 loc_oCnt.txt_4c__ds_conta.Value = TRIM(cursor_4c_CliTemp.RClis)
3727:                             ENDIF
3728:                             IF USED("cursor_4c_CliTemp")
3729:                                 USE IN cursor_4c_CliTemp
3730:                             ENDIF
3731:                         ENDIF
3732:                     ELSE
3733:                         MsgAviso("Acesso Negado...", "Aten" + CHR(231) + CHR(227) + "o")
3734:                         loc_oCnt.txt_4c_Cd_Conta.Value  = " "
3735:                         loc_oCnt.txt_4c__ds_conta.Value = ""
3736:                     ENDIF
3737:                     IF USED("cursor_4c_ContaTemp")
3738:                         USE IN cursor_4c_ContaTemp
3739:                     ENDIF

*-- Linhas 3756 a 3782:
3756: 
3757:             IF !EMPTY(loc_cDesc) AND gnConnHandle > 0
3758:                 TRY
3759:                     loc_cSQL = "SELECT a.grupos, a.contas, b.RClis " + ;
3760:                                "FROM SigMvSlc a, SigCdCli b " + ;
3761:                                "WHERE a.grupos = " + EscaparSQL(THIS.this_cGrupoOper) + ;
3762:                                " AND a.Contas = b.IClis " + ;
3763:                                " AND b.RClis LIKE " + EscaparSQL("%" + loc_cDesc + "%")
3764: 
3765:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DsContaTemp")
3766:                     IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_DsContaTemp") > 0
3767:                         SELECT cursor_4c_DsContaTemp
3768:                         GO TOP
3769:                         loc_oCnt.txt_4c_Cd_Conta.Value  = TRIM(cursor_4c_DsContaTemp.contas)
3770:                         loc_oCnt.txt_4c__ds_conta.Value = TRIM(cursor_4c_DsContaTemp.RClis)
3771:                     ELSE
3772:                         MsgAviso("Acesso Negado...", "Aten" + CHR(231) + CHR(227) + "o")
3773:                         loc_oCnt.txt_4c_Cd_Conta.Value  = ""
3774:                         loc_oCnt.txt_4c__ds_conta.Value = ""
3775:                     ENDIF
3776:                     IF USED("cursor_4c_DsContaTemp")
3777:                         USE IN cursor_4c_DsContaTemp
3778:                     ENDIF
3779:                 CATCH TO loc_oErro
3780:                     MsgErro(loc_oErro.Message, "Erro em TxtDsContaKeyPress")
3781:                 ENDTRY
3782:             ENDIF

*-- Linhas 3812 a 3830:
3812:         IF !EMPTY(loc_cConta)
3813:             *-- Posicionar cursor no registro da conta (botao OK)
3814:             IF USED("cursor_4c_Saldos")
3815:                 SELECT cursor_4c_Saldos
3816:                 LOCATE FOR TRIM(Contas) = loc_cConta
3817:             ENDIF
3818:         ENDIF
3819: 
3820:         THIS.FecharPainelConsultaSaldo()
3821:     ENDPROC
3822: 
3823:     *--------------------------------------------------------------------------
3824:     * FecharPainelConsultaSaldo - fecha o painel flutuante cntConsulta e
3825:     * devolve o estado da pagina SALDO (controles reabilitados + foco na
3826:     * grade). Corpo compartilhado pelos dois handlers do cmd_grupo do legado,
3827:     * que terminam exatamente nestas seis linhas.
3828:     *--------------------------------------------------------------------------
3829:     PROTECTED PROCEDURE FecharPainelConsultaSaldo()
3830:         LOCAL loc_oPag

*-- Linhas 3855 a 3877:
3855:                 pNoper = CrSigMvCcr.Nopers
3856: 
3857:                 *-- Requery CrAltcc: todas as pernas do lancamento
3858:                 loc_cSQL = "SELECT * FROM SigMvCcr WHERE Emps = " + EscaparSQL(pEmp) + ;
3859:                            " AND Nopers = " + STR(pNoper)
3860:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Altcc") >= 1
3861:                     *-- Verificar acesso contabil e a conta
3862:                     SELECT cursor_4c_Altcc
3863:                     GO TOP
3864:                     IF fAcessoContab(gc_4c_UsuarioLogado, "C", cursor_4c_Altcc.SGrupos)
3865:                         IF USED("cursor_4c_Saldos") AND ;
3866:                            fAcessoContas(gc_4c_UsuarioLogado, ;
3867:                                          TRIM(cursor_4c_Saldos.Grupos), "C", ;
3868:                                          TRIM(cursor_4c_Saldos.Contas))
3869:                             loc_lOk = .T.
3870:                         ELSE
3871:                             IF USED("cursor_4c_Saldos")
3872:                                 MsgAviso("Acesso a conta Negado...", "")
3873:                             ENDIF
3874:                         ENDIF
3875:                     ELSE
3876:                         MsgAviso("Acesso ao Grupo Negado...", "")
3877:                     ENDIF

*-- Linhas 3883 a 3907:
3883: 
3884:             IF loc_lOk
3885:                 *-- Abrir form de visualizacao
3886:                 SELECT cursor_4c_Altcc
3887:                 GO TOP
3888:                 SCATTER MEMVAR MEMO
3889:                 DO FORM SigOpAcc WITH THIS, "CONSULTAR"
3890: 
3891:                 *-- Refresh grade apos retorno
3892:                 SELECT CrSigMvCcr
3893:                 loc_oPagHist = THIS.pgf_4c_1.Page2
3894:                 IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
3895:                     loc_oPagHist.grd_4c_Lancamento.Refresh()
3896:                     loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
3897:                 ENDIF
3898:             ENDIF
3899:         CATCH TO loc_oErro
3900:             MsgErro(loc_oErro.Message, "Erro em BtnConsultaHistClick")
3901:         ENDTRY
3902:     ENDPROC
3903: 
3904:     *-- Cmd_Alterar Click -> validar todas as regras e abrir SigOpAcc em modo ALTERAR
3905:     PROCEDURE BtnAlterarHistClick()
3906:         LOCAL loc_oErro, loc_oPagHist, loc_cSQL, loc_lSaida, loc_cComple
3907:         LOCAL loc_nTpAltera, loc_lOkDt, loc_lProsseguir

*-- Linhas 3913 a 3951:
3913: 
3914:             IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
3915:                 THIS.DesabContainer()
3916:                 SELECT CrSigMvCcr
3917: 
3918:                 IF !EOF()
3919:                     pEmp   = CrSigMvCcr.Emps
3920:                     pNoper = CrSigMvCcr.Nopers
3921: 
3922:                     *-- Requery CrAltcc: todas as pernas do lancamento
3923:                     loc_cSQL = "SELECT * FROM SigMvCcr WHERE Emps = " + EscaparSQL(pEmp) + ;
3924:                                " AND Nopers = " + STR(pNoper)
3925:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Altcc") >= 1
3926:                         loc_lProsseguir = .T.
3927:                     ELSE
3928:                         MsgErro("Favor Reinicializar o Processo!", ;
3929:                                 "Falha na Conex" + CHR(227) + "o (CrAltcc)")
3930:                     ENDIF
3931:                 ENDIF
3932:             ENDIF
3933: 
3934:             *-- Validar TODAS as pernas do lancamento
3935:             IF loc_lProsseguir
3936:                 SELECT cursor_4c_Altcc
3937:                 GO TOP
3938:                 DO WHILE !EOF() AND !loc_lSaida
3939:                     IF cursor_4c_Altcc.Opers # CrSigMvCcr.Opers
3940:                         loc_cComple = "( Contra Partida )"
3941:                     ELSE
3942:                         loc_cComple = " "
3943:                     ENDIF
3944: 
3945:                     IF cursor_4c_Altcc.Autos
3946:                         MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
3947:                                  "lida !! Movimenta" + CHR(231) + CHR(227) + ;
3948:                                  "o Autom" + CHR(225) + "tica !" + loc_cComple, "")
3949:                         loc_lSaida = .T.
3950:                     ENDIF
3951:                     IF cursor_4c_Altcc.Concs AND !loc_lSaida

*-- Linhas 3979 a 4061:
3979:                                  "o Auditada!", "")
3980:                         loc_lSaida = .T.
3981:                     ENDIF
3982:                     SELECT cursor_4c_Altcc
3983:                     SKIP
3984:                 ENDDO
3985: 
3986:                 *-- Verificar se contra-partida ja foi baixada -> altera parcial
3987:                 SELECT cursor_4c_Altcc
3988:                 GO TOP
3989:                 SKIP
3990:                 IF !EOF() AND cursor_4c_Altcc.ContaPgs = 1 AND cursor_4c_Altcc.ValPags # 0
3991:                     loc_nTpAltera = 1
3992:                 ENDIF
3993: 
3994:                 IF !loc_lSaida
3995:                     SELECT cursor_4c_Altcc
3996:                     GO TOP
3997:                     SCATTER MEMVAR MEMO
3998:                     DO FORM SigOpAcc WITH THIS, "ALTERAR", loc_nTpAltera
3999:                     THIS.CmbConciliaHistChange()
4000:                 ENDIF
4001: 
4002:                 SELECT CrSigMvCcr
4003:                 LOCATE FOR Nopers = pNoper
4004:                 loc_oPagHist = THIS.pgf_4c_1.Page2
4005:                 IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
4006:                     loc_oPagHist.grd_4c_Lancamento.Refresh()
4007:                     loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
4008:                 ENDIF
4009:             ENDIF
4010:         CATCH TO loc_oErro
4011:             MsgErro(loc_oErro.Message, "Erro em BtnAlterarHistClick")
4012:         ENDTRY
4013:     ENDPROC
4014: 
4015:     *-- Cmd_Excluir Click -> validar todas as regras e abrir SigOpAcc em modo EXCLUIR
4016:     PROCEDURE BtnExcluirHistClick()
4017:         LOCAL loc_oErro, loc_oPagHist, loc_cSQL, loc_lOk, loc_cComple, loc_lOkDt
4018:         LOCAL loc_lProsseguir
4019:         PRIVATE pEmp, pNoper
4020:         TRY
4021:             loc_lProsseguir = .F.
4022:             loc_lOk = .T.
4023: 
4024:             IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
4025:                 SELECT CrSigMvCcr
4026:                 THIS.DesabContainer()
4027: 
4028:                 IF !EOF()
4029:                     pEmp   = CrSigMvCcr.Emps
4030:                     pNoper = CrSigMvCcr.Nopers
4031: 
4032:                     *-- Requery CrAltcc: todas as pernas do lancamento
4033:                     loc_cSQL = "SELECT * FROM SigMvCcr WHERE Emps = " + EscaparSQL(pEmp) + ;
4034:                                " AND Nopers = " + STR(pNoper)
4035:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Altcc") >= 1
4036:                         loc_lProsseguir = .T.
4037:                     ELSE
4038:                         MsgErro("Favor Reinicializar o Processo!", ;
4039:                                 "Falha na Conex" + CHR(227) + "o (CrAltcc)")
4040:                     ENDIF
4041:                 ENDIF
4042:             ENDIF
4043: 
4044:             *-- Validar TODAS as pernas
4045:             IF loc_lProsseguir
4046:                 SELECT cursor_4c_Altcc
4047:                 GO TOP
4048:                 DO WHILE !EOF() AND loc_lOk
4049:                     IF cursor_4c_Altcc.Opers # CrSigMvCcr.Opers
4050:                         loc_cComple = "( Contra Partida )"
4051:                     ELSE
4052:                         loc_cComple = " "
4053:                     ENDIF
4054: 
4055:                     loc_lOkDt = fVerificaBloqueio(cursor_4c_Altcc.Datas, gnConnHandle) <= 0
4056:                     IF !loc_lOkDt
4057:                         MsgAviso("Periodo Bloqueado!", "")
4058:                         loc_lOk = .F.
4059:                     ENDIF
4060:                     IF cursor_4c_Altcc.Autos AND loc_lOk
4061:                         MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;

*-- Linhas 4089 a 4119:
4089:                                  "o Auditada!", "")
4090:                         loc_lOk = .F.
4091:                     ENDIF
4092:                     SELECT cursor_4c_Altcc
4093:                     SKIP
4094:                 ENDDO
4095: 
4096:                 SELECT cursor_4c_Altcc
4097:                 GO TOP
4098:                 IF loc_lOk AND !EOF()
4099:                     SCATTER MEMVAR MEMO
4100:                     DO FORM SigOpAcc WITH THIS, "EXCLUIR"
4101:                     THIS.CmbConciliaHistChange()
4102:                 ENDIF
4103: 
4104:                 SELECT CrSigMvCcr
4105:                 LOCATE FOR Nopers = pNoper
4106:                 loc_oPagHist = THIS.pgf_4c_1.Page2
4107:                 IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
4108:                     loc_oPagHist.grd_4c_Lancamento.Refresh()
4109:                     loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
4110:                 ENDIF
4111:             ENDIF
4112:         CATCH TO loc_oErro
4113:             MsgErro(loc_oErro.Message, "Erro em BtnExcluirHistClick")
4114:         ENDTRY
4115:     ENDPROC
4116: 
4117:     *-- cmd_impressao Click -> configurar e exibir cnt_4c_Imprime
4118:     PROCEDURE BtnImpressaoHistClick()
4119:         LOCAL loc_oErro, loc_oPagHist, loc_oCnt

*-- Linhas 4194 a 4330:
4194:                 loc_nVope  = VAL(PADL(ALLTRIM(SUBSTR(CrSigMvCcr.VOpers, 4)), 7))
4195: 
4196:                 *-- Buscar operacao para determinar tipo de documento
4197:                 loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(lcDopc)
4198:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpOpe") >= 1
4199:                     SELECT CrSigMvCcr
4200:                     IF !EOF()
4201:                         loc_lProsseguir = .T.
4202:                     ENDIF
4203:                 ELSE
4204:                     MsgErro("Favor Reinicializar o Processo!", ;
4205:                             "Falha na Conex" + CHR(227) + "o (SigOpOpe)")
4206:                 ENDIF
4207:             ENDIF
4208: 
4209:             *-- Determinar qual form abrir baseado nos registros vinculados
4210:             LOCAL loc_lEncontrou
4211:             loc_lEncontrou = .F.
4212: 
4213:             IF loc_lProsseguir
4214: 
4215:             *-- 1) Verificar SigCdPgr (programacao)
4216:             loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigCdPgr " + ;
4217:                        "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
4218:                        " AND Dopes = " + EscaparSQL(loc_cDope) + ;
4219:                        " AND Numes = " + STR(loc_nNume)
4220:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
4221:                 IF RECCOUNT("cursor_4c_ChkReg") > 0
4222:                     DO FORM SigCdPgr WITH LEFT(CrSigMvCcr.Dopes, 1), .T., ;
4223:                         CrSigMvCcr.Emps, CrSigMvCcr.Dopes, CrSigMvCcr.Numes
4224:                     loc_lEncontrou = .T.
4225:                 ENDIF
4226:             ENDIF
4227: 
4228:             *-- 2) Verificar SigMvCab (movimentacao de estoque)
4229:             IF !loc_lEncontrou
4230:                 loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigMvCab " + ;
4231:                            "WHERE EmpDopNums = " + ;
4232:                            EscaparSQL(loc_cEmpr + loc_cDope + STR(loc_nNume, 6))
4233:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
4234:                     IF RECCOUNT("cursor_4c_ChkReg") > 0
4235:                         IF fChecaAcesso("SIGOPIND", "ALTMOV")
4236:                             DO FORM SigMvCab WITH CrSigMvCcr.Dopes, CrSigMvCcr.Numes, ;
4237:                                 CrSigMvCcr.Emps, .T., 3, THIS
4238:                         ELSE
4239:                             DO FORM SigMvExp WITH CrSigMvCcr.Dopes, "C", ;
4240:                                 CrSigMvCcr.Numes, CrSigMvCcr.Emps, .T.
4241:                         ENDIF
4242:                         loc_lEncontrou = .T.
4243:                     ENDIF
4244:                 ENDIF
4245:             ENDIF
4246: 
4247:             *-- 3) Verificar titulo de pagamento (SigPgTit)
4248:             IF !loc_lEncontrou AND ;
4249:                !EMPTY(CrSigMvCcr.Emps) AND !EMPTY(CrSigMvCcr.Dopcs) AND ;
4250:                !EMPTY(CrSigMvCcr.Numcs)
4251:                 IF USED("cursor_4c_SigOpOpe") AND RECCOUNT("cursor_4c_SigOpOpe") > 0
4252:                     SELECT cursor_4c_SigOpOpe
4253:                     GO TOP
4254:                     IF fChecaAcesso("C" + PADL(cursor_4c_SigOpOpe.NDopes, 8, "0"))
4255:                         DO FORM SigPgTit WITH CrSigMvCcr.Dopcs, "CONSULTAR", ;
4256:                             CrSigMvCcr.Emps, STR(CrSigMvCcr.Numcs, 6), ;
4257:                             (cursor_4c_SigOpOpe.RealPrevs = 2)
4258:                         loc_lEncontrou = .T.
4259:                     ELSE
4260:                         MsgAviso("Usu" + CHR(225) + "rio n" + CHR(227) + ;
4261:                                  "o tem acesso a Consultar T" + CHR(237) + "tulos!", "")
4262:                         loc_lEncontrou = .T.
4263:                     ENDIF
4264:                 ENDIF
4265:             ENDIF
4266: 
4267:             *-- 4) Verificar sigCcchm (carteira de cheques)
4268:             IF !loc_lEncontrou
4269:                 loc_cSQL = "SELECT TOP 1 1 AS Achou FROM sigCcchm " + ;
4270:                            "WHERE Emps = " + EscaparSQL(loc_cEmpo) + ;
4271:                            " AND Numos = " + STR(loc_nVope)
4272:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
4273:                     IF RECCOUNT("cursor_4c_ChkReg") > 0
4274:                         DO FORM SigCdChe WITH .T., LEFT(CrSigMvCcr.VOpers, 3), ;
4275:                             VAL(ALLTRIM(SUBSTR(CrSigMvCcr.VOpers, 4)))
4276:                         loc_lEncontrou = .T.
4277:                     ENDIF
4278:                 ENDIF
4279:             ENDIF
4280: 
4281:             *-- 5) Verificar SigCqChm (cheques a cobrar)
4282:             IF !loc_lEncontrou
4283:                 loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigCqChm " + ;
4284:                            "WHERE Emps = " + EscaparSQL(loc_cEmpo) + ;
4285:                            " AND Numos = " + STR(loc_nVope)
4286:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
4287:                     IF RECCOUNT("cursor_4c_ChkReg") > 0
4288:                         DO FORM SigCdLch WITH .T., LEFT(CrSigMvCcr.VOpers, 3), ;
4289:                             VAL(ALLTRIM(SUBSTR(CrSigMvCcr.VOpers, 4)))
4290:                         loc_lEncontrou = .T.
4291:                     ENDIF
4292:                 ENDIF
4293:             ENDIF
4294: 
4295:             *-- 6) Verificar SigPrCtb (provisoes contabeis)
4296:             IF !loc_lEncontrou
4297:                 loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigPrCtb " + ;
4298:                            "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
4299:                            " AND Dopes = " + EscaparSQL(loc_cDope) + ;
4300:                            " AND Numes = " + STR(loc_nNume)
4301:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
4302:                     IF RECCOUNT("cursor_4c_ChkReg") > 0
4303:                         DO FORM SigCdPgb WITH CrSigMvCcr.Emps, CrSigMvCcr.Dopes, ;
4304:                             CrSigMvCcr.Numes
4305:                         loc_lEncontrou = .T.
4306:                     ENDIF
4307:                 ENDIF
4308:             ENDIF
4309: 
4310:             *-- 7) Verificar SigCdNec (notas de entrada)
4311:             IF !loc_lEncontrou
4312:                 loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigCdNec " + ;
4313:                            "WHERE EmpDnPs = " + ;
4314:                            EscaparSQL(CrSigMvCcr.Emps + CrSigMvCcr.Dopes + STR(CrSigMvCcr.Numes, 10))
4315:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
4316:                     IF RECCOUNT("cursor_4c_ChkReg") > 0
4317:                         DO FORM SigMvPdt WITH CrSigMvCcr.Dopes, "C", ;
4318:                             CrSigMvCcr.Numes, CrSigMvCcr.Emps, .T.
4319:                         loc_lEncontrou = .T.
4320:                     ENDIF
4321:                 ENDIF
4322:             ENDIF
4323: 
4324:             ENDIF && loc_lProsseguir
4325: 
4326:             *-- Cleanup cursor temporario
4327:             IF USED("cursor_4c_ChkReg")
4328:                 USE IN cursor_4c_ChkReg
4329:             ENDIF
4330:             IF USED("cursor_4c_SigOpOpe")

*-- Linhas 4346 a 4405:
4346: 
4347:                 *-- Criar cursor xTmpBaixa se nao existe
4348:                 IF !USED("xTmpBaixa")
4349:                     CREATE CURSOR xTmpBaixa ;
4350:                         (Emps C(3), Dopes C(20), Numes C(6), Valos N(12,2), Moedas C(3), Datarcs D)
4351:                     INDEX ON Emps + Dopes + Numes TAG EmpDopNum
4352:                 ELSE
4353:                     SELECT xTmpBaixa
4354:                     DELETE ALL
4355:                     PACK
4356:                 ENDIF
4357: 
4358:                 loc_cEmpr = CrSigMvCcr.Emps
4359:                 loc_nNope = CrSigMvCcr.Nopers
4360: 
4361:                 loc_cSQL = "SELECT a.*, b.Datarcs FROM SigCdPbx a " + ;
4362:                            "JOIN SigCdPgr b ON a.EmpDopNums = b.EmpDopNums " + ;
4363:                            "WHERE a.Empos = " + EscaparSQL(loc_cEmpr) + ;
4364:                            " AND (a.Nopers = " + STR(loc_nNope) + ;
4365:                            " OR a.Nopercs = " + STR(loc_nNope) + ")"
4366:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdPbx") >= 1
4367:                     loc_lProsseguir = .T.
4368:                 ELSE
4369:                     MsgErro("Favor Reinicializar o Processo!", ;
4370:                             "Falha na Conex" + CHR(227) + "o (CrSigCdPbx)")
4371:                 ENDIF
4372:             ENDIF
4373: 
4374:             IF loc_lProsseguir
4375:                 SELECT cursor_4c_CrSigCdPbx
4376:                 SCAN
4377:                     INSERT INTO xTmpBaixa (Emps, Dopes, Numes, Valos, Moedas, Datarcs) ;
4378:                         VALUES (cursor_4c_CrSigCdPbx.Emps, ;
4379:                                 cursor_4c_CrSigCdPbx.Dopes, ;
4380:                                 fGerMascara(cursor_4c_CrSigCdPbx.Numes), ;
4381:                                 cursor_4c_CrSigCdPbx.Valos, ;
4382:                                 cursor_4c_CrSigCdPbx.Moedas, ;
4383:                                 cursor_4c_CrSigCdPbx.Datarcs)
4384:                 ENDSCAN
4385: 
4386:                 IF USED("cursor_4c_CrSigCdPbx")
4387:                     USE IN cursor_4c_CrSigCdPbx
4388:                 ENDIF
4389: 
4390:                 SELECT xTmpBaixa
4391:                 IF !EOF("xTmpBaixa")
4392:                     GO TOP
4393:                     loc_oPagHist = THIS.pgf_4c_1.Page2
4394: 
4395:                     *-- Desabilitar Sair
4396:                     IF PEMSTATUS(loc_oPagHist, "obj_4c_Grp_operacao", 5)
4397:                         loc_oPagHist.obj_4c_Grp_operacao.Buttons(1).Enabled = .F.
4398:                     ENDIF
4399: 
4400:                     *-- Exibir cnt_4c_Quitas
4401:                     IF PEMSTATUS(loc_oPagHist, "cnt_4c_Quitas", 5)
4402:                         loc_oPagHist.cnt_4c_Quitas.grd_4c_Grade.Refresh()
4403:                         loc_oPagHist.cnt_4c_Quitas.Visible = .T.
4404:                         loc_oPagHist.cnt_4c_Quitas.SetFocus()
4405:                     ENDIF

*-- Linhas 4429 a 4469:
4429:             loc_lProsseguir = .F.
4430: 
4431:             IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
4432:                 loc_cSQL = "SELECT * FROM SigCqOch WHERE Nopers = " + STR(CrSigMvCcr.Nopers)
4433:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lancto") >= 1
4434:                     loc_lProsseguir = .T.
4435:                 ELSE
4436:                     MsgErro("Favor Reinicializar o Processo!", ;
4437:                             "Falha na Conex" + CHR(227) + "o (SigCqOch)")
4438:                 ENDIF
4439:             ENDIF
4440: 
4441:             IF loc_lProsseguir
4442:                 SELECT cursor_4c_Lancto
4443:                 IF RECCOUNT() = 0
4444:                     MsgAviso("Nenhum lan" + CHR(231) + "amento de Follow-up Conciliado/Auditado!", "")
4445:                 ELSE
4446:                     THIS.DesabContainer()
4447:                     DO FORM SigOpOch WITH THIS, CrSigMvCcr.Nopers, CrSigMvCcr.Opers
4448:                 ENDIF
4449: 
4450:                 IF USED("cursor_4c_Lancto")
4451:                     USE IN cursor_4c_Lancto
4452:                 ENDIF
4453: 
4454:                 SELECT CrSigMvCcr
4455:                 loc_oPagHist = THIS.pgf_4c_1.Page2
4456:                 IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
4457:                     loc_oPagHist.grd_4c_Lancamento.Refresh()
4458:                     loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
4459:                 ENDIF
4460:             ENDIF
4461:         CATCH TO loc_oErro
4462:             MsgErro(loc_oErro.Message, "Erro em BtnFollowConciliaHistClick")
4463:         ENDTRY
4464:     ENDPROC
4465: 
4466:     *-- FollowUp Click -> Follow-up de conta (DO FORM SigOpFlp com conta)
4467:     PROCEDURE BtnFollowUpHistClick()
4468:         LOCAL loc_oErro, loc_oPagHist
4469:         TRY

*-- Linhas 4583 a 4601:
4583: 
4584:                 loc_nItem = loc_oPagHist.cmb_4c_Concilia.ListIndex
4585: 
4586:                 SELECT CrSigMvCcr
4587:                 DO CASE
4588:                     CASE loc_nItem = 0  && Lancamentos Realizados
4589:                         SET ORDER TO GruConMoe
4590:                         SET FILTER TO Tipo = "R"
4591:                     CASE loc_nItem = 1  && So Conciliados
4592:                         SET ORDER TO GruConMoec
4593:                         SET FILTER TO Concs
4594:                     CASE loc_nItem = 2  && Nao Conciliados
4595:                         SET ORDER TO GruConMoen
4596:                         SET FILTER TO !Concs
4597:                     CASE loc_nItem = 3  && Saldo Diario - Todos
4598:                         SET ORDER TO GruConMoe
4599:                         SET FILTER TO
4600:                     CASE loc_nItem = 4  && Saldo Diario - Conciliados
4601:                         SET ORDER TO GruConMoec

*-- Linhas 4612 a 4641:
4612:                 ENDCASE
4613:                 GO TOP
4614: 
4615:             *-- Reatribuir RecordSource e reconfirmar todos ControlSources
4616:                 loc_oGrd.RecordSource = "CrSigMvCcr"
4617:                 loc_oGrd.Column1.ControlSource  = "CrSigMvCcr.Datas"
4618:                 loc_oGrd.Column2.ControlSource  = "CrSigMvCcr.Hists"
4619:                 loc_oGrd.Column3.ControlSource  = "CrSigMvCcr.Valors"
4620:                 loc_oGrd.Column4.ControlSource  = "CrSigMvCcr.Opers"
4621:                 loc_oGrd.Column5.ControlSource  = "CrSigMvCcr.Emps"
4622:                 loc_oGrd.Column6.ControlSource  = "CrSigMvCcr.Saldos"
4623:                 loc_oGrd.Column7.ControlSource  = "CrSigMvCcr.Docus"
4624:                 loc_oGrd.Column8.ControlSource  = "CrSigMvCcr.NFs"
4625:                 loc_oGrd.Column9.ControlSource  = "CrSigMvCcr.Titulos"
4626:                 loc_oGrd.Column10.ControlSource = "CrSigMvCcr.Tipo"
4627:                 THIS.RestaurarColunaSelecao(loc_oGrd)
4628:                 loc_oGrd.Refresh()
4629: 
4630:                 *-- Legado (Cmb_Concilia.InteractiveChange): ao trocar o filtro
4631:                 *-- o total das linhas marcadas volta a zero.
4632:                 THIS.ZerarTotalSaldo()
4633:             ENDIF
4634:         CATCH TO loc_oErro
4635:             MsgErro(loc_oErro.Message, "Erro em CmbConciliaHistChange")
4636:         ENDTRY
4637:     ENDPROC
4638: 
4639:     *-- TxtMoeda KeyPress -> ENTER/TAB move foco para proximo campo
4640:     PROCEDURE TxtMoedaHistKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4641:         LOCAL loc_oErro, loc_oPagHist

*-- Linhas 4735 a 4790:
4735:             ENDIF
4736:             IF gnConnHandle > 0 AND !EMPTY(CrSigMvCcr.CidChaves)
4737:                 LOCAL loc_cSqlCob, loc_nRetCob
4738:                 loc_cSqlCob = "SELECT a.Contas, b.RClis " + ;
4739:                               "FROM SigMvCcr a INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
4740:                               "WHERE a.CidChaves = " + EscaparSQL(ALLTRIM(CrSigMvCcr.CidChaves))
4741:                 loc_nRetCob = SQLEXEC(gnConnHandle, loc_cSqlCob, "cursor_4c_LocalCta")
4742:                 IF loc_nRetCob > 0 AND RECCOUNT("cursor_4c_LocalCta") > 0
4743:                     GO TOP IN cursor_4c_LocalCta
4744:                     IF PEMSTATUS(loc_oPagHist, "txt_4c_CtaCob", 5)
4745:                         loc_oPagHist.txt_4c_CtaCob.Value = cursor_4c_LocalCta.Contas
4746:                     ENDIF
4747:                     IF PEMSTATUS(loc_oPagHist, "txt_4c_NomCob", 5)
4748:                         loc_oPagHist.txt_4c_NomCob.Value = cursor_4c_LocalCta.RClis
4749:                     ENDIF
4750:                 ENDIF
4751:                 IF USED("cursor_4c_LocalCta")
4752:                     USE IN cursor_4c_LocalCta
4753:                 ENDIF
4754:                 SELECT CrSigMvCcr
4755:             ENDIF
4756: 
4757:             *-- Job: busca RClis via Jobs (como no original)
4758:             IF PEMSTATUS(loc_oPagHist, "txt_4c_job", 5)
4759:                 loc_oPagHist.txt_4c_job.Value = CrSigMvCcr.Jobs
4760:             ENDIF
4761:             IF PEMSTATUS(loc_oPagHist, "txt_4c_djob", 5)
4762:                 loc_oPagHist.txt_4c_djob.Value = ""
4763:                 IF gnConnHandle > 0 AND !EMPTY(CrSigMvCcr.Jobs)
4764:                     LOCAL loc_cSqlJob, loc_nRetJob
4765:                     loc_cSqlJob = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
4766:                                   EscaparSQL(ALLTRIM(CrSigMvCcr.Jobs))
4767:                     loc_nRetJob = SQLEXEC(gnConnHandle, loc_cSqlJob, "cursor_4c_LocalJob")
4768:                     IF loc_nRetJob > 0 AND RECCOUNT("cursor_4c_LocalJob") > 0
4769:                         GO TOP IN cursor_4c_LocalJob
4770:                         loc_oPagHist.txt_4c_djob.Value = cursor_4c_LocalJob.RClis
4771:                     ENDIF
4772:                     IF USED("cursor_4c_LocalJob")
4773:                         USE IN cursor_4c_LocalJob
4774:                     ENDIF
4775:                     SELECT CrSigMvCcr
4776:                 ENDIF
4777:             ENDIF
4778:             IF PEMSTATUS(loc_oPagHist, "txt_4c_Auditors", 5)
4779:                 loc_oPagHist.txt_4c_Auditors.Value = CrSigMvCcr.Auditors
4780:             ENDIF
4781:             IF PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
4782:                 loc_oPagHist.txt_4c_DataConcilia.Value = CrSigMvCcr.DataConcs
4783:             ENDIF
4784:             IF PEMSTATUS(loc_oPagHist, "txt_4c_DtAudits", 5)
4785:                 loc_oPagHist.txt_4c_DtAudits.Value = CrSigMvCcr.DtAudits
4786:             ENDIF
4787: 
4788:             *-- Habilitar/desabilitar botoes de acao conforme Tipo
4789:             *   Previsao (Tipo='P'): desabilita Concilia/Audita/Quita; habilita Alterar/Excluir
4790:             IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Alterar", 5)

*-- Linhas 4890 a 4908:
4890:                     loc_oBusca.Show()
4891:                 ENDIF
4892:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4893:                     SELECT cursor_4c_Busca
4894:                     GO TOP
4895:                     par_oCnt.txt_4c_CdMoeda.Value = TRIM(cursor_4c_Busca.cmoes)
4896:                     par_oCnt.txt_4c_DsMoeda.Value = TRIM(cursor_4c_Busca.dmoes)
4897:                     *-- Habilitar chkRazaoCp/chkRazaoDoc quando moeda preenchida
4898:                     IF PEMSTATUS(par_oCnt, "chk_4c_RazaoCp", 5)
4899:                         par_oCnt.chk_4c_RazaoCp.Enabled = .T.
4900:                     ENDIF
4901:                     IF PEMSTATUS(par_oCnt, "chk_4c_RazaoDoc", 5)
4902:                         par_oCnt.chk_4c_RazaoDoc.Enabled = .T.
4903:                     ENDIF
4904:                 ELSE
4905:                     IF EMPTY(par_oCnt.txt_4c_CdMoeda.Value)
4906:                         par_oCnt.txt_4c_DsMoeda.Value = ""
4907:                         IF PEMSTATUS(par_oCnt, "chk_4c_RazaoCp", 5)
4908:                             par_oCnt.chk_4c_RazaoCp.Enabled = .F.

*-- Linhas 4965 a 4983:
4965:                     loc_oBusca.Show()
4966:                 ENDIF
4967:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4968:                     SELECT cursor_4c_Busca
4969:                     GO TOP
4970:                     par_oCnt.txt_4c_Emps.Value  = TRIM(cursor_4c_Busca.Cemps)
4971:                     par_oCnt.txt_4c_DEmps.Value = TRIM(cursor_4c_Busca.Razas)
4972:                 ELSE
4973:                     IF EMPTY(par_oCnt.txt_4c_Emps.Value)
4974:                         par_oCnt.txt_4c_DEmps.Value = ""
4975:                     ENDIF
4976:                 ENDIF
4977:                 IF USED("cursor_4c_Busca")
4978:                     USE IN cursor_4c_Busca
4979:                 ENDIF
4980:                 loc_oBusca.Release()
4981:             ENDIF
4982:         CATCH TO loc_oErro
4983:             MsgErro(loc_oErro.Message, "Erro em AbrirLookupEmps")

*-- Linhas 5217 a 5235:
5217:     *==========================================================================
5218:     PROCEDURE BtnConciliaHistClick()
5219:         LOCAL loc_oErro, loc_oPagHist, loc_lOk, loc_cSQL, loc_lPValue, loc_lProsseguir4c
5220:         LOCAL loc_cUpdate, loc_cTipo, loc_cCidChaves, loc_cDataSQL, loc_cInsert
5221:         LOCAL loc_nResultIns, loc_nResultUpd, loc_dData
5222:         PRIVATE llData, llConc
5223: 
5224:         loc_lProsseguir4c = .T.
5225:         TRY
5226:             loc_oPagHist = THIS.pgf_4c_1.Page2
5227: 
5228:             *-- Ignorar se checkbox desabilitado ou lancamento provisorio
5229:             IF !PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Concilia", 5)
5230:                 loc_lProsseguir4c = .F.
5231:             ENDIF
5232:             IF loc_lProsseguir4c
5233:                 IF !loc_oPagHist.chk_4c_Chk_Concilia.Enabled
5234:                     loc_lProsseguir4c = .F.
5235:                 ENDIF

*-- Linhas 5251 a 5269:
5251:             ENDIF
5252: 
5253:             IF loc_lProsseguir4c
5254:                 SELECT CrSigMvCcr
5255:                 loc_lOk = .T.
5256: 
5257:             *-- Verificar se conciliacao feita por outro usuario e sem permissao master
5258:                 IF CrSigMvCcr.Concs AND TRIM(CrSigMvCcr.UsuConcs) # TRIM(gc_4c_UsuarioLogado)
5259:                     IF !fChecaAcesso("SIGOPIND", "CONCMASTER")
5260:                         MsgAviso("Concilia" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
5261:                                  "o Pode Ser Desfeita Por Este Usu" + CHR(225) + "rio!!!" + ;
5262:                                  CHR(13) + "Ela Foi Executada Por " + ;
5263:                                  ALLTRIM(CrSigMvCcr.UsuConcs) + "!!!", "")
5264:                         loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
5265:                         loc_lOk = .F.
5266:                     ENDIF
5267:                 ENDIF
5268: 
5269:             *-- Verificar data da conciliacao informada

*-- Linhas 5278 a 5314:
5278: 
5279:             *-- Verificar bloqueio de periodo (SigSyBlq)
5280:                 IF loc_lOk AND gnConnHandle > 0
5281:                     loc_cSQL = "SELECT * FROM SigSyBlq"
5282:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpBloq2") >= 1
5283:                         IF RECCOUNT("cursor_4c_TmpBloq2") > 0
5284:                             SELECT cursor_4c_TmpBloq2
5285:                             GO TOP
5286:                             IF cursor_4c_TmpBloq2.ChkConcs = 1 AND ;
5287:                                PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5) AND ;
5288:                                fVerificaBloqueio(loc_oPagHist.txt_4c_DataConcilia.Value, gnConnHandle) >= 0
5289:                                 MsgAviso("Per" + CHR(237) + "odo Bloqueado !!!", "")
5290:                                 loc_lOk = .F.
5291:                             ENDIF
5292:                         ENDIF
5293:                         IF USED("cursor_4c_TmpBloq2")
5294:                             USE IN cursor_4c_TmpBloq2
5295:                         ENDIF
5296:                     ENDIF
5297:                 ENDIF
5298: 
5299:                 SELECT CrSigMvCcr
5300: 
5301:             *-- Verificar data conciliacao >= data lancamento (somente ao conciliar)
5302:                 IF !CrSigMvCcr.Concs AND loc_lOk AND PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
5303:                     IF loc_oPagHist.txt_4c_DataConcilia.Value < CrSigMvCcr.Datas
5304:                         MsgAviso("A Data da Concilia" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
5305:                                  "o Pode Ser Menor Que a Do Lan" + CHR(231) + "amento!!!", "")
5306:                         loc_oPagHist.chk_4c_Chk_Concilia.Value = 0
5307:                         loc_lOk = .F.
5308:                     ENDIF
5309:                 ENDIF
5310: 
5311:             *-- Confirmar desconciliacao
5312:                 IF CrSigMvCcr.Concs AND loc_lOk
5313:                     IF !MsgConfirma("Confirma a Desconcilia" + CHR(231) + CHR(227) + ;
5314:                                     "o do Lan" + CHR(231) + "amento?", ;

*-- Linhas 5329 a 5353:
5329: 
5330:             *-- Verificar estado atual no banco (evitar race condition)
5331:             IF loc_lProsseguir4c
5332:                 loc_cSQL = "SELECT DataConcs, Concs, UsuConcs, CidChaves FROM SigMvCcr " + ;
5333:                            "WHERE CidChaves = " + EscaparSQL(CrSigMvCcr.CidChaves)
5334: 
5335:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr3") > 0 AND ;
5336:                    RECCOUNT("cursor_4c_TmpMccr3") > 0
5337:     
5338:                     SELECT cursor_4c_TmpMccr3
5339:                     IF loc_lPValue
5340:                         IF cursor_4c_TmpMccr3.Concs
5341:                             MsgAviso("Lan" + CHR(231) + "amento j" + CHR(225) + ;
5342:                                      " conciliado Por " + ALLTRIM(cursor_4c_TmpMccr3.UsuConcs) + ;
5343:                                      "!!!", "")
5344:                             loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
5345:                             IF USED("cursor_4c_TmpMccr3")
5346:                                 USE IN cursor_4c_TmpMccr3
5347:                             ENDIF
5348:                             IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
5349:                                 loc_oPagHist.grd_4c_Lancamento.Refresh()
5350:                                 loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
5351:                             ENDIF
5352:                             loc_lProsseguir4c = .F.
5353:                         ENDIF

*-- Linhas 5373 a 5426:
5373:                             USE IN cursor_4c_TmpMccr3
5374:                         ENDIF
5375:     
5376:                         SELECT CrSigMvCcr
5377:     
5378:                     *-- Montar data para SQL Server
5379:                         loc_dData = IIF(PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5), ;
5380:                                         loc_oPagHist.txt_4c_DataConcilia.Value, DATE())
5381:                         loc_cDataSQL = TRANSFORM(YEAR(loc_dData), "9999") + "-" + ;
5382:                                        PADL(TRANSFORM(MONTH(loc_dData)), 2, "0") + "-" + ;
5383:                                        PADL(TRANSFORM(DAY(loc_dData)), 2, "0") + " 23:59:59"
5384:     
5385:                         IF loc_lPValue
5386:                             loc_cTipo   = "Conciliado"
5387:                             loc_cUpdate = "UPDATE SigMvCcr SET DataConcs = '" + loc_cDataSQL + ;
5388:                                           "', Concs = 1, UsuConcs = " + ;
5389:                                           EscaparSQL(gc_4c_UsuarioLogado) + ;
5390:                                           " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
5391:                         ELSE
5392:                             loc_cTipo   = "DesConciliado"
5393:                             loc_cUpdate = "UPDATE SigMvCcr SET DataConcs = NULL, " + ;
5394:                                           "Concs = 0, UsuConcs = ' ' " + ;
5395:                                           " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
5396:                         ENDIF
5397:     
5398:                     *-- Inserir log em SigCqOch
5399:                         loc_cInsert = "INSERT INTO SigCqOch " + ;
5400:                                       "(Nopers, Datars, TpLancs, Datas, Usuars, CidChaves) " + ;
5401:                                       "VALUES (" + STR(CrSigMvCcr.Nopers) + ", GETDATE(), " + ;
5402:                                       EscaparSQL(loc_cTipo) + ", " + ;
5403:                                       IIF(loc_lPValue, "'" + loc_cDataSQL + "'", "NULL") + ", " + ;
5404:                                       EscaparSQL(gc_4c_UsuarioLogado) + ", NEWID())"
5405:     
5406:                         loc_nResultIns = SQLEXEC(gnConnHandle, loc_cInsert)
5407:                         IF loc_nResultIns > 0
5408:                             loc_nResultUpd = SQLEXEC(gnConnHandle, loc_cUpdate)
5409:                             IF loc_nResultUpd > 0
5410:                                 *-- Atualizar cursor local CrSigMvCcr
5411:                                 SELECT CrSigMvCcr
5412:                                 IF loc_lPValue
5413:                                     REPLACE Concs     WITH .T., ;
5414:                                             UsuConcs  WITH gc_4c_UsuarioLogado, ;
5415:                                             DataConcs WITH loc_dData
5416:                                 ELSE
5417:                                     REPLACE Concs     WITH .F., ;
5418:                                             UsuConcs  WITH " ", ;
5419:                                             DataConcs WITH CTOD("  /  /  ")
5420:                                 ENDIF
5421:                             ELSE
5422:                                 MsgErro("Falha ao atualizar SigMvCcr.", ;
5423:                                         "Erro em Concilia" + CHR(231) + CHR(227) + "o")
5424:                             ENDIF
5425:                         ELSE
5426:                             MsgErro("Falha ao registrar log de concilia" + CHR(231) + ;

*-- Linhas 5462 a 5481:
5462:     * Equivale ao Chk_Auditoria.Click (100 linhas) do legado
5463:     *==========================================================================
5464:     PROCEDURE BtnAuditoriaHistClick()
5465:         LOCAL loc_oErro, loc_oPagHist, loc_lTval, loc_cSQL, loc_cUpdate, loc_cTipo, loc_lProsseguir4c
5466:         LOCAL loc_cCidChaves, loc_cDataSQL, loc_cInsert, loc_nErro
5467:         LOCAL loc_dDataAudit
5468:         PRIVATE llData
5469: 
5470:         loc_lProsseguir4c = .T.
5471:         TRY
5472:             loc_oPagHist = THIS.pgf_4c_1.Page2
5473: 
5474:             *-- Ignorar se checkbox desabilitado ou lancamento provisorio
5475:             IF !PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Auditoria", 5)
5476:                 loc_lProsseguir4c = .F.
5477:             ENDIF
5478:             IF loc_lProsseguir4c
5479:                 IF !loc_oPagHist.chk_4c_Chk_Auditoria.Enabled
5480:                     loc_lProsseguir4c = .F.
5481:                 ENDIF

*-- Linhas 5497 a 5515:
5497:             IF loc_lProsseguir4c
5498:                 loc_lTval = (loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1)
5499: 
5500:                 SELECT CrSigMvCcr
5501: 
5502:             *-- Verificar se auditoria feita por outro usuario sem permissao master
5503:                 IF !EMPTY(CrSigMvCcr.Auditors) AND ;
5504:                    (TRIM(CrSigMvCcr.Auditors) # TRIM(gc_4c_UsuarioLogado))
5505:                     IF !fChecaAcesso("SIGOPIND", "AUDMASTER")
5506:                         MsgAviso("Auditoria N" + CHR(227) + "o Pode Ser Desfeita Por Este Usu" + ;
5507:                                  CHR(225) + "rio!!!" + CHR(13) + ;
5508:                                  "Ela Foi Executada Por " + ALLTRIM(CrSigMvCcr.Auditors) + ;
5509:                                  "!!!", "")
5510:                         loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
5511:                         IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
5512:                             loc_oPagHist.grd_4c_Lancamento.Refresh()
5513:                             loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
5514:                         ENDIF
5515:                         loc_lProsseguir4c = .F.

*-- Linhas 5538 a 5564:
5538:                                PADR(TRIM(loc_oPagHist.txt_4c_CtaCob.Value), 10), ;
5539:                                CrSigMvCcr.Contas)
5540: 
5541:                 loc_cSQL = "SELECT DtAudits, Auditors, CidChaves FROM SigMvCcr " + ;
5542:                            "WHERE GruConMoes = " + ;
5543:                            EscaparSQL(CrSigMvCcr.Grupos + loc_cCta + CrSigMvCcr.Moedas) + ;
5544:                            " AND Nopers = " + STR(CrSigMvCcr.Nopers) + ;
5545:                            " AND Opers = " + EscaparSQL(CrSigMvCcr.Opers)
5546: 
5547:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr4")
5548:                 IF loc_nErro > 0
5549:                     SELECT cursor_4c_TmpMccr4
5550:     
5551:                     *-- Verificar estado atual de auditoria
5552:                     IF loc_lTval
5553:                         IF !EMPTY(TRIM(cursor_4c_TmpMccr4.Auditors))
5554:                             MsgAviso("Lan" + CHR(231) + "amento j" + CHR(225) + " Auditado Por " + ;
5555:                                      ALLTRIM(cursor_4c_TmpMccr4.Auditors) + "!!!", "")
5556:                             loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
5557:                             IF USED("cursor_4c_TmpMccr4")
5558:                                 USE IN cursor_4c_TmpMccr4
5559:                             ENDIF
5560:                             IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
5561:                                 loc_oPagHist.grd_4c_Lancamento.Refresh()
5562:                                 loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
5563:                             ENDIF
5564:                             loc_lProsseguir4c = .F.

*-- Linhas 5586 a 5628:
5586:     
5587:                         IF loc_lTval
5588:                             loc_cTipo   = "Auditado"
5589:                             loc_cUpdate = "UPDATE SigMvCcr SET DtAudits = '" + loc_cDataSQL + ;
5590:                                           "', Auditors = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
5591:                                           " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
5592:                         ELSE
5593:                             loc_cTipo   = "DesAuditado"
5594:                             loc_cUpdate = "UPDATE SigMvCcr SET DtAudits = NULL, " + ;
5595:                                           "Auditors = '          ' " + ;
5596:                                           " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
5597:                         ENDIF
5598:     
5599:                     *-- Inserir log em SigCqOch
5600:                         SELECT CrSigMvCcr
5601:                         loc_cInsert = "INSERT INTO SigCqOch " + ;
5602:                                       "(Nopers, Datars, TpLancs, Datas, Usuars, CidChaves, DtLancs) " + ;
5603:                                       "VALUES (" + STR(CrSigMvCcr.Nopers) + ", GETDATE(), " + ;
5604:                                       EscaparSQL(loc_cTipo) + ", " + ;
5605:                                       IIF(loc_lTval, "'" + loc_cDataSQL + "'", "NULL") + ", " + ;
5606:                                       EscaparSQL(gc_4c_UsuarioLogado) + ", NEWID(), " + ;
5607:                                       FormatarDataSQL(CrSigMvCcr.Datas) + ")"
5608:     
5609:                         IF SQLEXEC(gnConnHandle, loc_cInsert) > 0
5610:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate)
5611:                             IF loc_nErro > 0
5612:                                 *-- Atualizar cursor local CrSigMvCcr
5613:                                 SELECT CrSigMvCcr
5614:                                 IF loc_lTval
5615:                                     REPLACE DtAudits WITH DATETIME(), ;
5616:                                             Auditors WITH gc_4c_UsuarioLogado
5617:                                 ELSE
5618:                                     REPLACE DtAudits WITH {}, ;
5619:                                             Auditors WITH " "
5620:                                 ENDIF
5621:                             ELSE
5622:                                 MsgErro("Falha ao atualizar SigMvCcr.", ;
5623:                                         "Erro em Auditoria")
5624:                             ENDIF
5625:                         ELSE
5626:                             MsgErro("Falha ao registrar log de auditoria.", ;
5627:                                     "Erro em SigCqOch")
5628:                         ENDIF

*-- Linhas 6326 a 6344:
6326: 
6327:             *-- Limpar cursor de saldos
6328:             IF USED("cursor_4c_Saldos")
6329:                 SELECT cursor_4c_Saldos
6330:                 ZAP
6331:             ENDIF
6332: 
6333:             *-- Resetar propriedades internas
6334:             THIS.this_cGrupoOper    = ""
6335:             THIS.this_cCliente      = SPACE(10)
6336:             THIS.this_cOperacao     = ""
6337:             THIS.this_dDataConcilia = {}
6338: 
6339:         CATCH TO loc_oErro
6340:             MsgErro(loc_oErro.Message, "Erro em LimparCampos")
6341:         ENDTRY
6342:     ENDPROC
6343: 
6344:     *==========================================================================

*-- Linhas 6493 a 6511:
6493:     *==========================================================================
6494:     *==========================================================================
6495:     * PROCEDURE RestaurarColunaSelecao
6496:     * Reatribuir RecordSource/ControlSource de um Grid faz o VFP recalcular a
6497:     * coluna: Width, ColumnOrder, Sparse, ReadOnly, CurrentControl e as
6498:     * propriedades do Header voltam ao default. Este metodo repoe a coluna de
6499:     * marcacao (col_selec do legado) e tem de ser chamado DEPOIS de todo
6500:     * RecordSource do grd_4c_Lancamento.
6501:     *==========================================================================
6502:     PROCEDURE RestaurarColunaSelecao(par_oGrid)
6503:         LOCAL loc_oCol, loc_oErro
6504:         TRY
6505:             IF VARTYPE(par_oGrid) = "O" AND par_oGrid.ColumnCount >= 11
6506:                 loc_oCol = par_oGrid.Column11
6507: 
6508:                 *-- O CheckBox pode ter sido destruido junto com a Column
6509:                 IF !PEMSTATUS(loc_oCol, "chk_4c_Selec", 5)
6510:                     loc_oCol.AddObject("chk_4c_Selec", "CheckBox")
6511:                     WITH loc_oCol.chk_4c_Selec

*-- Linhas 6528 a 6546:
6528:                     BINDEVENT(loc_oCol.Header1,      "Click",     THIS, "HeaderSelecClick")
6529:                 ENDIF
6530: 
6531:                 loc_oCol.ControlSource  = "CrSigMvCcr.Seleciona"
6532:                 loc_oCol.Width          = 22
6533:                 loc_oCol.ColumnOrder    = 1
6534:                 loc_oCol.Movable        = .F.
6535:                 loc_oCol.Sparse         = .F.
6536:                 loc_oCol.FontName       = "Tahoma"
6537:                 loc_oCol.FontSize       = 8
6538:                 loc_oCol.CurrentControl = "chk_4c_Selec"
6539: 
6540:                 *-- ReadOnly da COLUNA depois do ReadOnly do GRID (o do grid propaga)
6541:                 loc_oCol.ReadOnly       = .F.
6542: 
6543:                 WITH loc_oCol.Header1
6544:                     .Caption     = ""
6545:                     .Alignment   = 2
6546:                     .Picture     = gc_4c_CaminhoIcones + "CHECKBX.BMP"

*-- Linhas 6566 a 6609:
6566:             loc_nRegAtual = 0
6567: 
6568:             IF USED("CrSigMvCcr")
6569:                 SELECT CrSigMvCcr
6570:                 loc_nRegAtual = RECNO("CrSigMvCcr")
6571: 
6572:                 IF USED("cursor_4c_Selecionados")
6573:                     USE IN cursor_4c_Selecionados
6574:                 ENDIF
6575: 
6576:                 SELECT * FROM CrSigMvCcr ;
6577:                     WHERE Seleciona = 1 ;
6578:                     INTO CURSOR cursor_4c_Selecionados READWRITE
6579: 
6580:                 SELECT cursor_4c_Selecionados
6581:                 GO TOP
6582:                 SCAN
6583:                     loc_nTotal = loc_nTotal + ;
6584:                                  IIF(cursor_4c_Selecionados.Opers = "D", ;
6585:                                      cursor_4c_Selecionados.Valors, ;
6586:                                      -cursor_4c_Selecionados.Valors)
6587:                 ENDSCAN
6588: 
6589:                 IF USED("cursor_4c_Selecionados")
6590:                     USE IN cursor_4c_Selecionados
6591:                 ENDIF
6592: 
6593:                 *-- Repor o ponteiro do cursor da grade (o SCAN move o RECNO)
6594:                 SELECT CrSigMvCcr
6595:                 IF loc_nRegAtual > 0 AND loc_nRegAtual <= RECCOUNT("CrSigMvCcr")
6596:                     GO loc_nRegAtual
6597:                 ENDIF
6598:             ENDIF
6599: 
6600:             loc_oPagHist = THIS.pgf_4c_1.Page2
6601:             IF PEMSTATUS(loc_oPagHist, "txt_4c_Total", 5)
6602:                 loc_oPagHist.txt_4c_Total.Value = loc_nTotal
6603:                 loc_oPagHist.txt_4c_Total.Refresh()
6604:             ENDIF
6605:         CATCH TO loc_oErro
6606:             MsgErro(loc_oErro.Message, "Erro em CalcSaldo")
6607:         ENDTRY
6608:     ENDPROC
6609: 

*-- Linhas 6640 a 6667:
6640:                 loc_cCur = ALLTRIM(loc_oGrd.RecordSource)
6641: 
6642:                 IF !EMPTY(loc_cCur) AND USED(loc_cCur)
6643:                     SELECT (loc_cCur)
6644:                     loc_nReg = RECNO(loc_cCur)
6645:                     IF loc_nReg > 0 AND loc_nReg <= RECCOUNT(loc_cCur)
6646:                         REPLACE Seleciona WITH IIF(Seleciona = 1, 0, 1) IN (loc_cCur)
6647: 
6648:                         IF UPPER(loc_cCur) == "CRSIGMVCCR"
6649:                             THIS.CalcSaldo()
6650:                         ENDIF
6651: 
6652:                         SELECT (loc_cCur)
6653:                         GO loc_nReg
6654:                     ENDIF
6655:                     loc_oGrd.Refresh()
6656:                 ENDIF
6657: 
6658:                 NODEFAULT
6659:             ENDIF
6660:         CATCH TO loc_oErro
6661:             MsgErro(loc_oErro.Message, "Erro em ChkSelecKeyPress")
6662:         ENDTRY
6663:     ENDPROC
6664: 
6665:     *-- MouseUp da celula: o legado delega para o mesmo tratamento do Enter
6666:     PROCEDURE ChkSelecMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
6667:         THIS.ChkSelecKeyPress(13, 0)

*-- Linhas 6692 a 6721:
6692:             loc_cCur = ALLTRIM(loc_oGrd.RecordSource)
6693: 
6694:             IF !EMPTY(loc_cCur) AND USED(loc_cCur)
6695:                 SELECT (loc_cCur)
6696:                 loc_nReg = RECNO(loc_cCur)
6697: 
6698:                 IF loc_oCol.Header1.Tag == "X"
6699:                     loc_oCol.Header1.Tag = ""
6700:                     REPLACE ALL Seleciona WITH 0 IN (loc_cCur)
6701:                 ELSE
6702:                     loc_oCol.Header1.Tag = "X"
6703:                     REPLACE ALL Seleciona WITH 1 IN (loc_cCur)
6704:                 ENDIF
6705: 
6706:                 SELECT (loc_cCur)
6707:                 IF loc_nReg > 0 AND loc_nReg <= RECCOUNT(loc_cCur)
6708:                     GO loc_nReg
6709:                 ENDIF
6710:                 loc_oGrd.Refresh()
6711:             ENDIF
6712:         CATCH TO loc_oErro
6713:             MsgErro(loc_oErro.Message, "Erro em HeaderSelecClick")
6714:         ENDTRY
6715:     ENDPROC
6716: 
6717:     *==========================================================================
6718:     * Eventos principais (nomes canonicos) - Fase 7/8
6719:     * SIGOPIND eh um visualizador/operacional de Conta Corrente: o legado NAO
6720:     * tem Incluir (nao existe cadastro de lancamento aqui - lancamentos nascem
6721:     * em outras telas: SigMvCab/SigPgTit/SigCdPgr/SigCdChe/SigCdLch/SigCdPgb/


### BO (C:\4c\projeto\app\classes\sigopindBO.prg):
*==============================================================================
* sigopindBO.prg - Business Object para Contas Correntes Individuais (SIGOPIND)
* Herda de: BusinessBase
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigopindBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela principal
    *--------------------------------------------------------------------------
    this_cTabela     = "SigMvSlc"
    this_cCampoChave = "Contas"

    *--------------------------------------------------------------------------
    * Propriedades de contexto operacional do formulario
    *--------------------------------------------------------------------------
    this_cGrupoOper    = ""    && Grupo de conta corrente selecionado
    this_cCliente      = ""    && Codigo do cliente/conta selecionada
    this_dDataConcilia = {}    && Data de conciliacao em andamento
    this_lMatrizes     = .F.   && Flag: eh matriz (go_4c_Sistema.Matrizes)
    this_cOperacao     = ""    && Operacao corrente (CONSULTA, ALTERAR, etc.)
    this_cUsuario      = ""    && Usuario logado corrente

    *--------------------------------------------------------------------------
    * Propriedades de SigMvSlc (saldos por conta/moeda)
    *--------------------------------------------------------------------------
    this_cEmps       = ""      && Empresa
    this_cGrupos     = ""      && Grupo de conta corrente
    this_cContas     = ""      && Codigo da conta (cliente)
    this_cMoedas     = ""      && Codigo da moeda
    this_nSaldos     = 0       && Saldo atual
    this_cRClis      = ""      && Razao social do cliente
    this_cSituas     = ""      && Situacao do cliente
    this_cCpfs       = ""      && CPF/CNPJ do cliente
    this_cContaMats  = ""      && Conta matriz

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCli (dados do cliente)
    *--------------------------------------------------------------------------
    this_cIClis          = ""   && Codigo interno do cliente
    this_nConcilias      = 0    && Flag: aceita conciliacao
    this_nCanAudits      = 0    && Flag: pode auditar

    *--------------------------------------------------------------------------
    * Propriedades de SigMvCcr (lancamentos/historico)
    *--------------------------------------------------------------------------
    this_cLancEmps      = ""    && Empresa do lancamento
    this_cDopes         = ""    && Documento/operacao
    this_nNumes         = 0     && Numero do lancamento
    this_nNopers        = 0     && Numero da operacao
    this_cVOpers        = ""    && Valor/numero operacao complementar
    this_cOpers         = ""    && Identificador de operacao
    this_cDopcs         = ""    && Documento contra-partida
    this_nNumcs         = 0     && Numero da contra-partida
    this_dDatas         = {}    && Data do lancamento
    this_nSaldosCcr     = 0     && Saldo do lancamento
    this_cHists         = ""    && Historico do lancamento
    this_lConcs         = .F.   && Conciliado?
    this_cUsuConcs      = ""    && Usuario que conciliou
    this_cAuditors      = ""    && Auditor
    this_dDtAudits      = {}    && Data de auditoria
    this_cTipo          = ""    && Tipo do lancamento (P=provisorio, etc.)
    this_cSGrupos       = ""    && Sub-grupo do lancamento

    *--------------------------------------------------------------------------
    * Propriedades de filtro do painel Saldo (cntSaldo / ProcessaSaldo)
    *--------------------------------------------------------------------------
    this_cMoedaCodFiltro   = ""  && Codigo da moeda para filtro saldo
    this_cMoedaDescFiltro  = ""  && Descricao da moeda para filtro saldo
    this_dDataLimiteFiltro = {}  && Data limite para filtro saldo
    this_nOrdemFiltro      = 1   && Ordem: 1=Nome 2=Codigo 3=Saldo
    this_lAscendente       = .F. && Ordenacao ascendente?
    this_cSituacaoFiltro   = ""  && Codigo da situacao para filtro
    this_lImprimeSaldoZero = .F. && Imprimir contas com saldo zero?
    this_nOptFiltro        = 1   && Opcao do optFiltro (1=Todos 2=Devedor 3=Credor)

    *--------------------------------------------------------------------------
    * Propriedades de filtro do historico (cntImprime / ProcessaHist)
    *--------------------------------------------------------------------------
    this_dDtInicial       = {}   && Data inicial do historico
    this_dDtFinal         = {}   && Data final do historico
    this_cMoedaHistCod    = ""   && Codigo da moeda para historico
    this_cMoedaHistDesc   = ""   && Descricao da moeda para historico
    this_cEmpsCod         = ""   && Codigo da empresa para historico
    this_cEmpsDesc        = ""   && Descricao da empresa para historico
    this_cGetOper         = ""   && D/C (debito/credito) para filtro
    this_nCmbConcilia     = 0    && Opcao do combobox de conciliacao
    this_lChkGrupo        = .F.  && Todas as contas do grupo?
    this_lCheckSalto      = .F.  && Quebra pagina por conta?
    this_lCheckSAnt       = .F.  && Sem saldo anterior?
    this_lCheckRazaoCP    = .F.  && Relacao com contrapartida?
    this_lCheckRazaoDoc   = .F.  && Relacao com documento?
    this_lCheckComissao   = .F.  && Incluir comissao?
    this_lCheckSaldoa     = .F.  && Sem saldo?
    this_lChkTaxas        = .F.  && Incluir taxas?
    this_lChkRelDets      = .F.  && Relacao detalhada?
    this_nOptSNA          = 1    && Opcao S/N/A (1=S, 2=N, 3=A)
    this_lChkOcultaCta    = .F.  && Ocultar descricao da conta?

    *--------------------------------------------------------------------------
    * Propriedades de periodos padroes da grade Saldo
    *--------------------------------------------------------------------------
    this_dDataInicialSaldo = {}   && Data inicial do filtro de periodo saldo
    this_dDataFinalSaldo   = {}   && Data final do filtro de periodo saldo

    *--------------------------------------------------------------------------
    * Propriedades para busca de conta (cntConsulta)
    *--------------------------------------------------------------------------
    this_cCdContaBusca  = ""    && Codigo da conta digitado para busca
    this_cDsContaBusca  = ""    && Descricao da conta digitado para busca

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvSlc"
            THIS.this_cCampoChave = "Contas"

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
    *-- Retorna a chave primaria do registro corrente
        RETURN THIS.this_cContas
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Carrega propriedades do BO a partir do cursor combinado (SigMvSlc + SigCdCli)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps      = TratarNulo(Emps, "C")
                THIS.this_cGrupos    = TratarNulo(Grupos, "C")
                THIS.this_cContas    = TratarNulo(Contas, "C")
                THIS.this_cMoedas    = TratarNulo(Moedas, "C")
                THIS.this_nSaldos    = TratarNulo(Saldos, "N")
                THIS.this_cRClis     = TratarNulo(RClis, "C")
                THIS.this_cSituas    = TratarNulo(Situas, "C")
                THIS.this_cCpfs      = TratarNulo(Cpfs, "C")
                THIS.this_cContaMats = TratarNulo(ContaMats, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Inserir()
    *==========================================================================
    *-- Form OPERACIONAL: insercoes sao feitas via lancamentos contabeis externos
        RETURN .F.
    ENDPROC

    *==========================================================================
    PROCEDURE Atualizar()
    *==========================================================================
    *-- Atualiza conciliacao/auditoria do lancamento corrente em SigMvCcr
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Concs = " + IIF(THIS.this_lConcs, "1", "0") + ", " + ;
                       "Usuconcs = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                       "Dataconcs = " + FormatarDataSQL(THIS.this_dDataConcilia) + ", " + ;
                       "Auditors = " + EscaparSQL(ALLTRIM(THIS.this_cAuditors)) + ", " + ;
                       "DtAudits = " + FormatarDataSQL(THIS.this_dDtAudits) + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cLancEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar registro.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
    *-- Exclui todos os lancamentos da operacao (corrente + contra-partida) em SigMvCcr
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "DELETE FROM SigMvCcr " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cLancEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("E")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Excluir()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + ;
                           CHR(231) + "amento?", "Confirma" + CHR(231) + CHR(227) + "o")
                loc_lResultado = THIS.ExecutarExclusao()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE MontaGrade(par_cGrupo, par_nOptFiltro)
    *==========================================================================
    *-- Carrega cursor_4c_Saldos com dados de SigMvSlc + SigCdCli por grupo
    *-- par_cGrupo    : codigo do grupo de conta corrente
    *-- par_nOptFiltro: 1=Todos  2=Devedores(Saldo>0)  3=Credores(Saldo<0)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cFiltroSaldo
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            IF EMPTY(ALLTRIM(par_cGrupo))
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Filtro de saldo conforme opcao selecionada
            DO CASE
                CASE par_nOptFiltro = 2
                    loc_cFiltroSaldo = " AND a.Saldos > 0"
                CASE par_nOptFiltro = 3
                    loc_cFiltroSaldo = " AND a.Saldos < 0"
                OTHERWISE
                    loc_cFiltroSaldo = ""
            ENDCASE

            *-- Consulta principal: saldos por conta/moeda do grupo
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                       "b.RClis, b.Situas, b.Cpfs, b.ContaMats, " + ;
                       "CAST(' ' AS CHAR(1)) AS Matriz " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                       loc_cFiltroSaldo + ;
                       " ORDER BY a.Contas, a.Moedas"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldosTemp")
            IF loc_nRet < 1
                MsgErro("Erro ao carregar saldos do grupo.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Transferir para cursor permanente do grid (protege colunas)
            SELECT cursor_4c_Saldos
            ZAP
            IF RECCOUNT("cursor_4c_SaldosTemp") > 0
                APPEND FROM DBF("cursor_4c_SaldosTemp")
            ENDIF
            IF USED("cursor_4c_SaldosTemp")
                USE IN cursor_4c_SaldosTemp
            ENDIF

            GO TOP IN cursor_4c_Saldos
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_SaldosTemp")
                USE IN cursor_4c_SaldosTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BuscarHistorico(par_cGrupo, par_cConta, par_cMoeda, ;
                                     par_dDataI, par_dDataF, ;
                                     par_cEmp, par_nCmbConcilia)
    *==========================================================================
    *-- Carrega CrSigMvCcr com lancamentos de SigMvCcr
    *-- par_cGrupo      : grupo conta corrente
    *-- par_cConta      : conta (codigo do cliente)
    *-- par_cMoeda      : moeda
    *-- par_dDataI/F    : intervalo de datas
    *-- par_cEmp        : empresa (vazio = todas as empresas)
    *-- par_nCmbConcilia: 0=Todos  1=N" + CHR(227) + "o conciliados  2=Conciliados
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cGruConMoe, loc_cFiltroEmp
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Chave composta gruconmoes: grupo(10) + conta(10) + moeda(3) = 23
            loc_cGruConMoe = PADR(ALLTRIM(par_cGrupo), 10) + ;
                             PADR(ALLTRIM(par_cConta), 10) + ;
                             PADR(ALLTRIM(par_cMoeda), 3)

            *-- Filtro de empresa
            loc_cFiltroEmp = ""
            IF !EMPTY(ALLTRIM(par_cEmp))
                loc_cFiltroEmp = " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmp))
            ENDIF

            *-- Consulta de lancamentos da conta no periodo (todos os registros)
            *-- Filtro de conciliacao aplicado localmente apos carga (como no original)
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                       "a.Datas, a.Dataconcs, a.Hists, a.Hist2s, a.Valors, a.Saldos, " + ;
                       "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                       "a.Concs, a.Usuconcs, a.Usualts, a.Auditors, a.DtAudits, " + ;
                       "a.Tipos, a.Vopers, a.Titulos, a.Nfs, a.Docus, " + ;
                       "a.Empos, a.SGrupos, a.Nlancs, a.GruConMoes, " + ;
                       "a.CidChaves, a.EmpCCs, a.Pagos, a.TitCancs, " + ;
                       "a.Jobs, a.Saldocs, " + ;
                       "b.RClis, b.Situas, b.Concilias " + ;
                       "FROM SigMvCcr a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.GruConMoes = " + EscaparSQL(loc_cGruConMoe) + ;
                       " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                       " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                       loc_cFiltroEmp + ;
                       " ORDER BY a.Datas, a.Nopers"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvCcrTemp")
            IF loc_nRet < 1
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Transferir para cursor permanente do grid (protege colunas)
            SELECT CrSigMvCcr
            ZAP
            IF RECCOUNT("CrSigMvCcrTemp") > 0
                APPEND FROM DBF("CrSigMvCcrTemp")
            ENDIF
            IF USED("CrSigMvCcrTemp")
                USE IN CrSigMvCcrTemp
            ENDIF

            *-- Aplicar filtro de conciliacao localmente (como no original: Delete Where Concs)
            SELECT CrSigMvCcr
            DO CASE
                CASE par_nCmbConcilia = 1
                    SET FILTER TO !Concs
                CASE par_nCmbConcilia = 2
                    SET FILTER TO Concs
                OTHERWISE
                    SET FILTER TO
            ENDCASE

            GO TOP IN CrSigMvCcr
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("CrSigMvCcrTemp")
                USE IN CrSigMvCcrTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarConciliacao(par_lConciliar, par_nNopers, ;
                                          par_cEmps, par_dDataConc)
    *==========================================================================
    *-- Concilia ou desconcilia todos os lancamentos de uma operacao
    *-- par_lConciliar: .T. = conciliar  .F. = desconciliar
    *-- par_nNopers   : numero da operacao (identifica todos os lancamentos)
    *-- par_cEmps     : empresa
    *-- par_dDataConc : data de conciliacao (usada ao conciliar)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cConcs, loc_cUsConcs, loc_cDataConcs
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            IF par_lConciliar
                loc_cConcs     = "1"
                loc_cUsConcs   = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
                loc_cDataConcs = FormatarDataSQL(par_dDataConc)
            ELSE
                loc_cConcs     = "0"
                loc_cUsConcs   = EscaparSQL("")
                loc_cDataConcs = "NULL"
            ENDIF

            *-- Atualiza todos os lancamentos da operacao (corrente + contra-partida)
            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Concs = " + loc_cConcs + ", " + ;
                       "Usuconcs = " + loc_cUsConcs + ", " + ;
                       "Dataconcs = " + loc_cDataConcs + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(par_cEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar concilia" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                THIS.this_nNopers    = par_nNopers
                THIS.this_cLancEmps  = par_cEmps
                THIS.this_lConcs     = par_lConciliar
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarAuditoria(par_lAuditar, par_nNopers, par_cEmps)
    *==========================================================================
    *-- Audita ou desaudita todos os lancamentos de uma operacao
    *-- par_lAuditar: .T. = auditar  .F. = desauditar
    *-- par_nNopers : numero da operacao
    *-- par_cEmps   : empresa
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cAuditors, loc_cDtAudits
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            IF par_lAuditar
                loc_cAuditors = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
                loc_cDtAudits = FormatarDataSQL(DATE())
            ELSE
                loc_cAuditors = EscaparSQL("")
                loc_cDtAudits = "NULL"
            ENDIF

            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Auditors = " + loc_cAuditors + ", " + ;
                       "DtAudits = " + loc_cDtAudits + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(par_cEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar auditoria.", "Erro")
            ELSE
                THIS.this_nNopers   = par_nNopers
                THIS.this_cLancEmps = par_cEmps
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDadosCliente(par_cICli)
    *==========================================================================
    *-- Carrega dados de SigCdCli para propriedades do BO
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            IF EMPTY(ALLTRIM(par_cICli))
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "SELECT IClis, RClis, Concilias " + ;
                       "FROM SigCdCli " + ;
                       "WHERE IClis = " + EscaparSQL(ALLTRIM(par_cICli))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliTemp")
            IF loc_nRet >= 1
                SELECT cursor_4c_CliTemp
                IF !EOF()
                    THIS.this_cIClis     = TratarNulo(IClis, "C")
                    THIS.this_cRClis     = TratarNulo(RClis, "C")
                    THIS.this_nConcilias = TratarNulo(Concilias, "N")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLancamento(par_cEmps, par_nNopers)
    *==========================================================================
    *-- Carrega dados de SigMvCcr para propriedades do BO pelo numero da operacao
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "SELECT Emps, Grupos, Contas, Moedas, Datas, Dataconcs, " + ;
                       "Hists, Valors, Saldos, Opers, Nopers, Numes, Dopes, " + ;
                       "Dopcs, Numcs, Concs, Usuconcs, Auditors, DtAudits, " + ;
                       "Tipos, Vopers, Empos, SGrupos " + ;
                       "FROM SigMvCcr " + ;
                       "WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
                       " AND Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " ORDER BY Nopers"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LancTemp")
            IF loc_nRet >= 1
                SELECT cursor_4c_LancTemp
                IF !EOF()
                    THIS.this_cLancEmps  = TratarNulo(Emps, "C")
                    THIS.this_cGrupos    = TratarNulo(Grupos, "C")
                    THIS.this_cContas    = TratarNulo(Contas, "C")
                    THIS.this_cMoedas    = TratarNulo(Moedas, "C")
                    THIS.this_dDatas     = TratarNulo(Datas, "D")
                    THIS.this_cHists     = TratarNulo(Hists, "C")
                    THIS.this_nSaldosCcr = TratarNulo(Saldos, "N")
                    THIS.this_cOpers     = TratarNulo(Opers, "C")
                    THIS.this_nNopers    = TratarNulo(Nopers, "N")
                    THIS.this_nNumes     = TratarNulo(Numes, "N")
                    THIS.this_cDopes     = TratarNulo(Dopes, "C")
                    THIS.this_cDopcs     = TratarNulo(Dopcs, "C")
                    THIS.this_nNumcs     = TratarNulo(Numcs, "N")
                    THIS.this_lConcs     = (TratarNulo(Concs, "N") = 1)
                    THIS.this_cUsuConcs  = TratarNulo(Usuconcs, "C")
                    THIS.this_cAuditors  = TratarNulo(Auditors, "C")
                    THIS.this_dDtAudits  = TratarNulo(DtAudits, "D")
                    THIS.this_cTipo      = TratarNulo(Tipos, "C")
                    THIS.this_cVOpers    = TratarNulo(Vopers, "C")
                    THIS.this_cSGrupos   = TratarNulo(SGrupos, "C")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_LancTemp")
                USE IN cursor_4c_LancTemp
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_LancTemp")
                USE IN cursor_4c_LancTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE ProcessaSaldo(par_cTipo, par_cGrupo, par_cMoeda, ;
                                   par_nOrdem, par_lAscendente, par_cSitua, ;
                                   par_nOptFiltro, par_lImprimeSaldoZero)
    *==========================================================================
    *-- Gera relatorio de Saldos de Conta Corrente
    *-- par_cTipo          : 'I'=Impressora  'V'=Video/Preview  'E'=Excel
    *-- par_cGrupo         : codigo do grupo
    *-- par_cMoeda         : codigo da moeda (vazio = todas)
    *-- par_nOrdem         : 1=Nome  2=Codigo  3=Saldo
    *-- par_lAscendente    : .T. = ascendente
    *-- par_cSitua         : codigo da situacao (vazio = todas)
    *-- par_nOptFiltro     : 1=Todos  2=Devedores  3=Credores
    *-- par_lImprimeSaldoZero: .T. = inclui contas com saldo zero
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cFiltroMoeda, loc_cFiltroSitua, loc_cFiltroSaldo
        LOCAL loc_cOrdem, loc_cDirecao, loc_cArqRel, loc_cSaida
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Filtros opcionais
            loc_cFiltroMoeda = ""
            IF !EMPTY(ALLTRIM(par_cMoeda))
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(ALLTRIM(par_cMoeda))
            ENDIF

            loc_cFiltroSitua = ""
            IF !EMPTY(ALLTRIM(par_cSitua))
                loc_cFiltroSitua = " AND b.Situas = " + EscaparSQL(ALLTRIM(par_cSitua))
            ENDIF

            DO CASE
                CASE par_nOptFiltro = 2
                    loc_cFiltroSaldo = " AND a.Saldos > 0"
                CASE par_nOptFiltro = 3
                    loc_cFiltroSaldo = " AND a.Saldos < 0"
                OTHERWISE
                    loc_cFiltroSaldo = IIF(!par_lImprimeSaldoZero, " AND a.Saldos <> 0", "")
            ENDCASE

            *-- Criterio de ordenacao
            DO CASE
                CASE par_nOrdem = 2
                    loc_cOrdem = "a.Contas"
                CASE par_nOrdem = 3
                    loc_cOrdem = "a.Saldos"
                OTHERWISE
                    loc_cOrdem = "b.RClis"
            ENDCASE
            loc_cDirecao = IIF(par_lAscendente, " ASC", " DESC")

            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                       "b.RClis, b.Situas, b.Cpfs, b.ContaMats " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                       loc_cFiltroMoeda + loc_cFiltroSitua + loc_cFiltroSaldo + ;
                       " ORDER BY " + loc_cOrdem + loc_cDirecao

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelSaldo")
            IF loc_nRet < 1
                MsgErro("Erro ao gerar dados do relat" + CHR(243) + "rio.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Definir tipo de saida e arquivo
            loc_cArqRel = gc_4c_CaminhoReports + "RelSigOpIndSaldo.frx"
            DO CASE
                CASE par_cTipo = "I"
                    loc_cSaida = "TO PRINTER PROMPT NOCONSOLE"
                CASE par_cTipo = "E"
                    loc_cSaida = "TO FILE " + gc_4c_CaminhoBase + "RelSaldo.xls TYPE XL5 PROMPT NOCONSOLE"
                OTHERWISE
                    loc_cSaida = "PREVIEW NOCONSOLE"
            ENDCASE

            REPORT FORM (loc_cArqRel) &loc_cSaida

            IF USED("cursor_4c_RelSaldo")
                USE IN cursor_4c_RelSaldo
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_RelSaldo")
                USE IN cursor_4c_RelSaldo
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE ProcessaHist(par_cTipo, par_cGrupo, par_cConta, ;
                                  par_cMoeda, par_dDataI, par_dDataF, ;
                                  par_cEmp, par_cGetOper, par_nCmbConcilia, ;
                                  par_lChkGrupo, par_lCheckSalto, ;
                                  par_lCheckSAnt, par_lCheckRazaoCP, ;
                                  par_lCheckRazaoDoc, par_lCheckComissao, ;
                                  par_lCheckSaldoa, par_lChkTaxas, ;
                                  par_lChkRelDets, par_nOptSNA, ;
                                  par_lChkOcultaCta)
    *==========================================================================
    *-- Gera relatorio de Historico de Conta Corrente
    *-- par_cTipo    : 'I'=Impressora  'V'=Video/Preview  'E'=Excel
    *-- par_lChkGrupo: .T. = todas as contas do grupo / .F. = conta individual
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cGruConMoe, loc_cFiltroEmp, loc_cFiltroOper
        LOCAL loc_cEscopo, loc_cArqRel, loc_cSaida
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Validacoes obrigatorias
            IF EMPTY(ALLTRIM(par_cMoeda))
                MsgAviso("A Moeda N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF EMPTY(par_dDataI)
                MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF EMPTY(par_dDataF)
                MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF par_dDataF < par_dDataI
                MsgAviso("Data Final menor que Data Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Chave composta gruconmoes: grupo(10) + conta(10) + moeda(3)
            loc_cGruConMoe = PADR(ALLTRIM(par_cGrupo), 10) + ;
                             PADR(ALLTRIM(par_cConta), 10) + ;
                             PADR(ALLTRIM(par_cMoeda), 3)

            *-- Filtros opcionais
            loc_cFiltroEmp = ""
            IF !EMPTY(ALLTRIM(par_cEmp))
                loc_cFiltroEmp = " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmp))
            ENDIF

            loc_cFiltroOper = ""
            IF !EMPTY(ALLTRIM(par_cGetOper)) AND !ALLTRIM(par_cGetOper) = " "
                loc_cFiltroOper = " AND a.Opers = " + EscaparSQL(UPPER(ALLTRIM(par_cGetOper)))
            ENDIF

            *-- Escopo: conta individual ou todas do grupo
            IF par_lChkGrupo
                loc_cEscopo = "a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                              " AND a.Moedas = " + EscaparSQL(ALLTRIM(par_cMoeda))
            ELSE
                loc_cEscopo = "a.GruConMoes = " + EscaparSQL(loc_cGruConMoe)
            ENDIF

            *-- Ordenacao: por conta (grupo) ou por data (individual)
            *-- Filtro de conciliacao aplicado localmente apos carga (como no original)
            IF par_lChkGrupo
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                           "a.Datas, a.Dataconcs, a.Hists, a.Valors, a.Saldos, " + ;
                           "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                           "a.Concs, a.Usuconcs, a.Auditors, a.DtAudits, a.Tipos, " + ;
                           "a.Vopers, a.Titulos, a.Nfs, a.Empos, b.RClis " + ;
                           "FROM SigMvCcr a " + ;
                           "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                           "WHERE " + loc_cEscopo + ;
                           " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                           " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                           loc_cFiltroEmp + loc_cFiltroOper + ;
                           " ORDER BY a.Contas, a.Datas, a.Nopers"
            ELSE
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                           "a.Datas, a.Dataconcs, a.Hists, a.Valors, a.Saldos, " + ;
                           "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                           "a.Concs, a.Usuconcs, a.Auditors, a.DtAudits, a.Tipos, " + ;
                           "a.Vopers, a.Titulos, a.Nfs, a.Empos, b.RClis " + ;
                           "FROM SigMvCcr a " + ;
                           "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                           "WHERE " + loc_cEscopo + ;
                           " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                           " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                           loc_cFiltroEmp + loc_cFiltroOper + ;
                           " ORDER BY a.Datas, a.Nopers"
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelHistorico")
            IF loc_nRet < 1
                MsgErro("Erro ao gerar dados do relat" + CHR(243) + "rio.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Aplicar filtro de conciliacao localmente (como no original: Delete Where Concs)
            SELECT cursor_4c_RelHistorico
            DO CASE
                CASE par_nCmbConcilia = 1
                    SET FILTER TO !Concs
                CASE par_nCmbConcilia = 2
                    SET FILTER TO Concs
                OTHERWISE
                    SET FILTER TO
            ENDCASE
            GO TOP

            *-- Arquivo de relatorio e tipo de saida
            loc_cArqRel = gc_4c_CaminhoReports + "RelSigOpIndHist.frx"
            DO CASE
                CASE par_cTipo = "I"
                    loc_cSaida = "TO PRINTER PROMPT NOCONSOLE"
                CASE par_cTipo = "E"
                    loc_cSaida = "TO FILE " + gc_4c_CaminhoBase + "RelHistorico.xls TYPE XL5 PROMPT NOCONSOLE"
                OTHERWISE
                    loc_cSaida = "PREVIEW NOCONSOLE"
            ENDCASE

            REPORT FORM (loc_cArqRel) &loc_cSaida

            IF USED("cursor_4c_RelHistorico")
                USE IN cursor_4c_RelHistorico
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_RelHistorico")
                USE IN cursor_4c_RelHistorico
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

