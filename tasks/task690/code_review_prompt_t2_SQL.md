# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, ICLIS, CONTAS, IFORS, TPCUSTOS, _FAZEST, GRUPODS, CONTADS, DATAS, GRUPOOS, CONTAOS, LCEMPRESA, EMPDOPNUMS, CPROS, TIPOOPS, CAIXAS, EMPS, DOPES, GERGDMIS, EMPGRUESTS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, TIPOS, GRUCONMOES, NUMES, OPERS, NOPERS, LLSUPERV, _RECNO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, ICLIS, CONTAS, IFORS, TPCUSTOS, _FAZEST, GRUPODS, CONTADS, DATAS, GRUPOOS, CONTAOS, LCEMPRESA, EMPDOPNUMS, CPROS, TIPOOPS, CAIXAS, EMPS, DOPES, GERGDMIS, EMPGRUESTS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, TIPOS, GRUCONMOES, NUMES, OPERS, NOPERS, LLSUPERV, _RECNO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, ICLIS, CONTAS, IFORS, TPCUSTOS, _FAZEST, GRUPODS, CONTADS, DATAS, GRUPOOS, CONTAOS, LCEMPRESA, EMPDOPNUMS, CPROS, TIPOOPS, CAIXAS, EMPS, DOPES, GERGDMIS, EMPGRUESTS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, TIPOS, GRUCONMOES, NUMES, OPERS, NOPERS, LLSUPERV, _RECNO

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
  Column1.ControlSource = "dbsaldo.moedas"
  Column2.ControlSource = "dbsaldo.saldos"
  ControlSource = "dbsaldo.moedas"
  ControlSource = "dbsaldo.saldos"
  DeleteMark = .F.
  Column1.ControlSource = "dbhistorico.datas"
  Column2.ControlSource = "dbhistorico.valors"
  Column3.ControlSource = "dbhistorico.opers"
  Column4.ControlSource = "dbhistorico.saldos"
  Column5.ControlSource = "dbhistorico.vencs"
  Column6.ControlSource = "dbhistorico.emps"
  Column7.ControlSource = "dbhistorico.Nfs"
  Column8.ControlSource = 'Iif(dbHistorico.Valors - dbHistorico.ValPags = 0, "*","")'
  ControlSource = "dbhistorico.datas"
  ControlSource = "dbhistorico.valors"
  ControlSource = "dbhistorico.opers"
  ControlSource = "dbhistorico.saldos"
  ControlSource = "dbhistorico.vencs"
  ControlSource = "dbhistorico.emps"
  ControlSource = "dbhistorico.nfs"
  ControlSource = "dbHistorico.Hists"
  ControlSource = "dbHistorico.Hist2s"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = ""
  ControlSource = "dbproduto.cpros"
  ControlSource = "dbproduto.dopes"
  ControlSource = "dbproduto.qtds"
  DeleteMark = .F.
  Column1.ControlSource = "cpros"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "custofs"
  Column3.ControlSource = "moecusfs"
  Column4.ControlSource = "marca"
  Column5.ControlSource = "DbProdFor.QtVend"
  Column6.ControlSource = "DbProdFor.VlVend"
  Column7.ControlSource = "DbProdFor.Estoque"
  Column8.ControlSource = "DbProdFor.PVens"
  Column9.ControlSource = "DbProdFor.Moedas"
  Column10.ControlSource = "reffs"
  ControlSource = "dbproduto.qtds"
  ControlSource = "DbProdFor.QtVend"
  ControlSource = "DbProdFor.VlVend"
  ControlSource = "DbProdFor.Estoque"
  ControlSource = "DbProdFor.PVens"
  ControlSource = "DbProdFor.Moedas"
  DeleteMark = .F.
  Column1.ControlSource = "DbOperaProd.Dopes"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "DbOperaProd.Valos"
  Column3.ControlSource = "DbOperaProd.Qtds"
  ControlSource = "DbOperaProd.Dopes"
  ControlSource = "DbOperaProd.Valos"
  ControlSource = "DbOperaProd.Qtds"
  DeleteMark = .F.
  Column1.ControlSource = "CPROS"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "SQTDS"
  ControlSource = "dbproduto.cpros"
  ControlSource = "dbproduto.qtds"
  DeleteMark = .F.
  Column1.ControlSource = "dbParcela.valos"
  Column2.ControlSource = "dbParcela.moefpgs"
  Column3.ControlSource = "dbParcela.vencs"
  Column4.ControlSource = "dbParcela.hists"
  ControlSource = "dbParcela.valos"
  ControlSource = "dbParcela.moefpgs"
  ControlSource = "dbParcela.vencs"
  ControlSource = "dbParcela.hists"
  DeleteMark = .F.
  Column1.ControlSource = "dbParcela.fpags"
  Column2.ControlSource = "dbParcela.valos"
  Column3.ControlSource = "dbParcela.moefpgs"
  Column4.ControlSource = "dbParcela.vencs"
  Column5.ControlSource = "dbParcela.hists"
  ControlSource = "dbParcela.fpags"
  ControlSource = "dbParcela.valos"
  ControlSource = "dbParcela.moefpgs"
  ControlSource = "dbParcela.vencs"
  ControlSource = "dbParcela.hists"
  DeleteMark = .F.
  Column1.ControlSource = "datas"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "emps"
  Column3.ControlSource = "opers"
  Column4.ControlSource = "obscon"
  ControlSource = ""
  ControlSource = ""
	lStrQuery = [Select iclis, rclis, endes, bairs, cidas, ceps, estas, tel1s, tel2s, faxs, cpfs, rgs, figjpgs ]+;
				[From SigCdCli ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpCli')
		Select TmpCli
	Select dbSaldo
	lStrQuery = [Select grupos,contas,moedas,saldos From SigMvSlc ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpSccr')
	Select TmpSccr
		Insert Into dbSaldo From MemVar
	Select dbSaldo
	Select dbHistorico
	lStrQuery = [Select emps,grupos,contas,datas,moedas,saldos,valors,opers,hists,hist2s,vencs,valpags,nfs ]+;
				[From SigMvCcr Where grupos = ']+lcGrEst+[' And contas = ']+lcCdConta+[' ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpMccr1')
	Select TmpMccr1
		Insert Into dbHistorico From MemVar
	Select dbHistorico
	Select dbProdFor
	lStrQuery = [Select cpros,dpros,custofs,moecusfs,cunis,pvens,moedas,reffs,pesoms,linhas,situas ]+;
				[From SigCdPro Where ifors = ']+lcCdConta+[' ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpPro')
	Select TmpPro
		If Seek(TmpPro.linhas,'CrSigCdLin','Linhas') And CrSigCdLin.tpcustos = '2'
		Insert Into dbProdFor From MemVar
	Select dbResumo
	Select dbOperaProd
				lStrQuery = [Select emps, dopes, numes, valos From SigMvCab ]+;
				lStrQuery = [Select emps, dopes, numes, valos From SigMvCab ]+;
			lnQueryOk = ThisForm.podataMgr.SqlExecute(lStrQuery, 'TprMvCab1')
			Select TprMvCab1
				loBarEest.Update(.T.,'Operação: ' + TprMvCab1.dopes)
				=Seek(TprMvCab1.dopes,'CrSigCdOpe','Dopes')
				If !Empty(CrSigCdOpe.cmoes) And Seek(CrSigCdOpe.cmoes,'CrSigCdCot','cmoes')
				If !Seek(TprMvCab1.dopes,'dbResumo','Dopes')
					Insert Into dbResumo (dopes) Values (TprMvCab1.dopes)
				lStrQuery = [Select cpros, qtds, moefats, moedas, tpesos, totas From SigMvItn ]+;
				lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TprMvCabi1')
				Select TprMvCabi1
					lStrQuery = [Select cpros, ifors, custofs, moecusfs, pvens, reffs, dpros, cunis, moedas, situas ]+;
								[From SigCdPro ]+;
					lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpProFor')
					If !Seek(TprMvCabi1.cpros + TprMvCab1.dopes,'dbOperaProd')
						Insert Into dbOperaProd (cpros,dopes) Values (TprMvCabi1.cpros,TprMvCab1.dopes)
					If !Seek(TprMvCabi1.cpros,'dbProdFor')
						Select TmpProFor
						Insert Into dbProdFor From MemVar
					Select TprMvCabi1
				Select TprMvCab1
	Select dbResumo
	Select dbProdFor
	Select dbOperaProd 
		Select CrSigCdPam
			lStrQuery = [Select b.Opers, b.emps, b.dopes, b.numes, b.cpros, b.qtds, b.totas, b.moedas, ] + ;
						  [From SigMvCab a, SigMvItn b, SigCdOpe c, SigCdTom t ] + ;
			lStrQuery = [Select b.Opers, b.emps, b.dopes, b.numes, b.cpros, b.qtds, b.totas, b.moedas, ] + ;
						  [From SigMvCab a, SigMvItn b, SigCdOpe c, SigCdTom t ] + ;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TprMvCabi2')
		Select TprMvCabi2
			loBarraMov.Update(.T.,TprMvCabi2.emps + ' - ' + TprMvCabi2.dopes + ' - ' + Str(TprMvCabi2.numes,6))
			Select dbProdFor
			If Seek(TprMvCabi2.cpros)
				Select dbOperaProd
				If !Seek(TprMvCabi2.cpros + TprMvCabi2.dopes)
					Insert Into dbOperaProd (cpros,dopes) Values (TprMvCabi2.cpros,TprMvCabi2.dopes)
				If !Seek(TprMvCabi2.dopes,'dbResumo','Dopes')
					Insert Into dbResumo (dopes) Values (TprMvCabi2.dopes)
				lStrQuery = [Select cpros, ifors, custofs, moecusfs From SigCdPro Where cpros = ']+TprMvCabi2.cpros+[' ]
				lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpPro2')
				Select TmpPro2
			Select TprMvCabi2
		Select CrSigCdEmp
			loBarraEmp.Update(.T.,'Empresa: ' + Alltrim(CrSigCdEmp.cemps) + ' - ' + Alltrim(CrSigCdEmp.razas))
				lStrQuery = [Select emps, cpros, sqtds ]+;
							[From SigMvEst ]+;
				lnQueryOk = ThisForm.podataMgr.SqlExecute(lStrQuery, 'TmpEst1')
				Select TmpEst1
				Select dbProdFor
					Select TmpEst1
					If Seek(CrSigCdEmp.cemps + dbProdFor.cpros,'TmpEst1','EmpPro')
					Select dbProdFor
			Select CrSigCdEmp
		=Seek(lcEmpresa,'CrSigCdEmp','cemps')
		lStrQuery = [Select emps, cpros, sqtds From SigMvEst Where empgruests = ']+lcEGEs+[' Order By emps, cpros, sqtds ]
		lnQueryOk = ThisForm.podataMgr.SqlExecute(lStrQuery, 'TmpEst1')
		Select TmpEst1
		Select dbProdFor
			Select TmpEst1
			If Seek(CrSigCdEmp.cemps + dbProdFor.cpros,'TmpEst1','EmpPro')
			Select dbProdFor
	Select dbEstoque
	Select CrSigCdEmp
		loBarraEmp.Update(.T.,'Empresa: ' + Alltrim(CrSigCdEmp.cemps) + ' - ' + Alltrim(CrSigCdEmp.razas))
			lStrQuery = [Select cpros, sqtds From SigMvEst Where empgruests = ']+lcEGEs+[' Order By cpros, sqtds ]
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpEst2')
			Select TmpEst2
				Insert Into dbEstoque (cpros,sqtds) Values (TmpEst2.cpros,TmpEst2.sqtds)
		Select CrSigCdEmp
	Select dbEstoque
	Select dbConserto
	Select CrSigCdPam
	lStrQuery = [Select emps, dopes, numes, datas, chksubn, obses, MascNum ]+;
				[From SigMvCab ]+;
	lnQueryOk = ThisForm.podataMgr.SqlExecute(lStrQuery, 'TprMvCab3')
	Select TprMvCab3
			Insert Into dbConserto From MemVar
	lStrQuery = [Select emps, dopes, numes, datas, chksubn, obses, mascNum ]+;
				[From SigMvCab ]+;
	lnQueryOk = ThisForm.podataMgr.SqlExecute(lStrQuery, 'TprMvCab4')
	Select TprMvCab4
			Insert Into dbConserto From MemVar
	Select dbConserto
	Select dbParcela
	Delete All
	lStrQuery = [Select emps, dopes, numes ]+;
				[From SigMvCab ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TprMvCab5')
	Select TprMvCab5
		=Seek(TprMvCab5.dopes,'CrSigCdOpe','Dopes')
		lStrQuery = [Select emps, dopes, numes, bancos, agencias, contas, numeros, fpags, valos, vpags, vencs, moefpgs ]+;
					[From SigMvPar ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpPar1')
		Select TmpPar1
			=Seek(m.fpags,'CrSigOpFp','FPags')
				lStrQuery = [Select umovs From SigChe ]+;
				lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpChe1')
				Select TmpChe1
					If Seek(TmpChe1.umovs,'CrSigCdOpt','Operacaos') And CrSigCdOpt.tipos <> 'CR'
				Insert Into dbParcela From MemVar
	lStrQuery = [Select emps, dopes, numes ]+;
				[From SigMvCab ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TprMvCab6')
	Select TprMvCab6
		=Seek(TprMvCab6.dopes,'CrSigCdOpe','Dopes')
		lStrQuery = [Select emps, dopes, numes, bancos, agencias, contas, numeros, fpags, valos, vpags, vencs, moefpgs ]+;
					[From SigMvPar ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpPar2')
		Select TmpPar2
			=Seek(m.fpags,'CrSigOpFp','FPags')
				lStrQuery = [Select umovs From SigChe ]+;
				lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpChe2')
				Select TmpChe2
					If Seek(TmpChe2.umovs,'CrSigCdOpt','Operacaos') And CrSigCdOpt.tipos <> 'CR'
				Insert Into dbParcela From MemVar
	lStrQuery = [Select emps, dopes, numes, hists, vencs, moedas As moefpgs, opers, nopers, valors, valpags ]+;
				[From SigMvCcr ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpMccr2')
	Select TmpMccr2
			Insert Into dbParcela From MemVar
			Select dbParcela
		Select TmpMccr2
	Select dbParcela
	=Seek(lcGrEst,'CrSigCdGcr','Codigos')
Select Sum(custofs * estoque) As custofs, moecusfs From dbProdFor Group by moecusfs Into Cursor TmpTot1
Select Sum(pvens * estoque) As pvens, moedas From dbProdFor Group by moedas Into Cursor TmpTot2
Select 4 As coluna, Padr(Replicate(Chr(255),2),14) As cpros, c.custofs, c.moecusfs, Space(1) As marca, 0 As qtvend,;
From TmpTot1 c ;
Full Join TmpTot2 v On c.moecusfs = v.moedas ;
		Select 1 As coluna, a.*, b.dopes, b.qtds, b.valos, _Fornece As fornece ;
		From dbProdFor a ;
		Left Join dbOperaProd b On a.cpros = b.cpros ;
		Select 1 As coluna, a.*, b.dopes, b.qtds, b.valos, _Fornece As fornece ;
		From dbProdFor a ;
		Left Join dbOperaProd b On a.cpros = b.cpros ;
		Select 2 As coluna, Space(14) As cpros, c.custofs, Space(3) As moecusfs, Space(1) As marca, 0 As qtvend,;
		From dbResumo c ;
		Select 3 As coluna, Padr(Chr(255),14) As cpros, 0 As custofs, Space(3) As moecusfs, Space(1) As marca,;
		From dbProdFor d ;
		Select e.coluna, e.cpros, Iif(IsNull(e.custofs),0,e.custofs) As custofs, Iif(IsNull(e.moecusfs),Space(3),e.moecusfs) As moecusfs,;
		From TmpTot3 e ;
		Select 1 As coluna, a.*, b.dopes, b.qtds , b.valos, _Fornece As fornece ;
		From dbProdFor a, dbOperaProd b ;
		Select 2 As coluna, Space(14) As cpros, c.custofs, Space(3) As moecusfs, Space(1) As marca, 0 As qtvend,;
		From dbResumo c ;
		Select 3 As coluna, Padr(Chr(255),14) As cpros, 0 As custofs, Space(3) As moecusfs, Space(1) As marca,;
		From dbProdFor d ;
		Select e.coluna, e.cpros, Iif(IsNull(e.custofs),0,e.custofs) As custofs,Iif(IsNull(e.moecusfs),Space(3),e.moecusfs) As moecusfs,;
		From TmpTot3 e ;
	Select [ ] as Agrupar,Sum(estoque) As TEstoque, Sum(estoque * (custofs * fCarregarCambio(moecusfs,Date()) / fCarregarCambio(_Moeda,Date()))) As TCusto,;
	From dbProdFor ;
lStrQuery = [Select * From SigCdPam ]
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CrSigCdPam')
Select CrSigCdPam
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cemps,razas,ativas From SigCdEmp ], 'CrSigCdEmp')
Select CrSigCdEmp
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select usuarios, supervis From SigCdUsu Where Not cAtivos='N'], 'CrUsuarios')
Select CrUsuarios
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select codigos, tpcads, mfotos From SigCdGcr ], 'CrSigCdGcr')
Select CrSigCdGcr
lcQuery = [Select a.Dopes, a.Cmoes, a.Caixas, a.TipoOps, a.Pesovts, a.Precovts, a.Valpends, b.GerGdmis ] + ;
		    [From SigCdOpe a, SigCdTom b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
Select crSigCdOpe
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select operacaos, tipos From SigCdOpt ], 'CrSigCdOpt')
Select CrSigCdOpt
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select fpags, infos, valpends From SigOpFp ], 'CrSigOpFp')
Select CrSigOpFp
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdMoe ],'CrSigCdMoe')
Select CrSigCdMoe
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot')
Select CrSigCdCot
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select linhas, tpcustos From SigCdLin ],'CrSigCdLin')
Select CrSigCdLin
	Select CrSigCdGcr
			Select CqSigCdCli
			Select CqSigCdCli
			Select CrClientes
		!Seek(This.Parent.Parent.Origem.Get_Grupo.Value,'CrSigCdGcr','codigos')
		!Seek(This.Parent.Parent.Get_Moeda.Value,'CrSigCdMoe','cmoes')
	Select CrUsuarios
	=Seek(Usuar,'CrUsuarios','Usuarios')
		.DeleteMark     = .F.
		.Column1.ControlSource     = 'dbHistorico.emps'
		.Column2.ControlSource     = 'dbHistorico.datas'
		.Column3.ControlSource     = 'dbHistorico.valors'
		.Column4.ControlSource     = 'dbHistorico.opers'
			.Column5.ControlSource     = 'dbHistorico.saldos'
			.Column6.ControlSource     = 'dbHistorico.vencs'
			.Column7.ControlSource     = 'dbHistorico.nfs'
			.Column8.ControlSource     = [Iif(dbHistorico.valors - dbHistorico.valpags = 0,'*','')]
			.Column5.ControlSource     = 'dbHistorico.vencs'
			.Column6.ControlSource     = 'dbHistorico.nfs'
			.Column7.ControlSource     = [Iif(dbHistorico.valors - dbHistorico.valpags = 0,'*','')]
		.DeleteMark       = .F.
		.Column1.ControlSource     = 'dbSaldo.moedas'
			.Column2.ControlSource     = 'dbSaldo.saldos'
	Select dbHistorico
		!Seek(This.Parent.Parent.Origem.Get_Grupo.Value,'CrSigCdGcr','codigos')
		!Seek(This.Parent.Parent.Get_Moeda.Value,'CrSigCdMoe','cmoes')
Select dbProdFor
Select dbProdFor
Select dbProdFor
Select dbProdFor
Select dbProdFor
Select dbProdFor
Select dbProdFor
Select dbProdFor
Select dbProdFor
lnQueryOk = ThisFOrm.poDataMgr.SqlExecute([Select figjpgs From SigCdPro Where cpros = ']+dbEstoque.cpros+[' ],'TmpPro')
Select TmpPro
Select TmpRelat
Select TmpRelat

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgc.prg) - TRECHOS RELEVANTES PARA PASS SQL (3822 linhas total):

*-- Linhas 1270 a 1288:
1270:     * Os grids sao ligados aos cursores AQUI porque os 8 cursores locais ja
1271:     * existem neste ponto: o BO eh instanciado no inicio de InicializarForm e
1272:     * cria todos em InicializarCursoresDados. Column.Width vem DEPOIS de
1273:     * RecordSource/ControlSource, que resetam a largura para o default 90.
1274:     *==========================================================================
1275:     PROTECTED PROCEDURE ConfigurarPaginaResultado(par_oPag)
1276:         LOCAL loc_oPgf
1277: 
1278:         par_oPag.AddObject("pgf_4c_Result", "PageFrame")
1279:         loc_oPgf = par_oPag.pgf_4c_Result
1280: 
1281:         WITH loc_oPgf
1282:             .PageCount = 5
1283:             .Top       = 186
1284:             .Left      = 59
1285:             .Width     = 701
1286:             .Height    = 421
1287:             .Tabs      = .T.
1288: 

*-- Linhas 1343 a 1361:
1343:     PROTECTED PROCEDURE FormatarGradeResultado(par_oGrid)
1344:         WITH par_oGrid
1345:             .ReadOnly         = .T.
1346:             .DeleteMark       = .F.
1347:             .RecordMark       = .F.
1348:             .ScrollBars       = 2
1349:             .RecordSourceType = 1
1350:             .GridLineColor    = RGB(238, 238, 238)
1351:             .FontName         = "Tahoma"
1352:             .FontSize         = 8
1353:         ENDWITH
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     * ConfigurarAbaSaldo - Page "Saldo" do Result: historico de conta corrente
1358:     * (grade FILHA da grade de saldos pela moeda), saldo por moeda, os dois
1359:     * campos de historico da linha corrente e o botao de impressao do extrato.
1360:     *==========================================================================
1361:     PROTECTED PROCEDURE ConfigurarAbaSaldo(par_oPage)

*-- Linhas 1453 a 1514:
1453:             .Width  = 653
1454:             .Height = 220
1455:             .RecordMark   = .F.
1456:             .DeleteMark   = .F.
1457:         ENDWITH
1458: 
1459:         par_oPage.AddObject("grd_4c_Saldo", "Grid")
1460:         WITH par_oPage.grd_4c_Saldo
1461:             .Top    = 274
1462:             .Left   = 14
1463:             .Width  = 156
1464:             .Height = 112
1465:             .RecordMark   = .F.
1466:             .DeleteMark   = .F.
1467:         ENDWITH
1468: 
1469:         *-- Get_Hists / Get_Hist2s: exibem o historico da linha corrente da
1470:         *-- grade. ReadOnly porque o When do legado devolve .F. (o campo
1471:         *-- nunca recebe foco).
1472:         par_oPage.AddObject("txt_4c_Hists", "TextBox")
1473:         WITH par_oPage.txt_4c_Hists
1474:             .Top           = 276
1475:             .Left          = 187
1476:             .Width         = 401
1477:             .Height        = 23
1478:             .FontName      = "Tahoma"
1479:             .FontSize      = 8
1480:             .ReadOnly      = .T.
1481:             .TabStop       = .F.
1482:             .ForeColor     = RGB(0, 0, 0)
1483:             .BackColor     = RGB(255, 255, 255)
1484:             .ControlSource = "cursor_4c_Historico.hists"
1485:         ENDWITH
1486: 
1487:         par_oPage.AddObject("txt_4c_Hist2s", "TextBox")
1488:         WITH par_oPage.txt_4c_Hist2s
1489:             .Top           = 299
1490:             .Left          = 187
1491:             .Width         = 401
1492:             .Height        = 23
1493:             .FontName      = "Tahoma"
1494:             .FontSize      = 8
1495:             .ReadOnly      = .T.
1496:             .TabStop       = .F.
1497:             .ForeColor     = RGB(0, 0, 0)
1498:             .BackColor     = RGB(255, 255, 255)
1499:             .ControlSource = "cursor_4c_Historico.hist2s"
1500:         ENDWITH
1501: 
1502:         *-- btnImprimir: abre o relatorio SigReCgc do fornecedor (legado:
1503:         *-- "Do Form SigReCgc With Get_Grupo.Value, Get_Conta.Value")
1504:         par_oPage.AddObject("cmd_4c_ImprimirExtrato", "CommandButton")
1505:         WITH par_oPage.cmd_4c_ImprimirExtrato
1506:             .Top             = 277
1507:             .Left            = 618
1508:             .Width           = 40
1509:             .Height          = 40
1510:             .FontName        = "Verdana"
1511:             .FontSize        = 8
1512:             .WordWrap        = .T.
1513:             .Caption         = ""
1514:             .ToolTipText     = "Imprimir"

*-- Linhas 1534 a 1553:
1534:     * historico tem 8 colunas (inclui Saldo) e a de moedas tem 2; sem acesso,
1535:     * 7 e 1, a moldura encolhe 94px e o titulo muda de "Saldo por Moeda" para
1536:     * "Moedas". Como mexer em ColumnCount RECRIA os objetos Column, toda a
1537:     * configuracao (ControlSource / Width / Header) eh refeita aqui - e a
1538:     * Width sempre DEPOIS do ControlSource, que a reseta para o default 90.
1539:     *
1540:     * llSaldo transcrito do legado:
1541:     *     llSaldo = !fChecaAcesso('SIGOPCGC','SALDO') Or llSupervis
1542:     * ATENCAO: o "!" eh do legado e esta preservado (regra #17 - nao inverter
1543:     * sinal de regra de negocio). Como fChecaAcesso em utils\functions.prg eh
1544:     * um stub que devolve SEMPRE .T., o efeito pratico hoje eh: coluna Saldo
1545:     * visivel apenas para o usuario 4CONTROL. Se a intencao do negocio for o
1546:     * contrario, a correcao eh de UMA linha aqui - mas inverter sem confirmar
1547:     * exporia saldo financeiro a quem o legado esconde.
1548:     *==========================================================================
1549:     PROTECTED PROCEDURE ConfigurarGradesSaldo()
1550:         LOCAL loc_oPage, loc_oGrdH, loc_oGrdS, loc_lSaldo, loc_lSupervis, loc_nCol
1551: 
1552:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
1553:         loc_oGrdH = loc_oPage.grd_4c_Historico

*-- Linhas 1629 a 1653:
1629:     *==========================================================================
1630:     * ConfigurarColunaResultado - aplica de uma vez as propriedades que toda
1631:     * coluna de grade de resultado recebe. A Width eh atribuida DEPOIS do
1632:     * ControlSource de proposito: mexer no ControlSource reseta a largura para
1633:     * o default 90.
1634:     *==========================================================================
1635:     PROTECTED PROCEDURE ConfigurarColunaResultado(par_oCol, par_cFonte, ;
1636:             par_nWidth, par_cCaption, par_nAlinhaHeader, par_cFormat, par_cMask)
1637:         WITH par_oCol
1638:             .ControlSource = par_cFonte
1639:             .Width         = par_nWidth
1640:             .Movable       = .F.
1641:             .Resizable     = .F.
1642:             .ReadOnly      = .T.
1643:             .FontName      = "Tahoma"
1644:             .FontSize      = 8
1645: 
1646:             IF !EMPTY(par_cFormat)
1647:                 .Format = par_cFormat
1648:             ENDIF
1649:             IF !EMPTY(par_cMask)
1650:                 .InputMask = par_cMask
1651:             ENDIF
1652: 
1653:             .Header1.Caption   = par_cCaption

*-- Linhas 1880 a 1902:
1880:             .Caption    = " Total por Opera" + CHR(231) + CHR(227) + "o "
1881:         ENDWITH
1882: 
1883:         *-- No SCX as Columns de grd_resumo ficaram com ControlSource VAZIO e
1884:         *-- os Text1 internos apontando para um alias "dbproduto" que nao
1885:         *-- existe neste form (residuo de copia de outra grade). As ligacoes
1886:         *-- abaixo vem dos captions dos headers e da estrutura de dbResumo -
1887:         *-- deixar o ControlSource vazio exibiria a grade em branco.
1888:         par_oPage.AddObject("grd_4c_Resumo", "Grid")
1889:         loc_oGrd = par_oPage.grd_4c_Resumo
1890:         loc_oGrd.ColumnCount  = 3
1891:         loc_oGrd.RecordSource = "cursor_4c_Resumo"
1892:         WITH loc_oGrd
1893:             .Top          = 180
1894:             .Left         = 14
1895:             .Width        = 320
1896:             .Height       = 113
1897:             THIS.FormatarGradeResultado(loc_oGrd)
1898:             .Highlight    = .T.
1899:             .HighlightRow = .T.
1900: 
1901:             THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Resumo.dopes", ;
1902:                 150, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")

*-- Linhas 2410 a 2452:
2410:                 IF USED("cursor_4c_VldGrp")
2411:                     USE IN cursor_4c_VldGrp
2412:                 ENDIF
2413:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2414:                     "SELECT TOP 1 codigos FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2415:                     "cursor_4c_VldGrp")
2416:                 IF loc_nResult <= 0 OR !USED("cursor_4c_VldGrp") OR EOF("cursor_4c_VldGrp")
2417:                     loc_lValido = .F.
2418:                     loc_cMsg    = "Grupo de Estoque Inv" + CHR(225) + "lido !!!"
2419:                     loc_oFoco   = loc_oOrigem.txt_4c_Grupo
2420:                 ENDIF
2421:                 IF USED("cursor_4c_VldGrp")
2422:                     USE IN cursor_4c_VldGrp
2423:                 ENDIF
2424:             ENDIF
2425: 
2426:             IF loc_lValido AND EMPTY(loc_cConta)
2427:                 loc_lValido = .F.
2428:                 loc_cMsg    = "Conta de Estoque Inv" + CHR(225) + "lida !!!"
2429:                 loc_oFoco   = loc_oOrigem.txt_4c_Conta
2430:             ENDIF
2431: 
2432:             IF loc_lValido
2433:                 IF USED("cursor_4c_VldCta")
2434:                     USE IN cursor_4c_VldCta
2435:                 ENDIF
2436:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2437:                     "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
2438:                     "cursor_4c_VldCta")
2439:                 IF loc_nResult <= 0 OR !USED("cursor_4c_VldCta") OR EOF("cursor_4c_VldCta")
2440:                     loc_lValido = .F.
2441:                     loc_cMsg    = "Conta de Estoque Inv" + CHR(225) + "lida !!!"
2442:                     loc_oFoco   = loc_oOrigem.txt_4c_Conta
2443:                 ENDIF
2444:                 IF USED("cursor_4c_VldCta")
2445:                     USE IN cursor_4c_VldCta
2446:                 ENDIF
2447:             ENDIF
2448: 
2449:             IF loc_lValido AND loc_oPag.obj_4c_Opt_Analise.Value = 1
2450:                 IF EMPTY(loc_oPag.txt_4c_Datai.Value)
2451:                     loc_lValido = .F.
2452:                     loc_cMsg    = "Data Inicial Inv" + CHR(225) + "lida !!!"

*-- Linhas 2463 a 2482:
2463:                     IF USED("cursor_4c_VldMoe")
2464:                         USE IN cursor_4c_VldMoe
2465:                     ENDIF
2466:                     loc_nResult = SQLEXEC(gnConnHandle, ;
2467:                         "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cMoeda), ;
2468:                         "cursor_4c_VldMoe")
2469:                     IF loc_nResult <= 0 OR !USED("cursor_4c_VldMoe") OR EOF("cursor_4c_VldMoe")
2470:                         loc_lValido = .F.
2471:                         loc_cMsg    = "Moeda Inv" + CHR(225) + "lida !!!"
2472:                         loc_oFoco   = loc_oPag.txt_4c_Moeda
2473:                     ENDIF
2474:                     IF USED("cursor_4c_VldMoe")
2475:                         USE IN cursor_4c_VldMoe
2476:                     ENDIF
2477:                 ENDIF
2478:             ENDIF
2479:         CATCH TO loc_oErro
2480:             loc_lValido  = .F.
2481:             loc_lErroSql = .T.
2482:             loc_cMsg     = loc_oErro.Message

*-- Linhas 2784 a 2813:
2784: 
2785:         *-- O legado refaz a configuracao das duas grades da aba Saldo a cada
2786:         *-- clique neste botao (ColumnCount depende da permissao) - mexer em
2787:         *-- ColumnCount recria as Column, por isso ControlSource/Width/Header
2788:         *-- sao reaplicados dentro de ConfigurarGradesSaldo.
2789:         THIS.ConfigurarGradesSaldo()
2790: 
2791:         THIS.AlternarPagina(2)
2792: 
2793:         *-- "Select dbHistorico / Go Bottom" do legado: o extrato abre no
2794:         *-- lancamento mais RECENTE. Tem de vir DEPOIS de AlternarPagina, que
2795:         *-- chama AtualizarGrades -> PosicionarCursores (GO TOP em todos os
2796:         *-- cursores) - antes dela, o GO TOP desfaria este GO BOTTOM.
2797:         IF USED("cursor_4c_Historico")
2798:             SELECT cursor_4c_Historico
2799:             GO BOTTOM
2800:         ENDIF
2801: 
2802:         TRY
2803:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
2804:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.SetFocus()
2805:         CATCH TO loc_oErro
2806:             *-- SetFocus falha quando a grade ainda nao esta visivel; eh so o
2807:             *-- foco inicial, nao afeta o conteudo exibido
2808:         ENDTRY
2809:     ENDPROC
2810: 
2811:     *==========================================================================
2812:     * BtnCancelarClick - botao "Encerrar" do grp_operacao (Page1), que no
2813:     * legado eh o objeto cmd_cancela (Cancel = .T., ou seja tambem responde ao

*-- Linhas 2944 a 2962:
2944:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3
2945:             loc_nValor = loc_oPage.obj_4c_OptSituas.Value
2946: 
2947:             SELECT cursor_4c_ProdFor
2948:             IF loc_nValor != 3
2949:                 IF loc_nValor = 1
2950:                     SET FILTER TO situas = 1
2951:                 ELSE
2952:                     SET FILTER TO situas = 2
2953:                 ENDIF
2954:             ELSE
2955:                 SET FILTER TO
2956:             ENDIF
2957: 
2958:             GO TOP IN cursor_4c_ProdFor
2959:             loc_oPage.grd_4c_Produto.Refresh()
2960:         CATCH TO loc_oErro
2961:             MsgErro(loc_oErro.Message, "Erro")
2962:         ENDTRY

*-- Linhas 2975 a 2993:
2975:         ENDIF
2976: 
2977:         TRY
2978:             SELECT cursor_4c_ProdFor
2979:             IF par_lDescendente
2980:                 SET ORDER TO (par_cTag) DESCENDING
2981:             ELSE
2982:                 SET ORDER TO (par_cTag) ASCENDING
2983:             ENDIF
2984:             GO TOP IN cursor_4c_ProdFor
2985:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3.grd_4c_Produto.Refresh()
2986:         CATCH TO loc_oErro
2987:             MsgErro(loc_oErro.Message, "Erro")
2988:         ENDTRY
2989:     ENDPROC
2990: 
2991:     PROCEDURE HeaderProdutoClick()
2992:         THIS.OrdenarGradeProdutos("cpros", .F.)
2993:     ENDPROC

*-- Linhas 3247 a 3286:
3247:     *==========================================================================
3248:     * ValidarMoeda - KeyPress de txt_4c_Moeda (Page1). Legado (Get_Moeda.
3249:     * Valid): fwbuscaext em SigCdMoe.cmoes - aqui com match exato via
3250:     * SQLEXEC e fallback no picker AbrirBuscaMoeda().
3251:     *==========================================================================
3252:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
3253:         LOCAL loc_cVal, loc_nResult, loc_oErro
3254: 
3255:         THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
3256: 
3257:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
3258:             RETURN
3259:         ENDIF
3260: 
3261:         loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
3262:         IF EMPTY(loc_cVal)
3263:             RETURN
3264:         ENDIF
3265: 
3266:         TRY
3267:             IF USED("cursor_4c_MoedaVal")
3268:                 USE IN cursor_4c_MoedaVal
3269:             ENDIF
3270:             loc_nResult = SQLEXEC(gnConnHandle, ;
3271:                 "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cVal), ;
3272:                 "cursor_4c_MoedaVal")
3273:             IF loc_nResult > 0 AND USED("cursor_4c_MoedaVal") AND !EOF("cursor_4c_MoedaVal")
3274:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_MoedaVal.cmoes)
3275:             ELSE
3276:                 THIS.AbrirBuscaMoeda()
3277:             ENDIF
3278:             IF USED("cursor_4c_MoedaVal")
3279:                 USE IN cursor_4c_MoedaVal
3280:             ENDIF
3281:         CATCH TO loc_oErro
3282:             MsgErro(loc_oErro.Message, "Erro")
3283:         ENDTRY
3284:     ENDPROC
3285: 
3286:     *==========================================================================

*-- Linhas 3298 a 3350:
3298:         loc_lProsseguir = .T.
3299:         TRY
3300:             IF EMPTY(loc_cValor)
3301:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes"
3302:             ELSE
3303:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
3304:                            "WHERE cmoes LIKE " + EscaparSQL(loc_cValor + "%") + ;
3305:                            " OR RTRIM(dmoes) LIKE " + EscaparSQL(loc_cValor + "%") + ;
3306:                            " ORDER BY cmoes"
3307:             ENDIF
3308:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")
3309: 
3310:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0) ;
3311:                     AND !EMPTY(loc_cValor)
3312:                 IF USED("cursor_4c_BuscaMoeda")
3313:                     USE IN cursor_4c_BuscaMoeda
3314:                 ENDIF
3315:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3316:                     "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes", "cursor_4c_BuscaMoeda")
3317:             ENDIF
3318: 
3319:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0
3320:                 MsgAviso("Nenhuma moeda encontrada.", "Moedas")
3321:                 loc_lProsseguir = .F.
3322:             ENDIF
3323: 
3324:             IF loc_lProsseguir
3325:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3326:                 IF VARTYPE(loc_oBusca) = "O"
3327:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeda"
3328:                     loc_oBusca.this_cTitulo        = "Moedas"
3329:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Moedas"
3330:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Moedas"
3331:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
3332:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3333:                     loc_oBusca.Show()
3334:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3335:                         SELECT cursor_4c_BuscaMoeda
3336:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3337:                     ELSE
3338:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3339:                     ENDIF
3340:                     loc_oBusca.Release()
3341:                 ENDIF
3342:             ELSE
3343:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
3344:             ENDIF
3345:         CATCH TO loc_oErro
3346:             MsgErro(loc_oErro.Message, "Erro")
3347:         ENDTRY
3348: 
3349:         IF USED("cursor_4c_BuscaMoeda")
3350:             USE IN cursor_4c_BuscaMoeda

*-- Linhas 3376 a 3395:
3376:             IF USED("cursor_4c_EmpVal")
3377:                 USE IN cursor_4c_EmpVal
3378:             ENDIF
3379:             loc_nResult = SQLEXEC(gnConnHandle, ;
3380:                 "SELECT TOP 1 Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
3381:                 "cursor_4c_EmpVal")
3382:             IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
3383:                 IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_EmpVal.Cemps))
3384:                     MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3385:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3386:                 ELSE
3387:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
3388:                 ENDIF
3389:             ELSE
3390:                 THIS.AbrirBuscaEmpresa()
3391:             ENDIF
3392:             IF USED("cursor_4c_EmpVal")
3393:                 USE IN cursor_4c_EmpVal
3394:             ENDIF
3395:         CATCH TO loc_oErro

*-- Linhas 3413 a 3465:
3413:         loc_lProsseguir = .T.
3414:         TRY
3415:             IF EMPTY(loc_cValor)
3416:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
3417:             ELSE
3418:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
3419:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
3420:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
3421:                            " ORDER BY Cemps"
3422:             ENDIF
3423:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
3424: 
3425:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
3426:                     AND !EMPTY(loc_cValor)
3427:                 IF USED("cursor_4c_BuscaEmp")
3428:                     USE IN cursor_4c_BuscaEmp
3429:                 ENDIF
3430:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3431:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", "cursor_4c_BuscaEmp")
3432:             ENDIF
3433: 
3434:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
3435:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
3436:                 loc_lProsseguir = .F.
3437:             ENDIF
3438: 
3439:             IF loc_lProsseguir
3440:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3441:                 IF VARTYPE(loc_oBusca) = "O"
3442:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
3443:                     loc_oBusca.this_cTitulo        = loc_cTitulo
3444:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
3445:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
3446:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
3447:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
3448:                     loc_oBusca.Show()
3449:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
3450:                         SELECT cursor_4c_BuscaEmp
3451:                         IF VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_BuscaEmp.Cemps))
3452:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
3453:                         ELSE
3454:                             MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3455:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3456:                         ENDIF
3457:                     ELSE
3458:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3459:                     ENDIF
3460:                     loc_oBusca.Release()
3461:                 ENDIF
3462:             ELSE
3463:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
3464:             ENDIF
3465:         CATCH TO loc_oErro

*-- Linhas 3503 a 3522:
3503:                 IF USED("cursor_4c_GrpVal")
3504:                     USE IN cursor_4c_GrpVal
3505:                 ENDIF
3506:                 loc_nResult = SQLEXEC(gnConnHandle, ;
3507:                     "SELECT TOP 1 tpcads FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cVal), ;
3508:                     "cursor_4c_GrpVal")
3509:                 IF loc_nResult > 0 AND USED("cursor_4c_GrpVal") AND !EOF("cursor_4c_GrpVal")
3510:                     IF cursor_4c_GrpVal.tpcads = 1
3511:                         loc_oOrigem.txt_4c_Dconta.Left  = 326
3512:                         loc_oOrigem.txt_4c_Dconta.Width = 278
3513:                         loc_oOrigem.lbl_4c__dConta.Left = 329
3514:                         loc_oOrigem.txt_4c_Cpf.Visible   = .T.
3515:                         loc_oOrigem.lbl_4c__CPF.Visible  = .T.
3516:                     ELSE
3517:                         loc_oOrigem.txt_4c_Dconta.Left  = 177
3518:                         loc_oOrigem.txt_4c_Dconta.Width = 427
3519:                         loc_oOrigem.lbl_4c__dConta.Left = 180
3520:                         loc_oOrigem.txt_4c_Cpf.Visible   = .F.
3521:                         loc_oOrigem.lbl_4c__CPF.Visible  = .F.
3522:                     ENDIF

*-- Linhas 3568 a 3587:
3568:                     IF USED("cursor_4c_CtaVal")
3569:                         USE IN cursor_4c_CtaVal
3570:                     ENDIF
3571:                     loc_nResult = SQLEXEC(gnConnHandle, ;
3572:                         "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
3573:                         "cursor_4c_CtaVal")
3574:                     IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
3575:                         IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
3576:                             loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
3577:                         ENDIF
3578:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
3579:                     ENDIF
3580:                     IF USED("cursor_4c_CtaVal")
3581:                         USE IN cursor_4c_CtaVal
3582:                     ENDIF
3583:                 ENDIF
3584:             ENDIF
3585:         CATCH TO loc_oErro
3586:             MsgErro(loc_oErro.Message, "Erro")
3587:         ENDTRY

*-- Linhas 3625 a 3644:
3625:                     IF USED("cursor_4c_CtaVal")
3626:                         USE IN cursor_4c_CtaVal
3627:                     ENDIF
3628:                     loc_nResult = SQLEXEC(gnConnHandle, ;
3629:                         "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
3630:                         "cursor_4c_CtaVal")
3631:                     IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
3632:                         IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
3633:                             loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
3634:                         ENDIF
3635:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
3636:                     ENDIF
3637:                     IF USED("cursor_4c_CtaVal")
3638:                         USE IN cursor_4c_CtaVal
3639:                     ENDIF
3640:                 ENDIF
3641:             ENDIF
3642:         CATCH TO loc_oErro
3643:             MsgErro(loc_oErro.Message, "Erro")
3644:         ENDTRY

*-- Linhas 3686 a 3704:
3686:                 ENDIF
3687: 
3688:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
3689:                     SELECT cursor_4c_BuscaCpf
3690:                     loc_cVal = ALLTRIM(cursor_4c_BuscaCpf.iclis)
3691: 
3692:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
3693:                             loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
3694:                         MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
3695:                         loc_oOrigem.txt_4c_Cpf.Value    = ""
3696:                         loc_oOrigem.txt_4c_Conta.Value  = ""
3697:                         loc_oOrigem.txt_4c_Dconta.Value = ""
3698:                     ELSE
3699:                         loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
3700:                     ENDIF
3701:                 ENDIF
3702:                 loc_oBusca.Release()
3703:             ENDIF
3704: 

