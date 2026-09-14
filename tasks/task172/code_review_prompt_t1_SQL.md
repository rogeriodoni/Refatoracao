# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (34)
- [GRID-SQL] Campo 'nMarca' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Cemps' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'CGrus' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'CCons' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'item' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cpros' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dpros' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'unitmeds' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'qtds' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'units' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'totas' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcors' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codtams' usado em ControlSource de cursor_4c_ItnOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'emps' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'opers' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dopes' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'empds' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupoos' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contaos' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupods' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contads' usado em ControlSource de cursor_4c_CabOperas mas NAO aparece no SELECT SQL
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
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TIPOESTOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODIGOS, DATAS, TPCADS, EMPDOPNUMS, CITENS, SQTDS, NMARCA, CGRUS, QTDDISTR, QTDSALDO, GRUPOS, ESTOS, EMPS, CONTAS, CODCORS, CODTAMS, XBAIXA, ORIGEMS, DOPES

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS SQL (2807 linhas total):

*-- Linhas 393 a 411:
393:             .HighlightBackColor = RGB(255, 255, 255)
394:             .HighlightForeColor = RGB(15, 41, 104)
395:             .HighlightStyle     = 2
396:             .DeleteMark         = .F.
397:             .RecordMark         = .F.
398:             .RowHeight          = 16
399:             .ScrollBars         = 2
400:             .GridLines          = 3
401:             .Visible            = .T.
402:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
403:             .Column1.Width           = 150
404:             .Column2.Header1.Caption = "Data"
405:             .Column2.Width           = 150
406:         ENDWITH
407: 
408:         *-- BINDEVENTs
409:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
410:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
411:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")

*-- Linhas 585 a 603:
585:             .HighlightBackColor = RGB(255, 255, 255)
586:             .HighlightForeColor = RGB(15, 41, 104)
587:             .HighlightStyle     = 2
588:             .DeleteMark         = .F.
589:             .RecordMark         = .F.
590:             .RowHeight          = 18
591:             .ScrollBars         = 2
592:             .GridLines          = 3
593:             .Visible            = .T.
594:             .Column1.Header1.Caption = ""
595:             .Column1.Width           = 25
596:             .Column2.Header1.Caption = "Empresa"
597:             .Column2.Width           = 80
598:             .Column3.Header1.Caption = "Grupo"
599:             .Column3.Width           = 80
600:             .Column4.Header1.Caption = "Conta"
601:             .Column4.Width           = 80
602:         ENDWITH
603: 

*-- Linhas 675 a 707:
675:                 loc_dDatai  = loc_oPagina.txt_4c_DtInicial.Value
676:                 loc_dDataf  = loc_oPagina.txt_4c_DtFinal.Value
677: 
678:                 loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
679:                            " WHERE CAST(Datas AS DATE) BETWEEN" + ;
680:                            " CAST(" + FormatarDataSQL(loc_dDatai) + " AS DATE)" + ;
681:                            " AND CAST(" + FormatarDataSQL(loc_dDataf) + " AS DATE)"
682: 
683:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
684: 
685:                 IF loc_nRet < 0
686:                     MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
687:                     loc_lResultado = .F.
688:                 ELSE
689:                     loc_oGrid.ColumnCount = 2
690:                     loc_oGrid.RecordSource            = "cursor_4c_Lista"
691:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.Codigos"
692:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.Datas"
693:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
694:                     loc_oGrid.Column2.Header1.Caption = "Data"
695:                     loc_oGrid.Column1.Width           = 150
696:                     loc_oGrid.Column2.Width           = 150
697:                     THIS.FormatarGridLista(loc_oGrid)
698:                     loc_lResultado = .T.
699:                 ENDIF
700:             ENDIF
701: 
702:         CATCH TO loc_oErro
703:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
704:             loc_lResultado = .F.
705:         ENDTRY
706: 
707:         RETURN loc_lResultado

*-- Linhas 719 a 758:
719:                 loc_lResultado = .T.
720:             ELSE
721:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
722:                 loc_oGrid = loc_oPage.grd_4c_Estoque
723: 
724:                 IF USED("cursor_4c_Estoque")
725:                     USE IN cursor_4c_Estoque
726:                 ENDIF
727: 
728:                 loc_cSQL = "SELECT 0 AS nMarca, Cemps, CGrus, CCons" + ;
729:                            " FROM SigCdCeg WHERE TpCads = 3 ORDER BY Cemps"
730: 
731:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")
732: 
733:                 IF loc_nRet < 0
734:                     MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
735:                     loc_lResultado = .F.
736:                 ELSE
737:                     loc_oGrid.ColumnCount = 3
738:                     loc_oGrid.RecordSource = "cursor_4c_Estoque"
739: 
740:                     loc_oGrid.Column1.chk_4c_nMarca.ControlSource  = "cursor_4c_Estoque.nMarca"
741:                     loc_oGrid.Column2.txt_4c_Empresa.ControlSource  = "cursor_4c_Estoque.Cemps"
742:                     loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.CGrus"
743:                     loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.CCons"
744: 
745:                     loc_oGrid.Column1.Header1.Caption = ""
746:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
747:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
748:                     loc_oGrid.Column4.Header1.Caption = "Conta"
749: 
750:                     loc_lResultado = .T.
751:                 ENDIF
752:             ENDIF
753: 
754:         CATCH TO loc_oErro
755:             MsgErro("Erro em CarregarEstoque:" + CHR(13) + loc_oErro.Message, "Erro")
756:             loc_lResultado = .F.
757:         ENDTRY
758: 

*-- Linhas 834 a 891:
834:             RETURN
835:         ENDIF
836: 
837:         SELECT cursor_4c_Lista
838:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
839: 
840:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
841:             THIS.this_cModoAtual = "VISUALIZAR"
842:             THIS.AlternarPagina(2)
843:         ENDIF
844:     ENDPROC
845: 
846:     *==========================================================================
847:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
848:     *==========================================================================
849:     PROCEDURE BtnAlterarClick()
850:         LOCAL loc_cCodigo
851:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
852:             MsgAviso("Nenhum registro selecionado.", "Aviso")
853:             RETURN
854:         ENDIF
855: 
856:         SELECT cursor_4c_Lista
857:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
858: 
859:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
860:             THIS.this_oBusinessObject.EditarRegistro()
861:             THIS.this_cModoAtual = "ALTERAR"
862:             THIS.AlternarPagina(2)
863:         ENDIF
864:     ENDPROC
865: 
866:     *==========================================================================
867:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
868:     *==========================================================================
869:     PROCEDURE BtnExcluirClick()
870:         LOCAL loc_cCodigo
871:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
872:             MsgAviso("Nenhum registro selecionado.", "Aviso")
873:             RETURN
874:         ENDIF
875: 
876:         SELECT cursor_4c_Lista
877:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
878: 
879:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da distribui" + ;
880:                         CHR(231) + CHR(227) + "o " + loc_cCodigo + "?", ;
881:                         "Confirmar Exclus" + CHR(227) + "o")
882:             RETURN
883:         ENDIF
884: 
885:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
886:             IF THIS.this_oBusinessObject.Excluir()
887:                 MsgInfo("Distribui" + CHR(231) + CHR(227) + "o exclu" + ;
888:                         CHR(237) + "da com sucesso.", "")
889:                 THIS.CarregarLista()
890:             ENDIF
891:         ENDIF

*-- Linhas 947 a 993:
947:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
948: 
949:         TRY
950:             loc_nVal = loc_oPage.cmg_4c_MarcaDesmarca.Value
951: 
952:             IF USED("cursor_4c_Estoque")
953:                 IF loc_nVal = 1
954:                     REPLACE ALL nMarca WITH 1 IN cursor_4c_Estoque
955:                 ELSE
956:                     REPLACE ALL nMarca WITH 0 IN cursor_4c_Estoque
957:                 ENDIF
958:                 loc_oPage.grd_4c_Estoque.Refresh()
959:             ENDIF
960: 
961:         CATCH TO loc_oErro
962:             MsgErro("Erro em CmgMarcaDesmarcaClick:" + CHR(13) + loc_oErro.Message, "Erro")
963:         ENDTRY
964:     ENDPROC
965: 
966:     *==========================================================================
967:     * BtnProcessarClick - Processa selecao de estoques e abre aba Distribuicao
968:     *==========================================================================
969:     PROCEDURE BtnProcessarClick()
970:         LOCAL loc_oErro
971: 
972:         IF !USED("cursor_4c_Estoque") OR RECCOUNT("cursor_4c_Estoque") = 0
973:             MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para processar.", "Processar")
974:             RETURN
975:         ENDIF
976: 
977:         TRY
978:             IF THIS.this_oBusinessObject.ProcessarDistribuicao("cursor_4c_Estoque")
979:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Enabled = .T.
980:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.Enabled = .T.
981:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage    = 2
982:                 THIS.CarregarDisponivel()
983:             ENDIF
984: 
985:         CATCH TO loc_oErro
986:             MsgErro("Erro em BtnProcessarClick:" + CHR(13) + loc_oErro.Message, "Erro")
987:         ENDTRY
988:     ENDPROC
989: 
990:     *==========================================================================
991:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
992:     *==========================================================================
993:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)

*-- Linhas 1224 a 1242:
1224:             .HighlightBackColor = RGB(255, 255, 255)
1225:             .HighlightForeColor = RGB(15, 41, 104)
1226:             .HighlightStyle     = 2
1227:             .DeleteMark         = .F.
1228:             .RecordMark         = .F.
1229:             .RowHeight          = 18
1230:             .ScrollBars         = 2
1231:             .GridLines          = 3
1232:             .Visible            = .T.
1233:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1234:             .Column1.Width           = 90
1235:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1236:             .Column2.Width           = 200
1237:             .Column3.Header1.Caption = "Cor"
1238:             .Column3.Width           = 60
1239:             .Column4.Header1.Caption = "Tam"
1240:             .Column4.Width           = 40
1241:             .Column5.Header1.Caption = "Estoque"
1242:             .Column5.Width           = 70

*-- Linhas 1294 a 1312:
1294:             .HighlightBackColor = RGB(255, 255, 255)
1295:             .HighlightForeColor = RGB(15, 41, 104)
1296:             .HighlightStyle     = 2
1297:             .DeleteMark         = .F.
1298:             .RecordMark         = .F.
1299:             .RowHeight          = 18
1300:             .ScrollBars         = 2
1301:             .GridLines          = 3
1302:             .Visible            = .T.
1303:             .Column1.Header1.Caption = "Empresa"
1304:             .Column1.Width           = 60
1305:             .Column2.Header1.Caption = "Saldo"
1306:             .Column2.Width           = 70
1307:             .Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
1308:             .Column3.Width           = 80
1309:             .Column4.Header1.Caption = "Local"
1310:             .Column4.Width           = 90
1311:         ENDWITH
1312: 

*-- Linhas 1607 a 1650:
1607: 
1608:         THIS.TornarControlesVisiveis(loc_oPage)
1609:     ENDPROC
1610: 
1611:     *==========================================================================
1612:     * CarregarDisponivel - Vincula grd_4c_Disponivel ao cursor_4c_Disponivel
1613:     *==========================================================================
1614:     PROTECTED PROCEDURE CarregarDisponivel()
1615:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1616:         loc_lResultado = .F.
1617: 
1618:         TRY
1619:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1620:                 loc_lResultado = .T.
1621:             ELSE
1622:                 IF USED("cursor_4c_Disponivel")
1623:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1624:                 loc_oGrid = loc_oPage.grd_4c_Disponivel
1625: 
1626:                 loc_oGrid.ColumnCount = 7
1627:                 loc_oGrid.RecordSource = "cursor_4c_Disponivel"
1628: 
1629:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Disponivel.Cpros"
1630:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Disponivel.Dpros"
1631:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Disponivel.CodCors"
1632:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Disponivel.CodTams"
1633:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Disponivel.Sqtds"
1634:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1635:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1636: 
1637:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1638:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1639:                 loc_oGrid.Column3.Header1.Caption = "Cor"
1640:                 loc_oGrid.Column4.Header1.Caption = "Tam"
1641:                 loc_oGrid.Column5.Header1.Caption = "Estoque"
1642:                 loc_oGrid.Column6.Header1.Caption = "Saldo"
1643:                 loc_oGrid.Column7.Header1.Caption = "Distribu" + CHR(237) + "do"
1644: 
1645:                 THIS.FormatarGridLista(loc_oGrid)
1646:                 loc_oGrid.Refresh()
1647: 
1648:                 THIS.CarregarDistribui()
1649: 
1650:                 loc_lResultado = .T.

*-- Linhas 1658 a 1698:
1658: 
1659:         RETURN loc_lResultado
1660:     ENDPROC
1661: 
1662:     *==========================================================================
1663:     * CarregarDistribui - Vincula grd_4c_Distribui ao cursor_4c_Distribui
1664:     *==========================================================================
1665:     PROTECTED PROCEDURE CarregarDistribui()
1666:         LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
1667:         loc_lResultado = .F.
1668: 
1669:         TRY
1670:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1671:                 loc_lResultado = .T.
1672:             ELSE
1673:                 IF USED("cursor_4c_Distribui")
1674:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1675:                 loc_oGrid = loc_oPage.grd_4c_Distribui
1676: 
1677:                 loc_oGrid.ColumnCount = 4
1678:                 loc_oGrid.RecordSource = "cursor_4c_Distribui"
1679: 
1680:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Distribui.Cemps"
1681:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1682:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1683:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"
1684: 
1685:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1686:                 loc_oGrid.Column2.Header1.Caption = "Saldo"
1687:                 loc_oGrid.Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
1688:                 loc_oGrid.Column4.Header1.Caption = "Local"
1689: 
1690:                 THIS.FormatarGridLista(loc_oGrid)
1691:                 loc_oGrid.Refresh()
1692: 
1693:                 loc_lResultado = .T.
1694:                 ENDIF
1695:             ENDIF
1696: 
1697:         CATCH TO loc_oErro
1698:             MsgErro("Erro em CarregarDistribui:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1707 a 1788:
1707:     *==========================================================================
1708:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1709:         LOCAL loc_cCodPro, loc_oPage, loc_oErro
1710: 
1711:         TRY
1712:             IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel") ;
1713:                AND USED("cursor_4c_Distribui")
1714:                 SELECT cursor_4c_Disponivel
1715:                 loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1716:                 SELECT cursor_4c_Distribui
1717:                 SET FILTER TO ALLTRIM(Cpros) = loc_cCodPro
1718:                 GO TOP IN cursor_4c_Distribui
1719:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Distribui.Refresh()
1720:                 THIS.PopularInfoProduto(loc_cCodPro)
1721:             ENDIF
1722: 
1723:         CATCH TO loc_oErro
1724:             MsgErro("Erro em GrdDisponivelAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1725:         ENDTRY
1726:     ENDPROC
1727: 
1728:     *==========================================================================
1729:     * DistribuidoLostFocus - Recalcula saldo ao sair do campo Distribuido
1730:     *==========================================================================
1731:     PROCEDURE DistribuidoLostFocus()
1732:         THIS.CalcularSaldo()
1733:     ENDPROC
1734: 
1735:     *==========================================================================
1736:     * CalcularSaldo - Recalcula QtdSaida e QtdSaldo no cursor_4c_Disponivel
1737:     *==========================================================================
1738:     PROCEDURE CalcularSaldo()
1739:         LOCAL loc_nQtdTotal, loc_cCodPro, loc_oPage, loc_oErro
1740: 
1741:         TRY
1742:             IF !USED("cursor_4c_Disponivel") OR !USED("cursor_4c_Distribui")
1743:                 loc_oErro = .NULL.
1744:             ELSE
1745:                 IF !EOF("cursor_4c_Disponivel")
1746:                     SELECT cursor_4c_Disponivel
1747:                     loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
1748: 
1749:                     SUM cursor_4c_Distribui.QtdDistr ;
1750:                         FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
1751:                         TO loc_nQtdTotal
1752: 
1753:                     SELECT cursor_4c_Disponivel
1754:                     REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
1755:                             cursor_4c_Disponivel.QtdSaldo  WITH ;
1756:                                 cursor_4c_Disponivel.Sqtds - loc_nQtdTotal
1757: 
1758:                     IF cursor_4c_Disponivel.QtdSaldo < 0
1759:                         MsgAviso("Saldo insuficiente para movimentar." + CHR(13) + ;
1760:                                  "O valor excede o estoque dispon" + CHR(237) + "vel.", ;
1761:                                  "Saldo Insuficiente")
1762:                         SELECT cursor_4c_Distribui
1763:                         REPLACE cursor_4c_Distribui.QtdDistr WITH 0 FOR ;
1764:                             ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro
1765: 
1766:                         SUM cursor_4c_Distribui.QtdDistr ;
1767:                             FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
1768:                             TO loc_nQtdTotal
1769: 
1770:                         SELECT cursor_4c_Disponivel
1771:                         REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
1772:                                 cursor_4c_Disponivel.QtdSaldo  WITH ;
1773:                                     cursor_4c_Disponivel.Sqtds - loc_nQtdTotal
1774:                     ENDIF
1775: 
1776:                     loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1777:                     loc_oPage.grd_4c_Disponivel.Refresh()
1778:                     loc_oPage.grd_4c_Distribui.Refresh()
1779:                 ENDIF
1780:             ENDIF
1781: 
1782:         CATCH TO loc_oErro
1783:             MsgErro("Erro em CalcularSaldo:" + CHR(13) + loc_oErro.Message, "Erro")
1784:         ENDTRY
1785:     ENDPROC
1786: 
1787:     *==========================================================================
1788:     * LocalDistribuidoValid - Lookup localizacao SigPrLcl (Column4 grdDistribui)

*-- Linhas 1800 a 1833:
1800:                     "Localiza" + CHR(231) + CHR(227) + "o")
1801: 
1802:                 IF VARTYPE(loc_oBusca) = "O"
1803:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1804:                         IF USED("cursor_4c_BuscaLocal")
1805:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1806:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1807:                         ENDIF
1808:                     ELSE
1809:                         IF !loc_oBusca.this_lAchouRegistro
1810:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1811:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1812:                         loc_oBusca.Show()
1813:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
1814:                             REPLACE cursor_4c_Distribui.CidChaves WITH ;
1815:                                 ALLTRIM(cursor_4c_BuscaLocal.Codigos)
1816:                         ENDIF
1817:                     ELSE
1818:                         REPLACE cursor_4c_Distribui.CidChaves WITH ""
1819:                         ENDIF
1820:                     ENDIF
1821:                     loc_oBusca.Release()
1822:                 ENDIF
1823: 
1824:                 IF USED("cursor_4c_BuscaLocal")
1825:                     USE IN cursor_4c_BuscaLocal
1826:                 ENDIF
1827:             ENDIF
1828: 
1829:         CATCH TO loc_oErro
1830:             MsgErro("Erro em LocalDistribuidoValid:" + CHR(13) + loc_oErro.Message, "Erro")
1831:         ENDTRY
1832:     ENDPROC
1833: 

*-- Linhas 2036 a 2101:
2036:     *==========================================================================
2037:     PROCEDURE FiltrarDisponivelClick()
2038:         LOCAL loc_cCodGrp, loc_cCodSgrp, loc_oPage, loc_oErro
2039: 
2040:         TRY
2041:             IF USED("cursor_4c_Disponivel")
2042:                 loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2043:                 loc_cCodGrp  = ALLTRIM(loc_oPage.txt_4c_CodGrupoDist.Value)
2044:                 loc_cCodSgrp = ALLTRIM(loc_oPage.txt_4c_CodSgrupoDist.Value)
2045: 
2046:                 SELECT cursor_4c_Disponivel
2047: 
2048:                 IF EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2049:                     SET FILTER TO
2050:                 ELSE
2051:                     IF !EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
2052:                     SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp
2053:                 ELSE
2054:                     IF EMPTY(loc_cCodGrp) AND !EMPTY(loc_cCodSgrp)
2055:                     SET FILTER TO ALLTRIM(Sgrus) = loc_cCodSgrp
2056:                 ELSE
2057:                     SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp ;
2058:                                   AND ALLTRIM(Sgrus) = loc_cCodSgrp
2059:                     ENDIF
2060:                     ENDIF
2061:                 ENDIF
2062: 
2063:                 GO TOP IN cursor_4c_Disponivel
2064:                 loc_oPage.grd_4c_Disponivel.Refresh()
2065:             ENDIF
2066: 
2067:         CATCH TO loc_oErro
2068:             MsgErro("Erro em FiltrarDisponivelClick:" + CHR(13) + loc_oErro.Message, "Erro")
2069:         ENDTRY
2070:     ENDPROC
2071: 
2072:     *==========================================================================
2073:     * ProdutoInicialValid - Navega grd_4c_Disponivel para o produto informado
2074:     *==========================================================================
2075:     PROCEDURE ProdutoInicialValid()
2076:         LOCAL loc_cProd, loc_oPage, loc_oErro
2077: 
2078:         TRY
2079:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2080:             loc_cProd = ALLTRIM(loc_oPage.txt_4c_ProdutoInicial.Value)
2081: 
2082:             IF !EMPTY(loc_cProd) AND USED("cursor_4c_Disponivel")
2083:                 SELECT cursor_4c_Disponivel
2084:                 GO TOP
2085:                 LOCATE FOR ALLTRIM(Cpros) >= loc_cProd
2086:                 IF !EOF("cursor_4c_Disponivel")
2087:                     loc_oPage.grd_4c_Disponivel.Refresh()
2088:                 ENDIF
2089:             ENDIF
2090: 
2091:         CATCH TO loc_oErro
2092:             MsgErro("Erro em ProdutoInicialValid:" + CHR(13) + loc_oErro.Message, "Erro")
2093:         ENDTRY
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * PopularInfoProduto - Preenche o painel info com dados do produto selecionado
2098:     *==========================================================================
2099:     PROCEDURE PopularInfoProduto(par_cCodPro)
2100:         LOCAL loc_oPage, loc_cSQL, loc_nRet, loc_oErro
2101: 

*-- Linhas 2120 a 2175:
2120:             loc_oPage.txt_4c_DsModeloInfo.Value   = ""
2121: 
2122:             IF !EMPTY(ALLTRIM(par_cCodPro))
2123:                 loc_cSQL = "SELECT RTRIM(a.cgrus) AS cgrus, " + ;
2124:                     "RTRIM(ISNULL(g.dgrus,'')) AS dgrus, " + ;
2125:                     "RTRIM(a.sgrus) AS sgrus, " + ;
2126:                     "RTRIM(ISNULL(sg.descricaos,'')) AS dsgrus, " + ;
2127:                     "RTRIM(a.ifors) AS ifors, " + ;
2128:                     "RTRIM(ISNULL(c.rclis,'')) AS rclis, " + ;
2129:                     "RTRIM(a.reffs) AS reffs, " + ;
2130:                     "a.pvens, RTRIM(a.moedas) AS moedas, a.pesoms, " + ;
2131:                     "RTRIM(a.cvens) AS cvens, " + ;
2132:                     "RTRIM(ISNULL(col.descs,'')) AS dcvens, " + ;
2133:                     "RTRIM(a.linhas) AS linhas, " + ;
2134:                     "RTRIM(ISNULL(lin.descs,'')) AS dlinhas, " + ;
2135:                     "RTRIM(a.codfinp) AS codfinp, " + ;
2136:                     "RTRIM(ISNULL(finp.descs,'')) AS dcodfinp " + ;
2137:                     "FROM SigCdPro a " + ;
2138:                     "LEFT JOIN SigCdGrp g " + ;
2139:                     "    ON RTRIM(g.cgrus) = RTRIM(a.cgrus) " + ;
2140:                     "LEFT JOIN SigCdPsg sg " + ;
2141:                     "    ON sg.cgrus = RTRIM(a.cgrus) AND sg.codigos = RTRIM(a.sgrus) " + ;
2142:                     "LEFT JOIN SIGCDCLI c " + ;
2143:                     "    ON RTRIM(c.iclis) = RTRIM(a.ifors) " + ;
2144:                     "LEFT JOIN SigCdCol col " + ;
2145:                     "    ON RTRIM(col.colecoes) = RTRIM(a.cvens) " + ;
2146:                     "LEFT JOIN SigCdLin lin " + ;
2147:                     "    ON RTRIM(lin.linhas) = RTRIM(a.linhas) " + ;
2148:                     "LEFT JOIN SigCdFip finp " + ;
2149:                     "    ON RTRIM(finp.cods) = RTRIM(a.codfinp) " + ;
2150:                     "WHERE RTRIM(a.cpros) = " + EscaparSQL(par_cCodPro)
2151: 
2152:                 IF USED("cursor_4c_InfoPro")
2153:                     USE IN cursor_4c_InfoPro
2154:                 ENDIF
2155: 
2156:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InfoPro")
2157: 
2158:                 IF loc_nRet > 0 AND USED("cursor_4c_InfoPro") ;
2159:                    AND RECCOUNT("cursor_4c_InfoPro") > 0
2160:                     SELECT cursor_4c_InfoPro
2161:                     GO TOP
2162: 
2163:                     loc_oPage.txt_4c_CdGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.cgrus)
2164:                     loc_oPage.txt_4c_DsGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.dgrus)
2165:                     loc_oPage.txt_4c_CdSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.sgrus)
2166:                     loc_oPage.txt_4c_DsSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.dsgrus)
2167:                     loc_oPage.txt_4c_CdFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.ifors)
2168:                     loc_oPage.txt_4c_DsFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.rclis)
2169:                     loc_oPage.txt_4c_RefFornInfo.Value    = ALLTRIM(cursor_4c_InfoPro.reffs)
2170:                     loc_oPage.txt_4c_PrVendaInfo.Value    = LTRIM(STR(cursor_4c_InfoPro.pvens, 12, 2))
2171:                     loc_oPage.txt_4c_PrVendaMoeInfo.Value = ALLTRIM(cursor_4c_InfoPro.moedas)
2172:                     loc_oPage.txt_4c_PesoMedioInfo.Value  = LTRIM(STR(cursor_4c_InfoPro.pesoms, 10, 3))
2173:                     loc_oPage.txt_4c_CdGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.cvens)
2174:                     loc_oPage.txt_4c_DsGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.dcvens)
2175:                     loc_oPage.txt_4c_CdLinhaInfo.Value    = ALLTRIM(cursor_4c_InfoPro.linhas)

*-- Linhas 2300 a 2318:
2300:             .HighlightBackColor = RGB(255, 255, 255)
2301:             .HighlightForeColor = RGB(15, 41, 104)
2302:             .HighlightStyle     = 2
2303:             .DeleteMark         = .F.
2304:             .RecordMark         = .F.
2305:             .RowHeight          = 18
2306:             .ScrollBars         = 3
2307:             .GridLines          = 3
2308:             .ReadOnly           = .T.
2309:             .Visible            = .T.
2310:             .Column1.Header1.Caption = "Emp O"
2311:             .Column1.Width           = 55
2312:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2313:             .Column2.Width           = 110
2314:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
2315:             .Column3.Width           = 130
2316:             .Column4.Header1.Caption = "Emp D"
2317:             .Column4.Width           = 55
2318:             .Column5.Header1.Caption = "Grupo Orig"

*-- Linhas 2368 a 2386:
2368:             .HighlightBackColor = RGB(255, 255, 255)
2369:             .HighlightForeColor = RGB(15, 41, 104)
2370:             .HighlightStyle     = 2
2371:             .DeleteMark         = .F.
2372:             .RecordMark         = .F.
2373:             .RowHeight          = 18
2374:             .ScrollBars         = 3
2375:             .GridLines          = 3
2376:             .ReadOnly           = .T.
2377:             .Visible            = .T.
2378:             .Column1.Header1.Caption = "Item"
2379:             .Column1.Width           = 50
2380:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
2381:             .Column2.Width           = 100
2382:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2383:             .Column3.Width           = 200
2384:             .Column4.Header1.Caption = "Uni"
2385:             .Column4.Width           = 40
2386:             .Column5.Header1.Caption = "Quantidade"

*-- Linhas 2434 a 2474:
2434:     *==========================================================================
2435:     PROCEDURE PgItensActivate()
2436:         LOCAL loc_oPage, loc_oErro
2437: 
2438:         TRY
2439:             IF USED("cursor_4c_ItnOperas")
2440:                 GO TOP IN cursor_4c_ItnOperas
2441:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2442:                 IF VARTYPE(loc_oPage) = "O" AND VARTYPE(loc_oPage.grd_4c_ItnOperas) = "O"
2443:                     loc_oPage.grd_4c_ItnOperas.Refresh()
2444:                 ENDIF
2445:             ENDIF
2446: 
2447:         CATCH TO loc_oErro
2448:             MsgErro("Erro em PgItensActivate:" + CHR(13) + loc_oErro.Message, "Erro")
2449:         ENDTRY
2450:     ENDPROC
2451: 
2452:     *==========================================================================
2453:     * BtnProcessarFinalClick - Valida, salva lote em sigprdis e exibe operacoes
2454:     *==========================================================================
2455:     PROCEDURE BtnProcessarFinalClick()
2456:         LOCAL loc_oErro
2457: 
2458:         TRY
2459:             IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
2460:                 MsgAviso("Nenhuma distribui" + CHR(231) + CHR(227) + "o para processar." + ;
2461:                          CHR(13) + "Processe os estoques primeiro.", "Processar")
2462:             ELSE
2463:                 IF THIS.this_oBusinessObject.SalvarLote()
2464:                     MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso!", "")
2465:                     THIS.CarregarCabOperas()
2466:                     THIS.CarregarItnOperas()
2467:                 ENDIF
2468:             ENDIF
2469: 
2470:         CATCH TO loc_oErro
2471:             MsgErro("Erro em BtnProcessarFinalClick:" + CHR(13) + loc_oErro.Message, "Erro")
2472:         ENDTRY
2473:     ENDPROC
2474: 

*-- Linhas 2482 a 2625:
2482:         TRY
2483:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page1
2484:             loc_oGrid   = loc_oPage.grd_4c_CabOperas
2485:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2486: 
2487:             IF USED("cursor_4c_CabOperas")
2488:                 USE IN cursor_4c_CabOperas
2489:             ENDIF
2490: 
2491:             loc_cSQL = "SELECT DISTINCT RTRIM(c.emps) AS emps, RTRIM(c.opers) AS opers, " + ;
2492:                        "RTRIM(c.dopes) AS dopes, RTRIM(c.empds) AS empds, " + ;
2493:                        "RTRIM(c.grupoos) AS grupoos, RTRIM(c.contaos) AS contaos, " + ;
2494:                        "RTRIM(c.grupods) AS grupods, RTRIM(c.contads) AS contads " + ;
2495:                        "FROM SigMvCab c " + ;
2496:                        "WHERE EXISTS (" + ;
2497:                        " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2498:                        " AND (RTRIM(d.empdopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2499:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)" + ;
2500:                        " OR RTRIM(d.oridopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2501:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)))" + ;
2502:                        " ORDER BY c.emps, c.dopes"
2503: 
2504:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOperas")
2505: 
2506:             IF loc_nRet < 0
2507:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
2508:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2509:             ELSE
2510:                 loc_oGrid.ColumnCount = 3
2511:                 loc_oGrid.RecordSource = "cursor_4c_CabOperas"
2512:                 IF RECCOUNT("cursor_4c_CabOperas") > 0
2513:                     loc_oGrid.Column1.txt_4c_Col01.ControlSource = "cursor_4c_CabOperas.emps"
2514:                     loc_oGrid.Column2.txt_4c_Col02.ControlSource = "cursor_4c_CabOperas.opers"
2515:                     loc_oGrid.Column3.txt_4c_Col03.ControlSource = "cursor_4c_CabOperas.dopes"
2516:                     loc_oGrid.Column4.txt_4c_Col04.ControlSource = "cursor_4c_CabOperas.empds"
2517:                     loc_oGrid.Column5.txt_4c_Col05.ControlSource = "cursor_4c_CabOperas.grupoos"
2518:                     loc_oGrid.Column6.txt_4c_Col06.ControlSource = "cursor_4c_CabOperas.contaos"
2519:                     loc_oGrid.Column7.txt_4c_Col07.ControlSource = "cursor_4c_CabOperas.grupods"
2520:                     loc_oGrid.Column8.txt_4c_Col08.ControlSource = "cursor_4c_CabOperas.contads"
2521:                 ENDIF
2522:                 loc_oGrid.Refresh()
2523:             ENDIF
2524: 
2525:         CATCH TO loc_oErro
2526:             MsgErro("Erro em CarregarCabOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2527:         ENDTRY
2528:     ENDPROC
2529: 
2530:     *==========================================================================
2531:     * CarregarItnOperas - Carrega grd_4c_ItnOperas com itens de movimentos do lote
2532:     *==========================================================================
2533:     PROTECTED PROCEDURE CarregarItnOperas()
2534:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2535:         loc_oErro = .NULL.
2536: 
2537:         TRY
2538:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2539:             loc_oGrid   = loc_oPage.grd_4c_ItnOperas
2540:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2541: 
2542:             IF USED("cursor_4c_ItnOperas")
2543:                 USE IN cursor_4c_ItnOperas
2544:             ENDIF
2545: 
2546:             loc_cSQL = "SELECT h.seqs AS item, RTRIM(h.cpros) AS cpros, " + ;
2547:                        "RTRIM(ISNULL(p.dpros,'')) AS dpros, " + ;
2548:                        "RTRIM(h.unitmeds) AS unitmeds, h.qtds, h.units, h.totas, " + ;
2549:                        "RTRIM(h.codcors) AS codcors, RTRIM(h.codtams) AS codtams " + ;
2550:                        "FROM SigMvHst h " + ;
2551:                        "LEFT JOIN SigCdPro p ON RTRIM(p.cpros) = RTRIM(h.cpros) " + ;
2552:                        "WHERE EXISTS (" + ;
2553:                        " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2554:                        " AND (RTRIM(d.empdopnums) = RTRIM(h.emps) + RTRIM(h.dopes)" + ;
2555:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(h.numes,6)),6)" + ;
2556:                        " OR RTRIM(d.oridopnums) = RTRIM(h.emps) + RTRIM(h.dopes)" + ;
2557:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(h.numes,6)),6)))" + ;
2558:                        " ORDER BY h.seqs"
2559: 
2560:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOperas")
2561: 
2562:             IF loc_nRet < 0
2563:                 MsgErro("Erro ao carregar itens de opera" + CHR(231) + CHR(245) + "es:" + ;
2564:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2565:             ELSE
2566:                 loc_oGrid.ColumnCount = 3
2567:                 loc_oGrid.RecordSource = "cursor_4c_ItnOperas"
2568:                 IF RECCOUNT("cursor_4c_ItnOperas") > 0
2569:                     loc_oGrid.Column1.txt_4c_Itn01.ControlSource = "cursor_4c_ItnOperas.item"
2570:                     loc_oGrid.Column2.txt_4c_Itn02.ControlSource = "cursor_4c_ItnOperas.cpros"
2571:                     loc_oGrid.Column3.txt_4c_Itn03.ControlSource = "cursor_4c_ItnOperas.dpros"
2572:                     loc_oGrid.Column4.txt_4c_Itn04.ControlSource = "cursor_4c_ItnOperas.unitmeds"
2573:                     loc_oGrid.Column5.txt_4c_Itn05.ControlSource = "cursor_4c_ItnOperas.qtds"
2574:                     loc_oGrid.Column6.txt_4c_Itn06.ControlSource = "cursor_4c_ItnOperas.units"
2575:                     loc_oGrid.Column7.txt_4c_Itn07.ControlSource = "cursor_4c_ItnOperas.totas"
2576:                     loc_oGrid.Column8.txt_4c_Itn08.ControlSource = "cursor_4c_ItnOperas.codcors"
2577:                     loc_oGrid.Column9.txt_4c_Itn09.ControlSource = "cursor_4c_ItnOperas.codtams"
2578:                 ENDIF
2579:                 loc_oGrid.Refresh()
2580:             ENDIF
2581: 
2582:         CATCH TO loc_oErro
2583:             MsgErro("Erro em CarregarItnOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2584:         ENDTRY
2585:     ENDPROC
2586: 
2587:     *==========================================================================
2588:     * Destroy - Libera recursos ao fechar
2589:     *==========================================================================
2590:     PROCEDURE Destroy()
2591:         IF USED("cursor_4c_Lista")
2592:             USE IN cursor_4c_Lista
2593:         ENDIF
2594:         IF USED("cursor_4c_Estoque")
2595:             USE IN cursor_4c_Estoque
2596:         ENDIF
2597:         IF USED("cursor_4c_Disponivel")
2598:             USE IN cursor_4c_Disponivel
2599:         ENDIF
2600:         IF USED("cursor_4c_Distribui")
2601:             USE IN cursor_4c_Distribui
2602:         ENDIF
2603:         IF USED("cursor_4c_InfoPro")
2604:             USE IN cursor_4c_InfoPro
2605:         ENDIF
2606:         IF USED("cursor_4c_CabOperas")
2607:             USE IN cursor_4c_CabOperas
2608:         ENDIF
2609:         IF USED("cursor_4c_ItnOperas")
2610:             USE IN cursor_4c_ItnOperas
2611:         ENDIF
2612:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2613:             THIS.this_oBusinessObject = .NULL.
2614:         ENDIF
2615:         DODEFAULT()
2616:     ENDPROC
2617: 
2618:     *==========================================================================
2619:     * FormParaBO - Transfere periodo de filtro do form para o BO
2620:     *==========================================================================
2621:     PROCEDURE FormParaBO()
2622:         LOCAL loc_oPage1, loc_oErro
2623:         TRY
2624:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
2625:             IF VARTYPE(loc_oPage1) = "O"


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
    *              Campos: nMarca (N), Cemps (C3), CGrus (C10), CCons (C10)
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
                        loc_cIN = loc_cIN + "'" + ALLTRIM(Cemps) + "|" + ;
                                  ALLTRIM(CGrus) + "|" + ALLTRIM(CCons) + "'"
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
                               "WHERE m.tipoestos = 3 " + ;
                               "AND (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
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
                                   "WHERE m.tipoestos = 3 " + ;
                                   "AND (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
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

