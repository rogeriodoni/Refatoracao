# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CRAVCERS, CIDCHAVES, IMPOPS, _XPULA, EMPDNPS, NOPS, _XLINE, LNQT2, MATS, _CNTLNH, NFUNDS, _LCCLASS, LCCODLIN, LCCODCOR, LINHAS, GRUPOS, CPROS, DOPPS, EMPDOPNUMS, CITEM2, ORDIMP, CODTAMS, CUNIS, CGRUS, NCOMPO, GLOBALIZAS, SERVICOS, ITIRAS, CTRLLOTES, GERBALS, NTPIMPRES, LNPOS, CMATS

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
  ControlSource = ""
Select crBranco
Append Memo Branco From (lcBrancos) Overwrite
lcQuery = [Select * ] + ;
		    [From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
		Select TmpImp 
		Insert Into TmpImp (Nops, Detalhe2, OrdImp, TpInstals ) Values (_Nops, .t., 2, [])
	Insert Into TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, Datas, Peso, ;
		lcQuery = [Update SigOpPic Set Imprs = ?pTru Where cIdChaves = ?pIds]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - Proctiraf 1)')
Select TmpImp
Select Nops, CPros, Sum(Qtde) as Qtde, Numps ;
  From TmpImp ;
Select TmpCompo
	Select crSigPrCpo
		Insert Into TmpImp (Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, cunis ) ;
Select TmpImp 	
Select Nops, CPros, Sum(Qtde) as Qtde ;
  From TmpImp where !Empty(cpros) ;
Select TmpCompo
	Select crSigCdPrf
		Insert Into TmpImp (Nops, DGrupos, Detalhe4, OrdImp, Obs, TpInstals ) ;
Select TmpImp
Delete File &lcApagar.
lcQuery = [Select * ] + ;
		    [From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
	lcSql = [Select Tubos from SigCdFud where nops = ]+STR(TempOpi.Nops,10)
	Thisform.Podatamgr.sqlexecute(lcSql,'TmpIfund')
	Select TmpiFund
	Select TmpImp
	If Not Seek(Str(TempOpi.Nops, 10) + '1')
		Insert Into TmpImp (Nops, Ordem, Seqs, Cpros, CodBar, ImpCodBar, qtdetiqs, nFunds, DtFunds, Dataes, ;
			Insert Into DbImpressao (Nops, idNfs, Ceras, Cpros, cclass, cfunds, CodBar, QtdEtiqs, Qtds ) Values ;
			=Seek(lnOpAnt+'1','DbImpressao')
						Select DbImpressao
			lcSql = [Select a.Mats, a.Qtscons, b.Sgrus From SigPrCpo a, SigCdPro b Where ]+;
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigPrCpo')
			Select crSigPrCpo
	Select TmpImp
		Insert Into TmpImp (Nops, Ordem, Seqs, Cpros, CodBar, qtdetiqs, nFunds, DtFunds, Idnfs, Ceras, CodAcbs, cClass, Tubos, ctubos, TipoOps ) ;
		=Seek(lnNop + '1','DbImpressao')
=Seek(lnOpAnt + '1','DbImpressao')
			Select DbImpressao
Select TmpImp
				Select DbImpressao
Select TmpImp
Delete All For Empty(Nops) And Empty(CPros)
lcQuery = [Select * ] + ;
		    [From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
		ThisForm.poDataMgr.SQlExecute([Select Grupos from SigCdLnf where Linhas = '] + crSigCdPro.Linhas + [' And Grupos = '] + lcFase + ['],[crSigCdLnf])	
		lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?TempMfas.CodPds]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
		Select crSigPrMtz
	Insert Into TmpImp (Ordem, Seqs, Cpros, Dpros, Dpro2s, Qtde, Obs, Pedido, ImpPeds, ;
	Select crSigPrCpo
		Select TmpRes
	Select TmpRes
	If Not Seek('1' + lcGru + lcCompo)
Select TmpImp
	Insert Into dbCabec (Operacao, Ordem, DtGeras, Subtitulo) ;
	Select Mats, Descs, Cunis, Sum(Qtds) as Qtds, Sum(Pesos) as Pesos, Sum(QtPcs) as QtPcs ;
	  From TmpRes ;
	Select CsRes
		Select TmpRes
	Select TmpImp
		Select Ordem, Seqs, CPros, CodCors, CodTams, DPros, Dpro2s, '' as Obs, ImpCodBar, ;
		  From TmpImp ;
		Select Ordem, Pedido, Usuars ;
		  From TmpImp ;
			Select TmpRes
lcQuery = [Select * From SigOpPic ] + ;
		  [Select * From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
		lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?TempMfas.CodPds]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
		Select crSigPrMtz
	Insert Into TmpImp (Nops, Seqs, Cpros, Dpros, Qtde, Obs, Pedido, ImpPeds, ;
	Select crSigPrCpo
		Select TmpRes
	Select TmpRes
	If Not Seek('1' + lcGru + lcCompo)
Select TmpImp
	Select Mats, Descs, Cunis, Sum(Qtds) as Qtds, Sum(Pesos) as Pesos, Sum(QtPcs) as QtPcs ;
	  From TmpRes ;
	Select CsRes
		Select TmpRes
	Insert Into dbCabec (Operacao, Ordem, DtGeras, Subtitulo) ;
	Select TmpImp
		Select Nops, Seqs, CPros, CodCors, CodTams, DPros, '' as Obs, Pedido, ImpPeds, ;
		  From TmpImp ;
		Select TmpRes
lcQuery = [Select * From SigOpPic ] + ;
		  [Select * From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
			Select TmpImp 
			Insert Into TmpImp (Cpros, Nops, Detalhe2, OrdImp ) Values (_Cpro, _Nops, .t., 2)
			Select TmpImp
			Seek(_Cpro)
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TempOpi.empdopnums and cpros = ?TempOpi.CPros and citem2 = ?TempOpi.citens],[crSigPrCpo])
	Insert Into TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, ;
		lcQuery = [Update SigOpPic Set Imprs = ?pTru Where cIdChaves = ?pIds]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - Proctiras 1)')
Select TmpImp
Select CPros, Sum(Qtde) as Qtde, Nops, empdopnums, citens, CodTams, CodCors ;
  From TmpImp where !Empty(cpros) and OrdImp = 1 ;
Select TmpCompo
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TmpCompo.empdopnums and cpros = ?TmpCompo.CPros and citem2 = ?TmpCompo.citens],[crSigPrCpo])
		lcSql = [Select a.Mats, b.cunis, b.dpros, a.Matriz, ] +;
				[From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros ] +;
				[Inner Join SigCdUni c On b.Cunis = c.Cunis ] +;
				[Inner Join SigCdGrp d On b.Cgrus = d.Cgrus ] +;
				[Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = ']+TmpCompo.CodTams+[' ] +;
		ThisForm.poDataMgr.sqlexecute(lcSql,'crSigPrCpo')
	Select crSigPrCpo
		Select TmpImp
			Insert Into TmpImp (cpros, Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, cunis, ncompo) ;
			Select crSigPrCpo2
				Insert Into TmpImp (Nops, CMats, cMat2s, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, cunis, ncompo ) ;
Select TmpImp
Select crBranco
Append Memo Branco From (lcBrancos) Overwrite
lcQuery = [Select * From SigOpPic ] + ;
		  [Select * From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
			Select TmpImp 
			Insert Into TmpImp (Cpros, Nops, Detalhe2, OrdImp, TpInstals ) Values (_Cpro, _Nops, .t., 2, [])
			Select TmpImp
			Seek(_Cpro)
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TempOpi.empdopnums and cpros = ?TempOpi.CPros and citem2 = ?TempOpi.citens],[crSigPrCpo])
	Insert Into TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, Datas, Peso, ;
		lcQuery = [Update SigOpPic Set Imprs = ?pTru Where cIdChaves = ?pIds]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - Proctiraf 1)')
Select TmpImp
Select TmpImp
Select CPros, Sum(Qtde) as Qtde, Numps, Nops, empdopnums, citens, CodTams, CodCors ;
  From TmpImp where !Empty(cpros) and OrdImp = 1 ;
Select TmpCompo
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TmpCompo.empdopnums and cpros = ?TmpCompo.CPros and citem2 = ?TmpCompo.citens],[crSigPrCpo])
		lcSql = [Select a.Mats, b.cunis, b.dpros, a.Matriz, ] +;
				[From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros ] +;
				[Inner Join SigCdUni c On b.Cunis = c.Cunis ] +;
				[Inner Join SigCdGrp d On b.Cgrus = d.Cgrus ] +;
				[Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = ']+TmpCompo.CodTams+[' ] +;
		ThisForm.poDataMgr.sqlexecute(lcSql,'crSigPrCpo')
	Select crSigPrCpo
		Select TmpImp
			Insert Into TmpImp (cpros, Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, cunis, ncompo) ;
			Select crSigPrCpo2
				Insert Into TmpImp (Nops, CMats, cMat2s, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, cunis, ncompo ) ;
Select TmpImp 	
Select Nops, CPros, Sum(Qtde) as Qtde ;
  From TmpImp where !Empty(cpros) ;
Select TmpCompo
	Select crSigCdPrf
		Insert Into TmpImp (Cpros, DGrupos, Detalhe4, OrdImp, Obs, TpInstals ) ;
Select TmpImp
Delete File &lcApagar.
Select crBranco
Append Memo Branco From (lcBrancos) Overwrite
lcQuery = [Select * ] + ;
		    [From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
		ThisForm.poDataMgr.SQlExecute([Select Grupos from SigCdLnf where Linhas = '] + crSigCdPro.Linhas + [' And Grupos = '] + lcFase + ['],[crSigCdLnf])	
	lcSql = [Select Numps from SigPdMvf Where Nops = ]+Str(TempOpi.Nops)+[ And Dopps = ']+CrSigCdPam.DopEnvels+[']
	ThisForm.poDataMgr.sqlexecute(lcSql,'TempMfas')
	Select TempOpi
		Select TmpImp 
		Insert Into TmpImp (Nops, Detalhe2, OrdImp, TpInstals, Processos) Values (_Nops, llProcs, 2, [], llProcs)
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TempOpi.empdopnums and cpros = ?TempOpi.CPros and citem2 = ?TempOpi.citens],[crSigPrCpo])
	IF (ThisForm.poDataMgr.SqlExecute([Select * From SigCdCnq], [crLocal])) >0
		Select crLocal
		IF SEEK(TempOpi.CodTams+LocalPro.conquilhas, [crLocal], [con]) 
	Insert Into TmpImp (Ordem, Seqs, Cpros, Dpros, DPro2s, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, Datas, Peso, ;
		lcQuery = [Update SigOpPic Set Imprs = ?pTru Where cIdChaves = ?pIds]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - Proctiraf 1)')
Select TmpImp
Select Nops, CPros, Sum(Qtde) as Qtde ;
  From TmpImp where !Empty(cpros) ;
Select TmpCompo
	lcQuery = [Select a.*, b.Locals ] + ;
			    [From SigPrMtz a, SigCdPro b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMtz]) < 1)
	Select LocalMtz
		Select TmpImp
Select TmpImp
Select TmpImp
Select Nops, CPros, Sum(Qtde) as Qtde, empdopnums, citens, numps, CodTams, CodCors ;
  From TmpImp where !Empty(cpros) ;
Select TmpCompo
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TmpCompo.empdopnums and cpros = ?TmpCompo.CPros and citem2 = ?TmpCompo.citens],[crSigPrCpo])
		lcSql = [Select a.Mats, b.cunis, b.CuniPs, b.dpros, a.Matriz, a.ObsOFs, ] +;
				[From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros ] +;
				[Inner Join SigCdUni c On b.Cunis = c.Cunis ] +;
				[Inner Join SigCdGrp d On b.Cgrus = d.Cgrus ] +;
				[Left Join SigSubCp e On a.Cpros = e.Cpros And a.mats = e.Mats And e.CodTams = ']+TmpCompo.CodTams+[' ] +;
		ThisForm.poDataMgr.sqlexecute(lcSql,'crSigPrCpo')
	Select crSigPrCpo
		Select TmpImp
			Insert Into TmpImp (Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, ;
			Select crSigPrCpo2
				Insert Into TmpImp (Nops, CMats, cMat2s, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, ;
	Select TmpImp 	
	Select Nops, CPros, Sum(Qtde) as Qtde ;
	  From TmpImp where !Empty(cpros) ;
	Select TmpCompo
		Select crSigCdPrf
			Insert Into TmpImp (Nops, DGrupos, Detalhe4, OrdImp, Obs, TpInstals ) ;
Select TmpImp
Delete File &lcApagar.
lcQuery = [Select * ] + ;
		    [From SigOpPic ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempOpi') < 1)
Select TempOpi
		Select TmpImp 
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TempOpi.empdopnums and cpros = ?TempOpi.CPros and citem2 = ?TempOpi.citens],[crSigPrCpo])
	IF (ThisForm.poDataMgr.SqlExecute([Select * From SigCdCnq], [crLocal])) >0
		Select crLocal
		IF SEEK(TempOpi.CodTams+LocalPro.conquilhas, [crLocal], [con]) 
	Insert Into TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, ;
		lcQuery = [Update SigOpPic Set Imprs = ?pTru Where cIdChaves = ?pIds]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - Proctiras 1)')
Select TmpImp
Select Nops, CPros, Sum(Qtde) as Qtde, empdopnums, citens, codtams, codcors ;
  From TmpImp where !Empty(cpros) ;
Select TmpCompo
	ThisForm.poDataMgr.sqlexecute([Select *, qtds as QtsCons from SigSubMv where empdopnums = ?TmpCompo.empdopnums and cpros = ?TmpCompo.CPros and citem2 = ?TmpCompo.citens],[crSigPrCpo])
		lcSql = [Select a.Mats, b.cunis, b.dpros, a.Matriz, ] +;
				[From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros ] +;
				[Inner Join SigCdUni c On b.Cunis = c.Cunis ] +;
				[Inner Join SigCdGrp d On b.Cgrus = d.Cgrus ] +;
				[Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = ']+TmpCompo.CodTams+[' ] +;
		ThisForm.poDataMgr.sqlexecute(lcSql,'crSigPrCpo')
	Select crSigPrCpo
		Select TmpImp
			Insert Into TmpImp (Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Cunis, ncompo) ;
			Select crSigPrCpo2
				Insert Into TmpImp (Nops, CMats, cMat2s, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, cunis, ncompo ) ;
Select TmpImp
		lcQuery = [Select Dopes ] + ;
				    [From SigCdOpe ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOpe') < 1)
		Select TmpOpe
		lcQuery = [Select Codigos, Descrs, OsAlfuns ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crGruposBal') < 1)
		Select crGruposBal
	lcQuery = [Select impres from SigCdmp Where nTpImpres <> 2]
	.poDataMgr.SqlExecute(lcQuery, [crTmpBolI])
	Select crTmpBolI
	Select crGruposBal
	If Not Seek(This.Value)
	Select crGruposBal
	If Not Seek(This.Value)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigregli.prg) - TRECHOS RELEVANTES PARA PASS SQL (2610 linhas total):

*-- Linhas 2357 a 2375:
2357:         TRY
2358:             loc_lAchou = .F.
2359:             IF USED("crGruposBal")
2360:                 SELECT crGruposBal
2361:                 SET ORDER TO TAG Codigos
2362:                 IF SEEK(loc_cValor)
2363:                     THIS.txt_4c_Dfase.Value = ALLTRIM(crGruposBal.Descrs)
2364:                     loc_lAchou = .T.
2365:                 ENDIF
2366:             ENDIF
2367:             IF !loc_lAchou
2368:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2369:                     "SigCdGcr", "cursor_4c_gcr", "Codigos", loc_cValor, ;
2370:                     "Cadastro de Grupos")
2371:                 IF !ISNULL(loc_oForm)
2372:                     IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2373:                         THIS.txt_4c_Fase.Value  = ALLTRIM(cursor_4c_gcr.Codigos)
2374:                         THIS.txt_4c_Dfase.Value = ALLTRIM(cursor_4c_gcr.Descrs)
2375:                     ELSE

*-- Linhas 2417 a 2435:
2417:         TRY
2418:             loc_lAchou = .F.
2419:             IF USED("crGruposBal")
2420:                 SELECT crGruposBal
2421:                 SET ORDER TO TAG Descrs
2422:                 IF SEEK(loc_cValor)
2423:                     THIS.txt_4c_Fase.Value  = ALLTRIM(crGruposBal.Codigos)
2424:                     THIS.txt_4c_Dfase.Value = ALLTRIM(crGruposBal.Descrs)
2425:                     loc_lAchou = .T.
2426:                 ENDIF
2427:             ENDIF
2428:             IF !loc_lAchou
2429:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2430:                     "SigCdGcr", "cursor_4c_gcr", "Descrs", loc_cValor, ;
2431:                     "Cadastro de Grupos")
2432:                 IF !ISNULL(loc_oForm)
2433:                     IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2434:                         THIS.txt_4c_Fase.Value  = ALLTRIM(cursor_4c_gcr.Codigos)
2435:                         THIS.txt_4c_Dfase.Value = ALLTRIM(cursor_4c_gcr.Descrs)

