# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VALDESCS, VARPADS, IMPS, SISTEF, CNNSUS, CHEADERS, LCTIPO, FPAGS, DOPES, IF, MODPAGTO, FORMAS, ADQUIRENTE, BANDEIRA, FPARCS, PGTOINATIV, GRUPOEMP, MOEFPGS, SITUAS, EMPS, CAIXAS, TABDS, TPDESC, CDESC, OBRIGS, I, TROCOS, VLRFPGS, OPCRS, IMPBOLS, VALOS, EMPDOPNUMS, EMPDOPNCS, NUMS, FSIGOPFIN_ORP, _RECANT, CEMPS, TIPOS, LNVARS, PARAUTOS, VALSERVS, TIPOCADS, TPLECHQS, CCUPOMNVS, NUMOLDS, TPCHEQUES, LNCHQOPERS, EMPOS, NCARTS, OP_ESCOLHA, CNIDTEFS, CHKBLQBON, NPARCS, EMICHQS, VALUE, LNVALP, DESCS, PARCDES, GRUCONMOES, VALMAXS, LNTPAR, LNPARCS, INFOS, CARAUTS, OBS, AUTORIZA, NSU, LNFPAGOBRIGS, PESOVTS, VALITENS, ALTCOTS, CUPFIS, VARS, _VARIA, PVARIAS, TOTAL, LDOLDVCT, BLQVCTOPAR, FPAGSS, VALDEVS, VALENCS, USUALS, CONTABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VALDESCS, VARPADS, IMPS, SISTEF, CNNSUS, CHEADERS, LCTIPO, FPAGS, DOPES, IF, MODPAGTO, FORMAS, ADQUIRENTE, BANDEIRA, FPARCS, PGTOINATIV, GRUPOEMP, MOEFPGS, SITUAS, EMPS, CAIXAS, TABDS, TPDESC, CDESC, OBRIGS, I, TROCOS, VLRFPGS, OPCRS, IMPBOLS, VALOS, EMPDOPNUMS, EMPDOPNCS, NUMS, FSIGOPFIN_ORP, _RECANT, CEMPS, TIPOS, LNVARS, PARAUTOS, VALSERVS, TIPOCADS, TPLECHQS, CCUPOMNVS, NUMOLDS, TPCHEQUES, LNCHQOPERS, EMPOS, NCARTS, OP_ESCOLHA, CNIDTEFS, CHKBLQBON, NPARCS, EMICHQS, VALUE, LNVALP, DESCS, PARCDES, GRUCONMOES, VALMAXS, LNTPAR, LNPARCS, INFOS, CARAUTS, OBS, AUTORIZA, NSU, LNFPAGOBRIGS, PESOVTS, VALITENS, ALTCOTS, CUPFIS, VARS, _VARIA, PVARIAS, TOTAL, LDOLDVCT, BLQVCTOPAR, FPAGSS, VALDEVS, VALENCS, USUALS, CONTABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VALDESCS, VARPADS, IMPS, SISTEF, CNNSUS, CHEADERS, LCTIPO, FPAGS, DOPES, IF, MODPAGTO, FORMAS, ADQUIRENTE, BANDEIRA, FPARCS, PGTOINATIV, GRUPOEMP, MOEFPGS, SITUAS, EMPS, CAIXAS, TABDS, TPDESC, CDESC, OBRIGS, I, TROCOS, VLRFPGS, OPCRS, IMPBOLS, VALOS, EMPDOPNUMS, EMPDOPNCS, NUMS, FSIGOPFIN_ORP, _RECANT, CEMPS, TIPOS, LNVARS, PARAUTOS, VALSERVS, TIPOCADS, TPLECHQS, CCUPOMNVS, NUMOLDS, TPCHEQUES, LNCHQOPERS, EMPOS, NCARTS, OP_ESCOLHA, CNIDTEFS, CHKBLQBON, NPARCS, EMICHQS, VALUE, LNVALP, DESCS, PARCDES, GRUCONMOES, VALMAXS, LNTPAR, LNPARCS, INFOS, CARAUTS, OBS, AUTORIZA, NSU, LNFPAGOBRIGS, PESOVTS, VALITENS, ALTCOTS, CUPFIS, VARS, _VARIA, PVARIAS, TOTAL, LDOLDVCT, BLQVCTOPAR, FPAGSS, VALDEVS, VALENCS, USUALS, CONTABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NTOTAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VALDESCS, VARPADS, IMPS, SISTEF, CNNSUS, CHEADERS, LCTIPO, FPAGS, DOPES, IF, MODPAGTO, FORMAS, ADQUIRENTE, BANDEIRA, FPARCS, PGTOINATIV, GRUPOEMP, MOEFPGS, SITUAS, EMPS, CAIXAS, TABDS, TPDESC, CDESC, OBRIGS, I, TROCOS, VLRFPGS, OPCRS, IMPBOLS, VALOS, EMPDOPNUMS, EMPDOPNCS, NUMS, FSIGOPFIN_ORP, _RECANT, CEMPS, TIPOS, LNVARS, PARAUTOS, VALSERVS, TIPOCADS, TPLECHQS, CCUPOMNVS, NUMOLDS, TPCHEQUES, LNCHQOPERS, EMPOS, NCARTS, OP_ESCOLHA, CNIDTEFS, CHKBLQBON, NPARCS, EMICHQS, VALUE, LNVALP, DESCS, PARCDES, GRUCONMOES, VALMAXS, LNTPAR, LNPARCS, INFOS, CARAUTS, OBS, AUTORIZA, NSU, LNFPAGOBRIGS, PESOVTS, VALITENS, ALTCOTS, CUPFIS, VARS, _VARIA, PVARIAS, TOTAL, LDOLDVCT, BLQVCTOPAR, FPAGSS, VALDEVS, VALENCS, USUALS, CONTABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VALDESCS, VARPADS, IMPS, SISTEF, CNNSUS, CHEADERS, LCTIPO, FPAGS, DOPES, IF, MODPAGTO, FORMAS, ADQUIRENTE, BANDEIRA, FPARCS, PGTOINATIV, GRUPOEMP, MOEFPGS, SITUAS, EMPS, CAIXAS, TABDS, TPDESC, CDESC, OBRIGS, I, TROCOS, VLRFPGS, OPCRS, IMPBOLS, VALOS, EMPDOPNUMS, EMPDOPNCS, NUMS, FSIGOPFIN_ORP, _RECANT, CEMPS, TIPOS, LNVARS, PARAUTOS, VALSERVS, TIPOCADS, TPLECHQS, CCUPOMNVS, NUMOLDS, TPCHEQUES, LNCHQOPERS, EMPOS, NCARTS, OP_ESCOLHA, CNIDTEFS, CHKBLQBON, NPARCS, EMICHQS, VALUE, LNVALP, DESCS, PARCDES, GRUCONMOES, VALMAXS, LNTPAR, LNPARCS, INFOS, CARAUTS, OBS, AUTORIZA, NSU, LNFPAGOBRIGS, PESOVTS, VALITENS, ALTCOTS, CUPFIS, VARS, _VARIA, PVARIAS, TOTAL, LDOLDVCT, BLQVCTOPAR, FPAGSS, VALDEVS, VALENCS, USUALS, CONTABS

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
  ControlSource = "crSigCdEmp.Grupo"
  ControlSource = "xPar.NoCreditos"
  ControlSource = "xpar.numeros"
  ControlSource = "xpar.contas"
  ControlSource = "xpar.agencias"
  ControlSource = "xpar.bancos"
  ControlSource = "xpar.outros"
  ControlSource = "xPar.NoCreditos"
  ControlSource = "xpar.outros"
  ControlSource = "xpar.bancos"
  ControlSource = "xpar.agencias"
  ControlSource = "xpar.numeros"
  ControlSource = "xpar.contas"
  ControlSource = "xpar.ncarnes"
  ControlSource = "xPar.Obs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "TprMvCab.valservs"
  ControlSource = ""
  ControlSource = "TprMvCab.valos"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCab.VarTots"
  ControlSource = ""
  ControlSource = "TprMvCab.valinis"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCab.ValTrans"
  ControlSource = ""
  ControlSource = "xPar.Nsu"
  ControlSource = "xpar.autoriza"
  ControlSource = "xpar.adquirente"
  ControlSource = "xpar.nocreditos"
  ControlSource = "xpar.cartaos"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCab.ValUtiCsh"
Select xPar
	Select CrSigMvNfi
	Select FPags ;
	  From xPar ;
			lcQuery = [Select a.Fpags, a.Descrs, a.MoeFpgs, a.Fparcs, o.Obrigs, o.Dopes, a.cCupomNvs ] + ;
						[From SigOpFp a, SigOpFpo o ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalTmpFPag') < 1)
			Select Fpags, Descrs, MoeFpgs, Fparcs, Obrigs ;
			  From LocalTmpFpag ;
			Select LocalSigOpFp
				lcQuery = [Select Fpags, Descrs, MoeFpgs, Fparcs, 0 as Obrigs, cCupomNvs, Situas ] + ;
							[From SigOpFp ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalTmpFPag') < 1)
				Select Fpags, Descrs, MoeFpgs, Fparcs, Obrigs ;
				  From LocalTmpFpag ;
			Select LocalSigOpFp
Select xPar
	LcQuery = [Select a.Fpags,a.Descrs,a.MoeFpgs,a.Fparcs,o.Obrigs,o.Dopes,a.cCupomNvs, ]+;
			  [From SigOpFp a, SigOpFpo o ] + ;
	If Thisform.Parentform.PoDataMgr.SqlExecute(lcQuery,'CrTmpFpag') < 1
	Select Fpags, Descrs, MoeFpgs, Fparcs, Obrigs, Grupods, Contads, ValPends, AgCobs, OriDes, BlqTabDs, OpcSnas, bandeira, chkBlqBon ;
	From CrTmpFpag Where  ;
	Select LocalFpag
		LcQuery = [Select Fpags, Descrs, MoeFpgs, Fparcs, 0 as Obrigs, cCupomNvs, Situas, ]+;
				  [From SigOpFp ]+;
		If Thisform.Parentform.PoDataMgr.SqlExecute(lcQuery,'CrTmpFpag') < 1
		Select Fpags, Descrs, MoeFpgs, Fparcs, Obrigs, Grupods, Contads, ValPends, AgCobs, OriDes, BlqTabDs, OpcSnas, bandeira, chkBlqBon;
		From CrTmpFpag ;
	lcSql = [Select Distinct fpags From SigOpFpD Where Tabds = ']+TprMvCab.TabDs+[']
	If Thisform.parentform.PoDataMgr.SqlExecute(lcSql,'LocalFpagD') < 1
		Select a.* From LocalFpag a, LocalFpagD b Where Iif(InList(CrSigOpCdd.OpcSnas,1,2),a.OpcSnas = CrSigOpCdd.OpcSnas,;
		Select * From LocalFpag Where Iif(InList(CrSigOpCdd.OpcSnas,1,2),OpcSnas = CrSigOpCdd.OpcSnas,;
	select * from crSigMvItd where tpdesc = 2 into cursor crAux1
		lcSql = [Select codigos From SigOpTdt]
		If Thisform.parentform.PoDataMgr.SqlExecute(lcSql,'crTdt') < 1
		select * from crAux1 where cdesc in (select codigos from crTdt) into cursor crAux2
			DELETE from csSigopfp where fparcs<>1	&& mena - 27/06/2017 - à vista =  numero de parcelas = 1
	LcQuery = [Select Fpags, Descrs, MoeFpgs, Fparcs, 0 as Obrigs, BlqTabDs, bandeira, chkBlqBon ] + ;
				[From SigOpFp ]+;
	If Thisform.parentform.PoDataMgr.SqlExecute(lcQuery,'CsSigOpFp') < 1
Select csSigOpFp
Select xPar
	Select xPar
Select xPar
Select xPar
Select xPar
Select xPar
Delete
	Select xPar
								Select CrChm
			Select xPar
	lcUpDate = [UpDate SigMvCab Set Valos=]+Str(TprMvCab.valos,12,2)+[, Valinis=]+Str(TprMvCab.ValInis,12,2)+[, ]+;
	If Thisform.Parentform.poDataMgr.sqlexecute(lcUpDate,'') < 1
	Select xPar
		Select Distinct EmpDopNcs From CrTmpMccr Into Cursor CrMccr
		Select CrMccr
			lcDelete = [Delete From SigOpCoc Where EmpdopNcs = ']+CrMccr.EmpDopNcs+[']
			If (Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,' ') < 1)
				=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigOpCoc)')
		lcDelete = [Delete From SigMvCcr Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
		lcSql = [Select Distinct EmpDopNcs From SigMvCpv Where EmpDopNums = ']+lcPosicao+[']
		If Ret And (Thisform.Parentform.poDataMgr.sqlexecute(lcSql, 'crMccr') < 1)
			Select CrMccr
				lcDelete = [Delete From SigOpCoc Where EmpdopNcs = ']+CrMccr.EmpDopNcs+[']
				If (Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,' ') < 1)
					=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigOpCoc)')
		lcDelete = [Delete From SigMvCpv Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvCpv)')
		lcDelete = [Delete From SigMvPar Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPar)')
		lcDelete = [Delete From SigCdCmm Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCmm)')
		lcDelete = [Delete From SigChLcq Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChLcq)')
		lcDelete = [Delete From SigCdCrd Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCrd)')
			Select CrTmpChm
				lcDelete = [Delete From SigChe where Nums = ']+CrTmpChm.Nums+[']
				If Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
					Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChe)')
		lcDelete = [Delete From SigCqChm Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCqChm)')
		lcDelete = [Delete From SigCdCar Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCar)')
		lcDelete = [Delete From SigCdCtt Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcDelete,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCtt)')
		lcSql = [select EspecieNfs From SigMvNfi where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcSql,'xNfis') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (select SigMvNfi)')
				Update cqSigMvCcr  Set EspecieNfs = xNFis.EspecieNfs
				Update CrSigMvCpv Set EspecieNfs = xNFis.EspecieNfs
		lcSql = [Update SigMvCab Set DtAlts = ?lpdata Where EmpDopNums = ']+lcPosicao+[']
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcSql,'') < 1
			Messagebox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab)')
		lcQuery = [Select Fpags, Contabs ] + ;
			[From SigOpFpo ] + ;
		If Ret And Thisform.Parentform.poDataMgr.sqlexecute(lcQuery,'LocalFpgCtb') < 1
			Select LocalFpgCtb
				Update crSigMvPar Set VPags = valos, Pagos = [0] Where Fpags = LocalFpgCtb.Fpags
		Select a.*, b.cpros ;
			From crSigMvOrp a, crSigMvOrc b ;
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigMvPar')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CqSigMvCcr')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigCdCmm')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigChe')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigCqChm')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigChLcq')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigCdCar')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigCdCtt')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigCdCrd')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigCdLca')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigMvCpv')
		If Ret And !Thisform.Parentform.poDataMgr.Update('CrSigOpCoc')
	Select xPar
	Select crTpmMvItn
Select xpar
	if seek( wbanco+wagenc+wconta+wnunch ) and _recant = recno()
select xpar
			Select crSigmvItd 
				Select crSigmvItd
lcSql = [Select * From SigcdEmp Where cemps = ']+TprMvCab.emps+[']
If Thisform.parentform.PoDataMgr.SqlExecute(lcSql,'crSigCdemp') < 1
lcSql = [Select * From SigOpFpP ]
If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'FpagFpagP') < 1
lcSql = [Select * From SigOpFpD Where Tabds = ']+TprMvCab.TabDs+[']
If Thisform.parentform.PoDataMgr.SqlExecute(lcSql,'fPagFpagD') < 1
Select FpagFpagD
Select xPar
	.FPagto.ControlSource = 'xPar.Fpags'
	.Valor.ControlSource  = 'xPar.Valos'
	.Venc.ControlSource   = 'xPar.Vencs'
	.Moeda.ControlSource  = 'xPar.MoeFPgs'
	.CotFPg.ControlSource = 'xPar.CotFPgs'
	.Column6.ControlSource = 'xPar.ValDescs'
Select crTpmMvItn
ThisForm.AlteraCotacao.Visible = ( ( !Seek( crSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) Or crSigCdCrg.AltCots # 'S' ) And ;
Select crSigMvNfi
Select xPar
Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcom ReadWrite
Select CrCfCom
Select xPar
		m.lnErro1 = ThisForm.ParentForm.poDataMgr.SQLExecute('select codigos,descrs,codpai,visuals from SigFiCt order by 1','crSigFiCT')
		Select ('crSigFiCT')
Select LocalMoe
	Select csSigOpFp
	Thisform.parentform.podatamgr.SqlExecute([Select * from SigCdCrt ],"crBan")
	Select CrBan
	If Not Seek(This.Value)
	lcQuery = [Select distinct Formas from SigOpFp Where ModPagto = 'Cartão']
	Thisform.parentform.podatamgr.sqlexecute(lcQuery,"crCad")
	Select CrCad
	If Not Seek(This.Value)
	Thisform.parentform.podatamgr.sqlexecute([Select * from SigcdCad Where tipocads = 'ADQUIRENTE'],"crCad")
	Select CrCad
	If Not Seek(This.Value)
Select csSigOpFp
Select csSigOpFp
	If !Seek( Replicate(Chr(254),10), 'csSigOpFp', 'FPags' )
	ThisForm.parentform.podatamgr.sqlexecute([Select * from SigcdCad Where tipocads = 'ADQUIRENTE'],"crCad")
	SELECT CrCad
	if not seek(this.value)
	Thisform.parentform.podatamgr.sqlexecute([Select * from SigCdMod],"crMod")
	Select crMod
	If Not Seek(This.Value)
	Select xPar
				Select [ ] as Agrupar,Count(1) as nTotal From xPar ;
						lcUpDate = [Update SigChe Set Valors = Valors where Nums = ']+Crcheque.Nums+[']
						If Thisform.Parentform.Podatamgr.sqlexecute(lcUpdate,'') < 1
							Select xPar
							Select xPar
								Select xPar
								Insert Into xPar From MemVar
							Select xPar
			Select xPar
					Select xPar
			Select xPar
			Select xPar
			Select xPar
Select xPar
			Select xPar
	Select xPar
Select crSigCdPam
		Select [ ] as Agrupar,Count(1) as nTotal From xPar ;
		Select xPar
	Select xPar
		Select xPar
lnOldSel = Select()
Select(lnOldSel)
		Select RecNo() As nRecNo, EmpOs, NCarts From xPar ;
			Select xPar
Select xpar
	Select crSigMvNfi
	Select xPar
			SELECT xpar
			DELETE ALL
		Select xPar
		Delete
				Select xPar
				Seek (lcNums)
					Delete
				Select xPar
					Delete
			Select xPar
			Delete For cnIdTefs = _pcnIdTef
		Select xPar
		Select xPar
		Select BarBonus
			Select BarBonus
	Select xPar
		If !Seek( This.Value, 'csSigOpFp', 'FPags' )
			If Seek(This.Value,'xPar','fPags') And crSigOpFp.Situas = [S]
					lcSql = [Select * From SigOpFpI Where Fpags = ']+CrSigOpFp.Fpags+[' And nParcs > 0 ]
					If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrSigOpFpI') > 0 And Reccount('CrSigOpFpI') > 0
				If Reccount('FpagFpagD') > 0 And Not Seek(CrSigOpFp.Fpags+Str(CrSigOpFp.fParcs,2),'FpagFpagD','Fpags')
			llCota = ( ( !Seek( crSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) Or crSigCdCrg.AltCots # 'S' ) And Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) And crSigCdMoe.Cotas )
	Select TprMvCab
		lcSql = [Select * From SigOpFpI Where Fpags = ']+CrSigOpFp.Fpags+[' And nParcs > 0 ]
		If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrSigOpFpI') > 0 And Reccount('CrSigOpFpI') > 0 And This.Value # 1
	If Reccount('FpagFpagD') > 0 And Not Seek(CrSigOpFp.Fpags+Str(This.Value,2),'FpagFpagD','Fpags')
		Select * From FpagFpagP Where Fpags = lcFpag And nParcs = lnP And lnValP >= ValMins And lnValP <= ValMaxs ;
		Select * From FpagFpagP Where Fpags = lcFpag And nParcs = lnP And lnValP >= ValMins And lnValP <= ValMaxs ;
	lcSql = [Select * From SigOpFpP Where Fpags = ']+CrSigOpFp.Fpags+[' And nParcs =]+Str(ThisForm.Get_npar.Value,2)
	If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'LocalFpagP') > 0 And ;
	lcSql = [Select GruConMoes,Opers,Valors From SigMvCcr Where EmpDopNums = ']+TprMvCab.Emps+TprMvCab.Dopes+Str(TprMvCab.Numes,6)+[']
	If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'TmpMccr') < 0 
	lcSql = [Select Saldos From SigMvSlc Where GruConMoes = ']+GruConMoe+[']
	If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrSigMvSlc') < 0 
	Select TmpMccr
lcSql = [Select * From SigOpFpI Where Fpags = ']+CrSigOpFp.Fpags+[' ]
If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrSigOpFpI') < 0 
Select * From CrSigOpFpI Where Fpags = CrSigOpFp.Fpags And nParcs = ThisForm.Get_npar.Value ;
Select * From CrSigOpFpI Where Fpags = CrSigOpFp.Fpags And nParcs = 0 And ValMaxs > 0 ;
	Select fpags, Sum(Valos) as vPars From xPar Where Fpags = CrSigOpFp.Fpags ;
	SELECT xpar
	DELETE ALL
Select xPar
	Select xPar
 			Select xPar
	 		Select xPar
	 		Select xPar
	Update xPar Set NoCreditos = ThisForm.Usulibs Where Fpags = CrSigOpFp.Fpags
Select crSigMvNfi
Select xPar
	Select Bancos+Agencias+Contas+Numeros as Cheque,Count(1) as nTotal From xPar ;
	Select CsVerChq
	Select xPar
		=Seek( xPar.FPags, 'csSigOpFp', 'FPags' )
		Select Distinct fpags From xPar Into Cursor Selecao
		Select Selecao
			lcSql = [Select * From SigOpFpI Where Fpags = ']+Selecao.Fpags+[' And nParcs = 0 And ValMaxs > 0 ]
			If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrSigOpFpI') < 0 
				Select fpags, Sum(Valos) as vPars From xPar Where Fpags = Selecao.Fpags ;
					Update xPar Set NoCreditos = ThisForm.UsuLibs Where Fpags = Selecao.Fpags
		Select TmpTotal
				Delete
		Select crTpmMvItn
			Select TmpTotal
				If !Seek( crTpmMvItn.MoeFats )
					Insert Into TmpTotal ( moeds ) Values ( crTpmMvItn.MoeFats )
				If !seek( crTpmMvItn.Moedas )
					Insert Into TmpTotal ( moeds ) Values ( crTpmMvItn.Moedas )
		Select TmpTotal
		Select TmpTotal
Return( Seek( crSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) And crSigCdCrg.AltCots = 'S' And Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) And crSigCdMoe.Cotas )
	Select xvalpar
	Select xPar
		If !Seek( xPar.moefpgs, 'xvalpar' )
			Insert Into xValPar ( Moeda ) Values ( xPar.moefpgs )
	Select xValPar
	ThisForm.TotForma.Grade_total.moeda.controlsource='xvalpar.moeda'
	ThisForm.TotForma.Grade_total.total.controlsource='xvalpar.total'
	Select xvalite
	Select crTpmMvItn
			Select xValIte
			If !Seek( _MoePeso )
				Insert into xValite ( Moeda ) Values ( _MoePeso )
			Select xValIte
			If !Seek( _MoePreco )
				Insert into xValite ( Moeda ) Values ( _MoePreco )
	Select xValIte
	ThisForm.TotForma.Grade_total.moeda.controlsource='xvalite.moeda'
	ThisForm.TotForma.Grade_total.total.controlsource='xvalite.total'
	Select TmpCot
	ThisForm.TotForma.Grade_total.moeda.controlsource='TmpCot.Cmoes'
	ThisForm.TotForma.Grade_total.total.controlsource='TmpCot.Valos'
Select TprMvCab
Select crSigMvNfi
Select TprMvCab
Select crSigMvNfi
Select crSigMvNfi
Select TprMvCab
Select crSigMvNfi
Select TprMvCab
Select crSigMvNfi
Select crSigMvNfi
Select xPar
	select xvalite
	select crTpmMvItn
			Select xValIte
			If !Seek( _MoePeso )
				Insert into xValite ( Moeda ) Values ( _MoePeso )
			Select xValIte
			If !Seek( _MoePreco )
				Insert into xValite ( Moeda ) Values ( _MoePreco )
	Select xValIte
				llCota = ( ( !Seek( crSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) Or crSigCdCrg.AltCots # 'S' ) And Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) And crSigCdMoe.Cotas )
Select xpar
Select xpar
	ThisForm.parentform.podatamgr.sqlexecute([Select * from SigcdCad Where tipocads = 'ADQUIRENTE'],"crCad")
	SELECT CrCad
	if not seek(this.value)
SELECT xpar
Select xpar
	Select xPar
	Select xPar
	Select xPar
lnOldSel = Select()
Select(lnOldSel)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppag.prg) - TRECHOS RELEVANTES PARA PASS SQL (2950 linhas total):

*-- Linhas 40 a 58:
40: *      no SIGOPPAG os botoes genericos Incluir/Visualizar/Alterar/
41: *      Excluir/Buscar do padrao CRUD, e inventa-los violaria o PILAR 1.
42: *   3) CarregarLista(): metodo UNICO de carga/repintura da grade, com o
43: *      bind canonico ColumnCount -> RecordSource -> ControlSource ->
44: *      Width -> Header1.Caption (RecordSource RESETA Width/Caption) e
45: *      fechando com GO TOP + Refresh (regra #21a: popular cursor NAO
46: *      repinta a grade).
47: *
48: * Fase 5/8 - CAMPOS PRINCIPAIS (PARTE 1/2):
49: *   ConfigurarCamposCondicao(): primeira metade dos campos soltos do
50: *   dump que ficam direto em SIGOPPAG (fora de qualquer container
51: *   flutuante) - o bloco "Condicao/Parcelas/Vencimento/Moeda/Valor
52: *   Original" que alimenta a linha da grade em edicao. Transcritos
53: *   Top/Left/Width/Height do dump; sem Format/InputMask porque o dump
54: *   nao declara nenhum para estes controles (regra #49 - "" no dump e
55: *   override vazio do Form Designer, nao se transcreve). A segunda
56: *   metade (bloco de Totais/Saldo/Variacao/checkboxes/avisos de porta)
57: *   entrou na Fase 6/8, abaixo.
58: *

*-- Linhas 289 a 335:
289: 		loc_nNumes = 0
290: 
291: 		IF USED("TprMvCab")
292: 			SELECT TprMvCab
293: 			loc_cEmps  = TratarNulo(Emps, "")
294: 			loc_cDopes = TratarNulo(Dopes, "")
295: 			loc_nNumes = TratarNulo(Numes, 0)
296: 		ENDIF
297: 
298: 		THIS.this_oBusinessObject = CREATEOBJECT("sigoppagBO", loc_cEmps, loc_cDopes, ;
299: 			loc_nNumes, THIS.this_lAltDireta, THIS.this_lAutomatico)
300: 
301: 		*-- Regra OPERACIONAL #4/precedente do projeto: SET DELETED ON global
302: 		*-- (start\config.prg) pode nao valer na DataSession deste form (ex.:
303: 		*-- rodando isolado, antes do SET DATASESSION TO do pai) - reposto
304: 		*-- aqui para que BtnExcluirCondicaoClick()/DELETE some da grade sem precisar de
305: 		*-- PACK (Fase 7/8).
306: 		SET DELETED ON
307: 
308: 		IF VARTYPE(THIS.this_oBusinessObject) = "O"
309: 			THIS.ConfigurarLayout()
310: 			THIS.ConfigurarBotoesAcao()
311: 			THIS.ConfigurarGrid()
312: 			THIS.ConfigurarCamposCondicao()
313: 			THIS.ConfigurarCamposTotais()
314: 			THIS.ConfigurarLookups()
315: 			THIS.ConfigurarEventosBotoes()
316: 
317: 			*-- Fase 7/8: cabecalho do movimento (TprMvCab/SigMvCab) +
318: 			*-- configuracao da operacao (SigCdOpe), usados pelos Click dos 5
319: 			*-- botoes de acao. Roda tambem em modo de validacao de UI (so
320: 			*-- faz leitura; sem gnConnHandle valido o SQLEXEC de SigCdOpe
321: 			*-- simplesmente nao preenche as propriedades *Ope, que ficam no
322: 			*-- default ja declarado).
323: 			THIS.this_oBusinessObject.CarregarConfiguracao()
324: 
325: 			*-- Fase 8/8: Enabled dos botoes de acao e dos campos soltos
326: 			*-- (depende de this_oBusinessObject.this_nParAutosOpe, logo
327: 			*-- roda SO depois de CarregarConfiguracao() acima).
328: 			THIS.AjustarBotoesPorModo()
329: 			THIS.HabilitarCampos()
330: 
331: 			*-- So busca SigMvPar por conta propria quando xPar (o cursor do
332: 			*-- form PAI) nao esta disponivel - replicar aqui com o pai
333: 			*-- presente duplicaria/sobrescreveria o buffer compartilhado
334: 			*-- dele (regra #21/comentario de CarregarLista abaixo).
335: 			IF !USED(THIS.this_cCursorLegado)

*-- Linhas 596 a 664:
596: 	* char(3), cotfpgs numeric(11,4), valdescs numeric(11,2), inschs bit,
597: 	* numchqs char(8), nidcheps numeric(10,0), trocos numeric(1,0).
598: 	*
599: 	* SET NULL ON antes do CREATE CURSOR (regra OPERACIONAL #4): os
600: 	* valores virao de SQLEXEC/SQL Server, que pode devolver NULL. Declarar
601: 	* inschs como L aqui tambem NORMALIZA o bit do SQL Server (que chega
602: 	* ora logico, ora numerico conforme o driver) na carga por
603: 	* ZAP + APPEND FROM DBF() da Fase 7.
604: 	*
605: 	* As propriedades do Grid e das 6 colunas sao transcritas do dump
606: 	* (Verdana 8 - NAO Tahoma; HeaderHeight 18; RowHeight 16;
607: 	* ReadOnly = .F.). Column1 e a UNICA ReadOnly = .T., e isso e aplicado
608: 	* DEPOIS do ReadOnly do Grid, que propaga para as colunas.
609: 	*====================================================================
610: 	PROTECTED PROCEDURE ConfigurarGrid()
611: 		LOCAL loc_cCursor
612: 
613: 		loc_cCursor = THIS.this_cCursorCondicoes
614: 
615: 		IF !USED(loc_cCursor)
616: 			SET NULL ON
617: 			CREATE CURSOR (loc_cCursor) ;
618: 				(cidchaves C(20) NULL, emps C(3) NULL, dopes C(20) NULL, ;
619: 				 numes N(6, 0) NULL, fpags C(12) NULL, valos N(11, 2) NULL, ;
620: 				 vencs T NULL, moefpgs C(3) NULL, cotfpgs N(11, 4) NULL, ;
621: 				 valdescs N(11, 2) NULL, inschs L NULL, numchqs C(8) NULL, ;
622: 				 nidcheps N(10, 0) NULL, trocos N(1, 0) NULL)
623: 			SET NULL OFF
624: 		ENDIF
625: 
626: 		THIS.AddObject("grd_4c_Condicoes", "Grid")
627: 		WITH THIS.grd_4c_Condicoes
628: 			.Top = 107
629: 			.Left = 444
630: 			.Width = 573
631: 			.Height = 246
632: 			.FontName = "Verdana"
633: 			.FontSize = 8
634: 			.HeaderHeight = 18
635: 			.RowHeight = 16
636: 			.ReadOnly = .F.
637: 			.RecordMark = .F.
638: 			.DeleteMark = .F.
639: 			.ChildOrder = ""
640: 			.ScrollBars = 2
641: 			.GridLines = 1
642: 			.GridLineColor = RGB(238, 238, 238)
643: 			.HighlightBackColor = RGB(255, 255, 255)
644: 			.HighlightForeColor = RGB(15, 41, 104)
645: 			.HighlightStyle = 2
646: 			.Visible = .T.
647: 
648: 			*-- Propriedades das colunas que NAO dependem do cursor. As que
649: 			*-- dependem (ControlSource) e as que o RecordSource RESETA
650: 			*-- (Width, Header1.Caption) ficam em CarregarLista().
651: 			.Column1.FontName = "Verdana"
652: 			.Column1.FontSize = 8
653: 			.Column1.Movable = .F.
654: 			.Column1.Resizable = .F.
655: 
656: 			.Column2.FontName = "Verdana"
657: 			.Column2.FontSize = 8
658: 			.Column2.Movable = .F.
659: 			.Column2.Resizable = .F.
660: 			.Column2.InputMask = "999999,999.99"
661: 
662: 			.Column3.FontName = "Verdana"
663: 			.Column3.FontSize = 8
664: 			.Column3.Movable = .F.

*-- Linhas 696 a 714:
696: 	* ficam direto em SIGOPPAG (fora dos containers flutuantes de forma
697: 	* de pagamento): o bloco "Condicao / Parcelas / Vencimento / Moeda /
698: 	* Valor Original" que espelha a linha corrente da grade (xPar) em
699: 	* edicao. Sem ControlSource/eventos ainda (Fases 7-8) - so os
700: 	* controles, nas posicoes e tamanhos exatos do dump.
701: 	*
702: 	* Mapeamento (SCX legado -> migrado), Top/Left/Width/Height do dump:
703: 	*   Say12          -> lbl_4c_Condicao     (147,96)  "Condicao :"
704: 	*   Get_modfpg     -> txt_4c_Modfpg       (142,178,36,25)  numeric
705: 	*   Get_fpg        -> txt_4c_Fpg          (142,218,147,25) char(12)
706: 	*   Say13          -> lbl_4c_Parcelas     (174,119) "Parcelas :"
707: 	*   Get_npar       -> txt_4c_Npar         (169,178,36,25)  numeric
708: 	*   GetPorc        -> txt_4c_Porc         (169,218,147,25) numeric
709: 	*   Say17          -> lbl_4c_Valor        (228,135) "Valor :"
710: 	*   Get_vpar       -> txt_4c_Vpar         (223,178,186,25) numeric
711: 	*   Say2           -> lbl_4c_Vencimento   (254,96)  "Vencimento :"
712: 	*   Get_Dias       -> txt_4c_Dias         (250,178,36,25)  numeric
713: 	*   Dataget_venc   -> txt_4c_DataVenc     (250,218,146,25) date
714: 	*   Say20          -> lbl_4c_Moeda        (302,132) "Moeda :"

*-- Linhas 947 a 965:
947: 	* ConfigurarCamposTotais - PARTE 2/2 dos campos soltos do dump que
948: 	* ficam direto em SIGOPPAG: o bloco "Valores Totais / Saldo /
949: 	* Variacao / Desconto % / Cambio / Bonus" mais os checkboxes de
950: 	* atalho e os 6 avisos de porta. Sem ControlSource/eventos ainda
951: 	* (Fases 7-8) - so os controles, nas posicoes e tamanhos exatos do
952: 	* dump (layout.json).
953: 	*
954: 	* Mapeamento (SCX legado -> migrado), Top/Left/Width/Height do dump:
955: 	*   Say6           -> lbl_4c_ValoresTotais (273,70,87,16) "Valores Totais"
956: 	*   Get_TotServico -> txt_4c_TotServico    (351,182,146,25) numeric
957: 	*   Say21          -> lbl_4c_Servicos      (356,124) "Servicos :"
958: 	*   getValTrans    -> txt_4c_ValTrans      (378,182,146,25) numeric
959: 	*   Say7           -> lbl_4c_Transporte    (383,108) "Transporte :"
960: 	*   Get_Variacao   -> txt_4c_Variacao      (405,182,146,25) numeric
961: 	*   Say5           -> lbl_4c_Variacao      (410,123) "Variacao :"
962: 	*   Get_valtot     -> txt_4c_ValTot        (432,182,146,25) numeric
963: 	*   Get_pVaria     -> txt_4c_PVaria        (513,182,146,25) numeric
964: 	*   Say3           -> lbl_4c_DescontoPercent (514,90,88,16) "Desconto (%) :"
965: 	*   Get_Saldo      -> txt_4c_Saldo         (486,182,146,25) numeric

*-- Linhas 1554 a 1583:
1554: 	* CarregarLista - metodo UNICO de carga/repintura da grade de
1555: 	* condicoes, chamado em TODO caminho que (re)popula o cursor (regra
1556: 	* #21a: popular o cursor NAO repinta a grade - o legado sempre fecha
1557: 	* com "Select xPar / Goto Top / Grade.Refresh").
1558: 	*
1559: 	* Fonte dos dados: o legado liga a grade ao cursor xPar que o form PAI
1560: 	* deixa aberto na DataSession compartilhada (dump:
1561: 	* Grade.RecordSource = "XPAR" e o bloco de rebind do Init, que repete
1562: 	* RecordSource + os 6 ControlSource + o DynamicForeColor + Refresh).
1563: 	* Reproduzimos isso: quando xPar existe, a grade se liga a ele; caso
1564: 	* contrario fica no cursor placeholder (form aberto isolado ou em
1565: 	* validacao de UI), de mesma estrutura.
1566: 	*
1567: 	* Ordem canonica obrigatoria (RecordSource RESETA Width e
1568: 	* Header1.Caption): ColumnCount -> RecordSource -> ControlSource ->
1569: 	* Width -> Header1.Caption. Por isso esse bloco vive AQUI e nao em
1570: 	* ConfigurarGrid: todo rebind precisa repeti-lo inteiro.
1571: 	*
1572: 	* PUBLIC de proposito (sem PROTECTED): o harness de teste e os
1573: 	* caminhos de recarga chamam THIS.CarregarLista() de FORA da classe
1574: 	* (regra #3 - PEMSTATUS nao verifica escopo e a chamada falharia em
1575: 	* runtime com "Property CARREGARLISTA is not found").
1576: 	*====================================================================
1577: 	PROCEDURE CarregarLista()
1578: 		LOCAL loc_lSucesso, loc_cAlias, loc_oGrid, loc_cDynFore, loc_oErro
1579: 
1580: 		loc_lSucesso = .F.
1581: 
1582: 		TRY
1583: 			*-- Fonte: xPar do form pai quando disponivel; senao o

*-- Linhas 1590 a 1627:
1590: 			IF USED(loc_cAlias) AND PEMSTATUS(THIS, "grd_4c_Condicoes", 5)
1591: 				loc_oGrid = THIS.grd_4c_Condicoes
1592: 
1593: 				SELECT (loc_cAlias)
1594: 				SET ORDER TO
1595: 				GO TOP
1596: 
1597: 				WITH loc_oGrid
1598: 					*-- 1) ColumnCount (sempre antes do RecordSource, para o
1599: 					*-- Grid nao auto-expandir para todas as colunas do cursor)
1600: 					.ColumnCount = 6
1601: 
1602: 					*-- 2) RecordSource
1603: 					.RecordSource = loc_cAlias
1604: 
1605: 					*-- 3) ControlSource (dump: Fpags/Valos/Vencs/MoeFPgs/
1606: 					*-- CotFPgs/ValDescs)
1607: 					.Column1.ControlSource = loc_cAlias + ".fpags"
1608: 					.Column2.ControlSource = loc_cAlias + ".valos"
1609: 					.Column3.ControlSource = loc_cAlias + ".vencs"
1610: 					.Column4.ControlSource = loc_cAlias + ".moefpgs"
1611: 					.Column5.ControlSource = loc_cAlias + ".cotfpgs"
1612: 					.Column6.ControlSource = loc_cAlias + ".valdescs"
1613: 
1614: 					*-- 4) Width (o RecordSource acima zera para o default 90)
1615: 					.Column1.Width = 148
1616: 					.Column2.Width = 120
1617: 					.Column3.Width = 78
1618: 					.Column4.Width = 30
1619: 					.Column5.Width = 80
1620: 					.Column6.Width = 90
1621: 
1622: 					*-- 5) Header1.Caption (idem - resetado pelo RecordSource).
1623: 					*-- Alignment = 2 (centralizado) em todos, como no dump.
1624: 					.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
1625: 					.Column2.Header1.Caption = "Valor"
1626: 					.Column3.Header1.Caption = "Vencimento"
1627: 					.Column4.Header1.Caption = "Moe"

*-- Linhas 1684 a 1702:
1684: 
1685: 				*-- Repintura (regra #21a): sem GO TOP + Refresh a grade
1686: 				*-- fica visualmente vazia com o cursor cheio.
1687: 				SELECT (loc_cAlias)
1688: 				GO TOP
1689: 				loc_oGrid.Refresh()
1690: 
1691: 				THIS.this_cAliasGrade = loc_cAlias
1692: 				loc_lSucesso = .T.
1693: 			ENDIF
1694: 		CATCH TO loc_oErro
1695: 			MsgErro("Erro ao carregar a grade de condi" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1696: 				loc_oErro.Message + CHR(13) + ;
1697: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1698: 				"Procedure: " + loc_oErro.Procedure, "Erro")
1699: 		ENDTRY
1700: 
1701: 		RETURN loc_lSucesso
1702: 	ENDPROC

*-- Linhas 1859 a 1877:
1859: 				ENDIF
1860: 
1861: 				IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1862: 					SELECT cursor_4c_BuscaMoeda
1863: 					THIS.txt_4c_Modfpg.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1864: 				ENDIF
1865: 
1866: 				IF USED("cursor_4c_BuscaMoeda")
1867: 					USE IN cursor_4c_BuscaMoeda
1868: 				ENDIF
1869: 
1870: 				loc_oBusca.Release()
1871: 			ENDIF
1872: 		CATCH TO loc_oErro
1873: 			MsgErro("Erro ao localizar moeda:" + CHR(13) + ;
1874: 				loc_oErro.Message + CHR(13) + ;
1875: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1876: 				"Procedure: " + loc_oErro.Procedure, "Erro")
1877: 		ENDTRY

*-- Linhas 2001 a 2019:
2001: 			IF USED(THIS.this_cCursorFormasPagamento)
2002: 				IF !EMPTY(loc_cValor) AND ;
2003: 				   SEEK(loc_cValor, THIS.this_cCursorFormasPagamento, "fpags")
2004: 					SELECT (THIS.this_cCursorFormasPagamento)
2005: 					THIS.txt_4c_Fpg.Value = ALLTRIM(EVALUATE(THIS.this_cCursorFormasPagamento + ".fpags"))
2006: 				ELSE
2007: 					loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2008: 
2009: 					IF VARTYPE(loc_oBusca) = "O"
2010: 						loc_oBusca.DefinirCursor(THIS.this_cCursorFormasPagamento, ;
2011: 							"fpags", "descrs", "Cadastro de Forma de Pagamento")
2012: 
2013: 						*-- DefinirCursor usa o NOME do campo como titulo das
2014: 						*-- duas primeiras colunas; zerar o contador faz
2015: 						*-- mAddColuna remontar a lista com os titulos e as
2016: 						*-- mascaras do legado (AddColuna de Get_fpg.Valid,
2017: 						*-- dump linhas 6931-6934).
2018: 						loc_oBusca.this_nColunas = 0
2019: 						loc_oBusca.mAddColuna("fpags", "", "C" + CHR(243) + "digo")

*-- Linhas 2078 a 2107:
2078: 		loc_cMoeda = ALLTRIM(TRANSFORM(THIS.txt_4c_Modfpg.Value))
2079: 
2080: 		TEXT TO loc_cSQL TEXTMERGE NOSHOW
2081: 			SELECT a.fpags, a.descrs, a.moefpgs, a.fparcs, a.situas
2082: 			FROM SigOpFp a
2083: 			WHERE a.emps IN (<<EscaparSQL(loc_cEmps)>>, '   ')
2084: 			<<IIF(!EMPTY(loc_cMoeda), " AND a.moefpgs = " + EscaparSQL(loc_cMoeda), "")>>
2085: 			<<IIF(!EMPTY(loc_cDopes), " AND a.fpags <> ISNULL((SELECT fpagopcrs FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cDopes) + "), '')", "")>>
2086: 			ORDER BY a.fpags
2087: 		ENDTEXT
2088: 
2089: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormasPagamento)
2090: 
2091: 		IF loc_nResultado >= 0 AND USED(THIS.this_cCursorFormasPagamento)
2092: 			SELECT (THIS.this_cCursorFormasPagamento)
2093: 			INDEX ON fpags TAG fpags
2094: 			GO TOP
2095: 		ENDIF
2096: 
2097: 		RETURN (loc_nResultado >= 0)
2098: 	ENDPROC
2099: 
2100: 	*====================================================================
2101: 	* ConfigurarEventosBotoes - liga o Click dos 5 CommandButton REAIS de
2102: 	* acao (regra #3 - BINDEVENT so dispara metodo PUBLIC) aos handlers da
2103: 	* Fase 7/8. btnRetCash.When do dump NAO e ligado aqui: CommandButton do
2104: 	* VFP9 nao tem evento When nativo (ver BtnRetCashWhen() abaixo).
2105: 	*====================================================================
2106: 	PROTECTED PROCEDURE ConfigurarEventosBotoes()
2107: 		LOCAL loc_oCnt

*-- Linhas 2381 a 2418:
2381: 		loc_cCaption = ""
2382: 		loc_lFechou  = .F.
2383: 
2384: 		SELECT (loc_cAlias)
2385: 		loc_cFpagAtual      = TratarNulo(fpags, "")
2386: 		loc_lInschsAtual    = ConverterParaLogico(inschs)
2387: 		loc_cCidchavesAtual = TratarNulo(cidchaves, "")
2388: 		loc_cNumChqsAtual   = IIF(TYPE(loc_cAlias + ".numchqs") != "U", TratarNulo(numchqs, ""), "")
2389: 		loc_cBancosAtual    = IIF(TYPE(loc_cAlias + ".bancos")  != "U", TratarNulo(bancos, ""),  "")
2390: 
2391: 		TRY
2392: 			loc_cOperAutos = ""
2393: 
2394: 			IF USED("cursor_4c_ApagaFp")
2395: 				USE IN cursor_4c_ApagaFp
2396: 			ENDIF
2397: 
2398: 			IF !EMPTY(loc_cFpagAtual)
2399: 				TEXT TO loc_cSQL TEXTMERGE NOSHOW
2400: 					SELECT operautos FROM SigOpFp WHERE fpags = <<EscaparSQL(loc_cFpagAtual)>>
2401: 				ENDTEXT
2402: 
2403: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ApagaFp")
2404: 				IF loc_nResultado >= 0 AND USED("cursor_4c_ApagaFp") AND !EOF("cursor_4c_ApagaFp")
2405: 					loc_cOperAutos = TratarNulo(cursor_4c_ApagaFp.operautos, "")
2406: 				ENDIF
2407: 
2408: 				IF USED("cursor_4c_ApagaFp")
2409: 					USE IN cursor_4c_ApagaFp
2410: 				ENDIF
2411: 			ENDIF
2412: 
2413: 			DO CASE
2414: 			CASE !EMPTY(loc_cOperAutos) AND loc_cFpagAtual == loc_cOperAutos
2415: 				loc_cMsg     = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Autom" + CHR(225) + "tica ... "
2416: 				loc_cCaption = "Exclus" + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Permitida"
2417: 
2418: 			CASE loc_lInschsAtual AND THIS.this_cOpEscolha == "ALTERAR"

*-- Linhas 2429 a 2475:
2429: 				loc_cCaption = "Exclus" + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Permitida"
2430: 
2431: 			CASE THIS.this_oBusinessObject.this_nCupfisOpe = 3
2432: 				*-- Legado: "Delete All" + "thisform.cancela.Click()" (zera a
2433: 				*-- forma inteira para o usuario recomecar, mena 06/10/2016).
2434: 				*-- Aqui o fechamento mora em FecharDialogo() - DESVIO
2435: 				*-- deliberado do literal "continuar executando o metodo
2436: 				*-- apos o Release()" do legado, que nesta arquitetura
2437: 				*-- estouraria ao tentar usar THIS depois de liberado.
2438: 				SELECT (loc_cAlias)
2439: 				SCAN
2440: 					IF !EMPTY(cidchaves)
2441: 						THIS.this_oBusinessObject.ExcluirCondicao(cidchaves)
2442: 					ENDIF
2443: 				ENDSCAN
2444: 
2445: 				SELECT (loc_cAlias)
2446: 				ZAP
2447: 
2448: 				loc_lFechou = .T.
2449: 			ENDCASE
2450: 
2451: 			IF !loc_lFechou
2452: 				IF !EMPTY(loc_cMsg)
2453: 					MsgAviso(loc_cMsg, loc_cCaption)
2454: 				ELSE
2455: 					IF !EMPTY(loc_cCidchavesAtual)
2456: 						THIS.this_oBusinessObject.ExcluirCondicao(loc_cCidchavesAtual)
2457: 					ENDIF
2458: 
2459: 					SELECT (loc_cAlias)
2460: 					DELETE
2461: 
2462: 					THIS.AtualizarTotaisPosExclusao(loc_cAlias)
2463: 
2464: 					*-- Fase 8/8: funil unico de limpeza (ver LimparCampos()) -
2465: 					*-- substitui o clear inline de 5 campos desta fase.
2466: 					THIS.LimparCampos()
2467: 
2468: 					THIS.CarregarLista()
2469: 					THIS.txt_4c_Fpg.SetFocus()
2470: 				ENDIF
2471: 			ENDIF
2472: 		CATCH TO loc_oErro
2473: 			MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + ;
2474: 				loc_oErro.Message + CHR(13) + ;
2475: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 2500 a 2518:
2500: 				USE IN cursor_4c_ApagaTot
2501: 			ENDIF
2502: 
2503: 			SELECT SUM(IIF(trocos = 1, -valos, valos)) AS total FROM (par_cAlias) INTO CURSOR cursor_4c_ApagaTot
2504: 
2505: 			IF USED("cursor_4c_ApagaTot")
2506: 				loc_nTotForma = TratarNulo(cursor_4c_ApagaTot.total, 0)
2507: 				USE IN cursor_4c_ApagaTot
2508: 			ENDIF
2509: 
2510: 			THIS.txt_4c_TotForma.Value = loc_nTotForma
2511: 			THIS.txt_4c_Saldo.Value    = THIS.txt_4c_ValTot.Value - loc_nTotForma
2512: 		CATCH TO loc_oErro
2513: 			MsgErro("Erro ao recalcular totais da condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "Erro")
2514: 		ENDTRY
2515: 	ENDPROC
2516: 
2517: 	*====================================================================
2518: 	* BtnConfirmarClick - porta de SIGOPPAG.Ok.Click (dump linha 7869) - "Confirmar":

*-- Linhas 2605 a 2697:
2605: 
2606: 	*====================================================================
2607: 	* ContaTemDescontoBloqueado - SigCdCli.Situas -> SigCdCst.BlqDescs,
2608: 	* consulta direta via SQLEXEC (substitui o
2609: 	* ThisForm.parentform.PoDataMgr.CursorQuery do legado, que nao existe
2610: 	* no projeto novo). Exibe o MsgAviso do proprio legado quando bloqueado.
2611: 	*====================================================================
2612: 	PROTECTED PROCEDURE ContaTemDescontoBloqueado(par_cConta)
2613: 		LOCAL loc_lBloqueado, loc_cSQL, loc_nResultado, loc_oErro
2614: 
2615: 		loc_lBloqueado = .F.
2616: 
2617: 		IF EMPTY(par_cConta)
2618: 			RETURN loc_lBloqueado
2619: 		ENDIF
2620: 
2621: 		TRY
2622: 			IF USED("cursor_4c_SituacaoCliente")
2623: 				USE IN cursor_4c_SituacaoCliente
2624: 			ENDIF
2625: 
2626: 			TEXT TO loc_cSQL TEXTMERGE NOSHOW
2627: 				SELECT c.descrs, c.blqdescs
2628: 				FROM SigCdCli a
2629: 				INNER JOIN SigCdCst c ON c.codigos = a.situas
2630: 				WHERE a.iclis = <<EscaparSQL(par_cConta)>>
2631: 			ENDTEXT
2632: 
2633: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SituacaoCliente")
2634: 
2635: 			IF loc_nResultado >= 0 AND USED("cursor_4c_SituacaoCliente") AND !EOF("cursor_4c_SituacaoCliente")
2636: 				IF cursor_4c_SituacaoCliente.blqdescs = 1
2637: 					loc_lBloqueado = .T.
2638: 					MsgAviso(ALLTRIM(TratarNulo(cursor_4c_SituacaoCliente.descrs, "")) + CHR(13) + ;
2639: 						"Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o a Conta", "Situa" + CHR(231) + CHR(227) + "o")
2640: 				ENDIF
2641: 			ENDIF
2642: 
2643: 			IF USED("cursor_4c_SituacaoCliente")
2644: 				USE IN cursor_4c_SituacaoCliente
2645: 			ENDIF
2646: 		CATCH TO loc_oErro
2647: 			MsgErro("Erro ao verificar situa" + CHR(231) + CHR(227) + "o do cliente:" + CHR(13) + loc_oErro.Message, "Erro")
2648: 		ENDTRY
2649: 
2650: 		RETURN loc_lBloqueado
2651: 	ENDPROC
2652: 
2653: 	*====================================================================
2654: 	* ValidarChequesDuplicados - porta literal do bloco "Select
2655: 	* Bancos+Agencias+Contas+Numeros..." do Ok.Click (dump linhas 7895-
2656: 	* 7904). Campos bancos/agencias/contas/numeros so existem no xPar
2657: 	* completo do form pai - no cursor placeholder (modo de teste) o TYPE()
2658: 	* devolve "U" e a checagem e pulada (sem crash, sem falso bloqueio).
2659: 	*====================================================================
2660: 	PROTECTED PROCEDURE ValidarChequesDuplicados(par_cAlias)
2661: 		LOCAL loc_lOk, loc_oErro
2662: 
2663: 		loc_lOk = .T.
2664: 
2665: 		IF TYPE(par_cAlias + ".bancos") == "U" OR TYPE(par_cAlias + ".agencias") == "U" OR ;
2666: 				TYPE(par_cAlias + ".contas") == "U" OR TYPE(par_cAlias + ".numeros") == "U"
2667: 			RETURN loc_lOk
2668: 		ENDIF
2669: 
2670: 		TRY
2671: 			IF USED("cursor_4c_VerChq")
2672: 				USE IN cursor_4c_VerChq
2673: 			ENDIF
2674: 
2675: 			SELECT bancos + agencias + contas + numeros AS cheque, COUNT(1) AS ntotal ;
2676: 				FROM (par_cAlias) ;
2677: 				WHERE !EMPTY(bancos + agencias + contas + numeros) ;
2678: 				INTO CURSOR cursor_4c_VerChq ;
2679: 				GROUP BY 1
2680: 
2681: 			IF USED("cursor_4c_VerChq")
2682: 				SELECT cursor_4c_VerChq
2683: 				LOCATE FOR ntotal > 1
2684: 				IF FOUND()
2685: 					loc_lOk = .F.
2686: 					MsgAviso("Existem Cheques Lan" + CHR(231) + CHR(227) + "ados em Duplicidade Nessa Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2687: 				ENDIF
2688: 				USE IN cursor_4c_VerChq
2689: 			ENDIF
2690: 		CATCH TO loc_oErro
2691: 			MsgErro("Erro ao verificar cheques duplicados:" + CHR(13) + loc_oErro.Message, "Erro")
2692: 		ENDTRY
2693: 
2694: 		RETURN loc_lOk
2695: 	ENDPROC
2696: 
2697: 	*====================================================================

*-- Linhas 2722 a 2768:
2722: 				USE IN cursor_4c_FormasUsadas
2723: 			ENDIF
2724: 
2725: 			SELECT DISTINCT fpags FROM (par_cAlias) WHERE !EMPTY(fpags) INTO CURSOR cursor_4c_FormasUsadas
2726: 
2727: 			IF USED("cursor_4c_FormasUsadas") AND RECCOUNT("cursor_4c_FormasUsadas") > 0
2728: 				SELECT cursor_4c_FormasUsadas
2729: 				SCAN
2730: 					loc_cFpagsIn = loc_cFpagsIn + IIF(EMPTY(loc_cFpagsIn), "", ",") + EscaparSQL(ALLTRIM(fpags))
2731: 				ENDSCAN
2732: 				USE IN cursor_4c_FormasUsadas
2733: 			ENDIF
2734: 
2735: 			IF USED("cursor_4c_SigOpFpAtual")
2736: 				USE IN cursor_4c_SigOpFpAtual
2737: 			ENDIF
2738: 
2739: 			IF !EMPTY(loc_cFpagsIn)
2740: 				TEXT TO loc_cSQL TEXTMERGE NOSHOW
2741: 					SELECT fpags, emivales, obs, autoriza, nsu, opcsnas
2742: 					FROM SigOpFp
2743: 					WHERE fpags IN (<<loc_cFpagsIn>>)
2744: 				ENDTEXT
2745: 
2746: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpAtual")
2747: 				IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpFpAtual")
2748: 					SELECT cursor_4c_SigOpFpAtual
2749: 					INDEX ON fpags TAG fpags
2750: 				ENDIF
2751: 			ENDIF
2752: 
2753: 			SELECT (par_cAlias)
2754: 			SCAN
2755: 				IF !EMPTY(fpags) AND EMPTY(vencs)
2756: 					loc_lOk = .F.
2757: 					MsgAviso("Vencimento Inv" + CHR(225) + "lido !", "Aten" + CHR(231) + CHR(227) + "o")
2758: 					EXIT
2759: 				ENDIF
2760: 
2761: 				IF USED("cursor_4c_SigOpFpAtual") AND SEEK(ALLTRIM(fpags), "cursor_4c_SigOpFpAtual", "fpags")
2762: 					IF cursor_4c_SigOpFpAtual.emivales = 3 AND TYPE(par_cAlias + ".outros") != "U" AND EMPTY(EVALUATE(par_cAlias + ".outros"))
2763: 						loc_lOk = .F.
2764: 						MsgAviso("Obrigat" + CHR(243) + "rio Informar # do Cr" + CHR(233) + "dito Utilizado", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2765: 						EXIT
2766: 					ENDIF
2767: 
2768: 					IF cursor_4c_SigOpFpAtual.obs = 3 AND TYPE(par_cAlias + ".obs") != "U" AND EMPTY(EVALUATE(par_cAlias + ".obs"))

*-- Linhas 2789 a 2819:
2789: 					loc_nTotNao = loc_nTotNao + IIF(cursor_4c_SigOpFpAtual.opcsnas = 2, valos, 0)
2790: 				ENDIF
2791: 
2792: 				SELECT (par_cAlias)
2793: 			ENDSCAN
2794: 
2795: 			IF loc_lOk AND !EMPTY(THIS.this_oBusinessObject.this_cTpFatsCab)
2796: 				IF USED("cursor_4c_SigCdTifAtual")
2797: 					USE IN cursor_4c_SigCdTifAtual
2798: 				ENDIF
2799: 
2800: 				TEXT TO loc_cSQL TEXTMERGE NOSHOW
2801: 					SELECT pvalors, opcsnas FROM SigCdTif WHERE codigos = <<EscaparSQL(THIS.this_oBusinessObject.this_cTpFatsCab)>>
2802: 				ENDTEXT
2803: 
2804: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTifAtual")
2805: 
2806: 				IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdTifAtual") AND !EOF("cursor_4c_SigCdTifAtual")
2807: 					IF cursor_4c_SigCdTifAtual.pvalors != 0 AND INLIST(cursor_4c_SigCdTifAtual.opcsnas, 1, 2) AND ;
2808: 							INLIST(THIS.this_oBusinessObject.this_nAptpfatsOpe, 2, 6)
2809: 
2810: 						loc_nTtMaxSim = ROUND(THIS.this_oBusinessObject.this_nValosCab * cursor_4c_SigCdTifAtual.pvalors / 100, 2)
2811: 						loc_nTtMaxNao = ROUND(THIS.this_oBusinessObject.this_nValosCab * (100 - cursor_4c_SigCdTifAtual.pvalors) / 100, 2)
2812: 
2813: 						IF ABS(loc_nTtMaxSim - loc_nTotSim) > 1 OR ABS(loc_nTtMaxNao - loc_nTotNao) > 1
2814: 							loc_lOk = .F.
2815: 							MsgAviso("Valores divergentes para condi" + CHR(231) + CHR(227) + "o de Pagamento Sim / N" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2816: 						ENDIF
2817: 					ENDIF
2818: 				ENDIF
2819: 

*-- Linhas 2854 a 2893:
2854: 		loc_lOk    = .T.
2855: 		loc_nRecno = 0
2856: 
2857: 		SELECT (par_cAlias)
2858: 		IF !EOF() AND !BOF()
2859: 			loc_nRecno = RECNO()
2860: 		ENDIF
2861: 
2862: 		SELECT (par_cAlias)
2863: 		SCAN WHILE loc_lOk
2864: 			IF THIS.this_oBusinessObject.CarregarDoCursor(par_cAlias)
2865: 				IF EMPTY(THIS.this_oBusinessObject.this_cCidchaves)
2866: 					loc_lOk = THIS.this_oBusinessObject.Inserir()
2867: 				ELSE
2868: 					loc_lOk = THIS.this_oBusinessObject.Atualizar()
2869: 				ENDIF
2870: 			ELSE
2871: 				loc_lOk = .F.
2872: 			ENDIF
2873: 
2874: 			SELECT (par_cAlias)
2875: 		ENDSCAN
2876: 
2877: 		IF loc_nRecno > 0 AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cAlias))
2878: 			SELECT (par_cAlias)
2879: 			GOTO loc_nRecno
2880: 		ENDIF
2881: 
2882: 		RETURN loc_lOk
2883: 	ENDPROC
2884: 
2885: 	*====================================================================
2886: 	* BtnCancelarClick - porta literal de SIGOPPAG.Cancela.Click (dump linha
2887: 	* 8468): confirma/libera a transacao TEF em aberto (VerifTef - funcao GLOBAL do
2888: 	* legado sem definicao no acervo migrado; wrapper no-op documentado em
2889: 	* utils\verifteF.prg, regra #27), reabilita o form pai e fecha este
2890: 	* dialogo.
2891: 	*====================================================================
2892: 	PROCEDURE BtnCancelarClick()
2893: 		THIS.FecharDialogo()


### BO (C:\4c\projeto\app\classes\sigoppagBO.prg):
*====================================================================
* sigoppagBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPPAG" ("Recebimento" -
* condicoes de pagamento/recebimento de um movimento). O legado abre
* este form como FILHO do form de cabecalho do movimento (Lparameters
* pForm, datses, plAltDireta, plAutomatico - Set Datasession To datses,
* isto e, o filho passa a compartilhar a MESMA data session do pai, com
* os cursores xPar/TprMvCab/crSigCdOpe/crSigMvNfi/crSigCdCfo/crSigCdPam
* ja abertos por ele).
*
* Tabelas envolvidas: SigMvPar (condicoes de pagamento/parcelas do
* movimento - cursor legado xPar, chave cidchaves), SigMvCab (cabecalho
* do movimento - espelhado no cursor temporario TprMvCab do pai),
* SigCdOpe (configuracao da operacao), SigOpFp (catalogo de formas de
* pagamento), SigCdMoe (moedas), SigCdCrt (bandeiras de cartao),
* SigCdCad (adquirentes/modalidades - tipocads = 'ADQUIRENTE'),
* SigCdMod (modalidades de pagamento), SigCqChm/SigChe (protocolo e
* cheque), SigCdCtt (protocolo de cartao de credito).
*
* Referencias legado -> BO (linha do xPar sendo incluida/alterada,
* mapeamento 1-para-1 para SigMvPar):
*   xPar.Agencias/Bancos/Cartaos/Contas/CotFPgs/Dopes/EmpOs/FPags/
*   InsChs/MoeFPgs/NCarnes/NCarts/NoCreditos/Nsu/NumChqs/Numeros/Numes/
*   NumOlds/Obs/Outros/Trocos/ValDescs/Valos/Vencs/adquirente/autoriza/
*   cnIdTefs/nIdCheps/Parcs/TParcs/VPags ->
*       this_cAgencias/this_cBancos/this_cCartaos/this_cContas/
*       this_nCotfpgs/this_cDopes/this_cEmpos/this_cFpags/this_lInschs/
*       this_cMoefpgs/this_cNcarnes/this_nNcarts/this_cNocreditos/
*       this_cNsu/this_cNumchqs/this_cNumeros/this_nNumes/
*       this_nNumolds/this_cObs/this_cOutros/this_nTrocos/
*       this_nValdescs/this_nValos/this_dVencs/this_cAdquirente/
*       this_cAutoriza/this_cCnidtefs/this_nNidcheps/this_nParcs/
*       this_nTparcs/this_nVpags
*   (demais colunas de SigMvPar sem uso direto no codigo analisado -
*   declaradas do mesmo jeito, para paridade de schema/INSERT futuro:
*   this_nEcNumes/this_cGrclis/this_cIclis/this_cImpcars/this_cLocals/
*   this_nNcopias/this_nNopers/this_nNrecs/this_nNtrans/this_cCotusus/
*   this_cCnnsuparcs/this_nNumlotechs/this_cCidchaves/this_nValocurs/
*   this_cEmpdopnums/this_cPagos/this_dDtalts/this_cCpfs/
*   this_cDigagencs/this_cDigchqs/this_cDigcontas/this_cPracas/
*   this_cCodbcrts/this_lLcancelas/this_nVcofins/this_nVcsll/this_nVirf/
*   this_nVlrtrbfs/this_nVpis/this_cChaveexterna/this_dDatas/
*   this_dDatatrans/this_cDcarts/this_dDpags/this_dDtdeps/this_cEmps)
*
* Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+Numes
* (this_cEmps/this_cDopes/this_nNumes abaixo). Sufixo "Cab" evita colisao
* com propriedades de mesmo nome da linha de SigMvPar (ex.: this_nValos
* e o valor da PARCELA; this_nValosCab e o total do movimento):
*   TprMvCab.ContaOs/ContaDs/Datas/Notas/PrazoEnts/TabDs/TpFats/ValDevs/
*   ValEncs/ValInis/ValServs/ValTrans/ValUtiCsh/ValVarPs/ValVars/Valos/
*   VarTots/Vars -> this_cContaOsCab/this_cContaDsCab/this_dDatasCab/
*   this_cNotasCab/this_dPrazoEntsCab/this_cTabDsCab/this_cTpFatsCab/
*   this_nValDevsCab/this_nValEncsCab/this_nValInisCab/this_nValServsCab/
*   this_nValTransCab/this_nValUtiCshCab/this_nValVarPsCab/
*   this_nValVarsCab/this_nValosCab/this_nVarTotsCab/this_nVarsCab
*   (TabDs/TpFats corrigidos para CHAR na Fase 7/8 - docs\schema.sql mostra
*   SigMvCab.tabds char(10) e tpfats char(3); a Fase 1 os declarara como
*   numeric por engano e nenhum outro arquivo do projeto os referenciava
*   ainda, regra #19 - MaxLength/tipo vem do schema, nunca de palpite)
*
* Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
* Sufixo "Ope" pelo mesmo motivo (SigCdOpe.Vars/parcs tambem colidiriam
* com propriedades de SigMvPar/outro config):
*   SigCdOpe.BlqDatas/CMoes/COpers/Caixas/Confes/Deacrs/DtEntrs/EdComis/
*   FPagOpCrs/HabServs/LPrecos/Opers/ParRecals/parcs/PesoVts/PrecoAuts/
*   PrecoVts/ValPres/Vars/aptpfats/cheqs/cupfis ->
*       this_nBlqDatasOpe/this_cCMoesOpe/this_nCopersOpe/this_nCaixasOpe/
*       this_nConfesOpe/this_nDeacrsOpe/this_nDtEntrsOpe/this_nEdComisOpe/
*       this_cFPagOpCrsOpe/this_nHabServsOpe/this_nLPrecosOpe/
*       this_nOpersOpe/this_nParRecalsOpe/this_nParcsOpe/this_nPesoVtsOpe/
*       this_nPrecoAutsOpe/this_nPrecoVtsOpe/this_nValPresOpe/
*       this_nVarsOpe/this_nAptpfatsOpe/this_nCheqsOpe/this_nCupfisOpe
*
* Flags recebidas do form pai na abertura (legado: plAltDireta,
* plAutomatico) -> this_lAltDireta/this_lAutomatico. poForm (referencia
* de UI) e a troca de DataSession ficam no FORM.
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigMvCab/SigCdOpe (os
* campos *Cab/*Ope acima) sera carregada por metodo proprio em fase
* posterior - os valores abaixo ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para a CONDICAO/PARCELA de SigMvPar (chave cidchaves), com
* RegistrarAuditoria() (herdado de BusinessBase) chamado em
* Inserir/Atualizar. cidchaves e a chave Fortyus (fUniqueIds(), regra
* #22) gerada no Inserir quando ainda vazia; empdopnums e a chave
* posicional Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito,
* nunca ALLTRIM nas partes).
*
* Fase 7/8 - CarregarConfiguracao() (SigMvCab/SigCdOpe, equivalentes aos
* cursores que o FORM PAI legado ja tinha abertos - regra #35/cabecalho
* acima), CarregarCondicoes() (leitura de SigMvPar para a grade - o
* legado faz isso via AddCursor no Init do pai; aqui e feito por SQLEXEC
* em cursor temporario + ZAP/APPEND no cursor ja ligado ao Grid, regra
* "SQLEXEC sobre alias de grid zera o ColumnCount") e ExcluirCondicao()
* (DELETE por cidchaves, chamado pelo Apaga.Click do form quando a linha
* corrente ja foi persistida em SigMvPar).
*====================================================================

DEFINE CLASS sigoppagBO AS BusinessBase

	*-- Flags recebidas do form pai na abertura (legado: Lparameters
	*-- pForm, datses, plAltDireta, plAutomatico). poForm (referencia de
	*-- UI) e a troca de DataSession ficam no Form.
	this_lAltDireta = .F.           && plAltDireta - fluxo de alteracao direta da condicao (pula parte da validacao de limite)
	this_lAutomatico = .F.          && plAutomatico - fluxo automatico (sem interacao do usuario, ex.: TEF/cartao processado por integracao)

	*-- Identificacao do cabecalho do movimento (legado: TprMvCab.Emps/
	*-- Dopes/Numes, compartilhados pela DataSession do pai). O form
	*-- migrado repassa so os valores escalares - mesmos valores que
	*-- aparecem tambem em cada linha de SigMvPar (emps/dopes/numes).
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps / SigMvPar.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes / SigMvPar.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes / SigMvPar.numes)

	*-- Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+
	*-- Numes acima. Sufixo "Cab" para nao colidir com propriedade de
	*-- mesmo nome da linha de SigMvPar (ex.: valos). Populados em fase
	*-- posterior (leitura via SQLEXEC); default abaixo.
	this_cContaOsCab = ""           && TprMvCab.ContaOs - conta de origem do movimento (credito a estornar/base de calculo)
	this_cContaDsCab = ""           && TprMvCab.ContaDs - conta de destino do movimento (cliente/fornecedor, usado em Chklimite/CursorQuery de SigCdCli)
	this_dDatasCab = {}             && TprMvCab.Datas - data do movimento, base do vencimento default da parcela
	this_cNotasCab = ""             && TprMvCab.Notas - numero/mascara da nota fiscal do movimento (usado na mensagem de confirmacao do Ok.Click)
	this_dPrazoEntsCab = {}         && TprMvCab.PrazoEnts - prazo de entrega, usado como base alternativa do vencimento quando CrSigOpFp.TpVencs = 2
	this_cTabDsCab = ""             && TprMvCab.TabDs - tabela de preco de destino (char(10) no schema - SigMvCab.tabds)
	this_cTpFatsCab = ""            && TprMvCab.TpFats - tipo de faturamento do movimento (char(3) no schema - SigMvCab.tpfats; chave de SigCdTif.Codigos no Ok.Click)
	this_nValDevsCab = 0            && TprMvCab.ValDevs - valor de devolucao (usado no calculo do total a receber quando Vars = 4)
	this_nValEncsCab = 0            && TprMvCab.ValEncs - valor de encargos do movimento
	this_nValInisCab = 0            && TprMvCab.ValInis - valor inicial do movimento (base de calculo de desconto/acrescimo)
	this_nValServsCab = 0           && TprMvCab.ValServs - valor total de servicos do movimento (somado ao valor de produto no calculo de variacao)
	this_nValTransCab = 0           && TprMvCab.ValTrans - valor de transporte/frete do movimento
	this_nValUtiCshCab = 0          && TprMvCab.ValUtiCsh - valor de cashback/bonus utilizado no movimento
	this_nValVarPsCab = 0           && TprMvCab.ValVarPs - percentual de variacao (desconto/acrescimo) aplicado ao movimento
	this_nValVarsCab = 0            && TprMvCab.ValVars - valor de variacao (desconto negativo/acrescimo positivo) do movimento
	this_nValosCab = 0              && TprMvCab.Valos - valor total do movimento (a ratear entre as condicoes de pagamento)
	this_nVarTotsCab = 0            && TprMvCab.VarTots - total de variacao acumulado do movimento
	this_nVarsCab = 0               && TprMvCab.Vars - percentual de variacao do movimento (espelha ValVarPs em alguns pontos do legado)

	*-- Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
	*-- Sufixo "Ope" pelo mesmo motivo de colisao de nomes (Vars/parcs
	*-- tambem existem em outras origens). Populados em fase posterior;
	*-- default abaixo.
	this_nBlqDatasOpe = 0           && SigCdOpe.BlqDatas - bloqueia alteracao de vencimento (1=sempre, 3=so para tras) no Valid de Dataget_venc
	this_cCMoesOpe = ""             && SigCdOpe.CMoes - moeda padrao da operacao (usada na cotacao de moeda da operacao x moeda de pagamento)
	this_nCopersOpe = 0             && SigCdOpe.COpers - tipo de calculo de troco/complemento (1=debita da conta, 2=credita)
	this_nCaixasOpe = 0             && SigCdOpe.Caixas - 1 = operacao movimenta caixa (habilita protocolo de cheque obrigatorio)
	this_nConfesOpe = 0             && SigCdOpe.Confes - 1 = condicao de pagamento ja confirmada (desabilita cartao de credito manual)
	this_nDeacrsOpe = 0             && SigCdOpe.Deacrs - habilita os containers de desconto/acrescimo manual (Get_PorcVariacao/Get_TotVariacao)
	this_nDtEntrsOpe = 0            && SigCdOpe.DtEntrs - habilita uso do prazo de entrega como base alternativa do vencimento (confirmar tipo exato no schema)
	this_nEdComisOpe = 0            && SigCdOpe.EdComis - habilita edicao manual do numero de parcelas (Get_npar)
	this_cFPagOpCrsOpe = ""         && SigCdOpe.FPagOpCrs - forma de pagamento padrao/credito da operacao (usada em Apaga.Click/comparacoes de forma)
	this_nHabServsOpe = 0           && SigCdOpe.HabServs - habilita o campo de total de servicos (Get_TotServico)
	this_nLPrecosOpe = 0            && SigCdOpe.LPrecos - operacao usa lista de precos (afeta regra de variacao/desconto)
	this_nOpersOpe = 0              && SigCdOpe.Opers - 1=Entrada/2=Saida, direcao da operacao
	this_nParRecalsOpe = 0          && SigCdOpe.ParRecals - recalcula parcelas automaticamente ao mudar o valor
	this_nParcsOpe = 0              && SigCdOpe.parcs - 1 = operacao permite parcelamento (habilita Get_npar/Get_vpar)
	this_nPesoVtsOpe = 0            && SigCdOpe.PesoVts - operacao totaliza por peso (usado em Bot_TotItem.Click)
	this_nPrecoAutsOpe = 0          && SigCdOpe.PrecoAuts - autoriza precificacao automatica (espelha o uso em outros BOs de item)
	this_nPrecoVtsOpe = 0           && SigCdOpe.PrecoVts - operacao totaliza por valor de venda (usado em Bot_TotItem.Click)
	this_nValPresOpe = 0            && SigCdOpe.ValPres - operacao exige valor presente (desconta juros/calcula a valor presente)
	this_nVarsOpe = 0               && SigCdOpe.Vars - tipo de variacao permitido na operacao (3 = bloqueia Desconto/Acrescimo)
	this_nAptpfatsOpe = 0           && SigCdOpe.aptpfats - tipo de fatura/apuracao da operacao
	this_nCheqsOpe = 0              && SigCdOpe.cheqs - operacao aceita cheque como forma de pagamento
	this_nCupfisOpe = 0             && SigCdOpe.cupfis - 3 = cupom fiscal/nao fiscal (regras de TEF e bloqueio de valor zero)
	this_nParAutosOpe = 0           && SigCdOpe.parautos - 4 = bloqueia exclusao de condicao InsChs (Apaga.Click); 5 = bloqueia o proprio botao Apaga (regra externa ao Click, nao portada nesta fase)

	*-- Nome do cursor que este BO popula/consome (constante, para o Form
	*-- referenciar sem repetir literal - equivalente ao alias global do
	*-- legado xPar)
	this_cCursorCondicoes = "cursor_4c_Condicoes"  && Grade de condicoes de pagamento do movimento (SigMvPar)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela
	*-- SigMvPar - uma CONDICAO/PARCELA de pagamento do movimento, chave
	*-- cidchaves). this_cEmps/this_cDopes/this_nNumes acima JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cAgencias     = ""   && agencias char(4) - agencia bancaria do cheque
	this_cBancos       = ""   && bancos char(3) - banco do cheque
	this_cCartaos      = ""   && cartaos char(20) - numero do cartao de credito
	this_cContas       = ""   && contas char(10) - conta bancaria do cheque
	this_nCotfpgs      = 0    && cotfpgs numeric(11,4) - cotacao da moeda de pagamento na data da condicao
	this_dDatas        = {}   && datas datetime - data da condicao (preenchimento conforme regra de negocio da operacao)
	this_dDatatrans    = {}   && datatrans datetime - data da transacao (TEF/cartao)
	this_cDcarts       = ""   && dcarts char(12) - data de validade do cartao (MM/AAAA ou similar, mascara do legado)
	this_nEcNumes      = 0    && ec_numes numeric(6,0) - numero do comprovante eletronico de cheque (DOC/TED)
	this_cFpags        = ""   && fpags char(12) - codigo da forma de pagamento (SigOpFp.Fpags)
	this_cGrclis       = ""   && grclis char(10) - grupo do cliente/conta na data da condicao
	this_cIclis        = ""   && iclis char(10) - codigo da conta (cliente/fornecedor) associada a condicao
	this_cImpcars      = ""   && impcars char(1) - indicador de impressao do carne/boleto
	this_lInschs       = .F.  && inschs bit - condicao inserida via leitor de cheque (insercao automatica)
	this_cLocals       = ""   && locals char(10) - local/filial de recebimento
	this_cMoefpgs      = ""   && moefpgs char(3) - moeda da forma de pagamento
	this_cNcarnes      = ""   && ncarnes char(11) - numero do carne de pagamento
	this_nNcarts       = 0    && ncarts numeric(10,0) - numero sequencial de protocolo do cartao de credito
	this_nNcopias      = 0    && ncopias numeric(6,0) - numero de copias impressas do comprovante
	this_cNocreditos   = ""   && nocreditos char(10) - numero/codigo de aprovacao do credito (cartao/cheque pre-datado)
	this_nNopers       = 0    && nopers numeric(7,0) - numero da operacao de TEF/cartao
	this_nNrecs        = 0    && nrecs numeric(11,0) - numero do recibo gerado para a condicao
	this_nNtrans       = 0    && ntrans numeric(6,0) - numero da transacao (TEF)
	this_cNumchqs      = ""   && numchqs char(8) - numero do cheque
	this_cNumeros      = ""   && numeros char(6) - numero da conta bancaria do cheque (complemento de contas)
	this_nNumolds      = 0    && numolds numeric(6,0) - numero antigo/sequencia de regravacao da condicao (controle de aprovacao)
	this_cOutros       = ""   && outros char(20) - campo livre complementar da condicao
	this_nValos        = 0    && valos numeric(11,2) - valor da parcela/condicao de pagamento
	this_dVencs        = {}   && vencs datetime - data de vencimento da parcela
	this_nVpags        = 0    && vpags numeric(11,2) - valor efetivamente pago/recebido da parcela
	this_cCotusus      = ""   && cotusus char(30) - usuario que autorizou a cotacao manual
	this_cObs          = ""   && obs text - observacao da condicao de pagamento
	this_nParcs        = 0    && parcs numeric(2,0) - numero da parcela (sequencial dentro do total de parcelas)
	this_cCnidtefs     = ""   && cnidtefs char(10) - identificador da transacao TEF
	this_cCnnsuparcs   = ""   && cnnsuparcs char(12) - NSU da parcela (TEF/cartao)
	this_nNumlotechs   = 0    && numlotechs numeric(8,0) - numero do lote de cheques
	this_nNidcheps     = 0    && nidcheps numeric(10,0) - identificador do cheque pre-datado associado
	this_cEmpos        = ""   && empos char(3) - empresa de origem (quando a condicao se refere a outra empresa do grupo)
	this_cCidchaves    = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_nValocurs     = 0    && valocurs numeric(11,2) - valor da condicao convertido na moeda corrente
	this_nTrocos       = 0    && trocos numeric(1,0) - 1 = condicao representa troco/complemento devolvido ao cliente
	this_cEmpdopnums   = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga a condicao ao cabecalho (regra #42)
	this_cPagos        = ""   && pagos char(1) - indicador S/N de condicao ja liquidada
	this_dDtalts       = {}   && dtalts datetime - data da ultima alteracao da condicao
	this_cCpfs         = ""   && cpfs char(20) - CPF/CNPJ do titular do cartao/cheque, quando divergente da conta
	this_cDigagencs    = ""   && digagencs char(1) - digito verificador da agencia bancaria
	this_cDigchqs      = ""   && digchqs char(1) - digito verificador do cheque
	this_cDigcontas    = ""   && digcontas char(1) - digito verificador da conta bancaria
	this_cPracas       = ""   && pracas char(3) - praca bancaria do cheque
	this_nTparcs       = 0    && tparcs numeric(2,0) - total de parcelas da condicao (denominador de Parcs)
	this_nValdescs     = 0    && valdescs numeric(11,2) - valor de desconto aplicado a esta condicao
	this_cCodbcrts     = ""   && codbcrts char(5) - codigo da bandeira do cartao (SigCdCrt)
	this_lLcancelas    = .F.  && lcancelas bit - condicao cancelada (exclusao logica)
	this_nVcofins      = 0    && vcofins numeric(14,2) - valor de COFINS retido na condicao
	this_nVcsll        = 0    && vcsll numeric(14,2) - valor de CSLL retido na condicao
	this_nVirf         = 0    && virf numeric(14,2) - valor de IRF retido na condicao
	this_nVlrtrbfs     = 0    && vlrtrbfs numeric(14,2) - valor de tributo federal retido na condicao
	this_nVpis         = 0    && vpis numeric(14,2) - valor de PIS retido na condicao
	this_cAdquirente   = ""   && adquirente char(8) - codigo da adquirente do cartao (SigCdCad, tipocads = 'ADQUIRENTE')
	this_cAutoriza     = ""   && autoriza char(6) - codigo de autorizacao da transacao de cartao
	this_cNsu          = ""   && nsu char(50) - NSU (Numero Sequencial Unico) da transacao de cartao/TEF
	this_cChaveexterna = ""   && chaveexterna char(33) - chave de integracao externa (TEF/adquirente)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters pForm, datses, plAltDireta,
	* plAutomatico do Init do form legado - o form migrado repassa os
	* valores escalares que identificam o cabecalho do movimento
	* (par_cEmps/par_cDopes/par_nNumes, lidos pelo form a partir do
	* chamador) alem das duas flags de comportamento (poForm/datses, que
	* sao referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_lAltDireta, par_lAutomatico)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvPar"
		THIS.this_cCampoChave = "cidchaves"

		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF

		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF

		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		IF VARTYPE(par_lAltDireta) = "L"
			THIS.this_lAltDireta = par_lAltDireta
		ENDIF

		IF VARTYPE(par_lAutomatico) = "L"
			THIS.this_lAutomatico = par_lAutomatico
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia uma linha de SigMvPar (cursor populado por
	* SQLEXEC, ex.: this_cCursorCondicoes) para as properties desta
	* condicao/parcela. NAO eh PROTECTED (regra #51 - BusinessBase declara
	* publico e o Form chama direto ao posicionar a linha da grade).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cEmps         = TratarNulo(emps, "")
			THIS.this_cDopes        = TratarNulo(dopes, "")
			THIS.this_nNumes        = TratarNulo(numes, 0)
			THIS.this_cAgencias     = TratarNulo(agencias, "")
			THIS.this_cBancos       = TratarNulo(bancos, "")
			THIS.this_cCartaos      = TratarNulo(cartaos, "")
			THIS.this_cContas       = TratarNulo(contas, "")
			THIS.this_nCotfpgs      = TratarNulo(cotfpgs, 0)
			THIS.this_dDatas        = TratarNulo(datas, {})
			THIS.this_dDatatrans    = TratarNulo(datatrans, {})
			THIS.this_cDcarts       = TratarNulo(dcarts, "")
			THIS.this_nEcNumes      = TratarNulo(ec_numes, 0)
			THIS.this_cFpags        = TratarNulo(fpags, "")
			THIS.this_cGrclis       = TratarNulo(grclis, "")
			THIS.this_cIclis        = TratarNulo(iclis, "")
			THIS.this_cImpcars      = TratarNulo(impcars, "")
			THIS.this_lInschs       = ConverterParaLogico(inschs)
			THIS.this_cLocals       = TratarNulo(locals, "")
			THIS.this_cMoefpgs      = TratarNulo(moefpgs, "")
			THIS.this_cNcarnes      = TratarNulo(ncarnes, "")
			THIS.this_nNcarts       = TratarNulo(ncarts, 0)
			THIS.this_nNcopias      = TratarNulo(ncopias, 0)
			THIS.this_cNocreditos   = TratarNulo(nocreditos, "")
			THIS.this_nNopers       = TratarNulo(nopers, 0)
			THIS.this_nNrecs        = TratarNulo(nrecs, 0)
			THIS.this_nNtrans       = TratarNulo(ntrans, 0)
			THIS.this_cNumchqs      = TratarNulo(numchqs, "")
			THIS.this_cNumeros      = TratarNulo(numeros, "")
			THIS.this_nNumolds      = TratarNulo(numolds, 0)
			THIS.this_cOutros       = TratarNulo(outros, "")
			THIS.this_nValos        = TratarNulo(valos, 0)
			THIS.this_dVencs        = TratarNulo(vencs, {})
			THIS.this_nVpags        = TratarNulo(vpags, 0)
			THIS.this_cCotusus      = TratarNulo(cotusus, "")
			THIS.this_cObs          = TratarNulo(obs, "")
			THIS.this_nParcs        = TratarNulo(parcs, 0)
			THIS.this_cCnidtefs     = TratarNulo(cnidtefs, "")
			THIS.this_cCnnsuparcs   = TratarNulo(cnnsuparcs, "")
			THIS.this_nNumlotechs   = TratarNulo(numlotechs, 0)
			THIS.this_nNidcheps     = TratarNulo(nidcheps, 0)
			THIS.this_cEmpos        = TratarNulo(empos, "")
			THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
			THIS.this_nValocurs     = TratarNulo(valocurs, 0)
			THIS.this_nTrocos       = TratarNulo(trocos, 0)
			THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
			THIS.this_cPagos        = TratarNulo(pagos, "")
			THIS.this_dDtalts       = TratarNulo(dtalts, {})
			THIS.this_cCpfs         = TratarNulo(cpfs, "")
			THIS.this_cDigagencs    = TratarNulo(digagencs, "")
			THIS.this_cDigchqs      = TratarNulo(digchqs, "")
			THIS.this_cDigcontas    = TratarNulo(digcontas, "")
			THIS.this_cPracas       = TratarNulo(pracas, "")
			THIS.this_nTparcs       = TratarNulo(tparcs, 0)
			THIS.this_nValdescs     = TratarNulo(valdescs, 0)
			THIS.this_cCodbcrts     = TratarNulo(codbcrts, "")
			THIS.this_lLcancelas    = ConverterParaLogico(lcancelas)
			THIS.this_nVcofins      = TratarNulo(vcofins, 0)
			THIS.this_nVcsll        = TratarNulo(vcsll, 0)
			THIS.this_nVirf         = TratarNulo(virf, 0)
			THIS.this_nVlrtrbfs     = TratarNulo(vlrtrbfs, 0)
			THIS.this_nVpis         = TratarNulo(vpis, 0)
			THIS.this_cAdquirente   = TratarNulo(adquirente, "")
			THIS.this_cAutoriza     = TratarNulo(autoriza, "")
			THIS.this_cNsu          = TratarNulo(nsu, "")
			THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
	* nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*====================================================================
	* Inserir - INSERT completo em SigMvPar (condicao/parcela do
	* movimento). cidchaves (PK) e gerada aqui se ainda vazia (regra #22
	* - fUniqueIds(), NUNCA string vazia). empdopnums e a chave posicional
	* Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito, NUNCA
	* ALLTRIM nas partes). dpags/dtdeps (datetime NULL, sem uso no
	* codigo legado analisado) ficam fora da lista - SQL Server grava
	* NULL por omissao, o que e permitido pelo schema.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		IF EMPTY(THIS.this_cCidchaves)
			THIS.this_cCidchaves = fUniqueIds()
		ENDIF

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigMvPar (
					emps, dopes, numes, agencias, bancos, cartaos, contas, cotfpgs,
					datas, datatrans, dcarts, ec_numes, fpags, grclis, iclis, impcars,
					inschs, locals, moefpgs, ncarnes, ncarts, ncopias, nocreditos,
					nopers, nrecs, ntrans, numchqs, numeros, numolds, outros, valos,
					vencs, vpags, cotusus, obs, parcs, cnidtefs, cnnsuparcs,
					numlotechs, nidcheps, empos, cidchaves, valocurs, trocos,
					empdopnums, pagos, dtalts, cpfs, digagencs, digchqs, digcontas,
					pracas, tparcs, valdescs, codbcrts, lcancelas, vcofins, vcsll,
					virf, vlrtrbfs, vpis, adquirente, autoriza, nsu, chaveexterna
				)
				VALUES (
					<<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					<<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					<<FormatarDataSQL(THIS.this_dDatas)>>,
					<<FormatarDataSQL(THIS.this_dDatatrans)>>,
					<<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					<<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					<<IIF(THIS.this_lInschs, "1", "0")>>,
					<<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					<<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					<<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					<<FormatarDataSQL(THIS.this_dVencs)>>,
					<<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					<<EscaparSQL(THIS.this_cObs)>>,
					<<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					<<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					<<FormatarDataSQL(THIS.this_dDtalts)>>,
					<<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					<<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					<<IIF(THIS.this_lLcancelas, "1", "0")>>,
					<<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					<<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					<<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERIR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE completo em SigMvPar pela PK cidchaves. emps/
	* dopes/numes/cidchaves identificam o registro e NAO entram no SET.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigMvPar SET
					agencias     = <<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					bancos       = <<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					cartaos      = <<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					contas       = <<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					cotfpgs      = <<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					datas        = <<FormatarDataSQL(THIS.this_dDatas)>>,
					datatrans    = <<FormatarDataSQL(THIS.this_dDatatrans)>>,
					dcarts       = <<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					ec_numes     = <<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					fpags        = <<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					grclis       = <<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					iclis        = <<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					impcars      = <<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					inschs       = <<IIF(THIS.this_lInschs, "1", "0")>>,
					locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					moefpgs      = <<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					ncarnes      = <<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					ncarts       = <<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					ncopias      = <<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					nocreditos   = <<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					nopers       = <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					nrecs        = <<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					numchqs      = <<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					numeros      = <<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					outros       = <<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					valos        = <<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					vencs        = <<FormatarDataSQL(THIS.this_dVencs)>>,
					vpags        = <<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					cotusus      = <<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					obs          = <<EscaparSQL(THIS.this_cObs)>>,
					parcs        = <<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					cnidtefs     = <<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					cnnsuparcs   = <<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					numlotechs   = <<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					nidcheps     = <<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					valocurs     = <<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					trocos       = <<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					pagos        = <<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					dtalts       = <<FormatarDataSQL(THIS.this_dDtalts)>>,
					cpfs         = <<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					digagencs    = <<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					digchqs      = <<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					digcontas    = <<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					pracas       = <<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					tparcs       = <<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					codbcrts     = <<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					lcancelas    = <<IIF(THIS.this_lLcancelas, "1", "0")>>,
					vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					vcsll        = <<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					virf         = <<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					vlrtrbfs     = <<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					adquirente   = <<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					autoriza     = <<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					nsu          = <<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("ALTERAR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - le o cabecalho do movimento (TprMvCab, cursor
	* que o FORM PAI legado ja deixa aberto na DataSession compartilhada -
	* regra #35/cabecalho do topo deste arquivo) e a configuracao da
	* operacao (SigCdOpe, via SQLEXEC por Dopes). Chamado pelo Form logo
	* apos instanciar o BO, ANTES de CarregarCondicoes()/CarregarLista().
	*
	* TprMvCab e um cursor MONTADO pelo form pai (nao necessariamente
	* 1-para-1 com as colunas de SigMvCab) - por isso cada leitura e
	* guardada por TYPE() != "U": campo ausente la NAO e erro aqui, so
	* mantem o default ja declarado na propriedade.
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			IF USED("TprMvCab")
				SELECT TprMvCab
				IF RECCOUNT() > 0 AND !EOF()
					IF TYPE("TprMvCab.contaos") != "U"
						THIS.this_cContaOsCab = TratarNulo(contaos, "")
					ENDIF
					IF TYPE("TprMvCab.contads") != "U"
						THIS.this_cContaDsCab = TratarNulo(contads, "")
					ENDIF
					IF TYPE("TprMvCab.datas") != "U"
						THIS.this_dDatasCab = TratarNulo(datas, {})
					ENDIF
					IF TYPE("TprMvCab.notas") != "U"
						THIS.this_cNotasCab = TratarNulo(notas, "")
					ENDIF
					IF TYPE("TprMvCab.prazoents") != "U"
						THIS.this_dPrazoEntsCab = TratarNulo(prazoents, {})
					ENDIF
					IF TYPE("TprMvCab.tabds") != "U"
						THIS.this_cTabDsCab = TratarNulo(tabds, "")
					ENDIF
					IF TYPE("TprMvCab.tpfats") != "U"
						THIS.this_cTpFatsCab = TratarNulo(tpfats, "")
					ENDIF
					IF TYPE("TprMvCab.valdevs") != "U"
						THIS.this_nValDevsCab = TratarNulo(valdevs, 0)
					ENDIF
					IF TYPE("TprMvCab.valencs") != "U"
						THIS.this_nValEncsCab = TratarNulo(valencs, 0)
					ENDIF
					IF TYPE("TprMvCab.valinis") != "U"
						THIS.this_nValInisCab = TratarNulo(valinis, 0)
					ENDIF
					IF TYPE("TprMvCab.valservs") != "U"
						THIS.this_nValServsCab = TratarNulo(valservs, 0)
					ENDIF
					IF TYPE("TprMvCab.valtrans") != "U"
						THIS.this_nValTransCab = TratarNulo(valtrans, 0)
					ENDIF
					IF TYPE("TprMvCab.valuticsh") != "U"
						THIS.this_nValUtiCshCab = TratarNulo(valuticsh, 0)
					ENDIF
					IF TYPE("TprMvCab.valvarps") != "U"
						THIS.this_nValVarPsCab = TratarNulo(valvarps, 0)
					ENDIF
					IF TYPE("TprMvCab.valvars") != "U"
						THIS.this_nValVarsCab = TratarNulo(valvars, 0)
					ENDIF
					IF TYPE("TprMvCab.valos") != "U"
						THIS.this_nValosCab = TratarNulo(valos, 0)
					ENDIF
					IF TYPE("TprMvCab.vartots") != "U"
						THIS.this_nVarTotsCab = TratarNulo(vartots, 0)
					ENDIF
					IF TYPE("TprMvCab.vars") != "U"
						THIS.this_nVarsCab = TratarNulo(vars, 0)
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SigCdOpeTmp")
				USE IN cursor_4c_SigCdOpeTmp
			ENDIF

			IF !EMPTY(THIS.this_cDopes)
				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT blqdatas, cmoes, copers, caixas, confes, deacrs, dtentrs,
						   edcomis, fpagopcrs, habservs, lprecos, opers, parrecals,
						   parcs, pesovts, precoauts, precovts, valpres, vars,
						   aptpfats, cheqs, cupfis, parautos
					FROM SigCdOpe
					WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeTmp")

				IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdOpeTmp") AND !EOF("cursor_4c_SigCdOpeTmp")
					SELECT cursor_4c_SigCdOpeTmp
					THIS.this_nBlqDatasOpe  = TratarNulo(blqdatas, 0)
					THIS.this_cCMoesOpe     = TratarNulo(cmoes, "")
					THIS.this_nCopersOpe    = TratarNulo(copers, 0)
					THIS.this_nCaixasOpe    = TratarNulo(caixas, 0)
					THIS.this_nConfesOpe    = TratarNulo(confes, 0)
					THIS.this_nDeacrsOpe    = TratarNulo(deacrs, 0)
					THIS.this_nDtEntrsOpe   = TratarNulo(dtentrs, 0)
					THIS.this_nEdComisOpe   = TratarNulo(edcomis, 0)
					THIS.this_cFPagOpCrsOpe = TratarNulo(fpagopcrs, "")
					THIS.this_nHabServsOpe  = TratarNulo(habservs, 0)
					THIS.this_nLPrecosOpe   = TratarNulo(lprecos, 0)
					THIS.this_nOpersOpe     = TratarNulo(opers, 0)
					THIS.this_nParRecalsOpe = TratarNulo(parrecals, 0)
					THIS.this_nParcsOpe     = TratarNulo(parcs, 0)
					THIS.this_nPesoVtsOpe   = TratarNulo(pesovts, 0)
					THIS.this_nPrecoAutsOpe = TratarNulo(precoauts, 0)
					THIS.this_nPrecoVtsOpe  = TratarNulo(precovts, 0)
					THIS.this_nValPresOpe   = TratarNulo(valpres, 0)
					THIS.this_nVarsOpe      = TratarNulo(vars, 0)
					THIS.this_nAptpfatsOpe  = TratarNulo(aptpfats, 0)
					THIS.this_nCheqsOpe     = TratarNulo(cheqs, 0)
					THIS.this_nCupfisOpe    = TratarNulo(cupfis, 0)
					THIS.this_nParAutosOpe  = TratarNulo(parautos, 0)
				ENDIF

				IF USED("cursor_4c_SigCdOpeTmp")
					USE IN cursor_4c_SigCdOpeTmp
				ENDIF
			ENDIF

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o do movimento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarConfiguracao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarCondicoes - porta PARCIAL do carregamento de condicoes de
	* SigMvPar para a grade. No legado isso e feito pelo FORM PAI, via
	* AddCursor no seu proprio Init, deixando xPar ja aberto e
	* compartilhado com este form filho (regra #35/cabecalho). Quando este
	* form roda ISOLADO (sem pai - modo de teste/validacao de UI), xPar
	* nao existe: este metodo busca SigMvPar por Emps+Dopes+Numes via
	* SQLEXEC e substitui o CONTEUDO do cursor_4c_Condicoes (ja criado e
	* ligado ao Grid por Formsigoppag::ConfigurarGrid) SEM refazer a
	* estrutura - SQLEXEC direto no alias do grid zeraria o ColumnCount.
	*====================================================================
	PROCEDURE CarregarCondicoes()
		LOCAL loc_cSQL, loc_nResultado, loc_cCursorTmp, loc_lSucesso, loc_oErro

		loc_lSucesso   = .F.
		loc_cCursorTmp = "cursor_4c_CondicoesTmp"

		IF !USED(THIS.this_cCursorCondicoes)
			RETURN loc_lSucesso
		ENDIF

		TRY
			IF USED(loc_cCursorTmp)
				USE IN (loc_cCursorTmp)
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cidchaves, emps, dopes, numes, fpags, valos, vencs,
					   moefpgs, cotfpgs, valdescs, inschs, numchqs, nidcheps, trocos
				FROM SigMvPar
				WHERE emps = <<EscaparSQL(THIS.this_cEmps)>>
				  AND dopes = <<EscaparSQL(THIS.this_cDopes)>>
				  AND numes = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>
				ORDER BY vencs
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

			IF loc_nResultado >= 0 AND USED(loc_cCursorTmp)
				SELECT (THIS.this_cCursorCondicoes)
				ZAP
				APPEND FROM (DBF(loc_cCursorTmp))

				USE IN (loc_cCursorTmp)

				SELECT (THIS.this_cCursorCondicoes)
				GO TOP

				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarCondicoes")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirCondicao - DELETE direto em SigMvPar pela PK cidchaves, usado
	* pelo Apaga.Click do form (regra #22 - cidchaves e a PK Fortyus).
	* Linha que nunca foi persistida (cidchaves ainda vazio) nao precisa de
	* DELETE remoto - retorna sucesso sem tocar no banco.
	*====================================================================
	PROCEDURE ExcluirCondicao(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		IF EMPTY(par_cCidchaves)
			RETURN .T.
		ENDIF

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				DELETE FROM SigMvPar WHERE cidchaves = <<EscaparSQL(LEFT(par_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.ExcluirCondicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

