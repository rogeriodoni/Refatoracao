# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-TABELA] Tabela 'SigCdParac' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, FRETE, FRETEDEFS, CEMPS, ICLIS, LNCOMST, LCUFO, CODIGOS, DESTINOS, CODS, 0, LNTOP, LCFIN, LCCFOD, LCPRE, TPEMIS, LNTAM, LCMOD, LCUFD, SITTRICMS, CPROS, CITENS, FKCHAVE, CODCLASFISCAL, CODCFOP, LCOMC, UFS, CODIGO, LCCST, LNFIN, EXICBSIMP, LCP, VALIPIS, VALICMS, CGERGIA1S, P, IF, ITRAS, LNFPG, EMIS, IMPNFS, EMPS, SERIES, I, ESTADOS, DESCS, LNONE, LNVEZ, STATS, C1, J, DV, LCARQ, ESTAS, CNPJ, FPAGS, CFOPS, NFC, OPERS, LCANCELAS, UFIBGES, LCDEST
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, FRETE, FRETEDEFS, CEMPS, ICLIS, LNCOMST, LCUFO, CODIGOS, DESTINOS, CODS, 0, LNTOP, LCFIN, LCCFOD, LCPRE, TPEMIS, LNTAM, LCMOD, LCUFD, SITTRICMS, CPROS, CITENS, FKCHAVE, CODCLASFISCAL, CODCFOP, LCOMC, UFS, CODIGO, LCCST, LNFIN, EXICBSIMP, LCP, VALIPIS, VALICMS, CGERGIA1S, P, IF, ITRAS, LNFPG, EMIS, IMPNFS, EMPS, SERIES, I, ESTADOS, DESCS, LNONE, LNVEZ, STATS, C1, J, DV, LCARQ, ESTAS, CNPJ, FPAGS, CFOPS, NFC, OPERS, LCANCELAS, UFIBGES, LCDEST
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IMPOSSIVEL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, EMPDOPNUMS, FRETE, FRETEDEFS, CEMPS, ICLIS, LNCOMST, LCUFO, CODIGOS, DESTINOS, CODS, 0, LNTOP, LCFIN, LCCFOD, LCPRE, TPEMIS, LNTAM, LCMOD, LCUFD, SITTRICMS, CPROS, CITENS, FKCHAVE, CODCLASFISCAL, CODCFOP, LCOMC, UFS, CODIGO, LCCST, LNFIN, EXICBSIMP, LCP, VALIPIS, VALICMS, CGERGIA1S, P, IF, ITRAS, LNFPG, EMIS, IMPNFS, EMPS, SERIES, I, ESTADOS, DESCS, LNONE, LNVEZ, STATS, C1, J, DV, LCARQ, ESTAS, CNPJ, FPAGS, CFOPS, NFC, OPERS, LCANCELAS, UFIBGES, LCDEST
- [TRANSACAO-AVULSA] Linha 1514: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS SQL (2195 linhas total):

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
78:             THIS.ConfigurarOperacoes()
79:             THIS.ConfigurarGrade()
80:             THIS.ConfigurarBotoesForm()
81:             THIS.ConfigurarBotoesGrade()
82:             THIS.ConfigurarCntInu()
83:             THIS.TornarControlesVisiveis()
84:             THIS.ConfigurarBINDEVENTs()

*-- Linhas 804 a 922:
804:             .GridLineWidth = 1
805:             .HeaderHeight  = 22
806:             .RowHeight     = 20
807:             .DeleteMark    = .F.
808:             .RecordMark    = .F.
809:             .ScrollBars    = 3
810:             .FontName      = "Tahoma"
811:             .FontSize      = 8
812:         ENDWITH
813: 
814:         *-- Column1: selecao (CheckBox com Sparse=.F.)
815:         WITH loc_oGrd.Column1
816:             .Width         = 25
817:             .ReadOnly      = .F.
818:             .ControlSource = "csOperacoes.SelImp"
819:         ENDWITH
820:         WITH loc_oGrd.Column1.Header1
821:             .Caption = ""
822:         ENDWITH
823:         loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
824:         WITH loc_oGrd.Column1.chk_4c_SelImp
825:             .Caption   = ""
826:             .Width     = 22
827:             .Height    = 17
828:             .BackStyle = 0
829:         ENDWITH
830:         loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
831:         loc_oGrd.Column1.Sparse         = .F.
832: 
833:         *-- Column2: Codigo (Dopes)
834:         WITH loc_oGrd.Column2
835:             .Width         = 185
836:             .ReadOnly      = .T.
837:             .ControlSource = "csOperacoes.Dopes"
838:         ENDWITH
839:         WITH loc_oGrd.Column2.Header1
840:             .Caption = "C" + CHR(243) + "digo"
841:         ENDWITH
842: 
843:         *-- Column3: Emissao (Datas)
844:         WITH loc_oGrd.Column3
845:             .Width         = 80
846:             .ReadOnly      = .T.
847:             .ControlSource = "csOperacoes.Datas"
848:         ENDWITH
849:         WITH loc_oGrd.Column3.Header1
850:             .Caption = "Emiss" + CHR(227) + "o"
851:         ENDWITH
852: 
853:         *-- Column4: Valor (Valos)
854:         WITH loc_oGrd.Column4
855:             .Width         = 100
856:             .ReadOnly      = .T.
857:             .ControlSource = "csOperacoes.Valos"
858:         ENDWITH
859:         WITH loc_oGrd.Column4.Header1
860:             .Caption = "Valor"
861:         ENDWITH
862: 
863:         *-- Column5: Nota Fiscal (Notas)
864:         WITH loc_oGrd.Column5
865:             .Width         = 80
866:             .ReadOnly      = .T.
867:             .ControlSource = "csOperacoes.Notas"
868:         ENDWITH
869:         WITH loc_oGrd.Column5.Header1
870:             .Caption = "Nota Fiscal"
871:         ENDWITH
872: 
873:         *-- Column6: Serie (Series)
874:         WITH loc_oGrd.Column6
875:             .Width         = 50
876:             .ReadOnly      = .T.
877:             .ControlSource = "csOperacoes.Series"
878:         ENDWITH
879:         WITH loc_oGrd.Column6.Header1
880:             .Caption = "S" + CHR(233) + "rie"
881:         ENDWITH
882: 
883:         *-- Column7: Movimentacao (Tipos)
884:         WITH loc_oGrd.Column7
885:             .Width         = 95
886:             .ReadOnly      = .T.
887:             .ControlSource = "csOperacoes.Tipos"
888:         ENDWITH
889:         WITH loc_oGrd.Column7.Header1
890:             .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
891:         ENDWITH
892: 
893:         *-- Column8: Empresa (Emps)
894:         WITH loc_oGrd.Column8
895:             .Width         = 50
896:             .ReadOnly      = .T.
897:             .ControlSource = "csOperacoes.Emps"
898:         ENDWITH
899:         WITH loc_oGrd.Column8.Header1
900:             .Caption = "Emp"
901:         ENDWITH
902: 
903:         *-- Column9: Status (stats)
904:         WITH loc_oGrd.Column9
905:             .Width         = 148
906:             .ReadOnly      = .T.
907:             .ControlSource = "csOperacoes.stats"
908:         ENDWITH
909:         WITH loc_oGrd.Column9.Header1
910:             .Caption = "Stat"
911:         ENDWITH
912:     ENDPROC
913: 
914:     *==========================================================================
915:     PROTECTED PROCEDURE ConfigurarBotoesForm()
916:     *==========================================================================
917:         *-- Botao Selecionar
918:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
919:         WITH THIS.cmd_4c_Selecionar
920:             .Top             = 83
921:             .Left            = 843
922:             .Width           = 75

*-- Linhas 1189 a 1207:
1189:             .GridLineWidth = 1
1190:             .HeaderHeight  = 22
1191:             .RowHeight     = 20
1192:             .DeleteMark    = .F.
1193:             .RecordMark    = .F.
1194:             .ScrollBars    = 3
1195:             .FontName      = "Tahoma"
1196:             .FontSize      = 8
1197:         ENDWITH
1198: 
1199:         WITH loc_oGrd.Column1
1200:             .Width = 35
1201:         ENDWITH
1202:         WITH loc_oGrd.Column1.Header1
1203:             .Caption = "Emp"
1204:         ENDWITH
1205:         WITH loc_oGrd.Column2
1206:             .Width = 40
1207:         ENDWITH

*-- Linhas 1448 a 1466:
1448: 
1449:         THIS.HabilitarControles(.F.)
1450: 
1451:         SELECT csOperacoes
1452:         SET ORDER TO Notas
1453:         GO TOP IN csOperacoes
1454:         IF EOF("csOperacoes")
1455:             IF INLIST(loc_nAcao, 1, 2, 3, 5)
1456:                 MsgAviso("Nenhuma Nota Foi Encontrada Para Processamento!!!")
1457:                 THIS.LimpaSelecao()
1458:                 THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
1459:             ENDIF
1460:         ELSE
1461:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1462:         ENDIF
1463:     ENDPROC
1464: 
1465:     PROCEDURE BtnLimparClick()
1466:         THIS.LimpaSelecao()

*-- Linhas 1473 a 1491:
1473:             IF USED("cursor_4c_SelChk")
1474:                 USE IN cursor_4c_SelChk
1475:             ENDIF
1476:             SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelChk
1477:             loc_nSel = cursor_4c_SelChk.nSel
1478:             USE IN cursor_4c_SelChk
1479:             IF loc_nSel < 1
1480:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado para Processamento!!!")
1481:                 THIS.cnt_4c_Grade.grd_4c_Operacoes.SetFocus()
1482:                 RETURN
1483:             ENDIF
1484:         ENDIF
1485:         loc_oBO = THIS.this_oBusinessObject
1486:         loc_oBO.this_nAcao      = loc_nAcao
1487:         loc_oBO.this_nAmbiente  = THIS.cnt_4c_Operacoes.opt_4c_Ambiente.Value
1488:         loc_oBO.this_nTipos     = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1489:         loc_oBO.this_nImpressao = THIS.cnt_4c_Operacoes.opt_4c_Impressao.Value
1490:         loc_oBO.this_nContin    = THIS.cnt_4c_Operacoes.opt_4c_Contin.Value
1491:         loc_oBO.this_cArquivos  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value)

*-- Linhas 1500 a 1550:
1500:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1501:         CATCH TO loc_oErro
1502:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1503:                     "Erro Processar")
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     PROCEDURE BtnEncerrarClick()
1508:         THIS.Release()
1509:     ENDPROC
1510: 
1511:     PROCEDURE BtnMarcaTudoClick()
1512:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1513:             SELECT csOperacoes
1514:             REPLACE ALL SelImp WITH .T.
1515:             GO TOP IN csOperacoes
1516:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1517:         ENDIF
1518:     ENDPROC
1519: 
1520:     PROCEDURE BtnDesmarcarClick()
1521:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1522:             SELECT csOperacoes
1523:             REPLACE ALL SelImp WITH .F.
1524:             GO TOP IN csOperacoes
1525:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1526:         ENDIF
1527:     ENDPROC
1528: 
1529:     PROCEDURE BtnDocumentosClick()
1530:         LOCAL loc_cDopes, loc_nNumes, loc_cEmps, loc_oForm, loc_oErro
1531:         IF !USED("csOperacoes") OR EOF("csOperacoes")
1532:             MsgAviso("Posicione o cursor em um registro.")
1533:             RETURN
1534:         ENDIF
1535:         SELECT csOperacoes
1536:         loc_cDopes = ALLTRIM(csOperacoes.Dopes)
1537:         loc_nNumes = csOperacoes.Numes
1538:         loc_cEmps  = ALLTRIM(csOperacoes.Emps)
1539:         TRY
1540:             loc_oForm = CREATEOBJECT("Formsigmvexp", loc_cDopes, "C", loc_nNumes, loc_cEmps)
1541:             IF VARTYPE(loc_oForm) = "O"
1542:                 loc_oForm.Show()
1543:             ELSE
1544:                 MsgErro("Erro ao criar Formsigmvexp. VARTYPE retornou: " + ;
1545:                         VARTYPE(loc_oForm), "Documentos")
1546:             ENDIF
1547:         CATCH TO loc_oErro
1548:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1549:                     "Erro ao abrir Documentos")
1550:         ENDTRY

*-- Linhas 1587 a 1605:
1587:         loc_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1588:         loc_cNIni   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1589:         loc_cNFim   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1590:         SELECT csInutil
1591:         GO TOP IN csInutil
1592:         loc_cCnpj = ALLTRIM(csInutil.cnpj)
1593:         loc_oBO = THIS.this_oBusinessObject
1594:         TRY
1595:             loc_oBO.ProcessaInutilizadas(loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim)
1596:         CATCH TO loc_oErro
1597:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1598:                     "Erro Inutilizar")
1599:         ENDTRY
1600:         THIS.AlternarPagina(1)
1601:     ENDPROC
1602: 
1603:     PROCEDURE AcaoInteractiveChange()
1604:         IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1605:             THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;

*-- Linhas 1619 a 1650:
1619:             *-- Carrega nfAinu com gap analysis via BO
1620:             loc_oBO.SelecionarInutilizadas(loc_cEmps)
1621:             IF USED("nfAinu")
1622:                 SELECT 1 AS nMarca, emps, series, notai, notaf, cnpj ;
1623:                     FROM nfAinu ;
1624:                     WHERE RTRIM(emps) = RTRIM(loc_cEmps) ;
1625:                     INTO CURSOR csInutil READWRITE
1626:                 IF USED("csInutil") AND RECCOUNT("csInutil") > 0
1627:                     GO TOP IN csInutil
1628:                     WITH THIS.cnt_4c_Inu.grd_4c_Inu
1629:                         .RecordSource          = "csInutil"
1630:                         .Column1.ControlSource = "csInutil.emps"
1631:                         .Column2.ControlSource = "csInutil.series"
1632:                         .Column3.ControlSource = "csInutil.notai"
1633:                         .Column4.ControlSource = "csInutil.notaf"
1634:                         .Column5.ControlSource = "csInutil.cnpj"
1635:                         .Column6.ControlSource = "csInutil.nMarca"
1636:                         .Refresh()
1637:                     ENDWITH
1638:                     THIS.AlternarPagina(2)
1639:                 ELSE
1640:                     MsgAviso("Nenhuma nota para inutilizar encontrada para esta empresa.")
1641:                 ENDIF
1642:             ELSE
1643:                 MsgAviso("Nenhuma nota para inutilizar encontrada.")
1644:             ENDIF
1645:         CATCH TO loc_oErro
1646:             MsgErro(loc_oErro.Message, "Erro CmdInu")
1647:         ENDTRY
1648:     ENDPROC
1649: 
1650:     PROCEDURE EmpsLostFocus(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1734 a 1754:
1734:             RETURN
1735:         ENDIF
1736:         TRY
1737:             loc_nResult = SQLEXEC(gnConnHandle, ;
1738:                 "SELECT Cods FROM SigCdSer WHERE ImpNfs = 3 AND LTRIM(RTRIM(Cods)) = " + ;
1739:                 EscaparSQL(loc_cSeries), "cursor_4c_SerValid")
1740:             IF loc_nResult > 0 AND USED("cursor_4c_SerValid") AND !EOF("cursor_4c_SerValid")
1741:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_SerValid.Cods)
1742:             ELSE
1743:                 THIS.AbrirBuscaSeries()
1744:             ENDIF
1745:             IF USED("cursor_4c_SerValid")
1746:                 USE IN cursor_4c_SerValid
1747:             ENDIF
1748:         CATCH TO loc_oErro
1749:             MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
1750:         ENDTRY
1751:     ENDPROC
1752: 
1753:     PROCEDURE AbrirBuscaSeries()
1754:         LOCAL loc_oBusca, loc_cCods, loc_oErro

*-- Linhas 1783 a 1813:
1783:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
1784:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1785:             m.SelImp = (NOT csOperacoes.SelImp)
1786:             SELECT csOperacoes
1787:             GATHER MEMVAR FIELDS SelImp
1788:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1789:         ENDIF
1790:         NODEFAULT
1791:     ENDPROC
1792: 
1793:     *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
1794:     PROCEDURE GridChkKeyPress
1795:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1796:         IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
1797:             m.SelImp = (NOT csOperacoes.SelImp)
1798:             SELECT csOperacoes
1799:             GATHER MEMVAR FIELDS SelImp
1800:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1801:             NODEFAULT
1802:         ENDIF
1803:     ENDPROC
1804: 
1805:     PROCEDURE LimpaSelecao()
1806:         IF USED("csOperacoes")
1807:             ZAP IN csOperacoes
1808:         ENDIF
1809:         THIS.HabilitarControles(.T.)
1810:         THIS.cmd_4c_ImpDSimpl.Enabled = .F.
1811:         THIS.Refresh()
1812:     ENDPROC
1813: 

*-- Linhas 1861 a 1912:
1861:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize Incluir primeiro.")
1862:             RETURN
1863:         ENDIF
1864:         SELECT csOperacoes
1865:         IF EOF("csOperacoes")
1866:             GO TOP IN csOperacoes
1867:         ENDIF
1868:         IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
1869:             MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
1870:             RETURN
1871:         ENDIF
1872:         THIS.BtnDocumentosClick()
1873:     ENDPROC
1874: 
1875:     PROCEDURE BtnVisualizarClick()
1876:         * Visualizar detalhes tecnicos (chave, protocolo, status)
1877:         * da nota fiscal apontada. Consulta SigMvNfi diretamente
1878:         * para exibir dados que nao aparecem no grid principal.
1879:         LOCAL loc_cChave, loc_cSQL, loc_oErro, loc_cMsg
1880:         LOCAL loc_cChv, loc_cProt, loc_cStat, loc_cXml
1881:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1882:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
1883:             RETURN
1884:         ENDIF
1885:         SELECT csOperacoes
1886:         IF EOF("csOperacoes")
1887:             GO TOP IN csOperacoes
1888:         ENDIF
1889:         loc_cChave = ALLTRIM(csOperacoes.Emps) + ALLTRIM(csOperacoes.Dopes) + ;
1890:                      PADL(ALLTRIM(TRANSFORM(csOperacoes.Numes)), 6, "0")
1891:         loc_cSQL = "SELECT TOP 1 nfechv, nfexml, prots, stats FROM SigMvNfi WHERE empdopnums = " + ;
1892:                    EscaparSQL(loc_cChave)
1893:         TRY
1894:             IF USED("cursor_4c_VisNfe")
1895:                 USE IN cursor_4c_VisNfe
1896:             ENDIF
1897:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisNfe") < 1
1898:                 MsgErro("Falha ao consultar SigMvNfi para a nota selecionada.", "Visualizar")
1899:                 RETURN
1900:             ENDIF
1901:             IF RECCOUNT("cursor_4c_VisNfe") = 0
1902:                 MsgAviso("Nota fiscal ainda n" + CHR(227) + "o transmitida (sem registro em SigMvNfi).")
1903:             ELSE
1904:                 loc_cChv  = ALLTRIM(NVL(cursor_4c_VisNfe.nfechv, "N/D"))
1905:                 loc_cProt = ALLTRIM(NVL(cursor_4c_VisNfe.prots, "N/D"))
1906:                 loc_cStat = ALLTRIM(NVL(cursor_4c_VisNfe.stats, "N/D"))
1907:                 loc_cXml  = IIF(EMPTY(NVL(cursor_4c_VisNfe.nfexml, "")), "N" + CHR(227) + "o", "Sim")
1908:                 loc_cMsg = "Nota: " + ALLTRIM(csOperacoes.Notas) + CHR(13) + ;
1909:                            "S" + CHR(233) + "rie: " + ALLTRIM(csOperacoes.Series) + CHR(13) + ;
1910:                            "Chave: " + loc_cChv + CHR(13) + ;
1911:                            "Protocolo: " + loc_cProt + CHR(13) + ;
1912:                            "Status: " + loc_cStat + CHR(13) + ;

*-- Linhas 2057 a 2076:
2057:         loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)
2058:         loc_oCnt.chk_4c_OptArq.Value = IIF(loc_oBO.this_lOptArq, 1, 0)
2059: 
2060:         *-- Bloco 3: registro corrente reflete csOperacoes via ControlSource do
2061:         *-- grid. Refresh forca releitura dos ControlSource apos alteracao no BO.
2062:         THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
2063:         RETURN .T.
2064:     ENDPROC
2065: 
2066:     *--------------------------------------------------------------------------
2067:     * HabilitarCampos - Interface CRUD-padrao. Delega para HabilitarControles
2068:     * (nome nativo deste form OPERACIONAL) que implementa a logica real de
2069:     * bloquear filtros durante processamento.
2070:     *--------------------------------------------------------------------------
2071:     PROCEDURE HabilitarCampos(par_lHabilitar)
2072:         LOCAL loc_lHab
2073:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2074:         THIS.HabilitarControles(loc_lHab)
2075:     ENDPROC
2076: 

*-- Linhas 2149 a 2167:
2149:             MsgAviso("A fila de processamento est" + CHR(225) + " vazia. Use Buscar/Selecionar antes.")
2150:             RETURN
2151:         ENDIF
2152:         SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelSalv
2153:         loc_nSel = cursor_4c_SelSalv.nSel
2154:         USE IN cursor_4c_SelSalv
2155:         IF loc_nSel < 1
2156:             MsgAviso("Nenhuma nota est" + CHR(225) + " marcada para processamento.")
2157:             RETURN
2158:         ENDIF
2159:         THIS.FormParaBO()
2160:         THIS.BtnCopiarClick()
2161:     ENDPROC
2162: 
2163:     *--------------------------------------------------------------------------
2164:     * BtnCancelarClick - Interface CRUD-padrao. Cancela a selecao atual e
2165:     * reabilita os filtros de busca (equivale ao Limpar do form legado).
2166:     *--------------------------------------------------------------------------
2167:     PROCEDURE BtnCancelarClick()

