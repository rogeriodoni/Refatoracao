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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg) - TRECHOS RELEVANTES PARA PASS SQL (6300 linhas total):

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
1420:         *-- Botao "Documento" (Anexa) do historico de conta corrente (Result.
1421:         *-- Saldo.Anexa do legado): mesmo padrao icone-only do cmd_4c_AnexaPend
1422:         *-- da aba Pendencias (regra do botao nunca desabilitado em runtime).
1423:         loc_oPg.AddObject("cmd_4c_AnexaSaldo", "CommandButton")
1424:         WITH loc_oPg.cmd_4c_AnexaSaldo
1425:             .Top             = 407
1426:             .Left            = 744
1427:             .Width           = 40

*-- Linhas 2742 a 2764:
2742:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1
2743: 
2744:                 IF USED("dbHistorico")
2745:                     SELECT dbHistorico
2746:                     GO TOP
2747:                 ENDIF
2748:                 IF USED("dbSaldo")
2749:                     SELECT dbSaldo
2750:                     GO TOP
2751:                 ENDIF
2752: 
2753:                 IF PEMSTATUS(loc_oAba, "grd_4c_Historico", 5)
2754:                     loc_oAba.grd_4c_Historico.Refresh()
2755:                 ENDIF
2756:                 IF PEMSTATUS(loc_oAba, "grd_4c_Saldo", 5)
2757:                     loc_oAba.grd_4c_Saldo.Refresh()
2758:                 ENDIF
2759:             ENDIF
2760:         CATCH TO loc_oErro
2761:             MsgErro(loc_oErro.Message + CHR(13) + ;
2762:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2763:                 "Erro ao atualizar as grades de saldo")
2764:         ENDTRY

*-- Linhas 3030 a 3115:
3030:             .Height            = 346
3031:             .AllowHeaderSizing = .F.
3032:             .AllowRowSizing    = .F.
3033:             .DeleteMark        = .F.
3034:             .RecordMark        = .F.
3035:             .ReadOnly          = .T.
3036:             .ScrollBars        = 2
3037:             .RecordSource      = "TmpPar"
3038:             .ColumnCount       = 6
3039:             .Themes            = .F.
3040:             .Visible           = .T.
3041: 
3042:             *-- ColumnOrder 1 - vencimento (o legado nao sobrepoe a largura)
3043:             .Columns(1).ControlSource   = "TmpPar.vencs"
3044:             .Columns(1).Header1.Caption = "Vecto"
3045:             .Columns(1).Movable         = .F.
3046:             .Columns(1).Resizable       = .F.
3047:             .Columns(1).ReadOnly        = .T.
3048: 
3049:             *-- ColumnOrder 2 - natureza do lancamento (sem cabecalho no legado)
3050:             .Columns(2).ControlSource   = "TmpPar.Opers"
3051:             .Columns(2).Header1.Caption = ""
3052:             .Columns(2).Width           = 19
3053:             .Columns(2).Movable         = .F.
3054:             .Columns(2).Resizable       = .F.
3055:             .Columns(2).ReadOnly        = .T.
3056: 
3057:             .Columns(3).ControlSource   = "TmpPar.Valos"
3058:             .Columns(3).Header1.Caption = "Valor"
3059:             .Columns(3).Width           = 77
3060:             .Columns(3).Movable         = .F.
3061:             .Columns(3).Resizable       = .F.
3062:             .Columns(3).ReadOnly        = .T.
3063: 
3064:             .Columns(4).ControlSource   = "TmpPar.Moefpgs"
3065:             .Columns(4).Header1.Caption = "Moe"
3066:             .Columns(4).Width           = 30
3067:             .Columns(4).Movable         = .F.
3068:             .Columns(4).Resizable       = .F.
3069:             .Columns(4).ReadOnly        = .T.
3070: 
3071:             .Columns(5).ControlSource   = "TmpPar.FPags"
3072:             .Columns(5).Header1.Caption = "Tipo"
3073:             .Columns(5).Width           = 100
3074:             .Columns(5).Movable         = .F.
3075:             .Columns(5).Resizable       = .F.
3076:             .Columns(5).ReadOnly        = .T.
3077: 
3078:             .Columns(6).ControlSource   = "TmpPar.Hists"
3079:             .Columns(6).Header1.Caption = "Hist" + CHR(243) + "rico"
3080:             .Columns(6).Width           = 360
3081:             .Columns(6).Movable         = .F.
3082:             .Columns(6).Resizable       = .F.
3083:             .Columns(6).ReadOnly        = .T.
3084:         ENDWITH
3085: 
3086:         *-- Grade das formas de pagamento marcaveis (crTmpTipos). A coluna 1 eh
3087:         *-- um CheckBox de verdade: Column.AddObject sozinho NAO exibe o
3088:         *-- controle - precisa de CurrentControl, e de Sparse = .F. para
3089:         *-- aparecer em TODAS as linhas (regra #18)
3090:         loc_oPg.AddObject("grd_4c_TiposPend", "Grid")
3091:         loc_oGrid = loc_oPg.grd_4c_TiposPend
3092:         WITH loc_oGrid
3093:             .Top               = 59
3094:             .Left              = 812
3095:             .Width             = 133
3096:             .Height            = 105
3097:             .FontSize          = 8
3098:             .AllowHeaderSizing = .F.
3099:             .AllowRowSizing    = .F.
3100:             .DeleteMark        = .F.
3101:             .RecordMark        = .F.
3102:             .RowHeight         = 17
3103:             .ScrollBars        = 2
3104:             .ReadOnly          = .F.
3105:             .RecordSource      = "crTmpTipos"
3106:             .ColumnCount       = 2
3107:             .Themes            = .F.
3108:             .Visible           = .T.
3109:         ENDWITH
3110: 
3111:         loc_oGrid.Columns(1).AddObject("chk_4c_TipoPend", "CheckBox")
3112:         WITH loc_oGrid.Columns(1).chk_4c_TipoPend
3113:             .Top       = 9
3114:             .Left      = 2
3115:             .Width     = 22

*-- Linhas 3126 a 3152:
3126:         WITH loc_oGrid
3127:             .Columns(1).CurrentControl   = "chk_4c_TipoPend"
3128:             .Columns(1).Sparse           = .F.
3129:             .Columns(1).ControlSource    = "crTmpTipos.Listas"
3130:             .Columns(1).Header1.Caption  = ""
3131:             .Columns(1).Width            = 15
3132:             .Columns(1).Movable          = .F.
3133:             .Columns(1).Resizable        = .F.
3134:             *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga)
3135:             .Columns(1).ReadOnly         = .F.
3136: 
3137:             .Columns(2).ControlSource    = "crTmpTipos.fPags"
3138:             .Columns(2).Header1.Caption  = "Tipos"
3139:             .Columns(2).Width            = 95
3140:             .Columns(2).FontName         = "Arial"
3141:             .Columns(2).FontSize         = 8
3142:             .Columns(2).Movable          = .F.
3143:             .Columns(2).Resizable        = .F.
3144:             .Columns(2).ReadOnly         = .T.
3145:         ENDWITH
3146: 
3147:         *-- CheckBox de grade nao alterna pelo binding nativo: os quatro
3148:         *-- handlers (Click/MouseDown suprimem o toggle padrao, MouseUp e
3149:         *-- KeyPress alternam por codigo) sao obrigatorios
3150:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "Click", ;
3151:             THIS, "ChkTipoPendClick")
3152:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseDown", ;

*-- Linhas 3338 a 3535:
3338:             .Width        = 471
3339:             .Height       = 86
3340:             .FontName     = "Courier New"
3341:             .DeleteMark   = .F.
3342:             .RecordMark   = .F.
3343:             .ReadOnly     = .T.
3344:             .Highlight    = .T.
3345:             .HighlightRow = .T.
3346:             .RowHeight    = 16
3347:             .ScrollBars   = 2
3348:             .RecordSource = "dbAberto"
3349:             .ColumnCount  = 6
3350:             .Themes       = .F.
3351:             .Visible      = .T.
3352: 
3353:             .Columns(1).ControlSource   = "dbAberto.vencs"
3354:             .Columns(1).Header1.Caption = "Vencimento"
3355:             .Columns(1).Width           = 80
3356:             .Columns(1).ReadOnly        = .T.
3357: 
3358:             .Columns(2).ControlSource   = "dbAberto.bancos"
3359:             .Columns(2).Header1.Caption = "Bco."
3360:             .Columns(2).Width           = 38
3361:             .Columns(2).Alignment       = 1
3362:             .Columns(2).ReadOnly        = .T.
3363: 
3364:             .Columns(3).ControlSource   = "dbAberto.agencias"
3365:             .Columns(3).Header1.Caption = "Ag."
3366:             .Columns(3).Width           = 45
3367:             .Columns(3).Alignment       = 1
3368:             .Columns(3).ReadOnly        = .T.
3369: 
3370:             .Columns(4).ControlSource   = "dbAberto.ncontas"
3371:             .Columns(4).Header1.Caption = "Conta"
3372:             .Columns(4).Width           = 100
3373:             .Columns(4).ReadOnly        = .T.
3374: 
3375:             .Columns(5).ControlSource   = "dbAberto.ncheques"
3376:             .Columns(5).Header1.Caption = "Cheque"
3377:             .Columns(5).Width           = 65
3378:             .Columns(5).Alignment       = 1
3379:             .Columns(5).ReadOnly        = .T.
3380: 
3381:             .Columns(6).ControlSource   = "dbAberto.valors"
3382:             .Columns(6).Header1.Caption = "Valor"
3383:             .Columns(6).Width           = 115
3384:             .Columns(6).ReadOnly        = .T.
3385:         ENDWITH
3386: 
3387:         *-- Follow-up do cheque corrente (DbFollow)
3388:         loc_oPg.AddObject("grd_4c_ChequeFollowup", "Grid")
3389:         loc_oGrid = loc_oPg.grd_4c_ChequeFollowup
3390:         WITH loc_oGrid
3391:             .Top          = 79
3392:             .Left         = 499
3393:             .Width        = 471
3394:             .Height       = 86
3395:             .FontName     = "Courier New"
3396:             .DeleteMark   = .F.
3397:             .RecordMark   = .F.
3398:             .ReadOnly     = .T.
3399:             .Highlight    = .T.
3400:             .HighlightRow = .T.
3401:             .RowHeight    = 16
3402:             .ScrollBars   = 2
3403:             .RecordSource = "DbFollow"
3404:             .ColumnCount  = 2
3405:             .Themes       = .F.
3406:             .Visible      = .T.
3407: 
3408:             .Columns(1).ControlSource   = "DbFollow.Datas"
3409:             .Columns(1).Header1.Caption = "Data"
3410:             .Columns(1).Width           = 78
3411:             .Columns(1).ReadOnly        = .T.
3412: 
3413:             .Columns(2).ControlSource   = "DbFollow.Hists"
3414:             .Columns(2).Header1.Caption = "Hist" + CHR(243) + "rico"
3415:             .Columns(2).Width           = 370
3416:             .Columns(2).ReadOnly        = .T.
3417:         ENDWITH
3418: 
3419:         *-- Cheques negociados / titulos (DbTitulo)
3420:         loc_oPg.AddObject("grd_4c_ChequeTitulo", "Grid")
3421:         loc_oGrid = loc_oPg.grd_4c_ChequeTitulo
3422:         WITH loc_oGrid
3423:             .Top          = 219
3424:             .Left         = 11
3425:             .Width        = 471
3426:             .Height       = 86
3427:             .FontName     = "Courier New"
3428:             .DeleteMark   = .F.
3429:             .RecordMark   = .F.
3430:             .ReadOnly     = .T.
3431:             .Highlight    = .T.
3432:             .HighlightRow = .T.
3433:             .RowHeight    = 16
3434:             .ScrollBars   = 2
3435:             .RecordSource = "DbTitulo"
3436:             .ColumnCount  = 6
3437:             .Themes       = .F.
3438:             .Visible      = .T.
3439: 
3440:             .Columns(1).ControlSource   = "DbTitulo.Titulos"
3441:             .Columns(1).Header1.Caption = "Titulo"
3442:             .Columns(1).Width           = 80
3443:             .Columns(1).ReadOnly        = .T.
3444: 
3445:             .Columns(2).ControlSource   = "DbTitulo.Vencs"
3446:             .Columns(2).Header1.Caption = "Vencto"
3447:             .Columns(2).Width           = 80
3448:             .Columns(2).ReadOnly        = .T.
3449: 
3450:             .Columns(3).ControlSource   = "DbTitulo.Valors"
3451:             .Columns(3).Header1.Caption = "Valor"
3452:             .Columns(3).Width           = 85
3453:             .Columns(3).ReadOnly        = .T.
3454: 
3455:             .Columns(4).ControlSource   = "DbTitulo.ValPags"
3456:             .Columns(4).Header1.Caption = "V.Pago"
3457:             .Columns(4).Width           = 85
3458:             .Columns(4).ReadOnly        = .T.
3459: 
3460:             .Columns(5).ControlSource   = "DbTitulo.Saldos"
3461:             .Columns(5).Header1.Caption = "Saldo"
3462:             .Columns(5).Width           = 80
3463:             .Columns(5).ReadOnly        = .T.
3464: 
3465:             .Columns(6).ControlSource   = "DbTitulo.Moedas"
3466:             .Columns(6).Header1.Caption = "Moe"
3467:             .Columns(6).Width           = 28
3468:             .Columns(6).ReadOnly        = .T.
3469:         ENDWITH
3470: 
3471:         *-- Historico de cheques devolvidos (dbDevolvido)
3472:         loc_oPg.AddObject("grd_4c_ChequeDevolvido", "Grid")
3473:         loc_oGrid = loc_oPg.grd_4c_ChequeDevolvido
3474:         WITH loc_oGrid
3475:             .Top          = 220
3476:             .Left         = 499
3477:             .Width        = 386
3478:             .Height       = 86
3479:             .FontName     = "Courier New"
3480:             .DeleteMark   = .F.
3481:             .RecordMark   = .F.
3482:             .ReadOnly     = .T.
3483:             .Highlight    = .T.
3484:             .HighlightRow = .T.
3485:             .RowHeight    = 16
3486:             .ScrollBars   = 2
3487:             .RecordSource = "dbDevolvido"
3488:             .ColumnCount  = 6
3489:             .Themes       = .F.
3490:             .Visible      = .T.
3491: 
3492:             .Columns(1).ControlSource   = "dbDevolvido.vencs"
3493:             .Columns(1).Header1.Caption = "Vencimento"
3494:             .Columns(1).Width           = 80
3495:             .Columns(1).ReadOnly        = .T.
3496: 
3497:             .Columns(2).ControlSource   = "dbDevolvido.bancos"
3498:             .Columns(2).Header1.Caption = "Bco."
3499:             .Columns(2).Width           = 31
3500:             .Columns(2).Alignment       = 1
3501:             .Columns(2).ReadOnly        = .T.
3502: 
3503:             .Columns(3).ControlSource   = "dbDevolvido.agencias"
3504:             .Columns(3).Header1.Caption = "Ag."
3505:             .Columns(3).Width           = 38
3506:             .Columns(3).Alignment       = 1
3507:             .Columns(3).ReadOnly        = .T.
3508: 
3509:             .Columns(4).ControlSource   = "dbDevolvido.ncontas"
3510:             .Columns(4).Header1.Caption = "Conta"
3511:             .Columns(4).Width           = 80
3512:             .Columns(4).ReadOnly        = .T.
3513: 
3514:             .Columns(5).ControlSource   = "dbDevolvido.ncheques"
3515:             .Columns(5).Header1.Caption = "Cheque"
3516:             .Columns(5).Width           = 52
3517:             .Columns(5).Alignment       = 1
3518:             .Columns(5).ReadOnly        = .T.
3519: 
3520:             .Columns(6).ControlSource   = "dbDevolvido.valors"
3521:             .Columns(6).Header1.Caption = "Valor"
3522:             .Columns(6).Width           = 80
3523:             .Columns(6).ReadOnly        = .T.
3524:         ENDWITH
3525: 
3526:         *-- Campos somente-leitura: total da grade de aberto, historico de
3527:         *-- devolvidos, observacao dos negociados e os oito totais do pe
3528:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_TotChequeAberto", 164, 344, 117, 23, .T.)
3529:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_TotDevolvido",    247, 890, 104, 24, .T.)
3530:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ObsNegoc1",       341,  11, 471, 23, .F.)
3531:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ObsNegoc2",       364,  11, 471, 23, .F.)
3532:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_LimiteCred",      345, 611, 115, 23, .T.)
3533:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqAVencer",      367, 611, 115, 23, .T.)
3534:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqVencidos",     389, 611, 115, 23, .T.)
3535:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqDevolv",       411, 611, 115, 23, .T.)

*-- Linhas 3568 a 3640:
3568:             .Width        = 725
3569:             .Height       = 254
3570:             .FontName     = "Courier New"
3571:             .DeleteMark   = .F.
3572:             .RecordMark   = .F.
3573:             .ReadOnly     = .T.
3574:             .Highlight    = .T.
3575:             .HighlightRow = .T.
3576:             .ScrollBars   = 2
3577:             .RecordSource = "TmpCart"
3578:             .ColumnCount  = 6
3579:             .Themes       = .F.
3580:             .Visible      = .T.
3581: 
3582:             .Columns(1).ControlSource   = "TmpCart.vencs"
3583:             .Columns(1).Header1.Caption = "Vencimento"
3584:             .Columns(1).Width           = 75
3585:             .Columns(1).Alignment       = 0
3586:             .Columns(1).ReadOnly        = .T.
3587: 
3588:             .Columns(2).ControlSource   = "TmpCart.fpags"
3589:             .Columns(2).Header1.Caption = "Cart" + CHR(227) + "o"
3590:             .Columns(2).Width           = 100
3591:             .Columns(2).Alignment       = 0
3592:             .Columns(2).ReadOnly        = .T.
3593: 
3594:             .Columns(3).ControlSource   = "TmpCart.nocreditos"
3595:             .Columns(3).Header1.Caption = "Cr" + CHR(233) + "dito"
3596:             .Columns(3).Width           = 80
3597:             .Columns(3).Alignment       = 0
3598:             .Columns(3).ReadOnly        = .T.
3599: 
3600:             .Columns(4).ControlSource   = "TmpCart.cartaos"
3601:             .Columns(4).Header1.Caption = "N" + CHR(186) + " Cart" + CHR(227) + "o"
3602:             .Columns(4).Width           = 120
3603:             .Columns(4).Alignment       = 0
3604:             .Columns(4).ReadOnly        = .T.
3605: 
3606:             .Columns(5).ControlSource   = "TmpCart.valos"
3607:             .Columns(5).Header1.Caption = "Valor"
3608:             .Columns(5).Width           = 110
3609:             .Columns(5).Alignment       = 3
3610:             .Columns(5).ReadOnly        = .T.
3611: 
3612:             .Columns(6).ControlSource   = "TmpCart.datas"
3613:             .Columns(6).Header1.Caption = "Data"
3614:             .Columns(6).Width           = 75
3615:             .Columns(6).Alignment       = 0
3616:             .Columns(6).ReadOnly        = .T.
3617:         ENDWITH
3618:     ENDPROC
3619: 
3620:     *==========================================================================
3621:     * ConfigurarAbaEstoque - Aba 6 (Result.Estoque do legado): moldura, filtro
3622:     * de grupo e a grade dos produtos em poder do cliente (dbEstoque).
3623:     *
3624:     * A terceira coluna ("Operacao") fica SEM ControlSource de proposito: no
3625:     * dump legado ela tem ControlSource = "" (literal vazio) porque dbEstoque
3626:     * nao tem coluna de operacao - eh uma coluna reservada, que o legado
3627:     * tambem mostra vazia.
3628:     *==========================================================================
3629:     PROTECTED PROCEDURE ConfigurarAbaEstoque()
3630:         LOCAL loc_oPg, loc_oGrid
3631:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6
3632: 
3633:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_EstoqueProduto", 86, 303, 392, 361)
3634: 
3635:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoEstoque", 60, 307, 41, 15, "Grupo : ")
3636: 
3637:         loc_oPg.AddObject("cbo_4c_GrupoEstoque", "ComboBox")
3638:         WITH loc_oPg.cbo_4c_GrupoEstoque
3639:             .Top           = 56
3640:             .Left          = 350

*-- Linhas 3657 a 3692:
3657:             .Width        = 381
3658:             .Height       = 347
3659:             .FontName     = "Courier New"
3660:             .DeleteMark   = .F.
3661:             .RecordMark   = .F.
3662:             .ReadOnly     = .T.
3663:             .Highlight    = .T.
3664:             .HighlightRow = .T.
3665:             .ScrollBars   = 2
3666:             .RecordSource = "dbEstoque"
3667:             .ColumnCount  = 3
3668:             .Themes       = .F.
3669:             .Visible      = .T.
3670: 
3671:             .Columns(1).ControlSource   = "dbEstoque.cpros"
3672:             .Columns(1).Header1.Caption = "Produto"
3673:             .Columns(1).Width           = 108
3674:             .Columns(1).Alignment       = 3
3675:             .Columns(1).ReadOnly        = .T.
3676: 
3677:             .Columns(2).ControlSource   = "dbEstoque.sqtds"
3678:             .Columns(2).Header1.Caption = "Qtde."
3679:             .Columns(2).Width           = 100
3680:             .Columns(2).Alignment       = 3
3681:             .Columns(2).InputMask       = "999,999,999.99"
3682:             .Columns(2).ReadOnly        = .T.
3683: 
3684:             .Columns(3).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3685:             .Columns(3).Width           = 150
3686:             .Columns(3).Alignment       = 3
3687:             .Columns(3).ReadOnly        = .T.
3688:         ENDWITH
3689: 
3690:         BINDEVENT(loc_oPg.cbo_4c_GrupoEstoque, "InteractiveChange", ;
3691:             THIS, "CboGrupoEstoqueInteractiveChange")
3692:     ENDPROC

*-- Linhas 3715 a 3796:
3715:             .Width        = 696
3716:             .Height       = 124
3717:             .FontName     = "Courier New"
3718:             .DeleteMark   = .F.
3719:             .RecordMark   = .F.
3720:             .ReadOnly     = .T.
3721:             .Highlight    = .T.
3722:             .HighlightRow = .T.
3723:             .ScrollBars   = 2
3724:             .RecordSource = "dbCheqHist"
3725:             .ColumnCount  = 11
3726:             .Themes       = .F.
3727:             .Visible      = .T.
3728: 
3729:             .Columns(1).ControlSource   = "dbCheqHist.Vencs"
3730:             .Columns(1).Header1.Caption = "Vencimento"
3731:             .Columns(1).Width           = 75
3732:             .Columns(1).ReadOnly        = .T.
3733: 
3734:             .Columns(2).ControlSource   = "dbCheqHist.Bancos"
3735:             .Columns(2).Header1.Caption = "Banco"
3736:             .Columns(2).Width           = 50
3737:             .Columns(2).ReadOnly        = .T.
3738: 
3739:             .Columns(3).ControlSource   = "dbCheqHist.Agencias"
3740:             .Columns(3).Header1.Caption = "Agencia"
3741:             .Columns(3).Width           = 55
3742:             .Columns(3).ReadOnly        = .T.
3743: 
3744:             .Columns(4).ControlSource   = "dbCheqHist.NContas"
3745:             .Columns(4).Header1.Caption = "Conta"
3746:             .Columns(4).Width           = 70
3747:             .Columns(4).ReadOnly        = .T.
3748: 
3749:             .Columns(5).ControlSource   = "dbCheqHist.NCheques"
3750:             .Columns(5).Header1.Caption = "N" + CHR(186) + "mero"
3751:             .Columns(5).Width           = 60
3752:             .Columns(5).ReadOnly        = .T.
3753: 
3754:             .Columns(6).ControlSource   = "dbCheqHist.Valors"
3755:             .Columns(6).Header1.Caption = "Valor"
3756:             .Columns(6).Width           = 75
3757:             .Columns(6).Alignment       = 3
3758:             .Columns(6).InputMask       = "999,999,999.99"
3759:             .Columns(6).ReadOnly        = .T.
3760: 
3761:             .Columns(7).ControlSource   = "dbCheqHist.GruCarts"
3762:             .Columns(7).Header1.Caption = "Grupo Carteira"
3763:             .Columns(7).Width           = 70
3764:             .Columns(7).ReadOnly        = .T.
3765: 
3766:             .Columns(8).ControlSource   = "dbCheqHist.ConCarts"
3767:             .Columns(8).Header1.Caption = "Conta Carteira"
3768:             .Columns(8).Width           = 70
3769:             .Columns(8).ReadOnly        = .T.
3770: 
3771:             .Columns(9).ControlSource   = "dbCheqHist.Emps"
3772:             .Columns(9).Header1.Caption = "Emp"
3773:             .Columns(9).Width           = 40
3774:             .Columns(9).ReadOnly        = .T.
3775: 
3776:             .Columns(10).ControlSource   = "dbCheqHist.Numeros"
3777:             .Columns(10).Header1.Caption = "Arquivo"
3778:             .Columns(10).Width           = 60
3779:             .Columns(10).ReadOnly        = .T.
3780: 
3781:             .Columns(11).ControlSource   = "dbCheqHist.DiasP"
3782:             .Columns(11).Header1.Caption = "Dias Pag."
3783:             .Columns(11).Width           = 55
3784:             .Columns(11).Alignment       = 3
3785:             .Columns(11).ReadOnly        = .T.
3786: 
3787:             *-- SetAll('DynamicForeColor'/'DynamicBackColor', ...) do legado:
3788:             *-- cheque com historico (SigCheh - Tipo nao vazio) fica azul sobre
3789:             *-- fundo verde-claro.
3790:             .SetAll("DynamicForeColor", ;
3791:                 "IIF(!EMPTY(dbCheqHist.Tipo), RGB(0,0,255), RGB(0,0,0))", "Column")
3792:             .SetAll("DynamicBackColor", ;
3793:                 "IIF(!EMPTY(dbCheqHist.Tipo), RGB(220,255,220), RGB(255,255,255))", "Column")
3794:         ENDWITH
3795: 
3796:         *-- GradeMovimenta (dbCheqMovim) - movimentacao do cheque selecionado

*-- Linhas 3802 a 3897:
3802:             .Width        = 696
3803:             .Height       = 90
3804:             .FontName     = "Courier New"
3805:             .DeleteMark   = .F.
3806:             .RecordMark   = .F.
3807:             .ReadOnly     = .T.
3808:             .Highlight    = .T.
3809:             .HighlightRow = .T.
3810:             .ScrollBars   = 2
3811:             .RecordSource = "dbCheqMovim"
3812:             .ColumnCount  = 9
3813:             .Themes       = .F.
3814:             .Visible      = .T.
3815: 
3816:             .Columns(1).ControlSource   = "dbCheqMovim.Codigos"
3817:             .Columns(1).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
3818:             .Columns(1).Width           = 80
3819:             .Columns(1).ReadOnly        = .T.
3820: 
3821:             .Columns(2).ControlSource   = "dbCheqMovim.Nalineas"
3822:             .Columns(2).Header1.Caption = "Alinea"
3823:             .Columns(2).Width           = 60
3824:             .Columns(2).ReadOnly        = .T.
3825: 
3826:             .Columns(3).ControlSource   = "dbCheqMovim.Dtents"
3827:             .Columns(3).Header1.Caption = "Entrada"
3828:             .Columns(3).Width           = 80
3829:             .Columns(3).ReadOnly        = .T.
3830: 
3831:             .Columns(4).ControlSource   = "dbCheqMovim.Gruorigs"
3832:             .Columns(4).Header1.Caption = "Grupo/Origem"
3833:             .Columns(4).Width           = 80
3834:             .Columns(4).ReadOnly        = .T.
3835: 
3836:             .Columns(5).ControlSource   = "dbCheqMovim.Conorigs"
3837:             .Columns(5).Header1.Caption = "Conta/Origem"
3838:             .Columns(5).Width           = 80
3839:             .Columns(5).ReadOnly        = .T.
3840: 
3841:             .Columns(6).ControlSource   = "dbCheqMovim.Grupos"
3842:             .Columns(6).Header1.Caption = "Grupo/Destino"
3843:             .Columns(6).Width           = 80
3844:             .Columns(6).ReadOnly        = .T.
3845: 
3846:             .Columns(7).ControlSource   = "dbCheqMovim.Contas"
3847:             .Columns(7).Header1.Caption = "Conta/Destino"
3848:             .Columns(7).Width           = 80
3849:             .Columns(7).ReadOnly        = .T.
3850: 
3851:             .Columns(8).ControlSource   = "dbCheqMovim.Numlotes"
3852:             .Columns(8).Header1.Caption = "Lote"
3853:             .Columns(8).Width           = 70
3854:             .Columns(8).ReadOnly        = .T.
3855: 
3856:             .Columns(9).ControlSource   = "dbCheqMovim.Protocolos"
3857:             .Columns(9).Header1.Caption = "Protocolo"
3858:             .Columns(9).Width           = 86
3859:             .Columns(9).ReadOnly        = .T.
3860:         ENDWITH
3861: 
3862:         *-- GradeProrrog (dbCheqProrrog) - prorrogacoes do cheque selecionado
3863:         loc_oPg.AddObject("grd_4c_ProrrogCheque", "Grid")
3864:         loc_oGrid = loc_oPg.grd_4c_ProrrogCheque
3865:         WITH loc_oGrid
3866:             .Top          = 273
3867:             .Left         = 735
3868:             .Width        = 113
3869:             .Height       = 84
3870:             .FontName     = "Courier New"
3871:             .DeleteMark   = .F.
3872:             .RecordMark   = .F.
3873:             .ReadOnly     = .T.
3874:             .Highlight    = .T.
3875:             .HighlightRow = .T.
3876:             .ScrollBars   = 2
3877:             .RecordSource = "dbCheqProrrog"
3878:             .ColumnCount  = 1
3879:             .Themes       = .F.
3880:             .Visible      = .T.
3881: 
3882:             .Columns(1).ControlSource   = "dbCheqProrrog.Vencs"
3883:             .Columns(1).Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
3884:             .Columns(1).Width           = 108
3885:             .Columns(1).ReadOnly        = .T.
3886:         ENDWITH
3887: 
3888:         *-- Follow-up da linha corrente (Cnt_Followup.UltFollowup)
3889:         loc_oPg.AddObject("cnt_4c_Followup", "Container")
3890:         WITH loc_oPg.cnt_4c_Followup
3891:             .Top       = 273
3892:             .Left      = 151
3893:             .Width     = 561
3894:             .Height    = 43
3895:             .BackStyle = 0
3896:             .Visible   = .T.
3897:         ENDWITH

*-- Linhas 4031 a 4121:
4031:             .txt_4c_CBancos.Width         = 36
4032:             .txt_4c_CBancos.Height        = 23
4033:             .txt_4c_CBancos.Value         = ""
4034:             .txt_4c_CBancos.ControlSource = "dbCredito.Cbancos"
4035:             .txt_4c_CBancos.Visible       = .T.
4036: 
4037:             .AddObject("txt_4c_CAgencias", "TextBox")
4038:             .txt_4c_CAgencias.Top           = 13
4039:             .txt_4c_CAgencias.Left          = 47
4040:             .txt_4c_CAgencias.Width         = 38
4041:             .txt_4c_CAgencias.Height        = 23
4042:             .txt_4c_CAgencias.Value         = ""
4043:             .txt_4c_CAgencias.ControlSource = "dbCredito.Cagencias"
4044:             .txt_4c_CAgencias.Visible       = .T.
4045: 
4046:             .AddObject("txt_4c_CContas", "TextBox")
4047:             .txt_4c_CContas.Top           = 13
4048:             .txt_4c_CContas.Left          = 92
4049:             .txt_4c_CContas.Width         = 80
4050:             .txt_4c_CContas.Height        = 23
4051:             .txt_4c_CContas.Value         = ""
4052:             .txt_4c_CContas.ControlSource = "dbCredito.Ccontas"
4053:             .txt_4c_CContas.Visible       = .T.
4054: 
4055:             .AddObject("txt_4c_CCheInis", "TextBox")
4056:             .txt_4c_CCheInis.Top           = 13
4057:             .txt_4c_CCheInis.Left          = 177
4058:             .txt_4c_CCheInis.Width         = 52
4059:             .txt_4c_CCheInis.Height        = 23
4060:             .txt_4c_CCheInis.Value         = ""
4061:             .txt_4c_CCheInis.ControlSource = "dbCredito.Ccheinis"
4062:             .txt_4c_CCheInis.Visible       = .T.
4063: 
4064:             .AddObject("txt_4c_CDigInis", "TextBox")
4065:             .txt_4c_CDigInis.Top           = 13
4066:             .txt_4c_CDigInis.Left          = 240
4067:             .txt_4c_CDigInis.Width         = 17
4068:             .txt_4c_CDigInis.Height        = 23
4069:             .txt_4c_CDigInis.Value         = ""
4070:             .txt_4c_CDigInis.ControlSource = "dbCredito.Cdiginis"
4071:             .txt_4c_CDigInis.Visible       = .T.
4072: 
4073:             .AddObject("txt_4c_CCheFins", "TextBox")
4074:             .txt_4c_CCheFins.Top           = 13
4075:             .txt_4c_CCheFins.Left          = 268
4076:             .txt_4c_CCheFins.Width         = 52
4077:             .txt_4c_CCheFins.Height        = 23
4078:             .txt_4c_CCheFins.Value         = ""
4079:             .txt_4c_CCheFins.ControlSource = "dbCredito.Cchefins"
4080:             .txt_4c_CCheFins.Visible       = .T.
4081: 
4082:             .AddObject("txt_4c_CDigFins", "TextBox")
4083:             .txt_4c_CDigFins.Top           = 13
4084:             .txt_4c_CDigFins.Left          = 329
4085:             .txt_4c_CDigFins.Width         = 17
4086:             .txt_4c_CDigFins.Height        = 23
4087:             .txt_4c_CDigFins.Value         = ""
4088:             .txt_4c_CDigFins.ControlSource = "dbCredito.Cdigfins"
4089:             .txt_4c_CDigFins.Visible       = .T.
4090: 
4091:             .AddObject("txt_4c_CSeries", "TextBox")
4092:             .txt_4c_CSeries.Top           = 13
4093:             .txt_4c_CSeries.Left          = 354
4094:             .txt_4c_CSeries.Width         = 52
4095:             .txt_4c_CSeries.Height        = 23
4096:             .txt_4c_CSeries.Value         = ""
4097:             .txt_4c_CSeries.ControlSource = "dbCredito.Cseries"
4098:             .txt_4c_CSeries.Visible       = .T.
4099: 
4100:             .AddObject("txt_4c_CDAberts", "TextBox")
4101:             .txt_4c_CDAberts.Top           = 13
4102:             .txt_4c_CDAberts.Left          = 413
4103:             .txt_4c_CDAberts.Width         = 59
4104:             .txt_4c_CDAberts.Height        = 23
4105:             .txt_4c_CDAberts.Value         = ""
4106:             .txt_4c_CDAberts.ControlSource = "dbCredito.Cdaberts"
4107:             .txt_4c_CDAberts.Visible       = .T.
4108:         ENDWITH
4109: 
4110:         *-- Cnt_Valor
4111:         loc_oCns.AddObject("cnt_4c_CreditoValor", "Container")
4112:         WITH loc_oCns.cnt_4c_CreditoValor
4113:             .Top       = 230
4114:             .Left      = 170
4115:             .Width     = 372
4116:             .Height    = 40
4117:             .BackStyle = 0
4118:             .Visible   = .T.
4119:         ENDWITH
4120:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_ValorCredito", 0, 166, 39, 17, "Valor")
4121:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_DtVenc",       0, 272, 83, 15, "Data Vencimento")

*-- Linhas 4127 a 4213:
4127:             .txt_4c_NrCpf.Width         = 150
4128:             .txt_4c_NrCpf.Height        = 23
4129:             .txt_4c_NrCpf.Value         = ""
4130:             .txt_4c_NrCpf.ControlSource = "dbCredito.Ccpfs"
4131:             .txt_4c_NrCpf.Visible       = .T.
4132: 
4133:             .AddObject("txt_4c_Valor", "TextBox")
4134:             .txt_4c_Valor.Top           = 12
4135:             .txt_4c_Valor.Left          = 166
4136:             .txt_4c_Valor.Width         = 108
4137:             .txt_4c_Valor.Height        = 23
4138:             .txt_4c_Valor.Value         = 0
4139:             .txt_4c_Valor.ControlSource = "dbCredito.Nvalors"
4140:             .txt_4c_Valor.InputMask     = "999,999,999.99"
4141:             .txt_4c_Valor.Visible       = .T.
4142: 
4143:             .AddObject("txt_4c_DtVenc", "TextBox")
4144:             .txt_4c_DtVenc.Top           = 12
4145:             .txt_4c_DtVenc.Left          = 281
4146:             .txt_4c_DtVenc.Width         = 80
4147:             .txt_4c_DtVenc.Height        = 23
4148:             .txt_4c_DtVenc.Value         = {}
4149:             .txt_4c_DtVenc.ControlSource = "dbCredito.Dvencs"
4150:             .txt_4c_DtVenc.Visible       = .T.
4151:         ENDWITH
4152: 
4153:         *-- Grade (crSigFiCp)
4154:         loc_oCns.AddObject("grd_4c_Credito", "Grid")
4155:         loc_oGrid = loc_oCns.grd_4c_Credito
4156:         WITH loc_oGrid
4157:             .Top          = 45
4158:             .Left         = 170
4159:             .Width        = 658
4160:             .Height       = 182
4161:             .FontName     = "Courier New"
4162:             .DeleteMark   = .F.
4163:             .RecordMark   = .F.
4164:             .ReadOnly     = .T.
4165:             .Highlight    = .T.
4166:             .HighlightRow = .T.
4167:             .ScrollBars   = 2
4168:             .RecordSource = "dbCredito"
4169:             .ColumnCount  = 6
4170:             .Themes       = .F.
4171:             .Visible      = .T.
4172: 
4173:             .Columns(1).ControlSource = "dbCredito.Tipos"
4174:             .Columns(1).Header1.Caption = ""
4175:             .Columns(1).Width = 30
4176:             .Columns(1).ReadOnly = .T.
4177: 
4178:             .Columns(2).ControlSource = "dbCredito.Usuars"
4179:             .Columns(2).Header1.Caption = "Usu" + CHR(225) + "rio"
4180:             .Columns(2).Width = 100
4181:             .Columns(2).ReadOnly = .T.
4182: 
4183:             .Columns(3).ControlSource = "dbCredito.Emps"
4184:             .Columns(3).Header1.Caption = "Emp"
4185:             .Columns(3).Width = 50
4186:             .Columns(3).ReadOnly = .T.
4187: 
4188:             .Columns(4).ControlSource = "dbCredito.Datas"
4189:             .Columns(4).Header1.Caption = "Data / Hora"
4190:             .Columns(4).Width = 120
4191:             .Columns(4).ReadOnly = .T.
4192: 
4193:             .Columns(5).ControlSource = "dbCredito.Dopes"
4194:             .Columns(5).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
4195:             .Columns(5).Width = 160
4196:             .Columns(5).ReadOnly = .T.
4197: 
4198:             .Columns(6).ControlSource = "dbCredito.Numes"
4199:             .Columns(6).Header1.Caption = "No. Oper"
4200:             .Columns(6).Width = 100
4201:             .Columns(6).ReadOnly = .T.
4202:         ENDWITH
4203: 
4204:         *-- Cnt_Docs
4205:         loc_oCns.AddObject("cnt_4c_CreditoDocs", "Container")
4206:         WITH loc_oCns.cnt_4c_CreditoDocs
4207:             .Top       = 230
4208:             .Left      = 545
4209:             .Width     = 185
4210:             .Height    = 40
4211:             .BackStyle = 0
4212:             .Visible   = .T.
4213:         ENDWITH

*-- Linhas 4223 a 4241:
4223:                 .ButtonCount   = 2
4224:                 .BackStyle     = 0
4225:                 .BorderStyle   = 0
4226:                 .ControlSource = "dbCredito.NChkDocs"
4227:                 WITH .Buttons(1)
4228:                     .Caption   = "RG"
4229:                     .Top       = 5
4230:                     .Left      = 5
4231:                     .BackStyle = 0
4232:                     .FontSize  = 8
4233:                 ENDWITH
4234:                 WITH .Buttons(2)
4235:                     .Caption   = "CNH"
4236:                     .Top       = 5
4237:                     .Left      = 45
4238:                     .Height    = 15
4239:                     .BackStyle = 0
4240:                     .FontSize  = 8
4241:                 ENDWITH

*-- Linhas 4249 a 4267:
4249:                 .Width         = 85
4250:                 .Height        = 23
4251:                 .Value         = {}
4252:                 .ControlSource = "dbCredito.TdDocs"
4253:                 .Visible       = .T.
4254:             ENDWITH
4255:         ENDWITH
4256:     ENDPROC
4257: 
4258:     *==========================================================================
4259:     * AdicionarMolduraAba - Shape de moldura (os "Shape" das abas do legado:
4260:     * BackStyle = 0, so a borda cinza). Fabrica usada pelas abas acima para nao
4261:     * repetir o mesmo bloco de nove propriedades em cada moldura.
4262:     *==========================================================================
4263:     PROTECTED PROCEDURE AdicionarMolduraAba(par_oPagina, par_cNome, ;
4264:             par_nTop, par_nLeft, par_nWidth, par_nHeight)
4265: 
4266:         par_oPagina.AddObject(par_cNome, "Shape")
4267: 

*-- Linhas 4356 a 4374:
4356:                     par_cCursorOrigem, "cursor_4c_GruposAba")
4357: 
4358:                 IF loc_nGrupos > 0 AND USED("cursor_4c_GruposAba")
4359:                     SELECT cursor_4c_GruposAba
4360:                     SCAN
4361:                         par_oCombo.AddItem( ;
4362:                             PADR(ALLTRIM(TratarNulo(cursor_4c_GruposAba.Codigos, "")), 10) + ;
4363:                             " - " + ALLTRIM(TratarNulo(cursor_4c_GruposAba.Descrs, "")))
4364:                     ENDSCAN
4365: 
4366:                     IF par_oCombo.ListCount > 0
4367:                         par_oCombo.ListIndex = 1
4368:                     ENDIF
4369:                 ENDIF
4370: 
4371:                 IF USED("cursor_4c_GruposAba")
4372:                     USE IN cursor_4c_GruposAba
4373:                 ENDIF
4374:             ENDIF

*-- Linhas 4397 a 4415:
4397: 
4398:         loc_cGrupo = LEFT(IIF(VARTYPE(par_cValorCombo) = "C", par_cValorCombo, ""), 10)
4399: 
4400:         SELECT (par_cCursor)
4401:         SET ORDER TO TAG Grupos
4402:         IF EMPTY(loc_cGrupo)
4403:             SET KEY TO
4404:         ELSE
4405:             SET KEY TO loc_cGrupo
4406:         ENDIF
4407:         GO TOP
4408:     ENDPROC
4409: 
4410:     *==========================================================================
4411:     * AtualizarAbaResultadoAtiva - Despachante UNICO de repintura da pagina
4412:     * Resultado: chama o funil da aba que esta a vista.
4413:     *
4414:     * Existe para que os DOIS caminhos que deixam a aba visivel - a troca de
4415:     * pagina (AlternarPagina(2)) e a troca de aba (OptResultadoInteractiveChange)

*-- Linhas 4501 a 4530:
4501:             IF USED("TmpPar") AND USED("crTmpTipos")
4502:                 loc_cTipos = ""
4503: 
4504:                 SELECT crTmpTipos
4505:                 GO TOP
4506:                 SCAN
4507:                     IF TratarNulo(crTmpTipos.Listas, 0) = 1
4508:                         loc_cTipos = loc_cTipos + ;
4509:                             IIF(EMPTY(loc_cTipos), "fPags = ", " OR fPags = ") + ;
4510:                             CHR(39) + ALLTRIM(TratarNulo(crTmpTipos.fPags, "")) + CHR(39)
4511:                     ENDIF
4512:                 ENDSCAN
4513:                 GO TOP IN crTmpTipos
4514: 
4515:                 SELECT TmpPar
4516:                 IF EMPTY(loc_cTipos)
4517:                     SET FILTER TO 0 = 1
4518:                 ELSE
4519:                     SET FILTER TO &loc_cTipos.
4520:                 ENDIF
4521:                 LOCATE
4522: 
4523:                 IF THIS.AbaResultadoDisponivel(2)
4524:                     loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4525:                     loc_oAba.txt_4c_TotPend.Value = THIS.this_oBusinessObject.TotalPendencias()
4526:                     loc_oAba.txt_4c_TotPend.Refresh()
4527:                 ENDIF
4528:             ENDIF
4529:         CATCH TO loc_oErro
4530:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 4678 a 4726:
4678:                 IF USED("crImpPend")
4679:                     USE IN crImpPend
4680:                 ENDIF
4681:                 CREATE CURSOR crImpPend (Tipo N(1), EmpDopNums C(29), Conta C(10), ;
4682:                     rClis C(40), Emps C(3), Dopes C(20), Numes N(6), Grupo C(10), ;
4683:                     Datas D, cPros C(14), dPros C(40), Qtds N(9,3), cUnis C(3), ;
4684:                     Units N(11,2), Totas N(11,2), TotGeral N(13,2), Grupos C(40))
4685: 
4686:                 loc_lTemLinha = .F.
4687:                 SELECT TmpPar
4688:                 GO TOP
4689:                 SCAN
4690:                     INSERT INTO crImpPend ;
4691:                         (Tipo, Conta, rClis, Emps, Dopes, Numes, Grupo, Datas, ;
4692:                          dPros, Totas, TotGeral, Grupos) ;
4693:                         VALUES ;
4694:                         (0, loc_cConta, LEFT(loc_cNome, 40), ;
4695:                          TratarNulo(TmpPar.emps, ""), ;
4696:                          TratarNulo(TmpPar.dopes, ""), ;
4697:                          TratarNulo(TmpPar.numes, 0), ;
4698:                          TratarNulo(TmpPar.grupos, ""), ;
4699:                          ConverterParaData(TmpPar.vencs), ;
4700:                          LEFT(TratarNulo(TmpPar.hists, ""), 40), ;
4701:                          TratarNulo(TmpPar.valos, 0), ;
4702:                          loc_nTotal, ;
4703:                          LEFT(loc_cGrupo, 40))
4704:                     loc_lTemLinha = .T.
4705:                 ENDSCAN
4706:                 GO TOP IN TmpPar
4707: 
4708:                 IF !loc_lTemLinha
4709:                     MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
4710:                 ELSE
4711:                     SELECT crImpPend
4712:                     GO TOP
4713:                     THIS.ImprimirListagem("SigReIpd", "crImpPend")
4714:                 ENDIF
4715:             ENDIF
4716:         CATCH TO loc_oErro
4717:             MsgErro(loc_oErro.Message + CHR(13) + ;
4718:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4719:                 "Erro ao listar as pend" + CHR(234) + "ncias")
4720:         ENDTRY
4721:     ENDPROC
4722: 
4723:     *==========================================================================
4724:     * ImprimirListagem - Helper canonico de REPORT FORM: resolve o caminho do
4725:     * FRX em gc_4c_CaminhoReports, avisa quando o arquivo nao existe (em vez de
4726:     * estourar sem dizer qual), isola o locale (SET POINT/SEPARATOR/

*-- Linhas 4752 a 4770:
4752:             SET SEPARATOR TO ","
4753:             SET REPORTBEHAVIOR 80
4754: 
4755:             SELECT (par_cCursorDados)
4756:             GO TOP
4757: 
4758:             REPORT FORM (loc_cFrx) TO PRINTER PROMPT PREVIEW
4759:         CATCH TO loc_oErro
4760:             MostrarErro("Erro ao gerar a listagem:" + CHR(13) + loc_oErro.Message, ;
4761:                 "Listagem")
4762:         FINALLY
4763:             SET POINT TO loc_cPonto
4764:             SET SEPARATOR TO loc_cSeparador
4765:             SET REPORTBEHAVIOR loc_nBehavior
4766:         ENDTRY
4767: 
4768:         *-- O preview do VFP9 corrompe _MSYSMENU: devolver o menu do sistema
4769:         TRY
4770:             SET SYSMENU TO DEFAULT

*-- Linhas 4821 a 4887:
4821:                 IF USED("crSigCdCeb")
4822:                     USE IN crSigCdCeb
4823:                 ENDIF
4824:                 loc_cSQL = "SELECT nbancos, bancos, nagencias, agencias, btels, ramals" + ;
4825:                     " FROM SigCdCeb WHERE iclis = " + EscaparSQL(loc_cConta)
4826:                 SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCeb")
4827: 
4828:                 IF USED("crSigCdCeb")
4829:                     SELECT crSigCdCeb
4830:                     IF EOF()
4831:                         _varRB = "N" + CHR(227) + "o Constam Refer" + CHR(234) + ;
4832:                             "ncias Bancarias Referentes ao Cliente!"
4833:                     ELSE
4834:                         SCAN
4835:                             _varRB = _varRB + TratarNulo(nbancos, "") + " " + ;
4836:                                 LEFT(TratarNulo(bancos, ""), 22) + " " + ;
4837:                                 TratarNulo(nagencias, "") + " " + ;
4838:                                 LEFT(TratarNulo(agencias, ""), 22) + " " + ;
4839:                                 TratarNulo(btels, "") + " " + TratarNulo(ramals, "")
4840:                         ENDSCAN
4841:                     ENDIF
4842:                     USE IN crSigCdCeb
4843:                 ENDIF
4844:             ENDIF
4845: 
4846:             IF par_lFollowup
4847:                 IF USED("crSigCdClh")
4848:                     USE IN crSigCdClh
4849:                 ENDIF
4850:                 loc_cSQL = "SELECT datas, hists FROM SigCdClh WHERE iclis = " + ;
4851:                     EscaparSQL(loc_cConta)
4852:                 SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdClh")
4853: 
4854:                 IF USED("crSigCdClh")
4855:                     SELECT crSigCdClh
4856:                     IF EOF()
4857:                         _varH = "N" + CHR(227) + "o Constam Follow-up Referentes ao Cliente!"
4858:                     ELSE
4859:                         SCAN
4860:                             _varH = _varH + TTOC(ConverterParaData(datas)) + " " + ;
4861:                                 TratarNulo(hists, "")
4862:                         ENDSCAN
4863:                     ENDIF
4864:                     USE IN crSigCdClh
4865:                 ENDIF
4866:             ENDIF
4867: 
4868:             IF USED("crCli")
4869:                 USE IN crCli
4870:             ENDIF
4871:             loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
4872:             SQLEXEC(gnConnHandle, loc_cSQL, "crCli")
4873: 
4874:             THIS.ImprimirListagem("SigReGcd", "crCli")
4875: 
4876:             IF USED("crSigCdCeb")
4877:                 USE IN crSigCdCeb
4878:             ENDIF
4879:             IF USED("crSigCdClh")
4880:                 USE IN crSigCdClh
4881:             ENDIF
4882:             IF USED("crCli")
4883:                 USE IN crCli
4884:             ENDIF
4885:         CATCH TO loc_oErro
4886:             MsgErro(loc_oErro.Message + CHR(13) + ;
4887:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 4930 a 5352:
4930:             IF USED("TmpRelGv")
4931:                 USE IN TmpRelGv
4932:             ENDIF
4933:             CREATE CURSOR TmpRelGv (ValTipo N(3), CabTipo C(70), Grupo C(10), ;
4934:                 Valor N(12,2), Moeda C(3), Data D, Descricao C(50), Observa C(76), ;
4935:                 Opers C(1), ValoPg N(12,2), Saldo N(12,2), Cpros C(14), DPros C(40), ;
4936:                 Numes N(6), Dopes C(20), PrazoEnts D, Fase C(10), Qtds N(9,2), ;
4937:                 Nenvs N(10), Nops N(10), xPer N(6,2), Emps C(3), Pesos N(9,2), ;
4938:                 Cbars N(14), Reffs C(40), Colecoes C(10), Anos C(4), Meses C(2))
4939:             INDEX ON STR(ValTipo, 3) + Anos + Meses + Grupo TAG ValGrupo
4940: 
4941:             IF USED("TmpTotal")
4942:                 USE IN TmpTotal
4943:             ENDIF
4944:             CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2))
4945:             INDEX ON Moeda TAG Moeda
4946: 
4947:             *-- (1) Saldo de Conta Corrente
4948:             IF par_lSaldo
4949:                 loc_nValTipo = 1
4950:                 loc_cCabTipo = "Saldos de Conta Corrente"
4951:                 IF USED("dbSaldo")
4952:                     SELECT dbSaldo
4953:                     GO TOP
4954:                     IF !EOF()
4955:                         SCAN
4956:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
4957:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbSaldo.grupos, ;
4958:                                     dbSaldo.saldos, dbSaldo.moedas)
4959:                         ENDSCAN
4960:                     ELSE
4961:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
4962:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
4963:                                 "o tem Saldo...")
4964:                     ENDIF
4965:                 ENDIF
4966:             ENDIF
4967: 
4968:             *-- (2) Limite de Credito
4969:             IF par_lLimite
4970:                 loc_nValTipo = 2
4971:                 loc_cCabTipo = "Limite de Cr" + CHR(233) + "dito"
4972:                 IF USED("crTmpLCrDi")
4973:                     USE IN crTmpLCrDi
4974:                 ENDIF
4975:                 loc_cSQL = "SELECT Grupos, LimCres, Moedas FROM SigClLcr" + ;
4976:                     " WHERE Contas = " + EscaparSQL(loc_cConta)
4977:                 SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLCrDi")
4978: 
4979:                 IF !USED("crTmpLCrDi") OR RECCOUNT("crTmpLCrDi") = 0
4980:                     INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
4981:                         VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
4982:                             "o tem Limite de Cr" + CHR(233) + "dito...")
4983:                 ELSE
4984:                     SELECT crTmpLCrDi
4985:                     SCAN
4986:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
4987:                             VALUES (loc_cCabTipo, loc_nValTipo, crTmpLCrDi.Grupos, ;
4988:                                 crTmpLCrDi.LimCres, crTmpLCrDi.Moedas)
4989:                     ENDSCAN
4990:                 ENDIF
4991:                 IF USED("crTmpLCrDi")
4992:                     USE IN crTmpLCrDi
4993:                 ENDIF
4994:             ENDIF
4995: 
4996:             *-- (3) Cheques Pend.
4997:             IF par_lChequePend
4998:                 loc_nValTipo = 3
4999:                 loc_cCabTipo = "Cheques Pendentes"
5000:                 IF USED("dbAberto")
5001:                     SELECT dbAberto
5002:                     GO TOP
5003:                     IF !EOF()
5004:                         SCAN
5005:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
5006:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbAberto.vencs, ;
5007:                                     dbAberto.valors, ;
5008:                                     ALLTRIM(dbAberto.bancos) + "." + ;
5009:                                     ALLTRIM(dbAberto.agencias) + "." + ;
5010:                                     ALLTRIM(dbAberto.ncontas) + "." + ;
5011:                                     ALLTRIM(dbAberto.ncheques))
5012: 
5013:                             IF USED("crSigCheh")
5014:                                 USE IN crSigCheh
5015:                             ENDIF
5016:                             loc_cSQL = "SELECT datas, hists FROM SigCheh" + ;
5017:                                 " WHERE nums = " + EscaparSQL(ALLTRIM(dbAberto.nums))
5018:                             SQLEXEC(gnConnHandle, loc_cSQL, "crSigCheh")
5019: 
5020:                             IF USED("crSigCheh") AND RECCOUNT("crSigCheh") > 0
5021:                                 SELECT crSigCheh
5022:                                 INDEX ON DTOS(datas) TAG Datas
5023:                                 GO BOTTOM
5024:                                 REPLACE TmpRelGv.Observa WITH TratarNulo(crSigCheh.hists, "")
5025:                             ENDIF
5026:                             IF USED("crSigCheh")
5027:                                 USE IN crSigCheh
5028:                             ENDIF
5029:                         ENDSCAN
5030:                     ELSE
5031:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5032:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5033:                                 "o tem Cheques Pendentes...")
5034:                     ENDIF
5035:                 ENDIF
5036:             ENDIF
5037: 
5038:             *-- (4) Cheques Devolvidos
5039:             IF par_lChequeDev
5040:                 loc_nValTipo = 4
5041:                 loc_cCabTipo = "Cheques Devolvidos"
5042:                 IF USED("dbDevolvido")
5043:                     SELECT dbDevolvido
5044:                     GO TOP
5045:                     IF !EOF()
5046:                         SCAN
5047:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
5048:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbDevolvido.vencs, ;
5049:                                     dbDevolvido.valors, ;
5050:                                     ALLTRIM(dbDevolvido.bancos) + "." + ;
5051:                                     ALLTRIM(dbDevolvido.agencias) + "." + ;
5052:                                     ALLTRIM(dbDevolvido.ncontas) + "." + ;
5053:                                     ALLTRIM(dbDevolvido.ncheques))
5054:                         ENDSCAN
5055:                     ELSE
5056:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5057:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5058:                                 "o tem Cheques Devolvidos...")
5059:                     ENDIF
5060:                 ENDIF
5061:             ENDIF
5062: 
5063:             *-- (5) Cheques Depositados
5064:             IF par_lChequeDep
5065:                 loc_nValTipo = 5
5066:                 loc_cCabTipo = "Cheques Depositados"
5067:                 IF USED("crTmpChe")
5068:                     USE IN crTmpChe
5069:                 ENDIF
5070:                 loc_cSQL = "SELECT * FROM SigChe WHERE Iclis = " + EscaparSQL(loc_cConta) + ;
5071:                     " AND Umovs = " + EscaparSQL("DEP" + CHR(211) + "SITO")
5072:                 SQLEXEC(gnConnHandle, loc_cSQL, "crTmpChe")
5073: 
5074:                 IF !USED("crTmpChe") OR RECCOUNT("crTmpChe") = 0
5075:                     INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5076:                         VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5077:                             "o tem Cheques Depositados...")
5078:                 ELSE
5079:                     SELECT crTmpChe
5080:                     SCAN
5081:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
5082:                             VALUES (loc_cCabTipo, loc_nValTipo, crTmpChe.vencs, ;
5083:                                 crTmpChe.valors, ;
5084:                                 ALLTRIM(crTmpChe.bancos) + "." + ;
5085:                                 ALLTRIM(crTmpChe.agencias) + "." + ;
5086:                                 ALLTRIM(crTmpChe.ncontas) + "." + ;
5087:                                 ALLTRIM(crTmpChe.ncheques))
5088:                     ENDSCAN
5089:                 ENDIF
5090:                 IF USED("crTmpChe")
5091:                     USE IN crTmpChe
5092:                 ENDIF
5093:             ENDIF
5094: 
5095:             *-- (9) Cartoes Pend.
5096:             IF par_lCartao
5097:                 loc_nValTipo = 9
5098:                 loc_cCabTipo = "Cart" + CHR(245) + "es Pendentes"
5099:                 IF USED("TmpCart")
5100:                     SELECT TmpCart
5101:                     GO TOP
5102:                     IF !EOF()
5103:                         SCAN
5104:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
5105:                                 VALUES (loc_cCabTipo, loc_nValTipo, TmpCart.vencs, ;
5106:                                     TmpCart.valos, ;
5107:                                     ALLTRIM(TmpCart.fpags) + " ( " + ;
5108:                                     ALLTRIM(TmpCart.cartaos) + " ) - " + ;
5109:                                     ALLTRIM(TmpCart.nocreditos))
5110:                         ENDSCAN
5111:                     ELSE
5112:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5113:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5114:                                 "o tem Cart" + CHR(245) + "es Pendentes...")
5115:                     ENDIF
5116:                 ENDIF
5117:             ENDIF
5118: 
5119:             *-- (7) Pendencias
5120:             IF par_lPend
5121:                 loc_nValTipo = 7
5122:                 loc_cCabTipo = "Pend" + CHR(234) + "ncias"
5123:                 IF USED("TmpPar")
5124:                     SELECT TmpPar
5125:                     GO TOP
5126:                     IF !EOF()
5127:                         SCAN
5128:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, ;
5129:                                     Descricao, Moeda, Opers) ;
5130:                                 VALUES (loc_cCabTipo, loc_nValTipo, TmpPar.vencs, ;
5131:                                     TmpPar.valos, TmpPar.hists, TmpPar.moefpgs, TmpPar.opers)
5132: 
5133:                             IF !SEEK(TmpPar.moefpgs, "TmpTotal")
5134:                                 INSERT INTO TmpTotal (Moeda) VALUES (TmpPar.moefpgs)
5135:                             ENDIF
5136:                             REPLACE TmpTotal.Valor WITH TmpTotal.Valor + ;
5137:                                 (TmpPar.valos * IIF(TmpPar.opers = "C", -1, 1))
5138:                         ENDSCAN
5139: 
5140:                         IF !par_lTermica OR par_cSaida == "V"
5141:                             SELECT TmpTotal
5142:                             SCAN
5143:                                 INSERT INTO TmpRelGv (ValTipo, Valor, Moeda) ;
5144:                                     VALUES (loc_nValTipo, TmpTotal.Valor, TmpTotal.Moeda)
5145:                             ENDSCAN
5146:                         ENDIF
5147:                     ELSE
5148:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5149:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5150:                                 "o tem Pendencias...")
5151:                     ENDIF
5152:                 ENDIF
5153:             ENDIF
5154: 
5155:             *-- (8) Operacoes Pend. - depende da aba Conserto (dbConserto),
5156:             *-- que so existe quando a fase do PProduto() for feita (ver
5157:             *-- cabecalho do arquivo); o bloco entra em acao sozinho quando o
5158:             *-- cursor passar a existir.
5159:             IF par_lOper
5160:                 loc_nValTipo = 8
5161:                 loc_cCabTipo = "Opera" + CHR(231) + CHR(245) + "es Pendentes"
5162:                 IF USED("dbConserto")
5163:                     SELECT dbConserto
5164:                     GO TOP
5165:                     IF !EOF()
5166:                         SCAN
5167:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Descricao) ;
5168:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbConserto.datas, ;
5169:                                     ALLTRIM(dbConserto.emps) + ALLTRIM(dbConserto.dopes) + ;
5170:                                     " - " + ALLTRIM(dbConserto.mascnum) + " (" + ;
5171:                                     ALLTRIM(dbConserto.status) + ")")
5172:                         ENDSCAN
5173:                     ELSE
5174:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5175:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5176:                                 "o tem Opera" + CHR(231) + CHR(245) + "es Pendentes...")
5177:                     ENDIF
5178:                 ENDIF
5179:             ENDIF
5180: 
5181:             *-- (6) Cheques Negociados
5182:             IF par_lChqNeg
5183:                 loc_nValTipo = 6
5184:                 loc_cCabTipo = "Cheques Negociados"
5185:                 IF USED("dbTitulo")
5186:                     SELECT dbTitulo
5187:                     GO TOP
5188:                     IF !EOF()
5189:                         SCAN
5190:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Data, Valor, ;
5191:                                     ValoPg, Saldo, Moeda, Observa) ;
5192:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbTitulo.titulos, ;
5193:                                     dbTitulo.vencs, dbTitulo.valors, dbTitulo.valpags, ;
5194:                                     dbTitulo.saldos, dbTitulo.moedas, ;
5195:                                     TratarNulo(dbTitulo.hists, ""))
5196:                         ENDSCAN
5197:                     ELSE
5198:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5199:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5200:                                 "o tem Cheques Negociados...")
5201:                     ENDIF
5202:                 ENDIF
5203:             ENDIF
5204: 
5205:             *-- (10) Resumo de Vendas - depende da aba Vendas (dbTotVendas),
5206:             *-- mesma pendencia do bloco (8).
5207:             IF par_lResVenda
5208:                 loc_nValTipo = 10
5209:                 loc_cCabTipo = "Resumo de Vendas"
5210:                 IF USED("dbTotVendas")
5211:                     SELECT dbTotVendas
5212:                     GO TOP
5213:                     IF !EOF()
5214:                         SCAN
5215:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Moeda, Valor, ;
5216:                                     ValoPg, Anos, Meses) ;
5217:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbTotVendas.mesanos, ;
5218:                                     dbTotVendas.moedas, dbTotVendas.totals, ;
5219:                                     dbTotVendas.vrmovs, dbTotVendas.anos, dbTotVendas.meses)
5220:                         ENDSCAN
5221:                     ELSE
5222:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5223:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5224:                                 "o tem Resumo de Vendas...")
5225:                     ENDIF
5226:                 ENDIF
5227:             ENDIF
5228: 
5229:             *-- (11) Produtos Adquiridos - depende da aba Vendas (dbProduto),
5230:             *-- mesma pendencia do bloco (8).
5231:             IF par_lProdutos
5232:                 loc_nValTipo = 11
5233:                 IF USED("dbProduto")
5234:                     LOCAL loc_oPnlProd
5235:                     loc_oPnlProd = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao.cnt_4c_ProdAdq
5236:                     loc_dDtIni = ConverterParaData(loc_oPnlProd.txt_4c_DtInicial.Value)
5237:                     loc_dDtFim = ConverterParaData(loc_oPnlProd.txt_4c_DtFinal.Value)
5238:                     loc_cCabTipo = "Produtos Adquiridos Pelo Cliente: " + ;
5239:                         DTOC(loc_dDtIni) + " - " + DTOC(loc_dDtFim)
5240: 
5241:                     SELECT dbProduto
5242:                     GO TOP
5243:                     IF !EOF()
5244:                         SCAN FOR BETWEEN(dbProduto.datas, loc_dDtIni, loc_dDtFim)
5245:                             IF USED("crTmpPro")
5246:                                 USE IN crTmpPro
5247:                             ENDIF
5248:                             loc_cSQL = "SELECT cpros, reffs, colecoes FROM SigCdPro" + ;
5249:                                 " WHERE cpros = " + EscaparSQL(dbProduto.cpros)
5250:                             SQLEXEC(gnConnHandle, loc_cSQL, "crTmpPro")
5251: 
5252:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Cpros, DPros, Qtds, ;
5253:                                     Opers, Emps, Dopes, Numes, Data, Valor, ValoPg, Saldo, ;
5254:                                     Pesos, Cbars, Reffs, Colecoes) ;
5255:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbProduto.cpros, ;
5256:                                     dbProduto.dpros, dbProduto.qtds, dbProduto.opers, ;
5257:                                     dbProduto.emps, dbProduto.dopes, ;
5258:                                     VAL(dbProduto.mascnum), dbProduto.datas, ;
5259:                                     dbProduto.totas, dbProduto.origtotas, ;
5260:                                     dbProduto.bastotas, dbProduto.pesos, ;
5261:                                     dbProduto.codbarras, ;
5262:                                     IIF(USED("crTmpPro"), ;
5263:                                         TratarNulo(crTmpPro.reffs, ""), ""), ;
5264:                                     IIF(USED("crTmpPro"), ;
5265:                                         TratarNulo(crTmpPro.colecoes, ""), ""))
5266: 
5267:                             IF USED("crTmpPro")
5268:                                 USE IN crTmpPro
5269:                             ENDIF
5270:                         ENDSCAN
5271:                     ELSE
5272:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5273:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5274:                                 "o Tem Produtos Adquiridos...")
5275:                     ENDIF
5276:                 ENDIF
5277:             ENDIF
5278: 
5279:             *-- (12) Posicao de Produtos em Producao - depende das abas Vendas
5280:             *-- (dbProduc) e Operacoes Pend. (dbConserto), mesma
5281:             *-- pendencia do bloco (8).
5282:             IF par_lProducao
5283:                 loc_nValTipo = 12
5284:                 loc_cCabTipo = "Posi" + CHR(231) + CHR(227) + "o de Produtos Em Produ" + ;
5285:                     CHR(231) + CHR(227) + "o"
5286:                 IF USED("dbProduc")
5287:                     SELECT dbProduc
5288:                     SET ORDER TO Nenvs
5289:                     GO TOP
5290:                     IF !EOF()
5291:                         SCAN
5292:                             IF USED("dbConserto")
5293:                                 = SEEK(dbProduc.emps + dbProduc.dopes + ;
5294:                                     STR(dbProduc.numes, 6), "dbConserto", "EmpDopNum")
5295:                             ENDIF
5296:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Dopes, Numes, Data, ;
5297:                                     PrazoEnts, Cpros, Fase, Qtds, Nenvs, Nops, xPer) ;
5298:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbProduc.dopes, ;
5299:                                     dbProduc.numes, ;
5300:                                     IIF(USED("dbConserto"), dbConserto.datas, {}), ;
5301:                                     IIF(USED("dbConserto"), dbConserto.prazoents, {}), ;
5302:                                     dbProduc.cpros, dbProduc.fase, dbProduc.qtde, ;
5303:                                     dbProduc.nenvs, dbProduc.nops, dbProduc.xper)
5304:                         ENDSCAN
5305:                     ELSE
5306:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5307:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5308:                                 "o Tem Produtos em Produ" + CHR(231) + CHR(227) + "o...")
5309:                     ENDIF
5310:                 ENDIF
5311:             ENDIF
5312: 
5313:             *-- (13) Posicao de Estoque
5314:             IF par_lEstoque
5315:                 loc_nValTipo = 13
5316:                 loc_cCabTipo = "Posi" + CHR(231) + CHR(227) + "o de Estoque "
5317:                 IF USED("dbEstoque")
5318:                     SELECT dbEstoque
5319:                     SET ORDER TO Grupos
5320:                     GO TOP
5321:                     IF !EOF()
5322:                         SCAN
5323:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Cpros, Qtds) ;
5324:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbEstoque.grupos, ;
5325:                                     dbEstoque.cpros, dbEstoque.sqtds)
5326:                         ENDSCAN
5327:                     ELSE
5328:                         INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
5329:                             VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
5330:                                 "o Tem Produtos em Estoque...")
5331:                     ENDIF
5332:                 ENDIF
5333:             ENDIF
5334: 
5335:             *-- Mesmo guard do legado: sem nenhuma linha, nao ha o que
5336:             *-- mostrar (regra #50 - avisar, nao abrir relatorio vazio)
5337:             SELECT TmpRelGv
5338:             GO TOP
5339:             IF EOF()
5340:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para imprimir...", ;
5341:                     "Impress" + CHR(227) + "o")
5342:             ELSE
5343:                 THIS.ImprimirListagem("SIGOPCGV", "TmpRelGv")
5344:             ENDIF
5345: 
5346:             IF USED("TmpRelGv")
5347:                 USE IN TmpRelGv
5348:             ENDIF
5349:             IF USED("TmpTotal")
5350:                 USE IN TmpTotal
5351:             ENDIF
5352:         CATCH TO loc_oErro

*-- Linhas 5427 a 5445:
5427:                 *-- Total dos devolvidos VISIVEIS (respeita o filtro de grupo)
5428:                 loc_nTotDev = 0
5429:                 IF USED("dbDevolvido")
5430:                     SELECT dbDevolvido
5431:                     SUM dbDevolvido.valors TO loc_nTotDev
5432:                     GO TOP IN dbDevolvido
5433:                 ENDIF
5434:                 loc_oAba.txt_4c_TotDevolvido.Value = loc_nTotDev
5435: 
5436:                 *-- Moeda do limite de credito nos dois rotulos "R$" do legado
5437:                 loc_cMoeda = ALLTRIM(loc_oBO.this_cMoedaPadrao)
5438:                 IF !EMPTY(loc_cMoeda)
5439:                     loc_oAba.lbl_4c_MoedaConta.Caption = loc_cMoeda
5440:                     loc_oAba.lbl_4c_MoedaHist.Caption  = loc_cMoeda
5441:                 ENDIF
5442: 
5443:                 loc_oAba.Refresh()
5444:             ENDIF
5445:         CATCH TO loc_oErro

*-- Linhas 5472 a 5500:
5472:             IF USED("DbFollow") AND USED("dbAberto") AND THIS.AbaResultadoDisponivel(3)
5473:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5474: 
5475:                 SELECT DbFollow
5476:                 SET ORDER TO TAG Nums
5477:                 IF EOF("dbAberto") OR EMPTY(TratarNulo(dbAberto.Nums, ""))
5478:                     SET KEY TO
5479:                 ELSE
5480:                     SET KEY TO PADR(ALLTRIM(dbAberto.Nums), 8)
5481:                 ENDIF
5482:                 GO TOP
5483: 
5484:                 loc_oAba.grd_4c_ChequeFollowup.Refresh()
5485:                 SELECT dbAberto
5486:             ENDIF
5487:         CATCH TO loc_oErro
5488:             MsgErro(loc_oErro.Message + CHR(13) + ;
5489:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5490:                 "Erro ao exibir o follow-up do cheque")
5491:         ENDTRY
5492:     ENDPROC
5493: 
5494:     *==========================================================================
5495:     * GradeChequeTituloAfterRowColChange - Grd_titulo.AfterRowColChange do
5496:     * legado: a observacao do titulo corrente vai para os dois campos de
5497:     * observacao (o legado parte o historico de 40 em duas metades de 20).
5498:     *==========================================================================
5499:     PROCEDURE GradeChequeTituloAfterRowColChange(par_nColIndex)
5500:         LOCAL loc_oAba, loc_cHists, loc_oErro

*-- Linhas 5580 a 5606:
5580:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5581: 
5582:                 IF USED("dbCheqHist")
5583:                     SELECT dbCheqHist
5584:                     GO TOP
5585:                 ENDIF
5586:                 IF USED("dbCheqMovim")
5587:                     SELECT dbCheqMovim
5588:                     GO TOP
5589:                 ENDIF
5590:                 IF USED("dbCheqProrrog")
5591:                     SELECT dbCheqProrrog
5592:                     GO TOP
5593:                 ENDIF
5594: 
5595:                 loc_oAba.grd_4c_HistCheque.Refresh()
5596:                 loc_oAba.grd_4c_MovCheque.Refresh()
5597:                 loc_oAba.grd_4c_ProrrogCheque.Refresh()
5598: 
5599:                 loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5600:                     TratarNulo(THIS.this_oBusinessObject.this_cFollowUpCheque, "")
5601:             ENDIF
5602:         CATCH TO loc_oErro
5603:             MsgErro(loc_oErro.Message + CHR(13) + ;
5604:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5605:                 "Erro ao atualizar a grade de hist" + CHR(243) + "rico de cheques")
5606:         ENDTRY

*-- Linhas 5633 a 5655:
5633:                     IF THIS.AbaResultadoDisponivel(9)
5634:                         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5635: 
5636:                         SELECT dbCheqMovim
5637:                         GO TOP
5638:                         loc_oAba.grd_4c_MovCheque.Refresh()
5639: 
5640:                         SELECT dbCheqProrrog
5641:                         GO TOP
5642:                         loc_oAba.grd_4c_ProrrogCheque.Refresh()
5643: 
5644:                         loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5645:                             TratarNulo(loc_oBO.this_cFollowUpCheque, "")
5646:                     ENDIF
5647:                 ENDIF
5648:             ENDIF
5649:         CATCH TO loc_oErro
5650:             MsgErro(loc_oErro.Message + CHR(13) + ;
5651:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5652:                 "Erro ao atualizar a movimenta" + CHR(231) + CHR(227) + "o do cheque")
5653:         ENDTRY
5654:     ENDPROC
5655: 

*-- Linhas 5668 a 5686:
5668:                 loc_oBO  = THIS.this_oBusinessObject
5669: 
5670:                 IF USED("dbCredito")
5671:                     SELECT dbCredito
5672:                     GO TOP
5673:                 ENDIF
5674: 
5675:                 loc_oAba.pgf_4c_Credito.Page1.grd_4c_Credito.Refresh()
5676: 
5677:                 IF VARTYPE(loc_oBO) = "O"
5678:                     loc_oAba.lbl_4c_SituacaoCredito.Caption = ;
5679:                         IIF(EMPTY(loc_oBO.this_cLabelSituacaoCredito), ;
5680:                             "CLIENTE", ALLTRIM(loc_oBO.this_cLabelSituacaoCredito))
5681:                     loc_oAba.lbl_4c_SituacaoCredito.ForeColor = ;
5682:                         IIF(loc_oBO.this_lSituacaoVermelha, RGB(255, 0, 0), RGB(0, 0, 255))
5683:                 ENDIF
5684:             ENDIF
5685:         CATCH TO loc_oErro
5686:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 5876 a 5894:
5876:                     loc_oBO.this_cConjuge   = ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value)
5877:                     loc_oBO.this_cTelefone  = ALLTRIM(loc_oCnt.txt_4c_Telefone.Value)
5878: 
5879:                     *-- optFiltro tem ControlSource NUMERICO de 2 opcoes: o
5880:                     *-- valor gravado eh o INDICE 1-based (1 = Iniciais,
5881:                     *-- 2 = Qualquer Parte), nunca 0/1 logico
5882:                     loc_oBO.this_nOpcaoFiltro = loc_oCnt.obj_4c_OptFiltro.Value
5883:                 ENDIF
5884: 
5885:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
5886:                     loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo
5887: 
5888:                     *-- ConverterParaData (nao TTOD): o TextBox nasce com {}
5889:                     *-- (DATE) e a coluna do banco chega como DATETIME (regra #16)
5890:                     loc_oBO.this_dDataInicial = ;
5891:                         ConverterParaData(loc_oPer.txt_4c_DtInicial.Value)
5892:                     loc_oBO.this_dDataFinal = ;
5893:                         ConverterParaData(loc_oPer.txt_4c_DtFinal.Value)
5894:                 ENDIF

