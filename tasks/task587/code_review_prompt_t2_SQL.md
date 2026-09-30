# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCONTA, SITUAS, IFORS, FORALINHA, MARGEMS, ENCARGOS, CFTIOCS, 1, CGRUS, CPROS, CIDCHAVES, MATPRINCS, CODS, ACRESCS, VALORS, LNTPRECAL, ORDEM, ARREDCS, TPCALCPS, INATIVAS, PVARIAS, LMARCA, NFAIXAFINS, TIPOS

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
lcQuery = [Select * From SigCdPro ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigCdPro') < 1)
Select CrSigCdPro
lcQuery = [Select * From SigPrCpo Where 1=0 ]
If (Thisform.poDataMgr.SqlExecute(lcQuery, [TmpPrCpo]) < 1)
Select TmpPrCpo
lcQuery = [Select * From SigPrFti ]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFti') < 1)
Select CrSigPrFti
lcQuery = [Select a.*, b.Dgrus From SigPrFto a, SigCdGrp b Where ]+;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFtiG') < 1)
Select CrSigPrFtiG
lcQuery = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where ]+;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrSigPrFtiP') < 1)
Select CrSigPrFtiP
Select CrSigPrCpo
	Select CrSigCdPro
		loBarra.Update(.T.)
		lcQuery = [Select * From SigPrCpo Where CPros = '] + pPro + [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [TmpCompo]) < 1)
		Select TmpCompo
				lcQuery = [Select a.PesoMs, b.CfgGerGprs ] + ;
					[From SigCdPro a, SigCdGrp b ] + ;
				If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalProCp]) < 1)
							lcQuery = [Update SigPrCpo Set Qtds = ] + Str(lnVal, 9, 3) + [ ] + ;
							If (Thisform.poDataMgr.SqlExecute(lcQuery, []) < 1)
							lcQuery = [Update SigPrCpo Set Pesos = ] + Str(lnVal, 9, 3) + [ ] + ;
							If (Thisform.poDataMgr.SqlExecute(lcQuery, []) < 1)
			Insert Into crProdutos (Cpros, DPros) Values (CrSigCdPro.Cpros, CrSigCdPro.DPros)
	Select CrSigCdPro
		lcSql = [Select * From SigPrCpo Where Cpros = ']+pPro+[']
		If Thisform.poDataMgr.SqlExecute(lcSql,'CrSigPrCpo') < 1
		Select CrSigPrCpo
		Insert Into crProdutos (Cpros, DPros, ValAnt, CustoAfs ) ;
		Select CrSigCdPro
		=Seek(CrSigCdPro.Moecs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moepcs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moedas, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Cgrus,'CrSigCdGrp','Cgrus')
		Select TotGrupo
		Select CrSigPrCpo
		=Seek(pPro)
			lcQuery = [Select Distinct Matprincs From SigCdPro Where MatPrincs <> Space(14) and MatPrincs = ']+CrSigPrCpo.Mats+[' ]
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crMatPrinc') < 1)
			Select crMatPrinc
				lcSql = [Select Custofs, MoeCusfs, Cunis, Cgrus, Moevs, cUniPs, pVens From SigCdPro ]+;
				If Thisform.poDataMgr.SqlExecute(lcSql,'CrCompoPro') < 1
				=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
				Select TotGrupo
					Insert Into TotGrupo (Grupo, Cpros, Moeda) Values (CrSigPrCpo.Cgrus, CrSigPrCpo.Mats, CrSigPrCpo.Moeds)
				=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
				=Seek(crCompoPro.Moevs, 'crSigCdMoe', 'CMoes' )
					=Seek(CrSigPrCpo.UniCompos,'CrSigCdUni','Cunis')
					=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
						=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
						=Seek(crCompoPro.Moevs, 'crSigCdMoe', 'CMoes' )
				=Seek(CrSigPrCpo.Moeds, 'crSigCdMoe', 'CMoes' )
				=Seek(CrSigPrCpo.Cgrus,'CrSigCdGrp','Cgrus')
					=Seek(Iif(CrSigCdGrp.BPesos=1,crCompoPro.Cunis,crCompoPro.CUniPs),'CrSigCdUni','Cunis')
					Select CrSigPrCpo
		Select CrSigCdPro
		Select CrSigPrCpo
			Select TmpPrCpo
			Select CrSigPrCpo
		Select Cgrus As Grupo, Mats As Cpros, dCompos As Dgrus, Moeds As Moeda, Pesos, Qtds, PCompos, 00000000.000 As ValGrupo, OrdTs ;
			From CrSigPrCpo ;
		Update LocalTGrupo Set ValGrupo = Iif(CrSigCdGrp.chkInstalas=2, Pesos, Qtds) * PCompos
			lcSql = [Select * From SigPrFti Where Cods = ']+MarkCus+[']
			Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtio')
			Select TmpFtio
				lcSql = [Select a.*, IsNull(b.Dgrus,'') as Dgrus From SigPrFto a Left Join SigCdGrp b on a.Cgrus = b.Cgrus Where a.Cods = ']+MarkCus+[' ]+;
				Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtioC')
					Select LocalTGrupo
						Select TmpFtioC
				lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkCus+[' And ]+;
				Thisform.poDataMgr.SqlExecute(lcSql,'TmpFtioC')
				Select TmpFtioC
		=Seek(MarkVen,'CrSigPrFti','Cods')
				Select CrSigPrFtiG
				Select TotGrupo
					Select CrSigPrFtiG
				Select CrSigPrFtiP
				Select CrSigPrFtiP
		=Seek(CrSigCdPro.Cgrus,'CrSigCdGrp','Cgrus')
		=Seek(CrSigCdPro.Moecs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moepcs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moevs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.MoeCusfs, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.Moedas, 'crSigCdMoe', 'CMoes' )
		=Seek(CrSigCdPro.mFtios, 'crSigCdMoe', 'CMoes' )
		=Seek(cFtioV,'CrSigPrFti','Cods')
		Select CrSigCdPro
			Select CrSigCdPro
		Select crProdutos
		loBarra.Update(.T.)
lnOldSel = Select()
Select CrProdutos
lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdCcp') < 1)
Select crSigCdCcp
	Select CrProdutos
	Select crSigCdCcp
		Select CrProdutos
			Delete For PVarias < lnVaria
			Delete For PVarias > lnVaria
	Select crSigCdCcp
Select(lnOldSel)
	Select * From CrProdutos Where lMarca = 1 Order By CPros Into Cursor CsProdutos ReadWrite
	Select CsProdutos
	Select CsProdutos
		loBarra.Update(.T.,'Produto: ' + CsProdutos.CPros)
		If Seek(CsProdutos.CPros,'CrSigCdPro','CPros')
			Select CrSigCdPro
			Insert Into GrSigCdPro From Memvar
			lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpPro2') < 1
			Select TmpPro2
			Insert Into CrSigCdPrc From MemVar
			If ThisForm.poDataMgr.SqlExecute([Select * From SigPrCpo Where CPros = ']+m.CPros+[' ],'TmpCompo') < 1
			Select TmpCompo
				Insert Into CrSigPrCp2 From MemVar
			If ThisForm.poDataMgr.SqlExecute([Delete From SigPrPrt Where CPros = '] + m.CPros + [' ], []) < 1
			Select TmpPrCpo
			=Seek(m.cpros)
				Insert Into GrSigPrCpo From Memvar
		Select CsProdutos
		Select grSigCdPro
			lcQrySGru  = [Select * From SigCdPsg Where CGrus = ']+grSigCdPro.cGrus+[' Order By nFaixaFins]
			If (ThisForm.poDatamgr.SqlExecute(lcQrySGru,'csSigCdPsg') < 1)
			Select csSigCdPsg
					Select grSigCdPro
					Select grSigCdPro
	loBarraFim.Update(.T.,'SigCdPro (1/4)...')
	llOk = ThisForm.poDataMgr.Update('grSigCdPro')
		loBarraFim.Update(.T.,'SigCdPrc (2/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigCdPrc')
		loBarraFim.Update(.T.,'SigPrCp2 (3/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigPrCp2')
		loBarraFim.Update(.T.,'SigPrCpo (4/4)...')
		llOk = ThisForm.poDataMgr.Update('grSigPrCpo')
		lcSql = [Select * From SigCdMoe ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdMoe')
		lcSql = [Select * From SigCdCot ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdCot')
		lcSql = [Select * From SigCdGrp ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdGrp')
		lcSql = [Select * From SigCdUni ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdUni')
		Select CrSigCdGrp
		Select CrSigCdUni
		Select CrSigCdCot
		Select CrSigCdMoe
		Select CrProdutos
			.Column1.ControlSource = 'CrProdutos.lMarca'
			.Column2.ControlSource = 'CrProdutos.CPros'
			.Column3.ControlSource = 'CrProdutos.DPros'
			.Column4.ControlSource = 'CrProdutos.ValAnt'
			.Column5.ControlSource = 'CrProdutos.ValAtu'
			.Column6.ControlSource = 'CrProdutos.pVarias'
			.Column7.ControlSource = 'CrProdutos.CustoAfs'
			.Column8.ControlSource = 'CrProdutos.CustoFs'
			.Column9.ControlSource = 'CrProdutos.cVarias'
Select CrProdutos
lcSql = [Select FigJpgs From SigCdPro Where Cpros = ']+lcCodPro+[']
If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpPro') < 1
Select TmpPro
	Select CrProdutos
		Select CrProdutos
			Delete For PVarias < lnVaria
			Delete For PVarias > lnVaria
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti ]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')
Select crprodutos
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
		Delete File (lcArquivo)
Update CrProdutos Set lMarca = 1
Update CrProdutos Set lMarca = 0
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti ] + lcFiltro
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS SQL (3516 linhas total):

*-- Linhas 102 a 125:
102: 			*--             de Processar/Atualizar abre o dialogo modal "Zap ...
103: 			*--             Are you sure?" e CONGELA a tela (o SET SAFETY OFF do
104: 			*--             main.prg roda na sessao 1 e nao alcanca esta).
105: 			*--   DELETED - com DELETED OFF (default), o "Delete For PVarias ..."
106: 			*--             do filtro de Variacao marca a linha mas ela CONTINUA
107: 			*--             aparecendo na grade (o SET DELETED ON do config.prg
108: 			*--             tambem so vale na sessao 1).
109: 			SET SAFETY OFF
110: 			SET DELETED ON
111: 
112: 			THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
113: 
114: 			IF VARTYPE(THIS.this_oBusinessObject) != "O"
115: 				MsgErro("Falha ao criar sigprccpBO", "Erro")
116: 			ELSE
117: 				THIS.this_oBusinessObject.this_lAutomatico = THIS.this_lAutomatico
118: 
119: 				THIS.ConfigurarPageFrame()
120: 				THIS.ConfigurarCabecalho()
121: 
122: 				THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_cTituloForm
123: 				THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_cTituloForm
124: 
125: 				*-- Campos de filtro (area "Filtros" do legado, acima da grade) -

*-- Linhas 599 a 617:
599: 		ENDWITH
600: 
601: 		*-- Markup (GetMrki/GetMrkf) - SigCdPro.margems numeric(9,6),
602: 		*-- BO formata/compara com 2 casas (FormatarNumeroSQL(...,2))
603: 		THIS.AddObject("lbl_4c_Markup", "Label")
604: 		WITH THIS.lbl_4c_Markup
605: 			.Top       = 142
606: 			.Left      = 493
607: 			.Width     = 44
608: 			.Height    = 15
609: 			.AutoSize  = .F.
610: 			.BackStyle = 0
611: 			.FontName  = loc_cFonte
612: 			.FontSize  = 8
613: 			.ForeColor = RGB(90, 90, 90)
614: 			.Caption   = "Markup :"
615: 		ENDWITH
616: 
617: 		THIS.AddObject("txt_4c_MarkupI", "TextBox")

*-- Linhas 706 a 724:
706: 		ENDWITH
707: 
708: 		*-- Encargo (Get_EncI/Get_Encf) - SigCdPro.encargos numeric(7,4),
709: 		*-- BO formata/compara com 2 casas (FormatarNumeroSQL(...,2))
710: 		THIS.AddObject("lbl_4c_Encargo", "Label")
711: 		WITH THIS.lbl_4c_Encargo
712: 			.Top       = 167
713: 			.Left      = 486
714: 			.Width     = 51
715: 			.Height    = 15
716: 			.AutoSize  = .F.
717: 			.BackStyle = 0
718: 			.FontName  = loc_cFonte
719: 			.FontSize  = 8
720: 			.ForeColor = RGB(90, 90, 90)
721: 			.Caption   = "Encargo :"
722: 		ENDWITH
723: 
724: 		THIS.AddObject("txt_4c_EncargoI", "TextBox")

*-- Linhas 1436 a 1456:
1436: 			USE IN (loc_cCursor)
1437: 		ENDIF
1438: 
1439: 		loc_cSQL = "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
1440: 			" WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cValor)
1441: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1442: 
1443: 		IF loc_nResultado > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1444: 			par_oTxt.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoCod))
1445: 			USE IN (loc_cCursor)
1446: 		ELSE
1447: 			IF USED(loc_cCursor)
1448: 				USE IN (loc_cCursor)
1449: 			ENDIF
1450: 			THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, loc_cValor, par_oTxt)
1451: 		ENDIF
1452: 
1453: 		par_oTxt.Refresh()
1454: 	ENDPROC
1455: 
1456: 	*====================================================================

*-- Linhas 1470 a 1494:
1470: 			USE IN (loc_cCursor)
1471: 		ENDIF
1472: 
1473: 		loc_cWhere = "Cods = " + EscaparSQL(loc_cValor)
1474: 		IF VARTYPE(par_cFiltroExtra) = "C" AND !EMPTY(par_cFiltroExtra)
1475: 			loc_cWhere = loc_cWhere + " AND " + par_cFiltroExtra
1476: 		ENDIF
1477: 
1478: 		loc_cSQL = "SELECT Cods FROM SigPrFti WHERE " + loc_cWhere
1479: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1480: 
1481: 		IF loc_nResultado > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1482: 			par_oTxt.Value = ALLTRIM(EVALUATE(loc_cCursor + ".Cods"))
1483: 			USE IN (loc_cCursor)
1484: 		ELSE
1485: 			IF USED(loc_cCursor)
1486: 				USE IN (loc_cCursor)
1487: 			ENDIF
1488: 			THIS.AbrirLookupCanonico("SigPrFti", "Cods", "Descs", par_cTitulo, loc_cValor, par_oTxt, .NULL., par_cFiltroExtra)
1489: 		ENDIF
1490: 
1491: 		par_oTxt.Refresh()
1492: 	ENDPROC
1493: 
1494: 	*====================================================================

*-- Linhas 1588 a 1607:
1588: 			USE IN cursor_4c_LkpFornecedor
1589: 		ENDIF
1590: 
1591: 		loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
1592: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpFornecedor")
1593: 
1594: 		IF loc_nResultado > 0 AND USED("cursor_4c_LkpFornecedor") AND ;
1595: 				RECCOUNT("cursor_4c_LkpFornecedor") > 0
1596: 			THIS.txt_4c_Fornecedor.Value     = ALLTRIM(cursor_4c_LkpFornecedor.Iclis)
1597: 			THIS.txt_4c_DescFornecedor.Value = ALLTRIM(cursor_4c_LkpFornecedor.Rclis)
1598: 			USE IN cursor_4c_LkpFornecedor
1599: 		ELSE
1600: 			IF USED("cursor_4c_LkpFornecedor")
1601: 				USE IN cursor_4c_LkpFornecedor
1602: 			ENDIF
1603: 			THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
1604: 				"Sele" + CHR(231) + CHR(227) + "o de Fornecedor", loc_cValor, ;
1605: 				THIS.txt_4c_Fornecedor, THIS.txt_4c_DescFornecedor)
1606: 		ENDIF
1607: 

*-- Linhas 1815 a 1855:
1815: 	* ConfigurarGridProdutos - Grade de recalculo (Grd_Produto no legado):
1816: 	* 9 colunas (Column1 = checkbox de selecao/lMarca, Column2..Column9
1817: 	* somente leitura), cria o cursor local que a alimenta e liga o
1818: 	* RecordSource - transcricao literal do "Create Cursor CrProdutos(...)"
1819: 	* + WITH ThisForm.Grd_Produto do Init legado. Dimensoes/mascaras/
1820: 	* captions EXATAS do SCX (form flat 1000x600, sem PageFrame - nao ha
1821: 	* compensacao de offset a aplicar).
1822: 	*
1823: 	* cursor_4c_Produtos carrega 5 colunas ALEM das 9 da grade (pvideals/
1824: 	* fcustos/fvendas/moecs/moevs): sao os demais campos que
1825: 	* this_oBusinessObject.Atualizar() grava em SigCdPro. Sem guarda-las
1826: 	* aqui, BtnAtualizarClick teria de gravar esses campos com o default
1827: 	* (0/vazio) e apagaria dado que nao veio para a tela.
1828: 	*====================================================================
1829: 	PROTECTED PROCEDURE ConfigurarGridProdutos()
1830: 		THIS.AddObject("grd_4c_Produtos", "Grid")
1831: 		WITH THIS.grd_4c_Produtos
1832: 			.Top         = 351
1833: 			.Left        = 12
1834: 			.Width       = 935
1835: 			.Height      = 244
1836: 			.FontName    = "Tahoma"
1837: 			.FontSize    = 8
1838: 			.RowHeight   = 16
1839: 			.ScrollBars  = 2
1840: 			.DeleteMark  = .F.
1841: 			.RecordMark  = .F.
1842: 			.ColumnCount = 9
1843: 
1844: 			.Column1.FontName        = "Tahoma"
1845: 			.Column1.FontSize        = 8
1846: 			.Column1.Alignment       = 3
1847: 			.Column1.Width           = 17
1848: 			.Column1.Movable         = .F.
1849: 			.Column1.Resizable       = .F.
1850: 			.Column1.Sparse          = .F.
1851: 			.Column1.Header1.Caption = ""
1852: 
1853: 			*-- Coluna checkbox (Check1 no legado) - regra #18: precisa de
1854: 			*-- AddObject + CurrentControl para o controle realmente aparecer
1855: 			.Column1.AddObject("chk_4c_Marca", "CheckBox")

*-- Linhas 1966 a 2018:
1966: 			.Column9.Text1.BackColor   = RGB(255, 255, 255)
1967: 		ENDWITH
1968: 
1969: 		*-- Cursor local da grade (Create Cursor CrProdutos(...) do legado)
1970: 		IF USED("cursor_4c_Produtos")
1971: 			USE IN cursor_4c_Produtos
1972: 		ENDIF
1973: 
1974: 		*-- Os 9 primeiros campos sao os do "Create Cursor CrProdutos" legado, na
1975: 		*-- MESMA ordem (as 9 colunas da grade). Os seguintes nao existem no
1976: 		*-- legado porque la o registro recalculado ficava em CrSigCdPro: aqui
1977: 		*-- viajam junto com a linha para que AtualizarPrecos() grave sem
1978: 		*-- reconsultar SigCdPro (cgrus eh usado na reclassificacao de subgrupo
1979: 		*-- por faixa, e nao aparece na grade).
1980: 		SET NULL ON
1981: 		CREATE CURSOR cursor_4c_Produtos (lMarca N(1), cpros C(14), dpros C(40), ;
1982: 			valant N(14,2), valatu N(14,2), custoafs N(12,4), custofs N(12,4), ;
1983: 			pvarias N(8,2), cvarias N(8,2), pvideals N(14,5), fcustos N(11,5), ;
1984: 			fvendas N(7,3), moecs C(3), moevs C(3), cgrus C(3))
1985: 		SET NULL OFF
1986: 		INDEX ON cpros TAG cpros
1987: 		SELECT cursor_4c_Produtos
1988: 		SET ORDER TO
1989: 		GO TOP
1990: 
1991: 		THIS.grd_4c_Produtos.ColumnCount = 9
1992: 		THIS.grd_4c_Produtos.RecordSource          = "cursor_4c_Produtos"
1993: 		THIS.grd_4c_Produtos.Column1.ControlSource  = "cursor_4c_Produtos.lMarca"
1994: 		THIS.grd_4c_Produtos.Column2.ControlSource  = "cursor_4c_Produtos.cpros"
1995: 		THIS.grd_4c_Produtos.Column3.ControlSource  = "cursor_4c_Produtos.dpros"
1996: 		THIS.grd_4c_Produtos.Column4.ControlSource  = "cursor_4c_Produtos.valant"
1997: 		THIS.grd_4c_Produtos.Column5.ControlSource  = "cursor_4c_Produtos.valatu"
1998: 		THIS.grd_4c_Produtos.Column6.ControlSource  = "cursor_4c_Produtos.pvarias"
1999: 		THIS.grd_4c_Produtos.Column7.ControlSource  = "cursor_4c_Produtos.custoafs"
2000: 		THIS.grd_4c_Produtos.Column8.ControlSource  = "cursor_4c_Produtos.custofs"
2001: 		THIS.grd_4c_Produtos.Column9.ControlSource  = "cursor_4c_Produtos.cvarias"
2002: 
2003: 		*-- RecordSource/ControlSource resetam Width e Header1.Caption -
2004: 		*-- reconfigurar SEMPRE depois de vincular (CLAUDE.md Problema 48)
2005: 		THIS.grd_4c_Produtos.Column1.Width           = 17
2006: 		THIS.grd_4c_Produtos.Column2.Width           = 108
2007: 		THIS.grd_4c_Produtos.Column2.Header1.Caption = "Produto"
2008: 		THIS.grd_4c_Produtos.Column3.Width           = 290
2009: 		THIS.grd_4c_Produtos.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2010: 		THIS.grd_4c_Produtos.Column4.Width           = 80
2011: 		THIS.grd_4c_Produtos.Column4.Header1.Caption = "Venda Ant."
2012: 		THIS.grd_4c_Produtos.Column5.Width           = 80
2013: 		THIS.grd_4c_Produtos.Column5.Header1.Caption = "Venda Atual"
2014: 		THIS.grd_4c_Produtos.Column6.Width           = 80
2015: 		THIS.grd_4c_Produtos.Column6.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o (%)"
2016: 		THIS.grd_4c_Produtos.Column7.Width           = 80
2017: 		THIS.grd_4c_Produtos.Column7.Header1.Caption = "Custo Ant."
2018: 		THIS.grd_4c_Produtos.Column8.Width           = 80

*-- Linhas 2098 a 2126:
2098: 				IF USED("cursor_4c_TmpFoto")
2099: 					USE IN cursor_4c_TmpFoto
2100: 				ENDIF
2101: 				loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCpros)
2102: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFoto")
2103: 
2104: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFoto") OR ;
2105: 						RECCOUNT("cursor_4c_TmpFoto") = 0
2106: 					loc_lProsseguir = .F.
2107: 				ENDIF
2108: 			ENDIF
2109: 
2110: 			IF loc_lProsseguir
2111: 				SELECT cursor_4c_TmpFoto
2112: 				GO TOP
2113: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFoto.FigJpgs, "")
2114: 				USE IN cursor_4c_TmpFoto
2115: 
2116: 				IF !EMPTY(loc_cFigJpgs)
2117: 					loc_cArqTemp = SYS(2023) + "\TempCj.jpg"
2118: 					loc_cFoto = STRCONV( ;
2119: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
2120: 							"data:image/png;base64,", ""), ;
2121: 							"data:image/jpeg;base64,", ""), ;
2122: 							"data:image/jpg;base64,", ""), 14)
2123: 					STRTOFILE(loc_cFoto, loc_cArqTemp)
2124: 					IF FILE(loc_cArqTemp)
2125: 						THIS.img_4c_FigJpg.Picture = loc_cArqTemp
2126: 						THIS.img_4c_FigJpg.Visible = .T.

*-- Linhas 2173 a 2202:
2173: 				IF USED("cursor_4c_TmpFotoZom")
2174: 					USE IN cursor_4c_TmpFotoZom
2175: 				ENDIF
2176: 				loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
2177: 					EscaparSQL(loc_cCpros)
2178: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")
2179: 
2180: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR ;
2181: 						RECCOUNT("cursor_4c_TmpFotoZom") = 0
2182: 					loc_lProsseguir = .F.
2183: 				ENDIF
2184: 			ENDIF
2185: 
2186: 			IF loc_lProsseguir
2187: 				SELECT cursor_4c_TmpFotoZom
2188: 				GO TOP
2189: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
2190: 				USE IN cursor_4c_TmpFotoZom
2191: 
2192: 				IF !EMPTY(loc_cFigJpgs)
2193: 					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
2194: 					loc_cFoto = STRCONV( ;
2195: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
2196: 							"data:image/png;base64,", ""), ;
2197: 							"data:image/jpeg;base64,", ""), ;
2198: 							"data:image/jpg;base64,", ""), 14)
2199: 					STRTOFILE(loc_cFoto, loc_cArqTemp)
2200: 
2201: 					IF FILE(loc_cArqTemp)
2202: 						loc_cCaption = "Produto : " + loc_cCpros + " - " + loc_cDpros

*-- Linhas 2565 a 2584:
2565: 	* de "atualizar" (junto dos Zap dos demais cursores de trabalho) e em
2566: 	* cada volta do Scan de "processaautomatico".
2567: 	*
2568: 	* ZAP, nunca USE IN + CREATE CURSOR: recriar o cursor derrubaria
2569: 	* RecordSource/ControlSource do Grid (e com eles Column.Width,
2570: 	* Header1.Caption, Sparse e CurrentControl do CheckBox).
2571: 	*
2572: 	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
2573: 	* NAO pode alargar o escopo herdado.
2574: 	*====================================================================
2575: 	PROTECTED PROCEDURE LimparCampos()
2576: 		IF USED("cursor_4c_Produtos")
2577: 			ZAP IN cursor_4c_Produtos
2578: 		ENDIF
2579: 
2580: 		*-- "ThisForm.FigJpg.Visible = .F. / .Picture = ''" do legado: sem
2581: 		*-- linha na grade nao ha produto, logo nao ha foto a exibir.
2582: 		IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
2583: 			THIS.img_4c_FigJpg.Visible = .F.
2584: 			THIS.img_4c_FigJpg.Picture = ""

*-- Linhas 2735 a 2753:
2735: 	* correntes (this_oBusinessObject.BuscarProdutosFiltrados, que
2736: 	* transcreve a fase de consulta do metodo "processar" legado) e
2737: 	* transfere o resultado para o cursor da grade - espelha o
2738: 	* "Insert Into crProdutos (Cpros, DPros, ValAnt, CustoAfs) Values
2739: 	* (CrSigCdPro.Cpros, CrSigCdPro.DPros, CrSigCdPro.Pvens,
2740: 	* CrSigCdPro.CustoFs)" do Scan principal do legado.
2741: 	*
2742: 	* PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form
2743: 	* direto de fora da classe (CLAUDE.md regra #3).
2744: 	*====================================================================
2745: 	PROCEDURE CarregarLista()
2746: 		LOCAL loc_lSucesso
2747: 		loc_lSucesso = .F.
2748: 
2749: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2750: 			RETURN loc_lSucesso
2751: 		ENDIF
2752: 
2753: 		THIS.FormParaBO()

*-- Linhas 2769 a 2812:
2769: 			ENDIF
2770: 
2771: 			IF USED("cursor_4c_ProdutosSQL")
2772: 				SELECT cursor_4c_ProdutosSQL
2773: 				SCAN
2774: 					INSERT INTO cursor_4c_Produtos ;
2775: 						(lMarca, cpros, dpros, valant, valatu, custoafs, custofs, ;
2776: 						 pvarias, cvarias, pvideals, fcustos, fvendas, moecs, moevs, cgrus) ;
2777: 					VALUES ;
2778: 						(0, ;
2779: 						 cursor_4c_ProdutosSQL.cpros, ;
2780: 						 cursor_4c_ProdutosSQL.dpros, ;
2781: 						 TratarNulo(cursor_4c_ProdutosSQL.pvens, 0), ;
2782: 						 TratarNulo(cursor_4c_ProdutosSQL.pvens, 0), ;
2783: 						 TratarNulo(cursor_4c_ProdutosSQL.custofs, 0), ;
2784: 						 TratarNulo(cursor_4c_ProdutosSQL.custofs, 0), ;
2785: 						 0, ;
2786: 						 0, ;
2787: 						 TratarNulo(cursor_4c_ProdutosSQL.pvideals, 0), ;
2788: 						 TratarNulo(cursor_4c_ProdutosSQL.fcustos, 0), ;
2789: 						 TratarNulo(cursor_4c_ProdutosSQL.fvendas, 0), ;
2790: 						 TratarNulo(cursor_4c_ProdutosSQL.moecs, ""), ;
2791: 						 TratarNulo(cursor_4c_ProdutosSQL.moevs, ""), ;
2792: 						 TratarNulo(cursor_4c_ProdutosSQL.cgrus, ""))
2793: 				ENDSCAN
2794: 				USE IN cursor_4c_ProdutosSQL
2795: 			ENDIF
2796: 
2797: 			SELECT cursor_4c_Produtos
2798: 			SET ORDER TO cpros
2799: 			GO TOP
2800: 
2801: 			THIS.grd_4c_Produtos.Refresh()
2802: 			loc_lSucesso = .T.
2803: 		ENDIF
2804: 
2805: 		RETURN loc_lSucesso
2806: 	ENDPROC
2807: 
2808: 	*====================================================================
2809: 	* BtnProcessarClick - Espelha Sair.Processa.Click do legado: confirma
2810: 	* reprocessamento se ja existem dados na grade, zera o cursor e chama
2811: 	* CarregarLista(). Ao terminar com sucesso, habilita Atualizar e
2812: 	* Imprimir (This.Parent.Atualiza.Enabled = .T. / ThisForm.Impress?o.

*-- Linhas 2823 a 2909:
2823: 		ENDIF
2824: 
2825: 		IF USED("cursor_4c_Produtos")
2826: 			SELECT cursor_4c_Produtos
2827: 			IF RECCOUNT() > 0
2828: 				IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?", ;
2829: 						"Aten" + CHR(231) + CHR(227) + "o")
2830: 					RETURN
2831: 				ENDIF
2832: 			ENDIF
2833: 		ENDIF
2834: 
2835: 		*-- "Zap In CrProdutos" do legado: descarta o resultado anterior antes
2836: 		*-- de reprocessar (e com ele a foto e o estado dos botoes de acao).
2837: 		THIS.LimparCampos()
2838: 
2839: 		IF THIS.CarregarLista()
2840: 			*-- Filtro de Variacao (%) aplicado DEPOIS do processamento, sobre
2841: 			*-- as linhas ja calculadas - transcricao literal do legado:
2842: 			*--   lnVaria = Thisform.Get_Variacao.Value
2843: 			*--   If lnVaria > 0 -> Delete For PVarias < lnVaria
2844: 			*--   If lnVaria < 0 -> Delete For PVarias > lnVaria
2845: 			*-- O SINAL eh regra: variacao negativa mantem as QUEDAS de preco
2846: 			*-- (descarta o que subiu mais que o limite) e vice-versa.
2847: 			THIS.AplicarFiltroVariacao()
2848: 
2849: 			SELECT cursor_4c_Produtos
2850: 			SET ORDER TO cpros
2851: 			GO TOP
2852: 
2853: 			*-- "This.Parent.Atualiza.Enabled = .T. / Thisform.Impress?o.
2854: 			*-- Enabled = .T." do legado, pelo FUNIL - que tambem recusa
2855: 			*-- habilitar quando o filtro de Variacao apagou TODAS as linhas
2856: 			*-- (grade vazia nao tem o que gravar nem o que imprimir).
2857: 			THIS.this_cModoAtual = "PROCESSADO"
2858: 			THIS.AjustarBotoesPorModo()
2859: 
2860: 			THIS.grd_4c_Produtos.Column1.SetFocus()
2861: 			THIS.grd_4c_Produtos.Refresh()
2862: 		ENDIF
2863: 	ENDPROC
2864: 
2865: 	*====================================================================
2866: 	* AplicarFiltroVariacao - Descarta da grade as linhas cuja variacao de
2867: 	* preco nao alcanca o limite informado em Variacao (%). Transcricao do
2868: 	* bloco que o legado repete IDENTICO em Processa.Click e em
2869: 	* ProcessaAutomatico:
2870: 	*     lnVaria = Thisform.Get_Variacao.Value
2871: 	*     If lnVaria > 0 / Delete For PVarias < lnVaria / Endif
2872: 	*     If lnVaria < 0 / Delete For PVarias > lnVaria / Endif
2873: 	*
2874: 	* Variacao ZERO nao filtra nada (o legado nao tem ramo para ela).
2875: 	* O DELETE so faz a linha desaparecer com SET DELETED ON, reposto em
2876: 	* InicializarForm porque DataSession = 2 nasce com DELETED OFF.
2877: 	*
2878: 	* PUBLIC - chamado tambem por ProcessaAutomatico.
2879: 	*====================================================================
2880: 	PROCEDURE AplicarFiltroVariacao()
2881: 		LOCAL loc_nVariacao
2882: 
2883: 		IF !USED("cursor_4c_Produtos")
2884: 			RETURN
2885: 		ENDIF
2886: 
2887: 		loc_nVariacao = THIS.txt_4c_Variacao.Value
2888: 
2889: 		SELECT cursor_4c_Produtos
2890: 		IF loc_nVariacao > 0
2891: 			DELETE FOR cursor_4c_Produtos.pvarias < loc_nVariacao
2892: 		ENDIF
2893: 		IF loc_nVariacao < 0
2894: 			DELETE FOR cursor_4c_Produtos.pvarias > loc_nVariacao
2895: 		ENDIF
2896: 	ENDPROC
2897: 
2898: 	*====================================================================
2899: 	* BtnAtualizarClick - Espelha Sair.Atualiza.Click do legado, que eh
2900: 	* apenas o disparo do metodo de gravacao:
2901: 	*     If Not ThisForm.Atualizar()
2902: 	*         Return .F.
2903: 	*     EndIf
2904: 	* Toda a logica fica em AtualizarPrecos(), igual ao legado, porque o
2905: 	* modo Automatico tambem a chama direto (sem passar pelo botao).
2906: 	*
2907: 	* PUBLIC - alvo de BINDEVENT (CLAUDE.md regra #3).
2908: 	*====================================================================
2909: 	PROCEDURE BtnAtualizarClick()

*-- Linhas 2928 a 2946:
2928: 	*
2929: 	* A ORDEM de (a)/(b) antes de (d) eh regra, nao detalhe: o historico
2930: 	* guarda o valor ANTIGO. No legado isso acontece porque os cursores
2931: 	* remotos so sao descarregados no poDataMgr.Update() do fim; aqui, como
2932: 	* cada passo grava na hora, inverter (a) e (d) faria o historico
2933: 	* registrar o preco NOVO - errado e sem nenhum sintoma visivel.
2934: 	*
2935: 	* PUBLIC - alvo de BINDEVENT e chamado por ProcessaAutomatico.
2936: 	*====================================================================
2937: 	PROCEDURE AtualizarPrecos()
2938: 		LOCAL loc_lRetorno, loc_lConfirma, loc_nImpEtiq, loc_nMarcados
2939: 		LOCAL loc_oBarra, loc_oBarraFim, loc_nChkSub, loc_cSubGru, loc_nVenda
2940: 		LOCAL loc_lTudoOk, loc_nGravados, loc_cCpros, loc_lProsseguir, loc_oErro
2941: 		LOCAL loc_cAvisoRollback, loc_oErroRb
2942: 
2943: 		loc_lRetorno = .F.
2944: 
2945: 		IF !USED("cursor_4c_Produtos") OR VARTYPE(THIS.this_oBusinessObject) != "O"
2946: 			RETURN loc_lRetorno

*-- Linhas 2969 a 2989:
2969: 				"o das Etiquetas?", "Etiquetas"), 1, 0)
2970: 		ENDIF
2971: 
2972: 		*-- 3) Exige selecao - legado: "Select * From CrProdutos Where lMarca = 1
2973: 		*-- Order By CPros Into Cursor CsProdutos" + "If Eof()"
2974: 		SELECT cursor_4c_Produtos
2975: 		SET ORDER TO cpros
2976: 		COUNT FOR lMarca = 1 TO loc_nMarcados
2977: 
2978: 		IF loc_nMarcados = 0
2979: 			IF !THIS.this_lAutomatico
2980: 				MsgAviso("Nenhum Produto Selecionado !!!", ;
2981: 					"Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2982: 				THIS.grd_4c_Produtos.Column1.SetFocus()
2983: 			ENDIF
2984: 			RETURN loc_lRetorno
2985: 		ENDIF
2986: 
2987: 		*-- 4) Parametro que liga a reclassificacao de subgrupo por faixa
2988: 		*-- (legado: If crSigCdPac.nChkSubGrs = 1, no fim de "atualizar")
2989: 		loc_nChkSub = THIS.this_oBusinessObject.ObterChkSubGrupos()

*-- Linhas 3016 a 3047:
3016: 			IF loc_lProsseguir
3017: 				THIS.this_oBusinessObject.this_nImpEtiqs = loc_nImpEtiq
3018: 
3019: 				SELECT cursor_4c_Produtos
3020: 				SET ORDER TO cpros
3021: 				GO TOP
3022: 				SCAN FOR lMarca = 1
3023: 					loc_cCpros = ALLTRIM(cursor_4c_Produtos.cpros)
3024: 
3025: 					IF VARTYPE(loc_oBarra) = "O"
3026: 						loc_oBarra.Update("Produto: " + loc_cCpros)
3027: 					ENDIF
3028: 
3029: 					WITH THIS.this_oBusinessObject
3030: 						*-- (a) historico do preco ANTIGO + (b) da composicao
3031: 						*-- corrente + (c) expurgo dos precos de tabela: tudo
3032: 						*-- ANTES do UPDATE de SigCdPro
3033: 						IF !.GravarHistoricoPreco(loc_cCpros)
3034: 							loc_lTudoOk = .F.
3035: 						ENDIF
3036: 
3037: 						IF loc_lTudoOk AND !.GravarHistoricoComposicao(loc_cCpros)
3038: 							loc_lTudoOk = .F.
3039: 						ENDIF
3040: 
3041: 						IF loc_lTudoOk AND !.ExcluirPrecosTabela(loc_cCpros)
3042: 							loc_lTudoOk = .F.
3043: 						ENDIF
3044: 
3045: 						IF loc_lTudoOk
3046: 							*-- Reclassificacao de subgrupo por faixa de preco.
3047: 							*-- Legado: "If crSigCdPro.pVens = 0 -> lnPVens =

*-- Linhas 3083 a 3152:
3083: 						EXIT
3084: 					ENDIF
3085: 
3086: 					SELECT cursor_4c_Produtos
3087: 				ENDSCAN
3088: 			ENDIF
3089: 
3090: 			IF VARTYPE(loc_oBarra) = "O"
3091: 				loc_oBarra.Complete(.T.)
3092: 				loc_oBarra = .NULL.
3093: 			ENDIF
3094: 
3095: 			IF loc_lProsseguir
3096: 				*-- Barra "Atualizando Fisicamente os Arquivos..." (loBarraFim)
3097: 				loc_oBarraFim = THIS.CriarBarraProgresso("Atualizando Fisicamente " + ;
3098: 					"os Arquivos...", 2)
3099: 
3100: 				IF loc_lTudoOk
3101: 					IF VARTYPE(loc_oBarraFim) = "O"
3102: 						loc_oBarraFim.Update("Confirmando a grava" + CHR(231) + CHR(227) + "o...")
3103: 					ENDIF
3104: 
3105: 					loc_lTudoOk = THIS.this_oBusinessObject.ConfirmarTransacao()
3106: 
3107: 					IF !loc_lTudoOk AND !THIS.this_lAutomatico
3108: 						MsgAviso("Falha na Atualiza" + CHR(231) + CHR(227) + ;
3109: 							"o. Reinicie o Processo !!!", "Confirma" + CHR(231) + CHR(227) + "o")
3110: 					ENDIF
3111: 				ELSE
3112: 					IF VARTYPE(loc_oBarraFim) = "O"
3113: 						loc_oBarraFim.Update("Desfazendo a grava" + CHR(231) + CHR(227) + "o...")
3114: 					ENDIF
3115: 
3116: 					THIS.this_oBusinessObject.DesfazerTransacao()
3117: 
3118: 					IF !THIS.this_lAutomatico
3119: 						MsgAviso("Falha na Atualiza" + CHR(231) + CHR(227) + ;
3120: 							"o. Reinicie o Processo !!!", "Confirma" + CHR(231) + CHR(227) + "o")
3121: 					ENDIF
3122: 				ENDIF
3123: 
3124: 				IF VARTYPE(loc_oBarraFim) = "O"
3125: 					loc_oBarraFim.Complete(.T.)
3126: 					loc_oBarraFim = .NULL.
3127: 				ENDIF
3128: 
3129: 				IF loc_lTudoOk AND !THIS.this_lAutomatico
3130: 					MsgInfo("Processamento Finalizado com Sucesso !!!", "Confirmar")
3131: 				ENDIF
3132: 
3133: 				*-- 7) O legado zera TODOS os cursores de trabalho no fim, com
3134: 				*-- sucesso OU com falha (os Zap ficam fora do If llOk). Aqui so
3135: 				*-- existe o cursor local da grade, e quem o zera eh
3136: 				*-- LimparCampos - que faz o ZAP (nao USE IN + CREATE CURSOR,
3137: 				*-- que derrubaria RecordSource/ControlSource do Grid), esconde a
3138: 				*-- foto e devolve a tela ao modo "LISTA", desabilitando
3139: 				*-- Atualizar/Imprimir junto ("ThisForm.Sair.Atualiza.Enabled =
3140: 				*-- .F." do Init, repetido na ultima linha de "atualizar").
3141: 				THIS.LimparCampos()
3142: 
3143: 				loc_lRetorno = loc_lTudoOk
3144: 			ENDIF
3145: 		CATCH TO loc_oErro
3146: 			*-- Qualquer excecao no meio do lote desfaz TUDO: gravacao parcial de
3147: 			*-- preco eh pior que gravacao nenhuma. O rollback vai num TRY
3148: 			*-- proprio porque ele tambem pode falhar (conexao caida) e nesse
3149: 			*-- caso o que interessa reportar eh o erro ORIGINAL - mas a falha
3150: 			*-- do rollback entra na mensagem, senao ninguem fica sabendo que
3151: 			*-- a gravacao ficou incompleta.
3152: 			loc_cAvisoRollback = ""

*-- Linhas 3279 a 3326:
3279: 
3280: 				loc_lRetorno = .T.
3281: 
3282: 				SELECT cursor_4c_PresetsCcp
3283: 				GO TOP
3284: 				SCAN
3285: 					IF USED("cursor_4c_Produtos")
3286: 						ZAP IN cursor_4c_Produtos
3287: 					ENDIF
3288: 
3289: 					SELECT cursor_4c_PresetsCcp
3290: 					THIS.AplicarPresetNaTela()
3291: 
3292: 					IF THIS.CarregarLista()
3293: 						THIS.AplicarFiltroVariacao()
3294: 
3295: 						SELECT cursor_4c_Produtos
3296: 						SET ORDER TO cpros
3297: 						GO TOP
3298: 
3299: 						*-- O legado marca implicitamente: "atualizar" grava so
3300: 						*-- lMarca = 1, e no modo automatico nao ha usuario para
3301: 						*-- clicar - "cmdSelemp.Click" (Update Set lMarca = 1) eh
3302: 						*-- o equivalente de "todos os produtos do preset"
3303: 						UPDATE cursor_4c_Produtos SET lMarca = 1
3304: 
3305: 						IF !THIS.AtualizarPrecos()
3306: 							loc_lRetorno = .F.
3307: 							EXIT
3308: 						ENDIF
3309: 					ENDIF
3310: 
3311: 					SELECT cursor_4c_PresetsCcp
3312: 				ENDSCAN
3313: 
3314: 				IF USED("cursor_4c_PresetsCcp")
3315: 					USE IN cursor_4c_PresetsCcp
3316: 				ENDIF
3317: 			ENDIF
3318: 		CATCH TO loc_oErro
3319: 			MsgErro("Erro no processamento autom" + CHR(225) + "tico:" + CHR(13) + ;
3320: 				loc_oErro.Message + CHR(13) + ;
3321: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3322: 				"Procedure: " + loc_oErro.Procedure, "Erro")
3323: 			loc_lRetorno = .F.
3324: 		ENDTRY
3325: 
3326: 		*-- "ThisForm.Sair.Cancela.Click()" da ultima linha do legado: o modo

*-- Linhas 3349 a 3367:
3349: 			RETURN
3350: 		ENDIF
3351: 
3352: 		SELECT cursor_4c_PresetsCcp
3353: 
3354: 		*-- Filtros
3355: 		THIS.txt_4c_Fornecedor.Value    = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cfornecs, ""))
3356: 		THIS.txt_4c_GrandeGrupoI.Value  = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.merci, ""))
3357: 		THIS.txt_4c_GrandeGrupoF.Value  = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.mercf, ""))
3358: 		THIS.txt_4c_GrupoI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cgrui, ""))
3359: 		THIS.txt_4c_GrupoF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cgruf, ""))
3360: 		THIS.txt_4c_SubGrupoI.Value     = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.sgrui, ""))
3361: 		THIS.txt_4c_SubGrupoF.Value     = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.sgruf, ""))
3362: 		THIS.txt_4c_UnidadeI.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cunii, ""))
3363: 		THIS.txt_4c_UnidadeF.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cunif, ""))
3364: 		THIS.txt_4c_LinhaI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.lini, ""))
3365: 		THIS.txt_4c_LinhaF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.linf, ""))
3366: 		THIS.txt_4c_ColecaoI.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.coli, ""))
3367: 		THIS.txt_4c_ColecaoF.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.colf, ""))

*-- Linhas 3440 a 3474:
3440: 	ENDPROC
3441: 
3442: 	*====================================================================
3443: 	* BtnSelTudoClick - Espelha cmdSelemp.Click (Update CrProdutos Set
3444: 	* lMarca = 1) do legado. PUBLIC - alvo de BINDEVENT.
3445: 	*====================================================================
3446: 	PROCEDURE BtnSelTudoClick()
3447: 		IF USED("cursor_4c_Produtos")
3448: 			UPDATE cursor_4c_Produtos SET lMarca = 1
3449: 			THIS.grd_4c_Produtos.Refresh()
3450: 		ENDIF
3451: 	ENDPROC
3452: 
3453: 	*====================================================================
3454: 	* BtnApagaClick - Espelha CmdApgEmp.Click (Update CrProdutos Set
3455: 	* lMarca = 0) do legado. PUBLIC - alvo de BINDEVENT.
3456: 	*====================================================================
3457: 	PROCEDURE BtnApagaClick()
3458: 		IF USED("cursor_4c_Produtos")
3459: 			UPDATE cursor_4c_Produtos SET lMarca = 0
3460: 			THIS.grd_4c_Produtos.Refresh()
3461: 		ENDIF
3462: 	ENDPROC
3463: 
3464: 	*====================================================================
3465: 	* BtnImprimirClick - Espelha Impress?o.Click (Do Form SigPrCcr) do
3466: 	* legado, abrindo o relatorio ja migrado (FormSIGPRCCR).
3467: 	* PUBLIC - alvo de BINDEVENT.
3468: 	*====================================================================
3469: 	PROCEDURE BtnImprimirClick()
3470: 		LOCAL loc_oForm, loc_oErro, loc_lErroExibido
3471: 
3472: 		loc_oForm        = .NULL.
3473: 		loc_lErroExibido = .F.
3474: 


### BO (C:\4c\projeto\app\classes\sigprccpBO.prg):
*====================================================================
* sigprccpBO.prg
*
* Business Object para sigprccp (Recalculo de Precos)
* Tabela principal atualizada pelo processamento: SigCdPro (cpros)
* Tabela de presets de filtro (somente LEITURA, nunca gravada por
* este form): SigCdCcp (cIdChaves)
*
* Form legado: SIGPRCCP - "Recalculo de Precos"
* Forma OPERACIONAL: recalcula Custo/Venda de produtos filtrados,
* grava o resultado em SigCdPro e registra o historico do calculo.
*====================================================================

DEFINE CLASS sigprccpBO AS BusinessBase

	*-- Modo de execucao (Automatico = .T. quando chamado via ProcessarAutomatico,
	*-- percorrendo os presets de SigCdCcp; .F. quando disparado manualmente)
	this_lAutomatico = .F.

	*-- Filtros - Fornecedor
	this_cFornecs = ""
	this_cDFornecs = ""

	*-- Filtros - Faixas de classificacao do produto (SigCdCcp.merci/mercf etc)
	this_cMercI = ""
	this_cMercF = ""
	this_cGrupoI = ""
	this_cGrupoF = ""
	this_cSubGrupoI = ""
	this_cSubGrupoF = ""
	this_cUnidadeI = ""
	this_cUnidadeF = ""
	this_cLinhaI = ""
	this_cLinhaF = ""
	this_cColecaoI = ""
	this_cColecaoF = ""
	this_cMoedaI = ""
	this_cMoedaF = ""

	*-- Filtros - Faixas numericas (Markup/Encargo/Variacao)
	this_nMarkupI = 0
	this_nMarkupF = 0
	this_nEncargoI = 0
	this_nEncargoF = 0
	this_nVariacao = 0

	*-- Filtros - Feitio (SigPrFti) usado como referencia de calculo
	this_cFeitio = ""

	*-- Opcoes de processamento (OptionGroups do form - valores 1-based).
	*-- this_nAtualizaVenda=2 ("Nao") e this_nOpcaoCompra=3 ("Todos") sao
	*-- os defaults EXATOS do SCX legado (Opc_pven.Value=2/Opc_Compra.Value=3)
	this_nOpcaoMoeda = 1
	this_nSituacao = 1
	this_nTipoRecalculo = 1
	this_nAtualizaVenda = 2
	this_nOpcaoCompra = 3

	*-- Dados de recalculo
	this_nReajuste = 0
	this_nNovoEncargo = 0
	this_nNovoMarkup = 0
	this_cNovoFeitio = ""

	*-- Produto corrente (linha da grade marcada para gravacao do preco
	*-- recalculado) - mapeia SigCdPro.cpros, o registro efetivamente
	*-- atualizado por Inserir/Atualizar/ObterChavePrimaria/CarregarDoCursor
	this_cCpros = ""                && cpros char(14) - PK
	this_cDescricaoProduto = ""     && dpros char(65) - somente referencia
	this_nCustoAtual = 0            && custofs numeric(11,3)
	this_nVendaAtual = 0            && pvens numeric(11,5)
	this_nVendaIdeal = 0            && pvideals numeric(11,5)
	this_nFatorCusto = 0            && fcustos numeric(11,5)
	this_nFatorVenda = 0            && fvendas numeric(7,3)
	this_cMoedaCusto = ""           && moecs char(3)
	this_cMoedaVenda = ""           && moevs char(3)

	*-- Flag "Confirma a Impressao das Etiquetas?" do metodo "atualizar"
	*-- legado (m.ImpEtiqs = llImpEtiq gravado junto com o preco novo).
	*-- NUMERICO 0/1 porque impetiqs eh bit e o CheckBox/confirmacao do
	*-- form trabalha com 0/1 (nunca .T./.F.)
	this_nImpEtiqs = 0              && impetiqs bit

	*-- Subgrupo recalculado por faixa de preco (SigCdPsg.nfaixafins),
	*-- aplicado somente quando SigCdPaC.nchksubgrs = 1 - transcricao do
	*-- bloco "If crSigCdPac.nChkSubGrs = 1 ... Replace sGrus With
	*-- csSigCdPsg.Codigos" do metodo "atualizar" legado.
	*-- this_lAtualizarSubGrupo controla se Atualizar() inclui sgrus no
	*-- UPDATE: o legado so troca o subgrupo quando acha a faixa.
	this_cSubGrupo = ""             && sgrus char(6)
	this_lAtualizarSubGrupo = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Tabela efetivamente atualizada pelo processamento (SigCdPro),
		*-- pois SigCdCcp (presets de filtro) e somente LEITURA neste form.
		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "cpros"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave do produto sendo gravado
	* (usada por RegistrarAuditoria em Atualizar)
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCpros)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega os dados do produto (linha da grade de
	* recalculo) para as propriedades this_c*/this_n* correspondentes.
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				*-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR default do
				*-- tipo da coluna, NUNCA um codigo de tipo ("C"/"N") - com a coluna
				*-- NULL, "C" gravaria a string literal "C" na property e "N" poria
				*-- uma STRING numa property this_n*, estourando FormatarNumeroSQL.
				THIS.this_cCpros            = TratarNulo(cpros,    "")
				THIS.this_cDescricaoProduto = TratarNulo(dpros,    "")
				THIS.this_nCustoAtual       = TratarNulo(custofs,  0)
				THIS.this_nVendaAtual       = TratarNulo(pvens,    0)
				THIS.this_nVendaIdeal       = TratarNulo(pvideals, 0)
				THIS.this_nFatorCusto       = TratarNulo(fcustos,  0)
				THIS.this_nFatorVenda       = TratarNulo(fvendas,  0)
				THIS.this_cMoedaCusto       = TratarNulo(moecs,    "")
				THIS.this_cMoedaVenda       = TratarNulo(moevs,    "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar produto do cursor:" + CHR(13) + ;
				loException.Message, "sigprccpBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Grava o preco/custo recalculado de volta em SigCdPro
	* Equivalente a PROCEDURE atualizar do legado: Scatter/Gather do
	* registro com DataAlts/UsuaAlts atualizados e commit do preco novo.
	*
	* Inserir()/ExecutarExclusao() NAO sao sobrescritos neste BO: o
	* recalculo so ATUALIZA produtos ja cadastrados em SigCdPro - nunca
	* cria nem apaga produto - entao o comportamento herdado de
	* BusinessBase (recusar a operacao) ja eh o correto para os dois.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_cSubGru, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- sgrus so entra no UPDATE quando a faixa de SigCdPsg foi
			*-- localizada (legado: "If ! Eof() / Replace sGrus With
			*-- csSigCdPsg.Codigos") - fora disso o subgrupo nao se mexe.
			loc_cSubGru = ""
			IF THIS.this_lAtualizarSubGrupo AND !EMPTY(ALLTRIM(THIS.this_cSubGrupo))
				loc_cSubGru = "sgrus = " + ;
					EscaparSQL(LEFT(ALLTRIM(THIS.this_cSubGrupo), 6)) + ","
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET custofs  = <<FormatarNumeroSQL(THIS.this_nCustoAtual, 3)>>,
					pvens    = <<FormatarNumeroSQL(THIS.this_nVendaAtual, 5)>>,
					pvideals = <<FormatarNumeroSQL(THIS.this_nVendaIdeal, 5)>>,
					fcustos  = <<FormatarNumeroSQL(THIS.this_nFatorCusto, 5)>>,
					fvendas  = <<FormatarNumeroSQL(THIS.this_nFatorVenda, 3)>>,
					moecs    = <<EscaparSQL(THIS.this_cMoedaCusto)>>,
					moevs    = <<EscaparSQL(THIS.this_cMoedaVenda)>>,
					impetiqs = <<FormatarNumeroSQL(IIF(THIS.this_nImpEtiqs = 1, 1, 0), 0)>>,
					<<loc_cSubGru>>
					dtalts   = GETDATE(),
					usuaalts = <<EscaparSQL(LEFT(gc_4c_UsuarioLogado, 20))>>
				WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar pre" + CHR(231) + "o do produto:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprccpBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AcrescentarFaixa - Helper de MontarWhereFiltros: acrescenta a faixa
	* (BETWEEN/>=/<=) de UM campo a clausula WHERE em construcao. Espelha
	* o corpo do "For lnConta = 1 To 7" do metodo "processar" legado
	* (SIGPRCCP): so entra em ">= "/"<= "/"Between" quando pelo menos um
	* dos limites foi informado, e "And" so precede quando ja existe algo
	* acumulado em par_cWhereAtual.
	*====================================================================
	PROTECTED FUNCTION AcrescentarFaixa(par_cWhereAtual, par_cCampo, par_cInicio, par_cFim)
		LOCAL loc_cWhere, loc_cIni, loc_cFim
		loc_cWhere = par_cWhereAtual
		loc_cIni   = ALLTRIM(TratarNulo(par_cInicio, ""))
		loc_cFim   = ALLTRIM(TratarNulo(par_cFim, ""))

		IF !EMPTY(loc_cIni) OR !EMPTY(loc_cFim)
			IF !EMPTY(loc_cWhere)
				loc_cWhere = loc_cWhere + " And "
			ENDIF

			IF EMPTY(loc_cIni)
				loc_cWhere = loc_cWhere + par_cCampo + " <= " + EscaparSQL(loc_cFim)
			ELSE
				IF EMPTY(loc_cFim)
					loc_cWhere = loc_cWhere + par_cCampo + " >= " + EscaparSQL(loc_cIni)
				ELSE
					loc_cWhere = loc_cWhere + par_cCampo + " Between " + ;
						EscaparSQL(loc_cIni) + " And " + EscaparSQL(loc_cFim)
				ENDIF
			ENDIF
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* MontarWhereFiltros - Constroi a clausula WHERE dos filtros de faixa
	* (Grande Grupo/Grupo/Subgrupo/Unidade/Linha/Colecao/Moeda), Situacao,
	* Fornecedor, Opcao de Compra, Markup, Encargo e Feitio - transcricao
	* literal do bloco de montagem de lcWhere do metodo "processar" legado
	* (laCampo/laVarias percorrendo os 7 pares de faixa, seguido dos IIF de
	* Situas/Ifors/ForaLinha/Margems/Encargos/cFtios+cFtioCs).
	*====================================================================
	PROTECTED FUNCTION MontarWhereFiltros()
		LOCAL loc_cWhere, loc_cCampoMoeda

		*-- laCampo[5] do legado: 'Moedas', ou 'Moevs' quando fwoption1.Value = 2
		loc_cCampoMoeda = IIF(THIS.this_nOpcaoMoeda = 2, "Moevs", "Moedas")

		loc_cWhere = ""
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "CGrus",     THIS.this_cGrupoI,    THIS.this_cGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Cunis",     THIS.this_cUnidadeI,  THIS.this_cUnidadeF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Linhas",    THIS.this_cLinhaI,    THIS.this_cLinhaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Colecoes",  THIS.this_cColecaoI,  THIS.this_cColecaoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, loc_cCampoMoeda, THIS.this_cMoedaI, THIS.this_cMoedaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "SGrus",     THIS.this_cSubGrupoI, THIS.this_cSubGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Mercs",     THIS.this_cMercI,     THIS.this_cMercF)

		loc_cWhere = ALLTRIM(loc_cWhere)
		IF EMPTY(loc_cWhere)
			loc_cWhere = "1=1"
		ENDIF
		IF UPPER(RIGHT(loc_cWhere, 3)) == "AND"
			loc_cWhere = ALLTRIM(SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3))
		ENDIF

		*-- Situacao (Opc_situacao): 1=Ativos, 2=Inativos, 3=Todos (sem filtro)
		IF INLIST(THIS.this_nSituacao, 1, 2)
			loc_cWhere = loc_cWhere + " And Situas = " + FormatarNumeroSQL(THIS.this_nSituacao, 0)
		ENDIF

		*-- Fornecedor (getCFornecs)
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFornecs, "")))
			loc_cWhere = loc_cWhere + " And Ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecs))
		ENDIF

		*-- Opc_Compra: 1=Comprar (ForaLinha=0), 2=Nao Comprar (ForaLinha=1), 3=Todos
		IF INLIST(THIS.this_nOpcaoCompra, 1, 2)
			loc_cWhere = loc_cWhere + " And ForaLinha = " + IIF(THIS.this_nOpcaoCompra = 1, "0", "1")
		ENDIF

		*-- Faixa de Markup (GetMrki/GetMrkf)
		IF THIS.this_nMarkupI > 0
			loc_cWhere = loc_cWhere + " And Margems Between " + ;
				FormatarNumeroSQL(THIS.this_nMarkupI, 2) + " And " + FormatarNumeroSQL(THIS.this_nMarkupF, 2)
		ENDIF

		*-- Faixa de Encargo (Get_EncI/Get_Encf)
		IF THIS.this_nEncargoI > 0
			loc_cWhere = loc_cWhere + " And Encargos Between " + ;
				FormatarNumeroSQL(THIS.this_nEncargoI, 2) + " And " + FormatarNumeroSQL(THIS.this_nEncargoF, 2)
		ENDIF

		*-- Feitio (Get_Feitio) - casa tanto o feitio de venda quanto o de custo
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFeitio, "")))
			loc_cWhere = loc_cWhere + " And (cFtios = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ;
				" Or cFtioCs = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ")"
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* BuscarProdutosFiltrados - Consulta SigCdPro com a clausula WHERE de
	* MontarWhereFiltros (transcricao da fase de consulta do metodo
	* "processar" legado: "lcQuery = [Select * From SigCdPro Where ] +
	* lcWhere + ..."). O calculo de reajuste (conversao de moeda, peso de
	* composicao e markup de grupo) que o legado aplica DEPOIS desta
	* consulta usa this_nReajuste/this_nNovoMarkup/this_nNovoEncargo, que
	* espelham os controles Get_Reajuste/GetnMrk/Get_Encargo do formulario.
	*
	* Resultado fica em cursor_4c_ProdutosSQL (cpros/dpros/pvens/custofs/
	* pvideals/fcustos/fvendas/moecs/moevs) para o Form transferir para o
	* cursor da grade (cursor_4c_Produtos) em CarregarLista.
	*====================================================================
	FUNCTION BuscarProdutosFiltrados()
		LOCAL loc_cWhere, loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = THIS.MontarWhereFiltros()

			IF USED("cursor_4c_ProdutosSQL")
				USE IN cursor_4c_ProdutosSQL
			ENDIF

			*-- cgrus nao aparece na grade, mas viaja junto porque a
			*-- reclassificacao de subgrupo por faixa (ResolverSubGrupoPorFaixa)
			*-- precisa do grupo do produto na hora de gravar
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cpros, dpros, pvens, custofs, pvideals, fcustos, fvendas,
					moecs, moevs, cgrus
				FROM SigCdPro
				WHERE <<loc_cWhere>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosSQL")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao consultar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao buscar produtos:" + CHR(13) + loException.Message, ;
				"sigprccpBO.BuscarProdutosFiltrados")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


	*====================================================================
	* BuscarPresetsAutomaticos - Le os presets de recalculo ativos de
	* SigCdCcp para o modo Automatico. Transcricao literal da consulta do
	* metodo "processaautomatico" legado:
	*     lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
	*
	* Resultado em cursor_4c_PresetsCcp (uma linha por preset, na ordem
	* natural da tabela - o legado nao ordena).
	*====================================================================
	FUNCTION BuscarPresetsAutomaticos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_PresetsCcp")
				USE IN cursor_4c_PresetsCcp
			ENDIF

			loc_cSQL = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PresetsCcp")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
					CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdCcp)")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler presets de rec" + CHR(225) + "lculo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.BuscarPresetsAutomaticos")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterChkSubGrupos - Le SigCdPaC.nchksubgrs, o parametro que liga a
	* reclassificacao de subgrupo por faixa de preco no fim do metodo
	* "atualizar" legado (If crSigCdPac.nChkSubGrs = 1). O legado carrega
	* esse valor no Init (CursorQuery 'SigCdPaC' ... 'Calccusts,NCHKSUBGRS').
	*
	* Retorno: NUMERICO (0 quando o parametro nao existe ou a consulta
	* falha) - nchksubgrs eh numeric(1,0), nao bit, entao chega SEMPRE
	* numerico e nao precisa de teste de VARTYPE para Logico.
	*====================================================================
	FUNCTION ObterChkSubGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_nChk
		loc_nChk = 0

		TRY
			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF

			loc_cSQL = "SELECT TOP 1 nchksubgrs FROM SigCdPaC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PacChk")

			IF loc_nResultado >= 0 AND USED("cursor_4c_PacChk")
				SELECT cursor_4c_PacChk
				GO TOP
				IF !EOF()
					loc_nChk = TratarNulo(cursor_4c_PacChk.nchksubgrs, 0)
				ENDIF
			ENDIF

			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler par" + CHR(226) + "metro de subgrupo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ObterChkSubGrupos")
		ENDTRY

		RETURN loc_nChk
	ENDFUNC

	*====================================================================
	* ResolverSubGrupoPorFaixa - Devolve o subgrupo (SigCdPsg.codigos) cuja
	* faixa comporta o preco de venda informado. Transcricao do bloco do
	* metodo "atualizar" legado:
	*     Select * From SigCdPsg Where CGrus = '<grupo>' Order By nFaixaFins
	*     Locate For nFaixaFins >= lnPVens
	*     If ! Eof() -> Replace sGrus With csSigCdPsg.Codigos
	* O "Locate" sobre o cursor ORDENADO por nFaixaFins pega a PRIMEIRA
	* faixa cujo limite superior alcanca o preco - equivalente exato ao
	* TOP 1 ... ORDER BY nfaixafins abaixo.
	*
	* Retorno: CHAR com o codigo do subgrupo, "" quando nao ha faixa
	* (caso em que o legado NAO troca o subgrupo).
	*====================================================================
	FUNCTION ResolverSubGrupoPorFaixa(par_cGrupo, par_nVenda)
		LOCAL loc_cSQL, loc_nResultado, loc_cCodigo
		loc_cCodigo = ""

		TRY
			IF !EMPTY(ALLTRIM(TratarNulo(par_cGrupo, "")))
				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF

				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT TOP 1 codigos
					FROM SigCdPsg
					WHERE cgrus = <<EscaparSQL(ALLTRIM(par_cGrupo))>>
						AND nfaixafins >= <<FormatarNumeroSQL(par_nVenda, 2)>>
					ORDER BY nfaixafins
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Psg")

				IF loc_nResultado >= 0 AND USED("cursor_4c_Psg")
					SELECT cursor_4c_Psg
					GO TOP
					IF !EOF()
						loc_cCodigo = ALLTRIM(TratarNulo(cursor_4c_Psg.codigos, ""))
					ENDIF
				ENDIF

				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao resolver subgrupo por faixa:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ResolverSubGrupoPorFaixa")
		ENDTRY

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* ColunasComunsProPrc - Lista das 121 colunas presentes ao mesmo tempo
	* em SigCdPro e SigCdPrc (extraidas de docs/schema.sql). O legado copia
	* o registro INTEIRO com "Scatter Memvar Memo" + "Insert Into
	* CrSigCdPrc From MemVar", que preenche apenas os campos de nome igual
	* nas duas tabelas - esta lista eh exatamente esse conjunto.
	*
	* par_lOrigem = .T. devolve as EXPRESSOES do SELECT sobre SigCdPro,
	* com LEFT() nas 3 colunas que sao mais CURTAS no destino (locals
	* 10->6, sittricms 3->2, codtams 4->2); sem o LEFT o SQL Server recusa
	* o INSERT com "String or binary data would be truncated".
	* par_lOrigem = .F. devolve os nomes crus, para a lista de destino.
	*====================================================================
	PROTECTED FUNCTION ColunasComunsProPrc(par_lOrigem)
		LOCAL loc_c
		loc_c = ""
		loc_c = loc_c + "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, "
		loc_c = loc_c + "cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, "
		loc_c = loc_c + "fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(locals, 6)", "locals") + ", "
		loc_c = loc_c + "margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, "
		loc_c = loc_c + "obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, "
		loc_c = loc_c + "reffs, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(sittricms, 2)", "sittricms") + ", "
		loc_c = loc_c + "tcomps, tipos, transps, valors, varias, situas, "
		loc_c = loc_c + "dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, "
		loc_c = loc_c + "codcors, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(codtams, 2)", "codtams") + ", "
		loc_c = loc_c + "compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, "
		loc_c = loc_c + "chkfunds, casas, impetiqs, qtdcpnts, dpro2s, dsccompras, encoms, obscompras, "
		loc_c = loc_c + "codacbs, cravcers, cunips, ipis, mercs, pesobs, tamhs, tamls, "
		loc_c = loc_c + "tamps, tptribs, volumes, obsetqs, ultcomps, vultcomps, multcomps, markupa, "
		loc_c = loc_c + "tinsts, cclass, cftiocs, figtecs, nivelqs, pftiocs, usuincs, diasinas, "
		loc_c = loc_c + "idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, contaccus, "
		loc_c = loc_c + "gruccus, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, "
		loc_c = loc_c + "idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, "
		loc_c = loc_c + "conjunts"

		RETURN loc_c
	ENDFUNC

	*====================================================================
	* GravarHistoricoPreco - Registra em SigCdPrc o retrato do produto
	* ANTES da gravacao do preco novo. Transcricao do bloco do metodo
	* "atualizar" legado:
	*     lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
	*     Select TmpPro2 / Scatter Memvar Memo
	*     m.DataAlts = Datetime() / m.HoraAlts = Substr(Ttoc(...),12,8)
	*     m.UsuaAlts = Usuar / m.cIdChaves = fUniqueIds()
	*     m.Origem   = Ttoc(Datetime()) + [ SigPrCcp]
	*     Insert Into CrSigCdPrc From MemVar
	* Feito com INSERT ... SELECT (server-side) para nao trazer as 121
	* colunas para o VFP so para devolve-las.
	*
	* As 15 colunas NOT NULL que existem em SigCdPrc e NAO em SigCdPro
	* recebem o valor em branco do tipo - equivalente ao registro em
	* branco do cursor do legado, que o "Insert From Memvar" nao toca.
	* SigCdPrc nao tem nenhum DEFAULT, entao omitir qualquer uma delas
	* faria o SQL Server recusar o INSERT inteiro (CLAUDE.md regra #22).
	* figuras (image) fica de fora porque aceita NULL.
	*
	* IMPORTANTE: chamar ANTES de Salvar()/Atualizar(), senao o historico
	* guarda o preco NOVO em vez do antigo.
	*====================================================================
	FUNCTION GravarHistoricoPreco(par_cCpros)
		LOCAL loc_cSQL, loc_cDestino, loc_cOrigem, loc_cExtras, loc_cValores
		LOCAL loc_cHora, loc_cOrigemTxt, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- m.HoraAlts = Substr(Ttoc(m.DataAlts),12,8) do legado
			loc_cHora = SUBSTR(TTOC(DATETIME()), 12, 8)

			*-- m.Origem = Ttoc(Datetime()) + [ SigPrCcp] do legado
			loc_cOrigemTxt = LEFT(TTOC(DATETIME()) + " SigPrCcp", 30)

			loc_cExtras  = "codcpds, cbms, caracts, cunifors, custocvs, ltmins, markcvs, pesomts, " + ;
				"pidealcvs, qtdias, retiras, codccnjs, montagens, tmontas, codconc"
			loc_cValores = EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ;
				", 0, 0, 0, 0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ;
				", " + EscaparSQL("")

			loc_cDestino = THIS.ColunasComunsProPrc(.F.)
			loc_cOrigem  = THIS.ColunasComunsProPrc(.T.)

			loc_cSQL = "INSERT INTO SigCdPrc " + ;
				"(dataalts, horaalts, usuaalts, cidchaves, origem, " + ;
				loc_cExtras + ", " + loc_cDestino + ") " + ;
				"SELECT GETDATE(), " + ;
				EscaparSQL(loc_cHora) + ", " + ;
				EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
				EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
				EscaparSQL(loc_cOrigemTxt) + ", " + ;
				loc_cValores + ", " + loc_cOrigem + " " + ;
				"FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
					"rico de pre" + CHR(231) + "o (SigCdPrc) do produto " + ;
					ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de pre" + CHR(231) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.GravarHistoricoPreco")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarHistoricoComposicao - Copia a composicao corrente do produto
	* (SigPrCpo) para SigPrCp2. Transcricao do bloco do metodo "atualizar"
	* legado:
	*     Select * From SigPrCpo Where CPros = '<cpros>' -> TmpCompo
	*     Scan / Scatter MemVar Memo
	*        m.DataAlts/HoraAlts/UsuaAlts / m.cIdChaves = fUniqueIds()
	*        Insert Into CrSigPrCp2 From MemVar
	*     EndScan
	* Como o legado gera um cIdChaves NOVO por LINHA, a gravacao eh feita
	* linha a linha (um INSERT ... SELECT por cidchaves de origem) - um
	* unico INSERT em conjunto repetiria a mesma chave em todas as linhas
	* e colidiria no indice unico.
	*
	* SigPrCp2 = SigPrCpo menos PedraPrincipal, mais dataalts/horaalts/
	* usuaalts; dcompos eh char(30) contra char(40) na origem, por isso o
	* LEFT(dcompos, 30).
	*====================================================================
	FUNCTION GravarHistoricoComposicao(par_cCpros)
		LOCAL loc_cSQL, loc_cCols, loc_cColsOrig, loc_cHora, loc_cUsuario
		LOCAL loc_nResultado, loc_lSucesso, loc_lProsseguir
		loc_lSucesso    = .F.
		loc_lProsseguir = .T.

		TRY
			loc_cHora    = SUBSTR(TTOC(DATETIME()), 12, 8)
			loc_cUsuario = LEFT(gc_4c_UsuarioLogado, 10)

			loc_cCols = ""
			loc_cCols = loc_cCols + "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, "
			loc_cCols = loc_cCols + "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, "
			loc_cCols = loc_cCols + "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, "
			loc_cCols = loc_cCols + "cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, "
			loc_cCols = loc_cCols + "tipos, matriz, obsofs"

			*-- Mesma lista, com LEFT() na unica coluna mais curta no destino
			loc_cColsOrig = STRTRAN(loc_cCols, "dcompos,", "LEFT(dcompos, 30),")

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF

			loc_cSQL = "SELECT cidchaves FROM SigPrCpo WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoOrig")

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Falha ao ler composi" + CHR(231) + CHR(227) + ;
					"o do produto " + ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				*-- Produto sem composicao: nada a historiar, e o legado
				*-- tambem apenas nao entra no Scan (sucesso)
				loc_lSucesso = .T.

				SELECT cursor_4c_CompoOrig
				SCAN
					loc_cSQL = "INSERT INTO SigPrCp2 " + ;
						"(dataalts, horaalts, usuaalts, cidchaves, " + loc_cCols + ") " + ;
						"SELECT GETDATE(), " + ;
						EscaparSQL(loc_cHora) + ", " + ;
						EscaparSQL(loc_cUsuario) + ", " + ;
						EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
						loc_cColsOrig + " " + ;
						"FROM SigPrCpo WHERE cidchaves = " + ;
						EscaparSQL(ALLTRIM(cursor_4c_CompoOrig.cidchaves))

					IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
						THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
							"rico de composi" + CHR(231) + CHR(227) + "o (SigPrCp2) do produto " + ;
							ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
						MsgErro(THIS.this_cMensagemErro, "Erro SQL")
						loc_lSucesso = .F.
						EXIT
					ENDIF

					SELECT cursor_4c_CompoOrig
				ENDSCAN
			ENDIF

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de composi" + ;
				CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, ;
				"sigprccpBO.GravarHistoricoComposicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ExcluirPrecosTabela - Apaga os precos de tabela do produto, que
	* passam a estar defasados depois do recalculo. Transcricao literal do
	* metodo "atualizar" legado:
	*     [Delete From SigPrPrt Where CPros = '] + m.CPros + [' ]
	*====================================================================
	FUNCTION ExcluirPrecosTabela(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao excluir pre" + CHR(231) + ;
					"os de tabela (SigPrPrt) do produto " + ALLTRIM(par_cCpros) + ;
					": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao excluir pre" + CHR(231) + "os de tabela:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ExcluirPrecosTabela")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* IniciarTransacao / ConfirmarTransacao / DesfazerTransacao
	*
	* Equivalentes de ThisForm.poDataMgr.Commit() / .RollBack() do legado,
	* que existem porque o fSqlConector legado abre a conexao com
	* Transactions = 2 (manual). Neste ambiente a conexao JA nasce em
	* transacao manual (SQLGETPROP(0,"Transactions") = 2 num VFP9 virgem),
	* entao nao ha nada a abrir: IniciarTransacao apenas confere o handle e
	* limpa a mensagem de erro; o que importa eh o par SQLCOMMIT/
	* SQLROLLBACK no fim - sem eles a transacao nunca eh fechada e a
	* gravacao SOME se o processo morrer antes do disconnect limpo.
	*====================================================================
	FUNCTION IniciarTransacao()
		THIS.this_cMensagemErro = ""
		RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
	ENDFUNC

	FUNCTION ConfirmarTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
			IF !loc_lSucesso
				THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + ;
					CHR(227) + "o: " + CapturarErroSQL()
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.ConfirmarTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	FUNCTION DesfazerTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLROLLBACK(gnConnHandle) > 0)
		CATCH TO loException
			MostrarErro("Erro ao desfazer transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.DesfazerTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


ENDDEFINE

