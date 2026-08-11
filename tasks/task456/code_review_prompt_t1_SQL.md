# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ADICIONA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, 0, NUMLOTES, EMPS, NUMLOTECHS, VOPERS, UMOVS, NUMS, NOPERS, ICLIS, DOPES, NUMES, CIDCHAVES, BANCOS, AGENCIAS, CONTAS, NUMEROS, NCONTAS, NCHEQUES, LNRECNO, PARCELAS, LCBANCO, ORDENS, CPFS, EMIINDS, ALTDADOS, EMIPROTS, VALPENDS, BXPENDS, VALPEND2S, CODIGOS, TIPOS, GRUPOS, CLASS, VENCS, NALINEAS, BXCOMCHQS, OBS, EMPDOPNUMS, DTENTS, CONCS, NUMOS, TAMGRPBOTOES, CONCARTS, DOCUS, LNCLASSERR, LNERRO2, ALTCOTS, ICL, VALORS, DEVOLVIDOS, MARCA, CADEM, VINCULAS, COTAS, VALOR, DTSIS, FLAG, NDTEMISS, LCGRUPO, EMPINDS, ALINEAS, VALUE, CADEMIS, DISPMOVS, DTALTS, PAGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, 0, NUMLOTES, EMPS, NUMLOTECHS, VOPERS, UMOVS, NUMS, NOPERS, ICLIS, DOPES, NUMES, CIDCHAVES, BANCOS, AGENCIAS, CONTAS, NUMEROS, NCONTAS, NCHEQUES, LNRECNO, PARCELAS, LCBANCO, ORDENS, CPFS, EMIINDS, ALTDADOS, EMIPROTS, VALPENDS, BXPENDS, VALPEND2S, CODIGOS, TIPOS, GRUPOS, CLASS, VENCS, NALINEAS, BXCOMCHQS, OBS, EMPDOPNUMS, DTENTS, CONCS, NUMOS, TAMGRPBOTOES, CONCARTS, DOCUS, LNCLASSERR, LNERRO2, ALTCOTS, ICL, VALORS, DEVOLVIDOS, MARCA, CADEM, VINCULAS, COTAS, VALOR, DTSIS, FLAG, NDTEMISS, LCGRUPO, EMPINDS, ALINEAS, VALUE, CADEMIS, DISPMOVS, DTALTS, PAGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERACAO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, 0, NUMLOTES, EMPS, NUMLOTECHS, VOPERS, UMOVS, NUMS, NOPERS, ICLIS, DOPES, NUMES, CIDCHAVES, BANCOS, AGENCIAS, CONTAS, NUMEROS, NCONTAS, NCHEQUES, LNRECNO, PARCELAS, LCBANCO, ORDENS, CPFS, EMIINDS, ALTDADOS, EMIPROTS, VALPENDS, BXPENDS, VALPEND2S, CODIGOS, TIPOS, GRUPOS, CLASS, VENCS, NALINEAS, BXCOMCHQS, OBS, EMPDOPNUMS, DTENTS, CONCS, NUMOS, TAMGRPBOTOES, CONCARTS, DOCUS, LNCLASSERR, LNERRO2, ALTCOTS, ICL, VALORS, DEVOLVIDOS, MARCA, CADEM, VINCULAS, COTAS, VALOR, DTSIS, FLAG, NDTEMISS, LCGRUPO, EMPINDS, ALINEAS, VALUE, CADEMIS, DISPMOVS, DTALTS, PAGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, 0, NUMLOTES, EMPS, NUMLOTECHS, VOPERS, UMOVS, NUMS, NOPERS, ICLIS, DOPES, NUMES, CIDCHAVES, BANCOS, AGENCIAS, CONTAS, NUMEROS, NCONTAS, NCHEQUES, LNRECNO, PARCELAS, LCBANCO, ORDENS, CPFS, EMIINDS, ALTDADOS, EMIPROTS, VALPENDS, BXPENDS, VALPEND2S, CODIGOS, TIPOS, GRUPOS, CLASS, VENCS, NALINEAS, BXCOMCHQS, OBS, EMPDOPNUMS, DTENTS, CONCS, NUMOS, TAMGRPBOTOES, CONCARTS, DOCUS, LNCLASSERR, LNERRO2, ALTCOTS, ICL, VALORS, DEVOLVIDOS, MARCA, CADEM, VINCULAS, COTAS, VALOR, DTSIS, FLAG, NDTEMISS, LCGRUPO, EMPINDS, ALINEAS, VALUE, CADEMIS, DISPMOVS, DTALTS, PAGOS

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
  ControlSource = "crSigChLcq.GrupoCCs"
  ControlSource = "crSigChLcq.ContaCCs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigChLcq.grupems"
  ControlSource = "crSigChLcq.contems"
  ControlSource = ""
  ControlSource = "crSigChLcq.obs"
  ControlSource = "crSigChLcq.codigos"
  ControlSource = "crSigChLcq.numlotes"
  ControlSource = "crSigChLcq.Usuarios"
  ControlSource = "crSigChLcq.dtents"
  ControlSource = "crSigChLcq.cnotas"
  ControlSource = "crSigChLcq.moeds"
  ControlSource = "crSigChLcq.cotas"
  ControlSource = "crSigChLcq.valconvs"
  ControlSource = "crSigChLcq.valtots"
  ControlSource = ""
  ControlSource = "crSigChLcq.grupos"
  ControlSource = "crSigChLcq.contas"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigChLcq.grclis"
  ControlSource = "crSigChLcq.iclis"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigChLcq.GruOrigs"
  ControlSource = "crSigChLcq.ConOrigs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigChLcq.concarts"
  ControlSource = "crSigChLcq.grucarts"
  ControlSource = "TempChq.NContas"
  ControlSource = "TempChq.NAlineas"
  ControlSource = "TempChq.Valors"
  ControlSource = "TempChq.Vencs"
  ControlSource = "TempChq.NCheques"
  ControlSource = "TempChq.Agencias"
  ControlSource = "TempChq.Bancos"
  ControlSource = "TempChq.Datas"
  ControlSource = "TempChq.Leituras"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TempChq.Obs"
  ControlSource = "crSigChLcq.valtots"
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  HideSelection = .F.
Select TempChq
=Seek( xPar.FPags, 'crSigOpFp', 'FPags' )
	Insert Into crSigMvCcr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
	Select crSigMvPar
		Insert Into crSigMvCcr ( NOpers, VOpers, Docus, Emps, Datas, usualts, datalts, Vencs, hists,;
Select *, Space(34) as Leituras From CrSigMvPar Where 0=1 ;
Select xPar
Select *,Space(3) as MoeComs From CrSigMvCcr Where 0=1 ;
Select TmpMccr
=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
		lcDelChm = [Delete From SigCqChm Where NumLotes = ]+Str(lnLotePar)
		lnErro   = ThisForm.podatamgr.SqlExecute(lcDelChm,'')
	lcWher  = [Select * From SigMvPar Where Emps = ']+CrSigChLcq.Emps+[' And NumloteChs = ]+Str(Codigo)
	lnErro  = ThisForm.Podatamgr.Sqlexecute(lcWher,'CrPar')
	Select CrPar
			lcWher   = [Select * From SigMvCcr Where Vopers = ']+lcVOpers+[']
			lnErro   = ThisForm.Podatamgr.SqlExecute(lcWher,'CrMccr')
			Select CrMccr
			lcDelMccr = [Delete From SigMvCcr Where Vopers = ']+lcVOpers+[']
			lnErro    = ThisForm.podatamgr.SqlExecute(lcDelMccr,'')
				lcDelChe = [Delete From SigChe Where Nums = ']+CrCheque.Nums+[']
				lnErro   = ThisForm.podatamgr.SqlExecute(lcDelChe,'')
		Select CrPar
	lcDelPar = [Delete From SigMvPar Where Emps = ']+CrSigChLcq.Emps+[' And NumloteChs = ]+Str(Codigo)
	lnErro   = ThisForm.Podatamgr.Sqlexecute(lcDelPar,'')
	lcDelCar = [Delete From SigCdCar Where Emps=']+lcEmpChq+[' And NumLoteChs=]+Str(lcLoteChq)
	lnErro   = ThisForm.PoDatamgr.SqlExecute(lcDelCar,'')
	lcDelCart= [Delete From SigCdCtt Where Emps=']+lcEmpChq+[' And NumLoteChs=]+Str(lcLoteChq)
	lnErro   = ThisForm.PoDatamgr.SqlExecute(lcDelCart,'')
	lcDelCard= [Delete From SigCdCrd Where Emps=']+lcEmpChq+[' And NumLoteChs=]+Str(lcLoteChq)
	lnErro   = ThisForm.PoDatamgr.SqlExecute(lcDelCard,'')
=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
lcWher = [Select * From SigCqChm Where NumLotes = ]+Str(codigo)
lnErro = ThisForm.PoDataMgr.SqlExecute(lcwher,'CrChm')
Select CrChm
	lcWher   = [Select * From SigMvCcr Where Vopers = ']+lcVOpers+[']
	lnErro   = ThisForm.Podatamgr.SqlExecute(lcWher,'CrMccr')
	Select CrMccr
	lcDelMccr = [Delete From SigMvCcr Where Vopers = ']+lcVOpers+[']
	lnErro    = ThisForm.podatamgr.SqlExecute(lcDelMccr,'')
		lcDelClih = [Delete From SigCdClh Where Emps=']+CrChm.Emps+[' And Nopers=]+Str(CrChm.Numos)+[ And Iclis = ']+CrChm.Iclis+[']
		lnErro    = ThisForm.Podatamgr.SqlExecute(lcDelClih,'')
	lcWher   = [Select * From SigChe Where Nums = ']+CrChm.Nums+[']
	lnErro   = ThisForm.Podatamgr.SqlExecute(lcwher,'CrCheque')
	Select CrCheque
	=Seek(CrCheque.umovs,'crSigCdOpt','operacao')
		lcWher  = [Select Count(1) As Total From SigCqChm Where Nums=']+CrCheque.Nums+[' Group By Nums ]
		lnErro  = ThisForm.podatamgr.SqlExecute(lcWher,'CsApaga')
		Select CsApaga
			lcDelChe = [Delete From SigChe Where Nums=']+CrCheque.Nums+[']
			lnErro   = ThisForm.Podatamgr.SqlExecute(lcDelche,'')
	=Seek(crSigChLcq.codigos, "crSigCdOpt", "Operacao" )
	Insert Into DelLote ( Nums ) Values ( crChm.Nums )
	Select CrChm
lcDelChm = [Delete From SigCqChm Where NumLotes = ]+Str(codigo)
lnErro   = ThisForm.PoDataMgr.SqlExecute(lcDelChm,'')
lcDelCheh = [Delete From SigCheh Where NumLotes = ]+Str(codigo)
lnErro   = ThisForm.PoDataMgr.SqlExecute(lcDelCheh,'')
Select DelLote
	lcWher = [Select * From SigCqChm Where Nums = ']+_Chave+[' Order By DtSis ]
	lnErro = ThisForm.PoDatamgr.SqlExecute(lcWher,'CrChm')
	Select CrChm
		lcUpDate = [Update SigChe Set Umovs = ']+_Umov+[', Nalineas=]+Str(lnAlineas)+;
		lnErro   = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
		lcWher = [Select * From SigChe Where Nums = ']+_Chave+[']
		lnErro = ThisForm.Podatamgr.SqlExecute(lcwher,'CrCheque')
		Select CrCheque
		If Not Empty( crCheque.FPags ) And Seek( crCheque.FPags, 'crSigOpFp', 'FPags' ) And ( crSigCdOpt.BxPends = 'S' )
				Select CrSigCdPbx
					lcWher = [Select * From SigMvPar Where Emps=']+CrSigCdPbx.Emps+[' And Dopes=']+CrSigCdPbx.Dopes+[']+;
					LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
					Select CrPar
							lcUpdate = [Update SigMvPar ] + ;
							lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
				lcWher = [Select * From SigMvPar Where Bancos=']+CrCheque.Bancos+[' And Agencias=']+CrCheque.Agencias+[']+;
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
				Select CrPar
					lcUpdate = [Update SigMvPar ] + ;
					lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
				lcWher  = [Select * From SigCdPbx Where Bancos=']+CrCheque.Bancos+[' And Agencias=']+CrCheque.Agencias+[' ]+;
				LnErro  = ThisForm.Podatamgr.SqlExecute(lcWher,'CrPrBx')
				Select CrPrBx
							Select CrPar
							If !Seek( CrPar.Emps + CrPar.Dopes + Str( CrPar.Numes, 6 ) + CrPrbx.Moedas + Str( CrPrbx.Nopers, 9 ), 'TmpComiss' )
								Insert Into TmpComiss ( Emps, Dopes, Numes, Moedas, Nopers, Cotacaos, Contas  ) ;
							If !Seek( CrPrbx.Emps + CrPrbx.Dopecs + Str( CrPrbx.Numecs, 6 ) + CrPrbx.Moecs + Str( CrPrbx.Nopercs, 9 ), 'TmpComiss' )
								Insert Into TmpComiss ( Emps, Dopes, Numes, Moedas, Nopers, Cotacaos, Contas ) ;
					Select TmpComiss
						Select CrEest
						Select CrOpe
						Select CrPar
						lcWher = [Select * From SigCdCmm Where Emps=']+TmpComiss.emps+[' And Dopes=']+TmpComiss.Dopes+[' ]+;
						LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrComis')
						Select CrComis
							lcUpDate = [UpDate SigCdCmm Set Baixas = ]+Str(CrComis.Baixas,12,2)+;
							LnErro   = ThisForm.podatamgr.SqlExecute(lcUpDate,'')
					lcWher = [Select * From SigMvPar Where Bancos=']+CrCheque.Bancos+[' And Agencias=']+CrCheque.Agencias+[']+;
					LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
					Select CrPar
						lcUpdate = [Update SigMvPar ] + ;
						lnErro   = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
						=Seek( CrPar.FPags, 'crSigOpFp', 'FPags' )
						Select CrEest
						Select CrOpe
						Select CrPar
						lcWher = [Select * From SigCdCmm Where Emps=']+CrPar.emps+[' And Dopes=']+crPar.Dopes+[' ]+;
						LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrComis')
						Select CrComis
							lcUpDate = [UpDate SigCdCmm Set Baixas = ]+Str(CrComis.Baixas,12,2)+;
							LnErro   = ThisForm.podatamgr.SqlExecute(lcUpDate,'')
				lcWher = [Select * From SigMvCcr Where Emps=']+lcOldEmps+[' And Nopers=]+Str(lcOldNumos)
				ThisForm.Podatamgr.SqlExecute(lcWher,'CrMccr')
				Select crMccr
					=Seek(lcOldCodigos,'crSigCdOpt','Operacao')
					lcWher = [Select * From SigMvCcr Where VOpers=']+lcOldVoper+[']
					ThisForm.Podatamgr.SqlExecute(lcWher,'CrvMccr')
					Select CrvMccr
							ThisForm.Podatamgr.SqlExecute([UpDate SigMvCcr Set ValPags = 0, pagos = ?lcpago, DopoTps = ?lcDtps Where Cidchaves = ']+CrvMccr.CidChaves+['],'')
			lcUpDate = [UpDate SigCdPbx Set Deposits = ?llDep  Where Bancos=']+CrCheque.Bancos+[' And Agencias=']+CrCheque.Agencias+[' ]+;
			lnErro   = ThisForm.PoDatamgr.SqlExecute(lcUpDate,'')
Select crSigChLcq
=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
		lcDelLchm = [Delete From SigChLcq Where NumLotes = ]+Str(lnNumLote)
		lnErro    = ThisForm.Podatamgr.SqlExecute(lcDellchm,'')
	lcDelLchm = [Delete From SigChLcq Where NumLotes = ]+Str(lnNumLote)
	lnErro    = ThisForm.Podatamgr.SqlExecute(lcDellchm,'')
Select crSigMvCcr
Insert Into crSigMvCcr ( VOpers, NOpers, NLancs, VLancs, Opers, Grupos,;
=Seek(CrSigChLcq.Codigos,'CrSigCdOpt','Operacao')
Select TempChq
	Select TempChq
		lcSql = [Select * From SigChe Where Bancos = ']+lcBanco+[' And Agencias = ']+lcAgencia+[' And ]+;
		OkChq = ( ThisForm.PodataMgr.Sqlexecute(lcsql,'CrCheque') > 0 And Reccount('CrCheque') > 0 )
					lcWhere = [Select * From SigCqChm Where Nums=']+CrCheQue.Nums+[' Order By Nums Desc, DtSis Desc ]
					lnErro = Thisform.podatamgr.SqlExecute(lcWhere,'CrChm')
					Select CrChm
							If Seek(crCheque.Umovs,'CrSigCdOpt','Operacao')
								=Seek(crSigChLcq.Codigos,'CrSigCdOpt','Operacao')
			lcUpdate = [Update SigChe Set nCheques = nCheques Where Nums = ']+CrCheque.Nums+[']
			If ThisForm.podatamgr.sqlexecute(lcupdate,'') < 1
		=Seek(crSigChLcq.Codigos,'CrSigCdOpt','Operacao')
				Select crSigChLcq
	=Seek(crSigChLcq.Codigos,'CrSigCdOpt','Operacao')
		lcquery = [Select bancos,agencias,contas,ncheques,emps,cpfs,id,dopes,ncheqfin,vencs,valors,datas,cidchaves From SigCqLcq Where Bancos = ']+lcBanco+[' And Agencias = ']+lcAgencia+[' ]+;
		=ThisForm.Podatamgr.SqlExecute(lcQuery,'CrSigCqLcq')
		Select CrSigCqLcq
			lcquery = [Select bancos,agencias,contas,ncheques,emps,cpfs,id,dopes,ncheqfin,vencs,valors,datas,cidchaves From SigCqLcq Where Bancos = ']+lcBanco+[' And Agencias = ']+lcAgencia+[' ]+;
			=ThisForm.Podatamgr.SqlExecute(lcQuery,'CrSigCqLcq')
			Select TempChq
				Select TempChq
				Select crSigChLcq
			Select TempChq
				Select TempChq
					Select TempChq
		lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
		=Thisform.PodataMgr.Sqlexecute(lcsql,'CrTmpcli')
		Select CrTmpCli
		Select TempChq
			Select crSigChLcq
			Select CrSigCheH
Select TempChq
Select TempChq
=Seek(crSigChLcq.Codigos, 'crSigCdOpt', 'Operacao')
Select TempChq
		Insert Into TmpRelat From MemVar
	Select xPar
			lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select CrTmpCli
			Insert Into TmpRelat From MemVar
lcSql = [Select Iclis,Rclis,Cpfs,grupos,RAZAOS From SigCdCli where Iclis = ']+lcCliente+[']
=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
Select CrTmpCli
Select TmpRelat
Select TempChq
=Seek(ThisForm.Locregister,'crSigChLcq','NumLotes')
Select CrSigChe
Select CrSigCheh
Select CrSigMvCcr
Select CrSigCqChm
Select TmpMccr
Select CrSigCdClh
Select CrSigMvPar
Select CrSigCdPbx
Select CrSigClLan
Select CrSigCdCar
Select CrSigCdCtt
Select CrSigCdCrd
=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
Select TempChq
				Select crSigCdCli
					=Seek(lcGrPadClis,'crSigCdGcr','Codigos')
				Select TempChq
				Select TempChq
			Select crSigOpFp
			Seek (crSigCdOpt.FPags)
		Select crSigChe
			Select crSigChe
				Select crSigChe
			lcUpdate = [Update SigChe Set Leituras = ']+TempChq.Leituras+[' ,DtAlts = ?lDtAlt Where Nums = ']+CrCheque.Nums+[']
			lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
			lcUpdate = [Update SigChe Set GruRes = ']+TempChq.GruRes+[' ,ConRes = ']+TempChq.ConRes+[' Where Nums = ']+CrCheque.Nums+[']
			lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
		lcUpdate = [Update SigChe Set Vencs  = ?llVenc, Iclis = ?lcIclis Where Nums = ']+CrCheque.Nums+[']
		lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
			Select crSigChe
			lcUpdate = [Update SigChe Set Numeros = ']+Trans(_Arq,'@L 999999')+[' ,DtAlts = ?lDtAlt Where Nums = ']+CrCheque.Nums+[']
			lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
		Select TempChq
			Select crSigChe
			lcUpdate = [Update SigChe Set Emps = ']+TempChq.Emps+[', DtAlts = ?lDtAlt Where Nums = ']+CrCheque.Nums+[']
			lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
	Select crSigCdOpt
	lcWhere = [Select * From SigCqChm Where Bancos=']+TempChq.Bancos+[' And Agencias = ']+TempChq.Agencias+[']+;
	lnErro = Thisform.podatamgr.SqlExecute(lcWhere,'CrChm')
	Select CrChm
	Select crSigCqChm
		Select TempChq
		Select crSigChe
		lcUpdate = [Update SigChe Set Protocolos = ']+TempChq.Protocolos+[' , DtAlts = ?lDtAlt Where Nums = ']+CrCheque.Nums+[']
		lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
		Select crSigCheH
	If Seek( _Fpag, 'CrSigOpFp', 'Fpags' ) And crSigOpFp.ValPends = 1 And crSigCdOpt.BxPends = 'S'
			Select CrSigCdPbx
						Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
						Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
				lcWher = [Select * From SigMvPar Where Emps=']+CrSigCdPbx.Emps+[' And Dopes=']+CrSigCdPbx.Dopes+[']+;
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
				Select CrPar
						lcUpdate = [Update SigMvPar ] + ;
						lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
			lcWher = [Select * From SigMvPar Where Bancos=']+Tempchq.Bancos+[' And Agencias=']+TempChq.Agencias+[']+;
			LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
			Select CrPar
				lcUpdate = [Update SigMvPar ] + ;
				lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
					Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
					Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
		=Seek( CrChm.Codigos, 'crSigCdOpt', 'Operacao' )
		lcWher = [Select * From SigMvCcr Where Vopers=?lcNumo ]
		ThisForm.Podatamgr.SqlExecute(lcWher,'CrMccr')
		Select CrMccr
				ThisForm.Podatamgr.SqlExecute([UpDate SigMvCcr Set ValPags = Valors, pagos=?lcpago, DopoTps = ?lcDtps Where Cidchaves = ']+CrMccr.CidChaves+['],'')
		Select crSigCdOpt
		=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
	If ( Seek( _Fpag, 'crSigOpFp', 'Fpags' ) And crSigOpFp.ValPends = 1 And crSigCdOpt.BxPends # 'S' ) Or ( crSigCdOpt.FazContas = 'S' And Empty( _FPag ) )
			Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
			Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
	If Not Empty( _FPag ) And Seek( _FPag, 'crSigOpFp', 'FPags' ) And ;
		lcWher = [Select * From SigCdPbx Where Bancos=']+Tempchq.Bancos+[' And Agencias=']+Tempchq.Agencias+[' ]+;
		LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrPrBx')
		Select CrPrBx
					Select CrPar
					If !Seek( CrPar.Emps + CrPar.Dopes + Str( CrPar.Numes, 6 ) + CrPrbx.Moedas + Str( CrPrbx.Nopers, 7 ), 'TmpComiss' )
						Insert Into TmpComiss ( Emps, Dopes, Numes, Moedas, Nopers, Cotacaos, Contas  ) ;
					If !Seek( CrPrbx.Emps + CrPrbx.Dopecs + Str( CrPrbx.Numecs, 6 ) + CrPrbx.Moecs + Str( CrPrbx.Nopercs, 7 ), 'TmpComiss' )
						Insert Into TmpComiss ( Emps, Dopes, Numes, Moedas, Nopers, Cotacaos, Contas ) ;
			Select TmpComiss
				Select CrEest
				Select CrOpe
				Select CrPar
				lcWher = [Select * From SigCdCmm Where Emps=']+TmpComiss.emps+[' And Dopes=']+TmpComiss.Dopes+[' ]+;
				LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrSigCdCmm')
				Select CrSigCdCmm
						lcUpDate = [UpDate SigCdCmm Set Baixas = ]+Str(CrSigCdCmm.Baixas,12,2)+;
						LnErro   = ThisForm.podatamgr.SqlExecute(lcUpDate,'')
						lcSql = [Select ComMoedas From SigCdGcr Where Codigos = ']+CrSigCdCmm.Grupos+[']
						If Thisform.Podatamgr.Sqlexecute(lcSql,'TmpGccr') < 1
						Select TmpMccr
						If !Seek(crSigCdCmm.Grupos+crSigCdCmm.Contas+Padr(_Hist,40)+Padr(lnMoeda,3)+Padr(lcMoeCom,3)+Padr(_Hist2,40))
			lcWher = [Select * From SigMvPar Where Bancos=']+TempChq.Bancos+[' And Agencias=']+TempChq.Agencias+[']+;
			LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
			Select CrPar
				Select CrEest
				Select CrOpe
				Select CrPar
				lcWher = [Select * From SigCdCmm Where Emps=']+CrPar.emps+[' And Dopes=']+crPar.Dopes+[' ]+;
				LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrSigCdCmm')
				Select CrSigCdCmm
						lcUpDate = [UpDate SigCdCmm Set Baixas = ]+Str(CrSigCdCmm.Baixas,12,2)+;
						LnErro   = ThisForm.podatamgr.SqlExecute(lcUpDate,'')
						lcSql = [Select ComMoedas From SigCdGcr Where Codigos = ']+CrSigCdCmm.Grupos+[']
						If Thisform.Podatamgr.Sqlexecute(lcSql,'TmpGccr') < 1
						Select TmpMccr
						If !Seek(crSigCdCmm.Grupos+crSigCdCmm.Contas+Padr(_Hist,40)+Padr(lnMoeda,3)+Padr(lcMoeCom,3)+Padr(_Hist2,40))
	Select crSigCqChm
		Select crSigChe
		lcUpdate = [Update SigChe Set Numos = ]+Str(_Noper)+[ , DtAlts = ?lDtAlt Where Nums = ']+CrCheque.Nums+[']
		lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
			Select CrSigClLan
			Select CrCli
			Insert Into crSigCdClh (Autos, Grupos, Iclis, Datas, Hists, Emps, Nopers, CidChaves, GruContas ) Values ;
		Select CrSigCqChm
	If !Seek(lcProcura,'TmpConsolida','TGruConMoe') Or (crSigCdOpt.Consolidas = 'N')
		Insert Into TmpConsolida (TGrupos, TContas, TMoedas, TValors, TCotas, oGrupos, oContas) ;
		Select TmpConsolida
		Select crSigChe
		lcUpdate = [Update SigChe Set ]+IIF(TempChq.nAlineas>0,[Nalineas=]+Str(TempChq.Nalineas)+[, ],[])+[ Umovs=']+CrSigChLcq.Codigos+[' ]+;
		lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
		lcWher = [Select * From SigMvCcr Where Emps=']+lcOldEmps+[' And Nopers=]+Str(lcOldNumos)
		ThisForm.Podatamgr.SqlExecute(lcWher,'CrMccr')
		Select crMccr
			=Seek(lcOldCodigos,'crSigCdOpt','Operacao')
			lcWher = [Select * From SigMvCcr Where VOpers=']+lcOldVoper+[']
			ThisForm.Podatamgr.SqlExecute(lcWher,'CrvMccr')
			Select CrvMccr
					ThisForm.Podatamgr.SqlExecute([UpDate SigMvCcr Set ValPags = Valors, pagos = ?lcpago, DopoTps = ?lcDtps Where Cidchaves = ']+CrvMccr.CidChaves+['],'')
	=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
	Select TempChq
Select TmpMccr
	Select crSigMvCcr
	Append From Array Memvar
	Select TmpConsolida
		Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
		Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
		Select TmpConsolida
	Select xPar
	select xpar
			select crSigOpFp
				Select crSigChLcq
				Insert Into crSigChLcq (dtents, dtsis, codigos, tipos, usuarios, numlotes, emps, ;
				Seek (lnNumLote)
			select crSigMvPar
			Insert Into crSigMvPar(Parcs, agencias,bancos,cartaos,contas,datas,datatrans,;
				select crSigOpFp
				select xpar
						lcUpdate = [Update SigChe Set Umovs=']+lcOpEntradas+[' , DtAlts = ?lDtAlt ]+;
						lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
						Select crSigChe
						Insert Into crSigChe ( Bancos, Agencias,NContas, NCheques, Valors, Vencs, ;
					Insert Into crSigCqChm (DtEnts, DtSis, codigos, moeds, Cotas,;
						Select crSigCheH
					select crSigCdCar
					Insert Into crSigCdCar (Emps, Datas, FPags, nlotecs, iclis, NumLoteChs);
					Insert Into crSigCdCtt (Parcs, emps, datas, datatrans,	cartaos, nocreditos, ;
						select crSigCdCrd
						Insert Into crSigCdCrd (Parcs, dt_deposit,datatrans,fpags,;
						select crSigCdCtt
					select crSigMvPar
						Select crSigCqChm
		select xpar
		Select crSigChLcq
		Seek (vLote)
				Delete
Select crSigChLcq
Seek (lnNumLote)
Select CrSigMvCcr
llErro01 = ThisForm.Podatamgr.Update('CrSigCdCli')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigCdCli)')
	Select CrSigCdCli
llErro02 = llErro01 And ThisForm.Podatamgr.Update('CrSigChe')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigChe)')
	Select CrSigChe
llErro03 = llErro02 And ThisForm.Podatamgr.Update('CrSigCqChm')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigCqChm)')
	Select CrSigCqChm
llErro04 = llErro03 And ThisForm.Podatamgr.Update('CrSigMvCcr')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigMvCcr)')
	Select CrSigMvCcr
llErro05 = llErro04 And ThisForm.Podatamgr.Update('CrSigClLan')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigClLan)')
	Select CrSigClLan
llErro06 = llErro05 And ThisForm.Podatamgr.Update('CrSigCdClh')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigCdClh)')
	Select CrSigCdClh
llErro07 = llErro06 And ThisForm.Podatamgr.Update('CrSigMvPar')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigMvPar)')
	Select CrSigMvPar
llErro08 = llErro07 And ThisForm.Podatamgr.Update('CrSigCdCar')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigCdCar)')
	Select CrSigCdCar
llErro09 = llErro08 And ThisForm.Podatamgr.Update('CrSigCdCtt')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigCdCtt)')
	Select CrSigCdCtt
llErro10 = llErro09 And ThisForm.Podatamgr.Update('CrSigCdCrd')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigCdCrd)')
	Select CrSigCdCrd
llErro11 = llErro10 And ThisForm.Podatamgr.Update('CrSigChLcq')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigChLcq)')
	Select CrSigChLcq
llErro12 = llErro11 And ThisForm.Podatamgr.UpDate('CrSigCheh')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão update (CrSigCheh)')
	Select CrSigCheh
Select TempChq
	lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
	=Thisform.PodataMgr.Sqlexecute(lcsql,'CrTmpcli')
	Select CrTmpCli
	Select TempChq
	Select TempChq
		Delete
Select TempChq
	lcSql = [select a.* from sigche a where a.umovs in (select b.operacaos from sigcdopt b ] +;
			IIF(EMPTY(lcClasEmp),[],[ and emps in (select cemps from sigcdemp where class = ']+lcClasEmp+[') ]) +;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrAuxChe')
	SELECT tempchq
	Select CrAuxChe
		SELECT tempchq
		Select CrAuxChe
		SELECT tempchq
Select crSigChLcq
Select a.*, b.OpAutos as Umovs From TempChq a, crSigCdAli b ;
Select TmpChq
			Select crSigChLcq
				Select TmpConsolida
					Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
					Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
					Select TmpConsolida
		Select crSigCdOpt
		Select crSigChLcq
		Gather From Tmp
	Select crSigCdOpt
		Select Crcheque
		Select CrSigCqChm
		lcUpDate = [UpDate SigChe Set Umovs = ']+TmpChq.Umovs+[' , Contas=']+CrSigChLcq.Contas+[' ]+;
		LnErro   = ThisForm.PoDatamgr.SqlExecute(lcUpdate,'')
		If Seek( crSigChe.FPags, 'crSigOpFp', 'Fpags' ) And crSigOpFp.ValPends = 1 And crSigCdOpt.BxPends = 'S'
				Select CrPrBx
							Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
							Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
						lcUpdate = [Update SigCdPbx Set Deposits = ?llDep Where CidChaves = ']+CrPrBx.Cidchaves+[']
						lnErro   = ThisForm.Podatamgr.SqlExecute(lcUpdate,'')
					lcWher   = [Select * From SigMvPar Where Emps=']+CrPrBx.Emps+[' And Dopes=']+CrPrBx.Dopes+[']+;
					LnErro   = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
					Select CrPar
							lcUpdate = [Update SigMvPar ] + ;
							lnErro   = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
				lcWher = [Select * From SigMvPar Where Bancos=']+Tmpchq.Bancos+[' And Agencias=']+TmpChq.Agencias+[']+;
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
				Select CrPar
					lcUpdate = [Update SigMvPar ] + ;
					lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
						Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
						Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
					=Seek( crPar.FPags, 'crSigOpFp', 'FPags' )
			Select crSigCdOpt
			=Seek( CrChm.Codigos, 'crSigCdOpt', 'Operacao' )
			lcWher = [Select * From SigMvCcr Where Vopers=?lcNumo ]
			ThisForm.Podatamgr.SqlExecute(lcWher,'CrMccr')
			Select CrMccr
					ThisForm.Podatamgr.SqlExecute([UpDate SigMvCcr Set ValPags = Valors, pagos = ?lcpago, DopoTps = ?lcDtps Where Cidchaves = ']+CrMccr.CidChaves+['],'')
			Select crSigCdOpt
			=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
		If Not Empty( crCheque.FPags ) And Seek( crCheque.FPags, 'crSigOpFp', 'FPags' ) And ;
			lcWher = [Select * From SigCdPbx Where Bancos=']+TmpChq.Bancos+[' And Agencias=']+TmpChq.Agencias+[' ]+;
			LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrPrBx')
			Select CrPrBx
						Select CrPar
						If !Seek( CrPar.Emps + CrPar.Dopes + Str( CrPar.Numes, 6 ) + CrPrbx.Moedas + Str( CrPrbx.Nopers, 9 ), 'TmpComiss' )
							Insert Into TmpComiss ( Emps, Dopes, Numes, Moedas, Nopers, Cotacaos) ;
						If !Seek( CrPrbx.Emps + CrPrbx.Dopecs + Str( CrPrbx.Numecs, 6 ) + CrPrbx.Moecs + Str( CrPrbx.Nopercs, 9 ), 'TmpComiss' )
							Insert Into TmpComiss ( Emps, Dopes, Numes, Moedas, Nopers, Cotacaos ) ;
				Select TmpComiss
					Select CrEest
					Select CrOpe
					Select CrPar
					lcWher = [Select * From SigCdCmm Where Emps=']+TmpComiss.emps+[' And Dopes=']+TmpComiss.Dopes+[' ]+;
					LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrSigCdCmm')
					Select CrSigCdCmm
							lcUpDate = [UpDate SigCdCmm Set Baixas = ]+Str(CrSigCdCmm.Baixas,12,2)+;
							LnErro   = ThisForm.podatamgr.SqlExecute(lcUpDate,'')
							lcSql = [Select ComMoedas From SigCdGcr Where Codigos = ']+CrSigCdCmm.Grupos+[']
							If Thisform.Podatamgr.Sqlexecute(lcSql,'TmpGccr') < 1
							Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
				lcWher = [Select * From SigMvPar Where Bancos=']+TmpChq.Bancos+[' And Agencias=']+TmpChq.Agencias+[']+;
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcWher,'CrPar')
				Select CrPar
					lcWher = [Select * From SigCdCmm Where Emps=']+CrPar.emps+[' And Dopes=']+crPar.Dopes+[' ]+;
					LnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CrSigCdCmm')
					Select CrSigCdCmm
							lcUpDate = [UpDate SigCdCmm Set Baixas = ]+Str(CrSigCdCmm.Baixas,12,2)+;
							LnErro   = ThisForm.podatamgr.SqlExecute(lcUpDate,'')
							lcSql = [Select ComMoedas From SigCdGcr Where Codigos = ']+CrSigCdCmm.Grupos+[']
							If Thisform.Podatamgr.Sqlexecute(lcSql,'TmpGccr') < 1
							Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
		If ( Seek( crCheque.FPags, 'crSigOpFp', 'Fpags' ) And crSigOpFp.ValPends = 1 And crSigCdOpt.BxPends # 'S' ) Or ( crSigCdOpt.FazContas = 'S' And Empty( crCheque.FPags ) )
				Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
				Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
		Select crSigCqChm
		lcUpDate = [UpDate SigChe Set Numos = ]+Str(_Noper)+[' , DtAlts = ?lDtAlt Where Nums=']+CrCheque.Nums+[']
		LnErro   = ThisForm.PoDatamgr.SqlExecute(lcUpdate,'')
				Select CrSigClLan
				Select CrtmpCli
				Insert Into crSigCdClh (Autos, Grupos, Iclis, Datas, Hists, Emps, Nopers, CidChaves, GruContas ) Values ;
		If !Seek(lcProcura,'TmpConsolida','TGruConMoe')
			Insert Into TmpConsolida (TGrupos, TContas, TMoedas, TValors, TCotas) Values ;
			Select TmpConsolida
	lcUpDate = [UpDAte SigChe Set Nalineas=]+Str(TmpChq.Nalineas)+[ , Umovs=']+CrSigChLcq.codigos+[' ]+;
	lnErro   = ThisForm.podatamgr.SqlExecute(lcUpDate,'')
		lcWher = [Select * From SigMvCcr Where Emps=']+lcOldEmps+[' And Nopers=']+lcOldNumos+[']
		ThisForm.Podatamgr.SqlExecute(lcWher,'CrMccr')
		Select crMccr
			=Seek(lcOldCodigos,'crSigCdOpt','Operacao')
			lcWher = [Select * From SigMvCcr Where VOpers=']+lcOldVoper+[']
			ThisForm.Podatamgr.SqlExecute(lcWher,'CrvMccr')
			Select CrvMccr
					ThisForm.Podatamgr.SqlExecute([UpDate SigMvCcr Set ValPags = Valors, pagos = ?lcpago, DopoTps = ?lcDtps Where Cidchaves = ']+CrvMccr.CidChaves+['],'')
	=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
	Select TempChq
	Select crSigChLcq
		Select TmpConsolida
			Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
			Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
			Select TmpConsolida
Select crSigChLcq
Seek (lcNumLoteAtual)
=Seek(crSigChLcq.Codigos,'CrSigCdOpt','Operacao')
Select TempChq
	=Seek(crSigChLcq.Emps,'crSigCdEmp','CEmps')
	If Not Empty(CrSigCdOpt.Respons) And Seek(CrSigCdOpt.Respons,'crSigCdGcr','Codigos')
		lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
		=Thisform.PodataMgr.Sqlexecute(lcsql,'CrTmpcli')
		Select CrTmpCli
		Select TempChq
		Select TempChq
Select TempChq
Select TempChq
lcQuery = [Select FPags ] + ;
		    [From SigMvPar ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPar]) < 1)
Select crSigChLcq
Select [ ] as Agrupar, Sum(Valors) As TotValors, Count(1) As TotCheques ;
	From TempChq Where Not Empty(Bancos+Agencias+nContas+nCheques) Into Cursor csTotal group by 1
Select crSigChLcq
Select (lcAlias)
lcQuerylchm  = [Select * From SigChLcq where dtents between ?llDatai And ?llDataf And (Concs=?llCmbf Or Concs=?llCmbt) ]
lcQueryCot   = [Select * From SigCdCot ]
lcQueRyMoe   = [Select * From SigCdMoe ] 
lcQueryMccr  = [Select * From SigMvCcr where Nopers = ?lNoper ]
lcQueryChm   = [Select b.* From SigCqChm b, SigChe a Where b.NumLotes = ?lnLote And b.Numos = a.Numos And b.Nums = a.Nums ]  &&[Select * From SigCqChm where NumLotes = ?lnLote ]
lcQueryOper  = [Select * From SigCdOpt Where Not Inativas = 1]
lcQueryGccr  = [Select * From SigCdGcr ]
lcQueryCli   = [Select * From SigCdCli Where Iclis = ?lcCliente ]
lcQueryUsu   = [Select * From SigCdUsu Where Not cAtivos='N']
lcQueryCarg  = [Select * From SigCdCrg  ]
lcQueryFpag  = [Select * From SigOpFp ]
lcQueryEmp   = [Select * From SigCdEmp ]
lcQueryParam = [Select gesind, moedetqs, grupoests, contaests, transfres, empmasters, SaldConcs, ]+;
			   [From SigCdPam ]
lcQueryferia = [Select * From SigCdFer ]
lcQueryChe   = [Select * From SigChe Where Nums = ?LnNum ]
lcQueryPrbx  = [Select * From SigCdPbx Where CidChaves = ?Cidchav ]
lcQueryPar   = [Select * From SigMvPar  Where CidChaves = ?Cidchav ]
lcQueryClih  = [Select * From SigCdClh Where CidChaves = ?Cidchav ]
lcQueryLanc  = [Select * From SigClLan Where CidChaves = ?Cidchav ]
lcQuerycar   = [Select * From SigCdCar  Where CidChaves = ?Cidchav ]
lcQuerycart  = [Select * From SigCdCtt Where CidChaves = ?Cidchav ]
lcQuerycard  = [Select * From SigCdCrd Where CidChaves = ?Cidchav ]
lcQueryAlin  = [Select * From SigCdAli ]
lcQueryCheh  = [Select * From SigCheh Where CidChaves = ?Cidchav ]
Select CrSigCdCot
Select CrSigCdMoe
Select CrSigCdUsu
Select CrSigCdCrg
Select CrSigCdGcr
Select CrSigOpFp
Select crSigCdOpt
Select CrSigCdEmp
Select CrSigCdFer
Select CrSigCdAli
lcSql = [Select TitOpcS, TitOpcN, TitOpcA From SigCdPac]
If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac') < 1
Select LocalParac
	.Banco.ControlSource      = 'TempChq.Bancos'
	.Agencia.ControlSource    = 'TempChq.Agencias'
	.Conta.ControlSource      = 'TempChq.NContas'
	.Cheque.ControlSource     = 'TempChq.NCheques'
	.Vencimento.ControlSource = 'TempChq.Vencs'
	.Valor.ControlSource      = 'TempChq.Valors'
	.Alinea.ControlSource     = 'TempChq.NAlineas'
	.Empresa.ControlSource    = 'TempChq.Emps'
	.Protocolo.ControlSource  = 'TempChq.Protocolos'
	.DtEmiss.ControlSource    = 'TempChq.Datas'
	.Marca.ControlSource	  = 'TempChq.Marca'
		.CodIclis.ControlSource     = 'TempChq.Cpfs'
		.CodIclis.ControlSource     = 'TempChq.IClis'
	.Get_Valor.ControlSource    = 'TempChq.Valors'
	.fweditdata_Venc.ControlSource = 'TempChq.Vencs'
	.Get_Alinea.ControlSource   = 'TempChq.NAlineas'
	.Data_Emiss.ControlSource   = 'TempChq.Datas'
	.Get_Emps.ControlSource  = 'TempChq.Emps'
	.Get_dEmps.ControlSource = 'TempChq.dEmps'
	.Get_Conta.ControlSource = 'TempChq.Iclis'
	.Get_Cpf.ControlSource   = 'TempChq.Cpfs'
	.Get_Nome.ControlSource  = 'TempChq.Nomes'
	.Get_GruRes.ControlSource  = 'TempChq.GruRes'
	.Get_ConRes.ControlSource  = 'TempChq.ConRes'
	.Get_dConRes.ControlSource = 'TempChq.dConRes'
	.Get_Obs.ControlSource  = 'TempChq.Obs'
	lcWher = [Select * From SigCqChm Where Emps = ']+lcEmpo+[' And Numos = ]+Str(lcVope)
	ThisForm.podatamgr.SqlExecute(lcWher,'CrSigCqChm')
	Select CrSigCqChm
	lcWher = [Select * From SigChLcq Where NumLotes = ]+Str(lnLote)
	ThisForm.poDatamgr.SqlExecute(lcWher,'crSigChLcq')
	Select crSigChLcq
Select crSigChLcq
Select CrSigChLcq
	=Seek( NumLote, "crSigChLcq", "NumLotes" )
Select crSigChLcq
lcWherChe   = [Select a.* From SigCqChm b, SigChe a Where b.NumLotes = ?lnLote And b.Nums = a.Nums]
Select CrSigCdCli
ThisForm.Podatamgr.SqlExecute(lcWherChe,'CrCheque')
Select CrSigCqChm
Select CrCheque
	=Seek( crSigChLcq.Codigos, "crSigCdOpt", "Operacao" )
	Select CrSigCqChm
		Select CrCheque
				Select crSigCqChm
				Seek (CrCheque.Bancos + CrCheque.Agencias + CrCheque.NContas + CrCheque.NCheques)
		Select crSigCqChm
		=Seek( crSigChLcq.codigos, "crSigCdOpt", "Operacao" )	
			lcWherMccr = [Select * From SigMvCcr Where VOpers = ?lcVoper ]
			lcWherPrit = [Select * From SigCdPit Where Emps = ?lcEmp And Nopers = ?lnOper]
			lnErro1 = ThisForm.Podatamgr.SqlExecute(lcWherMccr,'CrSigMvCcr')
			lnClassErr = ThisForm.Podatamgr.SqlExecute(lcWherPrit,'CrSigCdPit')
			lcCdPit = [SELECT a.* FROM sigcdpit a, SIGMVCCR b WHERE a.Emps = ?lcEmp And b.docus = ?lcOper and a.nopers = b.nopers ]
			lnErro2 = ThisForm.Podatamgr.SqlExecute(lcCdPit,'CrCdPit')
			Select CrSigCdPit
			Select CrSigMvCcr
				lcWherMccr = [Select * From SigMvCcr Where Emps = ?lcEmp And Nopers = ?lnOper]
				lnErro = ThisForm.Podatamgr.SqlExecute(lcWherMccr,'CrSigMvCcr')
				Select CrSigMvCcr
					Case Seek(crSigMvCcr.Emps + Str(crSigMvCcr.Nopers,9), 'crSigCdPit', 'EmpNopers' )
		Select crSigCqChm
		lcWherPar = [Select * From SigMvPar Where Emps = ?lcEmp And NumloteChs = ?Lote]
		lnErro = ThisForm.Podatamgr.Sqlexecute(lcWherPar,'CrSigMvPar')
		Select CrSigMvPar
			If Seek(crSigMvPar.FPags,'crSigOpFp','FPags')
						Select crSigCqChm
			Select crSigMvPar
			lcWherCart = [Select * From SigCdCtt Where Emps = ?lcEmp And NumLoteChs = ?Lote]
			lnErro = ThisForm.Podatamgr.Sqlexecute(lcWherCart,'CrSigCdCtt')
			Select crSigCdCtt
		Select Crcheque
			lcUpdate = [Update SigChe Set ncheques = nCheques where Nums = ']+CrCheque.nums+[']
			If Thisform.Podatamgr.Sqlexecute(lcUpdate,'') < 1
Select crSigChLcq
Select CliNeg
Select TempChq
&& Apaga todos os campos que não tem 'ControlSource'
		=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
=Seek( Padr( Alltrim( Usuar ), 10 ), 'crSigCdUsu', 'Usuarios' )
ThisForm.Pagina.Dados.CntInfos.AlteraCotacao.Visible = ((!Seek(crSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs') Or crSigCdCrg.AltCots = 'S') And ;
Select crSigChLcq
=Seek( crSigChLcq.Codigos, "crSigCdOpt", "Operacao" )
	Select crSigCqChm
		Select CrCheque
			lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select CrTmpCli
			If Seek(m.Emps,'crSigCdEmp','CEmps')
			If Not Empty(m.GruRes) And Seek(m.GruRes,'crSigCdGcr','Codigos')
				lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
			Insert Into TempChq From Memvar
			Select TempChq
			=Seek( CrSigCqChm.codigos, "crSigCdOpt", "Operacao" )				
				lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
				lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
	Select CrSigMvPar
		Select CrSigMvPar
		Insert Into xPar From Memvar			
	=Seek(crSigChLcq.GruCarts, 'crSigCdGcr', 'Codigos')
	lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
	Select CrTmpCli
	Select crSigCqChm
	=Seek(crSigChLcq.Grupos, 'crSigCdGcr', 'Codigos')
	lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
	Select CrTmpCli
			=Seek(crSigChLcq.GruOrigs, 'crSigCdGcr', 'Codigos')
			lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select CrTmpCli
			=Seek(crSigChLcq.grupems, 'crSigCdGcr', 'Codigos')
			lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select CrTmpCli
			=Seek(crSigChLcq.GrupoCCs, 'crSigCdGcr', 'Codigos')
			lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select CrTmpCli
	Select tempchq
	lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
	Select CrTmpCli
	=Seek(TempChq.GrClis,'crSigCdGcr','Codigos')
		Select crSigChLcq
	Select crSigChLcq
		Select crSigChLcq
=Seek( crSigChLcq.Moeds, 'crSigCdMoe', 'Cmoes' )
Select crSigChLcq
	Select TempChq
				!Seek(TempChq.NAlineas,'crSigCdAli','Codigos'))) And ;
					SELECT crCli
					SELECT crSigcdcli
			Select TempChq
		Select TempChq
	Select TempChq
	DELETE FROM tempchq where marca = 0
	=Seek(crSigChLcq.GrClis, 'crSigCdGcr', 'Codigos')
	lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
	=Thisform.PodataMgr.Sqlexecute(lcsql,'CrTmpcli')
	Select CrTmpCli
		Select CrSigCqChm
			lcQuery = [Select * From SigMvCcr Where VOpers = ?lcVoper ]
			lnErro  = ThisForm.podatamgr.SqlExecute(lcQuery,'CrSigMvCcr')
			Select crSigMvCcr
				lcSql = [Select Iclis,Rclis,Cpfs,Concilias,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
					lcUpdate = [Update SigMvCcr Set DataConcs = ?llData, Concs = ?llConc , UsuConcs = ']+lcUsuar+[ ' Where CidChaves = ']+crSigMvCcr.CidChaves+[']
					lnErro = ThisForm.poDataMgr.SqlExecute(lcUpdate,'')
			lcUpDate = [UpDate SigChLcq Set Concs = ?llConc Where NumLotes = ]+Str(Lnlote,8)
			lnErro = ThisForm.Podatamgr.Sqlexecute(lcUpDate,'')
=Seek(crSigChLcq.codigos,'crSigCdOpt','operacao')
	Select tempchq
	lcSql = [Select Iclis,Rclis,Cpfs,Vinculas,grupos From SigCdCli where Iclis = ']+crSigChLcq.contas+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
	Select CrTmpCli
		Select xPar
				If Seek(xPar.Fpags,'crSigOpFp','FPags')
								If !Seek(lcCheque,'TempChq','Cheque')
								Select crChm
			Select xPar
Select TempChq
		Delete
Select crSigChLcq
Select crSigChLcq
	Select crSigChLcq
	lcSql = [Update SigChLcq Set DataTrans = Null Where NumLotes = ]+Str(crSigChLcq.NumLotes,6)
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'') < 1
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão - Update SigChLcq ')
		lcSql = [Update SigCqChm Set DataTrans = Null Where NumLotes = ]+Str(crSigChLcq.NumLotes,6)
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'') < 1
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão - Update SigChLcq ')
	lcQuery = [Select Iclis, Cpfs, Rclis, Grupos, Situas, vultcomps, ultcomps From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrtmpCli')
	Select CrtmpCli
	lcQuery = [Select Iclis, Cpfs, Rclis, Grupos, Situas, vultcomps, ultcomps From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrtmpCli')
	Select CrtmpCli
Select [ ] as AGrupar,Sum(Valors) As TotValors, Count(1) As TotCheques ;
	From TempChq ;
	Append From (lcArq) TYPE XL5
	Select ChqExcel
	Delete For Valor = 0
lcWhere = [Select * From SigChe Where Umovs = ?lcProcura ]+;
lnErro = ThisForm.podatamgr.SqlExecute(lcWhere,'CrCheque')
Select CrCheque
		lcWhere = [Select * From SigCqChm Where Nums = ?lcNum Order By Nums, DtSis Desc ]
		lnErro = Thisform.podatamgr.SqlExecute(lcWhere,'CrChm')
		Select crChm
			lcWhere = [Select * From SigCqChm Where Nums = ']+lcNum+[' And NumLotes = ]+Str(lnLote)+[ Order By Nums, DtSis Desc ]
			lnErro = Thisform.podatamgr.SqlExecute(lcWhere,'CrChm')
			Select crChm
				If Not Seek(lcBusca,'ChqExcel','Cheque')
						Insert Into ExcelErr (Bancos, Agencias, Cheques, Contas, Vencs, Valor, Erro, Umovs );
		lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
		=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
		Select CrTmpCli
		Insert Into TempChq ( Bancos, Agencias, NContas, NCheques, Vencs, Valors, ;
Select TempChq
		Select * From ChqExcel Where Flag = 0 Into Cursor CsSelecao
		Select CsSelecao
			Insert Into ExcelErr (Bancos, Agencias, Cheques, Contas, Vencs, Valor, Erro, Umovs );
		Select ExcelErr
			Insert Into   DbCabecalho (_titrel1, _titrel2) Values ('Relação de Cheques Inconsistentes',;
			Select ExcelErr
Select crSigChLcq
Select crSigCdOpt
If !Seek( This.Value )
	Select crSigCdOpt
		Select CrSigCdOpt
		Seek (crSigChLcq.Codigos)
		Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcom
		Select CrCfCom
		Select TempChq
		=Seek( crSigChLcq.Codigos,"CrSigCdOpt", "Operacao" )
	=Seek(crSigCdOpt.GruEmis, 'crSigCdGcr', 'Codigos')
	Select TempChq
		Select crSigCdPam
		=Seek( crSigCdPam.grucarts, "crSigCdGcr", "Codigos" )
		lcSql = [Select Iclis,Rclis,Cpfs, grupos From SigCdCli where Iclis = ']+lcCliente+[']
		=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
		Select CrTmpCli
				Insert Into TempChq ( Emps, dEmps, GruRes, Datas ) Values ;
					( _Empr, iif(Seek(_Empr,'crSigCdEmp','Cemps'), crSigCdEmp.Razas,''), ;
				If Not Empty(crSigCdOpt.Respons) And Seek(crSigCdOpt.Respons,'crSigCdGcr','Codigos')
					Select TempChq
		Select crSigChLcq
				.Get_dGrupo.Value = iif(!Empty(.Get_Grupo.Value) And Seek(.Get_Grupo.Value,'crSigCdGcr','Codigos'),Evaluate('crSigCdGcr.Descrs'),'')
				lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
				.Get_dGruOrig.Value = iif(!Empty(.Get_GruOrig.Value) And Seek(.Get_GruOrig.Value,'crSigCdGcr','Codigos'),Evaluate('crSigCdGcr.Descrs'),'')
				lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
				.Get_dGruEmts.Value = iif(!Empty(.Get_GruEmts.Value) And Seek(.Get_GruEmts.Value,'crSigCdGcr','Codigos'),Evaluate('crSigCdGcr.Descrs'),'')
				lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
				.Get_dGrupoCcs.Value = iif(!Empty(.Get_GrupoCcs.Value) And Seek(.Get_GrupoCcs.Value,'crSigCdGcr','Codigos'),Evaluate('crSigCdGcr.Descrs'),'')
				lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
				Select CrTmpCli
	Select crSigChLcq
Select crSigCdMoe
If !Seek( This.Value )
=Seek( Padr( Alltrim( Usuar ), 10 ), 'crSigCdUsu', 'Usuarios' )
llCota = ( ( !Seek( crSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) Or crSigCdCrg.AltCots = 'S' ) And Inlist( ThisForm.pcEscolha, 'INSERIR', 'ALTERAR' ) And crSigCdMoe.Cotas )
		Select crSigCdCot
=Seek( Padr( Alltrim( Usuar ), 10 ), 'crSigCdUsu', 'Usuarios' )
=Seek( crSigChLcq.Moeds, 'crSigCdMoe', 'CMoes' )
Return (Seek(crSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs') And crSigCdCrg.AltCots='S' And Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')) && And crSigCdMoe.Cotas )
	lcQuery = [Select Iclis, Cpfs, Rclis, Grupos, Situas, vultcomps, ultcomps From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrtmpCli')
	Select CrtmpCli
	lcQuery = [Select Iclis, Cpfs, Rclis, Grupos From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrtmpCli
			lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select CrTmpCli
				Select TempChq
			lcSql = [Select Iclis,Rclis,Cpfs, grupos From SigCdCli where Iclis = ']+lcCliente+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
			Select CrTmpCli
	lcQuery = [Select Iclis, Cpfs, Rclis, Grupos, Situas, vultcomps, ultcomps From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrtmpCli')
	Select CrtmpCli
Select TempChq
			Select TempChq
Select TempChq
If !Empty(This.Value) And !Seek(This.Value,'crSigCdAli','Codigos')
		Select TempChq
Select TempChq
	lcquery = [Select bancos,agencias,contas,ncheques,emps,cpfs,id,dopes,ncheqfin,vencs,valors,datas,cidchaves From SigCqLcq Where Bancos = ']+lcBanco+[' And Agencias = ']+lcAgencia+[' ]+;
	=ThisForm.Podatamgr.SqlExecute(lcQuery,'CrSigCqLcq')
	Select CrSigCqLcq
		lcquery = [Select bancos,agencias,contas,ncheques,emps,cpfs,id,dopes,ncheqfin,vencs,valors,datas,cidchaves From SigCqLcq Where Bancos = ']+lcBanco+[' And Agencias = ']+lcAgencia+[' ]+;
		=ThisForm.Podatamgr.SqlExecute(lcQuery,'CrSigCqLcq')
		Select TempChq
			Select TempChq
			Select crSigChLcq
		Select TempChq
			Select TempChq
				Select TempChq
				Select TempChq
	=Seek(crSigChLcq.Codigos,'crSigCdOpt','Operacao')
		lcquery = [Select * From SigChe Where Bancos = ']+lcBanco+[' And Agencias = ']+lcAgencia+[' ]+;
		=ThisForm.Podatamgr.SqlExecute(lcQuery,'CrCheque')
		Select TempChq
		Select CrCheque
				Select TempChq
				Select TempChq
Select TempChq
			Select crCheque
			Select TempChq
			Select crCheque
			Select TempChq
Select TempChq
		Select TempChq
Select tempchq
	Select tempchq
Select tempchq
Select tempchq
					.Get_dGrupo.Value = Iif(!Empty(.get_grupo.Value) And Seek(.get_grupo.Value,'crSigCdGcr','Codigos'),Evaluate('crSigCdGcr.Descrs'),'')
					lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
					=Thisform.Podatamgr.Sqlexecute(lcSql,'CrTmpcli')
					Select CrTmpCli
			Delete From tempchq Where iclis <> crSigChLcq.Contas
	Select tempchq
Select tempchq
		lcSql = [Select Iclis,Rclis,Cpfs,grupos,situas,VultComps,UltComps From SigCdCli where Iclis = ']+lcCliente+[']
		=Thisform.PodataMgr.Sqlexecute(lcsql,'CrTmpcli')
		Select CrTmpCli
			Select TempChq
			Select crSigChLcq
		lcWher = [Select * From SigCdCst Where Codigos=']+CrtmpCli.situas+[']
		ThisForm.Podatamgr.SqlExecute(lcWher,'CrSigCdCst')
		Select TempChq
	lcQuery = [Select Iclis, Cpfs, Rclis, Grupos, Situas, vultcomps, ultcomps From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrtmpCli')
		Select CrtmpCli
		Select TempChq
		Select CrtmpCli
			Select TempChq
				Select crSigChLcq
			lcWher = [Select * From SigCdCst Where Codigos=']+CrtmpCli.situas+[']
			ThisForm.Podatamgr.SqlExecute(lcWher,'CrSigCdCst')
			Select TempChq
		lcSql = [Select Iclis,Rclis,Cpfs,grupos,situas,VultComps,UltComps From SigCdCli where Iclis = ']+lcCliente+[']
		=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpcli')
		Select CrTmpCli
		Select TempChq
			Select crSigChLcq
		lcWher = [Select * From SigCdCst Where Codigos=']+CrtmpCli.situas+[']
		ThisForm.Podatamgr.SqlExecute(lcWher,'CrSigCdCst')
Select TempChq
	Delete
		Select TempChq
	Select TempChq 
	Select TempChq 
	Select TempChq 
	Select TempChq 
	Select TempChq 
	Select TempChq 
	Select TempChq 
	Select TempChq 
	Select TempChq 
	Select TempChq 
					.Get_dGrupo.Value = Iif(!Empty(.get_grupo.Value) And Seek(.get_grupo.Value,'crSigCdGcr','Codigos'),Evaluate('crSigCdGcr.Descrs'),'')
					lcSql = [Select Iclis,Rclis,Cpfs,grupos From SigCdCli where Iclis = ']+lcCliente+[']
					=Thisform.Podatamgr.Sqlexecute(lcSql,'CrTmpcli')
					Select CrTmpCli
			Delete From tempchq Where iclis <> crSigChLcq.Contas
Select tempchq

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formlch.prg) - TRECHOS RELEVANTES PARA PASS SQL (4951 linhas total):

*-- Linhas 475 a 493:
475:             .HighlightBackColor = RGB(255, 255, 255)
476:             .HighlightForeColor = RGB(15, 41, 104)
477:             .HighlightStyle = 2
478:             .DeleteMark = .F.
479:             .RecordMark = .F.
480:             .RowHeight = 16
481:             .ScrollBars = 2
482:             .GridLines = 3
483:             .Visible = .T.
484:         ENDWITH
485:         WITH loc_oGrid.Column1
486:             .Width = 60
487:             .Header1.Caption = "Lote"
488:         ENDWITH
489:         WITH loc_oGrid.Column2
490:             .Width = 80
491:             .Header1.Caption = "Empresa"
492:         ENDWITH
493:         WITH loc_oGrid.Column3

*-- Linhas 1877 a 1895:
1877:             .HighlightBackColor = RGB(255, 255, 255)
1878:             .HighlightForeColor = RGB(15, 41, 104)
1879:             .HighlightStyle = 2
1880:             .DeleteMark = .F.
1881:             .RecordMark = .F.
1882:             .RowHeight = 16
1883:             .ScrollBars = 3
1884:             .GridLines = 3
1885:             .Visible = .T.
1886:         ENDWITH
1887:         WITH loc_oGrid.Column1
1888:             .Width = 30
1889:             .Header1.Caption = "Bco"
1890:         ENDWITH
1891:         WITH loc_oGrid.Column2
1892:             .Width = 38
1893:             .Header1.Caption = "Ag" + CHR(234) + "ncia"
1894:         ENDWITH
1895:         WITH loc_oGrid.Column3

*-- Linhas 2813 a 2831:
2813:                 IF USED("cursor_4c_Dados")
2814:                     USE IN cursor_4c_Dados
2815:                 ENDIF
2816:                 CREATE CURSOR cursor_4c_Dados ;
2817:                     (numlotes N(10,0), emps C(3), dtents D, codigos C(15), ;
2818:                      valtots N(15,2), concs N(1,0))
2819:                 SET DATASESSION TO (loc_nDsAtual)
2820:                 loc_lResultado = .T.
2821:             ELSE
2822:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2823: 
2824:                 *-- Montar filtro a partir dos controles da Page1
2825:                 loc_cFiltro = ""
2826:                 loc_dDtI = {}
2827:                 loc_dDtF = {}
2828:                 loc_nConc = 0
2829: 
2830:                 IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial) = "O"
2831:                     loc_dDtI = loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial.Value

*-- Linhas 2839 a 2880:
2839: 
2840:                 IF !EMPTY(loc_dDtI) AND !EMPTY(loc_dDtF)
2841:                     loc_cFiltro = loc_cFiltro + ;
2842:                         " AND a.dtents >= " + FormatarDataSQL(loc_dDtI) + ;
2843:                         " AND a.dtents <= " + FormatarDataSQL(loc_dDtF)
2844:                 ENDIF
2845: 
2846:                 DO CASE
2847:                 CASE loc_nConc = 2   && Conciliados
2848:                     loc_cFiltro = loc_cFiltro + " AND a.concs = 1"
2849:                 CASE loc_nConc = 3   && Pendentes
2850:                     loc_cFiltro = loc_cFiltro + " AND a.concs = 0"
2851:                 ENDCASE
2852: 
2853:                 IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
2854:                     loc_lResultado = .F.
2855:                 ELSE
2856:                     IF VARTYPE(loc_oPg1.grd_4c_Dados) = "O"
2857:                         loc_oGrid = loc_oPg1.grd_4c_Dados
2858:                         loc_oGrid.ColumnCount = 6
2859:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2860:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numlotes"
2861:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
2862:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dtents"
2863:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.codigos"
2864:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.valtots"
2865:                         loc_oGrid.Column6.ControlSource = ;
2866:                             "IIF(cursor_4c_Dados.concs=1,'Conciliado','Pendente')"
2867:                         loc_oGrid.Column1.Header1.Caption = "Lote"
2868:                         loc_oGrid.Column2.Header1.Caption = "Empresa"
2869:                         loc_oGrid.Column3.Header1.Caption = "Data Entrada"
2870:                         loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2871:                         loc_oGrid.Column5.Header1.Caption = "Valor Total"
2872:                         loc_oGrid.Column6.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
2873:                         THIS.FormatarGridLista(loc_oGrid)
2874:                     ENDIF
2875:                     loc_lResultado = .T.
2876:                 ENDIF
2877:             ENDIF
2878:         CATCH TO loc_oErro
2879:             MsgErro(loc_oErro.Message, "Formlch.CarregarLista")
2880:         ENDTRY

*-- Linhas 2923 a 2991:
2923:                 IF USED("cursor_4c_ChequesM")
2924:                     USE IN cursor_4c_ChequesM
2925:                 ENDIF
2926:                 CREATE CURSOR cursor_4c_ChequesM ;
2927:                     (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
2928:                      valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
2929:                      iclis C(10), protocolos C(20), dtemis D, marca L)
2930:                 loc_lResultado = .T.
2931:             ELSE
2932:                 IF THIS.this_oBusinessObject.BuscarCheques(loc_nLote)
2933:                     IF USED("cursor_4c_ChequesM")
2934:                         USE IN cursor_4c_ChequesM
2935:                     ENDIF
2936: 
2937:                     IF USED("cursor_4c_Cheques") AND RECCOUNT("cursor_4c_Cheques") >= 0
2938:                         SELECT bancos, agencias, ncontas, ncheques, valors, vencs, ;
2939:                             nalineas, emps, iclis, protocolos, dtemis, .F. AS marca ;
2940:                             FROM cursor_4c_Cheques ;
2941:                             INTO CURSOR cursor_4c_ChequesM READWRITE
2942:                     ELSE
2943:                         CREATE CURSOR cursor_4c_ChequesM ;
2944:                             (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
2945:                              valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
2946:                              iclis C(10), protocolos C(20), dtemis D, marca L)
2947:                     ENDIF
2948:                     loc_lResultado = .T.
2949:                 ENDIF
2950:             ENDIF
2951: 
2952:             IF loc_lResultado
2953:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques) = "O"
2954:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques
2955:                     loc_oGrid.ColumnCount = 12
2956:                     loc_oGrid.RecordSource = "cursor_4c_ChequesM"
2957:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_ChequesM.bancos"
2958:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_ChequesM.agencias"
2959:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_ChequesM.ncontas"
2960:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_ChequesM.ncheques"
2961:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_ChequesM.valors"
2962:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_ChequesM.vencs"
2963:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_ChequesM.nalineas"
2964:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_ChequesM.emps"
2965:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_ChequesM.iclis"
2966:                     loc_oGrid.Column10.ControlSource = "cursor_4c_ChequesM.protocolos"
2967:                     loc_oGrid.Column11.ControlSource = "cursor_4c_ChequesM.dtemis"
2968:                     loc_oGrid.Column12.ControlSource = "cursor_4c_ChequesM.marca"
2969:                 ENDIF
2970: 
2971:                 *-- Atualizar totalizadores
2972:                 IF USED("cursor_4c_ChequesM")
2973:                     LOCAL loc_nQtde, loc_nVlrTot
2974:                     loc_nQtde   = RECCOUNT("cursor_4c_ChequesM")
2975:                     loc_nVlrTot = 0
2976:                     SELECT SUM(valors) FROM cursor_4c_ChequesM INTO ARRAY laVlr
2977:                     IF TYPE("laVlr") = "N"
2978:                         loc_nVlrTot = laVlr
2979:                     ENDIF
2980: 
2981:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs) = "O"
2982:                         THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs.Value = loc_nQtde
2983:                     ENDIF
2984:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal) = "O"
2985:                         THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal.Value = loc_nVlrTot
2986:                     ENDIF
2987:                 ENDIF
2988:             ENDIF
2989:         CATCH TO loc_oErro
2990:             MsgErro(loc_oErro.Message, "Formlch.CarregarGrade")
2991:         ENDTRY

*-- Linhas 3024 a 3042:
3024:             RETURN
3025:         ENDIF
3026: 
3027:         SELECT cursor_4c_Dados
3028:         loc_nLote = cursor_4c_Dados.numlotes
3029: 
3030:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3031:             THIS.this_cModoAtual = "VISUALIZAR"
3032:             THIS.BOParaForm()
3033:             THIS.CarregarGrade()
3034:             THIS.HabilitarCampos(.F.)
3035:             THIS.AjustarBotoesPorModo()
3036:             THIS.AlternarPagina(2)
3037:         ENDIF
3038:     ENDPROC
3039: 
3040:     *--------------------------------------------------------------------------
3041:     * BtnAlterarClick
3042:     *--------------------------------------------------------------------------

*-- Linhas 3048 a 3066:
3048:             RETURN
3049:         ENDIF
3050: 
3051:         SELECT cursor_4c_Dados
3052:         loc_nLote = cursor_4c_Dados.numlotes
3053: 
3054:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3055:             THIS.this_oBusinessObject.EditarRegistro()
3056:             THIS.this_cModoAtual = "ALTERAR"
3057:             THIS.BOParaForm()
3058:             THIS.CarregarGrade()
3059:             THIS.HabilitarCampos(.T.)
3060:             THIS.AjustarBotoesPorModo()
3061:             THIS.AlternarPagina(2)
3062:         ENDIF
3063:     ENDPROC
3064: 
3065:     *--------------------------------------------------------------------------
3066:     * BtnExcluirClick

*-- Linhas 3079 a 3097:
3079:             RETURN
3080:         ENDIF
3081: 
3082:         SELECT cursor_4c_Dados
3083:         loc_nLote = cursor_4c_Dados.numlotes
3084: 
3085:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3086:             IF THIS.this_oBusinessObject.Excluir()
3087:                 MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "")
3088:                 THIS.CarregarLista()
3089:             ENDIF
3090:         ENDIF
3091:     ENDPROC
3092: 
3093:     *--------------------------------------------------------------------------
3094:     * BtnBuscarClick
3095:     *--------------------------------------------------------------------------
3096:     PROCEDURE BtnBuscarClick()
3097:         LOCAL loc_oBusca, loc_nLote, loc_lResultado

*-- Linhas 3111 a 3133:
3111:                 loc_oBusca.Show()
3112: 
3113:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLch")
3114:                     SELECT cursor_4c_BuscaLch
3115:                     IF !EOF("cursor_4c_BuscaLch")
3116:                         loc_nLote = cursor_4c_BuscaLch.numlotes
3117:                         THIS.this_oBusinessObject.Buscar("AND a.numlotes = " + ;
3118:                             FormatarNumeroSQL(loc_nLote))
3119:                         THIS.CarregarLista()
3120:                     ENDIF
3121:                 ELSE
3122:                     THIS.CarregarLista()
3123:                 ENDIF
3124: 
3125:                 loc_oBusca.Release()
3126:                 loc_lResultado = .T.
3127:             ENDIF
3128:         CATCH TO loc_oErro
3129:             MsgErro(loc_oErro.Message, "Formlch.BtnBuscarClick")
3130:         ENDTRY
3131: 
3132:         IF USED("cursor_4c_BuscaLch")
3133:             USE IN cursor_4c_BuscaLch

*-- Linhas 3268 a 3322:
3268:         ENDIF
3269: 
3270:         TRY
3271:             SELECT cursor_4c_ChequesM
3272: 
3273:             IF THIS.this_oBusinessObject.this_nNumLotes <= 0
3274:                 MsgAviso("Salve o lote antes de excluir cheques.", "")
3275:                 RETURN
3276:             ENDIF
3277: 
3278:             loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
3279:                 FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
3280:                 " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
3281:                 " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
3282:                 " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
3283:                 " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))
3284: 
3285:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3286: 
3287:             IF loc_nResult < 0
3288:                 MsgErro("Erro ao excluir cheque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3289:             ELSE
3290:                 MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso!", "")
3291:                 THIS.CarregarGrade()
3292:             ENDIF
3293:         CATCH TO loc_oErro
3294:             MsgErro(loc_oErro.Message, "Formlch.BtnExcluirChequeClick")
3295:         ENDTRY
3296:     ENDPROC
3297: 
3298:     *--------------------------------------------------------------------------
3299:     * BtnMarcaClick - marca/desmarca cheque selecionado
3300:     *--------------------------------------------------------------------------
3301:     PROCEDURE BtnMarcaClick()
3302:         IF !USED("cursor_4c_ChequesM") OR EOF("cursor_4c_ChequesM")
3303:             RETURN
3304:         ENDIF
3305: 
3306:         TRY
3307:             SELECT cursor_4c_ChequesM
3308:             REPLACE cursor_4c_ChequesM.marca WITH !cursor_4c_ChequesM.marca
3309:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques.Refresh()
3310:         CATCH TO loc_oErro
3311:             MsgErro(loc_oErro.Message, "Formlch.BtnMarcaClick")
3312:         ENDTRY
3313:     ENDPROC
3314: 
3315:     *--------------------------------------------------------------------------
3316:     * BtnCmdExcChequeClick - exclui cheques marcados do lote
3317:     *--------------------------------------------------------------------------
3318:     PROCEDURE BtnCmdExcChequeClick()
3319:         LOCAL loc_cSQL, loc_nResult, loc_nExcluidos
3320: 
3321:         IF !USED("cursor_4c_ChequesM") OR RECCOUNT("cursor_4c_ChequesM") = 0
3322:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " cheques para excluir.", "")

*-- Linhas 3329 a 3358:
3329: 
3330:         TRY
3331:             loc_nExcluidos = 0
3332:             SELECT cursor_4c_ChequesM
3333:             GO TOP
3334: 
3335:             DO WHILE !EOF("cursor_4c_ChequesM")
3336:                 IF cursor_4c_ChequesM.marca
3337:                     loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
3338:                         FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
3339:                         " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
3340:                         " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
3341:                         " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
3342:                         " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))
3343:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3344:                     IF loc_nResult >= 0
3345:                         loc_nExcluidos = loc_nExcluidos + 1
3346:                     ENDIF
3347:                 ENDIF
3348:                 SKIP IN cursor_4c_ChequesM
3349:             ENDDO
3350: 
3351:             IF loc_nExcluidos > 0
3352:                 MsgInfo(TRANSFORM(loc_nExcluidos) + " cheque(s) exclu" + CHR(237) + "do(s).", "")
3353:                 THIS.CarregarGrade()
3354:             ENDIF
3355:         CATCH TO loc_oErro
3356:             MsgErro(loc_oErro.Message, "Formlch.BtnCmdExcChequeClick")
3357:         ENDTRY
3358:     ENDPROC

*-- Linhas 4012 a 4031:
4012:         ENDIF
4013: 
4014:         TRY
4015:             loc_nRes = SQLEXEC(gnConnHandle, ;
4016:                 "SELECT operacao FROM SigCdOpt WHERE operacao = " + EscaparSQL(loc_cOper), ;
4017:                 "cursor_4c_ValidOper")
4018:             IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidOper") = 0
4019:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cOper, "")
4020:                 loc_oPg2.txt_4c_Oper.Value = ""
4021:             ENDIF
4022:         CATCH TO loc_oErro
4023:             MsgErro(loc_oErro.Message, "Formlch.ValidarOper")
4024:         ENDTRY
4025:         IF USED("cursor_4c_ValidOper")
4026:             USE IN cursor_4c_ValidOper
4027:         ENDIF
4028:     ENDPROC
4029: 
4030:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
4031:         LOCAL loc_oPg2, loc_cMoeda, loc_nRes

*-- Linhas 4039 a 4058:
4039:         ENDIF
4040: 
4041:         TRY
4042:             loc_nRes = SQLEXEC(gnConnHandle, ;
4043:                 "SELECT codigos FROM SigCdMoe WHERE codigos = " + EscaparSQL(loc_cMoeda), ;
4044:                 "cursor_4c_ValidMoe")
4045:             IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidMoe") = 0
4046:                 MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cMoeda, "")
4047:                 loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ""
4048:             ENDIF
4049:         CATCH TO loc_oErro
4050:             MsgErro(loc_oErro.Message, "Formlch.ValidarMoeda")
4051:         ENDTRY
4052:         IF USED("cursor_4c_ValidMoe")
4053:             USE IN cursor_4c_ValidMoe
4054:         ENDIF
4055:     ENDPROC
4056: 
4057:     PROCEDURE ValidarGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
4058:         THIS.BuscarDescGrupo("cnt_4c_Origem", "txt_4c_GruOrig", "txt_4c_DGruOrig")

*-- Linhas 4122 a 4144:
4122:         ENDIF
4123: 
4124:         TRY
4125:             loc_nRes = SQLEXEC(gnConnHandle, ;
4126:                 "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps), ;
4127:                 "cursor_4c_ValidEmp")
4128:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidEmp") > 0
4129:                 SELECT cursor_4c_ValidEmp
4130:                 IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4131:                     loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_ValidEmp.razas)
4132:                 ENDIF
4133:                 THIS.this_oBusinessObject.this_cDEmps = ALLTRIM(cursor_4c_ValidEmp.razas)
4134:             ELSE
4135:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, "")
4136:                 loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ""
4137:                 IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4138:                     loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ""
4139:                 ENDIF
4140:             ENDIF
4141:         CATCH TO loc_oErro
4142:             MsgErro(loc_oErro.Message, "Formlch.ValidarEmpresa")
4143:         ENDTRY
4144:         IF USED("cursor_4c_ValidEmp")

*-- Linhas 4158 a 4180:
4158:         ENDIF
4159: 
4160:         TRY
4161:             loc_nRes = SQLEXEC(gnConnHandle, ;
4162:                 "SELECT iclis, cpfs, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
4163:                 "cursor_4c_ValidCli")
4164:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidCli") > 0
4165:                 SELECT cursor_4c_ValidCli
4166:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4167:                     loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ALLTRIM(cursor_4c_ValidCli.cpfs)
4168:                 ENDIF
4169:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4170:                     loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ALLTRIM(cursor_4c_ValidCli.razaos)
4171:                 ENDIF
4172:             ELSE
4173:                 MsgAviso("Cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
4174:                 loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ""
4175:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4176:                     loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ""
4177:                 ENDIF
4178:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4179:                     loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ""
4180:                 ENDIF

*-- Linhas 4223 a 4246:
4223:         ENDIF
4224: 
4225:         TRY
4226:             loc_nRes = SQLEXEC(gnConnHandle, ;
4227:                 "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
4228:                 "cursor_4c_DescGru")
4229:             loc_cDesc = ""
4230:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGru") > 0
4231:                 SELECT cursor_4c_DescGru
4232:                 loc_cDesc = ALLTRIM(cursor_4c_DescGru.descrs)
4233:             ELSE
4234:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo, "")
4235:                 EVALUATE("loc_oCnt." + par_cTxtGru + ".Value = ''")
4236:             ENDIF
4237:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4238:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
4239:             ENDIF
4240:         CATCH TO loc_oErro
4241:             MsgErro(loc_oErro.Message, "Formlch.BuscarDescGrupo")
4242:         ENDTRY
4243:         IF USED("cursor_4c_DescGru")
4244:             USE IN cursor_4c_DescGru
4245:         ENDIF
4246:     ENDPROC

*-- Linhas 4274 a 4297:
4274:         ENDIF
4275: 
4276:         TRY
4277:             loc_nRes = SQLEXEC(gnConnHandle, ;
4278:                 "SELECT iclis, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
4279:                 "cursor_4c_DescCon")
4280:             loc_cDesc = ""
4281:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCon") > 0
4282:                 SELECT cursor_4c_DescCon
4283:                 loc_cDesc = ALLTRIM(cursor_4c_DescCon.razaos)
4284:             ELSE
4285:                 MsgAviso("Conta/cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
4286:                 EVALUATE("loc_oCnt." + par_cTxtCon + ".Value = ''")
4287:             ENDIF
4288:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4289:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
4290:             ENDIF
4291:         CATCH TO loc_oErro
4292:             MsgErro(loc_oErro.Message, "Formlch.BuscarDescConta")
4293:         ENDTRY
4294:         IF USED("cursor_4c_DescCon")
4295:             USE IN cursor_4c_DescCon
4296:         ENDIF
4297:     ENDPROC

*-- Linhas 4567 a 4585:
4567:                 loc_oBusca.Show()
4568: 
4569:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOper")
4570:                     SELECT cursor_4c_BuscaOper
4571:                     IF !EOF("cursor_4c_BuscaOper") AND VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
4572:                         loc_oPg2.txt_4c_Oper.Value = ALLTRIM(cursor_4c_BuscaOper.operacao)
4573:                     ENDIF
4574:                 ENDIF
4575: 
4576:                 loc_oBusca.Release()
4577:                 loc_lResultado = .T.
4578:             ENDIF
4579:         CATCH TO loc_oErro
4580:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupOper")
4581:         ENDTRY
4582: 
4583:         IF USED("cursor_4c_BuscaOper")
4584:             USE IN cursor_4c_BuscaOper
4585:         ENDIF

*-- Linhas 4605 a 4623:
4605:                 loc_oBusca.Show()
4606: 
4607:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
4608:                     SELECT cursor_4c_BuscaMoe
4609:                     IF !EOF("cursor_4c_BuscaMoe") AND ;
4610:                        VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
4611:                         loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ;
4612:                             ALLTRIM(cursor_4c_BuscaMoe.codigos)
4613:                     ENDIF
4614:                 ENDIF
4615: 
4616:                 loc_oBusca.Release()
4617:                 loc_lResultado = .T.
4618:             ENDIF
4619:         CATCH TO loc_oErro
4620:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupMoeda")
4621:         ENDTRY
4622: 
4623:         IF USED("cursor_4c_BuscaMoe")

*-- Linhas 4647 a 4665:
4647:                     loc_oBusca.Show()
4648: 
4649:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
4650:                         SELECT cursor_4c_BuscaGru
4651:                         IF !EOF("cursor_4c_BuscaGru")
4652:                             loc_oTxtGru = EVALUATE("loc_oCnt." + par_cTxtGru)
4653:                             IF VARTYPE(loc_oTxtGru) = "O"
4654:                                 loc_oTxtGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
4655:                             ENDIF
4656:                             IF !EMPTY(par_cTxtDesc)
4657:                                 loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
4658:                                 IF VARTYPE(loc_oTxtDesc) = "O"
4659:                                     loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
4660:                                 ENDIF
4661:                             ENDIF
4662:                         ENDIF
4663:                     ENDIF
4664: 
4665:                     loc_oBusca.Release()

*-- Linhas 4697 a 4715:
4697:                     loc_oBusca.Show()
4698: 
4699:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCon")
4700:                         SELECT cursor_4c_BuscaCon
4701:                         IF !EOF("cursor_4c_BuscaCon")
4702:                             loc_oTxtCon = EVALUATE("loc_oCnt." + par_cTxtCon)
4703:                             IF VARTYPE(loc_oTxtCon) = "O"
4704:                                 loc_oTxtCon.Value = ALLTRIM(cursor_4c_BuscaCon.iclis)
4705:                             ENDIF
4706:                             IF !EMPTY(par_cTxtDesc)
4707:                                 loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
4708:                                 IF VARTYPE(loc_oTxtDesc) = "O"
4709:                                     loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaCon.razaos)
4710:                                 ENDIF
4711:                             ENDIF
4712:                         ENDIF
4713:                     ENDIF
4714: 
4715:                     loc_oBusca.Release()

*-- Linhas 4748 a 4766:
4748:                     loc_oBusca.Show()
4749: 
4750:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
4751:                         SELECT cursor_4c_BuscaCpf
4752:                         IF !EOF("cursor_4c_BuscaCpf")
4753:                             loc_oTxtCpf = EVALUATE("loc_oCnt." + par_cTxtCpf)
4754:                             IF VARTYPE(loc_oTxtCpf) = "O"
4755:                                 loc_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
4756:                             ENDIF
4757:                         ENDIF
4758:                     ENDIF
4759: 
4760:                     loc_oBusca.Release()
4761:                     loc_lResultado = .T.
4762:                 ENDIF
4763:             ENDIF
4764:         CATCH TO loc_oErro
4765:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupCpf")
4766:         ENDTRY

*-- Linhas 4790 a 4808:
4790:                 loc_oBusca.Show()
4791: 
4792:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
4793:                     SELECT cursor_4c_BuscaEmp
4794:                     IF !EOF("cursor_4c_BuscaEmp")
4795:                         IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"
4796:                             loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ;
4797:                                 ALLTRIM(cursor_4c_BuscaEmp.cemps)
4798:                         ENDIF
4799:                         IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4800:                             loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ;
4801:                                 ALLTRIM(cursor_4c_BuscaEmp.razas)
4802:                         ENDIF
4803:                         THIS.this_oBusinessObject.this_cDEmps = ;
4804:                             ALLTRIM(cursor_4c_BuscaEmp.razas)
4805:                     ENDIF
4806:                 ENDIF
4807: 
4808:                 loc_oBusca.Release()

*-- Linhas 4838 a 4856:
4838:                 loc_oBusca.Show()
4839: 
4840:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIclis")
4841:                     SELECT cursor_4c_BuscaIclis
4842:                     IF !EOF("cursor_4c_BuscaIclis")
4843:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"
4844:                             loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ;
4845:                                 ALLTRIM(cursor_4c_BuscaIclis.iclis)
4846:                         ENDIF
4847:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4848:                             loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ;
4849:                                 ALLTRIM(cursor_4c_BuscaIclis.cpfs)
4850:                         ENDIF
4851:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4852:                             loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ;
4853:                                 ALLTRIM(cursor_4c_BuscaIclis.razaos)
4854:                         ENDIF
4855:                     ENDIF
4856:                 ENDIF

*-- Linhas 4886 a 4904:
4886:                 loc_oBusca.Show()
4887: 
4888:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGre")
4889:                     SELECT cursor_4c_BuscaGre
4890:                     IF !EOF("cursor_4c_BuscaGre") AND ;
4891:                        VARTYPE(loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp) = "O"
4892:                         SCATTER MEMVAR MEMO
4893:                         loc_cClasse = ALLTRIM(m.class)
4894:                         loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp.Value = loc_cClasse
4895:                     ENDIF
4896:                 ENDIF
4897: 
4898:                 loc_oBusca.Release()
4899:                 loc_lResultado = .T.
4900:             ENDIF
4901:         CATCH TO loc_oErro
4902:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupClasemp")
4903:         ENDTRY
4904: 

*-- Linhas 4927 a 4945:
4927:                 loc_oBusca.Show()
4928: 
4929:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAli")
4930:                     SELECT cursor_4c_BuscaAli
4931:                     IF !EOF("cursor_4c_BuscaAli") AND ;
4932:                        VARTYPE(loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe) = "O"
4933:                         loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe.Value = ;
4934:                             ALLTRIM(cursor_4c_BuscaAli.codigos)
4935:                     ENDIF
4936:                 ENDIF
4937: 
4938:                 loc_oBusca.Release()
4939:                 loc_lResultado = .T.
4940:             ENDIF
4941:         CATCH TO loc_oErro
4942:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupAlinea")
4943:         ENDTRY
4944: 
4945:         IF USED("cursor_4c_BuscaAli")


### BO (C:\4c\projeto\app\classes\lchBO.prg):
*==============================================================================
* lchBO.prg - Business Object para Lote de Cheques
* Herda de BusinessBase
* Tabela Principal : SigChLcq
* Chave Primaria   : NumLotes (numeric)
* Cursor de Dados  : cursor_4c_Dados
* Form relacionado : Formlch.prg
*==============================================================================

DEFINE CLASS lchBO AS BusinessBase

    *==========================================================================
    * PROPRIEDADES - TABELA SigChLcq (campos diretos)
    *==========================================================================

    *-- Identificacao do Lote
    this_nNumLotes    = 0      && PK - Numero do Lote
    this_nNumLoteFPs  = 0      && Numero do Lote de Parcelas vinculado

    *-- Operacao e configuracao
    this_cCodigos     = ""     && Codigo da Operacao (SigCdOpt.Operacao)
    this_cEmps        = ""     && Empresa C(3)
    this_cUsuar       = ""     && Usuario que criou/alterou

    *-- Moeda e valores financeiros
    this_cMoeds       = ""     && Codigo da Moeda
    this_nCotas       = 0      && Cotacao da Moeda
    this_cCotUsus     = ""     && Cotacao definida pelo Usuario (char(10) em SigChLcq)
    this_nValTots     = 0      && Valor Total em Moeda Original
    this_nValConvs    = 0      && Valor Total Convertido (ValTots / Cotas)

    *-- Datas
    this_dDtEnts      = {}     && Data de Entrada do Lote
    this_dDataTrans   = {}     && Data de Transporte (nullable em SigChLcq)

    *-- Grupo e Conta Destino (campos da tabela SigChLcq)
    this_cGrupos      = ""     && Grupo de Destino
    this_cContas      = ""     && Conta de Destino

    *-- Cliente Emissor (vinculo com SigCdCli)
    this_cIclis       = ""     && Codigo do Cliente Emissor
    this_cGrclis      = ""     && Grupo do Cliente Emissor

    *-- Quantidade e identificadores auxiliares
    this_nQtdeCheqs   = 0      && Quantidade de Cheques no Lote
    this_nOrdens      = 0      && Tipo de Ordens (de SigCdOpt.Ordens)

    *-- Observacoes e follow up
    this_cObss        = ""     && Observacoes gerais do Lote
    this_cFollowUp    = ""     && Texto do Follow Up
    this_lFollowUp    = .F.    && Flag Repetir Follow Up

    *==========================================================================
    * PROPRIEDADES - DESTINO (com descricoes para a UI)
    * Campos do container CntDestino (Page2)
    *==========================================================================

    this_cGruDest     = ""     && Grupo Destino (Get_Grupo em CntDestino)
    this_cConDest     = ""     && Conta Destino (Get_Conta em CntDestino)
    this_cDGruDest    = ""     && Descricao do Grupo Destino
    this_cDConDest    = ""     && Descricao da Conta Destino
    this_cCpfDest     = ""     && CPF quando destino e pessoa fisica

    *==========================================================================
    * PROPRIEDADES - ORIGEM
    * Campos do container CntOrigem (Page2)
    *==========================================================================

    this_cGruOrig     = ""     && Grupo de Origem (Get_GruOrig)
    this_cConOrig     = ""     && Conta de Origem (Get_ConOrig)
    this_cDGruOrig    = ""     && Descricao do Grupo de Origem
    this_cDConOrig    = ""     && Descricao da Conta de Origem
    this_cCpfOrig     = ""     && CPF da Origem

    *==========================================================================
    * PROPRIEDADES - CARTEIRA
    * Campos do container CntCarteira (Page2)
    *==========================================================================

    this_cGruCart     = ""     && Grupo de Carteira (Get_GruCart)
    this_cConCart     = ""     && Conta de Carteira (Get_ConCart)
    this_cDGruCart    = ""     && Descricao do Grupo de Carteira
    this_cDConCart    = ""     && Descricao da Conta de Carteira

    *==========================================================================
    * PROPRIEDADES - EMISSOR
    * Campos do container CntEmissor (Page2)
    *==========================================================================

    this_cGruEmiss    = ""     && Grupo do Emissor (Get_GruEmiss)
    this_cConEmiss    = ""     && Conta do Emissor (Get_ConEmiss)
    this_cDGruEmiss   = ""     && Descricao do Grupo do Emissor
    this_cDConEmiss   = ""     && Descricao da Conta do Emissor
    this_cCpfEmiss    = ""     && CPF do Emissor (Get_Cpf em CntEmissor)
    this_cNomeEmiss   = ""     && Nome do Emissor (Rclis de SigCdCli)

    *==========================================================================
    * PROPRIEDADES - DESPESA
    * Campos do container cntDespesa (Page2)
    *==========================================================================

    this_cGruEmts     = ""     && Grupo de Despesa (Get_GruEmts)
    this_cConEmts     = ""     && Conta de Despesa (Get_ConEmts)
    this_cDGruEmts    = ""     && Descricao do Grupo de Despesa
    this_cDConEmts    = ""     && Descricao da Conta de Despesa
    this_cCpfEmts     = ""     && CPF da Despesa

    *==========================================================================
    * PROPRIEDADES - CENTRO DE CUSTO
    * Campos do container CntCCusto (Page2)
    *==========================================================================

    this_cGruCCs      = ""     && Grupo de Centro de Custo (Get_GrupoCcs)
    this_cConCCs      = ""     && Conta de Centro de Custo (Get_ContaCcs)
    this_cDGruCCs     = ""     && Descricao do Grupo CC
    this_cDConCCs     = ""     && Descricao da Conta CC
    this_cCpfCCs      = ""     && CPF do Centro de Custo

    *==========================================================================
    * PROPRIEDADES - RESPONSAVEL
    * Campos do container CntResponsavel (Page2)
    *==========================================================================

    this_cGruRes      = ""     && Grupo do Responsavel (Get_GruRes)
    this_cConRes      = ""     && Conta do Responsavel (Get_ConRes)
    this_cDConRes     = ""     && Descricao da Conta do Responsavel

    *==========================================================================
    * PROPRIEDADES - EMPRESA (descricao para exibicao)
    *==========================================================================

    this_cDEmps       = ""     && Razao Social / Descricao da Empresa

    *==========================================================================
    * PROPRIEDADES - CONTA DO CLIENTE/EMISSOR (CntConta)
    * Container na parte inferior da Page2 para identificacao do emissor
    *==========================================================================

    this_cContaIclis  = ""     && Conta/Iclis do Emissor (Get_Conta em CntConta)
    this_cCpfIclis    = ""     && CPF do Emissor (Get_CPF em CntConta)
    this_cNomeIclis   = ""     && Nome do Emissor (Get_Nome em CntConta)

    *==========================================================================
    * PROPRIEDADES - PROCESSAMENTO EM LOTE
    * Campos do container CntProcessa (Page2) - processamento automatico
    *==========================================================================

    this_dDtIniProc   = {}     && Data Inicial do Processamento
    this_dDtFimProc   = {}     && Data Final do Processamento
    this_nLoteProc    = 0      && Numero do Lote para Processamento
    this_cEmpProc     = ""     && Empresa para Processamento em Lote
    this_cPlanilha    = ""     && Caminho completo da Planilha Excel (.XLS)

    *==========================================================================
    * PROPRIEDADES - FILTROS DE LISTAGEM (Page1)
    * Campos do cntFiltros na Page1 (lista de lotes)
    *==========================================================================

    this_dDataFiltroI = {}     && Data Inicial do Filtro (Dt_inicial)
    this_dDataFiltroF = {}     && Data Final do Filtro (Dt_final)
    this_nFiltroConc  = 0      && Filtro Conciliacao: 0=Todos, 1=Conciliados, 2=Pendentes, 3=Ambos
    this_cFiltClasemp = ""     && Filtro por Classe Empresarial (Get_Clasemp)

    *==========================================================================
    * PROPRIEDADES - CURSOR DE DADOS
    *==========================================================================

    this_cCursorDados = "cursor_4c_Dados"   && Cursor principal para listagem de lotes

    *==========================================================================
    * INIT - Configuracao da tabela principal
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChLcq"
            THIS.this_cCampoChave = "NumLotes"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar lchBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNumLotes, 10))
    ENDFUNC

    *==========================================================================
    * Buscar - Lista lotes de cheques com filtros opcionais
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.dtents >= '2024-01-01'")
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.codigos, a.emps, a.dtents, a.datas," + ;
                " a.datatrans, a.moeds, a.cotas, a.valtots, a.valconvs," + ;
                " a.grupos, a.contas, a.gruorigs, a.conorigs," + ;
                " a.grucarts, a.concarts, a.iclis, a.grclis, a.usuarios," + ;
                " a.concs, a.numloteFps, a.cotusus," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.obs" + ;
                " FROM SigChLcq a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.dtents DESC, a.numlotes DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega lote pelo numlotes (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.numloteFps, a.codigos, a.emps, a.usuarios," + ;
                " a.moeds, a.cotas, a.cotusus, a.valtots, a.valconvs," + ;
                " a.dtents, a.datatrans, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.iclis, a.grclis, a.concs, a.obs," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.tipos, a.nums," + ;
                " a.numdopes, a.dopes, a.empdopnums, a.cnotas, a.locals, a.ntrans" + ;
                " FROM SigChLcq a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLotes)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLotes    = TratarNulo(numlotes,   "N")
            THIS.this_nNumLoteFPs  = TratarNulo(numloteFps, "N")
            THIS.this_cCodigos     = TratarNulo(codigos,    "C")
            THIS.this_cEmps        = TratarNulo(emps,       "C")
            THIS.this_cUsuar       = TratarNulo(usuarios,   "C")
            THIS.this_cMoeds       = TratarNulo(moeds,      "C")
            THIS.this_nCotas       = TratarNulo(cotas,      "N")
            THIS.this_cCotUsus     = TratarNulo(cotusus,    "C")
            THIS.this_nValTots     = TratarNulo(valtots,    "N")
            THIS.this_nValConvs    = TratarNulo(valconvs,   "N")
            THIS.this_dDtEnts      = TratarNulo(dtents,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,  "D")
            THIS.this_cGrupos      = TratarNulo(grupos,     "C")
            THIS.this_cContas      = TratarNulo(contas,     "C")
            THIS.this_cIclis       = TratarNulo(iclis,      "C")
            THIS.this_cGrclis      = TratarNulo(grclis,     "C")
            THIS.this_cObss        = TratarNulo(obs,        "C")
            THIS.this_cGruCart     = TratarNulo(grucarts,   "C")
            THIS.this_cConCart     = TratarNulo(concarts,   "C")
            THIS.this_cGruOrig     = TratarNulo(gruorigs,   "C")
            THIS.this_cConOrig     = TratarNulo(conorigs,   "C")
            THIS.this_cGruCCs      = TratarNulo(grupoccs,   "C")
            THIS.this_cConCCs      = TratarNulo(contaccs,   "C")
            THIS.this_cGruEmts     = TratarNulo(grupems,    "C")
            THIS.this_cConEmts     = TratarNulo(contems,    "C")
            THIS.this_cGruRes      = TratarNulo(gratends,   "C")
            THIS.this_cConRes      = TratarNulo(atends,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarCheques - Carrega cheques do lote em cursor_4c_Cheques (grid Page2)
    *==========================================================================
    FUNCTION BuscarCheques(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.nums, a.bancos, a.agencias, a.ncontas, a.ncheques," + ;
                " a.valors, a.valpags, a.vencs, a.datas, a.dtemis, a.nalineas," + ;
                " a.emps, a.iclis, a.grclis, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.grures, a.conres, a.protocolos, a.leituras, a.numeros" + ;
                " FROM SIGCHE a" + ;
                " WHERE a.numos = " + FormatarNumeroSQL(par_nNumLotes) + ;
                " ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

            IF USED("cursor_4c_Cheques")
                USE IN cursor_4c_Cheques
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cheques")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar cheques do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.this_nQtdeCheqs = RECCOUNT("cursor_4c_Cheques")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.BuscarCheques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProximoLote - Retorna proximo numlotes disponivel para a empresa
    *==========================================================================
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigChLcq" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo
        loc_lSucesso = .F.

        TRY
            loc_nProximo = THIS.ObterProximoLote()
            THIS.this_nNumLotes = loc_nProximo

            loc_cSQL = "INSERT INTO SigChLcq (" + ;
                " numlotes, numloteFps, codigos, emps, usuarios, moeds, cotas, cotusus," + ;
                " valtots, valconvs, dtents, datatrans, grupos, contas," + ;
                " iclis, grclis, obs, concs, grucarts, concarts," + ;
                " gruorigs, conorigs, grupoccs, contaccs, grupems, contems," + ;
                " gratends, atends, autos, tipos, nums, numdopes, dopes," + ;
                " empdopnums, cnotas, locals, ntrans, dtsis)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLotes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumLoteFPs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                "0," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConRes)) + "," + ;
                "0,'','',0,'','',0,0,GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigChLcq SET" + ;
                " codigos = "   + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                " emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                " cotusus = "   + EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                " dtents = "    + FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                " datatrans = " + IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                " grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                " contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                " iclis = "     + EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                " grclis = "    + EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                " obs = "       + EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                " grucarts = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                " concarts = "  + EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                " gruorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                " conorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                " grupoccs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                " contaccs = "  + EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                " grupems = "   + EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                " contems = "   + EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                " gratends = "  + EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                " atends = "    + EscaparSQL(ALLTRIM(THIS.this_cConRes)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLotes)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de cheques (SIGCHE) e do lote (SigChLcq)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigChLcq WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

