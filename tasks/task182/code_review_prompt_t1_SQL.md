# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS

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
  DeleteMark = .F.
  DeleteMark = .F.
  DeleteMark = .F.
lcSql = [Select Rclis, GerBals, PagFals, RecFals From SigCdCli where Iclis = ']+CrSigMvEst.Estos+[']
If Thisform.Podatamgr.Sqlexecute(lcSql,'CrSigCdCli') < 1
=Seek(CrSigMvEst.Grupos,'CrSigCdGcr','Codigos')
lcQuery = [Select Datas, codigos ] + ;
		    [From SigCdFcx ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select TmpResumo
	Select LocalFecha
	=Seek(Dtos(ldDataB))
	lcQuery = [Select Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, Obss, cIdChaves, EmpDnPs ] + ;
				[From SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
	lcQuery = [Select b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams ] + ;
				[From SigCdNec a, SigCdNei b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensI') < 1)
	Select LocalNensI
	Select LocalNens
		loBarrap.UpDate(.t.)
		=Seek(LocalNens.Dopps, 'CrSigCdOpd', 'Dopps')
		Select LocalNensI
					lcSql = [Select Cpros From SigOpPic where Nops = ]+Str(LocalNensi.Nops)
					=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpOpi')
					=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
					lcSql = [Select Cpros From SigOpPic where Nops = ]+Str(LocalNensi.Nops)
					=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpOpi')
						=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
			=Seek(LocalNensI.CMats, 'TmpPro', 'CPros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
				If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + lcCodCor + lcCodTam, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
				Select TmpResumo
				If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats+ lcCodCor + lcCodTam, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams ) ;
				Select TmpResumo
			=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
				=Seek(_Material, 'TmpPro', 'CPros')
				=Seek(TmpPro.Cgrus,'LocalGru','CGrus')
				=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
					If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + _Material, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, visivel ) ;
					Select TmpResumo
					If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + _Material , 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel ) ;
					Select TmpResumo
	lcQuery = [Select Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves, EmpDs ] + ;
				[From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEest') < 1)
	lcQuery = [Select b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens ] + ;
				[From SigMvCab a, SigMvItn b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
	Select LocalEestI
	lcQuery = [Select b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens ] + ;
				[From SigMvCab a, SigMvIts b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEsti2') < 1)
	Select LocalEsti2
	Select LocalEest
		loBarrap.Update(.t.)
		=Seek(LocalEest.Dopes, 'crSigCdOpe', 'Dopes')
		Select LocalEestI
			=Seek(LocalEesti.Cpros, 'TmpPro', 'CPros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
			=Seek(TmpPro.CUnis,'CrSigCdUni','Cunis')
			Select LocalEsti2
			If Seek(LocalEesti.EmpDopNums + LocalEesti.Cpros + Str(LocalEesti.Citens,4))
						If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
							Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams  ) ;
						Select TmpResumo
						If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
							Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel, CodCors, CodTams ) ;
						Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel  ) ;
					Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel ) ;
					Select TmpResumo
	Select TmpResumo
		Select TmpResumo
		If Not Seek(_Grupo + _Conta + lcMat)
		Select [ ] as Agrupar,Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
		  From TmpResumo ;
		Select TmpResumo
		=Seek(_Grupo + _Conta)
	lcSql = [Select * From SigOpCfe Where Codigos = ]+Str(LocalFecha.Codigos,6)+[ And Emps= ']+_Empr+[' Order by Codigos, cpros ]
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSaldoI') < 1
	Select CrSaldoI
	Select TmpResumo
	=Seek(_Grupo + _Conta)
		=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
		Select CrSaldoI
		=Seek(TmpResumo.Cmats)
		Select TmpResumo
	Select CrSaldoI
		=Seek(CrSaldoI.Cpros, 'TmpPro', 'CPros')
		=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
		Select TmpResumo
			Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
			Select TmpResumo
	Select TmpResumo
	=Seek(_Grupo + _Conta + lcCodMat)
			If Not Seek(_Grupo, 'Saldos')
				Insert Into Saldos (Grupos, Contas, Emps) Values (_Grupo, _Conta, _Empr)
			If Not Seek(_Grupo , 'SaldoAnt')
				Insert Into SaldoAnt (Grupos, Contas, Emps) Values (_Grupo, _Conta, _Empr)
		Select crSigCdOpe
		Select crSigCdOpd
		Select crSigCdGcr
		Select crSigCdUni
		Select LocalGru
		Select LocalGgrp
	Select TmpImp
lcQuery = [Select Top 1 Sqtds ] + ;
		    [From SigMvHst ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvHst') < 1)
Select crSigMvHst
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'P' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPesag') < 1)
Select TmpPesag
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'H' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpSaldo') < 1)
Select TmpSaldo
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'E' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEntra') < 1)
Select TmpEntra
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'S' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpSaida') < 1)
Select TmpSaida
lcQuery = [Select CPros, DPros, CUnis, CGrus, Varias, Custofs, MoeCusfs, MatPrincs, cUniPs ] + ;
		    [From SigCdPro]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPro') < 1)
Select TmpPro
lcQuery = [Select a.Datas, a.Emps, a.Dopps, a.Numps, a.GrupoOs, a.ContaOs, ] + ;
		    [From SigCdNec a, SigCdNei b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crProducao') < 1)
lcQuery = [Select CPros, Nops ] + ;
		    [From SigOpPic]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'Tmpopi') < 1)
Select TmpOpi
Select Distinct EmpDnps, Servicos, CMats, Pesos, ChaveB, TpOps, Qtds, Nops ;
  From crProducao ;
Select crSigCdNei
Select Distinct Datas, Emps, Dopps, Numps, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
From crProducao ;
Select crSigCdNec
	loBarra.UpDate(.t.)
	=Seek(crSigCdNec.Dopps, 'crSigCdOpd', 'Dopps')
		If (Seek(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, 'TmpEntra') Or Seek(crSigCdNec.GrupoOs + Space(10), 'TmpEntra')) And (crSigCdOpd.EstOrigs = 1)
		If (Seek(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, 'TmpSaida') Or Seek(crSigCdNec.GrupoOs + Space(10), 'TmpSaida')) And (crSigCdOpd.EstOrigs = 2)
		If (Seek(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, 'TmpEntra') Or Seek(crSigCdNec.GrupoDs + Space(10), 'TmpEntra')) And (crSigCdOpd.EstDests = 1)
		If (Seek(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, 'TmpSaida') Or Seek(crSigCdNec.GrupoDs + Space(10), 'TmpSaida')) And (crSigCdOpd.EstDests = 2)
	Select crSigCdNei
	=SEEK(lcEdn)
		=Seek(crSigCdNec.GrupoOs, 'crSigCdGcr', 'Codigos')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
				=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
					=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + &lcTemp..TpOps, lcAlias)
					Insert Into &lcAlias. (TpOps) Values (&lcTemp..TpOps)
		=Seek(crSigCdNec.GrupoDs, 'crSigCdGcr', 'Codigos')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
				=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
					=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + &lcTemp..TpOps, lcAlias)
					Insert Into &lcAlias. (TpOps) Values (&lcTemp..TpOps)
lcQuery = [Select a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoOs, a.ContaOs, a.GrupoDs, ] + ;
		    [From SigMvCab a, SigMvItn b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crEstoque') < 1)
Select Distinct EmpDopNums, CPros, Opers, Qtds, ChaveB ;
  From crEstoque ;
Select crSigMvItn
Select Distinct Datas, Emps, EmpDs, Dopes, Numes, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
  From crEstoque ;
Select crSigMvCab
	loBarra.Update(.t.)
	=Seek(crSigMvCab.Dopes, 'crSigCdOpe', 'Dopes')
		If Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra')
		If (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or ; 
			Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or ; 
			Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra') Or ;
			Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpSaida')) Or ;
			(Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra') Or ; 
			Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida') Or ; 
			Seek(crSigMvCab.GrupoDs + Space(10), 'TmpEntra') Or ;
			Seek(crSigMvCab.GrupoDs + Space(10), 'TmpSaida'))			
	Select crSigMvItn
			If (crSigMvItn.Opers = 'S') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida'))
				If (crSigMvItn.Opers = 'E') And (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpEntra'))
					If (crSigMvItn.Opers = 'S') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida'))
						If (crSigMvItn.Opers = 'E') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra'))
						If (crSigMvItn.Opers = 'S') And (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpSaida') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpSaida'))
							If (crSigMvItn.Opers = 'E') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra'))
					If (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida')) And (crSigCdOpe.EstOrigs = 2)
						If (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra')) And (crSigCdOpe.EstOrigs = 1)
					If (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpSaida') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpSaida')) And (crSigCdOpe.EstDests = 2)
						If (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpEntra')) And (crSigCdOpe.EstDests = 1)
		=Seek(_Grupoo, 'crSigCdGcr', 'Codigos')
		=Seek(crSigMvItn.Cpros,'TmpPro','Cpros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')		
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + lcTpOp, lcAlias)
					Select (lcAlias)
		=Seek(_Grupod, 'crSigCdGcr', 'Codigos')
		=Seek(crSigMvItn.Cpros,'TmpPro','Cpros')				
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + lcTpOp, lcAlias)
					Select (lcAlias)
Select TmpPesag
	loBarra.UpDate(.t.)
	lcQuery = [Select Datas, Codigos ] + ;
			    [From SigCdPsc ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPsc') < 1)
	Select crSigCdPsc
	lcQuery = [Select CPros, Qtds ] + ;
			    [From SigCdPsi ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPsi') < 1)
	Select crSigCdPsi
Select TmpSaldo
	loBarra.UpDate(.t.)
	lcQuery = [Select Emps, Grupos, Estos, CPros ] + ;
			    [From SigMvEst Where ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvEst') < 1)
	Select crSigMvEst
		=Seek(CrSigMvEst.Grupos, 'crSigCdGcr', 'Codigos')
Select [ ] as Agrupar, Sum(qtde) as Qtde From Saldos Into cursor CsSelecao group by 1
Select [ ] as Agrupar, Sum(qtde) as Qtde From SaldoAnt Into cursor CsSelecao group by 1
Select TmpSaldo
	loBarra.UpDate(.t.)
	lcQuery = [Select b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems ] + ;
			    [From SigCdFcx a, SigOpCfe b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdFcx') < 1)
	Select crSigCdFcx
		If Not Seek(TmpSaldo.Grupos, 'Falhas')
			Insert Into Falhas (Grupos, Contas, Emps) Values (TmpSaldo.Grupos, TmpSaldo.Contas, _Empr)
Select Entradas
Select Saidas
Select SaldoAnt
		.Column1.Controlsource   = 'SaldoAnt.Grupos'
		.Column2.Controlsource   = 'SaldoAnt.Qtde'
		.Column3.Controlsource   = 'SaldoAnt.Emps'
Select Entradas
		.Column1.Controlsource   = 'Entradas.TpOps'
		.Column2.Controlsource   = 'Entradas.Qtde'
		.Column3.Controlsource   = 'Entradas.emps'
Select Saidas
		.Column1.Controlsource   = 'Saidas.TpOps'
		.Column2.Controlsource   = 'Saidas.Qtde'
		.Column3.Controlsource   = 'Saidas.emps'
Select Saldos
		.Column1.Controlsource   = 'Saldos.Grupos'
		.Column2.Controlsource   = 'Saldos.Qtde'
		.Column3.Controlsource   = 'Saldos.Emps'
Select Falhas
		.Column1.Controlsource   = 'Falhas.Grupos'
		.Column2.Controlsource   = 'Falhas.Qtde'
		.Column3.Controlsource   = 'Falhas.Emps'
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo Inicial : ', lnSaldoIni)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo Ant c/Funcionário : ', lnSaldoaFun)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Entradas : ', lnTotalEntra)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Total de Entradas : ', lnSaldoIni + lnTotalEntra + lnSaldoaFun)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saídas : ', lnTotalSaida)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo : ', lnSaldoIni + lnTotalEntra - lnTotalSaida + lnSaldoaFun)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo com Funcionários : ', lnSaldoFunc)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Pesagem : ', lnPesagem)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Total : ', lnPesagem + lnSaldoFunc)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Traco) Values (lnLinha, .f., 'Falha dos Funcionários : ', lnFalhaFunc, .t.)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Traco) Values (lnLinha, .f., 'Diferenca : ', lnSaldoIni + lnTotalEntra - lnTotalSaida + lnSaldoaFun - lnPesagem - lnSaldoFunc - lnFalhaFunc, .t.)
Select Entradas 
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., 'Resumo de Entradas')
	Select Entradas
		Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
	Select TmpImprime2
Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., ' ', lnTotalEntra)
Select Saidas
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., 'Resumo de Saidas')
	Select Saidas
		Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
	Select TmpImprime2
Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., ' ', lnTotalSaida)
Select Saldos
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., ' ')
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., 'Saldos das Fases')
	Select Saldos
		Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., Saldos.Grupos, Saldos.Qtde)
	Select TmpImprime2
Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., ' ', lnSaldoFunc)
Select Falhas 
	Insert Into TmpImprime (Linha, Cabec, Titulo) Values (lnLinha, .t., Padc('Falhas das Fases',70))
	Insert Into TmpImprime (Linha, Cabec, Titulo) Values (lnLinha, .t., 'Setor           Entrada      Saida      Falha Gr         %')
	Select Falhas
		Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
	Select Falhas
	Select TmpImprime
	Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
Select T1.*, T2.* ;
  From TmpImprime T1 ;
  Full Join TmpImprime2 T2 ;
Insert Into Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
	Select TmpImp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS SQL (1819 linhas total):

*-- Linhas 430 a 448:
430:                 .FontSize          = 8
431:                 .AllowHeaderSizing = .F.
432:                 .AllowRowSizing    = .F.
433:                 .DeleteMark        = .F.
434:                 .RecordMark        = .F.
435:                 .Panel             = 1
436:                 .ReadOnly          = .T.
437:                 .RowHeight         = 17
438:                 .ScrollBars        = 2
439:                 .GridLineColor     = RGB(238, 238, 238)
440:                 .Column1.Width     = 110
441:                 .Column1.Movable   = .F.
442:                 .Column1.Resizable = .F.
443:                 .Column1.ReadOnly  = .T.
444:                 .Column1.FontName  = "Tahoma"
445:                 .Column1.FontSize  = 8
446:                 .Column2.Width     = 80
447:                 .Column2.Movable   = .F.
448:                 .Column2.Resizable = .F.

*-- Linhas 498 a 516:
498:                 .FontSize          = 8
499:                 .AllowHeaderSizing = .F.
500:                 .AllowRowSizing    = .F.
501:                 .DeleteMark        = .F.
502:                 .RecordMark        = .F.
503:                 .Panel             = 1
504:                 .ReadOnly          = .T.
505:                 .RowHeight         = 17
506:                 .ScrollBars        = 2
507:                 .GridLineColor     = RGB(238, 238, 238)
508:                 .Column1.Width     = 110
509:                 .Column1.Movable   = .F.
510:                 .Column1.Resizable = .F.
511:                 .Column1.ReadOnly  = .T.
512:                 .Column1.FontName  = "Tahoma"
513:                 .Column1.FontSize  = 8
514:                 .Column2.Width     = 80
515:                 .Column2.Movable   = .F.
516:                 .Column2.Resizable = .F.

*-- Linhas 566 a 584:
566:                 .FontSize          = 8
567:                 .AllowHeaderSizing = .F.
568:                 .AllowRowSizing    = .F.
569:                 .DeleteMark        = .F.
570:                 .RecordMark        = .F.
571:                 .Panel             = 1
572:                 .ReadOnly          = .T.
573:                 .RowHeight         = 17
574:                 .ScrollBars        = 2
575:                 .GridLineColor     = RGB(238, 238, 238)
576:                 .Column1.Width     = 110
577:                 .Column1.Movable   = .F.
578:                 .Column1.Resizable = .F.
579:                 .Column1.ReadOnly  = .T.
580:                 .Column1.FontName  = "Tahoma"
581:                 .Column1.FontSize  = 8
582:                 .Column2.Width     = 80
583:                 .Column2.Movable   = .F.
584:                 .Column2.Resizable = .F.

*-- Linhas 634 a 652:
634:                 .FontSize          = 8
635:                 .AllowHeaderSizing = .F.
636:                 .AllowRowSizing    = .F.
637:                 .DeleteMark        = .F.
638:                 .RecordMark        = .F.
639:                 .Panel             = 1
640:                 .ReadOnly          = .T.
641:                 .RowHeight         = 17
642:                 .ScrollBars        = 2
643:                 .GridLineColor     = RGB(238, 238, 238)
644:                 .Column1.Width     = 110
645:                 .Column1.Movable   = .F.
646:                 .Column1.Resizable = .F.
647:                 .Column1.ReadOnly  = .T.
648:                 .Column1.FontName  = "Tahoma"
649:                 .Column1.FontSize  = 8
650:                 .Column2.Width     = 80
651:                 .Column2.Movable   = .F.
652:                 .Column2.Resizable = .F.

*-- Linhas 702 a 720:
702:                 .FontSize          = 8
703:                 .AllowHeaderSizing = .F.
704:                 .AllowRowSizing    = .F.
705:                 .DeleteMark        = .F.
706:                 .RecordMark        = .F.
707:                 .Panel             = 1
708:                 .ReadOnly          = .T.
709:                 .RowHeight         = 17
710:                 .ScrollBars        = 2
711:                 .GridLineColor     = RGB(238, 238, 238)
712:                 .Column1.Width     = 110
713:                 .Column1.Movable   = .F.
714:                 .Column1.Resizable = .F.
715:                 .Column1.ReadOnly  = .T.
716:                 .Column1.FontName  = "Tahoma"
717:                 .Column1.FontSize  = 8
718:                 .Column2.Width     = 80
719:                 .Column2.Movable   = .F.
720:                 .Column2.Resizable = .F.

*-- Linhas 1134 a 1247:
1134:     ENDPROC
1135: 
1136:     *==========================================================================
1137:     * AtualizarGrades - Vincula RecordSource/ControlSource em cada grade
1138:     *==========================================================================
1139:     PROTECTED PROCEDURE AtualizarGrades()
1140:         LOCAL loc_oRes
1141:         loc_oRes = THIS.cnt_4c_Resultado
1142: 
1143:         IF USED("SaldoAnt")
1144:             SELECT SaldoAnt
1145:             GO TOP
1146:         ENDIF
1147:         WITH loc_oRes.cnt_4c_Detalhe
1148:             .Visible = .T.
1149:             WITH .grd_4c_Dados
1150:                 .ColumnCount             = 3
1151:                 .RecordSource            = "SaldoAnt"
1152:                 .Column1.ControlSource   = "SaldoAnt.Grupos"
1153:                 .Column1.Header1.Caption = "Fase"
1154:                 .Column2.ControlSource   = "SaldoAnt.Qtde"
1155:                 .Column2.Header1.Caption = "Qtde"
1156:                 .Column3.ControlSource   = "SaldoAnt.Emps"
1157:                 .Column3.Header1.Caption = "Emp"
1158:                 .Refresh
1159:             ENDWITH
1160:         ENDWITH
1161: 
1162:         IF USED("Entradas")
1163:             SELECT Entradas
1164:             GO TOP
1165:         ENDIF
1166:         WITH loc_oRes.cnt_4c_Detalhe2
1167:             .Visible = .T.
1168:             WITH .grd_4c_Dados
1169:                 .ColumnCount             = 3
1170:                 .RecordSource            = "Entradas"
1171:                 .Column1.ControlSource   = "Entradas.TpOps"
1172:                 .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1173:                 .Column2.ControlSource   = "Entradas.Qtde"
1174:                 .Column2.Header1.Caption = "Qtde"
1175:                 .Column3.ControlSource   = "Entradas.Emps"
1176:                 .Column3.Header1.Caption = "Emp"
1177:                 .Refresh
1178:             ENDWITH
1179:         ENDWITH
1180: 
1181:         IF USED("Saidas")
1182:             SELECT Saidas
1183:             GO TOP
1184:         ENDIF
1185:         WITH loc_oRes.cnt_4c_Detalhe3
1186:             .Visible = .T.
1187:             WITH .grd_4c_Dados
1188:                 .ColumnCount             = 3
1189:                 .RecordSource            = "Saidas"
1190:                 .Column1.ControlSource   = "Saidas.TpOps"
1191:                 .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1192:                 .Column2.ControlSource   = "Saidas.Qtde"
1193:                 .Column2.Header1.Caption = "Qtde"
1194:                 .Column3.ControlSource   = "Saidas.Emps"
1195:                 .Column3.Header1.Caption = "Emp"
1196:                 .Refresh
1197:             ENDWITH
1198:         ENDWITH
1199: 
1200:         IF USED("Saldos")
1201:             SELECT Saldos
1202:             GO TOP
1203:         ENDIF
1204:         WITH loc_oRes.cnt_4c_Detalhe4
1205:             .Visible = .T.
1206:             WITH .grd_4c_Dados
1207:                 .ColumnCount             = 3
1208:                 .RecordSource            = "Saldos"
1209:                 .Column1.ControlSource   = "Saldos.Grupos"
1210:                 .Column1.Header1.Caption = "Fase"
1211:                 .Column2.ControlSource   = "Saldos.Qtde"
1212:                 .Column2.Header1.Caption = "Qtde"
1213:                 .Column3.ControlSource   = "Saldos.Emps"
1214:                 .Column3.Header1.Caption = "Emp"
1215:                 .Refresh
1216:             ENDWITH
1217:         ENDWITH
1218: 
1219:         IF USED("Falhas")
1220:             SELECT Falhas
1221:             GO TOP
1222:         ENDIF
1223:         WITH loc_oRes.cnt_4c_Detalhe5
1224:             .Visible = .T.
1225:             WITH .grd_4c_Dados
1226:                 .ColumnCount             = 3
1227:                 .RecordSource            = "Falhas"
1228:                 .Column1.ControlSource   = "Falhas.Grupos"
1229:                 .Column1.Header1.Caption = "Fase"
1230:                 .Column2.ControlSource   = "Falhas.Qtde"
1231:                 .Column2.Header1.Caption = "Falha"
1232:                 .Column3.ControlSource   = "Falhas.Emps"
1233:                 .Column3.Header1.Caption = "Emp"
1234:                 .Refresh
1235:             ENDWITH
1236:         ENDWITH
1237:     ENDPROC
1238: 
1239:     *==========================================================================
1240:     * AtualizarTotalizadores - Preenche TextBoxes do Resumo com valores do BO
1241:     *==========================================================================
1242:     PROTECTED PROCEDURE AtualizarTotalizadores()
1243:         LOCAL loc_oBO, loc_oResumo
1244:         loc_oBO     = THIS.this_oBusinessObject
1245:         loc_oResumo = THIS.cnt_4c_Resultado.cnt_4c_Resumo
1246: 
1247:         WITH loc_oResumo

*-- Linhas 1265 a 1304:
1265:         LOCAL loc_cRelatorio
1266:         IF THIS.cnt_4c_Resultado.Visible
1267:             IF USED("TmpImp")
1268:                 SELECT TmpImp
1269:                 GO TOP
1270:                 IF !EOF()
1271:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1272:                     IF FILE(loc_cRelatorio)
1273:                         REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
1274:                     ELSE
1275:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1276:                     ENDIF
1277:                 ENDIF
1278:             ENDIF
1279:         ENDIF
1280:     ENDPROC
1281: 
1282:     *==========================================================================
1283:     * CmdImprimirClick - Envia relatorio para impressora
1284:     *==========================================================================
1285:     PROCEDURE CmdImprimirClick()
1286:         LOCAL loc_cRelatorio
1287:         IF THIS.cnt_4c_Resultado.Visible
1288:             IF USED("TmpImp")
1289:                 SELECT TmpImp
1290:                 GO TOP
1291:                 IF !EOF()
1292:                     loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
1293:                     IF FILE(loc_cRelatorio)
1294:                         REPORT FORM (loc_cRelatorio) TO PRINT PROMPT NOCONSOLE
1295:                     ELSE
1296:                         MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
1297:                     ENDIF
1298:                 ENDIF
1299:             ENDIF
1300:         ENDIF
1301:     ENDPROC
1302: 
1303:     *==========================================================================
1304:     * CmdEncerrarClick - Fecha o formulario

*-- Linhas 1335 a 1357:
1335:         IF USED("cursor_4c_DmoValida")
1336:             USE IN cursor_4c_DmoValida
1337:         ENDIF
1338:         loc_nRet = SQLEXEC(gnConnHandle, ;
1339:             "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + EscaparSQL(loc_cValor), ;
1340:             "cursor_4c_DmoValida")
1341:         IF loc_nRet > 0 AND NOT EOF("cursor_4c_DmoValida")
1342:             SELECT cursor_4c_DmoValida
1343:             THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1344:         ELSE
1345:             THIS.AbrirLookupDemonstrativo()
1346:         ENDIF
1347:         IF USED("cursor_4c_DmoValida")
1348:             USE IN cursor_4c_DmoValida
1349:         ENDIF
1350:         THIS.txt_4c_Demonstrativo.Refresh
1351:     ENDPROC
1352: 
1353:     *==========================================================================
1354:     * AbrirLookupDemonstrativo - Abre FormBuscaAuxiliar para SigPrDmo
1355:     * Equivalente ao fwBuscaExt do legado (Get_Demonstrativo.Valid)
1356:     *==========================================================================
1357:     PROCEDURE AbrirLookupDemonstrativo()

*-- Linhas 1372 a 1397:
1372: 
1373:         IF loc_oForm.this_lAchouRegistro
1374:             IF USED("cursor_4c_DmoLista")
1375:                 SELECT cursor_4c_DmoLista
1376:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1377:             ENDIF
1378:         ELSE
1379:             loc_oForm.mAddColuna("Nome", "", "Nome")
1380:             loc_oForm.Show()
1381:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_DmoLista")
1382:                 SELECT cursor_4c_DmoLista
1383:                 THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
1384:             ENDIF
1385:         ENDIF
1386: 
1387:         IF USED("cursor_4c_DmoLista")
1388:             USE IN cursor_4c_DmoLista
1389:         ENDIF
1390: 
1391:         THIS.txt_4c_Demonstrativo.Refresh
1392:     ENDPROC
1393: 
1394:     *==========================================================================
1395:     * BtnIncluirClick - Nova analise: limpa filtros/resultados e foca DataI
1396:     *==========================================================================
1397:     PROCEDURE BtnIncluirClick()

*-- Linhas 1488 a 1530:
1488:             ENDIF
1489: 
1490:             IF USED("Entradas")
1491:                 SELECT Entradas
1492:                 ZAP
1493:             ENDIF
1494:             IF USED("Saidas")
1495:                 SELECT Saidas
1496:                 ZAP
1497:             ENDIF
1498:             IF USED("Saldos")
1499:                 SELECT Saldos
1500:                 ZAP
1501:             ENDIF
1502:             IF USED("SaldoAnt")
1503:                 SELECT SaldoAnt
1504:                 ZAP
1505:             ENDIF
1506:             IF USED("Falhas")
1507:                 SELECT Falhas
1508:                 ZAP
1509:             ENDIF
1510:             IF USED("TmpResumo")
1511:                 SELECT TmpResumo
1512:                 ZAP
1513:             ENDIF
1514:             IF USED("TmpImp")
1515:                 SELECT TmpImp
1516:                 ZAP
1517:             ENDIF
1518: 
1519:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1520:                 THIS.this_oBusinessObject.this_nSaldoIni   = 0
1521:                 THIS.this_oBusinessObject.this_nSaldoaFun  = 0
1522:                 THIS.this_oBusinessObject.this_nTotalEntra = 0
1523:                 THIS.this_oBusinessObject.this_nTotalSaida = 0
1524:                 THIS.this_oBusinessObject.this_nSaldoFunc  = 0
1525:                 THIS.this_oBusinessObject.this_nPesagem    = 0
1526:                 THIS.this_oBusinessObject.this_nFalhaFunc  = 0
1527:             ENDIF
1528: 
1529:             THIS.cnt_4c_Resultado.Visible = .F.
1530:             THIS.Refresh

