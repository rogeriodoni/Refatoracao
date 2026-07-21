# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, FRETE, FRETEDEFS, CEMPS, ICLIS, LNCOMST, LCUFO, CODIGOS, DESTINOS, CODS, 0, LNTOP, LCFIN, LCCFOD, LCPRE, TPEMIS, LNTAM, LCMOD, LCUFD, SITTRICMS, CPROS, CITENS, FKCHAVE, CODCLASFISCAL, CODCFOP, LCOMC, UFS, CODIGO, LCCST, LNFIN, EXICBSIMP, LCP, VALIPIS, VALICMS, CGERGIA1S, P, IF, ITRAS, LNFPG, EMIS, IMPNFS, EMPS, SERIES, I, ESTADOS, DESCS, LNONE, LNVEZ, STATS, C1, J, DV, LCARQ, ESTAS, CNPJ, FPAGS, CFOPS, NFC, OPERS, LCANCELAS, UFIBGES, LCDEST

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
Select Emps, Dopes, Numes, Notas, NFMemo, Erros, Tipos, .F. As OKs, stats, ids, lotes, recibos, prots, statts ;
	From csOperacoes ;
Select crNotas
Select crNotas
	lcQuery = [Select a.NFiscals, a.Parcs, b.ImpDFProNf, b.ImpDFObsNf, d.ImpdfRefNf, b.Distribs, ] + ;
		[From SigCdOpe a ] + ;
		[Left Join SigOpCdd b On a.Dopes = b.Dopes ] + ;
		[Left Join SigOpCdc c On a.Dopes = c.Dopes ] + ;
		[Left Join SigOpCdi d On a.Dopes = d.Dopes ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalOpe]) < 1)
	Select LocalOpe
	lcQuery = [Select Emps, NFis, CFis, Series, Emis, DtSaidas, Operas, CodServs, Fretes, VlFretes, ] + ;
		[From SigMvNfi ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalNFis]) < 1)
	Select LocalNFis
	lcQuery = [Select ContaOs, ContaDs, Datas, ValInis, Valos, ValVars, ContaEs, LocalEnts, Obses, PedidoWeb, IDEntrega ] + ;
		[From SigMvCab ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalEest]) < 1)
	Select LocalEest
	lcQuery = [Select * From SigCdEmp Where CEmps = '] + lcEmpEmi + [']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
	Select LocalEmp
	lcQuery = [Select SitTrIcms From SigMvItn Where EmpDopNums = '] + lcEdn + [']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crSTEestI]) < 1)
	Select crSTEestI
	lcQuery = [Select Cpfs From SigCdCli Where IClis = '] + LocalEmp.confranqs + [']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalCliC]) < 1)
	lcQuery = [Select Razaos, RClis, Cpfs, Endes, Nums, Compls, Bairs, Ceps, Cidas, Estas, Paises, Tel1s, ] + ;
		[From SigCdCli a join sigcdgcr b on a.grupos = b.codigos ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalCliD]) < 1)
	Select LocalCliD
	lcQuery = [Select * From SigCdUfd Where Codigos = '] + lcUFO + [' and destinos = ']+lcUFD + [']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalUFD]) < 1)
	Select LocalCliD
	lcQuery = [Select Codigos, Descricaos, IPIcst, PIScst, COFcst, ISSqnl, CgerGia1s, CTISSQN, AliqISSQN, RetTribs, AliqPis, AliqCofins, ] + ;
		[AliqII, frticms From SigCdCfo ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalCfo]) < 1)
	Select LocalCfo
	lcQuery = [Select Modelos ] + ;
		[From SigCdSer ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalSer]) < 1)
	Select LocalSer
	lcQuery = [Select a.Parcs, a.Datas, a.Vencs, a.Valos, b.ncodfinzs ] + ;
		[From SigMvPar a, sigopfp b ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalPar]) < 1)
	Select LocalPar
	Select LocalPar
		lcQuery = [Select Cpfs ] + ;
			[From SigCdCli ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalCliE]) < 1)
		Select LocalCliE
	lcQuery = [Select b.Ean13, a.CPros, a.DPros, b.DescFis, a.CUnis, a.Qtds, a.Units, a.Totas, a.Obs, a.SitTrIcms, ] + ;
		[From SigMvItn a, SigCdPro b, SigOpCdc c, SigCdCfo f ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalEestI]) < 1)
		Select cItens,SitTrIcms From localEesti Where Val(SitTrIcms) <  100 Into Cursor curAux
		Select cItens,SitTrIcms From localEesti Where Val(SitTrIcms) >= 100 Into Cursor curAux
		Select curAux
	Select localEesti
	Select localEesti
		lcQuery = [Select unidades, aliqfcp, cest From SigCdClf Where Codigos = '] + localEesti.ClFiscals + [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalClf]) < 1)
		lcQuery = [Select nfcis, cimps From Sigmvfci Where cpros = '] + localEesti.cpros + [' order by datas desc]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalFci]) < 1)
		lcQuery = [Select Codigos, Descricaos, IPIcst, PIScst, COFcst, ISSqnl, CgerGia1s, CTISSQN, AliqISSQN, RetTribs, AliqPis, AliqCofins,] + ;
			[aliqII, frticms From SigCdCfo ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalCfo]) < 1)
		Select LocalCfo
		lcQuery = [Select * From SigCdAlo Where fkchave = '] + LocalUfd.cidchaves + [' and codclasfiscal = ']+localEesti.ClFiscals+[']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalAlo]) < 1)
		lcQuery = [Select * From SigCdAlc Where fkchave = '] + LocalUfd.cidchaves + [' and codcfop = ']+localEesti.Cfops+[']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalAlc]) < 1)
					lcQuery = [Select * From SigCdIbp Where ufs = ']+LocalEmp.Estas+[' and codigo = ']+Alltrim(localEesti.ClFiscals)+[' order by datini desc]
					If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalIbp]) < 1)
					Select LocalIbp
		lcQuery = [Select ITras, Razaos, Endes, Cidas, Estas, Cgcs, Inscs ] + ;
			[From SigPrTrp ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalTra]) < 1)
		Select LocalTra
		Select LocalPar
		Select LocalPar
	Select LocalPar
		Select setfiscal
			Delete File &lcAqN.
	Select crNotas
				Insert Into crSigPrNfe (EmpDopNums, Emps, Dopes, Numes, DataS, Usuars, Arquivos, Notas, cidchaves, ids, lotes, recibos, prots, stats, statts) ;
		If Not Thisform.poDataMgr.Update([crSigPrNfe])
			=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
					Insert Into crSigPrNfe (EmpDopNums, Emps, Dopes, Numes, DataS, Usuars, cidchaves, ids, lotes, recibos, prots, stats) ;
					If Not Thisform.poDataMgr.Update([crSigPrNfe])
						=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
Select crNotas
lcQuery = [Select a.Emps, a.Dopes, a.Numes, a.Emis as Datas, a.TotNotas as Valos, a.NFis as Notas, a.Series, a.EmpDopNums, o2.PalmEsts ] + ;
			[From SigMvNfi a, SigCdOpe o, SigOpCdd o2, SigMvCab e ] + ;
		   		 Iif(Empty(ThisForm.pMovimentacao),[ And a.EmpDopNums ] + Iif(llNPr, [Not ], []) + [In (Select b.EmpDopNums From SigPrNfe b) ],[]) + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [csDados]) < 1)
Select csDados
lcQuery = [Select a.* From SigPrNfe a] + cheOpe
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [csNFe1]) < 1)
Select a.* from csNFe1 a where a.EmpDopNums In (Select b.EmpDopNums From csDados b) ORDER BY a.EmpDopNums, a.datas desc into cursor csNFe readwrite 
lcQuery = [Select a.Emps, a.Cods as Series, a.ImpNfs ] + ;
			[From SigCdSer a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSerie]) < 1)
Select csDados
	Select LocalSerie
	Select csNFe
		Insert Into csOperacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, Notas, Series, Tipos, stats, ids, lotes, recibos, prots, statts) ;
Select csOperacoes
lcQuery = [Select UFIBGEs ] + ;
		    [From SigCdUfs ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalUF]) < 1)
Select LocalUF
lcQuery = [Select Codigos ] + ;
		    [From SigCdPai ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPais]) < 1)
Select LocalPais
lcQuery = [Select a.Codigos ] + ;
		    [From SigCdMun a, SigCdUfs b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMunic]) < 1)
Select LocalMunic
	lcQuery = [Select * From SigCdEmp Where Not Ativas = 2]
	If (.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
	Select LocalEmp
							Delete File &lcOri.
Set Deleted On
	lcQuery = [Select * From SigMvNfi Where empdopnums = '] + lcEDN + [']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crSigMvNfi]) < 1)
	Delete File cPath+[*.XML]
			Delete File cPath+[*.TXT]
		Delete File lcPathNFe + lcPRetorno + [*-nfe-ret.xml]
		Delete File lcPathNFe + lcPRetorno + [*-pro-rec.xml]
		Delete File lcPathNFe + lcPRetorno + [*.err]
		Delete File lcPathNFe + lcPRetorno + [*-sit.XML]
		Delete File &lcOrig
PRIVATE cTo, cAssunto, cAnexo, cCorpo, cFrom, cCC, cServer, cSenha, nPorta
cFrom  = ALLTRIM(LocalEmp.emailnfe)
	DELETE FILE &lcDest
		DELETE FILE &lcDest
			DELETE FILE &lcDest
		DELETE FILE &lcDest
			DELETE FILE &lcDest
				DELETE FILE &lcDest
			IF enviaEmail(cTo, cCorpo, cAssunto, cAnexo, cFrom, cCC)
	SELECT crSigMvNfi
	IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
		SELECT crSigmvNfi
		IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
				IF enviaEmail(cTo, cCorpo, cAssunto, cAnexo, cFrom, cCC)
		DELETE FILE &lcDest
		DELETE FILE &lcDest
		DELETE FILE &lcDest
		DELETE FILE &lcDest
		SELECT crSigmvNfi
		IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
Insert   Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b, c8, c8b, c9, c9b, c10, c10b, c11, c11b, c12, c12b, c13, c13b, c14, c14b, c15, c15b, c16, c16b, c17, c17b, c18, c18b, c19, c19b, c20, c20b, c21, c21b, c22, c22b, c23, c23b, c24, c24b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4a, c4b, c5, c5b, c6, c6b, c7, c7b, c8, c8b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b, c8, c8b, c9, c9b, c10, c10b, c11, c11b, c12, c12b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3a, c3b, c4, c4b, c5, c5b, c6, c6b) ;
Insert Into NFTags (c1, c30, c2, c2a, c2b) ;
Insert Into NFTags (c1, c30, c2, c2a, c2b) ;
Insert Into NFTags (c1, c30, c2, c2a, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b, c8, c8b, c9, c9b, c10, c10b, c11, c11b, c12, c12b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c3, c3a, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c13a, c14, c15, c15a, c16, c16a, c17, c18, c18a, c19, c20, c21, ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b, c8, c8b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c2a, c3, c3a, c4, c4a, c5, c5a, c6, c6a, c7, c7a, c8, c8a, c9, c9a, c10, c10a) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2c, c3, c3c) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c2a, c3, c3a, c4, c4a, c5, c5a) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c2a, c3, c3a, c4, c4a, c5, c5a, c6, c6a, c7, c7a, c8, c8a, c9, c9a, c10, c10a, c11, c11a, c12, c12a, c13, c13a, ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7, c8) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b, c3, c3b, c4, c4b, c5, c5b, c6, c6b, c7, c7b) ;
Insert Into NFTags (c1, c30, c2, c2b, c2c) ;
Insert Into NFTags (c1, c30, c2, c2b) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c4a, c5) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c4a) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4) ;
Insert Into NFTags (c1, c30, c2) ;
Insert Into NFTags (c1, c30, c2, c3, c4, c5, c6, c7) ;
Select NFTags
Select NFTags
Select XMLTags
Select NFDados
Append From &lcTxt Delimited With Character "|"
Select NFDados
Select NFDados
		Select NFDados
			Select NFDados
		Select NFDados
			Select NFDados
			Select NFDados
		Select NFDados
			Select NFDados
			Select NFDados
			Select NFDados
		Select NFDados
		Select NFDados
		Select NFDados
		Select XMLTags
		Select NFDados
				Select NFDados
					Select NFDados
				Select NFDados
						Select NFDados
						Select NFDados
							Select NFDados
						Select NFDados
							Select NFDados
						Select NFDados
							Select NFDados
					Select NFDados
				Select NFDados
			Select NFDados
			Select XMLTags
			Select NFDados
		Select NFDados
			Select NFDados
		Select NFDados
			Select NFDados
		Select NFDados
			Select NFDados
		Select NFDados
			Select NFDados
		Select NFDados
	Select NFDados
Select XMLTags
Delete File &lcArq
Select XMLTags
		Select * From XMLTags Where c1 = cReg Order By c1, c3 Into Cursor aux
		Select XMLTags
		Select XMLTags
SELECT NFTags
			SELECT XMLTags
			select NFTags
			SELECT XMLTags
			select NFTags
SELECT NFTags
			SELECT XMLTags
			select NFTags
SELECT NFDados
PRIVATE cTo, cAssunto, cAnexo, cCorpo, cFrom, cCC, cServer, cSenha, nPorta
DELETE FILE &lcArq
cFrom  = ALLTRIM(LocalEmp.emailnfe)
	DELETE FILE &lcDest
			DELETE FILE &lcArq
			DELETE FILE &lcArq
		IF enviaEmail(cTo, cCorpo, cAssunto, cAnexo, cFrom, cCC)
	SELECT crSigmvNfi
	IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
		DELETE FILE &lcDest
	SELECT crSigmvNfi
	IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
PRIVATE cTo, cAssunto, cAnexo, cCorpo, cFrom, cCC, cServer, cSenha
DELETE FILE &lcArq
			DELETE FILE &lcDest
	DELETE FILE &lcDest
		DELETE FILE &lcDest
		DELETE FILE &lcDest
		DELETE FILE &lcDest
	SELECT crSigmvNfi
	IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
DELETE FILE &lcArq
	DELETE FILE &lcDest
		DELETE FILE &lcDest
			SELECT crNotas
		DELETE FILE &lcDest
DELETE FILE &lcArq
	DELETE FILE &lcDest
		DELETE FILE &lcDest
		DELETE FILE &lcDest
		SELECT crSigmvNfi
		IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
DELETE FILE &lcArq
	DELETE FILE &lcDest
		DELETE FILE &lcDest
	DELETE FILE &lcDest
	SELECT crSigmvNfi
	IF Not ThisForm.poDataMgr.Update([crSigMvNfi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
	SELECT nfdados
	SELECT crNotas
				Insert Into crSigPrNfe (EmpDopNums, Emps, Dopes, Numes, DataS, Usuars, cidchaves, ids, lotes, recibos, prots, stats) ;
				If Not Thisform.poDataMgr.Update([crSigPrNfe])
					=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
	Select crNotas
lcQuery = [Select * From SigCdEmp Where CEmps = '] + pEmp + [']
If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
Set Deleted On
	Delete File cPath+[*.XML]
	lcQ = [Select * from sigmvnfi Where empdopnums = '] + csOperacoes.emps + csOperacoes.dopes + PADL(alltrim(STR(csOperacoes.numes)),6) + [']
	If (Thisform.poDataMgr.SqlExecute(lcQ, [crNf]) < 1)
	insert into csDsimpl (fin, numero, emissao, chavea, chave, linha1e, linha2e, linha1d, linha2d, danfes, prot, prota) ;
	select csDsimpl 
		Select LocalParam
		Select LocalParac
			.DeleteMark   	   = .f.
			.Column1.ControlSource = [csOperacoes.SelImp]
			.Column2.ControlSource  = [csOperacoes.Numes]
			.Column3.ControlSource  = [csOperacoes.Datas]
			.Column4.ControlSource  = [csOperacoes.Valos]
			.Column5.ControlSource  = [csOperacoes.Notas]
			.Column6.ControlSource  = [csOperacoes.Series]
			.Column7.ControlSource  = [csOperacoes.Dopes]
			.Column8.ControlSource  = [csOperacoes.Emps]
			.Column9.ControlSource  = [csOperacoes.stats]
		lcQuery = [Select Cods From SigCdSer Where ImpNfs = 3 Order By Cods]
		If (.poDataMgr.SqlExecute(lcQuery, [LocalSer]) < 1)
	Select SelImp, Count(1) as Selecionados ;
	  From csOperacoes ;
Select csOperacoes
	Select csOperacoes
	Select 1 as nMarca, * From nfAinu where Emps = lcEmp Into Cursor csInutil ReadWrite
	Select csInutil
		.Column1.ControlSource = 'csInutil.Emps'
		.Column2.ControlSource = 'csInutil.Series'
		.Column3.ControlSource = 'csInutil.Notai'
		.Column4.ControlSource = 'csInutil.Notaf'
		.Column5.ControlSource = 'csInutil.Cnpj'
		.Column6.ControlSource = 'csInutil.nMarca'
	lcQuery= [select distinct emps, substring(ids,7,14) as cnpj, substring(ids,23,3) as series, substring(ids,26,9) as notai, substring(ids,26,9) as notaf from sigprnfe where stats = 'xxx' ] 
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [nfAInu]) < 1)
	lcQuery= [select distinct case when substring(ids,7,14) = '12136108000195' then 'SVP' else emps end as emps, ] + ;
			[from sigprnfe where stats = 'EMI' and substring(ids,26,9) <> '' ] + ;
			[select distinct case when substring(ids,5,14) = '12136108000195' then 'SVP' else emps end as emps, ] + ;
			[from sigprnfe where stats = 'INU' and substring(ids,24,9) <> '' ] + ; 
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [nfUsadas]) < 1)
	SELECT * from nfUsadas where cnpj != '              ' order by cnpj, series, notai into cursor nfUsadas1
	SELECT nfUsadas1
				SELECT nfAinu
			SELECT nfUsadas1
		SELECT nfUsadas1
SELECT nfAinu
SELECT nfAinu
Select csInutil
Select Count(1) as Selecionados From csInutil Into Cursor csSelesInu
Select csInutil 
	Select csInutil
		Select csOperacoes
		Select csOperacoes

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS SQL (2200 linhas total):

*-- Linhas 66 a 84:
66:             IF USED("csOperacoes")
67:                 USE IN csOperacoes
68:             ENDIF
69:             CREATE CURSOR csOperacoes (SelImp l(1), Emps c(3), Dopes c(20), ;
70:                 Numes n(6,0), Datas d(8), Valos n(12,2), Notas c(10), Series c(3), ;
71:                 NFMemo m(4), Erros m(4), Tipos n(1), stats c(3), ids c(47), ;
72:                 lotes c(15), recibos c(15), prots c(15), statts c(1))
73:             INDEX ON Notas+Emps+Dopes+STR(Numes,6) TAG Notas
74:             SET NULL OFF
75: 
76:             THIS.ConfigurarPageFrame()
77:             THIS.ConfigurarCabecalho()
78:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
79:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
80:             THIS.ConfigurarOperacoes()
81:             THIS.ConfigurarGrade()
82:             THIS.ConfigurarBotoesForm()
83:             THIS.ConfigurarBotoesGrade()
84:             THIS.ConfigurarCntInu()

*-- Linhas 806 a 924:
806:             .GridLineWidth = 1
807:             .HeaderHeight  = 22
808:             .RowHeight     = 20
809:             .DeleteMark    = .F.
810:             .RecordMark    = .F.
811:             .ScrollBars    = 3
812:             .FontName      = "Tahoma"
813:             .FontSize      = 8
814:         ENDWITH
815: 
816:         *-- Column1: selecao (CheckBox com Sparse=.F.)
817:         WITH loc_oGrd.Column1
818:             .Width         = 25
819:             .ReadOnly      = .F.
820:             .ControlSource = "csOperacoes.SelImp"
821:         ENDWITH
822:         WITH loc_oGrd.Column1.Header1
823:             .Caption = ""
824:         ENDWITH
825:         loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
826:         WITH loc_oGrd.Column1.chk_4c_SelImp
827:             .Caption   = ""
828:             .Width     = 22
829:             .Height    = 17
830:             .BackStyle = 0
831:         ENDWITH
832:         loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
833:         loc_oGrd.Column1.Sparse         = .F.
834: 
835:         *-- Column2: Codigo (Dopes)
836:         WITH loc_oGrd.Column2
837:             .Width         = 185
838:             .ReadOnly      = .T.
839:             .ControlSource = "csOperacoes.Dopes"
840:         ENDWITH
841:         WITH loc_oGrd.Column2.Header1
842:             .Caption = "C" + CHR(243) + "digo"
843:         ENDWITH
844: 
845:         *-- Column3: Emissao (Datas)
846:         WITH loc_oGrd.Column3
847:             .Width         = 80
848:             .ReadOnly      = .T.
849:             .ControlSource = "csOperacoes.Datas"
850:         ENDWITH
851:         WITH loc_oGrd.Column3.Header1
852:             .Caption = "Emiss" + CHR(227) + "o"
853:         ENDWITH
854: 
855:         *-- Column4: Valor (Valos)
856:         WITH loc_oGrd.Column4
857:             .Width         = 100
858:             .ReadOnly      = .T.
859:             .ControlSource = "csOperacoes.Valos"
860:         ENDWITH
861:         WITH loc_oGrd.Column4.Header1
862:             .Caption = "Valor"
863:         ENDWITH
864: 
865:         *-- Column5: Nota Fiscal (Notas)
866:         WITH loc_oGrd.Column5
867:             .Width         = 80
868:             .ReadOnly      = .T.
869:             .ControlSource = "csOperacoes.Notas"
870:         ENDWITH
871:         WITH loc_oGrd.Column5.Header1
872:             .Caption = "Nota Fiscal"
873:         ENDWITH
874: 
875:         *-- Column6: Serie (Series)
876:         WITH loc_oGrd.Column6
877:             .Width         = 50
878:             .ReadOnly      = .T.
879:             .ControlSource = "csOperacoes.Series"
880:         ENDWITH
881:         WITH loc_oGrd.Column6.Header1
882:             .Caption = "S" + CHR(233) + "rie"
883:         ENDWITH
884: 
885:         *-- Column7: Movimentacao (Tipos)
886:         WITH loc_oGrd.Column7
887:             .Width         = 95
888:             .ReadOnly      = .T.
889:             .ControlSource = "csOperacoes.Tipos"
890:         ENDWITH
891:         WITH loc_oGrd.Column7.Header1
892:             .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
893:         ENDWITH
894: 
895:         *-- Column8: Empresa (Emps)
896:         WITH loc_oGrd.Column8
897:             .Width         = 50
898:             .ReadOnly      = .T.
899:             .ControlSource = "csOperacoes.Emps"
900:         ENDWITH
901:         WITH loc_oGrd.Column8.Header1
902:             .Caption = "Emp"
903:         ENDWITH
904: 
905:         *-- Column9: Status (stats)
906:         WITH loc_oGrd.Column9
907:             .Width         = 148
908:             .ReadOnly      = .T.
909:             .ControlSource = "csOperacoes.stats"
910:         ENDWITH
911:         WITH loc_oGrd.Column9.Header1
912:             .Caption = "Stat"
913:         ENDWITH
914:     ENDPROC
915: 
916:     *==========================================================================
917:     PROTECTED PROCEDURE ConfigurarBotoesForm()
918:     *==========================================================================
919:         *-- Botao Selecionar
920:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
921:         WITH THIS.cmd_4c_Selecionar
922:             .Top             = 83
923:             .Left            = 843
924:             .Width           = 75

*-- Linhas 1191 a 1253:
1191:             .GridLineWidth = 1
1192:             .HeaderHeight  = 22
1193:             .RowHeight     = 20
1194:             .DeleteMark    = .F.
1195:             .RecordMark    = .F.
1196:             .ScrollBars    = 3
1197:             .FontName      = "Tahoma"
1198:             .FontSize      = 8
1199:         ENDWITH
1200: 
1201:         WITH loc_oGrd.Column1
1202:             .Width         = 35
1203:             .ControlSource = "csInutil.emps"
1204:         ENDWITH
1205:         WITH loc_oGrd.Column1.Header1
1206:             .Caption = "Emp"
1207:         ENDWITH
1208:         WITH loc_oGrd.Column2
1209:             .Width         = 40
1210:             .ControlSource = "csInutil.series"
1211:         ENDWITH
1212:         WITH loc_oGrd.Column2.Header1
1213:             .Caption = "S" + CHR(233) + "rie"
1214:         ENDWITH
1215:         WITH loc_oGrd.Column3
1216:             .Width         = 70
1217:             .ControlSource = "csInutil.notai"
1218:         ENDWITH
1219:         WITH loc_oGrd.Column3.Header1
1220:             .Caption = "Nota Inicial"
1221:         ENDWITH
1222:         WITH loc_oGrd.Column4
1223:             .Width         = 70
1224:             .ControlSource = "csInutil.notaf"
1225:         ENDWITH
1226:         WITH loc_oGrd.Column4.Header1
1227:             .Caption = "Nota Final"
1228:         ENDWITH
1229:         WITH loc_oGrd.Column5
1230:             .Width         = 105
1231:             .ControlSource = "csInutil.cnpj"
1232:         ENDWITH
1233:         WITH loc_oGrd.Column5.Header1
1234:             .Caption = "CPF/CNPJ"
1235:         ENDWITH
1236:         WITH loc_oGrd.Column6
1237:             .Width         = 62
1238:             .ControlSource = "csInutil.nMarca"
1239:         ENDWITH
1240:         WITH loc_oGrd.Column6.Header1
1241:             .Caption = ""
1242:         ENDWITH
1243:         loc_oGrd.Column6.AddObject("chk_4c_SelInu", "CheckBox")
1244:         WITH loc_oGrd.Column6.chk_4c_SelInu
1245:             .Caption   = ""
1246:             .Width     = 60
1247:             .Height    = 17
1248:             .BackStyle = 0
1249:         ENDWITH
1250:         loc_oGrd.Column6.CurrentControl = "chk_4c_SelInu"
1251:         loc_oGrd.Column6.Sparse         = .F.
1252:     ENDPROC
1253: 

*-- Linhas 1461 a 1479:
1461: 
1462:         THIS.HabilitarControles(.F.)
1463: 
1464:         SELECT csOperacoes
1465:         SET ORDER TO Notas
1466:         GO TOP IN csOperacoes
1467:         IF EOF("csOperacoes")
1468:             IF INLIST(loc_nAcao, 1, 2, 3, 5)
1469:                 MsgAviso("Nenhuma Nota Foi Encontrada Para Processamento!!!")
1470:                 THIS.LimpaSelecao()
1471:                 THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
1472:             ENDIF
1473:         ELSE
1474:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1475:         ENDIF
1476:     ENDPROC
1477: 
1478:     PROCEDURE BtnLimparClick()
1479:         THIS.LimpaSelecao()

*-- Linhas 1486 a 1504:
1486:             IF USED("cursor_4c_SelChk")
1487:                 USE IN cursor_4c_SelChk
1488:             ENDIF
1489:             SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelChk
1490:             loc_nSel = cursor_4c_SelChk.nSel
1491:             USE IN cursor_4c_SelChk
1492:             IF loc_nSel < 1
1493:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado para Processamento!!!")
1494:                 THIS.cnt_4c_Grade.grd_4c_Operacoes.SetFocus()
1495:                 RETURN
1496:             ENDIF
1497:         ENDIF
1498:         loc_oBO = THIS.this_oBusinessObject
1499:         loc_oBO.this_nAcao      = loc_nAcao
1500:         loc_oBO.this_nAmbiente  = THIS.cnt_4c_Operacoes.opt_4c_Ambiente.Value
1501:         loc_oBO.this_nTipos     = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1502:         loc_oBO.this_nImpressao = THIS.cnt_4c_Operacoes.opt_4c_Impressao.Value
1503:         loc_oBO.this_nContin    = THIS.cnt_4c_Operacoes.opt_4c_Contin.Value
1504:         loc_oBO.this_cArquivos  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value)

*-- Linhas 1523 a 1563:
1523: 
1524:     PROCEDURE BtnMarcaTudoClick()
1525:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1526:             SELECT csOperacoes
1527:             REPLACE ALL SelImp WITH .T.
1528:             GO TOP IN csOperacoes
1529:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1530:         ENDIF
1531:     ENDPROC
1532: 
1533:     PROCEDURE BtnDesmarcarClick()
1534:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1535:             SELECT csOperacoes
1536:             REPLACE ALL SelImp WITH .F.
1537:             GO TOP IN csOperacoes
1538:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1539:         ENDIF
1540:     ENDPROC
1541: 
1542:     PROCEDURE BtnDocumentosClick()
1543:         LOCAL loc_cDopes, loc_nNumes, loc_cEmps, loc_oForm, loc_oErro
1544:         IF !USED("csOperacoes") OR EOF("csOperacoes")
1545:             MsgAviso("Posicione o cursor em um registro.")
1546:             RETURN
1547:         ENDIF
1548:         SELECT csOperacoes
1549:         loc_cDopes = ALLTRIM(csOperacoes.Dopes)
1550:         loc_nNumes = csOperacoes.Numes
1551:         loc_cEmps  = ALLTRIM(csOperacoes.Emps)
1552:         TRY
1553:             loc_oForm = CREATEOBJECT("Formsigmvexp", loc_cDopes, "C", loc_nNumes, loc_cEmps)
1554:             IF VARTYPE(loc_oForm) = "O"
1555:                 loc_oForm.Show()
1556:             ELSE
1557:                 MsgErro("Erro ao criar Formsigmvexp. VARTYPE retornou: " + ;
1558:                         VARTYPE(loc_oForm), "Documentos")
1559:             ENDIF
1560:         CATCH TO loc_oErro
1561:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1562:                     "Erro ao abrir Documentos")
1563:         ENDTRY

*-- Linhas 1600 a 1618:
1600:         loc_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1601:         loc_cNIni   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1602:         loc_cNFim   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1603:         SELECT csInutil
1604:         GO TOP IN csInutil
1605:         loc_cCnpj = ALLTRIM(csInutil.cnpj)
1606:         loc_oBO = THIS.this_oBusinessObject
1607:         TRY
1608:             loc_oBO.ProcessaInutilizadas(loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim)
1609:         CATCH TO loc_oErro
1610:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1611:                     "Erro Inutilizar")
1612:         ENDTRY
1613:         THIS.AlternarPagina(1)
1614:     ENDPROC
1615: 
1616:     PROCEDURE AcaoInteractiveChange()
1617:         IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1618:             THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;

*-- Linhas 1632 a 1651:
1632:             *-- Carrega nfAinu com gap analysis via BO
1633:             loc_oBO.SelecionarInutilizadas(loc_cEmps)
1634:             IF USED("nfAinu")
1635:                 SELECT 1 AS nMarca, emps, series, notai, notaf, cnpj ;
1636:                     FROM nfAinu ;
1637:                     WHERE RTRIM(emps) = RTRIM(loc_cEmps) ;
1638:                     INTO CURSOR csInutil READWRITE
1639:                 IF USED("csInutil") AND RECCOUNT("csInutil") > 0
1640:                     GO TOP IN csInutil
1641:                     THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
1642:                     THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
1643:                     THIS.AlternarPagina(2)
1644:                 ELSE
1645:                     MsgAviso("Nenhuma nota para inutilizar encontrada para esta empresa.")
1646:                 ENDIF
1647:             ELSE
1648:                 MsgAviso("Nenhuma nota para inutilizar encontrada.")
1649:             ENDIF
1650:         CATCH TO loc_oErro
1651:             MsgErro(loc_oErro.Message, "Erro CmdInu")

*-- Linhas 1739 a 1759:
1739:             RETURN
1740:         ENDIF
1741:         TRY
1742:             loc_nResult = SQLEXEC(gnConnHandle, ;
1743:                 "SELECT Cods FROM SigCdSer WHERE ImpNfs = 3 AND LTRIM(RTRIM(Cods)) = " + ;
1744:                 EscaparSQL(loc_cSeries), "cursor_4c_SerValid")
1745:             IF loc_nResult > 0 AND USED("cursor_4c_SerValid") AND !EOF("cursor_4c_SerValid")
1746:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_SerValid.Cods)
1747:             ELSE
1748:                 THIS.AbrirBuscaSeries()
1749:             ENDIF
1750:             IF USED("cursor_4c_SerValid")
1751:                 USE IN cursor_4c_SerValid
1752:             ENDIF
1753:         CATCH TO loc_oErro
1754:             MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
1755:         ENDTRY
1756:     ENDPROC
1757: 
1758:     PROCEDURE AbrirBuscaSeries()
1759:         LOCAL loc_oBusca, loc_cCods, loc_oErro

*-- Linhas 1788 a 1818:
1788:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
1789:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1790:             m.SelImp = (NOT csOperacoes.SelImp)
1791:             SELECT csOperacoes
1792:             GATHER MEMVAR FIELDS SelImp
1793:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1794:         ENDIF
1795:         NODEFAULT
1796:     ENDPROC
1797: 
1798:     *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
1799:     PROCEDURE GridChkKeyPress
1800:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1801:         IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
1802:             m.SelImp = (NOT csOperacoes.SelImp)
1803:             SELECT csOperacoes
1804:             GATHER MEMVAR FIELDS SelImp
1805:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1806:             NODEFAULT
1807:         ENDIF
1808:     ENDPROC
1809: 
1810:     PROCEDURE LimpaSelecao()
1811:         IF USED("csOperacoes")
1812:             ZAP IN csOperacoes
1813:         ENDIF
1814:         THIS.HabilitarControles(.T.)
1815:         THIS.cmd_4c_ImpDSimpl.Enabled = .F.
1816:         THIS.Refresh()
1817:     ENDPROC
1818: 

*-- Linhas 1866 a 1917:
1866:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize Incluir primeiro.")
1867:             RETURN
1868:         ENDIF
1869:         SELECT csOperacoes
1870:         IF EOF("csOperacoes")
1871:             GO TOP IN csOperacoes
1872:         ENDIF
1873:         IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
1874:             MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
1875:             RETURN
1876:         ENDIF
1877:         THIS.BtnDocumentosClick()
1878:     ENDPROC
1879: 
1880:     PROCEDURE BtnVisualizarClick()
1881:         * Visualizar detalhes tecnicos (chave, protocolo, status)
1882:         * da nota fiscal apontada. Consulta SigMvNfi diretamente
1883:         * para exibir dados que nao aparecem no grid principal.
1884:         LOCAL loc_cChave, loc_cSQL, loc_oErro, loc_cMsg
1885:         LOCAL loc_cChv, loc_cProt, loc_cStat, loc_cXml
1886:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1887:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
1888:             RETURN
1889:         ENDIF
1890:         SELECT csOperacoes
1891:         IF EOF("csOperacoes")
1892:             GO TOP IN csOperacoes
1893:         ENDIF
1894:         loc_cChave = ALLTRIM(csOperacoes.Emps) + ALLTRIM(csOperacoes.Dopes) + ;
1895:                      PADL(ALLTRIM(TRANSFORM(csOperacoes.Numes)), 6, "0")
1896:         loc_cSQL = "SELECT TOP 1 nfechv, nfexml, prots, stats FROM SigMvNfi WHERE empdopnums = " + ;
1897:                    EscaparSQL(loc_cChave)
1898:         TRY
1899:             IF USED("cursor_4c_VisNfe")
1900:                 USE IN cursor_4c_VisNfe
1901:             ENDIF
1902:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisNfe") < 1
1903:                 MsgErro("Falha ao consultar SigMvNfi para a nota selecionada.", "Visualizar")
1904:                 RETURN
1905:             ENDIF
1906:             IF RECCOUNT("cursor_4c_VisNfe") = 0
1907:                 MsgAviso("Nota fiscal ainda n" + CHR(227) + "o transmitida (sem registro em SigMvNfi).")
1908:             ELSE
1909:                 loc_cChv  = ALLTRIM(NVL(cursor_4c_VisNfe.nfechv, "N/D"))
1910:                 loc_cProt = ALLTRIM(NVL(cursor_4c_VisNfe.prots, "N/D"))
1911:                 loc_cStat = ALLTRIM(NVL(cursor_4c_VisNfe.stats, "N/D"))
1912:                 loc_cXml  = IIF(EMPTY(NVL(cursor_4c_VisNfe.nfexml, "")), "N" + CHR(227) + "o", "Sim")
1913:                 loc_cMsg = "Nota: " + ALLTRIM(csOperacoes.Notas) + CHR(13) + ;
1914:                            "S" + CHR(233) + "rie: " + ALLTRIM(csOperacoes.Series) + CHR(13) + ;
1915:                            "Chave: " + loc_cChv + CHR(13) + ;
1916:                            "Protocolo: " + loc_cProt + CHR(13) + ;
1917:                            "Status: " + loc_cStat + CHR(13) + ;

*-- Linhas 2062 a 2081:
2062:         loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)
2063:         loc_oCnt.chk_4c_OptArq.Value = IIF(loc_oBO.this_lOptArq, 1, 0)
2064: 
2065:         *-- Bloco 3: registro corrente reflete csOperacoes via ControlSource do
2066:         *-- grid. Refresh forca releitura dos ControlSource apos alteracao no BO.
2067:         THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
2068:         RETURN .T.
2069:     ENDPROC
2070: 
2071:     *--------------------------------------------------------------------------
2072:     * HabilitarCampos - Interface CRUD-padrao. Delega para HabilitarControles
2073:     * (nome nativo deste form OPERACIONAL) que implementa a logica real de
2074:     * bloquear filtros durante processamento.
2075:     *--------------------------------------------------------------------------
2076:     PROCEDURE HabilitarCampos(par_lHabilitar)
2077:         LOCAL loc_lHab
2078:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2079:         THIS.HabilitarControles(loc_lHab)
2080:     ENDPROC
2081: 

*-- Linhas 2154 a 2172:
2154:             MsgAviso("A fila de processamento est" + CHR(225) + " vazia. Use Buscar/Selecionar antes.")
2155:             RETURN
2156:         ENDIF
2157:         SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelSalv
2158:         loc_nSel = cursor_4c_SelSalv.nSel
2159:         USE IN cursor_4c_SelSalv
2160:         IF loc_nSel < 1
2161:             MsgAviso("Nenhuma nota est" + CHR(225) + " marcada para processamento.")
2162:             RETURN
2163:         ENDIF
2164:         THIS.FormParaBO()
2165:         THIS.BtnCopiarClick()
2166:     ENDPROC
2167: 
2168:     *--------------------------------------------------------------------------
2169:     * BtnCancelarClick - Interface CRUD-padrao. Cancela a selecao atual e
2170:     * reabilita os filtros de busca (equivale ao Limpar do form legado).
2171:     *--------------------------------------------------------------------------
2172:     PROCEDURE BtnCancelarClick()

