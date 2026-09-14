# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CIDQUERYS, INVENTS, SQTDS, PEPS, LNQTDS, UNITS, EMPDOPNUMS, CPROS, LNIMPPEPS, LNIMPUEPS, PS2, PS, CEMPS, ESTAS, COTAS, LNCONTA, CODIGOS, DATAS

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
  ControlSource = ""
Select TmpGccr
lcQuery = [Select a.Emps, a.Grupos, a.Estos, a.CPros, a.CodCors, a.CodTams, a.SQtds, a.TEQtds, ] + ;
			[From SigMvEst a Inner Join SigCdPro b On b.CPros = a.CPros ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEst1') < 1)
Select a.Emps, a.Grupos, a.Estos, a.CPros, a.CodCors, a.CodTams, a.SQtds, a.TEQtds, ;
  From TmpEst1 a, TmpGccr1 b ;
Select TmpEst
	Update TmpEst Set SQtds = 0, TEQtds = 0, TSQtds = 0
	Select TmpEst
			Select SigMvHst
			Select TmpEst
				loBarraHis.Update(.T.,'Grupo: ' + Alltrim(TmpEst.Grupos)+ ' - Estoque: ' + Alltrim(TmpEst.Estos) + ' - Produto: ' + TmpEst.CPros)
				Select SigMvHst
				Select TmpEst
			Select Distinct Emps + Grupos + Estos as EmpGruEsts ;
			  From TmpEst ;
			Select CsEst
				Insert Into crSigTempR (cIdChaves, cIdQuerys, EmpGruests) ;
			If Not ThisForm.poDataMgr.Update('crSigTempR')
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigTempR)')
				lcQuery = [Select a.EmpGruEsts, a.OriDopNums, a.Emps, a.Grupos, a.Estos, a.CPros, a.Datas, a.Qtds, ] + ;
						    [From SigOpCdc o ] + ;
						   [Inner Join SigMvHst a On o.Dopes = a.Dopes ] + ;
						   [Inner Join SigTempR b On b.EmpGruEsts = a.EmpGruEsts ] + ;
				lcQuery = [Select a.EmpGruEsts, a.OriDopNums, a.Emps, a.Grupos, a.Estos, a.CPros, a.Datas, a.Qtds, ] + ;
						    [From SigMvHst a ] + ;
						   [Inner Join SigTempR b On b.EmpGruEsts = a.EmpGruEsts ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpHis') < 1)
			Select TmpHis
			Select TmpHis
				Select TmpEst
					loBarraHis.Update(.t., 'Grupo: ' + Alltrim(TmpEst.Grupos)+ ' - Estoque: ' + Alltrim(TmpEst.Estos) + ' - Produto: ' + TmpEst.CPros)
					If Seek(TmpEst.Emps + TmpEst.Grupos + TmpEst.Estos + TmpEst.CPros + TmpEst.CodCors + TmpEst.CodTams, 'TmpHis', 'EmpPro2')
Select a.Emps, a.Grupos, a.Estos, a.CPros, Iif(InList(b.TipoEstos,2,4), a.CodCors, Space(Len(a.CodCors))) as CodCors, ;
  From TmpEst a ;
 Inner Join crSigCdGrp  b On b.CGrus = a.CGrus ;
 Inner Join crSigCdGpr c On c.Codigos = b.Mercs ;
Select a.Emps, a.Grupos, a.Estos, a.CPros, a.CodCors, a.CodTams, a.TipEsts, a.UnitMeds, a.MoedMeds, a.CGrus, ;
  From crSigMvEst1 a ;
  Left Join crSigCdPsg b On b.GruCods = a.GruCods ;
  Left Join crSigCdLin  c On c.Linhas  = a.Linhas ;
Select crSigMvEst
Select Distinct Emps, Grupos, Estos, CPros, CodCors, CodTams ;
  From TmpEst ;
Select crSigMvEst
	loBarraEst.Update(.T., 'Faltam : ' + Alltrim(Str(lnFalta, 10)) + ;
	Select crSigMvEst
		Select Sum(SQtds) as SQtds, UnitMeds, MoedMeds ;
		  From TmpEst ;
		Select crSigMvEst
		Select crSigMvEst
		=Seek(lcChave)
		Select crSigMvEst
		Insert Into csTempo From MemVar
			Select TmpGrupo
				Insert Into TmpGrupo (Tipo, CGrus, Moedas) Values ('1', csTempo.CGrus, csTempo.MoeCusto)
			Select TmpGrupo
				Insert Into TmpGrupo (Tipo, CGrus, Moedas) Values ('2', csTempo.CGrus, csTempo.MoeVenda)
			Select TmpGrupo
				Insert Into TmpGrupo (Tipo, CGrus, Moedas) Values ('3', csTempo.CGrus, csTempo.MoeMedio)
		Select crSigMvEst
Select csTempo
		Select SigMvHst
	Select Distinct Emps ;
	  From TmpEst ;
	Select csEst
			Select csEst
		lStrQuery = [Select a.Datas, a.Emps, a.EmpGruEsts, a.OriDopNums, a.Grupos, ] + ;
					  [From SigOpCdc o Inner Join SigMvHst a On a.Dopes = o.Dopes ] + ;
		lStrQuery = [Select EmpGruEsts, OriDopNums, Emps, Grupos, Estos, CPros, Datas, Qtds, ] + ;
					  [From SigMvHst ] + ;
	If ThisForm.poDataMgr.SQLExecute(lStrQuery,'TmpHis') < 1
	Select TmpHis
Select CsTempo
	loBarraInv.Update(.T.,'Estoque: ' + CsTempo.grupos + ' / ' + CsTempo.estos + ' -  Produto: ' + CsTempo.cpros)
				Select SigMvHst
								lStrQuery = [Select EmpDopNums, CPros, AliqICMS ] + ;
											  [From SigMvItn ]+;
								If ThisForm.poDataMgr.SQLExecute(lStrQuery,'crLclMvItn') < 1
								Select crLclMvItn
							Insert Into CsInventario From MemVar
						Select SigMvHst
						Insert Into CsInventario From MemVar
					Insert Into CsInventario From MemVar
				Select TmpHis
					Select TmpHis
								lStrQuery = [Select EmpDopNums, CPros, AliqICMS ] + ;
											  [From SigMvItn ]+;
								If ThisForm.poDataMgr.SQLExecute(lStrQuery,'crLclMvItn') < 1
							Insert Into csInventario From MemVar
						Select TmpHis
						Insert Into csInventario From MemVar
					Insert Into csInventario From MemVar
				Select SigMvHst
								lStrQuery = [Select EmpDopNums,CPros,AliqICMS ]+;
											[From SigMvItn ]+;
								If ThisForm.poDataMgr.SQLExecute(lStrQuery,'crLclMvItn') < 1
								Select crLclMvItn
							Insert Into CsInventario From MemVar
						Select SigMvHst
						Insert Into CsInventario From MemVar
					Insert Into CsInventario From MemVar
				Select TmpHis
						If TmpHis.Opers = 'E' And TmpHis.Units > 0 AND TmpHis.Peps = 1 &&SEEK(TmpHis.Dopes,'CrSigOpCdc') AND CrSigOpCdc.Peps = 1
								lStrQuery = [Select EmpDopNums, CPros, AliqICMS ] + ;
											  [From SigMvItn ]+;
								If ThisForm.poDataMgr.SQLExecute(lStrQuery,'crLclMvItn') < 1
								Select crLclMvItn
							Insert Into CsInventario From MemVar
						Select TmpHis
						Insert Into CsInventario From MemVar
					Insert Into CsInventario From MemVar
	Select csTempo
	Select ClFiscals, CPros, lCPros, Emps, Grupos, Estos, CUnis, VlVenda, ;
	  From csInventario ;
	Select csInvent2
		loBarraInv.Update(.T.)
		Insert Into csTempo From MemVar
		Select csInvent2
	Select ClFiscals, CPros, lCPros, Emps, Grupos, Estos, CUnis, VlVenda, ;
	  From csTempo ;
=Seek(lcEmpLiv,'CrSigCdEmp','CEmps')
=Seek(lcEmpLiv,'CrSlvEmp','CEmps')
		Insert Into CsCabecalho (UniVals,TotVals) Values ('VlCusto','TotCusto')
		Insert Into CsCabecalho (UniVals,TotVals) Values ('VlMedio','TotMedio')
		Insert Into CsCabecalho (UniVals,TotVals) Values ('VlVenda','TotVenda')
If ThisForm.poDataMgr.SQLExecute([Select Codigos,Descs From SigCdGpr ],'CrSigCdGpr') < 1
Select CrSigCdGpr
If ThisForm.poDataMgr.SQLExecute([Select CGrus,Mercs,TipoEstos,Invents From SigCdGrp ],'CrSigCdGrp') < 1
Select CrSigCdGrp
If ThisForm.poDataMgr.SQLExecute([Select CGrus,Codigos,Descricaos,CGrus+Codigos as GruCods From SigCdPsg ],'CrSigCdPsg') < 1
Select CrSigCdPsg
If ThisForm.poDataMgr.SQLExecute([Select Linhas,TpCustos,TpVendas From SigCdLin ],'CrSigCdLin') < 1
Select CrSigCdLin
	Select CrSigCdEmp
		loBarraEmp.Update(.T.,'Empresa: ' + CrSigCdEmp.CEmps + ' - ' + CrSigCdEmp.Razas)
				Select * From CsTempo Into Cursor CsTemporario ReadWrite
				Select CsTempo
					Insert Into CsTemporario From MemVar
					Select CsTempo
	Select * From CsTempo Into Cursor CsTemporario ReadWrite
	Select GGrupo,Sum(&lcCampo * Indice) As Total ;
	From CsTemporario ;
	Select GGrupo,Sum(&lcCampo * cotacao) As Total ;
	From CsTemporario ;
Select TmpGGrupo
		Insert Into CsTemporario (Ps,Ps2,CPros,TotCusto,GGrupo,DPros) ;
Insert Into CsTemporario (Ps,Ps2,CPros,TotCusto,GGrupo,DPros) ;
Select CsTemporario
lStrQuery = [Select CEmps,Razas,Cidas,RazSocs,Endes,Cidas,IEs,CGCs,Ativas ]+;
			[From SigCdEmp ]+;
If ThisForm.poDataMgr.SQLExecute(lStrQuery,'CrSigCdEmp') < 1
Select CrSigCdEmp
lStrQuery = [Select a.CEmps,a.Estas,b.Estados,b.AICMS ]+;
			[From SigCdEmp a, SigCdUfs b ]+;
If ThisForm.poDataMgr.SQLExecute(lStrQuery,'CrAliq') < 1
Select CrAliq
If ThisForm.poDataMgr.SQLExecute([Select GrPadVens From SigCdPam ],'CrSigCdPam') < 1
If ThisForm.poDataMgr.SQLExecute([Select * From SigCdMoe ],'CrSigCdMoe') < 1
If ThisForm.poDataMgr.SQLExecute([Select Dopes,Peps From SigOpCdc ],'CrSigOpCdc') < 1
SELECT CrSigOpCdc
Select CrSigCdMoe
If ThisForm.poDataMgr.SQLExecute([Select * From SigCdCot ],'CrSigCdCot') < 1
Select CrSigCdCot
If ThisForm.poDataMgr.SQLExecute([Select CMoes,DMoes From SigCdMoe Where Cotas = 1 ],'TmpMoe') < 1
Select TmpMoe
lStrQuery = [Select Codigos, TipoInvs From SigCdGcr]
If ThisForm.poDataMgr.SQLExecute(lStrQuery,'TmpGccr1') < 1
lStrQuery = [Select CEmps, RazSocs as Razas, Endes, Cidas, Space(15) as NIRCs, ?ldDatas as DRegs, ] + ;
			  [From SigCdEmp]
If ThisForm.poDataMgr.SQLExecute(lStrQuery,'CrSlvEmp') < 1
Select CrSlvEmp
Select CrSigCdEmp
If Seek(_Empr,'CrSigCdEmp','CEmps')
Select CrSigCdEmp
=Seek(lcEmpLiv,'CrSigCdEmp','CEmps')
=Seek(lcEmpLiv,'CrSlvEmp','CEmps')
Insert Into TmpTermo (TermoAbre,TermoFecha) ;
Select TmpTermo
Select TmpTermo
=Seek(lcEmpLiv,'CrSigCdEmp','CEmps')
=Seek(lcEmpLiv,'CrSlvEmp','CEmps')
Insert Into TmpTermo (TermoAbre,TermoFecha) ;
		Select TmpTermo
		Select TmpTermo
lStrQuery = [Select a.Codigos ]+;
			[From SigCdGcr a, SigCdCli b ]+;
If ThisForm.poDataMgr.SQLExecute(lStrQuery,'TmpGccr') < 1
Select TmpGccr
lStrQuery = [Select a.Codigos ]+;
			[From SigCdGcr a, SigCdCli b ]+;
If ThisForm.poDataMgr.SQLExecute(lStrQuery,'TmpGccr') < 1
Select TmpGccr
	Select CsTemporario
		SELECT cpros,TipoInvs,vlcusto, dpros, clfiscals, cunis, SUM(sqtds) as sqtds from CsTemporario where !EMPTY(tipoinvs) group by cpros,TipoInvs,vlcusto, dpros, clfiscals, cunis order by cpros into cursor cur1
		SELECT cur1
	If ThisForm.poDataMgr.SQLExecute([Select CMoes,DMoes From SigCdMoe],'TmpMoe2') < 1
	Select TmpMoe2
	If Seek(This.Value,'TmpMoe2','CMoes')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReInv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1639 linhas total):

*-- Linhas 1418 a 1436:
1418: 
1419:             IF loc_oBusca.this_lSelecionou
1420:                 IF USED("cursor_4c_BuscaEmpresa")
1421:                     SELECT cursor_4c_BuscaEmpresa
1422:                     loc_cCodigo    = ALLTRIM(CEmps)
1423:                     loc_cDescricao = ALLTRIM(Razas)
1424:                     THIS.txt_4c_CdEmpresa.Value = loc_cCodigo
1425:                     THIS.txt_4c_DsEmpresa.Value = loc_cDescricao
1426:                     THIS.txt_4c_CdEmpresa.Refresh()
1427:                     THIS.txt_4c_DsEmpresa.Refresh()
1428:                 ENDIF
1429:             ENDIF
1430: 
1431:             IF USED("cursor_4c_BuscaEmpresa")
1432:                 USE IN cursor_4c_BuscaEmpresa
1433:             ENDIF
1434:             loc_oBusca.Release()
1435: 
1436:         CATCH TO loc_oErro

*-- Linhas 1455 a 1473:
1455: 
1456:             IF loc_oBusca.this_lSelecionou
1457:                 IF USED("cursor_4c_BuscaMoeda")
1458:                     SELECT cursor_4c_BuscaMoeda
1459:                     loc_cCodigo    = ALLTRIM(CMoes)
1460:                     loc_cDescricao = ALLTRIM(DMoes)
1461:                     THIS.txt_4c_Moeda.Value     = loc_cCodigo
1462:                     THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
1463:                     THIS.txt_4c_Moeda.Refresh()
1464:                     THIS.txt_4c_MoedaDesc.Refresh()
1465:                 ENDIF
1466:             ENDIF
1467: 
1468:             IF USED("cursor_4c_BuscaMoeda")
1469:                 USE IN cursor_4c_BuscaMoeda
1470:             ENDIF
1471:             loc_oBusca.Release()
1472: 
1473:         CATCH TO loc_oErro

*-- Linhas 1492 a 1510:
1492: 
1493:             IF loc_oBusca.this_lSelecionou
1494:                 IF USED("cursor_4c_BuscaMoeDesc")
1495:                     SELECT cursor_4c_BuscaMoeDesc
1496:                     loc_cCodigo    = ALLTRIM(CMoes)
1497:                     loc_cDescricao = ALLTRIM(DMoes)
1498:                     THIS.txt_4c_Moeda.Value     = loc_cCodigo
1499:                     THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
1500:                     THIS.txt_4c_Moeda.Refresh()
1501:                     THIS.txt_4c_MoedaDesc.Refresh()
1502:                 ENDIF
1503:             ENDIF
1504: 
1505:             IF USED("cursor_4c_BuscaMoeDesc")
1506:                 USE IN cursor_4c_BuscaMoeDesc
1507:             ENDIF
1508:             loc_oBusca.Release()
1509: 
1510:         CATCH TO loc_oErro

*-- Linhas 1530 a 1548:
1530: 
1531:             IF loc_oBusca.this_lSelecionou
1532:                 IF USED("cursor_4c_BuscaMoeFat")
1533:                     SELECT cursor_4c_BuscaMoeFat
1534:                     loc_cCodigo = ALLTRIM(CMoes)
1535:                     THIS.txt_4c_MoeFator.Value = loc_cCodigo
1536:                     THIS.txt_4c_MoeFator.Refresh()
1537: 
1538:                     loc_dData = IIF(THIS.opt_4c_Posicao.Value = 1, DATE(), THIS.txt_4c_DataSaldo.Value)
1539:                     IF VARTYPE(THIS.this_oRelatorio) = "O"
1540:                         loc_nValFat = THIS.this_oRelatorio.CarregarCambio(loc_cCodigo, loc_dData)
1541:                         THIS.txt_4c_ValFator.Value = loc_nValFat
1542:                         THIS.txt_4c_ValFator.Refresh()
1543:                     ENDIF
1544:                 ENDIF
1545:             ENDIF
1546: 
1547:             IF USED("cursor_4c_BuscaMoeFat")
1548:                 USE IN cursor_4c_BuscaMoeFat

