# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (21)
- [GRID-SQL] Campo 'emps' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dopes' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'numes' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'empdopnums' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cpros' usado em ControlSource de cursor_4c_ItensOper mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcors' usado em ControlSource de cursor_4c_ItensOper mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codtams' usado em ControlSource de cursor_4c_ItensOper mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'qtds' usado em ControlSource de cursor_4c_ItensOper mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'locals' usado em ControlSource de cursor_4c_ItensOper mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'nMarca' usado em ControlSource de cursor_4c_Estoques mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'emps' usado em ControlSource de cursor_4c_Estoques mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_Estoques mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contas' usado em ControlSource de cursor_4c_Estoques mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cpros' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dpros' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcors' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codtams' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtdEstoque' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtdSaida' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtdSaldo' usado em ControlSource de cursor_4c_Disponivel mas NAO aparece no SELECT SQL

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS SQL (1753 linhas total):

*-- Linhas 36 a 60:
36:     *==========================================================================
37:     PROCEDURE Destroy()
38:     *==========================================================================
39:         LOCAL loc_aCursores[8], loc_i
40:         loc_aCursores[1] = "cursor_4c_Dados"
41:         loc_aCursores[2] = "cursor_4c_Estoques"
42:         loc_aCursores[3] = "cursor_4c_Disponivel"
43:         loc_aCursores[4] = "cursor_4c_Distribui"
44:         loc_aCursores[5] = "cursor_4c_CabOpera"
45:         loc_aCursores[6] = "cursor_4c_ItensOper"
46:         loc_aCursores[7] = "cursor_4c_LotePrDis"
47:         loc_aCursores[8] = "cursor_4c_Produto"
48:         FOR loc_i = 1 TO 8
49:             IF USED(loc_aCursores[loc_i])
50:                 USE IN (loc_aCursores[loc_i])
51:             ENDIF
52:         NEXT loc_i
53:         DODEFAULT()
54:     ENDPROC
55: 
56:     *==========================================================================
57:     PROTECTED PROCEDURE InicializarForm()
58:     *==========================================================================
59:         LOCAL loc_lSucesso, loc_oErro
60:         loc_lSucesso = .F.

*-- Linhas 66 a 92:
66:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
67:                 MsgErro("Erro ao criar sigprdisBO.", "Erro InicializarForm")
68:             ELSE
69:                 *-- Placeholders para ControlSource em DataSession=2
70:                 *-- Fechados/substituidos pelos metodos do BO antes de cada SQLEXEC
71:                 SET NULL ON
72:                 CREATE CURSOR cursor_4c_Dados (Codigos C(20), Datas T)
73:                 CREATE CURSOR cursor_4c_Estoques (nMarca N(1), cidchaves C(36), emps C(4), grupos C(10), contas C(15))
74:                 CREATE CURSOR cursor_4c_Disponivel (cpros C(14), dpros C(65), codcors C(4), codtams C(4), QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
75:                 CREATE CURSOR cursor_4c_Distribui (emps C(4), grupos C(10), contas C(15), QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
76:                 CREATE CURSOR cursor_4c_CabOpera (emps C(4), dopes C(20), numes C(10), datas T, grupos C(10), empdopnums C(40))
77:                 CREATE CURSOR cursor_4c_ItensOper (cpros C(14), codcors C(4), codtams C(4), qtds N(10,2), locals C(10))
78:                 SET NULL OFF
79: 
80:                 THIS.ConfigurarPageFrame()
81:                 THIS.ConfigurarCabecalho()
82:                 THIS.ConfigurarSaida()
83:                 THIS.ConfigurarPaginaLista()
84:                 THIS.ConfigurarPaginaDados()
85: 
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
88: 
89:                 *-- Page1 BINDEVENTs
90:                 LOCAL loc_oPg1 AS Object
91:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
92:                 BINDEVENT(loc_oPg1.txt_4c_DtInicial, "LostFocus",     THIS, "TxtDtInicialValid")

*-- Linhas 394 a 426:
394:             .RecordSource      = ""
395:             .RecordSourceType  = 1
396:             .ColumnCount       = 2
397:             .DeleteMark        = .F.
398:             .RecordMark        = .F.
399:             .GridLines         = 1
400:             .ReadOnly          = .T.
401:             .Themes            = .F.
402:             .FontName          = "Tahoma"
403:             .FontSize          = 8
404:         ENDWITH
405:         WITH loc_oPg1.grd_4c_Grade.Column1
406:             .ControlSource   = "cursor_4c_Dados.Codigos"
407:             .Width           = 140
408:             .Header1.Caption = "C" + CHR(243) + "digo"
409:         ENDWITH
410:         WITH loc_oPg1.grd_4c_Grade.Column2
411:             .ControlSource   = "cursor_4c_Dados.Datas"
412:             .Width           = 700
413:             .Header1.Caption = ""
414:         ENDWITH
415:     ENDPROC
416: 
417:     *==========================================================================
418:     PROTECTED PROCEDURE ConfigurarPaginaDados()
419:     *==========================================================================
420:         LOCAL loc_oPg2 AS Object
421:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
422: 
423:         loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
424:         WITH loc_oPg2.cmd_4c_VoltarLista
425:             .Caption  = CHR(171) + " Lista"
426:             .Left     = 5

*-- Linhas 552 a 603:
552:             .RecordSource     = ""
553:             .RecordSourceType = 1
554:             .ColumnCount      = 4
555:             .DeleteMark       = .F.
556:             .RecordMark       = .F.
557:             .GridLines        = 1
558:             .Themes           = .F.
559:             .FontName         = "Tahoma"
560:             .FontSize         = 8
561:         ENDWITH
562:         WITH loc_oSub.grd_4c_Estoques.Column1
563:             .ControlSource   = "cursor_4c_Estoques.nMarca"
564:             .Width           = 30
565:             .Sparse          = .F.
566:             .Header1.Caption = ""
567:         ENDWITH
568:         loc_oSub.grd_4c_Estoques.Column1.AddObject("chk_4c_Marca", "CheckBox")
569:         WITH loc_oSub.grd_4c_Estoques.Column1.chk_4c_Marca
570:             .Caption = ""
571:             .Width   = 24
572:             .Height  = 17
573:         ENDWITH
574:         loc_oSub.grd_4c_Estoques.Column1.CurrentControl = "chk_4c_Marca"
575:         WITH loc_oSub.grd_4c_Estoques.Column2
576:             .ControlSource   = "cursor_4c_Estoques.emps"
577:             .Width           = 55
578:             .ReadOnly        = .T.
579:             .Header1.Caption = "Empresa"
580:         ENDWITH
581:         WITH loc_oSub.grd_4c_Estoques.Column3
582:             .ControlSource   = "cursor_4c_Estoques.grupos"
583:             .Width           = 90
584:             .ReadOnly        = .T.
585:             .Header1.Caption = "Grupo"
586:         ENDWITH
587:         WITH loc_oSub.grd_4c_Estoques.Column4
588:             .ControlSource   = "cursor_4c_Estoques.contas"
589:             .Width           = 90
590:             .ReadOnly        = .T.
591:             .Header1.Caption = "Conta"
592:         ENDWITH
593:     ENDPROC
594: 
595:     *==========================================================================
596:     PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
597:     *==========================================================================
598:         LOCAL loc_oSub AS Object
599:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
600: 
601:         loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
602:         WITH loc_oSub.cmd_4c_VoltarEst
603:             .Caption  = CHR(171) + " Estoques"

*-- Linhas 719 a 816:
719:             .RecordSource     = ""
720:             .RecordSourceType = 1
721:             .ColumnCount      = 7
722:             .DeleteMark       = .F.
723:             .RecordMark       = .F.
724:             .GridLines        = 1
725:             .ReadOnly         = .T.
726:             .Themes           = .F.
727:             .FontName         = "Tahoma"
728:             .FontSize         = 8
729:         ENDWITH
730:         WITH loc_oSub.grd_4c_Disponivel.Column1
731:             .ControlSource   = "cursor_4c_Disponivel.cpros"
732:             .Width           = 90
733:             .Header1.Caption = "C" + CHR(243) + "digo"
734:         ENDWITH
735:         WITH loc_oSub.grd_4c_Disponivel.Column2
736:             .ControlSource   = "cursor_4c_Disponivel.dpros"
737:             .Width           = 140
738:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
739:         ENDWITH
740:         WITH loc_oSub.grd_4c_Disponivel.Column3
741:             .ControlSource   = "cursor_4c_Disponivel.codcors"
742:             .Width           = 55
743:             .Header1.Caption = "Cor"
744:         ENDWITH
745:         WITH loc_oSub.grd_4c_Disponivel.Column4
746:             .ControlSource   = "cursor_4c_Disponivel.codtams"
747:             .Width           = 55
748:             .Header1.Caption = "Tam"
749:         ENDWITH
750:         WITH loc_oSub.grd_4c_Disponivel.Column5
751:             .ControlSource   = "cursor_4c_Disponivel.QtdEstoque"
752:             .Width           = 80
753:             .Header1.Caption = "Estoque"
754:         ENDWITH
755:         WITH loc_oSub.grd_4c_Disponivel.Column6
756:             .ControlSource   = "cursor_4c_Disponivel.QtdSaida"
757:             .Width           = 80
758:             .Header1.Caption = "Distribuido"
759:         ENDWITH
760:         WITH loc_oSub.grd_4c_Disponivel.Column7
761:             .ControlSource   = "cursor_4c_Disponivel.QtdSaldo"
762:             .Width           = 80
763:             .Header1.Caption = "Saldo"
764:         ENDWITH
765: 
766:         *-- Distribui grid (Column3=QtdDistr editable, Column4=locals editable)
767:         loc_oSub.AddObject("grd_4c_Distribui", "Grid")
768:         WITH loc_oSub.grd_4c_Distribui
769:             .Left             = 664
770:             .Top              = 141
771:             .Width            = 234
772:             .Height           = 327
773:             .RecordSource     = ""
774:             .RecordSourceType = 1
775:             .ColumnCount      = 4
776:             .DeleteMark       = .F.
777:             .RecordMark       = .F.
778:             .GridLines        = 1
779:             .Themes           = .F.
780:             .FontName         = "Tahoma"
781:             .FontSize         = 8
782:         ENDWITH
783:         WITH loc_oSub.grd_4c_Distribui.Column1
784:             .ControlSource   = "cursor_4c_Distribui.emps"
785:             .Width           = 50
786:             .ReadOnly        = .T.
787:             .Header1.Caption = "Empresa"
788:         ENDWITH
789:         WITH loc_oSub.grd_4c_Distribui.Column2
790:             .ControlSource   = "cursor_4c_Distribui.QtdSaldo"
791:             .Width           = 55
792:             .ReadOnly        = .T.
793:             .Header1.Caption = "Saldo"
794:         ENDWITH
795:         WITH loc_oSub.grd_4c_Distribui.Column3
796:             .ControlSource   = "cursor_4c_Distribui.QtdDistr"
797:             .Width           = 65
798:             .Header1.Caption = "Quantidade"
799:         ENDWITH
800:         WITH loc_oSub.grd_4c_Distribui.Column4
801:             .ControlSource   = "cursor_4c_Distribui.locals"
802:             .Width           = 55
803:             .Header1.Caption = "Local"
804:         ENDWITH
805: 
806:         *-- Product info panel (read-only) - bottom of page
807:         loc_oSub.AddObject("lbl_4c_LblGrupoP", "Label")
808:         WITH loc_oSub.lbl_4c_LblGrupoP
809:             .Caption   = "Grupo :"
810:             .Left      = 67
811:             .Top       = 474
812:             .Width     = 45
813:             .Height    = 15
814:             .AutoSize  = .F.
815:             .BackStyle = 0
816:             .FontName  = "Tahoma"

*-- Linhas 997 a 1209:
997:             .RecordSource     = ""
998:             .RecordSourceType = 1
999:             .ColumnCount      = 6
1000:             .DeleteMark       = .F.
1001:             .RecordMark       = .F.
1002:             .GridLines        = 1
1003:             .ReadOnly         = .T.
1004:             .Themes           = .F.
1005:             .FontName         = "Tahoma"
1006:             .FontSize         = 8
1007:         ENDWITH
1008:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1
1009:             .ControlSource   = "cursor_4c_CabOpera.emps"
1010:             .Width           = 55
1011:             .Header1.Caption = "Emp O"
1012:         ENDWITH
1013:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2
1014:             .ControlSource   = "cursor_4c_CabOpera.dopes"
1015:             .Width           = 110
1016:             .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1017:         ENDWITH
1018:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3
1019:             .ControlSource   = "cursor_4c_CabOpera.numes"
1020:             .Width           = 80
1021:             .Header1.Caption = ""
1022:         ENDWITH
1023:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4
1024:             .ControlSource   = "cursor_4c_CabOpera.datas"
1025:             .Width           = 130
1026:             .Header1.Caption = ""
1027:         ENDWITH
1028:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5
1029:             .ControlSource   = "cursor_4c_CabOpera.grupos"
1030:             .Width           = 100
1031:             .Header1.Caption = "Grupo Orig"
1032:         ENDWITH
1033:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6
1034:             .ControlSource   = "cursor_4c_CabOpera.empdopnums"
1035:             .Width           = 180
1036:             .Header1.Caption = "Emp+Op+Num"
1037:         ENDWITH
1038: 
1039:         *-- grdItnOperas
1040:         loc_oSub.pgf_4c_Operacoes.Page2.AddObject("grd_4c_ItnOperas", "Grid")
1041:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
1042:             .Left             = 5
1043:             .Top              = 5
1044:             .Width            = 880
1045:             .Height           = 280
1046:             .RecordSource     = ""
1047:             .RecordSourceType = 1
1048:             .ColumnCount      = 5
1049:             .DeleteMark       = .F.
1050:             .RecordMark       = .F.
1051:             .GridLines        = 1
1052:             .ReadOnly         = .T.
1053:             .Themes           = .F.
1054:             .FontName         = "Tahoma"
1055:             .FontSize         = 8
1056:         ENDWITH
1057:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1
1058:             .ControlSource   = "cursor_4c_ItensOper.cpros"
1059:             .Width           = 110
1060:             .Header1.Caption = "C" + CHR(243) + "digo"
1061:         ENDWITH
1062:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2
1063:             .ControlSource   = "cursor_4c_ItensOper.codcors"
1064:             .Width           = 60
1065:             .Header1.Caption = "Cor"
1066:         ENDWITH
1067:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3
1068:             .ControlSource   = "cursor_4c_ItensOper.codtams"
1069:             .Width           = 60
1070:             .Header1.Caption = "Tam"
1071:         ENDWITH
1072:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4
1073:             .ControlSource   = "cursor_4c_ItensOper.qtds"
1074:             .Width           = 90
1075:             .Header1.Caption = "Quantidade"
1076:         ENDWITH
1077:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5
1078:             .ControlSource   = "cursor_4c_ItensOper.locals"
1079:             .Width           = 110
1080:             .Header1.Caption = "Local"
1081:         ENDWITH
1082:     ENDPROC
1083: 
1084:     *==========================================================================
1085:     * METODOS DE NEGOCIO
1086:     *==========================================================================
1087: 
1088:     PROCEDURE CarregarLista()
1089:     *==========================================================================
1090:         THIS.this_oBusinessObject.this_dDataInicial = ;
1091:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value
1092:         THIS.this_oBusinessObject.this_dDataFinal = ;
1093:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value
1094:         THIS.this_oBusinessObject.Buscar("")
1095:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = ""
1096:         IF USED("cursor_4c_Dados")
1097:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 3
1098:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1099:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1100:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1101:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.Datas"
1102:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.Header1.Caption = ""
1103:         ENDIF
1104:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1105:     ENDPROC
1106: 
1107:     PROCEDURE AbrirNovoBatch()
1108:     *==========================================================================
1109:         THIS.this_cEscolha = "INSERIR"
1110:         THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
1111:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
1112:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"
1113: 
1114:         IF THIS.this_oBusinessObject.BuscarEstoques()
1115:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1116:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1117:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1118:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1119:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1120:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1121:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1122:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1123:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1124:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1125:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1126:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1127:         ENDIF
1128: 
1129:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1130:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
1131:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1132:         THIS.pgf_4c_Paginas.ActivePage = 2
1133:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1134:     ENDPROC
1135: 
1136:     PROCEDURE AbrirBatchExistente(par_cCodigos)
1137:     *==========================================================================
1138:         THIS.this_cEscolha = "ALTERAR"
1139:         THIS.this_cCodigos = par_cCodigos
1140:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
1141:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"
1142: 
1143:         THIS.this_oBusinessObject.InicializarLote(par_cCodigos)
1144: 
1145:         IF THIS.this_oBusinessObject.BuscarEstoques()
1146:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1147:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1148:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1149:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1150:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1151:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1152:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1153:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1154:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1155:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1156:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1157:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1158:         ENDIF
1159: 
1160:         *-- Pre-marcar estoques do lote
1161:         IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")
1162:             LOCAL loc_cEmpEst AS String
1163:             SELECT cursor_4c_Estoques
1164:             GO TOP
1165:             DO WHILE !EOF("cursor_4c_Estoques")
1166:                 loc_cEmpEst = ALLTRIM(cursor_4c_Estoques.emps)
1167:                 SELECT cursor_4c_LotePrDis
1168:                 LOCATE FOR ALLTRIM(empds) = loc_cEmpEst
1169:                 IF FOUND()
1170:                     REPLACE nMarca WITH 1 IN cursor_4c_Estoques
1171:                 ENDIF
1172:                 SELECT cursor_4c_Estoques
1173:                 SKIP
1174:             ENDDO
1175:             GO TOP IN cursor_4c_Estoques
1176:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1177:         ENDIF
1178: 
1179:         *-- Carregar operacoes existentes
1180:         IF THIS.this_oBusinessObject.BuscarOperacoes(par_cCodigos)
1181:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = ""
1182:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.ColumnCount = 6
1183:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = "cursor_4c_CabOpera"
1184:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.ControlSource = "cursor_4c_CabOpera.emps"
1185:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.Header1.Caption = "Emp O"
1186:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.ControlSource = "cursor_4c_CabOpera.dopes"
1187:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1188:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.ControlSource = "cursor_4c_CabOpera.numes"
1189:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.Header1.Caption = ""
1190:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.ControlSource = "cursor_4c_CabOpera.datas"
1191:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.Header1.Caption = ""
1192:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.ControlSource = "cursor_4c_CabOpera.grupos"
1193:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.Header1.Caption = "Grupo Orig"
1194:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.ControlSource = "cursor_4c_CabOpera.empdopnums"
1195:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.Header1.Caption = "Emp+Op+Num"
1196:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Refresh()
1197:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .T.
1198:         ENDIF
1199: 
1200:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1201:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1202:         THIS.pgf_4c_Paginas.ActivePage = 2
1203:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1204:     ENDPROC
1205: 
1206:     *==========================================================================
1207:     * HANDLERS DE EVENTOS
1208:     *==========================================================================
1209: 

*-- Linhas 1221 a 1239:
1221:     *==========================================================================
1222:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 ;
1223:                 AND !EOF("cursor_4c_Dados")
1224:             SELECT cursor_4c_Dados
1225:             LOCAL loc_cCodigos AS String
1226:             loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1227:             IF !EMPTY(loc_cCodigos)
1228:                 THIS.AbrirBatchExistente(loc_cCodigos)
1229:             ENDIF
1230:         ELSE
1231:             MsgAviso("Selecione um lote na lista.", "Aviso")
1232:         ENDIF
1233:     ENDPROC
1234: 
1235:     PROCEDURE TxtDtInicialValid()
1236:     *==========================================================================
1237:         LOCAL loc_oDtI AS Object, loc_oDtF AS Object
1238:         loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
1239:         loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal

*-- Linhas 1276 a 1426:
1276:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1277:     ENDPROC
1278: 
1279:     PROCEDURE BtnMarcarClick()
1280:     *==========================================================================
1281:         IF USED("cursor_4c_Estoques")
1282:             SELECT cursor_4c_Estoques
1283:             REPLACE ALL nMarca WITH 1
1284:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1285:         ENDIF
1286:     ENDPROC
1287: 
1288:     PROCEDURE BtnDesmarcarClick()
1289:     *==========================================================================
1290:         IF USED("cursor_4c_Estoques")
1291:             SELECT cursor_4c_Estoques
1292:             REPLACE ALL nMarca WITH 0
1293:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1294:         ENDIF
1295:     ENDPROC
1296: 
1297:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1298:     *==========================================================================
1299:         NODEFAULT
1300:         IF USED("cursor_4c_Estoques")
1301:             SELECT cursor_4c_Estoques
1302:             REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1303:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1304:         ENDIF
1305:     ENDPROC
1306: 
1307:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1308:     *==========================================================================
1309:         IF INLIST(par_nKeyCode, 13, 32)
1310:             IF USED("cursor_4c_Estoques")
1311:                 SELECT cursor_4c_Estoques
1312:                 REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1313:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1314:             ENDIF
1315:         ENDIF
1316:     ENDPROC
1317: 
1318:     PROCEDURE BtnProcessarPage1Click()
1319:     *==========================================================================
1320:         IF THIS.this_oBusinessObject.PrepararCursoresDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
1321:             LOCAL loc_oSub2 AS Object
1322:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1323:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1324:             IF USED("cursor_4c_Disponivel")
1325:                 loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1326:                 loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1327:                 loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1328:                 loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1329:                 loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1330:                 loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1331:                 loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1332:                 loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1333:                 loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1334:                 loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1335:                 loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1336:                 loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1337:                 loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1338:                 loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
1339:                 loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1340:                 loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1341:             ENDIF
1342:             loc_oSub2.grd_4c_Disponivel.Refresh()
1343:             loc_oSub2.grd_4c_Distribui.RecordSource = ""
1344:             IF USED("cursor_4c_Distribui")
1345:                 loc_oSub2.grd_4c_Distribui.ColumnCount = 4
1346:                 loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
1347:                 loc_oSub2.grd_4c_Distribui.Column1.ControlSource = "cursor_4c_Distribui.emps"
1348:                 loc_oSub2.grd_4c_Distribui.Column1.Header1.Caption = "Empresa"
1349:                 loc_oSub2.grd_4c_Distribui.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1350:                 loc_oSub2.grd_4c_Distribui.Column2.Header1.Caption = "Saldo"
1351:                 loc_oSub2.grd_4c_Distribui.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1352:                 loc_oSub2.grd_4c_Distribui.Column3.Header1.Caption = "Quantidade"
1353:                 loc_oSub2.grd_4c_Distribui.Column4.ControlSource = "cursor_4c_Distribui.locals"
1354:                 loc_oSub2.grd_4c_Distribui.Column4.Header1.Caption = "Local"
1355:             ENDIF
1356:             loc_oSub2.grd_4c_Distribui.Refresh()
1357:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
1358:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
1359:             loc_oSub2.grd_4c_Disponivel.SetFocus()
1360:         ENDIF
1361:     ENDPROC
1362: 
1363:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1364:     *==========================================================================
1365:         IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel")
1366:             LOCAL loc_cCpros AS String
1367:             SELECT cursor_4c_Disponivel
1368:             loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
1369:             IF !EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.BuscarProduto(loc_cCpros)
1370:                 LOCAL loc_oSub2 AS Object
1371:                 loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1372:                 SELECT cursor_4c_Produto
1373:                 loc_oSub2.txt_4c_CdGrupo.Value      = TratarNulo(cgrus,  "C")
1374:                 loc_oSub2.txt_4c_DsGrupoP.Value     = TratarNulo(dgrus,  "C")
1375:                 loc_oSub2.txt_4c_CdFornecedor.Value = TratarNulo(ifors,  "C")
1376:                 loc_oSub2.txt_4c_DsFornecedor.Value = TratarNulo(rclis,  "C")
1377:                 loc_oSub2.txt_4c_MoedaPrVenda.Value = TratarNulo(moevs,  "C")
1378:                 loc_oSub2.txt_4c_PrVenda.Value      = TratarNulo(pvens,  "N")
1379:             ENDIF
1380:         ENDIF
1381:     ENDPROC
1382: 
1383:     PROCEDURE GrdDistribuiQtdLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1384:     *==========================================================================
1385:         IF USED("cursor_4c_Disponivel") AND USED("cursor_4c_Distribui") ;
1386:                 AND !EOF("cursor_4c_Disponivel")
1387:             LOCAL loc_cCpros AS String, loc_cCodCors AS String, loc_cCodTams AS String
1388:             SELECT cursor_4c_Disponivel
1389:             loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
1390:             loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
1391:             loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)
1392:             THIS.this_oBusinessObject.CalcularSaldo(loc_cCpros, loc_cCodCors, loc_cCodTams)
1393:             LOCAL loc_oSub2 AS Object
1394:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1395:             loc_oSub2.grd_4c_Disponivel.Refresh()
1396:             loc_oSub2.grd_4c_Distribui.Refresh()
1397:         ENDIF
1398:     ENDPROC
1399: 
1400:     PROCEDURE GrdDistribuiLocalValid()
1401:     *==========================================================================
1402:         LOCAL loc_cLocal AS String, loc_nRes AS Number, loc_oLookup AS Object
1403:         LOCAL loc_lSucesso, loc_oErro
1404:         loc_lSucesso = .F.
1405:         TRY
1406:             loc_cLocal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2 ;
1407:                 .grd_4c_Distribui.Column4.Text1.Value)
1408:             IF !EMPTY(loc_cLocal)
1409:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1410:                     "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos LIKE " + ;
1411:                     EscaparSQL(loc_cLocal + "%") + " ORDER BY Codigos", ;
1412:                     "cursor_4c_Locais", "Codigos", loc_cLocal, ;
1413:                     "Localiza" + CHR(231) + CHR(227) + "o")
1414:                 IF VARTYPE(loc_oLookup) = "O"
1415:                     loc_oLookup.AddColuna("Codigos",    "", "Localiza" + CHR(231) + CHR(227) + "o")
1416:                     loc_oLookup.AddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1417:                     loc_oLookup.Show()
1418:                     IF USED("cursor_4c_Locais") AND RECCOUNT("cursor_4c_Locais") > 0
1419:                         IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
1420:                             REPLACE cursor_4c_Distribui.locals WITH ALLTRIM(cursor_4c_Locais.Codigos)
1421:                         ENDIF
1422:                     ENDIF
1423:                     IF USED("cursor_4c_Locais")
1424:                         USE IN cursor_4c_Locais
1425:                     ENDIF
1426:                 ENDIF

*-- Linhas 1446 a 1467:
1446: 
1447:     PROCEDURE TxtProdutoInicialValid()
1448:     *==========================================================================
1449:         LOCAL loc_cCpros AS String, loc_nRec AS Number
1450:         loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.txt_4c_ProdutoInicial.Value)
1451:         IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Disponivel")
1452:             SELECT cursor_4c_Disponivel
1453:             loc_nRec = RECNO()
1454:             GO TOP
1455:             LOCATE FOR ALLTRIM(cpros) >= loc_cCpros
1456:             IF EOF()
1457:                 GO loc_nRec
1458:             ENDIF
1459:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Refresh()
1460:         ENDIF
1461:     ENDPROC
1462: 
1463:     PROCEDURE TxtCGrupoValid(par_nKeyCode, par_nShiftAltCtrl)
1464:     *==========================================================================
1465:         LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
1466:         LOCAL loc_oSub2 AS Object
1467:         loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2

*-- Linhas 1477 a 1514:
1477:                 IF USED("cursor_4c_GrpBusca")
1478:                     USE IN cursor_4c_GrpBusca
1479:                 ENDIF
1480:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1481:                     "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
1482:                     EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", "cursor_4c_GrpBusca")
1483:                 IF loc_nRes > 0 AND USED("cursor_4c_GrpBusca") AND RECCOUNT("cursor_4c_GrpBusca") > 0
1484:                     IF RECCOUNT("cursor_4c_GrpBusca") = 1
1485:                         SELECT cursor_4c_GrpBusca
1486:                         loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBusca.CGrus)
1487:                         loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBusca.DGrus)
1488:                         THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBusca.CGrus)
1489:                     ELSE
1490:                         loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1491:                             "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
1492:                             EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", ;
1493:                             "cursor_4c_GrpBuscaD", "CGrus", loc_cCodigo, "Grupos")
1494:                         IF VARTYPE(loc_oLookup) = "O"
1495:                             loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1496:                             loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1497:                             loc_oLookup.Show()
1498:                             IF USED("cursor_4c_GrpBuscaD") AND RECCOUNT("cursor_4c_GrpBuscaD") > 0
1499:                                 SELECT cursor_4c_GrpBuscaD
1500:                                 loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
1501:                                 loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaD.DGrus)
1502:                                 THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
1503:                             ENDIF
1504:                             IF USED("cursor_4c_GrpBuscaD")
1505:                                 USE IN cursor_4c_GrpBuscaD
1506:                             ENDIF
1507:                         ENDIF
1508:                     ENDIF
1509:                 ELSE
1510:                     loc_oSub2.txt_4c_CodGrupo.Value = ""
1511:                     loc_oSub2.txt_4c_DsGrupo.Value  = ""
1512:                     THIS.this_cUltimoCGrupoValidado  = ""
1513:                 ENDIF
1514:                 IF USED("cursor_4c_GrpBusca")

*-- Linhas 1535 a 1668:
1535:         ELSE
1536:             TRY
1537:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1538:                     "SELECT DGrus, CGrus FROM SigCdGrp ORDER BY DGrus", ;
1539:                     "cursor_4c_GrpBuscaDesc", "DGrus", loc_cDesc, "Grupos")
1540:                 IF VARTYPE(loc_oLookup) = "O"
1541:                     loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1542:                     loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1543:                     loc_oLookup.Show()
1544:                     IF USED("cursor_4c_GrpBuscaDesc") AND RECCOUNT("cursor_4c_GrpBuscaDesc") > 0
1545:                         SELECT cursor_4c_GrpBuscaDesc
1546:                         loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaDesc.CGrus)
1547:                         loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
1548:                         THIS.this_cUltimoDGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
1549:                     ELSE
1550:                         loc_oSub2.txt_4c_CodGrupo.Value = ""
1551:                         loc_oSub2.txt_4c_DsGrupo.Value  = ""
1552:                         THIS.this_cUltimoDGrupoValidado = ""
1553:                     ENDIF
1554:                     IF USED("cursor_4c_GrpBuscaDesc")
1555:                         USE IN cursor_4c_GrpBuscaDesc
1556:                     ENDIF
1557:                 ENDIF
1558:             CATCH TO loc_oErro
1559:                 MsgErro(loc_oErro.Message, "Erro lookup Grupo Descri" + CHR(231) + CHR(227) + "o")
1560:             ENDTRY
1561:         ENDIF
1562:     ENDPROC
1563: 
1564:     PROCEDURE BtnFiltrarClick()
1565:     *==========================================================================
1566:         LOCAL loc_oSub2 AS Object, loc_cCGrupo AS String, loc_nRes AS Number, loc_oErro
1567:         loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1568:         loc_cCGrupo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
1569:         IF !USED("cursor_4c_Disponivel")
1570:             RETURN
1571:         ENDIF
1572:         IF EMPTY(loc_cCGrupo)
1573:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1574:             loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1575:             loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1576:             loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1577:             loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1578:             loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1579:             loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1580:             loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1581:             loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1582:             loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1583:             loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1584:             loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1585:             loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1586:             loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1587:             loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
1588:             loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1589:             loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1590:             loc_oSub2.grd_4c_Disponivel.Refresh()
1591:         ELSE
1592:             TRY
1593:                 IF USED("cursor_4c_DispFiltro")
1594:                     USE IN cursor_4c_DispFiltro
1595:                 ENDIF
1596:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1597:                     "SELECT DISTINCT a.cpros," + ;
1598:                     "  ISNULL(p.dpros,'') AS dpros," + ;
1599:                     "  a.codcors, a.codtams," + ;
1600:                     "  SUM(a.qtdos) AS QtdEstoque," + ;
1601:                     "  SUM(a.qtds) AS QtdSaida," + ;
1602:                     "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
1603:                     " FROM SigPrDis a" + ;
1604:                     " INNER JOIN SigCdPro p ON p.cpros = a.cpros" + ;
1605:                     " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
1606:                     "   AND p.cgrus = " + EscaparSQL(loc_cCGrupo) + ;
1607:                     " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
1608:                     " ORDER BY a.cpros, a.codcors, a.codtams", "cursor_4c_DispFiltro")
1609:                 IF loc_nRes > 0
1610:                     loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1611:                     loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1612:                     loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_DispFiltro"
1613:                     loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_DispFiltro.cpros"
1614:                     loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1615:                     loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_DispFiltro.dpros"
1616:                     loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1617:                     loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_DispFiltro.codcors"
1618:                     loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1619:                     loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_DispFiltro.codtams"
1620:                     loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1621:                     loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_DispFiltro.QtdEstoque"
1622:                     loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1623:                     loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_DispFiltro.QtdSaida"
1624:                     loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
1625:                     loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_DispFiltro.QtdSaldo"
1626:                     loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1627:                     loc_oSub2.grd_4c_Disponivel.Refresh()
1628:                 ENDIF
1629:             CATCH TO loc_oErro
1630:                 MsgErro(loc_oErro.Message, "Erro Filtrar")
1631:             ENDTRY
1632:         ENDIF
1633:     ENDPROC
1634: 
1635:     PROCEDURE ImgFotoClick()
1636:     *==========================================================================
1637:         LOCAL loc_nRes AS Number, loc_cArquivo AS String, loc_oErro
1638:         IF !USED("cursor_4c_Disponivel") OR EOF("cursor_4c_Disponivel")
1639:             RETURN
1640:         ENDIF
1641:         TRY
1642:             SELECT cursor_4c_Disponivel
1643:             LOCAL loc_cCpros AS String
1644:             loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
1645:             IF !EMPTY(loc_cCpros)
1646:                 IF USED("cursor_4c_TmpFoto")
1647:                     USE IN cursor_4c_TmpFoto
1648:                 ENDIF
1649:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1650:                     "SELECT FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros), ;
1651:                     "cursor_4c_TmpFoto")
1652:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpFoto") > 0
1653:                     SELECT cursor_4c_TmpFoto
1654:                     IF !EMPTY(cursor_4c_TmpFoto.FigJpgs) AND !ISNULL(cursor_4c_TmpFoto.FigJpgs)
1655:                         LOCAL loc_cBase64 AS String, loc_cBin AS String
1656:                         loc_cBase64 = STRTRAN(STRTRAN(STRTRAN( ;
1657:                             cursor_4c_TmpFoto.FigJpgs, ;
1658:                             "data:image/png;base64,",  ""), ;
1659:                             "data:image/jpeg;base64,", ""), ;
1660:                             "data:image/jpg;base64,",  "")
1661:                         loc_cBin     = STRCONV(loc_cBase64, 14)
1662:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
1663:                         STRTOFILE(loc_cBin, loc_cArquivo)
1664:                         IF FILE(loc_cArquivo)
1665:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.img_4c_FigJpg.Picture = ;
1666:                                 loc_cArquivo
1667:                         ENDIF
1668:                     ENDIF

*-- Linhas 1685 a 1753:
1685:             *-- Switch to operacoes page
1686:             IF THIS.this_oBusinessObject.BuscarOperacoes(THIS.this_cCodigos)
1687:                 LOCAL loc_oSub3 AS Object
1688:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1689:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = ""
1690:                 IF USED("cursor_4c_CabOpera")
1691:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.ColumnCount = 6
1692:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = "cursor_4c_CabOpera"
1693:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.ControlSource = "cursor_4c_CabOpera.emps"
1694:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.Header1.Caption = "Emp O"
1695:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.ControlSource = "cursor_4c_CabOpera.dopes"
1696:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1697:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.ControlSource = "cursor_4c_CabOpera.numes"
1698:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.Header1.Caption = ""
1699:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.ControlSource = "cursor_4c_CabOpera.datas"
1700:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.Header1.Caption = ""
1701:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.ControlSource = "cursor_4c_CabOpera.grupos"
1702:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.Header1.Caption = "Grupo Orig"
1703:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.ControlSource = "cursor_4c_CabOpera.empdopnums"
1704:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.Header1.Caption = "Emp+Op+Num"
1705:                 ENDIF
1706:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Refresh()
1707:                 loc_oSub3.Enabled = .T.
1708:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
1709:             ENDIF
1710:         ENDIF
1711:     ENDPROC
1712: 
1713:     PROCEDURE BtnProcOperClick()
1714:     *==========================================================================
1715:         LOCAL loc_oSub3 AS Object, loc_cCodObs AS String, loc_cObs AS String
1716:         loc_oSub3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1717:         loc_cCodObs = ALLTRIM(loc_oSub3.cntOperacao.txt_4c_CodObs.Value)
1718:         loc_cObs    = ALLTRIM(loc_oSub3.cntOperacao.edt_4c_Obs.Value)
1719:         MsgAviso("Processamento de opera" + CHR(231) + CHR(245) + "es n" + ;
1720:                  CHR(227) + "o implementado nesta vers" + CHR(227) + "o." + CHR(13) + ;
1721:                  "O lote j" + CHR(225) + " foi salvo em SigPrDis.", "Informa" + CHR(231) + CHR(227) + "o")
1722:     ENDPROC
1723: 
1724:     PROCEDURE GrdCabOperasAfterRowColChange(par_nColIndex)
1725:     *==========================================================================
1726:         IF USED("cursor_4c_CabOpera") AND !EOF("cursor_4c_CabOpera")
1727:             SELECT cursor_4c_CabOpera
1728:             LOCAL loc_cEmpDopNums AS String
1729:             loc_cEmpDopNums = ALLTRIM(cursor_4c_CabOpera.empdopnums)
1730:             IF !EMPTY(loc_cEmpDopNums) AND THIS.this_oBusinessObject.BuscarItensOperacao(loc_cEmpDopNums)
1731:                 LOCAL loc_oSub3 AS Object
1732:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1733:                 loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.RecordSource = ""
1734:                 IF USED("cursor_4c_ItensOper")
1735:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.ColumnCount = 5
1736:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.RecordSource = "cursor_4c_ItensOper"
1737:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1.ControlSource = "cursor_4c_ItensOper.cpros"
1738:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1739:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2.ControlSource = "cursor_4c_ItensOper.codcors"
1740:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2.Header1.Caption = "Cor"
1741:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3.ControlSource = "cursor_4c_ItensOper.codtams"
1742:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3.Header1.Caption = "Tam"
1743:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4.ControlSource = "cursor_4c_ItensOper.qtds"
1744:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4.Header1.Caption = "Quantidade"
1745:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5.ControlSource = "cursor_4c_ItensOper.locals"
1746:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5.Header1.Caption = "Local"
1747:                 ENDIF
1748:                 loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Refresh()
1749:             ENDIF
1750:         ENDIF
1751:     ENDPROC
1752: 
1753: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*=============================================================================*
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
*=============================================================================*
* Herda de: BusinessBase
* Form associado: Formsigprdis.prg (forms\operacionais\)
* Tabela principal: sigprdis (PK: cidchaves)
* Tabela auxiliar : SIGTEMPD  (cidchaves C64 - temp de processamento)
*
* Descricao: Gerencia a distribuicao de produtos entre empresas/estoques.
*   - Page1 (Lista): lista de distribuicoes por periodo (TmpSigPrDis)
*   - Page2 (Dados): grade de disponivel (crDisponivel) e distribuicao
*                    (crDistribui) por empresa/grupo/conta
*   - Page3 (Ops)  : historico de operacoes geradas pelo processamento
*
* Campos sigprdis:
*   cidchaves C(20)   PK auto (fUniqueIds por linha)
*   codigos   C(10)   chave de lote (agrupa N linhas do mesmo lote)
*   datas     T       data/hora do lote
*   dtalts    T       data/hora ultima alteracao
*   cpros     C(14)   codigo do produto
*   codcors   C(4)    codigo da cor
*   codtams   C(4)    codigo do tamanho
*   empdopnums C(29)  empresa+operacao+numero destino gerado
*   empds     C(3)    empresa destino
*   empgruests C(23)  empresa+grupo+conta (composto 3+10+10)
*   locals    C(10)   localizacao/enderecamento
*   qtds      N(10,2) quantidade distribuida
*   qtdos     N(10,2) quantidade original (pre-distribuicao)
*   usuars    C(10)   usuario que criou
*   usualts   C(10)   usuario que alterou por ultimo
*   oridopnums C(29)  empresa+operacao+numero origem
*=============================================================================*

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Identificacao do lote (chave de negocio usada nos SELECTs de listagem)
    this_cCodigos       = ""

    *-- PK fisica de cada linha da distribuicao (gerada por fUniqueIds)
    this_cCidChaves     = ""

    *-- Data e hora do lote
    this_dDatas         = {}

    *-- Data e hora da ultima alteracao
    this_dDtAlts        = {}

    *-- Codigo do produto distribuido
    this_cCpros         = ""

    *-- Codigo da cor do produto
    this_cCodCors       = ""

    *-- Codigo do tamanho do produto
    this_cCodTams       = ""

    *-- Empresa + Operacao + Numero destino (composto char 29)
    this_cEmpDopNums    = ""

    *-- Empresa destino (char 3)
    this_cEmpDs         = ""

    *-- Empresa + Grupo + Conta composto (char 23 = 3+10+10)
    this_cEmpGruEsts    = ""

    *-- Localizacao / enderecamento do estoque (char 10)
    this_cLocals        = ""

    *-- Quantidade distribuida
    this_nQtds          = 0

    *-- Quantidade original (antes da distribuicao, preenchida no processamento)
    this_nQtdOs         = 0

    *-- Usuario que criou o lancamento
    this_cUsuars        = ""

    *-- Usuario da ultima alteracao
    this_cUsuAlts       = ""

    *-- Empresa + Operacao + Numero origem (char 29)
    this_cOriDopNums    = ""

    *-- Filtros de pesquisa de lotes (usados em Buscar)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Chave de query temporaria (cidquerys em SIGTEMPD, gerada por fUniqueIds)
    this_cCidQuerys     = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "sigprdis"
        THIS.this_cCampoChave  = "cidchaves"
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal   = DATE()
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * METODOS CRUD (BusinessBase)
    *==========================================================================

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao por periodo (cursor_4c_Dados)
    * Colunas: Codigos, Datas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cWhere)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
                       " WHERE CAST(Datas AS date) BETWEEN " + ;
                       FormatarDataSQL(THIS.this_dDataInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDataFinal) + ;
                       " ORDER BY Datas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo campo Codigos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cidchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso             = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_cCodigos       = ALLTRIM(par_cCodigos)
                THIS.this_lNovoRegistro  = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cCodigos     = TratarNulo(codigos,     "C")
            THIS.this_dDatas       = IIF(ISNULL(datas),  {}, datas)
            THIS.this_dDtAlts      = IIF(ISNULL(dtalts), {}, dtalts)
            THIS.this_cCpros       = TratarNulo(cpros,       "C")
            THIS.this_cCodCors     = TratarNulo(codcors,     "C")
            THIS.this_cCodTams     = TratarNulo(codtams,     "C")
            THIS.this_cEmpDopNums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmpDs       = TratarNulo(empds,       "C")
            THIS.this_cEmpGruEsts  = TratarNulo(empgruests,  "C")
            THIS.this_cLocals      = TratarNulo(locals,      "C")
            THIS.this_nQtds        = TratarNulo(qtds,        "N")
            THIS.this_nQtdOs       = TratarNulo(qtdos,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,      "C")
            THIS.this_cUsuAlts     = TratarNulo(usualts,     "C")
            THIS.this_cOriDopNums  = TratarNulo(oridopnums,  "C")
            loc_lSucesso           = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigPrDis" + ;
                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)                       + "," + ;
                       EscaparSQL(THIS.this_cCodigos)                         + "," + ;
                       EscaparSQL(THIS.this_cCodCors)                         + "," + ;
                       EscaparSQL(THIS.this_cCodTams)                         + "," + ;
                       EscaparSQL(THIS.this_cCpros)                           + "," + ;
                       "GETDATE(),"                                                  + ;
                       "GETDATE(),"                                                  + ;
                       EscaparSQL(THIS.this_cEmpDopNums)                      + "," + ;
                       EscaparSQL(THIS.this_cEmpDs)                           + "," + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)                      + "," + ;
                       EscaparSQL(THIS.this_cLocals)                          + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs)                    + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtds)                     + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(THIS.this_cOriDopNums)                      + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrDis SET" + ;
                       "  codcors    = " + EscaparSQL(THIS.this_cCodCors)              + "," + ;
                       "  codtams    = " + EscaparSQL(THIS.this_cCodTams)              + "," + ;
                       "  cpros      = " + EscaparSQL(THIS.this_cCpros)                + "," + ;
                       "  dtalts     = GETDATE(),"                                           + ;
                       "  empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)           + "," + ;
                       "  empds      = " + EscaparSQL(THIS.this_cEmpDs)                + "," + ;
                       "  empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)           + "," + ;
                       "  locals     = " + EscaparSQL(THIS.this_cLocals)               + "," + ;
                       "  qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs)         + "," + ;
                       "  qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)          + "," + ;
                       "  usualts    = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))   + "," + ;
                       "  oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)                  + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do lote completo de SigPrDis (por Codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * METODOS DE NEGOCIO (operacional - distribuicao de produtos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BuscarEstoques - Carrega SigCdCeg (tpcads=3) com flag nMarca para selecao
    * Cria cursor_4c_Estoques: nMarca, cidchaves, emps, grupos, contas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEstoques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Estoques")
                USE IN cursor_4c_Estoques
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, cidchaves AS cidchaves, emps AS emps, grupos AS grupos, contas AS contas" + ;
                       " FROM SigCdCeg" + ;
                       " WHERE tpcads = 3" + ;
                       " ORDER BY emps, grupos, contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoques")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Estoques")
                    GO TOP IN cursor_4c_Estoques
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarEstoques:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarLote - Carrega todas as linhas SigPrDis de um lote
    * Cria cursor_4c_LotePrDis com todos os campos de SigPrDis
    *--------------------------------------------------------------------------
    PROCEDURE InicializarLote(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LotePrDis")
                USE IN cursor_4c_LotePrDis
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LotePrDis")

            IF loc_nResultado < 0
                MsgErro("Erro ao inicializar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_LotePrDis")
                    GO TOP IN cursor_4c_LotePrDis
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em InicializarLote:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresDistribuicao
    * Prepara cursor_4c_Disponivel e cursor_4c_Distribui a partir dos
    * estoques marcados em cursor_4c_Estoques.
    * par_cCodigos : codigo do lote (vazio se INSERIR)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nSel
        LOCAL loc_cEmp, loc_cGrupo, loc_cConta, loc_nQtdDistr
        loc_lSucesso = .F.

        TRY
            *-- Contar estoques marcados
            loc_nSel = 0
            IF USED("cursor_4c_Estoques")
                SELECT cursor_4c_Estoques
                COUNT FOR nMarca = 1 TO loc_nSel
            ENDIF

            IF loc_nSel = 0
                MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursores anteriores
            IF USED("cursor_4c_Disponivel")
                USE IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                USE IN cursor_4c_Distribui
            ENDIF

            *-- Montar cursor_4c_Disponivel
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "SELECT a.cpros AS cpros, ISNULL(p.dpros,'') AS dpros," + ;
                           "  a.codcors AS codcors, a.codtams AS codtams," + ;
                           "  SUM(a.qtdos) AS QtdEstoque," + ;
                           "  SUM(a.qtds)  AS QtdSaida," + ;
                           "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
                           " FROM SigPrDis a" + ;
                           " LEFT JOIN SigCdPro p ON p.cpros = a.cpros" + ;
                           " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
                           " ORDER BY a.cpros, a.codcors, a.codtams"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar produtos disponivel:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Disponivel ;
                    (cpros C(14), dpros C(65), codcors C(4), codtams C(4), ;
                     QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
                SET NULL OFF
            ENDIF

            *-- Montar cursor_4c_Distribui a partir dos estoques marcados
            SET NULL ON
            CREATE CURSOR cursor_4c_Distribui ;
                (emps C(3), grupos C(10), contas C(10), ;
                 QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
            SET NULL OFF

            SELECT cursor_4c_Estoques
            GO TOP
            DO WHILE !EOF("cursor_4c_Estoques")
                IF cursor_4c_Estoques.nMarca = 1
                    loc_cEmp   = ALLTRIM(cursor_4c_Estoques.emps)
                    loc_cGrupo = ALLTRIM(cursor_4c_Estoques.grupos)
                    loc_cConta = ALLTRIM(cursor_4c_Estoques.contas)
                    loc_nQtdDistr = 0

                    IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND ;
                       !EMPTY(par_cCodigos) AND ;
                       USED("cursor_4c_LotePrDis")
                        SELECT cursor_4c_LotePrDis
                        GO TOP
                        SCAN FOR ALLTRIM(empds) = loc_cEmp
                            loc_nQtdDistr = loc_nQtdDistr + qtds
                        ENDSCAN
                    ENDIF

                    INSERT INTO cursor_4c_Distribui ;
                        (emps, grupos, contas, QtdSaldo, QtdDistr, locals) ;
                        VALUES (loc_cEmp, loc_cGrupo, loc_cConta, 0, loc_nQtdDistr, "")
                ENDIF
                SELECT cursor_4c_Estoques
                SKIP
            ENDDO

            IF USED("cursor_4c_Disponivel")
                GO TOP IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                GO TOP IN cursor_4c_Distribui
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em PrepararCursoresDistribuicao:" + CHR(13) + ;
                    loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldo - Recalcula QtdSaldo em cursor_4c_Disponivel
    * Chamado apos edicao de QtdDistr em cursor_4c_Distribui
    * par_cCpros/par_cCodCors/par_cCodTams: produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CalcularSaldo(par_cCpros, par_cCodCors, par_cCodTams)
        LOCAL loc_nQtdDistr, loc_nQtdEstoque, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Distribui
            SUM QtdDistr TO loc_nQtdDistr

            SELECT cursor_4c_Disponivel
            LOCATE FOR ALLTRIM(cpros)   = ALLTRIM(par_cCpros)  AND ;
                        ALLTRIM(codcors) = ALLTRIM(par_cCodCors) AND ;
                        ALLTRIM(codtams) = ALLTRIM(par_cCodTams)

            IF FOUND()
                loc_nQtdEstoque = cursor_4c_Disponivel.QtdEstoque

                IF loc_nQtdEstoque - loc_nQtdDistr < 0
                    MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
                    SELECT cursor_4c_Distribui
                    GO TOP
                    REPLACE ALL QtdDistr WITH 0
                    loc_nQtdDistr = 0
                    *-- Recalcular apos zerar
                    SELECT cursor_4c_Distribui
                    SUM QtdDistr TO loc_nQtdDistr
                ENDIF

                SELECT cursor_4c_Disponivel
                REPLACE QtdSaida WITH loc_nQtdDistr
                REPLACE QtdSaldo WITH (loc_nQtdEstoque - loc_nQtdDistr)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em CalcularSaldo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Carrega detalhes de produto para exibicao no painel lateral
    * Cria cursor_4c_Produto com campos do SigCdPro + joins
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis," + ;
                       "  a.reffs, a.valors, a.moedas, a.pvens, a.moevs," + ;
                       "  a.pesoms, a.linhas, a.situas, a.colecoes," + ;
                       "  a.pcuss, a.moecs, a.pvideals, a.ifors," + ;
                       "  ISNULL(c.Rclis, '') AS rclis," + ;
                       "  ISNULL(g.dgrus, '') AS dgrus" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
                       " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(par_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Produto") > 0
                GO TOP IN cursor_4c_Produto
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarProduto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao
    * Grava o lote de distribuicao em SigPrDis a partir de cursor_4c_Distribui
    * e cursor_4c_Disponivel. Usa transacao explicita para garantir atomicidade.
    * par_cCodigos : codigo do lote (Codigos)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_lTransacaoAberta
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtdDistr, loc_cEmps, loc_cGrupos, loc_cContas
        LOCAL loc_nTotDis, loc_nQtdNeg

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.

        *-- Validar cursor_4c_Distribui tem quantidades
        IF !USED("cursor_4c_Distribui")
            MsgAviso("Cursor de distribui" + CHR(231) + CHR(227) + CHR(227) + ;
                     "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Distribui
        SUM QtdDistr TO loc_nTotDis
        IF loc_nTotDis = 0
            MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
            RETURN .F.
        ENDIF

        *-- Validar sem saldos negativos em cursor_4c_Disponivel
        IF USED("cursor_4c_Disponivel")
            SELECT cursor_4c_Disponivel
            GO TOP
            COUNT FOR QtdSaldo < 0 TO loc_nQtdNeg
            IF loc_nQtdNeg > 0
                MsgAviso("Existem produtos distribu" + CHR(237) + "dos que est" + ;
                         CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
                         "Favor checar antes de processar.", "Aviso")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- Se ALTERAR: remover linhas existentes do lote
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                           EscaparSQL(par_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    MsgErro("Erro ao remover lote anterior:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Para cada produto disponivel x empresa distribui: INSERT em SigPrDis
            IF USED("cursor_4c_Disponivel")
                SELECT cursor_4c_Disponivel
                GO TOP
                DO WHILE !EOF("cursor_4c_Disponivel")
                    loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
                    loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
                    loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)

                    SELECT cursor_4c_Distribui
                    GO TOP
                    DO WHILE !EOF("cursor_4c_Distribui")
                        loc_nQtdDistr = cursor_4c_Distribui.QtdDistr
                        loc_cEmps     = ALLTRIM(cursor_4c_Distribui.emps)
                        loc_cGrupos   = ALLTRIM(cursor_4c_Distribui.grupos)
                        loc_cContas   = ALLTRIM(cursor_4c_Distribui.contas)

                        IF loc_nQtdDistr > 0
                            loc_cCidChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigPrDis" + ;
                                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidChaves)                               + "," + ;
                                       EscaparSQL(par_cCodigos)                                 + "," + ;
                                       EscaparSQL(loc_cCodCors)                                 + "," + ;
                                       EscaparSQL(loc_cCodTams)                                 + "," + ;
                                       EscaparSQL(loc_cCpros)                                   + "," + ;
                                       "GETDATE(),"                                                    + ;
                                       "GETDATE(),"                                                    + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(loc_cEmps)                                    + "," + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Distribui.locals))          + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       "'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                MsgErro("Erro ao inserir linha de distribui" + ;
                                        CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Distribui
                        SKIP
                    ENDDO

                    SELECT cursor_4c_Disponivel
                    SKIP
                ENDDO
            ENDIF

            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            loc_lTransacaoAberta = .F.

            THIS.this_cCodigos = par_cCodigos
            THIS.RegistrarAuditoria(IIF(UPPER(ALLTRIM(par_cEscolha)) = "INSERIR", "INSERT", "UPDATE"))
            loc_lSucesso = .T.

        CATCH TO loException
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro("Erro em ProcessarDistribuicao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega operacoes de SigMvCab geradas pela distribuicao
    * Cria cursor_4c_CabOpera: cidchaves, emps, dopes, numes, grupos, datas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CabOpera")
                USE IN cursor_4c_CabOpera
            ENDIF

            loc_cSQL = "SELECT m.cidchaves AS cidchaves, m.emps AS emps, m.dopes AS dopes, m.numes AS numes," + ;
                       "  m.grupos AS grupos, m.datas AS datas, m.empdopnums AS empdopnums" + ;
                       " FROM SigMvCab m" + ;
                       " WHERE m.empdopnums IN (" + ;
                       "   SELECT DISTINCT empdopnums FROM SigPrDis" + ;
                       "   WHERE Codigos = " + EscaparSQL(par_cCodigos) + ")" + ;
                       " ORDER BY m.emps, m.dopes, m.numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOpera")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_CabOpera")
                    GO TOP IN cursor_4c_CabOpera
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensOperacao - Carrega itens distribuidos de uma operacao/lote
    * Cria cursor_4c_ItensOper: cidchaves, cpros, dpros, codcors, codtams, qtds, qtdos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensOperacao(par_cEmpdopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ItensOper")
                USE IN cursor_4c_ItensOper
            ENDIF

            loc_cSQL = "SELECT d.cidchaves, d.cpros, ISNULL(p.dpros,'') AS dpros," + ;
                       "  d.codcors, d.codtams, d.qtds, d.qtdos" + ;
                       " FROM SigPrDis d" + ;
                       " LEFT JOIN SigCdPro p ON p.cpros = d.cpros" + ;
                       " WHERE d.empdopnums = " + EscaparSQL(par_cEmpdopNums) + ;
                       " ORDER BY d.cpros, d.codcors, d.codtams"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensOper")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar itens da opera" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ItensOper")
                    GO TOP IN cursor_4c_ItensOper
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarItensOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

