# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, FRETE, FRETEDEFS, CEMPS, ICLIS, LNCOMST, LCUFO, CODIGOS, DESTINOS, CODS, 0, LNTOP, LCFIN, LCCFOD, LCPRE, TPEMIS, LNTAM, LCMOD, LCUFD, SITTRICMS, CPROS, CITENS, FKCHAVE, CODCLASFISCAL, CODCFOP, LCOMC, UFS, CODIGO, LCCST, LNFIN, EXICBSIMP, LCP, VALIPIS, VALICMS, CGERGIA1S, P, IF, ITRAS, LNFPG, EMIS, IMPNFS, EMPS, SERIES, I, ESTADOS, DESCS, LNONE, LNVEZ, STATS, C1, J, DV, LCARQ, ESTAS, CNPJ, FPAGS, CFOPS, NFC, OPERS, LCANCELAS, UFIBGES, LCDEST
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, FRETE, FRETEDEFS, CEMPS, ICLIS, LNCOMST, LCUFO, CODIGOS, DESTINOS, CODS, 0, LNTOP, LCFIN, LCCFOD, LCPRE, TPEMIS, LNTAM, LCMOD, LCUFD, SITTRICMS, CPROS, CITENS, FKCHAVE, CODCLASFISCAL, CODCFOP, LCOMC, UFS, CODIGO, LCCST, LNFIN, EXICBSIMP, LCP, VALIPIS, VALICMS, CGERGIA1S, P, IF, ITRAS, LNFPG, EMIS, IMPNFS, EMPS, SERIES, I, ESTADOS, DESCS, LNONE, LNVEZ, STATS, C1, J, DV, LCARQ, ESTAS, CNPJ, FPAGS, CFOPS, NFC, OPERS, LCANCELAS, UFIBGES, LCDEST
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMARCA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, FRETE, FRETEDEFS, CEMPS, ICLIS, LNCOMST, LCUFO, CODIGOS, DESTINOS, CODS, 0, LNTOP, LCFIN, LCCFOD, LCPRE, TPEMIS, LNTAM, LCMOD, LCUFD, SITTRICMS, CPROS, CITENS, FKCHAVE, CODCLASFISCAL, CODCFOP, LCOMC, UFS, CODIGO, LCCST, LNFIN, EXICBSIMP, LCP, VALIPIS, VALICMS, CGERGIA1S, P, IF, ITRAS, LNFPG, EMIS, IMPNFS, EMPS, SERIES, I, ESTADOS, DESCS, LNONE, LNVEZ, STATS, C1, J, DV, LCARQ, ESTAS, CNPJ, FPAGS, CFOPS, NFC, OPERS, LCANCELAS, UFIBGES, LCDEST

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS SQL (3428 linhas total):

*-- Linhas 1103 a 1121:
1103:                 ENDIF
1104: 
1105:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSerie")
1106:                     SELECT cursor_4c_BuscaSerie
1107:                     THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_BuscaSerie.Cods)
1108:                 ENDIF
1109: 
1110:                 IF USED("cursor_4c_BuscaSerie")
1111:                     USE IN cursor_4c_BuscaSerie
1112:                 ENDIF
1113:                 loc_oBusca.Release()
1114:             ENDIF
1115:         CATCH TO loc_oErro
1116:             MsgErro(loc_oErro.Message + CHR(13) + ;
1117:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1118:                     "Procedure: " + loc_oErro.Procedure, ;
1119:                     "Erro ao buscar a s" + CHR(233) + "rie")
1120:         ENDTRY
1121:     ENDPROC

*-- Linhas 1131 a 1161:
1131:     *
1132:     * O cursor_4c_Operacoes (csOperacoes do legado) nasce aqui VAZIO e e
1133:     * povoado por THIS.CarregarLista() -> sigprnfeBO.BuscarOperacoes().
1134:     * Column.ControlSource exige o cursor JA existir antes do bind (regra
1135:     * #41), por isso a estrutura abaixo e criada ANTES do AddObject do Grid,
1136:     * com os MESMOS nomes/ordem de campos do "Create Cursor csOperacoes" do
1137:     * legado (Processamento/Init).
1138:     *--------------------------------------------------------------------------
1139:     PROTECTED PROCEDURE ConfigurarGrade()
1140:         LOCAL loc_oCnt, loc_oGrd
1141: 
1142:         IF USED("cursor_4c_Operacoes")
1143:             USE IN cursor_4c_Operacoes
1144:         ENDIF
1145:         SET NULL ON
1146:         CREATE CURSOR cursor_4c_Operacoes ( ;
1147:             SelImp   L, ;
1148:             Emps     C(3), ;
1149:             Dopes    C(20), ;
1150:             Numes    N(6), ;
1151:             Datas    D, ;
1152:             Valos    N(12,2), ;
1153:             Notas    C(10), ;
1154:             Series   C(3), ;
1155:             NFMemo   M, ;
1156:             Erros    M, ;
1157:             Tipos    N(1), ;
1158:             stats    C(3), ;
1159:             ids      C(47), ;
1160:             lotes    C(15), ;
1161:             recibos  C(15), ;

*-- Linhas 1188 a 1221:
1188:             .FontSize      = 8
1189:             .AllowHeaderSizing = .F.
1190:             .AllowRowSizing    = .F.
1191:             .DeleteMark    = .F.
1192:             .RecordMark    = .F.
1193:             .HeaderHeight  = 16
1194:             .RowHeight     = 16
1195:             .ScrollBars    = 2
1196:             .GridLineColor = RGB(238, 238, 238)
1197:             .ColumnCount   = 9
1198:             .RecordSource  = "cursor_4c_Operacoes"
1199:             .Visible       = .T.
1200:         ENDWITH
1201: 
1202:         *-- Column1: Check1 (SelImp) - unica coluna editavel da grade
1203:         loc_oGrd.Column1.AddObject("chk_4c_Check1", "CheckBox")
1204:         WITH loc_oGrd.Column1
1205:             .Width          = 19
1206:             .ControlSource  = "cursor_4c_Operacoes.SelImp"
1207:             .CurrentControl = "chk_4c_Check1"
1208:             .Sparse         = .F.
1209:             .Header1.Caption   = ""
1210:             .Header1.Alignment = 2
1211:             .Header1.ForeColor = RGB(36, 84, 155)
1212:         ENDWITH
1213:         WITH loc_oGrd.Column1.chk_4c_Check1
1214:             .Top         = 9
1215:             .Left        = 2
1216:             .Height      = 17
1217:             .Width       = 22
1218:             .Alignment   = 0
1219:             .Caption     = ""
1220:             .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
1221:             .ReadOnly    = .F.

*-- Linhas 1239 a 1358:
1239:         *-- Column2: Codigo (Dopes)
1240:         WITH loc_oGrd.Column2
1241:             .Width          = 63
1242:             .ControlSource  = "cursor_4c_Operacoes.Dopes"
1243:             .Header1.Caption   = "C" + CHR(243) + "digo"
1244:             .Header1.Alignment = 2
1245:             .Header1.ForeColor = RGB(36, 84, 155)
1246:             .Text1.BorderStyle = 1
1247:             .Text1.Margin      = 0
1248:             .Text1.ReadOnly    = .T.
1249:             .Text1.ForeColor   = RGB(0, 0, 0)
1250:             .Text1.ToolTipText = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o na Origem"
1251:         ENDWITH
1252: 
1253:         *-- Column3: Emissao (Datas)
1254:         WITH loc_oGrd.Column3
1255:             .Width          = 80
1256:             .ControlSource  = "cursor_4c_Operacoes.Datas"
1257:             .Header1.Caption   = "Emiss" + CHR(227) + "o"
1258:             .Header1.Alignment = 2
1259:             .Header1.ForeColor = RGB(36, 84, 155)
1260:             .Text1.Margin      = 0
1261:             .Text1.ReadOnly    = .T.
1262:             .Text1.ToolTipText = "Data da Opera" + CHR(231) + CHR(227) + "o na Origem"
1263:         ENDWITH
1264: 
1265:         *-- Column4: Valor (Valos)
1266:         WITH loc_oGrd.Column4
1267:             .Width          = 129
1268:             .ControlSource  = "cursor_4c_Operacoes.Valos"
1269:             .Header1.Caption   = "Valor"
1270:             .Header1.Alignment = 2
1271:             .Header1.ForeColor = RGB(36, 84, 155)
1272:             .Text1.BorderStyle = 0
1273:             .Text1.Margin      = 0
1274:             .Text1.ReadOnly    = .T.
1275:             .Text1.ForeColor   = RGB(0, 0, 0)
1276:             .Text1.BackColor   = RGB(255, 255, 255)
1277:             .Text1.ToolTipText = "Valor da Opera" + CHR(231) + CHR(227) + "o na Origem"
1278:         ENDWITH
1279: 
1280:         *-- Column5: Nota Fiscal (Notas)
1281:         WITH loc_oGrd.Column5
1282:             .Width          = 75
1283:             .ControlSource  = "cursor_4c_Operacoes.Notas"
1284:             .Header1.Caption   = "Nota Fiscal"
1285:             .Header1.Alignment = 2
1286:             .Header1.ForeColor = RGB(36, 84, 155)
1287:             .Text1.BorderStyle = 0
1288:             .Text1.Margin      = 0
1289:             .Text1.ReadOnly    = .T.
1290:             .Text1.ForeColor   = RGB(0, 0, 0)
1291:             .Text1.BackColor   = RGB(255, 255, 255)
1292:             .Text1.ToolTipText = "Documento da Opera" + CHR(231) + CHR(227) + "o na Origem"
1293:         ENDWITH
1294: 
1295:         *-- Column6: Serie (Series)
1296:         WITH loc_oGrd.Column6
1297:             .Width          = 40
1298:             .ControlSource  = "cursor_4c_Operacoes.Series"
1299:             .Header1.Caption   = "S" + CHR(233) + "rie"
1300:             .Header1.Alignment = 2
1301:             .Header1.ForeColor = RGB(36, 84, 155)
1302:             .Text1.BorderStyle = 0
1303:             .Text1.Margin      = 0
1304:             .Text1.ReadOnly    = .T.
1305:             .Text1.ForeColor   = RGB(0, 0, 0)
1306:             .Text1.BackColor   = RGB(255, 255, 255)
1307:             .Text1.ToolTipText = "Usu" + CHR(225) + "rio Que Gerou a Opera" + CHR(231) + CHR(227) + "o na Origem"
1308:         ENDWITH
1309: 
1310:         *-- Column7: Movimentacao (Numes)
1311:         WITH loc_oGrd.Column7
1312:             .Width          = 307
1313:             .ControlSource  = "cursor_4c_Operacoes.Numes"
1314:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1315:             .Header1.Alignment = 2
1316:             .Header1.ForeColor = RGB(36, 84, 155)
1317:             .Text1.BorderStyle = 0
1318:             .Text1.Margin      = 0
1319:             .Text1.ReadOnly    = .T.
1320:             .Text1.ForeColor   = RGB(0, 0, 0)
1321:             .Text1.BackColor   = RGB(255, 255, 255)
1322:             .Text1.ToolTipText = "Conta de Origem da Opera" + CHR(231) + CHR(227) + "o na Origem"
1323:         ENDWITH
1324: 
1325:         *-- Column8: Emp (Emps)
1326:         WITH loc_oGrd.Column8
1327:             .Width          = 38
1328:             .ControlSource  = "cursor_4c_Operacoes.Emps"
1329:             .Header1.Caption   = "Emp"
1330:             .Header1.Alignment = 2
1331:             .Header1.ForeColor = RGB(36, 84, 155)
1332:             .Text1.BorderStyle = 0
1333:             .Text1.Margin      = 0
1334:             .Text1.ReadOnly    = .T.
1335:             .Text1.ForeColor   = RGB(0, 0, 0)
1336:             .Text1.BackColor   = RGB(255, 255, 255)
1337:             .Text1.ToolTipText = "Conta de Destino da Opera" + CHR(231) + CHR(227) + "o na Origem"
1338:         ENDWITH
1339: 
1340:         *-- Column9: Stat (stats)
1341:         WITH loc_oGrd.Column9
1342:             .Width          = 33
1343:             .ControlSource  = "cursor_4c_Operacoes.stats"
1344:             .Header1.Caption   = "Stat"
1345:             .Header1.Alignment = 2
1346:             .Header1.ForeColor = RGB(36, 84, 155)
1347:             .Text1.Alignment   = 2
1348:             .Text1.BorderStyle = 0
1349:             .Text1.Margin      = 0
1350:             .Text1.ReadOnly    = .T.
1351:             .Text1.ForeColor   = RGB(0, 0, 0)
1352:             .Text1.BackColor   = RGB(255, 255, 255)
1353:         ENDWITH
1354:     ENDPROC
1355: 
1356:     *--------------------------------------------------------------------------
1357:     * ConfigurarBotoesAcao - Grupos de botoes de acao do form principal:
1358:     * cmdBtnForm (Limpar Selecao/Processar/Encerrar), cmdSelecionar (botao

*-- Linhas 1607 a 1654:
1607:     * os botoes Encerrar/Processar. Aberto pelo botao "A inutilizar"
1608:     * (obj_4c_Commandgroup1) - handlers em BtnPrepararInutilizacaoClick.
1609:     *
1610:     * cursor_4c_Inutil espelha o "Select 1 as nMarca, * From nfAinu ...
1611:     * Into Cursor csInutil ReadWrite" do legado (btnInu.Click): nMarca
1612:     * (flag de selecao) + Emps/Cnpj/Series/Notai/Notaf da tabela auxiliar
1613:     * nfAinu. Placeholder vazio aqui - populado pelos metodos de
1614:     * inutilizacao (AbrirPainelInutilizacao) - regra #41.
1615:     *--------------------------------------------------------------------------
1616:     PROTECTED PROCEDURE ConfigurarPainelInutilizacao()
1617:         LOCAL loc_oPnl, loc_oGrd
1618: 
1619:         IF USED("cursor_4c_Inutil")
1620:             USE IN cursor_4c_Inutil
1621:         ENDIF
1622:         SET NULL ON
1623:         CREATE CURSOR cursor_4c_Inutil ( ;
1624:             nMarca N(1), ;
1625:             Emps   C(3), ;
1626:             Cnpj   C(14), ;
1627:             Series C(3), ;
1628:             Notai  C(9), ;
1629:             Notaf  C(9))
1630:         SET NULL OFF
1631: 
1632:         *-- cursor_4c_NotasAInutilizar (nfAinu do legado) - faixas de
1633:         *-- numeracao NAO usadas, calculadas por BtnPrepararInutilizacaoClick
1634:         *-- ("A Inutilizar"). cmdInu.Click (AbrirPainelInutilizacao) filtra
1635:         *-- este cursor pela Empresa digitada para montar cursor_4c_Inutil.
1636:         IF USED("cursor_4c_NotasAInutilizar")
1637:             USE IN cursor_4c_NotasAInutilizar
1638:         ENDIF
1639:         CREATE CURSOR cursor_4c_NotasAInutilizar ( ;
1640:             Emps   C(3), ;
1641:             Cnpj   C(14), ;
1642:             Series C(3), ;
1643:             Notai  C(9), ;
1644:             Notaf  C(9))
1645: 
1646:         THIS.AddObject("cnt_4c_Inu", "Container")
1647:         WITH THIS.cnt_4c_Inu
1648:             .Top           = 156
1649:             .Left          = 203
1650:             .Width         = 504
1651:             .Height        = 392
1652:             .SpecialEffect = 0
1653:             .BackColor     = RGB(255, 255, 255)
1654:             .Visible       = .F.

*-- Linhas 1714 a 1835:
1714:             .Height        = 355
1715:             .FontName      = "Tahoma"
1716:             .FontSize      = 8
1717:             .DeleteMark    = .F.
1718:             .RecordMark    = .F.
1719:             .RowHeight     = 16
1720:             .ScrollBars    = 2
1721:             .GridLineColor = RGB(238, 238, 238)
1722:             .ColumnCount   = 6
1723:             .RecordSource  = "cursor_4c_Inutil"
1724:             .Visible       = .T.
1725:         ENDWITH
1726: 
1727:         *-- ColumnOrder reproduz a ordem visual do legado: Check1 (Column6)
1728:         *-- aparece PRIMEIRO (ColumnOrder=1), seguido por Emp/Serie/Nota
1729:         *-- Inicial/Nota Final/CPF-CNPJ (ColumnOrder 2..6)
1730:         WITH loc_oGrd.Column1
1731:             .ColumnOrder = 2
1732:             .Width       = 40
1733:             .Movable     = .F.
1734:             .Resizable   = .F.
1735:             .ReadOnly    = .T.
1736:             .ControlSource     = "cursor_4c_Inutil.Emps"
1737:             .Header1.Caption   = "Emp"
1738:             .Header1.Alignment = 2
1739:             .Text1.BorderStyle = 0
1740:             .Text1.Margin      = 0
1741:             .Text1.ReadOnly    = .T.
1742:             .Text1.ForeColor   = RGB(0, 0, 0)
1743:             .Text1.BackColor   = RGB(255, 255, 255)
1744:         ENDWITH
1745:         WITH loc_oGrd.Column2
1746:             .ColumnOrder = 3
1747:             .Width       = 50
1748:             .Movable     = .F.
1749:             .Resizable   = .F.
1750:             .ReadOnly    = .T.
1751:             .ControlSource     = "cursor_4c_Inutil.Series"
1752:             .Header1.Caption   = "S" + CHR(233) + "rie"
1753:             .Header1.Alignment = 2
1754:             .Text1.BorderStyle = 0
1755:             .Text1.Margin      = 0
1756:             .Text1.ReadOnly    = .T.
1757:             .Text1.ForeColor   = RGB(0, 0, 0)
1758:             .Text1.BackColor   = RGB(255, 255, 255)
1759:         ENDWITH
1760:         WITH loc_oGrd.Column3
1761:             .ColumnOrder = 4
1762:             .Width       = 70
1763:             .Movable     = .F.
1764:             .Resizable   = .F.
1765:             .ReadOnly    = .T.
1766:             .ControlSource     = "cursor_4c_Inutil.Notai"
1767:             .Header1.Caption   = "Nota Inicial"
1768:             .Header1.Alignment = 2
1769:             .Text1.BorderStyle = 0
1770:             .Text1.Margin      = 0
1771:             .Text1.ReadOnly    = .T.
1772:             .Text1.ForeColor   = RGB(0, 0, 0)
1773:             .Text1.BackColor   = RGB(255, 255, 255)
1774:         ENDWITH
1775:         WITH loc_oGrd.Column4
1776:             .ColumnOrder = 5
1777:             .Width       = 70
1778:             .Movable     = .F.
1779:             .Resizable   = .F.
1780:             .ReadOnly    = .T.
1781:             .ControlSource     = "cursor_4c_Inutil.Notaf"
1782:             .Header1.Caption   = "Nota Final"
1783:             .Header1.Alignment = 2
1784:             .Text1.BorderStyle = 0
1785:             .Text1.Margin      = 0
1786:             .Text1.ReadOnly    = .T.
1787:             .Text1.ForeColor   = RGB(0, 0, 0)
1788:             .Text1.BackColor   = RGB(255, 255, 255)
1789:         ENDWITH
1790:         WITH loc_oGrd.Column5
1791:             .ColumnOrder = 6
1792:             .Width       = 110
1793:             .Movable     = .F.
1794:             .Resizable   = .F.
1795:             .ReadOnly    = .T.
1796:             .ControlSource     = "cursor_4c_Inutil.Cnpj"
1797:             .Header1.Caption   = "CPF/CNPJ"
1798:             .Header1.Alignment = 2
1799:             .Text1.BorderStyle = 0
1800:             .Text1.Margin      = 0
1801:             .Text1.ReadOnly    = .T.
1802:             .Text1.ForeColor   = RGB(0, 0, 0)
1803:             .Text1.BackColor   = RGB(255, 255, 255)
1804:         ENDWITH
1805: 
1806:         *-- Column6: Check1 (nMarca) - unica coluna editavel, 1a na ordem visual
1807:         *-- ORDEM OBRIGATORIA: o ControlSource da COLUNA vem ANTES do
1808:         *-- AddObject do CheckBox. O RecordSource do Grid ja amarrou Column6 ao
1809:         *-- 6o campo do cursor (Notaf, char) e o controle novo HERDA essa
1810:         *-- amarracao: adicionar o CheckBox antes de reapontar a coluna para
1811:         *-- nMarca (numerico) estoura "Error with CHK_4C_CHECK1 - Value : Data
1812:         *-- type mismatch" dentro do Init, o CREATEOBJECT devolve .F. e a tela
1813:         *-- NAO ABRE. Medido no VFP9 em 2026-10-17.
1814:         WITH loc_oGrd.Column6
1815:             .ColumnOrder    = 1
1816:             .Width          = 21
1817:             .Movable        = .F.
1818:             .Resizable      = .F.
1819:             .Sparse         = .F.
1820:             .ControlSource  = "cursor_4c_Inutil.nMarca"
1821:             .Header1.Caption = ""
1822:         ENDWITH
1823:         loc_oGrd.Column6.AddObject("chk_4c_Check1", "CheckBox")
1824:         WITH loc_oGrd.Column6.chk_4c_Check1
1825:             .Top       = 19
1826:             .Left      = 12
1827:             .Height    = 17
1828:             .Width     = 60
1829:             .Alignment = 0
1830:             .Caption   = ""
1831:             .ReadOnly  = .F.
1832:             .Visible   = .T.
1833:         ENDWITH
1834:         *-- CurrentControl por ULTIMO: sem ele a coluna segue desenhando o
1835:         *-- Text1 e o CheckBox nunca aparece (regra #18)

*-- Linhas 2200 a 2218:
2200:                     loc_cDestino = ADDBS(ALLTRIM(par_cBkp)) + loc_cNome
2201:                     COPY FILE (loc_cOrigem) TO (loc_cDestino)
2202:                     IF FILE(loc_cDestino)
2203:                         DELETE FILE (loc_cOrigem)
2204:                     ENDIF
2205:                 ENDIF
2206:             ENDFOR
2207:         CATCH TO loc_oErro
2208:             MsgErro(loc_oErro.Message + CHR(13) + ;
2209:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2210:                     "Procedure: " + loc_oErro.Procedure, ;
2211:                     "Erro ao arquivar os TXT de outras datas")
2212:         ENDTRY
2213:     ENDPROC
2214: 
2215:     *--------------------------------------------------------------------------
2216:     * FormParaBO - Transfere TODOS os criterios da tela para o BO. Neste form
2217:     * OPERACIONAL o "registro" e' o conjunto de criterios de cntOperacoes: o
2218:     * legado le cada um deles direto do controle no "selecionar" e no

*-- Linhas 2584 a 2602:
2584: 
2585:         TRY
2586:             IF USED("cursor_4c_Operacoes")
2587:                 SELECT cursor_4c_Operacoes
2588:                 SET ORDER TO TAG Notas
2589:                 GO TOP IN cursor_4c_Operacoes
2590:             ENDIF
2591: 
2592:             IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
2593:                 IF PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
2594:                     THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2595:                 ENDIF
2596:             ENDIF
2597:         CATCH TO loc_oErro
2598:             MsgErro(loc_oErro.Message + CHR(13) + ;
2599:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2600:                     "Procedure: " + loc_oErro.Procedure, ;
2601:                     "Erro ao atualizar a grade")
2602:         ENDTRY

*-- Linhas 2611 a 2629:
2611: 
2612:         TRY
2613:             IF USED("cursor_4c_Operacoes")
2614:                 SELECT cursor_4c_Operacoes
2615:                 ZAP
2616:             ENDIF
2617: 
2618:             THIS.AjustarBotoesPorModo(.F.)
2619:             THIS.AtualizarGrade()
2620:         CATCH TO loc_oErro
2621:             MsgErro(loc_oErro.Message + CHR(13) + ;
2622:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2623:                     "Procedure: " + loc_oErro.Procedure, ;
2624:                     "Erro ao limpar a sele" + CHR(231) + CHR(227) + "o")
2625:         ENDTRY
2626:     ENDPROC
2627: 
2628:     *--------------------------------------------------------------------------
2629:     * AjustarBotoesPorModo - FUNIL UNICO de habilitacao. Quem DESABILITA tem

*-- Linhas 2747 a 2783:
2747: 
2748:         TRY
2749:             IF USED("cursor_4c_Operacoes")
2750:                 SELECT cursor_4c_Operacoes
2751:                 REPLACE ALL SelImp WITH par_lMarcar
2752:                 THIS.AtualizarGrade()
2753:             ENDIF
2754:         CATCH TO loc_oErro
2755:             MsgErro(loc_oErro.Message + CHR(13) + ;
2756:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2757:                     "Procedure: " + loc_oErro.Procedure, ;
2758:                     "Erro ao marcar as opera" + CHR(231) + CHR(245) + "es")
2759:         ENDTRY
2760:     ENDPROC
2761: 
2762:     *--------------------------------------------------------------------------
2763:     * AlternarMarcacaoLinha - Inverte o SelImp da linha corrente.
2764:     *
2765:     * CheckBox em coluna de Grid NAO alterna pelo binding nativo: o legado
2766:     * SUPRIME o toggle padrao (Click/MouseDown com NoDefault) e inverte o
2767:     * valor por codigo no MouseUp e no KeyPress (Enter/Espaco). Migrar so o
2768:     * ControlSource deixa o checkbox inerte - o usuario clica e nada muda.
2769:     *--------------------------------------------------------------------------
2770:     PROCEDURE AlternarMarcacaoLinha()
2771:         LOCAL loc_oErro
2772: 
2773:         TRY
2774:             IF USED("cursor_4c_Operacoes")
2775:                 IF !EOF("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
2776:                     REPLACE SelImp WITH !cursor_4c_Operacoes.SelImp ;
2777:                         IN cursor_4c_Operacoes
2778:                     IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
2779:                         THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2780:                     ENDIF
2781:                 ENDIF
2782:             ENDIF
2783:         CATCH TO loc_oErro

*-- Linhas 2851 a 2869:
2851:         IF loc_nValor = 2
2852:             loc_nSelecionados = 0
2853:             IF USED("cursor_4c_Operacoes")
2854:                 SELECT COUNT(*) AS nSel FROM cursor_4c_Operacoes WHERE SelImp ;
2855:                     INTO CURSOR cursor_4c_Contagem
2856:                 loc_nSelecionados = cursor_4c_Contagem.nSel
2857:                 IF USED("cursor_4c_Contagem")
2858:                     USE IN cursor_4c_Contagem
2859:                 ENDIF
2860:             ENDIF
2861: 
2862:             IF loc_nSelecionados < 1 AND ;
2863:                INLIST(THIS.cnt_4c_Operacoes.obj_4c_OptAcao.Value, 1, 2, 3, 5)
2864:                 MsgAviso("Nenhuma Nota Fiscal Foi Selecionada!!!", ;
2865:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
2866:                 THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
2867:                 loc_lProsseguir = .F.
2868:             ENDIF
2869:         ENDIF

*-- Linhas 2965 a 3044:
2965:     * o painel oficial (AbrirPainelInutilizacao), entao essa saida paralela
2966:     * foi substituida por uma mensagem de confirmacao com a contagem.
2967:     *
2968:     * O 1o SqlExecute do legado ("...where stats = 'xxx'") so existia para
2969:     * criar nfAinu com a ESTRUTURA certa (nenhum status real vale 'xxx') -
2970:     * aqui vira CREATE CURSOR direto, mais claro para o mesmo efeito.
2971:     *--------------------------------------------------------------------------
2972:     PROCEDURE BtnPrepararInutilizacaoClick()
2973:         LOCAL loc_cSQL, loc_nResult, loc_cCnpj, loc_cSerie, loc_nNotaInu, loc_oErro
2974: 
2975:         TRY
2976:             IF USED("cursor_4c_NotasAInutilizar")
2977:                 SELECT cursor_4c_NotasAInutilizar
2978:                 ZAP
2979:             ENDIF
2980: 
2981:             *-- Numeros USADOS (emitidos ou ja inutilizados), com a mesma
2982:             *-- substituicao de CNPJ->'SVP' do legado (regra de negocio de
2983:             *-- um cliente especifico - transcrita literal, nao generalizada)
2984:             loc_cSQL = "SELECT DISTINCT CASE WHEN SUBSTRING(ids,7,14) = '12136108000195' THEN 'SVP' ELSE emps END AS emps," + ;
2985:                 " SUBSTRING(ids,7,14) AS cnpj, SUBSTRING(ids,23,3) AS series, SUBSTRING(ids,26,9) AS notai, SUBSTRING(ids,26,9) AS notaf" + ;
2986:                 " FROM sigprnfe WHERE stats = 'EMI' AND SUBSTRING(ids,26,9) <> ''" + ;
2987:                 " UNION" + ;
2988:                 " SELECT DISTINCT CASE WHEN SUBSTRING(ids,5,14) = '12136108000195' THEN 'SVP' ELSE emps END AS emps," + ;
2989:                 " SUBSTRING(ids,5,14) AS cnpj, SUBSTRING(ids,21,3) AS series, SUBSTRING(ids,24,9) AS notai, SUBSTRING(ids,33,9) AS notaf" + ;
2990:                 " FROM sigprnfe WHERE stats = 'INU' AND SUBSTRING(ids,24,9) <> ''" + ;
2991:                 " ORDER BY 1,2,4,5"
2992: 
2993:             IF USED("cursor_4c_NotasUsadas")
2994:                 USE IN cursor_4c_NotasUsadas
2995:             ENDIF
2996:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NotasUsadas")
2997: 
2998:             IF loc_nResult < 0
2999:                 MsgErro("Favor Reinicializar o Processo!!! (Falha na Conex" + ;
3000:                         CHR(227) + "o - notas usadas)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3001:             ELSE
3002:                 IF USED("cursor_4c_NotasUsadasOrd")
3003:                     USE IN cursor_4c_NotasUsadasOrd
3004:                 ENDIF
3005:                 SELECT * FROM cursor_4c_NotasUsadas WHERE ALLTRIM(cnpj) != "" ;
3006:                     ORDER BY cnpj, series, notai INTO CURSOR cursor_4c_NotasUsadasOrd
3007: 
3008:                 loc_nNotaInu = 1
3009:                 IF RECCOUNT("cursor_4c_NotasUsadasOrd") > 0
3010:                     SELECT cursor_4c_NotasUsadasOrd
3011:                     GO TOP
3012:                     loc_cCnpj  = cursor_4c_NotasUsadasOrd.cnpj
3013:                     loc_cSerie = cursor_4c_NotasUsadasOrd.series
3014: 
3015:                     DO WHILE !EOF("cursor_4c_NotasUsadasOrd")
3016:                         IF cursor_4c_NotasUsadasOrd.cnpj == loc_cCnpj ;
3017:                            AND cursor_4c_NotasUsadasOrd.series == loc_cSerie
3018:                             IF loc_nNotaInu < VAL(cursor_4c_NotasUsadasOrd.notai)
3019:                                 SELECT cursor_4c_NotasAInutilizar
3020:                                 APPEND BLANK
3021:                                 REPLACE Notai  WITH PADL(ALLTRIM(STR(loc_nNotaInu)), 8, "0")
3022:                                 REPLACE Emps   WITH cursor_4c_NotasUsadasOrd.emps
3023:                                 REPLACE Cnpj   WITH cursor_4c_NotasUsadasOrd.cnpj
3024:                                 REPLACE Series WITH cursor_4c_NotasUsadasOrd.series
3025:                                 REPLACE Notaf  WITH PADL(ALLTRIM(STR(VAL(cursor_4c_NotasUsadasOrd.notai) - 1)), 8, "0")
3026:                             ENDIF
3027:                             loc_nNotaInu = VAL(cursor_4c_NotasUsadasOrd.notaf) + 1
3028: 
3029:                             SELECT cursor_4c_NotasUsadasOrd
3030:                             SKIP
3031:                             IF !EOF("cursor_4c_NotasUsadasOrd")
3032:                                 IF !(cursor_4c_NotasUsadasOrd.cnpj == loc_cCnpj ;
3033:                                      AND cursor_4c_NotasUsadasOrd.series == loc_cSerie)
3034:                                     loc_cCnpj    = cursor_4c_NotasUsadasOrd.cnpj
3035:                                     loc_cSerie   = cursor_4c_NotasUsadasOrd.series
3036:                                     loc_nNotaInu = 1
3037:                                 ENDIF
3038:                             ENDIF
3039:                         ELSE
3040:                             loc_cCnpj    = cursor_4c_NotasUsadasOrd.cnpj
3041:                             loc_cSerie   = cursor_4c_NotasUsadasOrd.series
3042:                             loc_nNotaInu = 1
3043:                         ENDIF
3044:                     ENDDO

*-- Linhas 3076 a 3102:
3076:             loc_cEmps = ALLTRIM(TRANSFORM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value))
3077: 
3078:             IF USED("cursor_4c_Inutil")
3079:                 SELECT cursor_4c_Inutil
3080:                 ZAP
3081:             ENDIF
3082: 
3083:             IF USED("cursor_4c_NotasAInutilizar")
3084:                 SELECT cursor_4c_NotasAInutilizar
3085:                 SCAN FOR ALLTRIM(Emps) == loc_cEmps
3086:                     SCATTER MEMVAR
3087:                     INSERT INTO cursor_4c_Inutil (nMarca, Emps, Cnpj, Series, Notai, Notaf) ;
3088:                         VALUES (0, m.Emps, m.Cnpj, m.Series, m.Notai, m.Notaf)
3089:                 ENDSCAN
3090:             ENDIF
3091: 
3092:             THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
3093:             THIS.cnt_4c_Inu.Visible = .T.
3094:         CATCH TO loc_oErro
3095:             MsgErro(loc_oErro.Message + CHR(13) + ;
3096:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3097:                     "Procedure: " + loc_oErro.Procedure, ;
3098:                     "Erro ao abrir pain" + CHR(233) + "l de inutiliza" + CHR(231) + CHR(227) + "o")
3099:         ENDTRY
3100:     ENDPROC
3101: 
3102:     *--------------------------------------------------------------------------

*-- Linhas 3143 a 3191:
3143: 
3144:         loc_nSelecionados = 0
3145:         IF USED("cursor_4c_Inutil")
3146:             SELECT COUNT(*) AS nSel FROM cursor_4c_Inutil WHERE nMarca = 1 ;
3147:                 INTO CURSOR cursor_4c_ContagemInu
3148:             loc_nSelecionados = cursor_4c_ContagemInu.nSel
3149:             IF USED("cursor_4c_ContagemInu")
3150:                 USE IN cursor_4c_ContagemInu
3151:             ENDIF
3152:         ENDIF
3153: 
3154:         IF loc_nSelecionados < 1
3155:             MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Encontrado!!!", ;
3156:                      "Aten" + CHR(231) + CHR(227) + "o!!!")
3157:             THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
3158:             RETURN
3159:         ENDIF
3160: 
3161:         TRY
3162:             THIS.AjustarBotoesPorModo(.T.)
3163: 
3164:             loc_oBO       = THIS.this_oBusinessObject
3165:             loc_nAmbiente = THIS.cnt_4c_Operacoes.obj_4c_OptAmbiente.Value
3166: 
3167:             SELECT cursor_4c_Inutil
3168:             SCAN FOR nMarca = 1
3169:                 IF loc_nAcao = 4
3170:                     loc_oBO.InutilizarNumeracao(cursor_4c_Inutil.Emps, cursor_4c_Inutil.Series, ;
3171:                         cursor_4c_Inutil.Notai, cursor_4c_Inutil.Notaf, loc_nAmbiente)
3172:                 ELSE
3173:                     loc_oBO.InutilizarNumeracaoNfce(cursor_4c_Inutil.Emps, cursor_4c_Inutil.Series, ;
3174:                         cursor_4c_Inutil.Notai, cursor_4c_Inutil.Notaf)
3175:                 ENDIF
3176:                 SELECT cursor_4c_Inutil
3177:             ENDSCAN
3178: 
3179:             THIS.FecharPainelInutilizacao()
3180:         CATCH TO loc_oErro
3181:             MsgErro(loc_oErro.Message + CHR(13) + ;
3182:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3183:                     "Procedure: " + loc_oErro.Procedure, ;
3184:                     "Erro ao processar inutiliza" + CHR(231) + CHR(227) + "o")
3185:         ENDTRY
3186:     ENDPROC
3187: 
3188:     *--------------------------------------------------------------------------
3189:     * BtnAcaoGradeClick - cmdBtnGrade.Click do legado (CommandGroup com
3190:     * Selecionar/Desmarcar/Documento/Danfe Simpl, agindo sobre a grade de
3191:     * operacoes).

*-- Linhas 3250 a 3275:
3250:         ENDIF
3251: 
3252:         TRY
3253:             loc_cSQL = "SELECT * FROM sigmvnfi WHERE empdopnums = " + ;
3254:                 EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Emps) + ALLTRIM(cursor_4c_Operacoes.Dopes) + ;
3255:                            PADL(ALLTRIM(STR(cursor_4c_Operacoes.Numes)), 6, "0"))
3256: 
3257:             IF USED("cursor_4c_NfiDsi")
3258:                 USE IN cursor_4c_NfiDsi
3259:             ENDIF
3260:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfiDsi")
3261: 
3262:             IF loc_nResult < 1
3263:                 MsgErro("Favor Reinicializar o Processo!!! (Falha na Conex" + ;
3264:                         CHR(227) + "o - crNf)", "Erro")
3265:             ELSE
3266:                 loc_cXml     = NVL(cursor_4c_NfiDsi.nfexml, "")
3267:                 loc_cInfProt = STREXTRACT(loc_cXml, "<infProt", "</infProt>", 1)
3268:                 loc_cProt    = STREXTRACT(loc_cInfProt, "<nProt>", "</nProt>", 1)
3269:                 loc_cDataRec = STREXTRACT(loc_cInfProt, "<dhRecbto>", "</dhRecbto>", 1)
3270:                 loc_cChave   = STREXTRACT(loc_cInfProt, "<chNFe>", "</chNFe>", 1)
3271: 
3272:                 loc_cFin     = STREXTRACT(loc_cXml, "<finNFe>", "</finNFe>", 1)
3273:                 loc_cFin     = IIF(loc_cFin == "1", "1 - Saida", "0 - Entrada")
3274:                 loc_cNota    = STREXTRACT(loc_cXml, "<nNF>", "</nNF>", 1)
3275:                 loc_cSerie   = STREXTRACT(loc_cXml, "<serie>", "</serie>", 1)

*-- Linhas 3306 a 3333:
3306:                 IF USED("cursor_4c_DanfeSimpl")
3307:                     USE IN cursor_4c_DanfeSimpl
3308:                 ENDIF
3309:                 CREATE CURSOR cursor_4c_DanfeSimpl (fin C(30), numero C(30), emissao C(30), ;
3310:                     chavea C(30), chave C(50), linha1e C(70), linha2e C(70), linha1d C(70), ;
3311:                     linha2d C(70), danfes C(30), prot C(60), prota C(60))
3312:                 INSERT INTO cursor_4c_DanfeSimpl (fin, numero, emissao, chavea, chave, linha1e, ;
3313:                     linha2e, linha1d, linha2d, danfes, prot, prota) VALUES ( ;
3314:                     loc_cFin, loc_cNumero, loc_cEmissao, "Chave de acesso", loc_cChave, ;
3315:                     loc_cLinha1E, loc_cLinha2E, loc_cLinha1D, loc_cLinha2D, ;
3316:                     "DANFE SIMPLIFICADO", loc_cProtCompleto, "Protocolo de autorizacao de uso")
3317: 
3318:                 SELECT cursor_4c_DanfeSimpl
3319:                 THIS.ExecutarReportForm("SigReDsi", "PREVIEW", "cursor_4c_DanfeSimpl")
3320:             ENDIF
3321: 
3322:             IF USED("cursor_4c_NfiDsi")
3323:                 USE IN cursor_4c_NfiDsi
3324:             ENDIF
3325:         CATCH TO loc_oErro
3326:             MsgErro(loc_oErro.Message + CHR(13) + ;
3327:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3328:                     "Procedure: " + loc_oErro.Procedure, ;
3329:                     "Erro ao imprimir DANFE simplificado")
3330:         ENDTRY
3331:     ENDPROC
3332: 
3333:     *--------------------------------------------------------------------------

