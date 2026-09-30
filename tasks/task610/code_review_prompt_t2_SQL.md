# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTORIGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTDESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS SQL (1912 linhas total):

*-- Linhas 458 a 480:
458:             IF EMPTY(loc_cValor)
459:                 THIS.txt_4c_Demonstrativo.Value = ""
460:             ELSE
461:                 loc_cSQL = "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + ;
462:                            EscaparSQL(loc_cValor)
463:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FemDmoVal")
464:                 IF loc_nResultado > 0 AND !EOF("cursor_4c_FemDmoVal")
465:                     SELECT cursor_4c_FemDmoVal
466:                     THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoVal.Nome)
467:                 ELSE
468:                     THIS.AbrirBuscaDemonstrativo()
469:                 ENDIF
470:                 IF USED("cursor_4c_FemDmoVal")
471:                     USE IN cursor_4c_FemDmoVal
472:                 ENDIF
473:             ENDIF
474:         CATCH TO loc_oErro
475:             MsgErro(loc_oErro.Message + CHR(13) + ;
476:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
477:                     "Procedure: " + loc_oErro.Procedure, ;
478:                     "Erro em FormSigPrFem.ValidarDemonstrativo")
479:         ENDTRY
480: 

*-- Linhas 513 a 531:
513:                 ENDIF
514: 
515:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FemDmoBusca")
516:                     SELECT cursor_4c_FemDmoBusca
517:                     THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoBusca.Nome)
518:                 ENDIF
519: 
520:                 loc_oBusca.Release()
521:             ENDIF
522:         CATCH TO loc_oErro
523:             MsgErro(loc_oErro.Message + CHR(13) + ;
524:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
525:                     "Procedure: " + loc_oErro.Procedure, ;
526:                     "Erro em FormSigPrFem.AbrirBuscaDemonstrativo")
527:         ENDTRY
528: 
529:         IF USED("cursor_4c_FemDmoBusca")
530:             USE IN cursor_4c_FemDmoBusca
531:         ENDIF

*-- Linhas 579 a 600:
579:     *==========================================================================
580:     * Monta um dos 5 sub-containers de detalhe (par_cNome) dentro de
581:     * cnt_4c_Resultado: label lbl_4c_Titulo + grid grd_4c_Dados (3 colunas,
582:     * ReadOnly, sem RecordMark/DeleteMark - regra OPERACIONAL). O
583:     * RecordSource/ControlSource do grid NAO eh definido aqui: o cursor de
584:     * dados ainda nao existe (soh eh criado quando o botao Processar roda,
585:     * nas fases seguintes) - regra #41 (ControlSource antes do cursor
586:     * existir derruba o Init). Quem popular o grid mais adiante DEVE
587:     * reaplicar Column.Width/Header1.Caption depois de setar RecordSource
588:     * (RecordSource reseta ambos - Problema 48/regra #35c).
589:     *==========================================================================
590:         LOCAL loc_oDet
591: 
592:         THIS.cnt_4c_Resultado.AddObject(par_cNome, "Container")
593:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cNome)
594:         WITH loc_oDet
595:             .Top       = par_nTop
596:             .Left      = par_nLeft
597:             .Width     = 294
598:             .Height    = 172
599:             .BackStyle = 0
600:             .Visible   = .F.

*-- Linhas 628 a 646:
628:             .FontSize          = 8
629:             .AllowHeaderSizing = .F.
630:             .AllowRowSizing    = .F.
631:             .DeleteMark        = .F.
632:             .RecordMark        = .F.
633:             .ReadOnly          = .T.
634:             .RowHeight         = 17
635:             .ScrollBars        = 2
636:             .GridLineColor     = RGB(238, 238, 238)
637:             .Visible           = .T.
638:         ENDWITH
639: 
640:         WITH loc_oDet.grd_4c_Dados.Column1
641:             .FontName          = "Tahoma"
642:             .FontSize          = 8
643:             .Width             = 110
644:             .Movable           = .F.
645:             .Resizable         = .F.
646:             .ReadOnly          = .T.

*-- Linhas 966 a 1044:
966:     *
967:     * Roda ANTES de compor o layout, como no legado (Load executa antes do
968:     * Init): assim os cursores ja existem quando CarregarDados() liga os
969:     * grids. Os AddObject dos grids NAO definem RecordSource/ControlSource
970:     * (regra #41 - ControlSource de cursor inexistente derruba o Init); todo
971:     * o bind vive em CarregarDados().
972:     *
973:     * DataSession = 2 (private): estes cursores pertencem a esta instancia do
974:     * form e morrem com ela.
975:     *==========================================================================
976:         LOCAL loc_oErro
977:         TRY
978:             *-- Entradas no periodo (legado: Entradas)
979:             IF USED("cursor_4c_Entradas")
980:                 USE IN cursor_4c_Entradas
981:             ENDIF
982:             SET NULL ON
983:             CREATE CURSOR cursor_4c_Entradas (Emps C(3), TpOps C(15), Qtde N(12,3))
984:             SET NULL OFF
985:             INDEX ON Emps + TpOps TAG TpOps
986: 
987:             *-- Saidas no periodo (legado: Saidas)
988:             IF USED("cursor_4c_Saidas")
989:                 USE IN cursor_4c_Saidas
990:             ENDIF
991:             SET NULL ON
992:             CREATE CURSOR cursor_4c_Saidas (Emps C(3), TpOps C(15), Qtde N(12,3))
993:             SET NULL OFF
994:             INDEX ON Emps + TpOps TAG TpOps
995: 
996:             *-- Saldo atual com funcionarios (legado: Saldos)
997:             IF USED("cursor_4c_Saldos")
998:                 USE IN cursor_4c_Saldos
999:             ENDIF
1000:             SET NULL ON
1001:             CREATE CURSOR cursor_4c_Saldos (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
1002:             SET NULL OFF
1003:             INDEX ON Grupos + Contas TAG GruConta
1004: 
1005:             *-- Saldo com funcionarios antes do periodo (legado: SaldoAnt)
1006:             IF USED("cursor_4c_SaldoAnt")
1007:                 USE IN cursor_4c_SaldoAnt
1008:             ENDIF
1009:             SET NULL ON
1010:             CREATE CURSOR cursor_4c_SaldoAnt (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
1011:             SET NULL OFF
1012:             INDEX ON Grupos + Contas TAG GruConta
1013: 
1014:             *-- Falhas dos funcionarios no periodo (legado: Falhas)
1015:             IF USED("cursor_4c_Falhas")
1016:                 USE IN cursor_4c_Falhas
1017:             ENDIF
1018:             SET NULL ON
1019:             CREATE CURSOR cursor_4c_Falhas (Grupos C(10), Contas C(10), Qtde N(12,3), ;
1020:                                             Entra N(12,3), Saida N(12,3), Emps C(3))
1021:             SET NULL OFF
1022:             INDEX ON Grupos + Contas TAG GruConta
1023: 
1024:             *-- Cursor de trabalho do resumo por Grupo/Conta/Produto (legado: TmpResumo)
1025:             IF USED("cursor_4c_Resumo")
1026:                 USE IN cursor_4c_Resumo
1027:             ENDIF
1028:             SET NULL ON
1029:             CREATE CURSOR cursor_4c_Resumo (Flag L, Flag2 L, Grupo C(10), Conta C(10), ;
1030:                 CMats C(14), CUnis C(3), PesoEnts N(12,3), QtdeEnts N(12,3), ;
1031:                 PesoSais N(12,3), QtdeSais N(12,3), Saldoi N(12,3), Pesagem N(12,3), ;
1032:                 FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), PesoPEnts N(12,3), ;
1033:                 PesoPSais N(12,3), PfTrabs N(9,2), Flag3 L, Varias N(1), ;
1034:                 PesoFabre N(12,3), PesoFabrs N(12,3), cUniPs C(3), CodCors C(4), ;
1035:                 CodTams C(4), Visivel L, Agregas N(1))
1036:             SET NULL OFF
1037:             INDEX ON CMats + CodCors + CodTams TAG cpros
1038:             INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel
1039:         CATCH TO loc_oErro
1040:             *-- Se o erro estourou entre um SET NULL ON e o OFF correspondente,
1041:             *-- repor aqui - senao SET NULL fica ligado para o resto da sessao.
1042:             SET NULL OFF
1043:             MsgErro(loc_oErro.Message + CHR(13) + ;
1044:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1115 a 1176:
1115:     *==========================================================================
1116:     * Aplica a UM dos 5 sub-containers de detalhe o bind que o legado faz em
1117:     * bloco: torna o container e a grade visiveis, posiciona o cursor no topo,
1118:     * define RecordSource + ControlSource das 3 colunas, os captions e - por
1119:     * ULTIMO - as larguras do dump. A 3a coluna eh sempre Emps/"Emp" nos
1120:     * cinco grids do legado.
1121:     *
1122:     * Por que a largura vem DEPOIS do RecordSource: atribuir RecordSource/
1123:     * ControlSource faz o VFP recalcular as larguras para o default 90 e
1124:     * resetar os Header1.Caption (Problema 48 / regra #35c) - definir antes
1125:     * seria descartado.
1126:     *
1127:     * Sem o GO TOP + Refresh a grade nao repinta as linhas inseridas depois
1128:     * de o cursor ter nascido vazio: o cursor fica cheio e a tela parece sem
1129:     * dados (o legado fecha cada bloco com Select <cursor> / Go Top / .Refresh
1130:     * pelo mesmo motivo).
1131:     *==========================================================================
1132:         LOCAL loc_oDet, loc_oGrid
1133: 
1134:         IF !USED(par_cCursor)
1135:             RETURN
1136:         ENDIF
1137: 
1138:         *-- Os 5 sub-containers de detalhe sao filhos de cnt_4c_Resultado, nao
1139:         *-- do Form (Left/Top no dump sao relativos ao container Resultado).
1140:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cContainer)
1141:         loc_oDet.Visible = .T.
1142: 
1143:         loc_oGrid = loc_oDet.grd_4c_Dados
1144:         loc_oGrid.Visible = .T.
1145: 
1146:         SELECT (par_cCursor)
1147:         GO TOP
1148: 
1149:         *-- ColumnCount/RecordSource ficam FORA do WITH: acessar .Column dentro
1150:         *-- do mesmo WITH que ainda esta definindo o RecordSource estoura
1151:         *-- 'Unknown member COLUMN1' porque as colunas nao existem no momento
1152:         *-- em que o WITH eh aberto.
1153:         loc_oGrid.ColumnCount  = 3
1154:         loc_oGrid.RecordSource = par_cCursor
1155: 
1156:         WITH loc_oGrid
1157:             .Column1.ControlSource   = par_cCursor + "." + par_cCampo1
1158:             .Column1.Header1.Caption = par_cCaption1
1159:             .Column2.ControlSource   = par_cCursor + "." + par_cCampo2
1160:             .Column2.Header1.Caption = par_cCaption2
1161:             .Column3.ControlSource   = par_cCursor + ".Emps"
1162:             .Column3.Header1.Caption = "Emp"
1163: 
1164:             *-- Larguras do dump, reaplicadas DEPOIS do RecordSource
1165:             .Column1.Width = 110
1166:             .Column2.Width = 80
1167:             .Column3.Width = 40
1168: 
1169:             .Refresh()
1170:         ENDWITH
1171:     ENDPROC
1172: 
1173:     *==========================================================================
1174:     PROTECTED PROCEDURE AtualizarResumo()
1175:     *==========================================================================
1176:     * Espelha nos 10 TextBox ReadOnly de cnt_4c_Resumo os totais calculados

*-- Linhas 1455 a 1473:
1455:     * BtnVisualizarClick - evento do botao Video (SIGPRFEM.Visualizar.Click)
1456:     *
1457:     * Legado:
1458:     *   If thisform.resultado.Visible / Select TmpImp / Go Top / If !Eof()
1459:     *       Report Form SIGPRFEM Preview NoConsole
1460:     *
1461:     * O "resultado.Visible" do legado eh o gate: sem ter processado, o botao
1462:     * nao faz nada. Aqui o gate eh o mesmo container (cnt_4c_Resultado) mais a
1463:     * flag this_lResultadoPronto, que so fica .T. quando os cursores de
1464:     * impressao foram montados - assim o clique antes de processar avisa em vez
1465:     * de abrir um preview vazio.
1466:     *==========================================================================
1467:     PROCEDURE BtnVisualizarClick()
1468:         LOCAL loc_oErro
1469: 
1470:         IF !THIS.ResultadoDisponivel()
1471:             RETURN
1472:         ENDIF
1473: 

*-- Linhas 1526 a 1563:
1526: 
1527:         IF THIS.cnt_4c_Resultado.Visible AND THIS.this_lResultadoPronto AND ;
1528:            USED("TmpImp")
1529:             SELECT TmpImp
1530:             GO TOP
1531:             loc_lPronto = !EOF("TmpImp")
1532:         ENDIF
1533: 
1534:         IF !loc_lPronto
1535:             MsgAviso("Processe a an" + CHR(225) + "lise antes de emitir o relat" + ;
1536:                      CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
1537:         ENDIF
1538: 
1539:         RETURN loc_lPronto
1540:     ENDFUNC
1541: 
1542:     *==========================================================================
1543:     * MontarCursoresImpressao - bloco "Criando a Impressao" do fim de
1544:     * Processar.Click legado.
1545:     *
1546:     * Monta TmpImprime (coluna da esquerda: totais e falhas por fase),
1547:     * TmpImprime2 (coluna da direita: resumo de entradas/saidas/saldos), faz o
1548:     * FULL JOIN das duas em TmpImp e cria o cursor Cabecalho.
1549:     *
1550:     * Os nomes TmpImp/Cabecalho e os nomes de campo (Linha/Cabec/Titulo/Valor/
1551:     * Traco/Entrada/Saida/Falha/Linha2/Cabec2/Titulo2/Valor2/Traco2/Emps) NAO
1552:     * levam o prefixo cursor_4c_ nem sufixo _4c_: sao contrato do SigPrFem.frx,
1553:     * que veio do legado sem alteracao (PILAR 1/2). Renomear aqui quebraria
1554:     * todas as expressoes do FRX.
1555:     *
1556:     * As somas usadas nas linhas do relatorio vem das properties this_n* do BO
1557:     * (FONTE UNICA - regra #17): o total nao eh recalculado aqui.
1558:     *==========================================================================
1559:     PROTECTED FUNCTION MontarCursoresImpressao()
1560:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1561:         LOCAL loc_nLinha, loc_nLinha2, loc_nPerc
1562:         LOCAL loc_nQEnt, loc_nQSai, loc_nQFalha, loc_cOrdem
1563: 

*-- Linhas 1569 a 1761:
1569:             IF USED("TmpImprime2")
1570:                 USE IN TmpImprime2
1571:             ENDIF
1572:             CREATE CURSOR TmpImprime2 (Linha2 N(3), Cabec2 L, Titulo2 C(40), ;
1573:                                        Valor2 N(12,3), Traco2 L, Emps C(3))
1574: 
1575:             IF USED("TmpImprime")
1576:                 USE IN TmpImprime
1577:             ENDIF
1578:             CREATE CURSOR TmpImprime (Linha N(3), Cabec L, Titulo C(80), Valor N(12,3), ;
1579:                                       Valor1 N(11,3), Traco L, Entrada N(12,3), ;
1580:                                       Saida N(12,3), Falha L)
1581: 
1582:             *-- Coluna da esquerda: os 11 totalizadores, na ordem do legado
1583:             loc_nLinha = 1
1584:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1585:                  VALUES (loc_nLinha, .F., "Saldo Inicial : ", loc_oBO.this_nSaldoInicial)
1586:             loc_nLinha = loc_nLinha + 1
1587:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1588:                  VALUES (loc_nLinha, .F., "Saldo Ant c/Funcion" + CHR(225) + "rio : ", ;
1589:                          loc_oBO.this_nSaldoAnterior)
1590:             loc_nLinha = loc_nLinha + 1
1591:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1592:                  VALUES (loc_nLinha, .F., "Entradas : ", loc_oBO.this_nEntradas)
1593:             loc_nLinha = loc_nLinha + 1
1594:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1595:                  VALUES (loc_nLinha, .F., "Total de Entradas : ", loc_oBO.this_nTotalEntradas)
1596:             loc_nLinha = loc_nLinha + 1
1597:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1598:                  VALUES (loc_nLinha, .F., "Sa" + CHR(237) + "das : ", loc_oBO.this_nSaidas)
1599:             loc_nLinha = loc_nLinha + 1
1600:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1601:                  VALUES (loc_nLinha, .F., "Saldo : ", loc_oBO.this_nSaldo)
1602:             loc_nLinha = loc_nLinha + 1
1603:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1604:                  VALUES (loc_nLinha, .F., "Saldo com Funcion" + CHR(225) + "rios : ", ;
1605:                          loc_oBO.this_nSaldoFuncionarios)
1606:             loc_nLinha = loc_nLinha + 1
1607:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1608:                  VALUES (loc_nLinha, .F., "Pesagem : ", loc_oBO.this_nPesagem)
1609:             loc_nLinha = loc_nLinha + 1
1610:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1611:                  VALUES (loc_nLinha, .F., "Total : ", loc_oBO.this_nSaldoTotal)
1612:             loc_nLinha = loc_nLinha + 1
1613:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
1614:                  VALUES (loc_nLinha, .F., "Falha dos Funcion" + CHR(225) + "rios : ", ;
1615:                          loc_oBO.this_nFalhaFuncionarios, .T.)
1616:             loc_nLinha = loc_nLinha + 1
1617:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
1618:                  VALUES (loc_nLinha, .F., "Diferenca : ", ;
1619:                          loc_oBO.this_nSaldo - loc_oBO.this_nPesagem - ;
1620:                          loc_oBO.this_nSaldoFuncionarios - loc_oBO.this_nFalhaFuncionarios, .T.)
1621: 
1622:             *-- Coluna da direita: resumo de entradas / saidas / saldos das fases
1623:             loc_nLinha2 = 0
1624: 
1625:             SELECT cursor_4c_Entradas
1626:             GO TOP
1627:             IF !EOF()
1628:                 loc_nLinha2 = loc_nLinha2 + 1
1629:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1630:                      VALUES (loc_nLinha2, .T., "Resumo de Entradas")
1631: 
1632:                 SELECT cursor_4c_Entradas
1633:                 SCAN
1634:                     loc_nLinha2 = loc_nLinha2 + 1
1635:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
1636:                          VALUES (loc_nLinha2, .F., cursor_4c_Entradas.TpOps, ;
1637:                                  cursor_4c_Entradas.Qtde, cursor_4c_Entradas.Emps)
1638:                     SELECT cursor_4c_Entradas
1639:                 ENDSCAN
1640:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1641:             ENDIF
1642: 
1643:             loc_nLinha2 = loc_nLinha2 + 1
1644:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1645:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nEntradas)
1646: 
1647:             SELECT cursor_4c_Saidas
1648:             GO TOP
1649:             IF !EOF()
1650:                 loc_nLinha2 = loc_nLinha2 + 1
1651:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1652:                      VALUES (loc_nLinha2, .T., "Resumo de Saidas")
1653: 
1654:                 SELECT cursor_4c_Saidas
1655:                 SCAN
1656:                     loc_nLinha2 = loc_nLinha2 + 1
1657:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
1658:                          VALUES (loc_nLinha2, .F., ;
1659:                                  IIF(EMPTY(cursor_4c_Saidas.TpOps), "PRODUZIDO", cursor_4c_Saidas.TpOps), ;
1660:                                  cursor_4c_Saidas.Qtde, cursor_4c_Saidas.Emps)
1661:                     SELECT cursor_4c_Saidas
1662:                 ENDSCAN
1663:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1664:             ENDIF
1665: 
1666:             loc_nLinha2 = loc_nLinha2 + 1
1667:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1668:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaidas)
1669: 
1670:             SELECT cursor_4c_Saldos
1671:             GO TOP
1672:             IF !EOF()
1673:                 loc_nLinha2 = loc_nLinha2 + 1
1674:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1675:                      VALUES (loc_nLinha2, .T., " ")
1676:                 loc_nLinha2 = loc_nLinha2 + 1
1677:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1678:                      VALUES (loc_nLinha2, .T., "Saldos das Fases")
1679: 
1680:                 SELECT cursor_4c_Saldos
1681:                 SCAN
1682:                     loc_nLinha2 = loc_nLinha2 + 1
1683:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1684:                          VALUES (loc_nLinha2, .F., cursor_4c_Saldos.Grupos, cursor_4c_Saldos.Qtde)
1685:                     SELECT cursor_4c_Saldos
1686:                 ENDSCAN
1687:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1688:             ENDIF
1689: 
1690:             loc_nLinha2 = loc_nLinha2 + 1
1691:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1692:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaldoFuncionarios)
1693: 
1694:             *-- Falhas por fase - a coluna "%" eh Falha/Saida*100 (regra do legado:
1695:             *-- percentual sobre a SAIDA, nao sobre a entrada).
1696:             *-- O guard de Saida = 0 eh o UNICO desvio: o legado divide direto e
1697:             *-- estoura "Divisao por zero" numa fase sem saida no periodo,
1698:             *-- derrubando a montagem do relatorio inteiro.
1699:             SELECT cursor_4c_Falhas
1700:             GO TOP
1701:             IF !EOF()
1702:                 loc_nLinha = loc_nLinha + 1
1703:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
1704:                      VALUES (loc_nLinha, .T., PADC("Falhas das Fases", 70))
1705:                 loc_nLinha = loc_nLinha + 1
1706:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
1707:                      VALUES (loc_nLinha, .T., ;
1708:                              "Setor           Entrada      Saida      Falha Gr         %")
1709: 
1710:                 SELECT cursor_4c_Falhas
1711:                 SCAN
1712:                     loc_nLinha = loc_nLinha + 1
1713:                     loc_nPerc  = IIF(cursor_4c_Falhas.Saida = 0, 0, ;
1714:                                      cursor_4c_Falhas.Qtde / cursor_4c_Falhas.Saida * 100)
1715:                     INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
1716:                                             Entrada, Saida, Falha) ;
1717:                          VALUES (loc_nLinha, .F., cursor_4c_Falhas.Grupos, ;
1718:                                  cursor_4c_Falhas.Qtde, loc_nPerc, cursor_4c_Falhas.Entra, ;
1719:                                  cursor_4c_Falhas.Saida, .T.)
1720:                     SELECT cursor_4c_Falhas
1721:                 ENDSCAN
1722: 
1723:                 SELECT cursor_4c_Falhas
1724:                 SUM Entra, Saida, Qtde TO loc_nQEnt, loc_nQSai, loc_nQFalha
1725:                 loc_nPerc = IIF(loc_nQSai = 0, 0, loc_nQFalha / loc_nQSai * 100)
1726: 
1727:                 REPLACE Traco WITH .T. IN TmpImprime
1728:                 loc_nLinha = loc_nLinha + 1
1729:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
1730:                                         Entrada, Saida, Falha) ;
1731:                      VALUES (loc_nLinha, .F., " ", loc_nQFalha, loc_nPerc, ;
1732:                              loc_nQEnt, loc_nQSai, .T.)
1733:             ENDIF
1734: 
1735:             *-- FULL JOIN das duas colunas, ordenado pela mais longa
1736:             loc_cOrdem = "T1.Linha"
1737:             IF loc_nLinha2 > loc_nLinha
1738:                 loc_cOrdem = "T2.Linha2"
1739:             ENDIF
1740: 
1741:             IF USED("TmpImp")
1742:                 USE IN TmpImp
1743:             ENDIF
1744:             SELECT T1.*, T2.* ;
1745:               FROM TmpImprime T1 ;
1746:               FULL JOIN TmpImprime2 T2 ;
1747:                 ON T1.Linha = T2.Linha2 ;
1748:               INTO CURSOR TmpImp ;
1749:              ORDER BY &loc_cOrdem.
1750: 
1751:             *-- Cabecalho do FRX (razao social da empresa + titulo + periodo)
1752:             IF !THIS.MontarCabecalhoImpressao()
1753:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel montar o cabe" + ;
1754:                          CHR(231) + "alho do relat" + CHR(243) + "rio.", ;
1755:                          "Aten" + CHR(231) + CHR(227) + "o")
1756:             ENDIF
1757: 
1758:             loc_lSucesso = USED("TmpImp")
1759:         CATCH TO loc_oErro
1760:             MsgErro(loc_oErro.Message + CHR(13) + ;
1761:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1771 a 1821:
1771:     *
1772:     * Legado:
1773:     *   CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr, 'Razas')
1774:     *   Create Cursor Cabecalho(pNomeEmpresa c(60), pRelTitulo c(60), pPeriodo c(60))
1775:     *   Insert ... Values (crSigCdEmp.Razas, 'Analise de Producao',
1776:     *                      'Periodo : ' + Dtoc(ldDatai) + ' ate ' + Dtoc(ldDataf))
1777:     *
1778:     * SigCdEmp usa Cemps/Razas (nao Cemps/Razas) - conferido em docs/schema.sql.
1779:     *==========================================================================
1780:     PROTECTED FUNCTION MontarCabecalhoImpressao()
1781:         LOCAL loc_cRazao, loc_nRet, loc_cSQL, loc_oBO
1782: 
1783:         loc_oBO   = THIS.this_oBusinessObject
1784:         loc_cRazao = ""
1785: 
1786:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1787:             IF USED("cursor_4c_CdEmp")
1788:                 USE IN cursor_4c_CdEmp
1789:             ENDIF
1790:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1791:                        EscaparSQL(go_4c_Sistema.cCodEmpresa)
1792:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdEmp")
1793:             IF loc_nRet >= 1 AND USED("cursor_4c_CdEmp") AND !EOF("cursor_4c_CdEmp")
1794:                 loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_CdEmp.Razas, ""))
1795:             ENDIF
1796:         ENDIF
1797: 
1798:         IF EMPTY(loc_cRazao)
1799:             loc_cRazao = ALLTRIM(go_4c_Sistema.cEmpresa)
1800:         ENDIF
1801: 
1802:         IF USED("Cabecalho")
1803:             USE IN Cabecalho
1804:         ENDIF
1805:         CREATE CURSOR Cabecalho (pNomeEmpresa C(60), pRelTitulo C(60), pPeriodo C(60))
1806:         INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
1807:              VALUES (loc_cRazao, ;
1808:                      "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o", ;
1809:                      "Per" + CHR(237) + "odo : " + DTOC(loc_oBO.this_dDataInicial) + ;
1810:                      " at" + CHR(233) + " " + DTOC(loc_oBO.this_dDataFinal))
1811: 
1812:         RETURN USED("Cabecalho")
1813:     ENDFUNC
1814: 
1815:     *==========================================================================
1816:     * ExecutarReportForm - helper canonico de REPORT FORM
1817:     *
1818:     * Combina o que o REPORT FORM cru do legado nao tem e sem o que o relatorio
1819:     * sai errado ou nao sai:
1820:     *   1. guard de EXISTENCIA do FRX (o legado usa "Report Form SIGPRFEM"
1821:     *      BARE, e o VFP9 procuraria o arquivo no diretorio corrente);

*-- Linhas 1843 a 1861:
1843:                          "Aten" + CHR(231) + CHR(227) + "o")
1844:                 RETURN .F.
1845:             ENDIF
1846:             SELECT (par_cCursorDados)
1847:             GO TOP
1848:         ENDIF
1849: 
1850:         loc_cPointOrig    = SET("POINT")
1851:         loc_cSepOrig      = SET("SEPARATOR")
1852:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1853:         SET POINT TO "."
1854:         SET SEPARATOR TO ","
1855:         SET REPORTBEHAVIOR 80
1856: 
1857:         DO CASE
1858:             CASE par_cModo == "PREVIEW"
1859:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1860:             CASE par_cModo == "PRINTER_PROMPT"
1861:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE

