# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, OPCRS, CITENS, VNITEM, BAIXADO, VALDESCS, CUPFIS, LNTENTA, MESVENCS, VENCS, DIGITENS, IMPS, IF, ORDEMS, FPAGS, NCODFINZS, DOPES, PDATAIMP, SERIFAB, DATAS, NEMPS, CODS, LCSTR, LLERROR1, CIMPFABS, EMPS, VERSTATUS, CNCAIXAS, CODOPERS, OPERADOR, CDOPES, TIPOS, ICLIS, PRECOPS, 0, CBARS, EAN13, LPRECOS, IFORS, PVENS, CODBARRAS, ALTETIQS, ESTOQS, OPERS, SITUAS, BARINDIVS, CODIGOS, BARREFS, QTDS, EPRECOS, CHKDVAL, VALUE, CITEM, INFORMADO, CHKEDESC, LNKEY, LNPARCA, NBARRA1, NBARRA2, PEANTVALUE, NDOPES, EMPDOPNUMS, NOTAS, CIDCHAVES, LNBXVLOPCRS, SUBNOBRIGS, _OLDCODG, EMPSUBNS, VALVARS, VARPS, NCARBXS, LCANCELAS, CHKSUBN, CHKPAGOS, DTAGENDS, PQTDES, PVALORS, NDEBITOS, _CHECAAGENDA, SUBNS, OPEATU, CHECPAGOS, UTILIZADOS, _NDDVAL, GRVENDS, GRRESPS, NCARDSCS, PARAUTOS, _OPERITENS, ACUMULAS, INFOS, CCUPOMNVS, OBSDESTS, DISPMOVS, BLQDESCS, CPFS, GRUPOS, CGC1, OP_ESCOLHA, EMPRELEVS, QT, DESCOS, TABDOBRIGS, QTDVALID, OBSORIGS, DEACRS, PARCS, ACVCHQS, FPARCS, NPARCS, PARCDES, SISTEF, CNNSUS, CHEADERS, SENDTEF, LCTIPO, LCTIPOOK, TVENS, TROCOS, LNVALP, DESCS, LNVPAR, VALPRES, GRUCONMOES, NCHAVES, LNTPAR, CARAUTS, VALOS, CGC, _TTOP, IMPCUPF, HABPENDS, CSTATUS, CNIDENTS, CNIDTEFS, CTIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DECLARADO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, OPCRS, CITENS, VNITEM, BAIXADO, VALDESCS, CUPFIS, LNTENTA, MESVENCS, VENCS, DIGITENS, IMPS, IF, ORDEMS, FPAGS, NCODFINZS, DOPES, PDATAIMP, SERIFAB, DATAS, NEMPS, CODS, LCSTR, LLERROR1, CIMPFABS, EMPS, VERSTATUS, CNCAIXAS, CODOPERS, OPERADOR, CDOPES, TIPOS, ICLIS, PRECOPS, 0, CBARS, EAN13, LPRECOS, IFORS, PVENS, CODBARRAS, ALTETIQS, ESTOQS, OPERS, SITUAS, BARINDIVS, CODIGOS, BARREFS, QTDS, EPRECOS, CHKDVAL, VALUE, CITEM, INFORMADO, CHKEDESC, LNKEY, LNPARCA, NBARRA1, NBARRA2, PEANTVALUE, NDOPES, EMPDOPNUMS, NOTAS, CIDCHAVES, LNBXVLOPCRS, SUBNOBRIGS, _OLDCODG, EMPSUBNS, VALVARS, VARPS, NCARBXS, LCANCELAS, CHKSUBN, CHKPAGOS, DTAGENDS, PQTDES, PVALORS, NDEBITOS, _CHECAAGENDA, SUBNS, OPEATU, CHECPAGOS, UTILIZADOS, _NDDVAL, GRVENDS, GRRESPS, NCARDSCS, PARAUTOS, _OPERITENS, ACUMULAS, INFOS, CCUPOMNVS, OBSDESTS, DISPMOVS, BLQDESCS, CPFS, GRUPOS, CGC1, OP_ESCOLHA, EMPRELEVS, QT, DESCOS, TABDOBRIGS, QTDVALID, OBSORIGS, DEACRS, PARCS, ACVCHQS, FPARCS, NPARCS, PARCDES, SISTEF, CNNSUS, CHEADERS, SENDTEF, LCTIPO, LCTIPOOK, TVENS, TROCOS, LNVALP, DESCS, LNVPAR, VALPRES, GRUCONMOES, NCHAVES, LNTPAR, CARAUTS, VALOS, CGC, _TTOP, IMPCUPF, HABPENDS, CSTATUS, CNIDENTS, CNIDTEFS, CTIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TMPBARF' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, OPCRS, CITENS, VNITEM, BAIXADO, VALDESCS, CUPFIS, LNTENTA, MESVENCS, VENCS, DIGITENS, IMPS, IF, ORDEMS, FPAGS, NCODFINZS, DOPES, PDATAIMP, SERIFAB, DATAS, NEMPS, CODS, LCSTR, LLERROR1, CIMPFABS, EMPS, VERSTATUS, CNCAIXAS, CODOPERS, OPERADOR, CDOPES, TIPOS, ICLIS, PRECOPS, 0, CBARS, EAN13, LPRECOS, IFORS, PVENS, CODBARRAS, ALTETIQS, ESTOQS, OPERS, SITUAS, BARINDIVS, CODIGOS, BARREFS, QTDS, EPRECOS, CHKDVAL, VALUE, CITEM, INFORMADO, CHKEDESC, LNKEY, LNPARCA, NBARRA1, NBARRA2, PEANTVALUE, NDOPES, EMPDOPNUMS, NOTAS, CIDCHAVES, LNBXVLOPCRS, SUBNOBRIGS, _OLDCODG, EMPSUBNS, VALVARS, VARPS, NCARBXS, LCANCELAS, CHKSUBN, CHKPAGOS, DTAGENDS, PQTDES, PVALORS, NDEBITOS, _CHECAAGENDA, SUBNS, OPEATU, CHECPAGOS, UTILIZADOS, _NDDVAL, GRVENDS, GRRESPS, NCARDSCS, PARAUTOS, _OPERITENS, ACUMULAS, INFOS, CCUPOMNVS, OBSDESTS, DISPMOVS, BLQDESCS, CPFS, GRUPOS, CGC1, OP_ESCOLHA, EMPRELEVS, QT, DESCOS, TABDOBRIGS, QTDVALID, OBSORIGS, DEACRS, PARCS, ACVCHQS, FPARCS, NPARCS, PARCDES, SISTEF, CNNSUS, CHEADERS, SENDTEF, LCTIPO, LCTIPOOK, TVENS, TROCOS, LNVALP, DESCS, LNVPAR, VALPRES, GRUCONMOES, NCHAVES, LNTPAR, CARAUTS, VALOS, CGC, _TTOP, IMPCUPF, HABPENDS, CSTATUS, CNIDENTS, CNIDTEFS, CTIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, OPCRS, CITENS, VNITEM, BAIXADO, VALDESCS, CUPFIS, LNTENTA, MESVENCS, VENCS, DIGITENS, IMPS, IF, ORDEMS, FPAGS, NCODFINZS, DOPES, PDATAIMP, SERIFAB, DATAS, NEMPS, CODS, LCSTR, LLERROR1, CIMPFABS, EMPS, VERSTATUS, CNCAIXAS, CODOPERS, OPERADOR, CDOPES, TIPOS, ICLIS, PRECOPS, 0, CBARS, EAN13, LPRECOS, IFORS, PVENS, CODBARRAS, ALTETIQS, ESTOQS, OPERS, SITUAS, BARINDIVS, CODIGOS, BARREFS, QTDS, EPRECOS, CHKDVAL, VALUE, CITEM, INFORMADO, CHKEDESC, LNKEY, LNPARCA, NBARRA1, NBARRA2, PEANTVALUE, NDOPES, EMPDOPNUMS, NOTAS, CIDCHAVES, LNBXVLOPCRS, SUBNOBRIGS, _OLDCODG, EMPSUBNS, VALVARS, VARPS, NCARBXS, LCANCELAS, CHKSUBN, CHKPAGOS, DTAGENDS, PQTDES, PVALORS, NDEBITOS, _CHECAAGENDA, SUBNS, OPEATU, CHECPAGOS, UTILIZADOS, _NDDVAL, GRVENDS, GRRESPS, NCARDSCS, PARAUTOS, _OPERITENS, ACUMULAS, INFOS, CCUPOMNVS, OBSDESTS, DISPMOVS, BLQDESCS, CPFS, GRUPOS, CGC1, OP_ESCOLHA, EMPRELEVS, QT, DESCOS, TABDOBRIGS, QTDVALID, OBSORIGS, DEACRS, PARCS, ACVCHQS, FPARCS, NPARCS, PARCDES, SISTEF, CNNSUS, CHEADERS, SENDTEF, LCTIPO, LCTIPOOK, TVENS, TROCOS, LNVALP, DESCS, LNVPAR, VALPRES, GRUCONMOES, NCHAVES, LNTPAR, CARAUTS, VALOS, CGC, _TTOP, IMPCUPF, HABPENDS, CSTATUS, CNIDENTS, CNIDTEFS, CTIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ALIGNMENT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, OPCRS, CITENS, VNITEM, BAIXADO, VALDESCS, CUPFIS, LNTENTA, MESVENCS, VENCS, DIGITENS, IMPS, IF, ORDEMS, FPAGS, NCODFINZS, DOPES, PDATAIMP, SERIFAB, DATAS, NEMPS, CODS, LCSTR, LLERROR1, CIMPFABS, EMPS, VERSTATUS, CNCAIXAS, CODOPERS, OPERADOR, CDOPES, TIPOS, ICLIS, PRECOPS, 0, CBARS, EAN13, LPRECOS, IFORS, PVENS, CODBARRAS, ALTETIQS, ESTOQS, OPERS, SITUAS, BARINDIVS, CODIGOS, BARREFS, QTDS, EPRECOS, CHKDVAL, VALUE, CITEM, INFORMADO, CHKEDESC, LNKEY, LNPARCA, NBARRA1, NBARRA2, PEANTVALUE, NDOPES, EMPDOPNUMS, NOTAS, CIDCHAVES, LNBXVLOPCRS, SUBNOBRIGS, _OLDCODG, EMPSUBNS, VALVARS, VARPS, NCARBXS, LCANCELAS, CHKSUBN, CHKPAGOS, DTAGENDS, PQTDES, PVALORS, NDEBITOS, _CHECAAGENDA, SUBNS, OPEATU, CHECPAGOS, UTILIZADOS, _NDDVAL, GRVENDS, GRRESPS, NCARDSCS, PARAUTOS, _OPERITENS, ACUMULAS, INFOS, CCUPOMNVS, OBSDESTS, DISPMOVS, BLQDESCS, CPFS, GRUPOS, CGC1, OP_ESCOLHA, EMPRELEVS, QT, DESCOS, TABDOBRIGS, QTDVALID, OBSORIGS, DEACRS, PARCS, ACVCHQS, FPARCS, NPARCS, PARCDES, SISTEF, CNNSUS, CHEADERS, SENDTEF, LCTIPO, LCTIPOOK, TVENS, TROCOS, LNVALP, DESCS, LNVPAR, VALPRES, GRUCONMOES, NCHAVES, LNTPAR, CARAUTS, VALOS, CGC, _TTOP, IMPCUPF, HABPENDS, CSTATUS, CNIDENTS, CNIDTEFS, CTIPOS

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
  Picture = ..\vbmp\a_delete1.bmp
  ControlSource = "TprMvCab.ValInis"
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = "TprMvCab.grupods"
  ControlSource = "TprMvCab.contads"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCab.Resps"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCab.GrResps"
  ControlSource = "TprMvCab.vends"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCab.grvends"
  ControlSource = "TprMvCab.tabds"
  ControlSource = "TprMvCab.LPrecos"
  ControlSource = "TprMvCab.mascnum"
  ControlSource = "TprMvCab.nPedClis"
  ControlSource = "TprMvCab.grupoos"
  ControlSource = "TprMvCab.contaos"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "xpar.outros"
  ControlSource = ""
  ControlSource = "xPar.Obs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = "xpar.fpags"
  ControlSource = "xpar.valos"
  ControlSource = "xpar.vencs"
  ControlSource = ""
  ControlSource = "xpar.cpfs"
  ControlSource = "xPar.DigAgencs"
  ControlSource = "xpar.digcontas"
  ControlSource = "xpar.digchqs"
  ControlSource = "xpar.contas"
  ControlSource = "xpar.agencias"
  ControlSource = "xpar.bancos"
  ControlSource = "xpar.numeros"
  ControlSource = ""
	Select crTefImp
	lcSql = [Select Cpros,Cbars,DescFis,DescEcfs From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
	=Thisform.Podatamgr.SqlExecute(lcSql,'xPro')
			lcSql = [Select Cpros,Cbars,DescEcfs From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
			=Thisform.Podatamgr.SqlExecute(lcSql,'xPro')
	Select crTpmMvItnC
	Delete For cItens >= 1000
		Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
		If Not Seek(Str(crTpmMvItn.cItens,4))
			Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
				Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
				Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
				Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
	Select [ ] As Agrupar, Sum(Qtds) As QtItem From crTpmMvItn Into Cursor TotItem Group By 1
	Select crTpmMvItnC
	Delete For cItens >= 1000
	Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
	Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
	Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
	Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
	Select nChaves, fPags, Trocos, cnIdTefs, Infos, Max(tParcs) As tParcs, Max(pDescs) As pDescs, ;
		From xPar Into Cursor xParECF Group By 1,2,3,4,5 Order By nChaves,fPags
	Select xParECF
		Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
			Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
	Select xPar
		Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
		Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
Select crTpmMvItnC
Select crTpmMvItn
Select xPar
		Select xPar
		Select ParcTef
		Select ParcTef
			Select crTpmMvItn
		Select crTpmMvItn
Select TprMvCab
SELECT crTpmMvItn
Select crTpmMvItnE
				Select crTpmMvItnE
				Select crTpmMvItnE
		Select crTpmMvItnE
lcSql = [Select * From SigFiNtb Where Imps=']+CrSigFiFis.Imps+[' And Ordems = ]+Str(CrSigCdOpe.TrNfis,2)
If ThisForm.Podatamgr.SqlExecute(lcsql,'CrSigFiNtb') > 0
Select crSigFiFis
Select crTpmMvItn
Delete
Select crTpmMvItnC
If Seek(Str(_cIt,4))
	Delete While cItens = _cIt
Select crTpmMvItn
LcQuery = [Select a.Fpags, a.Descrs, a.MoeFpgs, a.Fparcs, 0 as Obrigs, a.cCupomNvs, a.Situas, a.nCodFinzs, ]+;
		  [a.nFpags, a.Trocos, a.Infos, a.Acumulas, a.libcsens, o.autos, a.ChkBins, a.BlqTabDs From SigOpFp a, SigOpFpo o ]+;
If Thisform.Parentform.PoDataMgr.SqlExecute(lcQuery,'CrTmpFpag') < 1
Select CrTmpFpag
	LcQuery = [Select Fpags, Descrs, MoeFpgs, Fparcs, 0 as Obrigs, cCupomNvs, Situas, nCodFinzs, nFpags, ]+;
			  [Trocos, Infos, Acumulas, libcsens, 0 as autos, chkbins, BlqTabDs From SigOpFp Where nCodFinzs > 0]
	If Thisform.Parentform.PoDataMgr.SqlExecute(lcQuery,'CrTmpFpag') < 1
	Select Fpags, Descrs, MoeFpgs, Fparcs, Obrigs, nFpags, Trocos, Infos, Acumulas, libcsens, Autos, ChkBins, BlqTabDs From CrTmpFpag ;
	Select * From CrTmpFpag Into Cursor ccSigOpFp ReadWrite
Select ccSigOpFp
	Select crTpmMvItn
	Delete For Empty(Cpros)
	If Not Seek( Spac( 14 ), 'crTpmMvItn', 'Cpros' )
		Select [ ] as Agrupar, Max(Citens) as Citens From crTpmMvItn Where cpros <> ' ' Into Cursor ItenEesti group by 1
		Select ItenEesti
		Insert Into crTpmMvItn(emps,dopes,numes,citens ) ;
	Select crTpmMvItn
		Select xPar
			Select crSigCdPam
Select xPar
Select crTpmMvItn
	Select crTpmMvItn
	lcSql = [Select Top 1 Serifab,dtredzs From SigFiRx Where SeriFab = ']+pSeriFab+[' Order by DtRedZs Desc ]
	If ThisForm.PoDataMgr.SqlExecute(lcSql,'LocalRelx') < 1
	Select LocalRelx
		lcSql = [Select a.Nemps, Max(a.Datas) as Datas From SigMvCab a, SigCdOpe b ]+;
		If ThisForm.PoDataMgr.Sqlexecute(lcSql,'MovEest') < 1
		Select MovEest
	lnErr = pCnx.SqlExecute([Select * From SigCdSts Where Cods = '] + Padr(pSta, 3) + ['], [crAr1])
			lcWhere = [Select * From SigFiMpf Where cimpfabs = ']+lcImpf+[' And Emps=']+ThisForm.parentform.pEmps+[']
			LnErro = ThisForm.parentForm.Podatamgr.SqlExecute(lcWhere,'CrSigFiMpf')
				Select CrSigFiMpf
Select crSigFiFis
lcQuery = [Select Seqs,cNivels From SigMvCxs where cDopes = ']+CrSigCdOpe.Dopes+[' Order by Seqs,cNivels ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalSqOpe') < 1)
Select LocalSqOpe
	Select LocalSqOpe
Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcomItc
Select CrCfComItc
lcSql = [Select Logos From SigCdPac ]
If Thisform.ParentForm.Podatamgr.SqlExecute(lcSql,'TmpLogo') < 1
lcSql = [Select * From SigOpFpP ]
If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'ItemCFpagP') < 1
	.Codigos.ControlSource = 'TmpOperacao.Codigos'
	.Notas.ControlSource   = 'TmpOperacao.notas'
	.Valor.ControlSource   = 'TmpOperacao.Valos'
	.Column1.ControlSource = 'TmpDevol.Codigos'
	.Column2.ControlSource = 'TmpDevol.Dopes'
	.Column3.ControlSource = 'TmpDevol.Numes'
	.Column1.ControlSource = 'TmpBarFin.nBarra2'
	.Column2.ControlSource = 'TmpBarFin.nParcs'
	.Column3.ControlSource = 'TmpBarFin.ValPs'
	.Column4.ControlSource = 'TmpBarFin.VencPs'
Select TprMvCab
Select crTpmMvItn
	.Column1.ControlSource    = 'crTpmMvItnc.Texto'
Select crSigFiFis
	Select TprMvCab
	lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.Contaos+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
	lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.ContaDs+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
		lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.Vends+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
		lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.Resps+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
lcSql = [Select Logos From SigCdPac ]
If Thisform.ParentForm.Podatamgr.SqlExecute(lcSql,'TmpLogo') < 1
	Select * From crTpmMvItn Where 0=1 Into Cursor crTpmMvItnPro ReadWrite
	Select crTpmMvItnPro
		lcSql = [Select cBars,Contas,Empos,Cpros,Qtds,Pesos,codCors,codTams From SigOpEtq Where Cbars = ]+Str(Val(This.Value),14)
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpEti') < 1
			lcSql = [Select Cpros,Dpros,Cunis,Situas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,Pvens,Pcuss,]+;
					[From SigCdPro Where Cpros = ']+Cpro+[']
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpPro') < 1
			lcSql = [Select Cpros, Cbars From SigCdPro Where Cbars = ]+Str(Val(This.Value),14)
			If Thisform.Podatamgr.Sqlexecute(lcsql,'LocalPro') < 1
			lcSql = [Select Cpros,Dpros,Cunis,Situas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,Pvens,Pcuss,Valors,CodFinP,]+;
					[From SigCdPro Where Cbars = ]+Str(Val(This.Value),14)
			If Thisform.Podatamgr.Sqlexecute(lcsql,'CrTmpPro') < 1
			lcSql = [Select Cpros,Dpros,Cunis,Situas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,Pvens,Pcuss,cftios,sgrus,custofs,]+;
					[From SigCdPro Where Cbars = ]+Str(Val(This.Value),14)
			If Thisform.Podatamgr.Sqlexecute(lcsql,'CrTmpPro') < 1
				lcSql = [Select Cpros,Ean13 From SigCdPro Where Ean13 = ]+Str(Val(Cpro),13)
				If ThisForm.Parentform.PodataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
		lcSql = [Select Cpros From SigCdPro Where Cpros = ']+cPro+[']
		If Thisform.Podatamgr.Sqlexecute(lcsql,'LocalPro') < 1
	Select crTpmMvItnPro
	Select crTpmMvItnPro
		lcSql = [Select Codigos from SigCdLpc Where lPrecos = ']+TprMvCab.lPrecos+[']
		lnErro = ThisForm.parentform.podatamgr.SqlExecute(lcSql,'CrTmplPre')
		lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
		lnErro = ThisForm.parentform.podatamgr.SqlExecute(lcWhere,'CrSigCdLpi')
		Select CrSigCdLpi
				lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
				=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
	Select crTpmMvItnPro
lcSql = [Select Logos From SigCdPac ]
If Thisform.ParentForm.Podatamgr.SqlExecute(lcSql,'TmpLogo') < 1
	Select crTpmMvItn
		Select crTpmMvItn
		If Seek( Val( This.Value ) ) And Recno() = _Recnx
		lcSql = [Select Contas,Empos,Cpros,Qtds,Pesos,Cbars, codCors, codTams From SigOpEtq Where Cbars = ]+Str(Val(This.Value),14)
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpEti') < 1
					lcSql = [Select Cpros,Dpros,Cunis,Situas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,Pvens,Pcuss,CodFinP,]+;
							[From SigCdPro Where Cpros = ']+Cpro+[']
					If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpPro') < 1
			lcSql = [Select Cpros, Cbars From SigCdPro Where Cbars = ]+Str(Val(This.Value),14)
			If Thisform.Podatamgr.Sqlexecute(lcsql,'LocalPro') < 1
			lcSql = [Select Cpros,Dpros,Cunis,Situas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,Pvens,Pcuss,Valors,CodFinP,]+;
					[From SigCdPro Where Cbars = ]+Str(Val(This.Value),14)
			If Thisform.Podatamgr.Sqlexecute(lcsql,'CrTmpPro') < 1
			lcSql = [Select Cpros,Dpros,Cunis,Situas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,Pvens,Pcuss,cftios,sgrus,custofs,]+;
					[From SigCdPro Where Cbars = ]+Str(Val(This.Value),14)
			If Thisform.Podatamgr.Sqlexecute(lcsql,'CrTmpPro') < 1
				lcSql = [Select Cpros,Ean13 From SigCdPro Where Ean13 = ]+Str(Val(Cpro),13)
				If ThisForm.Parentform.PodataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
			Select CrTmpPro
		lcSql = [Select Cpros From SigCdPro Where Cpros = ']+cPro+[']
		If Thisform.Podatamgr.Sqlexecute(lcsql,'LocalPro') < 1
		lcWhere = [Select * From SigOpTdt Where Codigos = ']+TprMvCab.Tabds+[']
		lnErro = ThisForm.Parentform.PodataMgr.SqlExecute(lcWhere,'CrSigOpTdt')
		Select CrSigOpTdt
			lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
			=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
		Select crSigOpTdt
		If Seek( TprMvCab.Tabds + '4' + CrtmpPro.CPros ) Or ;
				Seek( TprMvCab.Tabds + '9' + CrTmpPro.CodFinP ) Or ;
				Seek( TprMvCab.Tabds + '1' + CrTmpPro.CGrus ) Or ;
				Seek( TprMvCab.Tabds + '2' + CrTmpPro.Linhas ) Or ;
				Seek( TprMvCab.Tabds + '3' + CrTmpPro.Colecoes ) Or ;
				Seek( TprMvCab.TabDs + '5' + lcMoedas ) Or ;
				Seek( TprMvCab.TabDs + '6' + CrTmpPro.Cunis ) Or ;
				Seek( TprMvCab.TabDs + '7' + CrTmpPro.Cftios ) Or ;
				Seek( TprMvCab.TabDs + '8' + CrTmpPro.Sgrus )
	Select crTpmMvItn
	Select crTpmMvItn
		lcSql = [Select Codigos from SigCdLpc Where lPrecos = ']+TprMvCab.lPrecos+[']
		lnErro = ThisForm.parentform.podatamgr.SqlExecute(lcSql,'CrTmplPre')
		lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
		lnErro = ThisForm.parentform.podatamgr.SqlExecute(lcWhere,'CrSigCdLpi')
		Select CrSigCdLpi
				lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
				=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
	Select crTpmMvItn
	Select crTpmMvItn
		Select crTpmMvItn
	SELECT crTpmMvIts
	Select crTpmMvItn
		Select crTpmMvIts
			DELETE
		Select crTpmMvItn
	SELECT crTpmMvIts
				Select crTpmMvItn
					Select crTpmMvItn
								Select crTpmMvItn
							Select crTpmMvItn
					Select crTpmMvItn
Local llCntrlFrom
			llCntrlFrom = This.Value > 0 And Thisform.lControle And crTpmMvItn.Qtds > 0
	Select crTpmMvItn
				lcSql = [Select Qtds, Pesos, aQtds, aPesos From SigOpEtq Where Cbars = ]+Str(crTpmMvItn.CodBarras)
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcsql, 'crTmpET') < 1)
				Select [] as Agrupar,Sum(Qtds)+This.Value as Qtds From crTpmMvItn where CodBarras = lnBr And ;
			Select crTpmMvItn
				Select crTpmMvItn
				Select crTpmMvItn
				Select crTpmMvItn
					Select crTpmMvItn
									Select crTpmMvItn
								Select crTpmMvItn
					Select crTpmMvItn
		Select crTpmMvItn
	Select crTpmMvItn
		Select crTpmMvItn
	Select crTpmMvItn
	Select crTpmMvItn
				Select crTpmMvItn
			Select crTpmMvItn
	Select crTpmMvItn
Select crTpmMvItn
	Select crTpmMvItn
	Select crTpmMvItn
	Select crTpmMvItn
	Select crTpmMvItn
					Select crTpmMvItn
				Select crTpmMvItn
		Select crTpmMvItn
				Select crTpmMvItn
				Select crTpmMvItn
		Select crTpmMvItn
		Select crTpmMvItn
		Select crTpmMvItn
		Select crTpmMvItn
					Select crTpmMvItn
				Select crTpmMvItn
		Select crTpmMvItn
				Select crTpmMvItn
				Select crTpmMvItn
Select TmpBarFin
Delete
		Select TmpBarFin
			Insert Into TmpBarFin (nBarra1,nBarra2,nEmps,nParcs,ValPs,VencPs,nDopes,nNumes) Values ;
		Select sum(1) as Qt, Codigos From TmpDevol ;
		Select CheckDup
			Select TmpDevol
Select TprMvCab
	lcQuery = [Select * From SigCdOpe Where nDopes = ]+Str(nDope)
	=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
		lcSql = [Select * From SigMvCab Where EmpdopNums = ']+TprMvCab.Emps + Dope + Str(Nume,6)+[']
			lcSql = [Select * From SigMvCab Where Dopes = ']+Dope+[' And Notas = ']+lcNotas+[']
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTprMvCab')
		lcUpDate = [UpDate SigMvCab Set ChkSubn = ?lcSubn, DtAlts = ?ldDtAlt, DtBaixas = Null, DataTrans = Null Where CidChaves = ']+CrTprMvCab.CidChaves+[']
		lnErro = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 3)')
		Select xPar
		Delete All For EmpDopNums = CrTprMvCab.EmpDopNums And Fpags = lcFPagOpCrs
		Select xParTef
		Delete All For EmpDopNums = CrTprMvCab.EmpDopNums And Fpags = lcFPagOpCrs
	Select [ ] as Agrupar, sum(1) as Qt From TmpOperacao ;
		Select [ ] as Agrupar,sum(1) as Qt From TmpDevol ;
Select TmpDevol
	Select crSigCdOpe
		lcSql = [Select Dopes, nddVals From SigOpCdc Where Dopes = ']+CrSigCdOpe.Dopes+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalDcOpe')
						Select TmpDevol
					Select TmpDevol
				lcUpDate = [UpDate SigMvCab Set ChkBxParcs = ?lcSubn Where CidChaves = ']+CrEest.CidChaves+[']
				lnErro = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
					Select TmpDevol
				lcSql = [Select ChkSubn From SigMvCab Where CidChaves = ']+CrEest.CidChaves+[']
				lnErro = ThisForm.Podatamgr.SqlExecute(lcSql,'LocalEest')
					Select TmpDevol
					Select TmpDevol
				lcUpDate = [UpDate SigMvCab Set ChkSubn = ?lcSubn, DtAlts = ?ldDtAlt, DtBaixas = ?llDtBx Where CidChaves = ']+CrEest.CidChaves+[']
				lnErro = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
					Select TmpDevol
					Insert Into xPar ( FPags, Emps, Dopes, Numes, Datas, Parcs, Vencs, ;
					Select xPar
					Select xParTef
					If Not Seek(CrEest.EmpDopNums + lcFPagOpCrs)
	Select CrSigMvNfi
	Select TprMvCab
Select TmpDevol
	Select TmpDevol
		Insert Into TmpDevol (Emps, Dopes, Numes, Codigos, TpCodigos) ;
Select [ ] as Agrupar, sum(1) as Qt From TmpDevol ;
	Select [ ] as Agrupar, sum(1) as Qt From TmpOperacao ;
Select TmpDevol
Select [ ] as Agrupar, sum(1) as Qt From TprMvCabV Where Not Empty(Contas) Into Cursor TotEestV group by 1
Select TmpOperacao
Delete For Codigos = 0
	Select TmpOperacao
		Select sum(1) as Qt, EmpSubns, Codigos From TmpOperacao ;
		Select CheckDup
			Select TmpOperacao
		Select [ ] as Agrupar,Sum(1) as Qt From TmpOperacao ;
			Select TmpOperacao
	Insert Into Pdvlog (Detalhes ) Values ('Nivel 01 : '+Str(This.Value))
lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
	lcQuery = [Select * From SigCdOpe Where Dopes = ']+lcSubNivel+[']
	=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
	lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
	=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 02 : '+Str(This.Value))
		Select csSigOpCsn
		lcQuery = [Select * From SigCdOpe Where Dopes = ']+OldDope+[']
		=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
		Select crTpmMvItn
		Delete All For Dopes + Str(Numes,6) = OldDope + Str( OldNume, 6 )
		Select crTpmMvIts
		Delete All For Dopes + Str(Numes,6) = OldDope + Str( OldNume, 6 )
		Select xPar
		Delete All For Dopes + Str(Numes,6) = OldDope + Str( OldNume, 6 )
		Select xParTef
		Delete All For EmpDopNums = TmpOperacao.EmpSubns + OldDope + Str(OldNume,6)
		lcQuery = [Select * From SigMvCab Where EmpdopNums = ']+lcBusca+[']
		If ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTprMvCab') < 1
			lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
			=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 03 : '+Str(This.Value))
			Select TmpOperacao
			lcUpDate = [UpDate SigMvCab Set ChkSubn = ?llChkf, DtBaixas = ?llDtBx Where EmpDopNums = ']+lcBusca+[']
			lnErro   = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab)')
				lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
				=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
				Insert Into Pdvlog (Detalhes ) Values ('Nivel 04 : '+Str(This.Value))
				Select TmpOperacao
		Select TprMvCab
		lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
		=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
		Select [ ] as Agrupar, sum(1) as Qt From TmpOperacao ;
			Select [ ] as Agrupar, sum(1) as Qt From TmpDevol ;
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 05 : '+Str(This.Value))
		Select TprMvCab
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 06 : '+Str(This.Value))
	Select TmpOperacao
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 07 : '+Str(This.Value))
	Select csSigOpCsn
			Select CsSigOpCsn
					lcquery = [Select Emps, dopes, Numes, Valos From SigMvCab Where Datas>=']+Dtos(Date())+[' And Dopes = ']+CsSigOpCsn.cNivels+[' And Emps = ']+;
					If (ThisForm.Podatamgr.SqlExecute(lcQuery, 'creest') < 1)
						Select TmpOperacao
					Select CrEest
		Select csSigOpCsn
			Select TmpOperacao
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 08 : '+Str(This.Value))
	lcQuery = [Select TpFats From SigMvCab Where EmpdopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
	If ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTprMvCab') > 0
	Insert Into Pdvlog (Detalhes ) Values ('Nivel 09 : '+Str(This.Value))
lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
lcQuery = [Select * From SigCdTif Where Codigos = ']+_TpFat+[']
=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdTif')
	Select TmpOperacao
	Insert Into Pdvlog (Detalhes ) Values ('Nivel 10 : '+Str(This.Value))
	Select TmpOperacao
	Insert Into Pdvlog (Detalhes ) Values ('Nivel 11 : '+Str(This.Value))
lcQuery = [Select Dopes, cMoes From SigCdOpe Where Ndopes = ]+Str(nDope)+[]
=ThisForm.PodataMgr.SqlExecute(lcquery,'CrSigCdOpe')
lcQuery = [Select Dopes, nddVals From SigOpCdc Where Dopes = ']+CrSigCdOpe.Dopes+[']
=ThisForm.PodataMgr.SqlExecute(lcquery,'LocalDcOpe')
lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
	lcUpDate = [Update SigMvCab Set ChkBxParcs = ChkBxParcs Where EmpDopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
	If (ThisForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
		Select TmpOperacao
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 20 : '+Str(This.Value))
	lcQuery = [Select * From SigMvCab Where EmpDopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
	If ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTprMvCab') < 1
		Select TmpOperacao
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 12 : '+Str(This.Value))
	lcQuery = [Select Series,VlFretes,FrtIpis,FrtIcms,VlSeguros,SegIpis,SegIcms,DespAces,DesIpis,]+;
			  [DesIcms,Cfis,nFis,EspecieNfs From SigMvNfi Where EmpDopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
	If ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTmpNfis') < 1
		Select TmpOperacao
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 13 : '+Str(This.Value))
		Select TmpOperacao
	Select TmpOperacao
	Select Emps ;
	  From TmpOperacao ;
		lcQuery = [Select * From SigMvCab Where EmpDopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
		If ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTprMvCab') < 1
			Select TmpOperacao
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 14 : '+Str(This.Value))
		lcQuery = [Select * From SigMvCab Where EmpDopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
		If ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTprMvCab') < 1
			Select TmpOperacao
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 15 : '+Str(This.Value))
	lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
	=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
		Select TmpOperacao
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 16 : '+Str(This.Value))
	Select crSigCdPam
		lcQuery = [Select * From SigMvCab Where EmpDopNums = ']+TprMvCab.Emps + crSigCdPam.OpConFors + Str(Nume,6)+[']
		If ThisForm.PodataMgr.SqlExecute(lcQuery,'CrEest') < 1
			Select TmpOperacao
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 17 : '+Str(This.Value))
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 18 : '+Str(This.Value))
			lcUpDate = [UpDate SigMvCab Set ChkSubn = ?llChkf, DtBaixas = ?llDtBx Where EmpDopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
			lnErro = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
				Select TmpOperacao
				Insert Into Pdvlog (Detalhes ) Values ('Nivel 19 : '+Str(This.Value))
			lcUpDate = [Update SigMvCab Set ChkBxParcs = ChkBxParcs Where EmpDopNums = ']+TprMvCab.Emps + Dope + Str( Nume, 6 )+[']
			If (ThisForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
				Select TmpOperacao
				Insert Into Pdvlog (Detalhes ) Values ('Nivel 20 : '+Str(This.Value))
		lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
		=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
		Select crTpmMvItn
		Delete All For IsEmpty( cpros )
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 21 : '+Str(This.Value))
			Select TprMvCab
			Select TprMvCab
			Select CrTprMvCabV
				Insert Into TprMvCabV (Dopes,Numes,Contas) Values ;
				Select CrTprMvCabV
					If Not Seek(CrTprMvCabV.Contas,'TprMvCabV','Contas')
						lcSql = [Select Rclis From SigCdCli where Iclis = ']+CrTprMvCabV.Contas+[']
						Thisform.ParentForm.PodataMgr.SqlExecute(lcSql,'CrTmpCli')
						Insert Into TprMvCabV (Dopes,Numes,Contas,Rclis) Values ;
				lcSql = [Select Tabds From SigCdCli Where Iclis = ']+TprMvCab.ContaOs+[']
				=Thisform.parentform.Podatamgr.Sqlexecute(lcsql,'TmpCli')
					lcSql = [Select Tabds From SigCdCli Where Iclis = ']+TprMvCab.ContaDs+[']
					=Thisform.parentform.Podatamgr.Sqlexecute(lcsql,'TmpCli')
			Select TprMvCab
			Select TprMvCab
		lcWhere = [Select * From SigMvItn Where EmpDopNums = ']+lcBusca+[' order by cpros ]
		lnErro = Thisform.Podatamgr.SqlExecute(lcWhere,'CrEesti')
			Select TmpOperacao
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 21a : '+Str(This.Value))
		lcWhere = [Select * from SigMvIts Where EmpDopNums = ']+lcBusca+[' order by cpros ]
		lnErro = Thisform.Podatamgr.SqlExecute(lcWhere,'CrEsti2')
			Select TmpOperacao
		Select CrEesti
			lcQuery = [Select Cpros,Dpros,Moevs,Pvens,Moecs,Pcuss,Moedas,Valors,mUltComps,vUltComps,custofs From SigCdPro Where Cpros = ']+CrEesti.Cpros+[']
			=ThisForm.Podatamgr.SqlExecute(lcquery,'CrTmpPro')
				Insert Into Pdvlog (Detalhes ) Values ('Nivel 22 : '+Str(This.Value))
				Select crTpmMvItn
					lcSql = [Select lPrecos from SigCdLpc Where Codigos = ]+Str(CrEesti.CodlPrecs)
					lnErro = ThisForm.parentform.podatamgr.SqlExecute(lcSql,'CrTmplPre')
						lcwhere = [Select * From SigCdLpi Where Cpros = ']+crTpmMvItn.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
						lnErro = ThisForm.podatamgr.SqlExecute(lcWhere,'CrSigCdLpi')
							Select TmpOperacao
						Select CrSigCdLpi
										lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
										=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
							Select crTpmMvItn
				Select crEsti2
						Select crTpmMvIts
					 	Insert Into crTpmMvIts From Memvar
		Select crTpmMvItn
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 23 : '+Str(This.Value))
			Select crTpmMvIts
			Select crTpmMvItn
			lcQuery = [Select Cpros, Dpros, Moevs, Pvens, Moecs, Pcuss, Moedas, Valors, mUltComps, vUltComps ]+;
						[From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
			=ThisForm.Podatamgr.SqlExecute(lcquery,'CrTmpPro')
					lcwhere = [Select * From SigCdLpi Where Cpros = ']+crTpmMvItn.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
					lnErro = ThisForm.podatamgr.SqlExecute(lcWhere,'CrSigCdLpi')
						Select TmpOperacao
						Insert Into Pdvlog (Detalhes ) Values ('Nivel 24 : '+Str(This.Value))
						lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
						=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
			If !Seek( moeda, "TmpCot" )
					Insert Into TmpCot ( Cmoes, Valos ) Values ( Moeda, crTpmMvItn.MoeVals )
			If !Seek( crTpmMvItn.Moefats, "TmpCot" )
					Insert Into TmpCot ( Cmoes, Valos ) Values ( crTpmMvItn.MoeFats, crTpmMvItn.FatVals )
			If !Seek( crTpmMvItn.Moedas, "TmpCot" )
					Insert Into TmpCot ( Cmoes, Valos ) Values ( crTpmMvItn.Moedas, crTpmMvItn.Fators )
		Select crTpmMvItn
		Select crTpmMvIts
		Select crTpmMvItn
		 	Insert Into crTpmMvItn ( Emps, Dopes, Numes, CItens );
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 25 : '+Str(This.Value))
		Select crTpmMvIts
			lcWhere = [Select a.*, b.ccupomnvs, b.Infos From SigMvPar a, SigOpFp b Where a.EmpDopNums = ']+lcBusca+[' And a.fpags = b.fpags]
			lnErro = ThisForm.Podatamgr.SqlExecute(lcWhere,'CrxPar')
				Select TmpOperacao
				Insert Into Pdvlog (Detalhes ) Values ('Nivel 26 : '+Str(This.Value))
			Select EmpDopNums, Bancos, Agencias, Contas, Numeros, fpags, ccupomnvs, Infos, ;
			From CrxPar group by 1,2,3,4,5,6,7,8,9,10 Into Cursor CrPar
			Select CrPar
			 	Insert Into xParTef From Memvar
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 27 : '+Str(This.Value))
		Select TprMvCab
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 28 : '+Str(This.Value))
			Select TmpOperacao
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 29 : '+Str(This.Value))
			 	Insert Into TmpOperacao ( Emps, Dopes, Numes, Codigos ) ;
			Select TmpOperacao
			Insert Into Pdvlog (Detalhes ) Values ('Nivel 30 : '+Str(This.Value))
		Select TprMvCab
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 31 : '+Str(This.Value))
		Select TmpOperacao
		Insert Into Pdvlog (Detalhes ) Values ('Nivel 32 : '+Str(This.Value))
Select crTpmMvItn
lcQuery = [Select * From SigCdOpe Where Dopes = ']+TprMvCab.Dopes+[']
=Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdOpe')
Select TmpOperacao
Insert Into Pdvlog (Detalhes ) Values ('Nivel 33 : '+Str(This.Value))
							Seek( CrTmpCli.TabDs, 'csSigOpTdz', 'Codigos' )
	Select CrSigCdOpe
						Seek( CrTmpCli.TabDs, 'csSigOpTdz', 'Codigos' )
	Select crSigCdOpe
	lcQuery = [Select * From SigCdCli Where Cpfs = ?Cgc1 ]+;
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
					Select CrTmpCli
		lcQuery = [Select * From SigCdCli Where ]+Iif(Len(RetCli)=10,[ Iclis = ],[ Cpfs = ])+[ ?RetCli ]
		lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
						Seek( CrTmpCli.TabDs, 'csSigOpTdz', 'Codigos' )
	Select crSigCdOpe
	lcQuery = [Select * From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
Select [ ] as Agrupar,sum(1) as Qt From TprMvCabV Where Not Empty(Contas) Into Cursor TotEestV group by 1
Select [ ] as Agrupar,sum(1) as Qt From TprMvCabV Where Not Empty(Contas) Into Cursor TotEestV group by 1
	lcQuery = [Select * From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
Select [ ] as Agrupar,sum(1) as Qt From TprMvCabV Where Not Empty(Contas) Into Cursor TotEestV group by 1
	If Not Seek( This.Value, 'csSigOpTdz', 'Codigos' )
	Select crTpmMvItn
	lcSql = [Select * From SigCdLpc Where ]+Iif(CrSigCdOpe.tplprecs=2,[Tipos = 'C' ],[Tipos <> 'C'])
	If ThisForm.PoDatamgr.SqlExecute(lcSql,'CsSigCdLpc') < 1
	Select CsSigCdLpc
	If Not Seek( This.Value, 'csSigCdLpc', 'lPrecos' )
	Select crTpmMvItn
		Select TprMvCab
						Seek( CrTmpCli.TabDs, 'csSigOpTdz', 'Codigos' )
	Select crSigCdOpe
						Seek( CrTmpCli.TabDs, 'csSigOpTdz', 'Codigos' )
	lcQuery = [Select * From SigCdCli Where Cpfs = ?Cgc1 ]+;
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
					Select CrTmpCli
		lcQuery = [Select * From SigCdCli Where ]+Iif(Len(RetCli)=10,[ Iclis = ],[ Cpfs = ])+[ ?RetCli ]
		lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
						Seek( CrTmpCli.TabDs, 'csSigOpTdz', 'Codigos' )
Select TprMvCab
Select crSigMvNfi
Select TprMvCab
Select crSigMvNfi
Select TprMvCab
Select crSigMvNfi
Select TprMvCab
Select crSigMvNfi
	If ( Val(This.Value) > 0 And !Seek(Val(This.Value),'CcSigOpFp','nfpags')) Or Val(This.Value) = 0
		If !Seek( This.Value, 'ccSigOpFp', 'FPags' )
		Select xPar
		Select TmpOperacao
	Select xPar
		If Seek(This.Value,'xPar','fPags') And ( ( crSigOpFp.Infos = [C] And InList(CrSigOpFp.AcVchqs,0,2) ) Or CrSigOpFp.AcVchqs = 3  Or CrSigOpFp.Situas = [S] )
&&		If (Seek('CARTAO','xPar','fPags') And ( crSigOpFp.Infos = [C])) OR (Seek('CHEQUE REDE','xPar','fPags') And ( crSigOpFp.Infos = [T]) )
			lcSql = [Select * From SigCdFs Where codigos = ']+TprMvCab.MotDscs+[']
			If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalMdsc') < 1)
		Select crSigOpFp
Select TprMvCab
	lcSql = [Select * From SigOpFpP Where Fpags = ']+CrSigOpFp.Fpags+[' And nParcs =]+Str(ThisForm.Cnt_Fpagto.Get_npar.Value,2)
	If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'LocalFpagP') > 0 And ;
			Select crSigFiNfs
				Select crSigFiNfs
					lcQuery = [Select * from SigFiTef Where cnnsus = '] + Alltrim(lcNsu) + [' And ]+;
					ThisForm.Parentform.poDatamgr.SqlExecute(lcQuery,'TmpAux3')
					SELECT * from TmpAux3 where ;
Select xPar
		Select * From ItemcFpagp Where Fpags = lcFpag And nParcs = lnP And lnValP >= ValMins And lnValP <= ValMaxs ;
				Select * From ItemcFpagp Where Fpags = lcFpag And nParcs = lnP And lnValP >= ValMins And lnValP <= ValMaxs ;
				Select * From ItemcFpagp Where Fpags = lcFpag And nParcs = lnP And lnValP >= ValMins And lnValP <= ValMaxs ;
		lcSql = [Select Saldos From SigMvSlc Where GruConMoes = ']+GruConMoe+[']
		If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrSigMvSlc') < 0 
		SELECT xpar
			Select CrTefParc
	Select xpar
			Select CrTefParc
			If seek(lcdtvenc)
			If seek(lcvalparc) 
			If seek(lcnnsu)
		Select xPar
	 			Select xpar
		Update xPar Set NoCreditos = ThisForm.Usulibs Where Fpags = CrSigOpFp.Fpags
	Select crSigMvNfi
	Select xpar
SELECT xpar
Select xpar
Select crSigCdPam
				ThisForm.poDatamgr.SqlExecute([Select * From SigOpFp Where Fpags = '] + xPar.Fpags + ['], [csTmpFpag])
					Select Sum(Valos) As Valos From xPar Where FPags = csTmpFpag.Fpags Into Cursor crTotCHQ
						lcQryTef = [Select PCheque From SigOpFp Where FPags = '] + Alltrim(CrSigFiTef.ccupomnvs) + [']
						ThisForm.poDataMgr.SqlExecute(lcQryTef, [csTmpFPag])
						Select xPar
						Select xpar
						Select xPar
						Select xPar
						Select xPar
						Select xPar
				lcQryTef = [Select PCheque From SigOpFp Where FPags = '] + Alltrim(CrSigFiTef.ccupomnvs) + [']
				ThisForm.poDataMgr.SqlExecute(lcQryTef, [csTmpFPag])
					Thisform.Parentform.DeleteSigTef(crSigFiTef.cnIdents,lcTipo)
					Select xPar
	Select xpar
Select xpar
			Select xPar
						Delete For nChaves = lnChv
						Delete
					Select xPar
					Select xPar
SELECT xpar
Select xPar
	.FPagto.ControlSource = 'xPar.Fpags'
	.Valor.ControlSource  = 'xPar.Valos'
	.Venc.ControlSource   = 'xPar.Vencs'
	.Moeda.ControlSource  = 'xPar.MoeFPgs'
	lcSql = [Select Dopes From SigCdOpe Where Dopes = ']+lcDopCx+[']
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'TempoOpe') > 0 And Reccount('TempoOpe') > 0
	Select crTpmMvItn
Select xPar
Select xPar
Select TmpOperacao
Select crTpmMvItn
	Select crTpmMvItn
				SELECT 0
				IMPORT FROM &lcIBPT TYPE XL5
				SELECT 0
				SELECT IBPTAX
					Select crTpmMvItn
					Select crTpmMvItn
			Select crTpmMvItn
Select [ ] as Agrupar, Max(Citens) as Citens From crTpmMvItn Where cpros <> ' ' Into Cursor ItenEesti group by 1
Select ItenEesti
Select xPar
Select TmpOperacao
Select TmpDevol
lcQuery = [Select cNivels,Seqs From SigMvCxs where cDopes = ']+CrSigCdOpe.Dopes+[' Order by Seqs,cNivels ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalSqOpe') < 1)
Select TmpOperacao
	Select crTpmMvItn
Select [ ] as Agrupar, sum(1) as Qt From TmpOperacao ;
	Select [ ] as Agrupar, sum(1) as Qt From TmpDevol ;
Select [ ] as Agrupar, sum(1) as Qt From TprMvCabV Where Not Empty(Contas) Into Cursor TotEestV Group by 1
Select crTpmMvItn
	Select TprMvCab
	lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.Contaos+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
	lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.ContaDs+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
		lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.Vends+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
		lcQuery = [Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis = ']+TprMvCab.Resps+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpCli') < 1)
Select TmpOperacao
	Select crTpmMvItn
Select TmpOperacao
	Select crTpmMvItn
	lcSql = [Select * From SigFiNtb Where Imps=']+CrSigFiFis.Imps+[' And Ordems = ]+Str(CrSigCdOpe.TrNfis,2)
	If ThisForm.Podatamgr.SqlExecute(lcsql,'CrSigFiNtb') > 0
	Select crSigFiFis
Select [] as Agrupar, Sum(1) as TT from crTpmMvItn Where Not Empty(nChvTbds) And Not Empty(Cpros) ;
	Select crTpmMvItn
	Select [ ] as Agrupar,sum(Iif(UnitInfs#0,( UnitInfs - Units ),0)) as nvac From crTpmMvItn ;
	Select TprMvCab
Select crSigCdPam
Select xpar
Select xPar
Select CrCfComItc
Select crSigFiFis
	Select TprMvCab
lcQuery = [Select Fpags, Descrs From SigOpFp Order By Fpags ]
If (ThisForm.parentform.poDataMgr.SqlExecute(lcQuery, 'TmpFpag') < 1)
Select TmpFpag
Select xPar
Select xParTef
Select ParcTef
	Select a.Fpags, a.nparcs, a.Vencs, Iif(a.Utilizado,1,0) as Baixado, Iif(a.Creditos,1,0) as Credito, ;
	From xParTef a, ccSigOpFp b ;
	Select wParcTef
		Select ParcTef
		lcSql = [Select * From SigOpFpP Where Fpags = ']+m.Fpags+[' And nParcs =]+Str(m.nParcs,2)
		Select * From ItemcFpagp Where Fpags = m.Fpags And nParcs = m.nParcs And lnValP >= ValMins And lnValP <= ValMaxs ;
	Select ParcTef
	Select ParcTef
	Select Fpags, nparcs, Vencs, Iif(Utilizado,1,0) as Baixado, Iif(Creditos,1,0) as Credito, ;
	Sum(Valos) as Valos, Sum(Valos) as ValOrigs, Sum(ValDescs) as ValDescs From xParTef ;
Select TmpOperacao
Select xPar
Select xPar
Select TmpOperacao
	Select crTpmMvItn
Select xPar
Select xPar
		Select SigTef
		Count for ! Deleted() To lnQtdTef
			SELECT SigTef
			SqlCanTef = [Update SigFiTef Set cStatus = 'CNC' Where cnIdents = ']+SigTef.cnIdents+[']
			ThisForm.Parentform.poDatamgr4.SqlExecute(SqlCanTef)
			ThisForm.ParentForm.DeleteSigTef(SigTef.cnIdents,lcTipo)
				Select SigTef
				Select SigTef
					SqlCanTef = [Update SigFiTef Set cStatus = 'CNC' Where cnIdents = ']+SigTef.cnIdents+[']
					ThisForm.Parentform.poDatamgr4.SqlExecute(SqlCanTef)
					ThisForm.ParentForm.DeleteSigTef(SigTef.cnIdents,lcTipo)
				Select xPar
						Delete
			Select xPar
			Delete For cnIdTefs = _pcnIdTef
	Select xPar
		Delete For nChaves = lnChv
		Delete
Select xPar
Select xPar
			Select xpar
			Delete
Select xPar
Select crTpmMvItn
		Select crTpmMvItn
	Select crTpmMvItn
		Delete
	Seek ( Space( 14 ) )
		Insert Into crTpmMvItn ( Emps, Dopes, Numes) ;
		Select crTpmMvItn
		If ! Seek( Val( This.Value ) ) 
			lcSql = [Select Cpros From SigCdPro Where Ean13 = ]+Str(Val(Cpro),13)
			If ThisForm.Parentform.PodataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
			Select CrTmpPro
				lcSql = [Select Cpros From SigCdPro Where Cbars = ]+Str(Val(Cpro),14)
				If Thisform.ParentForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro') < 1
				Select CrTmpPro
		Select crTpmMvItn
		If ! Seek(This.Value)
	Select CItens,Cpros,Qtds From crTpmMvItn Where Cpros = lcPro And Empty(EmpDopNums) Into Cursor Selecao ReadWrite
	Select Selecao
		Select crTpmMvItn
	Select crTpmMvItn
		Select crTpmMvItn
		Select CQSigExMvi
		Select TprMvCab
		Select CQSigExMvc
			Insert Into cQSigExMvc From Memvar
		Select crTpmMvItn
		Insert Into CQSigExMvi From Memvar
		ThisForm.parentform.PodataMgr4.Update('CQSigExMvc')
		ThisForm.parentform.PodataMgr4.Update('CQSigExMvi')
		Select crTpmMvItn
		Delete
Select crTpmMvItn
Select crTpmMvItn

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg) - TRECHOS RELEVANTES PARA PASS SQL (7678 linhas total):

*-- Linhas 75 a 105:
75: * principal de lancamento de itens (CntItem - Cnt_Produto/Cnt_Subtotal/
76: * Cnt_Desconto) e o painel de crediario (CntFinanc). A segunda metade
77: * (Cnt_Identifica, Cnt_Fpagto, os labels remanescentes de Cnt_Credito/
78: * Cnt_Pendencia e cmbTOpers) fica para a Fase 6. Nenhum ControlSource e usado
79: * nestes campos (o legado liga varios deles a TprMvCab, cursor do form PAI que
80: * fica fora de alcance com DataSession=2 isolado - mesma decisao das Fases
81: * 1-4); a leitura/gravacao de valor entra junto com os eventos nas Fases 7-8.
82: * Colisoes de nome do mapeamento.json (dois "SayN"/"LabelN" iguais dentro do
83: * MESMO container, gerados sem desambiguacao) sao resolvidas caso a caso nos
84: * comentarios de cada metodo abaixo - nunca com dois AddObject do mesmo nome
85: * no mesmo pai (CLAUDE.md #11/#28).
86: *
87: * Decisao de arquitetura (PILAR 3): o legado usa um objeto "PoDataMgr" (Data
88: * Manager) e um "PoCalculator" (calculadora popup) compartilhados via
89: * ParentForm. A nova arquitetura NAO replica esse padrao - o BO (sigmvitnBO)
90: * acessa o SQL Server diretamente via SQLEXEC(gnConnHandle, ...), entao as
91: * propriedades "podatamgr"/"pocalculator" do legado foram OMITIDAS de proposito
92: * (nao sao "Property nao encontrada" por acidente - sao substituidas por
93: * chamadas diretas ao BO nas fases de evento).
94: *
95: * FASE 6/8: CAMPOS DE DADOS - SEGUNDA METADE + TODOS OS LOOKUPS. Completa
96: * Cnt_Identifica (Destino/Responsavel/Vendedor/Origem - Grupo+Conta+Nome+Cpf,
97: * TabDesconto, CodOperacao) e Cnt_Fpagto (Acrescimo/Desconto,
98: * Cnt_ChequepreTef.Cnt_Chq, campos soltos), os labels remanescentes de
99: * Cnt_Credito/Cnt_Pendencia (botao "Proximo" + instrucao [ENTER]) e o
100: * cmbTOpers. Diferente da Fase 5, aqui HA logica de evento: os lookups
101: * originais (fAcessoContab/fAcessoContas/fwBuscaExt/fwBuscaSel) sao
102: * PROIBIDOS de reproduzir direto (auto-preenchem com o primeiro match
103: * parcial sem selecao explicita do usuario - CLAUDE.md "fAcessoContas()
104: * PROIBIDO lookup UX" / "fAcessoEmpresa() NAO EXISTE"). Substituidos pelo
105: * padrao canonico FormBuscaAuxiliar (CLAUDE.md #36/#37), acionado em

*-- Linhas 183 a 201:
183: *     (crTpmMvItn) e as propriedades do sigmvitnBO. NAO existiam no legado
184: *     porque la o cursor pertencia a tela de movimentacao PAI e vivia na
185: *     datasession COMPARTILHADA ("Set DataSession To pnDatSes"), e era o pai
186: *     quem gravava tudo no fim (AcioSalva -> TableUpdate). Com DataSession = 2
187: *     (isolado, como o SCX declara) o pai NAO ve este cursor, entao a
188: *     transferencia e a gravacao passam a ser deste form. Mapeiam SO as
189: *     colunas que a tela possui; as ~100 propriedades fiscais/de rateio do BO
190: *     ficam com o default da Fase 2 - preenche-las aqui seria inventar valor
191: *     de imposto e gravar numero errado em silencio (CLAUDE.md #27).
192: *   - GravarItensLancados: grava item a item via BO (NovoRegistro +
193: *     FormParaBO + Salvar), aborta no primeiro erro e devolve .F. - nao
194: *     existe "gravou metade da venda". Chamado por BtnConfirmarClick ANTES de
195: *     anunciar sucesso: sem isto o Confirmar dizia "venda validada" e fechava
196: *     a tela sem ter escrito nada em SigMvItn (CLAUDE.md #189).
197: *   - BtnConfirmarClick / BtnCancelarClick: sao os DOIS botoes que o legado
198: *     realmente tem na barra (Barra_Botoes.ok Caption "Confirmar" e
199: *     Barra_Botoes.Cancela Caption "Cancelar", Cancel = .T.) - renomeados dos
200: *     provisorios CmdOkClick/CmdCancelaClick para o nome canonico do projeto
201: *     (PILAR 3). Nenhum botao foi inventado.

*-- Linhas 422 a 461:
422:             *-- DataSession = 2 (privada) nasce com os SET no DEFAULT do VFP9,
423:             *-- nao com os do config.prg - mesma armadilha que o FormBase ja
424:             *-- trata para SET DATE/CENTURY (CLAUDE.md #9.4). Medido no VFP9 em
425:             *-- 2026-09-24: config.prg faz "SET DELETED ON", mas dentro desta
426:             *-- datasession SET("DELETED") volta OFF, e ai linha DELETADA fica
427:             *-- VISIVEL. Consequencia real: o item que o caixa CANCELOU
428:             *-- (ExcluirItemCorrente faz DELETE logico, sem PACK) continuaria
429:             *-- sendo contado no total e GRAVADO em SigMvItn pelo Confirmar -
430:             *-- o cliente pagaria por item cancelado. Normalizado aqui, no
431:             *-- inicio do Init, para valer em TODA operacao de cursor deste
432:             *-- form (COUNT/SUM/SKIP/SCAN e as cinco grades).
433:             SET DELETED ON
434: 
435:             THIS.this_oBusinessObject = CREATEOBJECT("sigmvitnBO")
436: 
437:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
438:                 *-- Os cursores das grades nascem ANTES dos controles: assim o
439:                 *-- MontaGrade, logo abaixo, encontra os alias prontos. Ligar
440:                 *-- Column.ControlSource a cursor inexistente estoura dentro
441:                 *-- deste TRY e o form nao chega a abrir (CLAUDE.md #41).
442:                 THIS.CriarCursoresGrades()
443: 
444:                 THIS.ConfigurarPageFrame()
445: 
446:                 *-- Bind das cinco grades (RecordSource/ControlSource/Width/
447:                 *-- cabecalhos). Separado da criacao dos controles porque
448:                 *-- RecordSource reseta Width, Header1.Caption, CurrentControl
449:                 *-- e Sparse - tudo isso precisa vir DEPOIS dele.
450:                 THIS.MontaGrade()
451: 
452:                 THIS.TornarControlesVisiveis(THIS)
453: 
454:                 *-- Carga inicial: traz do banco os itens ja lancados desta
455:                 *-- movimentacao, remonta as linhas do cupom e repinta as
456:                 *-- grades. Nao aborta a abertura se falhar - a tela do Caixa
457:                 *-- continua utilizavel para lancar item novo.
458:                 THIS.CarregarDados()
459: 
460:                 *-- FASE 7/8: eventos principais. Liga os Click/KeyPress dos
461:                 *-- 17 botoes da barra principal, dos botoes de acao das

*-- Linhas 549 a 592:
549:     * andamento (GrdCupom no legado). Coluna unica, sem cabecalho (o legado
550:     * usa HeaderHeight=0 - cada linha e uma string formatada, no padrao de
551:     * cupom fiscal), fonte Verdana azul (ForeColor=RGB(0,0,255) no dump).
552:     * RecordSource/ControlSource NAO sao setados aqui de proposito - o cursor
553:     * do carrinho (cursor_4c_Cupom ou equivalente) so existe a partir da fase
554:     * de eventos/CarregarCupom; setar ControlSource contra cursor inexistente
555:     * derruba o Init (CLAUDE.md #41). Fica atras de cnt_4c_CaixaLivre no
556:     * z-order (criado ANTES dele), exatamente como no legado: o painel "CAIXA
557:     * LIVRE" cobre a grade quando nao ha operacao em andamento.
558:     * Original: GrdCupom Top=127 Left=407 Width=340 Height=312 ColumnCount=1
559:     * Enabled=.F. GridLines=0 HeaderHeight=0 ReadOnly=.T. RecordMark=.F.
560:     * ScrollBars=0. Column1: FontName="Verdana" Width=345 Movable=.F.
561:     * ReadOnly=.T. ForeColor=0,0,255. Header1.Caption="Header1" (legado nao
562:     * troca - HeaderHeight=0 o esconde).
563:     *--------------------------------------------------------------------------
564:     PROTECTED PROCEDURE ConfigurarGridCupom()
565:         THIS.AddObject("grd_4c_Cupom", "Grid")
566:         WITH THIS.grd_4c_Cupom
567:             .Top           = 127
568:             .Left          = 407
569:             .Width         = 340
570:             .Height        = 312
571:             .ColumnCount   = 1
572:             .Enabled       = .F.
573:             .GridLines     = 0
574:             .HeaderHeight  = 0
575:             .ReadOnly      = .T.
576:             .RecordMark    = .F.
577:             .DeleteMark    = .F.
578:             .ScrollBars    = 0
579:             .Visible       = .T.
580: 
581:             .Column1.FontBold  = .F.
582:             .Column1.FontName  = "Verdana"
583:             .Column1.Enabled   = .F.
584:             .Column1.Width     = 345
585:             .Column1.Movable   = .F.
586:             .Column1.ReadOnly  = .T.
587:             .Column1.ForeColor = RGB(0, 0, 255)
588:             .Column1.Header1.FontSize = 8
589:             .Column1.Header1.Caption  = "Header1"
590:             .Column1.Text1.FontBold   = .F.
591:             .Column1.Text1.FontName   = "Verdana"
592:             .Column1.Text1.BorderStyle = 0

*-- Linhas 1326 a 1346:
1326:     * nome generico no mapeamento se resolve no JSON, nao no .prg - o
1327:     * mapeamento foi ajustado junto com esta fase.
1328:     *
1329:     * NENHUM RecordSource/ControlSource/Width de coluna e definido aqui: todos
1330:     * ficam em MontaGrade(), que roda DEPOIS de CriarCursoresGrades(). Ligar
1331:     * ControlSource a cursor que ainda nao existe derruba o Init (CLAUDE.md
1332:     * #41), e RecordSource RECALCULA Column.Width para o default 90 e zera
1333:     * Header1.Caption - por isso largura e cabecalho vao por ultimo.
1334:     *--------------------------------------------------------------------------
1335:     PROTECTED PROCEDURE ConfigurarGradesOperacao()
1336:         LOCAL loc_cIcones, loc_oCnt, loc_oGrd
1337:         loc_cIcones = gc_4c_CaminhoIcones
1338: 
1339:         *======================================================================
1340:         * 1) CntFinanc.Cnt_GrdBarra - painel do crediario (codigos de barras)
1341:         *======================================================================
1342:         THIS.cnt_4c_Financ.AddObject("cnt_4c__GrdBarra", "Container")
1343:         loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
1344:         WITH loc_oCnt
1345:             .Top           = 183
1346:             .Left          = 4

*-- Linhas 1363 a 1381:
1363:             .Height      = 129
1364:             .ColumnCount = 4
1365:             .RecordMark  = .F.
1366:             .DeleteMark  = .F.
1367:             .Visible     = .T.
1368:         ENDWITH
1369: 
1370:         *-- F2-Selec: posiciona na grade para digitar um novo par de barras
1371:         *-- (legado: Grade.Column1.SetFocus).
1372:         loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
1373:         WITH loc_oCnt.cmd_4c_Inserir
1374:             .Top             = 131
1375:             .Left            = 3
1376:             .Width           = 80
1377:             .Height          = 30
1378:             .FontBold        = .T.
1379:             .FontName        = "Tahoma"
1380:             .FontSize        = 8
1381:             .Picture         = loc_cIcones + "a_misc7.bmp"

*-- Linhas 1396 a 1414:
1396:             .FontBold        = .T.
1397:             .FontName        = "Tahoma"
1398:             .FontSize        = 8
1399:             .Picture         = loc_cIcones + "a_delete1.bmp"
1400:             .Caption         = "F4-\<Excluir"
1401:             .TabIndex        = 77
1402:             .PicturePosition = 1
1403:             .ForeColor       = RGB(90, 90, 90)
1404:             .Visible         = .T.
1405:         ENDWITH
1406: 
1407:         *-- F5-Barra: devolve o foco ao campo do primeiro codigo de barras.
1408:         *-- Nome do legado e "ok"; aqui cmd_4c_OkBarra, para nao colidir com os
1409:         *-- outros dois "ok" do form (Barra_Botoes.ok e CancelaItem.ok).
1410:         loc_oCnt.AddObject("cmd_4c_OkBarra", "CommandButton")
1411:         WITH loc_oCnt.cmd_4c_OkBarra
1412:             .Top             = 131
1413:             .Left            = 161
1414:             .Width           = 80

*-- Linhas 1443 a 1461:
1443:             .RowHeight    = 16
1444:             .ScrollBars   = 2
1445:             .TabIndex     = 4
1446:             .DeleteMark   = .F.
1447:             .RecordMark   = .F.
1448:             .BackColor    = RGB(254, 255, 232)
1449:             .Visible      = .T.
1450:         ENDWITH
1451: 
1452:         *-- A Column1 do legado nao usa o Text1 nativo: tem um TextBox proprio
1453:         *-- (get_Devol), por onde o usuario digita o numero da operacao de
1454:         *-- credito. Column.AddObject sozinho NAO faz o controle aparecer - a
1455:         *-- coluna segue desenhando o Text1 ate receber CurrentControl
1456:         *-- (CLAUDE.md #18). CurrentControl e Sparse ficam no MontaGrade,
1457:         *-- porque RecordSource reseta os dois.
1458:         loc_oGrd.Column1.AddObject("txt_4c__Devol", "TextBox")
1459:         WITH loc_oGrd.Column1.txt_4c__Devol
1460:             .FontName  = "Courier New"
1461:             .Margin    = 0

*-- Linhas 1479 a 1497:
1479:             .RowHeight    = 16
1480:             .ScrollBars   = 2
1481:             .TabIndex     = 3
1482:             .DeleteMark   = .F.
1483:             .RecordMark   = .F.
1484:             .ForeColor    = RGB(36, 84, 155)
1485:             .BackColor    = RGB(254, 255, 232)
1486:             .Visible      = .T.
1487:         ENDWITH
1488: 
1489:         *-- [F3]Pend. - abre a tela de pendencias do cliente (SigOpPen no
1490:         *-- legado). Fica ao lado da grade, dentro do mesmo container.
1491:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_BotPendentes", "CommandButton")
1492:         WITH THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes
1493:             .Top         = 9
1494:             .Left        = 300
1495:             .Width       = 75
1496:             .Height      = 75
1497:             .FontBold    = .T.

*-- Linhas 1542 a 1598:
1542:             .ScrollBars   = 2
1543:             .TabIndex     = 11
1544:             .ReadOnly     = .F.
1545:             .DeleteMark   = .F.
1546:             .RecordMark   = .F.
1547:             .Visible      = .T.
1548:         ENDWITH
1549:     ENDPROC
1550: 
1551:     *--------------------------------------------------------------------------
1552:     * CriarCursoresGrades - cria, VAZIOS, os cursores locais que alimentam as
1553:     * cinco grades. No legado eles ja existiam: a tela de movimentacao (form
1554:     * PAI) os montava na datasession COMPARTILHADA, e o SIGMVITN.SCX apenas
1555:     * fazia "Set DataSession To pnDatSes" e os enxergava prontos. O form
1556:     * migrado usa DataSession = 2 (isolado, como o SCX declara), entao os
1557:     * cursores precisam nascer aqui.
1558:     *
1559:     * Roda ANTES de qualquer RecordSource/ControlSource: ligar coluna a alias
1560:     * inexistente estoura "Alias is not found" dentro do TRY do InicializarForm
1561:     * e o form simplesmente nao abre (CLAUDE.md #41).
1562:     *
1563:     * SET NULL ON antes do CREATE CURSOR porque estes cursores recebem dados do
1564:     * SQL Server via APPEND FROM DBF() - coluna nullable do servidor recusa o
1565:     * append num cursor declarado NOT NULL. O estado anterior e restaurado no
1566:     * fim, para nao vazar SET para o resto da datasession.
1567:     *
1568:     * Estruturas transcritas do uso real no dump legado. Nomes de campo
1569:     * PRESERVADOS: sao chave de ControlSource e aparecem literalmente nas
1570:     * expressoes Locate/Replace/Seek das fases de evento.
1571:     *--------------------------------------------------------------------------
1572:     PROTECTED PROCEDURE CriarCursoresGrades()
1573:         LOCAL loc_cNullAnt
1574:         loc_cNullAnt = SET("NULL")
1575:         SET NULL ON
1576: 
1577:         *-- crTpmMvItn: o carrinho - copia local dos itens de SigMvItn da
1578:         *-- movimentacao em andamento. As 23 primeiras colunas sao as de
1579:         *-- SigMvItn que o legado referencia; ImpCupFis e LPrecos NAO existem
1580:         *-- na tabela - sao campos de CONTROLE do cursor local (marcam item ja
1581:         *-- impresso no cupom fiscal e a lista de preco aplicada).
1582:         IF !USED("crTpmMvItn")
1583:             CREATE CURSOR crTpmMvItn ( ;
1584:                 citens     N(10, 0) NULL, ;
1585:                 cpros      C(14)    NULL, ;
1586:                 dpros      C(65)    NULL, ;
1587:                 cunis      C(3)     NULL, ;
1588:                 codbarras  N(14, 0) NULL, ;
1589:                 codlprecs  N(6, 0)  NULL, ;
1590:                 empdopnums C(29)    NULL, ;
1591:                 etiesps    L        NULL, ;
1592:                 fators     N(8, 3)  NULL, ;
1593:                 fatvals    N(15, 6) NULL, ;
1594:                 moedas     C(3)     NULL, ;
1595:                 moefats    C(3)     NULL, ;
1596:                 moevals    N(15, 6) NULL, ;
1597:                 notas      C(6)     NULL, ;
1598:                 opers      C(1)     NULL, ;

*-- Linhas 1616 a 1699:
1616:         *-- "@Z 9999" + identificacao(14) + descricao(65) + separadores).
1617:         *-- Cores e o indice lido pelo DynamicForeColor (0 item .. 4 troco).
1618:         IF !USED("crTpmMvItnC")
1619:             CREATE CURSOR crTpmMvItnC ( ;
1620:                 cItens N(10, 0), ;
1621:                 Linha  N(2, 0), ;
1622:                 Texto  C(90), ;
1623:                 Cores  N(1, 0))
1624:             *-- O legado procura a linha do item com Seek(Str(cItens, 4)),
1625:             *-- entao a chave do indice e a MESMA expressao.
1626:             INDEX ON STR(cItens, 4) TAG cItens
1627:         ENDIF
1628: 
1629:         *-- TmpOperacao: sub-niveis/pendencias vinculados a esta movimentacao.
1630:         IF !USED("TmpOperacao")
1631:             CREATE CURSOR TmpOperacao ( ;
1632:                 Emps      C(3)     NULL, ;
1633:                 Dopes     C(20)    NULL, ;
1634:                 Numes     N(6, 0)  NULL, ;
1635:                 Codigos   N(10, 0) NULL, ;
1636:                 Notas     C(6)     NULL, ;
1637:                 Valos     N(11, 2) NULL, ;
1638:                 VlValVars N(11, 2) NULL, ;
1639:                 EmpSubns  C(29)    NULL, ;
1640:                 ChkSubn   L        NULL, ;
1641:                 Validado  L        NULL, ;
1642:                 Saida     L        NULL)
1643:             INDEX ON STR(Codigos, 10) TAG Codigos
1644:             SET ORDER TO
1645:         ENDIF
1646: 
1647:         *-- TmpDevol: operacoes de credito/devolucao aproveitadas na venda.
1648:         IF !USED("TmpDevol")
1649:             CREATE CURSOR TmpDevol ( ;
1650:                 Emps      C(3)     NULL, ;
1651:                 Dopes     C(20)    NULL, ;
1652:                 Numes     N(6, 0)  NULL, ;
1653:                 Codigos   N(10, 0) NULL, ;
1654:                 TpCodigos N(1, 0)  NULL, ;
1655:                 Saida     L        NULL)
1656:             INDEX ON STR(Codigos, 10) TAG Codigos
1657:             SET ORDER TO
1658:         ENDIF
1659: 
1660:         *-- TmpBarFin: pares de codigo de barras do crediario/carne. nEmps,
1661:         *-- nDopes e nNumes sao NUMERICOS de proposito: o legado os extrai do
1662:         *-- proprio codigo de barras com Val(Left(...)) / Val(Substr(...)).
1663:         IF !USED("TmpBarFin")
1664:             CREATE CURSOR TmpBarFin ( ;
1665:                 nBarra1 N(18, 0), ;
1666:                 nBarra2 N(18, 0), ;
1667:                 nEmps   N(3, 0), ;
1668:                 nDopes  N(5, 0), ;
1669:                 nNumes  N(6, 0), ;
1670:                 nParcs  N(2, 0), ;
1671:                 ValPs   N(11, 2), ;
1672:                 VencPs  D)
1673:             INDEX ON STR(nBarra1, 18) + STR(nBarra2, 18) TAG barras
1674:             SET ORDER TO
1675:         ENDIF
1676: 
1677:         *-- xPar: as parcelas/formas de pagamento lancadas. Espelha as colunas
1678:         *-- de SigMvPar que o legado referencia, MAIS cinco que so existem no
1679:         *-- cursor local (nao estao na tabela): nChaves (agrupador da forma de
1680:         *-- pagamento), Infos e Acumulas (copias do cadastro da forma,
1681:         *-- SigOpFp), pDescs (percentual de desconto aplicado) e Bcds (bonus/
1682:         *-- credito acumulado na parcela).
1683:         IF !USED("xPar")
1684:             CREATE CURSOR xPar ( ;
1685:                 Emps       C(3)     NULL, ;
1686:                 Dopes      C(20)    NULL, ;
1687:                 Numes      N(6, 0)  NULL, ;
1688:                 Datas      D        NULL, ;
1689:                 Parcs      N(2, 0)  NULL, ;
1690:                 tParcs     N(2, 0)  NULL, ;
1691:                 Vencs      D        NULL, ;
1692:                 Valos      N(11, 2) NULL, ;
1693:                 VPags      N(11, 2) NULL, ;
1694:                 ValDescs   N(11, 2) NULL, ;
1695:                 pDescs     N(9, 4)  NULL, ;
1696:                 FPags      C(12)    NULL, ;
1697:                 MoeFPgs    C(3)     NULL, ;
1698:                 CotFPgs    N(11, 4) NULL, ;
1699:                 Trocos     N(1, 0)  NULL, ;

*-- Linhas 1733 a 1774:
1733:     * CurrentControl e Sparse. Por isso a ordem dentro de cada WITH e sempre a
1734:     * mesma e NAO pode ser trocada:
1735:     *
1736:     *   RecordSource -> CurrentControl/Sparse -> ControlSource ->
1737:     *   demais props da coluna -> Width -> Header1.Caption
1738:     *
1739:     * Definir Width antes do RecordSource faz o VFP jogar todas as colunas para
1740:     * o default 90 e os cabecalhos para "Header1". O bloco roda de novo a cada
1741:     * recarga (CarregarDados chama este metodo), exatamente como o legado
1742:     * refazia o bind ao trocar de cursor.
1743:     *
1744:     * Os RecordSource/ControlSource sao os do Init legado (dump linhas
1745:     * 7427-7446 e 7503-7518 de sigmvitn_form_codigo_fonte.txt) e do proprio
1746:     * SCX (Cnt_ChequepreTef.Grade, RecordSource = "XPAR").
1747:     *--------------------------------------------------------------------------
1748:     PROTECTED PROCEDURE MontaGrade()
1749:         LOCAL loc_oGrd, loc_cDyn
1750: 
1751:         *======================================================================
1752:         * Grade do CUPOM (crTpmMvItnC) - coluna unica, sem cabecalho visivel
1753:         * (HeaderHeight = 0), fonte Courier New como o legado troca em runtime.
1754:         *======================================================================
1755:         IF USED("crTpmMvItnC")
1756:             loc_oGrd = THIS.grd_4c_Cupom
1757:             loc_oGrd.RecordSource = "crTpmMvItnC"
1758:             WITH loc_oGrd
1759:                 .Column1.ControlSource = "crTpmMvItnC.Texto"
1760:                 .Column1.Enabled       = .F.
1761:                 .Column1.FontBold      = .T.
1762:                 .Column1.FontName      = "Courier New"
1763:                 .Column1.Movable       = .F.
1764:                 .Column1.ReadOnly      = .T.
1765:                 .Column1.ForeColor     = RGB(0, 0, 255)
1766: 
1767:                 .Column1.Text1.Enabled   = .F.
1768:                 .Column1.Text1.FontBold  = .T.
1769:                 .Column1.Text1.FontName  = "Courier New"
1770:                 .Column1.Text1.ReadOnly  = .T.
1771:                 .Column1.Text1.ForeColor = RGB(0, 0, 255)
1772:                 .Column1.Text1.Width     = 345
1773: 
1774:                 .Column1.Width = 345

*-- Linhas 1793 a 1835:
1793:             loc_oGrd = THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
1794:             loc_oGrd.RecordSource = "TmpOperacao"
1795:             WITH loc_oGrd
1796:                 .Column1.ControlSource = "TmpOperacao.Codigos"
1797:                 .Column1.FontName      = "Verdana"
1798:                 .Column1.InputMask     = "9999999999"
1799:                 .Column1.Movable       = .F.
1800:                 .Column1.Resizable     = .F.
1801:                 .Column1.ForeColor     = RGB(36, 84, 155)
1802:                 .Column1.BackColor     = RGB(254, 255, 232)
1803:                 .Column1.Text1.FontName  = "Verdana"
1804:                 .Column1.Text1.Margin    = 0
1805:                 .Column1.Text1.ForeColor = RGB(36, 84, 155)
1806:                 .Column1.Text1.BackColor = RGB(254, 255, 232)
1807: 
1808:                 .Column2.ControlSource = "TmpOperacao.Notas"
1809:                 .Column2.FontName      = "Verdana"
1810:                 .Column2.Movable       = .F.
1811:                 .Column2.Resizable     = .F.
1812:                 .Column2.ForeColor     = RGB(36, 84, 155)
1813:                 .Column2.BackColor     = RGB(254, 255, 232)
1814:                 .Column2.Text1.FontName    = "Verdana"
1815:                 .Column2.Text1.BorderStyle = 0
1816:                 .Column2.Text1.Margin      = 0
1817:                 .Column2.Text1.ForeColor   = RGB(36, 84, 155)
1818:                 .Column2.Text1.BackColor   = RGB(254, 255, 232)
1819: 
1820:                 .Column3.ControlSource = "TmpOperacao.Valos"
1821:                 .Column3.FontName      = "Verdana"
1822:                 .Column3.ForeColor     = RGB(36, 84, 155)
1823:                 .Column3.BackColor     = RGB(254, 255, 232)
1824:                 .Column3.Text1.FontName    = "Verdana"
1825:                 .Column3.Text1.BorderStyle = 0
1826:                 .Column3.Text1.Margin      = 0
1827:                 .Column3.Text1.ForeColor   = RGB(36, 84, 155)
1828:                 .Column3.Text1.BackColor   = RGB(254, 255, 232)
1829: 
1830:                 .Column1.Width = 80
1831:                 .Column2.Width = 80
1832:                 .Column3.Width = 90
1833: 
1834:                 .Column1.Header1.FontBold  = .T.
1835:                 .Column1.Header1.FontName  = "Verdana"

*-- Linhas 1864 a 1905:
1864:                 .Column1.CurrentControl = "txt_4c__Devol"
1865:                 .Column1.Sparse         = .F.
1866: 
1867:                 .Column1.ControlSource = "TmpDevol.Codigos"
1868:                 .Column1.FontName      = "Courier New"
1869:                 .Column1.InputMask     = "9999999999"
1870:                 .Column1.Movable       = .F.
1871:                 .Column1.Resizable     = .F.
1872:                 .Column1.BackColor     = RGB(254, 255, 232)
1873:                 .Column1.txt_4c__Devol.FontName  = "Courier New"
1874:                 .Column1.txt_4c__Devol.InputMask = "9999999999"
1875:                 .Column1.txt_4c__Devol.Margin    = 0
1876:                 .Column1.txt_4c__Devol.ForeColor = RGB(0, 0, 0)
1877:                 .Column1.txt_4c__Devol.BackColor = RGB(254, 255, 232)
1878: 
1879:                 .Column2.ControlSource = "TmpDevol.Dopes"
1880:                 .Column2.FontName      = "Courier New"
1881:                 .Column2.Movable       = .F.
1882:                 .Column2.Resizable     = .F.
1883:                 .Column2.BackColor     = RGB(254, 255, 232)
1884:                 .Column2.Text1.FontName    = "Courier New"
1885:                 .Column2.Text1.BorderStyle = 0
1886:                 .Column2.Text1.Margin      = 0
1887:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
1888:                 .Column2.Text1.BackColor   = RGB(254, 255, 232)
1889: 
1890:                 .Column3.ControlSource = "TmpDevol.Numes"
1891:                 .Column3.BackColor     = RGB(254, 255, 232)
1892:                 .Column3.Text1.BorderStyle = 0
1893:                 .Column3.Text1.Margin      = 0
1894:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)
1895:                 .Column3.Text1.BackColor   = RGB(254, 255, 232)
1896: 
1897:                 .Column1.Width = 82
1898:                 .Column2.Width = 180
1899:                 .Column3.Width = 70
1900: 
1901:                 .Column1.Header1.FontBold  = .T.
1902:                 .Column1.Header1.FontSize  = 8
1903:                 .Column1.Header1.Alignment = 2
1904:                 .Column1.Header1.Caption   = "Op. Cr" + CHR(233) + "dito"
1905: 

*-- Linhas 1922 a 1943:
1922:             loc_oGrd = THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras
1923:             loc_oGrd.RecordSource = "TmpBarFin"
1924:             WITH loc_oGrd
1925:                 .Column1.ControlSource = "TmpBarFin.nBarra2"
1926:                 .Column2.ControlSource = "TmpBarFin.nParcs"
1927:                 .Column3.ControlSource = "TmpBarFin.ValPs"
1928:                 .Column4.ControlSource = "TmpBarFin.VencPs"
1929: 
1930:                 .Column1.Text1.BorderStyle = 0
1931:                 .Column1.Text1.Margin      = 0
1932:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
1933:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
1934:                 .Column2.Text1.BorderStyle = 0
1935:                 .Column2.Text1.Margin      = 0
1936:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
1937:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
1938:                 .Column3.Text1.BorderStyle = 0
1939:                 .Column3.Text1.Margin      = 0
1940:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)
1941:                 .Column3.Text1.BackColor   = RGB(255, 255, 255)
1942:                 .Column4.Text1.BorderStyle = 0
1943:                 .Column4.Text1.Margin      = 0

*-- Linhas 1971 a 2036:
1971:                 *-- alterar valor, vencimento e moeda da parcela, mas nunca a
1972:                 *-- forma de pagamento ja escolhida. Column.ReadOnly vem DEPOIS
1973:                 *-- de Grid.ReadOnly, senao o do grid sobrescreve o da coluna.
1974:                 .Column1.ControlSource = "xPar.FPags"
1975:                 .Column1.FontName      = "Tahoma"
1976:                 .Column1.FontSize      = 8
1977:                 .Column1.Movable       = .F.
1978:                 .Column1.Resizable     = .F.
1979:                 .Column1.ReadOnly      = .T.
1980:                 .Column1.Text1.FontName    = "Tahoma"
1981:                 .Column1.Text1.FontSize    = 8
1982:                 .Column1.Text1.BorderStyle = 0
1983:                 .Column1.Text1.Margin      = 0
1984:                 .Column1.Text1.ReadOnly    = .T.
1985:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
1986:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
1987: 
1988:                 .Column2.ControlSource = "xPar.Valos"
1989:                 .Column2.FontName      = "Tahoma"
1990:                 .Column2.FontSize      = 8
1991:                 .Column2.Movable       = .F.
1992:                 .Column2.Resizable     = .F.
1993:                 .Column2.ReadOnly      = .F.
1994:                 .Column2.InputMask     = "999999,999.99"
1995:                 .Column2.Text1.FontName    = "Tahoma"
1996:                 .Column2.Text1.FontSize    = 8
1997:                 .Column2.Text1.BorderStyle = 0
1998:                 .Column2.Text1.Margin      = 0
1999:                 .Column2.Text1.ReadOnly    = .F.
2000:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
2001:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
2002: 
2003:                 .Column3.ControlSource = "xPar.Vencs"
2004:                 .Column3.FontName      = "Tahoma"
2005:                 .Column3.FontSize      = 8
2006:                 .Column3.Movable       = .F.
2007:                 .Column3.Resizable     = .F.
2008:                 .Column3.ReadOnly      = .F.
2009:                 .Column3.Text1.FontName        = "Tahoma"
2010:                 .Column3.Text1.FontSize        = 8
2011:                 .Column3.Text1.BorderStyle     = 0
2012:                 .Column3.Text1.Margin          = 0
2013:                 .Column3.Text1.ReadOnly        = .F.
2014:                 .Column3.Text1.StrictDateEntry = 0
2015:                 .Column3.Text1.Format          = "E"
2016:                 .Column3.Text1.InputMask       = "99/99/9999"
2017:                 .Column3.Text1.MaxLength       = 10
2018:                 .Column3.Text1.ForeColor       = RGB(0, 0, 0)
2019:                 .Column3.Text1.BackColor       = RGB(255, 255, 255)
2020: 
2021:                 .Column4.ControlSource = "xPar.MoeFPgs"
2022:                 .Column4.FontName      = "Tahoma"
2023:                 .Column4.FontSize      = 8
2024:                 .Column4.Movable       = .F.
2025:                 .Column4.Resizable     = .F.
2026:                 .Column4.ReadOnly      = .F.
2027:                 .Column4.Text1.FontName    = "Tahoma"
2028:                 .Column4.Text1.FontSize    = 8
2029:                 .Column4.Text1.BorderStyle = 0
2030:                 .Column4.Text1.Margin      = 0
2031:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)
2032:                 .Column4.Text1.BackColor   = RGB(255, 255, 255)
2033: 
2034:                 .Column1.Width = 120
2035:                 .Column2.Width = 110
2036:                 .Column3.Width = 78

*-- Linhas 2064 a 2083:
2064:     *
2065:     * 1) Le do banco, pelo BO, os itens ja gravados da movimentacao corrente e
2066:     *    despeja no carrinho (crTpmMvItn). A leitura vai SEMPRE para um cursor
2067:     *    TEMPORARIO e so dali entra no cursor da grade, por ZAP + APPEND FROM
2068:     *    DBF(): SQLEXEC direto no alias da grade recria o cursor e destroi as
2069:     *    colunas e o binding.
2070:     * 2) Remonta as linhas de texto do cupom (crTpmMvItnC) a partir da carga,
2071:     *    com a mesma formatacao do AtuaCupom legado.
2072:     * 3) Refaz o bind (MontaGrade) e, como o legado sempre faz, posiciona no
2073:     *    topo e manda cada grade se repintar - popular cursor NAO repinta a
2074:     *    grade sozinho, e sem isso a tela parece vazia com o cursor cheio.
2075:     *
2076:     * Movimentacao SEM numero ainda (venda nova, this_nNumes = 0) nao tem item
2077:     * gravado: o carrinho fica vazio, o painel CAIXA LIVRE continua visivel e
2078:     * as grades sao repintadas vazias - que e exatamente o estado inicial do
2079:     * legado quando o caixa abre sem operacao em andamento.
2080:     *--------------------------------------------------------------------------
2081:     PROCEDURE CarregarDados()
2082:         LOCAL loc_lSucesso, loc_oErro
2083:         loc_lSucesso = .F.

*-- Linhas 2092 a 2118:
2092:                         THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
2093:                         "cursor_4c_ItensTmp")
2094: 
2095:                     SELECT crTpmMvItn
2096:                     ZAP
2097:                     IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
2098:                         APPEND FROM DBF("cursor_4c_ItensTmp")
2099:                     ENDIF
2100: 
2101:                     *-- Numero do proximo item = ultimo lancado, como o legado
2102:                     *-- faz no fim do Init (Goto Bottom / CItem = cItens).
2103:                     SELECT crTpmMvItn
2104:                     GO BOTTOM
2105:                     THIS.this_nCitem = IIF(RECCOUNT("crTpmMvItn") > 0, ;
2106:                         NVL(crTpmMvItn.citens, 0), 0)
2107: 
2108:                     THIS.MontarLinhasCupom()
2109: 
2110:                     IF USED("cursor_4c_ItensTmp")
2111:                         USE IN cursor_4c_ItensTmp
2112:                     ENDIF
2113:                 ENDIF
2114:             ENDIF
2115: 
2116:             THIS.MontaGrade()
2117:             THIS.AtualizarGrades()
2118: 

*-- Linhas 2149 a 2199:
2149:     * impressora fiscal.
2150:     *
2151:     * Le do cursor TEMPORARIO da carga (cursor_4c_ItensTmp) porque e nele que
2152:     * vem, no mesmo SELECT, os campos do cadastro do produto; o carrinho
2153:     * (crTpmMvItn) so tem as colunas da tabela de itens, como no legado.
2154:     *--------------------------------------------------------------------------
2155:     PROTECTED PROCEDURE MontarLinhasCupom()
2156:         LOCAL loc_nIdentPro, loc_nOpCrs, loc_cDescr, loc_nCodBarra, loc_cIdent
2157:         LOCAL loc_nNotas, loc_cTexto, loc_nAreaAnt, loc_lProsseguir
2158: 
2159:         loc_lProsseguir = USED("cursor_4c_ItensTmp") AND USED("crTpmMvItnC")
2160: 
2161:         IF loc_lProsseguir
2162:             loc_nAreaAnt = SELECT()
2163: 
2164:             *-- Parametros da operacao (no legado, cursores globais CrSigOpCdd
2165:             *-- e CrSigCdOpe montados pela tela de movimentacao).
2166:             loc_nIdentPro = 0
2167:             loc_nOpCrs    = 0
2168:             IF THIS.this_oBusinessObject.CarregarParametrosOperacao( ;
2169:                     THIS.this_cDopes, "cursor_4c_ParOperacao")
2170:                 IF USED("cursor_4c_ParOperacao") AND RECCOUNT("cursor_4c_ParOperacao") > 0
2171:                     SELECT cursor_4c_ParOperacao
2172:                     GO TOP
2173:                     loc_nIdentPro = NVL(cursor_4c_ParOperacao.identpro, 0)
2174:                     loc_nOpCrs    = NVL(cursor_4c_ParOperacao.opcrs, 0)
2175:                 ENDIF
2176:                 IF USED("cursor_4c_ParOperacao")
2177:                     USE IN cursor_4c_ParOperacao
2178:                 ENDIF
2179:             ENDIF
2180: 
2181:             SELECT crTpmMvItnC
2182:             ZAP
2183: 
2184:             SELECT cursor_4c_ItensTmp
2185:             SCAN
2186:                 loc_cDescr    = NVL(cursor_4c_ItensTmp.dpros, "")
2187:                 loc_nCodBarra = 0
2188: 
2189:                 IF loc_nIdentPro = 1 AND loc_nOpCrs <> 4
2190:                     loc_cDescr = PADR(fLimpaTexto( ;
2191:                         MLINE(NVL(cursor_4c_ItensTmp.prodescfis, ""), 1)), 40)
2192:                 ELSE
2193:                     IF NVL(cursor_4c_ItensTmp.codbarras, 0) <> 0
2194:                         loc_nCodBarra = NVL(cursor_4c_ItensTmp.codbarras, 0)
2195:                     ELSE
2196:                         loc_nNotas = VAL(NVL(cursor_4c_ItensTmp.notas, ""))
2197:                         IF loc_nOpCrs = 4 ;
2198:                                 AND !EMPTY(ALLTRIM(NVL(cursor_4c_ItensTmp.notas, ""))) ;
2199:                                 AND TRANSFORM(loc_nNotas, "@L 999999") = ;

*-- Linhas 2216 a 2266:
2216:                 *-- Linha 1: item + identificacao + descricao.
2217:                 loc_cTexto = TRANSFORM(NVL(cursor_4c_ItensTmp.citens, 0), "@Z 9999") + ;
2218:                     " " + PADR(loc_cIdent, 14) + " " + ALLTRIM(loc_cDescr)
2219:                 INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
2220:                     VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 1, loc_cTexto, 0)
2221: 
2222:                 IF NVL(cursor_4c_ItensTmp.valdescs, 0) <> 0
2223:                     loc_cTexto = "    " + ;
2224:                         TRANSFORM(NVL(cursor_4c_ItensTmp.qtds, 0), "@Z 999.99") + " " + ;
2225:                         NVL(cursor_4c_ItensTmp.cunis, "") + " X  " + ;
2226:                         TRANSFORM(NVL(cursor_4c_ItensTmp.univals, 0), "@Z 999,999,999.99") + ;
2227:                         " " + TRANSFORM(NVL(cursor_4c_ItensTmp.univals, 0) * ;
2228:                             NVL(cursor_4c_ItensTmp.qtds, 0), "@Z 999,999,999.99")
2229:                     INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
2230:                         VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 2, loc_cTexto, 0)
2231: 
2232:                     loc_cTexto = "    " + ;
2233:                         IIF(NVL(cursor_4c_ItensTmp.valdescs, 0) < 0, "Acrescimo", "Desconto ") + ;
2234:                         TRANSFORM(NVL(cursor_4c_ItensTmp.valdescs, 0) * (-1), ;
2235:                             "@Z 999,999,999.99") + " " + ;
2236:                         TRANSFORM(NVL(cursor_4c_ItensTmp.totas, 0), "@Z 999,999,999.99")
2237:                     INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
2238:                         VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 2, loc_cTexto, 0)
2239:                 ELSE
2240:                     loc_cTexto = "    " + ;
2241:                         TRANSFORM(NVL(cursor_4c_ItensTmp.qtds, 0), "@Z 999.99") + " " + ;
2242:                         NVL(cursor_4c_ItensTmp.cunis, "") + " X  " + ;
2243:                         TRANSFORM(NVL(cursor_4c_ItensTmp.units, 0), "@Z 999,999,999.99") + ;
2244:                         " " + TRANSFORM(NVL(cursor_4c_ItensTmp.totas, 0), "@Z 999,999,999.99")
2245:                     INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
2246:                         VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 2, loc_cTexto, 0)
2247:                 ENDIF
2248:             ENDSCAN
2249: 
2250:             IF loc_nAreaAnt > 0
2251:                 SELECT (loc_nAreaAnt)
2252:             ENDIF
2253:         ENDIF
2254:     ENDPROC
2255: 
2256:     *--------------------------------------------------------------------------
2257:     * AtualizarGrades - posiciona TODOS os cursores das grades no topo e manda
2258:     * cada grade se repintar. Popular um cursor NAO repinta a grade ligada a
2259:     * ele: sem este passo a tela aparece vazia com o cursor cheio, e o sintoma
2260:     * ("a tela nao traz dados") manda o diagnostico para o SQL, que esta certo.
2261:     * O legado fecha assim toda carga - "Go Top In <cursor>" + "<grade>.Refresh".
2262:     *--------------------------------------------------------------------------
2263:     PROCEDURE AtualizarGrades()
2264:         IF USED("crTpmMvItnC")
2265:             GO TOP IN crTpmMvItnC
2266:             THIS.grd_4c_Cupom.Refresh()

*-- Linhas 3423 a 3441:
3423:     *     sem colisao de nome)
3424:     *   Get_total Alignment=3 Value=0 FontSize=20 InputMask="9,999,999.99"
3425:     *     Height=45 Left=92 SpecialEffect=1 Top=354 Width=218
3426:     *     BackColor=188,225,245. NAO recebe o ControlSource="TprMvCab.ValInis"
3427:     *     do legado - TprMvCab e o cursor de cabecalho do form PAI, fora de
3428:     *     alcance com DataSession=2 isolado (mesma decisao das Fases 1-4); o
3429:     *     valor e populado por evento nas Fases 7-8.
3430:     *--------------------------------------------------------------------------
3431:     PROTECTED PROCEDURE ConfigurarCamposFinanc()
3432:         LOCAL loc_cIcones, loc_oCnt, loc_oSub
3433:         loc_cIcones = gc_4c_CaminhoIcones
3434:         loc_oCnt    = THIS.cnt_4c_Financ
3435: 
3436:         loc_oCnt.AddObject("shp_4c_Shape4", "Shape")
3437:         WITH loc_oCnt.shp_4c_Shape4
3438:             .Top           = 349
3439:             .Left          = 0
3440:             .Width         = 370
3441:             .Height        = 3

*-- Linhas 5534 a 5575:
5534:     * auto-preenche com o primeiro match parcial sem selecao explicita).
5535:     * Padrao canonico FormBuscaAuxiliar (CLAUDE.md #36/#37): o proprio Init ja
5536:     * tenta o match EXATO e so mostra o picker se nao encontrar - por isso NAO
5537:     * ha um SQLEXEC de pre-checagem aqui, so a chamada direta.
5538:     *==========================================================================
5539: 
5540:     *--------------------------------------------------------------------------
5541:     * AbrirLookupGrupo - Grupo de Contas (SigCdGcr.codigos/descrs).
5542:     *--------------------------------------------------------------------------
5543:     PROTECTED PROCEDURE AbrirLookupGrupo(par_oTxtGrupo)
5544:         LOCAL loc_oBusca
5545: 
5546:         IF USED("cursor_4c_BuscaGrupo")
5547:             USE IN cursor_4c_BuscaGrupo
5548:         ENDIF
5549: 
5550:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
5551:             "cursor_4c_BuscaGrupo", "codigos", ALLTRIM(par_oTxtGrupo.Value), "Grupo de Contas")
5552: 
5553:         IF VARTYPE(loc_oBusca) = "O"
5554:             IF !loc_oBusca.this_lAchouRegistro
5555:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
5556:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5557:                 loc_oBusca.Show()
5558:             ENDIF
5559:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
5560:                 SELECT cursor_4c_BuscaGrupo
5561:                 par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
5562:             ENDIF
5563:             loc_oBusca.Release()
5564:         ENDIF
5565: 
5566:         IF USED("cursor_4c_BuscaGrupo")
5567:             USE IN cursor_4c_BuscaGrupo
5568:         ENDIF
5569:     ENDPROC
5570: 
5571:     *--------------------------------------------------------------------------
5572:     * AbrirLookupConta - Contas (SigCdCli.iclis/rclis/cpfs/grupos). Busca por
5573:     * par_cCampoBusca ("iclis"/"rclis"/"cpfs" - o campo que o usuario digitou)
5574:     * com par_cValorBusca; filtra por Grupo quando par_oTxtGrupo ja tem valor.
5575:     * Preenche Conta+Nome+Cpf sempre; Grupo so se estava vazio (nao sobrescreve

*-- Linhas 5581 a 5617:
5581: 
5582:         loc_cFiltro = ""
5583:         IF VARTYPE(par_oTxtGrupo) = "O" AND !EMPTY(ALLTRIM(par_oTxtGrupo.Value))
5584:             loc_cFiltro = "grupos = " + EscaparSQL(PADR(ALLTRIM(par_oTxtGrupo.Value), 10))
5585:         ENDIF
5586: 
5587:         IF USED("cursor_4c_BuscaConta")
5588:             USE IN cursor_4c_BuscaConta
5589:         ENDIF
5590: 
5591:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
5592:             "cursor_4c_BuscaConta", par_cCampoBusca, par_cValorBusca, "Contas", .F., .T., loc_cFiltro)
5593: 
5594:         IF VARTYPE(loc_oBusca) = "O"
5595:             IF !loc_oBusca.this_lAchouRegistro
5596:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5597:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
5598:                 loc_oBusca.mAddColuna("cpfs",  "", "CPF" + CHR(47) + "CNPJ")
5599:                 loc_oBusca.Show()
5600:             ENDIF
5601:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
5602:                 SELECT cursor_4c_BuscaConta
5603:                 par_oTxtConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
5604:                 IF VARTYPE(par_oTxtDconta) = "O"
5605:                     par_oTxtDconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
5606:                 ENDIF
5607:                 IF VARTYPE(par_oTxtCpf) = "O"
5608:                     par_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaConta.cpfs)
5609:                 ENDIF
5610:                 IF VARTYPE(par_oTxtGrupo) = "O" AND EMPTY(ALLTRIM(par_oTxtGrupo.Value))
5611:                     par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaConta.grupos)
5612:                 ENDIF
5613:             ENDIF
5614:             loc_oBusca.Release()
5615:         ENDIF
5616: 
5617:         IF USED("cursor_4c_BuscaConta")

*-- Linhas 5639 a 5657:
5639:                 loc_oBusca.Show()
5640:             ENDIF
5641:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
5642:                 SELECT cursor_4c_BuscaTabd
5643:                 par_oTxtTabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
5644:             ENDIF
5645:             loc_oBusca.Release()
5646:         ENDIF
5647: 
5648:         IF USED("cursor_4c_BuscaTabd")
5649:             USE IN cursor_4c_BuscaTabd
5650:         ENDIF
5651:     ENDPROC
5652: 
5653:     *--------------------------------------------------------------------------
5654:     * AbrirLookupListaPreco - Listas de Preco (SigCdLpc.lprecos).
5655:     *--------------------------------------------------------------------------
5656:     PROTECTED PROCEDURE AbrirLookupListaPreco(par_oTxtListaPreco)
5657:         LOCAL loc_oBusca

*-- Linhas 5670 a 5688:
5670:                 loc_oBusca.Show()
5671:             ENDIF
5672:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaListaPreco")
5673:                 SELECT cursor_4c_BuscaListaPreco
5674:                 par_oTxtListaPreco.Value = ALLTRIM(cursor_4c_BuscaListaPreco.lprecos)
5675:             ENDIF
5676:             loc_oBusca.Release()
5677:         ENDIF
5678: 
5679:         IF USED("cursor_4c_BuscaListaPreco")
5680:             USE IN cursor_4c_BuscaListaPreco
5681:         ENDIF
5682:     ENDPROC
5683: 
5684:     *--------------------------------------------------------------------------
5685:     * AbrirLookupFormaPagamento - Forma de Pagamento (SigOpFp.fpags/descrs).
5686:     *--------------------------------------------------------------------------
5687:     PROTECTED PROCEDURE AbrirLookupFormaPagamento(par_oTxtFpg)
5688:         LOCAL loc_oBusca

*-- Linhas 5702 a 5720:
5702:                 loc_oBusca.Show()
5703:             ENDIF
5704:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
5705:                 SELECT cursor_4c_BuscaFpg
5706:                 par_oTxtFpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
5707:             ENDIF
5708:             loc_oBusca.Release()
5709:         ENDIF
5710: 
5711:         IF USED("cursor_4c_BuscaFpg")
5712:             USE IN cursor_4c_BuscaFpg
5713:         ENDIF
5714:     ENDPROC
5715: 
5716:     *==========================================================================
5717:     * FASE 7/8 - EVENTOS PRINCIPAIS
5718:     *
5719:     * Liga os Click/KeyPress dos 17 CommandButtons da barra principal (Fase
5720:     * 3), dos 4 botoes de acao das grades (Fase 4), dos paineis CancelaItem/

*-- Linhas 5875 a 5918:
5875:         loc_nQt = 0
5876: 
5877:         IF USED("xPar")
5878:             loc_nAreaAnt = SELECT()
5879:             SELECT xPar
5880:             COUNT FOR Valos > 0 AND !EMPTY(FPags) AND !InsChs TO loc_nQt
5881:             IF loc_nAreaAnt > 0
5882:                 SELECT (loc_nAreaAnt)
5883:             ENDIF
5884:         ENDIF
5885: 
5886:         RETURN (loc_nQt > 0)
5887:     ENDFUNC
5888: 
5889:     *--------------------------------------------------------------------------
5890:     * RecalcularTotalCarrinho - soma crTpmMvItn.totas e atualiza o TOTAL da
5891:     * tela de Itens + a propriedade this_nTotal. Chamado sempre que um item e
5892:     * removido do carrinho localmente (CancelaItemOkClick).
5893:     *--------------------------------------------------------------------------
5894:     PROTECTED PROCEDURE RecalcularTotalCarrinho()
5895:         LOCAL loc_nTotal, loc_nAreaAnt
5896:         loc_nTotal = 0
5897: 
5898:         IF USED("crTpmMvItn")
5899:             loc_nAreaAnt = SELECT()
5900:             SELECT crTpmMvItn
5901:             SUM totas TO loc_nTotal
5902:             IF loc_nAreaAnt > 0
5903:                 SELECT (loc_nAreaAnt)
5904:             ENDIF
5905:         ENDIF
5906: 
5907:         THIS.this_nTotal = loc_nTotal
5908:         THIS.cnt_4c_Item.txt_4c_Total.Value = loc_nTotal
5909:     ENDPROC
5910: 
5911:     *--------------------------------------------------------------------------
5912:     * CancelaItemFechar - fecha o painel de cancelamento e devolve o controle
5913:     * a tela de Itens. Compartilhado por CancelaItemOkClick (apos processar) e
5914:     * CancelaItemCancelaDispClick.
5915:     *--------------------------------------------------------------------------
5916:     PROTECTED PROCEDURE CancelaItemFechar()
5917:         THIS.cnt_4c_CancelaItem.Visible = .F.
5918:         THIS.cnt_4c_Item.Enabled        = .T.

*-- Linhas 5994 a 6051:
5994:     ENDPROC
5995: 
5996:     *-- [F4] CancPagto - cancela a ULTIMA forma de pagamento lancada (xPar).
5997:     *-- A baixa em gateway TEF (DeleteSigTef, do legado) nao tem equivalente
5998:     *-- nesta migracao - so a parcela local (e as demais da mesma "chave" de
5999:     *-- lancamento, nChaves) e removida.
6000:     PROCEDURE CmdCancPagtoClick()
6001:         LOCAL loc_nChave
6002: 
6003:         IF !USED("xPar")
6004:             RETURN
6005:         ENDIF
6006: 
6007:         SELECT xPar
6008:         GO BOTTOM
6009:         IF EOF()
6010:             RETURN
6011:         ENDIF
6012: 
6013:         loc_nChave = xPar.nChaves
6014:         DELETE FOR nChaves == loc_nChave
6015: 
6016:         THIS.AtualizarGrades()
6017:         THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6018:     ENDPROC
6019: 
6020:     *-- [F4] Apaga - abre o painel de cancelamento com os dados do ULTIMO
6021:     *-- item lancado. Legado (Barra_Botoes.apaga.Click): guarda "Not
6022:     *-- Empty(Get_Produto.Value) Return" + "Get_item.Value = Citem-1" +
6023:     *-- "Locate For citens = Get_item.Value" + preenche Produto/Descricao/
6024:     *-- Barra do painel.
6025:     PROCEDURE CmdApagaClick()
6026:         LOCAL loc_nItem
6027: 
6028:         IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value)
6029:             RETURN
6030:         ENDIF
6031: 
6032:         IF !USED("crTpmMvItn")
6033:             RETURN
6034:         ENDIF
6035: 
6036:         SELECT crTpmMvItn
6037:         LOCATE
6038:         IF EOF()
6039:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " item lan" + CHR(231) + "ado para cancelar.", "Cancelar Item")
6040:             RETURN
6041:         ENDIF
6042: 
6043:         loc_nItem = THIS.this_nCitem - 1
6044: 
6045:         LOCATE FOR citens == loc_nItem
6046:         IF EOF()
6047:             GO BOTTOM
6048:             loc_nItem = NVL(crTpmMvItn.citens, 0)
6049:         ENDIF
6050: 
6051:         WITH THIS.cnt_4c_CancelaItem

*-- Linhas 6167 a 6229:
6167:         LOCAL loc_nQt, loc_oErro
6168: 
6169:         IF USED("xPar")
6170:             SELECT xPar
6171:             COUNT FOR Valos > 0 AND !EMPTY(FPags) TO loc_nQt
6172:             IF loc_nQt > 0
6173:                 MsgAviso("Condi" + CHR(231) + CHR(245) + "es de Pagamento j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6174:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6175:                 RETURN
6176:             ENDIF
6177:         ENDIF
6178: 
6179:         IF USED("TmpOperacao")
6180:             SELECT TmpOperacao
6181:             COUNT FOR Codigos > 0 TO loc_nQt
6182:             IF loc_nQt > 0
6183:                 MsgAviso("Opera" + CHR(231) + CHR(245) + "es de SubN" + CHR(237) + "veis j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6184:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6185:                 RETURN
6186:             ENDIF
6187:         ENDIF
6188: 
6189:         IF USED("TmpDevol")
6190:             SELECT TmpDevol
6191:             COUNT FOR Codigos > 0 TO loc_nQt
6192:             IF loc_nQt > 0
6193:                 MsgAviso("Opera" + CHR(231) + CHR(245) + "es de Cr" + CHR(233) + "dito j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
6194:                     "Muda Opera" + CHR(231) + CHR(227) + "o")
6195:                 RETURN
6196:             ENDIF
6197:         ENDIF
6198: 
6199:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
6200:             RETURN
6201:         ENDIF
6202: 
6203:         TRY
6204:             IF USED("cursor_4c_ListaOpe")
6205:                 USE IN cursor_4c_ListaOpe
6206:             ENDIF
6207: 
6208:             IF SQLEXEC(gnConnHandle, "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", "cursor_4c_ListaOpe") > 0 ;
6209:                     AND USED("cursor_4c_ListaOpe") AND RECCOUNT("cursor_4c_ListaOpe") > 0
6210: 
6211:                 THIS.cbo_4c_CmbTOpers.RowSourceType = 0
6212:                 THIS.cbo_4c_CmbTOpers.Clear()
6213: 
6214:                 SELECT cursor_4c_ListaOpe
6215:                 SCAN
6216:                     THIS.cbo_4c_CmbTOpers.AddItem(ALLTRIM(cursor_4c_ListaOpe.Dopes))
6217:                 ENDSCAN
6218: 
6219:                 THIS.cbo_4c_CmbTOpers.Visible = .T.
6220:                 THIS.FocarControle(THIS.cbo_4c_CmbTOpers)
6221:             ENDIF
6222: 
6223:             IF USED("cursor_4c_ListaOpe")
6224:                 USE IN cursor_4c_ListaOpe
6225:             ENDIF
6226:         CATCH TO loc_oErro
6227:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
6228:                 "Erro em Muda Opera" + CHR(231) + CHR(227) + "o")
6229:         ENDTRY

*-- Linhas 6238 a 6300:
6238:             RETURN
6239:         ENDIF
6240: 
6241:         SELECT crTpmMvItn
6242:         LOCATE
6243:         IF EOF()
6244:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens lan" + CHR(231) + "ados para pagamento.", "Pagamento")
6245:             RETURN
6246:         ENDIF
6247: 
6248:         THIS.AlternarTelaOperacao("FPAGTO")
6249:         THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6250:     ENDPROC
6251: 
6252:     *-- Confirmar (cmd_4c_Ok) - legado (Barra_Botoes.ok.Click, 25 linhas):
6253:     *-- valida sub-nivel/pagamento e chama AcioSalva() no ParentForm, que
6254:     *-- gravava o cursor de itens inteiro com TableUpdate na datasession
6255:     *-- COMPARTILHADA e fechava o cupom fiscal.
6256:     *--
6257:     *-- Aqui: sem item lancado, so fecha o Caixa; havendo itens, exige forma de
6258:     *-- pagamento informada e GRAVA os itens em SigMvItn pelo BO antes de
6259:     *-- devolver o controle a tela de movimentacao. A gravacao acontece NESTE
6260:     *-- form porque DataSession = 2 isola o carrinho (crTpmMvItn) do form pai -
6261:     *-- sem ela os itens morreriam na memoria ao fechar a tela e o Confirmar
6262:     *-- anunciaria "venda validada" sem nada no banco.
6263:     *--
6264:     *-- A finalizacao FISCAL (emissao do cupom / TEF) continua sendo do form
6265:     *-- pai: depende da impressora fiscal, que esta fora de alcance daqui.
6266:     PROCEDURE BtnConfirmarClick()
6267:         LOCAL loc_nItens, loc_lTemPagamento
6268: 
6269:         *-- Conta so as linhas com produto: o carrinho mantem uma linha em
6270:         *-- branco aberta para o proximo item (LimparCntItem), que NAO conta
6271:         *-- como venda.
6272:         loc_nItens = 0
6273:         IF USED("crTpmMvItn")
6274:             SELECT crTpmMvItn
6275:             COUNT FOR !EMPTY(NVL(cpros, "")) AND !DELETED() TO loc_nItens
6276:         ENDIF
6277: 
6278:         IF loc_nItens = 0
6279:             THIS.Release()
6280:             RETURN
6281:         ENDIF
6282: 
6283:         loc_lTemPagamento = .F.
6284:         IF USED("xPar")
6285:             SELECT xPar
6286:             LOCATE FOR !EMPTY(FPags)
6287:             loc_lTemPagamento = !EOF()
6288:         ENDIF
6289: 
6290:         IF !loc_lTemPagamento
6291:             MsgAviso("Informe a forma de pagamento antes de confirmar a venda.", "Confirmar")
6292:             THIS.CmdPagtoClick()
6293:             RETURN
6294:         ENDIF
6295: 
6296:         *-- Grava os itens. Falhando, NAO fecha a tela e NAO anuncia sucesso -
6297:         *-- o caixa continua com o carrinho na tela para corrigir e repetir.
6298:         *-- BusinessBase.Salvar() ja exibiu o motivo (CLAUDE.md #20).
6299:         IF !THIS.GravarItensLancados()
6300:             RETURN

*-- Linhas 6328 a 6426:
6328:         THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__Barras.txt_4c_Barra_1)
6329:     ENDPROC
6330: 
6331:     *-- F4-Excluir - legado: "Select TmpBarFin / Delete / Go Top /
6332:     *-- ThisForm.parentForm.Atuatot() / Get_total.Refresh() / Grade.Refresh()".
6333:     *-- Atuatot() do form pai fica fora de alcance (DataSession=2) - o total
6334:     *-- do carne e recalculado aqui, localmente, a partir do proprio
6335:     *-- TmpBarFin.
6336:     PROCEDURE CmdExcluirBarraClick()
6337:         LOCAL loc_nTotal
6338:         loc_nTotal = 0
6339: 
6340:         IF !USED("TmpBarFin")
6341:             RETURN
6342:         ENDIF
6343: 
6344:         SELECT TmpBarFin
6345:         DELETE
6346:         GO TOP
6347: 
6348:         SUM ValPs TO loc_nTotal
6349:         THIS.cnt_4c_Financ.txt_4c_Total.Value = loc_nTotal
6350: 
6351:         THIS.AtualizarGrades()
6352:     ENDPROC
6353: 
6354:     *-- [F3]Pend. - legado abre SigOpPen (tela de selecao de pendencias do
6355:     *-- cliente), sem equivalente migrado. A limpeza local de linhas com
6356:     *-- codigo zerado (Delete For Codigos = 0) e feita mesmo assim.
6357:     PROCEDURE CmdBotPendentesClick()
6358:         IF !USED("TmpOperacao")
6359:             RETURN
6360:         ENDIF
6361: 
6362:         SELECT TmpOperacao
6363:         DELETE FOR Codigos = 0
6364:         GO TOP
6365: 
6366:         THIS.AtualizarGrades()
6367:     ENDPROC
6368: 
6369:     *==========================================================================
6370:     * HANDLERS - PAINEL DE CANCELAMENTO DE ITEM (CancelaItem)
6371:     *==========================================================================
6372: 
6373:     *-- CancelaDisp - legado (6 linhas): reabilita CntItem e fecha o painel
6374:     *-- SEM cancelar nada.
6375:     PROCEDURE CancelaItemCancelaDispClick()
6376:         *-- Legado (CancelaDisp.Click): "Select crTpmMvItn / Set Order To".
6377:         *-- SET ORDER TO exige a ORDEM antes do IN (SET ORDER TO 0 IN <alias>);
6378:         *-- "SET ORDER TO IN <alias>" nao compila.
6379:         IF USED("crTpmMvItn")
6380:             SELECT crTpmMvItn
6381:             SET ORDER TO
6382:         ENDIF
6383:         THIS.CancelaItemFechar()
6384:     ENDPROC
6385: 
6386:     *-- Ok (confirmar cancelamento) - o legado abre "Do Form SigOpSen With
6387:     *-- 'CANCITEM',..." (senha de supervisor) antes de cancelar; sem
6388:     *-- equivalente migrado, MsgConfirma() faz o papel do gate de
6389:     *-- confirmacao. Remove o item de crTpmMvItn/crTpmMvItnC (local - a
6390:     *-- exclusao definitiva em SigMvItn e responsabilidade da fase de
6391:     *-- persistencia dos itens, ainda nao lancada nesta tela) e recalcula o
6392:     *-- total.
6393:     PROCEDURE CancelaItemOkClick()
6394:         LOCAL loc_nItem
6395:         loc_nItem = THIS.cnt_4c_CancelaItem.txt_4c_Item.Value
6396: 
6397:         IF loc_nItem <= 0 OR !USED("crTpmMvItn")
6398:             THIS.CancelaItemFechar()
6399:             RETURN
6400:         ENDIF
6401: 
6402:         IF MsgConfirma("Confirma o cancelamento do item " + TRANSFORM(loc_nItem) + "?", "Cancelamento de Item")
6403:             SELECT crTpmMvItn
6404:             DELETE FOR citens == loc_nItem
6405: 
6406:             IF USED("crTpmMvItnC")
6407:                 SELECT crTpmMvItnC
6408:                 DELETE FOR cItens == loc_nItem
6409:             ENDIF
6410: 
6411:             SELECT crTpmMvItn
6412:             GO TOP
6413:             IF EOF()
6414:                 THIS.this_nCitem = 0
6415:             ELSE
6416:                 GO BOTTOM
6417:                 THIS.this_nCitem = NVL(crTpmMvItn.citens, 0)
6418:             ENDIF
6419: 
6420:             THIS.RecalcularTotalCarrinho()
6421:             THIS.AtualizarGrades()
6422:         ENDIF
6423: 
6424:         THIS.CancelaItemFechar()
6425:     ENDPROC
6426: 

*-- Linhas 6463 a 6486:
6463:                 USE IN cursor_4c_ConsultaPreco
6464:             ENDIF
6465: 
6466:             IF SQLEXEC(gnConnHandle, "SELECT dpros, pvens FROM SigCdPro WHERE cpros = " + ;
6467:                     EscaparSQL(PADR(loc_cValor, 14)) + " OR cbars = " + TRANSFORM(VAL(loc_cValor)), ;
6468:                     "cursor_4c_ConsultaPreco") > 0 ;
6469:                     AND USED("cursor_4c_ConsultaPreco") AND RECCOUNT("cursor_4c_ConsultaPreco") > 0
6470: 
6471:                 SELECT cursor_4c_ConsultaPreco
6472:                 GO TOP
6473:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6474:                     ALLTRIM(NVL(cursor_4c_ConsultaPreco.dpros, ""))
6475:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6476:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = NVL(cursor_4c_ConsultaPreco.pvens, 0)
6477:             ELSE
6478:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6479:                     "Produto n" + CHR(227) + "o encontrado."
6480:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6481:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = 0
6482:             ENDIF
6483: 
6484:             IF USED("cursor_4c_ConsultaPreco")
6485:                 USE IN cursor_4c_ConsultaPreco
6486:             ENDIF

*-- Linhas 6739 a 6800:
6739:     * do carrinho: apaga as linhas sem produto e, se nao sobrou nenhuma em
6740:     * branco, cria a proxima (citens = MAX + 1, respeitando UltimoCancel).
6741:     *
6742:     * O INSERT do legado gravava tambem emps/dopes/numes (tirados de TprMvCab,
6743:     * cursor do form pai): crTpmMvItn desta tela NAO tem essas tres colunas
6744:     * (Fase 4, CriarCursoresGrades) - a empresa/operacao/documento da venda
6745:     * vivem nas properties this_cEmps/this_cDopes/this_nNumes e sao aplicadas
6746:     * na persistencia, nao na linha do carrinho. Por isso aqui so citens.
6747:     *--------------------------------------------------------------------------
6748:     PROTECTED PROCEDURE LimparCntItem(par_lInsere)
6749:         LOCAL loc_lInsere, loc_nMaxItem, loc_lTemBranco, loc_oCnt
6750: 
6751:         loc_lInsere = IIF(VARTYPE(par_lInsere) = "L", par_lInsere, .F.)
6752: 
6753:         IF loc_lInsere AND USED("crTpmMvItn")
6754:             SELECT crTpmMvItn
6755:             SET ORDER TO
6756:             GO TOP
6757:             DELETE FOR EMPTY(NVL(cpros, ""))
6758: 
6759:             *-- Sobrou alguma linha em branco utilizavel? (legado:
6760:             *-- "Seek(Spac(14),'crTpmMvItn','Cpros')")
6761:             LOCATE FOR EMPTY(NVL(cpros, "")) AND !DELETED()
6762:             loc_lTemBranco = !EOF()
6763: 
6764:             IF !loc_lTemBranco
6765:                 loc_nMaxItem = 0
6766:                 SELECT MAX(citens) AS nMaxItem ;
6767:                     FROM crTpmMvItn ;
6768:                     WHERE !EMPTY(NVL(cpros, "")) ;
6769:                     INTO CURSOR cursor_4c_MaxItem
6770:                 IF USED("cursor_4c_MaxItem")
6771:                     GO TOP IN cursor_4c_MaxItem
6772:                     loc_nMaxItem = NVL(cursor_4c_MaxItem.nMaxItem, 0)
6773:                     USE IN cursor_4c_MaxItem
6774:                 ENDIF
6775: 
6776:                 IF THIS.this_nUltimocancel > loc_nMaxItem
6777:                     loc_nMaxItem = THIS.this_nUltimocancel
6778:                 ENDIF
6779: 
6780:                 THIS.this_nCitem = loc_nMaxItem + 1
6781: 
6782:                 INSERT INTO crTpmMvItn (citens) VALUES (THIS.this_nCitem)
6783:             ENDIF
6784: 
6785:             SELECT crTpmMvItn
6786:             SET ORDER TO
6787:         ENDIF
6788: 
6789:         loc_oCnt = THIS.cnt_4c_Item
6790:         loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Value    = ""
6791:         loc_oCnt.cnt_4c__Produto.txt_4c_Qtds.Value       = 0
6792:         loc_oCnt.cnt_4c__Subtotal.txt_4c_Valor.Value     = 0
6793:         loc_oCnt.cnt_4c__Desconto.txt_4c_Unival.Value    = 0
6794:         loc_oCnt.cnt_4c__Desconto.txt_4c_Valdesc.Value   = 0
6795:         loc_oCnt.cnt_4c__Desconto.txt_4c_Pvaldesc.Value  = 0
6796:         loc_oCnt.cnt_4c__Desconto.txt_4c_ValAcre.Value   = 0
6797:         loc_oCnt.cnt_4c__Desconto.txt_4c__pValAcre.Value = 0
6798:         loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Refresh()
6799:     ENDPROC
6800: 

*-- Linhas 6814 a 6850:
6814:             RETURN
6815:         ENDIF
6816: 
6817:         SELECT crTpmMvItn
6818:         IF EOF()
6819:             RETURN
6820:         ENDIF
6821: 
6822:         loc_nItem = NVL(citens, 0)
6823:         DELETE
6824: 
6825:         THIS.this_nCitem = THIS.this_nCitem - 1
6826: 
6827:         IF USED("crTpmMvItnC")
6828:             SELECT crTpmMvItnC
6829:             DELETE FOR cItens == loc_nItem
6830:         ENDIF
6831: 
6832:         THIS.RecalcularTotalCarrinho()
6833:         THIS.AtualizarGrades()
6834: 
6835:         SELECT crTpmMvItn
6836:         GO BOTTOM
6837:     ENDPROC
6838: 
6839:     *--------------------------------------------------------------------------
6840:     * CmdEnviaProdClick - Confirmar do bloco de item (CntItem.Cnt_Produto.
6841:     * CmdEnviaProd). Legado (Click): "ThisForm.CmdEnviaProd() / This.Visible =
6842:     * .f. / Get_Produto.SetFocus".
6843:     *
6844:     * O metodo CmdEnviaProd do legado imprime o item no cupom fiscal
6845:     * (ItemFiscal/CancelCupom/AtuaCupom) - impressora ECF, fora de alcance
6846:     * desta tela migrada (mesmo limite ja documentado em BtnConfirmarClick). O que
6847:     * NAO depende do ECF e transcrito fielmente: valor zero rejeita o item
6848:     * (mensagem do legado, remove a linha e remonta o bloco), valor valido
6849:     * marca ImpCupFis, reabilita o [F4]Canc e recicla a linha corrente.
6850:     *--------------------------------------------------------------------------

*-- Linhas 6862 a 6880:
6862:             THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = "Imprimindo Itens..."
6863: 
6864:             IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
6865:                 SELECT crTpmMvItn
6866:                 REPLACE ImpCupFis WITH .T.
6867:             ENDIF
6868: 
6869:             *-- Legado: "ThisForm.Barra_Botoes.Apaga.Enabled = .T."
6870:             THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga.Enabled = .T.
6871: 
6872:             THIS.MontarLinhasCupom()
6873:             THIS.AtualizarGrades()
6874:             THIS.LimparCntItem(.T.)
6875:         ENDIF
6876: 
6877:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
6878:         THIS.LimparCntItem(.F.)
6879: 
6880:         THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd.Visible = .F.

*-- Linhas 7037 a 7092:
7037:             RETURN .T.
7038:         ENDIF
7039: 
7040:         loc_nAreaAnt = SELECT()
7041: 
7042:         *-- Passo 1: o SCAN do legado. NENHUM comando que mova o ponteiro pode
7043:         *-- entrar aqui (COUNT/SUM/LOCATE varrem a tabela e quebram o SCAN) -
7044:         *-- a checagem de duplicidade fica no passo 2, fora do laco.
7045:         SELECT xPar
7046:         GO TOP
7047:         SCAN FOR UPPER(NVL(Infos, "")) == "C"
7048:             IF EMPTY(NVL(Bancos, ""))   OR EMPTY(NVL(Agencias, "")) OR ;
7049:                EMPTY(NVL(Contas, ""))   OR EMPTY(NVL(Numeros, ""))  OR ;
7050:                EMPTY(NVL(Cpfs, ""))
7051:                 loc_lOk = .F.
7052:                 EXIT
7053:             ENDIF
7054:         ENDSCAN
7055: 
7056:         *-- Passo 2: mesmo banco+agencia+conta+numero em mais de uma parcela.
7057:         IF loc_lOk
7058:             loc_nDuplicados = 0
7059:             SELECT ALLTRIM(NVL(Bancos, "")) + "|" + ALLTRIM(NVL(Agencias, "")) + "|" + ;
7060:                        ALLTRIM(NVL(Contas, "")) + "|" + ALLTRIM(NVL(Numeros, "")) AS cChaveChq, ;
7061:                    COUNT(*) AS nQt ;
7062:                 FROM xPar ;
7063:                 WHERE UPPER(NVL(Infos, "")) == "C" ;
7064:                 GROUP BY 1 ;
7065:                 HAVING COUNT(*) > 1 ;
7066:                 INTO CURSOR cursor_4c_ChqDup
7067:             IF USED("cursor_4c_ChqDup")
7068:                 loc_nDuplicados = RECCOUNT("cursor_4c_ChqDup")
7069:                 USE IN cursor_4c_ChqDup
7070:             ENDIF
7071:             loc_lOk = (loc_nDuplicados = 0)
7072:         ENDIF
7073: 
7074:         SELECT xPar
7075:         GO TOP
7076:         IF loc_nAreaAnt > 0
7077:             SELECT (loc_nAreaAnt)
7078:         ENDIF
7079: 
7080:         RETURN loc_lOk
7081:     ENDFUNC
7082: 
7083:     *--------------------------------------------------------------------------
7084:     * CmdTefChqClick - "Consulta Cheque" do painel de cheque pre-datado.
7085:     * ToolTipText do proprio legado: "Verifica e Confirma se a numeracao dos
7086:     * cheques esta OK."
7087:     *
7088:     * Transcreve os dois trechos do legado que nao dependem de hardware:
7089:     *   1) o SCAN de conferencia dos cheques lancados (ValidarChequesLancados);
7090:     *   2) o rodape: cheque invalido -> mensagem + limpa_cheptef + zera
7091:     *      nidcheps + foco na Praca; cheque valido -> se o total da forma de
7092:     *      pagamento fechou com o total liquido (e nenhum dos dois e zero),

*-- Linhas 7116 a 7134:
7116:             MsgAviso("Cheque Inv" + CHR(225) + "lido!!!", "Conferir Cheque")
7117:             THIS.LimparChequePreTef()
7118:             IF USED("xPar")
7119:                 SELECT xPar
7120:                 IF !EOF()
7121:                     REPLACE nIdCheps WITH 0
7122:                 ENDIF
7123:             ENDIF
7124:             THIS.FocarControle(loc_oChq.txt_4c_Pca)
7125:             RETURN
7126:         ENDIF
7127: 
7128:         MsgInfo("Numera" + CHR(231) + CHR(227) + "o dos cheques conferida." + CHR(13) + ;
7129:             "A consulta ao gerenciador TEF e a impress" + CHR(227) + "o do cheque prosseguem na tela " + ;
7130:             "de movimenta" + CHR(231) + CHR(227) + "o.", "Conferir Cheque")
7131: 
7132:         loc_nTotLiquido = THIS.cnt_4c__Fpagto.txt_4c_TotLiquido.Value
7133:         loc_nTotForma   = THIS.cnt_4c__Fpagto.txt_4c_TotForma.Value
7134: 

*-- Linhas 7158 a 7188:
7158:     * O SetAll('DynamicForeColor',...) do legado pinta a linha conforme
7159:     * InsChs/NumChqs/nIdCheps/Trocos - transcrito com os nomes das colunas
7160:     * deste cursor. O rebind e feito por MontaGrade(), que ja reaplica na ordem
7161:     * correta RecordSource -> ControlSource -> Width -> Header (Problema 48).
7162:     *--------------------------------------------------------------------------
7163:     PROCEDURE CmdInsChequeClick()
7164:         LOCAL loc_oChq, loc_oGrd
7165:         LOCAL loc_cBco, loc_cAgc, loc_cCta, loc_cDAgc, loc_cDCta, loc_cCpf, loc_cPca, loc_cNum
7166: 
7167:         IF !USED("xPar")
7168:             RETURN
7169:         ENDIF
7170: 
7171:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
7172: 
7173:         SELECT xPar
7174:         IF EOF()
7175:             RETURN
7176:         ENDIF
7177: 
7178:         loc_cBco  = NVL(Bancos, "")
7179:         loc_cAgc  = NVL(Agencias, "")
7180:         loc_cCta  = NVL(Contas, "")
7181:         loc_cDAgc = NVL(DigAgencs, "")
7182:         loc_cDCta = NVL(DigContas, "")
7183:         loc_cCpf  = NVL(Cpfs, "")
7184:         loc_cPca  = NVL(Pracas, "")
7185:         loc_cNum  = NVL(Numeros, "")
7186: 
7187:         SKIP
7188:         loc_oChq.txt_4c_Num.Value   = ""

*-- Linhas 7201 a 7219:
7201:             SKIP
7202:         ENDDO
7203: 
7204:         SELECT xPar
7205:         SET ORDER TO
7206:         GO TOP
7207: 
7208:         THIS.MontaGrade()
7209: 
7210:         loc_oGrd = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas
7211:         loc_oGrd.SetAll("DynamicForeColor", ;
7212:             "IIF(xPar.InsChs, IIF(!EMPTY(NVL(xPar.NumChqs, '')), RGB(255,0,0), RGB(0,0,255))," + ;
7213:             " IIF(NVL(xPar.nIdCheps, 0) = 0, IIF(NVL(xPar.Trocos, 0) = 1, RGB(0,0,160), RGB(0,0,0)), RGB(0,0,255)))", ;
7214:             "Column")
7215:         loc_oGrd.Refresh()
7216: 
7217:         *-- Legado: ".valor.text1.SetFocus" - o alvo do foco e o TextBox da
7218:         *-- coluna Valor (Column2), nao a Column.
7219:         THIS.FocarControle(loc_oGrd.Column2.Text1)

*-- Linhas 7227 a 7262:
7227:     *--------------------------------------------------------------------------
7228:     * FormParaBO - copia a linha CORRENTE de crTpmMvItn (o item que o caixa
7229:     * acabou de lancar) e o contexto da movimentacao para as propriedades do
7230:     * BO, que e quem monta o INSERT/UPDATE em SigMvItn.
7231:     *
7232:     * O legado NAO tinha este metodo porque nao precisava: o cursor
7233:     * crTpmMvItn pertencia a tela de movimentacao PAI, vivia na datasession
7234:     * COMPARTILHADA ("Set DataSession To pnDatSes" no Init do SCX) e era o PAI
7235:     * quem gravava tudo de uma vez no fim (AcioSalva -> TableUpdate). O form
7236:     * migrado usa DataSession = 2 (isolado, como o proprio SCX declara), entao
7237:     * o cursor daqui NAO e visivel para o pai - sem esta transferencia os itens
7238:     * lancados morreriam na memoria quando a tela fechasse, e o Confirmar
7239:     * anunciaria sucesso sem ter gravado nada.
7240:     *
7241:     * MAPEIA SOMENTE as colunas que esta tela realmente possui: as do cursor
7242:     * do carrinho (CriarCursoresGrades) mais as 3 do contexto recebido do pai
7243:     * (Emps/Dopes/Numes) e a PK cidchaves. As ~100 propriedades restantes do
7244:     * BO sao colunas FISCAIS/de rateio de SigMvItn (impostos, bases de
7245:     * calculo, CFOP, ST) que o Caixa NAO calcula nem exibe - ficam com o
7246:     * default declarado no BO, que e o que a Fase 2 projetou e o gate
7247:     * Validate-InsertNotNull aprovou. Preenche-las com 0/"" por conta propria
7248:     * seria inventar valor de imposto, que grava numero errado EM SILENCIO
7249:     * (CLAUDE.md #27 - stub que devolve valor de calculo e proibido).
7250:     *
7251:     * Retorna .F. sem gravar nada quando nao ha linha utilizavel, para que o
7252:     * chamador ABORTE em vez de seguir e gravar registro parcial (CLAUDE.md
7253:     * #187 - FormParaBO e FUNCTION e quem chama tem de respeitar o retorno).
7254:     *--------------------------------------------------------------------------
7255:     *--------------------------------------------------------------------------
7256:     * ESCOPO destes tres metodos: FormParaBO, BOParaForm e LimparCampos sao
7257:     * declarados PROTECTED porque o FormBase os declara PROTECTED (linhas
7258:     * 276/280/285 de classes\formbase.prg) e em VFP9 a protecao e HERDADA -
7259:     * redefinir na subclasse SEM a palavra PROTECTED nao os torna publicos.
7260:     * Medido em 2026-09-24 com harness externo: PEMSTATUS(oForm, "FormParaBO",
7261:     * 5) devolve .T. (so verifica existencia, nao escopo - mesma armadilha da
7262:     * regra #3 do CLAUDE.md), mas a chamada de fora estoura "Property

*-- Linhas 7279 a 7297:
7279:                     !EMPTY(NVL(crTpmMvItn.cpros, ""))
7280: 
7281:                 loc_oBO = THIS.this_oBusinessObject
7282:                 SELECT crTpmMvItn
7283: 
7284:                 *-- Contexto da movimentacao (no legado vinha de TprMvCab, o
7285:                 *-- cursor de cabecalho do form pai).
7286:                 loc_oBO.this_cEmps  = THIS.this_cEmps
7287:                 loc_oBO.this_cDopes = THIS.this_cDopes
7288:                 loc_oBO.this_nNumes = THIS.this_nNumes
7289: 
7290:                 *-- Chave composta que o legado montava em empdopnums
7291:                 *-- (Emps + Dopes + Str(Numes,6)) - char(29) no schema.
7292:                 loc_oBO.this_cEmpdopnums = LEFT(PADR(THIS.this_cEmps, 3) + ;
7293:                     PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6), 29)
7294: 
7295:                 *-- PK Fortyus (cidchaves): NAO e gerada aqui de proposito -
7296:                 *-- quem gera e o sigmvitnBO.Inserir, com LEFT(fUniqueIds(),20)
7297:                 *-- para caber no char(20). Duplicar a geracao aqui (sem o

*-- Linhas 7372 a 7390:
7372:         TRY
7373:             IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
7374:                 loc_oBO = THIS.this_oBusinessObject
7375:                 SELECT crTpmMvItn
7376: 
7377:                 REPLACE citens     WITH loc_oBO.this_nCitens, ;
7378:                         cpros      WITH loc_oBO.this_cCpros, ;
7379:                         dpros      WITH loc_oBO.this_cDpros, ;
7380:                         cunis      WITH loc_oBO.this_cCunis, ;
7381:                         codbarras  WITH loc_oBO.this_nCodbarras, ;
7382:                         codlprecs  WITH loc_oBO.this_nCodlprecs, ;
7383:                         empdopnums WITH loc_oBO.this_cEmpdopnums, ;
7384:                         etiesps    WITH loc_oBO.this_lEtiesps, ;
7385:                         fators     WITH loc_oBO.this_nFators, ;
7386:                         fatvals    WITH loc_oBO.this_nFatvals ;
7387:                     IN crTpmMvItn
7388: 
7389:                 REPLACE moedas   WITH loc_oBO.this_cMoedas, ;
7390:                         moefats  WITH loc_oBO.this_cMoefats, ;

*-- Linhas 7439 a 7494:
7439:     * (crTpmMvItn) que tem produto informado, um a um, via BO.
7440:     *
7441:     * Este e o passo que fechava no legado por outro caminho: la o pai gravava
7442:     * o cursor inteiro com TableUpdate na datasession COMPARTILHADA. Aqui, com
7443:     * DataSession = 2, cada linha vira NovoRegistro() + FormParaBO() +
7444:     * Salvar().
7445:     *
7446:     * Erro em QUALQUER item aborta o laco e devolve .F. - nao existe "gravou
7447:     * metade da venda". Quem chama (BtnConfirmarClick) so anuncia sucesso e
7448:     * fecha a tela se isto devolver .T.
7449:     *
7450:     * BusinessBase.Salvar() ja exibe a falha sozinho (ExibirFalha) e marca
7451:     * this_lErroExibido, entao aqui NAO se repete a mensagem (CLAUDE.md #20).
7452:     *--------------------------------------------------------------------------
7453:     PROTECTED FUNCTION GravarItensLancados()
7454:         LOCAL loc_oBO, loc_lSucesso, loc_nGravados, loc_nRec, loc_oErro
7455:         loc_lSucesso  = .T.
7456:         loc_nGravados = 0
7457: 
7458:         IF !USED("crTpmMvItn")
7459:             RETURN .F.
7460:         ENDIF
7461: 
7462:         TRY
7463:             loc_oBO = THIS.this_oBusinessObject
7464: 
7465:             SELECT crTpmMvItn
7466:             SET ORDER TO
7467:             GO TOP
7468: 
7469:             *-- Laco explicito em vez de SCAN/ENDSCAN de proposito: Salvar()
7470:             *-- faz SQLEXEC e RegistrarAuditoria no meio da iteracao e pode
7471:             *-- deixar OUTRA work area selecionada - o SKIP implicito do
7472:             *-- ENDSCAN cairia no alias errado. Aqui a area e o registro sao
7473:             *-- reposicionados explicitamente a cada volta.
7474:             DO WHILE !EOF("crTpmMvItn") AND loc_lSucesso
7475:                 SELECT crTpmMvItn
7476: 
7477:                 *-- Guarda redundante ao SET DELETED ON do Init, de proposito: item
7478:                 *-- CANCELADO (DELETE logico) nunca pode ser gravado.
7479:                 IF EMPTY(NVL(crTpmMvItn.cpros, "")) OR DELETED()
7480:                     SKIP IN crTpmMvItn
7481:                     LOOP
7482:                 ENDIF
7483: 
7484:                 loc_nRec = RECNO("crTpmMvItn")
7485: 
7486:                 loc_oBO.NovoRegistro()
7487: 
7488:                 *-- Chave nova a cada item: BusinessBase.LimparDados e um stub
7489:                 *-- que NAO limpa as propriedades da subclasse, entao sem este
7490:                 *-- reset o Inserir reusaria a chave do item anterior e o 2o
7491:                 *-- registro colidiria no indice unico (CLAUDE.md #22).
7492:                 loc_oBO.this_cCidchaves = ""
7493: 
7494:                 IF THIS.FormParaBO()

*-- Linhas 7502 a 7530:
7502:                 ENDIF
7503: 
7504:                 *-- Reposiciona antes de avancar: ver comentario do laco.
7505:                 SELECT crTpmMvItn
7506:                 IF BETWEEN(loc_nRec, 1, RECCOUNT("crTpmMvItn"))
7507:                     GO loc_nRec IN crTpmMvItn
7508:                 ENDIF
7509: 
7510:                 IF loc_lSucesso
7511:                     SKIP IN crTpmMvItn
7512:                 ENDIF
7513:             ENDDO
7514: 
7515:             SELECT crTpmMvItn
7516:             GO TOP
7517:         CATCH TO loc_oErro
7518:             MsgErro("Erro ao gravar os itens da venda:" + CHR(13) + ;
7519:                 loc_oErro.Message + CHR(13) + ;
7520:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7521:                 "Procedure: " + loc_oErro.Procedure, "Confirmar")
7522:             loc_lSucesso = .F.
7523:         ENDTRY
7524: 
7525:         *-- Carrinho com produto mas nada gravado nao e sucesso: devolve .F.
7526:         *-- para o Confirmar nao anunciar venda validada sem registro no banco
7527:         *-- (CLAUDE.md #189 - nunca reportar sucesso sem ter gravado).
7528:         IF loc_lSucesso AND loc_nGravados = 0
7529:             loc_lSucesso = .F.
7530:         ENDIF

