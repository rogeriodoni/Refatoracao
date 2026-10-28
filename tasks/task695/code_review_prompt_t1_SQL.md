# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _CONT, _GRUPO, DESCS, ESTADOS, LIBCSENS, ICLIS, FPAGS, UMOVS, _SAIDA, NTPIMPRES, USUACESS, CIMPS, USUARIOS, GRUPOS, _XLINHA, CPFS, CCPFS, CODIGOS, DTENTS, VENCS, NUMS, ESTOS, EMPS, ATIVAS, BXPARCIALS, BXAUTOS, CDOPES, CONTADS, DATAS, CONTAOS, DOPES, VENDAS, CITENS, EMPDOPNUMS, CIDQUERYS, CPROS, VALPRES, EMPGRUESTS, NUMES, NOPS, EMPDNPS, SERVICOS, SALDO, CONTAS, PAGOS, VALPENDS, PARCS, LISCONGV, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, TIPOS, CONGVS, DEVOLVIDOS, DOPCS, CONTEMS, OPERS, GRCLIS, CHKLIMESTS, I, CONJCONVS, RCLIS, CONJUGES, TEL1S, IMPS, CBARS, CGRUS, CHKPAGOS, NENVS, UFIBGES, OPCONRCL

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
  Column1.ControlSource = "dbhistorico.datas"
  Column2.ControlSource = "dbhistorico.valors"
  Column3.ControlSource = "dbhistorico.opers"
  Column4.ControlSource = "dbhistorico.saldos"
  Column5.ControlSource = "dbhistorico.hists"
  Column6.ControlSource = "dbhistorico.emps"
  ControlSource = "dbhistorico.datas"
  ControlSource = "dbhistorico.valors"
  ControlSource = "dbhistorico.opers"
  ControlSource = "dbhistorico.saldos"
  ControlSource = "dbhistorico.hists"
  ControlSource = "dbhistorico.emps"
  DeleteMark = .F.
  Column1.ControlSource = "dbsaldo.moedas"
  Column2.ControlSource = "dbsaldo.saldos"
  Column3.ControlSource = "dbsaldo.saldoConta"
  ControlSource = "dbsaldo.moedas"
  ControlSource = "dbsaldo.saldos"
  DeleteMark = .F.
  Column1.ControlSource = "dbaberto.bancos"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "dbaberto.agencias"
  Column3.ControlSource = "dbaberto.ncheques"
  Column4.ControlSource = "dbaberto.vencs"
  Column5.ControlSource = "dbaberto.valors"
  Column6.ControlSource = "dbaberto.ncontas"
  ControlSource = "dbaberto.bancos"
  ControlSource = "dbaberto.agencias"
  ControlSource = "dbaberto.ncheques"
  ControlSource = "dbaberto.vencs"
  ControlSource = "dbaberto.valors"
  DeleteMark = .F.
  Column1.ControlSource = "dbfollow.hists"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "dbfollow.datas"
  ControlSource = "dbfollow.hists"
  ControlSource = "dbfollow.datas"
  DeleteMark = .F.
  Column1.ControlSource = "dbtitulo.titulos"
  Column2.ControlSource = "dbtitulo.vencs"
  Column3.ControlSource = "dbtitulo.valors"
  Column4.ControlSource = "dbtitulo.valpags"
  Column5.ControlSource = "dbtitulo.saldos"
  Column6.ControlSource = "dbtitulo.moedas"
  ControlSource = "dbtitulo.titulos"
  ControlSource = "dbtitulo.vencs"
  ControlSource = "dbtitulo.valors"
  ControlSource = "dbtitulo.valpags"
  ControlSource = "dbtitulo.saldos"
  ControlSource = "dbtitulo.moedas"
  DeleteMark = .F.
  Column1.ControlSource = "dbdevolvido.bancos"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "dbdevolvido.agencias"
  Column3.ControlSource = "dbdevolvido.ncheques"
  Column4.ControlSource = "dbdevolvido.vencs"
  Column5.ControlSource = "dbdevolvido.valors"
  Column6.ControlSource = "dbdevolvido.ncontas"
  ControlSource = "dbdevolvido.bancos"
  ControlSource = "dbdevolvido.agencias"
  ControlSource = "dbdevolvido.ncheques"
  ControlSource = "dbdevolvido.vencs"
  ControlSource = "dbdevolvido.valors"
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
  Column1.ControlSource = "DbOperac.Numes"
  Column2.ControlSource = "DbOperac.Datas"
  Column3.ControlSource = "DbOperac.Emps"
  Column4.ControlSource = "DbOperac.Valos"
  DeleteMark = .F.
  Column1.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "dbTotVendas.MesAnos"
  Column2.ControlSource = "dbTotVendas.Moedas"
  Column3.ControlSource = "dbTotVendas.VRMOVS"
  Column4.ControlSource = "dbTotVendas.TOTALS"
  ControlSource = "dbProduto.CodBarras"
  ControlSource = "dbProduto.CodTams"
  DeleteMark = .F.
  Column1.ControlSource = "DbEstoque.Cpros"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "DbEstoque.Sqtds"
  Column3.ControlSource = '""'
  ControlSource = "DbEstoque.Cpros"
  ControlSource = "DbEstoque.Sqtds"
  DeleteMark = .F.
  Column1.ControlSource = "TmpPar.FPags"
  Column2.ControlSource = "TmpPar.Valos"
  Column3.ControlSource = "TmpPar.Moefpgs"
  Column4.ControlSource = "tmppar.vencs"
  Column5.ControlSource = "TmpPar.Hists"
  Column6.ControlSource = "TmpPar.Opers"
  ControlSource = ""
  ControlSource = "tmppar.vencs"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "dboperaP.dopes"
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  ControlSource = ""
  ControlSource = "mascnum"
  DeleteMark = .F.
  Column1.ControlSource = "Tmpcart.Vencs"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "Tmpcart.FPags"
  Column3.ControlSource = "Tmpcart.NoCreditos"
  Column4.ControlSource = "Tmpcart.Cartaos"
  Column5.ControlSource = "Tmpcart.Valos"
  Column6.ControlSource = "Tmpcart.Datas"
  ControlSource = "dbaberto.bancos"
  ControlSource = "dbaberto.agencias"
  ControlSource = "dbaberto.ncheques"
  ControlSource = "dbaberto.vencs"
  ControlSource = "dbaberto.valors"
  DeleteMark = .F.
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = "dbItens.cpros"
  Column2.ControlSource = "dbItens.qtds"
  Column3.ControlSource = "dbItens.saldo"
  Column4.ControlSource = "dbItens.xper"
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = "dbProduc.cpros"
  Column2.ControlSource = "dbProduc.fase"
  Column3.ControlSource = "dbProduc.qtde"
  Column4.ControlSource = "dbProduc.prevs"
  Column5.ControlSource = "dbProduc.xper"
  Column6.ControlSource = "dbproduc.Nops"
  Column7.ControlSource = "dbProduc.nenvs"
  Column8.ControlSource = "dbProduc.Numes"
  DeleteMark = .F.
  Column1.ControlSource = "DbConserto.Datas"
  Column1.SelectOnEntry = .T.
  Column2.ControlSource = "DbConserto.Emps"
  Column3.ControlSource = "DbConserto.PrazoEnts"
  Column4.ControlSource = "DbConserto.MascNum"
  Column5.ControlSource = "DbConserto.Status"
  ControlSource = ""
  ControlSource = "mascnum"
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = "dbEstIte.grupos"
  Column2.ControlSource = "dbEstIte.estos"
  Column3.ControlSource = "dbEstIte.sqtds"
  Column4.ControlSource = "dbEstIte.xper"
  Column5.ControlSource = "dbEstIte.cpros"
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = "dbopera.dopes"
  ControlSource = ""
  DeleteMark = .F.
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
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
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
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
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  ControlSource = ""
		=Seek(_Grupo,'CrSigCdGcr','Codigos')
		=Seek(_Grupo,'CrSigCdGcr','Codigos')
					Select &_Alias
lcQuery = [Select a.Codigos ] + ;
		    [From SigCdMun a, SigCdUfs b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMunic]) < 1)
Select LocalMunic
lcQuery = [Select UFIBGEs ] + ;
		    [From SigCdUfs ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalUF]) < 1)
Select LocalUF
lcQuery = [Select Dopes ] + ;
		    [From SigOpCdd ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crOpe]) < 1)
Select crOpe
		lcQuery = [Select ContaVens ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crCli]) < 1)
		Select crCli
	Select TmpPar
	Select TmpPar
Select TmpPar
		Select dbOperaP
		lcQuery = 'Select *  from dbConserto Where' + ;
			.Column1.ControlSource = 'mascnum'
			.Column2.ControlSource = 'datas'
			.Column3.ControlSource = 'emps'
			.Column4.ControlSource = 'Status'
			.Column5.ControlSource = 'ObsCon'
			.Column6.ControlSource = 'ValPends'	
	Select dbSaldo
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Grupo, Valor, Moeda ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select CrTmpLCrdi
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Grupo, Valor, Moeda ) ;
	Select dbAberto
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Data, Valor, Descricao ) ;
			Select CrSigCheH
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select dbDevolvido
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Data, Valor, Descricao ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select CrTmpChe
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Data, Valor, Descricao ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select TmpCart
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Data, Valor, Descricao ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select TmpPar
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Data, Valor, Descricao, Moeda, Opers ) ;
			If !Seek( TmpPar.Moefpgs, 'TmpTotal' )
				Insert Into TmpTotal ( Moeda ) Values ( TmpPar.Moefpgs )
			Select TmpTotal
				Insert Into TmpRelGv ( Valtipo, Valor, Moeda ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select dbConserto
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Data, Descricao ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select dbTitulo
			Insert Into TmpRelGv ( Cabtipo, Valtipo, Grupo, Data, Valor, ValoPg, Saldo, Moeda, Observa ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select dbTotVendas
			Insert Into TmpRelGv ( CabTipo, ValTipo, Grupo, Moeda, Valor, ValoPg, Anos, Meses ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select dbProduto
			Insert Into TmpRelGv ( CabTipo, ValTipo, Cpros, DPros, Qtds, Opers, Emps, dopes, Numes, Data, Valor, Valopg, ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select dbproduc
			=Seek(DbProduc.Emps + DbProduc.Dopes + Str(DbProduc.Numes,6),'DbConserto','EmpDopNum')
			Insert Into TmpRelGv ( CabTipo, ValTipo, Dopes, Numes, Data, PrazoEnts, Cpros, Fase, Qtds,;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
	Select dbEstoque
			Insert Into TmpRelGv ( CabTipo, ValTipo, Grupo, Cpros, Qtds ) ;
		Insert Into TmpRelGv ( Cabtipo, Valtipo, Observa ) ;
Select TmpRelGv
	Insert Into TmpRelGv ( ValTipo ) Value ( 999 )
	lcQuery = [Select * from SigCdCeb where iClis = ']+_CodEmp+[']
	ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCdCeb])
	Select crSigCdCeb
	lcQuery = [Select * from SigCdClh where iClis = ']+_CodEmp+[']
	ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCdClh])
	Select crSigCdClh
Select * From crSigCdCli Into Cursor crCli
Select crCli
		lcQuery = [Select * from SigCdmp]
		ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCdmp])		
		lcQuery = [Select * from SigSyImp]
		ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigSyImp])
		lcQuery = [Select * from SigCdAcG]
		ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCdAcG])
	Select * From crSigCdmp Where nTpImpres = 1 Into Cursor LocalCimp
	Select b.* From crSigSyImp a, crSigCdmp b Where a.UsuAcess = Usuar And a.cimps = b.impres ;
			Select c.* From crSigCdAcG a, crSigSyImp b, crSigCdmp c Where a.Usuarios = Usuar ;
	Select CrTmpCimp
		Select * From CrTmpCimp Into Cursor LocalcImp1
		Select LocalCImp
	Select LocalcImp
	Select *, llFlags as lMarcas, llFlags as lSituas ;
	  From LocalcImp ;
	Select csSigCdmp
	lcQuery = [Select * from SigCdCeb where iClis = ']+_CodEmp+[']
	ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCdCeb])
	Select crSigCdCeb
	lcQuery = [Select * from SigCdClh where iClis = ']+_CodEmp+[']
	ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigCdClh])
	Select crSigCdClh
	lcQuery = 'Select * ' + ;
				'From SigCdCli ' + ;
	ThisForm.poDataMgr.SQLExecute(lcQuery,'crCli')
	lcQuery  = 'Select * From SigFiCp Where ccpfs = "'+lcNrCpf+'"' 
	ThisForm.poDataMgr.SQLExecute(lcQuery,'crSigFiCp')
	Select crSigFiCp
	Select crSigFiCp
			.Column1.ControlSource = "crSigFiCp.Tipos"
			.Column2.ControlSource = "crSigFiCp.Usuars"
			.Column3.ControlSource = "crSigFiCp.Emps"
			.Column4.ControlSource = "crSigFiCp.Datas"
			.Column5.ControlSource = "crSigFiCp.Dopes"
			.Column6.ControlSource = "crSigFiCp.Numes"
			.get_nr_cpf.ControlSource = "crSigFiCp.ccpfs"
			.get_valor.ControlSource  = "crSigFiCp.nvalors"
			.dtvenc.ControlSource	  = "crSigFiCp.dvencs"
			.get_bco.ControlSource     = "crSigFiCp.cbancos"
			.get_age.ControlSource     = "crSigFiCp.cagencias"
			.get_conta.ControlSource   = "crSigFiCp.ccontas"
			.get_num.ControlSource     = "crSigFiCp.ccheinis"
			.get_dig.ControlSource     = "crSigFiCp.cdiginis"
			.get_numf.ControlSource    = "crSigFiCp.cchefins"
			.get_digf.ControlSource    = "crSigFiCp.cdigfins"
			.get_serie.ControlSource   = "crSigFiCp.cseries"
			.get_dtctaab.ControlSource = "crSigFiCp.cdaberts"
			.OptDocs.ControlSource     = "crSigFiCp.nChkDocs"
			.Get_Data.ControlSource    = "crSigFiCp.tdDocs"
	lcQuery = 'Select Descrs ' + ;
				'From SigCdCst ' + ;
	ThisForm.poDataMgr.SQLExecute(lcQuery,'crScli')
	ThisForm.poDataMgr.SQLExecute('select codigos,descrs,codpai,visuals from SigFiCt order by 1','crSigFiCT')
lcWherChe = [ select b.dtents,a.*,d.Nums as Tipo,VENCS=case when c.tipos = 'CR' then c.DTENTS ]+;
			[ when c.tipos = 'DB' then getdate() end from SigChe a join ]+;
			[ (select max(dtents) as dtents, nums  from SigCqChm group by nums ) b on  a.nums = b.nums ]+;
			[ join SigCqChm c on b.nums = c.nums and b.dtents = c.dtents ]+;
			[ left join SigCheh d On a.Nums = d.Nums ]
ThisForm.podatamgr.SqlExecute(lcWherChe,'CrSigCheT')
Select *, 000000 AS DiasP from CrSigCheT into cursor CrSigChe readwrite 
Select CrSigChe
Select CrSigChe
lcQuery = [Select * From SigCqChm Where Nums = '] + lcNum + [' Order By Nums, Dtsis Desc]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCqChm]) < 1)
Select crSigCqChm
lcQuery = [Select * From SigChea Where Nums = '] + lcNum + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigChea]) < 1)
Select crSigChea
Select CrSigChe
		.Column9.ControlSource = "CrSigChe.Emps"
		.Column1.ControlSource = "CrSigChe.Vencs"
		.Column2.ControlSource = "CrSigChe.Bancos"
		.Column3.ControlSource = "CrSigChe.Agencias"
		.Column4.ControlSource = "CrSigChe.ncontas"
		.Column5.ControlSource = "CrSigChe.ncheques"
		.Column6.ControlSource = "CrSigChe.valors"
		.Column7.ControlSource = "CrSigChe.grucarts"
		.Column8.ControlSource = "CrSigChe.concarts"
		.Column10.ControlSource = "CrSigChe.Numeros"
		.Column11.ControlSource = "CrSigChe.DiasP"
		.Column1.ControlSource = "CrSigCqChm.Codigos"
		.Column2.ControlSource = "CrSigCqChm.Nalineas"
		.Column3.ControlSource = "CrSigCqChm.dtents"
		.Column4.ControlSource = "CrSigCqChm.gruorigs"
		.Column5.ControlSource = "CrSigCqChm.conorigs"
		.Column6.ControlSource = "CrSigCqChm.grupos"
		.Column7.ControlSource = "CrSigCqChm.contas"
		.Column8.ControlSource = "CrSigCqChm.Numlotes"
		.Column9.ControlSource = "CrSigCqChm.protocolos"
		.Column1.ControlSource = "ttod(CrSigChea.Vencs)"
lStrQuery = [Select cartaos, datas, fpags, valos, nocreditos, vencs, totres, totpar From SigCdCrd ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpCard')
Select TmpCard
		Insert Into TmpCart (cartaos,datas,fpags,valos,nocreditos,vencs) ;
lStrQuery = [Select a.grupos, a.cpros, Sum(a.sqtds) as Sqtds From SigMvEst a, SigCdEmp b ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpEst')
Select TmpEst
		Insert Into dbEstoque (grupos,cpros,sqtds) Values (TmpEst.grupos,TmpEst.cpros,TmpEst.sqtds)
lcQuery = [Select a.Nivels ] + ;
			[From SigCdOpe a ] + ;
		  [Select b.CNivels as Nivels ] + ;
			[From SigOpCsn b, SigCdOpe c ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSubs]) < 1)
Select Distinct Nivels ;
  From LocalSubs ;
Select TmpOpe
lStrQuery = [Select Dopes,Vendas,Valpres,cMoes,Casas,globalizas,Servicos,Produc,Origems,EstOrigs,Destinos,EstDests,CupFis From SigCdOpe ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CrTmpOpe') < 1
Select CrTmpOpe
lStrQuery = [Select '1' as tps, GrupoDs as Grupos,Dopes,ChkSubn,Grupoos,GrupoDs,ContaOs,ContaDs,Datas,]+;
			[From SigMvCab Where ContaDs = ']+lcCdConta+[' ]+ ;
			[Select '2' as tps, GrupoOs as Grupos,Dopes,ChkSubn,Grupoos,GrupoDs,ContaOs,ContaDs,Datas,]+; 
			[From SigMvCab Where ContaOs = ']+lcCdConta+[' And Not ContaDs = ']+lcCdConta+[' ] +;
If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CrTprMvCab') < 1
lStrQuery = [Select * From SigOpPed ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CrSigOpPed') < 1
Select a.* From CrTprMvCab a, TmpOpe b, CrSigOpPed c Where Not a.ChkSubn And a.dopes = b.Nivels And ;
Select a.*, b.ValPres, b.Cmoes From CrTprMvCab a, CrTmpOpe b where a.Dopes = b.dopes And b.Vendas = 1 ;
Select CrSigTempC
Select CrVendas
	Select CrSigTempC
If !ThisForm.Podatamgr.UpDate('CrSigTempC')
lStrQuery = [Select b.Grupos, c.Cgrus, a.Cpros, a.Dpros, a.Qtds, a.dopes, b.MascNum, b.Datas, ]+;
			[From SigMvItn a left Join SigMvIts f on f.empdopnums = a.empdopnums and f.citens = a.citens ]+;
			[Left Join SigOpEtq g On g.cbars = a.CodBarras, ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CrItens') < 1
Update CrItens Set Datas = Nvl(Datas, Ctod([]))
Select DbProdTodos
Append From Dbf('CrItens')
	=Seek(DbProdTodos.Dopes,'CrTmpOpe','Dopes')
Update DbProdTodos; 	
Select * From CrVendas Where ValPres = 3 And Not Empty(Cmoes) Into Cursor CrVendas2
	Select a.* From CrTprMvCab a, TmpOpe b Where Not a.ChkSubn And a.dopes = b.Nivels And a.Dopes = lcOpConsers;
	Select CrConserto1
		Insert Into DbConserto ( Grupos, Datas, Emps, Dopes, Mascnum, Status, Obscon, Numes, PrazoEnts, ChkPagos, Utilizados ) ;
		lcSql = [Select EmpDopNums From SigMvCab Where EmpDopNums = ']+_Emp + crSigCdPam.OpConRClis + Str( _Num, 6 )+[']
		If Thisform.Podatamgr.Sqlexecute(lcsql,'TmpConserto') < 1
			Select DbConserto
			Delete
			lcSql = [Select EmpDopNums From SigMvCab Where EmpDopNums = ']+_Emp + crSigCdPam.OpConRFors + Str( _Num, 6 )+[']
			If Thisform.Podatamgr.Sqlexecute(lcsql,'TmpConserto') < 1
				lcSql = [Select EmpDopNums From SigMvCab Where EmpDopNums = ']+_Emp + crSigCdPam.OpConFors + Str( _Num, 6 )+[']
				If Thisform.Podatamgr.Sqlexecute(lcsql,'TmpConserto') < 1
			=Seek(CrConserto1.Dopes,'CrTmpOpe','Dopes')
				Select * from DbOpera  WHERE Grupos = _Grupo and Dopes = CrConserto1.Dopes into Cursor Vopera
					Insert Into DbOpera ( Grupos, Dopes ) Values ( _Grupo, CrConserto1.dopes)
						Insert Into DbOperaP( Grupos, Dopes ) Values ('|', 'TODAS OPERAÇÕES')
					Insert Into DbOperaP( Grupos, Dopes ) Values ( _Grupo, CrConserto1.dopes)
Select CrConserto2
	Insert Into DbConserto ( Grupos, Datas, Emps, Dopes, Mascnum, Status, ;
	=Seek(CrConserto2.Dopes,'CrTmpOpe','Dopes')
		Select * from DbOpera  WHERE Grupos = _Grupo and Dopes = CrConserto2.Dopes into Cursor Vopera
			Insert Into DbOpera ( Grupos, Dopes ) Values ( _Grupo, CrConserto2.dopes)
				Insert Into DbOperaP( Grupos, Dopes ) Values ('|', 'TODAS OPERAÇÕES')
			Insert Into DbOperaP( Grupos, Dopes ) Values ( _Grupo, CrConserto2.dopes)			
Select CrVendas2
	=Seek(CrVendas2.Dopes,'CrTmpOpe','Dopes')
	lcSql = [Select * From SigMvMov Where EmpDopNums = ']+CrVendas2.Emps + CrVendas2.Dopes + Str(CrVendas2.Numes,6)+[']
	If ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpEstMo') < 1
	Select CrTmpEstMo
	lcSql = [Select a.*, b.Colecoes, b.Cgrus  From SigMvItn a Left Join SigCdPro b On a.cpros = b.cpros ]+;
	If ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTprMvCabi') < 1
	Select CrTprMvCabi
	Select CrTprMvCabi
		Insert Into DbProdTodos ( Grupos, Cgrus, Cpros, Dpros, Qtds, Dopes, ;
Select Distinct Grupos From DbProdTodos Into Cursor crGrupos
Select Distinct Cgrus From DbProdTodos Into Cursor crcGrus
Select CrGrupos
lcSql = [Select Cgrus, Dgrus From SigCdGrp ]
If ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpGru') < 1
Select CrTmpGru
Select CrCgrus
	=Seek(CrCgrus.Cgrus,'CrTmpGru','Cgrus')
Select DbConserto
	lcQuery = [ Select Emps,Dopes,Numes,Qtds,Qtbaixas,Units,Valrats,Cpros,DPros ] + ;
			  [ From SigMvItn ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTprMvCabi]) < 1)
		lcQuery = [ Select Valos ] + ;
				  [ From SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEest]) < 1)
		Select crTprMvCabi
Select Distinct Emps, Dopes, Numes ;
  From DbConserto ;
Select CrSigTempC
Select CsCabec
	Select CrSigTempC
If !ThisForm.Podatamgr.UpDate('CrSigTempC')
Select CrSigTempC
	lStrQuery = [Select a.emps, a.dopes, a.numes, a.cpros, a.DPros, sum(a.qtds) as qtds, sum(a.qtds-a.qtbaixas) as saldo ]+;
				[From SigMvItn a, SigTempC b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CsEestiTmp') < 1
	Select dbItens
	Append from dbf('csEestiTmp')
loBarra.Update( .t.,'')
Select CrSigTempC
Select dbItens
	Select CrSigTempC
If !ThisForm.Podatamgr.UpDate('CrSigTempC')
Select CrSigTempC
	lStrQuery = [Select a.emps, a.grupos, a.estos, a.cpros, sum(a.sqtds) as sqtds From SigMvEst a, SigTempC b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CsEstTmp') < 1
	Select dbEstIte
	Append from dbf('csEstTmp')
loBarra.Update( .t.,'')
Select csCabec
	lStrQuery = [Select emps, dopes, numes, nops, empds, qtds, dataes From SigOpPic ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'crTmpOpi')
	Select CrTmpOpi
		lStrQuery = [Select emps, nops, Nenvs, datas, Codpds, grupods, contads From SigPdMvf Where nops = ]+Str(crTmpOpi.nops,10)+[ ]
		lnQueryOk = ThisForm.podataMgr.SqlExecute(lStrQuery, 'crTmpMFas')
		Select CrTmpMFas
			lStrQuery = [Select empdnps, chksubn From SigCdNec ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'crTmpNens')
			Select CrtmpNens
				lStrQuery = [Select empdnps, chksubn From SigCdNec ]+;
				lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'crTmpNens')
				Select CrTmpNens
			Select CrTmpMFas
			=Seek(crtmpOpi.Dopes,'crtmpOpe','Dopes')
			lcSql = [Select GrupoOs, ContaOs, GrupoDs, ContaDs From SigMvCab where EmpDopNums = ']+lcEDN+[']
			If ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTprMvCab') < 1
				Insert Into dbProduc ( Op, Sequencia, CPros, Qtde, Fase, Data, Dopes, Numes, emps, Prevs, Nops, Nenvs ) ;
loBarra.Update( .t.,'')
Select Emps, Dopes, Numes, Nops, Fase, Max(Op) as Op, Max(Sequencia) as Sequencia, Max(Qtde) as Qtde, ;
  From dbProduc ;
Select dbProduc
Append from dbf('dbProd1')
Select dbItens
loBarra.Update( .t.,'')
Select dbEstIte
	if Seek(dbEstIte.emps+dbEstIte.cPros,"dbItens","cPros") and dbItens.saldo <> 0
loBarra.Update( .t.,'')
Select dbConserto
Select dbProduc
	if seek(dbProduc.Emps+dbProduc.Dopes+str(dbProduc.Numes,6)+dbProduc.Cpros,"dbItens","EmpDopNum") and dbItens.saldo <>0
loBarra.Update( .t.,'')
Select dbProduc
	Select crTmpCli
		.Column1.ControlSource = 'CrSigClLcr.grupos'
		.Column2.ControlSource = 'CrSigClLcr.limcres'
		.Column3.ControlSource = 'CrSigClLcr.moedas'
	lStrQuery = [Select * From SigMvCcr ]+;
	If ThisForm.podataMgr.SqlExecute(lStrQuery, 'TmpMccr') < 1
	Select TmpMccr 
		Insert Into DbHistorico (Emps, Grupos, Datas, Valors, Opers, Saldos, Hists, Hist2s, Moedas, Dopes, Numes) ;
			Insert Into TmpPar ( Emps, Grupos, Vencs, Fpags, Valos, Moefpgs, Hists, Opers ) ;
		lStrQuery = [Select a.grupos, c.descrs, a.contas, b.rclis, a.moedas, a.saldos, isnull(d.LimCres,0) as LimCres, ] + ;
						[from SigMvSlc a ] + ; 
						[join sigcdcli b on a.contas = b.iclis ] + ;
						[join sigcdgcr c on a.grupos = c.codigos ] + ;
						[left join sigClLcr d on a.contas = d.contas ] + ;
		If ThisForm.podataMgr.SqlExecute(lStrQuery, 'TmpSccr') < 1
		Select TmpSccr
			Insert Into dbSaldo (grupos,moedas,saldos,SaldoConta) Values (TmpSccr.grupos,TmpSccr.moedas,TmpSccr.saldos,TmpSccr.SaldoConta)
		Select grupos, moedas, Sum(Valors * Iif(opers=[D],1,-1)) as saldos ;
		from DbHistorico group by grupos, moedas into cursor TmpSccr
		Select TmpSccr
			Insert Into dbSaldo (grupos,moedas,saldos) Values (TmpSccr.grupos,TmpSccr.moedas,TmpSccr.saldos)
	lStrQuery = [Select a.Grupods, a.Contads, a.GrupoOs, a.ContaOs, a.EmpdopNums, c.emps, c.dopes, c.numes, ]+;
				[From SigMvCab a, SigMvPar c Where a.Contads = ']+lcCdConta+[' ]+;
	 			[Select a.Grupods, a.Contads, a.GrupoOs, a.ContaOs, a.EmpdopNums, c.emps, c.dopes, c.numes, ]+;
				[From SigMvCab a, SigMvPar c Where a.Contaos = ']+lcCdConta+[' ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'crTmpPar2') < 1
	Select a.*, b.COpers, d.infos from CrTmpPar2 a, CrtmpOpe b, CrTmpFpag d ;
	Select crTmpPar
			lStrQuery = [Select umovs From SigChe ]+;
			If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpChe') < 1
			=Seek( TmpChe.UMovs, "crSigCdOpt", "Operacaos" ) 
			Insert Into TmpPar ( Emps, Grupos, Vencs, Fpags, Valos, Moefpgs, ;
	Select Distinct(fPags) as fPags from TmpPar into cursor crTiposAux
	Select crTiposAux
		Insert into crTmpTipos Values(1,crTiposAux.fPags)
		lStrQuery = [Select Distinct dopes From SigMvCab Where (contads = ']+lcCdConta+[' Or ContaOs = ']+lcCdConta+[') And ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CsOpeUsadas')
			Select CsOpeUsadas
	lStrQuery = [Select a.*, b.Devolvidos From SigChe a, SigCqChm c, SigCdOpt b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpChe') < 1
	Select TmpChe
		Insert Into DbAberto ( Grupos, Vencs, Bancos, Agencias, NContas, NCheques, Valors, Nums, Devolvidos ) ;
			Select TmpCheH
				Insert Into DbFollow (Nums, Datas, Hists ) Values ;
	lStrQuery = [Select a.vencs,a.bancos,a.agencias,a.ncontas,a.ncheques,a.valors,a.nums,a.grclis,a.grclis As grupos ]+;
				[From SigChe a, SigCqChm b, SigCdOpt c ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpDevolvidos')
	Select TmpDevolvidos
		If Seek(lcCheque,'dbDevolvido','Cheque')
			Select TmpDevolvidos
			Insert Into dbDevolvido From MemVar
	lcQuery = [Select a.Grupos, a.titulos, a.vencs, a.valors, a.valpags, a.moedas, a.Hist2s as Hists, ]+;
			  [(a.Valors - a.ValPags) as Saldos From SigMvCcr a, SigOpOpe b ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpTit')
	Select DbTitulo
	Append From Dbf('TmpTit')
	Select CrSigCdGcr
	=Seek(CrSigCdPam.grpadclis,'CrSigCdGcr','Codigos')
		Select CrSigCdCot
		Select crSigClLcr
		If Seek(_MoeLim,'CrSigCdCot')
				If Seek(CrSigClLcr.moedas,'CrSigCdCot')
		lStrQuery = [Select grupos, moedas, saldos From SigMvSlc Where Grupos = ']+_Grupo+[' And Contas=']+_Conta+[']
		lnQueryOk = ThisForm.podataMgr.SqlExecute(lStrQuery, 'TmpSccr')
		Select TmpSccr
			If Seek(TmpSccr.moedas,'CrSigCdCot')
		Select TmpTit
			If Seek( Moedas, 'crSigCdCot' )
		lStrQuery = [Select grclis, iclis, valors, fpags, vencs, Umovs From SigChe ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpChe')
		Select a.grclis, a.iclis, a.valors, a.fpags, Nvl(a.vencs,Ctod(Space(8))) As vencs, b.devolvidos ;
		From TmpChe a, CrSigCdOpt b ;
		Select Cheques
				=Seek(Cheques.fpags,'CrSigOpFp','FPags')
		lcQuery = [Select a.Cpros, Sum(a.Sqtds) as Qtds From SigMvEst a, SigCdGcr b ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEst') < 1)
		Select TmpEst 
	Select dbDevolvido 
	Select dbAberto
			Select(cFile)
	Select CrSigCdCli
	Select crSigClLcr
	Select dbProduto
Select TmpPar
lnOldSel = Select()
	lcQuery = [Select Iclis,Rclis,Cpfs From SigCdCli Where Iclis = '] + pcConta + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [csOpenC]) < 1)
Select(lnOldSel)
lnOldSel = Select()
lcQuery = [Select iclis,rclis,cpfs,convert(char(10),nascs,23)+'T00:00:00-03:00' as nascs,emails,ddds,tel1s From SigCdCli Where Iclis = '] + cConta + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [csOpenCli]) < 1)
Select csOpenCli
Select(lnOldSel)
Select dbSaldo
Select dbHistorico
Select dbAberto
Select dbDevolvido
Select dbProduto
Select dbProdTodos
Select dbEstoque
Select dbConserto
Select TmpPar
Select TmpCart
lcQuery = [Select TpInstalas, EmpMasters, GrupoJuros, ContaJuros, GrupoRecs, ContaRecs, GrupoPags, ContaPags, DiaPrors, GrPadClis ] + ;
		    [From SigCdPam]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPam]) < 1)
lcQuery = [Select * From SigCdPac]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPac]) < 1)
lcQuery = [Select Codigos, Descrs From SigCdGcr]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CrSigCdGcr]) < 1)
Select crSigCdGcr
lcQueryTmpd  = [Select * From SigTempC Where CidQuerys = ?CidChav ]
lStrQuery = [Select dopes,nivels,valpends,copers,parcs,baixasns,bxparcials,bxautos,oppends,vendas,casas,valpres,]+;
			[From SigCdOpe ]
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrSigCdOpe')
Select CrSigCdOpe
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select operacaos, devolvidos, tipos From SigCdOpt ],'CrSigCdOpt')
Select CrSigCdOpt
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select fpags, valpends, infos From SigOpFp ],'CrSigOpFp')
Select CrSigOpFp
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdCot ],'CrSigCdCot')
Select CrSigCdCot
Select CrSigCdPam
	.Column1.ControlSource = 'CrSigClLcr.grupos'
	.Column2.ControlSource = 'CrSigClLcr.limcres'
	.Column3.ControlSource = 'CrSigClLcr.moedas'
	.Column1.ControlSource      = 'dbProduto.cpros'
	.Column2.ControlSource      = 'dbProduto.qtds'
	.Column3.ControlSource      = 'dbProduto.opers'
	.Column4.ControlSource      = 'dbProduto.emps'
	.Column5.ControlSource      = 'dbProduto.dopes'
	.Column6.ControlSource      = 'dbProduto.mascnum'
	.Column7.ControlSource      = 'dbProduto.datas'
	.Column8.ControlSource      = 'dbProduto.totas'
	.Column9.ControlSource      = 'dbProduto.origtotas'
	.Column10.ControlSource     = 'dbProduto.bastotas'
	.Column11.ControlSource     = 'dbProduto.pesos'
	.Column12.ControlSource     = 'dbProduto.notas'
	.Column13.ControlSource     = 'dbProduto.codtams'
	.DeleteMark        = .f.
			Select CqSigCdCli
			lStrQuery = [Select rclis, iclis, cpfs, conjuges, Inativas From SigCdCli Where rclis Like ?lcDescricao Order By rclis]
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CqSigCdCli')
			Select CqSigCdCli
		Select CqSigCdCli
		Select CqSigCdCli
	lStrQuery = [Select conjuges, tel1s, grupos, iclis, rclis, cpfs From SigCdCli Where conjuges Like ?lcConj Order By conjuges ]
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpConj')
	Select TmpConj
		If !Seek(Alltrim(This.Value)) Or Alltrim(This.Value) <> Alltrim(TmpConj.conjuges)
		Select TmpConj
	lStrQuery = [Select tel1s, Conjuges, grupos, iclis, rclis, cpfs From SigCdCli Where tel1s Like ?lcTel Order By tel1s ]
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpTel')
	Select TmpTel
		If !Seek(Alltrim(This.Value)) Or Alltrim(This.Value) <> Alltrim(TmpTel.tel1s)
		Select TmpTel
	Select dbEstoque
Select dbHistorico
Select dbSaldo
Select DbAberto
Select DbDevolvido
Select DbTitulo
Select DbFollow
Select DbAberto
Select &lcCur.
		lcQuery = [Select * ] + ;
				    [From SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crEst]) < 1)
		Select crEst
			lcQuery = [Select * ] + ;
					    [From SigMvCab ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crEst]) < 1)
			Select crEst
lnQueryOk = ThisForm.podataMgr.SqlExecute([Select cpros,dpros,colecoes,reffs,figjpgs From SigCdPro ]+;
Select TmpPro
Select TmpPro
Select dbProdTodos
	lStrQuery = [Select cpros, dpros From SigCdPro Where cpros = ']+dbProdTodos.cpros+[' ]
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpPro')
	Select TmpPro
				Select dbProdTodos
				lcquery = [ select codtams from SigMvIts ]+;
				If ThisForm.Podatamgr.Sqlexecute(lcquery,'CsTmpItn') < 1
					Insert Into dbProduto From MemVar
					If Seek(Substr(Dtos(dbProdTodos.Datas), 1, 6) + dbProdTodos.Moedas, [dbTotVendas], [MesAnos])
						Insert Into dbTotVendas (MesAnos, Meses, Anos, Moedas, Totals, VrMovs) ;
					If Seek('999999' + dbProdTodos.Moedas, [dbTotVendas], [MesAnos])
						Insert Into dbTotVendas (MesAnos, Meses, Anos, Moedas, Totals, VrMovs) ;
				lcSql = [Select Empos From SigOpEtq Where Cbars = ]+Str(dbProduto.CodBarras)
				If ThisForm.Podatamgr.Sqlexecute(lcsql,'CqSigOpEtq') < 1
		Delete From dbProdTodos Where Empty(Notas)
	Select dbProdTodos
Select dbTotVendas
Select dbProduto
Select dbProduto
Select dbProduto
Select dbProduto
Select dbProduto
Select dbProduto
Select dbProduto
Select dbProduto
Select dbProduto
lStrQuery = [Select A.emps, A.dopes, A.numes, A.datas, A.valos, A.Notas, ]+;
			[From SigMvCab A, SigCdOpe B ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TprMvCab')
Select TprMvCab
	Insert Into dbOperac From MemVar
Update dbOperac; 	
	Select dbProdTodos
			Select dbProdTodos
				Insert Into dbProduto From MemVar
				If Seek(Substr(Dtos(dbProdTodos.Datas), 1, 6) + dbProdTodos.Moedas, [dbTotVendas], [MesAnos])
					Insert Into dbTotVendas (MesAnos, Meses, Anos, Moedas, Totals, VrMovs) ;
				If Seek('999999' + dbProdTodos.Moedas, [dbTotVendas], [MesAnos])
					Insert Into dbTotVendas (MesAnos, Meses, Anos, Moedas, Totals, VrMovs) ;
	Select dbTotVendas
	Select dbProduto
		Delete From dbProduto Where Empty(Notas)
	Select dbProduto
lcQuery = [Select Replace(Replace(Replace(Cpfs,'.',''),'-',''),'/','') as Cpfs From SigCdCli Where Iclis = ']+lcCli+[']
If ThisForm.Podatamgr.SqlExecute(lcQuery,[TmpCli]) < 1
Select TmpCli
Select dbEstoque
	lcSql = [Select EmpDopNums From SigMvCab where EmpdopNums = ']+lcEDNs+[']
	If Thisform.Podatamgr.Sqlexecute(lcSql,'LocalEest') > 0 And Reccount('LocalEest') > 0
Select TmpPar
	Select tmppar
	Insert Into crImpPend From MemVar
	Select TmpPar
		Insert Into crImpPend From MemVar
		Select CrISigMvItn
				Insert Into crImpPend From MemVar
			Delete In crImpPend for EmpDopNums = CrISigMvCab.EmpDopNums
			Insert Into crImpPend (tipo,dopes) values (3,m.dopes)
	Select Sum(Totas) as TotGeral , Dopes, 4 as Tipo from crImpPend Group by Dopes Where Dopes <> ' ' into cursor crTotDope
	Select crImpPend 
	Append From Dbf('crTotDope')
	Select crTotDope
	Insert Into crImpPend From MemVar	
	Select crImpPend
Select crTmpTipos
	Select crTmpTipos
Select dbOpera
	Insert Into crImpPend From MemVar
	Select dbConsertoP
			Insert Into crImpPend From MemVar
			Select CrISigMvItn
					Insert Into crImpPend From MemVar	 		
				Delete In crImpPend for EmpDopNums = CrISigMvCab.EmpDopNums
				Insert Into crImpPend (tipo,dopes) values (3,m.dopes)
	Select Sum(Totas) as TotGeral , Dopes, 4 as Tipo ;
			from crImpPend ;
	Select crImpPend 
	Append From Dbf('crTotDope')
	Select crTotDope
	Insert Into crImpPend From MemVar	
	Select crImpPend
	Select dbConsertoP
Select dbOpera
Select dbProduc
Select dbItens
	Select DbProduc
	Select DbProduc
Select DbOpera
Select DbConserto
Select DbProduc
Select dbProduc
Select dbConserto
lcQueryCli   = [Select * From SigCdCli Where Iclis = ?lcCliente ]
lcQuery = [Select * From SigCdCli Where Iclis = '] + lcCliente + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCli]) < 1)
Select crSigCdCli
lcQuery = [Select * From SigCqChm Where Nums = '] + lcNum + [' Order By Nums, Dtsis Desc]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCqChm]) < 1)
Select crSigCqChm
lcQuery = [Select * From SigChea Where Nums = '] + lcNum + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigChea]) < 1)
Select crSigChea
	.Column1.ControlSource = "CrSigCqChm.Codigos"
	.Column2.ControlSource = "CrSigCqChm.Nalineas"
	.Column3.ControlSource = "CrSigCqChm.dtents"
	.Column4.ControlSource = "CrSigCqChm.gruorigs"
	.Column5.ControlSource = "CrSigCqChm.conorigs"
	.Column6.ControlSource = "CrSigCqChm.grupos"
	.Column7.ControlSource = "CrSigCqChm.contas"
	.Column8.ControlSource = "CrSigCqChm.Numlotes"
	.Column9.ControlSource = "CrSigCqChm.protocolos"
	.Column1.ControlSource = "ttod(CrSigChea.Vencs)"
	Select CrSigCheH
Select crSigChe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg) - TRECHOS RELEVANTES PARA PASS SQL (6247 linhas total):

*-- Linhas 75 a 93:
75: *   aba 10 Credito    : transcricao de mativacredito() - grade de lancamentos
76: *                      de SigFiCp pelo CPF/CGC pesquisado (normalizado para a
77: *                      mascara que a coluna Ccpfs grava), com os paineis de
78: *                      banco/valor/documento ligados por ControlSource direto
79: *                      (a troca de linha atualiza os campos sem codigo extra,
80: *                      igual ao legado) e o rotulo de situacao do cliente
81: *                      (SigCdCli.Situas + SigCdCst.Descrs).
82: *
83: * FASE 7/8 - Eventos principais dos botoes. Este form eh OPERACIONAL de
84: * CONSULTA: o legado herda de `form` (nao de `frmcadastro`), entao os
85: * "eventos principais" reais sao os botoes das fases 3/4 (Cadastro /
86: * Movimento / Voltar / MudaCli / MudaMov) mais, nesta fase:
87: *
88: *   BtnAlterarClick / BtnVisualizarClick : as duas pontas reais do
89: *       IIF(fChecaAcesso('SIGOPCGV','ALTERAR'), 'ALTERAR', 'CONSULTAR') do
90: *       cmd_cadastro.Click legado, num funil unico (AbrirVisaoCadastral):
91: *       mesma validacao de conta, mesma visao cadastral - muda so o modo
92: *       guardado no BO, que eh o que decide se a tela grava.
93: *   BtnIncluirClick / BtnExcluirClick : o legado NAO inclui nem exclui conta

*-- Linhas 274 a 292:
274:                 THIS.this_oBusinessObject.this_cCpf    = THIS.this_cCpfInicial
275: 
276:                 *-- Cursores locais da aba Saldo (dbSaldo/dbHistorico) tem de
277:                 *-- existir ANTES dos grids que os referenciam no ControlSource
278:                 THIS.this_oBusinessObject.CriarCursoresLocais()
279: 
280:                 THIS.ConfigurarPageFrame()
281: 
282:                 THIS.pgf_4c_Paginas.Visible = .T.
283: 
284:                 *-- Entra pelo funil de troca de pagina (regra #40): eh ele que
285:                 *-- repoe o modo e a altura do form (o Init legado abre a tela
286:                 *-- com Height = 300, so a pagina Consulta a vista)
287:                 THIS.AlternarPagina(1)
288: 
289:                 loc_lSucesso = .T.
290:             ENDIF
291: 
292:         CATCH TO loc_oErro

*-- Linhas 878 a 896:
878: 
879:             IF loc_lTemCursor
880:                 IF RECCOUNT(par_cCursor) = 1
881:                     SELECT (par_cCursor)
882:                     GO TOP
883:                     loc_cConta = ALLTRIM(Iclis)
884:                     IF THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
885:                         THIS.AtualizarCamposOrigem()
886:                     ENDIF
887:                 ELSE
888:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
889:                     IF VARTYPE(loc_oBusca) = "O"
890:                         loc_oBusca.DefinirCursor(par_cCursor, "Iclis", "Rclis", par_cTitulo)
891:                         IF loc_oBusca.Mostrar()
892:                             loc_cConta = loc_oBusca.cCodigoSelecionado
893:                             IF !EMPTY(loc_cConta) AND THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
894:                                 THIS.AtualizarCamposOrigem()
895:                             ENDIF
896:                         ENDIF

*-- Linhas 1322 a 1379:
1322:             .Width         = 721
1323:             .Height        = 292
1324:             .FontName      = "Courier New"
1325:             .DeleteMark    = .F.
1326:             .RecordMark    = .F.
1327:             .ReadOnly      = .T.
1328:             .ScrollBars    = 2
1329:             .RecordSource  = "dbHistorico"
1330:             .ColumnCount   = 6
1331:             .Themes        = .F.
1332:             .Visible       = .T.
1333: 
1334:             .Columns(1).ControlSource      = "dbHistorico.emps"
1335:             .Columns(1).Header1.Caption    = "Emp"
1336:             .Columns(1).Width              = 31
1337:             .Columns(1).ReadOnly           = .T.
1338: 
1339:             .Columns(2).ControlSource      = "dbHistorico.datas"
1340:             .Columns(2).Header1.Caption    = "Data"
1341:             .Columns(2).Width              = 80
1342:             .Columns(2).ReadOnly           = .T.
1343: 
1344:             .Columns(3).ControlSource      = "dbHistorico.valors"
1345:             .Columns(3).Header1.Caption    = "Valor"
1346:             .Columns(3).Width              = 94
1347:             .Columns(3).Format             = "9,999,999.99"
1348:             .Columns(3).InputMask          = "9,999,999.99"
1349:             .Columns(3).ReadOnly           = .T.
1350: 
1351:             .Columns(4).ControlSource      = "dbHistorico.opers"
1352:             .Columns(4).Header1.Caption    = "O"
1353:             .Columns(4).Width              = 18
1354:             .Columns(4).ReadOnly           = .T.
1355: 
1356:             .Columns(5).ControlSource      = "dbHistorico.saldos"
1357:             .Columns(5).Header1.Caption    = "Saldo"
1358:             .Columns(5).Width              = 94
1359:             .Columns(5).Alignment          = 3
1360:             .Columns(5).Format             = "9,999,999.99"
1361:             .Columns(5).InputMask          = "9,999,999.99"
1362:             .Columns(5).ReadOnly           = .T.
1363: 
1364:             .Columns(6).ControlSource      = "dbHistorico.hists"
1365:             .Columns(6).Header1.Caption    = "Hist" + CHR(243) + "rico"
1366:             .Columns(6).Width              = 376
1367:             .Columns(6).ReadOnly           = .T.
1368:         ENDWITH
1369: 
1370:         loc_oPg.AddObject("lbl_4c_Saldo", "Label")
1371:         WITH loc_oPg.lbl_4c_Saldo
1372:             .Top       = 251
1373:             .Left      = 747
1374:             .Width     = 150
1375:             .Height    = 15
1376:             .Alignment = 0
1377:             .FontSize  = 8
1378:             .BackStyle = 0
1379:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1388 a 1427:
1388:             .Width        = 242
1389:             .Height       = 131
1390:             .FontName     = "Courier New"
1391:             .DeleteMark   = .F.
1392:             .RecordMark   = .F.
1393:             .ReadOnly     = .T.
1394:             .ScrollBars   = 2
1395:             .RecordSource = "dbSaldo"
1396:             .ColumnCount  = 3
1397:             .Themes       = .F.
1398:             .Visible      = .T.
1399: 
1400:             .Columns(1).ControlSource   = "dbSaldo.moedas"
1401:             .Columns(1).Header1.Caption = "Moe"
1402:             .Columns(1).Width           = 70
1403:             .Columns(1).ReadOnly        = .T.
1404: 
1405:             .Columns(2).ControlSource   = "dbSaldo.saldos"
1406:             .Columns(2).Header1.Caption = "Saldo"
1407:             .Columns(2).Width           = 86
1408:             .Columns(2).Format          = "9,999,999.99"
1409:             .Columns(2).InputMask       = "9,999,999.99"
1410:             .Columns(2).ReadOnly        = .T.
1411: 
1412:             .Columns(3).ControlSource   = "dbSaldo.SaldoConta"
1413:             .Columns(3).Header1.Caption = "Dispon" + CHR(237) + "vel"
1414:             .Columns(3).Width           = 86
1415:             .Columns(3).Format          = "9,999,999.99"
1416:             .Columns(3).InputMask       = "9,999,999.99"
1417:             .Columns(3).ReadOnly        = .T.
1418:         ENDWITH
1419: 
1420:         loc_oPg.grd_4c_Historico.Refresh()
1421:         loc_oPg.grd_4c_Saldo.Refresh()
1422:     ENDPROC
1423: 
1424:     *==========================================================================
1425:     * ConfigurarNavegacaoResultado - OptionGroup de navegacao entre as 10 abas
1426:     * da pagina Resultado (Optiongroup1 do legado, Top = 12 / Left = 44 /
1427:     * 760x85, 10 botoes graficos de 75x75 lado a lado).

*-- Linhas 2720 a 2742:
2720:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1
2721: 
2722:                 IF USED("dbHistorico")
2723:                     SELECT dbHistorico
2724:                     GO TOP
2725:                 ENDIF
2726:                 IF USED("dbSaldo")
2727:                     SELECT dbSaldo
2728:                     GO TOP
2729:                 ENDIF
2730: 
2731:                 IF PEMSTATUS(loc_oAba, "grd_4c_Historico", 5)
2732:                     loc_oAba.grd_4c_Historico.Refresh()
2733:                 ENDIF
2734:                 IF PEMSTATUS(loc_oAba, "grd_4c_Saldo", 5)
2735:                     loc_oAba.grd_4c_Saldo.Refresh()
2736:                 ENDIF
2737:             ENDIF
2738:         CATCH TO loc_oErro
2739:             MsgErro(loc_oErro.Message + CHR(13) + ;
2740:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2741:                 "Erro ao atualizar as grades de saldo")
2742:         ENDTRY

*-- Linhas 3008 a 3093:
3008:             .Height            = 346
3009:             .AllowHeaderSizing = .F.
3010:             .AllowRowSizing    = .F.
3011:             .DeleteMark        = .F.
3012:             .RecordMark        = .F.
3013:             .ReadOnly          = .T.
3014:             .ScrollBars        = 2
3015:             .RecordSource      = "TmpPar"
3016:             .ColumnCount       = 6
3017:             .Themes            = .F.
3018:             .Visible           = .T.
3019: 
3020:             *-- ColumnOrder 1 - vencimento (o legado nao sobrepoe a largura)
3021:             .Columns(1).ControlSource   = "TmpPar.vencs"
3022:             .Columns(1).Header1.Caption = "Vecto"
3023:             .Columns(1).Movable         = .F.
3024:             .Columns(1).Resizable       = .F.
3025:             .Columns(1).ReadOnly        = .T.
3026: 
3027:             *-- ColumnOrder 2 - natureza do lancamento (sem cabecalho no legado)
3028:             .Columns(2).ControlSource   = "TmpPar.Opers"
3029:             .Columns(2).Header1.Caption = ""
3030:             .Columns(2).Width           = 19
3031:             .Columns(2).Movable         = .F.
3032:             .Columns(2).Resizable       = .F.
3033:             .Columns(2).ReadOnly        = .T.
3034: 
3035:             .Columns(3).ControlSource   = "TmpPar.Valos"
3036:             .Columns(3).Header1.Caption = "Valor"
3037:             .Columns(3).Width           = 77
3038:             .Columns(3).Movable         = .F.
3039:             .Columns(3).Resizable       = .F.
3040:             .Columns(3).ReadOnly        = .T.
3041: 
3042:             .Columns(4).ControlSource   = "TmpPar.Moefpgs"
3043:             .Columns(4).Header1.Caption = "Moe"
3044:             .Columns(4).Width           = 30
3045:             .Columns(4).Movable         = .F.
3046:             .Columns(4).Resizable       = .F.
3047:             .Columns(4).ReadOnly        = .T.
3048: 
3049:             .Columns(5).ControlSource   = "TmpPar.FPags"
3050:             .Columns(5).Header1.Caption = "Tipo"
3051:             .Columns(5).Width           = 100
3052:             .Columns(5).Movable         = .F.
3053:             .Columns(5).Resizable       = .F.
3054:             .Columns(5).ReadOnly        = .T.
3055: 
3056:             .Columns(6).ControlSource   = "TmpPar.Hists"
3057:             .Columns(6).Header1.Caption = "Hist" + CHR(243) + "rico"
3058:             .Columns(6).Width           = 360
3059:             .Columns(6).Movable         = .F.
3060:             .Columns(6).Resizable       = .F.
3061:             .Columns(6).ReadOnly        = .T.
3062:         ENDWITH
3063: 
3064:         *-- Grade das formas de pagamento marcaveis (crTmpTipos). A coluna 1 eh
3065:         *-- um CheckBox de verdade: Column.AddObject sozinho NAO exibe o
3066:         *-- controle - precisa de CurrentControl, e de Sparse = .F. para
3067:         *-- aparecer em TODAS as linhas (regra #18)
3068:         loc_oPg.AddObject("grd_4c_TiposPend", "Grid")
3069:         loc_oGrid = loc_oPg.grd_4c_TiposPend
3070:         WITH loc_oGrid
3071:             .Top               = 59
3072:             .Left              = 812
3073:             .Width             = 133
3074:             .Height            = 105
3075:             .FontSize          = 8
3076:             .AllowHeaderSizing = .F.
3077:             .AllowRowSizing    = .F.
3078:             .DeleteMark        = .F.
3079:             .RecordMark        = .F.
3080:             .RowHeight         = 17
3081:             .ScrollBars        = 2
3082:             .ReadOnly          = .F.
3083:             .RecordSource      = "crTmpTipos"
3084:             .ColumnCount       = 2
3085:             .Themes            = .F.
3086:             .Visible           = .T.
3087:         ENDWITH
3088: 
3089:         loc_oGrid.Columns(1).AddObject("chk_4c_TipoPend", "CheckBox")
3090:         WITH loc_oGrid.Columns(1).chk_4c_TipoPend
3091:             .Top       = 9
3092:             .Left      = 2
3093:             .Width     = 22

*-- Linhas 3104 a 3130:
3104:         WITH loc_oGrid
3105:             .Columns(1).CurrentControl   = "chk_4c_TipoPend"
3106:             .Columns(1).Sparse           = .F.
3107:             .Columns(1).ControlSource    = "crTmpTipos.Listas"
3108:             .Columns(1).Header1.Caption  = ""
3109:             .Columns(1).Width            = 15
3110:             .Columns(1).Movable          = .F.
3111:             .Columns(1).Resizable        = .F.
3112:             *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga)
3113:             .Columns(1).ReadOnly         = .F.
3114: 
3115:             .Columns(2).ControlSource    = "crTmpTipos.fPags"
3116:             .Columns(2).Header1.Caption  = "Tipos"
3117:             .Columns(2).Width            = 95
3118:             .Columns(2).FontName         = "Arial"
3119:             .Columns(2).FontSize         = 8
3120:             .Columns(2).Movable          = .F.
3121:             .Columns(2).Resizable        = .F.
3122:             .Columns(2).ReadOnly         = .T.
3123:         ENDWITH
3124: 
3125:         *-- CheckBox de grade nao alterna pelo binding nativo: os quatro
3126:         *-- handlers (Click/MouseDown suprimem o toggle padrao, MouseUp e
3127:         *-- KeyPress alternam por codigo) sao obrigatorios
3128:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "Click", ;
3129:             THIS, "ChkTipoPendClick")
3130:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseDown", ;

*-- Linhas 3316 a 3513:
3316:             .Width        = 471
3317:             .Height       = 86
3318:             .FontName     = "Courier New"
3319:             .DeleteMark   = .F.
3320:             .RecordMark   = .F.
3321:             .ReadOnly     = .T.
3322:             .Highlight    = .T.
3323:             .HighlightRow = .T.
3324:             .RowHeight    = 16
3325:             .ScrollBars   = 2
3326:             .RecordSource = "dbAberto"
3327:             .ColumnCount  = 6
3328:             .Themes       = .F.
3329:             .Visible      = .T.
3330: 
3331:             .Columns(1).ControlSource   = "dbAberto.vencs"
3332:             .Columns(1).Header1.Caption = "Vencimento"
3333:             .Columns(1).Width           = 80
3334:             .Columns(1).ReadOnly        = .T.
3335: 
3336:             .Columns(2).ControlSource   = "dbAberto.bancos"
3337:             .Columns(2).Header1.Caption = "Bco."
3338:             .Columns(2).Width           = 38
3339:             .Columns(2).Alignment       = 1
3340:             .Columns(2).ReadOnly        = .T.
3341: 
3342:             .Columns(3).ControlSource   = "dbAberto.agencias"
3343:             .Columns(3).Header1.Caption = "Ag."
3344:             .Columns(3).Width           = 45
3345:             .Columns(3).Alignment       = 1
3346:             .Columns(3).ReadOnly        = .T.
3347: 
3348:             .Columns(4).ControlSource   = "dbAberto.ncontas"
3349:             .Columns(4).Header1.Caption = "Conta"
3350:             .Columns(4).Width           = 100
3351:             .Columns(4).ReadOnly        = .T.
3352: 
3353:             .Columns(5).ControlSource   = "dbAberto.ncheques"
3354:             .Columns(5).Header1.Caption = "Cheque"
3355:             .Columns(5).Width           = 65
3356:             .Columns(5).Alignment       = 1
3357:             .Columns(5).ReadOnly        = .T.
3358: 
3359:             .Columns(6).ControlSource   = "dbAberto.valors"
3360:             .Columns(6).Header1.Caption = "Valor"
3361:             .Columns(6).Width           = 115
3362:             .Columns(6).ReadOnly        = .T.
3363:         ENDWITH
3364: 
3365:         *-- Follow-up do cheque corrente (DbFollow)
3366:         loc_oPg.AddObject("grd_4c_ChequeFollowup", "Grid")
3367:         loc_oGrid = loc_oPg.grd_4c_ChequeFollowup
3368:         WITH loc_oGrid
3369:             .Top          = 79
3370:             .Left         = 499
3371:             .Width        = 471
3372:             .Height       = 86
3373:             .FontName     = "Courier New"
3374:             .DeleteMark   = .F.
3375:             .RecordMark   = .F.
3376:             .ReadOnly     = .T.
3377:             .Highlight    = .T.
3378:             .HighlightRow = .T.
3379:             .RowHeight    = 16
3380:             .ScrollBars   = 2
3381:             .RecordSource = "DbFollow"
3382:             .ColumnCount  = 2
3383:             .Themes       = .F.
3384:             .Visible      = .T.
3385: 
3386:             .Columns(1).ControlSource   = "DbFollow.Datas"
3387:             .Columns(1).Header1.Caption = "Data"
3388:             .Columns(1).Width           = 78
3389:             .Columns(1).ReadOnly        = .T.
3390: 
3391:             .Columns(2).ControlSource   = "DbFollow.Hists"
3392:             .Columns(2).Header1.Caption = "Hist" + CHR(243) + "rico"
3393:             .Columns(2).Width           = 370
3394:             .Columns(2).ReadOnly        = .T.
3395:         ENDWITH
3396: 
3397:         *-- Cheques negociados / titulos (DbTitulo)
3398:         loc_oPg.AddObject("grd_4c_ChequeTitulo", "Grid")
3399:         loc_oGrid = loc_oPg.grd_4c_ChequeTitulo
3400:         WITH loc_oGrid
3401:             .Top          = 219
3402:             .Left         = 11
3403:             .Width        = 471
3404:             .Height       = 86
3405:             .FontName     = "Courier New"
3406:             .DeleteMark   = .F.
3407:             .RecordMark   = .F.
3408:             .ReadOnly     = .T.
3409:             .Highlight    = .T.
3410:             .HighlightRow = .T.
3411:             .RowHeight    = 16
3412:             .ScrollBars   = 2
3413:             .RecordSource = "DbTitulo"
3414:             .ColumnCount  = 6
3415:             .Themes       = .F.
3416:             .Visible      = .T.
3417: 
3418:             .Columns(1).ControlSource   = "DbTitulo.Titulos"
3419:             .Columns(1).Header1.Caption = "Titulo"
3420:             .Columns(1).Width           = 80
3421:             .Columns(1).ReadOnly        = .T.
3422: 
3423:             .Columns(2).ControlSource   = "DbTitulo.Vencs"
3424:             .Columns(2).Header1.Caption = "Vencto"
3425:             .Columns(2).Width           = 80
3426:             .Columns(2).ReadOnly        = .T.
3427: 
3428:             .Columns(3).ControlSource   = "DbTitulo.Valors"
3429:             .Columns(3).Header1.Caption = "Valor"
3430:             .Columns(3).Width           = 85
3431:             .Columns(3).ReadOnly        = .T.
3432: 
3433:             .Columns(4).ControlSource   = "DbTitulo.ValPags"
3434:             .Columns(4).Header1.Caption = "V.Pago"
3435:             .Columns(4).Width           = 85
3436:             .Columns(4).ReadOnly        = .T.
3437: 
3438:             .Columns(5).ControlSource   = "DbTitulo.Saldos"
3439:             .Columns(5).Header1.Caption = "Saldo"
3440:             .Columns(5).Width           = 80
3441:             .Columns(5).ReadOnly        = .T.
3442: 
3443:             .Columns(6).ControlSource   = "DbTitulo.Moedas"
3444:             .Columns(6).Header1.Caption = "Moe"
3445:             .Columns(6).Width           = 28
3446:             .Columns(6).ReadOnly        = .T.
3447:         ENDWITH
3448: 
3449:         *-- Historico de cheques devolvidos (dbDevolvido)
3450:         loc_oPg.AddObject("grd_4c_ChequeDevolvido", "Grid")
3451:         loc_oGrid = loc_oPg.grd_4c_ChequeDevolvido
3452:         WITH loc_oGrid
3453:             .Top          = 220
3454:             .Left         = 499
3455:             .Width        = 386
3456:             .Height       = 86
3457:             .FontName     = "Courier New"
3458:             .DeleteMark   = .F.
3459:             .RecordMark   = .F.
3460:             .ReadOnly     = .T.
3461:             .Highlight    = .T.
3462:             .HighlightRow = .T.
3463:             .RowHeight    = 16
3464:             .ScrollBars   = 2
3465:             .RecordSource = "dbDevolvido"
3466:             .ColumnCount  = 6
3467:             .Themes       = .F.
3468:             .Visible      = .T.
3469: 
3470:             .Columns(1).ControlSource   = "dbDevolvido.vencs"
3471:             .Columns(1).Header1.Caption = "Vencimento"
3472:             .Columns(1).Width           = 80
3473:             .Columns(1).ReadOnly        = .T.
3474: 
3475:             .Columns(2).ControlSource   = "dbDevolvido.bancos"
3476:             .Columns(2).Header1.Caption = "Bco."
3477:             .Columns(2).Width           = 31
3478:             .Columns(2).Alignment       = 1
3479:             .Columns(2).ReadOnly        = .T.
3480: 
3481:             .Columns(3).ControlSource   = "dbDevolvido.agencias"
3482:             .Columns(3).Header1.Caption = "Ag."
3483:             .Columns(3).Width           = 38
3484:             .Columns(3).Alignment       = 1
3485:             .Columns(3).ReadOnly        = .T.
3486: 
3487:             .Columns(4).ControlSource   = "dbDevolvido.ncontas"
3488:             .Columns(4).Header1.Caption = "Conta"
3489:             .Columns(4).Width           = 80
3490:             .Columns(4).ReadOnly        = .T.
3491: 
3492:             .Columns(5).ControlSource   = "dbDevolvido.ncheques"
3493:             .Columns(5).Header1.Caption = "Cheque"
3494:             .Columns(5).Width           = 52
3495:             .Columns(5).Alignment       = 1
3496:             .Columns(5).ReadOnly        = .T.
3497: 
3498:             .Columns(6).ControlSource   = "dbDevolvido.valors"
3499:             .Columns(6).Header1.Caption = "Valor"
3500:             .Columns(6).Width           = 80
3501:             .Columns(6).ReadOnly        = .T.
3502:         ENDWITH
3503: 
3504:         *-- Campos somente-leitura: total da grade de aberto, historico de
3505:         *-- devolvidos, observacao dos negociados e os oito totais do pe
3506:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_TotChequeAberto", 164, 344, 117, 23, .T.)
3507:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_TotDevolvido",    247, 890, 104, 24, .T.)
3508:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ObsNegoc1",       341,  11, 471, 23, .F.)
3509:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ObsNegoc2",       364,  11, 471, 23, .F.)
3510:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_LimiteCred",      345, 611, 115, 23, .T.)
3511:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqAVencer",      367, 611, 115, 23, .T.)
3512:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqVencidos",     389, 611, 115, 23, .T.)
3513:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqDevolv",       411, 611, 115, 23, .T.)

*-- Linhas 3546 a 3618:
3546:             .Width        = 725
3547:             .Height       = 254
3548:             .FontName     = "Courier New"
3549:             .DeleteMark   = .F.
3550:             .RecordMark   = .F.
3551:             .ReadOnly     = .T.
3552:             .Highlight    = .T.
3553:             .HighlightRow = .T.
3554:             .ScrollBars   = 2
3555:             .RecordSource = "TmpCart"
3556:             .ColumnCount  = 6
3557:             .Themes       = .F.
3558:             .Visible      = .T.
3559: 
3560:             .Columns(1).ControlSource   = "TmpCart.vencs"
3561:             .Columns(1).Header1.Caption = "Vencimento"
3562:             .Columns(1).Width           = 75
3563:             .Columns(1).Alignment       = 0
3564:             .Columns(1).ReadOnly        = .T.
3565: 
3566:             .Columns(2).ControlSource   = "TmpCart.fpags"
3567:             .Columns(2).Header1.Caption = "Cart" + CHR(227) + "o"
3568:             .Columns(2).Width           = 100
3569:             .Columns(2).Alignment       = 0
3570:             .Columns(2).ReadOnly        = .T.
3571: 
3572:             .Columns(3).ControlSource   = "TmpCart.nocreditos"
3573:             .Columns(3).Header1.Caption = "Cr" + CHR(233) + "dito"
3574:             .Columns(3).Width           = 80
3575:             .Columns(3).Alignment       = 0
3576:             .Columns(3).ReadOnly        = .T.
3577: 
3578:             .Columns(4).ControlSource   = "TmpCart.cartaos"
3579:             .Columns(4).Header1.Caption = "N" + CHR(186) + " Cart" + CHR(227) + "o"
3580:             .Columns(4).Width           = 120
3581:             .Columns(4).Alignment       = 0
3582:             .Columns(4).ReadOnly        = .T.
3583: 
3584:             .Columns(5).ControlSource   = "TmpCart.valos"
3585:             .Columns(5).Header1.Caption = "Valor"
3586:             .Columns(5).Width           = 110
3587:             .Columns(5).Alignment       = 3
3588:             .Columns(5).ReadOnly        = .T.
3589: 
3590:             .Columns(6).ControlSource   = "TmpCart.datas"
3591:             .Columns(6).Header1.Caption = "Data"
3592:             .Columns(6).Width           = 75
3593:             .Columns(6).Alignment       = 0
3594:             .Columns(6).ReadOnly        = .T.
3595:         ENDWITH
3596:     ENDPROC
3597: 
3598:     *==========================================================================
3599:     * ConfigurarAbaEstoque - Aba 6 (Result.Estoque do legado): moldura, filtro
3600:     * de grupo e a grade dos produtos em poder do cliente (dbEstoque).
3601:     *
3602:     * A terceira coluna ("Operacao") fica SEM ControlSource de proposito: no
3603:     * dump legado ela tem ControlSource = "" (literal vazio) porque dbEstoque
3604:     * nao tem coluna de operacao - eh uma coluna reservada, que o legado
3605:     * tambem mostra vazia.
3606:     *==========================================================================
3607:     PROTECTED PROCEDURE ConfigurarAbaEstoque()
3608:         LOCAL loc_oPg, loc_oGrid
3609:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6
3610: 
3611:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_EstoqueProduto", 86, 303, 392, 361)
3612: 
3613:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoEstoque", 60, 307, 41, 15, "Grupo : ")
3614: 
3615:         loc_oPg.AddObject("cbo_4c_GrupoEstoque", "ComboBox")
3616:         WITH loc_oPg.cbo_4c_GrupoEstoque
3617:             .Top           = 56
3618:             .Left          = 350

*-- Linhas 3635 a 3670:
3635:             .Width        = 381
3636:             .Height       = 347
3637:             .FontName     = "Courier New"
3638:             .DeleteMark   = .F.
3639:             .RecordMark   = .F.
3640:             .ReadOnly     = .T.
3641:             .Highlight    = .T.
3642:             .HighlightRow = .T.
3643:             .ScrollBars   = 2
3644:             .RecordSource = "dbEstoque"
3645:             .ColumnCount  = 3
3646:             .Themes       = .F.
3647:             .Visible      = .T.
3648: 
3649:             .Columns(1).ControlSource   = "dbEstoque.cpros"
3650:             .Columns(1).Header1.Caption = "Produto"
3651:             .Columns(1).Width           = 108
3652:             .Columns(1).Alignment       = 3
3653:             .Columns(1).ReadOnly        = .T.
3654: 
3655:             .Columns(2).ControlSource   = "dbEstoque.sqtds"
3656:             .Columns(2).Header1.Caption = "Qtde."
3657:             .Columns(2).Width           = 100
3658:             .Columns(2).Alignment       = 3
3659:             .Columns(2).InputMask       = "999,999,999.99"
3660:             .Columns(2).ReadOnly        = .T.
3661: 
3662:             .Columns(3).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3663:             .Columns(3).Width           = 150
3664:             .Columns(3).Alignment       = 3
3665:             .Columns(3).ReadOnly        = .T.
3666:         ENDWITH
3667: 
3668:         BINDEVENT(loc_oPg.cbo_4c_GrupoEstoque, "InteractiveChange", ;
3669:             THIS, "CboGrupoEstoqueInteractiveChange")
3670:     ENDPROC

*-- Linhas 3693 a 3774:
3693:             .Width        = 696
3694:             .Height       = 124
3695:             .FontName     = "Courier New"
3696:             .DeleteMark   = .F.
3697:             .RecordMark   = .F.
3698:             .ReadOnly     = .T.
3699:             .Highlight    = .T.
3700:             .HighlightRow = .T.
3701:             .ScrollBars   = 2
3702:             .RecordSource = "dbCheqHist"
3703:             .ColumnCount  = 11
3704:             .Themes       = .F.
3705:             .Visible      = .T.
3706: 
3707:             .Columns(1).ControlSource   = "dbCheqHist.Vencs"
3708:             .Columns(1).Header1.Caption = "Vencimento"
3709:             .Columns(1).Width           = 75
3710:             .Columns(1).ReadOnly        = .T.
3711: 
3712:             .Columns(2).ControlSource   = "dbCheqHist.Bancos"
3713:             .Columns(2).Header1.Caption = "Banco"
3714:             .Columns(2).Width           = 50
3715:             .Columns(2).ReadOnly        = .T.
3716: 
3717:             .Columns(3).ControlSource   = "dbCheqHist.Agencias"
3718:             .Columns(3).Header1.Caption = "Ag" + CHR(234) + "ncia"
3719:             .Columns(3).Width           = 55
3720:             .Columns(3).ReadOnly        = .T.
3721: 
3722:             .Columns(4).ControlSource   = "dbCheqHist.NContas"
3723:             .Columns(4).Header1.Caption = "Conta"
3724:             .Columns(4).Width           = 70
3725:             .Columns(4).ReadOnly        = .T.
3726: 
3727:             .Columns(5).ControlSource   = "dbCheqHist.NCheques"
3728:             .Columns(5).Header1.Caption = "N" + CHR(186) + "mero"
3729:             .Columns(5).Width           = 60
3730:             .Columns(5).ReadOnly        = .T.
3731: 
3732:             .Columns(6).ControlSource   = "dbCheqHist.Valors"
3733:             .Columns(6).Header1.Caption = "Valor"
3734:             .Columns(6).Width           = 75
3735:             .Columns(6).Alignment       = 3
3736:             .Columns(6).InputMask       = "999,999,999.99"
3737:             .Columns(6).ReadOnly        = .T.
3738: 
3739:             .Columns(7).ControlSource   = "dbCheqHist.GruCarts"
3740:             .Columns(7).Header1.Caption = "Grupo Carteira"
3741:             .Columns(7).Width           = 70
3742:             .Columns(7).ReadOnly        = .T.
3743: 
3744:             .Columns(8).ControlSource   = "dbCheqHist.ConCarts"
3745:             .Columns(8).Header1.Caption = "Conta Carteira"
3746:             .Columns(8).Width           = 70
3747:             .Columns(8).ReadOnly        = .T.
3748: 
3749:             .Columns(9).ControlSource   = "dbCheqHist.Emps"
3750:             .Columns(9).Header1.Caption = "Emp"
3751:             .Columns(9).Width           = 40
3752:             .Columns(9).ReadOnly        = .T.
3753: 
3754:             .Columns(10).ControlSource   = "dbCheqHist.Numeros"
3755:             .Columns(10).Header1.Caption = "Arquivo"
3756:             .Columns(10).Width           = 60
3757:             .Columns(10).ReadOnly        = .T.
3758: 
3759:             .Columns(11).ControlSource   = "dbCheqHist.DiasP"
3760:             .Columns(11).Header1.Caption = "Dias Pag."
3761:             .Columns(11).Width           = 55
3762:             .Columns(11).Alignment       = 3
3763:             .Columns(11).ReadOnly        = .T.
3764: 
3765:             *-- SetAll('DynamicForeColor'/'DynamicBackColor', ...) do legado:
3766:             *-- cheque com historico (SigCheh - Tipo nao vazio) fica azul sobre
3767:             *-- fundo verde-claro.
3768:             .SetAll("DynamicForeColor", ;
3769:                 "IIF(!EMPTY(dbCheqHist.Tipo), RGB(0,0,255), RGB(0,0,0))", "Column")
3770:             .SetAll("DynamicBackColor", ;
3771:                 "IIF(!EMPTY(dbCheqHist.Tipo), RGB(220,255,220), RGB(255,255,255))", "Column")
3772:         ENDWITH
3773: 
3774:         *-- GradeMovimenta (dbCheqMovim) - movimentacao do cheque selecionado

*-- Linhas 3780 a 3875:
3780:             .Width        = 696
3781:             .Height       = 90
3782:             .FontName     = "Courier New"
3783:             .DeleteMark   = .F.
3784:             .RecordMark   = .F.
3785:             .ReadOnly     = .T.
3786:             .Highlight    = .T.
3787:             .HighlightRow = .T.
3788:             .ScrollBars   = 2
3789:             .RecordSource = "dbCheqMovim"
3790:             .ColumnCount  = 9
3791:             .Themes       = .F.
3792:             .Visible      = .T.
3793: 
3794:             .Columns(1).ControlSource   = "dbCheqMovim.Codigos"
3795:             .Columns(1).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3796:             .Columns(1).Width           = 80
3797:             .Columns(1).ReadOnly        = .T.
3798: 
3799:             .Columns(2).ControlSource   = "dbCheqMovim.Nalineas"
3800:             .Columns(2).Header1.Caption = "Al" + CHR(237) + "nea"
3801:             .Columns(2).Width           = 60
3802:             .Columns(2).ReadOnly        = .T.
3803: 
3804:             .Columns(3).ControlSource   = "dbCheqMovim.Dtents"
3805:             .Columns(3).Header1.Caption = "Entrada"
3806:             .Columns(3).Width           = 80
3807:             .Columns(3).ReadOnly        = .T.
3808: 
3809:             .Columns(4).ControlSource   = "dbCheqMovim.Gruorigs"
3810:             .Columns(4).Header1.Caption = "Grupo/Origem"
3811:             .Columns(4).Width           = 80
3812:             .Columns(4).ReadOnly        = .T.
3813: 
3814:             .Columns(5).ControlSource   = "dbCheqMovim.Conorigs"
3815:             .Columns(5).Header1.Caption = "Conta/Origem"
3816:             .Columns(5).Width           = 80
3817:             .Columns(5).ReadOnly        = .T.
3818: 
3819:             .Columns(6).ControlSource   = "dbCheqMovim.Grupos"
3820:             .Columns(6).Header1.Caption = "Grupo/Destino"
3821:             .Columns(6).Width           = 80
3822:             .Columns(6).ReadOnly        = .T.
3823: 
3824:             .Columns(7).ControlSource   = "dbCheqMovim.Contas"
3825:             .Columns(7).Header1.Caption = "Conta/Destino"
3826:             .Columns(7).Width           = 80
3827:             .Columns(7).ReadOnly        = .T.
3828: 
3829:             .Columns(8).ControlSource   = "dbCheqMovim.Numlotes"
3830:             .Columns(8).Header1.Caption = "Lote"
3831:             .Columns(8).Width           = 70
3832:             .Columns(8).ReadOnly        = .T.
3833: 
3834:             .Columns(9).ControlSource   = "dbCheqMovim.Protocolos"
3835:             .Columns(9).Header1.Caption = "Protocolo"
3836:             .Columns(9).Width           = 86
3837:             .Columns(9).ReadOnly        = .T.
3838:         ENDWITH
3839: 
3840:         *-- GradeProrrog (dbCheqProrrog) - prorrogacoes do cheque selecionado
3841:         loc_oPg.AddObject("grd_4c_ProrrogCheque", "Grid")
3842:         loc_oGrid = loc_oPg.grd_4c_ProrrogCheque
3843:         WITH loc_oGrid
3844:             .Top          = 273
3845:             .Left         = 735
3846:             .Width        = 113
3847:             .Height       = 84
3848:             .FontName     = "Courier New"
3849:             .DeleteMark   = .F.
3850:             .RecordMark   = .F.
3851:             .ReadOnly     = .T.
3852:             .Highlight    = .T.
3853:             .HighlightRow = .T.
3854:             .ScrollBars   = 2
3855:             .RecordSource = "dbCheqProrrog"
3856:             .ColumnCount  = 1
3857:             .Themes       = .F.
3858:             .Visible      = .T.
3859: 
3860:             .Columns(1).ControlSource   = "dbCheqProrrog.Vencs"
3861:             .Columns(1).Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
3862:             .Columns(1).Width           = 108
3863:             .Columns(1).ReadOnly        = .T.
3864:         ENDWITH
3865: 
3866:         *-- Follow-up da linha corrente (Cnt_Followup.UltFollowup)
3867:         loc_oPg.AddObject("cnt_4c_Followup", "Container")
3868:         WITH loc_oPg.cnt_4c_Followup
3869:             .Top       = 273
3870:             .Left      = 151
3871:             .Width     = 561
3872:             .Height    = 43
3873:             .BackStyle = 0
3874:             .Visible   = .T.
3875:         ENDWITH

*-- Linhas 4009 a 4099:
4009:             .txt_4c_CBancos.Width         = 36
4010:             .txt_4c_CBancos.Height        = 23
4011:             .txt_4c_CBancos.Value         = ""
4012:             .txt_4c_CBancos.ControlSource = "dbCredito.Cbancos"
4013:             .txt_4c_CBancos.Visible       = .T.
4014: 
4015:             .AddObject("txt_4c_CAgencias", "TextBox")
4016:             .txt_4c_CAgencias.Top           = 13
4017:             .txt_4c_CAgencias.Left          = 47
4018:             .txt_4c_CAgencias.Width         = 38
4019:             .txt_4c_CAgencias.Height        = 23
4020:             .txt_4c_CAgencias.Value         = ""
4021:             .txt_4c_CAgencias.ControlSource = "dbCredito.Cagencias"
4022:             .txt_4c_CAgencias.Visible       = .T.
4023: 
4024:             .AddObject("txt_4c_CContas", "TextBox")
4025:             .txt_4c_CContas.Top           = 13
4026:             .txt_4c_CContas.Left          = 92
4027:             .txt_4c_CContas.Width         = 80
4028:             .txt_4c_CContas.Height        = 23
4029:             .txt_4c_CContas.Value         = ""
4030:             .txt_4c_CContas.ControlSource = "dbCredito.Ccontas"
4031:             .txt_4c_CContas.Visible       = .T.
4032: 
4033:             .AddObject("txt_4c_CCheInis", "TextBox")
4034:             .txt_4c_CCheInis.Top           = 13
4035:             .txt_4c_CCheInis.Left          = 177
4036:             .txt_4c_CCheInis.Width         = 52
4037:             .txt_4c_CCheInis.Height        = 23
4038:             .txt_4c_CCheInis.Value         = ""
4039:             .txt_4c_CCheInis.ControlSource = "dbCredito.Ccheinis"
4040:             .txt_4c_CCheInis.Visible       = .T.
4041: 
4042:             .AddObject("txt_4c_CDigInis", "TextBox")
4043:             .txt_4c_CDigInis.Top           = 13
4044:             .txt_4c_CDigInis.Left          = 240
4045:             .txt_4c_CDigInis.Width         = 17
4046:             .txt_4c_CDigInis.Height        = 23
4047:             .txt_4c_CDigInis.Value         = ""
4048:             .txt_4c_CDigInis.ControlSource = "dbCredito.Cdiginis"
4049:             .txt_4c_CDigInis.Visible       = .T.
4050: 
4051:             .AddObject("txt_4c_CCheFins", "TextBox")
4052:             .txt_4c_CCheFins.Top           = 13
4053:             .txt_4c_CCheFins.Left          = 268
4054:             .txt_4c_CCheFins.Width         = 52
4055:             .txt_4c_CCheFins.Height        = 23
4056:             .txt_4c_CCheFins.Value         = ""
4057:             .txt_4c_CCheFins.ControlSource = "dbCredito.Cchefins"
4058:             .txt_4c_CCheFins.Visible       = .T.
4059: 
4060:             .AddObject("txt_4c_CDigFins", "TextBox")
4061:             .txt_4c_CDigFins.Top           = 13
4062:             .txt_4c_CDigFins.Left          = 329
4063:             .txt_4c_CDigFins.Width         = 17
4064:             .txt_4c_CDigFins.Height        = 23
4065:             .txt_4c_CDigFins.Value         = ""
4066:             .txt_4c_CDigFins.ControlSource = "dbCredito.Cdigfins"
4067:             .txt_4c_CDigFins.Visible       = .T.
4068: 
4069:             .AddObject("txt_4c_CSeries", "TextBox")
4070:             .txt_4c_CSeries.Top           = 13
4071:             .txt_4c_CSeries.Left          = 354
4072:             .txt_4c_CSeries.Width         = 52
4073:             .txt_4c_CSeries.Height        = 23
4074:             .txt_4c_CSeries.Value         = ""
4075:             .txt_4c_CSeries.ControlSource = "dbCredito.Cseries"
4076:             .txt_4c_CSeries.Visible       = .T.
4077: 
4078:             .AddObject("txt_4c_CDAberts", "TextBox")
4079:             .txt_4c_CDAberts.Top           = 13
4080:             .txt_4c_CDAberts.Left          = 413
4081:             .txt_4c_CDAberts.Width         = 59
4082:             .txt_4c_CDAberts.Height        = 23
4083:             .txt_4c_CDAberts.Value         = ""
4084:             .txt_4c_CDAberts.ControlSource = "dbCredito.Cdaberts"
4085:             .txt_4c_CDAberts.Visible       = .T.
4086:         ENDWITH
4087: 
4088:         *-- Cnt_Valor
4089:         loc_oCns.AddObject("cnt_4c_CreditoValor", "Container")
4090:         WITH loc_oCns.cnt_4c_CreditoValor
4091:             .Top       = 230
4092:             .Left      = 170
4093:             .Width     = 372
4094:             .Height    = 40
4095:             .BackStyle = 0
4096:             .Visible   = .T.
4097:         ENDWITH
4098:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_ValorCredito", 0, 166, 39, 17, "Valor")
4099:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_DtVenc",       0, 272, 83, 15, "Data Vencimento")

*-- Linhas 4105 a 4191:
4105:             .txt_4c_NrCpf.Width         = 150
4106:             .txt_4c_NrCpf.Height        = 23
4107:             .txt_4c_NrCpf.Value         = ""
4108:             .txt_4c_NrCpf.ControlSource = "dbCredito.Ccpfs"
4109:             .txt_4c_NrCpf.Visible       = .T.
4110: 
4111:             .AddObject("txt_4c_Valor", "TextBox")
4112:             .txt_4c_Valor.Top           = 12
4113:             .txt_4c_Valor.Left          = 166
4114:             .txt_4c_Valor.Width         = 108
4115:             .txt_4c_Valor.Height        = 23
4116:             .txt_4c_Valor.Value         = 0
4117:             .txt_4c_Valor.ControlSource = "dbCredito.Nvalors"
4118:             .txt_4c_Valor.InputMask     = "999,999,999.99"
4119:             .txt_4c_Valor.Visible       = .T.
4120: 
4121:             .AddObject("txt_4c_DtVenc", "TextBox")
4122:             .txt_4c_DtVenc.Top           = 12
4123:             .txt_4c_DtVenc.Left          = 281
4124:             .txt_4c_DtVenc.Width         = 80
4125:             .txt_4c_DtVenc.Height        = 23
4126:             .txt_4c_DtVenc.Value         = {}
4127:             .txt_4c_DtVenc.ControlSource = "dbCredito.Dvencs"
4128:             .txt_4c_DtVenc.Visible       = .T.
4129:         ENDWITH
4130: 
4131:         *-- Grade (crSigFiCp)
4132:         loc_oCns.AddObject("grd_4c_Credito", "Grid")
4133:         loc_oGrid = loc_oCns.grd_4c_Credito
4134:         WITH loc_oGrid
4135:             .Top          = 45
4136:             .Left         = 170
4137:             .Width        = 658
4138:             .Height       = 182
4139:             .FontName     = "Courier New"
4140:             .DeleteMark   = .F.
4141:             .RecordMark   = .F.
4142:             .ReadOnly     = .T.
4143:             .Highlight    = .T.
4144:             .HighlightRow = .T.
4145:             .ScrollBars   = 2
4146:             .RecordSource = "dbCredito"
4147:             .ColumnCount  = 6
4148:             .Themes       = .F.
4149:             .Visible      = .T.
4150: 
4151:             .Columns(1).ControlSource = "dbCredito.Tipos"
4152:             .Columns(1).Header1.Caption = ""
4153:             .Columns(1).Width = 30
4154:             .Columns(1).ReadOnly = .T.
4155: 
4156:             .Columns(2).ControlSource = "dbCredito.Usuars"
4157:             .Columns(2).Header1.Caption = "Usu" + CHR(225) + "rio"
4158:             .Columns(2).Width = 100
4159:             .Columns(2).ReadOnly = .T.
4160: 
4161:             .Columns(3).ControlSource = "dbCredito.Emps"
4162:             .Columns(3).Header1.Caption = "Emp"
4163:             .Columns(3).Width = 50
4164:             .Columns(3).ReadOnly = .T.
4165: 
4166:             .Columns(4).ControlSource = "dbCredito.Datas"
4167:             .Columns(4).Header1.Caption = "Data / Hora"
4168:             .Columns(4).Width = 120
4169:             .Columns(4).ReadOnly = .T.
4170: 
4171:             .Columns(5).ControlSource = "dbCredito.Dopes"
4172:             .Columns(5).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
4173:             .Columns(5).Width = 160
4174:             .Columns(5).ReadOnly = .T.
4175: 
4176:             .Columns(6).ControlSource = "dbCredito.Numes"
4177:             .Columns(6).Header1.Caption = "No. Oper"
4178:             .Columns(6).Width = 100
4179:             .Columns(6).ReadOnly = .T.
4180:         ENDWITH
4181: 
4182:         *-- Cnt_Docs
4183:         loc_oCns.AddObject("cnt_4c_CreditoDocs", "Container")
4184:         WITH loc_oCns.cnt_4c_CreditoDocs
4185:             .Top       = 230
4186:             .Left      = 545
4187:             .Width     = 185
4188:             .Height    = 40
4189:             .BackStyle = 0
4190:             .Visible   = .T.
4191:         ENDWITH

*-- Linhas 4201 a 4219:
4201:                 .ButtonCount   = 2
4202:                 .BackStyle     = 0
4203:                 .BorderStyle   = 0
4204:                 .ControlSource = "dbCredito.NChkDocs"
4205:                 WITH .Buttons(1)
4206:                     .Caption   = "RG"
4207:                     .Top       = 5
4208:                     .Left      = 5
4209:                     .BackStyle = 0
4210:                     .FontSize  = 8
4211:                 ENDWITH
4212:                 WITH .Buttons(2)
4213:                     .Caption   = "CNH"
4214:                     .Top       = 5
4215:                     .Left      = 45
4216:                     .Height    = 15
4217:                     .BackStyle = 0
4218:                     .FontSize  = 8
4219:                 ENDWITH

*-- Linhas 4227 a 4245:
4227:                 .Width         = 85
4228:                 .Height        = 23
4229:                 .Value         = {}
4230:                 .ControlSource = "dbCredito.TdDocs"
4231:                 .Visible       = .T.
4232:             ENDWITH
4233:         ENDWITH
4234:     ENDPROC
4235: 
4236:     *==========================================================================
4237:     * AdicionarMolduraAba - Shape de moldura (os "Shape" das abas do legado:
4238:     * BackStyle = 0, so a borda cinza). Fabrica usada pelas abas acima para nao
4239:     * repetir o mesmo bloco de nove propriedades em cada moldura.
4240:     *==========================================================================
4241:     PROTECTED PROCEDURE AdicionarMolduraAba(par_oPagina, par_cNome, ;
4242:             par_nTop, par_nLeft, par_nWidth, par_nHeight)
4243: 
4244:         par_oPagina.AddObject(par_cNome, "Shape")
4245: 

*-- Linhas 4334 a 4352:
4334:                     par_cCursorOrigem, "cursor_4c_GruposAba")
4335: 
4336:                 IF loc_nGrupos > 0 AND USED("cursor_4c_GruposAba")
4337:                     SELECT cursor_4c_GruposAba
4338:                     SCAN
4339:                         par_oCombo.AddItem( ;
4340:                             PADR(ALLTRIM(TratarNulo(cursor_4c_GruposAba.Codigos, "")), 10) + ;
4341:                             " - " + ALLTRIM(TratarNulo(cursor_4c_GruposAba.Descrs, "")))
4342:                     ENDSCAN
4343: 
4344:                     IF par_oCombo.ListCount > 0
4345:                         par_oCombo.ListIndex = 1
4346:                     ENDIF
4347:                 ENDIF
4348: 
4349:                 IF USED("cursor_4c_GruposAba")
4350:                     USE IN cursor_4c_GruposAba
4351:                 ENDIF
4352:             ENDIF

*-- Linhas 4375 a 4393:
4375: 
4376:         loc_cGrupo = LEFT(IIF(VARTYPE(par_cValorCombo) = "C", par_cValorCombo, ""), 10)
4377: 
4378:         SELECT (par_cCursor)
4379:         SET ORDER TO TAG Grupos
4380:         IF EMPTY(loc_cGrupo)
4381:             SET KEY TO
4382:         ELSE
4383:             SET KEY TO loc_cGrupo
4384:         ENDIF
4385:         GO TOP
4386:     ENDPROC
4387: 
4388:     *==========================================================================
4389:     * AtualizarAbaResultadoAtiva - Despachante UNICO de repintura da pagina
4390:     * Resultado: chama o funil da aba que esta a vista.
4391:     *
4392:     * Existe para que os DOIS caminhos que deixam a aba visivel - a troca de
4393:     * pagina (AlternarPagina(2)) e a troca de aba (OptResultadoInteractiveChange)

*-- Linhas 4479 a 4508:
4479:             IF USED("TmpPar") AND USED("crTmpTipos")
4480:                 loc_cTipos = ""
4481: 
4482:                 SELECT crTmpTipos
4483:                 GO TOP
4484:                 SCAN
4485:                     IF TratarNulo(crTmpTipos.Listas, 0) = 1
4486:                         loc_cTipos = loc_cTipos + ;
4487:                             IIF(EMPTY(loc_cTipos), "fPags = ", " OR fPags = ") + ;
4488:                             CHR(39) + ALLTRIM(TratarNulo(crTmpTipos.fPags, "")) + CHR(39)
4489:                     ENDIF
4490:                 ENDSCAN
4491:                 GO TOP IN crTmpTipos
4492: 
4493:                 SELECT TmpPar
4494:                 IF EMPTY(loc_cTipos)
4495:                     SET FILTER TO 0 = 1
4496:                 ELSE
4497:                     SET FILTER TO &loc_cTipos.
4498:                 ENDIF
4499:                 LOCATE
4500: 
4501:                 IF THIS.AbaResultadoDisponivel(2)
4502:                     loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4503:                     loc_oAba.txt_4c_TotPend.Value = THIS.this_oBusinessObject.TotalPendencias()
4504:                     loc_oAba.txt_4c_TotPend.Refresh()
4505:                 ENDIF
4506:             ENDIF
4507:         CATCH TO loc_oErro
4508:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 4625 a 4673:
4625:                 IF USED("crImpPend")
4626:                     USE IN crImpPend
4627:                 ENDIF
4628:                 CREATE CURSOR crImpPend (Tipo N(1), EmpDopNums C(29), Conta C(10), ;
4629:                     rClis C(40), Emps C(3), Dopes C(20), Numes N(6), Grupo C(10), ;
4630:                     Datas D, cPros C(14), dPros C(40), Qtds N(9,3), cUnis C(3), ;
4631:                     Units N(11,2), Totas N(11,2), TotGeral N(13,2), Grupos C(40))
4632: 
4633:                 loc_lTemLinha = .F.
4634:                 SELECT TmpPar
4635:                 GO TOP
4636:                 SCAN
4637:                     INSERT INTO crImpPend ;
4638:                         (Tipo, Conta, rClis, Emps, Dopes, Numes, Grupo, Datas, ;
4639:                          dPros, Totas, TotGeral, Grupos) ;
4640:                         VALUES ;
4641:                         (0, loc_cConta, LEFT(loc_cNome, 40), ;
4642:                          TratarNulo(TmpPar.emps, ""), ;
4643:                          TratarNulo(TmpPar.dopes, ""), ;
4644:                          TratarNulo(TmpPar.numes, 0), ;
4645:                          TratarNulo(TmpPar.grupos, ""), ;
4646:                          ConverterParaData(TmpPar.vencs), ;
4647:                          LEFT(TratarNulo(TmpPar.hists, ""), 40), ;
4648:                          TratarNulo(TmpPar.valos, 0), ;
4649:                          loc_nTotal, ;
4650:                          LEFT(loc_cGrupo, 40))
4651:                     loc_lTemLinha = .T.
4652:                 ENDSCAN
4653:                 GO TOP IN TmpPar
4654: 
4655:                 IF !loc_lTemLinha
4656:                     MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
4657:                 ELSE
4658:                     SELECT crImpPend
4659:                     GO TOP
4660:                     THIS.ImprimirListagem("SigReIpd", "crImpPend")
4661:                 ENDIF
4662:             ENDIF
4663:         CATCH TO loc_oErro
4664:             MsgErro(loc_oErro.Message + CHR(13) + ;
4665:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4666:                 "Erro ao listar as pend" + CHR(234) + "ncias")
4667:         ENDTRY
4668:     ENDPROC
4669: 
4670:     *==========================================================================
4671:     * ImprimirListagem - Helper canonico de REPORT FORM: resolve o caminho do
4672:     * FRX em gc_4c_CaminhoReports, avisa quando o arquivo nao existe (em vez de
4673:     * estourar sem dizer qual), isola o locale (SET POINT/SEPARATOR/

*-- Linhas 4699 a 4717:
4699:             SET SEPARATOR TO ","
4700:             SET REPORTBEHAVIOR 80
4701: 
4702:             SELECT (par_cCursorDados)
4703:             GO TOP
4704: 
4705:             REPORT FORM (loc_cFrx) TO PRINTER PROMPT PREVIEW
4706:         CATCH TO loc_oErro
4707:             MostrarErro("Erro ao gerar a listagem:" + CHR(13) + loc_oErro.Message, ;
4708:                 "Listagem")
4709:         FINALLY
4710:             SET POINT TO loc_cPonto
4711:             SET SEPARATOR TO loc_cSeparador
4712:             SET REPORTBEHAVIOR loc_nBehavior
4713:         ENDTRY
4714: 
4715:         *-- O preview do VFP9 corrompe _MSYSMENU: devolver o menu do sistema
4716:         TRY
4717:             SET SYSMENU TO DEFAULT

*-- Linhas 4768 a 4834:
4768:                 IF USED("crSigCdCeb")
4769:                     USE IN crSigCdCeb
4770:                 ENDIF
4771:                 loc_cSQL = "SELECT nbancos, bancos, nagencias, agencias, btels, ramals" + ;
4772:                     " FROM SigCdCeb WHERE iclis = " + EscaparSQL(loc_cConta)
4773:                 SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCeb")
4774: 
4775:                 IF USED("crSigCdCeb")
4776:                     SELECT crSigCdCeb
4777:                     IF EOF()
4778:                         _varRB = "N" + CHR(227) + "o Constam Refer" + CHR(234) + ;
4779:                             "ncias Bancarias Referentes ao Cliente!"
4780:                     ELSE
4781:                         SCAN
4782:                             _varRB = _varRB + TratarNulo(nbancos, "") + " " + ;
4783:                                 LEFT(TratarNulo(bancos, ""), 22) + " " + ;
4784:                                 TratarNulo(nagencias, "") + " " + ;
4785:                                 LEFT(TratarNulo(agencias, ""), 22) + " " + ;
4786:                                 TratarNulo(btels, "") + " " + TratarNulo(ramals, "")
4787:                         ENDSCAN
4788:                     ENDIF
4789:                     USE IN crSigCdCeb
4790:                 ENDIF
4791:             ENDIF
4792: 
4793:             IF par_lFollowup
4794:                 IF USED("crSigCdClh")
4795:                     USE IN crSigCdClh
4796:                 ENDIF
4797:                 loc_cSQL = "SELECT datas, hists FROM SigCdClh WHERE iclis = " + ;
4798:                     EscaparSQL(loc_cConta)
4799:                 SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdClh")
4800: 
4801:                 IF USED("crSigCdClh")
4802:                     SELECT crSigCdClh
4803:                     IF EOF()
4804:                         _varH = "N" + CHR(227) + "o Constam Follow-up Referentes ao Cliente!"
4805:                     ELSE
4806:                         SCAN
4807:                             _varH = _varH + TTOC(ConverterParaData(datas)) + " " + ;
4808:                                 TratarNulo(hists, "")
4809:                         ENDSCAN
4810:                     ENDIF
4811:                     USE IN crSigCdClh
4812:                 ENDIF
4813:             ENDIF
4814: 
4815:             IF USED("crCli")
4816:                 USE IN crCli
4817:             ENDIF
4818:             loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
4819:             SQLEXEC(gnConnHandle, loc_cSQL, "crCli")
4820: 
4821:             THIS.ImprimirListagem("SigReGcd", "crCli")
4822: 
4823:             IF USED("crSigCdCeb")
4824:                 USE IN crSigCdCeb
4825:             ENDIF
4826:             IF USED("crSigCdClh")
4827:                 USE IN crSigCdClh
4828:             ENDIF
4829:             IF USED("crCli")
4830:                 USE IN crCli
4831:             ENDIF
4832:         CATCH TO loc_oErro
4833:             MsgErro(loc_oErro.Message + CHR(13) + ;
4834:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 4877 a 5299:
4877:             IF USED("TmpRelGv")
4878:                 USE IN TmpRelGv
4879:             ENDIF
4880:             CREATE CURSOR TmpRelGv (ValTipo N(3), CabTipo C(70), Grupo C(10), ;
4881:                 Valor N(12,2), Moeda C(3), Data D, Descricao C(50), Observa C(76), ;
4882:                 Opers C(1), ValoPg N(12,2), Saldo N(12,2), Cpros C(14), DPros C(40), ;
4883:                 Numes N(6), Dopes C(20), PrazoEnts D, Fase C(10), Qtds N(9,2), ;
4884:                 Nenvs N(10), Nops N(10), xPer N(6,2), Emps C(3), Pesos N(9,2), ;
4885:                 Cbars N(14), Reffs C(40), Colecoes C(10), Anos C(4), Meses C(2))
4886:             INDEX ON STR(ValTipo, 3) + Anos + Meses + Grupo TAG ValGrupo
4887: 
4888:             IF USED("TmpTotal")
4889:                 USE IN TmpTotal
4890:             ENDIF
4891:             CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2))
4892:             INDEX ON Moeda TAG Moeda
4893: 
4894:             *-- (1) Saldo de Conta Corrente
4895:             IF par_lSaldo
4896:                 loc_nValTipo = 1
4897:                 loc_cCabTipo = "Saldos de Conta Corrente"
4898:                 IF USED("dbSaldo")
4899:                     SELECT dbSaldo
4900:                     GO TOP
4901:                     IF !EOF()
4902:                         SCAN
4903:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
4904:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbSaldo.grupos, ;
4905:                                     dbSaldo.saldos, dbSaldo.moedas)
4906:                         ENDSCAN
4907:                     ELSE
4908:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
4909:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
4910:                                 "o tem Saldo...")
4911:                     ENDIF
4912:                 ENDIF
4913:             ENDIF
4914: 
4915:             *-- (2) Limite de Credito
4916:             IF par_lLimite
4917:                 loc_nValTipo = 2
4918:                 loc_cCabTipo = "Limite de Cr" + CHR(233) + "dito"
4919:                 IF USED("crTmpLCrDi")
4920:                     USE IN crTmpLCrDi
4921:                 ENDIF
4922:                 loc_cSQL = "SELECT Grupos, LimCres, Moedas FROM SigClLcr" + ;
4923:                     " WHERE Contas = " + EscaparSQL(loc_cConta)
4924:                 SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLCrDi")
4925: 
4926:                 IF !USED("crTmpLCrDi") OR RECCOUNT("crTmpLCrDi") = 0
4927:                     INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
4928:                         VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
4929:                             "o tem Limite de Cr" + CHR(233) + "dito...")
4930:                 ELSE
4931:                     SELECT crTmpLCrDi
4932:                     SCAN
4933:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
4934:                             VALUES (loc_cCabTipo, loc_nValTipo, crTmpLCrDi.Grupos, ;
4935:                                 crTmpLCrDi.LimCres, crTmpLCrDi.Moedas)
4936:                     ENDSCAN
4937:                 ENDIF
4938:                 IF USED("crTmpLCrDi")
4939:                     USE IN crTmpLCrDi
4940:                 ENDIF
4941:             ENDIF
4942: 
4943:             *-- (3) Cheques Pend.
4944:             IF par_lChequePend
4945:                 loc_nValTipo = 3
4946:                 loc_cCabTipo = "Cheques Pendentes"
4947:                 IF USED("dbAberto")
4948:                     SELECT dbAberto
4949:                     GO TOP
4950:                     IF !EOF()
4951:                         SCAN
4952:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
4953:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbAberto.vencs, ;
4954:                                     dbAberto.valors, ;
4955:                                     ALLTRIM(dbAberto.bancos) + "." + ;
4956:                                     ALLTRIM(dbAberto.agencias) + "." + ;
4957:                                     ALLTRIM(dbAberto.ncontas) + "." + ;
4958:                                     ALLTRIM(dbAberto.ncheques))
4959: 
4960:                             IF USED("crSigCheh")
4961:                                 USE IN crSigCheh
4962:                             ENDIF
4963:                             loc_cSQL = "SELECT datas, hists FROM SigCheh" + ;
4964:                                 " WHERE nums = " + EscaparSQL(ALLTRIM(dbAberto.nums))
4965:                             SQLEXEC(gnConnHandle, loc_cSQL, "crSigCheh")
4966: 
4967:                             IF USED("crSigCheh") AND RECCOUNT("crSigCheh") > 0
4968:                                 SELECT crSigCheh
4969:                                 INDEX ON DTOS(datas) TAG Datas
4970:                                 GO BOTTOM
4971:                                 REPLACE TmpRelGv.Observa WITH TratarNulo(crSigCheh.hists, "")
4972:                             ENDIF
4973:                             IF USED("crSigCheh")
4974:                                 USE IN crSigCheh
4975:                             ENDIF
4976:                         ENDSCAN
4977:                     ELSE
4978:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
4979:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
4980:                                 "o tem Cheques Pendentes...")
4981:                     ENDIF
4982:                 ENDIF
4983:             ENDIF
4984: 
4985:             *-- (4) Cheques Devolvidos
4986:             IF par_lChequeDev
4987:                 loc_nValTipo = 4
4988:                 loc_cCabTipo = "Cheques Devolvidos"
4989:                 IF USED("dbDevolvido")
4990:                     SELECT dbDevolvido
4991:                     GO TOP
4992:                     IF !EOF()
4993:                         SCAN
4994:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
4995:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbDevolvido.vencs, ;
4996:                                     dbDevolvido.valors, ;
4997:                                     ALLTRIM(dbDevolvido.bancos) + "." + ;
4998:                                     ALLTRIM(dbDevolvido.agencias) + "." + ;
4999:                                     ALLTRIM(dbDevolvido.ncontas) + "." + ;
5000:                                     ALLTRIM(dbDevolvido.ncheques))
5001:                         ENDSCAN
5002:                     ELSE
5003:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5004:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5005:                                 "o tem Cheques Devolvidos...")
5006:                     ENDIF
5007:                 ENDIF
5008:             ENDIF
5009: 
5010:             *-- (5) Cheques Depositados
5011:             IF par_lChequeDep
5012:                 loc_nValTipo = 5
5013:                 loc_cCabTipo = "Cheques Depositados"
5014:                 IF USED("crTmpChe")
5015:                     USE IN crTmpChe
5016:                 ENDIF
5017:                 loc_cSQL = "SELECT * FROM SigChe WHERE Iclis = " + EscaparSQL(loc_cConta) + ;
5018:                     " AND Umovs = " + EscaparSQL("DEP" + CHR(211) + "SITO")
5019:                 SQLEXEC(gnConnHandle, loc_cSQL, "crTmpChe")
5020: 
5021:                 IF !USED("crTmpChe") OR RECCOUNT("crTmpChe") = 0
5022:                     INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5023:                         VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5024:                             "o tem Cheques Depositados...")
5025:                 ELSE
5026:                     SELECT crTmpChe
5027:                     SCAN
5028:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
5029:                             VALUES (loc_cCabTipo, loc_nValTipo, crTmpChe.vencs, ;
5030:                                 crTmpChe.valors, ;
5031:                                 ALLTRIM(crTmpChe.bancos) + "." + ;
5032:                                 ALLTRIM(crTmpChe.agencias) + "." + ;
5033:                                 ALLTRIM(crTmpChe.ncontas) + "." + ;
5034:                                 ALLTRIM(crTmpChe.ncheques))
5035:                     ENDSCAN
5036:                 ENDIF
5037:                 IF USED("crTmpChe")
5038:                     USE IN crTmpChe
5039:                 ENDIF
5040:             ENDIF
5041: 
5042:             *-- (9) Cartoes Pend.
5043:             IF par_lCartao
5044:                 loc_nValTipo = 9
5045:                 loc_cCabTipo = "Cart" + CHR(245) + "es Pendentes"
5046:                 IF USED("TmpCart")
5047:                     SELECT TmpCart
5048:                     GO TOP
5049:                     IF !EOF()
5050:                         SCAN
5051:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
5052:                                 VALUES (loc_cCabTipo, loc_nValTipo, TmpCart.vencs, ;
5053:                                     TmpCart.valos, ;
5054:                                     ALLTRIM(TmpCart.fpags) + " ( " + ;
5055:                                     ALLTRIM(TmpCart.cartaos) + " ) - " + ;
5056:                                     ALLTRIM(TmpCart.nocreditos))
5057:                         ENDSCAN
5058:                     ELSE
5059:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5060:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5061:                                 "o tem Cart" + CHR(245) + "es Pendentes...")
5062:                     ENDIF
5063:                 ENDIF
5064:             ENDIF
5065: 
5066:             *-- (7) Pendencias
5067:             IF par_lPend
5068:                 loc_nValTipo = 7
5069:                 loc_cCabTipo = "Pend" + CHR(234) + "ncias"
5070:                 IF USED("TmpPar")
5071:                     SELECT TmpPar
5072:                     GO TOP
5073:                     IF !EOF()
5074:                         SCAN
5075:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, ;
5076:                                     Descricao, Moeda, Opers) ;
5077:                                 VALUES (loc_cCabTipo, loc_nValTipo, TmpPar.vencs, ;
5078:                                     TmpPar.valos, TmpPar.hists, TmpPar.moefpgs, TmpPar.opers)
5079: 
5080:                             IF !SEEK(TmpPar.moefpgs, "TmpTotal")
5081:                                 INSERT INTO TmpTotal (Moeda) VALUES (TmpPar.moefpgs)
5082:                             ENDIF
5083:                             REPLACE TmpTotal.Valor WITH TmpTotal.Valor + ;
5084:                                 (TmpPar.valos * IIF(TmpPar.opers = "C", -1, 1))
5085:                         ENDSCAN
5086: 
5087:                         IF !par_lTermica OR par_cSaida == "V"
5088:                             SELECT TmpTotal
5089:                             SCAN
5090:                                 INSERT INTO TmpRelGv (ValTipo, Valor, Moeda) ;
5091:                                     VALUES (loc_nValTipo, TmpTotal.Valor, TmpTotal.Moeda)
5092:                             ENDSCAN
5093:                         ENDIF
5094:                     ELSE
5095:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5096:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5097:                                 "o tem Pendencias...")
5098:                     ENDIF
5099:                 ENDIF
5100:             ENDIF
5101: 
5102:             *-- (8) Operacoes Pend. - depende da aba Conserto (dbConserto),
5103:             *-- que so existe quando a fase do PProduto() for feita (ver
5104:             *-- cabecalho do arquivo); o bloco entra em acao sozinho quando o
5105:             *-- cursor passar a existir.
5106:             IF par_lOper
5107:                 loc_nValTipo = 8
5108:                 loc_cCabTipo = "Opera" + CHR(231) + CHR(245) + "es Pendentes"
5109:                 IF USED("dbConserto")
5110:                     SELECT dbConserto
5111:                     GO TOP
5112:                     IF !EOF()
5113:                         SCAN
5114:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Descricao) ;
5115:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbConserto.datas, ;
5116:                                     ALLTRIM(dbConserto.emps) + ALLTRIM(dbConserto.dopes) + ;
5117:                                     " - " + ALLTRIM(dbConserto.mascnum) + " (" + ;
5118:                                     ALLTRIM(dbConserto.status) + ")")
5119:                         ENDSCAN
5120:                     ELSE
5121:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5122:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5123:                                 "o tem Opera" + CHR(231) + CHR(245) + "es Pendentes...")
5124:                     ENDIF
5125:                 ENDIF
5126:             ENDIF
5127: 
5128:             *-- (6) Cheques Negociados
5129:             IF par_lChqNeg
5130:                 loc_nValTipo = 6
5131:                 loc_cCabTipo = "Cheques Negociados"
5132:                 IF USED("dbTitulo")
5133:                     SELECT dbTitulo
5134:                     GO TOP
5135:                     IF !EOF()
5136:                         SCAN
5137:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Data, Valor, ;
5138:                                     ValoPg, Saldo, Moeda, Observa) ;
5139:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbTitulo.titulos, ;
5140:                                     dbTitulo.vencs, dbTitulo.valors, dbTitulo.valpags, ;
5141:                                     dbTitulo.saldos, dbTitulo.moedas, ;
5142:                                     TratarNulo(dbTitulo.hists, ""))
5143:                         ENDSCAN
5144:                     ELSE
5145:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5146:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5147:                                 "o tem Cheques Negociados...")
5148:                     ENDIF
5149:                 ENDIF
5150:             ENDIF
5151: 
5152:             *-- (10) Resumo de Vendas - depende da aba Vendas (dbTotVendas),
5153:             *-- mesma pendencia do bloco (8).
5154:             IF par_lResVenda
5155:                 loc_nValTipo = 10
5156:                 loc_cCabTipo = "Resumo de Vendas"
5157:                 IF USED("dbTotVendas")
5158:                     SELECT dbTotVendas
5159:                     GO TOP
5160:                     IF !EOF()
5161:                         SCAN
5162:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Moeda, Valor, ;
5163:                                     ValoPg, Anos, Meses) ;
5164:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbTotVendas.mesanos, ;
5165:                                     dbTotVendas.moedas, dbTotVendas.totals, ;
5166:                                     dbTotVendas.vrmovs, dbTotVendas.anos, dbTotVendas.meses)
5167:                         ENDSCAN
5168:                     ELSE
5169:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5170:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5171:                                 "o tem Resumo de Vendas...")
5172:                     ENDIF
5173:                 ENDIF
5174:             ENDIF
5175: 
5176:             *-- (11) Produtos Adquiridos - depende da aba Vendas (dbProduto),
5177:             *-- mesma pendencia do bloco (8).
5178:             IF par_lProdutos
5179:                 loc_nValTipo = 11
5180:                 IF USED("dbProduto")
5181:                     LOCAL loc_oPnlProd
5182:                     loc_oPnlProd = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao.cnt_4c_ProdAdq
5183:                     loc_dDtIni = ConverterParaData(loc_oPnlProd.txt_4c_DtInicial.Value)
5184:                     loc_dDtFim = ConverterParaData(loc_oPnlProd.txt_4c_DtFinal.Value)
5185:                     loc_cCabTipo = "Produtos Adquiridos Pelo Cliente: " + ;
5186:                         DTOC(loc_dDtIni) + " - " + DTOC(loc_dDtFim)
5187: 
5188:                     SELECT dbProduto
5189:                     GO TOP
5190:                     IF !EOF()
5191:                         SCAN FOR BETWEEN(dbProduto.datas, loc_dDtIni, loc_dDtFim)
5192:                             IF USED("crTmpPro")
5193:                                 USE IN crTmpPro
5194:                             ENDIF
5195:                             loc_cSQL = "SELECT cpros, reffs, colecoes FROM SigCdPro" + ;
5196:                                 " WHERE cpros = " + EscaparSQL(dbProduto.cpros)
5197:                             SQLEXEC(gnConnHandle, loc_cSQL, "crTmpPro")
5198: 
5199:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Cpros, DPros, Qtds, ;
5200:                                     Opers, Emps, Dopes, Numes, Data, Valor, ValoPg, Saldo, ;
5201:                                     Pesos, Cbars, Reffs, Colecoes) ;
5202:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbProduto.cpros, ;
5203:                                     dbProduto.dpros, dbProduto.qtds, dbProduto.opers, ;
5204:                                     dbProduto.emps, dbProduto.dopes, ;
5205:                                     VAL(dbProduto.mascnum), dbProduto.datas, ;
5206:                                     dbProduto.totas, dbProduto.origtotas, ;
5207:                                     dbProduto.bastotas, dbProduto.pesos, ;
5208:                                     dbProduto.codbarras, ;
5209:                                     IIF(USED("crTmpPro"), ;
5210:                                         TratarNulo(crTmpPro.reffs, ""), ""), ;
5211:                                     IIF(USED("crTmpPro"), ;
5212:                                         TratarNulo(crTmpPro.colecoes, ""), ""))
5213: 
5214:                             IF USED("crTmpPro")
5215:                                 USE IN crTmpPro
5216:                             ENDIF
5217:                         ENDSCAN
5218:                     ELSE
5219:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5220:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5221:                                 "o Tem Produtos Adquiridos...")
5222:                     ENDIF
5223:                 ENDIF
5224:             ENDIF
5225: 
5226:             *-- (12) Posicao de Produtos em Producao - depende das abas Vendas
5227:             *-- (dbProduc) e Operacoes Pend. (dbConserto), mesma
5228:             *-- pendencia do bloco (8).
5229:             IF par_lProducao
5230:                 loc_nValTipo = 12
5231:                 loc_cCabTipo = "Posi" + CHR(231) + CHR(227) + "o de Produtos Em Produ" + ;
5232:                     CHR(231) + CHR(227) + "o"
5233:                 IF USED("dbProduc")
5234:                     SELECT dbProduc
5235:                     SET ORDER TO Nenvs
5236:                     GO TOP
5237:                     IF !EOF()
5238:                         SCAN
5239:                             IF USED("dbConserto")
5240:                                 = SEEK(dbProduc.emps + dbProduc.dopes + ;
5241:                                     STR(dbProduc.numes, 6), "dbConserto", "EmpDopNum")
5242:                             ENDIF
5243:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Dopes, Numes, Data, ;
5244:                                     PrazoEnts, Cpros, Fase, Qtds, Nenvs, Nops, xPer) ;
5245:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbProduc.dopes, ;
5246:                                     dbProduc.numes, ;
5247:                                     IIF(USED("dbConserto"), dbConserto.datas, {}), ;
5248:                                     IIF(USED("dbConserto"), dbConserto.prazoents, {}), ;
5249:                                     dbProduc.cpros, dbProduc.fase, dbProduc.qtde, ;
5250:                                     dbProduc.nenvs, dbProduc.nops, dbProduc.xper)
5251:                         ENDSCAN
5252:                     ELSE
5253:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5254:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5255:                                 "o Tem Produtos em Produ" + CHR(231) + CHR(227) + "o...")
5256:                     ENDIF
5257:                 ENDIF
5258:             ENDIF
5259: 
5260:             *-- (13) Posicao de Estoque
5261:             IF par_lEstoque
5262:                 loc_nValTipo = 13
5263:                 loc_cCabTipo = "Posi" + CHR(231) + CHR(227) + "o de Estoque "
5264:                 IF USED("dbEstoque")
5265:                     SELECT dbEstoque
5266:                     SET ORDER TO Grupos
5267:                     GO TOP
5268:                     IF !EOF()
5269:                         SCAN
5270:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Cpros, Qtds) ;
5271:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbEstoque.grupos, ;
5272:                                     dbEstoque.cpros, dbEstoque.sqtds)
5273:                         ENDSCAN
5274:                     ELSE
5275:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5276:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5277:                                 "o Tem Produtos em Estoque...")
5278:                     ENDIF
5279:                 ENDIF
5280:             ENDIF
5281: 
5282:             *-- Mesmo guard do legado: sem nenhuma linha, nao ha o que
5283:             *-- mostrar (regra #50 - avisar, nao abrir relatorio vazio)
5284:             SELECT TmpRelGv
5285:             GO TOP
5286:             IF EOF()
5287:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para imprimir...", ;
5288:                     "Impress" + CHR(227) + "o")
5289:             ELSE
5290:                 THIS.ImprimirListagem("SIGOPCGV", "TmpRelGv")
5291:             ENDIF
5292: 
5293:             IF USED("TmpRelGv")
5294:                 USE IN TmpRelGv
5295:             ENDIF
5296:             IF USED("TmpTotal")
5297:                 USE IN TmpTotal
5298:             ENDIF
5299:         CATCH TO loc_oErro

*-- Linhas 5374 a 5392:
5374:                 *-- Total dos devolvidos VISIVEIS (respeita o filtro de grupo)
5375:                 loc_nTotDev = 0
5376:                 IF USED("dbDevolvido")
5377:                     SELECT dbDevolvido
5378:                     SUM dbDevolvido.valors TO loc_nTotDev
5379:                     GO TOP IN dbDevolvido
5380:                 ENDIF
5381:                 loc_oAba.txt_4c_TotDevolvido.Value = loc_nTotDev
5382: 
5383:                 *-- Moeda do limite de credito nos dois rotulos "R$" do legado
5384:                 loc_cMoeda = ALLTRIM(loc_oBO.this_cMoedaPadrao)
5385:                 IF !EMPTY(loc_cMoeda)
5386:                     loc_oAba.lbl_4c_MoedaConta.Caption = loc_cMoeda
5387:                     loc_oAba.lbl_4c_MoedaHist.Caption  = loc_cMoeda
5388:                 ENDIF
5389: 
5390:                 loc_oAba.Refresh()
5391:             ENDIF
5392:         CATCH TO loc_oErro

*-- Linhas 5419 a 5447:
5419:             IF USED("DbFollow") AND USED("dbAberto") AND THIS.AbaResultadoDisponivel(3)
5420:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5421: 
5422:                 SELECT DbFollow
5423:                 SET ORDER TO TAG Nums
5424:                 IF EOF("dbAberto") OR EMPTY(TratarNulo(dbAberto.Nums, ""))
5425:                     SET KEY TO
5426:                 ELSE
5427:                     SET KEY TO PADR(ALLTRIM(dbAberto.Nums), 8)
5428:                 ENDIF
5429:                 GO TOP
5430: 
5431:                 loc_oAba.grd_4c_ChequeFollowup.Refresh()
5432:                 SELECT dbAberto
5433:             ENDIF
5434:         CATCH TO loc_oErro
5435:             MsgErro(loc_oErro.Message + CHR(13) + ;
5436:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5437:                 "Erro ao exibir o follow-up do cheque")
5438:         ENDTRY
5439:     ENDPROC
5440: 
5441:     *==========================================================================
5442:     * GradeChequeTituloAfterRowColChange - Grd_titulo.AfterRowColChange do
5443:     * legado: a observacao do titulo corrente vai para os dois campos de
5444:     * observacao (o legado parte o historico de 40 em duas metades de 20).
5445:     *==========================================================================
5446:     PROCEDURE GradeChequeTituloAfterRowColChange(par_nColIndex)
5447:         LOCAL loc_oAba, loc_cHists, loc_oErro

*-- Linhas 5527 a 5553:
5527:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5528: 
5529:                 IF USED("dbCheqHist")
5530:                     SELECT dbCheqHist
5531:                     GO TOP
5532:                 ENDIF
5533:                 IF USED("dbCheqMovim")
5534:                     SELECT dbCheqMovim
5535:                     GO TOP
5536:                 ENDIF
5537:                 IF USED("dbCheqProrrog")
5538:                     SELECT dbCheqProrrog
5539:                     GO TOP
5540:                 ENDIF
5541: 
5542:                 loc_oAba.grd_4c_HistCheque.Refresh()
5543:                 loc_oAba.grd_4c_MovCheque.Refresh()
5544:                 loc_oAba.grd_4c_ProrrogCheque.Refresh()
5545: 
5546:                 loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5547:                     TratarNulo(THIS.this_oBusinessObject.this_cFollowUpCheque, "")
5548:             ENDIF
5549:         CATCH TO loc_oErro
5550:             MsgErro(loc_oErro.Message + CHR(13) + ;
5551:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5552:                 "Erro ao atualizar a grade de hist" + CHR(243) + "rico de cheques")
5553:         ENDTRY

*-- Linhas 5580 a 5602:
5580:                     IF THIS.AbaResultadoDisponivel(9)
5581:                         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5582: 
5583:                         SELECT dbCheqMovim
5584:                         GO TOP
5585:                         loc_oAba.grd_4c_MovCheque.Refresh()
5586: 
5587:                         SELECT dbCheqProrrog
5588:                         GO TOP
5589:                         loc_oAba.grd_4c_ProrrogCheque.Refresh()
5590: 
5591:                         loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5592:                             TratarNulo(loc_oBO.this_cFollowUpCheque, "")
5593:                     ENDIF
5594:                 ENDIF
5595:             ENDIF
5596:         CATCH TO loc_oErro
5597:             MsgErro(loc_oErro.Message + CHR(13) + ;
5598:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5599:                 "Erro ao atualizar a movimenta" + CHR(231) + CHR(227) + "o do cheque")
5600:         ENDTRY
5601:     ENDPROC
5602: 

*-- Linhas 5615 a 5633:
5615:                 loc_oBO  = THIS.this_oBusinessObject
5616: 
5617:                 IF USED("dbCredito")
5618:                     SELECT dbCredito
5619:                     GO TOP
5620:                 ENDIF
5621: 
5622:                 loc_oAba.pgf_4c_Credito.Page1.grd_4c_Credito.Refresh()
5623: 
5624:                 IF VARTYPE(loc_oBO) = "O"
5625:                     loc_oAba.lbl_4c_SituacaoCredito.Caption = ;
5626:                         IIF(EMPTY(loc_oBO.this_cLabelSituacaoCredito), ;
5627:                             "CLIENTE", ALLTRIM(loc_oBO.this_cLabelSituacaoCredito))
5628:                     loc_oAba.lbl_4c_SituacaoCredito.ForeColor = ;
5629:                         IIF(loc_oBO.this_lSituacaoVermelha, RGB(255, 0, 0), RGB(0, 0, 255))
5630:                 ENDIF
5631:             ENDIF
5632:         CATCH TO loc_oErro
5633:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 5823 a 5841:
5823:                     loc_oBO.this_cConjuge   = ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value)
5824:                     loc_oBO.this_cTelefone  = ALLTRIM(loc_oCnt.txt_4c_Telefone.Value)
5825: 
5826:                     *-- optFiltro tem ControlSource NUMERICO de 2 opcoes: o
5827:                     *-- valor gravado eh o INDICE 1-based (1 = Iniciais,
5828:                     *-- 2 = Qualquer Parte), nunca 0/1 logico
5829:                     loc_oBO.this_nOpcaoFiltro = loc_oCnt.obj_4c_OptFiltro.Value
5830:                 ENDIF
5831: 
5832:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
5833:                     loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo
5834: 
5835:                     *-- ConverterParaData (nao TTOD): o TextBox nasce com {}
5836:                     *-- (DATE) e a coluna do banco chega como DATETIME (regra #16)
5837:                     loc_oBO.this_dDataInicial = ;
5838:                         ConverterParaData(loc_oPer.txt_4c_DtInicial.Value)
5839:                     loc_oBO.this_dDataFinal = ;
5840:                         ConverterParaData(loc_oPer.txt_4c_DtFinal.Value)
5841:                 ENDIF

