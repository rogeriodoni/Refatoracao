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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS SQL (2852 linhas total):

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
406:             .Column2.Header1.Caption = "Data"
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
710:                     loc_oGrid.Column2.Header1.Caption = "Data"
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

*-- Linhas 744 a 781:
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
763:                     loc_oGrid.Column1.chk_4c_nMarca.ControlSource  = "cursor_4c_Estoque.nMarca"
764:                     loc_oGrid.Column2.txt_4c_Empresa.ControlSource  = "cursor_4c_Estoque.Emps"
765:                     loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.Grupos"
766:                     loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.Contas"
767: 
768:                     loc_oGrid.Column1.Header1.Caption = ""
769:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
770:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
771:                     loc_oGrid.Column4.Header1.Caption = "Conta"
772: 
773:                     loc_lResultado = .T.
774:                 ENDIF
775:             ENDIF
776: 
777:         CATCH TO loc_oErro
778:             MsgErro("Erro em CarregarEstoque:" + CHR(13) + loc_oErro.Message, "Erro")
779:             loc_lResultado = .F.
780:         ENDTRY
781: 

*-- Linhas 857 a 914:
857:             RETURN
858:         ENDIF
859: 
860:         SELECT cursor_4c_Lista
861:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
862: 
863:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
864:             THIS.this_cModoAtual = "VISUALIZAR"
865:             THIS.AlternarPagina(2)
866:         ENDIF
867:     ENDPROC
868: 
869:     *==========================================================================
870:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
871:     *==========================================================================
872:     PROCEDURE BtnAlterarClick()
873:         LOCAL loc_cCodigo
874:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
875:             MsgAviso("Nenhum registro selecionado.", "Aviso")
876:             RETURN
877:         ENDIF
878: 
879:         SELECT cursor_4c_Lista
880:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
881: 
882:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
883:             THIS.this_oBusinessObject.EditarRegistro()
884:             THIS.this_cModoAtual = "ALTERAR"
885:             THIS.AlternarPagina(2)
886:         ENDIF
887:     ENDPROC
888: 
889:     *==========================================================================
890:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
891:     *==========================================================================
892:     PROCEDURE BtnExcluirClick()
893:         LOCAL loc_cCodigo
894:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
895:             MsgAviso("Nenhum registro selecionado.", "Aviso")
896:             RETURN
897:         ENDIF
898: 
899:         SELECT cursor_4c_Lista
900:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
901: 
902:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da distribui" + ;
903:                         CHR(231) + CHR(227) + "o " + loc_cCodigo + "?", ;
904:                         "Confirmar Exclus" + CHR(227) + "o")
905:             RETURN
906:         ENDIF
907: 
908:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
909:             IF THIS.this_oBusinessObject.Excluir()
910:                 MsgInfo("Distribui" + CHR(231) + CHR(227) + "o exclu" + ;
911:                         CHR(237) + "da com sucesso.", "")
912:                 THIS.CarregarLista()
913:             ENDIF
914:         ENDIF

*-- Linhas 1247 a 1265:
1247:             .HighlightBackColor = RGB(255, 255, 255)
1248:             .HighlightForeColor = RGB(15, 41, 104)
1249:             .HighlightStyle     = 2
1250:             .DeleteMark         = .F.
1251:             .RecordMark         = .F.
1252:             .RowHeight          = 18
1253:             .ScrollBars         = 2
1254:             .GridLines          = 3
1255:             .Visible            = .T.
1256:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1257:             .Column1.Width           = 90
1258:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1259:             .Column2.Width           = 200
1260:             .Column3.Header1.Caption = "Cor"
1261:             .Column3.Width           = 60
1262:             .Column4.Header1.Caption = "Tam"
1263:             .Column4.Width           = 40
1264:             .Column5.Header1.Caption = "Estoque"
1265:             .Column5.Width           = 70

*-- Linhas 1317 a 1335:
1317:             .HighlightBackColor = RGB(255, 255, 255)
1318:             .HighlightForeColor = RGB(15, 41, 104)
1319:             .HighlightStyle     = 2
1320:             .DeleteMark         = .F.
1321:             .RecordMark         = .F.
1322:             .RowHeight          = 18
1323:             .ScrollBars         = 2
1324:             .GridLines          = 3
1325:             .Visible            = .T.
1326:             .Column1.Header1.Caption = "Empresa"
1327:             .Column1.Width           = 60
1328:             .Column2.Header1.Caption = "Saldo"
1329:             .Column2.Width           = 70
1330:             .Column3.Header1.Caption = "Distribuido"
1331:             .Column3.Width           = 80
1332:             .Column4.Header1.Caption = "Local"
1333:             .Column4.Width           = 90
1334:         ENDWITH
1335: 

*-- Linhas 1630 a 1673:
1630: 
1631:         THIS.TornarControlesVisiveis(loc_oPage)
1632:     ENDPROC
1633: 
1634:     *==========================================================================
1635:     * CarregarDisponivel - Vincula grd_4c_Disponivel ao cursor_4c_Disponivel
1636:     *==========================================================================
1637:     PROTECTED PROCEDURE CarregarDisponivel()
1638:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1639:         loc_lResultado = .F.
1640: 
1641:         TRY
1642:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1643:                 loc_lResultado = .T.
1644:             ELSE
1645:                 IF USED("cursor_4c_Disponivel")
1646:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1647:                 loc_oGrid = loc_oPage.grd_4c_Disponivel
1648: 
1649:                 loc_oGrid.ColumnCount = 7
1650:                 loc_oGrid.RecordSource = "cursor_4c_Disponivel"
1651: 
1652:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Disponivel.Cpros"
1653:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Disponivel.Dpros"
1654:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Disponivel.CodCors"
1655:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Disponivel.CodTams"
1656:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Disponivel.Sqtds"
1657:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1658:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1659: 
1660:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1661:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1662:                 loc_oGrid.Column3.Header1.Caption = "Cor"
1663:                 loc_oGrid.Column4.Header1.Caption = "Tam"
1664:                 loc_oGrid.Column5.Header1.Caption = "Estoque"
1665:                 loc_oGrid.Column6.Header1.Caption = "Saldo"
1666:                 loc_oGrid.Column7.Header1.Caption = "Distribuido"
1667: 
1668:                 THIS.FormatarGridLista(loc_oGrid)
1669:                 loc_oGrid.Refresh()
1670: 
1671:                 THIS.CarregarDistribui()
1672: 
1673:                 loc_lResultado = .T.

*-- Linhas 1681 a 1721:
1681: 
1682:         RETURN loc_lResultado
1683:     ENDPROC
1684: 
1685:     *==========================================================================
1686:     * CarregarDistribui - Vincula grd_4c_Distribui ao cursor_4c_Distribui
1687:     *==========================================================================
1688:     PROTECTED PROCEDURE CarregarDistribui()
1689:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1690:         loc_lResultado = .F.
1691: 
1692:         TRY
1693:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1694:                 loc_lResultado = .T.
1695:             ELSE
1696:                 IF USED("cursor_4c_Distribui")
1697:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1698:                 loc_oGrid = loc_oPage.grd_4c_Distribui
1699: 
1700:                 loc_oGrid.ColumnCount = 4
1701:                 loc_oGrid.RecordSource = "cursor_4c_Distribui"
1702: 
1703:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Distribui.Cemps"
1704:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1705:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1706:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"
1707: 
1708:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1709:                 loc_oGrid.Column2.Header1.Caption = "Saldo"
1710:                 loc_oGrid.Column3.Header1.Caption = "Distribuido"
1711:                 loc_oGrid.Column4.Header1.Caption = "Local"
1712: 
1713:                 THIS.FormatarGridLista(loc_oGrid)
1714:                 loc_oGrid.Refresh()
1715: 
1716:                 loc_lResultado = .T.
1717:                 ENDIF
1718:             ENDIF
1719: 
1720:         CATCH TO loc_oErro
1721:             MsgErro("Erro em CarregarDistribui:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1730 a 1811:
1730:     *==========================================================================
1731:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1732:         LOCAL loc_cCodPro, loc_oPage, loc_oErro
1733: 
1734:         TRY
1735:             IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel") ;
1736:                AND USED("cursor_4c_Distribui")
1737:                 SELECT cursor_4c_Disponivel
1738:                 loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1739:                 SELECT cursor_4c_Distribui
1740:                 SET FILTER TO ALLTRIM(Cpros) = loc_cCodPro
1741:                 GO TOP IN cursor_4c_Distribui
1742:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Distribui.Refresh()
1743:                 THIS.PopularInfoProduto(loc_cCodPro)
1744:             ENDIF
1745: 
1746:         CATCH TO loc_oErro
1747:             MsgErro("Erro em GrdDisponivelAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1748:         ENDTRY
1749:     ENDPROC
1750: 
1751:     *==========================================================================
1752:     * DistribuidoLostFocus - Recalcula saldo ao sair do campo Distribuido
1753:     *==========================================================================
1754:     PROCEDURE DistribuidoLostFocus()
1755:         THIS.CalcularSaldo()
1756:     ENDPROC
1757: 
1758:     *==========================================================================
1759:     * CalcularSaldo - Recalcula QtdSaida e QtdSaldo no cursor_4c_Disponivel
1760:     *==========================================================================
1761:     PROCEDURE CalcularSaldo()
1762:         LOCAL loc_nQtdTotal, loc_cCodPro, loc_oPage, loc_oErro
1763: 
1764:         TRY
1765:             IF !USED("cursor_4c_Disponivel") OR !USED("cursor_4c_Distribui")
1766:                 loc_oErro = .NULL.
1767:             ELSE
1768:                 IF !EOF("cursor_4c_Disponivel")
1769:                     SELECT cursor_4c_Disponivel
1770:                     loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1771: 
1772:                     SUM cursor_4c_Distribui.QtdDistr ;
1773:                         FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
1774:                         TO loc_nQtdTotal
1775: 
1776:                     SELECT cursor_4c_Disponivel
1777:                     REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
1778:                             cursor_4c_Disponivel.QtdSaldo  WITH ;
1779:                                 cursor_4c_Disponivel.Sqtds - loc_nQtdTotal
1780: 
1781:                     IF cursor_4c_Disponivel.QtdSaldo < 0
1782:                         MsgAviso("Saldo insuficiente para movimentar." + CHR(13) + ;
1783:                                  "O valor excede o estoque dispon" + CHR(237) + "vel.", ;
1784:                                  "Saldo Insuficiente")
1785:                         SELECT cursor_4c_Distribui
1786:                         REPLACE cursor_4c_Distribui.QtdDistr WITH 0 FOR ;
1787:                             ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro
1788: 
1789:                         SUM cursor_4c_Distribui.QtdDistr ;
1790:                             FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
1791:                             TO loc_nQtdTotal
1792: 
1793:                         SELECT cursor_4c_Disponivel
1794:                         REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
1795:                                 cursor_4c_Disponivel.QtdSaldo  WITH ;
1796:                                     cursor_4c_Disponivel.Sqtds - loc_nQtdTotal
1797:                     ENDIF
1798: 
1799:                     loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1800:                     loc_oPage.grd_4c_Disponivel.Refresh()
1801:                     loc_oPage.grd_4c_Distribui.Refresh()
1802:                 ENDIF
1803:             ENDIF
1804: 
1805:         CATCH TO loc_oErro
1806:             MsgErro("Erro em CalcularSaldo:" + CHR(13) + loc_oErro.Message, "Erro")
1807:         ENDTRY
1808:     ENDPROC
1809: 
1810:     *==========================================================================
1811:     * LocalDistribuidoValid - Lookup localizacao SigPrLcl (Column4 grdDistribui)

*-- Linhas 1823 a 1856:
1823:                     "Localiza" + CHR(231) + CHR(227) + "o")
1824: 
1825:                 IF VARTYPE(loc_oBusca) = "O"
1826:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1827:                         IF USED("cursor_4c_BuscaLocal")
1828:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1829:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1830:                         ENDIF
1831:                     ELSE
1832:                         IF !loc_oBusca.this_lAchouRegistro
1833:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1834:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1835:                         loc_oBusca.Show()
1836:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
1837:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1838:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1839:                         ENDIF
1840:                     ELSE
1841:                         REPLACE cursor_4c_Distribui.CidChaves WITH ""
1842:                         ENDIF
1843:                     ENDIF
1844:                     loc_oBusca.Release()
1845:                 ENDIF
1846: 
1847:                 IF USED("cursor_4c_BuscaLocal")
1848:                     USE IN cursor_4c_BuscaLocal
1849:                 ENDIF
1850:             ENDIF
1851: 
1852:         CATCH TO loc_oErro
1853:             MsgErro("Erro em LocalDistribuidoValid:" + CHR(13) + loc_oErro.Message, "Erro")
1854:         ENDTRY
1855:     ENDPROC
1856: 

*-- Linhas 2059 a 2124:
2059:     *==========================================================================
2060:     PROCEDURE FiltrarDisponivelClick()
2061:         LOCAL loc_cCodGrp, loc_cCodSgrp, loc_oPage, loc_oErro
2062: 
2063:         TRY
2064:             IF USED("cursor_4c_Disponivel")
2065:                 loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2066:                 loc_cCodGrp  = ALLTRIM(loc_oPage.txt_4c_CodGrupoDist.Value)
2067:                 loc_cCodSgrp = ALLTRIM(loc_oPage.txt_4c_CodSgrupoDist.Value)
2068: 
2069:                 SELECT cursor_4c_Disponivel
2070: 
2071:                 IF EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2072:                     SET FILTER TO
2073:                 ELSE
2074:                     IF !EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2075:                     SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp
2076:                 ELSE
2077:                     IF EMPTY(loc_cCodGrp) AND !EMPTY(loc_cCodSgrp)
2078:                     SET FILTER TO ALLTRIM(Sgrus) = loc_cCodSgrp
2079:                 ELSE
2080:                     SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp ;
2081:                                   AND ALLTRIM(Sgrus) = loc_cCodSgrp
2082:                     ENDIF
2083:                     ENDIF
2084:                 ENDIF
2085: 
2086:                 GO TOP IN cursor_4c_Disponivel
2087:                 loc_oPage.grd_4c_Disponivel.Refresh()
2088:             ENDIF
2089: 
2090:         CATCH TO loc_oErro
2091:             MsgErro("Erro em FiltrarDisponivelClick:" + CHR(13) + loc_oErro.Message, "Erro")
2092:         ENDTRY
2093:     ENDPROC
2094: 
2095:     *==========================================================================
2096:     * ProdutoInicialValid - Navega grd_4c_Disponivel para o produto informado
2097:     *==========================================================================
2098:     PROCEDURE ProdutoInicialValid()
2099:         LOCAL loc_cProd, loc_oPage, loc_oErro
2100: 
2101:         TRY
2102:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2103:             loc_cProd = ALLTRIM(loc_oPage.txt_4c_ProdutoInicial.Value)
2104: 
2105:             IF !EMPTY(loc_cProd) AND USED("cursor_4c_Disponivel")
2106:                 SELECT cursor_4c_Disponivel
2107:                 GO TOP
2108:                 LOCATE FOR ALLTRIM(Cpros) >= loc_cProd
2109:                 IF !EOF("cursor_4c_Disponivel")
2110:                     loc_oPage.grd_4c_Disponivel.Refresh()
2111:                 ENDIF
2112:             ENDIF
2113: 
2114:         CATCH TO loc_oErro
2115:             MsgErro("Erro em ProdutoInicialValid:" + CHR(13) + loc_oErro.Message, "Erro")
2116:         ENDTRY
2117:     ENDPROC
2118: 
2119:     *==========================================================================
2120:     * PopularInfoProduto - Preenche o painel info com dados do produto selecionado
2121:     *==========================================================================
2122:     PROCEDURE PopularInfoProduto(par_cCodPro)
2123:         LOCAL loc_oPage, loc_cSQL, loc_nRet, loc_oErro
2124: 

*-- Linhas 2143 a 2198:
2143:             loc_oPage.txt_4c_DsModeloInfo.Value   = ""
2144: 
2145:             IF !EMPTY(ALLTRIM(par_cCodPro))
2146:                 loc_cSQL = "SELECT RTRIM(a.cgrus) AS cgrus, " + ;
2147:                     "RTRIM(ISNULL(g.dgrus,'')) AS dgrus, " + ;
2148:                     "RTRIM(a.sgrus) AS sgrus, " + ;
2149:                     "RTRIM(ISNULL(sg.descricaos,'')) AS dsgrus, " + ;
2150:                     "RTRIM(a.ifors) AS ifors, " + ;
2151:                     "RTRIM(ISNULL(c.rclis,'')) AS rclis, " + ;
2152:                     "RTRIM(a.reffs) AS reffs, " + ;
2153:                     "a.pvens, RTRIM(a.moedas) AS moedas, a.pesoms, " + ;
2154:                     "RTRIM(a.cvens) AS cvens, " + ;
2155:                     "RTRIM(ISNULL(col.descs,'')) AS dcvens, " + ;
2156:                     "RTRIM(a.linhas) AS linhas, " + ;
2157:                     "RTRIM(ISNULL(lin.descs,'')) AS dlinhas, " + ;
2158:                     "RTRIM(a.codfinp) AS codfinp, " + ;
2159:                     "RTRIM(ISNULL(finp.descs,'')) AS dcodfinp " + ;
2160:                     "FROM SigCdPro a " + ;
2161:                     "LEFT JOIN SigCdGrp g " + ;
2162:                     "    ON RTRIM(g.cgrus) = RTRIM(a.cgrus) " + ;
2163:                     "LEFT JOIN SigCdPsg sg " + ;
2164:                     "    ON sg.cgrus = RTRIM(a.cgrus) AND sg.codigos = RTRIM(a.sgrus) " + ;
2165:                     "LEFT JOIN SIGCDCLI c " + ;
2166:                     "    ON RTRIM(c.iclis) = RTRIM(a.ifors) " + ;
2167:                     "LEFT JOIN SigCdCol col " + ;
2168:                     "    ON RTRIM(col.colecoes) = RTRIM(a.cvens) " + ;
2169:                     "LEFT JOIN SigCdLin lin " + ;
2170:                     "    ON RTRIM(lin.linhas) = RTRIM(a.linhas) " + ;
2171:                     "LEFT JOIN SigCdFip finp " + ;
2172:                     "    ON RTRIM(finp.cods) = RTRIM(a.codfinp) " + ;
2173:                     "WHERE RTRIM(a.cpros) = " + EscaparSQL(par_cCodPro)
2174: 
2175:                 IF USED("cursor_4c_InfoPro")
2176:                     USE IN cursor_4c_InfoPro
2177:                 ENDIF
2178: 
2179:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InfoPro")
2180: 
2181:                 IF loc_nRet > 0 AND USED("cursor_4c_InfoPro") ;
2182:                    AND RECCOUNT("cursor_4c_InfoPro") > 0
2183:                     SELECT cursor_4c_InfoPro
2184:                     GO TOP
2185: 
2186:                     loc_oPage.txt_4c_CdGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.cgrus)
2187:                     loc_oPage.txt_4c_DsGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.dgrus)
2188:                     loc_oPage.txt_4c_CdSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.sgrus)
2189:                     loc_oPage.txt_4c_DsSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.dsgrus)
2190:                     loc_oPage.txt_4c_CdFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.ifors)
2191:                     loc_oPage.txt_4c_DsFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.rclis)
2192:                     loc_oPage.txt_4c_RefFornInfo.Value    = ALLTRIM(cursor_4c_InfoPro.reffs)
2193:                     loc_oPage.txt_4c_PrVendaInfo.Value    = LTRIM(STR(cursor_4c_InfoPro.pvens, 12, 2))
2194:                     loc_oPage.txt_4c_PrVendaMoeInfo.Value = ALLTRIM(cursor_4c_InfoPro.moedas)
2195:                     loc_oPage.txt_4c_PesoMedioInfo.Value  = LTRIM(STR(cursor_4c_InfoPro.pesoms, 10, 3))
2196:                     loc_oPage.txt_4c_CdGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.cvens)
2197:                     loc_oPage.txt_4c_DsGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.dcvens)
2198:                     loc_oPage.txt_4c_CdLinhaInfo.Value    = ALLTRIM(cursor_4c_InfoPro.linhas)

*-- Linhas 2323 a 2341:
2323:             .HighlightBackColor = RGB(255, 255, 255)
2324:             .HighlightForeColor = RGB(15, 41, 104)
2325:             .HighlightStyle     = 2
2326:             .DeleteMark         = .F.
2327:             .RecordMark         = .F.
2328:             .RowHeight          = 18
2329:             .ScrollBars         = 3
2330:             .GridLines          = 3
2331:             .ReadOnly           = .T.
2332:             .Visible            = .T.
2333:             .Column1.Header1.Caption = "Emp O"
2334:             .Column1.Width           = 55
2335:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2336:             .Column2.Width           = 110
2337:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
2338:             .Column3.Width           = 130
2339:             .Column4.Header1.Caption = "Emp D"
2340:             .Column4.Width           = 55
2341:             .Column5.Header1.Caption = "Grupo Orig"

*-- Linhas 2391 a 2409:
2391:             .HighlightBackColor = RGB(255, 255, 255)
2392:             .HighlightForeColor = RGB(15, 41, 104)
2393:             .HighlightStyle     = 2
2394:             .DeleteMark         = .F.
2395:             .RecordMark         = .F.
2396:             .RowHeight          = 18
2397:             .ScrollBars         = 3
2398:             .GridLines          = 3
2399:             .ReadOnly           = .T.
2400:             .Visible            = .T.
2401:             .Column1.Header1.Caption = "Item"
2402:             .Column1.Width           = 50
2403:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
2404:             .Column2.Width           = 100
2405:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2406:             .Column3.Width           = 200
2407:             .Column4.Header1.Caption = "Uni"
2408:             .Column4.Width           = 40
2409:             .Column5.Header1.Caption = "Quantidade"

*-- Linhas 2477 a 2497:
2477:     *==========================================================================
2478:     PROCEDURE BtnProcessarFinalClick()
2479:         LOCAL loc_oErro
2480: 
2481:         TRY
2482:             IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
2483:                 MsgAviso("Nenhuma distribui" + CHR(231) + CHR(227) + "o para processar." + ;
2484:                          CHR(13) + "Processe os estoques primeiro.", "Processar")
2485:             ELSE
2486:                 IF THIS.this_oBusinessObject.SalvarLote()
2487:                     MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso!", "")
2488:                     THIS.CarregarCabOperas()
2489:                     THIS.CarregarItnOperas()
2490:                 ENDIF
2491:             ENDIF
2492: 
2493:         CATCH TO loc_oErro
2494:             MsgErro("Erro em BtnProcessarFinalClick:" + CHR(13) + loc_oErro.Message, "Erro")
2495:         ENDTRY
2496:     ENDPROC
2497: 

*-- Linhas 2514 a 2566:
2514:                 USE IN cursor_4c_CabOperasTemp
2515:             ENDIF
2516: 
2517:             loc_cSQL = "SELECT DISTINCT RTRIM(c.emps) AS emps, " + ;
2518:                        "RTRIM(c.dopes) AS dopes, " + ;
2519:                        "c.numes AS numes, " + ;
2520:                        "RTRIM(c.empds) AS empds, " + ;
2521:                        "RTRIM(c.grupoos) AS grupoos, RTRIM(c.contaos) AS contaos, " + ;
2522:                        "RTRIM(c.grupods) AS grupods, RTRIM(c.contads) AS contads " + ;
2523:                        "FROM SigMvCab c " + ;
2524:                        "WHERE EXISTS (" + ;
2525:                        " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2526:                        " AND (RTRIM(d.empdopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2527:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)" + ;
2528:                        " OR RTRIM(d.oridopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2529:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)))" + ;
2530:                        " ORDER BY c.emps, c.dopes"
2531: 
2532:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOperasTemp")
2533: 
2534:             IF loc_nRet < 0
2535:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
2536:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2537:             ELSE
2538:                 SELECT * FROM cursor_4c_CabOperasTemp INTO CURSOR cursor_4c_CabOperas READWRITE
2539:                 IF USED("cursor_4c_CabOperasTemp")
2540:                     USE IN cursor_4c_CabOperasTemp
2541:                 ENDIF
2542:                 loc_oGrid.ColumnCount = 8
2543:                 loc_oGrid.RecordSource = "cursor_4c_CabOperas"
2544:                 loc_oGrid.Column1.txt_4c_Col01.ControlSource = "cursor_4c_CabOperas.emps"
2545:                 loc_oGrid.Column2.txt_4c_Col02.ControlSource = "cursor_4c_CabOperas.dopes"
2546:                 loc_oGrid.Column3.txt_4c_Col03.ControlSource = "cursor_4c_CabOperas.numes"
2547:                 loc_oGrid.Column4.txt_4c_Col04.ControlSource = "cursor_4c_CabOperas.empds"
2548:                 loc_oGrid.Column5.txt_4c_Col05.ControlSource = "cursor_4c_CabOperas.grupoos"
2549:                 loc_oGrid.Column6.txt_4c_Col06.ControlSource = "cursor_4c_CabOperas.contaos"
2550:                 loc_oGrid.Column7.txt_4c_Col07.ControlSource = "cursor_4c_CabOperas.grupods"
2551:                 loc_oGrid.Column8.txt_4c_Col08.ControlSource = "cursor_4c_CabOperas.contads"
2552:                 loc_oGrid.Refresh()
2553:             ENDIF
2554: 
2555:         CATCH TO loc_oErro
2556:             MsgErro("Erro em CarregarCabOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2557:         ENDTRY
2558:     ENDPROC
2559: 
2560:     *==========================================================================
2561:     * CarregarItnOperas - Carrega grd_4c_ItnOperas com itens de movimentos do lote
2562:     *==========================================================================
2563:     PROTECTED PROCEDURE CarregarItnOperas()
2564:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2565:         loc_oErro = .NULL.
2566: 

*-- Linhas 2576 a 2655:
2576:                 USE IN cursor_4c_ItnOperasTemp
2577:             ENDIF
2578: 
2579:             loc_cSQL = "SELECT RTRIM(b.cItens) AS Citens, RTRIM(b.CPros) AS CPros, " + ;
2580:                        "RTRIM(ISNULL(b.DPros,'')) AS Dpros, " + ;
2581:                        "RTRIM(b.Cunis) AS CUnis, b.Qtds, b.Units, b.totas, " + ;
2582:                        "RTRIM(c.CodCors) AS CodCors, RTRIM(c.CodTams) AS CodTams " + ;
2583:                        "FROM (SELECT DISTINCT d.EmpDopNums FROM sigprdis d" + ;
2584:                        " WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2585:                        " AND RTRIM(d.EmpDopNums) <> '') x " + ;
2586:                        "INNER JOIN SigMvItn b ON x.EmpDopNums = b.EmpDopNums " + ;
2587:                        "INNER JOIN SigMvIts c ON b.EmpDopNums = c.EmpDopNums" + ;
2588:                        " AND b.cItens = c.Citens " + ;
2589:                        "ORDER BY b.cItens"
2590: 
2591:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOperasTemp")
2592: 
2593:             IF loc_nRet < 0
2594:                 MsgErro("Erro ao carregar itens de opera" + CHR(231) + CHR(245) + "es:" + ;
2595:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2596:             ELSE
2597:                 SELECT * FROM cursor_4c_ItnOperasTemp INTO CURSOR cursor_4c_ItnOperas READWRITE
2598:                 IF USED("cursor_4c_ItnOperasTemp")
2599:                     USE IN cursor_4c_ItnOperasTemp
2600:                 ENDIF
2601:                 loc_oGrid.ColumnCount = 9
2602:                 loc_oGrid.RecordSource = "cursor_4c_ItnOperas"
2603:                 loc_oGrid.Column1.txt_4c_Itn01.ControlSource = "cursor_4c_ItnOperas.Citens"
2604:                 loc_oGrid.Column2.txt_4c_Itn02.ControlSource = "cursor_4c_ItnOperas.CPros"
2605:                 loc_oGrid.Column3.txt_4c_Itn03.ControlSource = "cursor_4c_ItnOperas.Dpros"
2606:                 loc_oGrid.Column4.txt_4c_Itn04.ControlSource = "cursor_4c_ItnOperas.CUnis"
2607:                 loc_oGrid.Column5.txt_4c_Itn05.ControlSource = "cursor_4c_ItnOperas.Qtds"
2608:                 loc_oGrid.Column6.txt_4c_Itn06.ControlSource = "cursor_4c_ItnOperas.Units"
2609:                 loc_oGrid.Column7.txt_4c_Itn07.ControlSource = "cursor_4c_ItnOperas.totas"
2610:                 loc_oGrid.Column8.txt_4c_Itn08.ControlSource = "cursor_4c_ItnOperas.CodCors"
2611:                 loc_oGrid.Column9.txt_4c_Itn09.ControlSource = "cursor_4c_ItnOperas.CodTams"
2612:                 loc_oGrid.Refresh()
2613:             ENDIF
2614: 
2615:         CATCH TO loc_oErro
2616:             MsgErro("Erro em CarregarItnOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2617:         ENDTRY
2618:     ENDPROC
2619: 
2620:     *==========================================================================
2621:     * Destroy - Libera recursos ao fechar
2622:     *==========================================================================
2623:     PROCEDURE Destroy()
2624:         IF USED("cursor_4c_Lista")
2625:             USE IN cursor_4c_Lista
2626:         ENDIF
2627:         IF USED("cursor_4c_ListaTemp")
2628:             USE IN cursor_4c_ListaTemp
2629:         ENDIF
2630:         IF USED("cursor_4c_Estoque")
2631:             USE IN cursor_4c_Estoque
2632:         ENDIF
2633:         IF USED("cursor_4c_EstoqueTemp")
2634:             USE IN cursor_4c_EstoqueTemp
2635:         ENDIF
2636:         IF USED("cursor_4c_Disponivel")
2637:             USE IN cursor_4c_Disponivel
2638:         ENDIF
2639:         IF USED("cursor_4c_Distribui")
2640:             USE IN cursor_4c_Distribui
2641:         ENDIF
2642:         IF USED("cursor_4c_InfoPro")
2643:             USE IN cursor_4c_InfoPro
2644:         ENDIF
2645:         IF USED("cursor_4c_CabOperas")
2646:             USE IN cursor_4c_CabOperas
2647:         ENDIF
2648:         IF USED("cursor_4c_CabOperasTemp")
2649:             USE IN cursor_4c_CabOperasTemp
2650:         ENDIF
2651:         IF USED("cursor_4c_ItnOperas")
2652:             USE IN cursor_4c_ItnOperas
2653:         ENDIF
2654:         IF USED("cursor_4c_ItnOperasTemp")
2655:             USE IN cursor_4c_ItnOperasTemp


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

