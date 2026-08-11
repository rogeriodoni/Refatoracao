# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ADICIONA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, 0, NUMLOTES, EMPS, NUMLOTECHS, VOPERS, UMOVS, NUMS, NOPERS, ICLIS, DOPES, NUMES, CIDCHAVES, BANCOS, AGENCIAS, CONTAS, NUMEROS, NCONTAS, NCHEQUES, LNRECNO, PARCELAS, LCBANCO, ORDENS, CPFS, EMIINDS, ALTDADOS, EMIPROTS, VALPENDS, BXPENDS, VALPEND2S, CODIGOS, TIPOS, GRUPOS, CLASS, VENCS, NALINEAS, BXCOMCHQS, OBS, EMPDOPNUMS, DTENTS, CONCS, NUMOS, TAMGRPBOTOES, CONCARTS, DOCUS, LNCLASSERR, LNERRO2, ALTCOTS, ICL, VALORS, DEVOLVIDOS, MARCA, CADEM, VINCULAS, COTAS, VALOR, DTSIS, FLAG, NDTEMISS, LCGRUPO, EMPINDS, ALINEAS, VALUE, CADEMIS, DISPMOVS, DTALTS, PAGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, 0, NUMLOTES, EMPS, NUMLOTECHS, VOPERS, UMOVS, NUMS, NOPERS, ICLIS, DOPES, NUMES, CIDCHAVES, BANCOS, AGENCIAS, CONTAS, NUMEROS, NCONTAS, NCHEQUES, LNRECNO, PARCELAS, LCBANCO, ORDENS, CPFS, EMIINDS, ALTDADOS, EMIPROTS, VALPENDS, BXPENDS, VALPEND2S, CODIGOS, TIPOS, GRUPOS, CLASS, VENCS, NALINEAS, BXCOMCHQS, OBS, EMPDOPNUMS, DTENTS, CONCS, NUMOS, TAMGRPBOTOES, CONCARTS, DOCUS, LNCLASSERR, LNERRO2, ALTCOTS, ICL, VALORS, DEVOLVIDOS, MARCA, CADEM, VINCULAS, COTAS, VALOR, DTSIS, FLAG, NDTEMISS, LCGRUPO, EMPINDS, ALINEAS, VALUE, CADEMIS, DISPMOVS, DTALTS, PAGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERACAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, 0, NUMLOTES, EMPS, NUMLOTECHS, VOPERS, UMOVS, NUMS, NOPERS, ICLIS, DOPES, NUMES, CIDCHAVES, BANCOS, AGENCIAS, CONTAS, NUMEROS, NCONTAS, NCHEQUES, LNRECNO, PARCELAS, LCBANCO, ORDENS, CPFS, EMIINDS, ALTDADOS, EMIPROTS, VALPENDS, BXPENDS, VALPEND2S, CODIGOS, TIPOS, GRUPOS, CLASS, VENCS, NALINEAS, BXCOMCHQS, OBS, EMPDOPNUMS, DTENTS, CONCS, NUMOS, TAMGRPBOTOES, CONCARTS, DOCUS, LNCLASSERR, LNERRO2, ALTCOTS, ICL, VALORS, DEVOLVIDOS, MARCA, CADEM, VINCULAS, COTAS, VALOR, DTSIS, FLAG, NDTEMISS, LCGRUPO, EMPINDS, ALINEAS, VALUE, CADEMIS, DISPMOVS, DTALTS, PAGOS
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formlch.prg) - TRECHOS RELEVANTES PARA PASS SQL (4983 linhas total):

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
491:             .Header1.Caption = "Emp"
492:         ENDWITH
493:         WITH loc_oGrid.Column3

*-- Linhas 1896 a 1914:
1896:             .HighlightBackColor = RGB(255, 255, 255)
1897:             .HighlightForeColor = RGB(15, 41, 104)
1898:             .HighlightStyle = 2
1899:             .DeleteMark = .F.
1900:             .RecordMark = .F.
1901:             .RowHeight = 16
1902:             .ScrollBars = 3
1903:             .GridLines = 3
1904:             .Visible = .T.
1905:         ENDWITH
1906:         WITH loc_oGrid.Column1
1907:             .Width = 30
1908:             .Header1.Caption = "Bco"
1909:         ENDWITH
1910:         WITH loc_oGrid.Column2
1911:             .Width = 38
1912:             .Header1.Caption = "Agen"
1913:         ENDWITH
1914:         WITH loc_oGrid.Column3

*-- Linhas 2833 a 2851:
2833:                     USE IN cursor_4c_Dados
2834:                 ENDIF
2835:                 SET NULL ON
2836:                 CREATE CURSOR cursor_4c_Dados ;
2837:                     (numlotes N(10,0), emps C(3), dtents D, codigos C(15), ;
2838:                      valtots N(15,2), concs N(1,0))
2839:                 SET NULL OFF
2840:                 SET DATASESSION TO (loc_nDsAtual)
2841:                 loc_lResultado = .T.
2842:             ELSE
2843:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2844: 
2845:                 *-- Montar filtro a partir dos controles da Page1
2846:                 loc_cFiltro = ""
2847:                 loc_dDtI = {}
2848:                 loc_dDtF = {}
2849:                 loc_nConc = 0
2850: 
2851:                 IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial) = "O"

*-- Linhas 2860 a 2901:
2860: 
2861:                 IF !EMPTY(loc_dDtI) AND !EMPTY(loc_dDtF)
2862:                     loc_cFiltro = loc_cFiltro + ;
2863:                         " AND a.dtents >= " + FormatarDataSQL(loc_dDtI) + ;
2864:                         " AND a.dtents <= " + FormatarDataSQL(loc_dDtF)
2865:                 ENDIF
2866: 
2867:                 DO CASE
2868:                 CASE loc_nConc = 2   && Conciliados
2869:                     loc_cFiltro = loc_cFiltro + " AND a.concs = 1"
2870:                 CASE loc_nConc = 3   && Pendentes
2871:                     loc_cFiltro = loc_cFiltro + " AND a.concs = 0"
2872:                 ENDCASE
2873: 
2874:                 IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
2875:                     loc_lResultado = .F.
2876:                 ELSE
2877:                     IF VARTYPE(loc_oPg1.grd_4c_Dados) = "O"
2878:                         loc_oGrid = loc_oPg1.grd_4c_Dados
2879:                         loc_oGrid.ColumnCount = 6
2880:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2881:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numlotes"
2882:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
2883:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dtents"
2884:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.codigos"
2885:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.valtots"
2886:                         loc_oGrid.Column6.ControlSource = ;
2887:                             "IIF(cursor_4c_Dados.concs=1,'Conciliado','Pendente')"
2888:                         loc_oGrid.Column1.Header1.Caption = "Lote"
2889:                         loc_oGrid.Column2.Header1.Caption = "Emp"
2890:                         loc_oGrid.Column3.Header1.Caption = "Dt. Entrada"
2891:                         loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2892:                         loc_oGrid.Column5.Header1.Caption = "Valor"
2893:                         loc_oGrid.Column6.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
2894:                         THIS.FormatarGridLista(loc_oGrid)
2895:                     ENDIF
2896:                     loc_lResultado = .T.
2897:                 ENDIF
2898:             ENDIF
2899:         CATCH TO loc_oErro
2900:             MsgErro(loc_oErro.Message, "Formlch.CarregarLista")
2901:         ENDTRY

*-- Linhas 2945 a 3016:
2945:                     USE IN cursor_4c_ChequesM
2946:                 ENDIF
2947:                 SET NULL ON
2948:                 CREATE CURSOR cursor_4c_ChequesM ;
2949:                     (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
2950:                      valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
2951:                      iclis C(10), protocolos C(20), dtemis D, marca L)
2952:                 SET NULL OFF
2953:                 loc_lResultado = .T.
2954:             ELSE
2955:                 IF THIS.this_oBusinessObject.BuscarCheques(loc_nLote)
2956:                     IF USED("cursor_4c_ChequesM")
2957:                         USE IN cursor_4c_ChequesM
2958:                     ENDIF
2959: 
2960:                     SET NULL ON
2961:                     IF USED("cursor_4c_Cheques") AND RECCOUNT("cursor_4c_Cheques") >= 0
2962:                         SELECT bancos, agencias, ncontas, ncheques, valors, vencs, ;
2963:                             nalineas, emps, iclis, protocolos, dtemis, .F. AS marca ;
2964:                             FROM cursor_4c_Cheques ;
2965:                             INTO CURSOR cursor_4c_ChequesM READWRITE
2966:                     ELSE
2967:                         CREATE CURSOR cursor_4c_ChequesM ;
2968:                             (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
2969:                              valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
2970:                              iclis C(10), protocolos C(20), dtemis D, marca L)
2971:                     ENDIF
2972:                     SET NULL OFF
2973:                     loc_lResultado = .T.
2974:                 ENDIF
2975:             ENDIF
2976: 
2977:             IF loc_lResultado
2978:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques) = "O"
2979:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques
2980:                     loc_oGrid.ColumnCount = 12
2981:                     loc_oGrid.RecordSource = "cursor_4c_ChequesM"
2982:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_ChequesM.bancos"
2983:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_ChequesM.agencias"
2984:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_ChequesM.ncontas"
2985:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_ChequesM.ncheques"
2986:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_ChequesM.valors"
2987:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_ChequesM.vencs"
2988:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_ChequesM.nalineas"
2989:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_ChequesM.emps"
2990:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_ChequesM.iclis"
2991:                     loc_oGrid.Column10.ControlSource = "cursor_4c_ChequesM.protocolos"
2992:                     loc_oGrid.Column11.ControlSource = "cursor_4c_ChequesM.dtemis"
2993:                     loc_oGrid.Column12.ControlSource = "cursor_4c_ChequesM.marca"
2994:                 ENDIF
2995: 
2996:                 *-- Atualizar totalizadores
2997:                 IF USED("cursor_4c_ChequesM")
2998:                     LOCAL loc_nQtde, loc_nVlrTot
2999:                     loc_nQtde   = RECCOUNT("cursor_4c_ChequesM")
3000:                     loc_nVlrTot = 0
3001:                     SELECT SUM(valors) FROM cursor_4c_ChequesM INTO ARRAY laVlr
3002:                     IF TYPE("laVlr") = "N"
3003:                         loc_nVlrTot = laVlr
3004:                     ENDIF
3005: 
3006:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs) = "O"
3007:                         THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs.Value = loc_nQtde
3008:                     ENDIF
3009:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal) = "O"
3010:                         THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal.Value = loc_nVlrTot
3011:                     ENDIF
3012:                 ENDIF
3013:             ENDIF
3014:         CATCH TO loc_oErro
3015:             MsgErro(loc_oErro.Message, "Formlch.CarregarGrade")
3016:         ENDTRY

*-- Linhas 3049 a 3067:
3049:             RETURN
3050:         ENDIF
3051: 
3052:         SELECT cursor_4c_Dados
3053:         loc_nLote = cursor_4c_Dados.numlotes
3054: 
3055:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3056:             THIS.this_cModoAtual = "VISUALIZAR"
3057:             THIS.BOParaForm()
3058:             THIS.CarregarGrade()
3059:             THIS.HabilitarCampos(.F.)
3060:             THIS.AjustarBotoesPorModo()
3061:             THIS.AlternarPagina(2)
3062:         ENDIF
3063:     ENDPROC
3064: 
3065:     *--------------------------------------------------------------------------
3066:     * BtnAlterarClick
3067:     *--------------------------------------------------------------------------

*-- Linhas 3073 a 3091:
3073:             RETURN
3074:         ENDIF
3075: 
3076:         SELECT cursor_4c_Dados
3077:         loc_nLote = cursor_4c_Dados.numlotes
3078: 
3079:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3080:             THIS.this_oBusinessObject.EditarRegistro()
3081:             THIS.this_cModoAtual = "ALTERAR"
3082:             THIS.BOParaForm()
3083:             THIS.CarregarGrade()
3084:             THIS.HabilitarCampos(.T.)
3085:             THIS.AjustarBotoesPorModo()
3086:             THIS.AlternarPagina(2)
3087:         ENDIF
3088:     ENDPROC
3089: 
3090:     *--------------------------------------------------------------------------
3091:     * BtnExcluirClick

*-- Linhas 3104 a 3122:
3104:             RETURN
3105:         ENDIF
3106: 
3107:         SELECT cursor_4c_Dados
3108:         loc_nLote = cursor_4c_Dados.numlotes
3109: 
3110:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3111:             IF THIS.this_oBusinessObject.Excluir()
3112:                 MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "")
3113:                 THIS.CarregarLista()
3114:             ENDIF
3115:         ENDIF
3116:     ENDPROC
3117: 
3118:     *--------------------------------------------------------------------------
3119:     * BtnBuscarClick
3120:     *--------------------------------------------------------------------------
3121:     PROCEDURE BtnBuscarClick()
3122:         LOCAL loc_oBusca, loc_nLote, loc_lResultado

*-- Linhas 3136 a 3158:
3136:                 loc_oBusca.Show()
3137: 
3138:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLch")
3139:                     SELECT cursor_4c_BuscaLch
3140:                     IF !EOF("cursor_4c_BuscaLch")
3141:                         loc_nLote = cursor_4c_BuscaLch.numlotes
3142:                         THIS.this_oBusinessObject.Buscar("AND a.numlotes = " + ;
3143:                             FormatarNumeroSQL(loc_nLote))
3144:                         THIS.CarregarLista()
3145:                     ENDIF
3146:                 ELSE
3147:                     THIS.CarregarLista()
3148:                 ENDIF
3149: 
3150:                 loc_oBusca.Release()
3151:                 loc_lResultado = .T.
3152:             ENDIF
3153:         CATCH TO loc_oErro
3154:             MsgErro(loc_oErro.Message, "Formlch.BtnBuscarClick")
3155:         ENDTRY
3156: 
3157:         IF USED("cursor_4c_BuscaLch")
3158:             USE IN cursor_4c_BuscaLch

*-- Linhas 3300 a 3354:
3300:         ENDIF
3301: 
3302:         TRY
3303:             SELECT cursor_4c_ChequesM
3304: 
3305:             IF THIS.this_oBusinessObject.this_nNumLotes <= 0
3306:                 MsgAviso("Salve o lote antes de excluir cheques.", "")
3307:                 RETURN
3308:             ENDIF
3309: 
3310:             loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
3311:                 FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
3312:                 " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
3313:                 " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
3314:                 " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
3315:                 " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))
3316: 
3317:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3318: 
3319:             IF loc_nResult < 0
3320:                 MsgErro("Erro ao excluir cheque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3321:             ELSE
3322:                 MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso!", "")
3323:                 THIS.CarregarGrade()
3324:             ENDIF
3325:         CATCH TO loc_oErro
3326:             MsgErro(loc_oErro.Message, "Formlch.BtnExcluirChequeClick")
3327:         ENDTRY
3328:     ENDPROC
3329: 
3330:     *--------------------------------------------------------------------------
3331:     * BtnMarcaClick - marca/desmarca cheque selecionado
3332:     *--------------------------------------------------------------------------
3333:     PROCEDURE BtnMarcaClick()
3334:         IF !USED("cursor_4c_ChequesM") OR EOF("cursor_4c_ChequesM")
3335:             RETURN
3336:         ENDIF
3337: 
3338:         TRY
3339:             SELECT cursor_4c_ChequesM
3340:             REPLACE cursor_4c_ChequesM.marca WITH !cursor_4c_ChequesM.marca
3341:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques.Refresh()
3342:         CATCH TO loc_oErro
3343:             MsgErro(loc_oErro.Message, "Formlch.BtnMarcaClick")
3344:         ENDTRY
3345:     ENDPROC
3346: 
3347:     *--------------------------------------------------------------------------
3348:     * BtnCmdExcChequeClick - exclui cheques marcados do lote
3349:     *--------------------------------------------------------------------------
3350:     PROCEDURE BtnCmdExcChequeClick()
3351:         LOCAL loc_cSQL, loc_nResult, loc_nExcluidos
3352: 
3353:         IF !USED("cursor_4c_ChequesM") OR RECCOUNT("cursor_4c_ChequesM") = 0
3354:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " cheques para excluir.", "")

*-- Linhas 3361 a 3390:
3361: 
3362:         TRY
3363:             loc_nExcluidos = 0
3364:             SELECT cursor_4c_ChequesM
3365:             GO TOP
3366: 
3367:             DO WHILE !EOF("cursor_4c_ChequesM")
3368:                 IF cursor_4c_ChequesM.marca
3369:                     loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
3370:                         FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
3371:                         " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
3372:                         " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
3373:                         " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
3374:                         " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))
3375:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3376:                     IF loc_nResult >= 0
3377:                         loc_nExcluidos = loc_nExcluidos + 1
3378:                     ENDIF
3379:                 ENDIF
3380:                 SKIP IN cursor_4c_ChequesM
3381:             ENDDO
3382: 
3383:             IF loc_nExcluidos > 0
3384:                 MsgInfo(TRANSFORM(loc_nExcluidos) + " cheque(s) exclu" + CHR(237) + "do(s).", "")
3385:                 THIS.CarregarGrade()
3386:             ENDIF
3387:         CATCH TO loc_oErro
3388:             MsgErro(loc_oErro.Message, "Formlch.BtnCmdExcChequeClick")
3389:         ENDTRY
3390:     ENDPROC

*-- Linhas 4044 a 4063:
4044:         ENDIF
4045: 
4046:         TRY
4047:             loc_nRes = SQLEXEC(gnConnHandle, ;
4048:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cOper), ;
4049:                 "cursor_4c_ValidOper")
4050:             IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidOper") = 0
4051:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cOper, "")
4052:                 loc_oPg2.txt_4c_Oper.Value = ""
4053:             ENDIF
4054:         CATCH TO loc_oErro
4055:             MsgErro(loc_oErro.Message, "Formlch.ValidarOper")
4056:         ENDTRY
4057:         IF USED("cursor_4c_ValidOper")
4058:             USE IN cursor_4c_ValidOper
4059:         ENDIF
4060:     ENDPROC
4061: 
4062:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
4063:         LOCAL loc_oPg2, loc_cMoeda, loc_nRes

*-- Linhas 4071 a 4090:
4071:         ENDIF
4072: 
4073:         TRY
4074:             loc_nRes = SQLEXEC(gnConnHandle, ;
4075:                 "SELECT codigos FROM SigCdMoe WHERE codigos = " + EscaparSQL(loc_cMoeda), ;
4076:                 "cursor_4c_ValidMoe")
4077:             IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidMoe") = 0
4078:                 MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cMoeda, "")
4079:                 loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ""
4080:             ENDIF
4081:         CATCH TO loc_oErro
4082:             MsgErro(loc_oErro.Message, "Formlch.ValidarMoeda")
4083:         ENDTRY
4084:         IF USED("cursor_4c_ValidMoe")
4085:             USE IN cursor_4c_ValidMoe
4086:         ENDIF
4087:     ENDPROC
4088: 
4089:     PROCEDURE ValidarGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
4090:         THIS.BuscarDescGrupo("cnt_4c_Origem", "txt_4c_GruOrig", "txt_4c_DGruOrig")

*-- Linhas 4154 a 4176:
4154:         ENDIF
4155: 
4156:         TRY
4157:             loc_nRes = SQLEXEC(gnConnHandle, ;
4158:                 "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps), ;
4159:                 "cursor_4c_ValidEmp")
4160:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidEmp") > 0
4161:                 SELECT cursor_4c_ValidEmp
4162:                 IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4163:                     loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_ValidEmp.razas)
4164:                 ENDIF
4165:                 THIS.this_oBusinessObject.this_cDEmps = ALLTRIM(cursor_4c_ValidEmp.razas)
4166:             ELSE
4167:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, "")
4168:                 loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ""
4169:                 IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4170:                     loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ""
4171:                 ENDIF
4172:             ENDIF
4173:         CATCH TO loc_oErro
4174:             MsgErro(loc_oErro.Message, "Formlch.ValidarEmpresa")
4175:         ENDTRY
4176:         IF USED("cursor_4c_ValidEmp")

*-- Linhas 4190 a 4212:
4190:         ENDIF
4191: 
4192:         TRY
4193:             loc_nRes = SQLEXEC(gnConnHandle, ;
4194:                 "SELECT iclis, cpfs, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
4195:                 "cursor_4c_ValidCli")
4196:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidCli") > 0
4197:                 SELECT cursor_4c_ValidCli
4198:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4199:                     loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ALLTRIM(cursor_4c_ValidCli.cpfs)
4200:                 ENDIF
4201:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4202:                     loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ALLTRIM(cursor_4c_ValidCli.razaos)
4203:                 ENDIF
4204:             ELSE
4205:                 MsgAviso("Cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
4206:                 loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ""
4207:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4208:                     loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ""
4209:                 ENDIF
4210:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4211:                     loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ""
4212:                 ENDIF

*-- Linhas 4255 a 4278:
4255:         ENDIF
4256: 
4257:         TRY
4258:             loc_nRes = SQLEXEC(gnConnHandle, ;
4259:                 "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
4260:                 "cursor_4c_DescGru")
4261:             loc_cDesc = ""
4262:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGru") > 0
4263:                 SELECT cursor_4c_DescGru
4264:                 loc_cDesc = ALLTRIM(cursor_4c_DescGru.descrs)
4265:             ELSE
4266:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo, "")
4267:                 EVALUATE("loc_oCnt." + par_cTxtGru + ".Value = ''")
4268:             ENDIF
4269:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4270:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
4271:             ENDIF
4272:         CATCH TO loc_oErro
4273:             MsgErro(loc_oErro.Message, "Formlch.BuscarDescGrupo")
4274:         ENDTRY
4275:         IF USED("cursor_4c_DescGru")
4276:             USE IN cursor_4c_DescGru
4277:         ENDIF
4278:     ENDPROC

*-- Linhas 4306 a 4329:
4306:         ENDIF
4307: 
4308:         TRY
4309:             loc_nRes = SQLEXEC(gnConnHandle, ;
4310:                 "SELECT iclis, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
4311:                 "cursor_4c_DescCon")
4312:             loc_cDesc = ""
4313:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCon") > 0
4314:                 SELECT cursor_4c_DescCon
4315:                 loc_cDesc = ALLTRIM(cursor_4c_DescCon.razaos)
4316:             ELSE
4317:                 MsgAviso("Conta/cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
4318:                 EVALUATE("loc_oCnt." + par_cTxtCon + ".Value = ''")
4319:             ENDIF
4320:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4321:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
4322:             ENDIF
4323:         CATCH TO loc_oErro
4324:             MsgErro(loc_oErro.Message, "Formlch.BuscarDescConta")
4325:         ENDTRY
4326:         IF USED("cursor_4c_DescCon")
4327:             USE IN cursor_4c_DescCon
4328:         ENDIF
4329:     ENDPROC

*-- Linhas 4599 a 4617:
4599:                 loc_oBusca.Show()
4600: 
4601:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOper")
4602:                     SELECT cursor_4c_BuscaOper
4603:                     IF !EOF("cursor_4c_BuscaOper") AND VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
4604:                         loc_oPg2.txt_4c_Oper.Value = ALLTRIM(cursor_4c_BuscaOper.operacaos)
4605:                     ENDIF
4606:                 ENDIF
4607: 
4608:                 loc_oBusca.Release()
4609:                 loc_lResultado = .T.
4610:             ENDIF
4611:         CATCH TO loc_oErro
4612:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupOper")
4613:         ENDTRY
4614: 
4615:         IF USED("cursor_4c_BuscaOper")
4616:             USE IN cursor_4c_BuscaOper
4617:         ENDIF

*-- Linhas 4637 a 4655:
4637:                 loc_oBusca.Show()
4638: 
4639:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
4640:                     SELECT cursor_4c_BuscaMoe
4641:                     IF !EOF("cursor_4c_BuscaMoe") AND ;
4642:                        VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
4643:                         loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ;
4644:                             ALLTRIM(cursor_4c_BuscaMoe.codigos)
4645:                     ENDIF
4646:                 ENDIF
4647: 
4648:                 loc_oBusca.Release()
4649:                 loc_lResultado = .T.
4650:             ENDIF
4651:         CATCH TO loc_oErro
4652:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupMoeda")
4653:         ENDTRY
4654: 
4655:         IF USED("cursor_4c_BuscaMoe")

*-- Linhas 4679 a 4697:
4679:                     loc_oBusca.Show()
4680: 
4681:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
4682:                         SELECT cursor_4c_BuscaGru
4683:                         IF !EOF("cursor_4c_BuscaGru")
4684:                             loc_oTxtGru = EVALUATE("loc_oCnt." + par_cTxtGru)
4685:                             IF VARTYPE(loc_oTxtGru) = "O"
4686:                                 loc_oTxtGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
4687:                             ENDIF
4688:                             IF !EMPTY(par_cTxtDesc)
4689:                                 loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
4690:                                 IF VARTYPE(loc_oTxtDesc) = "O"
4691:                                     loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
4692:                                 ENDIF
4693:                             ENDIF
4694:                         ENDIF
4695:                     ENDIF
4696: 
4697:                     loc_oBusca.Release()

*-- Linhas 4729 a 4747:
4729:                     loc_oBusca.Show()
4730: 
4731:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCon")
4732:                         SELECT cursor_4c_BuscaCon
4733:                         IF !EOF("cursor_4c_BuscaCon")
4734:                             loc_oTxtCon = EVALUATE("loc_oCnt." + par_cTxtCon)
4735:                             IF VARTYPE(loc_oTxtCon) = "O"
4736:                                 loc_oTxtCon.Value = ALLTRIM(cursor_4c_BuscaCon.iclis)
4737:                             ENDIF
4738:                             IF !EMPTY(par_cTxtDesc)
4739:                                 loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
4740:                                 IF VARTYPE(loc_oTxtDesc) = "O"
4741:                                     loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaCon.razaos)
4742:                                 ENDIF
4743:                             ENDIF
4744:                         ENDIF
4745:                     ENDIF
4746: 
4747:                     loc_oBusca.Release()

*-- Linhas 4780 a 4798:
4780:                     loc_oBusca.Show()
4781: 
4782:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
4783:                         SELECT cursor_4c_BuscaCpf
4784:                         IF !EOF("cursor_4c_BuscaCpf")
4785:                             loc_oTxtCpf = EVALUATE("loc_oCnt." + par_cTxtCpf)
4786:                             IF VARTYPE(loc_oTxtCpf) = "O"
4787:                                 loc_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
4788:                             ENDIF
4789:                         ENDIF
4790:                     ENDIF
4791: 
4792:                     loc_oBusca.Release()
4793:                     loc_lResultado = .T.
4794:                 ENDIF
4795:             ENDIF
4796:         CATCH TO loc_oErro
4797:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupCpf")
4798:         ENDTRY

*-- Linhas 4822 a 4840:
4822:                 loc_oBusca.Show()
4823: 
4824:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
4825:                     SELECT cursor_4c_BuscaEmp
4826:                     IF !EOF("cursor_4c_BuscaEmp")
4827:                         IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"
4828:                             loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ;
4829:                                 ALLTRIM(cursor_4c_BuscaEmp.cemps)
4830:                         ENDIF
4831:                         IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4832:                             loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ;
4833:                                 ALLTRIM(cursor_4c_BuscaEmp.razas)
4834:                         ENDIF
4835:                         THIS.this_oBusinessObject.this_cDEmps = ;
4836:                             ALLTRIM(cursor_4c_BuscaEmp.razas)
4837:                     ENDIF
4838:                 ENDIF
4839: 
4840:                 loc_oBusca.Release()

*-- Linhas 4870 a 4888:
4870:                 loc_oBusca.Show()
4871: 
4872:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIclis")
4873:                     SELECT cursor_4c_BuscaIclis
4874:                     IF !EOF("cursor_4c_BuscaIclis")
4875:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"
4876:                             loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ;
4877:                                 ALLTRIM(cursor_4c_BuscaIclis.iclis)
4878:                         ENDIF
4879:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4880:                             loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ;
4881:                                 ALLTRIM(cursor_4c_BuscaIclis.cpfs)
4882:                         ENDIF
4883:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4884:                             loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ;
4885:                                 ALLTRIM(cursor_4c_BuscaIclis.razaos)
4886:                         ENDIF
4887:                     ENDIF
4888:                 ENDIF

*-- Linhas 4918 a 4936:
4918:                 loc_oBusca.Show()
4919: 
4920:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGre")
4921:                     SELECT cursor_4c_BuscaGre
4922:                     IF !EOF("cursor_4c_BuscaGre") AND ;
4923:                        VARTYPE(loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp) = "O"
4924:                         SCATTER MEMVAR MEMO
4925:                         loc_cClasse = ALLTRIM(m.class)
4926:                         loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp.Value = loc_cClasse
4927:                     ENDIF
4928:                 ENDIF
4929: 
4930:                 loc_oBusca.Release()
4931:                 loc_lResultado = .T.
4932:             ENDIF
4933:         CATCH TO loc_oErro
4934:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupClasemp")
4935:         ENDTRY
4936: 

*-- Linhas 4959 a 4977:
4959:                 loc_oBusca.Show()
4960: 
4961:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAli")
4962:                     SELECT cursor_4c_BuscaAli
4963:                     IF !EOF("cursor_4c_BuscaAli") AND ;
4964:                        VARTYPE(loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe) = "O"
4965:                         loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe.Value = ;
4966:                             ALLTRIM(cursor_4c_BuscaAli.codigos)
4967:                     ENDIF
4968:                 ENDIF
4969: 
4970:                 loc_oBusca.Release()
4971:                 loc_lResultado = .T.
4972:             ENDIF
4973:         CATCH TO loc_oErro
4974:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupAlinea")
4975:         ENDTRY
4976: 
4977:         IF USED("cursor_4c_BuscaAli")


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

