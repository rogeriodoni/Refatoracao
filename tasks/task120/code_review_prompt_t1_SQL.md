# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (26)
- [SQL-ASPAS] Linha 250: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "FROM SigMvCab WHERE EmpDopNums = '" + loc_cEdn + "'", ;
- [SQL-ASPAS] Linha 268: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_cEdn + "' AND a.CPros = b.CPros"
- [SQL-ASPAS] Linha 298: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_cEdn + "' " + ;
- [SQL-ASPAS] Linha 326: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "SELECT * FROM SigOpTdt WHERE Codigos = '" + loc_cTab + "'", ;
- [SQL-ASPAS] Linha 367: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_cEdn + "' AND a.CPros = b.CPros " + ;
- [SQL-ASPAS] Linha 388: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "FROM sigexmvi a WHERE a.empdopnums = '" + loc_cEdn + "'", ;
- [SQL-ASPAS] Linha 402: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_cEdn + "' " + ;
- [SQL-ASPAS] Linha 445: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "SELECT * FROM SigMvNfi WHERE EmpDopNums = '" + loc_cEdn + "'", ;
- [SQL-ASPAS] Linha 459: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "SELECT * FROM SigPrTrp WHERE itras = '" + loc_cTraCod + "'", ;
- [SQL-ASPAS] Linha 470: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_cEdn + "' AND b.FPags = a.FPags", ;
- [SQL-ASPAS] Linha 493: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_cEdn + "' ORDER BY a.Codigos", ;
- [SQL-ASPAS] Linha 505: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_cEdn + "'", ;
- [SQL-ASPAS] Linha 524: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "SELECT * FROM SigOpFnl WHERE EmpDopNums = '" + loc_cEdn + "'", ;
- [SQL-ASPAS] Linha 716: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE EmpDopNums = '" + loc_cEdn + "'", ;
- [SQL-ASPAS] Linha 2209: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "SELECT Docus FROM SigCdOpe WHERE Dopes = '" + THIS.this_cDopes + "'", ;
- [SQL-ASPAS] Linha 2655: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.Dopes = '" + THIS.this_cDopes + "' " + ;
- [SQL-ASPAS] Linha 2681: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "SELECT Impress FROM SigMvCab WHERE EmpDopNums = '" + loc_lcEdn + "'", ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ITRAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCKBARRA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCKDPRO3S' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCKEQS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VLFRETES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOCUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, EMPDOPNUMS, OPERS, HABSERVS, CODIGOS, I, IMPDUPS, ICLIS, NTIPOS, DATAS, GRUPOS, CONTAS, MOEDAS, LCREF, LCVEN, LLIFR, CITENS, IFORS, COLECOES, FATORS, LCOBM, DOPES, IMPRESS, CGRUS, SGRUS, FPAGS

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
lcQuery = [Select b.Descricaos ] + ;
			[From SigCdPro a, SigCdPsg b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSgru]) < 1)
				.cOption("UpdateInterval")		 = 0
				.cOption("DisableUpdateCheck")   = 1														
	If Thisform.mEmail( 	Thisform.oEMAIL.cFrom, ;
	Insert Into LocalOpe2 (DckLogos, DckAcess, DocAcess, ChkImpDp, ChkImpRot, ChkImpMon) Values (0, 0, [], 0, 0, 0)
lcQuery = [Select a.CItens, a.CPros, b.Reffs, a.DPros, b.DPro2s, a.CUnis, a.Qtds, a.Units, a.Unitorigs, a.Moedas, a.MoeVals, ] + ;
		    [From SigMvItn a, SigCdPro b ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalEestI]) < 1)
	lcQuery = [Select a.CItens, a.CPros, b.Reffs, c.DPros, a.dpros as DPro2s, c.CUnis, c.Qtds, c.Units, c.Unitorigs, c.Moedas, c.MoeVals, ] + ;
			    [From SigMvItn a, SigCdPro b, sigmvitp c ] + ;
	If (loCnx.SqlExecute(lcQuery, [LocalEestI]) < 1)
lcQuery = [Select a.CPros, a.DPros, a.empdopnums, a.Qtds, a.Units, a.Totas From sigexmvi a ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalEestIE]) < 1)
Select LocalEestI
		lcSel = [Select * From SigOpTdt Where Codigos = '] + lcTab + [']
		lnErr = loCnx.SqlExecute(lcSel, [LocalTabDescs])
		Select LocalTabDescs
		If (Seek(lcTab + '4' + LocalEestI.CPros) Or ;
			Seek(lcTab + '9' + LocalEestI.CodFinP) Or ;
			Seek(lcTab + '1' + LocalEestI.CGrus) Or ;
			Seek(lcTab + '2' + LocalEestI.Linhas) Or ;
			Seek(lcTab + '3' + LocalEestI.Colecoes) Or ;
			Seek(lcTab + '6' + LocalEestI.Cunis) Or ;
			Seek(lcTab + '7' + LocalEestI.Cftios) Or ;
			Seek(lcTab + '8' + LocalEestI.Sgrus))
Select LocalEestI
	lcQuery = [Select a.*, b.Valors, b.DPro2s ] + ;
			    [From SigMvItt a, SigCdPro b ] + ;
	If (loCnx.SqlExecute(lcQuery, [LocalEestis]) < 1)
	Select LocalEestis
		Insert Into LocalEestI (CItens, CPros, DPros, DPro2s, CUnis, Qtds, Units, Totas, Moedas, MoeVals, Valors) ;
lcQuery = [Select a.CItens, a.CPros, c.Reffs, a.DPros, c.DPro2s, b.CodEmbs as CUnis, b.Qtds, a.Units, a.Unitorigs, a.Moedas, a.MoeVals, ] + ;
		    [From SigMvItn a, SigMvIts b, SigCdPro c ] + ;
If (loCnx.SqlExecute(lcQuery, [TmpEstI2]) < 1)
Select CItens, CPros, Reffs, DPros, DPro2s, CUnis, Qtds, Units * Iif(QtdEmbs > 0, QtdEmbs, 1) as Units, Unitorigs, ;
  From TmpEstI2 ;
Select LocalEstI2
lcQuery = [Select a.FPags, a.MoeFpgs, a.CotFpgs, a.Valos, a.Vencs, b.Descrs ] + ;
			[From SigMvPar a, SigOpFp b ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalPar1]) < 1)
	Update LocalPar1 Set Vencs = Nvl(Iif(LocalDcOpe.DocFxVencs = 1, Vencs, Ctot([])), Ctot([]))
	Select Sum(1) as Total, Ttod(Vencs) as Vencs, FPags, MoeFpgs, CotFpgs, Valos, Descrs ;
	  From LocalPar1 ;
	lcQuery = [Select a.Codigos ] + ;
				[From SigMvPec a ] + ;
	If (loCnx.SqlExecute(lcQuery, [LocalEstPe]) < 1)
	lcQuery = [Select a.*, b.Descs From SigMvIte a Inner Join SigCdEmb b On a.CodEmbs = b.Cods Where a.EmpDopNums = '] + lcEdn + [']
	If loCnx.SqlExecute(lcQuery, [LocalMvIte]) < 1
	If loCnx.SqlExecute([Select * From SigCdobs],'TmpObs') < 1
	lStrQuery = [Select * from SigOpFnl Where EmpDopNums = ']+lcEdn+[' ]
	If loCnx.SqlExecute(lStrQuery,'crTmpFnl') < 1
				DELETE FOR EMPTY(cpros)
			Select crCabecalho
			Select crDados2
		Select crCabecalho
	Select LocalPar
			Delete
		Select crCabecalho
		Select LocalPar
	Delete File &lcArq.
	Delete File &lcArq.
	Delete File &lcArq.
		lcQuery = [Select Emails From SigCdCli Where Iclis = '] + LocalEest.ContaOs + [']
		loCnx.Sqlexecute(lcQuery, [crTmpCli])
		lcQuery = [Select Emails From SigCdCli Where Iclis = '] + LocalEest.ContaDs + [']
		loCnx.Sqlexecute(lcQuery, [crTmpCli])
	lcQuery = [Select rtrim(ltrim(b.Descrs)) + ' - ' + case when ctits = '' then rtrim(ltrim(a.Resps)) else rtrim(ltrim(c.descrs)) End as ObsDet ] + ;
			[From SigMvFtc a ] + ;
			[Join SigCrRaP b on a.ccars = b.codigos ] + ;
			[Join SigPrCpP c on a.ctits = c.codigos ] + ;
	loCnx.SqlExecute(lcQuery,'LocalDet')
	Select LocalDet
		lcQuery = [Select Top 1 Saldos, Moedas, IsNull(DtEmis,Datas) as Datas From SigMvCcr ] + ;
		loCnx.Sqlexecute(lcQuery, [crSldCta])
		lcQuery = [Select Top 1 Saldos, Moedas, IsNull(DtEmis,Datas) as Datas ] + ;
				[From SigMvCcr ] + ;
		loCnx.Sqlexecute(lcQuery, [crSldCta2])
	Insert Into crCabecalho (Dopes, Numes, Datas, Razas, RazSocs, Cgcs, Ies, Obses, TitFornec, DckPrzE, DocPrzE, DckReffs, DocReffs, ;
		Select LocalEstPe
		Select LocalPar
			Select LocalPar
			Select LocalPar1
				If Seek(Alltrim(LocalPar1.Descrs)+Alltrim(LocalPar1.MoeFpgs),'crLcPag','IdxLcPag')
					Insert Into crLcPag (Total,Descrs,MoeFpgs,Valos,CotFpgs) Values (1,LocalPar1.Descrs,LocalPar1.MoeFpgs,LocalPar1.Valos,LocalPar1.CotFpgs) 
			Select crLcPag
	Select LocalEestI
			lcQuery = [Select DescFis, DPro3s, CProEqs ] + ;
						[From SigCdPro ] + ;
			If (loCnx.SqlExecute(lcQuery, [LocalPro]) < 1)
			lcQuery = [Select FigJpgs, Colecoes, codfinp, pesobs, linhas, Mercs From SigCdPro Where Cpros = '] + LocalEestI.CPros + [']
			If (loCnx.SqlExecute(lcQuery, [LocalPro]) < 1)
			lcQuery = [Select FigJpgs, Colecoes, codfinp, pesobs, linhas, Mercs From SigCdPro Where Cpros = '] + LocalEestI.CPros + [']
			If (loCnx.SqlExecute(lcQuery, [LocalPro]) < 1)
					Select xtotEmb
					If !Seek( LocalPro.Colecoes + lcFator )
						Insert Into xtotEmb(Colecoes, Fators) values (LocalPro.Colecoes, lcFator)
					Select CodEmbs, Descs, Qtds, Pesos From LocalMvIte Where Citens = LocalEestI.Citens into cursor LocalEmb
					Select LocalEmb
		Select LocalEstI2
		If Seek(Str(LocalEestI.CItens, 6), 'LocalEstI2', 'CItens')
			Select LocalEstI2
					lcQuery = [Select Reffs from SigPrFnc where cPros = ']+LocalEstI2.cPros+[' and iFors = ']+lcFor+[']
					If(loCnx.SQLExecute(lcQuery,[LocalfPro]) < 1 )
				Insert Into crDados (Pagina, CItens, CPros, Reffs, DPros, DPro2s, CUnis, Qtds, Units, Unitorigs, Totas, Moedas, MoeVals, ;
				If Not Seek(LocalEestI.Fator, [crFatores], [Fator])
					Insert Into crFatores (Fator) Values (LocalEestI.Fator)
				If Not Seek(LocalEstI2.Moedas, [crMoedas], [CMoes])
					Insert Into crMoedas (CMoes, CotFpgs) Values (LocalEstI2.Moedas, LocalEstI2.MoeVals)
					lcquery = [Select i.CItens, i.Qtds , i.CodEmbs, i.CodTams, i.CodCors, ] + ;
					  			[From SigMvIts i ] +;
					loCnx.SQLExecute(lcquery,'TmpRel2')
					Select TmpRel2
						Insert Into crDados (Pagina, CItens, CPros, Reffs, DPros, DPro2s, CUnis, Qtds, Units, ;
						Select TmpRel2
				Select LocalEstI2
			Select LocalEestI
				lcQuery = [Select Reffs from SigPrFnc where cPros = ']+LocalEestI.cPros+[' and iFors = ']+lcFor+[']
				If(loCnx.SQLExecute(lcQuery,[LocalfPro]) < 1 )
				Select SUM(Pesos) as pesos From LocalMvIte Where Citens = LocalEestI.Citens into cursor LocalEmb
			Select LocalEestI
			Insert Into crDados (Pagina, CItens, CPros, Reffs, DPros, DPro2s, CUnis, Qtds, Units, unitOrigs, Totas, Moedas, ;
			If Not Seek(LocalEestI.Fator, [crFatores], [Fator])
				Insert Into crFatores (Fator) Values (LocalEestI.Fator)
			If Not Seek(LocalEestI.Moedas, [crMoedas], [CMoes])
				Insert Into crMoedas (CMoes, CotFpgs) Values (LocalEestI.Moedas, LocalEestI.MoeVals)
		SELECT LocalEestIE
			Insert Into crDados (Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds, Units, Totas, Moedas, ;
		Select xtotEmb
				SELECT SUM(Qtds*pesos*fators) as nVt, SUM(Qtds*pesos) as nVL, SUM(Qtds) as nTQ  from LocalEestI where colecoes = lcCol and fators = lnFat into cursor crAux
			Insert Into crDados (Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds, Units, Totas, Moedas, ;
			SELECT xtotemb					 		 
		Select * From crDados Into Cursor crDados Order By Colecoes, Fators, Citens ReadWrite
		Select crDados
		Select * From crDados Into Cursor crDados Order By Colecoes, Fators, Pagina, Citens ReadWrite
			Insert Into crDados (Pagina) Values (lnPgn)
	Select csBranco
	Append Memo Branco From (ThisForm.ImgBranco) OverWrite
		Select [] as Agrupar, Sum(Val(Qtds)) as Qtds ;
		  From crDados ;
			Select crMoedas
			Select crMoedas
	Select crFatores
	SELECT crTmpFnl
		SELECT tmpObs
		Select crTmpFnl
	SELECT * from crdados where !EMPTY(pagina) and !EMPTY(citens) into cursor crAux
	SELECT crDados
		SELECT crAux
			SELECT crDados
			SELECT crAux
	Select * From crDados Where Padr(Cpros,10) = Colecoes Into Cursor crDados2 Order By Colecoes, Fators, Pagina, Citens ReadWrite
	Select crDados2
Select LocalEmp
Select crCabecalho
Select crDados
			lcQuery = [ Select a.Ndopes, b.chkImpDoc ] + ;
					    [ From SigCdOpe a, SigOpCdc b ]+ ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdOpeD]) < 1)
				DELETE FOR EMPTY(cpros)
			Select crCabecalho
			Select crDados2
		Select crCabecalho
	Select LocalPar
			Delete
		Select crCabecalho
		Select LocalPar
Select CItens as Itens, CPros as Produtos, Reffs as Referencia, ;
  From crDados ;
Select crExcel
Select (lcTabela)
					Select crCabecalho
					Select crDados2
		Select crCabecalho
	Select LocalPar
			Delete
		Select crCabecalho
		Select LocalPar

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreifx.prg) - TRECHOS RELEVANTES PARA PASS SQL (830 linhas total):

*-- Linhas 112 a 131:
112:                 *-- Consulta leve em SigCdOpe para obter Docus (tipo do documento)
113:                 *   Necess" + CHR(225) + "rio para visibilidade dos checkboxes ANTES de PrepararDados()
114:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
115:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
116:                         "SELECT Docus FROM SigCdOpe WHERE Dopes = '" + THIS.this_cDopes + "'", ;
117:                         "cursor_4c_TmpDocType")
118:                     IF loc_nResultado > 0 AND USED("cursor_4c_TmpDocType")
119:                         GO TOP IN cursor_4c_TmpDocType
120:                         IF !EOF("cursor_4c_TmpDocType")
121:                             loc_nDocus = cursor_4c_TmpDocType.Docus
122:                         ENDIF
123:                         USE IN cursor_4c_TmpDocType
124:                     ENDIF
125:                 ENDIF
126: 
127:                 *-- Montar cabecalho escuro superior (equivalente ao cntSombra do legado)
128:                 THIS.ConfigurarCabecalho()
129: 
130:                 *-- Montar botoes de acao (equivalente ao btnReport do legado)
131:                 THIS.ConfigurarBotoes()

*-- Linhas 236 a 342:
236:     *   Left=578 EXATO do original (btnReport.Left=578, Width=845).
237:     *   Buttons: Visualizar(1), Imprimir(2), Excel(3), Sair(4).
238:     *--------------------------------------------------------------------------
239:     PROTECTED PROCEDURE ConfigurarBotoes()
240:         LOCAL loc_cIcones
241:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
242: 
243:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
244:         WITH THIS.cmg_4c_Botoes
245:             .Top           = 0
246:             .Left          = 578   && EXATO do original: btnReport.Left = 578
247:             .Width         = 267   && 845 - 578 = 267
248:             .Height        = 80
249:             .ButtonCount   = 4
250:             .BackStyle     = 0
251:             .BorderStyle   = 0
252:             .BorderColor   = RGB(136, 189, 188)
253:             .SpecialEffect = 1
254:             .Themes        = .F.
255:             .Visible       = .T.
256: 
257:             WITH .Buttons(1)
258:                 .Top             = 5
259:                 .Left            = 5
260:                 .Width           = 65
261:                 .Height          = 70
262:                 .Caption         = "Visualizar"
263:                 .FontBold        = .T.
264:                 .FontItalic      = .T.
265:                 .BackColor       = RGB(255, 255, 255)
266:                 .ForeColor       = RGB(90, 90, 90)
267:                 .PicturePosition = 13
268:                 .SpecialEffect   = 0
269:                 .MousePointer    = 15
270:                 .ToolTipText     = "Gerar o Documento no V" + CHR(237) + "deo"
271:                 .Themes          = .F.
272:                 .Visible         = .T.
273:                 IF !EMPTY(loc_cIcones)
274:                     .Picture = loc_cIcones + "relatorio_video_26.jpg"
275:                 ENDIF
276:             ENDWITH
277: 
278:             WITH .Buttons(2)
279:                 .Top             = 5
280:                 .Left            = 71
281:                 .Width           = 65
282:                 .Height          = 70
283:                 .Caption         = "Imprimir"
284:                 .FontName        = "Comic Sans MS"
285:                 .FontBold        = .T.
286:                 .FontItalic      = .T.
287:                 .FontSize        = 8
288:                 .BackColor       = RGB(255, 255, 255)
289:                 .ForeColor       = RGB(90, 90, 90)
290:                 .PicturePosition = 13
291:                 .SpecialEffect   = 0
292:                 .MousePointer    = 15
293:                 .ToolTipText     = "Enviar o Documento Para Impressora"
294:                 .Themes          = .F.
295:                 .Visible         = .T.
296:                 IF !EMPTY(loc_cIcones)
297:                     .Picture = loc_cIcones + "relatorio_impressora_26.jpg"
298:                 ENDIF
299:             ENDWITH
300: 
301:             WITH .Buttons(3)
302:                 .Top             = 5
303:                 .Left            = 137
304:                 .Width           = 65
305:                 .Height          = 70
306:                 .Caption         = "Excel"
307:                 .FontName        = "Comic Sans MS"
308:                 .FontBold        = .T.
309:                 .FontItalic      = .T.
310:                 .FontSize        = 8
311:                 .BackColor       = RGB(255, 255, 255)
312:                 .ForeColor       = RGB(90, 90, 90)
313:                 .PicturePosition = 13
314:                 .SpecialEffect   = 0
315:                 .MousePointer    = 15
316:                 .ToolTipText     = "Exportar para Excel"
317:                 .Themes          = .F.
318:                 .Visible         = .T.
319:                 IF !EMPTY(loc_cIcones)
320:                     .Picture = loc_cIcones + "relatorio_excel_26.jpg"
321:                 ENDIF
322:             ENDWITH
323: 
324:             WITH .Buttons(4)
325:                 .Top             = 5
326:                 .Left            = 203
327:                 .Width           = 65
328:                 .Height          = 70
329:                 .Caption         = "Sair"
330:                 .Cancel          = .T.
331:                 .FontName        = "Comic Sans MS"
332:                 .FontBold        = .T.
333:                 .FontItalic      = .T.
334:                 .FontSize        = 8
335:                 .BackColor       = RGB(255, 255, 255)
336:                 .ForeColor       = RGB(90, 90, 90)
337:                 .PicturePosition = 13
338:                 .SpecialEffect   = 0
339:                 .MousePointer    = 15
340:                 .ToolTipText     = "[Esc] Sair"
341:                 .Themes          = .F.
342:                 .Visible         = .T.

*-- Linhas 353 a 418:
353:     *   os campos de filtro sao agrupados em um PageFrame de 1 pagina para
354:     *   consistencia com o restante do sistema (Page1 = "Filtros" hospeda
355:     *   chk_4c_ChkObs e chk_4c_ChkImagem).
356:     *
357:     *   Geometria: logo abaixo do cmg_4c_Botoes (80px) ate o fim do form.
358:     *     Top    = 80
359:     *     Left   = 0
360:     *     Width  = THIS.Width
361:     *     Height = THIS.Height - 80  (= 50 para form de 130 de altura)
362:     *     Tabs   = .F.   (esconder abas, ja que ha apenas 1 pagina logica)
363:     *--------------------------------------------------------------------------
364:     PROTECTED PROCEDURE ConfigurarPageFrame()
365:         LOCAL loc_oPgf
366: 
367:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
368:         loc_oPgf = THIS.pgf_4c_Paginas
369: 
370:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
371:         loc_oPgf.PageCount = 1
372: 
373:         *-- Posicionamento: logo abaixo do cabecalho/botoes (80px) ate fim do form
374:         loc_oPgf.Top    = 80
375:         loc_oPgf.Left   = 0
376:         loc_oPgf.Width  = THIS.Width
377:         loc_oPgf.Height = THIS.Height - 80
378:         loc_oPgf.Tabs   = .F.
379: 
380:         loc_oPgf.Visible = .T.
381: 
382:         *-- Configurar Page1 (estilo, fontes, cores) via metodo dedicado
383:         THIS.ConfigurarPaginaLista()
384: 
385:         *-- Ativar Page1 (unica pagina logica deste form REPORT)
386:         THIS.AlternarPagina(1)
387:     ENDPROC
388: 
389:     *--------------------------------------------------------------------------
390:     * ConfigurarPaginaLista - Configura Page1 do pgf_4c_Paginas
391:     *   Em forms CRUD, este metodo configura a pagina de listagem (grid).
392:     *   Neste form REPORT (frmrelatorio), Page1 hospeda os checkboxes de
393:     *   filtros de impressao (chk_4c_ChkObs, chk_4c_ChkImagem); portanto,
394:     *   este metodo aplica apenas o estilo visual da pagina - os controles
395:     *   sao adicionados separadamente por ConfigurarCheckBoxes() pois sua
396:     *   visibilidade depende do tipo do documento (Docus) consultado em
397:     *   InicializarForm().
398:     *
399:     *   PILAR 1 (UX): Page1.BackColor e ForeColor seguem o padrao do
400:     *   framework frmrelatorio (fundo branco, texto cinza 90,90,90).
401:     *--------------------------------------------------------------------------
402:     PROTECTED PROCEDURE ConfigurarPaginaLista()
403:         LOCAL loc_oPagina
404: 
405:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
406:             RETURN
407:         ENDIF
408:         IF THIS.pgf_4c_Paginas.PageCount < 1
409:             RETURN
410:         ENDIF
411: 
412:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
413: 
414:         *-- Estilo visual da Page1 (Filtros)
415:         loc_oPagina.Caption   = "Filtros"
416:         loc_oPagina.FontName  = "Tahoma"
417:         loc_oPagina.FontSize  = 8
418:         loc_oPagina.BackColor = RGB(255, 255, 255)

*-- Linhas 431 a 540:
431:     *
432:     *   Retorno: .T. se a pagina foi ativada com sucesso, .F. caso contrario.
433:     *--------------------------------------------------------------------------
434:     PROCEDURE AlternarPagina(par_nPagina)
435:         LOCAL loc_lOk, loc_nPagina, loc_oPgf
436:         loc_lOk     = .F.
437:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
438: 
439:         TRY
440:             loc_oPgf = THIS.pgf_4c_Paginas
441:             IF VARTYPE(loc_oPgf) = "O"
442:                 *-- Limitar entre 1 e PageCount
443:                 IF loc_nPagina < 1
444:                     loc_nPagina = 1
445:                 ENDIF
446:                 IF loc_nPagina > loc_oPgf.PageCount
447:                     loc_nPagina = loc_oPgf.PageCount
448:                 ENDIF
449: 
450:                 *-- Garantir que o PageFrame esteja visivel antes de ativar
451:                 loc_oPgf.Visible    = .T.
452:                 loc_oPgf.ActivePage = loc_nPagina
453: 
454:                 loc_lOk = .T.
455:             ENDIF
456:         CATCH TO loc_oErro
457:             THIS.this_cMensagemErro = loc_oErro.Message
458:         ENDTRY
459: 
460:         RETURN loc_lOk
461:     ENDPROC
462: 
463:     *--------------------------------------------------------------------------
464:     * ConfigurarPaginaDados - Campos de filtro da pagina de opcoes (1a metade)
465:     *   Para forms REPORT, "PaginaDados" corresponde a pagina de filtros de
466:     *   impressao (Page1 unica, sem Page2 CRUD). Adiciona o primeiro campo
467:     *   de opcao de impressao.
468:     *
469:     *   Campos adicionados (1a metade - Phase 5):
470:     *     - chk_4c_ChkObs: Imprimir Obs Moedas/Cotacoes (visivel Docus 3/6/11)
471:     *       Top=9, Left=36 relativo a Page1 (original Top=89 - 80px PageFrame)
472:     *
473:     *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
474:     *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
475:     *--------------------------------------------------------------------------
476:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_nDocus)
477:         LOCAL loc_oPagina
478:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
479: 
480:         *-- chkObs: Imprimir Observacao de Moedas/Cotacoes
481:         loc_oPagina.AddObject("chk_4c_ChkObs", "CheckBox")
482:         WITH loc_oPagina.chk_4c_ChkObs
483:             .Top           = 9
484:             .Left          = 36
485:             .AutoSize      = .T.
486:             .Alignment     = 0
487:             .Caption       = "Imprimir Observa" + CHR(231) + CHR(227) + "o de Moedas/Cota" + CHR(231) + CHR(245) + "es"
488:             .SpecialEffect = 1
489:             .FontName      = "Arial"
490:             .FontSize      = 9
491:             IF INLIST(par_nDocus, 3, 6, 11)
492:                 *-- Visivel: Docus Fixo Horizontal (3/11) e Fixo Vertical (6)
493:                 .Value   = 1
494:                 .Visible = .T.
495:             ELSE
496:                 *-- Oculto: valor = 1 apenas se Docus=6 (Fixo Vertical sem checkbox visivel)
497:                 .Value   = IIF(par_nDocus = 6, 1, 0)
498:                 .Visible = .F.
499:             ENDIF
500:         ENDWITH
501:     ENDPROC
502: 
503:     *--------------------------------------------------------------------------
504:     * ConfigurarCheckBoxes - Campos de filtro da pagina de opcoes (2a metade)
505:     *   Complementa ConfigurarPaginaDados() adicionando o segundo campo de
506:     *   opcao de impressao (chk_4c_ChkImagem).
507:     *
508:     *   Campos adicionados (2a metade - Phase 6):
509:     *     - chk_4c_ChkImagem: Imprimir Imagem do produto (visivel Docus 6/10)
510:     *       Top=25, Left=36 relativo a Page1 (original Top=105 - 80px PageFrame)
511:     *
512:     *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
513:     *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
514:     *--------------------------------------------------------------------------
515:     PROTECTED PROCEDURE ConfigurarCheckBoxes(par_nDocus)
516:         LOCAL loc_oPagina
517:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
518: 
519:         *-- chkImagem: Imprimir Imagem do produto
520:         loc_oPagina.AddObject("chk_4c_ChkImagem", "CheckBox")
521:         WITH loc_oPagina.chk_4c_ChkImagem
522:             .Top           = 25
523:             .Left          = 36
524:             .AutoSize      = .T.
525:             .Alignment     = 0
526:             .Caption       = "Imprimir Imagem"
527:             .Value         = 1
528:             .SpecialEffect = 1
529:             .FontName      = "Arial"
530:             .FontSize      = 9
531:             *-- Visivel apenas para Docus 6 (Fixo Vertical) e 10 (Tres Vias)
532:             .Visible       = INLIST(par_nDocus, 6, 10)
533:         ENDWITH
534:     ENDPROC
535: 
536:     *--------------------------------------------------------------------------
537:     * VerificarHistoricoImpressao - Verifica se o documento ja foi impresso
538:     *   Se SigOpCdc.chkImpDoc = 1 e SigMvCab.Impress <> 0:
539:     *     - Consulta permissao de reimpressao via fChecaAcesso
540:     *     - Desabilita botoes Imprimir e Excel se sem permissao

*-- Linhas 556 a 576:
556: 
557:             IF loc_lContinuar
558:                 *-- Verificar se a operacao tem controle de impressao (SigOpCdc.chkImpDoc)
559:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
560:                     "SELECT a.NDopes, b.chkImpDoc " + ;
561:                     "FROM SigCdOpe a, SigOpCdc b " + ;
562:                     "WHERE a.Dopes = '" + THIS.this_cDopes + "' " + ;
563:                     "AND b.Dopes = a.Dopes", ;
564:                     "cursor_4c_TmpChkDoc")
565:                 IF loc_nResultado < 1 OR !USED("cursor_4c_TmpChkDoc")
566:                     loc_lContinuar = .F.
567:                 ENDIF
568:             ENDIF
569: 
570:             IF loc_lContinuar
571:                 GO TOP IN cursor_4c_TmpChkDoc
572:                 IF EOF("cursor_4c_TmpChkDoc")
573:                     loc_lContinuar = .F.
574:                 ELSE
575:                     loc_lChkImpDoc = (cursor_4c_TmpChkDoc.chkImpDoc <> 0)
576:                     loc_nNDopes    = cursor_4c_TmpChkDoc.NDopes

*-- Linhas 584 a 603:
584:             IF loc_lContinuar
585:                 *-- Verificar se o documento ja foi impresso em SigMvCab.Impress
586:                 loc_lcEdn = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
587:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
588:                     "SELECT Impress FROM SigMvCab WHERE EmpDopNums = '" + loc_lcEdn + "'", ;
589:                     "cursor_4c_TmpImpress")
590:                 IF loc_nResultado < 1 OR !USED("cursor_4c_TmpImpress")
591:                     loc_lContinuar = .F.
592:                 ENDIF
593:             ENDIF
594: 
595:             IF loc_lContinuar
596:                 GO TOP IN cursor_4c_TmpImpress
597:                 loc_lImpresso = (!EOF("cursor_4c_TmpImpress") AND cursor_4c_TmpImpress.Impress <> 0)
598:                 USE IN cursor_4c_TmpImpress
599:                 IF !loc_lImpresso
600:                     loc_lContinuar = .F.
601:                 ENDIF
602:             ENDIF
603: 

*-- Linhas 702 a 732:
702:         ENDIF
703:     ENDPROC
704: 
705:     *--------------------------------------------------------------------------
706:     * BtnDocExcelClick - Exporta dados do documento para cursor crExcel
707:     *--------------------------------------------------------------------------
708:     PROCEDURE BtnDocExcelClick()
709:         IF VARTYPE(THIS.this_oRelatorio) != "O"
710:             MsgErro("BO n" + CHR(227) + "o inicializado", "Erro")
711:             RETURN
712:         ENDIF
713:         THIS.FormParaRelatorio()
714:         THIS.this_oRelatorio.DocumentoExcel()
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * BtnSairClick - Fecha o formulario
719:     *--------------------------------------------------------------------------
720:     PROCEDURE BtnSairClick()
721:         THIS.Release()
722:     ENDPROC
723: 
724:     *--------------------------------------------------------------------------
725:     * LimparCampos - Reinicia checkboxes de filtro para valores padrao
726:     *   Chamado por FormBase em certas transicoes de estado.
727:     *--------------------------------------------------------------------------
728:     PROTECTED PROCEDURE LimparCampos()
729:         LOCAL loc_oErro
730:         TRY
731:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND THIS.pgf_4c_Paginas.PageCount >= 1
732:                 LOCAL loc_oPagina

*-- Linhas 2195 a 830:

*-- Linhas 2641 a 830:

*-- Linhas 2667 a 830:

