# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_TOTA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODIGOS, CONTAS, GRUPOS, CPROS, 1, DELETAR, CODBARRAS, DATAS, ESTOS, CODTAMS, CODCORS, OPERS, CBARS, 0, LNCNT, GGRUPOS, IFORS, CGRUS, MERCS, LINHAS, SGRUS, COLECOES, CUNIS, OBSPES, LNPRECOFS, PVENS, NMARCAS, LCWHELOC, LOCALIZAS, DTBALS, SQTDS, ETIQS, CIDQUERYS, PARCS, DIGITENS, CAIXAS, TIPOS, TPBARRAS, ICLIS, ACEBALS, SALDOPS, PESOLIDO, LOCALIS, LNQTDE, NPOS, CTPARQS, MTPRIMAS, CESTOS, TRTPORPESO, PCESCOLHA, CBARS_OLD, LNOKBTN, BARINDIVS, EAN13, AGRUPAS, TIPOESTOS, AUTOS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'I' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODIGOS, CONTAS, GRUPOS, CPROS, 1, DELETAR, CODBARRAS, DATAS, ESTOS, CODTAMS, CODCORS, OPERS, CBARS, 0, LNCNT, GGRUPOS, IFORS, CGRUS, MERCS, LINHAS, SGRUS, COLECOES, CUNIS, OBSPES, LNPRECOFS, PVENS, NMARCAS, LCWHELOC, LOCALIZAS, DTBALS, SQTDS, ETIQS, CIDQUERYS, PARCS, DIGITENS, CAIXAS, TIPOS, TPBARRAS, ICLIS, ACEBALS, SALDOPS, PESOLIDO, LOCALIS, LNQTDE, NPOS, CTPARQS, MTPRIMAS, CESTOS, TRTPORPESO, PCESCOLHA, CBARS_OLD, LNOKBTN, BARINDIVS, EAN13, AGRUPAS, TIPOESTOS, AUTOS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODIGOS, CONTAS, GRUPOS, CPROS, 1, DELETAR, CODBARRAS, DATAS, ESTOS, CODTAMS, CODCORS, OPERS, CBARS, 0, LNCNT, GGRUPOS, IFORS, CGRUS, MERCS, LINHAS, SGRUS, COLECOES, CUNIS, OBSPES, LNPRECOFS, PVENS, NMARCAS, LCWHELOC, LOCALIZAS, DTBALS, SQTDS, ETIQS, CIDQUERYS, PARCS, DIGITENS, CAIXAS, TIPOS, TPBARRAS, ICLIS, ACEBALS, SALDOPS, PESOLIDO, LOCALIS, LNQTDE, NPOS, CTPARQS, MTPRIMAS, CESTOS, TRTPORPESO, PCESCOLHA, CBARS_OLD, LNOKBTN, BARINDIVS, EAN13, AGRUPAS, TIPOESTOS, AUTOS, CIDCHAVES

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
  ControlSource = "crSigCdBal.grupos"
  ControlSource = "crSigCdBal.datafims"
  ControlSource = "crSigCdBal.datainis"
  ControlSource = "crSigCdBal.dtbases"
  ControlSource = "crSigCdBal.codigos"
  ControlSource = "crSigCdBal.localfs"
  ControlSource = "crSigCdBal.CProsF"
  ControlSource = "crSigCdBal.agrupas"
  ControlSource = "crSigCdBal.FilBarras"
  ControlSource = "crSigCdBal.localis"
  ControlSource = "crSigCdBal.CProsI"
  ControlSource = "crSigCdBal.iforfs"
  ControlSource = "crSigCdBal.iforis"
  ControlSource = "crSigCdBal.cggrufs"
  ControlSource = "crSigCdBal.cggruis"
  ControlSource = "crSigCdBal.SGrusF"
  ControlSource = "crSigCdBal.SGrusI"
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = "crSigCdBal.cgrufs"
  ControlSource = "crSigCdBal.cgruis"
  ControlSource = "crSigCdBal.ColecoesF"
  ControlSource = "crSigCdBal.ColecoesI"
  ControlSource = "crSigCdBal.precofs"
  ControlSource = ""
  ControlSource = "crSigCdBal.trtporpeso"
  ControlSource = "crSigCdBal.precois"
  ControlSource = "crSigCdBal.contas"
  ControlSource = ""
  ControlSource = "crSigCdBal.LeitGruCta"
  ControlSource = "crSigCdBal.SepEstqs"
  ControlSource = "crSigCdBal.Obs"
  ControlSource = "crSigCdBal.grupos"
  ControlSource = "crSigCdBal.codigos"
  ControlSource = "crSigCdBal.contas"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "Historico.PesReals"
  ControlSource = "Historico.Ocors"
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "Historico.Obs"
lcQuery = [select a.cPros,a.DPros,a.CUnis,a.Moevs,a.PVens From SigCdPro a Order by 1]
If Thisform.poDataMgr.SqlExecute(lcQuery,'crSigCdPro') < 1
lcQuery = [ Select CodCors, CodTams, Cpros, Lidos as Qtds, 0 as Cbars, Contas, 'N' as Deletar ]+;
	[From SigIvTrB Where Emps = ?pEmp And Codigos = ?pCod Order by cpros]
If Thisform.poDataMgr.SqlExecute(lcQuery,'Inventario') < 1
Select Inventario
lcQuery = [select a.Contas, a.Grupos, A.CPros, a.Cbars ]+;
	[From SigOpEtq a ]+;
	[Join SigIvTrE b on a.cbars = b.cbars ]+;
If Thisform.poDataMgr.SqlExecute(lcQuery,'crOpEtq') < 1
Select crOpEtq
lStrQuery = [Select a.*, 'N' as Deletar ] + ;
	[From SigIvTrE a, SigCdPro b ]+;
If Thisform.poDataMgr.SqlExecute(lStrQuery,'Etiqueta') < 1
Select Etiqueta
lStrQuery = [Select CPros, CodCors, CodTams, Contas, CBars, Tipos, Qtds, Localis, Pesos, PesReals, Emps, Codigos, 'N' as Deletar ] + ;
	[From SigIvTrH ] + ;
If (Thisform.poDataMgr.SqlExecute(lStrQuery,'Historico') < 1)
Select Historico
Select Etiqueta
Select CPros,CodCors,CodTams,Contas,Emps,Codigos,Cbars,Qtds,Pesos, ' ' As Opers From Etiqueta Where 1=0 Into Cursor Apuracao Readwrite
Select Historico
	If Seek(Historico.CPros + Historico.CodCors + Historico.CodTams + Str(Historico.Cbars,14),'Etiqueta','cbars')
Select Inventario
	If Seek(Inventario.CPros + Inventario.CodCors + Inventario.CodTams,'Historico','CorTam')
Select Etiqueta
	If Seek(Etiqueta.CPros + Etiqueta.CodCors + Etiqueta.CodTams + Str(Etiqueta.Cbars,14),'Historico','cbars')
Select Historico
	Select Apuracao
Select Etiqueta
	Select Apuracao
Select Inventario
	Select Apuracao
Select Apuracao
Select CPros, CodCors, CodTams, Contas, Emps, Codigos, Cbars, Sum(Qtds) As Qtds, Sum(Pesos) As Pesos, Opers ;
	From Apuracao ;
Select Diferencas
Select a.Emps,a.CPros,a.Qtds,a.CodTams,a.Pesos,a.CodCors,b.DPros,b.CUnis,b.Moevs,b.PVens,a.Opers,a.Cbars ;
	From Diferencas a ;
	Inner Join crSigCdPro b On b.CPros=a.CPros ;
Select TmpLiRe
		If Not Seek(TmpLiRe.CPros + Str(TmpLiRe.Cbars,14),'crOpEtq','BarraPro')
		lcQuery = [select top 1 sqtds from SigMvHst ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery,'crHists') < 1)
		lcQuery = [select top 1 sqtds from SigMvHst ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery,'crSaldo') < 1)
		Select crSaldo
		Insert Into CrSigMvCab (Datars,DataS,Dopes,Emps,Numes,MascNum,GrupoOs,ContaOs,CIdChaves,DtAlts,EmpDopNums, usuals, Usuars) ;
	Insert Into CrSigMvItn (CPros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Totas,Moedas,DPros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras) ;
		Insert Into CrSigMvIts (Emps,Dopes,Numes,CPros,CodTams,CodCors,Qtds,AQtds,;
		Insert Into CrSigMvHst (CPros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,Opers,Numes,Qtds,Units,Totas,Grupos,;
		lcUpdate = [Update SigOpEtq Set Contas = Space(10), Grupos = Space(10) Where Cbars = ]+Str(TmpLiRe.Cbars,14)
		If Thisform.poDataMgr.SqlExecute(lcUpdate) < 1
			Messagebox('Favor reinicializar o processo !!!',16,'Falha na Conexão (lcUpdate - Inventario)')
	Select TmpLiRe
lnOldSel = Select()
	Select Historico
	Select * From Historico Where 0=0 Into Cursor crQtdLidos ReadWrite
	Select crQtdLidos
	Select Count(*) As Lidos, Sum(Qtds) As Qtds ;
		From crQtdLidos ;
	Select crQtdLidos2
Select(lnOldSel)
lnOldSel = Select()
Select CrGGrupo
Select nMarcas, GGrupos, Descricaos From CrGGrupo Where 1=0 Into Cursor CrAux ReadWrite
Select CrSigCdBal				
	Select CrAux
		Update CrGGrupo set nMarcas =  CrAux.nMarcas Where GGrupos = CrAux.GGrupos
		Select CrAux	
Select CrGGrupo
Select CrGrupo
Select nMarcas, Grupos, Descricaos From CrGrupo Where 1=0 Into Cursor CrAux ReadWrite
Select CrSigCdBal				
	Select CrAux
		Update CrGrupo set nMarcas =  CrAux.nMarcas Where Grupos = CrAux.Grupos
		Select CrAux	
Select CrGrupo
Select(lnOldSel)
lcQuery = [Select 0 As nMarcas, a.Codigos As GGrupos, a.Descs As Descricaos From SigCdGpr a ]
If ThisForm.PoDataMgr.SQLExecute(lcQuery,'TmpGGrp') < 1
Select nMarcas, Descricaos, GGrupos From TmpGGrp Where 1 = 0 Into Cursor 'CrGGrupo' ReadWrite
Select CrGGrupo
Select TmpGGrp
	If !Seek(TmpGGrp.GGrupos,'CrGGrupo','IdxCrGGrp')
		Insert into CrGGrupo from Memvar
Select CrGGrupo
	Select CrGGrupo
		.Column1.ControlSource = 'CrGGrupo.nMarcas'
		.Column2.ControlSource = 'CrGGrupo.GGrupos'
		.Column3.ControlSource = 'CrGGrupo.Descricaos'
lcQuery = [Select 0 As nMarcas,a.CGrus As Grupos,a.DGrus As Descricaos, a.Mercs As GGrupos From SigCdGrp a ]
If ThisForm.PoDataMgr.SQLExecute(lcQuery,'TmpGrp') < 1
Select nMarcas,Grupos,Descricaos,GGrupos From TmpGrp Where 1 = 0 Into Cursor 'CrGrupo' ReadWrite
Select CrGrupo
Select TmpGrp 
	If !Seek(TmpGrp.Grupos,'CrGrupo','IdxCrGrupo')
		Insert into CrGrupo from Memvar
Select CrGrupo
	Select CrGrupo
		.Column1.ControlSource = 'CrGrupo.nMarcas'
		.Column2.ControlSource = 'CrGrupo.Grupos'
		.Column3.ControlSource = 'CrGrupo.Descricaos'
Select CrSigCdBal
Select crProdutos
		Insert Into crSigTempC (cIdQuerys, cIdChaves, CPros) ;
If Not ThisForm.poDataCnx.Update([crSigTempC])
	Messagebox('Favor reinicializar o processo !!!',16,'Falha na Conexão (Update - crSigTempC)')
Select CrGGrupo
Select GGrupos From CrGGrupo Where nMarcas = 1 Into Cursor LocalGGrupo
Select LocalGGrupo
Select CrGrupo
Select Grupos From CrGrupo Where nMarcas = 1 Into Cursor LocalGrupo
Select LocalGrupo
	lcFiltro = [ And p.Cunis in( select cunis from sigcduni where etiqs = ']+Iif(lnFilBar=1,[S],[N])+[') ]
lStrQuery = [Select e.CPros,e.CodCors,e.CodTams,e.Grupos,e.Estos,e.SQtds, e.sPesos, p.cuniPs, p.cBars ]+;
			  [From SigMvEst e, SigCdPro p ]+;
			  [Left Join SigCdGrp g On g.CGrus = p.CGrus ]+;
			 Iif(Reccount([crSigTempC])=0, [], [And e.CPros In (Select c.CPros From SigTempC c ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsBalanco') < 1
Select CPros,cBars,Iif(lnAgrupa = 1,Space(4),CodCors) As CodCors,Iif(lnAgrupa = 1,Space(4),CodTams) As CodTams,;
From CsBalanco ;
Select TmpBalanco
	Insert Into Balanco From MemVar
	Select TmpBalanco
lStrQuery = [Select e.CBars,e.CPros,e.Qtds,e.Datas,e.CodCors,e.CodTams,e.Grupos,e.Contas,e.Pesos,p.cunis,p.cUniPs ]+;
			[From SigOpEtq e, SigCdPro p ]+;
			[Left Join SigCdGrp g On g.CGrus = p.CGrus ]+;
			 Iif(Reccount([crSigTempC])=0, [], [And e.CPros In (Select c.CPros From SigTempC c ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsEtiqueta') < 1
Select CBars,CPros,Qtds,Datas,Iif(lnAgrupa = 1,Space(4),CodCors) As CodCors,Iif(lnAgrupa = 1,Space(4),CodTams) As CodTams,;
From CsEtiqueta ;
Select TmpEtiqueta
	Insert Into Etiqueta From MemVar
	Select TmpEtiqueta
If ! ThisForm.poDataMgr.Update('Balanco') 
If ! ThisForm.poDataMgr.Update('Etiqueta')
Select CrSigCdBal
Delete From Balanco
Delete From Etiqueta
Delete From Historico
ThisForm.poDataMgr.Update('Balanco')
ThisForm.poDataMgr.Update('Etiqueta')
ThisForm.poDataMgr.Update('Historico')
Select crSigCdBal
lcQryBal  = [Select * From SigCdBal Where Emps = ?_Empr Order By Codigos,CIdChaves ]
lcQryInvB = [Select * From SigIvTrB Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CidChaves ]
lcQryInvH = [Select a.*, isnull(b.cbars_old,0) as cbars_old From SigIvTrH a left join SigOpEta b on a.cbars = b.cbars_new Where a.Emps = ?_Empr And a.Codigos = ?lnCodBal Order By a.CidChaves ]
lcQryInvE = [Select * From SigIvTrE Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CidChaves ]
lcQryInvP = [Select a.*, b.DPros From SigIvTrP a, SigCdPro b Where a.Emps = ?_Empr And a.Codigos = ?lnCodBal And a.CPros = b.CPros Order By a.CPros]
If ThisForm.poDataMgr.SqlExecute([Select GrPadFors,GesInd,BalcTrats,ChkDtBars,PerLocals,TpCBars,mascnums,MoePadVens From SigCdPam ],'CrSigCdPam') < 1
Select CrSigCdPam
lStrQuery = [Select * From SigCdOpe Where Parcs <> 1 And Opers = 3 And DigItens = 1 And Caixas <> 1 ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrOpera') < 1
Select CrOpera
Select * From crSigSyCom Where Tipos = 'Leitora Codigo Barra' And TpBarras = 1 Into Cursor CrCfCom
Select CrCfCom
	m.lcMcrSql1 = [select a.cmoes,a.cotas,a.moeqs,a.qtdeqs from SigCdMoe a order by 1]
		Select ('SigCdMoe') 
	m.lcMcrSql1 = [select a.cmoes,a.datas,a.horas,a.valos from SigCdCot a order by 1 asc,2 desc,3 desc]
		Select ('crSigCdCot') 
Select CrSigCdBal
Delete From crProdutos Where Empty(CPros)
lStrQuery = [Select Codigos,Descrs From SigCdGcr Where Codigos = ']+CrSigCdBal.Grupos+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGccr') < 1
Select TmpGccr
lStrQuery = [Select IClis,RClis From SigCdCli Where IClis = ']+CrSigCdBal.Contas+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpCli') < 1
Select TmpCli
Select CrSigCdBal
	Select CrGGrupo
	Select CrGrupo
	Select CrSigCdBal
		Select crProdutos
				Delete In crProdutos
		If Not ThisForm.poDataMgr.Update([crProdutos])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crProdutos)])
Select CrSigCdBal
	Select Balanco
	Update Balanco Set Lidos = 0, Relidos = 0, LidoPs = 0, RelidoPs = 0
	Select Etiqueta
	Select Historico
	Select CPros, CodCors, CodTams, Contas, Tipos, Sum(Qtds) as Qtds, Sum(Pesos) as Pesos ;
		From Historico ;
	Select Historico2
		loBarraHis.Update(.T.)
		If !Seek(Historico2.CPros + Historico2.CodCors + Historico2.CodTams + Historico2.Contas,'Balanco','CPros')
			Insert Into Balanco (CPros,CodCors,CodTams,Contas,Emps,codigos,CIdChaves) ;
	Select Min(DataS) As DataS From CrSigMvCab Into Cursor TmpGdm
	Select CrSigCdBal
		lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigCdBal'),1,-1)
		lnErro1 = Iif(Thisform.poDataMgr.Update('Historico'),1,-1)
		lnErro1 = Iif(Thisform.poDataMgr.Update('Balanco'),1,-1)
			Select CrSigMvCab
			Select CrSigMvItn
			Select CrSigMvIts
			Select CrSigMvHst
			lcQuery = [select a.cPros,a.DPros,a.CUnis,a.Moevs,a.PVens From SigCdPro a Order by 1]
			If Thisform.poDataMgr.SqlExecute(lcQuery,'crSigCdPro') < 1
			lcQuery = [select * From SigCdUni Where Etiqs <> 'S']
			If Thisform.poDataMgr.SqlExecute(lcQuery,'crSigCdUni') < 1
			lStrQuery = [Select a.CPros,a.Saldos,a.Lidos,a.Relidos,a.SaldoPs,a.LidoPs,a.RelidoPs ]+;
				[ From SigIvTrB a ]+;
			If Thisform.poDataMgr.SqlExecute(lStrQuery,'TmpInvB') < 1
			Select a.CPros From TmpInvB a Where a.CPros Not In (Select b.CPros From crSigCdPro b) Into Cursor crChkPro
				Select a.CPros,a.Saldos,a.SaldoPs,;
					From TmpInvB a ;
					Inner Join crSigCdPro b On b.CPros=a.CPros ;
					Inner Join crSigCdUni c on b.Cunis=c.Cunis ; &&-- Rafael - 26/09/2017 -  Carrega as informações somente dos produtos que nao controlam etiqueta individual
				Select TmpLiRe
				Update TmpLiRe Set Opers = [S] Where (Saldos > Qtds Or SaldoPs > PesoLido)
				Update TmpLiRe Set Opers = [E] Where (Saldos < Qtds Or SaldoPs < PesoLido)
				Select CrSigMvCab
				Select CrSigMvItn
				Select CrSigMvHst
				Select CrSigMvHst
				Select TmpLiRe
						Insert Into CrSigMvCab (Datars,DataS,Dopes,Emps,Numes,MascNum,GrupoOs,ContaOs,CIdChaves,DtAlts,EmpDopNums, usuals, Usuars) ;
					Insert Into CrSigMvItn (CPros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Totas,Moedas,DPros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos) ;
						Insert Into CrSigMvHst (CPros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,Opers,Numes,Qtds,Units,Totas,Grupos,;
					lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvCab'), 1, -1)
					lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvItn'), 1, -1)
					lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvIts'), 1, -1)
					lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvHst'), 1, -1)
				Select crChkPro
Select CrSigCdBal
Select Historico
Select Etiqueta
Select Historico 
	lStrQuery = [Select CBars,Pesos From SigOpEtq Where CBars = ]+Alltrim(Str(Historico.CBars,14))+[ ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
	Select TmpEti
	lStrQuery = [Select a.CPros,a.DPros,a.Reffs,a.Linhas,a.FigJpgs,b.Descs,a.CodCors ]+;
				[From SigCdPro a ]+;
				[Left Join SigCdLin b On b.Linhas = a.Linhas ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
	Select TmpPro
	.Column1.ControlSource = 'Historico.CBars'
	.Column2.ControlSource = 'Historico.CPros'
	.Column3.ControlSource = 'Historico.Qtds'
	.Column4.ControlSource = 'Historico.Localis'
	.Column5.ControlSource = 'Historico.CodCors'
	.Column6.ControlSource = 'Historico.CodTams'
	.Column7.ControlSource = 'Historico.pesos'
	.Column8.ControlSource = 'Historico.cBars_old'
	Select Historico
Select crSigCdBal
Select crSigCdBal
Select crRelInvent
	ThisForm.poDataMgr.SqlExecute([Select * From SigCdGcr Where Codigos = ']+crSigCdBal.Grupos+['],'crGrupo')
	Select crRelInvent
	lStrQuery = [Select IClis,RClis From SigCdCli Where IClis = ']+CrSigCdBal.Contas+[' ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpCli') < 1
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
	Select crRelInvent
Select CrSigCdBal
Select Historico
Select Historico 
	lStrQuery = [Select CBars,Pesos From SigOpEtq Where CBars = ]+Alltrim(Str(Historico.CBars,14))+[ ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
	Select TmpEti
	lStrQuery = [Select a.CPros,a.DPros,a.Reffs,a.Linhas,a.FigJpgs,b.Descs,a.CodCors ]+;
				[From SigCdPro a ]+;
				[Left Join SigCdLin b On b.Linhas = a.Linhas ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
	Select TmpPro
	.Column1.ControlSource = 'Historico.CBars'
	.Column2.ControlSource = 'Historico.CPros'
	.Column3.ControlSource = 'Historico.Qtds'
	.Column4.ControlSource = 'Historico.Localis'
	.Column5.ControlSource = 'Historico.CodCors'
	.Column6.ControlSource = 'Historico.CodTams'
	.Column7.ControlSource = 'Historico.Pesos' && #Programador - Hold Gold - Não estava mostrando o peso lido
	.Column8.ControlSource = 'Historico.cBars_old' 
		lcQuery = [select cbars, count(*) from SigCdPro group by cbars having count(*) > 1]
		ThisForm.poDatamgr.SqlExecute(lcQuery, [crTmpPro])
		Select crTmpPro
			Select crTmpPro
			Select crTmpGru
		Select crGerArq
			Insert Into crGerArq (nMarcas, cTpArqs, cNomArqs) ;
		Select crGerArq
				lcQuery = [Select a.* From SigIvTrb a]+;
							[ Inner Join SigCdBal b on b.Codigos = a.Codigos and b.emps=a.emps]+;
				ThisForm.poDataMgr.SqlExecute(lcQuery,'csSigIvTrB')
				Select csSigIvTrB
						= Seek(m.cPros, 'crTmpPro', 'cPros')
						Insert Into crExporta From Memvar
				Select crExporta
				Select a.* From crTmpPro a, crTmpGru b Where a.Cgrus = b.Cgrus And b.mtprimas = 3 ;
				Select crTmpDisp
					= Seek(moecusfs, 'SigCdMoe', 'Cmoes')
					= Seek(crSigCdPam.MoePadVens, 'SigCdMoe', 'Cmoes')
					Select crTmpDisp
					= Seek(m.cPros, 'crTmpPro', 'cPros')
					Insert Into crExporta From Memvar
				Select crExporta
				lcQuery = [Select a.* From SigIvTrb a]+;
							[ Inner Join SigCdBal b on b.Codigos = a.Codigos and b.emps=a.emps]+;
				ThisForm.poDataMgr.SqlExecute(lcQuery,'csSigIvTrB')
				Select crTmpPro
					Insert Into crExporta From Memvar
				Select csSigIvTrB
						= Seek(m.cPros, 'crTmpPro', 'cPros')
						Insert Into crExporta From Memvar
				Select crExporta
	UpDate CrGGrupo Set nMarcas = 0
	UpDate CrGGrupo Set nMarcas = 1 Where GGrupos = This.Value
	UpDate CrGrupo Set nMarcas  = 0
	UpDate CrGrupo Set nMarcas  = 1 Where GGrupos = This.Value
	Select CrGGrupo
	UpDate CrGGrupo Set nMarcas = 0
	UpDate CrGGrupo Set nMarcas = 1 Where GGrupos = This.Value
	UpDate CrGrupo Set nMarcas  = 0
	UpDate CrGrupo Set nMarcas  = 1 Where GGrupos = This.Value
	Select CrGGrupo
UpDate CrGrupo Set nMarcas = 1
UpDate CrGrupo Set nMarcas = 0
UpDate CrGGrupo Set nMarcas = 1
UpDate CrGrupo Set nMarcas = 1
Select CrGrupo
Select CrGGrupo
UpDate CrGGrupo Set nMarcas = 0
UpDate CrGrupo Set nMarcas = 0
	UpDate CrGrupo Set nMarcas    = 0
	UpDate CrGrupo Set nMarcas    = 1 Where Grupos = This.Value
	UpDate CrGrupo Set nMarcas    = 0
	UpDate CrGrupo Set nMarcas    = 1 Where Grupos = This.Value
	Insert Into Historico (CPros,Qtds,Datas,Usuars,Tipos,Localis,CodCors,CodTams,Emps,Codigos,PesReals,CIdChaves );
		lStrQuery = [Select a.CPros,a.CBars, b.cbars_old ] + ;
				[From SigOpEtq a ] + ;
				[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
		If Thisform.poDataMgr.SqlExecute(lStrQuery,'CrEtiqs') < 1
		Select CrEtiqs
		lStrQuery = [Select a.*, isnull(b.cbars_old,0) as cbars_old From SigIvTrH a left join SigOpEta b on a.cbars = b.cbars_new  ]+;
		If Thisform.poDataMgr.SqlExecute(lStrQuery,'CrInvH') < 1
		Select CrInvH
			Select Historico
			If !Seek(CrInvH.CIdChaves,'Historico','CIdChaves')
				Insert Into Historico From Memvar
		Select Historico
		If Seek(Str(This.Parent.TipoLeitura.Value,1) + Padl(Alltrim(lcProd),14),'Historico','TpCBars');
				Or Seek(Str(This.Parent.TipoLeitura.Value + 2,1) + Padl(Alltrim(lcProd),14),'Historico','TpCBars')
				Select Historico
			If CrSigCdPam.BalcTrats And !Seek(Padl(Alltrim(lcProd),14),'Etiqueta','CBars') And Alltrim(lcProd) # '99999999999999'
		Select Historico
			lStrQuery = [Select a.CPros,a.CBars, IsNull(b.cbars_old,0) as cbars_old, a.Qtds,a.Pesos,a.CodCors,a.CodTams,a.Grupos,a.Contas, a.empos, a.Localizas ] + ;
				[From SigOpEtq a ] + ;
				[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
			If Thisform.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
			Select TmpEti
				If Seek(TmpEti.CBars,'Historico','CBars')
					Select Historico
				lStrQuery = [Select CBars,CPros From SigCdPro Where CBars = ]+Alltrim(lcProd)+[ ]
				If Thisform.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
				Select TmpPro
		lStrQuery = [Select a.CPros,a.DPros,a.CGrus,a.IFors,a.Reffs,a.Linhas,a.FigJpgs,b.TipoEstos,c.Descs,d.Etiqs,]+;
			[From SigCdPro a ]+;
			[Left Join SigCdGrp b On b.CGrus  = a.CGrus ]+;
			[Left Join SigCdLin c On c.Linhas = a.Linhas ]+;
			[Left Join SigCdUni d On d.CUnis  = a.CUnis ]+;
		If Thisform.poDataMgr.SqlExecute(lStrQuery,'CsProdutos') < 1
		Select CsProdutos
			lcSql = [Select Cpros,Dpros,Cunis,Situas, DtSituas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,pvens,pvideals,Pcuss,cftios,sgrus,]+;
				[From SigCdPro Where Cbars = ]+lcProd
			If Thisform.poDataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
				lcSql = [Select Cpros, Ean13, cproeqs From SigCdPro Where Ean13 = ]+lcProd
				If Thisform.poDataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
			Select CrTmpPro
				lcSql = [Select Cpros, cproeqs From SigCdPro Where Cpros = ']+lcProd+[']
				If Thisform.poDataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
				Select CrTmpPro
			lcSql = [select cpros, dpros, cbars from sigcdpro where cunis in(select cunis from sigcduni where etiqs <> 'S') And cpros = ']+lcProd+[']
			If Thisform.poDataMgr.SqlExecute(lcSql,'CrTmpProUn') < 1
			Select CrTmpProUn
		lStrQuery = [Select a.CPros,a.DPros,a.CGrus,a.IFors,a.Reffs,a.Linhas,a.FigJpgs,b.TipoEstos,c.Descs,d.Etiqs,]+;
			[From SigCdPro a ]+;
			[Left Join SigCdGrp b On b.CGrus  = a.CGrus ]+;
			[Left Join SigCdLin c On c.Linhas = a.Linhas ]+;
			[Left Join SigCdUni d On d.CUnis  = a.CUnis ]+;
		If Thisform.poDataMgr.SqlExecute(lStrQuery,'CsProdutos') < 1
		Select CsProdutos
	Select CsProdutos
	lnOldSel = Select()
	Select CrGGrupo
		Select * From CrGGrupo Where CrGGrupo.nMarcas = 1 And GGrupos = CsProdutos.Mercs Into Cursor csGGrpLei ReadWrite 
		Select csGGrpLei
	Select CrGrupo
		Select * From CrGrupo Where CrGrupo.nMarcas = 1 And Grupos = CsProdutos.CGrus Into Cursor csGrpLei ReadWrite 
		Select csGrpLei
	Select(lnOldSel)
		If !Seek(TmpEti.CBars,'Etiqueta','CBars')
			Select Historico
			Insert Into Historico (CPros,Qtds,DataS,Usuars,Tipos,Localis,CBars,Emps,Codigos,PesReals,CIdChaves,Pesos, cbars_old ) ;
				Select Historico
				Insert Into Historico (Qtds,DataS,Usuars,Tipos,Localis,CBars,Contas,Emps,Codigos,PesReals,CIdChaves) ;
			Select Historico
	lStrQuery = [Select Codigos,Descrs From SigBaOco Where Tipos = 'O' And Autos <> 'S' ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsOcorr') < 1
	Select CsOcorr
	If Seek(This.Value,'CsOcorr','Codigos')
Select Historico
Select Historico
	Select crTPro
Select Historico
	If Not ThisForm.poDataMgr.Update('Historico') Or  ThisForm.poDataMgr.Commit() < 1
		Messagebox('Favor reinicializar o processo !!!',16,'Falha na Conexão (Update Historico)')
Select Historico
Select Historico
	Select Historico
	Select Historico
		Delete
	Select Historico
Select Historico
lcQueryH = [Select * From SigIvTrH Where Emps = ?_Empr And Codigos = ?lnCodBal Order by CidChaves ]
lcQueryE = [Select * From SigIvTrE Where Emps = ?_Empr And Codigos = ?lnCodBal Order By CidChaves ]
=ThisForm.PodataMgr.SqlExecute(lcQueryH,'CsHistorico')
=Thisform.PodataMgr.SqlExecute(lcQueryE,'CsEtiqueta')
Select Historico
		lcDelete = [Delete from SigIvTrh Where CidChaves = ']+lnChave+[' ]
		If ThisForm.poDataMgr.SqlExecute(lcDelete) < 1
		Select Historico
		Delete
Select Historico

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormBAL.prg) - TRECHOS RELEVANTES PARA PASS SQL (4878 linhas total):

*-- Linhas 470 a 488:
470:             .HighlightBackColor = RGB(255, 255, 255)
471:             .HighlightForeColor = RGB(15, 41, 104)
472:             .HighlightStyle     = 2
473:             .DeleteMark         = .F.
474:             .RecordMark         = .F.
475:             .RowHeight          = 16
476:             .ScrollBars         = 3
477:             .GridLines          = 3
478:             .ReadOnly           = .T.
479:             .Visible            = .T.
480:             .Column1.Width      = 55
481:             .Column2.Width      = 85
482:             .Column3.Width      = 85
483:             .Column4.Width      = 85
484:             .Column5.Width      = 70
485:             .Column6.Width      = 100
486:             .Column7.Width      = 100
487:             .Column8.Width      = 90
488:             .Column1.ReadOnly   = .T.

*-- Linhas 1756 a 1774:
1756:             .BackColor          = RGB(255, 255, 255)
1757:             .GridLineColor      = RGB(200, 200, 200)
1758:             .HighlightStyle     = 2
1759:             .DeleteMark         = .F.
1760:             .RecordMark         = .F.
1761:             .RowHeight          = 17
1762:             .ScrollBars         = 3
1763:             .GridLines          = 3
1764:             .ReadOnly           = .F.
1765:             .Visible            = .T.
1766:             .Column1.Width      = 30
1767:             .Column2.Width      = 50
1768:             .Column3.Width      = 150
1769:             .Column1.Sparse     = .F.
1770:             .Column2.ReadOnly   = .T.
1771:             .Column3.ReadOnly   = .T.
1772:             .Column1.Header1.Caption = ""
1773:             .Column2.Header1.Caption = ""
1774:             .Column3.Header1.Caption = ""

*-- Linhas 1859 a 1877:
1859:             .BackColor          = RGB(255, 255, 255)
1860:             .GridLineColor      = RGB(200, 200, 200)
1861:             .HighlightStyle     = 2
1862:             .DeleteMark         = .F.
1863:             .RecordMark         = .F.
1864:             .RowHeight          = 17
1865:             .ScrollBars         = 3
1866:             .GridLines          = 3
1867:             .ReadOnly           = .F.
1868:             .Visible            = .T.
1869:             .Column1.Width      = 30
1870:             .Column2.Width      = 50
1871:             .Column3.Width      = 150
1872:             .Column1.Sparse     = .F.
1873:             .Column2.ReadOnly   = .T.
1874:             .Column3.ReadOnly   = .T.
1875:             .Column1.Header1.Caption = ""
1876:             .Column2.Header1.Caption = ""
1877:             .Column3.Header1.Caption = ""

*-- Linhas 2329 a 2347:
2329:             .BackColor          = RGB(255, 255, 255)
2330:             .GridLineColor      = RGB(200, 200, 200)
2331:             .HighlightStyle     = 2
2332:             .DeleteMark         = .F.
2333:             .RecordMark         = .F.
2334:             .RowHeight          = 17
2335:             .ScrollBars         = 3
2336:             .GridLines          = 3
2337:             .ReadOnly           = .T.
2338:             .Visible            = .T.
2339:             .Column1.Width      = 100
2340:             .Column2.Width      = 90
2341:             .Column3.Width      = 55
2342:             .Column4.Width      = 70
2343:             .Column5.Width      = 45
2344:             .Column6.Width      = 45
2345:             .Column7.Width      = 55
2346:             .Column8.Width      = 75
2347:             .Column1.ReadOnly   = .T.

*-- Linhas 2999 a 3024:
2999:             ELSE
3000:                 loc_oGrid.ColumnCount = 8
3001:                 loc_oGrid.RecordSource              = "cursor_4c_Dados"
3002:                 loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.codigos"
3003:                 loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.dtbases"
3004:                 loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.datainis"
3005:                 loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.datafims"
3006:                 loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.encerras"
3007:                 loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.grupos"
3008:                 loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.contas"
3009:                 loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.usuars"
3010:                 loc_oGrid.Refresh()
3011:                 loc_lResultado = .T.
3012:             ENDIF
3013:         CATCH TO loc_oErro
3014:             MsgErro(loc_oErro.Message, "FormBAL.CarregarLista")
3015:         ENDTRY
3016: 
3017:         RETURN loc_lResultado
3018:     ENDPROC
3019: 
3020:     *--------------------------------------------------------------------------
3021:     * AlternarPagina - Alterna entre as paginas (1=Lista, 2=Dados, 3=Leitura)
3022:     *--------------------------------------------------------------------------
3023:     PROCEDURE AlternarPagina(par_nPagina)
3024:         TRY

*-- Linhas 3135 a 3156:
3135: 
3136:         TRY
3137:             IF !EMPTY(loc_cGrupo)
3138:                 loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
3139:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGrp")
3140:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGrp") > 0
3141:                     SELECT cursor_4c_DescGrp
3142:                     loc_cDesc = ALLTRIM(cursor_4c_DescGrp.descrs)
3143:                 ENDIF
3144:                 IF USED("cursor_4c_DescGrp")
3145:                     USE IN cursor_4c_DescGrp
3146:                 ENDIF
3147:             ENDIF
3148:         CATCH TO loc_oErro
3149:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoGrupo")
3150:         ENDTRY
3151: 
3152:         THIS.pgf_4c_Paginas.Page2.txt_4c_DGrupo.Value = loc_cDesc
3153:     ENDPROC
3154: 
3155:     *--------------------------------------------------------------------------
3156:     * CarregarDescricaoConta - Preenche txt_4c_DConta com descricao da conta

*-- Linhas 3162 a 3183:
3162: 
3163:         TRY
3164:             IF !EMPTY(loc_cConta)
3165:                 loc_cSQL = "SELECT TOP 1 DNoms FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
3166:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCta")
3167:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCta") > 0
3168:                     SELECT cursor_4c_DescCta
3169:                     loc_cDesc = ALLTRIM(cursor_4c_DescCta.DNoms)
3170:                 ENDIF
3171:                 IF USED("cursor_4c_DescCta")
3172:                     USE IN cursor_4c_DescCta
3173:                 ENDIF
3174:             ENDIF
3175:         CATCH TO loc_oErro
3176:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoConta")
3177:         ENDTRY
3178: 
3179:         THIS.pgf_4c_Paginas.Page2.txt_4c_DConta.Value = loc_cDesc
3180:     ENDPROC
3181: 
3182:     *--------------------------------------------------------------------------
3183:     * CarregarGrades - Carrega grdGGrupo (Grandes Grupos) e grd_4c_Grupos

*-- Linhas 3193 a 3284:
3193:                 USE IN cursor_4c_GGruposTemp
3194:             ENDIF
3195: 
3196:             loc_cSQL = "SELECT 0 AS nMarcas, codigos AS GGrupos, descs AS Descricaos" + ;
3197:                        " FROM SigCdGpr ORDER BY codigos"
3198:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGruposTemp")
3199: 
3200:             IF loc_nRes >= 0
3201:                 *-- Restaurar marcacoes salvas (formato: "cod1,cod2,cod3")
3202:                 IF !EMPTY(loc_cMfilggrp)
3203:                     SELECT cursor_4c_GGruposTemp
3204:                     SCAN
3205:                         IF "," + ALLTRIM(cursor_4c_GGruposTemp.GGrupos) + "," $ "," + loc_cMfilggrp + ","
3206:                             REPLACE nMarcas WITH 1 IN cursor_4c_GGruposTemp
3207:                         ENDIF
3208:                         SELECT cursor_4c_GGruposTemp
3209:                     ENDSCAN
3210:                 ENDIF
3211: 
3212:                 IF USED("cursor_4c_GGrupos")
3213:                     SELECT cursor_4c_GGrupos
3214:                     ZAP
3215:                     APPEND FROM DBF("cursor_4c_GGruposTemp")
3216:                     GO TOP
3217:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3218:                 ELSE
3219:                     SELECT * FROM cursor_4c_GGruposTemp INTO CURSOR cursor_4c_GGrupos READWRITE
3220:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.ColumnCount = 3
3221:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.RecordSource              = "cursor_4c_GGrupos"
3222:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.ControlSource     = "cursor_4c_GGrupos.nMarcas"
3223:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.ControlSource     = "cursor_4c_GGrupos.GGrupos"
3224:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.ControlSource     = "cursor_4c_GGrupos.Descricaos"
3225:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.Header1.Caption   = ""
3226:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.Header1.Caption   = ""
3227:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.Header1.Caption   = ""
3228:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3229:                 ENDIF
3230: 
3231:                 IF USED("cursor_4c_GGruposTemp")
3232:                     USE IN cursor_4c_GGruposTemp
3233:                 ENDIF
3234:             ENDIF
3235: 
3236:             *-- Carregar Grupos Produto (SigCdGrp)
3237:             IF USED("cursor_4c_GruposProdTemp")
3238:                 USE IN cursor_4c_GruposProdTemp
3239:             ENDIF
3240: 
3241:             loc_cSQL = "SELECT 0 AS nMarcas, cgrus AS Codigos, descs AS Descricaos" + ;
3242:                        " FROM SigCdGrp ORDER BY cgrus"
3243:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProdTemp")
3244: 
3245:             IF loc_nRes >= 0
3246:                 *-- Restaurar marcacoes salvas
3247:                 IF !EMPTY(loc_cMfilgrupo)
3248:                     SELECT cursor_4c_GruposProdTemp
3249:                     SCAN
3250:                         IF "," + ALLTRIM(cursor_4c_GruposProdTemp.Codigos) + "," $ "," + loc_cMfilgrupo + ","
3251:                             REPLACE nMarcas WITH 1 IN cursor_4c_GruposProdTemp
3252:                         ENDIF
3253:                         SELECT cursor_4c_GruposProdTemp
3254:                     ENDSCAN
3255:                 ENDIF
3256: 
3257:                 IF USED("cursor_4c_GruposProd")
3258:                     SELECT cursor_4c_GruposProd
3259:                     ZAP
3260:                     APPEND FROM DBF("cursor_4c_GruposProdTemp")
3261:                     GO TOP
3262:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3263:                 ELSE
3264:                     SELECT * FROM cursor_4c_GruposProdTemp INTO CURSOR cursor_4c_GruposProd READWRITE
3265:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.ColumnCount = 3
3266:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.RecordSource              = "cursor_4c_GruposProd"
3267:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.ControlSource     = "cursor_4c_GruposProd.nMarcas"
3268:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.ControlSource     = "cursor_4c_GruposProd.Codigos"
3269:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.ControlSource     = "cursor_4c_GruposProd.Descricaos"
3270:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.Header1.Caption   = ""
3271:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.Header1.Caption   = ""
3272:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.Header1.Caption   = ""
3273:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3274:                 ENDIF
3275: 
3276:                 IF USED("cursor_4c_GruposProdTemp")
3277:                     USE IN cursor_4c_GruposProdTemp
3278:                 ENDIF
3279:             ENDIF
3280:         CATCH TO loc_oErro
3281:             MsgErro(loc_oErro.Message, "FormBAL.CarregarGrades")
3282:         ENDTRY
3283:     ENDPROC
3284: 

*-- Linhas 3291 a 3338:
3291: 
3292:         TRY
3293:             IF USED("cursor_4c_GGrupos")
3294:                 SELECT cursor_4c_GGrupos
3295:                 SCAN
3296:                     IF cursor_4c_GGrupos.nMarcas = 1
3297:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GGrupos.GGrupos)
3298:                     ENDIF
3299:                     SELECT cursor_4c_GGrupos
3300:                 ENDSCAN
3301:             ENDIF
3302:         CATCH TO loc_oErro
3303:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGGrupo")
3304:         ENDTRY
3305: 
3306:         RETURN loc_cLista
3307:     ENDPROC
3308: 
3309:     *--------------------------------------------------------------------------
3310:     * ObterMfilGrupo - Gera string CSV de grupos produto marcados
3311:     *--------------------------------------------------------------------------
3312:     PROTECTED PROCEDURE ObterMfilGrupo()
3313:         LOCAL loc_cLista
3314:         loc_cLista = ""
3315: 
3316:         TRY
3317:             IF USED("cursor_4c_GruposProd")
3318:                 SELECT cursor_4c_GruposProd
3319:                 SCAN
3320:                     IF cursor_4c_GruposProd.nMarcas = 1
3321:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GruposProd.Codigos)
3322:                     ENDIF
3323:                     SELECT cursor_4c_GruposProd
3324:                 ENDSCAN
3325:             ENDIF
3326:         CATCH TO loc_oErro
3327:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGrupo")
3328:         ENDTRY
3329: 
3330:         RETURN loc_cLista
3331:     ENDPROC
3332: 
3333:     *--------------------------------------------------------------------------
3334:     * CarregarGradeLeitura - Carrega historico de leituras do inventario
3335:     *--------------------------------------------------------------------------
3336:     PROCEDURE CarregarGradeLeitura()
3337:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps, loc_oGrd
3338:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos

*-- Linhas 3344 a 3390:
3344:                 USE IN cursor_4c_HistoricoTemp
3345:             ENDIF
3346: 
3347:             loc_cSQL = "SELECT a.cbars, a.cpros, a.lidos AS Qtds, a.localis, a.codcors," + ;
3348:                        " a.codtams, a.lidos2 AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld" + ;
3349:                        " FROM SigIvTrH a" + ;
3350:                        " LEFT JOIN SigOpEta b ON a.cbars = b.cbars_new" + ;
3351:                        " WHERE a.emps = " + EscaparSQL(loc_cEmps) + ;
3352:                        " AND a.codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3353:                        " ORDER BY a.cidchaves"
3354: 
3355:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
3356: 
3357:             IF loc_nRes >= 0
3358:                 IF USED("cursor_4c_Historico")
3359:                     SELECT cursor_4c_Historico
3360:                     ZAP
3361:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
3362:                     GO TOP
3363:                     loc_oGrd.Refresh()
3364:                 ELSE
3365:                     SELECT * FROM cursor_4c_HistoricoTemp INTO CURSOR cursor_4c_Historico READWRITE
3366:                     loc_oGrd.ColumnCount = 8
3367:                     loc_oGrd.RecordSource          = "cursor_4c_Historico"
3368:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Historico.cbars"
3369:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Historico.cpros"
3370:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Historico.Qtds"
3371:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Historico.localis"
3372:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Historico.codcors"
3373:                     loc_oGrd.Column6.ControlSource = "cursor_4c_Historico.codtams"
3374:                     loc_oGrd.Column7.ControlSource = "cursor_4c_Historico.Qtds2"
3375:                     loc_oGrd.Column8.ControlSource = "cursor_4c_Historico.BarsOld"
3376:                     loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
3377:                     loc_oGrd.Column2.Header1.Caption = "Produto"
3378:                     loc_oGrd.Column3.Header1.Caption = "Qtd(1)"
3379:                     loc_oGrd.Column4.Header1.Caption = "Local"
3380:                     loc_oGrd.Column5.Header1.Caption = "Cor"
3381:                     loc_oGrd.Column6.Header1.Caption = "Tam"
3382:                     loc_oGrd.Column7.Header1.Caption = "Qtd(2)"
3383:                     loc_oGrd.Column8.Header1.Caption = "Barra"
3384:                     loc_oGrd.Refresh()
3385:                 ENDIF
3386: 
3387:                 IF USED("cursor_4c_HistoricoTemp")
3388:                     USE IN cursor_4c_HistoricoTemp
3389:                 ENDIF
3390: 

*-- Linhas 3404 a 3430:
3404:         LOCAL loc_nLidos, loc_nQtde, loc_cSQL, loc_nRes
3405: 
3406:         TRY
3407:             IF USED("cursor_4c_Historico")
3408:                 SELECT COUNT(*) AS Lidos, SUM(Qtds) AS Qtde FROM cursor_4c_Historico ;
3409:                     INTO CURSOR cursor_4c_Totais READWRITE
3410: 
3411:                 IF USED("cursor_4c_Totais")
3412:                     SELECT cursor_4c_Totais
3413:                     loc_nLidos = IIF(ISNULL(cursor_4c_Totais.Lidos), 0, cursor_4c_Totais.Lidos)
3414:                     loc_nQtde  = IIF(ISNULL(cursor_4c_Totais.Qtde),  0, cursor_4c_Totais.Qtde)
3415:                     USE IN cursor_4c_Totais
3416:                 ENDIF
3417: 
3418:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Lidos.Value = loc_nLidos
3419:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Qtde.Value  = loc_nQtde
3420:             ENDIF
3421:         CATCH TO loc_oErro
3422:             MsgErro(loc_oErro.Message, "FormBAL.AtualizarTotalLeitura")
3423:         ENDTRY
3424:     ENDPROC
3425: 
3426:     *--------------------------------------------------------------------------
3427:     * InicializarLeitura - Configura Page3 para o inventario selecionado
3428:     *--------------------------------------------------------------------------
3429:     PROTECTED PROCEDURE InicializarLeitura()
3430:         LOCAL loc_oPg3, loc_oBO

*-- Linhas 3482 a 3500:
3482: 
3483:         TRY
3484:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
3485:                 SELECT cursor_4c_Dados
3486:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
3487:             ENDIF
3488:         CATCH TO loc_oErro
3489:             MsgErro(loc_oErro.Message, "FormBAL.ObterCidchavesSelecionado")
3490:         ENDTRY
3491: 
3492:         RETURN loc_cCidchaves
3493:     ENDPROC
3494: 
3495:     *--------------------------------------------------------------------------
3496:     * HabilitarCamposDados - Habilita/desabilita campos da Page2
3497:     *--------------------------------------------------------------------------
3498:     PROTECTED PROCEDURE HabilitarCamposDados(par_lHabilitar)
3499:         LOCAL loc_oPg2
3500:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2

*-- Linhas 3747 a 3765:
3747:     PROCEDURE BtnOrdenarPeriodoClick()
3748:         TRY
3749:             IF USED("cursor_4c_Dados")
3750:                 SELECT cursor_4c_Dados
3751:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3752:             ENDIF
3753:         CATCH TO loc_oErro
3754:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarPeriodoClick")
3755:         ENDTRY
3756:     ENDPROC
3757: 
3758:     PROCEDURE BtnOrdenarEstoqueClick()
3759:         TRY
3760:             THIS.CarregarLista()
3761:         CATCH TO loc_oErro
3762:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarEstoqueClick")
3763:         ENDTRY
3764:     ENDPROC
3765: 

*-- Linhas 3868 a 3931:
3868:     PROCEDURE BtnSelecionarTodosGGrupoClick()
3869:         TRY
3870:             IF USED("cursor_4c_GGrupos")
3871:                 SELECT cursor_4c_GGrupos
3872:                 REPLACE ALL nMarcas WITH 1
3873:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3874:             ENDIF
3875:         CATCH TO loc_oErro
3876:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGGrupoClick")
3877:         ENDTRY
3878:     ENDPROC
3879: 
3880:     *--------------------------------------------------------------------------
3881:     * BtnDesmarcarTodosGGrupoClick - Desmarca todos os grandes grupos
3882:     *--------------------------------------------------------------------------
3883:     PROCEDURE BtnDesmarcarTodosGGrupoClick()
3884:         TRY
3885:             IF USED("cursor_4c_GGrupos")
3886:                 SELECT cursor_4c_GGrupos
3887:                 REPLACE ALL nMarcas WITH 0
3888:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3889:             ENDIF
3890:         CATCH TO loc_oErro
3891:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGGrupoClick")
3892:         ENDTRY
3893:     ENDPROC
3894: 
3895:     *--------------------------------------------------------------------------
3896:     * BtnSelecionarTodosGrupoClick - Marca todos os grupos de produto
3897:     *--------------------------------------------------------------------------
3898:     PROCEDURE BtnSelecionarTodosGrupoClick()
3899:         TRY
3900:             IF USED("cursor_4c_GruposProd")
3901:                 SELECT cursor_4c_GruposProd
3902:                 REPLACE ALL nMarcas WITH 1
3903:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3904:             ENDIF
3905:         CATCH TO loc_oErro
3906:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGrupoClick")
3907:         ENDTRY
3908:     ENDPROC
3909: 
3910:     *--------------------------------------------------------------------------
3911:     * BtnDesmarcarTodosGrupoClick - Desmarca todos os grupos de produto
3912:     *--------------------------------------------------------------------------
3913:     PROCEDURE BtnDesmarcarTodosGrupoClick()
3914:         TRY
3915:             IF USED("cursor_4c_GruposProd")
3916:                 SELECT cursor_4c_GruposProd
3917:                 REPLACE ALL nMarcas WITH 0
3918:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3919:             ENDIF
3920:         CATCH TO loc_oErro
3921:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGrupoClick")
3922:         ENDTRY
3923:     ENDPROC
3924: 
3925:     *==========================================================================
3926:     * HANDLERS - Page3 (Leitura)
3927:     *==========================================================================
3928: 
3929:     *--------------------------------------------------------------------------
3930:     * BtnGravarClick - Salva item de leitura em SigIvTrH
3931:     *--------------------------------------------------------------------------

*-- Linhas 3959 a 4020:
3959:             *-- Gerar UUID para cidchaves da leitura
3960:             LOCAL loc_cCidchaves, loc_nResUuid
3961:             loc_cCidchaves = ""
3962:             loc_nResUuid = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_UuidH")
3963:             IF loc_nResUuid >= 0 AND RECCOUNT("cursor_4c_UuidH") > 0
3964:                 SELECT cursor_4c_UuidH
3965:                 loc_cCidchaves = ALLTRIM(cursor_4c_UuidH.novo_uuid)
3966:             ENDIF
3967:             IF USED("cursor_4c_UuidH")
3968:                 USE IN cursor_4c_UuidH
3969:             ENDIF
3970: 
3971:             IF EMPTY(loc_cCidchaves)
3972:                 MsgErro("Erro ao gerar chave " + CHR(250) + "nica para leitura.", "Erro")
3973:                 RETURN
3974:             ENDIF
3975: 
3976:             *-- Obter cbars do produto (codigo de barras)
3977:             LOCAL loc_cCbars, loc_nResCb
3978:             loc_cCbars = ""
3979:             loc_nResCb = SQLEXEC(gnConnHandle, "SELECT TOP 1 cbars FROM SigCdPro WHERE cpros = " + ;
3980:                          EscaparSQL(loc_cProd), "cursor_4c_CBars")
3981:             IF loc_nResCb >= 0 AND RECCOUNT("cursor_4c_CBars") > 0
3982:                 SELECT cursor_4c_CBars
3983:                 loc_cCbars = ALLTRIM(cursor_4c_CBars.cbars)
3984:             ENDIF
3985:             IF USED("cursor_4c_CBars")
3986:                 USE IN cursor_4c_CBars
3987:             ENDIF
3988: 
3989:             loc_cSQL = "INSERT INTO SigIvTrH (cidchaves, emps, codigos, cbars, cpros," + ;
3990:                        " codcors, codtams, lidos, lidos2, localis, obs)" + ;
3991:                        " VALUES (" + ;
3992:                        EscaparSQL(loc_cCidchaves) + "," + ;
3993:                        EscaparSQL(loc_cEmps) + "," + ;
3994:                        FormatarNumeroSQL(loc_nCodigos) + "," + ;
3995:                        EscaparSQL(loc_cCbars) + "," + ;
3996:                        EscaparSQL(loc_cProd) + "," + ;
3997:                        EscaparSQL(loc_cCodCor) + "," + ;
3998:                        EscaparSQL(loc_cCodTam) + "," + ;
3999:                        FormatarNumeroSQL(loc_nQtd) + "," + ;
4000:                        FormatarNumeroSQL(loc_nQtd2) + "," + ;
4001:                        EscaparSQL(loc_cLocal) + "," + ;
4002:                        EscaparSQL(loc_cObs) + ;
4003:                        ")"
4004: 
4005:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
4006:             IF loc_nRes >= 0
4007:                 loc_lSucesso = .T.
4008:                 THIS.LimparCamposLeitura()
4009:                 THIS.CarregarGradeLeitura()
4010:             ELSE
4011:                 MsgErro("Erro ao gravar leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4012:             ENDIF
4013:         CATCH TO loc_oErro
4014:             MsgErro(loc_oErro.Message, "FormBAL.BtnGravarClick")
4015:         ENDTRY
4016:     ENDPROC
4017: 
4018:     *--------------------------------------------------------------------------
4019:     * BtnCancelaClick - Cancela leitura e volta para lista
4020:     *--------------------------------------------------------------------------

*-- Linhas 4036 a 4066:
4036: 
4037:         TRY
4038:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
4039:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
4040: 
4041:             IF USED("cursor_4c_TotalLocal")
4042:                 USE IN cursor_4c_TotalLocal
4043:             ENDIF
4044: 
4045:             loc_cSQL = "SELECT localis AS Local, COUNT(*) AS Qtde_Itens, SUM(lidos) AS Total_Qtd" + ;
4046:                        " FROM SigIvTrH" + ;
4047:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
4048:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
4049:                        " GROUP BY localis ORDER BY localis"
4050: 
4051:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TotalLocal")
4052:             IF loc_nRes >= 0
4053:                 MsgInfo("Consulta de totais por local conclu" + CHR(237) + "da.", "Total Local")
4054:             ELSE
4055:                 MsgErro("Erro ao calcular totais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4056:             ENDIF
4057:         CATCH TO loc_oErro
4058:             MsgErro(loc_oErro.Message, "FormBAL.BtnTotalLocalClick")
4059:         ENDTRY
4060:     ENDPROC
4061: 
4062:     *--------------------------------------------------------------------------
4063:     * BtnOcorrenciaClick - Registra ocorrencia
4064:     *--------------------------------------------------------------------------
4065:     PROCEDURE BtnOcorrenciaClick()
4066:         TRY

*-- Linhas 4083 a 4104:
4083:                 RETURN
4084:             ENDIF
4085: 
4086:             loc_cSQL = "SELECT TOP 1 imagem FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cProd)
4087:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
4088:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
4089:                 SELECT cursor_4c_ImgProd
4090:                 loc_cImagem = ALLTRIM(cursor_4c_ImgProd.imagem)
4091:                 IF !EMPTY(loc_cImagem) AND FILE(loc_cImagem)
4092:                     loc_oPg3.img_4c_ImgJpg.Picture = loc_cImagem
4093:                     loc_oPg3.img_4c_ImgJpg.Visible = .T.
4094:                 ELSE
4095:                     loc_oPg3.img_4c_ImgJpg.Visible = .F.
4096:                 ENDIF
4097:             ENDIF
4098:             IF USED("cursor_4c_ImgProd")
4099:                 USE IN cursor_4c_ImgProd
4100:             ENDIF
4101:         CATCH TO loc_oErro
4102:             MsgErro(loc_oErro.Message, "FormBAL.BtnImagemClick")
4103:         ENDTRY
4104:     ENDPROC

*-- Linhas 4113 a 4171:
4113:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
4114:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
4115: 
4116:             loc_cSQL = "SELECT TOP 1 localis FROM SigIvTrH" + ;
4117:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
4118:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
4119:                        " ORDER BY cidchaves DESC"
4120: 
4121:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltLocal")
4122:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_UltLocal") > 0
4123:                 SELECT cursor_4c_UltLocal
4124:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value = ALLTRIM(cursor_4c_UltLocal.localis)
4125:             ENDIF
4126:             IF USED("cursor_4c_UltLocal")
4127:                 USE IN cursor_4c_UltLocal
4128:             ENDIF
4129:         CATCH TO loc_oErro
4130:             MsgErro(loc_oErro.Message, "FormBAL.BtnLocalGravadoClick")
4131:         ENDTRY
4132:     ENDPROC
4133: 
4134:     *--------------------------------------------------------------------------
4135:     * BtnExcluirLeituraClick - Exclui registro de leitura selecionado na grade
4136:     *--------------------------------------------------------------------------
4137:     PROCEDURE BtnExcluirLeituraClick()
4138:         LOCAL loc_cCidchaves, loc_cSQL, loc_nRes, loc_lConfirma
4139: 
4140:         TRY
4141:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
4142:                 MsgAviso("Selecione uma leitura para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
4143:                 RETURN
4144:             ENDIF
4145: 
4146:             SELECT cursor_4c_Historico
4147:             loc_cCidchaves = ALLTRIM(cursor_4c_Historico.cbars)
4148: 
4149:             loc_lConfirma = MsgConfirma("Deseja excluir esta leitura?", "Confirmar Exclus" + CHR(227) + "o")
4150: 
4151:             IF loc_lConfirma
4152:                 loc_cSQL = "DELETE FROM SigIvTrH WHERE cbars = " + EscaparSQL(loc_cCidchaves) + ;
4153:                            " AND emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
4154:                            " AND codigos = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nCodigos)
4155: 
4156:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
4157:                 IF loc_nRes >= 0
4158:                     THIS.CarregarGradeLeitura()
4159:                 ELSE
4160:                     MsgErro("Erro ao excluir leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4161:                 ENDIF
4162:             ENDIF
4163:         CATCH TO loc_oErro
4164:             MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirLeituraClick")
4165:         ENDTRY
4166:     ENDPROC
4167: 
4168:     *==========================================================================
4169:     * HANDLERS DE LOOKUP (KeyPress F4)
4170:     *==========================================================================
4171: 


### BO (C:\4c\projeto\app\classes\BALBO.prg):
*====================================================================
* BALBO.prg
*
* Business Object para Balanco de Inventario
* Tabela: SIGCDBAL
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS BALBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDBAL)
	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica UUID)
	*-- Identificacao
	this_nCodigos    = 0    && codigos numeric(4,0) - codigo do balanco
	this_cEmps       = ""   && emps char(3) - empresa
	this_cUsuars     = ""   && usuars char(10) - usuario
	this_nNtrans     = 0    && ntrans numeric(6,0) - numero da transacao
	*-- Grupos de Estoque (conta + grupo)
	this_cGrupos     = ""   && grupos char(10) - grupo de estoque (SigCdGcr)
	this_cContas     = ""   && contas char(10) - conta de estoque (SigCdCli)
	*-- Datas
	this_dDtbases    = {}   && dtbases datetime - data base
	this_dDatainis   = {}   && datainis datetime - data inicial leitura
	this_dDatafims   = {}   && datafims datetime - data final leitura
	this_dDatatrans  = {}   && datatrans datetime - data transporte
	*-- Flags de controle
	this_lEncerras   = .F.  && encerras bit - balanco encerrado
	this_lTratas     = .F.  && tratas bit - tratamento especial
	this_nSepestqs   = 0    && sepestqs numeric(1,0) - separar por estoque
	this_nTrtporpeso = 0    && trtporpeso numeric(1,0) - tratar por peso
	this_nAgrupas    = 0    && agrupas numeric(1,0) - forma de agrupamento
	this_nLeitgructa = 0    && leitgructa numeric(1,0) - leitura somente grupo+conta
	this_nFilbarras  = 0    && filbarras numeric(1,0) - filtro tipo codigo de barras
	*-- Locais (filtros)
	this_cLocals     = ""   && locals char(10) - local (usado na leitura)
	this_cLocalis    = ""   && localis char(10) - local inicial (filtro)
	this_cLocalfs    = ""   && localfs char(10) - local final (filtro)
	*-- Fornecedores (filtros)
	this_cIforis     = ""   && iforis char(10) - fornecedor inicial
	this_cIforfs     = ""   && iforfs char(10) - fornecedor final
	*-- Preco (filtros)
	this_nPrecois    = 0    && precois numeric(8,2) - preco inicial
	this_nPrecofs    = 0    && precofs numeric(8,2) - preco final
	*-- Grupos de Produto (filtros)
	this_cCgruis     = ""   && cgruis char(3) - grupo produto inicial (SigCdGrp.cgrus)
	this_cCgrufs     = ""   && cgrufs char(3) - grupo produto final (SigCdGrp.cgrus)
	*-- Grandes Grupos (filtros)
	this_cCggruis    = ""   && cggruis char(3) - grande grupo inicial (SigCdGpr.codigos)
	this_cCggrufs    = ""   && cggrufs char(3) - grande grupo final (SigCdGpr.codigos)
	*-- Colecoes (filtros)
	this_cColecoesi  = ""   && colecoesi char(10) - colecao inicial (SigCdCol.colecoes)
	this_cColecoesf  = ""   && colecoesf char(10) - colecao final (SigCdCol.colecoes)
	*-- Produtos (filtros)
	this_cCprosi     = ""   && cprosi char(14) - produto inicial (SigCdPro.cpros)
	this_cCprosf     = ""   && cprosf char(14) - produto final (SigCdPro.cpros)
	*-- Subgrupos (filtros)
	this_cSgrusi     = ""   && sgrusi char(6) - subgrupo inicial (SigCdPsg.codigos)
	this_cSgrusf     = ""   && sgrusf char(6) - subgrupo final (SigCdPsg.codigos)
	*-- Unidades (filtros)
	this_cCfinpsi    = ""   && cfinpsi char(3) - unidade inicial (SigCdUni.cunis)
	this_cCfinpsf    = ""   && cfinpsf char(3) - unidade final (SigCdUni.cunis)
	*-- Memo/XML (filtros em grade)
	this_cMfilggrp   = ""   && mfilggrp text - XML marcacoes grandes grupos
	this_cMfilgrupo  = ""   && mfilgrupo text - XML marcacoes grupos produto
	this_cObs        = ""   && obs text - observacao geral

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDBAL"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Lista balancos de inventario da empresa atual
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " ORDER BY codigos, cidchaves"
			ELSE
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos, cidchaves"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um balanco pelo cidchaves (PK UUID)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorNumero - Carrega balanco pelo numero (codigos + emps)
	*====================================================================
	PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
			           " AND emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves    = TratarNulo(cidchaves,    "C")
			THIS.this_nCodigos      = TratarNulo(codigos,      "N")
			THIS.this_cEmps         = TratarNulo(emps,         "C")
			THIS.this_cGrupos       = TratarNulo(grupos,       "C")
			THIS.this_cContas       = TratarNulo(contas,       "C")
			THIS.this_dDtbases      = TratarNulo(dtbases,      "D")
			THIS.this_dDatainis     = TratarNulo(datainis,     "D")
			THIS.this_dDatafims     = TratarNulo(datafims,     "D")
			THIS.this_dDatatrans    = TratarNulo(datatrans,    "D")
			THIS.this_lEncerras     = (TratarNulo(encerras,    "N") = 1)
			THIS.this_lTratas       = (TratarNulo(tratas,      "N") = 1)
			THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
			THIS.this_nSepestqs     = TratarNulo(sepestqs,     "N")
			THIS.this_nTrtporpeso   = TratarNulo(trtporpeso,   "N")
			THIS.this_nLeitgructa   = TratarNulo(leitgructa,   "N")
			THIS.this_nFilbarras    = TratarNulo(filbarras,     "N")
			THIS.this_cLocalis      = TratarNulo(localis,      "C")
			THIS.this_cLocalfs      = TratarNulo(localfs,      "C")
			THIS.this_cIforis       = TratarNulo(iforis,       "C")
			THIS.this_cIforfs       = TratarNulo(iforfs,       "C")
			THIS.this_cCgruis       = TratarNulo(cgruis,       "C")
			THIS.this_cCgrufs       = TratarNulo(cgrufs,       "C")
			THIS.this_cCggruis      = TratarNulo(cggruis,      "C")
			THIS.this_cCggrufs      = TratarNulo(cggrufs,      "C")
			THIS.this_cColecoesi    = TratarNulo(colecoesi,    "C")
			THIS.this_cColecoesf    = TratarNulo(colecoesf,    "C")
			THIS.this_cCprosi       = TratarNulo(cprosi,       "C")
			THIS.this_cCprosf       = TratarNulo(cprosf,       "C")
			THIS.this_cSgrusi       = TratarNulo(sgrusi,       "C")
			THIS.this_cSgrusf       = TratarNulo(sgrusf,       "C")
			THIS.this_cCfinpsi      = TratarNulo(cfinpsi,      "C")
			THIS.this_cCfinpsf      = TratarNulo(cfinpsf,      "C")
			THIS.this_nPrecois      = TratarNulo(precois,      "N")
			THIS.this_nPrecofs      = TratarNulo(precofs,      "N")
			THIS.this_nNtrans       = TratarNulo(ntrans,       "N")
			THIS.this_cLocals       = TratarNulo(locals,       "C")
			THIS.this_cUsuars       = TratarNulo(usuars,       "C")
			*-- Campos TEXT/memo (podem nao estar no cursor de listagem)
			IF PEMSTATUS(EVAL(par_cAliasCursor), "mfilggrp", 5) OR ;
			   !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
				THIS.this_cMfilggrp  = TratarNulo(mfilggrp,   "C")
				THIS.this_cMfilgrupo = TratarNulo(mfilgrupo,  "C")
				THIS.this_cObs       = TratarNulo(obs,        "C")
			ENDIF
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
	*====================================================================
	PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
		loc_nCodigo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
			           " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nCodigo = cursor_4c_ProxCod.prox_cod
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		ENDTRY

		RETURN loc_nCodigo
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			*-- Gerar chave UUID e proximo codigo sequencial
			THIS.this_cCidchaves = ""
			loc_cSQL = "SELECT LEFT(NEWID(), 20) AS novo_uuid"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidchaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidchaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				loc_lSucesso = .F.
			ENDIF

			loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
			IF loc_nCodigo = 0
				MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
				loc_lSucesso = .F.
			ENDIF
			THIS.this_nCodigos = loc_nCodigo
			THIS.this_cEmps    = loc_cEmp
			THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

			loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
			           " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
			           " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
			           ") VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cEmps) + "," + ;
			           EscaparSQL(THIS.this_cGrupos) + "," + ;
			           EscaparSQL(THIS.this_cContas) + "," + ;
			           FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           EscaparSQL(THIS.this_cLocalis) + "," + ;
			           EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           EscaparSQL(THIS.this_cIforis) + "," + ;
			           EscaparSQL(THIS.this_cIforfs) + "," + ;
			           EscaparSQL(THIS.this_cCgruis) + "," + ;
			           EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           EscaparSQL(THIS.this_cCggruis) + "," + ;
			           EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           EscaparSQL(THIS.this_cCprosi) + "," + ;
			           EscaparSQL(THIS.this_cCprosf) + "," + ;
			           EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
			           EscaparSQL(THIS.this_cLocals) + "," + ;
			           EscaparSQL(THIS.this_cUsuars) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
			           " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
			           " dtbases = " + FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           " datainis = " + FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           " datafims = " + FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           " filbarras = " + FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
			           " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
			           " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
			           " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
			           " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
			           " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
			           " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
			           " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
			           " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE do balanco e registros filhos
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
		loc_lSucesso = .F.
		loc_nCodigos = THIS.this_nCodigos
		loc_cEmps    = ALLTRIM(THIS.this_cEmps)

		TRY
			*-- Remover registros filhos: SigIvTrB (balancos itens)
			loc_cSQL = "DELETE FROM SigIvTrB" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrH (historico de leitura)
			loc_cSQL = "DELETE FROM SigIvTrH" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrE (etiquetas)
			loc_cSQL = "DELETE FROM SigIvTrE" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover o balanco principal
			loc_cSQL = "DELETE FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarEncerramento - Marca/desmarca balanco como encerrado
	*====================================================================
	PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
			           " datafims = " + FormatarDataSQL(par_dDatafim) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_lEncerras  = par_lEncerrar
				THIS.this_dDatafims  = par_dDatafim
				THIS.RegistrarAuditoria("ENCERRAR")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarTransporte - Marca balanco como transportado
	*====================================================================
	PROCEDURE AtualizarTransporte(par_dDataTrans)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " datatrans = " + FormatarDataSQL(par_dDataTrans) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_dDatatrans = par_dDataTrans
				THIS.RegistrarAuditoria("TRANSPORTE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao registrar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao registrar transporte:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarFiltrosXML - Salva filtros de grade (mfilggrp, mfilgrupo)
	*====================================================================
	PROCEDURE AtualizarFiltrosXML(par_cMfilggrp, par_cMfilgrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " mfilggrp = " + EscaparSQL(par_cMfilggrp) + "," + ;
			           " mfilgrupo = " + EscaparSQL(par_cMfilgrupo) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_cMfilggrp  = par_cMfilggrp
				THIS.this_cMfilgrupo = par_cMfilgrupo
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao salvar filtros XML:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao salvar filtros XML:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarGrupoEstoque - Verifica se grupo de estoque eh valido
	*====================================================================
	PROCEDURE ValidarGrupoEstoque(par_cGrupos)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cGrupos))
				loc_lValido = .F.
			ENDIF

			loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
			           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* ValidarConta - Verifica se conta de estoque eh valida
	*====================================================================
	PROCEDURE ValidarConta(par_cContas)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cContas))
				loc_lValido = .T.
			ENDIF

			loc_cSQL = "SELECT TOP 1 IClis FROM SigCdCli" + ;
			           " WHERE IClis = " + EscaparSQL(ALLTRIM(par_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCta")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValCta") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

ENDDEFINE

