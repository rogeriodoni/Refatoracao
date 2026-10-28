# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPOS, CESTOS, I, EMPDOPNUMS, DGOPES, DESCPORS, LIMDESCS, ACREPORS, LIMACRES, MATS, CPROS, DIRCOLINS, GRUPOS, ESTOS, CODCORS, 0, EMPS, CODTAMS, GERGDMIS, DOPES, TIPOOPS, CHKSUBN, ICLIS, QTDS, CPROEQS, ESTIMADO, LNCNT, CONJUNTS, CEMPS, INVISIVEL, CODIGOS, TIPOS, CUSTOS, SELEC, DESCRS, CODS, CBARS, CBARS_OLD, EAN13, DATAS, PRAZOENTS, LNPRODOFF, FIGJPGS, DPROS, DPRO2S, IFORS, REFFS, CGRUS, SGRUS, MERCS, MOECUSFS, MOEVS, MOEDAS, LINHAS, COLECOES, CUSTOFS, PVENS, VALORS, PESOMS, SITUAS, CATEGORIA, LOCALS, CCLASS, PRODWEBS, CODFINP, DPRO3S, TAMPS, TAMHS, TAMLS, CODMACRO, PRODOFF, PROMOS, NUMES, CHKPAGOS, SQTDS, UNITMEDS, CODBARRAS, PRODUTOS, QTDEMPHS, SPESOS, LCCHAVE, DOPPS, LPRECOS, VENCFS, DESCOS, ORDEMS, DOPERS, ENTPENDS, CIDCHAVES, CODCORES, CONTAS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "CsMatPrima.mats"
  Column2.ControlSource = "CsMatPrima.dcompos"
  Column3.ControlSource = "CsMatPrima.qtd_inicial"
  Column4.ControlSource = "CsMatPrima.qtd_final"
  Column5.ControlSource = "CsMatPrima.apenas"
  Column6.ControlSource = "CsMatPrima.Cgrus"
  Column7.ControlSource = "CsMatPrima.Tipos"
  ControlSource = "CsMatPrima.mats"
  ControlSource = "CsMatPrima.dcompos"
  ControlSource = "CsMatPrima.qtd_inicial"
  ControlSource = "CsMatPrima.qtd_final"
  ControlSource = "CsMatPrima.apenas"
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "crSigPrCpo.Mats"
  Column1.SelectOnEntry = .F.
  Column2.ControlSource = "crSigPrCpo.DCompos"
  Column2.SelectOnEntry = .F.
  Column3.ControlSource = "crSigPrCpo.UniCompos"
  Column4.ControlSource = "crSigPrCpo.PCompos"
  Column5.ControlSource = "crSigPrCpo.Qtds"
  Column6.ControlSource = "crSigPrCpo.Moeds"
  Column7.ControlSource = "crSigPrCpo.ObsCompos"
  Column8.ControlSource = "crSigPrCpo.Pesos"
  Column9.ControlSource = "crSigPrCpo.CUniPs"
  ControlSource = "CrSigPrCpo.mats"
  ControlSource = "CrSigPrCpo.dcompos"
  ControlSource = "CrSigPrCpo.unicompos"
  ControlSource = "CrSigPrCpo.pcompos"
  ControlSource = "CrSigPrCpo.qtds"
  ControlSource = "CrSigPrCpo.moeds"
  ControlSource = "CrSigPrCpo.obscompos"
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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = ""
  Column2.SelectOnEntry = .T.
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  ControlSource = "CrSigMvHst.datas"
  ControlSource = "(alltrim(mascnum(CrSigMvHst.numes)))"
  ControlSource = "CrSigMvHst.dopes"
  ControlSource = "CrSigMvHst.qtds"
  ControlSource = "CrSigMvHst.opers"
  ControlSource = "CrSigMvHst.sqtds"
  ControlSource = "CrSigMvHst.codbarras"
  ControlSource = "CrSigMvHst.Pesos"
  ControlSource = "CrSigMvHst.spesos"
  ControlSource = "CrSigMvHst.Fators"
  DeleteMark = .F.
  Column1.ControlSource = "crSigMvEst.Emps"
  Column2.ControlSource = "crSigMvEst.Grupos"
  Column3.ControlSource = "crSigMvEst.Estos"
  Column4.ControlSource = "crSigMvEst.Sqtds"
  Column5.ControlSource = "crSigMvEst.CodCors"
  Column6.ControlSource = "crSigMvEst.CodTams"
  Column7.ControlSource = "crSigMvEst.QtdEmpHs"
  Column8.ControlSource = "crSigMvEst.SPesos"
  Column9.ControlSource = "crSigMvEst.Pedidos"
  Column10.ControlSource = "crSigMvEst.EntPends"
  ControlSource = "crSigMvEst.emps"
  ControlSource = "crSigMvEst.grupos"
  ControlSource = "crSigMvEst.estos"
  ControlSource = "crSigMvEst.sqtds"
  ControlSource = "crSigMvEst.codcors"
  ControlSource = "crSigMvEst.codtams"
  ControlSource = "crSigMvEst.Qtdemphs"
  ControlSource = "crSigMvEst.spesos"
  ControlSource = "crSigMvEst.Pedidos"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = "LpItem.lprecos"
  ControlSource = "LpItem.tabds"
  ControlSource = "LpItem.units"
  ControlSource = "LpItem.moedas"
  ControlSource = "LpItem.Parcelas"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = ""
  ControlSource = "CrProdutos.cpros"
  ControlSource = "CrProdutos.dpros"
  ControlSource = "crTSigpro.Obscompras"
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
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crTSigpro.UsuIncs"
  ControlSource = "crTSigpro.MUltComps"
  ControlSource = "crTSigpro.vUltComps"
  ControlSource = "crTSigpro.UltComps"
  ControlSource = "crTSigpro.dtincs"
  ControlSource = ""
  ControlSource = "crTSigpro.DPro3s"
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "CsFase.ordems"
  Column2.ControlSource = "CsFase.grupos"
  Column3.ControlSource = "CsFase.etiquetas"
  Column4.ControlSource = "CsFase.descrs"
  ControlSource = "CsFase.ordems"
  ControlSource = "CsFase.grupos"
  ControlSource = "CsFase.etiquetas"
  ControlSource = "CsFase.descrs"
  ControlSource = "CsFase.obs"
  DeleteMark = .F.
  Column1.ControlSource = "crSigPrCpo.Mats"
  Column1.SelectOnEntry = .F.
  Column2.ControlSource = "crSigPrCpo.UniCompos"
  Column3.ControlSource = "crSigPrCpo.QtsCons"
  Column4.ControlSource = "crSigPrCpo.Qtds"
  Column5.ControlSource = "crSigPrCpo.Grupos"
  Column6.ControlSource = "crSigPrCpo.DscGrp"
  Column7.ControlSource = "crSigPrCpo.Cats"
  ControlSource = "crSigPrCpo.mats"
  ControlSource = "CrSigPrCpo.unicompos"
  ControlSource = "CrSigPrCpo.qtscons"
  ControlSource = "CrSigPrCpo.qtds"
  ControlSource = "CrSigPrCpo.grupos"
  ControlSource = "CrSigPrCpo.dscgrp"
  ControlSource = "CrSigPrCpo.cats"
  DeleteMark = .F.
  Column1.ControlSource = "CsEtiqueta.cbars"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "CsEtiqueta.qtds"
  Column3.ControlSource = "CsEtiqueta.pesos"
  Column4.ControlSource = "CsEtiqueta.localizas"
  Column5.ControlSource = "CsEtiqueta.codtams"
  Column6.ControlSource = "CsEtiqueta.codcors"
  Column7.ControlSource = "CsEtiqueta.datas"
  Column8.ControlSource = "CsEtiqueta.CPros"
  ControlSource = "CsEtiqueta.cbars"
  ControlSource = "CsEtiqueta.qtds"
  ControlSource = "CsEtiqueta.pesos"
  ControlSource = "CsEtiqueta.localizas"
  ControlSource = "CsEtiqueta.codtams"
  ControlSource = "CsEtiqueta.codcors"
  ControlSource = "CsEtiqueta.datas"
  DeleteMark = .F.
  Column1.ControlSource = "crGrpOpe.Emps"
  Column2.ControlSource = "crGrpOpe.Dopes"
  Column3.ControlSource = "crGrpOpe.Numes"
  Column4.ControlSource = "crGrpOpe.Qtds"
  ControlSource = "crGrpOpe.Emps"
  ControlSource = "crGrpOpe.Dopes"
  ControlSource = "crGrpOpe.Numes"
  ControlSource = "crGrpOpe.Qtds"
  DeleteMark = .F.
  Column1.ControlSource = "crSigMvEtr.Emps"
  Column2.ControlSource = "crSigMvEtr.Grupos"
  Column3.ControlSource = "crSigMvEtr.Estos"
  Column4.ControlSource = "crSigMvEtr.Sqtds"
  Column5.ControlSource = "crSigMvEtr.CodCors"
  Column6.ControlSource = "crSigMvEtr.CodTams"
  Column7.ControlSource = "crSigMvEtr.QtdEmpHs"
  Column8.ControlSource = "crSigMvEtr.SPesos"
  Column9.ControlSource = "crSigMvEtr.DContas"
  ControlSource = "crSigMvEtr.Emps"
  ControlSource = "crSigMvEtr.Grupos"
  ControlSource = "crSigMvEtr.estos"
  ControlSource = "crSigMvEtr.sqtds"
  ControlSource = "crSigMvEtr.codcors"
  ControlSource = "crSigMvEtr.codtams"
  ControlSource = "crSigMvEtr.Qtdemphs"
  ControlSource = "crSigMvEtr.spesos"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
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
  Column12.ControlSource = ""
  Column13.ControlSource = ""
  ControlSource = "CrSigPrCpo.Dcompos"
  DeleteMark = .F.
  Column1.ControlSource = "TotGrupo2.Grupo"
  Column2.ControlSource = "TotGrupo2.ValGrupo"
  Column3.ControlSource = "TotGrupo2.Moeda"
  DeleteMark = .F.
  Column1.ControlSource = "crMvEst.Emps"
  Column2.ControlSource = "crMvEst.Grupos"
  Column3.ControlSource = "crMvEst.Estos"
  Column4.ControlSource = "crMvEst.sqtds"
  Column5.ControlSource = "crMvEst.codcors"
  Column6.ControlSource = "crMvEst.codtams"
  Column7.ControlSource = "crMvEst.Qtdemphs"
  Column8.ControlSource = "crMvEst.spesos"
  Column9.ControlSource = "crMvEst.Pedidos"
  Column10.ControlSource = ""
  Column11.ControlSource = "crMvEst.Cpros"
  ControlSource = "crMvEst.emps"
  ControlSource = "crMvEst.grupos"
  ControlSource = "crMvEst.estos"
  ControlSource = "crMvEst.sqtds"
  ControlSource = "crMvEst.codcors"
  ControlSource = "crMvEst.codtams"
  ControlSource = "crMvEst.Qtdemphs"
  ControlSource = "crMvEst.spesos"
  ControlSource = "crMvEst.Pedidos"
  ControlSource = "crMvEst.Cpros"
  DeleteMark = .F.
  Column1.ControlSource = "CsEtiqueta.cbars"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "CsEtiqueta.qtds"
  Column3.ControlSource = "CsEtiqueta.pesos"
  Column4.ControlSource = "CsEtiqueta.localizas"
  Column5.ControlSource = "CsEtiqueta.codtams"
  Column6.ControlSource = "CsEtiqueta.codcors"
  Column7.ControlSource = "CsEtiqueta.datas"
  Column8.ControlSource = "CsEtiqueta.CPros"
  ControlSource = "CsEtiqueta.cbars"
  ControlSource = "CsEtiqueta.qtds"
  ControlSource = "CsEtiqueta.pesos"
  ControlSource = "CsEtiqueta.localizas"
  ControlSource = "CsEtiqueta.codtams"
  ControlSource = "CsEtiqueta.codcors"
  ControlSource = "CsEtiqueta.datas"
  ControlSource = ""
	Select a.cpros,a.empos,a.grupos,a.contas,a.cbars,a.qtds,a.pesos,a.localizas,a.codtams,a.codcors,a.datas,a.cps1s,a.locals,a.codamss, a.CBars_old ;
  	  From CrSigOpEtq1 a ;
	Select CsEtiqueta
		.Column1.ControlSource = 'CsEtiqueta.cbars'
		.Column2.ControlSource = 'CsEtiqueta.qtds'
		.Column3.ControlSource = 'CsEtiqueta.pesos'
		.Column4.ControlSource = 'CsEtiqueta.localizas'
		.Column5.ControlSource = 'CsEtiqueta.codtams'
		.Column6.ControlSource = 'CsEtiqueta.codcors'
		.Column7.ControlSource = 'CsEtiqueta.datas'
		.Column8.ControlSource = 'CsEtiqueta.CPros'
		.Column9.ControlSource = 'CsEtiqueta.CBars_old'
	.getRefs.ControlSource = [CsEtiqueta.CodAmss]
	Select CsEtiqueta
	Select CsEtiqueta
	lcCampo = grdOrdenar.Columns(i).ControlSource	
lcSql = [Select cmoes, 0000.000 as valos From Sigcdcot group by cmoes ]
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcSql,'TmpCot')
Select TmpCot
Select TmpCot
loPag.GrdCot.Grade_cot.column1.controlsource='TmpCot.Cmoes'
loPag.GrdCot.Grade_cot.column2.controlsource='TmpCot.Valos'
lcQuery = [Select ContaOs, ContaDs, Vends ] + ;
		    [From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEest]) < 1)
Select LocalEest
lcQuery = [Select b.Emps, b.Dopes, b.Numes, Sum(c.Qtds - c.QtBaixas) as Qtds ] + ;
			[From SigCdGpo a, SigMvCab b, SigMvItn c ] + ;
If (ThisForm.poDataMgr1.SqlExecute(lcQuery, 'crDados') < 1)
Select crDados
	Insert Into crGrpOpe (Emps, Dopes, Numes, Qtds) Values (crDados.Emps, crDados.Dopes, crDados.Numes, crDados.Qtds)
=Seek(CrSigCdUsu.cCargs,'CrSigCdCrg','CCargs')
Select crSigPrCpo
Select crProEtqEqs
	lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select e.cpros,e.empos,e.grupos,e.contas,e.cbars,e.qtds,e.pesos,] +;
					[ From SigOpEtq e ] +;
					[ Left join SigOpEta c on e.cbars = c.cbars_new ] + ;
					[ And e.Empos In (Select b.cemps From SigCdEmp b Where Not b.dircolins='] + Space(32) + [')] +;
					[ And e.cpros + e.empos + e.grupos + e.contas In (Select a.cpros + a.emps + a.grupos + a.estos] +;
					[ From SigMvEst a where a.cpros='] + crProEtqEqs.CPros + [' and &lcFilQtd.) ] +;
					[Select e.cpros,e.empos,e.grupos,e.contas,e.cbars,e.qtds,e.pesos,] +;
					[ From SigOpEtq e ] +;
					[ Left join SigOpEta c on e.cbars = c.cbars_new ] + ;
					[ And e.Empos In (Select b.cemps From SigCdEmp b Where b.dircolins='] + Space(32) + [')] +;
					[ And e.cpros + e.empos + e.grupos + e.contas In (Select a.cpros + a.emps + a.grupos + a.estos] +;
					[ From SigMvEst a where a.cpros='] + crProEtqEqs.CPros + [' and &lcFilQtd.) ] +;				
	Select CrSigOpEtq2
	m.lcMcrsql1 = [Select a.empos, a.cbars, IsNull(c.CBars_old,0) as CBars_old ] + ;
		[From SigOpEtq a ] + ;
		[ Left join SigOpEta c on a.cbars = c.cbars_new ] + ;
		m.lnErro1 = ThisForm.poDataMgr2.SQLExecute(m.lcMcrSql1, 'crTmpChkEti1')
		Select crTmpChkEti1
			Update CrSigOpEtq2 Set cps1s='0' Where Str(cbars,14)+empos=m.lcIdChave1
	Select crSigOpEtq2
		Insert Into crSigOpEtq1 From Memvar	
Select crProEtqEqs
	lcQuery = [Select a.CPros, a.Emps, a.Grupos, a.Estos, a.Sqtds, a.CodCors, a.CodTams, ] + ;
		   		[From SigMvEst a inner join SigCdCli b on a.Estos = b.Iclis ] + ;
	If (ThisForm.poDataMgr1.SqlExecute(lcQuery, [LocalEst]) < 1)
	Select LocalEst
		If Seek(LocalEst.Emps + LocalEst.Grupos + LocalEst.Estos + LocalEst.CodCors + LocalEst.CodTams, [crSigMvEst], [EmpGruCon])
			Insert Into crSigMvEst From Memvar
	lcQuery = [Select a.CPros, a.CodCors, a.CodTams, a.Emps, a.Dopes, a.Numes, a.Qtds, a.QtBaixas ] + ;
				[From SigMvIts a, SigCdOpe o, SigCdTom t ]
	lcQuery = [Select a.CPros, '    ' as CodCors, '    ' as CodTams, a.Emps, a.Dopes, a.Numes, a.Qtds, a.QtBaixas ] + ;
				[From SigMvItn a, SigCdOpe o, SigCdTom t ]
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcQuery, [LocalEstI])
Select LocalEstI
	lcQuery = [Select a.GrupoOs, a.ContaOs, b.Rclis From SigMvCab a inner join SigCdCli b on a.ContaOs = b.Iclis Where a.EmpDopNums = ']+ lcEdn +[']
	lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcQuery, [LocalEest])
	Select LocalEest
	Select crSigMvEst
		Insert Into crSigMvEst (Emps, Grupos, Estos, CPros, CodCors, CodTams, Fk_Chave, DContas) ;
		Select crSigMvEstPd
			Insert Into crSigMvEstPd (Fk_Chave, EmpDopNums) Values (crSigMvEst.Fk_Chave, lcEdn)
	.Column1.ControlSource = 'CrSigMvEst.emps'
	.Column2.ControlSource = 'CrSigMvEst.grupos'
	.Column3.ControlSource = 'CrSigMvEst.estos'
	.Column4.ControlSource = 'CrSigMvEst.sqtds'
	.Column5.ControlSource = 'CrSigMvEst.codcors'
	.Column6.ControlSource = 'CrSigMvEst.codtams'
		.Column7.ControlSource = ""
		.Column7.ControlSource = 'CrSigMvEst.QtdEmphs'
	.Column9.ControlSource  = 'CrSigMvEst.Pedidos'
	.Column10.ControlSource = 'CrSigMvEst.EntPends'
		.Column8.ControlSource = 'CrSigMvEst.sPesos'
		.Column8.ControlSource = ""
		.Column8.ControlSource = 'crSigMvEtr.sPesos'
		.Column8.ControlSource = ""
	Select CrSigMvEst
	Select Distinct Emps From CrSigMvEst Into Cursor csTmpContas ReadWrite 
	Select csTmpContas
			Select CrSigCdOpe
					lcQuery = [Select cpros, codCors, codTams, emps, dopes, numes, qtds, Space(10) as ContaDs, Space(10) as GrupoDs, DtAlts as Datas From SigMvIts Where 0=1]
					If ThisForm.poDataMgr1.SqlExecute(lcQuery,'CrEmpenhado') < 1
					lcQuery = [Select cpros, codCors, codTams, emps, dopes, numes, qtds, qtbaixas ]+;
							[From SigMvIts Where EmpDopNums Between ?lcEdnIs And ?lcEdnFs And Cpros=']+lcCodPro+[']
					lcQuery = [Select cpros, '    ' as codCors, '    ' as codTams, emps, dopes, numes, qtds, qtbaixas ]+;
							[From SigMvItn Where EmpDopNums Between ?lcEdnIs And ?lcEdnFs And Cpros=']+lcCodPro+[']
				lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcQuery,'CrSigMvItn')
				Select CrSigMvItn
							lcQuery = [Select Grupoos, ContaOs, GrupoDs, ContaDs, Datas From SigMvCab Where EmpDopNums = ']+ lcEdn +[']
							If ThisForm.PodataMgr1.SqlExecute(lcquery,'CrTprMvCab') > 0
								Select CrSigMvEst
										Insert into crEmpenhado(Cpros, CodCors, CodTams, Qtds, Emps, Dopes, Numes, ContaDs, GrupoDs, Datas) ;
		Select csTmpContas
lcSql = [Select * from SigCdTom Where GerGdmis = 6 ]
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcSql,'CrTmpTope')
Select CrTmpTOpe
		lcSql = [Select a.Emps,a.Dopes,a.Numes,a.grupods,a.contads,d.cpros, sum(d.qtds-d.qtbaixas) as qtds, d.CodCors, d.CodTams, e.Rclis as Dcontas ]+;
				[from SigMvIts d, SigMvCab a, SigCdOpe b, SigCdTom c, SigCdCli e ]+;
		lcSql = [Select a.Emps,a.Dopes,a.Numes,a.grupods,a.contads,d.cpros, sum(d.qtds-d.qtbaixas) as qtds, '' as CodCors, '' as CodTams, e.Rclis as Dcontas ]+;
				[from SigMvItn d, SigMvCab a, SigCdOpe b, SigCdTom c, SigCdCli e ]+;
	lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcSql,'CrTprMvCabix')
	Select Emps, Dopes, Numes, GrupoDs, ContaDs, CPros, Sum(Qtds) as Qtds, CodCors, CodTams, DContas ;
	  From crTprMvCabIx ;
	Select crTprMvCabI
		Select crSigMvEst
		Select crSigMvEstPd
			Insert Into crSigMvEstPd (Fk_Chave, EmpDopNums) Values (crSigMvEst.Fk_Chave, lcEdn)
Select CrSigMvEst
	lcQuery = [Select CPros, CProEqs From SigCdPro Where CPros = '] + pPro + [' ] + ;
			  [Select CPros, CProEqs From SigCdPro Where CProEqs = '] + pPro + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalProEt]) < 1)
	Select LocalProEt
		lcQuery = [Select CPros, CProEqs From SigCdPro Where CPros In ('] + lcPai + [', '] + lcFil + [') ] + ;
				  [Select CPros, CProEqs From SigCdPro Where CProEqs In ('] + lcPai + [', '] + lcFil + [') ]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalProEt1]) < 1)
		Select LocalProEt1
			If Not Seek(LocalProEt1.CPros, [crProEtqEqs], [CPros])
				Insert Into crProEtqEqs (CPros) Values (LocalProEt1.CPros)
			If Not Empty(LocalProEt1.CProEqs) And Not Seek(LocalProEt1.CProEqs, [crProEtqEqs], [CPros])
				Insert Into crProEtqEqs (CPros) Values (LocalProEt1.CProEqs)
	Insert Into crProEtqEqs (CPros) Values (pPro)
Select crSigCdTom
Select Cgrus, Moeds, pCompos, Qtds From crSigPrCpo Into Cursor crtmp
Select crtmp
	Select TotGrupo2
		Insert Into TotGrupo2 (Grupo, ValGrupo, Moeda ) Values ;
Select TotGrupo2
Select crSigPrCpo
lcQuery = [Select e.cpros,e.empos,e.grupos,e.contas,e.cbars,e.qtds,e.pesos, e.localizas,e.codtams,] + ;
	[From SigOpEtq e ] + ;
	[Join SigCdPro b on e.cpros = b.cpros ] + ;
	[Left join SigOpEta c on e.cbars = c.cbars_new ] + ;
	[And e.Empos In (Select b.cemps From SigCdEmp b Where Not b.dircolins=Space(32)) ] + ;
	[And e.cpros + e.empos + e.grupos + e.contas In (Select a.cpros + a.emps + a.grupos + a.estos ] + ;
	[From SigMvEst a join sigcdpro b on a.cpros = b.cpros ] + ;
	[Select e.cpros,e.empos,e.grupos,e.contas,e.cbars,e.qtds,e.pesos, e.localizas,e.codtams,] + ;
	[From SigOpEtq e ] + ;
	[Left join SigOpEta c on e.cbars = c.cbars_new ] + ;
	[Join SigCdPro b on e.cpros = b.cpros ] + ;
	[And e.Empos In (Select b.cemps From SigCdEmp b Where b.dircolins=Space(32)) ] + ;
	[And e.cpros + e.empos + e.grupos + e.contas In (Select a.cpros + a.emps + a.grupos + a.estos ] + ;
	[From SigMvEst a join sigcdpro b on a.cpros = b.cpros ] + ;
lnQueryOk = Thisform.poDataMgr1.SqlExecute(lcQuery,'CrOpEtq2')
Select CrOpEtq2
m.lcMcrsql1 = [Select a.empos, a.cbars, IsNull(c.CBars_old,0) as CBars_old ] + ;
	[From SigOpEtq a ] + ;
	[Left join SigOpEta c on a.cbars = c.cbars_new ] + ;
	[join SigCdPro b on a.cpros = b.cpros ] + ;
	m.lnErro1 = Thisform.poDataMgr2.SqlExecute(m.lcMcrsql1, 'crTmpChkEti1')
	Select crTmpChkEti1
		Update CrOpEtq2 Set CPs1s='0' Where Str(CBars,14)+EmpOs=m.lcIdChave1
Select CrOpEtq2
	Insert Into crCpEtq1 From Memvar
lcQuery = [Select a.CPros, a.Emps, a.Grupos, a.Estos, a.Sqtds, a.CodCors, a.CodTams, ] + ;
	[From SigMvEst a ] + ;
	[inner join SigCdCli b on a.Estos = b.Iclis ] + ;
	[inner join sigcdpro c on a.cpros = c.cpros ] + ;
If (Thisform.poDataMgr1.SqlExecute(lcQuery, [LocalEst]) < 1)
Select LocalEst
	If Seek(LocalEst.Emps + LocalEst.Grupos + LocalEst.Estos + LocalEst.CodCors + LocalEst.CodTams, [CrMvEst], [EmpGruCon])
		Insert Into CrMvEst From Memvar
	lcQuery = [Select a.CPros, a.CodCors, a.CodTams, a.Emps, a.Dopes, a.Numes, a.Qtds, a.QtBaixas ] + ;
		[From SigMvIts a, SigCdOpe o, SigCdTom t, SigCdPro b ]
	lcQuery = [Select a.CPros, '    ' as CodCors, '    ' as CodTams, a.Emps, a.Dopes, a.Numes, a.Qtds, a.QtBaixas ] + ;
		[From SigMvItn a, SigCdOpe o, SigCdTom t, SigCdPro b ]
lnQueryOk = Thisform.poDataMgr1.SqlExecute(lcQuery, [LocalEstI])
Select LocalEstI
	lcQuery = [Select a.GrupoOs, a.ContaOs, b.Rclis From SigMvCab a inner join SigCdCli b on a.ContaOs = b.Iclis Where a.EmpDopNums = ']+ lcEdn +[']
	lnQueryOk = Thisform.poDataMgr1.SqlExecute(lcQuery, [LocalEest])
	Select LocalEest
	Select CrMvEst
		Insert Into CrMvEst (Emps, Grupos, Estos, CPros, CodCors, CodTams, Fk_Chave, DContas) ;
		Select crMvEstPd
			Insert Into crMvEstPd (Fk_Chave, EmpDopNums) Values (crSigMvEst.Fk_Chave, lcEdn)
Select CrMvEst
	.Column1.ControlSource = 'CrMvEst.emps'
	.Column2.ControlSource = 'CrMvEst.grupos'
	.Column3.ControlSource = 'CrMvEst.estos'
	.Column4.ControlSource = 'CrMvEst.sqtds'
	.Column5.ControlSource = 'CrMvEst.codcors'
	.Column6.ControlSource = 'CrMvEst.codtams'
		.Column7.ControlSource = ""
		.Column7.ControlSource = 'CrMvEst.QtdEmphs'
	.Column9.ControlSource  = 'CrMvEst.Pedidos'
	.Column10.ControlSource = 'CrMvEst.EntPends'
		.Column8.ControlSource = 'CrMvEst.sPesos'
		.Column8.ControlSource = ""
	Select CrMvEst
	Select Distinct Emps From CrMvEst Into Cursor csTmpContas ReadWrite 
	Select csTmpContas
			Select CrSigCdOpe
					lcQuery = [Select cpros, codCors, codTams, emps, dopes, numes, qtds, Space(10) as ContaDs, Space(10) as GrupoDs, DtAlts as Datas From SigMvIts Where 0=1]
					If ThisForm.poDataMgr1.SqlExecute(lcQuery,'CrEmpenhado') < 1
					lcQuery = [Select cpros, codCors, codTams, emps, dopes, numes, qtds, qtbaixas ]+;
							[From SigMvIts Where EmpDopNums Between ?lcEdnIs And ?lcEdnFs And Cpros in(Select cpros from sigcdpro where conjunts = ]+lcCodPai+[) ]
					lcQuery = [Select cpros, '    ' as codCors, '    ' as codTams, emps, dopes, numes, qtds, qtbaixas ]+;
							[From SigMvItn Where EmpDopNums Between ?lcEdnIs And ?lcEdnFs And Cpros in(Select cpros from sigcdpro where conjunts = ]+lcCodPai+[)]
				lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcQuery,'CrSigMvItn')
				Select CrSigMvItn
							lcQuery = [Select Grupoos, ContaOs, GrupoDs, ContaDs, Datas From SigMvCab Where EmpDopNums = ']+ lcEdn +[']
							If ThisForm.PodataMgr1.SqlExecute(lcquery,'CrTprMvCab') > 0
								Select CrMvEst
										Insert into crEmpenhado(Cpros, CodCors, CodTams, Qtds, Emps, Dopes, Numes, ContaDs, GrupoDs, Datas) ;
		Select csTmpContas
	Select a.cpros,a.empos,a.grupos,a.contas,a.cbars,a.qtds,a.pesos,a.localizas,a.codtams,a.codcors,a.datas,a.cps1s,a.locals,a.codamss, a.CBars_old ;
  	  From crCpEtq1 a ;
	Select CsEtiqCodP
		.Column1.ControlSource = 'CsEtiqCodP.cbars'
		.Column2.ControlSource = 'CsEtiqCodP.qtds'
		.Column3.ControlSource = 'CsEtiqCodP.pesos'
		.Column4.ControlSource = 'CsEtiqCodP.localizas'
		.Column5.ControlSource = 'CsEtiqCodP.codtams'
		.Column6.ControlSource = 'CsEtiqCodP.codcors'
		.Column7.ControlSource = 'CsEtiqCodP.datas'
		.Column8.ControlSource = 'CsEtiqCodP.CPros'
		.Column9.ControlSource = 'CsEtiqCodP.CBars_old'
	.getRefs.ControlSource = [CsEtiqCodP.CodAmss]
	Select CsEtiqCodP
	Select CsEtiqCodP
Select CsMatPrima
lcQueryCot     	= [Select a.cmoes,a.datas,a.valos,a.cidchaves From SigCdCot a]
lcQueryEesti   	= [Select a.cpros,a.emps,a.dopes,a.numes,a.units,a.moedas,a.cunis,a.moefats,]+;
						[a.fatvals,a.descvals,a.cidchaves From SigMvItn a]
lcQueryEmp     	= [Select a.cemps,a.razas From SigCdEmp a Where a.cemps = ']+_empr+[' ]
lcQueryMoe     	= [Select a.cmoes,a.dmoes,a.cotas From SigCdMoe a]
lcQueryOpe     	= [Select a.dopes,a.ndopes,a.estoqs From SigCdOpe a where (a.dopes=?m.pcdope or a.dopes=?m.pcdope2)]
lcQueryParam   	= [Select a.gesind,a.moedetqs,a.grupoests,a.contaests,a.transfres,a.empmasters,a.moepadvens,tpcbars,tpinstalas ]+;
				   [From SigCdPam a]
lcQueryParac   	= [Select * From SigCdPac a]
lcQueryLpc		= [Select lPrecos From SigCdLpc a Where emps = ']+_empr+[' ]
			.AddCursor('SigCdPrf','Cidchaves','CrSigCdPrf','','',[Select * from SigCdPrf where 0=1])
		lcSql = [Select iclis From SigCdCli a, SigCdGcr b where b.invisivel=1 and a.grupos = b.codigos and a.invisivel = 1 ]
		ThisForm.Podatamgr1.Sqlexecute(lcSql,'crEstInv')
		lcQuery = [Select TpInstalas From SigCdPam]
		If (ThisForm.poDataMgr1.SqlExecute(lcQuery, [csTmpParam]) < 1)
		lStrQuery = [Select a.*,b.Padraos From SigOpTdz a, SigOpTde b ]+;
		If ThisForm.poDataMgr1.SQLExecute(lStrQuery,'CsSigOpTdz') < 1
		Select CsSigOpTdz
			lStrQuery = [Select a.*,0 As Padraos From SigOpTdz a ]
			If ThisForm.poDataMgr1.SQLExecute(lStrQuery,'CsSigOpTdz') < 1
		Select CsSigOpTdz
		If ThisForm.poDataMgr1.SQLExecute([Select * From SigCdCrg ],'CrSigCdCrg') < 1
		Select CrSigCdCrg
		If ThisForm.poDataMgr1.SQLExecute([Select Colecoes From SigCdCol Where Not ConProds = 2], 'crSigCdCol') < 1
		Select crSigCdCol
		If Not Seek(Space(10), 'crSigCdCol', 'Colecoes')
		lStrQuery = [Select Tipos From SigCdCom]
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'LocalCdCom') < 1
		lcQuery = [Select a.Tipos, a.Custos, b.CGrus ] + ;
				    [From SigCdTpc a, SigCdCom b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCom]) < 1)
		Select crSigCdCom
		lcQuery = [Select Tipos ] + ;
				    [From SigCdTpc ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdTpc]) < 1)
		Select crSigCdTpc
		lcQuery = [Select a.Cods, a.Descs ] + ;
					[From SigCdCls a ] 
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCls]) < 1)
		Select crSigCdCls
		lcSql = [Select Count(1) as Qt From SigCdUni WherE cEstos = '3' ]
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CstmpUni') < 1)
			Select LocalGope
					Insert Into crMGOpe (DgOpes) Values (LocalGope.DgOpes)
		Create Cursor LpItem From Array v01
			.Column1.ControlSource = 'LpItem.lprecos'
			.Column2.ControlSource = 'LpItem.tabds'
			.Column3.ControlSource = 'LpItem.units'
			.Column4.ControlSource = 'LpItem.moedas'
			.Column5.ControlSource = 'LpItem.Parcelas'
		Select CrSigCdPam
		lcQuery = [Select 0 as Selec, Codigos From SigCrRap]
		If ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCrRap]) < 1
			.DeleteMark        = .f.
			.Column1.ControlSource   = 'crSigCrRap.Selec'
			.Column2.ControlSource   = 'crSigCrRap.Codigos'
		lcQuery = [Select 0 as Selec, Codigos, Descrs from SigCdTom]
		If ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCdTom]) < 1
			.DeleteMark        = .f.
			.Column1.ControlSource   = 'crSigCdTom.Selec'
			.Column2.ControlSource   = 'crSigCdTom.Codigos'
			.Column3.ControlSource   = 'crSigCdTom.Descrs'
Select CsMatPrima
	Select CsMatPrima
			Delete
Select CsMatPrima
Select csMatPrima
If not IsEmpty(csMatPrima.cGrus) or not IsEmpty(csMatPrima.Tipos) or not IsEmpty(csMatPrima.Mats) &&Not Seek(cChave)
Select crSigCdTom
Select crSigCdTom
Select crSigCrRap
Select crSigCrRap
	Select crSigCrRap
	Select crSigCrRap
Select crSigCdTom
Select crSigCdTom
	Select crSigCdTom
	Select crSigCdTom
Select crSigCdTom
Select crSigCdTom
Select crSigCdTom
	lcQuery = [Select b.Descrs, b.FaixaIs, b.FaixaFs ] + ;
			    [From SigCdPpc a, SigCdPpi b ] + ;
	If (ThisForm.poDataMgr1.SqlExecute(lcQuery, 'LocalProp') < 1)
	Select LocalProp
		Select CqSigCdCli
	Select crSigCdCls
			lStrQuery = [Select a.CPros,a.CBars ] + ;
					[From SigOpEtq a ] + ;
					[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
			If ThisForm.poDataMgr1.SqlExecute(lStrQuery,'CrEtiqs') < 1
			Select CrEtiqs
				lStrQuery = [Select a.CPros,a.EAN13 From SigCdPro a Where a.EAN13 = ]+lcCBars+[ ]
				If ThisForm.poDataMgr1.SqlExecute(lStrQuery,'CrProEAN') < 1
				Select CrProEAN
					lStrQuery = [Select a.CPros,a.CBars From SigCdPro a Where a.CBars = ]+lcCBars+[ ]
					If ThisForm.poDataMgr1.SqlExecute(lStrQuery,'CrEtiPro') < 1
					Select CrEtiPro
	lcQuery = [Select LPrecos, Formulas, Emps ] + ;
				[From SigCdLpc a ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdLpc') < 1)
	Select crSigCdLpc
	If Not Seek(This.Value, 'crSigCdLpc', 'LPrecos')
lcSql = [Select Caixas, copers, opers From SigCdOpe Where Dopes=']+lcdopes+[']
If ThisForm.poDataMgr1.SQLExecute(lcSql,'TmpOpe') < 1
lStrQuery = [Select a.Datas,a.Emps,a.Dopes,a.Numes,a.PrazoEnts,c.Rclis,c.conjuges, ]+;
			[From SigMvCab a, SigCdCli c, SigCdOpe b ]+;
If ThisForm.poDataMgr1.SQLExecute(lStrQuery,'TprMvCab') < 1
lcQuery = [Select Distinct Emps,Datas,Dopes,Numes,Nvl(PrazoEnts,Ctod('')) As PrazoEnts,Contas,RClis,Conjuges ] + ;
		  	[From TprMvCab Order By 1,]+Iif(lnTpData = 1,[2],[5])+[,3,4 Into Cursor CrTprMvCab]
Select TprMvCab
Select CrTprMvCab
Select crSigCdTom
	Select crSigCdTom
		lcSql = [Select Caixas, copers, opers From SigCdOpe Where Dopes=']+lcdopes+[']
		If ThisForm.poDataMgr1.SQLExecute(lcSql,'TmpOpe') < 1
		lStrQuery = [Select distinct(a.empdopnums) as empdopnums ]+;
					[From SigMvCab a, SigCdCli c, SigCdOpe b ]+;
		If ThisForm.poDataMgr1.SQLExecute(lStrQuery,'TprMvCab') < 1
		Select TprMvCab
			Insert into crFilOper Values(TprMvCab.EmpDopNums)
	Select ('CrSigCdPam')
	Select CsMatPrima
			Delete
		This.Parent.Parent.Parent.Pag_Resultado.Result.Fase.Get_Obs.ControlSource = ''
			lcQuery = [Select b.Descrs, b.FaixaIs, b.FaixaFs ] + ;
					    [From SigCdPpc a, SigCdPpi b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalProp') < 1)
			Select LocalProp
	Select CsMatPrima
							[And a.cpros Not in (Select xa.Cpros From SigPrFnc xa Where xa.Ifors = '] + lcCfor + [' And xa.Reffs = '] + lcRefI + [') ]
		lcWhereFproTB1 = [And a.cpros in (Select xa.Cpros From SigPrFnc xa Where xa.Ifors = '] + lcCfor + [' And xa.Reffs = '] + lcRefI + [') ]
							[And a.cpros Not in (Select xa.Cpros From SigPrFnc xa Where xa.Ifors = '] + lcCfor + [') ]
			lcWhereFproTB1 = [And a.cpros in (Select xa.Cpros From SigPrFnc xa Where xa.Ifors = '] + lcCfor + [') ]
								[And a.Cpros Not in (Select Cpros From SigPrFnc Where Upper(reffs) Like '%]+AllTrim(lcRefI)+[%') ]
				lcWhereFproTB2 = [And a.Cpros in (Select Cpros From SigPrFnc Where Upper(reffs) Like '%]+AllTrim(lcRefI)+[%') ]
									[And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs = '] + lcRefI + [') ]						
					lcWhereFproTB2 = [And a.cpros in (Select Cpros From SigPrFnc Where Reffs = '] + lcRefI + [') ]
									[And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs Between '] + lcRefI + [' And '] + lcRefF + [') ]
					lcWhereFproTB2 = [And a.cpros in (Select Cpros From SigPrFnc Where Reffs Between '] + lcRefI + [' And '] + lcRefF + [') ]
									[And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs <= '] + lcRefF + [') ]
					lcWhereFproTB2 = [And a.cpros in (Select Cpros From SigPrFnc Where Reffs <= '] + lcRefF + [') ]
									[And a.cpros Not in (Select Cpros From SigPrFnc Where Reffs >= '] + lcRefI + [') ]
					lcWhereFproTB2 = [And a.cpros in (Select Cpros From SigPrFnc Where Reffs >= '] + lcRefI + [') ]
	m.SelectPro   = ''
	m.FromPro     = ''
	m.SelectPro  = ([Select a.cpros,a.dpros,a.situas,a.linhas,a.cunis,a.pesoms,a.reffs,a.obspeds,]+;
	m.FromPro    = ([From SigCdPro a ])
		m.FromPro  = ""
			m.SelectPro = m.SelectPro + [,p.pecas ]
			m.FromPro  = ([From SigCdPro a Inner Join SigPrPmi p on p.cpros=a.cpros ])
				m.FromPro = m.FromPro + [ Right Join SigCdGrp g On a.cgrus = g.cgrus ]
			m.FromPro    = ([From SigCdPro a Inner Join SigMvItn e On a.cpros = e.cpros Inner Join SigMvCab x on x.EmpDopNums = e.EmpDopNums ])
				m.FromPro = ([From SigCdPro a Right Join SigCdGrp g On a.cgrus = g.cgrus ])
		m.FromPro = m.FromPro + [Inner Join SigMvEst t on t.cPros = a.cPros ]
	Select CsMatPrima
	m.lcSqlPro1 = IIf(!IsEmpty(m.SelectPro),m.SelectPro,'') + IIf(!IsEmpty(m.FromPro),m.FromPro,'') +;
			<<m.SelectPro>>
			<<m.FromPro>>
			<<m.SelectPro>>
			<<m.FromPro>>
	m.lcSqlPro2 = ('select a.cpros,sum(b.sqtds) As sqtds '+IIf(!IsEmpty(m.FromPro),m.FromPro,'') +;
					[Inner Join SigMvEst b On b.cpros=a.cpros ]+;
			Select a.cpros, Sum(b.sqtds) As sqtds
			<<m.FromPro>>
			Inner Join SigMvEst b On b.cpros=a.cpros
			Select a.cpros, Sum(b.sqtds) As sqtds
			<<m.FromPro>>
			Inner Join SigMvEst b On b.cpros=a.cpros
			m.lnErro1 = ThisForm.poDataMgr1.SqlExecute(m.lcSqlPro1,'Tmp_Pros1')
			Select a.* From Tmp_Pros1 a, crSigCdCol b Where a.Colecoes = b.Colecoes Into Cursor Tmp_Pros ReadWrite
			m.FromPro  = ([From SigCdPro a Inner Join SigPrPmv p on p.Colecoes = a.Colecoes ])
				m.FromPro = m.FromPro + [ Right Join SigCdGrp g On a.cgrus = g.cgrus ]
			m.SelectPro = Strtran(m.SelectPro, [,p.pecas], [,Space(10) as pecas])
			m.lcSqlPro1 = IIf(!IsEmpty(m.SelectPro),m.SelectPro,'') + IIf(!IsEmpty(m.FromPro),m.FromPro,'') +;
					<<m.SelectPro>>
					<<m.FromPro>>
					<<m.SelectPro>>
					<<m.FromPro>>
				m.lnErro1 = ThisForm.poDataMgr1.SqlExecute(m.lcSqlPro1,'Tmp_Pros2')
			Select a.* From Tmp_Pros1 a, crSigCdCol b Where a.Colecoes = b.Colecoes ;
			Select c.* From Tmp_Pros2 c, crSigCdCol d Where c.Colecoes = d.Colecoes ;
			Select Distinct * ;
			  From Tmp_Pros3 ;
		Select Tmp_Pros
				Select a.cpros, Sum(a.Sqtds) As Saldo, f.nTemSaldos 
					From SigMvEst a
						Inner Join <<m.lcIdTab1>> b On b.Cpros = a.Cpros
						Left Join (Select e.cPros, Sum(1) As nTemSaldos From SigMvEst e Inner Join <<m.lcIdTab1>> t On t.Cpros = e.Cpros Where Not e.Sqtds = 0 Group by e.cPros) f On f.Cpros = a.Cpros
				m.lnErro1 = ThisForm.poDataMgr2.SQLExecute(m.lcSql1, 'Tmp_EstPro')
			Select Tmp_EstPro
				Select ('Tmp_EstPro')
				Select ('Tmp_Pros')
							Select e.cPros, Sum(1) As nTemSaldos 
								From SigMvEst e 
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcSql1, 'crTmpProEst1')
							Select a.cpros, Sum(a.Sqtds) As Saldo
								From SigMvEst a
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcSql1, 'crTmpEst0')
						Select a.cPros, a.Saldo, b.nTemSaldos ;
							From crTmpEst0 a ;
								Left Join crTmpProEst1 b On b.cPros = a.cPros ;
							Select crTmpEst1
								If Not Seek(crtmpest1.cpros,'Tmp_EstPro','cpros')
									Insert Into Tmp_EstPro (cpros,saldo,nTemSaldos) Values (crtmpest1.cpros,crtmpest1.saldo,Nvl(crtmpest1.nTemSaldos,0))
		Select Distinct a.*, Val(Str(Nvl(b.nTemSaldos, 0), 10, 0)) As nTemSaldos, Val(Str(Nvl(b.saldo,0),16,4)) as saldo, Val(Str(0,16,4)) as SaldoEstR ;
		  From Tmp_Pros a ;
		  Left Join Tmp_EstPro b On a.cpros = b.cpros ;
				m.lnErro1 = ThisForm.poDataMgr1.SqlExecute([Select m.cpros,m.mats,m.tipos,sum(m.qtds) as qtds ]+;
					   [From SigPrCpo m ]+;
							[And Not Exists(Select n.cpros From SigPrCpo n ]+;
				Select Tmp_Compos
				m.lcMcrsql1 = (IIf(!IsEmpty(m.SelectPro),m.SelectPro,'') + IIf(!IsEmpty(m.FromPro),m.FromPro,'') +;
					m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcMcrSql1,'Tmp_Pros1')
					Select a.* From Tmp_Pros1 a, crSigCdCol b Where a.Colecoes = b.Colecoes Into Cursor Tmp_Pros ReadWrite
					Select ('Tmp_Pros')
				Select ('tmp_compos')
							Select e.cPros, Sum(1) As nTemSaldos 
								From SigMvEst e 
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcSql1, 'crTmpProEst1')
							Select a.cpros, Sum(a.Sqtds) As Saldo
								From SigMvEst a
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcSql1, 'crTmpEst0')
						Select a.cPros, a.Saldo, b.nTemSaldos ;
							From crTmpEst0 a ;
								Left Join crTmpProEst1 b On b.cPros = a.cPros ;
							Select ('crtmpest1')
								If Not Seek(crtmpest1.cpros,'Tmp_EstPro','cpros')
									Insert Into Tmp_EstPro (cpros,saldo,ntemsaldos) Values (crtmpest1.cpros,crtmpest1.saldo,Nvl(crtmpest1.ntemsaldos,0))
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcMcrSql2,'crtmppro1')
							Select ('crtmppro1')
								If Not Seek(crtmppro1.cpros,'Tmp_Pros','cpros')
									Select ('crtmppro1')
									Insert Into Tmp_Pros From Memvar
			Select Distinct a.*, Val(Str(Nvl(e.nTemSaldos, 0), 10, 0)) As nTemSaldos, Val(Str(Nvl(e.saldo,0),16,4)) as saldo, Val(Str(0,16,4)) as SaldoEstR ;
			  From Tmp_Produtos a ;
				Inner Join Tmp_Compos b On b.cpros = a.cpros ;
				Left Join Tmp_EstPro e On e.cpros = b.cpros ;
				Select ('csMatprima')
								m.lcMcrSql1 = ([select a.cpros,a.compos,a.mats,a.qtds,a.Tipos from SigPrCpo a where a.mats in (]+Left(m.lcMcrSql1,(Len(m.lcMcrSql1)-1))+[) order by a.cpros])
								m.lcMcrSql1 = [Select a.cpros,a.compos,a.mats,a.qtds,a.Tipos ] + ;
												[From SigPrCpo a ] + ;
								m.lcMcrSql1 = [Select a.cpros,a.compos,a.mats,a.qtds,a.Tipos ] + ;
												[From SigPrCpo a ] + ;
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcMcrSql1,'crtmpcompf1')
							Select ('crtmpcompf1')
								If Not Seek(crtmpcompf1.compos+crtmpcompf1.cpros+crtmpcompf1.mats+crtmpcompf1.Tipos+Transform(crtmpcompf1.qtds*10000,'@L 999999999999'),'Tmp_CompoF','skgroup1')
									Insert Into Tmp_CompoF (cpros,compos,mats,tipos,qtds) Values (crtmpcompf1.cpros,crtmpcompf1.compos,crtmpcompf1.mats,crtmpcompf1.tipos,crtmpcompf1.qtds)
				Select ('csMatprima')
						m.lcMcrSql1 = ([select a.cpros,a.compos,a.mats,a.tipos,a.qtds,b.cgrus from SigPrCpo a, SigCdPro b ]+;
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcMcrSql1,'crtmpcompf1')
							Select ('crtmpcompf1')
								If Not Seek(crtmpcompf1.compos+crtmpcompf1.cpros+crtmpcompf1.mats+crtmpcompf1.tipos+Transform(crtmpcompf1.qtds*10000,'@L 999999999999'),'Tmp_CompoF','skgroup1')
									Insert Into Tmp_CompoF (cpros,compos,mats,tipos,qtds,Cgrus) Values ;
				Select CsMatPrima
						Select a.cpros,a.Tipos,IIf(IsEmpty(a.compos),a.mats,a.compos) as mats, sum(a.qtds) as qtds ;
						  From Tmp_CompoF a ;
						Select a.cpros,a.tipos,IIf(IsEmpty(a.compos),a.mats,a.compos) as mats, sum(a.qtds) as qtds ;
						  From Tmp_CompoF a;
									 a.cpros In (Select b.cpros From Tmp_Compos b)) ;
					Select CsMatPrima
				m.lcMcrsql1 = (IIf(!IsEmpty(m.SelectPro),m.SelectPro,'') + IIf(!IsEmpty(m.FromPro),m.FromPro,'') +;
					m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcMcrSql1,'Tmp_Pros1')
					Select a.* From Tmp_Pros1 a, crSigCdCol b Where a.Colecoes = b.Colecoes Into Cursor Tmp_Pros ReadWrite
					Select ('Tmp_Pros')
				Select ('tmp_compos')
							Select a.cpros, Sum(a.Sqtds) As Saldo, f.nTemSaldos 
								From SigMvEst a
									Left Join (Select e.cPros, Sum(1) As nTemSaldos 
												From SigMvEst e 
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcSql1, 'crtmpest1')
							Select ('crtmpest1')
								If Not Seek(crtmpest1.cpros,'Tmp_EstPro','cpros')
									Insert Into Tmp_EstPro (cpros,saldo,ntemsaldos) Values (crtmpest1.cpros,crtmpest1.saldo,Nvl(crtmpest1.ntemsaldos,0))
							m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcMcrSql2,'crtmppro1')
							Select ('crtmppro1')
								If Not Seek(crtmppro1.cpros,'Tmp_Pros','cpros')
									Select ('crtmppro1')
									Insert Into Tmp_Pros From Memvar
			Select Tmp_Pros
			Select Distinct * ;
			  From Tmp_Pros ;
			SELECT Tmp_Compos
			SELECT Tmp_EstPro
			SELECT Tmp_Produtos
			Select Distinct a.*, Val(Str(Nvl(e.nTemSaldos, 0), 10, 0)) As nTemSaldos, Val(Str(Nvl(e.saldo,0),16,4)) as Saldo, Val(Str(0,16,4)) as SaldoEstR ;
			  From Tmp_Produtos a ;
				Inner Join Tmp_Compos b On b.cpros = a.cpros ;
				Left Join Tmp_EstPro e On e.cpros = b.cpros ;
		Select ('crSigCdMoe')
		m.lcMcrsql1 = [select a.cmoes,a.datas,a.horas,a.valos from SigCdCot a inner join SigCdMoe b on b.cmoes=a.cmoes order by 1,2 Desc,3 Desc]
			m.lnErro1 = ThisForm.poDataMgr1.SQLExecute(m.lcMcrSql1,'crSigCdCot')
		Select ('crSigCdCot')
	Select csMatPrima
	Select Codigos From crSigCrRap Where Selec = 1 Into Cursor LocalCarcs ReadWrite
	Select LocalCarcs
		Select crProdutos
			lcQuery = [Select Codigos ] + ;
					    [From SigPrCar ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [BusCars]) < 1)
			Select BusCars
					If Seek(BusCars.Codigos, [LocalCarcs], [Codigos])
				Delete In crProdutos
	Select CrProdutos
		.col_cpros.ControlSource = 'CrProdutos.cpros'
		.col_dpros.ControlSource = 'CrProdutos.dpros'
		.Column3.ControlSource = 'CrProdutos.Offs'
	Select CrProdutos
	Select ('crProdutos')
	Select ('crProdutos')
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select a.cpros,a.mats,a.dcompos,a.unicompos,a.pcompos,a.qtds,]+;
		   [From SigPrCpo a ]+;
Select CrSigPrCpo
	.material.ControlSource = 'CrSigPrCpo.mats'
	.descrimt.ControlSource = 'CrSigPrCpo.dcompos'
	.unidmt.ControlSource   = 'CrSigPrCpo.unicompos'
	.precomt.ControlSource  = 'CrSigPrCpo.pcompos'
	.qtdmt.ControlSource    = 'CrSigPrCpo.qtds'
	.moedamt.ControlSource  = 'CrSigPrCpo.moeds'
	.obscomp.ControlSource  = 'CrSigPrCpo.obscompos'
	.Column8.ControlSource  = 'CrSigPrCpo.Pesos'
	.Column9.ControlSource  = 'CrSigPrCpo.cUniPs'
lcSql = [Select UnitMeds, MoedMeds From SigMvEst Where Cpros = ']+CrTSigPro.Cpros+[' And Emps = ']+_Empr+[']
If ThisForm.poDataMgr1.SqlExecute(lcSql,'LocalEst') < 1
Select LocalEst
	Select CrSigMvEst
		SELECT crEstInv
			SELECT CrSigMvEst
			DELETE
			SELECT CrSigMvEst
Select CrSigMvEst
lcSql = [Select a.cpros,a.emps,a.grupos,a.estos,a.datas,a.numes,a.dopes,a.empos,]+;
		[From SigMvHst a ]+;
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcSql,'Tmp_Hist')
	Select Tmp_Hist
		lcQuery = [Select Fators From SigMvItn where empdopnums = '] + lcEDN + [' and cpros = '] + Tmp_Hist.Cpros +[' and codbarras = ] + Str(codbarras,14)
		If (ThisForm.poDataMgr1.SqlExecute(lcQuery, 'LocalFator') < 1)
			Select Tmp_Hist
		Select Tmp_Hist
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select a.cpros,a.mats,a.dcompos,a.unicompos,a.pcompos,a.qtds,]+;
		   [From SigPrCpo a ]+;
Select CrSigPrCpo
	.Get_dcompos.ControlSource          = 'CrSigPrCpo.dcompos'
	.grd_consumo.material.ControlSource = 'CrSigPrCpo.mats'
	.grd_consumo.unidmt.ControlSource   = 'CrSigPrCpo.unicompos'
	.grd_consumo.consmt.ControlSource   = 'CrSigPrCpo.qtscons'
	.grd_consumo.qtdmt.ControlSource    = 'CrSigPrCpo.qtds'
	.grd_consumo.grupo.ControlSource    = 'CrSigPrCpo.grupos'
	.grd_consumo.dscgrp.ControlSource   = 'CrSigPrCpo.dscgrp'
	.grd_consumo.cats.ControlSource     = 'CrSigPrCpo.cats'
Select CrSigPrCpo
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select a.produtos,a.grupos,a.ordems,a.etiquetas,a.FigProcs,]+;
	   [From SigCdPrf a, SigCdGcr b ]+;
Select CsFase
This.Get_Obs.ControlSource = 'CsFase.obs'
	.Column1.ControlSource = 'CsFase.Ordems'
	.Column2.ControlSource = 'CsFase.Grupos'
	.Column3.ControlSource = 'CsFase.Etiquetas'
	.Column4.ControlSource = 'CsFase.Descrs'
Select CrTSigPro
Select crSigMvEtr
	Select CrSigMvEst
		SELECT crEstInv
			SELECT CrSigMvEst
			DELETE
			SELECT CrSigMvEst
Select crSigMvEst
	If Seek(crSigMvEst.Emps + crSigMvEst.Grupos + crSigMvEst.Estos + crSigMvEst.CodCors + crSigMvEst.CodTams, [crSigMvEtr], [EmpGruCon])
		Insert Into crSigMvEtr From Memvar
Select crSigMvEtr
Select crSigMvEtr
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
	Select CrSigCdMoe
		Select CrSigCdCot
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select a.cpros,a.mats,a.dcompos,a.unicompos,a.pcompos,a.qtds,]+;
		   [From SigPrCpo a ]+;
Select CrSigPrCpo
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigPrCpo.Mats'
	.Column2.ControlSource  = 'crSigPrCpo.DCompos'
	.Column3.ControlSource  = 'crSigPrCpo.UniCompos'
	.Column4.ControlSource  = 'crSigPrCpo.PCompos'
	.Column5.ControlSource  = 'crSigPrCpo.Qtds'
	.Column6.ControlSource  = 'crSigPrCpo.Qtds * crSigPrCpo.PCompos'
	.Column7.ControlSource  = 'crSigPrCpo.Moeds'
	.Column8.ControlSource  = 'crSigPrCpo.ObsCompos'
	.Column9.ControlSource  = 'crSigPrCpo.Etiqs'
	.Column10.ControlSource = 'crSigPrCpo.QtsCons'
	.Column11.ControlSource = 'crSigPrCpo.Pesos'
	.Column12.ControlSource = 'crSigPrCpo.cUniPs'
	.Column13.ControlSource = 'crSigPrCpo.Tipos'
Select crSigMvEtr
Select CrMvEst
	Select CrMvEst
		SELECT crEstInv
			SELECT CrMvEst
			DELETE
			SELECT CrMvEst
	Select CrSigMvEst
	Select CrSigMvEst
		SELECT crEstInv
			SELECT CrSigMvEst
			DELETE
			SELECT CrSigMvEst
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)  
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)  
	Select a.Emps,a.cpros,a.datas,a.numes,a.dopes,a.qtds,a.opers,a.sqtds,a.codbarras,a.cidchaves,a.pesos,a.spesos,a.Seqs,a.empos, a.Fators ;
	  From Tmp_Hist a ;
		.col_data.ControlSource     = 'CrSigMvHst.datas'
		.col_codigo.ControlSource   = 'CrSigMvHst.numes'
		.col_operacao.ControlSource = 'CrSigMvHst.dopes'
		.col_qtde.ControlSource     = 'CrSigMvHst.qtds'
		.col_o.ControlSource        = 'CrSigMvHst.opers'
		.col_saldo.ControlSource    = 'CrSigMvHst.sqtds'
		.col_cdbarras.ControlSource = 'CrSigMvHst.codbarras'
		.col_fator.ControlSource 	= 'CrSigMvHst.Fators'
			.Col_peso.controlsource = 'CrSigMvHst.Pesos'
			.col_speso.Controlsource= 'CrSigMvHst.sPesos'
			.Col_peso.controlsource = ''
			.col_speso.Controlsource= ''
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)  
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
	ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
	ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource, .T.) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
	lcSql = [Select Dopes From SigCdOpe Where Dopes = ']+CrSigMvHst.Dopes+[']
	If thisform.Podatamgr.SqlExecute(lcsql,'TmpOpe') > 0 And Reccount('TmpOpe') > 0
		lcSql = [Select Dopps From SigCdOpd Where Dopps = ']+CrSigMvHst.Dopes+[']
		If Thisform.Podatamgr.SqlExecute(lcsql,'TmpOpp') > 0 And Reccount('TmpOpp') > 0
Select CrProdutos
m.SelectPro   = [Select a.cpros,a.cgrus,a.dpros,a.sgrus,a.cunis,a.cunips,a.ifors,a.reffs,a.qmins,a.valors,a.moedas,a.icms,]+;
				[From SigCdPro a ]+;
				[Left Join SigCdGrp g On a.cgrus = g.cgrus ]+;
				[Left Join SigCdUni u On a.cunis = u.cunis ]+;
				[Left Join SigCdCol b On a.colecoes = b.colecoes ]+;
				[Left Join SigCdLin l On a.linhas = l.linhas ]+;
				[Left Join SigCdCtg j On a.Categoria = j.Cods ]+;
				[Left Join SigPrFti f On a.cftios = f.cods ]+;
				[Left Join SigCdCli c On a.ifors = c.iclis ]+;
				[Left Join SigCdGpr h On a.Mercs= h.codigos ]+;
				Iif(Not Empty(lcLstPre),[Left Join SigCdLpi i On a.cpros = i.cpros and i.lprecos = ']+lcLstPre+[' ],[]) + ;
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(m.SelectPro,'CrTSigPro')
Select CrTSigPro
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select s.codigos,s.descricaos ]+;
				  [From SigCdPsg s ]+;
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select descs ]+;
				  [From SigCdCor ]+;
	Select CrTSigPro
		Select CrSigCdCot
		Select CrSigCdCot
	lcQuery = [Select a.cpros ] + ;
				[From SigCdLpi a, SigCdLpc b ] + ;
	If ThisForm.poDataMgr1.SqlExecute(lcQuery, 'Tmp_lPrei') < 1
		lcQuery = [Select a.CPros ] + ;
					[From SigCdMin a ] + ;
		If (ThisForm.poDataMgr1.SqlExecute(lcQuery, [LocalBusca]) < 1)
Select CrProdutos
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select i.FigJpgs ]+;
				  [From SigCdPro i ]+;
Select Tmp_Img
Select CrProdutos
Select CrProdutos
Select CrProdutos
	Select ('crSigCdPam')
	Select LpItem
		Select CsSigOpTdz
		If Seek(LpItem.TabDs,'CsSigOpTdz','Codigos')
					Delete In LpItem
	Select LpItem
	Select crProdutos
		lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select FigJpgs From SigCdPro Where CPros = '] + lcPro + ['], [LocalImg])
		Select LocalImg
lcQuery = [Select a.*, b.Descrs From SigPrCar a Inner Join SigCrRap b On a.Codigos = b.Codigos And a.CPros = '] + crProdutos.CPros + [']
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcQuery, [crSigPrCar])
lcQuery = [select a.cpros, a.cods, b.descs from sigserpr a join sigprser b on a.cods = b.cods join sigcdpro c on a.cpros = c.cpros Where a.cpros = '] + crProdutos.CPros + [']
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcQuery, [crSigSerPr])
lcQuery = [select a.cpros, isnull(a.ObsInsp,'') as ObsInsp, isnull(b.ObsTars,'') as ObsTars from sigcdpro a left join sigprtar b on a.cpros = b.cpros Where a.cpros = '] + crProdutos.CPros + [']
lnQueryOk = ThisForm.poDataMgr1.SqlExecute(lcQuery, [csTmpPrTar])
	lcUpdate = [Update SigCdPrf Set Obs = ?lc_Obs Where Produtos = ']+csFase.Produtos+[' And Ordems = ]+Str(CsFase.Ordems,2)
	If ThisForm.poDataMgr1.SqlExecute(lcUpdate,'') < 1
		lcDelete = [Delete from SigPrPrt Where Cpros = ']+csFase.Produtos+[' ]
		If ThisForm.Podatamgr1.SqlExecute(lcDelete,'') < 1
Select csFase
		lcQuery = [Select * from SigCdPrf Where Produtos = ']+csFase.Produtos+[' And Ordems = ]+Str(CsFase.Ordems,2)
		If ThisForm.poDataMgr1.SqlExecute(lcQuery,'TmpCdPrf') < 1
		Select TmpCdPrf
		Insert into CrSigCdPrf from memvar
		If Not ThisForm.poDataMgr1.Update('crSigCdPrf')
			lcDelete = [Delete from SigPrPrt Where Cpros = ']+csFase.Produtos+[' ]
			If ThisForm.Podatamgr1.SqlExecute(lcDelete,'') < 1
			Delete File (lcFigura)
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
	If Not Seek(This.Value, 'crMGOpe', 'DgOpes')
	Select CrSigMvEst
lnQueryOk = ThisForm.poDataMgr1.SqlExecute([Select a.cods,a.descs ]+;
	   [From SigCdCor a ]+;
	Select CrSigCdCor
lcQuery = [Select Locals ] + ;
		    [From SigCdMin ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPrEmp]) < 1)
Select LocalPrEmp
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
	ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
	ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource, .T.) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
		Select crEmpenhado
		Select distinct * from crEmpenhado Into Cursor csEmpenho ReadWrite
		Select csEmpenho
			Select * from csEmpenho Into Cursor crEmpenhado ReadWrite
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)  
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
	ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
	ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource, .T.) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource)  
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
ThisForm.AcertaOrdemGrade(This.Parent.Parent,This.Parent.ControlSource) 
	Select CrMvEst
	Select CrMvEst
		Select crEstInv
			Select CrMvEst
			Delete
			Select CrMvEst
If ThisForm.poDataMgr1.SqlExecute([Select a.cods,a.descs From SigCdCor a Where a.cods = ']+lcCodCor+[' ],'CrSigCdCor') < 1
	Select CrSigCdCor

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgp.prg) - TRECHOS RELEVANTES PARA PASS SQL (5896 linhas total):

*-- Linhas 289 a 359:
289:     *-- Validacao de UI nao executa SQL - apenas cria placeholders
290:     IF NOT USED("cursor_4c_Dados")
291:       SET NULL ON
292:       CREATE CURSOR cursor_4c_Dados ;
293:         (cpros  C(15), dpros  C(60), cgrus  C(5),  ;
294:          dgrus  C(40), cmoes  C(3),  price  N(18,4),;
295:          qatua  N(18,4), ativo L)
296:       SET NULL OFF
297:     ENDIF
298: 
299:     IF NOT USED("CsMatPrima")
300:       SET NULL ON
301:       CREATE CURSOR CsMatPrima ;
302:         (mats C(15), dcompos C(60), qtd_inicial N(18,4), ;
303:          qtd_final N(18,4), apenas L, Cgrus C(5), Tipos C(10))
304:       SET NULL OFF
305:     ENDIF
306: 
307:     IF NOT USED("cursor_4c_Caract")
308:       SET NULL ON
309:       CREATE CURSOR cursor_4c_Caract ;
310:         (marcado L, cods C(5), descs C(40))
311:       SET NULL OFF
312:     ENDIF
313: 
314:     IF NOT USED("cursor_4c_TOpe")
315:       SET NULL ON
316:       CREATE CURSOR cursor_4c_TOpe ;
317:         (marcado L, ctipo C(5), dtipo C(40))
318:       SET NULL OFF
319:     ENDIF
320: 
321:     IF NOT USED("CrSigMvHst")
322:       SET NULL ON
323:       CREATE CURSOR CrSigMvHst ;
324:         (cpros C(15), dtmov D, qtmov N(18,4), vlmov N(18,4))
325:       SET NULL OFF
326:     ENDIF
327: 
328:     IF NOT USED("CsEtiqueta")
329:       SET NULL ON
330:       CREATE CURSOR CsEtiqueta ;
331:         (cpros C(15), dpros C(60), qetiq N(18,4))
332:       SET NULL OFF
333:     ENDIF
334: 
335:     IF NOT USED("CsFase")
336:       SET NULL ON
337:       CREATE CURSOR CsFase ;
338:         (cpros C(15), cfases C(5), dfases C(40))
339:       SET NULL OFF
340:     ENDIF
341: 
342:     IF NOT USED("CrProdutos")
343:       SET NULL ON
344:       CREATE CURSOR CrProdutos (cpros C(15), dpros C(60))
345:       SET NULL OFF
346:     ENDIF
347:   ENDPROC
348: 
349:   *------------------------------------------------------------
350:   PROCEDURE CarregarDados
351:     THIS.BtnConsultarClick()
352:   ENDPROC
353: 
354:   *------------------------------------------------------------
355:   PROCEDURE BtnConsultarClick
356:     LOCAL loc_oPag, loc_oFiltros, loc_lSucesso, loc_cCaption
357:     LOCAL loc_cPesoI, loc_cPesoF, loc_cCustoI, loc_cCustoF
358: 
359:     loc_oPag     = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1

*-- Linhas 432 a 460:
432:         THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.RecordSource = ""
433: 
434:         IF USED("CrProdutos")
435:           SELECT CrProdutos
436:           ZAP IN CrProdutos
437:         ENDIF
438: 
439:         IF RECCOUNT("cursor_4c_Produtos") > 0
440:           SELECT CrProdutos
441:           APPEND FROM DBF("cursor_4c_Produtos") FIELDS cpros, dpros
442:         ENDIF
443: 
444:         THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.RecordSource = "CrProdutos"
445:         SELECT CrProdutos
446:         IF !EOF()
447:           GO TOP
448:         ENDIF
449:         THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos.Refresh()
450: 
451:         *-- Atualiza legenda e navega para pagina de resultado
452:         loc_cCaption = THIS.this_cPrompt
453:         THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = loc_cCaption
454:         THIS.this_lConsultaExecutada                   = .T.
455: 
456:         THIS.AlternarPagina(2)
457:       ELSE
458:         THIS.MousePointer = 0
459:         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
460:           MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")

*-- Linhas 2565 a 2724:
2565:     WITH par_oPag.grd_4c_Composicao
2566:       .FontName          = "Tahoma"
2567:       .FontSize          = 8
2568:       .DeleteMark        = .F.
2569:       .RecordMark        = .F.
2570:       .ScrollBars        = 2
2571:       .RowHeight         = 18
2572:       .AllowHeaderSizing = .F.
2573:       .AllowRowSizing    = .F.
2574: 
2575:       WITH .Column1
2576:         .Width           = 108
2577:         .ControlSource   = "CsMatPrima.mats"
2578:         .Movable         = .F.
2579:         .Resizable       = .F.
2580:         .Header1.Caption = "Caracter" + CHR(237) + "stica"
2581:         .Header1.Alignment = 2
2582:       ENDWITH
2583: 
2584:       WITH .Column2
2585:         .Width           = 290
2586:         .ControlSource   = "CsMatPrima.dcompos"
2587:         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2588:         .Header1.Alignment = 2
2589:       ENDWITH
2590: 
2591:       WITH .Column3
2592:         .Width           = 80
2593:         .ControlSource   = "CsMatPrima.qtd_inicial"
2594:         .Header1.Caption = "Qtd"
2595:         .Header1.Alignment = 2
2596:       ENDWITH
2597: 
2598:       WITH .Column4
2599:         .Width           = 80
2600:         .ControlSource   = "CsMatPrima.qtd_final"
2601:         .Header1.Caption = "Quantidade"
2602:         .Header1.Alignment = 2
2603:       ENDWITH
2604: 
2605:       *-- Column5: CheckBox (apenas)
2606:       .Column5.AddObject("Check1", "CheckBox")
2607:       WITH .Column5
2608:         .Width          = 15
2609:         .CurrentControl = "Check1"
2610:         .Sparse         = .F.
2611:         .ControlSource  = "CsMatPrima.apenas"
2612:         .Header1.Caption = ""
2613:       ENDWITH
2614: 
2615:       WITH .Column6
2616:         .Width           = 31
2617:         .ControlSource   = "CsMatPrima.Cgrus"
2618:         .Header1.Caption = "Grupo"
2619:         .Header1.Alignment = 2
2620:       ENDWITH
2621: 
2622:       WITH .Column7
2623:         .Width           = 80
2624:         .ControlSource   = "CsMatPrima.Tipos"
2625:         .Header1.Caption = "Tipos"
2626:         .Header1.Alignment = 2
2627:       ENDWITH
2628:     ENDWITH
2629:   ENDPROC
2630: 
2631:   *------------------------------------------------------------
2632:   PROTECTED PROCEDURE ConfigurarGrdCaracts(par_oPag)
2633:     par_oPag.AddObject("grd_4c_Caract", "Grid")
2634:     par_oPag.grd_4c_Caract.Top          = 319
2635:     par_oPag.grd_4c_Caract.Left         = 568
2636:     par_oPag.grd_4c_Caract.Width        = 187
2637:     par_oPag.grd_4c_Caract.Height       = 105
2638:     par_oPag.grd_4c_Caract.ColumnCount  = 2
2639:     par_oPag.grd_4c_Caract.RecordSource = "cursor_4c_Caract"
2640: 
2641:     WITH par_oPag.grd_4c_Caract
2642:       .FontName          = "Tahoma"
2643:       .FontSize          = 8
2644:       .DeleteMark        = .F.
2645:       .RecordMark        = .F.
2646:       .ScrollBars        = 2
2647:       .RowHeight         = 17
2648:       .AllowHeaderSizing = .F.
2649:       .AllowRowSizing    = .F.
2650: 
2651:       *-- Column1: CheckBox (marcado)
2652:       .Column1.AddObject("Check1", "CheckBox")
2653:       WITH .Column1
2654:         .Width          = 15
2655:         .CurrentControl = "Check1"
2656:         .Sparse         = .F.
2657:         .ControlSource  = "cursor_4c_Caract.marcado"
2658:         .Header1.Caption = ""
2659:       ENDWITH
2660: 
2661:       WITH .Column2
2662:         .Width           = 150
2663:         .ControlSource   = "cursor_4c_Caract.descs"
2664:         .Header1.Caption = "Caracter" + CHR(237) + "stica"
2665:         .Header1.Alignment = 2
2666:       ENDWITH
2667:     ENDWITH
2668:   ENDPROC
2669: 
2670:   *------------------------------------------------------------
2671:   PROTECTED PROCEDURE ConfigurarGrdTOpe(par_oPag)
2672:     par_oPag.AddObject("grd_4c_TOpe", "Grid")
2673:     par_oPag.grd_4c_TOpe.Top          = 485
2674:     par_oPag.grd_4c_TOpe.Left         = 118
2675:     par_oPag.grd_4c_TOpe.Width        = 360
2676:     par_oPag.grd_4c_TOpe.Height       = 89
2677:     par_oPag.grd_4c_TOpe.ColumnCount  = 3
2678:     par_oPag.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"
2679: 
2680:     WITH par_oPag.grd_4c_TOpe
2681:       .FontName          = "Tahoma"
2682:       .FontSize          = 8
2683:       .DeleteMark        = .F.
2684:       .RecordMark        = .F.
2685:       .ScrollBars        = 2
2686:       .RowHeight         = 17
2687:       .AllowHeaderSizing = .F.
2688:       .AllowRowSizing    = .F.
2689: 
2690:       *-- Column1: CheckBox (marcado)
2691:       .Column1.AddObject("Check1", "CheckBox")
2692:       WITH .Column1
2693:         .Width          = 15
2694:         .CurrentControl = "Check1"
2695:         .Sparse         = .F.
2696:         .ControlSource  = "cursor_4c_TOpe.marcado"
2697:         .Header1.Caption = ""
2698:       ENDWITH
2699: 
2700:       WITH .Column2
2701:         .Width           = 31
2702:         .ControlSource   = "cursor_4c_TOpe.ctipo"
2703:         .Header1.Caption = "C" + CHR(243) + "d"
2704:         .Header1.Alignment = 2
2705:       ENDWITH
2706: 
2707:       WITH .Column3
2708:         .Width           = 290
2709:         .ControlSource   = "cursor_4c_TOpe.dtipo"
2710:         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2711:         .Header1.Alignment = 2
2712:       ENDWITH
2713:     ENDWITH
2714:   ENDPROC
2715: 
2716:   *------------------------------------------------------------
2717:   *-- Fase 5/8: Page2 (Selecao) - Grid + Cabecalho Parte 1
2718:   PROTECTED PROCEDURE ConfigurarPaginaDados
2719:     LOCAL loc_oPag
2720:     loc_oPag = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1
2721: 
2722:     *-- Grid principal de produtos (grd_produtos)
2723:     loc_oPag.AddObject("grd_4c_Produtos", "Grid")
2724:     loc_oPag.grd_4c_Produtos.RecordSource = "CrProdutos"

*-- Linhas 2731 a 2768:
2731:     WITH loc_oPag.grd_4c_Produtos
2732:       .FontName          = "Tahoma"
2733:       .FontSize          = 8
2734:       .DeleteMark        = .F.
2735:       .RecordMark        = .F.
2736:       .ScrollBars        = 2
2737:       .RowHeight         = 18
2738:       .AllowHeaderSizing = .F.
2739:       .AllowRowSizing    = .F.
2740:       .ReadOnly          = .T.
2741: 
2742:       WITH .Column1
2743:         .Width             = 108
2744:         .ControlSource     = "CrProdutos.cpros"
2745:         .Movable           = .F.
2746:         .Resizable         = .F.
2747:         .Header1.Caption   = "C" + CHR(243) + "d"
2748:         .Header1.Alignment = 2
2749:       ENDWITH
2750: 
2751:       WITH .Column2
2752:         .Width             = 525
2753:         .ControlSource     = "CrProdutos.dpros"
2754:         .Movable           = .F.
2755:         .Resizable         = .F.
2756:         .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
2757:         .Header1.Alignment = 2
2758:       ENDWITH
2759:     ENDWITH
2760: 
2761:     *-- Imagem do produto (FigJpg) - lado direito do grid
2762:     loc_oPag.AddObject("img_4c_FigJpg", "Image")
2763:     WITH loc_oPag.img_4c_FigJpg
2764:       .Top         = 5
2765:       .Left        = 658
2766:       .Width       = 222
2767:       .Height      = 220
2768:       .BorderStyle = 0

*-- Linhas 3807 a 3825:
3807:     ENDWITH
3808: 
3809:     *-- Memos de Observacao de Compras (getObsCompras) e Descritivo complementar
3810:     *-- (getDPro3s). No legado sao EditBox com ControlSource em crTSigPro.ObsCompras
3811:     *-- / crTSigPro.DPro3s; aqui sao preenchidos por codigo em GrdProdutosAfterRowColChange.
3812:     loc_oPag.AddObject("lbl_4c_LblObsCompras", "Label")
3813:     WITH loc_oPag.lbl_4c_LblObsCompras
3814:       .Top       = 525
3815:       .Left      = 5
3816:       .Width     = 72
3817:       .Height    = 15
3818:       .Caption   = "Obs. Compras :"
3819:       .FontName  = "Tahoma"
3820:       .FontSize  = 8
3821:       .Alignment = 0
3822:       .AutoSize  = .F.
3823:       .BackStyle = 0
3824:       .ForeColor = RGB(90, 90, 90)
3825:     ENDWITH

*-- Linhas 4490 a 4508:
4490:     ENDIF
4491: 
4492:     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpTam")
4493:       SELECT cursor_4c_LkpTam
4494:       loc_oPag.txt_4c_Tam.Value  = ALLTRIM(NVL(cursor_4c_LkpTam.Cods, ""))
4495:       loc_oPag.txt_4c_DTam.Value = ALLTRIM(NVL(cursor_4c_LkpTam.Descs, ""))
4496:     ENDIF
4497: 
4498:     IF USED("cursor_4c_LkpTam")
4499:       USE IN cursor_4c_LkpTam
4500:     ENDIF
4501:     loc_oForm.Release()
4502:     loc_oPag = .NULL.
4503:   ENDPROC
4504: 
4505:   *------------------------------------------------------------
4506:   *-- AbrirLookupCategoria: legado getCategoria.Valid / getDCategoria.Valid
4507:   *-- fwbuscaext sobre SigCdCtg, buscando por Cods ("C") ou Descs ("D").
4508:   PROCEDURE AbrirLookupCategoria(par_cLado)

*-- Linhas 4536 a 4554:
4536:     ENDIF
4537: 
4538:     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpCtg")
4539:       SELECT cursor_4c_LkpCtg
4540:       loc_oPag.txt_4c_Categoria.Value  = ALLTRIM(NVL(cursor_4c_LkpCtg.Cods, ""))
4541:       loc_oPag.txt_4c_DCategoria.Value = ALLTRIM(NVL(cursor_4c_LkpCtg.Descs, ""))
4542:     ENDIF
4543: 
4544:     IF USED("cursor_4c_LkpCtg")
4545:       USE IN cursor_4c_LkpCtg
4546:     ENDIF
4547:     loc_oForm.Release()
4548:     loc_oPag = .NULL.
4549:   ENDPROC
4550: 
4551:   PROCEDURE AbrirLookupPromocao
4552:     LOCAL loc_oPag, loc_cVal, loc_oForm
4553:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4554:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Promo.Value)

*-- Linhas 4932 a 5036:
4932:       RETURN
4933:     ENDIF
4934: 
4935:     SELECT CrProdutos
4936:     IF EOF()
4937:       RETURN
4938:     ENDIF
4939: 
4940:     loc_cCodPro = ALLTRIM(CrProdutos.cpros)
4941:     IF EMPTY(loc_cCodPro)
4942:       RETURN
4943:     ENDIF
4944: 
4945:     loc_lProsseguir = .T.
4946:     TRY
4947:       THIS.MousePointer = 11
4948: 
4949:       *-- Query principal: dados do produto com JOINs
4950:       loc_cSQL = ;
4951:         "Select a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis, " + ;
4952:         "a.ifors, a.reffs, a.qmins, a.pvens, a.moevs, " + ;
4953:         "a.pesoms, a.fcustos, a.moepcs, a.fvendas, a.moepvs, " + ;
4954:         "a.obspeds, a.obspes, a.linhas, a.colecoes, " + ;
4955:         "a.CodCors, a.cproeqs, a.cClass, a.Locals, a.cbars, " + ;
4956:         "a.CodFinP, a.Conjunts, a.Mercs, a.pcuss, a.moecs, " + ;
4957:         "a.situas, a.DPro2s, a.DPro3s, a.Volumes, " + ;
4958:         "a.Categoria, a.CodMacro, a.ObsCompras, a.PrecoDe, " + ;
4959:         "a.dtincs, a.UsuIncs, a.UltComps, a.vUltComps, a.MUltComps, " + ;
4960:         "k.descs As descCtg, " + ;
4961:         "a.pesobs, a.tamps, a.tamhs, a.tamls, a.ProdWebs, " + ;
4962:         "c.rclis, g.dgrus, " + ;
4963:         "b.descs As desccol, l.descs As desclin, " + ;
4964:         "f.descs As descftio, h.descs As descgru " + ;
4965:         "From SigCdPro a " + ;
4966:         "Left Join SigCdGrp g On a.cgrus = g.cgrus " + ;
4967:         "Left Join SigCdCol b On a.colecoes = b.colecoes " + ;
4968:         "Left Join SigCdLin l On a.linhas = l.linhas " + ;
4969:         "Left Join SigPrFti f On a.cftios = f.cods " + ;
4970:         "Left Join SigCdCli c On a.ifors = c.iclis " + ;
4971:         "Left Join SigCdGpr h On a.Mercs = h.codigos " + ;
4972:         "Left Join SigCdCtg k On a.Categoria = k.Cods " + ;
4973:         "Where a.cpros = " + EscaparSQL(loc_cCodPro)
4974: 
4975:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProd")
4976:       IF loc_nRet < 1
4977:         THIS.MousePointer = 0
4978:         loc_lProsseguir = .F.
4979:       ENDIF
4980: 
4981:       IF loc_lProsseguir
4982:           SELECT cursor_4c_TmpProd
4983:           IF EOF()
4984:             THIS.MousePointer = 0
4985:             IF USED("cursor_4c_TmpProd")
4986:               USE IN cursor_4c_TmpProd
4987:             ENDIF
4988:             loc_lProsseguir = .F.
4989:           ENDIF
4990:       ENDIF
4991: 
4992:       IF loc_lProsseguir
4993:           GO TOP IN cursor_4c_TmpProd
4994: 
4995:       *-- Buscar subgrupo separadamente
4996:           loc_cCodGru  = ALLTRIM(NVL(cursor_4c_TmpProd.cgrus, ""))
4997:           loc_cCodSgru = ALLTRIM(NVL(cursor_4c_TmpProd.sgrus, ""))
4998: 
4999:           loc_cDsSgrupo = ""
5000:           IF !EMPTY(loc_cCodSgru)
5001:             loc_cSQL = "Select descricaos From SigCdPsg " + ;
5002:               "Where cgrus = " + EscaparSQL(loc_cCodGru) + ;
5003:               " And codigos = " + EscaparSQL(loc_cCodSgru)
5004:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSgr") >= 1
5005:               IF USED("cursor_4c_TmpSgr") AND !EOF("cursor_4c_TmpSgr")
5006:                 loc_cDsSgrupo = ALLTRIM(NVL(cursor_4c_TmpSgr.descricaos, ""))
5007:               ENDIF
5008:               IF USED("cursor_4c_TmpSgr")
5009:                 USE IN cursor_4c_TmpSgr
5010:               ENDIF
5011:             ENDIF
5012:           ENDIF
5013: 
5014:       *-- Buscar cor separadamente
5015:           loc_cCodCor = ALLTRIM(NVL(cursor_4c_TmpProd.CodCors, ""))
5016: 
5017:           loc_cDsCor = ""
5018:           IF !EMPTY(loc_cCodCor)
5019:             loc_cSQL = "Select descs From SigCdCor Where Cods = " + ;
5020:               EscaparSQL(loc_cCodCor)
5021:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCor") >= 1
5022:               IF USED("cursor_4c_TmpCor") AND !EOF("cursor_4c_TmpCor")
5023:                 loc_cDsCor = ALLTRIM(NVL(cursor_4c_TmpCor.descs, ""))
5024:               ENDIF
5025:               IF USED("cursor_4c_TmpCor")
5026:                 USE IN cursor_4c_TmpCor
5027:               ENDIF
5028:             ENDIF
5029:           ENDIF
5030: 
5031:       *-- Preencher campos do cabecalho
5032:           loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
5033: 
5034:       *-- Fornecedor
5035:           loc_oCab.txt_4c__cd_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.ifors, ""))
5036:           loc_oCab.txt_4c__ds_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpProd.rclis, ""))

*-- Linhas 5183 a 5326:
5183:     loc_oImg.Picture = ""
5184: 
5185:     TRY
5186:       loc_cSQL = "Select FigJpgs From SigCdPro " + ;
5187:         "Where cpros = " + EscaparSQL(par_cCodPro)
5188:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpImg")
5189:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpImg") AND !EOF("cursor_4c_TmpImg")
5190:         IF !ISNULL(cursor_4c_TmpImg.FigJpgs) AND !EMPTY(cursor_4c_TmpImg.FigJpgs)
5191:           loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
5192:           STRTOFILE(cursor_4c_TmpImg.FigJpgs, loc_cArquivo)
5193:           loc_oImg.Picture = loc_cArquivo
5194:         ENDIF
5195:       ENDIF
5196:       IF USED("cursor_4c_TmpImg")
5197:         USE IN cursor_4c_TmpImg
5198:       ENDIF
5199:     CATCH TO loc_oErro
5200:       *-- INTENCIONAL: imagem nao disponivel (cursor/SQLEXEC pode falhar, FigJpgs vazio); produto exibe sem foto
5201:     ENDTRY
5202: 
5203:     loc_oImg = .NULL.
5204:   ENDPROC
5205: 
5206:   *------------------------------------------------------------
5207:   *-- CarregarCaracteristicas: carrega grid de caracteristicas do filtro
5208:   PROTECTED PROCEDURE CarregarCaracteristicas
5209:     LOCAL loc_cSQL, loc_nRet
5210:     TRY
5211:       loc_cSQL = "Select 0 as marcado, Codigos as cods, " + ;
5212:         "Codigos as descs From SigCrRap"
5213:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCaract")
5214:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpCaract")
5215:         IF USED("cursor_4c_Caract")
5216:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = ""
5217:           SELECT cursor_4c_Caract
5218:           SELECT cursor_4c_Caract
5219:           ZAP
5220:           APPEND FROM DBF("cursor_4c_TmpCaract")
5221:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.ColumnCount = 2
5222:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = "cursor_4c_Caract"
5223:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.ControlSource  = "cursor_4c_Caract.marcado"
5224:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.Header1.Caption = ""
5225:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.ControlSource  = "cursor_4c_Caract.descs"
5226:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.Header1.Caption = "Caracter" + CHR(237) + "stica"
5227:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Refresh()
5228:         ENDIF
5229:         USE IN cursor_4c_TmpCaract
5230:       ENDIF
5231:     CATCH TO loc_oErro
5232:       *-- INTENCIONAL: caracteristicas nao disponiveis para o produto; grid permanece vazio sem dialog
5233:     ENDTRY
5234:   ENDPROC
5235: 
5236:   *------------------------------------------------------------
5237:   *-- CarregarTiposOperacao: carrega grid de tipos de operacao
5238:   PROTECTED PROCEDURE CarregarTiposOperacao
5239:     LOCAL loc_cSQL, loc_nRet
5240:     TRY
5241:       loc_cSQL = "Select 0 as marcado, Codigos as ctipo, " + ;
5242:         "Descrs as dtipo From SigCdTom"
5243:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTOpe")
5244:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpTOpe")
5245:         IF USED("cursor_4c_TOpe")
5246:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = ""
5247:           SELECT cursor_4c_TOpe
5248:           SELECT cursor_4c_TOpe
5249:           ZAP
5250:           APPEND FROM DBF("cursor_4c_TmpTOpe")
5251:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.ColumnCount = 3
5252:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"
5253:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.ControlSource  = "cursor_4c_TOpe.marcado"
5254:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.Header1.Caption = ""
5255:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.ControlSource  = "cursor_4c_TOpe.ctipo"
5256:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.Header1.Caption = "C" + CHR(243) + "d"
5257:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.ControlSource  = "cursor_4c_TOpe.dtipo"
5258:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5259:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Refresh()
5260:         ENDIF
5261:         USE IN cursor_4c_TmpTOpe
5262:       ENDIF
5263:     CATCH TO loc_oErro
5264:       *-- INTENCIONAL: tipos de operacao nao disponiveis para o produto; grid permanece vazio sem dialog
5265:     ENDTRY
5266:   ENDPROC
5267: 
5268:   *------------------------------------------------------------
5269:   *-- MontaStrTpOpe: monta string IN para filtro de tipos de operacao
5270:   PROTECTED PROCEDURE MontaStrTpOpe
5271:     LOCAL loc_cResult
5272:     loc_cResult = ""
5273: 
5274:     IF !USED("cursor_4c_TOpe")
5275:       RETURN loc_cResult
5276:     ENDIF
5277: 
5278:     SELECT cursor_4c_TOpe
5279:     SCAN FOR cursor_4c_TOpe.marcado
5280:       IF !EMPTY(loc_cResult)
5281:         loc_cResult = loc_cResult + ","
5282:       ENDIF
5283:       loc_cResult = loc_cResult + "'" + ;
5284:         ALLTRIM(cursor_4c_TOpe.ctipo) + "'"
5285:     ENDSCAN
5286: 
5287:     RETURN loc_cResult
5288:   ENDPROC
5289: 
5290:   *------------------------------------------------------------
5291:   *-- CarregarComposicaoFiltro: carrega grid composicao do filtro
5292:   PROTECTED PROCEDURE CarregarComposicaoFiltro
5293:     LOCAL loc_cSQL, loc_nRet
5294: 
5295:     IF USED("CsMatPrima")
5296:       THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = ""
5297:       SELECT CsMatPrima
5298:       ZAP IN CsMatPrima
5299:     ENDIF
5300: 
5301:     TRY
5302:       loc_cSQL = "Select cpros as mats, dpros as dcompos, " + ;
5303:         "0.00 as qtd_inicial, 0.00 as qtd_final, " + ;
5304:         ".F. as apenas, cgrus as Cgrus, '' as Tipos " + ;
5305:         "From SigCdPro Where 1=0"
5306:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMat")
5307:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpMat")
5308:         USE IN cursor_4c_TmpMat
5309:       ENDIF
5310:     CATCH TO loc_oErro
5311:       *-- INTENCIONAL: SQLEXEC inicial pode falhar (estrutura cursor); CsMatPrima sera populado por consulta real
5312:     ENDTRY
5313: 
5314:     IF USED("CsMatPrima")
5315:       THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = "CsMatPrima"
5316:       THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.Refresh()
5317:     ENDIF
5318:   ENDPROC
5319: 
5320:   *------------------------------------------------------------
5321:   *-- LimparCamposCabecalho: limpa todos os campos de detalhe do produto
5322:   PROTECTED PROCEDURE LimparCamposCabecalho
5323:     LOCAL loc_oCab
5324: 
5325:     loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
5326: 

*-- Linhas 5478 a 5516:
5478:       RETURN
5479:     ENDIF
5480: 
5481:     SELECT CrProdutos
5482:     IF EOF()
5483:       MsgAviso("Nenhum produto selecionado.")
5484:       RETURN
5485:     ENDIF
5486: 
5487:     loc_cCodPro = ALLTRIM(CrProdutos.cpros)
5488:     IF EMPTY(loc_cCodPro)
5489:       MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o identificado.")
5490:       RETURN
5491:     ENDIF
5492: 
5493:     loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
5494: 
5495:     TRY
5496:       *-- Recarregar dados atuais do produto do banco para nao perder campos nao editaveis
5497:       loc_cSQL = "SELECT dpros, cgrus, sgrus, cunis, ifors, reffs, " + ;
5498:         "pcuss, moecs, pesoms, fcustos, margems, pvens, valors " + ;
5499:         "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)
5500: 
5501:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSalvar")
5502: 
5503:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpSalvar") AND !EOF("cursor_4c_TmpSalvar")
5504:         GO TOP IN cursor_4c_TmpSalvar
5505: 
5506:         THIS.this_oBusinessObject.this_cCodPro        = loc_cCodPro
5507:         THIS.this_oBusinessObject.this_cDescPro       = ALLTRIM(NVL(cursor_4c_TmpSalvar.dpros,   ""))
5508:         THIS.this_oBusinessObject.this_cGrupoPro      = ALLTRIM(NVL(cursor_4c_TmpSalvar.cgrus,   ""))
5509:         THIS.this_oBusinessObject.this_cSubGrupoPro   = ALLTRIM(NVL(cursor_4c_TmpSalvar.sgrus,   ""))
5510:         THIS.this_oBusinessObject.this_cUnidadePro    = ALLTRIM(NVL(cursor_4c_TmpSalvar.cunis,   ""))
5511:         THIS.this_oBusinessObject.this_cFornecedorPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.ifors,   ""))
5512:         THIS.this_oBusinessObject.this_cRefPro        = ALLTRIM(NVL(cursor_4c_TmpSalvar.reffs,   ""))
5513:         THIS.this_oBusinessObject.this_nPrecoCusto    = NVL(cursor_4c_TmpSalvar.pcuss,   0)
5514:         THIS.this_oBusinessObject.this_cMoedaCustoPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.moecs,   ""))
5515:         THIS.this_oBusinessObject.this_nMargem        = NVL(cursor_4c_TmpSalvar.margems, 0)
5516:         THIS.this_oBusinessObject.this_nCustoEstimado = NVL(cursor_4c_TmpSalvar.valors,  0)


### BO (C:\4c\projeto\app\classes\sigopcgpBO.prg):
*==============================================================================
* sigopcgpBO.prg - Business Object para Consulta Global de Produtos
* Origem: SIGOPCGP.SCX
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta/relatorio - nao eh CRUD de tabela unica)
*==============================================================================

DEFINE CLASS sigopcgpBO AS BusinessBase

    *-- Controle de fluxo (equivalentes as propriedades/vars do form legado)
    this_lConsultaExecutada = .F.   && ConsultaExecutada - evita reprocessar a mesma consulta
    this_cProdutoAtual      = ""    && _Produto - produto corrente (crTSigPro.cpros) na Pagina Resultado
    this_lAlteraPreco       = .F.   && ThisForm.AlteraPreco - fluxo de alteracao de preco (Do Form SigCdPro)
    this_lPrEca             = .F.   && par_prEca recebido no Init do form legado (fluxo iniciado por outra tela)
    this_nTpCalcp           = 0     && ThisForm.Tpcalcp - tipo de calculo de preco em uso
    this_cComposiciona      = ""    && ThisForm.Composiciona - grupo de composicao corrente
    this_lRetornoCj         = .F.   && ThisForm.RetornoCj - retorno do dialogo de conjuge (Do Form SigOpCcj)
    this_cEmpOperas         = ""    && ThisForm.EmpOperas - empresa selecionada para a faixa de operacao
    this_lUsuarioRestrito   = .F.   && ThisForm.llUser - restringe edicao de imagem/preco por tipo de usuario

    *-- Filtro: Produto (faixa de codigo + descricoes)
    this_cProdutoInicial = ""    && Get_produto_inicial - SigCdPro.cpros (faixa - inicio)
    this_cProdutoFinal   = ""    && Get_produto_final   - SigCdPro.cpros (faixa - fim)
    this_cDescricao      = ""    && Get_descricao       - SigCdPro.dpros (contem)
    this_cDescritivo     = ""    && Get_Descritivo      - SigCdPro.descritivo (contem)
    this_cDCompl         = ""    && Get_DCompl          - descricao completa (contem)
    this_cEquivalente    = ""    && getEquivalente      - SigCdPro.cpros do produto equivalente
    this_nBarra          = 0     && Get_Barra           - codigo de barras (SigCdPro.cbars)
    this_lEquivalentes   = .F.   && chkEquivalentes     - .T. = inclui produtos equivalentes na busca

    *-- Filtro: Grupo / Subgrupo / Grande Grupo / Linha / Colecao
    this_cCdGrupo    = ""    && get_cd_grupo  - SigCdGrp.cgrus
    this_cDsGrupo    = ""    && get_ds_grupo  - SigCdGrp.dgrus (preenchido pelo lookup)
    this_cCdSGrupo   = ""    && get_cd_sgrupo - SigCdPsg.codigos (subgrupo do grupo acima)
    this_cDsSGrupo   = ""    && get_ds_sgrupo - SigCdPsg.descricaos (preenchido pelo lookup)
    this_cGde        = ""    && Get_gde       - SigCdGpr.codigos (grande grupo)
    this_cLinhaI     = ""    && GetLin        - SigCdLin.linhas (faixa - inicio)
    this_cLinhaF     = ""    && GetLin2       - SigCdLin.linhas (faixa - fim)
    this_cColecaoI   = ""    && GetCol        - SigCdCol.colecoes (faixa - inicio)
    this_cColecaoF   = ""    && GetCol1       - SigCdCol.colecoes (faixa - fim)

    *-- Filtro: Peso / Cor / Tamanho / Dimensoes
    this_nPesoInicial = 0     && get_peso_inicial - SigCdPro.pesoms (faixa - inicio)
    this_nPesoFinal   = 0     && get_peso_final   - SigCdPro.pesoms (faixa - fim)
    this_cCor         = ""    && getCor      - SigCdCor.cods
    this_cDCor        = ""    && Get_dCor    - SigCdCor.descs (preenchido pelo lookup)
    this_cTam         = ""    && getTam      - SigCdTam.cods
    this_cDTam        = ""    && get_dTam    - SigCdTam.descs (preenchido pelo lookup)
    this_nTamProf     = 0     && get_tamps   - dimensao: profundidade
    this_nTamAlt      = 0     && get_tamas   - dimensao: altura
    this_nTamComp     = 0     && get_tamcs   - dimensao: comprimento

    *-- Filtro: Categoria / Conjunto (codigo pai) / Classificacao / Modelo / Faixa de Valor
    this_cCategoria   = ""    && getCategoria   - SigCdCtg.cods
    this_cDCategoria  = ""    && getDCategoria  - SigCdCtg.descs (preenchido pelo lookup)
    this_cConjunto    = ""    && getConjunto    - codigo pai (SigCdPro.conjunts)
    this_cClasse      = ""    && get_cClass     - SigCdCls.cods
    this_cCodFinPI    = ""    && getCodFinP     - SigCdFip.cods (Modelo, faixa - inicio)
    this_cCodFinPF    = ""    && getCodFinPF    - SigCdFip.cods (Modelo, faixa - fim)
    this_cFxPreco     = ""    && getFxPreco     - SigCdPpc/SigCdPpi (faixa de valor do grupo)
    this_cLocais      = ""    && getLocals      - localizacao do produto
    this_cCodMacro    = ""    && getCodMacro    - codigo macro do produto

    *-- Filtro: CPF/CGC, Situacao, Imagem, Web
    this_cCPF          = ""    && Get_CPF   - CPF/CGC do cliente/fornecedor (faixa de operacao)
    this_cSituacao     = ""    && cmbSituas  - situacao do produto (RowSource)
    this_cImagem       = ""    && cmbImagem  - filtro por presenca de imagem (RowSource)
    this_nProdutoWeb   = 0     && optWebs    - indice do OptionGroup (5 opcoes) - produto web
    this_lOff          = .F.   && chkOff     - produto fora de linha / inativo no site

    *-- Filtro: Fornecedor / Referencia / Lista de Precos / Promocao
    this_cCdFornecedor   = ""    && get_cd_fornecedor  - SigCdCli.iclis (fAcessoContas)
    this_cDsFornecedor   = ""    && get_ds_fornecedor  - SigCdCli.rclis (preenchido pelo lookup)
    this_cRefFornecedor  = ""    && get_ref_fornecedor - SigCdPro.reffs (faixa - inicio)
    this_cRefFornecedorF = ""    && Get_ReffsF         - SigCdPro.reffs (faixa - fim)
    this_nTpReffs        = 0     && Opt_TpReffs        - indice do OptionGroup (3 opcoes)
    this_cLista          = ""    && Get_Lista          - SigCdLpc.lprecos
    this_cPromo          = ""    && get_promo          - SigPrPmc.promos

    *-- Filtro: Faixas de valor (custo / estimado / venda) + moeda
    this_nCustoInicial    = 0     && get_custo_inicial    - faixa de custo (inicio)
    this_nCustoFinal      = 0     && get_custo_final      - faixa de custo (fim)
    this_cMoeCusto        = ""    && get_moe_custo        - SigCdMoe.cmoes
    this_nEstimadoInicial = 0     && get_estimado_inicial - faixa de valor estimado (inicio)
    this_nEstimadoFinal   = 0     && get_estimado_final   - faixa de valor estimado (fim)
    this_cMoeEstimado     = ""    && get_moe_estimado     - SigCdMoe.cmoes
    this_nVendaInicial    = 0     && get_venda_inicial    - faixa de preco de venda (inicio)
    this_nVendaFinal      = 0     && get_venda_final      - faixa de preco de venda (fim)
    this_cMoeVenda        = ""    && get_moe_venda        - SigCdMoe.cmoes

    *-- Filtro: Empresa / Operacao / Periodo
    this_cEmpresa      = ""    && getEmps    - SigCdEmp.cemps
    this_cDEmpresa     = ""    && getDEmps   - SigCdEmp.razas (preenchido pelo lookup)
    this_cEmpresaOpe   = ""    && getEmpsO   - SigCdEmp.cemps (faixa de operacao)
    this_cOperacaoI    = ""    && Get_Operacaoi - SigCdOpe.dopes (faixa - inicio)
    this_cOperacaoF    = ""    && Get_Operacao  - SigCdOpe.dopes (faixa - fim)
    this_nTipoOperacao = 0     && OptOperacao   - indice do OptionGroup (3 opcoes)
    this_nTipoData     = 0     && OptTpData     - indice do OptionGroup (2 opcoes) - Dt. Operacao / Dt. Cadastro
    this_nTipoDataCad  = 0     && OptTpDtCad    - indice do OptionGroup (2 opcoes) - Inclusao / Alteracao
    this_nFormaPagto   = 0     && OptPagamento  - indice do OptionGroup (3 opcoes)
    this_lMarcaTOpe    = .F.   && ck_MarcaTOpe  - marca/desmarca todos os tipos de operacao da grade
    this_dDtOperacaoI  = {}    && get_dt_inicial - faixa de data de operacao (inicio)
    this_dDtOperacaoF  = {}    && get_dt_final   - faixa de data de operacao (fim)
    this_dDtAlteracaoI = {}    && getDtAltI      - faixa de data de alteracao (inicio)
    this_dDtAlteracaoF = {}    && getDtAltF      - faixa de data de alteracao (fim)

    *-- Filtro: Grupo/Conta Contabil (C.C. relacionado) e Conta de Origem/Destino do movimento
    this_cCdGrupoContab = ""    && get_Grupo   - SigCdCrg.ccargs (fAcessoContab)
    this_cDsGrupoContab = ""    && get_NGrupo  - descricao do grupo contabil (preenchido pelo lookup)
    this_cConta         = ""    && Get_Conta   - SigCdCli.iclis (fAcessoContas)
    this_cDConta        = ""    && Get_NConta  - SigCdCli.rclis (preenchido pelo lookup)
    this_cContaO        = ""    && get_ContaO  - SigCdCli.iclis (conta de origem/destino do movimento)
    this_cDContaO       = ""    && get_NContaO - SigCdCli.rclis (preenchido pelo lookup)

    *--------------------------------------------------------------------------
    * Init - este BO eh de CONSULTA customizada (SigOpCgp nao eh cadastro CRUD
    * de uma tabela so, e sim um painel que cruza SigCdPro com dezenas de
    * tabelas de apoio). this_cTabela/this_cCampoChave ficam com a entidade
    * central da consulta (Produtos), mas NAO sao passados a DODEFAULT():
    * BusinessBase.Init(pcTabela) so instanciaria um DataAccess generico sobre
    * SigCdPro, que este BO nao usa (as consultas sao todas via SQLEXEC).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o produto corrente a partir do cursor que
    * alimenta a grade de resultados (CrTSigPro/CrProdutos no legado). Este BO
    * eh de CONSULTA (SigOpCgp cruza SigCdPro com dezenas de tabelas de apoio
    * via SQLEXEC proprios de cada aba de resultado) - nao ha gravacao de
    * registro aqui, so o rastreio de qual produto esta em foco.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE("cpros") != "U"
            THIS.this_cProdutoAtual = TratarNulo(cpros, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SigOpCgp eh consulta sobre SigCdPro; a chave do
    * registro em foco (usada so se algum fluxo chegar a chamar
    * RegistrarAuditoria) eh o codigo do produto corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cProdutoAtual
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - SigOpCgp eh form de CONSULTA
    * (Consulta Global de Produtos): nenhum botao do legado grava SigCdPro por
    * aqui - alteracao e inclusao de produto abrem Do Form SigCdPro (FormProduto,
    * via BtnCadastroAlterar/btnProduto). A unica gravacao vista no dump
    * (Update SigCdPrf Set Obs em Pag_Resultado.Result.Fase.Get_Obs.LostFocus)
    * eh a observacao de fase de producao, que pertence ao metodo da propria
    * grade/aba Fase (fases seguintes desta migracao), nao a este trio. O
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para este BO.
    *--------------------------------------------------------------------------

ENDDEFINE

