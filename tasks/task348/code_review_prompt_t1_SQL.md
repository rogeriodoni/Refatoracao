# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (15)
- [GRID-SQL] Campo 'nMarcas' usado em ControlSource de cursor_4c_GruposProd mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Descricaos' usado em ControlSource de cursor_4c_GruposProd mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'nMarcas' usado em ControlSource de cursor_4c_GGrupos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'GGrupos' usado em ControlSource de cursor_4c_GGrupos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Descricaos' usado em ControlSource de cursor_4c_GGrupos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cbars' usado em ControlSource de cursor_4c_Historico mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cpros' usado em ControlSource de cursor_4c_Historico mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Qtds' usado em ControlSource de cursor_4c_Historico mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcors' usado em ControlSource de cursor_4c_Historico mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codtams' usado em ControlSource de cursor_4c_Historico mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Qtds2' usado em ControlSource de cursor_4c_Historico mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'BarsOld' usado em ControlSource de cursor_4c_Historico mas NAO aparece no SELECT SQL
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBAL.prg) - TRECHOS RELEVANTES PARA PASS SQL (4773 linhas total):

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

*-- Linhas 1726 a 1744:
1726:             .BackColor          = RGB(255, 255, 255)
1727:             .GridLineColor      = RGB(200, 200, 200)
1728:             .HighlightStyle     = 2
1729:             .DeleteMark         = .F.
1730:             .RecordMark         = .F.
1731:             .RowHeight          = 17
1732:             .ScrollBars         = 3
1733:             .GridLines          = 3
1734:             .ReadOnly           = .F.
1735:             .Visible            = .T.
1736:             .Column1.Width      = 30
1737:             .Column2.Width      = 50
1738:             .Column3.Width      = 150
1739:             .Column1.Sparse     = .F.
1740:             .Column2.ReadOnly   = .T.
1741:             .Column3.ReadOnly   = .T.
1742:             .Column1.Header1.Caption = ""
1743:             .Column2.Header1.Caption = "Cod."
1744:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 1829 a 1847:
1829:             .BackColor          = RGB(255, 255, 255)
1830:             .GridLineColor      = RGB(200, 200, 200)
1831:             .HighlightStyle     = 2
1832:             .DeleteMark         = .F.
1833:             .RecordMark         = .F.
1834:             .RowHeight          = 17
1835:             .ScrollBars         = 3
1836:             .GridLines          = 3
1837:             .ReadOnly           = .F.
1838:             .Visible            = .T.
1839:             .Column1.Width      = 30
1840:             .Column2.Width      = 50
1841:             .Column3.Width      = 150
1842:             .Column1.Sparse     = .F.
1843:             .Column2.ReadOnly   = .T.
1844:             .Column3.ReadOnly   = .T.
1845:             .Column1.Header1.Caption = ""
1846:             .Column2.Header1.Caption = "Cod."
1847:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 2287 a 2305:
2287:             .BackColor          = RGB(255, 255, 255)
2288:             .GridLineColor      = RGB(200, 200, 200)
2289:             .HighlightStyle     = 2
2290:             .DeleteMark         = .F.
2291:             .RecordMark         = .F.
2292:             .RowHeight          = 17
2293:             .ScrollBars         = 3
2294:             .GridLines          = 3
2295:             .ReadOnly           = .T.
2296:             .Visible            = .T.
2297:             .Column1.Width      = 100
2298:             .Column2.Width      = 90
2299:             .Column3.Width      = 55
2300:             .Column4.Width      = 70
2301:             .Column5.Width      = 45
2302:             .Column6.Width      = 45
2303:             .Column7.Width      = 55
2304:             .Column8.Width      = 75
2305:             .Column1.ReadOnly   = .T.

*-- Linhas 2957 a 2982:
2957:             ELSE
2958:                 loc_oGrid.ColumnCount = 8
2959:                 loc_oGrid.RecordSource              = "cursor_4c_Dados"
2960:                 loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.codigos"
2961:                 loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.dtbases"
2962:                 loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.datainis"
2963:                 loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.datafims"
2964:                 loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.encerras"
2965:                 loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.grupos"
2966:                 loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.contas"
2967:                 loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.usuars"
2968:                 loc_oGrid.Refresh()
2969:                 loc_lResultado = .T.
2970:             ENDIF
2971:         CATCH TO loc_oErro
2972:             MsgErro(loc_oErro.Message, "FormBAL.CarregarLista")
2973:         ENDTRY
2974: 
2975:         RETURN loc_lResultado
2976:     ENDPROC
2977: 
2978:     *--------------------------------------------------------------------------
2979:     * AlternarPagina - Alterna entre as paginas (1=Lista, 2=Dados, 3=Leitura)
2980:     *--------------------------------------------------------------------------
2981:     PROCEDURE AlternarPagina(par_nPagina)
2982:         TRY

*-- Linhas 3093 a 3114:
3093: 
3094:         TRY
3095:             IF !EMPTY(loc_cGrupo)
3096:                 loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
3097:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGrp")
3098:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGrp") > 0
3099:                     SELECT cursor_4c_DescGrp
3100:                     loc_cDesc = ALLTRIM(cursor_4c_DescGrp.descrs)
3101:                 ENDIF
3102:                 IF USED("cursor_4c_DescGrp")
3103:                     USE IN cursor_4c_DescGrp
3104:                 ENDIF
3105:             ENDIF
3106:         CATCH TO loc_oErro
3107:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoGrupo")
3108:         ENDTRY
3109: 
3110:         THIS.pgf_4c_Paginas.Page2.txt_4c_DGrupo.Value = loc_cDesc
3111:     ENDPROC
3112: 
3113:     *--------------------------------------------------------------------------
3114:     * CarregarDescricaoConta - Preenche txt_4c_DConta com descricao da conta

*-- Linhas 3120 a 3335:
3120: 
3121:         TRY
3122:             IF !EMPTY(loc_cConta)
3123:                 loc_cSQL = "SELECT TOP 1 DNoms FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
3124:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCta")
3125:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCta") > 0
3126:                     SELECT cursor_4c_DescCta
3127:                     loc_cDesc = ALLTRIM(cursor_4c_DescCta.DNoms)
3128:                 ENDIF
3129:                 IF USED("cursor_4c_DescCta")
3130:                     USE IN cursor_4c_DescCta
3131:                 ENDIF
3132:             ENDIF
3133:         CATCH TO loc_oErro
3134:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoConta")
3135:         ENDTRY
3136: 
3137:         THIS.pgf_4c_Paginas.Page2.txt_4c_DConta.Value = loc_cDesc
3138:     ENDPROC
3139: 
3140:     *--------------------------------------------------------------------------
3141:     * CarregarGrades - Carrega grdGGrupo (Grandes Grupos) e grd_4c_Grupos
3142:     *--------------------------------------------------------------------------
3143:     PROCEDURE CarregarGrades()
3144:         LOCAL loc_cSQL, loc_nRes, loc_cMfilggrp, loc_cMfilgrupo
3145:         loc_cMfilggrp  = ALLTRIM(THIS.this_oBusinessObject.this_cMfilggrp)
3146:         loc_cMfilgrupo = ALLTRIM(THIS.this_oBusinessObject.this_cMfilgrupo)
3147: 
3148:         TRY
3149:             *-- Carregar Grandes Grupos (SigCdGpr)
3150:             IF USED("cursor_4c_GGrupos")
3151:                 USE IN cursor_4c_GGrupos
3152:             ENDIF
3153: 
3154:             loc_cSQL = "SELECT 0 AS nMarcas, codigos AS GGrupos, descs AS Descricaos" + ;
3155:                        " FROM SigCdGpr ORDER BY codigos"
3156:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGrupos")
3157: 
3158:             IF loc_nRes >= 0
3159:                 *-- Restaurar marcacoes salvas (formato: "cod1,cod2,cod3")
3160:                 IF !EMPTY(loc_cMfilggrp)
3161:                     SELECT cursor_4c_GGrupos
3162:                     SCAN
3163:                         IF "," + ALLTRIM(cursor_4c_GGrupos.GGrupos) + "," $ "," + loc_cMfilggrp + ","
3164:                             REPLACE nMarcas WITH 1 IN cursor_4c_GGrupos
3165:                         ENDIF
3166:                         SELECT cursor_4c_GGrupos
3167:                     ENDSCAN
3168:                 ENDIF
3169: 
3170:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.ColumnCount = 3
3171:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.RecordSource              = "cursor_4c_GGrupos"
3172:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.ControlSource     = "cursor_4c_GGrupos.nMarcas"
3173:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.ControlSource     = "cursor_4c_GGrupos.GGrupos"
3174:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.ControlSource     = "cursor_4c_GGrupos.Descricaos"
3175:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3176:             ENDIF
3177: 
3178:             *-- Carregar Grupos Produto (SigCdGrp)
3179:             IF USED("cursor_4c_GruposProd")
3180:                 USE IN cursor_4c_GruposProd
3181:             ENDIF
3182: 
3183:             loc_cSQL = "SELECT 0 AS nMarcas, cgrus AS Codigos, descs AS Descricaos" + ;
3184:                        " FROM SigCdGrp ORDER BY cgrus"
3185:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProd")
3186: 
3187:             IF loc_nRes >= 0
3188:                 *-- Restaurar marcacoes salvas
3189:                 IF !EMPTY(loc_cMfilgrupo)
3190:                     SELECT cursor_4c_GruposProd
3191:                     SCAN
3192:                         IF "," + ALLTRIM(cursor_4c_GruposProd.Codigos) + "," $ "," + loc_cMfilgrupo + ","
3193:                             REPLACE nMarcas WITH 1 IN cursor_4c_GruposProd
3194:                         ENDIF
3195:                         SELECT cursor_4c_GruposProd
3196:                     ENDSCAN
3197:                 ENDIF
3198: 
3199:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.ColumnCount = 3
3200:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.RecordSource              = "cursor_4c_GruposProd"
3201:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.ControlSource     = "cursor_4c_GruposProd.nMarcas"
3202:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.ControlSource     = "cursor_4c_GruposProd.Codigos"
3203:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.ControlSource     = "cursor_4c_GruposProd.Descricaos"
3204:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3205:             ENDIF
3206:         CATCH TO loc_oErro
3207:             MsgErro(loc_oErro.Message, "FormBAL.CarregarGrades")
3208:         ENDTRY
3209:     ENDPROC
3210: 
3211:     *--------------------------------------------------------------------------
3212:     * ObterMfilGGrupo - Gera string CSV de grandes grupos marcados
3213:     *--------------------------------------------------------------------------
3214:     PROTECTED PROCEDURE ObterMfilGGrupo()
3215:         LOCAL loc_cLista
3216:         loc_cLista = ""
3217: 
3218:         TRY
3219:             IF USED("cursor_4c_GGrupos")
3220:                 SELECT cursor_4c_GGrupos
3221:                 SCAN
3222:                     IF cursor_4c_GGrupos.nMarcas = 1
3223:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GGrupos.GGrupos)
3224:                     ENDIF
3225:                     SELECT cursor_4c_GGrupos
3226:                 ENDSCAN
3227:             ENDIF
3228:         CATCH TO loc_oErro
3229:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGGrupo")
3230:         ENDTRY
3231: 
3232:         RETURN loc_cLista
3233:     ENDPROC
3234: 
3235:     *--------------------------------------------------------------------------
3236:     * ObterMfilGrupo - Gera string CSV de grupos produto marcados
3237:     *--------------------------------------------------------------------------
3238:     PROTECTED PROCEDURE ObterMfilGrupo()
3239:         LOCAL loc_cLista
3240:         loc_cLista = ""
3241: 
3242:         TRY
3243:             IF USED("cursor_4c_GruposProd")
3244:                 SELECT cursor_4c_GruposProd
3245:                 SCAN
3246:                     IF cursor_4c_GruposProd.nMarcas = 1
3247:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GruposProd.Codigos)
3248:                     ENDIF
3249:                     SELECT cursor_4c_GruposProd
3250:                 ENDSCAN
3251:             ENDIF
3252:         CATCH TO loc_oErro
3253:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGrupo")
3254:         ENDTRY
3255: 
3256:         RETURN loc_cLista
3257:     ENDPROC
3258: 
3259:     *--------------------------------------------------------------------------
3260:     * CarregarGradeLeitura - Carrega historico de leituras do inventario
3261:     *--------------------------------------------------------------------------
3262:     PROCEDURE CarregarGradeLeitura()
3263:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps, loc_oGrd
3264:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3265:         loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3266:         loc_oGrd     = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3267: 
3268:         TRY
3269:             IF USED("cursor_4c_Historico")
3270:                 USE IN cursor_4c_Historico
3271:             ENDIF
3272: 
3273:             loc_cSQL = "SELECT a.cbars, a.cpros, a.lidos AS Qtds, a.localis, a.codcors," + ;
3274:                        " a.codtams, a.lidos2 AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld" + ;
3275:                        " FROM SigIvTrH a" + ;
3276:                        " LEFT JOIN SigOpEta b ON a.cbars = b.cbars_new" + ;
3277:                        " WHERE a.emps = " + EscaparSQL(loc_cEmps) + ;
3278:                        " AND a.codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3279:                        " ORDER BY a.cidchaves"
3280: 
3281:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Historico")
3282: 
3283:             IF loc_nRes >= 0
3284:                 loc_oGrd.ColumnCount = 8
3285:                 loc_oGrd.RecordSource          = "cursor_4c_Historico"
3286:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Historico.cbars"
3287:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Historico.cpros"
3288:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Historico.Qtds"
3289:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Historico.localis"
3290:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Historico.codcors"
3291:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Historico.codtams"
3292:                 loc_oGrd.Column7.ControlSource = "cursor_4c_Historico.Qtds2"
3293:                 loc_oGrd.Column8.ControlSource = "cursor_4c_Historico.BarsOld"
3294:                 loc_oGrd.Refresh()
3295: 
3296:                 THIS.AtualizarTotalLeitura()
3297:             ELSE
3298:                 MsgErro("Erro ao carregar leituras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3299:             ENDIF
3300:         CATCH TO loc_oErro
3301:             MsgErro(loc_oErro.Message, "FormBAL.CarregarGradeLeitura")
3302:         ENDTRY
3303:     ENDPROC
3304: 
3305:     *--------------------------------------------------------------------------
3306:     * AtualizarTotalLeitura - Atualiza contadores de lidos e quantidade
3307:     *--------------------------------------------------------------------------
3308:     PROCEDURE AtualizarTotalLeitura()
3309:         LOCAL loc_nLidos, loc_nQtde, loc_cSQL, loc_nRes
3310: 
3311:         TRY
3312:             IF USED("cursor_4c_Historico")
3313:                 SELECT COUNT(*) AS Lidos, SUM(Qtds) AS Qtde FROM cursor_4c_Historico ;
3314:                     INTO CURSOR cursor_4c_Totais READWRITE
3315: 
3316:                 IF USED("cursor_4c_Totais")
3317:                     SELECT cursor_4c_Totais
3318:                     loc_nLidos = IIF(ISNULL(cursor_4c_Totais.Lidos), 0, cursor_4c_Totais.Lidos)
3319:                     loc_nQtde  = IIF(ISNULL(cursor_4c_Totais.Qtde),  0, cursor_4c_Totais.Qtde)
3320:                     USE IN cursor_4c_Totais
3321:                 ENDIF
3322: 
3323:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Lidos.Value = loc_nLidos
3324:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Qtde.Value  = loc_nQtde
3325:             ENDIF
3326:         CATCH TO loc_oErro
3327:             MsgErro(loc_oErro.Message, "FormBAL.AtualizarTotalLeitura")
3328:         ENDTRY
3329:     ENDPROC
3330: 
3331:     *--------------------------------------------------------------------------
3332:     * InicializarLeitura - Configura Page3 para o inventario selecionado
3333:     *--------------------------------------------------------------------------
3334:     PROTECTED PROCEDURE InicializarLeitura()
3335:         LOCAL loc_oPg3, loc_oBO

*-- Linhas 3387 a 3405:
3387: 
3388:         TRY
3389:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
3390:                 SELECT cursor_4c_Dados
3391:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
3392:             ENDIF
3393:         CATCH TO loc_oErro
3394:             MsgErro(loc_oErro.Message, "FormBAL.ObterCidchavesSelecionado")
3395:         ENDTRY
3396: 
3397:         RETURN loc_cCidchaves
3398:     ENDPROC
3399: 
3400:     *--------------------------------------------------------------------------
3401:     * HabilitarCamposDados - Habilita/desabilita campos da Page2
3402:     *--------------------------------------------------------------------------
3403:     PROTECTED PROCEDURE HabilitarCamposDados(par_lHabilitar)
3404:         LOCAL loc_oPg2
3405:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2

*-- Linhas 3652 a 3670:
3652:     PROCEDURE BtnOrdenarPeriodoClick()
3653:         TRY
3654:             IF USED("cursor_4c_Dados")
3655:                 SELECT cursor_4c_Dados
3656:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3657:             ENDIF
3658:         CATCH TO loc_oErro
3659:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarPeriodoClick")
3660:         ENDTRY
3661:     ENDPROC
3662: 
3663:     PROCEDURE BtnOrdenarEstoqueClick()
3664:         TRY
3665:             THIS.CarregarLista()
3666:         CATCH TO loc_oErro
3667:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarEstoqueClick")
3668:         ENDTRY
3669:     ENDPROC
3670: 

*-- Linhas 3770 a 3836:
3770:     *--------------------------------------------------------------------------
3771:     * BtnSelecionarTodosGGrupoClick - Marca todos os grandes grupos
3772:     *--------------------------------------------------------------------------
3773:     PROCEDURE BtnSelecionarTodosGGrupoClick()
3774:         TRY
3775:             IF USED("cursor_4c_GGrupos")
3776:                 SELECT cursor_4c_GGrupos
3777:                 REPLACE ALL nMarcas WITH 1
3778:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3779:             ENDIF
3780:         CATCH TO loc_oErro
3781:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGGrupoClick")
3782:         ENDTRY
3783:     ENDPROC
3784: 
3785:     *--------------------------------------------------------------------------
3786:     * BtnDesmarcarTodosGGrupoClick - Desmarca todos os grandes grupos
3787:     *--------------------------------------------------------------------------
3788:     PROCEDURE BtnDesmarcarTodosGGrupoClick()
3789:         TRY
3790:             IF USED("cursor_4c_GGrupos")
3791:                 SELECT cursor_4c_GGrupos
3792:                 REPLACE ALL nMarcas WITH 0
3793:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3794:             ENDIF
3795:         CATCH TO loc_oErro
3796:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGGrupoClick")
3797:         ENDTRY
3798:     ENDPROC
3799: 
3800:     *--------------------------------------------------------------------------
3801:     * BtnSelecionarTodosGrupoClick - Marca todos os grupos de produto
3802:     *--------------------------------------------------------------------------
3803:     PROCEDURE BtnSelecionarTodosGrupoClick()
3804:         TRY
3805:             IF USED("cursor_4c_GruposProd")
3806:                 SELECT cursor_4c_GruposProd
3807:                 REPLACE ALL nMarcas WITH 1
3808:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3809:             ENDIF
3810:         CATCH TO loc_oErro
3811:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGrupoClick")
3812:         ENDTRY
3813:     ENDPROC
3814: 
3815:     *--------------------------------------------------------------------------
3816:     * BtnDesmarcarTodosGrupoClick - Desmarca todos os grupos de produto
3817:     *--------------------------------------------------------------------------
3818:     PROCEDURE BtnDesmarcarTodosGrupoClick()
3819:         TRY
3820:             IF USED("cursor_4c_GruposProd")
3821:                 SELECT cursor_4c_GruposProd
3822:                 REPLACE ALL nMarcas WITH 0
3823:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3824:             ENDIF
3825:         CATCH TO loc_oErro
3826:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGrupoClick")
3827:         ENDTRY
3828:     ENDPROC
3829: 
3830:     *==========================================================================
3831:     * HANDLERS - Page3 (Leitura)
3832:     *==========================================================================
3833: 
3834:     *--------------------------------------------------------------------------
3835:     * BtnGravarClick - Salva item de leitura em SigIvTrH
3836:     *--------------------------------------------------------------------------

*-- Linhas 3864 a 3925:
3864:             *-- Gerar UUID para cidchaves da leitura
3865:             LOCAL loc_cCidchaves, loc_nResUuid
3866:             loc_cCidchaves = ""
3867:             loc_nResUuid = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_UuidH")
3868:             IF loc_nResUuid >= 0 AND RECCOUNT("cursor_4c_UuidH") > 0
3869:                 SELECT cursor_4c_UuidH
3870:                 loc_cCidchaves = ALLTRIM(cursor_4c_UuidH.novo_uuid)
3871:             ENDIF
3872:             IF USED("cursor_4c_UuidH")
3873:                 USE IN cursor_4c_UuidH
3874:             ENDIF
3875: 
3876:             IF EMPTY(loc_cCidchaves)
3877:                 MsgErro("Erro ao gerar chave " + CHR(250) + "nica para leitura.", "Erro")
3878:                 RETURN
3879:             ENDIF
3880: 
3881:             *-- Obter cbars do produto (codigo de barras)
3882:             LOCAL loc_cCbars, loc_nResCb
3883:             loc_cCbars = ""
3884:             loc_nResCb = SQLEXEC(gnConnHandle, "SELECT TOP 1 cbars FROM SigCdPro WHERE cpros = " + ;
3885:                          EscaparSQL(loc_cProd), "cursor_4c_CBars")
3886:             IF loc_nResCb >= 0 AND RECCOUNT("cursor_4c_CBars") > 0
3887:                 SELECT cursor_4c_CBars
3888:                 loc_cCbars = ALLTRIM(cursor_4c_CBars.cbars)
3889:             ENDIF
3890:             IF USED("cursor_4c_CBars")
3891:                 USE IN cursor_4c_CBars
3892:             ENDIF
3893: 
3894:             loc_cSQL = "INSERT INTO SigIvTrH (cidchaves, emps, codigos, cbars, cpros," + ;
3895:                        " codcors, codtams, lidos, lidos2, localis, obs)" + ;
3896:                        " VALUES (" + ;
3897:                        EscaparSQL(loc_cCidchaves) + "," + ;
3898:                        EscaparSQL(loc_cEmps) + "," + ;
3899:                        FormatarNumeroSQL(loc_nCodigos) + "," + ;
3900:                        EscaparSQL(loc_cCbars) + "," + ;
3901:                        EscaparSQL(loc_cProd) + "," + ;
3902:                        EscaparSQL(loc_cCodCor) + "," + ;
3903:                        EscaparSQL(loc_cCodTam) + "," + ;
3904:                        FormatarNumeroSQL(loc_nQtd) + "," + ;
3905:                        FormatarNumeroSQL(loc_nQtd2) + "," + ;
3906:                        EscaparSQL(loc_cLocal) + "," + ;
3907:                        EscaparSQL(loc_cObs) + ;
3908:                        ")"
3909: 
3910:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
3911:             IF loc_nRes >= 0
3912:                 loc_lSucesso = .T.
3913:                 THIS.LimparCamposLeitura()
3914:                 THIS.CarregarGradeLeitura()
3915:             ELSE
3916:                 MsgErro("Erro ao gravar leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3917:             ENDIF
3918:         CATCH TO loc_oErro
3919:             MsgErro(loc_oErro.Message, "FormBAL.BtnGravarClick")
3920:         ENDTRY
3921:     ENDPROC
3922: 
3923:     *--------------------------------------------------------------------------
3924:     * BtnCancelaClick - Cancela leitura e volta para lista
3925:     *--------------------------------------------------------------------------

*-- Linhas 3941 a 3971:
3941: 
3942:         TRY
3943:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3944:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3945: 
3946:             IF USED("cursor_4c_TotalLocal")
3947:                 USE IN cursor_4c_TotalLocal
3948:             ENDIF
3949: 
3950:             loc_cSQL = "SELECT localis AS Local, COUNT(*) AS Qtde_Itens, SUM(lidos) AS Total_Qtd" + ;
3951:                        " FROM SigIvTrH" + ;
3952:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
3953:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3954:                        " GROUP BY localis ORDER BY localis"
3955: 
3956:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TotalLocal")
3957:             IF loc_nRes >= 0
3958:                 MsgInfo("Consulta de totais por local conclu" + CHR(237) + "da.", "Total Local")
3959:             ELSE
3960:                 MsgErro("Erro ao calcular totais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3961:             ENDIF
3962:         CATCH TO loc_oErro
3963:             MsgErro(loc_oErro.Message, "FormBAL.BtnTotalLocalClick")
3964:         ENDTRY
3965:     ENDPROC
3966: 
3967:     *--------------------------------------------------------------------------
3968:     * BtnOcorrenciaClick - Registra ocorrencia
3969:     *--------------------------------------------------------------------------
3970:     PROCEDURE BtnOcorrenciaClick()
3971:         TRY

*-- Linhas 3988 a 4009:
3988:                 RETURN
3989:             ENDIF
3990: 
3991:             loc_cSQL = "SELECT TOP 1 imagem FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cProd)
3992:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
3993:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
3994:                 SELECT cursor_4c_ImgProd
3995:                 loc_cImagem = ALLTRIM(cursor_4c_ImgProd.imagem)
3996:                 IF !EMPTY(loc_cImagem) AND FILE(loc_cImagem)
3997:                     loc_oPg3.img_4c_ImgJpg.Picture = loc_cImagem
3998:                     loc_oPg3.img_4c_ImgJpg.Visible = .T.
3999:                 ELSE
4000:                     loc_oPg3.img_4c_ImgJpg.Visible = .F.
4001:                 ENDIF
4002:             ENDIF
4003:             IF USED("cursor_4c_ImgProd")
4004:                 USE IN cursor_4c_ImgProd
4005:             ENDIF
4006:         CATCH TO loc_oErro
4007:             MsgErro(loc_oErro.Message, "FormBAL.BtnImagemClick")
4008:         ENDTRY
4009:     ENDPROC

*-- Linhas 4018 a 4076:
4018:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
4019:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
4020: 
4021:             loc_cSQL = "SELECT TOP 1 localis FROM SigIvTrH" + ;
4022:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
4023:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
4024:                        " ORDER BY cidchaves DESC"
4025: 
4026:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltLocal")
4027:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_UltLocal") > 0
4028:                 SELECT cursor_4c_UltLocal
4029:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value = ALLTRIM(cursor_4c_UltLocal.localis)
4030:             ENDIF
4031:             IF USED("cursor_4c_UltLocal")
4032:                 USE IN cursor_4c_UltLocal
4033:             ENDIF
4034:         CATCH TO loc_oErro
4035:             MsgErro(loc_oErro.Message, "FormBAL.BtnLocalGravadoClick")
4036:         ENDTRY
4037:     ENDPROC
4038: 
4039:     *--------------------------------------------------------------------------
4040:     * BtnExcluirLeituraClick - Exclui registro de leitura selecionado na grade
4041:     *--------------------------------------------------------------------------
4042:     PROCEDURE BtnExcluirLeituraClick()
4043:         LOCAL loc_cCidchaves, loc_cSQL, loc_nRes, loc_lConfirma
4044: 
4045:         TRY
4046:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
4047:                 MsgAviso("Selecione uma leitura para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
4048:                 RETURN
4049:             ENDIF
4050: 
4051:             SELECT cursor_4c_Historico
4052:             loc_cCidchaves = ALLTRIM(cursor_4c_Historico.cbars)
4053: 
4054:             loc_lConfirma = MsgConfirma("Deseja excluir esta leitura?", "Confirmar Exclus" + CHR(227) + "o")
4055: 
4056:             IF loc_lConfirma
4057:                 loc_cSQL = "DELETE FROM SigIvTrH WHERE cbars = " + EscaparSQL(loc_cCidchaves) + ;
4058:                            " AND emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
4059:                            " AND codigos = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nCodigos)
4060: 
4061:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
4062:                 IF loc_nRes >= 0
4063:                     THIS.CarregarGradeLeitura()
4064:                 ELSE
4065:                     MsgErro("Erro ao excluir leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4066:                 ENDIF
4067:             ENDIF
4068:         CATCH TO loc_oErro
4069:             MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirLeituraClick")
4070:         ENDTRY
4071:     ENDPROC
4072: 
4073:     *==========================================================================
4074:     * HANDLERS DE LOOKUP (KeyPress F4)
4075:     *==========================================================================
4076: 

*-- Linhas 4699 a 4726:
4699:     PROCEDURE Destroy()
4700:         TRY
4701:             IF USED("cursor_4c_Dados")
4702:                 USE IN cursor_4c_Dados
4703:             ENDIF
4704:             IF USED("cursor_4c_GGrupos")
4705:                 USE IN cursor_4c_GGrupos
4706:             ENDIF
4707:             IF USED("cursor_4c_GruposProd")
4708:                 USE IN cursor_4c_GruposProd
4709:             ENDIF
4710:             IF USED("cursor_4c_Historico")
4711:                 USE IN cursor_4c_Historico
4712:             ENDIF
4713:         CATCH TO loc_oErro
4714:             MsgErro(loc_oErro.Message, "FormBAL.Destroy")
4715:         ENDTRY
4716: 
4717:         DODEFAULT()
4718:     ENDPROC
4719: 
4720:     *--------------------------------------------------------------------------
4721:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
4722:     *--------------------------------------------------------------------------
4723:     PROCEDURE AjustarBotoesPorModo()
4724:         LOCAL loc_lModoEdicao, loc_oPage1
4725:         TRY
4726:             loc_lModoEdicao = (THIS.this_cModoAtual = "NOVO" OR THIS.this_cModoAtual = "EDICAO")


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

