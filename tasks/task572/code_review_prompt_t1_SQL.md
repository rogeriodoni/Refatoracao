# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DECLARADO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, OPCRS, DOPES, CITENS, VNITEM, BAIXADO, VALDESCS, LNRET, DESCS, ESTADOS, CUPFIS, LNTENTA, LNLEN, UFS, CODIGO, MESVENCS, VENCS, DIGITENS, IMPS, IF, ORDEMS, FPAGS, NCODFINZS, CEMPS, CODIGOS, DESTINOS, LCCNPJ, ICLIS, LCUFO, LCUFD, FKCHAVE, CODCLASFISCAL, GRUPOS, ESTS, CLFISCALS, TPFATS, FORMAS, PNCODST, PDATAIMP, SERIFAB, DATAS, NEMPS, LLERROR1, CIMPFABS, EMPS, VERSTATUS, CNCAIXAS, CODOPERS, OPERADOR, EMPDOPNUMS, CDOPES, TIPOS, PRECOPS, _OLDCODG, EMPSUBNS, VALVARS, VARPS, NCARBXS, CHKSUBN, NOTAS, CHKPAGOS, DTAGENDS, PQTDES, PVALORS, NDEBITOS, NDOPES, _CHECAAGENDA, SUBNS, OPEATU, CHECPAGOS, UTILIZADOS, _NDDVAL, GRVENDS, GRRESPS, NCARDSCS, PARAUTOS, _OPERITENS, LPRECOS, IFORS, PVENS, ACUMULAS, INFOS, CCUPOMNVS, ALTETIQS, VALUE, CBARS, CODBARRAS, CITEM, EPRECOS, CHKDVAL, QTDS, LNKEY, CHKEDESC, INFORMADO, ESTOQS, OPERS, SITUAS, BARINDIVS, EAN13, BARREFS, DEACRS, PARCS, ACVCHQS, FPARCS, NPARCS, PARCDES, SISTEF, CNNSUS, CHEADERS, SENDTEF, LCTIPO, LCTIPOOK, TVENS, TROCOS, LNVALP, PEANTVALUE, LNVPAR, VALPRES, GRUCONMOES, NCHAVES, LNTPAR, CARAUTS, NSU, AUTORIZA, TIPOCADS, CNIDTEFS, VALOS, IMPCUPF, HABPENDS, CNIDENTS, CSTATUS, OP_ESCOLHA, C1, QT, CPFS, ENDES, NUMS, BAIRS, CEPS, CIDAS, ESTAS, CGC, SUBNOBRIGS, 0, _TTOP, OBSDESTS, DISPMOVS, BLQDESCS, CGC1, EMPRELEVS, DESCOS, TABDOBRIGS, QTDVALID, OBSORIGS, UFIBGES, LCP, LCVBP, LCVP, LCTP, CTIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RECALCULARTOTA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, OPCRS, DOPES, CITENS, VNITEM, BAIXADO, VALDESCS, LNRET, DESCS, ESTADOS, CUPFIS, LNTENTA, LNLEN, UFS, CODIGO, MESVENCS, VENCS, DIGITENS, IMPS, IF, ORDEMS, FPAGS, NCODFINZS, CEMPS, CODIGOS, DESTINOS, LCCNPJ, ICLIS, LCUFO, LCUFD, FKCHAVE, CODCLASFISCAL, GRUPOS, ESTS, CLFISCALS, TPFATS, FORMAS, PNCODST, PDATAIMP, SERIFAB, DATAS, NEMPS, LLERROR1, CIMPFABS, EMPS, VERSTATUS, CNCAIXAS, CODOPERS, OPERADOR, EMPDOPNUMS, CDOPES, TIPOS, PRECOPS, _OLDCODG, EMPSUBNS, VALVARS, VARPS, NCARBXS, CHKSUBN, NOTAS, CHKPAGOS, DTAGENDS, PQTDES, PVALORS, NDEBITOS, NDOPES, _CHECAAGENDA, SUBNS, OPEATU, CHECPAGOS, UTILIZADOS, _NDDVAL, GRVENDS, GRRESPS, NCARDSCS, PARAUTOS, _OPERITENS, LPRECOS, IFORS, PVENS, ACUMULAS, INFOS, CCUPOMNVS, ALTETIQS, VALUE, CBARS, CODBARRAS, CITEM, EPRECOS, CHKDVAL, QTDS, LNKEY, CHKEDESC, INFORMADO, ESTOQS, OPERS, SITUAS, BARINDIVS, EAN13, BARREFS, DEACRS, PARCS, ACVCHQS, FPARCS, NPARCS, PARCDES, SISTEF, CNNSUS, CHEADERS, SENDTEF, LCTIPO, LCTIPOOK, TVENS, TROCOS, LNVALP, PEANTVALUE, LNVPAR, VALPRES, GRUCONMOES, NCHAVES, LNTPAR, CARAUTS, NSU, AUTORIZA, TIPOCADS, CNIDTEFS, VALOS, IMPCUPF, HABPENDS, CNIDENTS, CSTATUS, OP_ESCOLHA, C1, QT, CPFS, ENDES, NUMS, BAIRS, CEPS, CIDAS, ESTAS, CGC, SUBNOBRIGS, 0, _TTOP, OBSDESTS, DISPMOVS, BLQDESCS, CGC1, EMPRELEVS, DESCOS, TABDOBRIGS, QTDVALID, OBSORIGS, UFIBGES, LCP, LCVBP, LCVP, LCTP, CTIPOS

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
  Column1.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "xpar.outros"
  ControlSource = "xPar.Obs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
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
  ControlSource = "xPar.Nsu"
  ControlSource = "xpar.autoriza"
  ControlSource = "xpar.adquirente"
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
	Select crTefImp
	lcSql = [Select Cpros,Cbars,DescFis,DescEcfs,Reffs,Compos, codimppro, dcodimppro, codnacpro, dcodnacpro, coddcr From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
	=ThisForm.Podatamgr.SqlExecute(lcSql,'xPro')
			lcSql = [Select Cpros,Cbars,DescFis,DescEcfs,Reffs,Compos From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
			=ThisForm.Podatamgr.SqlExecute(lcSql,'xPro')
	lcQuery = [Select * From SigOpCdi Where Dopes = ']+TprMvCab.Dopes+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigOpCdi') < 1)
	Select crTpmMvItnC
	Delete For cItens >= 1000
		Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
		If Not Seek(Str(crTpmMvItn.cItens,4))
			Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
			Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values ;
	Select [ ] as Agrupar, Sum(Qtds) as QtItem From crTpmMvItn Into Cursor TotItem Group by 1
	Select crTpmMvItnC
	Delete For cItens >= 1000
	Insert Into crTpmMvItnC (cItens, Linha, Texto ) Values (1001,0,xTexto)
	Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values (1001,1,xTexto0, 1)
	Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values (1002,1,xTexto1, 1)
	Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values (1003,2,xTexto2, 1)
	Select nChaves, fPags, Trocos, cnIdTefs, Infos, Max(tParcs) as tParcs, Max(pDescs) as pDescs, ;
	From xPar Into Cursor xParECF group by 1,2,3,4,5 order by nChaves,Fpags
	Select xParEcf	
		Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
			Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
	Select xpar
		Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
		Insert Into crTpmMvItnC (cItens, Linha, Texto, Cores ) Values ;
Select crTpmMvItnC
Select crTpmMvItn
Select xPar
SELECT crTpmMvItn
		Select xPar
		Select ParcTef
		Select ParcTef
			SELECT * from TprMvCab into cursor crSigmvCab readwrite
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2, c3, c4) ;
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2, c3, c4) ;
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2) ;
	INSERT into CFTags (c1, c24, c2) ;
	SELECT CFTags
	SELECT CFTags
	SELECT CFTags
	SELECT CFTags
			Select crTpmMvItn
		Select crTpmMvItn
	lcQuery = [Select a.Codigos ] + ;
			    [From SigCdMun a, SigCdUfs b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMunic]) < 1)
	Select LocalMunic
	lcQuery = [Select UFIBGEs ] + ;
			    [From SigCdUfs ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalUF]) < 1)
	Select LocalUF
	lcQuery = [Select Codigos ] + ;
			    [From SigCdPai ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPais]) < 1)
	Select LocalPais
Select TprMvCab
				lcQuery = [Select * From SigCdIbp Where ufs = ']+localEmp.estas+[' and codigo = ']+ALLTRIM(pcClf)+[' ]+;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalIbp]) < 1)
				SELECT LocalIbp
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
lcQuery = [Select RazSocs, Razas, Endes, Numeros, Compls, Bairs, Cidas, Estas, Ceps, ] + ;
		    [From SigCdEmp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
lcQuery = [Select layoutnf From SigCdUfs Where estados = '] + localemp.estas + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crUfs]) < 1)
lcQuery = [Select * From SigCdUfd Where Codigos = '] + localemp.estas + [' and destinos = ']+localemp.estas + [']
If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalUFD]) < 1)
Select LocalEmp
lcQuery = [Select RClis, iclis From SigCdCli Where IClis = '] + TprMvCab.vends + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCliV]) < 1)
SELECT localCliV
lcQuery = [Select Razaos, RClis, Cpfs, Endes, Nums, Compls, Bairs, Ceps, Cidas, Estas, Paises, Tel1s, ] + ;
		    [From SigCdCli ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCliD]) < 1)
Select LocalCliD
SELECT crTpmMvItn
		lcSql = [Select Cpros,Cbars,DescEcfs,DescFis,clfiscals,reffs,ean13,cgrus,Compos,codimppro,dcodimppro,codnacpro,dcodnacpro,coddcr From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
		=ThisForm.Podatamgr.SqlExecute(lcSql,'xPro')
		lcQuery = [Select unidades, aliqfcp, cest From SigCdClf Where Codigos = '] + xPro.clfiscals+ [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalClf]) < 1)
		lcQuery = [Select * From SigCdAlo Where fkchave = '] + LocalUfd.cidchaves + [' and codclasfiscal = ']+xPro.clfiscals+[']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalAlo]) < 1)
		lcSql = [Select * From SigCdCfo Where codigos = ']+lcCfo+[']
		IF ThisForm.Podatamgr.SqlExecute(lcSql,'crTmpCfo') < 1
		lcSql = [Select * From SigCdCfi Where grupos = ']+ALLTRIM(xpro.cgrus)+[' and ests = ']+localEmp.estas+[' and clfiscals = ']+lcNcm+[' ]
		IF ThisForm.Podatamgr.SqlExecute(lcSql,'crTmpCfi') < 1
		lcSql = [Select * From SigCdCfi Where grupos = ']+ALLTRIM(xpro.cgrus)+[' and ests = ']+localEmp.estas+[' and clfiscals = '          ' ]
			IF ThisForm.Podatamgr.SqlExecute(lcSql,'crTmpCfi') < 1
		Select crTmpCfo
	SELECT crTpmMvItn
SELECT SUM(valos) as valos, fpags from xpar group by fpags into cursor crPar
SELECT crPar
	SELECT crFp
lcQuery = [Select RazSocs, Razas, Endes, Numeros, Compls, Bairs, Cidas, Estas, Ceps, ] + ;
		  [From SigCdEmp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
Select LocalEmp
DELETE FILE &lcArq
SELECT CFTags
lcQuery = [Select RClis, iclis From SigCdCli Where IClis = '] + TprMvCab.vends + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCliV]) < 1)
SELECT localCliV
lcQuery = [Select Razaos, RClis, Cpfs, Endes, Nums, Compls, Bairs, Ceps, Cidas, Estas, Paises, Tel1s, ] + ;
		  [From SigCdCli ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCliD]) < 1)
Select LocalCliD
SELECT CFTags
	SELECT CFTags
SELECT crTpmMvItn
SELECT crTpmMvItn
	lcSql = [Select Cpros,Cbars,DescEcfs,DescFis,ClFiscals,origmercs,cgrus,reffs,Compos,codimppro,dcodimppro,codnacpro,dcodnacpro,coddcr From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
	IF ThisForm.Podatamgr.SqlExecute(lcSql,'xPro') < 1
	lcSql = [Select * From SigCdCfo Where codigos = ']+lcCfop+[']
	IF ThisForm.Podatamgr.SqlExecute(lcSql,'crTmpCfo') < 1
	lcSql = [Select * From SigCdCfi Where grupos = ']+ALLTRIM(xpro.cgrus)+[' and ests = ']+localEmp.estas+[' and clfiscals = ']+lcNcm+[' ]
	IF ThisForm.Podatamgr.SqlExecute(lcSql,'crTmpCfi') < 1
	lcSql = [Select * From SigCdCfi Where grupos = ']+ALLTRIM(xpro.cgrus)+[' and ests = ']+localEmp.estas+[' and clfiscals = '          ' ]
		IF ThisForm.Podatamgr.SqlExecute(lcSql,'crTmpCfi') < 1
	Select crTmpCfo
	SELECT CFTags
	SELECT crTpmMvItn
SELECT CFTags
SELECT CFTags
SELECT * from xPar into cursor crXPar	&& mena - salva cursor de parcelas para imprimir o financiamento se for o caso
SELECT SUM(valos) as valos, fpags, moefpgs from xpar group by fpags, moefpgs into cursor crPar
SELECT crPar
		SELECT crFp
	SELECT CFTags
	SELECT crPar
SELECT CFTags
		Select xPar
			Select crSigCdPam
Select xPar
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7, c8, c9, c10) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7, c8, c9, c10) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4, c5, c6, c7) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
SELECT CFTags
Select crTpmMvItn
	Select crTpmMvItn
		lcSql = [Select Cpros,Cbars,DescEcfs,DescFis,clfiscals,reffs,ean13,cgrus,Compos,codimppro,dcodimppro,codnacpro,dcodnacpro,coddcr From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
		=ThisForm.Podatamgr.SqlExecute(lcSql,'xPro')
	lcSql = [Select Top 1 Serifab,dtredzs From SigFiRx Where SeriFab = ']+pSeriFab+[' Order by DtRedZs Desc ]
	If ThisForm.PoDataMgr.SqlExecute(lcSql,'LocalRelx') < 1
	Select LocalRelx
		lcSql = [Select a.Nemps, Max(a.Datas) as Datas From SigMvCab a, SigCdOpe b ]+;
		If ThisForm.PoDataMgr.Sqlexecute(lcSql,'MovEest') < 1
		Select MovEest
			lcWhere = [Select * From SigFiMpf Where cimpfabs = ']+lcImpf+[' And Emps=']+ThisForm.parentform.pEmps+[']
			LnErro = ThisForm.parentForm.Podatamgr.SqlExecute(lcWhere,'CrSigFiMpf')
				Select CrSigFiMpf
	Insert Into crSigPrNfe (EmpDopNums, Emps, Dopes, Numes, Datas, Usuars, Arquivos, cIdChaves, ids, lotes, recibos, prots, stats, statts) ;
	SELECT * from TprMvCab into cursor crSigmvCab readwrite
	SELECT crSigmvNfi
	DELETE ALL
	SELECT crSigPrnfe
	DELETE ALL
	SELECT crSigmvcab
	DELETE ALL
IF pnGraDel = 3		&& mena 12/12/2016 - update e comit nas tres tabelas
		SELECT tmppends
			lcUpDate = [Update SigMvCab Set ChkSubn = 0 Where EmpDopNums = ']+lcEdn+[']
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvCab)])
	If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvNfi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
	If Not ThisForm.ParentForm.poDataMgr.Update([crSigPrNfe])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
	If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvCab])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvCab)])
Select crSigFiFis
Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcomItc
Select CrCfComItc
lcSql = [Select Logos From SigCdPac ]
If Thisform.ParentForm.Podatamgr.SqlExecute(lcSql,'TmpLogo') < 1
lcSql = [Select * From SigOpFpP ]
If Thisform.ParentForm.PodataMgr.Sqlexecute(lcSql,'ItemCFpagP') < 1
	.Codigos.ControlSource = 'TmpOperacao.Codigos'
	.Notas.ControlSource   = 'TmpOperacao.notas'
	.Valor.ControlSource   = 'TmpOperacao.Valos'
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
Select crTpmMvItn
	Select crTpmMvItn
		SELECT PADR(fpags,20)+PADL(ALLTRIM(STR(COUNT(fpags)))+' X '+ALLTRIM(TRANSFORM(MAX(valos),'@ 9999,999.99')),20) as linha from xParTef group by fpags into cursor tmpPar
		SELECT tmpPar	
			INSERT into xParC (texto) values (m.linha)
		SELECT xParC
		thisform.grdFp.colUMN1.ControlSource = 'xParC.Texto'
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
lcQuery = [Select * From SigCdOpe Where Ndopes = ]+Str(nDope)+[]
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
Local llCntrlFrom
			llCntrlFrom = This.Value > 0 And Thisform.lControle And crTpmMvItn.Qtds > 0
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
Select TprMvCab
Select crSigMvNfi
Select TprMvCab
Select crSigMvNfi
	If ( Val(This.Value) > 0 And !Seek(Val(This.Value),'CcSigOpFp','nfpags')) Or Val(This.Value) = 0
		If !Seek( This.Value, 'ccSigOpFp', 'FPags' )
		Select xPar
		Select TmpOperacao
	Select xPar
&&		If (Seek('CARTAO','xPar','fPags') And ( crSigOpFp.Infos = [C])) OR (Seek('CHEQUE REDE','xPar','fPags') And ( crSigOpFp.Infos = [T]) )
			lcSql = [Select * From SigCdFs Where codigos = ']+TprMvCab.MotDscs+[']
			If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalMdsc') < 1)
		Select crSigOpFp
Select TprMvCab
	lcSql = [Select * From SigOpFpP Where Fpags = ']+CrSigOpFp.Fpags+[' And nParcs =]+Str(ThisForm.Cnt_Fpagto.cnt_forma.Get_npar.Value,2)
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
	SELECT xpar
			Select xpar
	Select xpar
Select xpar
			Select xPar
						Delete For nChaves = lnChv
						Delete
					Select xPar
					Select xPar
SELECT xpar
SELECT xpar
	ThisForm.parentform.podatamgr.sqlexecute([Select * from SigcdCad Where tipocads = 'ADQUIRENTE'],"crCad")
	SELECT CrCad
	if not seek(this.value)
SELECT xpar
Select xpar
Select xPar
Select xPar
Select TmpOperacao
	Select crTpmMvItn
Select xPar
Select xPar
		Select SigTef
		Count for ! Deleted() To lnQtdTef
			SELECT SigTef
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
	Select crTpmMvItn
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
	select crTpmMvItn	
		lcQuery = [Select Razaos, RClis, Cpfs, Endes, Nums, Compls, Bairs, Ceps, Cidas, Estas From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crCli]) < 1)
	lcSql = [Select * From SigFiNtb Where Imps=']+CrSigFiFis.Imps+[' And Ordems = ]+Str(CrSigCdOpe.TrNfis,2)
	If ThisForm.Podatamgr.SqlExecute(lcsql,'CrSigFiNtb') > 0
	Select crSigFiFis
Select [] as Agrupar, Sum(1) as TT from crTpmMvItn Where Not Empty(nChvTbds) And Not Empty(Cpros) ;
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

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvits.prg) - TRECHOS RELEVANTES PARA PASS SQL (5873 linhas total):

*-- Linhas 153 a 187:
153:             THIS.BackColor = RGB(255, 255, 255)
154: 
155:             *-- DataSession = 2 da ao form uma datasession PRIVADA com os SETs
156:             *-- no DEFAULT do VFP, e o default de DELETED e OFF (mesma familia
157:             *-- da regra #9.4 do CLAUDE.md, que trata de SET DATE/CENTURY). O
158:             *-- legado rodava na datasession compartilhada, onde o config.prg
159:             *-- ja deixou SET DELETED ON - sem isto, o item cancelado (DELETE
160:             *-- em crTpmMvItn) continuaria aparecendo na grade do cupom e
161:             *-- entrando nos totais.
162:             SET DELETED ON
163: 
164:             *-- Os cursores das grades nascem ANTES dos controles: assim o
165:             *-- MontaGrade, mais abaixo, encontra os alias prontos. Ligar
166:             *-- Column.ControlSource a cursor inexistente derruba o Init
167:             *-- (CLAUDE.md #41).
168:             THIS.CriarCursoresGrades()
169: 
170:             THIS.ConfigurarContainerPrincipal()
171: 
172:             *-- Bind das grades (RecordSource/ControlSource/Width/cabecalhos).
173:             *-- Separado da criacao dos controles porque RecordSource reseta
174:             *-- Width, Header1.Caption, CurrentControl e Sparse - tudo isso
175:             *-- precisa vir DEPOIS dele (Problema 48 / CLAUDE.md #41).
176:             THIS.MontaGrade()
177: 
178:             *-- FASE 7: liga os Click/Timer. Vai DEPOIS de todo AddObject -
179:             *-- BINDEVENT contra objeto que ainda nao existe estoura no Init.
180:             THIS.RegistrarEventosPrincipais()
181: 
182:             *-- FASE 7: estado inicial da tela. O legado faz isso no proprio
183:             *-- Init ("Cnt_identifica.Visible = .f. / Cnt_pendencia.Visible =
184:             *-- .f. / Cnt_Fpagto.Visible = .f. / grdFP.Visible = .f."), deixando
185:             *-- so a tela de ITENS a mostra; sem esta chamada os quatro
186:             *-- containers de operacao, criados Visible = .T. nas Fases 3-6,
187:             *-- abrem empilhados na mesma area.

*-- Linhas 828 a 849:
828:     * parcelamento automatico (crSigCdOpe.ParAutos = 1, Barra_Botoes.ok).
829:     * Filha DIRETA do form (nao de nenhum container) - mapeamento.json: GrdFP.
830:     *
831:     * RecordSource/ControlSource NAO sao setados aqui de proposito: no legado
832:     * o alias "xParC" e um SELECT dinamico (PADR(fpags,20)+... agrupando xPar
833:     * por forma de pagamento) montado dentro do proprio Confirmar - o cursor
834:     * so existe a partir da fase de eventos. Ligar ControlSource contra alias
835:     * inexistente derruba o Init (CLAUDE.md #41).
836:     *
837:     * Original: Top=20 Left=306 Width=445 Height=146 ColumnCount=1 Enabled=.F.
838:     * GridLines=0 GridLineWidth=1 HeaderHeight=20 Panel=1 RecordMark=.F.
839:     * ScrollBars=0 Visible=.F. GridLineColor=192,192,192. Column1:
840:     * FontName="Courier New" FontSize=8 Enabled=.F. Width=432 Visible=.F.
841:     * Header1: FontName="Verdana" FontSize=8 Alignment=2
842:     * Caption="Formas de Pagamento" ForeColor=36,84,155. Text1:
843:     * FontName="Courier New" FontSize=8 Alignment=3 BorderStyle=0 Enabled=.F.
844:     * Format="!" Margin=0 Visible=.F.
845:     *==========================================================================
846:         THIS.AddObject("grd_4c_FormasPag", "Grid")
847:         WITH THIS.grd_4c_FormasPag
848:             .Top           = 20
849:             .Left          = 306

*-- Linhas 856 a 874:
856:             .HeaderHeight  = 20
857:             .Panel         = 1
858:             .RecordMark    = .F.
859:             .DeleteMark    = .F.
860:             .ScrollBars    = 0
861:             .GridLineColor = RGB(192, 192, 192)
862:             .Visible       = .F.
863: 
864:             .Column1.FontName  = "Courier New"
865:             .Column1.FontSize  = 8
866:             .Column1.Enabled   = .F.
867:             .Column1.Width     = 432
868:             .Column1.Visible   = .F.
869:             .Column1.Header1.FontBold   = .F.
870:             .Column1.Header1.FontName   = "Verdana"
871:             .Column1.Header1.FontSize   = 8
872:             .Column1.Header1.Alignment  = 2
873:             .Column1.Header1.Caption    = "Formas de Pagamento"
874:             .Column1.Header1.ForeColor  = RGB(36, 84, 155)

*-- Linhas 919 a 943:
919:     * ajuste feito no form irmao Formsigmvitn.prg/task571 para a MESMA
920:     * GradeMultiSubN).
921:     *
922:     * RecordSource/ControlSource ficam para MontaGrade() - RecordSource
923:     * reseta Width/Header1.Caption/CurrentControl/Sparse (CLAUDE.md #41).
924:     *
925:     * Original: Label1 Top=0 Left=0 Width=347 Height=19 FontBold=.T.
926:     * FontSize=10 Alignment=2 Caption="Busca Pre Venda" ForeColor=255,255,255
927:     * BackColor=90,90,90. GradeMultiSubN Top=21 Left=36 Width=274 Height=91
928:     * ColumnCount=3 FontName="Tahoma" DeleteMark=.F. HeaderHeight=16
929:     * RecordMark=.F. ScrollBars=2 ForeColor=0,0,0 BackColor=255,255,255.
930:     * Column1(Codigos) Width=80 InputMask="9999999999" Header="Pendencias".
931:     * Column2(Notas) Width=80 Header="Notas". Column3(Valor) Width=90
932:     * Header="Valor". Botao Pend. Top=112 Left=36 W=110 H=40
933:     * Picture=date2.ico Caption="[F3]Pend." Proximo Top=112 Left=200 W=110
934:     * H=40 Picture=b_arrow2.bmp Caption="" ForeColor=36,84,155.
935:     *==========================================================================
936:         LOCAL loc_cIcones
937:         loc_cIcones = gc_4c_CaminhoIcones
938: 
939:         THIS.cnt_4c__Pendencia.AddObject("lbl_4c_Label1", "Label")
940:         WITH THIS.cnt_4c__Pendencia.lbl_4c_Label1
941:             .Top       = 0
942:             .Left      = 0
943:             .Width     = 347

*-- Linhas 962 a 980:
962:             .FontName     = "Tahoma"
963:             .HeaderHeight = 16
964:             .ScrollBars   = 2
965:             .DeleteMark   = .F.
966:             .RecordMark   = .F.
967:             .ForeColor    = RGB(0, 0, 0)
968:             .BackColor    = RGB(255, 255, 255)
969:             .Visible      = .T.
970: 
971:             .Column1.FontName  = "Tahoma"
972:             .Column1.Width     = 80
973:             .Column1.Movable   = .F.
974:             .Column1.Resizable = .F.
975:             .Column1.InputMask = "9999999999"
976:             .Column1.ForeColor = RGB(0, 0, 0)
977:             .Column1.BackColor = RGB(255, 255, 255)
978:             .Column1.Header1.FontBold  = .T.
979:             .Column1.Header1.FontName  = "Tahoma"
980:             .Column1.Header1.FontSize  = 8

*-- Linhas 2377 a 2398:
2377:     * (cnt_4c_Destino/cnt_4c_Responsavel/cnt_4c_Vendedor/cnt_4c_Origem).
2378:     *
2379:     * par_cCtrlGrupo/par_cCtrlConta NAO sao aplicados a nenhuma propriedade
2380:     * aqui - documentam apenas o ControlSource legado (TprMvCab.grupods/
2381:     * grvends/grupoos/GrResps e contads/vends/contaos/Resps) para a Fase
2382:     * 7/8, quando FormParaBO/BOParaForm ligarem estes TextBox as
2383:     * propriedades do BO (este form nao usa .ControlSource nativo em
2384:     * nenhum outro campo, e nao seria diferente aqui).
2385:     *==========================================================================
2386:         LOCAL loc_cCnt, loc_oCnt, loc_cIcones
2387:         loc_cIcones = gc_4c_CaminhoIcones
2388:         loc_cCnt = "cnt_4c_" + par_cNome
2389: 
2390:         THIS.cnt_4c__Identifica.AddObject(loc_cCnt, "Container")
2391:         loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica." + loc_cCnt)
2392:         WITH loc_oCnt
2393:             .Top           = par_nTop
2394:             .Left          = 0
2395:             .Width         = 404
2396:             .Height        = 94
2397:             .BackStyle     = 0
2398:             .BorderWidth   = 0

*-- Linhas 3005 a 3023:
3005:     * cabecalho visivel (HeaderHeight=0 - cada linha e uma string formatada,
3006:     * padrao de cupom fiscal), fonte Cordia New roxa (ForeColor=58,44,126).
3007:     *
3008:     * RecordSource/ControlSource de grd_4c_Cupom ficam para MontaGrade() -
3009:     * RecordSource reseta Width/Header1.Caption (CLAUDE.md #41).
3010:     *
3011:     * Original: GrdCupom Top=0 Left=3 Width=445 Height=360 ColumnCount=1
3012:     * Enabled=.F. GridLines=0 HeaderHeight=0 ReadOnly=.T. RecordMark=.F.
3013:     * ScrollBars=0 ForeColor=58,44,126. Column1 FontName="Cordia New"
3014:     * Width=345 Movable=.F. ReadOnly=.T. Cnt_subt/cnt_tots Top=365
3015:     * Width=221 Height=49 BackStyle=0 BorderWidth=1 SpecialEffect=2
3016:     * BackColor=126,211,226; Say7 Caption="Subtotal"/"Total Geral"
3017:     * FontBold=.T. FontSize=8 ForeColor=90,90,90; Get_Total/Get_total
3018:     * FontBold=.T. FontSize=18 Alignment=2 BackStyle=0 BorderStyle=0
3019:     * InputMask="9,999,999.99" Height=35 Width=218 ForeColor=0,0,0
3020:     * BackColor=255,255,255.
3021:     *==========================================================================
3022:         THIS.cnt_4c_Grade.AddObject("grd_4c_Cupom", "Grid")
3023:         WITH THIS.cnt_4c_Grade.grd_4c_Cupom

*-- Linhas 3031 a 3049:
3031:             .HeaderHeight = 0
3032:             .ReadOnly     = .T.
3033:             .RecordMark   = .F.
3034:             .DeleteMark   = .F.
3035:             .ScrollBars   = 0
3036:             .ForeColor    = RGB(58, 44, 126)
3037:             .Visible      = .T.
3038: 
3039:             .Column1.FontBold   = .F.
3040:             .Column1.FontName   = "Cordia New"
3041:             .Column1.Enabled    = .F.
3042:             .Column1.Width      = 345
3043:             .Column1.Movable    = .F.
3044:             .Column1.ReadOnly   = .T.
3045:             .Column1.ForeColor  = RGB(58, 44, 126)
3046:             .Column1.Header1.FontSize = 8
3047:             .Column1.Header1.Caption  = "Header1"
3048:             .Column1.Text1.FontBold    = .F.
3049:             .Column1.Text1.FontName    = "Cordia New"

*-- Linhas 3237 a 3278:
3237:     * fazia "Set DataSession To pnDatSes" e os enxergava prontos. Como este
3238:     * form usa DataSession = 2 (isolado), eles nascem aqui.
3239:     *
3240:     * Roda ANTES de qualquer RecordSource/ControlSource (MontaGrade): ligar
3241:     * coluna a alias inexistente estoura "Alias is not found" dentro do TRY
3242:     * do InicializarForm e o form nao chega a abrir (CLAUDE.md #41).
3243:     *
3244:     * SET NULL ON antes do CREATE CURSOR porque, quando a fase de eventos
3245:     * popular estes cursores via APPEND FROM DBF()/SQLEXEC, coluna nullable
3246:     * do SQL Server recusa o append num cursor declarado NOT NULL. Estado
3247:     * anterior restaurado no fim, para nao vazar SET para o resto da
3248:     * datasession.
3249:     *
3250:     * Estruturas transcritas do uso real no dump legado (comportamento.json)
3251:     * e IDENTICAS as ja usadas no form irmao Formsigmvitn.prg (task571), que
3252:     * tem o MESMO Cnt_Pendencia.GradeMultiSubN. Nomes de campo PRESERVADOS:
3253:     * sao chave de ControlSource e aparecem literalmente nas expressoes
3254:     * Locate/Replace/Seek das fases de evento.
3255:     *==========================================================================
3256:         LOCAL loc_cNullAnt
3257:         loc_cNullAnt = SET("NULL")
3258:         SET NULL ON
3259: 
3260:         *-- TmpOperacao: sub-niveis/pendencias vinculados a esta movimentacao
3261:         *-- (grd_4c_SubNiveis - Cnt_Pendencia.GradeMultiSubN).
3262:         IF !USED("TmpOperacao")
3263:             CREATE CURSOR TmpOperacao ( ;
3264:                 Emps      C(3)     NULL, ;
3265:                 Dopes     C(20)    NULL, ;
3266:                 Numes     N(6, 0)  NULL, ;
3267:                 Codigos   N(10, 0) NULL, ;
3268:                 Notas     C(6)     NULL, ;
3269:                 Valos     N(11, 2) NULL, ;
3270:                 VlValVars N(11, 2) NULL, ;
3271:                 EmpSubns  C(29)    NULL, ;
3272:                 ChkSubn   L        NULL, ;
3273:                 Validado  L        NULL, ;
3274:                 Saida     L        NULL)
3275:             INDEX ON STR(Codigos, 10) TAG Codigos
3276:             SET ORDER TO
3277:         ENDIF
3278: 

*-- Linhas 3286 a 3304:
3286:         *-- totais, contar itens lancados); sem ele todo handler viraria um
3287:         *-- no-op silencioso preso no IF !USED(...).
3288:         IF !USED("crTpmMvItn")
3289:             CREATE CURSOR crTpmMvItn ( ;
3290:                 citens     N(10, 0) NULL, ;
3291:                 cpros      C(14)    NULL, ;
3292:                 dpros      C(65)    NULL, ;
3293:                 cunis      C(3)     NULL, ;
3294:                 codbarras  N(14, 0) NULL, ;
3295:                 codlprecs  N(6, 0)  NULL, ;
3296:                 empdopnums C(29)    NULL, ;
3297:                 etiesps    L        NULL, ;
3298:                 fators     N(8, 3)  NULL, ;
3299:                 fatvals    N(15, 6) NULL, ;
3300:                 moedas     C(3)     NULL, ;
3301:                 moefats    C(3)     NULL, ;
3302:                 moevals    N(15, 6) NULL, ;
3303:                 notas      C(6)     NULL, ;
3304:                 opers      C(1)     NULL, ;

*-- Linhas 3319 a 3342:
3319: 
3320:         *-- xPar: as parcelas/formas de pagamento lancadas. Espelha as colunas
3321:         *-- de SigMvPar que o legado referencia MAIS cinco que so existem no
3322:         *-- cursor local: nChaves (agrupador do lancamento, usado no "Delete
3323:         *-- For nChaves = lnChv" do CancPagto), Infos e Acumulas (copias do
3324:         *-- cadastro da forma, SigOpFp), pDescs (percentual de desconto
3325:         *-- aplicado) e Bcds (bonus/credito acumulado na parcela).
3326:         IF !USED("xPar")
3327:             CREATE CURSOR xPar ( ;
3328:                 Emps       C(3)     NULL, ;
3329:                 Dopes      C(20)    NULL, ;
3330:                 Numes      N(6, 0)  NULL, ;
3331:                 Datas      D        NULL, ;
3332:                 Parcs      N(2, 0)  NULL, ;
3333:                 tParcs     N(2, 0)  NULL, ;
3334:                 Vencs      D        NULL, ;
3335:                 Valos      N(11, 2) NULL, ;
3336:                 VPags      N(11, 2) NULL, ;
3337:                 ValDescs   N(11, 2) NULL, ;
3338:                 pDescs     N(9, 4)  NULL, ;
3339:                 FPags      C(12)    NULL, ;
3340:                 MoeFPgs    C(3)     NULL, ;
3341:                 CotFPgs    N(11, 4) NULL, ;
3342:                 Trocos     N(1, 0)  NULL, ;

*-- Linhas 3371 a 3433:
3371:         *-- descricao(65) + separadores). Cores e o indice do DynamicForeColor
3372:         *-- legado (0 item .. 4 troco) - mantido como coluna de controle.
3373:         IF !USED("crTpmMvItnC")
3374:             CREATE CURSOR crTpmMvItnC ( ;
3375:                 cItens N(10, 0) NULL, ;
3376:                 Linha  N(2, 0)  NULL, ;
3377:                 Texto  C(90)    NULL, ;
3378:                 Cores  N(1, 0)  NULL)
3379:             INDEX ON STR(cItens, 4) TAG cItens
3380:             SET ORDER TO
3381:         ENDIF
3382: 
3383:         IF loc_cNullAnt = "OFF"
3384:             SET NULL OFF
3385:         ENDIF
3386:     ENDPROC
3387: 
3388:     *==========================================================================
3389:     PROTECTED PROCEDURE MontaGrade
3390:     *==========================================================================
3391:     * Liga grd_4c_SubNiveis e grd_4c_Cupom aos seus cursores (criados em
3392:     * CriarCursoresGrades) e REAPLICA tudo o que o VFP9 reseta quando
3393:     * RecordSource muda: Column.Width e Header1.Caption (Problema 48 /
3394:     * CLAUDE.md #41). Por isso a ordem dentro de cada WITH e sempre a mesma
3395:     * e NAO pode ser trocada: RecordSource -> ControlSource -> Width ->
3396:     * Header1.Caption.
3397:     *
3398:     * grd_4c_FormasPag NAO entra aqui: o cursor "xParC" e um SELECT dinamico
3399:     * montado dentro do Confirmar (Barra_Botoes.ok, fase de eventos) - nao
3400:     * existe ainda nesta fase (ver comentario de ConfigurarGrdFormasPagamento).
3401:     *==========================================================================
3402:         LOCAL loc_oGrd
3403: 
3404:         loc_oGrd = THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
3405:         loc_oGrd.RecordSource = "TmpOperacao"
3406:         loc_oGrd.Column1.ControlSource = "TmpOperacao.Codigos"
3407:         loc_oGrd.Column2.ControlSource = "TmpOperacao.Notas"
3408:         loc_oGrd.Column3.ControlSource = "TmpOperacao.Valos"
3409:         loc_oGrd.Column1.Width = 80
3410:         loc_oGrd.Column2.Width = 80
3411:         loc_oGrd.Column3.Width = 90
3412:         loc_oGrd.Column1.Header1.Caption = "Pend" + CHR(234) + "ncias"
3413:         loc_oGrd.Column2.Header1.Caption = "Notas"
3414:         loc_oGrd.Column3.Header1.Caption = "Valor"
3415: 
3416:         loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Cupom
3417:         loc_oGrd.RecordSource = "crTpmMvItnC"
3418:         loc_oGrd.Column1.ControlSource = "crTpmMvItnC.Texto"
3419:         loc_oGrd.Column1.Width = 345
3420:         loc_oGrd.Column1.Header1.Caption = "Header1"
3421:     ENDPROC
3422: 
3423:     *==========================================================================
3424:     * LOOKUPS (FASE 6/8) - handlers KeyPress (PUBLIC, exigido por BINDEVENT -
3425:     * CLAUDE.md #3) + os metodos AbrirLookupXxx() que efetivamente abrem o
3426:     * FormBuscaAuxiliar. Todos seguem o contrato canonico do projeto
3427:     * (CLAUDE.md #37): Show() SO quando !this_lAchouRegistro, atribuicao SO
3428:     * sob this_lSelecionou, e Release() sempre no final.
3429:     *==========================================================================
3430: 
3431:     *==========================================================================
3432:     PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3433:     *==========================================================================

*-- Linhas 3467 a 3485:
3467:             ENDIF
3468: 
3469:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
3470:                 SELECT cursor_4c_BuscaFpg
3471:                 loc_oCnt.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
3472:             ENDIF
3473: 
3474:             IF USED("cursor_4c_BuscaFpg")
3475:                 USE IN cursor_4c_BuscaFpg
3476:             ENDIF
3477:             loc_oBusca.Release()
3478:         ENDIF
3479:     ENDPROC
3480: 
3481:     *==========================================================================
3482:     PROCEDURE AdquireKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3483:     *==========================================================================
3484:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3485:             THIS.AbrirLookupAdquirente()

*-- Linhas 3506 a 3534:
3506:             "cursor_4c_BuscaAdq", ;
3507:             "descads", ;
3508:             ALLTRIM(loc_oCnt.txt_4c__adquire.Value), ;
3509:             "Adquirente", .F., .T., "tipocads = " + EscaparSQL("ADQUIRENTE"))
3510: 
3511:         IF VARTYPE(loc_oBusca) = "O"
3512:             loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
3513: 
3514:             IF !loc_oBusca.this_lAchouRegistro
3515:                 loc_oBusca.Show()
3516:             ENDIF
3517: 
3518:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
3519:                 SELECT cursor_4c_BuscaAdq
3520:                 loc_oCnt.txt_4c__adquire.Value = ALLTRIM(cursor_4c_BuscaAdq.descads)
3521:             ENDIF
3522: 
3523:             IF USED("cursor_4c_BuscaAdq")
3524:                 USE IN cursor_4c_BuscaAdq
3525:             ENDIF
3526:             loc_oBusca.Release()
3527:         ENDIF
3528:     ENDPROC
3529: 
3530:     *==========================================================================
3531:     PROCEDURE TabdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3532:     *==========================================================================
3533:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3534:             THIS.AbrirLookupTabDesconto()

*-- Linhas 3564 a 3582:
3564:             ENDIF
3565: 
3566:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
3567:                 SELECT cursor_4c_BuscaTabd
3568:                 loc_oCnt.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
3569:             ENDIF
3570: 
3571:             IF USED("cursor_4c_BuscaTabd")
3572:                 USE IN cursor_4c_BuscaTabd
3573:             ENDIF
3574:             loc_oBusca.Release()
3575:         ENDIF
3576:     ENDPROC
3577: 
3578:     *==========================================================================
3579:     PROCEDURE ListaPrecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3580:     *==========================================================================
3581:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3582:             THIS.AbrirLookupListaPreco()

*-- Linhas 3621 a 3639:
3621:             ENDIF
3622: 
3623:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
3624:                 SELECT cursor_4c_BuscaLpc
3625:                 loc_oCnt.txt_4c_ListaPreco.Value = ALLTRIM(cursor_4c_BuscaLpc.lprecos)
3626:             ENDIF
3627: 
3628:             IF USED("cursor_4c_BuscaLpc")
3629:                 USE IN cursor_4c_BuscaLpc
3630:             ENDIF
3631:             loc_oBusca.Release()
3632:         ENDIF
3633:     ENDPROC
3634: 
3635:     *==========================================================================
3636:     * Identificacao de conta (Destino/Responsavel/Vendedor/Origem) - os 4
3637:     * blocos criados por MontarBlocoIdentificacao() tem a MESMA estrutura de
3638:     * campos, entao os handlers abaixo so mudam no NOME do bloco (par_cBloco)
3639:     * passado a AbrirLookupGrupo/AbrirLookupConta/AbrirLookupContaPorCpf.

*-- Linhas 3744 a 3762:
3744:             ENDIF
3745: 
3746:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
3747:                 SELECT cursor_4c_BuscaGrupo
3748:                 loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
3749:             ENDIF
3750: 
3751:             IF USED("cursor_4c_BuscaGrupo")
3752:                 USE IN cursor_4c_BuscaGrupo
3753:             ENDIF
3754:             loc_oBusca.Release()
3755:         ENDIF
3756:     ENDPROC
3757: 
3758:     *==========================================================================
3759:     PROTECTED PROCEDURE AbrirLookupConta(par_cBloco)
3760:     *==========================================================================
3761:     * Get_conta (Destino/Responsavel/Vendedor/Origem) - conta (SigCdCli,
3762:     * chave Iclis). Ao selecionar, preenche tambem o Nome (txt_4c_Dconta),

*-- Linhas 3786 a 3804:
3786:             ENDIF
3787: 
3788:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
3789:                 SELECT cursor_4c_BuscaConta
3790:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
3791:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
3792:             ENDIF
3793: 
3794:             IF USED("cursor_4c_BuscaConta")
3795:                 USE IN cursor_4c_BuscaConta
3796:             ENDIF
3797:             loc_oBusca.Release()
3798:         ENDIF
3799:     ENDPROC
3800: 
3801:     *==========================================================================
3802:     PROTECTED PROCEDURE AbrirLookupContaPorCpf(par_cBloco)
3803:     *==========================================================================
3804:     * Get_cpf (Destino/Responsavel/Vendedor/Origem) - localiza a conta pelo

*-- Linhas 3831 a 3849:
3831:             ENDIF
3832: 
3833:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
3834:                 SELECT cursor_4c_BuscaCpf
3835:                 loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
3836:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCpf.iclis)
3837:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCpf.rclis)
3838:             ENDIF
3839: 
3840:             IF USED("cursor_4c_BuscaCpf")
3841:                 USE IN cursor_4c_BuscaCpf
3842:             ENDIF
3843:             loc_oBusca.Release()
3844:         ENDIF
3845:     ENDPROC
3846: 
3847:     *==========================================================================
3848:     * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
3849:     *==========================================================================

*-- Linhas 4002 a 4025:
4002:         loc_nQt = 0
4003: 
4004:         IF USED("xPar")
4005:             loc_nAreaAnt = SELECT()
4006:             SELECT xPar
4007:             COUNT FOR NVL(Valos, 0) > 0 AND !EMPTY(NVL(FPags, "")) AND !NVL(InsChs, .F.) ;
4008:                 AND !DELETED() TO loc_nQt
4009:             IF loc_nAreaAnt > 0
4010:                 SELECT (loc_nAreaAnt)
4011:             ENDIF
4012:         ENDIF
4013: 
4014:         RETURN (loc_nQt > 0)
4015:     ENDFUNC
4016: 
4017:     *--------------------------------------------------------------------------
4018:     * HaFormaPagamentoEmAberto - .T. quando o campo Forma de Pagamento esta
4019:     * preenchido, isto e, ha lancamento de pagamento EM ANDAMENTO. Guarda
4020:     * literal do legado ("If Not Empty(Cnt_Fpagto.cnt_forma.get_fpg.Value) /
4021:     * Return 0") no inicio de Itens/Financia/pendencia/credito/identifica.
4022:     *--------------------------------------------------------------------------
4023:     PROTECTED FUNCTION HaFormaPagamentoEmAberto()
4024:         RETURN !EMPTY(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg.Value)
4025:     ENDFUNC

*-- Linhas 4036 a 4140:
4036:         loc_lAchou = .F.
4037: 
4038:         IF USED("crTpmMvItn")
4039:             loc_nAreaAnt = SELECT()
4040:             SELECT crTpmMvItn
4041:             LOCATE FOR !NVL(ImpCupFis, .F.) AND !EMPTY(NVL(cpros, ""))
4042:             loc_lAchou = !EOF()
4043:             IF loc_nAreaAnt > 0
4044:                 SELECT (loc_nAreaAnt)
4045:             ENDIF
4046:         ENDIF
4047: 
4048:         RETURN loc_lAchou
4049:     ENDFUNC
4050: 
4051:     *--------------------------------------------------------------------------
4052:     * ContarItensLancados - quantas linhas do carrinho tem produto. O carrinho
4053:     * mantem sempre uma linha EM BRANCO aberta para o proximo item
4054:     * (LimparCamposItem), que nao conta como venda. Legado: "Count to
4055:     * lnContaItems For Not IsEmpty( crTpmMvItn.Cpros )".
4056:     *--------------------------------------------------------------------------
4057:     PROTECTED FUNCTION ContarItensLancados()
4058:         LOCAL loc_nQt, loc_nAreaAnt
4059:         loc_nQt = 0
4060: 
4061:         IF USED("crTpmMvItn")
4062:             loc_nAreaAnt = SELECT()
4063:             SELECT crTpmMvItn
4064:             COUNT FOR !EMPTY(NVL(cpros, "")) AND !DELETED() TO loc_nQt
4065:             IF loc_nAreaAnt > 0
4066:                 SELECT (loc_nAreaAnt)
4067:             ENDIF
4068:         ENDIF
4069: 
4070:         RETURN loc_nQt
4071:     ENDFUNC
4072: 
4073:     *--------------------------------------------------------------------------
4074:     * HaSubNivelInformado - .T. quando ha pendencia/sub-nivel selecionado.
4075:     * Legado (repetido em ok/Cancela/Pagto/Itens/pendencia.Click): "Select
4076:     * TmpOperacao / llSubNivel = .f. / Scan for !IsEmpty( Codigos ) /
4077:     * llSubNivel = .t. / EndScan".
4078:     *--------------------------------------------------------------------------
4079:     PROTECTED FUNCTION HaSubNivelInformado()
4080:         LOCAL loc_nQt, loc_nAreaAnt
4081:         loc_nQt = 0
4082: 
4083:         IF USED("TmpOperacao")
4084:             loc_nAreaAnt = SELECT()
4085:             SELECT TmpOperacao
4086:             COUNT FOR NVL(Codigos, 0) > 0 AND !DELETED() TO loc_nQt
4087:             IF loc_nAreaAnt > 0
4088:                 SELECT (loc_nAreaAnt)
4089:             ENDIF
4090:         ENDIF
4091: 
4092:         RETURN (loc_nQt > 0)
4093:     ENDFUNC
4094: 
4095:     *--------------------------------------------------------------------------
4096:     * LimparCamposItem - equivalente ao mLimpaCntItem(plInsere) do legado:
4097:     * com par_lInsere, remove do carrinho as linhas em branco, renumera o
4098:     * proximo item e abre UMA linha nova em branco; depois zera os oito campos
4099:     * do bloco de digitacao do item.
4100:     *--------------------------------------------------------------------------
4101:     PROTECTED PROCEDURE LimparCamposItem(par_lInsere)
4102:         LOCAL loc_nMax, loc_lInsere
4103:         loc_lInsere = IIF(VARTYPE(par_lInsere) = "L", par_lInsere, .F.)
4104: 
4105:         IF loc_lInsere AND USED("crTpmMvItn")
4106:             SELECT crTpmMvItn
4107:             SET ORDER TO
4108:             GO TOP
4109:             DELETE FOR EMPTY(NVL(cpros, ""))
4110: 
4111:             *-- Legado: "ThisForm.Citem = Iif(UltimoCancel > Max(Citens),
4112:             *-- UltimoCancel, Max(Citens)) + 1". O Max e apurado por SCAN e
4113:             *-- nao por SELECT ... INTO CURSOR para nao trocar a area de
4114:             *-- trabalho corrente no meio do metodo.
4115:             loc_nMax = 0
4116:             SCAN FOR !EMPTY(NVL(cpros, "")) AND !DELETED()
4117:                 IF NVL(citens, 0) > loc_nMax
4118:                     loc_nMax = NVL(citens, 0)
4119:                 ENDIF
4120:             ENDSCAN
4121: 
4122:             THIS.this_nCItem = MAX(THIS.this_nUltimoCancel, loc_nMax) + 1
4123: 
4124:             INSERT INTO crTpmMvItn (citens) VALUES (THIS.this_nCItem)
4125:             SELECT crTpmMvItn
4126:             SET ORDER TO
4127:         ENDIF
4128: 
4129:         WITH THIS.cnt_4c_Item
4130:             .cnt_4c__Prod.txt_4c_Produto.Value    = ""
4131:             .cnt_4c__Qtd.txt_4c_Qtds.Value        = 0
4132:             .cnt_4c__val.txt_4c_Valor.Value       = 0
4133:             .cnt_4c__ValU.txt_4c_Unival.Value     = 0
4134:             .cnt_4c__vdesc.txt_4c_Valdesc.Value   = 0
4135:             .cnt_4c__pDesc.txt_4c_Pvaldesc.Value  = 0
4136:             .cnt_4c__vacre.txt_4c_ValAcre.Value   = 0
4137:             .cnt_4c__pacre.txt_4c__pValAcre.Value = 0
4138:             .cnt_4c__Prod.txt_4c_Produto.Refresh()
4139:             .Visible     = .T.
4140:         ENDWITH

*-- Linhas 4166 a 4208:
4166:         loc_nFormas   = 0
4167: 
4168:         IF USED("crTpmMvItn")
4169:             SELECT crTpmMvItn
4170:             *-- Ordem canonica do SUM: FOR vem ANTES do TO.
4171:             SUM NVL(qtds, 0) * NVL(units, 0) FOR !DELETED() TO loc_nSubTotal
4172:             SUM NVL(totas, 0) FOR !DELETED() TO loc_nTotal
4173:             GO TOP
4174:         ENDIF
4175: 
4176:         *-- O legado usa Totas (valor do item ja com desconto/acrescimo) no
4177:         *-- Total Geral e qtds*units no Subtotal. Carrinho recem-aberto tem
4178:         *-- Totas zerado - nesse caso o Total Geral acompanha o Subtotal, para
4179:         *-- nao exibir 0,00 com itens na tela.
4180:         IF loc_nTotal = 0
4181:             loc_nTotal = loc_nSubTotal
4182:         ENDIF
4183: 
4184:         THIS.cnt_4c_Grade.cnt_4c__subt.txt_4c_Total.Value = loc_nSubTotal
4185:         THIS.cnt_4c_Grade.cnt_4c__tots.txt_4c_Total.Value = loc_nTotal
4186:         THIS.this_nTotIte = loc_nTotal
4187: 
4188:         IF USED("xPar")
4189:             SELECT xPar
4190:             *-- Forma com Trocos = 1 ABATE (legado: "ctotal = Round(ctotal -
4191:             *-- (valos * cotfpgs), 2)"), as demais SOMAM.
4192:             SUM ROUND(NVL(Valos, 0) * NVL(CotFPgs, 1) * IIF(NVL(Trocos, 0) = 1, -1, 1), 2) ;
4193:                 FOR !DELETED() TO loc_nFormas
4194:             GO BOTTOM
4195:         ENDIF
4196: 
4197:         WITH THIS.cnt_4c__Fpagto
4198:             loc_nDesc  = .cnt_4c_Desconto.txt_4c_TotVariacao.Value
4199:             loc_nAcre  = .cnt_4c_Acrescimo.txt_4c_TotVariacao.Value
4200:             loc_nDescP = .cnt_4c__descp.txt_4c_Tvariacao.Value
4201: 
4202:             loc_nLiquido = loc_nTotal + loc_nAcre - loc_nDesc - loc_nDescP
4203: 
4204:             .cnt_4c__tot.txt_4c_Valinic.Value      = loc_nTotal
4205:             .cnt_4c__saldo.txt_4c_TotLiquido.Value = loc_nLiquido
4206:             .cnt_4c__pag.txt_4c_TotForma.Value     = loc_nFormas
4207:             .cnt_4c__apag.txt_4c_Saldo.Value       = loc_nLiquido - loc_nFormas
4208:             .Refresh()

*-- Linhas 4345 a 4384:
4345: 
4346:     *--------------------------------------------------------------------------
4347:     * ContaBloqueiaDesconto - uma conta. O legado faz em duas etapas
4348:     * (CursorQuery SigCdCli -> CursorQuery SigCdCst); aqui o JOIN resolve as
4349:     * duas de uma vez, contra as MESMAS tabelas e colunas.
4350:     *--------------------------------------------------------------------------
4351:     PROTECTED FUNCTION ContaBloqueiaDesconto(par_cConta)
4352:         LOCAL loc_lBloqueia, loc_cSQL, loc_nRes, loc_cDesc, loc_oErro
4353: 
4354:         loc_lBloqueia = .F.
4355: 
4356:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
4357:             RETURN .F.
4358:         ENDIF
4359: 
4360:         TRY
4361:             loc_cSQL = "SELECT b.Codigos, b.Descrs, b.Descr2s, b.BlqDescs " + ;
4362:                 "FROM SigCdCli a " + ;
4363:                 "INNER JOIN SigCdCst b ON b.Codigos = a.Situas " + ;
4364:                 "WHERE a.Iclis = " + EscaparSQL(par_cConta)
4365: 
4366:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SitConta")
4367: 
4368:             IF loc_nRes > 0 AND USED("cursor_4c_SitConta")
4369:                 SELECT cursor_4c_SitConta
4370:                 IF RECCOUNT("cursor_4c_SitConta") > 0
4371:                     GO TOP
4372:                     IF NVL(cursor_4c_SitConta.BlqDescs, 0) = 1
4373:                         loc_cDesc = ALLTRIM(NVL(cursor_4c_SitConta.Descr2s, ""))
4374:                         IF EMPTY(loc_cDesc)
4375:                             loc_cDesc = ALLTRIM(NVL(cursor_4c_SitConta.Descrs, ""))
4376:                         ENDIF
4377: 
4378:                         MsgAviso(ALLTRIM(NVL(cursor_4c_SitConta.Codigos, "")) + " - " + loc_cDesc + CHR(13) + ;
4379:                             "Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o da Conta", ;
4380:                             "Situa" + CHR(231) + CHR(227) + CHR(227))
4381:                         loc_lBloqueia = .T.
4382:                     ENDIF
4383:                 ENDIF
4384:             ENDIF

*-- Linhas 4433 a 4493:
4433:     * CARTAO (crSigOpFp.cCupomNvs = 'TEF'), consulta o gateway TEF no arquivo
4434:     * local SigTef, chama TefImpr/VerifGP (driver do pinpad), grava
4435:     * SigFiTef.cStatus = 'CNC' e so entao apaga a parcela; nas demais formas
4436:     * apaga direto ("Delete For nChaves = lnChv" quando CrSigOpCdd.VarPs = 1,
4437:     * senao "Delete"). No fim recalcula o total das formas, limpa os campos da
4438:     * forma e devolve o foco.
4439:     *
4440:     * O trecho de TEF depende do pinpad fisico e de TefImpr/VerifGP/
4441:     * DeleteSigTef (driver, nao portadas) - fica na tela de movimentacao, que
4442:     * e quem conversa com o gateway. Aqui a parcela LOCAL e removida junto com
4443:     * as demais da mesma chave de lancamento (nChaves), que e o caminho do
4444:     * legado para forma NAO-cartao, e a pendencia no gateway e AVISADA ao
4445:     * operador em vez de ser simulada em silencio (CLAUDE.md #27).
4446:     *--------------------------------------------------------------------------
4447:     PROCEDURE CmdCancPagtoClick()
4448:         LOCAL loc_nChave, loc_cIdTef
4449: 
4450:         IF !THIS.cnt_4c__Fpagto.Visible
4451:             RETURN
4452:         ENDIF
4453: 
4454:         IF !USED("xPar")
4455:             RETURN
4456:         ENDIF
4457: 
4458:         SELECT xPar
4459:         GO BOTTOM
4460:         IF EOF() OR EMPTY(NVL(xPar.FPags, ""))
4461:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
4462:             RETURN
4463:         ENDIF
4464: 
4465:         loc_nChave = NVL(xPar.nChaves, 0)
4466:         loc_cIdTef = ALLTRIM(NVL(xPar.cnIdTefs, ""))
4467: 
4468:         IF !EMPTY(loc_cIdTef)
4469:             MsgAviso("Esta forma de pagamento tem transa" + CHR(231) + CHR(227) + "o de cart" + CHR(227) + ;
4470:                 "o (TEF) associada." + CHR(13) + ;
4471:                 "O cancelamento no gateway TEF depende do pinpad do caixa e deve ser " + ;
4472:                 "feito na tela de movimenta" + CHR(231) + CHR(227) + "o.", "Cancelar Pagamento")
4473:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
4474:             RETURN
4475:         ENDIF
4476: 
4477:         SELECT xPar
4478:         DELETE FOR NVL(nChaves, 0) = loc_nChave
4479:         GO BOTTOM
4480: 
4481:         WITH THIS.cnt_4c__Fpagto.cnt_4c__forma
4482:             .txt_4c_Fpg.Value             = ""
4483:             .txt_4c_Npar.Value            = 0
4484:             .txt_4c_Vpar.Value            = 0
4485:             .txt_4c_Fweditdata_venc.Value = {}
4486:             .Visible     = .T.
4487:         ENDWITH
4488: 
4489:         THIS.RecalcularTotais()
4490:         THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
4491:     ENDPROC
4492: 
4493:     *--------------------------------------------------------------------------

*-- Linhas 4518 a 4536:
4518: 
4519:         IF INLIST(loc_nCupFis, 1, 5, 6)
4520:             *-- Caminho do caixa fiscal: painel de cancelamento de item.
4521:             SELECT crTpmMvItn
4522:             SET ORDER TO
4523:             loc_nItem = THIS.this_nCItem - 1
4524: 
4525:             LOCATE FOR NVL(citens, 0) = loc_nItem
4526:             loc_lAchou = !EOF()
4527:             IF !loc_lAchou
4528:                 loc_nItem = 0
4529:             ENDIF
4530: 
4531:             WITH THIS.cnt_4c_CancelaItem
4532:                 .txt_4c_Item.Value    = loc_nItem
4533:                 .txt_4c_Produto.Value = IIF(loc_lAchou, ALLTRIM(NVL(crTpmMvItn.cpros, "")), "")
4534:                 .txt_4c__dpro.Value   = IIF(loc_lAchou, ALLTRIM(NVL(crTpmMvItn.dpros, "")), "")
4535:                 .txt_4c_Cbarra.Value  = IIF(loc_lAchou, ;
4536:                     ALLTRIM(TRANSFORM(NVL(crTpmMvItn.codbarras, 0))), "")

*-- Linhas 4543 a 4567:
4543:             THIS.FocarControle(THIS.cnt_4c_CancelaItem.txt_4c_Item)
4544:         ELSE
4545:             *-- Caminho sem cupom fiscal: apaga a linha e renumera.
4546:             SELECT crTpmMvItn
4547:             IF !EMPTY(NVL(cpros, ""))
4548:                 DELETE
4549:             ENDIF
4550: 
4551:             loc_nCont = 0
4552:             SCAN FOR !DELETED()
4553:                 loc_nCont = loc_nCont + 1
4554:                 REPLACE citens WITH loc_nCont IN crTpmMvItn
4555:             ENDSCAN
4556:             THIS.this_nCItem = loc_nCont
4557: 
4558:             THIS.LimparCamposItem(.T.)
4559:             THIS.RecalcularTotais()
4560: 
4561:             IF THIS.cnt_4c_Item.Visible
4562:                 THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto)
4563:             ELSE
4564:                 THIS.FocarControle(THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok)
4565:             ENDIF
4566:         ENDIF
4567:     ENDPROC

*-- Linhas 4576 a 4616:
4576:             RETURN
4577:         ENDIF
4578: 
4579:         SELECT crTpmMvItn
4580:         IF EMPTY(NVL(crTpmMvItn.cpros, ""))
4581:             RETURN
4582:         ENDIF
4583: 
4584:         THIS.this_lAlteraValor = .T.
4585:         WITH THIS.cnt_4c_Item
4586:             .cnt_4c__vdesc.txt_4c_Valdesc.Value  = 0
4587:             .cnt_4c__pDesc.txt_4c_Pvaldesc.Value = 0
4588:             .Visible     = .T.
4589:         ENDWITH
4590: 
4591:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__val.txt_4c_Valor)
4592:     ENDPROC
4593: 
4594:     *--------------------------------------------------------------------------
4595:     * [F6] Identif. (cmd_4c_Identifica) - abre a tela de identificacao das
4596:     * contas (Origem/Destino/Vendedor/Responsavel).
4597:     *
4598:     * Legado (Barra_Botoes.identifica.Click, 167 linhas): guarda de forma de
4599:     * pagamento em aberto; esconde as outras telas; zera o gate dos botoes;
4600:     * libera a edicao de Origem/Destino quando ainda nao ha sub-nivel nem
4601:     * devolucao lancados; CARREGA nome e CPF das quatro contas via SELECT em
4602:     * SigCdCli; e escolhe qual campo recebe o foco, na ordem Documento ->
4603:     * Pedido -> Tab.Desconto -> Lista de Precos -> Origem -> Destino ->
4604:     * Vendedor -> Responsavel -> Proximo.
4605:     *
4606:     * A cascata de foco do legado e decidida por 12 flags de crSigCdOpe
4607:     * (FixGOrigs/FixCOrigs/FixGDests/.../Numeras/PedClis/TabDescs/LPrecos),
4608:     * cursor do form pai. Sob DataSession = 2 essas flags nao existem aqui: a
4609:     * ordem e mantida, mas testando a VISIBILIDADE e o preenchimento de cada
4610:     * campo, que e o efeito pratico daquelas flags nesta tela.
4611:     *--------------------------------------------------------------------------
4612:     PROCEDURE CmdIdentificaClick()
4613:         IF THIS.HaFormaPagamentoEmAberto()
4614:             RETURN
4615:         ENDIF
4616: 

*-- Linhas 4631 a 4649:
4631: 
4632:     *--------------------------------------------------------------------------
4633:     * CarregarDadosContasIdentifica - as quatro consultas do identifica.Click
4634:     * legado ("Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis =
4635:     * '<conta>'" para Origem, Destino, Vendedor e Responsavel, preenchendo
4636:     * Get_dconta e Get_cpf de cada bloco). Bloco com conta vazia tem nome e
4637:     * CPF limpos, como no ELSE do legado.
4638:     *--------------------------------------------------------------------------
4639:     PROTECTED PROCEDURE CarregarDadosContasIdentifica()
4640:         THIS.CarregarContaBloco("Origem")
4641:         THIS.CarregarContaBloco("Destino")
4642:         THIS.CarregarContaBloco("Vendedor")
4643:         THIS.CarregarContaBloco("Responsavel")
4644:     ENDPROC
4645: 
4646:     *--------------------------------------------------------------------------
4647:     * CarregarContaBloco - um dos quatro blocos de identificacao. O nome do
4648:     * container e montado em tempo de execucao ("cnt_4c_" + par_cBloco) e
4649:     * resolvido por EVALUATE UMA VEZ, para uma referencia de objeto: dai em

*-- Linhas 4672 a 4696:
4672:         ENDIF
4673: 
4674:         TRY
4675:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli " + ;
4676:                 "WHERE Iclis = " + EscaparSQL(loc_cConta)
4677: 
4678:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaIdent")
4679: 
4680:             IF loc_nRes > 0 AND USED("cursor_4c_ContaIdent")
4681:                 SELECT cursor_4c_ContaIdent
4682:                 IF RECCOUNT("cursor_4c_ContaIdent") > 0
4683:                     GO TOP
4684:                     loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_ContaIdent.Rclis, ""))
4685:                     loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(NVL(cursor_4c_ContaIdent.Cpfs, ""))
4686:                 ENDIF
4687:             ENDIF
4688: 
4689:             IF USED("cursor_4c_ContaIdent")
4690:                 USE IN cursor_4c_ContaIdent
4691:             ENDIF
4692: 
4693:             loc_oCnt.Refresh()
4694:         CATCH TO loc_oErro
4695:             MsgErro(loc_oErro.Message + CHR(13) + ;
4696:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 4850 a 4868:
4850:         loc_lSubNivel = THIS.HaSubNivelInformado()
4851:         loc_lTemItem  = .F.
4852:         IF USED("crTpmMvItn")
4853:             SELECT crTpmMvItn
4854:             LOCATE FOR NVL(ImpCupFis, .F.) AND !EMPTY(NVL(cpros, ""))
4855:             loc_lTemItem = !EOF()
4856:         ENDIF
4857: 
4858:         loc_lLibera = !(loc_lSubNivel AND loc_lTemItem)
4859: 
4860:         THIS.AlternarTelaOperacao("PENDENCIA")
4861: 
4862:         WITH THIS.cnt_4c__Pendencia
4863:             .grd_4c_SubNiveis.Visible     = .T.
4864:             .grd_4c_SubNiveis.Enabled     = loc_lLibera
4865:             .cmd_4c_Bot_Pendentes.Visible = .T.
4866:             .cmd_4c_Bot_Pendentes.Enabled = loc_lLibera
4867:         ENDWITH
4868: 

*-- Linhas 4975 a 4993:
4975:     * quando ha sub-nivel; exige sub-nivel quando SubnObrigs esta em 1/3;
4976:     * acumula o valor cancelado no form pai; e, conforme o modelo fiscal,
4977:     * chama montaNFc()/montaSatD() (emissao de NFC-e/SAT) ou
4978:     * ParentForm.AcioSalva(), que gravava o documento inteiro com TABLEUPDATE
4979:     * na datasession COMPARTILHADA.
4980:     *
4981:     * Aqui as guardas ficam iguais e a GRAVACAO acontece NESTE form, pelo BO:
4982:     * com DataSession = 2 o carrinho (crTpmMvItn) esta isolado do form pai, e
4983:     * sem gravar aqui os itens morreriam na memoria ao fechar a tela - o
4984:     * Confirmar anunciaria venda fechada sem nada no banco (CLAUDE.md #20 /
4985:     * "sucesso anunciado sem gravar"). A emissao FISCAL (NFC-e/SAT/cupom)
4986:     * continua na tela de movimentacao, que e quem tem a impressora.
4987:     *--------------------------------------------------------------------------
4988:     PROCEDURE BtnConfirmarClick()
4989:         LOCAL loc_nItens, loc_lTemPagamento
4990: 
4991:         loc_nItens = THIS.ContarItensLancados()
4992: 
4993:         *-- Sem item nenhum o Confirmar so encerra a tela: e o que o legado faz

*-- Linhas 5006 a 5024:
5006: 
5007:         loc_lTemPagamento = .F.
5008:         IF USED("xPar")
5009:             SELECT xPar
5010:             LOCATE FOR !EMPTY(NVL(FPags, ""))
5011:             loc_lTemPagamento = !EOF()
5012:         ENDIF
5013: 
5014:         IF !loc_lTemPagamento
5015:             MsgAviso("Informe a forma de pagamento antes de confirmar a venda.", "Confirmar")
5016:             THIS.CmdPagtoClick()
5017:             RETURN
5018:         ENDIF
5019: 
5020:         *-- Falhando a gravacao, NAO fecha a tela e NAO anuncia sucesso: o
5021:         *-- caixa fica com o carrinho na tela para corrigir e repetir.
5022:         *-- BusinessBase.Salvar() ja exibiu o motivo (CLAUDE.md #20).
5023:         IF !THIS.GravarDocumento()
5024:             RETURN

*-- Linhas 5041 a 5059:
5041:     * TprMvCab, cursor do form pai) - aqui usam go_4c_Sistema/DATETIME(),
5042:     * unica fonte disponivel nesta tela isolada.
5043:     *
5044:     * Documento (txt_4c_Codigo): o ControlSource do legado (TprMvCab.mascnum)
5045:     * e so o que o campo EXIBE - o Valid legado grava o digitado em
5046:     * TprMvCab.Numes (Replace TprMvCab.Numes With fRetornaInt(This.Value)),
5047:     * entao o valor numerico vai para this_nNumes, nao this_cMascnum.
5048:     *
5049:     * Desconto/Acrescimo/Vars: MESMA formula ja usada em RecalcularTotais()
5050:     * (nao recalculada de outro jeito) - valvars negativo em desconto,
5051:     * positivo em acrescimo (CLAUDE.md #17 - formula transcrita, nao
5052:     * reescrita).
5053:     *--------------------------------------------------------------------------
5054:     PROTECTED PROCEDURE FormParaBO()
5055:         LOCAL loc_oBO, loc_oId, loc_oFp, loc_nTotal, loc_nLiquido, loc_nFormas
5056:         LOCAL loc_nDesc, loc_nAcre, loc_nDescP, loc_nVarLiq
5057: 
5058:         loc_oBO = THIS.this_oBusinessObject
5059:         loc_oId = THIS.cnt_4c__Identifica

*-- Linhas 5237 a 5255:
5237:     * 2 forma de pagamento, 3 recebido, 4 troco.
5238:     *
5239:     * Tres trechos do legado nao tem equivalente nesta tela isolada, e por
5240:     * isso a linha do item usa o proprio carrinho como fonte: o SELECT em
5241:     * SigCdPro (DescEcfs / CBars), o IdentPro de CrSigOpCdd e o SubCdProrF de
5242:     * CrSigOpCdi decidem COMO o produto e identificado na IMPRESSORA FISCAL e
5243:     * dependem de cursores que a tela de movimentacao (form pai) monta na
5244:     * datasession COMPARTILHADA - com DataSession = 2 eles nao existem aqui. A
5245:     * descricao (dpros) e o codigo de barras (codbarras) ja vem gravados no
5246:     * carrinho no momento do lancamento do item, entao a linha exibida e a
5247:     * mesma.
5248:     *
5249:     * SET SAFETY salvo e restaurado em volta do ZAP: DataSession = 2 nasce com
5250:     * os SETs no DEFAULT do VFP, onde SAFETY esta ON e o ZAP abriria um
5251:     * dialogo modal (mesma familia da regra #9.4 do CLAUDE.md).
5252:     *
5253:     * PUBLIC de proposito: TesteAutomatico.prg chama
5254:     * THIS.oForm.CarregarLista() de fora da classe e PROTECTED falharia em
5255:     * runtime mesmo passando no PEMSTATUS (CLAUDE.md #3).

*-- Linhas 5265 a 5447:
5265:         loc_lOk = .F.
5266: 
5267:         IF USED("crTpmMvItnC") AND USED("crTpmMvItn")
5268:             loc_nAreaAnt = SELECT()
5269: 
5270:             *-- Grade reconstruida do zero (o legado limpa so o rodape, com
5271:             *-- "Delete For cItens >= 1000", porque acrescenta um item por vez).
5272:             loc_cSafetyAnt = SET("SAFETY")
5273:             SET SAFETY OFF
5274:             SELECT crTpmMvItnC
5275:             SET ORDER TO
5276:             ZAP
5277:             IF loc_cSafetyAnt = "ON"
5278:                 SET SAFETY ON
5279:             ENDIF
5280: 
5281:             *-- 1) Linhas dos ITENS do carrinho.
5282:             SELECT crTpmMvItn
5283:             SET ORDER TO
5284:             GO TOP
5285:             SCAN FOR !EMPTY(NVL(cpros, "")) AND !DELETED()
5286:                 *-- Cada campo lido para variavel local ANTES do primeiro
5287:                 *-- INSERT: "INSERT INTO <cursor>" TROCA a area de trabalho
5288:                 *-- corrente para o cursor de destino, e a partir dali um
5289:                 *-- nome de campo sem alias resolveria contra crTpmMvItnC -
5290:                 *-- "Variable 'QTDS' is not found" em runtime.
5291:                 loc_nItem  = NVL(citens, 0)
5292:                 loc_cDescr = ALLTRIM(NVL(dpros, ""))
5293:                 loc_nQtd   = NVL(qtds, 0)
5294:                 loc_cUni   = NVL(cunis, "")
5295:                 loc_nUnit  = NVL(units, 0)
5296:                 loc_nTota  = NVL(totas, 0)
5297: 
5298:                 IF NVL(codbarras, 0) > 0
5299:                     loc_cCodigo = PADL(ALLTRIM(TRANSFORM(NVL(codbarras, 0))), 14, "0")
5300:                 ELSE
5301:                     loc_cCodigo = ALLTRIM(NVL(cpros, ""))
5302:                 ENDIF
5303: 
5304:                 loc_cTexto = TRANSFORM(loc_nItem, "@Z 9999") + " " + ;
5305:                     PADR(loc_cCodigo, 14) + " " + loc_cDescr
5306:                 INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5307:                     VALUES (loc_nItem, 1, LEFT(loc_cTexto, 90), 0)
5308: 
5309:                 loc_cTexto = "    " + TRANSFORM(loc_nQtd, "@Z 999.99") + " " + ;
5310:                     loc_cUni + " X  " + ;
5311:                     TRANSFORM(loc_nUnit, "@Z 999,999,999.99") + " " + ;
5312:                     TRANSFORM(loc_nTota, "@Z 999,999,999.99")
5313:                 INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5314:                     VALUES (loc_nItem, 2, LEFT(loc_cTexto, 90), 0)
5315: 
5316:                 SELECT crTpmMvItn
5317:             ENDSCAN
5318: 
5319:             *-- 2) Rodape: total de itens, TOTAL, formas, recebido e troco.
5320:             loc_nQtItem = 0
5321:             SELECT crTpmMvItn
5322:             SUM NVL(qtds, 0) FOR !DELETED() TO loc_nQtItem
5323: 
5324:             loc_nTotLiq   = THIS.cnt_4c__Fpagto.cnt_4c__saldo.txt_4c_TotLiquido.Value
5325:             loc_nTotForma = THIS.cnt_4c__Fpagto.cnt_4c__pag.txt_4c_TotForma.Value
5326: 
5327:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5328:                 VALUES (1001, 0, REPLICATE("-", 47), 0)
5329:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5330:                 VALUES (1001, 1, "TI:" + TRANSFORM(loc_nQtItem, "@z 9,999.99"), 1)
5331:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5332:                 VALUES (1002, 1, "", 1)
5333:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5334:                 VALUES (1003, 2, PADR("..TOTAL", 33) + ;
5335:                     TRANSFORM(loc_nTotLiq, "@Z 999,999,999.99"), 1)
5336: 
5337:             loc_nBcd  = 0
5338:             loc_nItem = 1004
5339: 
5340:             IF USED("xPar")
5341:                 *-- Agrupamento transcrito do legado: mesmas chaves, mesmos
5342:                 *-- agregados, mesma ordenacao.
5343:                 SELECT nChaves, FPags, Trocos, cnIdTefs, Infos, ;
5344:                        MAX(tParcs) AS tParcs, MAX(pDescs) AS pDescs, ;
5345:                        SUM(Valos) AS Valos, SUM(ValDescs) AS ValDescs, ;
5346:                        SUM(Bcds) AS Bcds ;
5347:                     FROM xPar ;
5348:                     INTO CURSOR xParECF READWRITE ;
5349:                     GROUP BY 1, 2, 3, 4, 5 ;
5350:                     ORDER BY nChaves, FPags
5351: 
5352:                 IF USED("xParECF")
5353:                     SELECT xParECF
5354:                     GO TOP
5355:                     SCAN
5356:                         *-- Mesma razao do laco dos itens: os campos vao para
5357:                         *-- locais ANTES do primeiro INSERT, que troca a area
5358:                         *-- de trabalho corrente para crTpmMvItnC.
5359:                         loc_cFpag     = ALLTRIM(NVL(FPags, ""))
5360:                         loc_nTParcs   = NVL(tParcs, 0)
5361:                         loc_nPDescs   = NVL(pDescs, 0)
5362:                         loc_nValos    = NVL(Valos, 0)
5363:                         loc_nValDescs = NVL(ValDescs, 0)
5364:                         loc_nBcdLin   = NVL(Bcds, 0)
5365:                         loc_nTrocos   = NVL(Trocos, 0)
5366: 
5367:                         loc_cTexto = PADR(".." + loc_cFpag + ;
5368:                             IIF(loc_nTParcs = 1, "", ;
5369:                                 " (" + TRANSFORM(loc_nTParcs, "@L 99") + "x) " + ;
5370:                                 IIF(loc_nTParcs = 0, "", ;
5371:                                     TRANSFORM(loc_nValos / MAX(loc_nTParcs, 1), ;
5372:                                         "@Z 9999,999.99"))), 33) + ;
5373:                             TRANSFORM(loc_nValos, "@Z 999,999,999.99")
5374:                         INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5375:                             VALUES (loc_nItem, 1, LEFT(loc_cTexto, 90), ;
5376:                                 IIF(loc_nTrocos = 1, 4, 2))
5377:                         loc_nItem = loc_nItem + 1
5378: 
5379:                         IF loc_nValDescs <> 0
5380:                             loc_cTexto = PADR(SPACE(10) + "Desconto " + ;
5381:                                 ALLTRIM(TRANSFORM(loc_nPDescs, "@Z 9999.9999%")), 33) + ;
5382:                                 TRANSFORM(loc_nValDescs, "@Z 999,999,999.99")
5383:                             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5384:                                 VALUES (loc_nItem, 1, LEFT(loc_cTexto, 90), 2)
5385:                             loc_nItem = loc_nItem + 1
5386:                         ENDIF
5387: 
5388:                         loc_nBcd = loc_nBcd + loc_nBcdLin
5389:                         SELECT xParECF
5390:                     ENDSCAN
5391: 
5392:                     USE IN xParECF
5393:                 ENDIF
5394: 
5395:                 SELECT xPar
5396:                 GO BOTTOM
5397:             ENDIF
5398: 
5399:             THIS.this_nBcds = loc_nBcd
5400: 
5401:             IF loc_nTotForma <> 0
5402:                 loc_cTexto = PADR("..Valor Recebido", 33) + ;
5403:                     TRANSFORM(loc_nTotForma, "@Z 999,999,999.99")
5404:                 INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5405:                     VALUES (2000, 1, LEFT(loc_cTexto, 90), 3)
5406:             ENDIF
5407: 
5408:             *-- O troco so aparece com a operacao liberada para troco: e a
5409:             *-- condicao do legado ("And ThisForm.Libtroco"), nao um detalhe.
5410:             IF loc_nTotLiq < loc_nTotForma AND loc_nTotLiq > 0 AND THIS.this_lLibTroco
5411:                 loc_nTroco = loc_nTotForma - loc_nTotLiq
5412:                 loc_cTexto = PADR("..TROCO", 33) + ;
5413:                     TRANSFORM(loc_nTroco, "@Z 999,999,999.99")
5414:                 INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5415:                     VALUES (3000, 1, LEFT(loc_cTexto, 90), 4)
5416:             ENDIF
5417: 
5418:             *-- Popular cursor NAO repinta a grade: Go Top + Refresh, como o
5419:             *-- legado sempre faz (CLAUDE.md #21a).
5420:             SELECT crTpmMvItnC
5421:             SET ORDER TO
5422:             GO TOP
5423:             THIS.cnt_4c_Grade.grd_4c_Cupom.Refresh()
5424:             THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()
5425: 
5426:             *-- Legado encerra o AtuaCupom limpando a linha de mensagem.
5427:             THIS.ExibirMensagem("")
5428: 
5429:             IF loc_nAreaAnt > 0
5430:                 SELECT (loc_nAreaAnt)
5431:             ELSE
5432:                 SELECT crTpmMvItn
5433:             ENDIF
5434: 
5435:             loc_lOk = .T.
5436:         ENDIF
5437: 
5438:         RETURN loc_lOk
5439:     ENDFUNC
5440: 
5441:     *--------------------------------------------------------------------------
5442:     * GravarDocumento - leva a tela para o BO e grava. O cabecalho do
5443:     * documento (SigMvCab, tabela do sigmvitsBO) vai pelo caminho canonico
5444:     * BusinessBase.Salvar(), que ja reporta a falha sozinho (CLAUDE.md #20 -
5445:     * o form nao repete a mensagem).
5446:     *--------------------------------------------------------------------------
5447:     PROTECTED FUNCTION GravarDocumento()

*-- Linhas 5516 a 5550:
5516:     *--------------------------------------------------------------------------
5517:     * [F3]Pend. (cnt_4c__Pendencia.cmd_4c_Bot_Pend) - legado (13 linhas):
5518:     * exige conta de ORIGEM quando crSigOpCdi.OrigDest = 1; limpa as linhas
5519:     * com codigo zerado ("Select TmpOperacao / Delete For Codigos = 0"); e
5520:     * abre SigOpPen, a tela de selecao de pendencias do cliente, que nao tem
5521:     * equivalente migrado. A limpeza local acontece de todo modo.
5522:     *--------------------------------------------------------------------------
5523:     PROCEDURE CmdBotPendentesClick()
5524:         IF EMPTY(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_Conta.Value)
5525:             MsgAviso("Conta de Origem Obrigat" + CHR(243) + "ria!", "Aviso")
5526:             THIS.CmdIdentificaClick()
5527:             RETURN
5528:         ENDIF
5529: 
5530:         IF !USED("TmpOperacao")
5531:             RETURN
5532:         ENDIF
5533: 
5534:         SELECT TmpOperacao
5535:         DELETE FOR NVL(Codigos, 0) = 0
5536:         GO TOP
5537: 
5538:         THIS.RecalcularTotais()
5539:     ENDPROC
5540: 
5541:     *--------------------------------------------------------------------------
5542:     * Painel de cancelamento de item - Ok (cnt_4c_CancelaItem.cmd_4c_Ok).
5543:     *
5544:     * Legado (CancelaItem.ok.Click, 52 linhas): pede senha de supervisor ("Do
5545:     * Form SigOpSen With 'CANCITEM' ..."), chama ParentForm.Cancel_Item_Gen()
5546:     * e replica o cancelamento em CQSigExMvi/CQSigExMvc (tabelas de exportacao
5547:     * fiscal do PAF) antes de atualizar o cupom.
5548:     *
5549:     * SigOpSen (senha) nao tem equivalente migrado - MsgConfirma faz o papel do
5550:     * gate. A replicacao nas tabelas de exportacao fiscal e do form pai. O que

*-- Linhas 5568 a 5622:
5568:             RETURN
5569:         ENDIF
5570: 
5571:         SELECT crTpmMvItn
5572:         SET ORDER TO
5573:         LOCATE FOR NVL(citens, 0) = loc_nItem
5574:         IF EOF()
5575:             MsgAviso("Item n" + CHR(227) + "o encontrado!!!", "Cancelamento de Item")
5576:             THIS.FecharPainelCancelaItem()
5577:             RETURN
5578:         ENDIF
5579: 
5580:         DELETE
5581: 
5582:         *-- Legado: "UltimoCancel = Iif(Get_item.Value > UltimoCancel,
5583:         *-- Get_item.Value, UltimoCancel)" - guarda o maior item cancelado
5584:         *-- para a renumeracao nao reaproveitar o numero.
5585:         THIS.this_nUltimoCancel = MAX(THIS.this_nUltimoCancel, loc_nItem)
5586:         THIS.this_lCancelouItem = .T.
5587: 
5588:         *-- As linhas de texto do cupom daquele item saem da grade junto.
5589:         IF USED("crTpmMvItnC")
5590:             SELECT crTpmMvItnC
5591:             DELETE FOR NVL(cItens, 0) = loc_nItem
5592:             GO TOP
5593:         ENDIF
5594: 
5595:         THIS.RecalcularTotais()
5596:         THIS.FecharPainelCancelaItem()
5597:     ENDPROC
5598: 
5599:     *--------------------------------------------------------------------------
5600:     * Painel de cancelamento de item - CancelaDisp (cmd_4c_CancelaDisp).
5601:     * Legado (6 linhas): "Select crTpmMvItn / Set Order To / CntItem.Enabled =
5602:     * .T. / CancelaItem.Visible = .f. / Get_Produto.Setfocus" - fecha o painel
5603:     * SEM cancelar nada.
5604:     *--------------------------------------------------------------------------
5605:     PROCEDURE CancelaItemCancelaDispClick()
5606:         IF USED("crTpmMvItn")
5607:             SELECT crTpmMvItn
5608:             SET ORDER TO
5609:         ENDIF
5610:         THIS.FecharPainelCancelaItem()
5611:     ENDPROC
5612: 
5613:     *--------------------------------------------------------------------------
5614:     * FecharPainelCancelaItem - fecha o painel e devolve o controle a tela de
5615:     * itens. Compartilhado pelo Ok (apos processar) e pelo CancelaDisp.
5616:     *--------------------------------------------------------------------------
5617:     PROTECTED PROCEDURE FecharPainelCancelaItem()
5618:         THIS.cnt_4c_CancelaItem.Visible = .F.
5619:         THIS.cnt_4c_Item.Enabled        = .T.
5620:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto)
5621:     ENDPROC
5622: 

*-- Linhas 5651 a 5670:
5651:         *-- Legado (Cnt_Pendencia.Proximo.Click): limpa as linhas zeradas do
5652:         *-- sub-nivel e segue para os itens.
5653:         IF USED("TmpOperacao")
5654:             SELECT TmpOperacao
5655:             DELETE FOR NVL(Codigos, 0) = 0
5656:             GO TOP
5657:         ENDIF
5658: 
5659:         THIS.CmdItensClick()
5660:     ENDPROC
5661: 
5662:     PROCEDURE FpagtoProximoClick()
5663:         IF THIS.cnt_4c__Fpagto.cnt_4c__apag.txt_4c_Saldo.Value <= 0
5664:             THIS.FocarControle(THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok)
5665:         ELSE
5666:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
5667:         ENDIF
5668:     ENDPROC
5669: 
5670:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigmvitsBO.prg):
*===============================================================================
* sigmvitsBO.prg - Business Object para Caixa (Frente de Loja / PDV)
* Tabela principal: SigMvCab (cabecalho do movimento/cupom em processamento)
* PK tecnica: empdopnums char(29) = Emps + Dopes + Str(Numes,6)
* Origem legado: SIGMVITS ("Caixa"), pagina/container filho do PDV completo
* Tabelas relacionadas usadas pelo legado (fases seguintes): crTpmMvItn (SigMvItn,
* itens do cupom), SigOpFp/SigOpFpi (formas de pagamento), SigFiFis/SigFiMpf
* (config. fiscal da impressora), SigCdCli (identificacao do cliente/conta),
* SigCdOpe (config. da operacao), SigCdPam (parametros gerais do sistema)
*===============================================================================
DEFINE CLASS sigmvitsBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = "empdopnums"

    *---------------------------------------------------------------------------
    * Propriedades - SigMvCab (cabecalho do movimento/cupom - TprMvCab no legado)
    *---------------------------------------------------------------------------
    this_cEmpdopnums = ""   && empdopnums char(29) NOT NULL - Chave tecnica (Emps+Dopes+Str(Numes,6))
    this_cEmps       = ""   && emps       char(3)  NOT NULL - Empresa
    this_cDopes      = ""   && dopes      char(20) NOT NULL - Codigo da operacao (tipo de movimento)
    this_nNumes      = 0    && numes      numeric(6,0) NOT NULL - Numero do documento/cupom
    this_cEmpds      = ""   && empds      char(3)  NOT NULL - Empresa do documento
    this_cNemps      = ""   && nemps      char(40) NOT NULL - Nome da empresa (grade/historico)
    this_dDatas      = {}   && datas      datetime NULL - Data do movimento
    this_cContads    = ""   && contads    char(10) NOT NULL - Conta destino (cliente)
    this_cContaos    = ""   && contaos    char(10) NOT NULL - Conta origem
    this_cGrupods    = ""   && grupods    char(10) NOT NULL - Grupo destino
    this_cGrupoos    = ""   && grupoos    char(10) NOT NULL - Grupo origem
    this_cResps      = ""   && resps      char(10) NOT NULL - Responsavel/vendedor destino
    this_cGrresps    = ""   && grresps    char(10) NOT NULL - Grupo do responsavel destino
    this_cVends      = ""   && vends      char(10) NOT NULL - Vendedor
    this_cGrvends    = ""   && grvends    char(10) NOT NULL - Grupo do vendedor
    this_cTabds      = ""   && tabds      char(10) NOT NULL - Tabela de desconto
    this_cLprecos    = ""   && lprecos    char(30) NOT NULL - Lista de precos
    this_cMascnum    = ""   && mascnum    char(10) NOT NULL - Mascara de numeracao do documento
    this_nNpedclis   = 0    && npedclis   numeric(11,0) NOT NULL - Numero do pedido do cliente
    this_cTpfats     = ""   && tpfats     char(3)  NOT NULL - Tipo de faturamento
    this_cEcfs       = ""   && ecfs       char(7)  NOT NULL - Numero de serie do ECF
    this_cNcupoms    = ""   && ncupoms    char(6)  NOT NULL - Numero do cupom fiscal
    this_cCodtrans   = ""   && codtrans   char(10) NOT NULL - Codigo da transacao (TEF/cartao)
    this_cMotdscs    = ""   && motdscs    char(10) NOT NULL - Motivo do desconto
    this_cEspes      = ""   && espes      char(10) NOT NULL - Especie (documento/moeda)
    this_cNotas      = ""   && notas      char(6)  NOT NULL - Numero da nota (impressao)
    this_cObses      = ""   && obses      text NULL - Observacoes (memo)
    this_dPrazoents  = {}   && prazoents  datetime NULL - Prazo de entrega
    this_dDtagends   = {}   && dtagends   datetime NULL - Data agendada
    this_nQtdes      = 0    && qtdes      numeric(6,0) NOT NULL - Quantidade de itens do cupom
    this_nPbrus      = 0    && pbrus      numeric(10,3) NULL - Peso bruto
    this_nPliqs      = 0    && pliqs      numeric(10,3) NULL - Peso liquido
    this_nUtilizados = 0    && utilizados numeric(1,0) NOT NULL - Flag de utilizacao
    this_nLocalents  = 0    && localents  numeric(10,0) NOT NULL - Local de entrega
    this_nValos      = 0    && valos      numeric(11,2) NOT NULL - Valor total do documento
    this_nValinis    = 0    && valinis    numeric(11,2) NOT NULL - Valor inicial (bruto dos itens)
    this_nValdevs    = 0    && valdevs    numeric(11,2) NOT NULL - Valor devolvido
    this_nValobxs    = 0    && valobxs    numeric(11,2) NOT NULL - Valor baixado
    this_nValservs   = 0    && valservs   numeric(11,2) NOT NULL - Valor de servicos
    this_nValvars    = 0    && valvars    numeric(11,2) NOT NULL - Valor de variacao (desconto/acrescimo)
    this_nValvarps   = 0    && valvarps   numeric(11,2) NOT NULL - Valor de variacao percentual
    this_nVars       = 0    && vars       numeric(9,4) NOT NULL - Percentual de variacao
    this_lChkpagos   = .F.  && chkpagos   bit NOT NULL - Flag pagamento conferido
    this_lChksubn    = .F.  && chksubn    bit NOT NULL - Flag possui sub-nivel
    this_lLcancelas  = .F.  && lcancelas  bit NOT NULL - Flag documento cancelado

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "empdopnums"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpdopnums)
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega do cursor SQL para as propriedades do BO.
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar os campos -
    * "campo" e sintaxe invalida em VFP9 (regra #9 CLAUDE.md).
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cEmpds      = TratarNulo(empds, "")
                THIS.this_cNemps      = TratarNulo(nemps, "")
                THIS.this_dDatas      = TratarNulo(datas, {})
                THIS.this_cContads    = TratarNulo(contads, "")
                THIS.this_cContaos    = TratarNulo(contaos, "")
                THIS.this_cGrupods    = TratarNulo(grupods, "")
                THIS.this_cGrupoos    = TratarNulo(grupoos, "")
                THIS.this_cResps      = TratarNulo(resps, "")
                THIS.this_cGrresps    = TratarNulo(grresps, "")
                THIS.this_cVends      = TratarNulo(vends, "")
                THIS.this_cGrvends    = TratarNulo(grvends, "")
                THIS.this_cTabds      = TratarNulo(tabds, "")
                THIS.this_cLprecos    = TratarNulo(lprecos, "")
                THIS.this_cMascnum    = TratarNulo(mascnum, "")
                THIS.this_nNpedclis   = TratarNulo(npedclis, 0)
                THIS.this_cTpfats     = TratarNulo(tpfats, "")
                THIS.this_cEcfs       = TratarNulo(ecfs, "")
                THIS.this_cNcupoms    = TratarNulo(ncupoms, "")
                THIS.this_cCodtrans   = TratarNulo(codtrans, "")
                THIS.this_cMotdscs    = TratarNulo(motdscs, "")
                THIS.this_cEspes      = TratarNulo(espes, "")
                THIS.this_cNotas      = TratarNulo(notas, "")
                THIS.this_cObses      = TratarNulo(obses, "")
                THIS.this_dPrazoents  = TratarNulo(prazoents, {})
                THIS.this_dDtagends   = TratarNulo(dtagends, {})
                THIS.this_nQtdes      = TratarNulo(qtdes, 0)
                THIS.this_nPbrus      = TratarNulo(pbrus, 0)
                THIS.this_nPliqs      = TratarNulo(pliqs, 0)
                THIS.this_nUtilizados = TratarNulo(utilizados, 0)
                THIS.this_nLocalents  = TratarNulo(localents, 0)
                THIS.this_nValos      = TratarNulo(valos, 0)
                THIS.this_nValinis    = TratarNulo(valinis, 0)
                THIS.this_nValdevs    = TratarNulo(valdevs, 0)
                THIS.this_nValobxs    = TratarNulo(valobxs, 0)
                THIS.this_nValservs   = TratarNulo(valservs, 0)
                THIS.this_nValvars    = TratarNulo(valvars, 0)
                THIS.this_nValvarps   = TratarNulo(valvarps, 0)
                THIS.this_nVars       = TratarNulo(vars, 0)

                IF VARTYPE(chkpagos) = "L"
                    THIS.this_lChkpagos = chkpagos
                ELSE
                    THIS.this_lChkpagos = (NVL(chkpagos, 0) = 1)
                ENDIF

                IF VARTYPE(chksubn) = "L"
                    THIS.this_lChksubn = chksubn
                ELSE
                    THIS.this_lChksubn = (NVL(chksubn, 0) = 1)
                ENDIF

                IF VARTYPE(lcancelas) = "L"
                    THIS.this_lLcancelas = lcancelas
                ELSE
                    THIS.this_lLcancelas = (NVL(lcancelas, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCab (PROTECTED, chamado por
    * BusinessBase.Salvar() quando this_lNovoRegistro = .T.)
    *
    * SigMvCab tem 158 colunas, quase todas NOT NULL sem DEFAULT (regra #22
    * CLAUDE.md). Este BO so declara propriedade para as colunas que o
    * container "Caixa" (SIGMVITS) de fato le/grava - as demais colunas
    * NOT NULL recebem o default do TIPO (char="", numeric/bit=0) para nao
    * violar a constraint; colunas NULLABLE sem propriedade sao OMITIDAS da
    * lista (o SQL Server preenche NULL sozinho). cidchaves eh a PK real
    * (fUniqueIds()) - NUNCA string vazia, senao a inclusao inteira falha
    * por colisao/violacao da PRIMARY KEY.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCidchaves, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCidchaves = LEFT(fUniqueIds(), 20)

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCab ("
            loc_cSQL = loc_cSQL + "npedclis, acres, antecs, chksubn, codpeds, contads, contaos, datas,"
            loc_cSQL = loc_cSQL + "desc2s, descs, devols, dopes, empds, emps, grresps, grupods,"
            loc_cSQL = loc_cSQL + "grupoos, grupos, grvends, iclis, ifors, locals, lotechqs, lprecos,"
            loc_cSQL = loc_cSQL + "mascnum, ncarnecs, nemps, nops, notas, nrcons, ntrans, numes,"
            loc_cSQL = loc_cSQL + "numolds, obses, opers, prazoents, resps, tabds, tpfats, transps,"
            loc_cSQL = loc_cSQL + "usuals, usuars, usulibs, valacres, valdes2s, valdescs, valdevs, valencs,"
            loc_cSQL = loc_cSQL + "valinis, valos, valservs, valvars, vars, vends, cotusus, espes,"
            loc_cSQL = loc_cSQL + "pbrus, pliqs, qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs,"
            loc_cSQL = loc_cSQL + "codobs, dgopes, trfisicos, utilizados, valndevs, valobxs, noforms, auditors,"
            loc_cSQL = loc_cSQL + "cidchaves, empdopnums, empgopnums, contaes, dtagends, localents, localizas, chkpagos,"
            loc_cSQL = loc_cSQL + "chkpgs, codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, motdscs,"
            loc_cSQL = loc_cSQL + "ndeclaras, numbalds, numbals, priors, procbals, procdbal, protats, usupagos,"
            loc_cSQL = loc_cSQL + "ultgrvs, moeits, rnops, impress, pstatus, valvarps, cifccfs, cupfis,"
            loc_cSQL = loc_cSQL + "idconta, ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, jobs,"
            loc_cSQL = loc_cSQL + "ptax1s, ptax2s, ptax3s, obscabmovs, codobs2, valserfix, perserfix, valosfix,"
            loc_cSQL = loc_cSQL + "chkencerra, perdesc, compet, pedidoweb, cdrastreio, identrega, idtransp, peracresc,"
            loc_cSQL = loc_cSQL + "tpmovs, empfats, numeronota, meiotrans, chavenota, contaccs, grupoccs, natend,"
            loc_cSQL = loc_cSQL + "nlivdg, presente, chaveexterna, empret, msgpresnte, ckoperpend, usuconfs"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidchaves) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCab (WHERE empdopnums,
    * chave tecnica desta entidade - Emps+Dopes+Str(Numes,6) - regra #22).
    * cidchaves (PK real da tabela) NUNCA e regravado num UPDATE.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " npedclis = " + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + " chksubn = " + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contads = " + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = " + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " empds = " + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grresps = " + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = " + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + " grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = " + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + " lprecos = " + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + " mascnum = " + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + " nemps = " + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " obses = " + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + " resps = " + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = " + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + " tpfats = " + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + " valdevs = " + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + " valinis = " + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + " valservs = " + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + " valvars = " + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + " vars = " + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + " vends = " + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " lcancelas = " + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " ecfs = " + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + " utilizados = " + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + " valobxs = " + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " dtagends = " + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + " localents = " + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + " chkpagos = " + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + " motdscs = " + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + " valvarps = " + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + " ncupoms = " + EscaparSQL(LEFT(THIS.this_cNcupoms, 6))
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

