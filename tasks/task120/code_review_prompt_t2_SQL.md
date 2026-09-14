# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (9)
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreifx.prg) - TRECHOS RELEVANTES PARA PASS SQL (835 linhas total):

*-- Linhas 112 a 131:
112:                 *-- Consulta leve em SigCdOpe para obter Docus (tipo do documento)
113:                 *   Necess" + CHR(225) + "rio para visibilidade dos checkboxes ANTES de PrepararDados()
114:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
115:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
116:                         "SELECT Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes), ;
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

*-- Linhas 561 a 582:
561: 
562:             IF loc_lContinuar
563:                 *-- Verificar se a operacao tem controle de impressao (SigOpCdc.chkImpDoc)
564:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
565:                     "SELECT a.NDopes, b.chkImpDoc " + ;
566:                     "FROM SigCdOpe a, SigOpCdc b " + ;
567:                     "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes) + " " + ;
568:                     "AND b.Dopes = a.Dopes", ;
569:                     "cursor_4c_TmpChkDoc")
570:                 IF loc_nResultado < 1 OR !USED("cursor_4c_TmpChkDoc")
571:                     loc_lContinuar = .F.
572:                 ENDIF
573:             ENDIF
574: 
575:             IF loc_lContinuar
576:                 GO TOP IN cursor_4c_TmpChkDoc
577:                 IF EOF("cursor_4c_TmpChkDoc")
578:                     loc_lContinuar = .F.
579:                 ELSE
580:                     loc_lChkImpDoc = (cursor_4c_TmpChkDoc.chkImpDoc <> 0)
581:                     loc_nNDopes    = cursor_4c_TmpChkDoc.NDopes
582:                 ENDIF

*-- Linhas 589 a 608:
589:             IF loc_lContinuar
590:                 *-- Verificar se o documento ja foi impresso em SigMvCab.Impress
591:                 loc_lcEdn = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
592:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
593:                     "SELECT Impress FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn), ;
594:                     "cursor_4c_TmpImpress")
595:                 IF loc_nResultado < 1 OR !USED("cursor_4c_TmpImpress")
596:                     loc_lContinuar = .F.
597:                 ENDIF
598:             ENDIF
599: 
600:             IF loc_lContinuar
601:                 GO TOP IN cursor_4c_TmpImpress
602:                 loc_lImpresso = (!EOF("cursor_4c_TmpImpress") AND cursor_4c_TmpImpress.Impress <> 0)
603:                 USE IN cursor_4c_TmpImpress
604:                 IF !loc_lImpresso
605:                     loc_lContinuar = .F.
606:                 ENDIF
607:             ENDIF
608: 

