# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (12)
- [GRID-SQL] Campo 'Cemps' usado em ControlSource de cursor_4c_Distribui mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtdSaldo' usado em ControlSource de cursor_4c_Distribui mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtdDistr' usado em ControlSource de cursor_4c_Distribui mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'CidChaves' usado em ControlSource de cursor_4c_Distribui mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Cpros' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Dpros' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'CodCors' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'CodTams' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Sqtds' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtdSaida' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtdSaldo' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODIGOS, DATAS, TPCADS, EMPDOPNUMS, CITENS, SQTDS, NMARCA, CGRUS, QTDDISTR, QTDSALDO, GRUPOS, ESTOS, EMPS, CONTAS, CODCORS, CODTAMS, XBAIXA, ORIGEMS, DOPES

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
Select crDistribui
	Select crDistribui
Select crSigPrDis
If Not ThisForm.poDataMgr.Update('crSigPrDis')
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrDis Where Codigos = ?_Codigo], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigPrDis')
		lcQueryLista = [Select Distinct Codigos, Datas from SigPrDis where Datas Between ?ldDatai And ?ldDataF]
		lcQueryPrDis = [Select * from SigPrDis where Codigos = ?_Codigo]
		lcSql = [Select * From SigCdPac ]
		.poDataMgr.Sqlexecute(lcsql,'crSigCdPac')
		lcSql = [select a.cmoes,a.datas,a.horas,a.valos from SigCdCot a order by 1 asc,2 desc,3 desc]
		.poDataMgr.Sqlexecute(lcsql,'crSigCdCot')
lcQuery = [Select 0 as nMarca, * From SigCdCeg Where TpCads = 3]
If ThisForm.PodataMgr.SqlExecute(lcquery,'crSigCdCeg') < 1
lcQuery = [Select b.* from (Select Distinct a.EmpDopNums from SigPrDis a Where a.Codigos = ?_Codigo And a.EmpDopNums <> '') a Inner Join SigMvCab b On a.EmpDopNums = b.EmpDopNums]
If thisform.podatamgr.SqlExecute(lcQuery, [crCabOpera] ) < 1
	MessageBox( [Problemas no Select dos Produtos com Saldo], 48, [Atenção] )
lcQuery = [Select b.*, c.CodCors, c.CodTams from (Select Distinct a.EmpDopNums from SigPrDis a Where a.Codigos = ?_Codigo And a.EmpDopNums <> '') a Inner Join SigMvItn b On a.EmpDopNums = b.EmpDopNums ] +;
			[Inner Join SigMvIts c On b.EmpDopNums = c.EmpDopNums And b.Citens = c.Citens]
If thisform.podatamgr.SqlExecute(lcQuery, [crItnOpera] ) < 1
	MessageBox( [Problemas no Select dos Produtos com Saldo], 48, [Atenção] )
Select crCabOpera
	Select TmpSigPrDis
			Select a.EmpGruEsts, Substr(a.EmpGruEsts,1,3) as Emps, Substr(a.EmpGruEsts,4,10) as Grupos, Substr(a.EmpGruEsts,14,10) as Contas, 1 as nMarca, b.Priors ;
				from crSigPrDis a Inner Join crSigCdCeg b On Substr(a.EmpGruEsts,1,3) + Substr(a.EmpGruEsts,4,10) + Substr(a.EmpGruEsts,14,10) = b.Emps + b.Grupos + b.Contas ;
			Select crSigCdCeg
				Select a.CPros, b.Dpros, a.CodCors, a.CodTams, Sum(a.SQtds) as Sqtds, 0000000 As QtdSaida, Sum(a.SQtds) As QtdSaldo, b.Cgrus, b.Sgrus
				From SigMvEst a, SigCdpro b
			If thisform.podatamgr.SqlExecute(lcSQL, [crDisponivel] ) < 1
				MessageBox( [Problemas no Select dos Produtos com Saldo], 48, "Atenção" )
					Select b.cEmps, Case When d.SQtds is null Then 0000000 Else d.Sqtds End As QtdSaldo, 0000000 As QtdDistr,
					from (Select Distinct a.CPros, a.CodCors, a.CodTams From SigMvEst a
					Inner Join SigCdEmp b On b.cEmps not in <<lcEmps>>
					Inner Join SigCdOpe c On b.DirColOuts = c.Dopes
					Left Join SigMvEst d On d.EmpGruEsts = b.cEmps + c.GruDests + c.ConDests And d.CPros + d.CodCors + d.CodTams = a.CPros + a.CodCors + a.CodTams
				If thisform.podatamgr.SqlExecute(lcQuery, [crDistribui] ) < 1
					MessageBox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
				lcQuery = [Select a.EmpDs as cEmps, 0000000 as QtdSaldo, a.Qtds as QtdDistr, a.Locals, a.CPros, a.CodCors, a.CodTams, a.QtdOs, b.Dpros, b.cgrus, b.sgrus ] +;
							[from SigPrDis a Inner Join SigCdPro b On a.Cpros = b.Cpros where a.codigos = '] + _Codigo + [' And a.Cpros <> '']
				If thisform.podatamgr.SqlExecute(lcQuery, [crDistribui2] ) < 1
					MessageBox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
				Select crDistribui2
					Select crDistribui
						Select crDistribui2
						Insert into crDistribui from Memvar
				lcQuery = [Select a.EmpDs as cEmps, 0000000 as QtdSaldo, a.Qtds as QtdDistr, a.Locals, a.CPros, a.CodCors, a.CodTams, a.QtdOs, b.Dpros, b.cgrus, b.sgrus ] +;
							[from SigPrDis a Inner Join SigCdPro b On a.Cpros = b.Cpros where a.codigos = '] + _Codigo + [' And a.Cpros <> '']
				If thisform.podatamgr.SqlExecute(lcQuery, [crDistribui] ) < 1
					MessageBox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
				Select a.CPros, a.Dpros, a.CodCors, a.CodTams, ;
				from crDisponivel a Inner Join (Select Max(QtdOs) as QtdOs, Sum(QtdDistr) as QtdDistr, CPros, CodCors, CodTams From crDistribui Group By CPros, CodCors, CodTams) b ;
				Select crDistribui2
					Select crDisponivel
						Select crDistribui2
						Insert into crDisponivel from Memvar
				Select Distinct Cpros, Dpros, CodCors, CodTams, QtdOs as Sqtds, 0000000 as QtdSaida, 0000000 as QtdSaldo, Cgrus, Sgrus from crDistribui into cursor crDisponivel ReadWrite
			Select crDistribui
			Select crDisponivel
thisform.pagina.dados.pageframe1.page1.grdEstoque.column1.ControlSource = [crSigCdCeg.nMarca]
thisform.pagina.dados.pageframe1.page1.grdEstoque.column2.ControlSource = [crSigCdCeg.Emps]
thisform.pagina.dados.pageframe1.page1.grdEstoque.column3.ControlSource = [crSigCdCeg.Grupos]
thisform.pagina.dados.pageframe1.page1.grdEstoque.column4.ControlSource = [crSigCdCeg.Contas]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column2.ControlSource = [crCabOpera.Emps]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column3.ControlSource = [crCabOpera.Dopes]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column4.ControlSource = [crCabOpera.Numes]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column5.ControlSource = [crCabOpera.EmpDs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column6.ControlSource = [crCabOpera.GrupoOs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column7.ControlSource = [crCabOpera.ContaOs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column8.ControlSource = [crCabOpera.GrupoDs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column9.ControlSource = [crCabOpera.ContaDs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column1.ControlSource = [crItnOpera.Citens]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column2.ControlSource = [crItnOpera.CPros]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column3.ControlSource = [crItnOpera.Dpros]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column8.ControlSource = [crItnOpera.CodCors]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column9.ControlSource = [crItnOpera.CodTams]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column4.ControlSource = [crItnOpera.CUnis]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column5.ControlSource = [crItnOpera.Qtds]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column6.ControlSource = [crItnOpera.Units]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column7.ControlSource = [crItnOpera.totas]
Select TmpSigPrDis
		Select crSigPrDis
		Select crDisponivel
		Select crDistribui
				Insert Into crSigPrDis (Codigos, Datas, CidChaves, Cpros, CodCors, CodTams, EmpDopNums, Qtds, EmpDs, Locals ) Values ;
				Select crDisponivel
	Select crSigCdCeg
			Insert Into crSigPrDis (CidChaves, Datas, Codigos, EmpGruEsts, Usuars) Values ;
Update crSigCdCeg Set nMarca = 1
Update crSigCdCeg Set nMarca = 0
Select crSigCdceg
Select 0
Select crSigCdCeg
	Select a.CPros, b.Dpros, a.CodCors, a.CodTams, Sum(a.SQtds) as Sqtds, 0000000 As QtdSaida, Sum(a.SQtds) As QtdSaldo, b.Cgrus, b.Sgrus
	From SigMvEst a, SigCdpro b
If thisform.podatamgr.SqlExecute(lcSQL, [crDisponivel] ) < 1
	MessageBox( [Problemas no Select dos Produtos com Saldo], 48, "Atenção" )
	Select b.cEmps, Case When d.SQtds is null Then 0000000 Else d.Sqtds End As QtdSaldo, 0 As QtdDistr, Space(10) as Locals, a.CPros, a.CodCors, a.CodTams, c.Dopes
	from (Select Distinct a.CPros, a.CodCors, a.CodTams From SigMvEst a
	Inner Join SigCdEmp b On b.cEmps not in <<lcEmps>>
	Inner Join SigCdOpe c On b.DirColOuts = c.Dopes
	Left Join SigMvEst d On d.EmpGruEsts = b.cEmps + c.GruDests + c.ConDests And d.CPros + d.CodCors + d.CodTams = a.CPros + a.CodCors + a.CodTams
If thisform.podatamgr.SqlExecute(lcSQL, [crDistribui] ) < 1
	MessageBox( [Problemas no Select dos Produtos Distribuidos], 48, "Atenção" )
Select crDistribui
Select crDisponivel
m.SelectPro   = [Select a.cpros,a.cgrus,a.dpros,a.sgrus,a.cunis,a.cunips,a.ifors,a.reffs,a.qmins,a.valors,a.moedas,a.icms,]+;
				[From SigCdPro a ]+;
				[Left Join SigCdGrp g On a.cgrus = g.cgrus ]+;
				[Left Join SigCdUni u On a.cunis = u.cunis ]+;
				[Left Join SigCdCol b On a.colecoes = b.colecoes ]+;
				[Left Join SigCdLin l On a.linhas = l.linhas ]+;
				[Left Join SigPrFti f On a.cftios = f.cods ]+;
				[Left Join SigCdCli c On a.ifors = c.iclis ]+;
				[Left Join SigCdGpr h On a.Mercs= h.codigos ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(m.SelectPro,'crSidCdPro')
Select crSidCdPro
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select s.codigos,s.descricaos ]+;
				  [From SigCdPsg s ]+;
	Select crSidCdPro
		Select CrSigCdCot
		Select CrSigCdCot
Select crDisponivel
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
Select crDisponivel
	Select crDisponivel
Select crItnOpera
Select crDistribui
Select crDisponivel
Select crSigCdCeg
		Select CrSigTempd
	Select CrSigTempd
If !ThisForm.Podatamgr2.UpDate('CrSigTempd')
lcQuery = [Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ]+;
		[Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ] +;
If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpEstoque') < 1
Select crSigPrDis
Select crSigMvCab
Select crSigMvItn
Select crSigMvIts
Select crSigMvHst
Select crSigOpEtq
Select crSigCdMlc
Select TmpEstoque
	Insert Into TmpSaldg ( Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps );
Select crDistribui
		Select TmpSaldG
		=Seek(crDistribui.Cpros + crDistribui.CodCors + crDistribui.CodTams)
				Insert Into TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Grupos, Estos, Estoque, EmpDs, Locals ) Values ;
					Insert Into TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Grupos, Estos, Estoque, EmpDs, Locals ) Values ;
Select crDisponivel
Select TmpEstoque
	Select TmpEstoque
		Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
	Insert Into crSigMvItn (Emps, Dopes, Numes, EmpDopNums, CPros, Qtds, Cunis, Pesos, CuniPs, DPros, Opers, cItens, CidChaves, DtAlts, Locals, Moedas, SitTrIcms) ;
	Select crSigMvItn
	Select crDisponivel
	Insert Into crSigPrDis from Memvar
	Select TmpEstoque
		Insert Into crSigMvIts (cItens, Emps, Dopes, Numes, EmpDopNums, CPros, Qtds, Pesos, CodCors, CodTams, QtdEmbs, CidChaves, DtAlts, Locals) ;
			Select crSigMvIts
			Select crSigMvItn
		Insert into crSigOpEtq (cbars,cpros,pesos,qtds,emps,Dopes,numes,datas,empos,obsetiqs, DtMovs, DtBals, DtIncs, Localizas, Grupos, Contas, CodAmss,EmpDopNums, ;
			Insert Into crSigCdMlc (Barras, Codigos, Contas, cpros, Datas, Emps, Grupos, Horas, ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, Opers, Grupos, ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, Opers, Grupos, ;
	Select crSigPrDis
If Not ThisForm.poDataMgr.Update('crSigPrDis')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrDis)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvItn')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvIts')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvIts)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigCdMlc')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdMlc)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigOpEtq')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpEtq)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvHst')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
Select crSigMvCab
	lcQuery = [ Select a.Ndopes, b.chkImpDoc, b.carcompos, b.dckTermos, a.Cmoes, a.TipoNfs, a.Opers ] + ;
			    [ From SigCdOpe a, SigOpCdc b ]+ ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdOpeD]) < 1)
Select * from crSigMvCab into cursor crCabOpera
Select a.*, b.codcors, b.codtams from crSigMvItn a Inner Join crSigMvIts b On a.EmpDopNums = b.EmpDopNums and a.Citens = b.Citens into cursor crItnOpera
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column2.ControlSource = [crCabOpera.Emps]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column3.ControlSource = [crCabOpera.Dopes]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column4.ControlSource = [crCabOpera.Numes]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column5.ControlSource = [crCabOpera.EmpDs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column6.ControlSource = [crCabOpera.GrupoOs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column7.ControlSource = [crCabOpera.ContaOs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column8.ControlSource = [crCabOpera.GrupoDs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgOperacoes.grdCabOperas.column9.ControlSource = [crCabOpera.ContaDs]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column1.ControlSource = [crItnOpera.Citens]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column2.ControlSource = [crItnOpera.CPros]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column3.ControlSource = [crItnOpera.Dpros]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column8.ControlSource = [crItnOpera.CodCors]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column9.ControlSource = [crItnOpera.CodTams]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column4.ControlSource = [crItnOpera.CUnis]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column5.ControlSource = [crItnOpera.Qtds]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column6.ControlSource = [crItnOpera.Units]
thisform.pagina.dados.pageframe1.page3.pgOperacoes.pgItens.grdItnOperas.column7.ControlSource = [crItnOpera.totas]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS SQL (2878 linhas total):

*-- Linhas 395 a 413:
395:             .HighlightBackColor = RGB(255, 255, 255)
396:             .HighlightForeColor = RGB(15, 41, 104)
397:             .HighlightStyle     = 2
398:             .DeleteMark         = .F.
399:             .RecordMark         = .F.
400:             .RowHeight          = 16
401:             .ScrollBars         = 2
402:             .GridLines          = 3
403:             .Visible            = .T.
404:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
405:             .Column1.Width           = 150
406:             .Column2.Header1.Caption = ""
407:             .Column2.Width           = 150
408:         ENDWITH
409: 
410:         *-- BINDEVENTs
411:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
412:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
413:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")

*-- Linhas 587 a 605:
587:             .HighlightBackColor = RGB(255, 255, 255)
588:             .HighlightForeColor = RGB(15, 41, 104)
589:             .HighlightStyle     = 2
590:             .DeleteMark         = .F.
591:             .RecordMark         = .F.
592:             .RowHeight          = 18
593:             .ScrollBars         = 2
594:             .GridLines          = 3
595:             .Visible            = .T.
596:             .Column1.Header1.Caption = ""
597:             .Column1.Width           = 25
598:             .Column2.Header1.Caption = "Empresa"
599:             .Column2.Width           = 80
600:             .Column3.Header1.Caption = "Grupo"
601:             .Column3.Width           = 80
602:             .Column4.Header1.Caption = "Conta"
603:             .Column4.Width           = 80
604:         ENDWITH
605: 

*-- Linhas 677 a 723:
677:                 loc_dDatai  = loc_oPagina.txt_4c_DtInicial.Value
678:                 loc_dDataf  = loc_oPagina.txt_4c_DtFinal.Value
679: 
680:                 loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
681:                            " WHERE CAST(Datas AS DATE) BETWEEN" + ;
682:                            " CAST(" + FormatarDataSQL(loc_dDatai) + " AS DATE)" + ;
683:                            " AND CAST(" + FormatarDataSQL(loc_dDataf) + " AS DATE)"
684: 
685:                 IF USED("cursor_4c_ListaTemp")
686:                     USE IN cursor_4c_ListaTemp
687:                 ENDIF
688:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaTemp")
689: 
690:                 IF loc_nRet < 0
691:                     MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
692:                     loc_lResultado = .F.
693:                 ELSE
694:                     IF USED("cursor_4c_Lista")
695:                         SELECT cursor_4c_Lista
696:                         ZAP
697:                         APPEND FROM DBF("cursor_4c_ListaTemp")
698:                         GO TOP IN cursor_4c_Lista
699:                     ELSE
700:                         SELECT * FROM cursor_4c_ListaTemp INTO CURSOR cursor_4c_Lista READWRITE
701:                     ENDIF
702:                     IF USED("cursor_4c_ListaTemp")
703:                         USE IN cursor_4c_ListaTemp
704:                     ENDIF
705:                     loc_oGrid.ColumnCount = 2
706:                     loc_oGrid.RecordSource            = "cursor_4c_Lista"
707:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.Codigos"
708:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.Datas"
709:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
710:                     loc_oGrid.Column2.Header1.Caption = ""
711:                     loc_oGrid.Column1.Width           = 150
712:                     loc_oGrid.Column2.Width           = 150
713:                     THIS.FormatarGridLista(loc_oGrid)
714:                     loc_lResultado = .T.
715:                 ENDIF
716:             ENDIF
717: 
718:         CATCH TO loc_oErro
719:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
720:             loc_lResultado = .F.
721:         ENDTRY
722: 
723:         RETURN loc_lResultado

*-- Linhas 744 a 786:
744:                     USE IN cursor_4c_EstoqueTemp
745:                 ENDIF
746: 
747:                 loc_cSQL = "SELECT 0 AS nMarca, Emps, Grupos, Contas" + ;
748:                            " FROM SigCdCeg WHERE TpCads = 3 ORDER BY Emps"
749: 
750:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstoqueTemp")
751: 
752:                 IF loc_nRet < 0
753:                     MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
754:                     loc_lResultado = .F.
755:                 ELSE
756:                     SELECT * FROM cursor_4c_EstoqueTemp INTO CURSOR cursor_4c_Estoque READWRITE
757:                     IF USED("cursor_4c_EstoqueTemp")
758:                         USE IN cursor_4c_EstoqueTemp
759:                     ENDIF
760:                     loc_oGrid.ColumnCount = 4
761:                     loc_oGrid.RecordSource = "cursor_4c_Estoque"
762: 
763:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Estoque.nMarca"
764:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Estoque.Emps"
765:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Estoque.Grupos"
766:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Estoque.Contas"
767: 
768:                     loc_oGrid.Column1.chk_4c_nMarca.ControlSource  = "cursor_4c_Estoque.nMarca"
769:                     loc_oGrid.Column2.txt_4c_Empresa.ControlSource  = "cursor_4c_Estoque.Emps"
770:                     loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.Grupos"
771:                     loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.Contas"
772: 
773:                     loc_oGrid.Column1.Header1.Caption = ""
774:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
775:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
776:                     loc_oGrid.Column4.Header1.Caption = "Conta"
777: 
778:                     loc_lResultado = .T.
779:                 ENDIF
780:             ENDIF
781: 
782:         CATCH TO loc_oErro
783:             MsgErro("Erro em CarregarEstoque:" + CHR(13) + loc_oErro.Message, "Erro")
784:             loc_lResultado = .F.
785:         ENDTRY
786: 

*-- Linhas 862 a 919:
862:             RETURN
863:         ENDIF
864: 
865:         SELECT cursor_4c_Lista
866:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
867: 
868:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
869:             THIS.this_cModoAtual = "VISUALIZAR"
870:             THIS.AlternarPagina(2)
871:         ENDIF
872:     ENDPROC
873: 
874:     *==========================================================================
875:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
876:     *==========================================================================
877:     PROCEDURE BtnAlterarClick()
878:         LOCAL loc_cCodigo
879:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
880:             MsgAviso("Nenhum registro selecionado.", "Aviso")
881:             RETURN
882:         ENDIF
883: 
884:         SELECT cursor_4c_Lista
885:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
886: 
887:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
888:             THIS.this_oBusinessObject.EditarRegistro()
889:             THIS.this_cModoAtual = "ALTERAR"
890:             THIS.AlternarPagina(2)
891:         ENDIF
892:     ENDPROC
893: 
894:     *==========================================================================
895:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
896:     *==========================================================================
897:     PROCEDURE BtnExcluirClick()
898:         LOCAL loc_cCodigo
899:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
900:             MsgAviso("Nenhum registro selecionado.", "Aviso")
901:             RETURN
902:         ENDIF
903: 
904:         SELECT cursor_4c_Lista
905:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
906: 
907:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da distribui" + ;
908:                         CHR(231) + CHR(227) + "o " + loc_cCodigo + "?", ;
909:                         "Confirmar Exclus" + CHR(227) + "o")
910:             RETURN
911:         ENDIF
912: 
913:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
914:             IF THIS.this_oBusinessObject.Excluir()
915:                 MsgInfo("Distribui" + CHR(231) + CHR(227) + "o exclu" + ;
916:                         CHR(237) + "da com sucesso.", "")
917:                 THIS.CarregarLista()
918:             ENDIF
919:         ENDIF

*-- Linhas 1252 a 1270:
1252:             .HighlightBackColor = RGB(255, 255, 255)
1253:             .HighlightForeColor = RGB(15, 41, 104)
1254:             .HighlightStyle     = 2
1255:             .DeleteMark         = .F.
1256:             .RecordMark         = .F.
1257:             .RowHeight          = 18
1258:             .ScrollBars         = 2
1259:             .GridLines          = 3
1260:             .Visible            = .T.
1261:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1262:             .Column1.Width           = 90
1263:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1264:             .Column2.Width           = 200
1265:             .Column3.Header1.Caption = "Cor"
1266:             .Column3.Width           = 60
1267:             .Column4.Header1.Caption = "Tam"
1268:             .Column4.Width           = 40
1269:             .Column5.Header1.Caption = "Estoque"
1270:             .Column5.Width           = 70

*-- Linhas 1322 a 1340:
1322:             .HighlightBackColor = RGB(255, 255, 255)
1323:             .HighlightForeColor = RGB(15, 41, 104)
1324:             .HighlightStyle     = 2
1325:             .DeleteMark         = .F.
1326:             .RecordMark         = .F.
1327:             .RowHeight          = 18
1328:             .ScrollBars         = 2
1329:             .GridLines          = 3
1330:             .Visible            = .T.
1331:             .Column1.Header1.Caption = "Empresa"
1332:             .Column1.Width           = 60
1333:             .Column2.Header1.Caption = "Saldo"
1334:             .Column2.Width           = 70
1335:             .Column3.Header1.Caption = "Distribuido"
1336:             .Column3.Width           = 80
1337:             .Column4.Header1.Caption = "Local"
1338:             .Column4.Width           = 90
1339:         ENDWITH
1340: 

*-- Linhas 1635 a 1678:
1635: 
1636:         THIS.TornarControlesVisiveis(loc_oPage)
1637:     ENDPROC
1638: 
1639:     *==========================================================================
1640:     * CarregarDisponivel - Vincula grd_4c_Disponivel ao cursor_4c_Disponivel
1641:     *==========================================================================
1642:     PROTECTED PROCEDURE CarregarDisponivel()
1643:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1644:         loc_lResultado = .F.
1645: 
1646:         TRY
1647:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1648:                 loc_lResultado = .T.
1649:             ELSE
1650:                 IF USED("cursor_4c_Disponivel")
1651:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1652:                 loc_oGrid = loc_oPage.grd_4c_Disponivel
1653: 
1654:                 loc_oGrid.ColumnCount = 7
1655:                 loc_oGrid.RecordSource = "cursor_4c_Disponivel"
1656: 
1657:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Disponivel.Cpros"
1658:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Disponivel.Dpros"
1659:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Disponivel.CodCors"
1660:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Disponivel.CodTams"
1661:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Disponivel.Sqtds"
1662:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1663:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1664: 
1665:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1666:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1667:                 loc_oGrid.Column3.Header1.Caption = "Cor"
1668:                 loc_oGrid.Column4.Header1.Caption = "Tam"
1669:                 loc_oGrid.Column5.Header1.Caption = "Estoque"
1670:                 loc_oGrid.Column6.Header1.Caption = "Saldo"
1671:                 loc_oGrid.Column7.Header1.Caption = "Distribuido"
1672: 
1673:                 THIS.FormatarGridLista(loc_oGrid)
1674:                 loc_oGrid.Refresh()
1675: 
1676:                 THIS.CarregarDistribui()
1677: 
1678:                 loc_lResultado = .T.

*-- Linhas 1686 a 1726:
1686: 
1687:         RETURN loc_lResultado
1688:     ENDPROC
1689: 
1690:     *==========================================================================
1691:     * CarregarDistribui - Vincula grd_4c_Distribui ao cursor_4c_Distribui
1692:     *==========================================================================
1693:     PROTECTED PROCEDURE CarregarDistribui()
1694:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1695:         loc_lResultado = .F.
1696: 
1697:         TRY
1698:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1699:                 loc_lResultado = .T.
1700:             ELSE
1701:                 IF USED("cursor_4c_Distribui")
1702:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1703:                 loc_oGrid = loc_oPage.grd_4c_Distribui
1704: 
1705:                 loc_oGrid.ColumnCount = 4
1706:                 loc_oGrid.RecordSource = "cursor_4c_Distribui"
1707: 
1708:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Distribui.Cemps"
1709:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1710:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1711:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"
1712: 
1713:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1714:                 loc_oGrid.Column2.Header1.Caption = "Saldo"
1715:                 loc_oGrid.Column3.Header1.Caption = "Distribuido"
1716:                 loc_oGrid.Column4.Header1.Caption = "Local"
1717: 
1718:                 THIS.FormatarGridLista(loc_oGrid)
1719:                 loc_oGrid.Refresh()
1720: 
1721:                 loc_lResultado = .T.
1722:                 ENDIF
1723:             ENDIF
1724: 
1725:         CATCH TO loc_oErro
1726:             MsgErro("Erro em CarregarDistribui:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1735 a 1816:
1735:     *==========================================================================
1736:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1737:         LOCAL loc_cCodPro, loc_oPage, loc_oErro
1738: 
1739:         TRY
1740:             IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel") ;
1741:                AND USED("cursor_4c_Distribui")
1742:                 SELECT cursor_4c_Disponivel
1743:                 loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1744:                 SELECT cursor_4c_Distribui
1745:                 SET FILTER TO ALLTRIM(Cpros) = loc_cCodPro
1746:                 GO TOP IN cursor_4c_Distribui
1747:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Distribui.Refresh()
1748:                 THIS.PopularInfoProduto(loc_cCodPro)
1749:             ENDIF
1750: 
1751:         CATCH TO loc_oErro
1752:             MsgErro("Erro em GrdDisponivelAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1753:         ENDTRY
1754:     ENDPROC
1755: 
1756:     *==========================================================================
1757:     * DistribuidoLostFocus - Recalcula saldo ao sair do campo Distribuido
1758:     *==========================================================================
1759:     PROCEDURE DistribuidoLostFocus()
1760:         THIS.CalcularSaldo()
1761:     ENDPROC
1762: 
1763:     *==========================================================================
1764:     * CalcularSaldo - Recalcula QtdSaida e QtdSaldo no cursor_4c_Disponivel
1765:     *==========================================================================
1766:     PROCEDURE CalcularSaldo()
1767:         LOCAL loc_nQtdTotal, loc_cCodPro, loc_oPage, loc_oErro
1768: 
1769:         TRY
1770:             IF !USED("cursor_4c_Disponivel") OR !USED("cursor_4c_Distribui")
1771:                 loc_oErro = .NULL.
1772:             ELSE
1773:                 IF !EOF("cursor_4c_Disponivel")
1774:                     SELECT cursor_4c_Disponivel
1775:                     loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1776: 
1777:                     SUM cursor_4c_Distribui.QtdDistr ;
1778:                         FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
1779:                         TO loc_nQtdTotal
1780: 
1781:                     SELECT cursor_4c_Disponivel
1782:                     REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
1783:                             cursor_4c_Disponivel.QtdSaldo  WITH ;
1784:                                 cursor_4c_Disponivel.Sqtds - loc_nQtdTotal
1785: 
1786:                     IF cursor_4c_Disponivel.QtdSaldo < 0
1787:                         MsgAviso("Saldo insuficiente para movimentar." + CHR(13) + ;
1788:                                  "O valor excede o estoque dispon" + CHR(237) + "vel.", ;
1789:                                  "Saldo Insuficiente")
1790:                         SELECT cursor_4c_Distribui
1791:                         REPLACE cursor_4c_Distribui.QtdDistr WITH 0 FOR ;
1792:                             ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro
1793: 
1794:                         SUM cursor_4c_Distribui.QtdDistr ;
1795:                             FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
1796:                             TO loc_nQtdTotal
1797: 
1798:                         SELECT cursor_4c_Disponivel
1799:                         REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
1800:                                 cursor_4c_Disponivel.QtdSaldo  WITH ;
1801:                                     cursor_4c_Disponivel.Sqtds - loc_nQtdTotal
1802:                     ENDIF
1803: 
1804:                     loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1805:                     loc_oPage.grd_4c_Disponivel.Refresh()
1806:                     loc_oPage.grd_4c_Distribui.Refresh()
1807:                 ENDIF
1808:             ENDIF
1809: 
1810:         CATCH TO loc_oErro
1811:             MsgErro("Erro em CalcularSaldo:" + CHR(13) + loc_oErro.Message, "Erro")
1812:         ENDTRY
1813:     ENDPROC
1814: 
1815:     *==========================================================================
1816:     * LocalDistribuidoValid - Lookup localizacao SigPrLcl (Column4 grdDistribui)

*-- Linhas 1828 a 1861:
1828:                     "Localiza" + CHR(231) + CHR(227) + "o")
1829: 
1830:                 IF VARTYPE(loc_oBusca) = "O"
1831:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1832:                         IF USED("cursor_4c_BuscaLocal")
1833:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1834:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1835:                         ENDIF
1836:                     ELSE
1837:                         IF !loc_oBusca.this_lAchouRegistro
1838:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1839:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1840:                         loc_oBusca.Show()
1841:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
1842:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1843:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1844:                         ENDIF
1845:                     ELSE
1846:                         REPLACE cursor_4c_Distribui.CidChaves WITH ""
1847:                         ENDIF
1848:                     ENDIF
1849:                     loc_oBusca.Release()
1850:                 ENDIF
1851: 
1852:                 IF USED("cursor_4c_BuscaLocal")
1853:                     USE IN cursor_4c_BuscaLocal
1854:                 ENDIF
1855:             ENDIF
1856: 
1857:         CATCH TO loc_oErro
1858:             MsgErro("Erro em LocalDistribuidoValid:" + CHR(13) + loc_oErro.Message, "Erro")
1859:         ENDTRY
1860:     ENDPROC
1861: 

*-- Linhas 2064 a 2129:
2064:     *==========================================================================
2065:     PROCEDURE FiltrarDisponivelClick()
2066:         LOCAL loc_cCodGrp, loc_cCodSgrp, loc_oPage, loc_oErro
2067: 
2068:         TRY
2069:             IF USED("cursor_4c_Disponivel")
2070:                 loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2071:                 loc_cCodGrp  = ALLTRIM(loc_oPage.txt_4c_CodGrupoDist.Value)
2072:                 loc_cCodSgrp = ALLTRIM(loc_oPage.txt_4c_CodSgrupoDist.Value)
2073: 
2074:                 SELECT cursor_4c_Disponivel
2075: 
2076:                 IF EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2077:                     SET FILTER TO
2078:                 ELSE
2079:                     IF !EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2080:                     SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp
2081:                 ELSE
2082:                     IF EMPTY(loc_cCodGrp) AND !EMPTY(loc_cCodSgrp)
2083:                     SET FILTER TO ALLTRIM(Sgrus) = loc_cCodSgrp
2084:                 ELSE
2085:                     SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp ;
2086:                                   AND ALLTRIM(Sgrus) = loc_cCodSgrp
2087:                     ENDIF
2088:                     ENDIF
2089:                 ENDIF
2090: 
2091:                 GO TOP IN cursor_4c_Disponivel
2092:                 loc_oPage.grd_4c_Disponivel.Refresh()
2093:             ENDIF
2094: 
2095:         CATCH TO loc_oErro
2096:             MsgErro("Erro em FiltrarDisponivelClick:" + CHR(13) + loc_oErro.Message, "Erro")
2097:         ENDTRY
2098:     ENDPROC
2099: 
2100:     *==========================================================================
2101:     * ProdutoInicialValid - Navega grd_4c_Disponivel para o produto informado
2102:     *==========================================================================
2103:     PROCEDURE ProdutoInicialValid()
2104:         LOCAL loc_cProd, loc_oPage, loc_oErro
2105: 
2106:         TRY
2107:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2108:             loc_cProd = ALLTRIM(loc_oPage.txt_4c_ProdutoInicial.Value)
2109: 
2110:             IF !EMPTY(loc_cProd) AND USED("cursor_4c_Disponivel")
2111:                 SELECT cursor_4c_Disponivel
2112:                 GO TOP
2113:                 LOCATE FOR ALLTRIM(Cpros) >= loc_cProd
2114:                 IF !EOF("cursor_4c_Disponivel")
2115:                     loc_oPage.grd_4c_Disponivel.Refresh()
2116:                 ENDIF
2117:             ENDIF
2118: 
2119:         CATCH TO loc_oErro
2120:             MsgErro("Erro em ProdutoInicialValid:" + CHR(13) + loc_oErro.Message, "Erro")
2121:         ENDTRY
2122:     ENDPROC
2123: 
2124:     *==========================================================================
2125:     * PopularInfoProduto - Preenche o painel info com dados do produto selecionado
2126:     *==========================================================================
2127:     PROCEDURE PopularInfoProduto(par_cCodPro)
2128:         LOCAL loc_oPage, loc_cSQL, loc_nRet, loc_oErro
2129: 

*-- Linhas 2148 a 2203:
2148:             loc_oPage.txt_4c_DsModeloInfo.Value   = ""
2149: 
2150:             IF !EMPTY(ALLTRIM(par_cCodPro))
2151:                 loc_cSQL = "SELECT RTRIM(a.cgrus) AS cgrus, " + ;
2152:                     "RTRIM(ISNULL(g.dgrus,'')) AS dgrus, " + ;
2153:                     "RTRIM(a.sgrus) AS sgrus, " + ;
2154:                     "RTRIM(ISNULL(sg.descricaos,'')) AS dsgrus, " + ;
2155:                     "RTRIM(a.ifors) AS ifors, " + ;
2156:                     "RTRIM(ISNULL(c.rclis,'')) AS rclis, " + ;
2157:                     "RTRIM(a.reffs) AS reffs, " + ;
2158:                     "a.pvens, RTRIM(a.moedas) AS moedas, a.pesoms, " + ;
2159:                     "RTRIM(a.cvens) AS cvens, " + ;
2160:                     "RTRIM(ISNULL(col.descs,'')) AS dcvens, " + ;
2161:                     "RTRIM(a.linhas) AS linhas, " + ;
2162:                     "RTRIM(ISNULL(lin.descs,'')) AS dlinhas, " + ;
2163:                     "RTRIM(a.codfinp) AS codfinp, " + ;
2164:                     "RTRIM(ISNULL(finp.descs,'')) AS dcodfinp " + ;
2165:                     "FROM SigCdPro a " + ;
2166:                     "LEFT JOIN SigCdGrp g " + ;
2167:                     "    ON RTRIM(g.cgrus) = RTRIM(a.cgrus) " + ;
2168:                     "LEFT JOIN SigCdPsg sg " + ;
2169:                     "    ON sg.cgrus = RTRIM(a.cgrus) AND sg.codigos = RTRIM(a.sgrus) " + ;
2170:                     "LEFT JOIN SIGCDCLI c " + ;
2171:                     "    ON RTRIM(c.iclis) = RTRIM(a.ifors) " + ;
2172:                     "LEFT JOIN SigCdCol col " + ;
2173:                     "    ON RTRIM(col.colecoes) = RTRIM(a.cvens) " + ;
2174:                     "LEFT JOIN SigCdLin lin " + ;
2175:                     "    ON RTRIM(lin.linhas) = RTRIM(a.linhas) " + ;
2176:                     "LEFT JOIN SigCdFip finp " + ;
2177:                     "    ON RTRIM(finp.cods) = RTRIM(a.codfinp) " + ;
2178:                     "WHERE RTRIM(a.cpros) = " + EscaparSQL(par_cCodPro)
2179: 
2180:                 IF USED("cursor_4c_InfoPro")
2181:                     USE IN cursor_4c_InfoPro
2182:                 ENDIF
2183: 
2184:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InfoPro")
2185: 
2186:                 IF loc_nRet > 0 AND USED("cursor_4c_InfoPro") ;
2187:                    AND RECCOUNT("cursor_4c_InfoPro") > 0
2188:                     SELECT cursor_4c_InfoPro
2189:                     GO TOP
2190: 
2191:                     loc_oPage.txt_4c_CdGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.cgrus)
2192:                     loc_oPage.txt_4c_DsGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.dgrus)
2193:                     loc_oPage.txt_4c_CdSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.sgrus)
2194:                     loc_oPage.txt_4c_DsSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.dsgrus)
2195:                     loc_oPage.txt_4c_CdFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.ifors)
2196:                     loc_oPage.txt_4c_DsFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.rclis)
2197:                     loc_oPage.txt_4c_RefFornInfo.Value    = ALLTRIM(cursor_4c_InfoPro.reffs)
2198:                     loc_oPage.txt_4c_PrVendaInfo.Value    = LTRIM(STR(cursor_4c_InfoPro.pvens, 12, 2))
2199:                     loc_oPage.txt_4c_PrVendaMoeInfo.Value = ALLTRIM(cursor_4c_InfoPro.moedas)
2200:                     loc_oPage.txt_4c_PesoMedioInfo.Value  = LTRIM(STR(cursor_4c_InfoPro.pesoms, 10, 3))
2201:                     loc_oPage.txt_4c_CdGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.cvens)
2202:                     loc_oPage.txt_4c_DsGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.dcvens)
2203:                     loc_oPage.txt_4c_CdLinhaInfo.Value    = ALLTRIM(cursor_4c_InfoPro.linhas)

*-- Linhas 2328 a 2346:
2328:             .HighlightBackColor = RGB(255, 255, 255)
2329:             .HighlightForeColor = RGB(15, 41, 104)
2330:             .HighlightStyle     = 2
2331:             .DeleteMark         = .F.
2332:             .RecordMark         = .F.
2333:             .RowHeight          = 18
2334:             .ScrollBars         = 3
2335:             .GridLines          = 3
2336:             .ReadOnly           = .T.
2337:             .Visible            = .T.
2338:             .Column1.Header1.Caption = "Emp O"
2339:             .Column1.Width           = 55
2340:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2341:             .Column2.Width           = 110
2342:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
2343:             .Column3.Width           = 130
2344:             .Column4.Header1.Caption = "Emp D"
2345:             .Column4.Width           = 55
2346:             .Column5.Header1.Caption = "Grupo Orig"

*-- Linhas 2396 a 2414:
2396:             .HighlightBackColor = RGB(255, 255, 255)
2397:             .HighlightForeColor = RGB(15, 41, 104)
2398:             .HighlightStyle     = 2
2399:             .DeleteMark         = .F.
2400:             .RecordMark         = .F.
2401:             .RowHeight          = 18
2402:             .ScrollBars         = 3
2403:             .GridLines          = 3
2404:             .ReadOnly           = .T.
2405:             .Visible            = .T.
2406:             .Column1.Header1.Caption = "Item"
2407:             .Column1.Width           = 50
2408:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
2409:             .Column2.Width           = 100
2410:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2411:             .Column3.Width           = 200
2412:             .Column4.Header1.Caption = "Uni"
2413:             .Column4.Width           = 40
2414:             .Column5.Header1.Caption = "Quantidade"

*-- Linhas 2482 a 2502:
2482:     *==========================================================================
2483:     PROCEDURE BtnProcessarFinalClick()
2484:         LOCAL loc_oErro
2485: 
2486:         TRY
2487:             IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
2488:                 MsgAviso("Nenhuma distribui" + CHR(231) + CHR(227) + "o para processar." + ;
2489:                          CHR(13) + "Processe os estoques primeiro.", "Processar")
2490:             ELSE
2491:                 IF THIS.this_oBusinessObject.SalvarLote()
2492:                     MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso!", "")
2493:                     THIS.CarregarCabOperas()
2494:                     THIS.CarregarItnOperas()
2495:                 ENDIF
2496:             ENDIF
2497: 
2498:         CATCH TO loc_oErro
2499:             MsgErro("Erro em BtnProcessarFinalClick:" + CHR(13) + loc_oErro.Message, "Erro")
2500:         ENDTRY
2501:     ENDPROC
2502: 

*-- Linhas 2519 a 2581:
2519:                 USE IN cursor_4c_CabOperasTemp
2520:             ENDIF
2521: 
2522:             loc_cSQL = "SELECT DISTINCT RTRIM(c.emps) AS emps, " + ;
2523:                        "RTRIM(c.dopes) AS dopes, " + ;
2524:                        "c.numes AS numes, " + ;
2525:                        "RTRIM(c.empds) AS empds, " + ;
2526:                        "RTRIM(c.grupoos) AS grupoos, RTRIM(c.contaos) AS contaos, " + ;
2527:                        "RTRIM(c.grupods) AS grupods, RTRIM(c.contads) AS contads " + ;
2528:                        "FROM SigMvCab c " + ;
2529:                        "WHERE EXISTS (" + ;
2530:                        " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2531:                        " AND (RTRIM(d.empdopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2532:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)" + ;
2533:                        " OR RTRIM(d.oridopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2534:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)))" + ;
2535:                        " ORDER BY c.emps, c.dopes"
2536: 
2537:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOperasTemp")
2538: 
2539:             IF loc_nRet < 0
2540:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
2541:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2542:             ELSE
2543:                 SELECT * FROM cursor_4c_CabOperasTemp INTO CURSOR cursor_4c_CabOperas READWRITE
2544:                 IF USED("cursor_4c_CabOperasTemp")
2545:                     USE IN cursor_4c_CabOperasTemp
2546:                 ENDIF
2547:                 loc_oGrid.ColumnCount = 8
2548:                 loc_oGrid.RecordSource = "cursor_4c_CabOperas"
2549: 
2550:                 loc_oGrid.Column1.ControlSource = "cursor_4c_CabOperas.emps"
2551:                 loc_oGrid.Column2.ControlSource = "cursor_4c_CabOperas.dopes"
2552:                 loc_oGrid.Column3.ControlSource = "cursor_4c_CabOperas.numes"
2553:                 loc_oGrid.Column4.ControlSource = "cursor_4c_CabOperas.empds"
2554:                 loc_oGrid.Column5.ControlSource = "cursor_4c_CabOperas.grupoos"
2555:                 loc_oGrid.Column6.ControlSource = "cursor_4c_CabOperas.contaos"
2556:                 loc_oGrid.Column7.ControlSource = "cursor_4c_CabOperas.grupods"
2557:                 loc_oGrid.Column8.ControlSource = "cursor_4c_CabOperas.contads"
2558: 
2559:                 loc_oGrid.Column1.txt_4c_Col01.ControlSource = "cursor_4c_CabOperas.emps"
2560:                 loc_oGrid.Column2.txt_4c_Col02.ControlSource = "cursor_4c_CabOperas.dopes"
2561:                 loc_oGrid.Column3.txt_4c_Col03.ControlSource = "cursor_4c_CabOperas.numes"
2562:                 loc_oGrid.Column4.txt_4c_Col04.ControlSource = "cursor_4c_CabOperas.empds"
2563:                 loc_oGrid.Column5.txt_4c_Col05.ControlSource = "cursor_4c_CabOperas.grupoos"
2564:                 loc_oGrid.Column6.txt_4c_Col06.ControlSource = "cursor_4c_CabOperas.contaos"
2565:                 loc_oGrid.Column7.txt_4c_Col07.ControlSource = "cursor_4c_CabOperas.grupods"
2566:                 loc_oGrid.Column8.txt_4c_Col08.ControlSource = "cursor_4c_CabOperas.contads"
2567:                 loc_oGrid.Refresh()
2568:             ENDIF
2569: 
2570:         CATCH TO loc_oErro
2571:             MsgErro("Erro em CarregarCabOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2572:         ENDTRY
2573:     ENDPROC
2574: 
2575:     *==========================================================================
2576:     * CarregarItnOperas - Carrega grd_4c_ItnOperas com itens de movimentos do lote
2577:     *==========================================================================
2578:     PROTECTED PROCEDURE CarregarItnOperas()
2579:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2580:         loc_oErro = .NULL.
2581: 

*-- Linhas 2591 a 2681:
2591:                 USE IN cursor_4c_ItnOperasTemp
2592:             ENDIF
2593: 
2594:             loc_cSQL = "SELECT RTRIM(b.cItens) AS Citens, RTRIM(b.CPros) AS CPros, " + ;
2595:                        "RTRIM(ISNULL(b.DPros,'')) AS Dpros, " + ;
2596:                        "RTRIM(b.Cunis) AS CUnis, b.Qtds, b.Units, b.totas, " + ;
2597:                        "RTRIM(c.CodCors) AS CodCors, RTRIM(c.CodTams) AS CodTams " + ;
2598:                        "FROM (SELECT DISTINCT d.EmpDopNums FROM sigprdis d" + ;
2599:                        " WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2600:                        " AND RTRIM(d.EmpDopNums) <> '') x " + ;
2601:                        "INNER JOIN SigMvItn b ON x.EmpDopNums = b.EmpDopNums " + ;
2602:                        "INNER JOIN SigMvIts c ON b.EmpDopNums = c.EmpDopNums" + ;
2603:                        " AND b.cItens = c.Citens " + ;
2604:                        "ORDER BY b.cItens"
2605: 
2606:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOperasTemp")
2607: 
2608:             IF loc_nRet < 0
2609:                 MsgErro("Erro ao carregar itens de opera" + CHR(231) + CHR(245) + "es:" + ;
2610:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2611:             ELSE
2612:                 SELECT * FROM cursor_4c_ItnOperasTemp INTO CURSOR cursor_4c_ItnOperas READWRITE
2613:                 IF USED("cursor_4c_ItnOperasTemp")
2614:                     USE IN cursor_4c_ItnOperasTemp
2615:                 ENDIF
2616:                 loc_oGrid.ColumnCount = 9
2617:                 loc_oGrid.RecordSource = "cursor_4c_ItnOperas"
2618: 
2619:                 loc_oGrid.Column1.ControlSource = "cursor_4c_ItnOperas.Citens"
2620:                 loc_oGrid.Column2.ControlSource = "cursor_4c_ItnOperas.CPros"
2621:                 loc_oGrid.Column3.ControlSource = "cursor_4c_ItnOperas.Dpros"
2622:                 loc_oGrid.Column4.ControlSource = "cursor_4c_ItnOperas.CUnis"
2623:                 loc_oGrid.Column5.ControlSource = "cursor_4c_ItnOperas.Qtds"
2624:                 loc_oGrid.Column6.ControlSource = "cursor_4c_ItnOperas.Units"
2625:                 loc_oGrid.Column7.ControlSource = "cursor_4c_ItnOperas.totas"
2626:                 loc_oGrid.Column8.ControlSource = "cursor_4c_ItnOperas.CodCors"
2627:                 loc_oGrid.Column9.ControlSource = "cursor_4c_ItnOperas.CodTams"
2628: 
2629:                 loc_oGrid.Column1.txt_4c_Itn01.ControlSource = "cursor_4c_ItnOperas.Citens"
2630:                 loc_oGrid.Column2.txt_4c_Itn02.ControlSource = "cursor_4c_ItnOperas.CPros"
2631:                 loc_oGrid.Column3.txt_4c_Itn03.ControlSource = "cursor_4c_ItnOperas.Dpros"
2632:                 loc_oGrid.Column4.txt_4c_Itn04.ControlSource = "cursor_4c_ItnOperas.CUnis"
2633:                 loc_oGrid.Column5.txt_4c_Itn05.ControlSource = "cursor_4c_ItnOperas.Qtds"
2634:                 loc_oGrid.Column6.txt_4c_Itn06.ControlSource = "cursor_4c_ItnOperas.Units"
2635:                 loc_oGrid.Column7.txt_4c_Itn07.ControlSource = "cursor_4c_ItnOperas.totas"
2636:                 loc_oGrid.Column8.txt_4c_Itn08.ControlSource = "cursor_4c_ItnOperas.CodCors"
2637:                 loc_oGrid.Column9.txt_4c_Itn09.ControlSource = "cursor_4c_ItnOperas.CodTams"
2638:                 loc_oGrid.Refresh()
2639:             ENDIF
2640: 
2641:         CATCH TO loc_oErro
2642:             MsgErro("Erro em CarregarItnOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2643:         ENDTRY
2644:     ENDPROC
2645: 
2646:     *==========================================================================
2647:     * Destroy - Libera recursos ao fechar
2648:     *==========================================================================
2649:     PROCEDURE Destroy()
2650:         IF USED("cursor_4c_Lista")
2651:             USE IN cursor_4c_Lista
2652:         ENDIF
2653:         IF USED("cursor_4c_ListaTemp")
2654:             USE IN cursor_4c_ListaTemp
2655:         ENDIF
2656:         IF USED("cursor_4c_Estoque")
2657:             USE IN cursor_4c_Estoque
2658:         ENDIF
2659:         IF USED("cursor_4c_EstoqueTemp")
2660:             USE IN cursor_4c_EstoqueTemp
2661:         ENDIF
2662:         IF USED("cursor_4c_Disponivel")
2663:             USE IN cursor_4c_Disponivel
2664:         ENDIF
2665:         IF USED("cursor_4c_Distribui")
2666:             USE IN cursor_4c_Distribui
2667:         ENDIF
2668:         IF USED("cursor_4c_InfoPro")
2669:             USE IN cursor_4c_InfoPro
2670:         ENDIF
2671:         IF USED("cursor_4c_CabOperas")
2672:             USE IN cursor_4c_CabOperas
2673:         ENDIF
2674:         IF USED("cursor_4c_CabOperasTemp")
2675:             USE IN cursor_4c_CabOperasTemp
2676:         ENDIF
2677:         IF USED("cursor_4c_ItnOperas")
2678:             USE IN cursor_4c_ItnOperas
2679:         ENDIF
2680:         IF USED("cursor_4c_ItnOperasTemp")
2681:             USE IN cursor_4c_ItnOperasTemp


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*==============================================================================
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
* Data: 2026-07-02
* Tabela: sigprdis | PK: cidchaves | Chave negocio: codigos (lote)
*
* ATENCAO: Esta tabela opera em modo LOTE (batch):
* - Um lote (codigos) possui N linhas (uma por empresa/produto/cor/tamanho)
* - cidchaves = chave unica por linha (gerada via fUniqueIds)
* - codigos   = identificador do lote de distribuicao
* - Excluir() apaga TODAS as linhas do lote (WHERE codigos = ...)
* - Inserir() insere MULTIPLAS linhas por lote
*==============================================================================

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Campos da tabela sigprdis
    this_cCidChaves  = ""   && cidchaves  CHAR(20)    - Chave unica por linha (PK)
    this_cCodigos    = ""   && codigos    CHAR(10)    - Codigo do lote de distribuicao
    this_cCpros      = ""   && cpros      CHAR(14)    - Codigo do produto
    this_cCodCors    = ""   && codcors    CHAR(4)     - Codigo da cor
    this_cCodTams    = ""   && codtams    CHAR(4)     - Codigo do tamanho
    this_dDatas      = {}   && datas      DATETIME    - Data da distribuicao
    this_dDtAlts     = {}   && dtalts     DATETIME    - Data da ultima alteracao
    this_cEmpDopNums = ""   && empdopnums CHAR(29)    - Numero do pedido destino
    this_cEmpDs      = ""   && empds      CHAR(3)     - Empresa destino
    this_cEmpGruEsts = ""   && empgruests CHAR(23)    - Empresa/Grupo/Estoque marcado
    this_cLocals     = ""   && locals     CHAR(10)    - Localizacao de destino
    this_nQtdOs      = 0    && qtdos      NUMERIC(10,2) - Quantidade original em estoque
    this_nQtds       = 0    && qtds       NUMERIC(10,2) - Quantidade distribuida
    this_cUsualts    = ""   && usualts    CHAR(10)    - Usuario da ultima alteracao
    this_cUsuars     = ""   && usuars     CHAR(10)    - Usuario criador
    this_cOriDopNums = ""   && oridopnums CHAR(29)    - Numero do pedido origem

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprdis"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCodigos    = TratarNulo(codigos,    "C")
                THIS.this_cCpros      = TratarNulo(cpros,      "C")
                THIS.this_cCodCors    = TratarNulo(codcors,    "C")
                THIS.this_cCodTams    = TratarNulo(codtams,    "C")
                THIS.this_dDatas      = NVL(datas,      {})
                THIS.this_dDtAlts     = NVL(dtalts,     {})
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cEmpDs      = TratarNulo(empds,      "C")
                THIS.this_cEmpGruEsts = TratarNulo(empgruests, "C")
                THIS.this_cLocals     = TratarNulo(locals,     "C")
                THIS.this_nQtdOs      = TratarNulo(qtdos,      "N")
                THIS.this_nQtds       = TratarNulo(qtds,       "N")
                THIS.this_cUsualts    = TratarNulo(usualts,    "C")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_cOriDopNums = TratarNulo(oridopnums, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao (suporta filtro WHERE opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos, datas FROM sigprdis"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY datas DESC, codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lotes: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorData - Carrega lotes filtrados por intervalo de data/hora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorData(par_dDataIni, par_dDataFim)
        LOCAL loc_cSQL, loc_cDataIni, loc_cDataFim, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_dDataIni) != "T" OR EMPTY(par_dDataIni)
                par_dDataIni = CTOT(DTOC(DATE()) + " 00:00:00")
            ENDIF
            IF VARTYPE(par_dDataFim) != "T" OR EMPTY(par_dDataFim)
                par_dDataFim = CTOT(DTOC(DATE()) + " 23:59:59")
            ENDIF

            loc_cDataIni = FormatarDataSQL(par_dDataIni)
            loc_cDataFim = FormatarDataSQL(par_dDataFim)

            loc_cSQL = "SELECT DISTINCT codigos, datas FROM sigprdis" + ;
                       " WHERE datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " ORDER BY datas DESC, codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar por data: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeiro item de um lote (para edicao)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM sigprdis WHERE codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensPorCodigos - Carrega todos os itens de um lote em cursor
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensPorCodigos(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM sigprdis WHERE codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPrdis")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens do lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere uma linha de distribuicao no banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO sigprdis (" + ;
                       "cidchaves, codigos, cpros, codcors, codtams, datas, dtalts," + ;
                       " empdopnums, empds, empgruests, locals, qtdos, qtds," + ;
                       " usualts, usuars, oridopnums" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                       EscaparSQL(THIS.this_cCodigos)      + ", " + ;
                       EscaparSQL(THIS.this_cCpros)        + ", " + ;
                       EscaparSQL(THIS.this_cCodCors)      + ", " + ;
                       EscaparSQL(THIS.this_cCodTams)      + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)  + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums)   + ", " + ;
                       EscaparSQL(THIS.this_cEmpDs)        + ", " + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)   + ", " + ;
                       EscaparSQL(THIS.this_cLocals)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)  + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)      + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)       + ", " + ;
                       EscaparSQL(THIS.this_cOriDopNums)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de distribuicao no banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE sigprdis SET" + ;
                       " codigos    = " + EscaparSQL(THIS.this_cCodigos)      + "," + ;
                       " cpros      = " + EscaparSQL(THIS.this_cCpros)        + "," + ;
                       " codcors    = " + EscaparSQL(THIS.this_cCodCors)      + "," + ;
                       " codtams    = " + EscaparSQL(THIS.this_cCodTams)      + "," + ;
                       " datas      = " + FormatarDataSQL(THIS.this_dDatas)   + "," + ;
                       " dtalts     = " + FormatarDataSQL(THIS.this_dDtAlts)  + "," + ;
                       " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)   + "," + ;
                       " empds      = " + EscaparSQL(THIS.this_cEmpDs)        + "," + ;
                       " empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)   + "," + ;
                       " locals     = " + EscaparSQL(THIS.this_cLocals)       + "," + ;
                       " qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs) + "," + ;
                       " qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)  + "," + ;
                       " usualts    = " + EscaparSQL(THIS.this_cUsualts)      + "," + ;
                       " usuars     = " + EscaparSQL(THIS.this_cUsuars)       + "," + ;
                       " oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)   + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todos os itens de um lote (WHERE codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM sigprdis WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Salvar - Sobrescreve BusinessBase.Salvar() para delegar ao SalvarLote()
    *--------------------------------------------------------------------------
    PROCEDURE Salvar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !THIS.this_lEmEdicao
            THIS.this_cMensagemErro = "N" + CHR(227) + "o est" + CHR(225) + ;
                                      " em modo de edi" + CHR(231) + CHR(227) + "o"
        ELSE
            loc_lResultado = THIS.SalvarLote()
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLote - Insere multiplas linhas de distribui" + CHR(231) + CHR(227) + "o em lote
    * Usa cursor_4c_Distribui e cursor_4c_Disponivel (devem existir no ambiente)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLote()
        LOCAL loc_cCodigos, loc_nTotal, loc_nNeg, loc_lOK, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Distribui")
                MsgErro("Cursor de distribui" + CHR(231) + CHR(227) + ;
                        "o n" + CHR(227) + "o encontrado.", "Erro")
            ELSE
                *-- Contar registros com quantidade a distribuir
                SELECT cursor_4c_Distribui
                COUNT FOR QtdDistr != 0 TO loc_nTotal

                IF loc_nTotal = 0
                    MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
                ELSE
                    *-- Verificar saldo negativo
                    loc_nNeg = 0
                    IF USED("cursor_4c_Disponivel")
                        SELECT cursor_4c_Disponivel
                        COUNT FOR QtdSaldo < 0 TO loc_nNeg
                    ENDIF

                    IF loc_nNeg > 0
                        MsgAviso("Existem produtos distribu" + CHR(237) + "dos com saldo negativo." + ;
                                 CHR(13) + "Favor checar antes de processar.", "Saldo Negativo")
                    ELSE
                        *-- Gerar codigo do lote (novo ou reutilizar existente para alteracao)
                        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                            loc_cCodigos = ALLTRIM(STR(fGerUniqueKey("sigprdis"), 10))
                        ELSE
                            loc_cCodigos = ALLTRIM(THIS.this_cCodigos)
                            THIS.ExecutarExclusao()
                        ENDIF

                        *-- Inserir cada linha com QtdDistr != 0
                        loc_lOK = .T.
                        SELECT cursor_4c_Distribui
                        GO TOP IN cursor_4c_Distribui

                        DO WHILE !EOF("cursor_4c_Distribui") AND loc_lOK
                            IF cursor_4c_Distribui.QtdDistr != 0
                                THIS.this_cCidChaves  = fUniqueIds()
                                THIS.this_cCodigos    = loc_cCodigos
                                THIS.this_cCpros      = ALLTRIM(cursor_4c_Distribui.Cpros)
                                THIS.this_cCodCors    = ALLTRIM(cursor_4c_Distribui.CodCors)
                                THIS.this_cCodTams    = ALLTRIM(cursor_4c_Distribui.CodTams)
                                THIS.this_dDatas      = DATETIME()
                                THIS.this_dDtAlts     = DATETIME()
                                THIS.this_cEmpDs      = ALLTRIM(cursor_4c_Distribui.Cemps)
                                THIS.this_cEmpGruEsts = ALLTRIM(cursor_4c_Distribui.empgruests)
                                THIS.this_cLocals     = ALLTRIM(cursor_4c_Distribui.CidChaves)
                                THIS.this_nQtdOs      = cursor_4c_Distribui.QtdSaldo
                                THIS.this_nQtds       = cursor_4c_Distribui.QtdDistr
                                THIS.this_cUsualts    = gc_4c_UsuarioLogado
                                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                                THIS.this_cEmpDopNums = ""
                                THIS.this_cOriDopNums = ""
                                IF !THIS.Inserir()
                                    loc_lOK = .F.
                                ENDIF
                            ENDIF
                            IF loc_lOK
                                SKIP IN cursor_4c_Distribui
                            ENDIF
                        ENDDO

                        IF loc_lOK
                            THIS.this_cCodigos      = loc_cCodigos
                            THIS.this_lNovoRegistro = .F.
                            THIS.this_lEmEdicao     = .F.
                            loc_lResultado          = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao - Cria cursor_4c_Disponivel e cursor_4c_Distribui
    * par_cAlias = alias do cursor de estoques selecionados (cursor_4c_Estoque)
    *              Campos: nMarca (N), Emps (C3), Grupos (C10), Contas (C10)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cAlias)
        LOCAL loc_cIN, loc_cSQL, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cAlias) != "C" OR !USED(par_cAlias)
                MsgErro("Alias inv" + CHR(225) + "lido para processar distribui" + ;
                        CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                *-- Montar IN clause com os estoques marcados
                SELECT (par_cAlias)
                GO TOP
                loc_cIN = ""
                SCAN
                    IF nMarca = 1
                        IF !EMPTY(loc_cIN)
                            loc_cIN = loc_cIN + ","
                        ENDIF
                        loc_cIN = loc_cIN + "'" + ALLTRIM(Emps) + "|" + ;
                                  ALLTRIM(Grupos) + "|" + ALLTRIM(Contas) + "'"
                    ENDIF
                ENDSCAN

                IF EMPTY(loc_cIN)
                    MsgAviso("Nenhum estoque selecionado para processar.", "Processar")
                ELSE
                    *-- cursor_4c_Disponivel: estoque agregado por produto/cor/tamanho
                    loc_cSQL = "SELECT RTRIM(m.cpros) AS Cpros, " + ;
                               "RTRIM(ISNULL(p.dpros,'')) AS Dpros, " + ;
                               "RTRIM(m.codcors) AS CodCors, " + ;
                               "RTRIM(m.codtams) AS CodTams, " + ;
                               "SUM(m.sqtds) AS Sqtds, " + ;
                               "CAST(0 AS NUMERIC(11,3)) AS QtdSaida, " + ;
                               "SUM(m.sqtds) AS QtdSaldo, " + ;
                               "RTRIM(ISNULL(p.cgrus,'')) AS Cgrus, " + ;
                               "RTRIM(ISNULL(p.sgrus,'')) AS Sgrus " + ;
                               "FROM SigMvEst m " + ;
                               "JOIN SigCdPro p ON RTRIM(p.cpros) = RTRIM(m.cpros) " + ;
                               "WHERE (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
                               " IN (" + loc_cIN + ") " + ;
                               "GROUP BY m.cpros, p.dpros, m.codcors, m.codtams, p.cgrus, p.sgrus " + ;
                               "ORDER BY m.cpros, m.codcors, m.codtams"

                    IF USED("cursor_4c_Disponivel")
                        USE IN cursor_4c_Disponivel
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")

                    IF loc_nRet < 0
                        MsgErro("Erro ao carregar estoque dispon" + CHR(237) + "vel:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- cursor_4c_Distribui: uma linha por empresa x produto/cor/tamanho
                        loc_cSQL = "SELECT RTRIM(m.emps) AS Cemps, " + ;
                                   "RTRIM(m.grupos) AS CGrus, " + ;
                                   "RTRIM(m.estos) AS CCons, " + ;
                                   "RTRIM(m.cpros) AS Cpros, " + ;
                                   "RTRIM(m.codcors) AS CodCors, " + ;
                                   "RTRIM(m.codtams) AS CodTams, " + ;
                                   "m.sqtds AS QtdSaldo, " + ;
                                   "CAST(0 AS NUMERIC(11,3)) AS QtdDistr, " + ;
                                   "RTRIM(m.empgruests) AS empgruests, " + ;
                                   "REPLICATE(' ', 20) AS CidChaves " + ;
                                   "FROM SigMvEst m " + ;
                                   "WHERE (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
                                   " IN (" + loc_cIN + ") " + ;
                                   "ORDER BY m.cpros, m.codcors, m.codtams, m.emps"

                        IF USED("cursor_4c_Distribui")
                            USE IN cursor_4c_Distribui
                        ENDIF

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Distribui")

                        IF loc_nRet < 0
                            MsgErro("Erro ao montar distribui" + CHR(231) + CHR(227) + "o:" + ;
                                    CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

