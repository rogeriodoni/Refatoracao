# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GESIND' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PNCHKCONVERSAO1, 0, CODIGOS, ICLIS, PS, EMPS, CPROS, TPCUSTOS, TPVENDAS, LNLOCALI, LNBARRAS, LNVENDA, LNCUSTO, TIPOS, LOCALIS, CBARS, CRTOTA, CEMPS

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
		lcMcrSql1 = [select a.cmoes from SigCdMoe a inner join SigCdCot b on b.cmoes=a.cmoes where 0=1 order by 1]
			lcMcrSql1 = [select a.cmoes,a.cotas,a.moeqs,a.qtdeqs from SigCdMoe a order by 1]
				Select ('crSigCdMoe') 
			lcMcrSql1 = [select a.cmoes,a.datas,a.horas,a.valos from SigCdCot a order by 1 asc,2 desc,3 desc]
				Select ('crSigCdCot') 
		If (Seek(lcMoedaConv1,'crSigCdMoe','cmoes') And Not IsEmpty(crSigCdMoe.Moeqs))
		If (Seek(lcMoedaBase1,'crSigCdMoe','cmoes') And Not IsEmpty(crSigCdMoe.Moeqs))
Select csSigCdBal
m.lcMcrSql1 = [Select Descrs From SigCdGcr Where Codigos='] + csSigCdBal.Grupos + [' Order by 1]
	m.lnErro1 = Thisform.poDataMgr.SQLExecute(m.lcMcrSql1, 'crTmpGccr1')
m.lcMcrSql1 = [Select Rclis From SigCdCli Where Iclis='] + csSigCdBal.Contas + [' Order by 1]
	m.lnErro1 = Thisform.poDataMgr.SQLExecute(m.lcMcrSql1, 'crTmpCli1')
m.lcMcrSql1 = [Select cPros, pVens, MoeVs, 99999999.99 as nVendConv1s, CustoFs, MoeCusFs, 99999999.99 as nCustConv1s From SigCdPro Order by 1]
	m.lnErro1 = Thisform.poDataMgr.SQLExecute(m.lcMcrSql1, 'crSigCdPro')
Select crSigCdPro
Select crSigCdPro
Locate For .F. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
Select Base
	= Seek(Base.cpros, 'crSigCdPro', 'cPros')
Insert Into crRel1 From Memvar
Insert Into crRel1 From Memvar
Insert Into crRel1 From Memvar
Insert Into crRel1 From Memvar
Insert Into crRel1 From Memvar
Insert Into crRel1 From Memvar
	Select CsRelatorio
			Delete File (lcArquivo)
Insert Into CsCabecalho (ImpImagem) Values (llImg)
Select CrBranco
Append Memo Branco From (lcBrancos) OverWrite
Select CsSigCdBal
lcDsGrupo = Iif(Seek(m.Grupos,'CrSigCdGcr','Codigos'),Alltrim(CrSigCdGcr.descrs),'')
If ThisForm.poDataMgr.SqlExecute([Select iclis,rclis From SigCdCli Where iclis = ']+m.Contas+[' ],'TmpCli') < 1
Select TmpCli
Insert Into CsFiltro From MemVar
		lStrQuery = [Select a.Emps,a.Codigos,a.CPros,a.CodCors,a.CodTams,a.Grupos,a.Contas,a.Saldos,a.Lidos,a.Relidos,]+;
					[From SigIvTrB a, SigCdPro b ]+;
					[Left Join SigCdUni c On c.CUnis = b.CUnis ]+;
					[Left Join SigCdLin d On d.Linhas = b.Linhas ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'Base') < 1
		Select Base
			Select Base
			lStrQuery = [Select CPros, CodCors, CodTams, Contas, CBars, Tipos, Qtds, Localis, Pesos, PesReals ] + ;
						[From SigIvTrH ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrTmpHist') < 1)
			Select CrTmpHist
				oProg.Update(.T.)
				If !Seek(CrTmpHist.CPros + CrTmpHist.CodCors + CrTmpHist.Codtams + CrTmpHist.Contas,'Base','CPros')
					Insert Into Base (CPros,CodCors,CodTams,Contas,Emps,Codigos,Localis) ;
			Select Base
			Select a.Emps,a.Codigos,a.CPros,a.CodCors,a.CodTams,a.Grupos,a.Contas,a.Saldos,a.Lidos,a.Relidos,a.CustoFs,;
			From Base a ;
			Select CsBase
			Select * From CsBase Into Cursor CsRelatorio ReadWrite
			Select CsRelatorio
				Select CsRelatorio
	        Select a.Moecusfs as Moedas, Val(Str(Sum(a.CustoFs),16,2)) as CustoFs, 0000000000000000.00 as PVens, 0000000000000000.00 as PVenPesos ;
			  From CsRelatorio  a ;
			Select a.MoeVs as Moedas, 0000000000000000.00 as CustoFs, Val(Str(Sum(a.PVens),16,2)) as PVens, Val(Str(Sum(a.PVenPesos),16,2)) as PVenPesos ;
			  From CsRelatorio a ;
	        Select CsRelatorio
				Select CsRelatorio
					Insert Into CsResult From MemVar
					lStrQuery = [Select Distinct Localis From SigIvTrH ]+;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsLocalis') < 1
					Select CsLocalis
					Select CsResult
					Select CsRelatorio
			Select CrSMoeda
	        Select Moedas, Sum(CustoFs) as CustoFs, Sum(Pvens) as PVens ;
	          From crSMoeda ;
	 		Select TmpMoeda
				Insert Into CsRelatorio (TcCabecs,TcTraco1s,TcLinhas,Ps,CGrus,IFors) ;
		lStrQuery = [Select Emps,Codigos,CPros,Saldos,SaldoPs From SigIvTrB ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsSaldo') < 1
        Select CsSaldo
		lStrQuery = [Select *, ' ' As PS, Space(8) as OrdImg, Space(40) as Reffs From SigIvTrH ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsRelatorio') < 1
		lStrQuery = [Select a.Emps,a.Codigos,a.CBars,a.CPros,a.Contas,b.DPros,b.CGrus,b.Sgrus,b.pvens,b.Reffs ] + ;
					  [From SigIvTrE a ] + ;
					 [Inner Join SigCdPro b On a.Cpros = b.Cpros ] + ;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsEtiqueta') < 1
		Select CsEtiqueta
		lStrQuery = [Select a.Emps,a.Codigos,a.CBars,a.CPros,a.Contas,b.DPros,b.CGrus,b.Sgrus,b.pvens,b.Reffs ] + ;
					  [From SigIvTrH a ] + ;
					 [Inner Join SigCdPro b On a.Cpros = b.Cpros ] + ;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsHistorico') < 1
		Select CsHistorico
		Select CsEtiqueta
			If !Seek(CsEtiqueta.CBars,'CsHistorico','CBars')
				Insert Into CsRelatorio (Contas, CBars, CPros, Tipos, Dpros, Cgrus, Sgrus, Pvens, Reffs) ;
		Select CsHistorico
			If !Seek(CsHistorico.Cbars,'CsEtiqueta','CBars')
				Insert Into CsRelatorio (Contas, CBars, CPros, Tipos, Dpros, Cgrus, Sgrus, Pvens, Reffs) ;
	Select csRelatorio
        Insert Into csRelatorio5 (Ps, Mercs, CGrus, CPros, CBars, CodCors, CodTams, Dpros, Custos, ;
	Select Ps, MoeCusFs, Sum(Custos) as Custos From csRelatorio5 Group By Ps, MoeCusFs Into Cursor crTotais
	Select crTotais
		Update csRelatorio5 Set Totais = Alltrim(Totais) + Iif(Empty(Totais), [], [ | ]) + ;
		Select csRelatorio5
		Select crRel1
		Select csRelatorio5
		Select CsRelatorio
			Select CsResult
			Select CsRelatorio
	Select CsRelatorio
		lcQuery = [Select FigJpgs ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
If ThisForm.poDataMgr.SqlExecute([Select GesInd, TpInstalas, moedaps From SigCdPam ],'CsSigCdPam') < 1
Select CsSigCdPam
If ThisForm.poDataMgr.SqlExecute([Select CEmps,Razas From SigCdEmp Where CEmps = ']+_Empr+[' ],'CrSigCdEmp') < 1
Select CrSigCdEmp
If ThisForm.poDataMgr.SqlExecute([Select Codigos,Descrs From SigCdGcr ],'CrSigCdGcr') < 1
Select CrSigCdGcr
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdBal Where Emps = ?_Empr And Codigos = ?lnNumBal ],'CsSigCdBal') < 1
Select CsSigCdBal

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIr1.prg) - TRECHOS RELEVANTES PARA PASS SQL (1688 linhas total):

*-- Linhas 1140 a 1158:
1140:             IF !USED("CsSigCdPam")
1141:                 RETURN
1142:             ENDIF
1143:             SELECT CsSigCdPam
1144:             GO TOP
1145:             IF !EOF() AND CsSigCdPam.GesInd = 1
1146:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
1147:                 loc_oPg.obj_4c_TipoOrdem.Visible       = .F.
1148:                 loc_oPg.obj_4c_OptgDescricao.Visible   = .F.
1149:                 loc_oPg.obj_4c_OptgBarras.Visible      = .F.
1150:                 loc_oPg.obj_4c_OptgLocalizacao.Visible = .F.
1151:                 loc_oPg.lbl_4c_LblOrdem.Visible        = .F.
1152:                 loc_oPg.lbl_4c_LblDescricao.Visible    = .F.
1153:                 loc_oPg.lbl_4c_LblBarras.Visible       = .F.
1154:                 loc_oPg.lbl_4c_LblLocalizacao.Visible  = .F.
1155:             ENDIF
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message, "Erro AplicarRegraGesInd")
1158:         ENDTRY

*-- Linhas 1361 a 1382:
1361:             THIS.AtualizarReadOnly()
1362:             RETURN
1363:         ENDIF
1364:         loc_cSQL    = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cValor)
1365:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProVal")
1366:         IF loc_nResult > 0
1367:             SELECT cursor_4c_ProVal
1368:             IF !EOF()
1369:                 loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_ProVal.DPros)
1370:             ELSE
1371:                 loc_oPg.txt_4c__ds_codigo.Value = ""
1372:                 THIS.AbrirBuscaCdCodigo()
1373:             ENDIF
1374:         ELSE
1375:             loc_oPg.txt_4c__ds_codigo.Value = ""
1376:             THIS.AbrirBuscaCdCodigo()
1377:         ENDIF
1378:         IF USED("cursor_4c_ProVal")
1379:             USE IN cursor_4c_ProVal
1380:         ENDIF
1381:         THIS.AtualizarReadOnly()
1382:     ENDPROC

*-- Linhas 1481 a 1502:
1481:             THIS.AtualizarReadOnly()
1482:             RETURN
1483:         ENDIF
1484:         loc_cSQL    = "SELECT codigos, descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cValor)
1485:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclVal")
1486:         IF loc_nResult > 0
1487:             SELECT cursor_4c_LclVal
1488:             IF !EOF()
1489:                 loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_LclVal.descricaos)
1490:             ELSE
1491:                 loc_oPg.txt_4c__Dlocal.Value = ""
1492:                 THIS.AbrirBuscaLocal()
1493:             ENDIF
1494:         ELSE
1495:             loc_oPg.txt_4c__Dlocal.Value = ""
1496:             THIS.AbrirBuscaLocal()
1497:         ENDIF
1498:         IF USED("cursor_4c_LclVal")
1499:             USE IN cursor_4c_LclVal
1500:         ENDIF
1501:         THIS.AtualizarReadOnly()
1502:     ENDPROC

