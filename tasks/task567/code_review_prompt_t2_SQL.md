# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, CODIGOS, DATAS, DISTRIBUI, GRUPODS, CONTADS, CITENS, CRSIGMVD, CODTAMS, CODCORS, SQTDS, PCESCOLHA, NMARCA, CGRUS, QTDDISTR, QTDSALDO, GRUPOS, ESTOS, EMPS, CONTAS, XBAIXA, I, ORIGEMS, DOPES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, CODIGOS, DATAS, DISTRIBUI, GRUPODS, CONTADS, CITENS, CRSIGMVD, CODTAMS, CODCORS, SQTDS, PCESCOLHA, NMARCA, CGRUS, QTDDISTR, QTDSALDO, GRUPOS, ESTOS, EMPS, CONTAS, XBAIXA, I, ORIGEMS, DOPES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, CODIGOS, DATAS, DISTRIBUI, GRUPODS, CONTADS, CITENS, CRSIGMVD, CODTAMS, CODCORS, SQTDS, PCESCOLHA, NMARCA, CGRUS, QTDDISTR, QTDSALDO, GRUPOS, ESTOS, EMPS, CONTAS, XBAIXA, I, ORIGEMS, DOPES, OPERS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
Select crDistribui
	Select crDistribui
		Insert Into dbImpressao ( CPros, Qtds, Cbars, Obs) Values ( crSigCdPam.Ouros, 1, lnBar, lcObs)
		lcQuery = [Select * From SigMvItn Where 0=1 Order By CItens]
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrEesti') < 0
		lcquery = [Select * From SigMvIts Where 0=1 Order By CItens]
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrEsti2') < 1
		lcQuery = [Select * From SigMvItn Where EmpDopNums = ']+lcbusca+[' Order By CItens]
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrEesti') < 0
		lcquery = [Select * From SigMvIts Where EmpDopNums = ']+lcBusca+[' Order By CItens]
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrEsti2') < 1
	lcQuery = [Select a.*,b.cunis From SigMvHst a, SigCdPro b Where a.OriDopNums = ']+lcbusca+[' And ]+;
	If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrEesti') < 1
	lcquery = [Select * From SigMvIts Where EmpDopNums = ']+lcBusca+[' And 0=1 ]
	If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrEsti2') < 1
Select CrEsti2
Select crEesti
		lcSql = [Select a.Cpros, a.Cgrus, b.nTipoJoals, b.etipads ]+;
				[From SigCdPro a Inner Join SigCdGrp b on b.cGrus = a.cGrus Where a.Cpros = ']+CrEesti.Cpros+[']
		If ThisForm.poDataMgr.Sqlexecute(lcSql,'LocalPro') < 1
				Select crEsti2
				Insert Into dbImpressao (cpros, qtds, qtdeEtiq, Pesos, Obs, PVens, Moedas, EmpDopNums, CItens, CodTams) ;
				Select crEsti2
						Insert Into dbImpressao (CPros, Qtds, QtdeEtiq, CodTams, Obs, PVens, Pesos, Moedas, EmpDopNums, CItens) ;
			Select crEsti2
			Insert Into dbImpressao (CPros, Qtds, Pesos, Obs, PVens, Moedas, EmpDopNums, CItens, CodTams) ;
Update dbImpressao Set Pedido = crSigCdOpe.Abrevs
Select dbImpressao
Select crSigPrDis
If Not ThisForm.poDataMgr.Update('crSigPrDis')
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrDis Where Codigos = ?_Codigo], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigPrDis')
		lcQueryLista = [Select Distinct Codigos, Datas from SigPrDis where Datas Between ?ldDatai And ?ldDataF]
		lcQueryPrDis = [Select * from SigPrDis where Codigos = ?_Codigo]
		lcSql = [Select * From SigCdPac ]
		.poDataMgr.Sqlexecute(lcsql,'crSigCdPac')
		lcSql = [select a.cmoes,a.datas,a.horas,a.valos from SigCdCot a order by 1 asc,2 desc,3 desc]
		.poDataMgr.Sqlexecute(lcsql,'crSigCdCot')
lcQuery = [Select 0 as nMarca, a.Emps, a.Dopes, a.Numes, a.EmpDopNums as OriDopNums, a.grupods as Grupos, a.contads as Contas From SigMvCab a ] + ;
	[join sigcdope b on a.dopes = b.dopes ] + ;
	[join SigOpCdd c on b.dopes = c.dopes ] + ;
If Thisform.podatamgr.SqlExecute(lcQuery,'crSigMvDis') < 1
lcQuery = [Select distinct a.Cpros, isnull(b.codcors,'') as CodCors, Isnull(b.codtams,'') as CodTams, a.EmpDopNums as OriDopNums ] + ;
	[From SigmvItn a ] + ;
	[Left Join SigMvIts b on a.empdopnums = b.EmpDopNums And a.cItens = b.cItens And a.Cpros = b.Cpros ] + ;
	[join SigMvCab c on a.EmpDopNums = c.EmpDopNums ] + ;
	[join sigcdope d on c.dopes = d.dopes ] + ;
	[join SigOpCdd e on d.dopes = e.dopes ] + ;
If Thisform.podatamgr.SqlExecute(lcQuery,'crSigDisIt') < 1
lcQuery = [Select b.* from (Select Distinct a.EmpDopNums from SigPrDis a Where a.Codigos = ?_Codigo And a.EmpDopNums <> '') a Inner Join SigMvCab b On a.EmpDopNums = b.EmpDopNums]
If Thisform.podatamgr.SqlExecute(lcQuery, [crCabOpera] ) < 1
	Messagebox( [Problemas no Select dos Produtos com Saldo], 48, [Atenção] )
lcQuery = [Select b.*, c.CodCors, c.CodTams from (Select Distinct a.EmpDopNums from SigPrDis a Where a.Codigos = ?_Codigo And a.EmpDopNums <> '') a Inner Join SigMvItn b On a.EmpDopNums = b.EmpDopNums ] +;
	[Inner Join SigMvIts c On b.EmpDopNums = c.EmpDopNums And b.Citens = c.Citens]
If Thisform.podatamgr.SqlExecute(lcQuery, [crItnOpera] ) < 1
	Messagebox( [Problemas no Select dos Produtos com Saldo], 48, [Atenção] )
Select crCabOpera
	Select TmpSigPrDis
		Select a.EmpGruEsts, b.OriDopNums as EmpDopNums, a.OriDopNums, b.Dopes, b.Numes, ;
			from crSigPrDis a ;
			Inner Join crSigMvDis b On Substr(a.EmpGruEsts,1,3) + Substr(a.EmpGruEsts,4,10) + Substr(a.EmpGruEsts,14,10) = b.Emps + b.Grupos + b.Contas ;
		Select crSigMvDis
				Select a.CPros, b.Dpros, a.CodCors, a.CodTams, Sum(a.SQtds) as Sqtds, 0000000 As QtdSaida, Sum(a.SQtds) As QtdSaldo, b.Cgrus, b.Sgrus, c.EmpDopNums as OriDopNums
				From SigMvEst a
				Join SigCdpro b on a.Cpros = b.Cpros
				Join (Select distinct a.Cpros, Isnull(b.codcors,'') as CodCors, Isnull(b.codtams,'') as CodTams, a.EmpDopNums
						from SigmvItn a 
						Left Join SigMvIts b on a.empdopnums = b.EmpDopNums And a.cItens = b.cItens And a.Cpros = b.Cpros 
						join SigMvCab c on a.EmpDopNums = c.EmpDopNums
						join sigcdope d on c.dopes = d.dopes 
						join SigOpCdd e on d.dopes = e.dopes
		If Thisform.podatamgr.SqlExecute(lcSQL, [crDisponivel] ) < 1
			Messagebox( [Problemas no Select dos Produtos com Saldo], 48, "Atenção" )
					Select e.EmpDopNums as OriDopNums, b.cEmps, Case When d.SQtds is null Then 0000000 Else d.Sqtds End As QtdSaldo, 0000000 As QtdDistr,
					from (Select Distinct a.CPros, a.CodCors, a.CodTams From SigMvEst a
					Inner Join SigCdEmp b On b.cEmps not in <<lcEmps>>
					Inner Join SigCdOpe c On b.DirColOuts = c.Dopes
					Left Join SigMvEst d On d.EmpGruEsts = b.cEmps + c.GruDests + c.ConDests And d.CPros + d.CodCors + d.CodTams = a.CPros + a.CodCors + a.CodTams
					Join (Select distinct a.Cpros, Isnull(b.codcors,'') as CodCors, Isnull(b.codtams,'') as CodTams, a.EmpDopNums
						from SigmvItn a 
						Left Join SigMvIts b on a.empdopnums = b.EmpDopNums And a.cItens = b.cItens And a.Cpros = b.Cpros 
						join SigMvCab c on a.EmpDopNums = c.EmpDopNums
						join sigcdope d on c.dopes = d.dopes 
						join SigOpCdd e on d.dopes = e.dopes
			If Thisform.podatamgr.SqlExecute(lcQuery, [crDistribui] ) < 1
				Messagebox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
			lcQuery = [Select a.EmpDs as cEmps, 0000000 as QtdSaldo, a.Qtds as QtdDistr, a.Locals, a.CPros, a.CodCors, a.CodTams, a.QtdOs, b.Dpros, b.cgrus, b.sgrus, a.OriDopNums ] +;
				[from SigPrDis a ] + ;
				[Inner Join SigCdPro b On a.Cpros = b.Cpros ] + ;
			If Thisform.podatamgr.SqlExecute(lcQuery, [crDistribui2] ) < 1
				Messagebox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
			Select crDistribui2
				Select crDistribui
					Select crDistribui2
					Insert Into crDistribui From Memvar
			lcQuery = [Select a.EmpDs as cEmps, 0000000 as QtdSaldo, a.Qtds as QtdDistr, a.Locals, a.CPros, a.CodCors, a.CodTams, a.QtdOs, b.Dpros, b.cgrus, b.sgrus, a.OriDopNums ] +;
				[from SigPrDis a Inner Join SigCdPro b On a.Cpros = b.Cpros where a.codigos = '] + _Codigo + [' And a.Cpros <> '']
			If Thisform.podatamgr.SqlExecute(lcQuery, [crDistribui] ) < 1
				Messagebox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
			Select a.CPros, a.Dpros, a.CodCors, a.CodTams, ;
				from crDisponivel a ;
				Inner Join (Select Max(QtdOs) As QtdOs, Sum(QtdDistr) As QtdDistr, CPros, CodCors, CodTams From crDistribui Group By CPros, CodCors, CodTams) b ;
			Select crDistribui2
				Select crDisponivel
					Select crDistribui2
					Insert Into crDisponivel From Memvar
			Select Distinct CPros, Dpros, CodCors, CodTams, QtdOs As Sqtds, 0000000 As QtdSaida, 0000000 As QtdSaldo, Cgrus, Sgrus, OriDopNums ;
			From crDistribui ;
		Select crDistribui
		Select crDisponivel
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column1.ControlSource = [crSigMvDis.nMarca]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column2.ControlSource = [crSigMvDis.Emps]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column3.ControlSource = [crSigMvDis.Dopes]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column4.ControlSource = [crSigMvDis.Numes]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column5.ControlSource = [crSigMvDis.Grupos]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column6.ControlSource = [crSigMvDis.Contas]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column2.ControlSource = [crCabOpera.Emps]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column3.ControlSource = [crCabOpera.Dopes]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column4.ControlSource = [crCabOpera.Numes]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column5.ControlSource = [crCabOpera.EmpDs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column6.ControlSource = [crCabOpera.GrupoOs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column7.ControlSource = [crCabOpera.ContaOs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column8.ControlSource = [crCabOpera.GrupoDs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column9.ControlSource = [crCabOpera.ContaDs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column1.ControlSource = [crItnOpera.Citens]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column2.ControlSource = [crItnOpera.CPros]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column3.ControlSource = [crItnOpera.Dpros]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column8.ControlSource = [crItnOpera.CodCors]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column9.ControlSource = [crItnOpera.CodTams]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column4.ControlSource = [crItnOpera.CUnis]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column5.ControlSource = [crItnOpera.Qtds]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column6.ControlSource = [crItnOpera.Units]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column7.ControlSource = [crItnOpera.totas]
Select TmpSigPrDis
		Select crSigPrDis
		Select crDisponivel
		Select crDistribui
				Insert Into crSigPrDis (Codigos, Datas, CidChaves, Cpros, CodCors, CodTams, EmpDopNums, Qtds, EmpDs, Locals ) Values ;
				Select crDisponivel
	Select crSigMvDis
			Insert Into crSigPrDis (CidChaves, Datas, Codigos, EmpGruEsts, Usuars) Values ;
Update crSigMvDis Set nMarca = 1
Update crSigMvDis Set nMarca = 0
Select crSigMvDis
Select 0
Select crSigMvDis
	Select a.CPros, b.Dpros, a.CodCors, a.CodTams, Sum(a.SQtds) as Sqtds, 0000000 As QtdSaida, Sum(a.SQtds) As QtdSaldo, b.Cgrus, b.Sgrus, c.OriDopNums
	From SigMvEst a
	Join SigCdpro b on a.Cpros = b.Cpros
	Join (Select distinct a.Cpros, Isnull(b.codcors,'') as CodCors, Isnull(b.codtams,'') as CodTams, a.EmpDopNums as OriDopNums
						from SigmvItn a
						Left Join SigMvIts b on a.empdopnums = b.EmpDopNums And a.cItens = b.cItens And a.Cpros = b.Cpros
						join SigMvCab c on a.EmpDopNums = c.EmpDopNums
						join sigcdope d on c.dopes = d.dopes
						join SigOpCdd e on d.dopes = e.dopes
If Thisform.podatamgr.SqlExecute(lcSQL, [crDisponivel] ) < 1
	Messagebox( [Problemas no Select dos Produtos com Saldo], 48, "Atenção" )
	Select b.cEmps, Case When d.SQtds is null Then 0000000 Else d.Sqtds End As QtdSaldo, 0 As QtdDistr, Space(10) as Locals, a.CPros, a.CodCors, a.CodTams, c.Dopes, e.OriDopNums
	from (Select Distinct a.CPros, a.CodCors, a.CodTams From SigMvEst a
	Inner Join SigCdEmp b On b.cEmps not in <<lcEmps>>
	Inner Join SigCdOpe c On b.DirColOuts = c.Dopes
	Left Join SigMvEst d On d.EmpGruEsts = b.cEmps + c.GruDests + c.ConDests And d.CPros + d.CodCors + d.CodTams = a.CPros + a.CodCors + a.CodTams
	Join (Select distinct a.Cpros, Isnull(b.codcors,'') as CodCors, Isnull(b.codtams,'') as CodTams, a.EmpDopNums as OriDopNums
						from SigmvItn a
						Left Join SigMvIts b on a.empdopnums = b.EmpDopNums And a.cItens = b.cItens And a.Cpros = b.Cpros
						join SigMvCab c on a.EmpDopNums = c.EmpDopNums
						join sigcdope d on c.dopes = d.dopes
						join SigOpCdd e on d.dopes = e.dopes
If Thisform.podatamgr.SqlExecute(lcSQL, [crDistribui] ) < 1
	Messagebox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
Select crDistribui
Select crDisponivel
m.SelectPro   = [Select a.cpros,a.cgrus,a.dpros,a.sgrus,a.cunis,a.cunips,a.ifors,a.reffs,a.qmins,a.valors,a.moedas,a.icms,]+;
				[From SigCdPro a ]+;
				[Left Join SigCdGrp g On a.cgrus = g.cgrus ]+;
				[Left Join SigCdUni u On a.cunis = u.cunis ]+;
				[Left Join SigCdCol b On a.colecoes = b.colecoes ]+;
				[Left Join SigCdLin l On a.linhas = l.linhas ]+;
				[Left Join SigPrFti f On a.cftios = f.cods ]+;
				[Left Join SigCdCli c On a.ifors = c.iclis ]+;
				[Left Join SigCdGpr h On a.Mercs= h.codigos ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(m.SelectPro,'CrTSigPro')
Select CrTSigPro
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select s.codigos,s.descricaos ]+;
				  [From SigCdPsg s ]+;
	Select CrTSigPro
		Select CrSigCdCot
		Select CrSigCdCot
Select crDisponivel
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
Select crDisponivel
	Select crDisponivel
Select crItnOpera
Select crDistribui
Select crDisponivel
Select crSigMvDis
		Select CrSigTempd
	Select CrSigTempd
If !Thisform.Podatamgr2.Update('CrSigTempd')
lcQuery = [Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ]+;
	[Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ] +;
If Thisform.PodataMgr.SqlExecute(lcQuery,'TmpEstoque') < 1
Select crSigPrDis
Select crSigMvCab
Select crSigMvItn
Select crSigMvIts
Select crSigMvHst
Select crSigOpEtq
Select crSigCdMlc
Select TmpEstoque
	Insert Into TmpSaldg ( Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps );
Select crDistribui
		Select TmpSaldg
		=Seek(crDistribui.CPros + crDistribui.CodCors + crDistribui.CodTams)
				Insert Into TmpEstoque (CPros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs, Locals ) Values ;
					Insert Into TmpEstoque (CPros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs, Locals ) Values ;
Select crDisponivel
Select TmpEstoque
	Select TmpEstoque
		Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, DataS, Datars, Usuars, Grupoos, Contaos, ;
		Insert Into crSigMvItn (Emps, Dopes, Numes, EmpDopNums, CPros, Qtds, Cunis, Pesos, CuniPs, DPros, Opers, cItens, CidChaves, Dtalts, Locals, Moedas, SitTrIcms) ;
		Select crSigMvItn
		Select crDisponivel
		Insert Into crSigPrDis From Memvar
		Select TmpEstoque
			Insert Into crSigMvIts (cItens, Emps, Dopes, Numes, EmpDopNums, CPros, Qtds, Pesos, CodCors, CodTams, QtdEmbs, CidChaves, Dtalts, Locals) ;
				Select crSigMvIts
				Select crSigMvItn
			Insert Into crSigOpEtq (cbars,CPros,Pesos,Qtds,Emps,Dopes,Numes,DataS,empos,obsetiqs, DtMovs, DtBals, DtIncs, Localizas, Grupos, Contas, CodAmss,EmpDopNums, ;
				Insert Into crSigCdMlc (Barras, Codigos, Contas, CPros, DataS, Emps, Grupos, Horas, ;
			Insert Into crSigMvHst (Usuars, DataS, Datars, Emps, Dopes, Numes, empos, CPros, Qtds, Opers, Grupos, ;
			Insert Into crSigMvHst (Usuars, DataS, Datars, Emps, Dopes, Numes, empos, CPros, Qtds, Opers, Grupos, ;
	Select crSigPrDis
If Not Thisform.PodataMgr.Update('crSigPrDis')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrDis)')
If Not llErro And Not Thisform.PodataMgr.Update('crSigMvCab')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
If Not llErro And Not Thisform.PodataMgr.Update('crSigMvItn')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
If Not llErro And Not Thisform.PodataMgr.Update('crSigMvIts')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvIts)')
If Not llErro And Not Thisform.PodataMgr.Update('crSigCdMlc')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdMlc)')
If Not llErro And Not Thisform.PodataMgr.Update('crSigOpEtq')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpEtq)')
If Not llErro And Not Thisform.PodataMgr.Update('crSigMvHst')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
Select crSigMvCab
	lcQuery = [ Select a.Ndopes, b.chkImpDoc, b.carcompos, b.dckTermos, a.Cmoes, a.TipoNfs, a.Opers, b.ietiqs, a.CtrlLotes ] + ;
		[ From SigCdOpe a, SigOpCdc b ]+ ;
	If (Thisform.PodataMgr.SqlExecute(lcQuery, [crSigCdOpeD]) < 1)
Select * From crSigMvCab Into Cursor crCabOpera
Select a.*, b.CodCors, b.CodTams From crSigMvItn a Inner Join crSigMvIts b On a.EmpDopNums = b.EmpDopNums And a.cItens = b.cItens Into Cursor crItnOpera
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column2.ControlSource = [crCabOpera.Emps]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column3.ControlSource = [crCabOpera.Dopes]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column4.ControlSource = [crCabOpera.Numes]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column5.ControlSource = [crCabOpera.EmpDs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column6.ControlSource = [crCabOpera.GrupoOs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column7.ControlSource = [crCabOpera.ContaOs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column8.ControlSource = [crCabOpera.GrupoDs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column9.ControlSource = [crCabOpera.ContaDs]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column1.ControlSource = [crItnOpera.Citens]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column2.ControlSource = [crItnOpera.CPros]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column3.ControlSource = [crItnOpera.Dpros]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column8.ControlSource = [crItnOpera.CodCors]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column9.ControlSource = [crItnOpera.CodTams]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column4.ControlSource = [crItnOpera.CUnis]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column5.ControlSource = [crItnOpera.Qtds]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column6.ControlSource = [crItnOpera.Units]
Thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column7.ControlSource = [crItnOpera.totas]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvdis.prg) - TRECHOS RELEVANTES PARA PASS SQL (3822 linhas total):

*-- Linhas 343 a 361:
343:             .Left               = 26
344:             .Width              = 880
345:             .Height             = 498
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .GridLines          = 3
349:             .GridLineColor      = RGB(238, 238, 238)
350:             .HighlightStyle     = 2
351:             .HighlightBackColor = RGB(255, 255, 255)
352:             .HighlightForeColor = RGB(15, 41, 104)
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .ReadOnly           = .T.
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)
360:     ENDPROC
361: 

*-- Linhas 1012 a 1030:
1012:             .FontSize          = 8
1013:             .AllowHeaderSizing = .F.
1014:             .AllowRowSizing    = .F.
1015:             .DeleteMark        = .F.
1016:             .RecordMark        = .F.
1017:             .RowHeight         = 16
1018:             .ScrollBars        = 2
1019:             .GridLineColor     = RGB(128, 128, 128)
1020:             .Visible           = .T.
1021:         ENDWITH
1022: 
1023:         *-- Coluna 1: Checkbox de marcacao (nMarca) - regra #18 CLAUDE.md
1024:         WITH loc_oGrid.Column1
1025:             .Width           = 17
1026:             .Header1.Caption = ""
1027:         ENDWITH
1028:         loc_oGrid.Column1.AddObject("chk_4c_Marca", "CheckBox")
1029:         WITH loc_oGrid.Column1.chk_4c_Marca
1030:             .Top       = 9

*-- Linhas 2428 a 2461:
2428: 
2429:     *===========================================================================
2430:     * CarregarLista - Carrega lotes de distribuicao (Codigos/Datas) no Grid
2431:     * Espelha o legado: Select Distinct Codigos, Datas from SigPrDis
2432:     *===========================================================================
2433:     PROCEDURE CarregarLista()
2434:         LOCAL loc_lResultado, loc_oGrid
2435:         loc_lResultado = .F.
2436: 
2437:         TRY
2438:             IF THIS.this_oBusinessObject.Buscar("")
2439:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2440: 
2441:                 *-- RecordSource ANTES de ControlSource (auto-bind seria sobrescrito - Problema 48)
2442:                 loc_oGrid.ColumnCount   = 2
2443:                 loc_oGrid.RecordSource  = "cursor_4c_Dados"
2444: 
2445:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
2446:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
2447: 
2448:                 loc_oGrid.Column1.Width    = 150
2449:                 loc_oGrid.Column2.Width    = 725
2450: 
2451:                 loc_oGrid.Column1.ReadOnly = .T.
2452:                 loc_oGrid.Column2.ReadOnly = .T.
2453: 
2454:                 *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
2455:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2456:                 loc_oGrid.Column2.Header1.Caption = "Data"
2457: 
2458:                 THIS.FormatarGridLista(loc_oGrid)
2459:                 loc_lResultado = .T.
2460:             ENDIF
2461:         CATCH TO loc_oErro

*-- Linhas 2597 a 2616:
2597:             RETURN
2598:         ENDIF
2599: 
2600:         loc_cSQL = "SELECT cpros, dpros FROM SigCdPro WHERE CAST(cpros AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2601:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaProduto")
2602: 
2603:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaProduto") = 1
2604:             loc_oPg2.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ValidaProduto.cpros)
2605:             IF USED("cursor_4c_ValidaProduto")
2606:                 USE IN cursor_4c_ValidaProduto
2607:             ENDIF
2608:         ELSE
2609:             IF USED("cursor_4c_ValidaProduto")
2610:                 USE IN cursor_4c_ValidaProduto
2611:             ENDIF
2612:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2613:             THIS.AbrirBuscaCodProduto()
2614:         ENDIF
2615:     ENDPROC
2616: 

*-- Linhas 2662 a 2681:
2662:             RETURN
2663:         ENDIF
2664: 
2665:         loc_cSQL = "SELECT cods, descs FROM SigCdCor WHERE CAST(cods AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2666:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaCor")
2667: 
2668:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaCor") = 1
2669:             loc_oPg2.txt_4c_CodCor.Value = ALLTRIM(cursor_4c_ValidaCor.cods)
2670:             IF USED("cursor_4c_ValidaCor")
2671:                 USE IN cursor_4c_ValidaCor
2672:             ENDIF
2673:         ELSE
2674:             IF USED("cursor_4c_ValidaCor")
2675:                 USE IN cursor_4c_ValidaCor
2676:             ENDIF
2677:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2678:             THIS.AbrirBuscaCodCor()
2679:         ENDIF
2680:     ENDPROC
2681: 

*-- Linhas 2727 a 2746:
2727:             RETURN
2728:         ENDIF
2729: 
2730:         loc_cSQL = "SELECT cods, descs FROM SigCdTam WHERE CAST(cods AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2731:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaTamanho")
2732: 
2733:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaTamanho") = 1
2734:             loc_oPg2.txt_4c_CodTamanho.Value = ALLTRIM(cursor_4c_ValidaTamanho.cods)
2735:             IF USED("cursor_4c_ValidaTamanho")
2736:                 USE IN cursor_4c_ValidaTamanho
2737:             ENDIF
2738:         ELSE
2739:             IF USED("cursor_4c_ValidaTamanho")
2740:                 USE IN cursor_4c_ValidaTamanho
2741:             ENDIF
2742:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2743:             THIS.AbrirBuscaCodTamanho()
2744:         ENDIF
2745:     ENDPROC
2746: 

*-- Linhas 2792 a 2811:
2792:             RETURN
2793:         ENDIF
2794: 
2795:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE CAST(cemps AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2796:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmpresa")
2797: 
2798:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaEmpresa") = 1
2799:             loc_oPg2.txt_4c_EmpDestino.Value = ALLTRIM(cursor_4c_ValidaEmpresa.cemps)
2800:             IF USED("cursor_4c_ValidaEmpresa")
2801:                 USE IN cursor_4c_ValidaEmpresa
2802:             ENDIF
2803:         ELSE
2804:             IF USED("cursor_4c_ValidaEmpresa")
2805:                 USE IN cursor_4c_ValidaEmpresa
2806:             ENDIF
2807:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2808:             THIS.AbrirBuscaEmpDestino()
2809:         ENDIF
2810:     ENDPROC
2811: 

*-- Linhas 2857 a 2910:
2857:             RETURN
2858:         ENDIF
2859: 
2860:         loc_cSQL = "SELECT codigos, descricaos FROM SigPrLcl WHERE CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2861:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaLocal")
2862: 
2863:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaLocal") = 1
2864:             loc_oPg2.txt_4c_Local.Value = ALLTRIM(cursor_4c_ValidaLocal.codigos)
2865:             IF USED("cursor_4c_ValidaLocal")
2866:                 USE IN cursor_4c_ValidaLocal
2867:             ENDIF
2868:         ELSE
2869:             IF USED("cursor_4c_ValidaLocal")
2870:                 USE IN cursor_4c_ValidaLocal
2871:             ENDIF
2872:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2873:             THIS.AbrirBuscaLocal()
2874:         ENDIF
2875:     ENDPROC
2876: 
2877:     *===========================================================================
2878:     * PGDADOSINTERNOS.PAGE2 (Filtrar) - handlers da grade de estoques
2879:     * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page1 do legado.
2880:     * PUBLIC: exigido por BINDEVENT (regra #3 CLAUDE.md).
2881:     *===========================================================================
2882: 
2883:     *-- Marca/Desmarca Todas (cmdMarcaDesmarca.btnMarcar/btnDesmarcar no legado)
2884:     *-- Legado: Update crSigMvDis Set nMarca = 1/0
2885:     PROCEDURE BtnMarcarTodasClick()
2886:         IF USED("cursor_4c_Estoque")
2887:             SELECT cursor_4c_Estoque
2888:             REPLACE ALL nMarca WITH 1
2889:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
2890:         ENDIF
2891:     ENDPROC
2892: 
2893:     PROCEDURE BtnDesmarcarTodasClick()
2894:         IF USED("cursor_4c_Estoque")
2895:             SELECT cursor_4c_Estoque
2896:             REPLACE ALL nMarca WITH 0
2897:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
2898:         ENDIF
2899:     ENDPROC
2900: 
2901:     *-- Checkbox da Coluna1 (nMarca): alterna no MouseDown/KeyPress, igual ao
2902:     *-- legado (Click/MouseUp so fazem NoDefault - regra #18 CLAUDE.md)
2903:     PROCEDURE ToggleMarcaEstoqueMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2904:         IF USED("cursor_4c_Estoque")
2905:             REPLACE nMarca WITH IIF(cursor_4c_Estoque.nMarca = 0, 1, 0) IN cursor_4c_Estoque
2906:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
2907:         ENDIF
2908:     ENDPROC
2909: 
2910:     PROCEDURE ToggleMarcaEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2925 a 2943:
2925:         loc_nSelecionados = 0
2926: 
2927:         IF USED("cursor_4c_Estoque")
2928:             SELECT cursor_4c_Estoque
2929:             COUNT FOR nMarca = 1 TO loc_nSelecionados
2930:         ENDIF
2931: 
2932:         IF loc_nSelecionados = 0
2933:             MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
2934:         ELSE
2935:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = 3
2936:         ENDIF
2937:     ENDPROC
2938: 
2939:     *===========================================================================
2940:     * PGDADOSINTERNOS.PAGE3 (Distribuicao) - handlers
2941:     * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page2 do legado.
2942:     * cursor_4c_Disponivel/cursor_4c_Distribui ainda nao sao populados nesta
2943:     * fase (fase futura) - todo handler que os referencia esta guardado por

*-- Linhas 2964 a 3082:
2964: 
2965:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
2966: 
2967:         loc_cSQL = "SELECT a.cpros, a.ifors, a.reffs, a.cgrus, a.sgrus, a.pesoms," + ;
2968:             " a.colecoes, a.linhas, a.CodFinP, a.pvens, a.moevs, a.FigJpgs," + ;
2969:             " g.dgrus, c.rclis, b.descs AS desccol, l.descs AS desclin" + ;
2970:             " FROM SigCdPro a" + ;
2971:             " LEFT JOIN SigCdGrp g ON a.cgrus = g.cgrus" + ;
2972:             " LEFT JOIN SigCdCli c ON a.ifors = c.iclis" + ;
2973:             " LEFT JOIN SigCdCol b ON a.colecoes = b.colecoes" + ;
2974:             " LEFT JOIN SigCdLin l ON a.linhas = l.linhas" + ;
2975:             " WHERE a.cpros = " + EscaparSQL(loc_cCpros)
2976: 
2977:         IF USED("cursor_4c_DetalheProduto")
2978:             USE IN cursor_4c_DetalheProduto
2979:         ENDIF
2980:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DetalheProduto")
2981: 
2982:         IF loc_nResultado < 0 OR !USED("cursor_4c_DetalheProduto") OR RECCOUNT("cursor_4c_DetalheProduto") = 0
2983:             RETURN
2984:         ENDIF
2985: 
2986:         SELECT cursor_4c_DetalheProduto
2987:         GO TOP
2988: 
2989:         loc_oPgN.txt_4c_DetCodFornecedor.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.ifors, ""))
2990:         loc_oPgN.txt_4c_DetDescFornecedor.Value = ALLTRIM(NVL(cursor_4c_DetalheProduto.rclis, ""))
2991:         loc_oPgN.txt_4c_DetRefFornecedor.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.reffs, ""))
2992:         loc_oPgN.txt_4c_DetCodGrupo.Value       = ALLTRIM(NVL(cursor_4c_DetalheProduto.cgrus, ""))
2993:         loc_oPgN.txt_4c_DetDescGrupo.Value      = ALLTRIM(NVL(cursor_4c_DetalheProduto.dgrus, ""))
2994:         loc_oPgN.txt_4c_DetCodSubgrupo.Value    = ALLTRIM(NVL(cursor_4c_DetalheProduto.sgrus, ""))
2995:         loc_oPgN.txt_4c_DetPeso.Value           = NVL(cursor_4c_DetalheProduto.pesoms, 0)
2996:         loc_oPgN.txt_4c_DetCodGrupoVenda.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.colecoes, ""))
2997:         loc_oPgN.txt_4c_DetDescGrupoVenda.Value = ALLTRIM(NVL(cursor_4c_DetalheProduto.desccol, ""))
2998:         loc_oPgN.txt_4c_DetCodLinha.Value       = ALLTRIM(NVL(cursor_4c_DetalheProduto.linhas, ""))
2999:         loc_oPgN.txt_4c_DetDescLinha.Value      = ALLTRIM(NVL(cursor_4c_DetalheProduto.desclin, ""))
3000:         loc_oPgN.txt_4c_DetCodModelo.Value      = ALLTRIM(NVL(cursor_4c_DetalheProduto.CodFinP, ""))
3001: 
3002:         *-- Descricao do Subgrupo (Tmp_Sgru no legado: SigCdPsg por cgrus+codigos)
3003:         loc_oPgN.txt_4c_DetDescSubgrupo.Value = ""
3004:         IF !EMPTY(loc_oPgN.txt_4c_DetCodSubgrupo.Value)
3005:             IF USED("cursor_4c_DetalheSubgrupo")
3006:                 USE IN cursor_4c_DetalheSubgrupo
3007:             ENDIF
3008:             IF SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE cgrus = " + ;
3009:                     EscaparSQL(loc_oPgN.txt_4c_DetCodGrupo.Value) + " AND codigos = " + ;
3010:                     EscaparSQL(loc_oPgN.txt_4c_DetCodSubgrupo.Value), "cursor_4c_DetalheSubgrupo") > 0 ;
3011:                     AND USED("cursor_4c_DetalheSubgrupo") AND RECCOUNT("cursor_4c_DetalheSubgrupo") > 0
3012:                 loc_oPgN.txt_4c_DetDescSubgrupo.Value = ALLTRIM(NVL(cursor_4c_DetalheSubgrupo.descricaos, ""))
3013:             ENDIF
3014:             IF USED("cursor_4c_DetalheSubgrupo")
3015:                 USE IN cursor_4c_DetalheSubgrupo
3016:             ENDIF
3017:         ENDIF
3018: 
3019:         *-- Descricao do Modelo (getDesFinP no legado: SigCdFip por Cods=CodFinP)
3020:         loc_oPgN.txt_4c_DetDescModelo.Value = ""
3021:         IF !EMPTY(loc_oPgN.txt_4c_DetCodModelo.Value)
3022:             IF USED("cursor_4c_DetalheModelo")
3023:                 USE IN cursor_4c_DetalheModelo
3024:             ENDIF
3025:             IF SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdFip WHERE cods = " + ;
3026:                     EscaparSQL(loc_oPgN.txt_4c_DetCodModelo.Value), "cursor_4c_DetalheModelo") > 0 ;
3027:                     AND USED("cursor_4c_DetalheModelo") AND RECCOUNT("cursor_4c_DetalheModelo") > 0
3028:                 loc_oPgN.txt_4c_DetDescModelo.Value = ALLTRIM(NVL(cursor_4c_DetalheModelo.descs, ""))
3029:             ENDIF
3030:             IF USED("cursor_4c_DetalheModelo")
3031:                 USE IN cursor_4c_DetalheModelo
3032:             ENDIF
3033:         ENDIF
3034: 
3035:         *-- Preco de venda: converte para moeda padrao se configurada (SigCdPam.moedetqs)
3036:         loc_cMoeDetqs = ""
3037:         IF USED("cursor_4c_DetalhePam")
3038:             USE IN cursor_4c_DetalhePam
3039:         ENDIF
3040:         IF SQLEXEC(gnConnHandle, "SELECT TOP 1 moedetqs FROM SigCdPam", "cursor_4c_DetalhePam") > 0 ;
3041:                 AND USED("cursor_4c_DetalhePam") AND RECCOUNT("cursor_4c_DetalhePam") > 0
3042:             loc_cMoeDetqs = ALLTRIM(NVL(cursor_4c_DetalhePam.moedetqs, ""))
3043:             USE IN cursor_4c_DetalhePam
3044:         ENDIF
3045: 
3046:         IF EMPTY(loc_cMoeDetqs)
3047:             loc_oPgN.txt_4c_DetPrecoVenda.Value = NVL(cursor_4c_DetalheProduto.pvens, 0)
3048:             loc_oPgN.txt_4c_DetMoedaVenda.Value = ALLTRIM(NVL(cursor_4c_DetalheProduto.moevs, ""))
3049:         ELSE
3050:             loc_nCotAlvo  = 1
3051:             loc_nCotVenda = 1
3052:             IF USED("cursor_4c_DetalheCot")
3053:                 USE IN cursor_4c_DetalheCot
3054:             ENDIF
3055:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3056:                     EscaparSQL(loc_cMoeDetqs) + " ORDER BY datas DESC", "cursor_4c_DetalheCot") > 0 ;
3057:                     AND USED("cursor_4c_DetalheCot") AND RECCOUNT("cursor_4c_DetalheCot") > 0
3058:                 loc_nCotAlvo = NVL(cursor_4c_DetalheCot.valos, 1)
3059:                 USE IN cursor_4c_DetalheCot
3060:             ENDIF
3061:             loc_cMoeVenda = ALLTRIM(NVL(cursor_4c_DetalheProduto.moevs, ""))
3062:             IF !EMPTY(loc_cMoeVenda)
3063:                 IF USED("cursor_4c_DetalheCot")
3064:                     USE IN cursor_4c_DetalheCot
3065:                 ENDIF
3066:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3067:                         EscaparSQL(loc_cMoeVenda) + " ORDER BY datas DESC", "cursor_4c_DetalheCot") > 0 ;
3068:                         AND USED("cursor_4c_DetalheCot") AND RECCOUNT("cursor_4c_DetalheCot") > 0
3069:                     loc_nCotVenda = NVL(cursor_4c_DetalheCot.valos, 1)
3070:                     USE IN cursor_4c_DetalheCot
3071:                 ENDIF
3072:             ENDIF
3073:             loc_oPgN.txt_4c_DetPrecoVenda.Value = ROUND(NVL(cursor_4c_DetalheProduto.pvens, 0) * ;
3074:                 loc_nCotVenda / IIF(loc_nCotAlvo = 0, 1, loc_nCotAlvo), 2)
3075:             loc_oPgN.txt_4c_DetMoedaVenda.Value = loc_cMoeDetqs
3076:         ENDIF
3077: 
3078:         *-- Movimentacao de origem (Emps/Dopes/Numes a partir de OriDopNums)
3079:         loc_cOriDopNums = ALLTRIM(NVL(cursor_4c_Disponivel.OriDopNums, ""))
3080:         loc_oPgN.txt_4c_DetEmp.Value   = SUBSTR(loc_cOriDopNums, 1, 3)
3081:         loc_oPgN.txt_4c_DetDopes.Value = SUBSTR(loc_cOriDopNums, 4, 20)
3082:         loc_oPgN.txt_4c_DetNumes.Value = ALLTRIM(RIGHT(loc_cOriDopNums, 6))

*-- Linhas 3118 a 3146:
3118:             RETURN
3119:         ENDIF
3120: 
3121:         loc_cSQL = "SELECT cpros, dpros, FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
3122:         IF USED("cursor_4c_ZoomProduto")
3123:             USE IN cursor_4c_ZoomProduto
3124:         ENDIF
3125:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ZoomProduto")
3126: 
3127:         IF loc_nResultado < 0 OR !USED("cursor_4c_ZoomProduto") OR RECCOUNT("cursor_4c_ZoomProduto") = 0
3128:             RETURN
3129:         ENDIF
3130: 
3131:         SELECT cursor_4c_ZoomProduto
3132:         GO TOP
3133:         loc_cFigJpgs = NVL(cursor_4c_ZoomProduto.FigJpgs, "")
3134:         loc_cCaption = "Produto : " + loc_cCpros + " - " + ALLTRIM(NVL(cursor_4c_ZoomProduto.dpros, ""))
3135:         IF USED("cursor_4c_ZoomProduto")
3136:             USE IN cursor_4c_ZoomProduto
3137:         ENDIF
3138: 
3139:         IF EMPTY(loc_cFigJpgs) OR ISNULL(loc_cFigJpgs)
3140:             RETURN
3141:         ENDIF
3142: 
3143:         loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3144:         loc_cFoto = STRCONV(;
3145:             STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3146:                 "data:image/png;base64,", ""), ;

*-- Linhas 3164 a 3224:
3164: 
3165:     *-- Filtrar (fwbtng "Filtrar" no legado): filtra grd_4c_Disponivel por
3166:     *-- Grupo/Subgrupo digitados. Legado usa Index+Set Key; aqui usamos
3167:     *-- SET FILTER TO, mais seguro sobre cursor vindo de SQLEXEC.
3168:     PROCEDURE BtnFiltrarDisponivelClick()
3169:         LOCAL loc_oPgN, loc_cCodGrupo, loc_cCodSubgrupo, loc_cFiltro
3170: 
3171:         IF !USED("cursor_4c_Disponivel")
3172:             RETURN
3173:         ENDIF
3174: 
3175:         loc_oPgN         = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3176:         loc_cCodGrupo    = ALLTRIM(loc_oPgN.txt_4c_FiltroCodGrupo.Value)
3177:         loc_cCodSubgrupo = ALLTRIM(loc_oPgN.txt_4c_FiltroCodSubgrupo.Value)
3178: 
3179:         SELECT cursor_4c_Disponivel
3180: 
3181:         DO CASE
3182:             CASE EMPTY(loc_cCodGrupo) AND EMPTY(loc_cCodSubgrupo)
3183:                 loc_cFiltro = ""
3184:             CASE !EMPTY(loc_cCodGrupo) AND EMPTY(loc_cCodSubgrupo)
3185:                 loc_cFiltro = "ALLTRIM(Cgrus) = " + EscaparSQL(loc_cCodGrupo)
3186:             CASE EMPTY(loc_cCodGrupo) AND !EMPTY(loc_cCodSubgrupo)
3187:                 loc_cFiltro = "ALLTRIM(Sgrus) = " + EscaparSQL(loc_cCodSubgrupo)
3188:             OTHERWISE
3189:                 loc_cFiltro = "ALLTRIM(Cgrus) = " + EscaparSQL(loc_cCodGrupo) + ;
3190:                     " AND ALLTRIM(Sgrus) = " + EscaparSQL(loc_cCodSubgrupo)
3191:         ENDCASE
3192: 
3193:         SET FILTER TO &loc_cFiltro.
3194:         GO TOP
3195:         loc_oPgN.grd_4c_Disponivel.Refresh()
3196:     ENDPROC
3197: 
3198:     *-- Procurar produto na grade de disponiveis (get_produto_inicial no legado)
3199:     PROCEDURE ValidarProdutoInicial(par_nKeyCode, par_nShiftAltCtrl)
3200:         LOCAL loc_oPgN, loc_cValor, loc_nRegAtual
3201: 
3202:         loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3203:         loc_cValor = ALLTRIM(loc_oPgN.txt_4c_ProdutoInicial.Value)
3204: 
3205:         IF EMPTY(loc_cValor) OR !USED("cursor_4c_Disponivel")
3206:             RETURN
3207:         ENDIF
3208: 
3209:         SELECT cursor_4c_Disponivel
3210:         loc_nRegAtual = RECNO()
3211:         GO TOP
3212:         LOCATE FOR ALLTRIM(Cpros) = loc_cValor
3213:         IF EOF()
3214:             GO loc_nRegAtual
3215:         ENDIF
3216:         loc_oPgN.grd_4c_Disponivel.Refresh()
3217:     ENDPROC
3218: 
3219:     *-- Filtro Grupo (get_cgrupo/get_dgrupo no legado) -> SigCdGrp (cgrus/dgrus)
3220:     PROCEDURE TeclaLookupFiltroGrupo(par_nKeyCode, par_nShiftAltCtrl)
3221:         IF INLIST(par_nKeyCode, 115, 116)
3222:             THIS.AbrirBuscaFiltroGrupo()
3223:         ENDIF
3224:     ENDPROC

*-- Linhas 3266 a 3285:
3266:             RETURN
3267:         ENDIF
3268: 
3269:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp WHERE " + ;
3270:             "CAST(cgrus AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroGrupo")
3271: 
3272:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroGrupo") = 1
3273:             loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroGrupo.cgrus)
3274:             loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroGrupo.dgrus)
3275:             IF USED("cursor_4c_ValidaFiltroGrupo")
3276:                 USE IN cursor_4c_ValidaFiltroGrupo
3277:             ENDIF
3278:         ELSE
3279:             IF USED("cursor_4c_ValidaFiltroGrupo")
3280:                 USE IN cursor_4c_ValidaFiltroGrupo
3281:             ENDIF
3282:             loc_oPgN.txt_4c_FiltroDescGrupo.Value = ""
3283:             THIS.AbrirBuscaFiltroGrupo()
3284:         ENDIF
3285:     ENDPROC

*-- Linhas 3294 a 3313:
3294:             RETURN
3295:         ENDIF
3296: 
3297:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp WHERE " + ;
3298:             "CAST(dgrus AS VARCHAR(60)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroGrupo")
3299: 
3300:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroGrupo") = 1
3301:             loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroGrupo.cgrus)
3302:             loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroGrupo.dgrus)
3303:             IF USED("cursor_4c_ValidaFiltroGrupo")
3304:                 USE IN cursor_4c_ValidaFiltroGrupo
3305:             ENDIF
3306:         ELSE
3307:             IF USED("cursor_4c_ValidaFiltroGrupo")
3308:                 USE IN cursor_4c_ValidaFiltroGrupo
3309:             ENDIF
3310:             loc_oPgN.txt_4c_FiltroCodGrupo.Value = ""
3311:             THIS.AbrirBuscaFiltroGrupo()
3312:         ENDIF
3313:     ENDPROC

*-- Linhas 3363 a 3382:
3363:             RETURN
3364:         ENDIF
3365: 
3366:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE " + ;
3367:             "CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroSubgrupo")
3368: 
3369:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroSubgrupo") = 1
3370:             loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.codigos)
3371:             loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.descricaos)
3372:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3373:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3374:             ENDIF
3375:         ELSE
3376:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3377:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3378:             ENDIF
3379:             loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ""
3380:             THIS.AbrirBuscaFiltroSubgrupo()
3381:         ENDIF
3382:     ENDPROC

*-- Linhas 3391 a 3410:
3391:             RETURN
3392:         ENDIF
3393: 
3394:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE " + ;
3395:             "CAST(descricaos AS VARCHAR(60)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroSubgrupo")
3396: 
3397:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroSubgrupo") = 1
3398:             loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.codigos)
3399:             loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.descricaos)
3400:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3401:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3402:             ENDIF
3403:         ELSE
3404:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3405:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3406:             ENDIF
3407:             loc_oPgN.txt_4c_FiltroCodSubgrupo.Value = ""
3408:             THIS.AbrirBuscaFiltroSubgrupo()
3409:         ENDIF
3410:     ENDPROC

*-- Linhas 3424 a 3459:
3424: 
3425:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3426: 
3427:         SELECT cursor_4c_Distribui
3428:         IF NVL(QtdDistr, 0) <= 0
3429:             REPLACE QtdDistr WITH 0
3430:         ENDIF
3431: 
3432:         loc_cCpros  = ALLTRIM(NVL(cursor_4c_Disponivel.Cpros, ""))
3433:         loc_cCodCor = ALLTRIM(NVL(cursor_4c_Disponivel.CodCors, ""))
3434:         loc_cCodTam = ALLTRIM(NVL(cursor_4c_Disponivel.CodTams, ""))
3435: 
3436:         SELECT cursor_4c_Distribui
3437:         SUM QtdDistr TO loc_nTotalDistr FOR ALLTRIM(NVL(Cpros, "")) = loc_cCpros ;
3438:             AND ALLTRIM(NVL(CodCors, "")) = loc_cCodCor AND ALLTRIM(NVL(CodTams, "")) = loc_cCodTam
3439: 
3440:         IF NVL(cursor_4c_Disponivel.Sqtds, 0) - loc_nTotalDistr < 0
3441:             MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
3442:         ENDIF
3443: 
3444:         SELECT cursor_4c_Disponivel
3445:         REPLACE QtdSaida WITH loc_nTotalDistr, QtdSaldo WITH NVL(Sqtds, 0) - loc_nTotalDistr
3446: 
3447:         loc_oPgN.grd_4c_Disponivel.Refresh()
3448:         loc_oPgN.grd_4c_Distribui.Refresh()
3449:     ENDPROC
3450: 
3451:     *-- Coluna "Local" do grd_4c_Distribui -> SigPrLcl (codigos/descricaos)
3452:     PROCEDURE TeclaLookupLocalDistribui(par_nKeyCode, par_nShiftAltCtrl)
3453:         IF INLIST(par_nKeyCode, 115, 116)
3454:             THIS.AbrirBuscaLocalDistribui()
3455:         ENDIF
3456:     ENDPROC
3457: 
3458:     PROCEDURE AbrirBuscaLocalDistribui()
3459:         LOCAL loc_oGrid, loc_cValorAtual, loc_oBusca

*-- Linhas 3496 a 3515:
3496:             RETURN
3497:         ENDIF
3498: 
3499:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigPrLcl WHERE " + ;
3500:             "CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaLocalDistribui")
3501: 
3502:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaLocalDistribui") = 1
3503:             loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_ValidaLocalDistribui.codigos)
3504:             IF USED("cursor_4c_ValidaLocalDistribui")
3505:                 USE IN cursor_4c_ValidaLocalDistribui
3506:             ENDIF
3507:         ELSE
3508:             IF USED("cursor_4c_ValidaLocalDistribui")
3509:                 USE IN cursor_4c_ValidaLocalDistribui
3510:             ENDIF
3511:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
3512:             THIS.AbrirBuscaLocalDistribui()
3513:         ENDIF
3514:     ENDPROC
3515: 

*-- Linhas 3531 a 3549:
3531:             RETURN
3532:         ENDIF
3533: 
3534:         SELECT cursor_4c_ItnOpera
3535:         SET ORDER TO Ordem
3536:         SET KEY TO cursor_4c_CabOpera.Dopes + STR(cursor_4c_CabOpera.Numes, 6) IN cursor_4c_ItnOpera
3537:         GO TOP IN cursor_4c_ItnOpera
3538: 
3539:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page4.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
3540:         loc_oGrid.Refresh()
3541:         loc_oGrid.Column1.SetFocus()
3542:     ENDPROC
3543: 
3544:     *-- Processar Distribuicao (cmdProcessar.btnProcessar no legado): mesmas
3545:     *-- duas guard clauses do legado, transcritas literalmente (regra #21
3546:     *-- CLAUDE.md - a condicao ao redor da validacao e regra). A geracao das
3547:     *-- movimentacoes (crSigMvCab/crSigMvItn/crSigMvHst/crSigOpEtq/SigPrDis,
3548:     *-- etiquetas e commit no SQL Server - cerca de 400 linhas no legado) fica
3549:     *-- para fase futura, junto com a populacao de

*-- Linhas 3556 a 3582:
3556:         ENDIF
3557: 
3558:         loc_nTotalDistribuido = 0
3559:         SELECT cursor_4c_Distribui
3560:         COUNT FOR QtdDistr > 0 TO loc_nTotalDistribuido
3561:         IF loc_nTotalDistribuido = 0
3562:             MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
3563:             RETURN
3564:         ENDIF
3565: 
3566:         loc_nSaldoNegativo = 0
3567:         SELECT cursor_4c_Disponivel
3568:         GO TOP
3569:         COUNT FOR QtdSaldo < 0 TO loc_nSaldoNegativo
3570:         IF loc_nSaldoNegativo > 0
3571:             MsgAviso("Existe produtos distribu" + CHR(237) + "dos que est" + CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
3572:                 "Favor checar antes de processar.", "Aviso")
3573:             RETURN
3574:         ENDIF
3575:     ENDPROC
3576: 
3577:     *===========================================================================
3578:     * BtnIncluirClick - Inicia um novo lote de distribuicao
3579:     *===========================================================================
3580:     PROCEDURE BtnIncluirClick()
3581:         TRY
3582:             THIS.this_oBusinessObject.NovoRegistro()

*-- Linhas 3600 a 3618:
3600:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3601:                 MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
3602:             ELSE
3603:                 SELECT cursor_4c_Dados
3604:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3605: 
3606:                 IF THIS.this_oBusinessObject.BuscarItensPorLote(loc_cCodigo)
3607:                     THIS.this_oBusinessObject.this_cCodigo = loc_cCodigo
3608:                     THIS.this_cModoAtual = "VISUALIZAR"
3609:                     THIS.BOParaForm()
3610:                     THIS.HabilitarCampos(.F.)
3611:                     THIS.AjustarBotoesPorModo()
3612:                     THIS.AlternarPagina(2)
3613:                 ENDIF
3614:             ENDIF
3615:         CATCH TO loc_oErro
3616:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnVisualizarClick")
3617:         ENDTRY
3618:     ENDPROC

*-- Linhas 3626 a 3672:
3626:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3627:                 MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
3628:             ELSE
3629:                 SELECT cursor_4c_Dados
3630:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3631: 
3632:                 IF THIS.this_oBusinessObject.BuscarItensPorLote(loc_cCodigo)
3633:                     THIS.this_oBusinessObject.this_cCodigo = loc_cCodigo
3634:                     THIS.this_oBusinessObject.EditarRegistro()
3635:                     THIS.this_cModoAtual = "ALTERAR"
3636:                     THIS.BOParaForm()
3637:                     THIS.HabilitarCampos(.T.)
3638:                     THIS.AjustarBotoesPorModo()
3639:                     THIS.AlternarPagina(2)
3640:                 ENDIF
3641:             ENDIF
3642:         CATCH TO loc_oErro
3643:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnAlterarClick")
3644:         ENDTRY
3645:     ENDPROC
3646: 
3647:     *===========================================================================
3648:     * BtnExcluirClick - Exclui TODOS os itens do lote selecionado
3649:     * Espelha o legado: Delete From SigPrDis Where Codigos = ?_Codigo
3650:     *===========================================================================
3651:     PROCEDURE BtnExcluirClick()
3652:         LOCAL loc_cCodigo
3653:         TRY
3654:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3655:                 MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
3656:             ELSE
3657:                 SELECT cursor_4c_Dados
3658:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3659: 
3660:                 IF MsgConfirma("Confirma exclus" + CHR(227) + "o do lote " + loc_cCodigo + "?", ;
3661:                         "Confirmar Exclus" + CHR(227) + "o")
3662:                     IF THIS.this_oBusinessObject.ExcluirPorCodigo(loc_cCodigo)
3663:                         MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "Sucesso")
3664:                         THIS.CarregarLista()
3665:                     ENDIF
3666:                 ENDIF
3667:             ENDIF
3668:         CATCH TO loc_oErro
3669:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnExcluirClick")
3670:         ENDTRY
3671:     ENDPROC
3672: 

*-- Linhas 3686 a 3708:
3686:                 loc_oBusca.Show()
3687: 
3688:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLote")
3689:                     SELECT cursor_4c_BuscaLote
3690:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaLote.codigos)
3691:                     loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
3692:                     IF USED("cursor_4c_Dados")
3693:                         SELECT cursor_4c_Dados
3694:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3695:                         loc_oGrid.Refresh()
3696:                     ENDIF
3697:                 ENDIF
3698: 
3699:                 loc_oBusca.Release()
3700:             ENDIF
3701: 
3702:             IF USED("cursor_4c_BuscaLote")
3703:                 USE IN cursor_4c_BuscaLote
3704:             ENDIF
3705:         CATCH TO loc_oErro
3706:             IF VARTYPE(loc_oBusca) = "O"
3707:                 loc_oBusca.Release()
3708:             ENDIF


### BO (C:\4c\projeto\app\classes\sigmvdisBO.prg):
*====================================================================
* sigmvdisBO.prg
*
* Business Object para Distribuicao por Movimentacao de Produtos
* Tabela: SigPrDis
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigmvdisBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDis)
    this_cCidChave         = ""    && cidchaves     char(20)  - PK (Fortyus)
    this_cCodigo           = ""    && codigos       char(10)  - Codigo do lote de distribuicao
    this_cCodProduto       = ""    && cpros         char(14)  - Codigo do produto
    this_cCodCor           = ""    && codcors       char(4)   - Codigo da cor
    this_cCodTamanho       = ""    && codtams       char(4)   - Codigo do tamanho
    this_dData             = {}    && datas         datetime  - Data da distribuicao
    this_dDataAlteracao    = {}    && dtalts        datetime  - Data da ultima alteracao
    this_cEmpDopNum        = ""    && empdopnums    char(29)  - Empresa+Documento+Numero de origem
    this_cOriDopNum        = ""    && oridopnums    char(29)  - Empresa+Documento+Numero original
    this_cEmpDestino       = ""    && empds         char(3)   - Empresa de destino
    this_cEmpGrupoEstab    = ""    && empgruests    char(23)  - Empresa+Grupo+Estabelecimento
    this_cLocal            = ""    && locals        char(10)  - Local de estoque
    this_nQtdOrigem        = 0     && qtdos         numeric(10,2) - Quantidade de origem
    this_nQtd              = 0     && qtds          numeric(10,2) - Quantidade distribuida
    this_cUsuario          = ""    && usuars        char(10)  - Usuario de inclusao
    this_cUsuarioAlteracao = ""    && usualts       char(10)  - Usuario de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDis"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvdisBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChave         = TratarNulo(cidchaves,  "C")
                THIS.this_cCodigo           = TratarNulo(codigos,    "C")
                THIS.this_cCodProduto       = TratarNulo(cpros,      "C")
                THIS.this_cCodCor           = TratarNulo(codcors,    "C")
                THIS.this_cCodTamanho       = TratarNulo(codtams,    "C")
                THIS.this_dData             = TratarNulo(datas,      "D")
                THIS.this_dDataAlteracao    = TratarNulo(dtalts,     "D")
                THIS.this_cEmpDopNum        = TratarNulo(empdopnums, "C")
                THIS.this_cOriDopNum        = TratarNulo(oridopnums, "C")
                THIS.this_cEmpDestino       = TratarNulo(empds,      "C")
                THIS.this_cEmpGrupoEstab    = TratarNulo(empgruests, "C")
                THIS.this_cLocal            = TratarNulo(locals,     "C")
                THIS.this_nQtdOrigem        = TratarNulo(qtdos,      "N")
                THIS.this_nQtd              = TratarNulo(qtds,       "N")
                THIS.this_cUsuario          = TratarNulo(usuars,     "C")
                THIS.this_cUsuarioAlteracao = TratarNulo(usualts,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigmvdisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCodProduto)
            MsgAviso("Produto n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmpDestino)
            MsgAviso("Empresa de destino n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nQtd <= 0
            MsgAviso("Quantidade distribu" + CHR(237) + "da deve ser maior que zero!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrDis
    * PK Fortyus (cidchaves): gerada via fUniqueIds() - NUNCA string vazia
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChave
        loc_lSucesso = .F.

        TRY
            loc_cCidChave = IIF(EMPTY(THIS.this_cCidChave), fUniqueIds(), THIS.this_cCidChave)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrDis
                    (cidchaves, codigos, cpros, codcors, codtams,
                     datas, dtalts, empdopnums, oridopnums, empds,
                     empgruests, locals, qtdos, qtds, usuars, usualts)
                VALUES (
                    <<EscaparSQL(loc_cCidChave)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cCodProduto)>>,
                    <<EscaparSQL(THIS.this_cCodCor)>>,
                    <<EscaparSQL(THIS.this_cCodTamanho)>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNum)>>,
                    <<EscaparSQL(THIS.this_cOriDopNum)>>,
                    <<EscaparSQL(THIS.this_cEmpDestino)>>,
                    <<EscaparSQL(THIS.this_cEmpGrupoEstab)>>,
                    <<EscaparSQL(THIS.this_cLocal)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdOrigem, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtd, 2)>>,
                    <<EscaparSQL(gc_4c_UsuarioLogado)>>,
                    <<EscaparSQL(gc_4c_UsuarioLogado)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChave = loc_cCidChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigmvdisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrDis
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrDis
                SET codigos    = <<EscaparSQL(THIS.this_cCodigo)>>,
                    cpros      = <<EscaparSQL(THIS.this_cCodProduto)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodCor)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTamanho)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dData)>>,
                    dtalts     = <<GETDATE()>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNum)>>,
                    oridopnums = <<EscaparSQL(THIS.this_cOriDopNum)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDestino)>>,
                    empgruests = <<EscaparSQL(THIS.this_cEmpGrupoEstab)>>,
                    locals     = <<EscaparSQL(THIS.this_cLocal)>>,
                    qtdos      = <<FormatarNumeroSQL(THIS.this_nQtdOrigem, 2)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nQtd, 2)>>,
                    usualts    = <<EscaparSQL(gc_4c_UsuarioLogado)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigmvdisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrDis
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "sigmvdisBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirPorCodigo - Exclui TODOS os registros de um lote (codigos)
    * Espelha o legado: Delete From SigPrDis Where Codigos = ?_Codigo
    *====================================================================
    PROCEDURE ExcluirPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir lote:" + CHR(13) + loException.Message, "sigmvdisBO.ExcluirPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca lotes de distribuicao (lista distinta de Codigos/Datas)
    * Espelha o legado: Select Distinct Codigos, Datas from SigPrDis
    * Retorna cursor_4c_Dados com codigos, datas
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), datas T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT codigos, datas FROM SigPrDis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY datas DESC, codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvdisBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codigos, cpros, codcors, codtams," + ;
                " datas, dtalts, empdopnums, oridopnums, empds," + ;
                " empgruests, locals, qtdos, qtds, usuars, usualts" + ;
                " FROM SigPrDis WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro de distribui" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigmvdisBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItensPorLote - Carrega TODOS os itens de um lote (codigos)
    * Espelha o legado: Select * from SigPrDis where Codigos = ?_Codigo
    * Retorna cursor_4c_ItensLote
    *====================================================================
    PROCEDURE BuscarItensPorLote(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codigos, cpros, codcors, codtams," + ;
                " datas, dtalts, empdopnums, oridopnums, empds," + ;
                " empgruests, locals, qtdos, qtds, usuars, usualts" + ;
                " FROM SigPrDis WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_ItensLote")
                USE IN cursor_4c_ItensLote
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensLote")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigmvdisBO.BuscarItensPorLote")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

