# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, 0, GRUPOS, CONTAS, DATAS, MARCA, VENDAS, CALCFECS, RELFECHAS, COPERS, NOTAS, USUARS, OPERADORS, EMPDOPNUMS, ICLIS, DFPAGS, DEACRS, LNOPTCOL, LNOPTMOV, CAIXAS, TPS, RELFECHGRS, 1, NUMS, CODIGOS, DOPES, DTENTS, USUARIOS, ORDENS, TIPOS, UMOVS, DT_DEPOSIT, TOTBCO, TTOTBCO, LNCTMCCR, RESVDETS, LCUSERDOPES, NTPIMPRES, USUACESS, CIMPS, I, LNIMPRESS, LNVEZ, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, 0, GRUPOS, CONTAS, DATAS, MARCA, VENDAS, CALCFECS, RELFECHAS, COPERS, NOTAS, USUARS, OPERADORS, EMPDOPNUMS, ICLIS, DFPAGS, DEACRS, LNOPTCOL, LNOPTMOV, CAIXAS, TPS, RELFECHGRS, 1, NUMS, CODIGOS, DOPES, DTENTS, USUARIOS, ORDENS, TIPOS, UMOVS, DT_DEPOSIT, TOTBCO, TTOTBCO, LNCTMCCR, RESVDETS, LCUSERDOPES, NTPIMPRES, USUACESS, CIMPS, I, LNIMPRESS, LNVEZ, FPAGS

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
  ControlSource = "m.reslanca"
  ControlSource = "m.resforma"
  ControlSource = "m.rescheque"
  ControlSource = "m.rescartao"
  ControlSource = "m.resvende"
  ControlSource = "m.resconta"
  ControlSource = "m.reslanfor"
  ControlSource = "m.resqtdes"
  ControlSource = "m.resvdets"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (Space(40),_Tipo,_Usuario,_Datas)
			Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (Space(40),_Tipo,_Usuario,_Datas)
			Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (_Linha,_Tipo,_Usuario,_Datas)
			Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (Replicate('=',ThisForm.MaxCols),_Tipo,_Usuario,_Datas)
	lcNmEmpresa = Iif(!Empty(lcEmpresa),lcEmpresa + ' - ' + Iif(Seek(lcEmpresa,'CrSigCdEmp','Cemps'),CrSigCdEmp.razas,''),[TODAS AS EMPRESAS])
	Insert Into dbCabecalho (nomeempresa,titulo,periodo,usuario,tipo) ;
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.*,99999999999999.99 As valoavs,999999999.99 As devols,']+;
			[From SigMvPar a Where 0 = 1 ],'Parcela')
Select Parcela
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select Top 1 Emps, Datas, Saldos, CidChaves From SigMvCcr ]+;
Select TmpMccr
Select cs_SigCdTom
Select CrSigCdOpe
	=Seek(CrSigCdOpe.TipoOps,'cs_SigCdTom','Codigos')
	lcSql = [Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos,]+;
			[notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEest')
	Select CsEest
		Select TmpUsuarios
			Insert Into TmpUsuarios (usuarios) Values (m.usuars)
		Select Vendas
		If !Seek(m.usuars + CrSigCdOpe.dopes)
		lcSql = [Select a.cotfpgs, a.Dopes, a.Datas, a.Vencs, a.Fpags, a.Moefpgs, a.Valos, b.Acumulas, c.ChkPagos, a.cnIdTefs ]+;
				[From SigMvPar a, SigOpFp b, SigMvCab c ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'TmpPar')
		Select TmpPar
			Select Parcela
			=Seek(TmpPar.dopes,'CrSigCdOpe','Dopes')
			=Seek(TmpPar.fpags,'CrSigOpFp','FPags')
			Select CrSigOpFp
			Select Parcela
				lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a ]+;
							[Left Join SigCdCrg b On b.ccargs = a.ccargs ]+;
				Select TmpCli
				Select Comissao
					If !Seek(m.usuars + CrSigOpFp.dcarts + TmpPar.cnIdTefs,'CsCartaos','IdCart')
						Insert Into CsCartaos (cusuarios,cdcarts,cnIdTefs) Values (m.usuars,CrSigOpFp.dcarts,TmpPar.CnIdTefs)
					If !Seek(m.usuars + CrSigOpFp.dcarts,'CsCartaos','IdCart')
						Insert Into CsCartaos (cusuarios,cdcarts) Values (m.usuars,CrSigOpFp.dcarts)
				Select CsCartaos
			If !Seek(m.usuars + TmpPar.dopes + _Forma,'LancFor','DopPag')
				Insert Into LancFor (dopes,forma,usuars) Values (TmpPar.dopes,_Forma,m.usuars)
			Select TmpPar
			Select CsEest
			Insert Into dbRelIni (emps,numes,dopes,datas,notas,totas,conta,obses,vends,usuars,det,Abrevs,nPedClis) ;
		Select Comissao
		Select CsEest
		lcSql = [Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars ]+;
				[From SigMvCab a, SigMvItn b ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEesti')
		Select CsEesti
			Select TmpUsuarios
				Insert Into TmpUsuarios (usuarios) Values (m.usuars)
			Select VdaEesti
			If !Seek(m.usuars + CrSigCdOpe.dopes)
			Select CsEesti
	Select CrSigCdOpe
Select dbRelIni
Select CrSigCdOpe
	=Seek(CrSigCdOpe.TipoOps,'cs_SigCdTom','Codigos')
	lcSql = [Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos,]+;
			[notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEest')
	Select CsEest
		Select TmpUsuarios
			Insert Into TmpUsuarios (Usuarios) Values (m.usuars)
		Select EntCai
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select dopes,datas,vencs,fpags,moefpgs,cotfpgs,valos ]+;
					[From SigMvPar ]+;
		Select TmpPar
			Select Parcela
			=Seek(TmpPar.dopes,'CrSigCdOpe','Dopes')
			=Seek(TmpPar.fpags,'CrSigOpFp','FPags')
			Select CrSigOpFp
			Select Parcela
				lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a ]+;
							[Left Join SigCdCrg b On b.ccargs = a.ccargs ]+;
				Select TmpCli
				Select Comissao
			If !Seek(TmpPar.dopes + _Forma,'LancFor','DopPag')
				Insert Into LancFor (dopes,forma) ;
			Select TmpPar
		Select Comissao
		Select CsEest
		lcSql = [Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars ]+;
				[From SigMvCab a, SigMvItn b ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEesti')
		Select CsEesti
			Select TmpUsuarios
				Insert Into TmpUsuarios (Usuarios) Values (m.usuars)
			Select EntEesti
	Select CrSigCdOpe
Select CrSigCdOpe
	=Seek(CrSigCdOpe.TipoOps,'cs_SigCdTom','Codigos')
	lcSql = [Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos,]+;
			[notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEest')
	Select CsEest
		Select TmpUsuarios
			Insert Into TmpUsuarios (usuarios) Values (m.usuars)
		Select SaiCai
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select dopes,datas,vencs,fpags,moefpgs,cotfpgs,valos ]+;
					[From SigMvPar ]+;
		Select TmpPar
			Select Parcela
			=Seek(TmpPar.dopes,'CrSigCdOpe','Dopes')
			=Seek(TmpPar.fpags,'CrSigOpFp','FPags')
			Select CrSigOpFp
			Select Parcela
			Select Parcela
				lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a ]+;
							[Left Join SigCdCrg b On b.ccargs = a.ccargs ]+;
				Select TmpCli
				Select Comissao
			If !Seek(TmpPar.dopes + _Forma,'LancFor','DopPag')
				Insert Into LancFor (dopes,forma) ;
			Select TmpPar
		Select Comissao
		Select CsEest
		lcSql = [Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars ]+;
				[From SigMvCab a, SigMvItn b ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEesti')
		Select CsEesti
			Select TmpUsuarios
				Insert Into TmpUsuarios (usuarios) Values (m.usuars)
			Select SaiEesti
			Select CsEesti
	Select CrSigCdOpe
Select CrSigCdOpe
	=Seek(CrSigCdOpe.TipoOps,'cs_SigCdTom','Codigos')
	lcSql = [Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos,]+;
			[notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEest')
	Select CsEest
		Select TmpUsuarios
			Insert Into TmpUsuarios (Usuarios) Values (m.usuars)
		Select DevCai
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select dopes,datas,vencs,fpags,moefpgs,cotfpgs,valos ]+;
					[From SigMvPar ]+;
		Select TmpPar
			Select Parcela
			=Seek(TmpPar.dopes,'CrSigCdOpe','Dopes')
			=Seek(TmpPar.fpags,'CrSigOpFp','FPags')
			Select CrSigOpFp
			Select Parcela
				lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a ]+;
							[Left Join SigCdCrg b On b.ccargs = a.ccargs ]+;
				Select TmpCli
				Select Comissao
			If !Seek(m.usuars + TmpPar.dopes + _Forma,'LancFor','DopPag')
				Insert Into LancFor (dopes,forma,usuars) ;
			Select TmpPar
		Select Comissao
		Select CsEest
		lcSql = [Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars ]+;
				[From SigMvCab a, SigMvItn b ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'CsEesti')
		Select CsEesti
			Select TmpUsuarios
				Insert Into TmpUsuarios (Usuarios) Values (m.usuars)
			Select DevEesti
			Select CsEesti
	Select CrSigCdOpe
Select TmpUsuarios
	loBarraRes.Update(.T.)
	=Seek(lcEmpresa,'CrSigCdEmp','Cemps')
		Select Vendas
		Select EntCai
		Select DevCai
		Select SaiCai
		Select 'Vendas' As tps,* From vendas ;
		Select 'EntCai' As tps,* From EntCai ;
		Select 'SaiCai' As tps,* From SaiCai ;
		Select tps,usuars,tipoops,dopes,relfechgrs,Sum(totas) As totals ;
		From CsResLan ;
		Select Count(1) As totitens,tps,usuars,relfechgrs,Sum(totals) As totgeral;
		From CsItem ;
		Select CsCab
			Select CsItem
				=Seek(CsItem.dopes,'CrSigCdOpe','Dopes')
			Select CsCab
		Select CsCab
		Select VdaEesti
		Select EntEesti
		Select DevEesti
		Select SaiEesti
		Select 'Vendas' As tps,* From VdaEesti ;
		Select 'EntCai' As tps,* From EntEesti ;
		Select 'SaiCai' As tps,* From SaiEesti ;
		Select 'DevCai' As tps,* From DevEesti ;
		Select tps,usuars,tipoops,dopes,relfechgrs,Sum(totas) As totals,Sum(qtds) As qtds ;
		From CsResQtde ;
		Select Count(1) As totitens,tps,usuars,relfechgrs,Sum(totals) As totgeral,Sum(qtds) As qtdgeral ;
		From CsItemQt ;
		Select CsCabQtde
			Select CsItemQt
				=Seek(CsItemQt.dopes,'CrSigCdOpe','Dopes')
			Select CsCabQtde
		Select CsCabQtde
		Select Parcela 
		Select Parcela
			=Seek(Parcela.fpags,'crSigOpFp','FPags')
		Select usuars,dopes From Vendas Where usuars = TmpUsuarios.usuarios ;
		Select usuars,dopes From EntCai Where usuars = TmpUsuarios.usuarios ;
		Select usuars,dopes From SaiCai Where usuars = TmpUsuarios.usuarios ;
		Select usuars,dopes From DevCai Where usuars = TmpUsuarios.usuarios ;
		Select ImpLanFor
				Select LancFor
				=Seek(ImpLanFor.usuars + ImpLanFor.dopes)
				Select ImpLanFor
			lcSql = [Select a.ncheques,a.vencs,a.umovs,a.valors,b.codigos,c.tipos,b.usuarios,b.dopes,a.Nums, a.Iclis, d.Rclis, o.RelFechas ]+;
					  [From SigChe a, SigCqChm b, SigCdOpt c, SigCdCli d, SigCdOpe o ]+;
					[ And a.Nums in (Select distinct a.Nums From SigCqChm a, SigCdOpt b where a.codigos=b.operacaos ]+;
			lcSql = [Select a.ncheques,a.vencs,a.umovs,a.valors,b.codigos,c.tipos,b.usuarios,b.dopes,a.Nums, a.Iclis, o.RelFechas ]+;
					  [From SigChe a, SigCqChm b, SigCdOpt c, SigMvCab d, SigCdCli E, SigCdOpe o ]+;
						   [ And a.Nums in (Select distinct a.Nums From SigCqChm a, SigCdOpt b where a.codigos=b.operacaos ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'TmpCheb')
		Delete From TmpCheb Where Not Relfechas = Iif(ThisForm.Segunda, 3, 1)	
		Select TmpCheb
			Select TmpCheb
			Select Sum(valors) As totchq,codigos From TmpCheb Group By codigos Into Cursor TmpChe
			Select TmpChe
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select operacaos,tipos From SigCdOpt Where tipos = 'DB'],'TmpOper')
			Select c.Tipos,Sum(valors) As aberto ;
			From TmpCheb a, TmpOper c ;
			Select TmpChea
			Select TmpCheb
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select Sum(valos) As totcar ]+;
						[From SigCdCtt ]+;
			Select TmpCar
		Select CsCartaos
		Select Comissao
		Select ComiComp
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.moedas,a.grupos,a.contas,a.datas,a.hists,a.docus,]+;
						[From SigMvCcr a ]+;
			Select TmpMccr
	Select TmpUsuarios
	Select dbRelIni
Select &lcArq.
Select dbRelIni
		=Seek(dbRelIni.dopes,'CrSigCdOpe','dopes')
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcCabecalho,1,dbRelIni.usuars,ldRelIni)
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcCabecalho,1,dbRelIni.usuars,ldRelIni)
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcCabecalho,1,dbRelIni.usuars,ldRelIni)
	Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcDetalhe,1,dbRelIni.usuars,ldRelIni)
		lcQuery = [Select Codbarras, CPros, DPros, Opers, Totas ] + ;
				    [From SigMvItn ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalItems]) < 1)
		Select LocalItems
			Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcDetalhe,1,dbRelIni.usuars,ldRelIni)
		lcQuery = [Select FPags, Sum(Valos) as Valos, TParcs ] + ;
				    [From SigMvPar ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalItems]) < 1)
		Select LocalItems
			Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcDetalhe,1,dbRelIni.usuars,ldRelIni)
	Select dbRelIni
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcDetalhe,1,dbRelIni.usuars,ldRelIni)
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcDetalhe,1,dbRelIni.usuars,ldRelIni)
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (Space(80),1,dbRelIni.usuars,ldRelIni)
Select &lcArq.
Select dbRelIni
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcCabecalho,1,dbRelIni.usuars,ldRelIni)
		Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcCabecalho,1,dbRelIni.usuars,ldRelIni)
	Insert Into &lcArq. (detalhe,tipo,usuars,datas) Values (lcDetalhe,1,dbRelIni.usuars,ldRelIni)
	Select dbRelIni
Select &lcArq.
	lcSQLCmd = [Select * From SigCdmp ] + ;
	lnSQLErr = ThisForm.Podatamgr.SQLExecute(lcSQLCmd, 'Tmp1')
	Select *, llFlags as lMarcas, llFlags as lSituas ;
	  From Tmp1 ;
	Select csSigCdmp
	lcSql = [Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = ']+Usuar+[' And a.cImps = b.Impres And b.nTpImpres = ?pTip ]+;
			[Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios=']+Usuar+[' ]+;
	If ThisForm.Podatamgr.sqlexecute(lcSql,'CrTmpCimp') <= 0
	Select CrTmpCimp
		Select Impres From CrTmpCimp Into Cursor LocalcImp Group by Impres ReadWrite
		Select *, llFlags as lMarcas, llFlags as lSituas ;
		  From LocalcImp ;
		Select csSigCdmp
 		If Seek(lcImpres, 'csSigCdmp', 'Impres')
	 		Select csSigCdmp
	Select csSigCdmp
	Select dbRelatorio
		lnQueryOk = ThisForm.podataMgr.SqlExecute([Select * From SigCdPam ],'CrSigCdPam')
		lnQueryOk = ThisForm.podataMgr.SqlExecute([Select * From SigCdPac ],'CrSigCdPac')
		Select CrSigCdPam
		Select CrSigCdPac
		lnQueryOk = ThisForm.podataMgr.SqlExecute([Select cemps,razas From SigCdEmp ],'CrSigCdEmp')
		Select CrSigCdEmp
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdMoe ],'CrSigCdMoe')
		Select CrSigCdMoe
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot')
		Select CrSigCdCot
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select dopes,ordes,vendas,dfpags,opcrs,nopcrs,deacrs,vars,caixas,copers,cmoes,]+;
					[From SigCdOpe ],'CrSigCdOpe')
		Select CrSigCdOpe
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigOpFp ],'CrSigOpFp')
		Select CrSigOpFp
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdmp Where ntpimpres <> 2 ],'CrSigCdmp')
		Select CrSigCdmp
		lcSQLCmd = [Select Codigos, Descrs From SigCdTom]
		If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, 'crSigCdTom') < 1)
		Select crSigCdTom
			Insert Into Cs_SigCdTom (Marca,Codigos,Descri) ;
		Select cs_SigCdTom
	Select * From dbTmpRel ;
	Select * From dbTmpRel2 ;
		Select * From dbTmpRel ;
		Select * From dbTmpRel2 ;
			loBarraDias.Update(.T.,'Dia : ' + Dtoc(ldDtProc))
				Select * From dbTmpRel ;
				Select * From dbTmpRel2 ;
				Select dbTmpRel
					Insert Into dbRelatorio From MemVar
					Select dbTmpRel
				Select dbTmpRel2
					Insert Into dbRelatorio From MemVar
					Select dbTmpRel2
Select dbRelatorio
lcQuery = [Select Usuarios From SigCdUsu]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crListaRemota1') < 1)
Select Usuarios ;
  From crListaRemota1 ;
Select crListaRemota
	If Not Seek(Padr(This.Value, 10), 'crListaRemota', 'Usuarios')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefcx.prg) - TRECHOS RELEVANTES PARA PASS SQL (2043 linhas total):

*-- Linhas 64 a 82:
64: 
65:                 *-- Garante cs_SigCdTom para grid (BO popula com dados reais; placeholder aqui para UI validation)
66:                 IF !USED("cs_SigCdTom")
67:                     CREATE CURSOR cs_SigCdTom (Marca n(1), Descri c(40), Codigos n(2))
68:                     INDEX ON Codigos TAG Codigos
69:                 ENDIF
70: 
71:                 THIS.ConfigurarPaginaLista()
72: 
73:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
74:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
75:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
76:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
77: 
78:                 THIS.LimparCampos()
79:                 THIS.Visible = .T.
80:                 loc_lSucesso = .T.
81:             ENDIF
82:         CATCH TO loc_oErro

*-- Linhas 850 a 868:
850:             .Height        = 138
851:             .RecordSource  = "cs_SigCdTom"
852:             .ColumnCount   = 2
853:             .DeleteMark    = .F.
854:             .HeaderHeight  = 0
855:             .RecordMark    = .F.
856:             .RowHeight     = 18
857:             .ScrollBars    = 2
858:             .FontName      = "Tahoma"
859:             .FontSize      = 8
860:             .GridLineColor = RGB(238, 238, 238)
861:             .Visible       = .T.
862:         ENDWITH
863:         WITH loc_oPg.grd_4c_GrdTipo.Column1
864:             .Width     = 20
865:             .Alignment = 0
866:             .Sparse    = .F.
867:             .FontName  = "Tahoma"
868:             .FontSize  = 8

*-- Linhas 876 a 898:
876:                 .FontName  = "Tahoma"
877:             ENDWITH
878:             .CurrentControl = "chk_4c_GrdMarca"
879:             .ControlSource  = "cs_SigCdTom.Marca"
880:         ENDWITH
881:         WITH loc_oPg.grd_4c_GrdTipo.Column2
882:             .Width         = 215
883:             .ControlSource = "cs_SigCdTom.Descri"
884:             .ReadOnly      = .T.
885:             .FontName      = "Tahoma"
886:             .FontSize      = 8
887:             .Enabled       = .T.
888:         ENDWITH
889: 
890:         loc_oPg.AddObject("btn_4c_SelTudo", "CommandButton")
891:         WITH loc_oPg.btn_4c_SelTudo
892:             .Top         = 241
893:             .Left        = 657
894:             .Width       = 45
895:             .Height      = 45
896:             .Caption     = ""
897:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
898:             .ToolTipText = "Marcar"

*-- Linhas 1333 a 1351:
1333:             *-- OptCol a partir de SigCdPam.resimps (default 2 = 80 colunas)
1334:             loc_nOptCol = 2
1335:             IF USED("CrSigCdPam")
1336:                 SELECT CrSigCdPam
1337:                 GO TOP
1338:                 IF !EOF() AND TYPE("CrSigCdPam.resimps") != "U"
1339:                     IF INLIST(NVL(resimps, 0), 1, 2)
1340:                         loc_nOptCol = NVL(resimps, 2)
1341:                     ENDIF
1342:                 ENDIF
1343:             ENDIF
1344:             loc_oPg.opt_4c_OptCol.Value = loc_nOptCol
1345: 
1346:             loc_oPg.opt_4c_OptQuebra.Value = THIS.this_oRelatorio.this_nOptQuebra
1347:             loc_oPg.opt_4c_ImpNomCli.Value = THIS.this_oRelatorio.this_nOptImpNomCli
1348:             loc_oPg.opt_4c_OpcTipo.Value   = THIS.this_oRelatorio.this_nOpcTipo
1349:             loc_oPg.opt_4c_OptMov.Value    = THIS.this_oRelatorio.this_nOptMov
1350:             loc_oPg.opt_4c_NrOpcao.Value   = THIS.this_oRelatorio.this_nOptNrOpcao
1351: 

*-- Linhas 1510 a 1541:
1510:     PROCEDURE BtnSelTudoClick()
1511:         TRY
1512:             IF USED("cs_SigCdTom")
1513:                 SELECT cs_SigCdTom
1514:                 REPLACE ALL Marca WITH 1
1515:                 GO TOP
1516:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
1517:             ENDIF
1518:         CATCH TO loc_oErro
1519:             MsgErro(loc_oErro.Message, "BtnSelTudoClick")
1520:         ENDTRY
1521:     ENDPROC
1522: 
1523:     PROCEDURE BtnApagaClick()
1524:         TRY
1525:             IF USED("cs_SigCdTom")
1526:                 SELECT cs_SigCdTom
1527:                 REPLACE ALL Marca WITH 0
1528:                 GO TOP
1529:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
1530:             ENDIF
1531:         CATCH TO loc_oErro
1532:             MsgErro(loc_oErro.Message, "BtnApagaClick")
1533:         ENDTRY
1534:     ENDPROC
1535: 
1536:     *==========================================================================
1537:     * HANDLERS DE TECLADO (F4=115, ENTER=13, TAB=9)
1538:     *==========================================================================
1539: 
1540:     PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1541:         IF par_nKeyCode = 115

*-- Linhas 1689 a 1711:
1689:             loc_oPg.txt_4c_DsEmpresa.Value = ""
1690:             RETURN
1691:         ENDIF
1692:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1693:             EscaparSQL(loc_cValor)
1694:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1695:         IF loc_nResult > 0
1696:             SELECT cursor_4c_EmpVal
1697:             IF !EOF()
1698:                 loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1699:             ELSE
1700:                 loc_oPg.txt_4c_DsEmpresa.Value = ""
1701:                 THIS.AbrirBuscaCdEmpresa()
1702:             ENDIF
1703:         ELSE
1704:             loc_oPg.txt_4c_DsEmpresa.Value = ""
1705:             THIS.AbrirBuscaCdEmpresa()
1706:         ENDIF
1707:         IF USED("cursor_4c_EmpVal")
1708:             USE IN cursor_4c_EmpVal
1709:         ENDIF
1710:     ENDPROC
1711: 

*-- Linhas 1717 a 1739:
1717:             loc_oPg.txt_4c_CdEmpresa.Value = ""
1718:             RETURN
1719:         ENDIF
1720:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1721:             EscaparSQL(loc_cValor + "%")
1722:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal2")
1723:         IF loc_nResult > 0
1724:             SELECT cursor_4c_EmpVal2
1725:             IF !EOF()
1726:                 loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Cemps)
1727:                 loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Razas)
1728:             ELSE
1729:                 THIS.AbrirBuscaDsEmpresa()
1730:             ENDIF
1731:         ELSE
1732:             THIS.AbrirBuscaDsEmpresa()
1733:         ENDIF
1734:         IF USED("cursor_4c_EmpVal2")
1735:             USE IN cursor_4c_EmpVal2
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *==========================================================================

*-- Linhas 1870 a 1923:
1870:         IF EMPTY(loc_cValor)
1871:             RETURN
1872:         ENDIF
1873:         loc_cSQL = "SELECT TOP 1 usuarios FROM SigCdUsu WHERE usuarios = " + ;
1874:             EscaparSQL(PADR(loc_cValor, 10))
1875:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
1876:         IF loc_nResult > 0
1877:             SELECT cursor_4c_UsuVal
1878:             IF EOF()
1879:                 loc_oPg.txt_4c_Usuario.Value = ""
1880:                 THIS.AbrirBuscaUsuario()
1881:             ENDIF
1882:         ELSE
1883:             loc_oPg.txt_4c_Usuario.Value = ""
1884:             THIS.AbrirBuscaUsuario()
1885:         ENDIF
1886:         IF USED("cursor_4c_UsuVal")
1887:             USE IN cursor_4c_UsuVal
1888:         ENDIF
1889:     ENDPROC
1890: 
1891:     *==========================================================================
1892:     * LOOKUP - OPERADOR (lista de usuarios com codigo numerico curto)
1893:     *==========================================================================
1894: 
1895:     PROCEDURE AbrirBuscaOperador()
1896:         LOCAL loc_cValor, loc_oPg, loc_nResult, loc_oBusca
1897:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
1898:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Operador.Value)
1899: 
1900:         loc_nResult = SQLEXEC(gnConnHandle, ;
1901:             "SELECT Usuarios FROM SigCdUsu " + ;
1902:             "WHERE LEN(RTRIM(Usuarios)) < 4 AND ISNUMERIC(Usuarios) = 1", ;
1903:             "cursor_4c_Operadores")
1904:         IF loc_nResult < 1
1905:             MsgErro("Falha ao carregar lista de operadores", "AbrirBuscaOperador")
1906:             RETURN
1907:         ENDIF
1908:         SELECT cursor_4c_Operadores
1909:         INDEX ON Usuarios TAG Usuarios
1910: 
1911:         IF EMPTY(loc_cValor) OR ;
1912:            !SEEK(PADR(loc_cValor, 10), "cursor_4c_Operadores", "Usuarios")
1913:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1914:                 "cursor_4c_Operadores", "cursor_4c_Operadores", "Usuarios", ;
1915:                 loc_cValor, "Operadores", .F., .T., "")
1916:             IF VARTYPE(loc_oBusca) = "O"
1917:                 loc_oBusca.mAddColuna("Usuarios", "", "Operadores")
1918:                 loc_oBusca.Show()
1919:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Operadores")
1920:                     loc_oPg.txt_4c_Operador.Value = ALLTRIM(cursor_4c_Operadores.Usuarios)
1921:                 ELSE
1922:                     loc_oPg.txt_4c_Operador.Value = ""
1923:                 ENDIF

