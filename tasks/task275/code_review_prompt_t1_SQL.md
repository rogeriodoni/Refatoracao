# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (30)
- [GRID-SQL] Campo 'empds' usado em ControlSource de cursor_4c_CabOpera mas NAO existe no CREATE CURSOR
- [GRID-SQL] Campo 'contaos' usado em ControlSource de cursor_4c_CabOpera mas NAO existe no CREATE CURSOR
- [GRID-SQL] Campo 'grupods' usado em ControlSource de cursor_4c_CabOpera mas NAO existe no CREATE CURSOR
- [GRID-SQL] Campo 'contads' usado em ControlSource de cursor_4c_CabOpera mas NAO existe no CREATE CURSOR
- [GRID-SQL] Campo 'emps' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dopes' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'numes' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'empds' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contaos' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupods' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contads' usado em ControlSource de cursor_4c_CabOpera mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dpros' usado em ControlSource de cursor_4c_ItensOper mas NAO existe no CREATE CURSOR
- [GRID-SQL] Campo 'cpros' usado em ControlSource de cursor_4c_ItensOper mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dpros' usado em ControlSource de cursor_4c_ItensOper mas NAO aparece no SELECT SQL
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS SQL (2350 linhas total):

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

*-- Linhas 396 a 428:
396:             .RecordSource      = ""
397:             .RecordSourceType  = 1
398:             .ColumnCount       = 2
399:             .DeleteMark        = .F.
400:             .RecordMark        = .F.
401:             .GridLines         = 1
402:             .ReadOnly          = .T.
403:             .Themes            = .F.
404:             .FontName          = "Tahoma"
405:             .FontSize          = 8
406:         ENDWITH
407:         WITH loc_oPg1.grd_4c_Grade.Column1
408:             .ControlSource   = "cursor_4c_Dados.Codigos"
409:             .Width           = 140
410:             .Header1.Caption = "C" + CHR(243) + "digo"
411:         ENDWITH
412:         WITH loc_oPg1.grd_4c_Grade.Column2
413:             .ControlSource   = "cursor_4c_Dados.Datas"
414:             .Width           = 700
415:             .Header1.Caption = "Data"
416:         ENDWITH
417:     ENDPROC
418: 
419:     *==========================================================================
420:     PROTECTED PROCEDURE ConfigurarPaginaDados()
421:     *==========================================================================
422:         LOCAL loc_oPg2 AS Object
423:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
424: 
425:         loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
426:         WITH loc_oPg2.cmd_4c_VoltarLista
427:             .Caption  = CHR(171) + " Lista"
428:             .Left     = 5

*-- Linhas 554 a 605:
554:             .RecordSource     = ""
555:             .RecordSourceType = 1
556:             .ColumnCount      = 4
557:             .DeleteMark       = .F.
558:             .RecordMark       = .F.
559:             .GridLines        = 1
560:             .Themes           = .F.
561:             .FontName         = "Tahoma"
562:             .FontSize         = 8
563:         ENDWITH
564:         WITH loc_oSub.grd_4c_Estoques.Column1
565:             .ControlSource   = "cursor_4c_Estoques.nMarca"
566:             .Width           = 30
567:             .Sparse          = .F.
568:             .Header1.Caption = ""
569:         ENDWITH
570:         loc_oSub.grd_4c_Estoques.Column1.AddObject("chk_4c_Marca", "CheckBox")
571:         WITH loc_oSub.grd_4c_Estoques.Column1.chk_4c_Marca
572:             .Caption = ""
573:             .Width   = 24
574:             .Height  = 17
575:         ENDWITH
576:         loc_oSub.grd_4c_Estoques.Column1.CurrentControl = "chk_4c_Marca"
577:         WITH loc_oSub.grd_4c_Estoques.Column2
578:             .ControlSource   = "cursor_4c_Estoques.emps"
579:             .Width           = 55
580:             .ReadOnly        = .T.
581:             .Header1.Caption = "Empresa"
582:         ENDWITH
583:         WITH loc_oSub.grd_4c_Estoques.Column3
584:             .ControlSource   = "cursor_4c_Estoques.grupos"
585:             .Width           = 90
586:             .ReadOnly        = .T.
587:             .Header1.Caption = "Grupo"
588:         ENDWITH
589:         WITH loc_oSub.grd_4c_Estoques.Column4
590:             .ControlSource   = "cursor_4c_Estoques.contas"
591:             .Width           = 90
592:             .ReadOnly        = .T.
593:             .Header1.Caption = "Conta"
594:         ENDWITH
595:     ENDPROC
596: 
597:     *==========================================================================
598:     PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
599:     *==========================================================================
600:         LOCAL loc_oSub AS Object
601:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
602: 
603:         loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
604:         WITH loc_oSub.cmd_4c_VoltarEst
605:             .Caption  = CHR(171) + " Estoques"

*-- Linhas 721 a 818:
721:             .RecordSource     = ""
722:             .RecordSourceType = 1
723:             .ColumnCount      = 7
724:             .DeleteMark       = .F.
725:             .RecordMark       = .F.
726:             .GridLines        = 1
727:             .ReadOnly         = .T.
728:             .Themes           = .F.
729:             .FontName         = "Tahoma"
730:             .FontSize         = 8
731:         ENDWITH
732:         WITH loc_oSub.grd_4c_Disponivel.Column1
733:             .ControlSource   = "cursor_4c_Disponivel.cpros"
734:             .Width           = 90
735:             .Header1.Caption = "C" + CHR(243) + "digo"
736:         ENDWITH
737:         WITH loc_oSub.grd_4c_Disponivel.Column2
738:             .ControlSource   = "cursor_4c_Disponivel.dpros"
739:             .Width           = 140
740:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
741:         ENDWITH
742:         WITH loc_oSub.grd_4c_Disponivel.Column3
743:             .ControlSource   = "cursor_4c_Disponivel.codcors"
744:             .Width           = 55
745:             .Header1.Caption = "Cor"
746:         ENDWITH
747:         WITH loc_oSub.grd_4c_Disponivel.Column4
748:             .ControlSource   = "cursor_4c_Disponivel.codtams"
749:             .Width           = 55
750:             .Header1.Caption = "Tam"
751:         ENDWITH
752:         WITH loc_oSub.grd_4c_Disponivel.Column5
753:             .ControlSource   = "cursor_4c_Disponivel.QtdEstoque"
754:             .Width           = 80
755:             .Header1.Caption = "Estoque"
756:         ENDWITH
757:         WITH loc_oSub.grd_4c_Disponivel.Column6
758:             .ControlSource   = "cursor_4c_Disponivel.QtdSaida"
759:             .Width           = 80
760:             .Header1.Caption = "Distribuido"
761:         ENDWITH
762:         WITH loc_oSub.grd_4c_Disponivel.Column7
763:             .ControlSource   = "cursor_4c_Disponivel.QtdSaldo"
764:             .Width           = 80
765:             .Header1.Caption = "Saldo"
766:         ENDWITH
767: 
768:         *-- Distribui grid (Column3=QtdDistr editable, Column4=locals editable)
769:         loc_oSub.AddObject("grd_4c_Distribui", "Grid")
770:         WITH loc_oSub.grd_4c_Distribui
771:             .Left             = 664
772:             .Top              = 141
773:             .Width            = 234
774:             .Height           = 327
775:             .RecordSource     = ""
776:             .RecordSourceType = 1
777:             .ColumnCount      = 4
778:             .DeleteMark       = .F.
779:             .RecordMark       = .F.
780:             .GridLines        = 1
781:             .Themes           = .F.
782:             .FontName         = "Tahoma"
783:             .FontSize         = 8
784:         ENDWITH
785:         WITH loc_oSub.grd_4c_Distribui.Column1
786:             .ControlSource   = "cursor_4c_Distribui.emps"
787:             .Width           = 50
788:             .ReadOnly        = .T.
789:             .Header1.Caption = "Empresa"
790:         ENDWITH
791:         WITH loc_oSub.grd_4c_Distribui.Column2
792:             .ControlSource   = "cursor_4c_Distribui.QtdSaldo"
793:             .Width           = 55
794:             .ReadOnly        = .T.
795:             .Header1.Caption = "Saldo"
796:         ENDWITH
797:         WITH loc_oSub.grd_4c_Distribui.Column3
798:             .ControlSource   = "cursor_4c_Distribui.QtdDistr"
799:             .Width           = 65
800:             .Header1.Caption = "Quantidade"
801:         ENDWITH
802:         WITH loc_oSub.grd_4c_Distribui.Column4
803:             .ControlSource   = "cursor_4c_Distribui.locals"
804:             .Width           = 55
805:             .Header1.Caption = "Local"
806:         ENDWITH
807: 
808:         *-- Product info panel (read-only) - bottom of page
809:         loc_oSub.AddObject("lbl_4c_LblGrupoP", "Label")
810:         WITH loc_oSub.lbl_4c_LblGrupoP
811:             .Caption   = "Grupo :"
812:             .Left      = 67
813:             .Top       = 474
814:             .Width     = 45
815:             .Height    = 15
816:             .AutoSize  = .F.
817:             .BackStyle = 0
818:             .FontName  = "Tahoma"

*-- Linhas 1225 a 1458:
1225:             .RecordSource     = ""
1226:             .RecordSourceType = 1
1227:             .ColumnCount      = 8
1228:             .DeleteMark       = .F.
1229:             .RecordMark       = .F.
1230:             .GridLines        = 1
1231:             .ReadOnly         = .T.
1232:             .Themes           = .F.
1233:             .FontName         = "Tahoma"
1234:             .FontSize         = 8
1235:         ENDWITH
1236:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1
1237:             .ControlSource   = "cursor_4c_CabOpera.emps"
1238:             .Width           = 45
1239:             .Header1.Caption = "Emp O"
1240:         ENDWITH
1241:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2
1242:             .ControlSource   = "cursor_4c_CabOpera.dopes"
1243:             .Width           = 250
1244:             .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1245:         ENDWITH
1246:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3
1247:             .ControlSource   = "cursor_4c_CabOpera.numes"
1248:             .Width           = 80
1249:             .Header1.Caption = "N" + CHR(176)
1250:         ENDWITH
1251:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4
1252:             .ControlSource   = "cursor_4c_CabOpera.empds"
1253:             .Width           = 45
1254:             .Header1.Caption = "Emp D"
1255:         ENDWITH
1256:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5
1257:             .ControlSource   = "cursor_4c_CabOpera.grupos"
1258:             .Width           = 80
1259:             .Header1.Caption = "Grupo Orig"
1260:         ENDWITH
1261:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6
1262:             .ControlSource   = "cursor_4c_CabOpera.contaos"
1263:             .Width           = 80
1264:             .Header1.Caption = "Conta Orig"
1265:         ENDWITH
1266:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column7
1267:             .ControlSource   = "cursor_4c_CabOpera.grupods"
1268:             .Width           = 80
1269:             .Header1.Caption = "Grupo Dest"
1270:         ENDWITH
1271:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column8
1272:             .ControlSource   = "cursor_4c_CabOpera.contads"
1273:             .Width           = 80
1274:             .Header1.Caption = "Conta Dest"
1275:         ENDWITH
1276: 
1277:         *-- grdItnOperas: 6 columns (cpros/dpros/codcors/codtams/qtds/locals)
1278:         loc_oSub.pgf_4c_Operacoes.Page2.AddObject("grd_4c_ItnOperas", "Grid")
1279:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
1280:             .Left             = 9
1281:             .Top              = 5
1282:             .Width            = 975
1283:             .Height           = 340
1284:             .RecordSource     = ""
1285:             .RecordSourceType = 1
1286:             .ColumnCount      = 6
1287:             .DeleteMark       = .F.
1288:             .RecordMark       = .F.
1289:             .GridLines        = 1
1290:             .ReadOnly         = .T.
1291:             .Themes           = .F.
1292:             .FontName         = "Tahoma"
1293:             .FontSize         = 8
1294:         ENDWITH
1295:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1
1296:             .ControlSource   = "cursor_4c_ItensOper.cpros"
1297:             .Width           = 106
1298:             .Header1.Caption = "C" + CHR(243) + "digo"
1299:         ENDWITH
1300:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2
1301:             .ControlSource   = "cursor_4c_ItensOper.dpros"
1302:             .Width           = 382
1303:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1304:         ENDWITH
1305:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3
1306:             .ControlSource   = "cursor_4c_ItensOper.codcors"
1307:             .Width           = 60
1308:             .Header1.Caption = "Cor"
1309:         ENDWITH
1310:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4
1311:             .ControlSource   = "cursor_4c_ItensOper.codtams"
1312:             .Width           = 60
1313:             .Header1.Caption = "Tam"
1314:         ENDWITH
1315:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5
1316:             .ControlSource   = "cursor_4c_ItensOper.qtds"
1317:             .Width           = 150
1318:             .Header1.Caption = "Quantidade"
1319:         ENDWITH
1320:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column6
1321:             .ControlSource   = "cursor_4c_ItensOper.locals"
1322:             .Width           = 150
1323:             .Header1.Caption = "Local"
1324:         ENDWITH
1325:     ENDPROC
1326: 
1327:     *==========================================================================
1328:     * METODOS DE NEGOCIO
1329:     *==========================================================================
1330: 
1331:     PROCEDURE CarregarLista()
1332:     *==========================================================================
1333:         THIS.this_oBusinessObject.this_dDataInicial = ;
1334:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value
1335:         THIS.this_oBusinessObject.this_dDataFinal = ;
1336:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value
1337:         THIS.this_oBusinessObject.Buscar("")
1338:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = ""
1339:         IF USED("cursor_4c_Dados")
1340:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 2
1341:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1342:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1343:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1344:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.Datas"
1345:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.Header1.Caption = "Data"
1346:         ENDIF
1347:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1348:     ENDPROC
1349: 
1350:     PROCEDURE AbrirNovoBatch()
1351:     *==========================================================================
1352:         THIS.this_cEscolha = "INSERIR"
1353:         THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
1354:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
1355:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"
1356: 
1357:         IF THIS.this_oBusinessObject.BuscarEstoques()
1358:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1359:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1360:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1361:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1362:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1363:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1364:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1365:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1366:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1367:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1368:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1369:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1370:         ENDIF
1371: 
1372:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1373:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
1374:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1375:         THIS.pgf_4c_Paginas.ActivePage = 2
1376:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1377:     ENDPROC
1378: 
1379:     PROCEDURE AbrirBatchExistente(par_cCodigos)
1380:     *==========================================================================
1381:         THIS.this_cEscolha = "ALTERAR"
1382:         THIS.this_cCodigos = par_cCodigos
1383:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
1384:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"
1385: 
1386:         THIS.this_oBusinessObject.InicializarLote(par_cCodigos)
1387: 
1388:         IF THIS.this_oBusinessObject.BuscarEstoques()
1389:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1390:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1391:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1392:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1393:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1394:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1395:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1396:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1397:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1398:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1399:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1400:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1401:         ENDIF
1402: 
1403:         *-- Pre-marcar estoques do lote
1404:         IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")
1405:             LOCAL loc_cEmpEst AS String
1406:             SELECT cursor_4c_Estoques
1407:             GO TOP
1408:             DO WHILE !EOF("cursor_4c_Estoques")
1409:                 loc_cEmpEst = ALLTRIM(cursor_4c_Estoques.emps)
1410:                 SELECT cursor_4c_LotePrDis
1411:                 LOCATE FOR ALLTRIM(empds) = loc_cEmpEst
1412:                 IF FOUND()
1413:                     REPLACE nMarca WITH 1 IN cursor_4c_Estoques
1414:                 ENDIF
1415:                 SELECT cursor_4c_Estoques
1416:                 SKIP
1417:             ENDDO
1418:             GO TOP IN cursor_4c_Estoques
1419:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1420:         ENDIF
1421: 
1422:         *-- Carregar operacoes existentes
1423:         IF THIS.this_oBusinessObject.BuscarOperacoes(par_cCodigos)
1424:             LOCAL loc_oGrdCab AS Object
1425:             loc_oGrdCab = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
1426:             loc_oGrdCab.RecordSource = ""
1427:             loc_oGrdCab.ColumnCount  = 8
1428:             loc_oGrdCab.RecordSource = "cursor_4c_CabOpera"
1429:             loc_oGrdCab.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
1430:             loc_oGrdCab.Column1.Header1.Caption = "Emp O"
1431:             loc_oGrdCab.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
1432:             loc_oGrdCab.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1433:             loc_oGrdCab.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
1434:             loc_oGrdCab.Column3.Header1.Caption = "N" + CHR(176)
1435:             loc_oGrdCab.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
1436:             loc_oGrdCab.Column4.Header1.Caption = "Emp D"
1437:             loc_oGrdCab.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
1438:             loc_oGrdCab.Column5.Header1.Caption = "Grupo Orig"
1439:             loc_oGrdCab.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
1440:             loc_oGrdCab.Column6.Header1.Caption = "Conta Orig"
1441:             loc_oGrdCab.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
1442:             loc_oGrdCab.Column7.Header1.Caption = "Grupo Dest"
1443:             loc_oGrdCab.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
1444:             loc_oGrdCab.Column8.Header1.Caption = "Conta Dest"
1445:             loc_oGrdCab.Refresh()
1446:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .T.
1447:         ENDIF
1448: 
1449:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1450:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1451:         THIS.pgf_4c_Paginas.ActivePage = 2
1452:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1453:     ENDPROC
1454: 
1455:     *==========================================================================
1456:     PROCEDURE AlternarPagina(par_nPagina)
1457:     *==========================================================================
1458:         LOCAL loc_lResultado

*-- Linhas 1491 a 1509:
1491:     *==========================================================================
1492:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 ;
1493:                 AND !EOF("cursor_4c_Dados")
1494:             SELECT cursor_4c_Dados
1495:             LOCAL loc_cCodigos AS String
1496:             loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1497:             IF !EMPTY(loc_cCodigos)
1498:                 THIS.AbrirBatchExistente(loc_cCodigos)
1499:             ENDIF
1500:         ELSE
1501:             MsgAviso("Selecione um lote na lista.", "Aviso")
1502:         ENDIF
1503:     ENDPROC
1504: 
1505:     PROCEDURE TxtDtInicialValid()
1506:     *==========================================================================
1507:         LOCAL loc_oDtI AS Object, loc_oDtF AS Object
1508:         loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
1509:         loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal

*-- Linhas 1546 a 1736:
1546:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1547:     ENDPROC
1548: 
1549:     PROCEDURE BtnMarcarClick()
1550:     *==========================================================================
1551:         IF USED("cursor_4c_Estoques")
1552:             SELECT cursor_4c_Estoques
1553:             REPLACE ALL nMarca WITH 1
1554:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1555:         ENDIF
1556:     ENDPROC
1557: 
1558:     PROCEDURE BtnDesmarcarClick()
1559:     *==========================================================================
1560:         IF USED("cursor_4c_Estoques")
1561:             SELECT cursor_4c_Estoques
1562:             REPLACE ALL nMarca WITH 0
1563:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1564:         ENDIF
1565:     ENDPROC
1566: 
1567:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1568:     *==========================================================================
1569:         NODEFAULT
1570:         IF USED("cursor_4c_Estoques")
1571:             SELECT cursor_4c_Estoques
1572:             REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1573:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1574:         ENDIF
1575:     ENDPROC
1576: 
1577:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1578:     *==========================================================================
1579:         IF INLIST(par_nKeyCode, 13, 32)
1580:             NODEFAULT
1581:             IF USED("cursor_4c_Estoques")
1582:                 SELECT cursor_4c_Estoques
1583:                 REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1584:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1585:             ENDIF
1586:         ENDIF
1587:     ENDPROC
1588: 
1589:     PROCEDURE BtnProcessarPage1Click()
1590:     *==========================================================================
1591:         IF THIS.this_oBusinessObject.PrepararCursoresDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
1592:             LOCAL loc_oSub2 AS Object
1593:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1594:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1595:             IF USED("cursor_4c_Disponivel")
1596:                 loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1597:                 loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1598:                 loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1599:                 loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1600:                 loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1601:                 loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1602:                 loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1603:                 loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1604:                 loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1605:                 loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1606:                 loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1607:                 loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1608:                 loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1609:                 loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
1610:                 loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1611:                 loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1612:             ENDIF
1613:             loc_oSub2.grd_4c_Disponivel.Refresh()
1614:             loc_oSub2.grd_4c_Distribui.RecordSource = ""
1615:             IF USED("cursor_4c_Distribui")
1616:                 loc_oSub2.grd_4c_Distribui.ColumnCount = 4
1617:                 loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
1618:                 loc_oSub2.grd_4c_Distribui.Column1.ControlSource = "cursor_4c_Distribui.emps"
1619:                 loc_oSub2.grd_4c_Distribui.Column1.Header1.Caption = "Empresa"
1620:                 loc_oSub2.grd_4c_Distribui.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1621:                 loc_oSub2.grd_4c_Distribui.Column2.Header1.Caption = "Saldo"
1622:                 loc_oSub2.grd_4c_Distribui.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1623:                 loc_oSub2.grd_4c_Distribui.Column3.Header1.Caption = "Quantidade"
1624:                 loc_oSub2.grd_4c_Distribui.Column4.ControlSource = "cursor_4c_Distribui.locals"
1625:                 loc_oSub2.grd_4c_Distribui.Column4.Header1.Caption = "Local"
1626:             ENDIF
1627:             loc_oSub2.grd_4c_Distribui.Refresh()
1628:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
1629:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
1630:             loc_oSub2.grd_4c_Disponivel.SetFocus()
1631:         ENDIF
1632:     ENDPROC
1633: 
1634:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1635:     *==========================================================================
1636:         IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel")
1637:             LOCAL loc_cCpros AS String
1638:             SELECT cursor_4c_Disponivel
1639:             loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
1640:             IF !EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.BuscarProduto(loc_cCpros)
1641:                 LOCAL loc_oSub2 AS Object, loc_cCGru AS String, loc_cSGru AS String
1642:                 LOCAL loc_nRes AS Number, loc_oErro
1643:                 loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1644:                 SELECT cursor_4c_Produto
1645:                 loc_cCGru = TratarNulo(cgrus,  "C")
1646:                 loc_cSGru = TratarNulo(sgrus,  "C")
1647:                 loc_oSub2.txt_4c_CdGrupo.Value       = loc_cCGru
1648:                 loc_oSub2.txt_4c_DsGrupoP.Value      = TratarNulo(dgrus,       "C")
1649:                 loc_oSub2.txt_4c_CdLinha.Value        = TratarNulo(linhas,      "C")
1650:                 loc_oSub2.txt_4c_DsLinha.Value        = TratarNulo(desclin,     "C")
1651:                 loc_oSub2.txt_4c_CdSgrupoP.Value      = loc_cSGru
1652:                 loc_oSub2.txt_4c_CdFornecedor.Value   = TratarNulo(ifors,       "C")
1653:                 loc_oSub2.txt_4c_DsFornecedor.Value   = TratarNulo(rclis,       "C")
1654:                 loc_oSub2.txt_4c_CodFinP.Value        = TratarNulo(codfinp,     "C")
1655:                 loc_oSub2.txt_4c_DesFinP.Value        = TratarNulo(descfeitio,  "C")
1656:                 loc_oSub2.txt_4c_RefFornecedor.Value  = TratarNulo(reffs,       "C")
1657:                 loc_oSub2.txt_4c_GrpVenda.Value       = TratarNulo(colecoes,    "C")
1658:                 loc_oSub2.txt_4c_GrDvenda.Value       = ""
1659:                 loc_oSub2.txt_4c_PrVenda.Value        = TratarNulo(pvens,       "N")
1660:                 loc_oSub2.txt_4c_MoedaPrVenda.Value   = TratarNulo(moevs,       "C")
1661:                 loc_oSub2.txt_4c_PesoMedio.Value      = TratarNulo(pesoms,      "N")
1662: 
1663:                 *-- Subgrupo description from SigCdPsg (separate query like original)
1664:                 IF !EMPTY(loc_cSGru)
1665:                     TRY
1666:                         IF USED("cursor_4c_TmpSgru")
1667:                             USE IN cursor_4c_TmpSgru
1668:                         ENDIF
1669:                         loc_nRes = SQLEXEC(gnConnHandle, ;
1670:                             "SELECT s.descricaos FROM SigCdPsg s" + ;
1671:                             " WHERE s.cgrus = " + EscaparSQL(loc_cCGru) + ;
1672:                             " AND s.codigos = " + EscaparSQL(loc_cSGru), ;
1673:                             "cursor_4c_TmpSgru")
1674:                         IF loc_nRes > 0 AND USED("cursor_4c_TmpSgru") AND RECCOUNT("cursor_4c_TmpSgru") > 0
1675:                             SELECT cursor_4c_TmpSgru
1676:                             loc_oSub2.txt_4c_DsSgrupoP.Value = TratarNulo(descricaos, "C")
1677:                         ELSE
1678:                             loc_oSub2.txt_4c_DsSgrupoP.Value = ""
1679:                         ENDIF
1680:                         IF USED("cursor_4c_TmpSgru")
1681:                             USE IN cursor_4c_TmpSgru
1682:                         ENDIF
1683:                     CATCH TO loc_oErro
1684:                         MsgErro(loc_oErro.Message, "Erro lookup subgrupo")
1685:                     ENDTRY
1686:                 ELSE
1687:                     loc_oSub2.txt_4c_DsSgrupoP.Value = ""
1688:                 ENDIF
1689:             ENDIF
1690:         ENDIF
1691:     ENDPROC
1692: 
1693:     PROCEDURE GrdDistribuiQtdLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1694:     *==========================================================================
1695:         IF USED("cursor_4c_Disponivel") AND USED("cursor_4c_Distribui") ;
1696:                 AND !EOF("cursor_4c_Disponivel")
1697:             LOCAL loc_cCpros AS String, loc_cCodCors AS String, loc_cCodTams AS String
1698:             SELECT cursor_4c_Disponivel
1699:             loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
1700:             loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
1701:             loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)
1702:             THIS.this_oBusinessObject.CalcularSaldo(loc_cCpros, loc_cCodCors, loc_cCodTams)
1703:             LOCAL loc_oSub2 AS Object
1704:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1705:             loc_oSub2.grd_4c_Disponivel.Refresh()
1706:             loc_oSub2.grd_4c_Distribui.Refresh()
1707:         ENDIF
1708:     ENDPROC
1709: 
1710:     PROCEDURE GrdDistribuiLocalValid()
1711:     *==========================================================================
1712:         LOCAL loc_cLocal AS String, loc_nRes AS Number, loc_oLookup AS Object
1713:         LOCAL loc_lSucesso, loc_oErro
1714:         loc_lSucesso = .F.
1715:         TRY
1716:             loc_cLocal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2 ;
1717:                 .grd_4c_Distribui.Column4.Text1.Value)
1718:             IF !EMPTY(loc_cLocal)
1719:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1720:                     "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos LIKE " + ;
1721:                     EscaparSQL(loc_cLocal + "%") + " ORDER BY Codigos", ;
1722:                     "cursor_4c_Locais", "Codigos", loc_cLocal, ;
1723:                     "Localiza" + CHR(231) + CHR(227) + "o")
1724:                 IF VARTYPE(loc_oLookup) = "O"
1725:                     loc_oLookup.AddColuna("Codigos",    "", "Localiza" + CHR(231) + CHR(227) + "o")
1726:                     loc_oLookup.AddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1727:                     loc_oLookup.Show()
1728:                     IF USED("cursor_4c_Locais") AND RECCOUNT("cursor_4c_Locais") > 0
1729:                         IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
1730:                             REPLACE cursor_4c_Distribui.locals WITH ALLTRIM(cursor_4c_Locais.Codigos)
1731:                         ENDIF
1732:                     ENDIF
1733:                     IF USED("cursor_4c_Locais")
1734:                         USE IN cursor_4c_Locais
1735:                     ENDIF
1736:                 ENDIF

*-- Linhas 1756 a 1777:
1756: 
1757:     PROCEDURE TxtProdutoInicialValid()
1758:     *==========================================================================
1759:         LOCAL loc_cCpros AS String, loc_nRec AS Number
1760:         loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.txt_4c_ProdutoInicial.Value)
1761:         IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Disponivel")
1762:             SELECT cursor_4c_Disponivel
1763:             loc_nRec = RECNO()
1764:             GO TOP
1765:             LOCATE FOR ALLTRIM(cpros) >= loc_cCpros
1766:             IF EOF()
1767:                 GO loc_nRec
1768:             ENDIF
1769:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Refresh()
1770:         ENDIF
1771:     ENDPROC
1772: 
1773:     PROCEDURE TxtCodSgrupoValid(par_nKeyCode, par_nShiftAltCtrl)
1774:     *==========================================================================
1775:         LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
1776:         LOCAL loc_oSub2 AS Object
1777:         loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2

*-- Linhas 1792 a 1829:
1792:             IF USED("cursor_4c_SgruBusca")
1793:                 USE IN cursor_4c_SgruBusca
1794:             ENDIF
1795:             loc_nRes = SQLEXEC(gnConnHandle, ;
1796:                 "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos LIKE " + ;
1797:                 EscaparSQL(loc_cCodigo + "%") + " ORDER BY codigos", ;
1798:                 "cursor_4c_SgruBusca")
1799:             IF loc_nRes > 0 AND USED("cursor_4c_SgruBusca") AND RECCOUNT("cursor_4c_SgruBusca") > 0
1800:                 IF RECCOUNT("cursor_4c_SgruBusca") = 1
1801:                     SELECT cursor_4c_SgruBusca
1802:                     loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBusca.codigos)
1803:                     loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBusca.descricaos)
1804:                 ELSE
1805:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1806:                         "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos LIKE " + ;
1807:                         EscaparSQL(loc_cCodigo + "%") + " ORDER BY codigos", ;
1808:                         "cursor_4c_SgruBuscaD", "codigos", loc_cCodigo, "Subgrupos")
1809:                     IF VARTYPE(loc_oLookup) = "O"
1810:                         loc_oLookup.AddColuna("codigos",    "XXXXXXXXXX", "C" + CHR(243) + "digo")
1811:                         loc_oLookup.AddColuna("descricaos", "",            "Descri" + CHR(231) + CHR(227) + "o")
1812:                         loc_oLookup.Show()
1813:                         IF USED("cursor_4c_SgruBuscaD") AND RECCOUNT("cursor_4c_SgruBuscaD") > 0
1814:                             SELECT cursor_4c_SgruBuscaD
1815:                             loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBuscaD.codigos)
1816:                             loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBuscaD.descricaos)
1817:                         ENDIF
1818:                         IF USED("cursor_4c_SgruBuscaD")
1819:                             USE IN cursor_4c_SgruBuscaD
1820:                         ENDIF
1821:                     ENDIF
1822:                 ENDIF
1823:             ELSE
1824:                 loc_oSub2.txt_4c_CodSgrupo.Value = ""
1825:                 loc_oSub2.txt_4c_DsSgrupo.Value  = ""
1826:             ENDIF
1827:             IF USED("cursor_4c_SgruBusca")
1828:                 USE IN cursor_4c_SgruBusca
1829:             ENDIF

*-- Linhas 1852 a 1877:
1852:         ENDIF
1853:         TRY
1854:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1855:                 "SELECT descricaos, codigos FROM SigCdPsg ORDER BY descricaos", ;
1856:                 "cursor_4c_SgruBuscaDesc", "descricaos", loc_cDesc, "Subgrupos")
1857:             IF VARTYPE(loc_oLookup) = "O"
1858:                 loc_oLookup.AddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1859:                 loc_oLookup.AddColuna("codigos",    "", "C" + CHR(243) + "digo")
1860:                 loc_oLookup.Show()
1861:                 IF USED("cursor_4c_SgruBuscaDesc") AND RECCOUNT("cursor_4c_SgruBuscaDesc") > 0
1862:                     SELECT cursor_4c_SgruBuscaDesc
1863:                     loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBuscaDesc.codigos)
1864:                     loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBuscaDesc.descricaos)
1865:                 ELSE
1866:                     loc_oSub2.txt_4c_CodSgrupo.Value = ""
1867:                     loc_oSub2.txt_4c_DsSgrupo.Value  = ""
1868:                 ENDIF
1869:                 IF USED("cursor_4c_SgruBuscaDesc")
1870:                     USE IN cursor_4c_SgruBuscaDesc
1871:                 ENDIF
1872:             ENDIF
1873:         CATCH TO loc_oErro
1874:             MsgErro(loc_oErro.Message, "Erro lookup Subgrupo Descri" + CHR(231) + CHR(227) + "o")
1875:         ENDTRY
1876:     ENDPROC
1877: 

*-- Linhas 1892 a 1929:
1892:                 IF USED("cursor_4c_GrpBusca")
1893:                     USE IN cursor_4c_GrpBusca
1894:                 ENDIF
1895:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1896:                     "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
1897:                     EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", "cursor_4c_GrpBusca")
1898:                 IF loc_nRes > 0 AND USED("cursor_4c_GrpBusca") AND RECCOUNT("cursor_4c_GrpBusca") > 0
1899:                     IF RECCOUNT("cursor_4c_GrpBusca") = 1
1900:                         SELECT cursor_4c_GrpBusca
1901:                         loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBusca.CGrus)
1902:                         loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBusca.DGrus)
1903:                         THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBusca.CGrus)
1904:                     ELSE
1905:                         loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1906:                             "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
1907:                             EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", ;
1908:                             "cursor_4c_GrpBuscaD", "CGrus", loc_cCodigo, "Grupos")
1909:                         IF VARTYPE(loc_oLookup) = "O"
1910:                             loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1911:                             loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1912:                             loc_oLookup.Show()
1913:                             IF USED("cursor_4c_GrpBuscaD") AND RECCOUNT("cursor_4c_GrpBuscaD") > 0
1914:                                 SELECT cursor_4c_GrpBuscaD
1915:                                 loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
1916:                                 loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaD.DGrus)
1917:                                 THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
1918:                             ENDIF
1919:                             IF USED("cursor_4c_GrpBuscaD")
1920:                                 USE IN cursor_4c_GrpBuscaD
1921:                             ENDIF
1922:                         ENDIF
1923:                     ENDIF
1924:                 ELSE
1925:                     loc_oSub2.txt_4c_CodGrupo.Value = ""
1926:                     loc_oSub2.txt_4c_DsGrupo.Value  = ""
1927:                     THIS.this_cUltimoCGrupoValidado  = ""
1928:                 ENDIF
1929:                 IF USED("cursor_4c_GrpBusca")

*-- Linhas 1950 a 2083:
1950:         ELSE
1951:             TRY
1952:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1953:                     "SELECT DGrus, CGrus FROM SigCdGrp ORDER BY DGrus", ;
1954:                     "cursor_4c_GrpBuscaDesc", "DGrus", loc_cDesc, "Grupos")
1955:                 IF VARTYPE(loc_oLookup) = "O"
1956:                     loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1957:                     loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1958:                     loc_oLookup.Show()
1959:                     IF USED("cursor_4c_GrpBuscaDesc") AND RECCOUNT("cursor_4c_GrpBuscaDesc") > 0
1960:                         SELECT cursor_4c_GrpBuscaDesc
1961:                         loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaDesc.CGrus)
1962:                         loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
1963:                         THIS.this_cUltimoDGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
1964:                     ELSE
1965:                         loc_oSub2.txt_4c_CodGrupo.Value = ""
1966:                         loc_oSub2.txt_4c_DsGrupo.Value  = ""
1967:                         THIS.this_cUltimoDGrupoValidado = ""
1968:                     ENDIF
1969:                     IF USED("cursor_4c_GrpBuscaDesc")
1970:                         USE IN cursor_4c_GrpBuscaDesc
1971:                     ENDIF
1972:                 ENDIF
1973:             CATCH TO loc_oErro
1974:                 MsgErro(loc_oErro.Message, "Erro lookup Grupo Descri" + CHR(231) + CHR(227) + "o")
1975:             ENDTRY
1976:         ENDIF
1977:     ENDPROC
1978: 
1979:     PROCEDURE BtnFiltrarClick()
1980:     *==========================================================================
1981:         LOCAL loc_oSub2 AS Object, loc_cCGrupo AS String, loc_nRes AS Number, loc_oErro
1982:         loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1983:         loc_cCGrupo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
1984:         IF !USED("cursor_4c_Disponivel")
1985:             RETURN
1986:         ENDIF
1987:         IF EMPTY(loc_cCGrupo)
1988:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1989:             loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1990:             loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1991:             loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1992:             loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1993:             loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1994:             loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1995:             loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1996:             loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1997:             loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1998:             loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1999:             loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
2000:             loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
2001:             loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
2002:             loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
2003:             loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
2004:             loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
2005:             loc_oSub2.grd_4c_Disponivel.Refresh()
2006:         ELSE
2007:             TRY
2008:                 IF USED("cursor_4c_DispFiltro")
2009:                     USE IN cursor_4c_DispFiltro
2010:                 ENDIF
2011:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2012:                     "SELECT DISTINCT a.cpros," + ;
2013:                     "  ISNULL(p.dpros,'') AS dpros," + ;
2014:                     "  a.codcors, a.codtams," + ;
2015:                     "  SUM(a.qtdos) AS QtdEstoque," + ;
2016:                     "  SUM(a.qtds) AS QtdSaida," + ;
2017:                     "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
2018:                     " FROM SigPrDis a" + ;
2019:                     " INNER JOIN SigCdPro p ON p.cpros = a.cpros" + ;
2020:                     " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
2021:                     "   AND p.cgrus = " + EscaparSQL(loc_cCGrupo) + ;
2022:                     " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
2023:                     " ORDER BY a.cpros, a.codcors, a.codtams", "cursor_4c_DispFiltro")
2024:                 IF loc_nRes > 0
2025:                     loc_oSub2.grd_4c_Disponivel.RecordSource = ""
2026:                     loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
2027:                     loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_DispFiltro"
2028:                     loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_DispFiltro.cpros"
2029:                     loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2030:                     loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_DispFiltro.dpros"
2031:                     loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2032:                     loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_DispFiltro.codcors"
2033:                     loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
2034:                     loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_DispFiltro.codtams"
2035:                     loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
2036:                     loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_DispFiltro.QtdEstoque"
2037:                     loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
2038:                     loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_DispFiltro.QtdSaida"
2039:                     loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
2040:                     loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_DispFiltro.QtdSaldo"
2041:                     loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
2042:                     loc_oSub2.grd_4c_Disponivel.Refresh()
2043:                 ENDIF
2044:             CATCH TO loc_oErro
2045:                 MsgErro(loc_oErro.Message, "Erro Filtrar")
2046:             ENDTRY
2047:         ENDIF
2048:     ENDPROC
2049: 
2050:     PROCEDURE ImgFotoClick()
2051:     *==========================================================================
2052:         LOCAL loc_nRes AS Number, loc_cArquivo AS String, loc_oErro
2053:         IF !USED("cursor_4c_Disponivel") OR EOF("cursor_4c_Disponivel")
2054:             RETURN
2055:         ENDIF
2056:         TRY
2057:             SELECT cursor_4c_Disponivel
2058:             LOCAL loc_cCpros AS String
2059:             loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
2060:             IF !EMPTY(loc_cCpros)
2061:                 IF USED("cursor_4c_TmpFoto")
2062:                     USE IN cursor_4c_TmpFoto
2063:                 ENDIF
2064:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2065:                     "SELECT FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros), ;
2066:                     "cursor_4c_TmpFoto")
2067:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpFoto") > 0
2068:                     SELECT cursor_4c_TmpFoto
2069:                     IF !EMPTY(cursor_4c_TmpFoto.FigJpgs) AND !ISNULL(cursor_4c_TmpFoto.FigJpgs)
2070:                         LOCAL loc_cBase64 AS String, loc_cBin AS String
2071:                         loc_cBase64 = STRTRAN(STRTRAN(STRTRAN( ;
2072:                             cursor_4c_TmpFoto.FigJpgs, ;
2073:                             "data:image/png;base64,",  ""), ;
2074:                             "data:image/jpeg;base64,", ""), ;
2075:                             "data:image/jpg;base64,",  "")
2076:                         loc_cBin     = STRCONV(loc_cBase64, 14)
2077:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2078:                         STRTOFILE(loc_cBin, loc_cArquivo)
2079:                         IF FILE(loc_cArquivo)
2080:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.img_4c_FigJpg.Picture = ;
2081:                                 loc_cArquivo
2082:                         ENDIF
2083:                     ENDIF

*-- Linhas 2102 a 2185:
2102:                 LOCAL loc_oSub3 AS Object
2103:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
2104:                 LOCAL loc_oGrdCab2 AS Object
2105:                 loc_oGrdCab2 = loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
2106:                 loc_oGrdCab2.RecordSource = ""
2107:                 IF USED("cursor_4c_CabOpera")
2108:                     loc_oGrdCab2.ColumnCount  = 8
2109:                     loc_oGrdCab2.RecordSource = "cursor_4c_CabOpera"
2110:                     loc_oGrdCab2.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
2111:                     loc_oGrdCab2.Column1.Header1.Caption = "Emp O"
2112:                     loc_oGrdCab2.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
2113:                     loc_oGrdCab2.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2114:                     loc_oGrdCab2.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
2115:                     loc_oGrdCab2.Column3.Header1.Caption = "N" + CHR(176)
2116:                     loc_oGrdCab2.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
2117:                     loc_oGrdCab2.Column4.Header1.Caption = "Emp D"
2118:                     loc_oGrdCab2.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
2119:                     loc_oGrdCab2.Column5.Header1.Caption = "Grupo Orig"
2120:                     loc_oGrdCab2.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
2121:                     loc_oGrdCab2.Column6.Header1.Caption = "Conta Orig"
2122:                     loc_oGrdCab2.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
2123:                     loc_oGrdCab2.Column7.Header1.Caption = "Grupo Dest"
2124:                     loc_oGrdCab2.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
2125:                     loc_oGrdCab2.Column8.Header1.Caption = "Conta Dest"
2126:                 ENDIF
2127:                 loc_oGrdCab2.Refresh()
2128:                 loc_oSub3.Enabled = .T.
2129:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
2130:             ENDIF
2131:         ENDIF
2132:     ENDPROC
2133: 
2134:     PROCEDURE BtnProcOperClick()
2135:     *==========================================================================
2136:         LOCAL loc_oSub3 AS Object, loc_cCodObs AS String, loc_cObs AS String
2137:         loc_oSub3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
2138:         loc_cCodObs = ALLTRIM(loc_oSub3.cnt_4c_Operacao.txt_4c_CodObs.Value)
2139:         loc_cObs    = ALLTRIM(loc_oSub3.cnt_4c_Operacao.obj_4c_GetObs.Value)
2140:         MsgAviso("Processamento de opera" + CHR(231) + CHR(245) + "es n" + ;
2141:                  CHR(227) + "o implementado nesta vers" + CHR(227) + "o." + CHR(13) + ;
2142:                  "O lote j" + CHR(225) + " foi salvo em SigPrDis.", "Informa" + CHR(231) + CHR(227) + "o")
2143:     ENDPROC
2144: 
2145:     PROCEDURE GrdCabOperasAfterRowColChange(par_nColIndex)
2146:     *==========================================================================
2147:         IF USED("cursor_4c_CabOpera") AND !EOF("cursor_4c_CabOpera")
2148:             SELECT cursor_4c_CabOpera
2149:             LOCAL loc_cEmpDopNums AS String
2150:             loc_cEmpDopNums = ALLTRIM(cursor_4c_CabOpera.empdopnums)
2151:             IF !EMPTY(loc_cEmpDopNums) AND THIS.this_oBusinessObject.BuscarItensOperacao(loc_cEmpDopNums)
2152:                 LOCAL loc_oSub3 AS Object
2153:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
2154:                 LOCAL loc_oGrdItn AS Object
2155:                 loc_oGrdItn = loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
2156:                 loc_oGrdItn.RecordSource = ""
2157:                 IF USED("cursor_4c_ItensOper")
2158:                     loc_oGrdItn.ColumnCount  = 6
2159:                     loc_oGrdItn.RecordSource = "cursor_4c_ItensOper"
2160:                     loc_oGrdItn.Column1.ControlSource   = "cursor_4c_ItensOper.cpros"
2161:                     loc_oGrdItn.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2162:                     loc_oGrdItn.Column2.ControlSource   = "cursor_4c_ItensOper.dpros"
2163:                     loc_oGrdItn.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2164:                     loc_oGrdItn.Column3.ControlSource   = "cursor_4c_ItensOper.codcors"
2165:                     loc_oGrdItn.Column3.Header1.Caption = "Cor"
2166:                     loc_oGrdItn.Column4.ControlSource   = "cursor_4c_ItensOper.codtams"
2167:                     loc_oGrdItn.Column4.Header1.Caption = "Tam"
2168:                     loc_oGrdItn.Column5.ControlSource   = "cursor_4c_ItensOper.qtds"
2169:                     loc_oGrdItn.Column5.Header1.Caption = "Quantidade"
2170:                     loc_oGrdItn.Column6.ControlSource   = "cursor_4c_ItensOper.locals"
2171:                     loc_oGrdItn.Column6.Header1.Caption = "Local"
2172:                 ENDIF
2173:                 loc_oGrdItn.Refresh()
2174:             ENDIF
2175:         ENDIF
2176:     ENDPROC
2177: 
2178:     *==========================================================================
2179:     * FormParaBO - Transfere filtros de data do form para o BO
2180:     *==========================================================================
2181:     PROCEDURE FormParaBO()
2182:         LOCAL loc_oPg1 AS Object
2183:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2184:         THIS.this_oBusinessObject.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
2185:         THIS.this_oBusinessObject.this_dDataFinal   = loc_oPg1.txt_4c_DtFinal.Value

*-- Linhas 2290 a 2350:
2290:         LOCAL loc_cCodigos AS String
2291:         loc_cCodigos = ""
2292:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
2293:             SELECT cursor_4c_Dados
2294:             loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
2295:         ENDIF
2296:         IF EMPTY(loc_cCodigos)
2297:             MsgAviso("Selecione um lote na lista.", "Aviso")
2298:             RETURN
2299:         ENDIF
2300:         THIS.AbrirBatchExistente(loc_cCodigos)
2301:     ENDPROC
2302: 
2303:     *==========================================================================
2304:     PROCEDURE BtnVisualizarClick()
2305:     *==========================================================================
2306:         LOCAL loc_cCodigos AS String
2307:         loc_cCodigos = ""
2308:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
2309:             SELECT cursor_4c_Dados
2310:             loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
2311:         ENDIF
2312:         IF EMPTY(loc_cCodigos)
2313:             MsgAviso("Selecione um lote na lista.", "Aviso")
2314:             RETURN
2315:         ENDIF
2316:         THIS.AbrirBatchExistente(loc_cCodigos)
2317:     ENDPROC
2318: 
2319:     *==========================================================================
2320:     PROCEDURE BtnExcluirClick()
2321:     *==========================================================================
2322:         LOCAL loc_cCodigos AS String, loc_lResultado AS Logical, loc_nRes AS Number, loc_oErro AS Object
2323:         loc_lResultado = .F.
2324:         loc_cCodigos = ""
2325:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
2326:             SELECT cursor_4c_Dados
2327:             loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
2328:         ENDIF
2329:         IF EMPTY(loc_cCodigos)
2330:             MsgAviso("Selecione um lote na lista.", "Aviso")
2331:             RETURN
2332:         ENDIF
2333:         IF !MsgConfirma("Confirmar exclus" + CHR(227) + "o do lote " + loc_cCodigos + "?", "Excluir Lote")
2334:             RETURN
2335:         ENDIF
2336:         TRY
2337:             loc_nRes = SQLEXEC(gnConnHandle, "DELETE FROM SigPrDis WHERE Codigos = " + EscaparSQL(loc_cCodigos))
2338:             IF loc_nRes >= 0
2339:                 loc_lResultado = .T.
2340:                 MsgInfo("Lote exclu" + CHR(237) + "do com sucesso.", "Sucesso")
2341:                 THIS.CarregarLista()
2342:             ELSE
2343:                 MsgErro("Erro ao excluir lote: " + CapturarErroSQL(), "Erro SQL")
2344:             ENDIF
2345:         CATCH TO loc_oErro
2346:             MsgErro(loc_oErro.Message, "Erro ao excluir")
2347:         ENDTRY
2348:     ENDPROC
2349: 
2350: ENDDEFINE


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
                       "  a.pcuss, a.moecs, a.pvideals, a.ifors, a.codfinp," + ;
                       "  ISNULL(c.Rclis, '') AS rclis," + ;
                       "  ISNULL(g.dgrus, '') AS dgrus," + ;
                       "  ISNULL(l.descs,  '') AS desclin," + ;
                       "  ISNULL(f.descs,  '') AS descfeitio" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis  = a.ifors" + ;
                       " LEFT JOIN SigCdGrp g ON g.cgrus  = a.cgrus" + ;
                       " LEFT JOIN SigCdLin l ON l.linhas = a.linhas" + ;
                       " LEFT JOIN SigPrFti f ON f.cods   = a.cftios" + ;
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
                       "  m.empds AS empds, m.grupos AS grupos, m.contaos AS contaos," + ;
                       "  m.grupods AS grupods, m.contads AS contads," + ;
                       "  m.datas AS datas, m.empdopnums AS empdopnums" + ;
                       " FROM SigMvCab m" + ;
                       " WHERE m.empdopnums IN (" + ;
                       "   SELECT DISTINCT empdopnums FROM sigprdis" + ;
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
    * Cria cursor_4c_ItensOper: cidchaves, cpros, dpros, codcors, codtams, qtds, locals
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensOperacao(par_cEmpdopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ItensOper")
                USE IN cursor_4c_ItensOper
            ENDIF

            loc_cSQL = "SELECT d.cidchaves, d.cpros, ISNULL(p.dpros,'') AS dpros," + ;
                       "  d.codcors, d.codtams, d.qtds, d.locals" + ;
                       " FROM sigprdis d" + ;
                       " LEFT JOIN SigCdPro p ON p.cpros = d.cpros" + ;
                       " WHERE d.empdopnums = " + EscaparSQL(par_cEmpdopNums) + ;
                       " ORDER BY d.cpros, d.codcors, d.codtams"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensOper")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar itens da opera" + CHR(231) + CHR(227) + "o:" + ;
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

